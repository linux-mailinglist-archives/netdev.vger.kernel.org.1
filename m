Return-Path: <netdev+bounces-158341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A06A116FF
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F41165DF1
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 02:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B331E1C26;
	Wed, 15 Jan 2025 02:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZyofTVx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FB43597D;
	Wed, 15 Jan 2025 02:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736906812; cv=none; b=avLvxukBY8QEAGZN/BdUpNUue3FyIG9fCgT51Zl0KCetKnbNTDTgNEm+bmPuE8i20I/W0ZXyncbj3SAOroT87/j0dueFR7IeW/Qj+btoGSlKG3BC03pd96k6vBbep7IlZRiOe1vsyeTPTOwtZ5tlYsCDnwhA2/V0XOVMnhSG4N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736906812; c=relaxed/simple;
	bh=Is2DEKJqxrZolAAhs79aRj+JZ1MAa+Qb4ZhMoIVs3d8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MtYGDHiuc8JAMvpF6xtMweN8e625HYCc7V0CPVyxRtJP50O5DeiRJXxvcTzeS8SrUYzxjctOD/a4jPrA2Qd8y8hFVDJOTHt28Ql0rlB10HUbzAQo0HWM18FqGw76wAh/Eyaah1jA7lJpsea8wDnqqdwRc1bLGTI8OfKYvwFR3o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZyofTVx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3A2C4CEDD;
	Wed, 15 Jan 2025 02:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736906812;
	bh=Is2DEKJqxrZolAAhs79aRj+JZ1MAa+Qb4ZhMoIVs3d8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gZyofTVxT+u0L1znLIHaVN7i/eistrx0gCPsPi/UxOgGoHuAjcBiP6ME2pKBxTacu
	 zFM1j6uCI7pcHUql7guwQmcGIuNSL3tQcbl9j2CbHRJ61+aODAhHOJ7cU6sOx1zv/i
	 q+gJCXt/eCmA/hOWlACdyak6CaezRoe/2rLWeDI5jIvDIsbLB+2AsJtOqMYiLRx0CA
	 3KdE7YelM4LW+HUdQwrvQl2ep73dZ22N2wBND0ITlX4VnZTu8usyuK037Q3acaCgWq
	 mDse7By8hi98ni1zoNYA7Ug/AO/THF1IxXS8zkiBQbtnpcAgYLKZXh2euq5Il7jQoC
	 GmtnMio6JkIMg==
Date: Tue, 14 Jan 2025 18:06:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose
 Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, imx@lists.linux.dev
Subject: Re: [PATCH net-next 2/5] net: ti: icssg-prueth: Use
 syscon_regmap_lookup_by_phandle_args
Message-ID: <20250114180650.4ba50ea4@kernel.org>
In-Reply-To: <1376b2b3-90c4-4f06-b05c-10b9e5d1535e@linaro.org>
References: <20250112-syscon-phandle-args-net-v1-0-3423889935f7@linaro.org>
	<20250112-syscon-phandle-args-net-v1-2-3423889935f7@linaro.org>
	<0eaff868-f67f-4e8a-ade8-4bdf98d9d094@ti.com>
	<1376b2b3-90c4-4f06-b05c-10b9e5d1535e@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 12:04:35 +0100 Krzysztof Kozlowski wrote:
> > The patch only touches `drivers/net/ethernet/ti/am65-cpsw-nuss.c`
> > however the subject suggests the patch is related to "icssg-prueth".
> > 
> > I suppose the subject should be changed to "am65-cpsw-nuss" instead of
> > "icssg-prueth"  
> 
> Indeed, copy paste.

Will fix when applying.


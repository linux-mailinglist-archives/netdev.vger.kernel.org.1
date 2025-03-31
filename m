Return-Path: <netdev+bounces-178371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D93EAA76C70
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 19:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E0FC7A2032
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98E91E3DC8;
	Mon, 31 Mar 2025 17:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORfRDVXa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE983130A54;
	Mon, 31 Mar 2025 17:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743441038; cv=none; b=ZQg+IsCDKdMjdrCJztud5IhQ41YkHTJGtQwAz1cx36NMkVrPUqpg18UGftIuA8r+gpadVvhWEJzIrWJQqDdZesTkIFznvk7BP1ZgqjA4KBxYW0lRKd8T9Dln5UypABTsX0dUt6frNPz8NwuMNoJeHQrYmD9BKgOQfOMOCF+t2bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743441038; c=relaxed/simple;
	bh=fW05yxRGO3a+2Htch6vXAYBqk9OLY5N7AW6f2uPA3YY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlYYTyoupUeqMLDyqACfqSBWYCPP+Ougz72Wplo4gsPmuZemgbyw9XR9ZISWkYytUbl325KhugZldiH2dJtCTnlxEu01VIiUpkp/j3YfCBjYw7j6UKbS5x817toXq5Vd2YQwWzFASdKDFaOiyuR/V+TQMewc15STDpwhAo8fFqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORfRDVXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4B2C4CEE3;
	Mon, 31 Mar 2025 17:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743441038;
	bh=fW05yxRGO3a+2Htch6vXAYBqk9OLY5N7AW6f2uPA3YY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ORfRDVXaxI9YZrPQrwaQ+hwVtaV18urjj8Ade0KrD+cnNsBYHDMnBo8OSm62QcV8E
	 tvjTrFyYPj73I5d0LVCsqp4aiSVLN7pnjEkR2u34+1lOYKp29syxx6BOAckzcsOqRx
	 QbRRmXrlAwAR2Jz+FTnIh/Lp4grB5xs7hgji/Czjy1EXZtKY1Heg4oF3M2I4IFfl4B
	 S+zIOUnGAn1AsfhLXo4yD2oDUPgGRP32mDTtE4tFypkU/CEIWVvWRh+edPwdRU2laC
	 3KMGU4tG7KRPpOyWNbhdK4frov6v8dGmMznna8/dGQbyV1OmnXpI0WchXqq58TAx/Q
	 xw2ddPWw7axqg==
Date: Mon, 31 Mar 2025 10:10:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/4] net: mtip: Add support for MTIP imx287 L2 switch
 driver
Message-ID: <20250331101036.68afd26a@kernel.org>
In-Reply-To: <20250331103116.2223899-1-lukma@denx.de>
References: <20250331103116.2223899-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 12:31:12 +0200 Lukasz Majewski wrote:
> This patch series adds support for More Than IP's L2 switch driver embedded
> in some NXP's SoCs. This one has been tested on imx287, but is also available
> in the vf610.

Lukasz, please post with RFC in the subject tags during the merge
window. As I already said net-next is closed.


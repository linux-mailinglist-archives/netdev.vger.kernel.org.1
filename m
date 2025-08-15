Return-Path: <netdev+bounces-214159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB7AB2861F
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 21:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D653B189B55E
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 19:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D32308F39;
	Fri, 15 Aug 2025 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKA1Htk0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCC2308F0C;
	Fri, 15 Aug 2025 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755284399; cv=none; b=S05O9iMcQ9xc4TTZoZwskT9QowZ+QZRX+0GAZZdlK0n/Ys4gvSgR9kKFCtspf1c981KMx46GaLWcrduwP+o2FQC36kzlrVLzMQuegSz1L3FO8SEOnjVmS4G/+3CtfpZG4qDYfTRe1rmdI3mlVi7C5zHhVsTKiN40V5eW5Kcy6zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755284399; c=relaxed/simple;
	bh=XFgdqlcF4w6JcQknFkuyLVCuivnPG7StN6tF26sMAY4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LG6mGs0LDNkgfWuTMrop06NDub/ZTNkH7WdPELNruKSM8IcVHhN+cue5SFWu1XocxFNlK7cnnzlZK4st4qBQoo55VTfUEDM4FspHiRaMeIKDglVYjB/KDFtQITjoWebiA5enEK6PbKx3hMzTbLRJT/S5ANoHHbgd+GUMyR5PH80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKA1Htk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FB7C4CEEB;
	Fri, 15 Aug 2025 18:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755284398;
	bh=XFgdqlcF4w6JcQknFkuyLVCuivnPG7StN6tF26sMAY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JKA1Htk0Vn8klSgNQ5+BvVD/T9TcDb70snLPG4jCD/orLjAXrzx0xUz7AxM9Wp46j
	 h7/iUiJQ9WdT2tnY4EPirct5e+PErV6hq4WNoRgMDWjOjsLIRtZdPY6phvXs2d/jpG
	 MkEKJrZm+wfMMQoTPF5oxotCJ9Cxfr4W1nvAgL+BJa16bav51S2wHCErtdCje+JBFG
	 Zh3spCW8Dj9s0UnrtBtMABB2VXWbcfIkprqMAaJfjlDD6jzKHz8gJGi02fbq3I2XOB
	 Ljr90FRYb/7kW0lJv0FPYx371wa2uy/UqVMPWroDyhS9u+SO81Gsykz6kGp2Nmief6
	 WXvgJLcvfPI1A==
Date: Fri, 15 Aug 2025 11:59:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ssantosh@kernel.org, richardcochran@gmail.com, m-malladi@ti.com,
 s.hauer@pengutronix.de, afd@ti.com, jacob.e.keller@intel.com,
 horms@kernel.org, johan@kernel.org, m-karicheri2@ti.com, s-anna@ti.com,
 glaroque@baylibre.com, saikrishnag@marvell.com, kory.maincent@bootlin.com,
 diogo.ivo@siemens.com, javier.carrasco.cruz@gmail.com,
 basharath@couthit.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, vadim.fedorenko@linux.dev,
 alok.a.tiwari@oracle.com, bastien.curutchet@bootlin.com, pratheesh@ti.com,
 prajith@ti.com, vigneshr@ti.com, praneeth@ti.com, srk@ti.com,
 rogerq@ti.com, krishna@couthit.com, pmohan@couthit.com, mohan@couthit.com
Subject: Re: [PATCH net-next v13 4/5] net: ti: prueth: Adds link detection,
 RX and TX support.
Message-ID: <20250815115956.0f36ae06@kernel.org>
In-Reply-To: <20250812133534.4119053-5-parvathi@couthit.com>
References: <20250812110723.4116929-1-parvathi@couthit.com>
	<20250812133534.4119053-5-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 19:04:19 +0530 Parvathi Pudi wrote:
> +static irqreturn_t icssm_emac_rx_packets(struct prueth_emac *emac, int quota)

Please stick to calling the budget budget rather than synonym terms
like "quota". Makes it harder to review the code.

> +	/* search host queues for packets */
> +	for (i = start_queue; i <= end_queue; i++) {
> +		queue_desc = emac->rx_queue_descs + i;
> +		rxqueue = &queue_infos[PRUETH_PORT_HOST][i];

budget can be 0, in which case the driver is not supposed to process
Rx, just Tx (if the NAPI instance is used to serve completions).

> +	num_rx_packets = icssm_emac_rx_packets(emac, budget);
> +	if (num_rx_packets < budget) {
> +		napi_complete_done(napi, num_rx_packets);

don't ignore the return value of napi_complete_done()
-- 
pw-bot: cr


Return-Path: <netdev+bounces-264805-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH0tDWXdqmlqXwEAu9opvQ
	(envelope-from <netdev+bounces-264805-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 14:57:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E3422231F
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 14:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F01D4306FE0A
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 13:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCD439B489;
	Fri,  6 Mar 2026 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V+Lc+Q3Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5743A1A35
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772804998; cv=none; b=ojNuZVZd2u/7v+0/DQGq0jc1hOFWxq0BqdU/APzQsxCXCOX5nkhr7quVnTyzGgCm3uTe0TMEFFVNNSL1w9am36Dvc4OOQo0RFEK3tnnfcq81OUZZT9DXDrH1858avL9O6QW39PWynzjj4etRWa/xFVG0W1WvpGdx8HtYgw4dlVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772804998; c=relaxed/simple;
	bh=xDkL6TzFGrTxC514XfyOIrW4ST8vZI8e5m+MG2Hs1Zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOJ3AvuqOucY2W6oX7alEBQISA5Hpz7N5qkqBRdpzJzgiD8iohxF3XGCT225HWbWHXnRHkmPOPRZVbx515RA5Ro1jDMOf6rzJoHucph/GMDzi+qqlItgPLusn9HA6Na+rmkDk41wHC3PqRUgDjVpI9cClUVjhFleXpGoCUevUAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V+Lc+Q3Y; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 000A2C40431;
	Fri,  6 Mar 2026 13:50:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D6AF35FF92;
	Fri,  6 Mar 2026 13:49:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 47679103699EA;
	Fri,  6 Mar 2026 14:49:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772804988; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=c20mkraPRlwGY3oRHlW+Mslb5VLebC/91Q18kftMfIc=;
	b=V+Lc+Q3YI20csUK/+es6cMzQASPQbm3w0yg/676z9/NKiipGSIEG+Xm0iztANxCElgi6ho
	3SetuUv4madjjCv8utjMBKnn2LX9XiLztVnv7/xWOTO3FBB/DAIF0xnkxbDOHaUocQKppe
	TLNSBuLsBbamRXcb9fA/myymZx6gqKHxZWim+hdnIKkWusoxhfcmm6Wi6OV7KY7+9uFLLi
	yR8gUKiFUkq3C8uZU3g4sgtTQkN4C6bbWGuCPXMC84gv/ViTnEgv/WM8uKDd6WfqINtslQ
	WR4Tw59PXLXt9GIhLJp1Hq2cg8/8OzgRvf1x9aVACnZvpAgc7f4H9soUuirqfA==
Message-ID: <ff7fc863-0f8a-49e2-8e75-ee446a43df34@bootlin.com>
Date: Fri, 6 Mar 2026 14:49:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/8] net: stmmac: mdio related cleanups
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Chen-Yu Tsai <wens@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Samuel Holland <samuel@sholland.org>
References: <aald--qJquWGIvmO@shell.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aald--qJquWGIvmO@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: C8E3422231F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264805-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid]
X-Rspamd-Action: no action

Hi,

On 05/03/2026 11:42, Russell King (Oracle) wrote:
> Hi,
> 
> The first four patches clean up the MDC clock divisor selection code,
> turning the three different ways we choose a divisor into tabular form,
> rather than doing the selection purely in code.
> 
> Convert MDIO to use field_prep() which allows a non-constant mask to be
> used when preparing fields.
> 
> Then use u32 and the associated typed GENMASK for MDIO register field
> definitions.
> 
> Finally, an extra couple of patches that use appropriate types in
> struct mdio_bus_data.
> 
> v2:
> - add comments about 300MHz to commit message in patch 1
> - fix incorrect usage of stmmac_sun8i_csr_to_mdc in patch 3
> - fix BIT_u32()->BIT_U32() in patch 8

I have tested this series as a whole on 2 platforms using the dwmac mdio
driver (socfpga - KSZ9031 / imx8mp + KSZ9131), no regressions found. I'm
not stressing the 300M case though.

feel free to add my :

Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

>  drivers/net/ethernet/stmicro/stmmac/common.h       |  10 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |   2 +-
>  .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |  11 +--
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |   9 +-
>  .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |   9 +-
>  .../net/ethernet/stmicro/stmmac/dwmac100_core.c    |   9 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |   9 +-
>  .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  18 ++--
>  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  | 106 ++++++++++++---------
>  include/linux/stmmac.h                             |   6 +-
>  10 files changed, 92 insertions(+), 97 deletions(-)
> 



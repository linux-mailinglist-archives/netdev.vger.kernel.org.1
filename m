Return-Path: <netdev+bounces-303211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3IJ3BszOQ2pNiwoAu9opvQ
	(envelope-from <netdev+bounces-303211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:12:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D546E544F
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:12:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=FUoLqOkr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303211-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303211-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BD51312A960
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA9536BCC9;
	Tue, 30 Jun 2026 14:05:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37818358378;
	Tue, 30 Jun 2026 14:04:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828300; cv=none; b=HrwBRzmBguHXsv3zkOYB4XJw61S4Ug3sRtxWxq3huYLQtynAzeJR+UqibBn4Acvbhj1e4p7MJTMIt1qoLNBEtjEPeVbalOYaQCp1IpO7WKCDpwBK8MF2hWnCcJExXddRU+7AUzthZE2pcwxtgntbW85759JfRB2YP8/YkqfZ5Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828300; c=relaxed/simple;
	bh=M3nMIHM0CsIal5ps+98iV4ppcJBOc4XAy2zZXrzNx5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mm/2o01q34mjbV16ktz8BUuXnTE6BGy1w5rsJkGgBQ7dMAc6BXNwK5gwsKinZudNOoETOQT0OVdXNAJDQB7jyb3SKKzfmnHbT0ugPP/xv0RBZuP5OV0ji2R5VJdf74CpgM1RliKziO7rTRN2Tkru59tksPpvQWqheE46CkJTBJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FUoLqOkr; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B58331A0D64;
	Tue, 30 Jun 2026 14:04:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8597E6025A;
	Tue, 30 Jun 2026 14:04:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EF050106F1F6A;
	Tue, 30 Jun 2026 16:04:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782828295; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=6rjDgL/xt0149iiitUzxfV7EKlVMkvz0wclCPfWzM1I=;
	b=FUoLqOkrO8rzuA1Ak7mXnpNxg4VXWCHELhJxzYACKEQIbR7/J0Y/k2NsH6LM/o11J8uiH+
	fc2ZFO5jSm/ZRI0yP1GfBih4u9hwx7smvcu0Feb3NptqCaPiab3vhq3gJM+KJs29WW9W7N
	mVp3UV1RlIc+UbeyjNytz3lMquy1jvgjWgTT9fyvO19H7Mgcxxnf2v06+/SwXtoA3YpVfD
	0GSWcj92+nec0sTksyFKtyfZmSmfoc+zeK0vdAmf1Wmgu4iahdgX93SvdMA25FuopURWe2
	eAwXn4eO2DEv5MSnVLfy7+9iUBK9HvwT3al8E0EKvAY9/T8RrPSOYMM7dJ/BBA==
Message-ID: <7c57bb08-b72d-44bf-be44-f1bcb2aa9a84@bootlin.com>
Date: Tue, 30 Jun 2026 16:04:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net: stmmac: dwmac-socfpga: Add mac-mode DT property
 support
To: Andrew Lunn <andrew@lunn.ch>,
 muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: dinguyen@kernel.org, rmk+kernel@armlinux.org.uk, krzk+dt@kernel.org,
 conor+dt@kernel.org, robh@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260630133108.27244-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260630133108.27244-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <4c285993-978c-4d9e-a8c5-c3b36baa6840@lunn.ch>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <4c285993-978c-4d9e-a8c5-c3b36baa6840@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303211-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:dinguyen@kernel.org,m:rmk+kernel@armlinux.org.uk,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[altera.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:mid,bootlin.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65D546E544F

On 6/30/26 16:02, Andrew Lunn wrote:
> On Tue, Jun 30, 2026 at 06:31:08AM -0700, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
>> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
>>
>> Russell King's commit de696c63c1dc ("net: stmmac: socfpga: convert to
>> use phy_interface") replaced mac_interface with phy_interface in
>> socfpga_get_plat_phymode(), noting that no upstream DTS files set the
>> "mac-mode" property, making the two values identical.
>>
>> The Agilex5 SoCDK TSN Config2 board is an exception: its gmac1 TSN
>> port uses GMII internally in the MAC while the PHY-side interface is
>> RGMII, so mac-mode and phy-mode differ.
> 
> Maybe you need to represent the hardware block which magically
> converts GMII to RGMII in DT?

Yeah that's what we have on CycloneV, and we force the INTF_SEL to GMII if that
HW block is present. I wonder if there's the same on agileX5 ?

> 
> 	 Andrew



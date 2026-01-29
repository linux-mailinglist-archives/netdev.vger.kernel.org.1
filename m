Return-Path: <netdev+bounces-254501-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHaoNiqkeml48wEAu9opvQ
	(envelope-from <netdev+bounces-254501-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 01:04:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4617AAA15B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 01:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A30F5300A61A
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 00:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168322581;
	Thu, 29 Jan 2026 00:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="o4FH7OVH"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D239179A3
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 00:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769645096; cv=none; b=RPTzOrjTcd04Sd1bsMq+QHKsaKl2k5Bu0YlWw4d2pL6WWHM5LeL04DDbpt0Go7gIWJEPFTRnaOONt8iiP1Z1iYgcSoqzBSf7Tt0VxppMZ3H4maH61AaE34MTv+Zjq+JL2BiFqffZbgdFOTCf6AyLd1VGpTXkMAQToiUDN7UdMSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769645096; c=relaxed/simple;
	bh=bTY35kyhtjhmnhXVsZ+1TPKg0VST9R6RoS6BPEyMvk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oAmsiaOgBvCnYxMbkaMBP90vKmtYrBLtawf3yUB/3Y63wo8dhza/TgNm1UHH57NjeieUaPJHiZZe3ftcICyJ0+lYjn2fzzoxk9cq67xayka789PASn6j7Yq7+nUli5KFR8+WXTyUn7GrLEucXUodndZWM1ZXAEzIczCEyxHuMcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=o4FH7OVH; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4f1fXK4clvz9sv3;
	Thu, 29 Jan 2026 01:04:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1769645089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+JnuMYIC7y1bbb5+eOj+QfMYFNUXpE6iagH2WsJTsnQ=;
	b=o4FH7OVHtPB2ooBkRvKJybFqpvStNCgy6G6Bb3VXuPKzdz0ooucT50edEQXaldeM28zO+t
	K18MD87X+HK74iQxytSfKO8aJgXiHgkbh/TpJ7WXIAa19ksXRXh9tPlf4F4k8DTd6XJ9i+
	MAlnfllwcQ1ZZyDGs+74kBqjPRUlXAX7vfZWQewm3zgCoNafyxmi6TR4zuCnX136UjEFCP
	Swt86/Pl7f7YSn1aCQA70Xy0dr/t3qH8CFIbzRm+yPUAwpeSu5d2nusEX7DZlRWV9dvYDF
	3hAY9Q+oKsvEskjbJGFkpGGNfBg2A4pEGTMGdSeqtO2yOphOS0171vETn6L+0g==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of hauke@hauke-m.de designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=hauke@hauke-m.de
Message-ID: <d80fef86-ba14-4bd4-bce5-4d61a75d591b@hauke-m.de>
Date: Thu, 29 Jan 2026 01:04:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Status of orphaned ltq_etop ethernet driver: mainline vs. OpenWRT
To: Heiner Kallweit <hkallweit1@gmail.com>, John Crispin <john@phrozen.org>,
 Daniel Golle <daniel@makrotopia.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 OpenWrt Development List <openwrt-devel@lists.openwrt.org>
References: <43dff7cf-cb00-4480-8856-501a8313951e@gmail.com>
Content-Language: en-US
From: Hauke Mehrtens <hauke@hauke-m.de>
In-Reply-To: <43dff7cf-cb00-4480-8856-501a8313951e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[hauke-m.de:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254501-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[hauke-m.de];
	FREEMAIL_TO(0.00)[gmail.com,phrozen.org,makrotopia.org,kernel.org,redhat.com,google.com,davemloft.net,lunn.ch];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[hauke-m.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hauke@hauke-m.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 4617AAA15B
X-Rspamd-Action: no action

On 1/28/26 21:23, Heiner Kallweit wrote:
> This driver in mainline lost its in-tree user with commit
> cd93b4895ea5 ("MIPS: lantiq: drop mips_machine support")
> in 2012. Since then it has had no in-tree user.
> 
> Only (?) user seems to be OpenWRT, with several changes to
> the in-tree driver version:
> target/linux/lantiq/patches-6.12/035-owrt-lantiq-wifi-and-ethernet-eeprom-handling.patch
> target/linux/lantiq/patches-6.12/028-NET-lantiq-various-etop-fixes.patch
> target/linux/lantiq/patches-6.12/701-NET-lantiq-etop-of-mido.patch
> So it seems the driver is maintained in OpenWrt only
> (except tree-wide in-tree changes).
> 
> To me this leaves two questions:
> - Move this driver to OpenWRT completely?
> - Or mainline all downstream changes, maintain driver in
>    mainline, and mainline also the users of this driver?
> 

Hi,

I think dropping this from the mainline kernel is fine, if it causes 
efforts for you.
This is the Ethernet of the Lantiq Danube SoC, the SoC is probably EoL 
since 15 years. I assume that all users either use the vendor SDK with 
Linux 2.6.X or OpenWrt.

I will not spend much effort on this driver and others will probably 
also not spend much effort. We can move it completely into OpenWrt and 
keep it running there.

Hauke


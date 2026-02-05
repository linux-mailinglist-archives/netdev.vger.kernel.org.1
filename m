Return-Path: <netdev+bounces-257245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAFiKrLAhGnG4wMAu9opvQ
	(envelope-from <netdev+bounces-257245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 17:09:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1D2F4FE3
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 17:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60E9B30055F5
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 16:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD20A423A6D;
	Thu,  5 Feb 2026 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="jvezvik3"
X-Original-To: netdev@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DF6429813
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307747; cv=none; b=WRP3yCjjBnrf3JK02ECn90O8wKvLWjVH6ok28aTUbjZg4/nl/qCSLI+ct1NKJVn+IjkdSo0YeDmkeSsMzWaMefRku0JpK/KeZviCXH4XUOfd274CgG5owtvC35boKc98dUlrtKRBUotvWkapuW0XtKwKKwqPQHHnJEsohGWQSA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307747; c=relaxed/simple;
	bh=10aIrcqCdEdMIKNXQ0abaaQDfh4zdVS1zv0QFBd9pUw=;
	h=Date:Message-Id:To:Cc:Subject:From:Mime-Version:Content-Type; b=k+cC/EYagpgmbwthZV7Kh7kJveTqPVL5GWyg2V8m5lFaABmmza4ZWoOSjS2DQ+pYuS5FS4oXg4vXdksAm0aTuNkJtAyOWShy408XS18/Iohv8QTOuHTVgE9hxJBRbzLyL8L6CJ+EY6zz7fX3g4OUxyKLMPuDTlW4W38v7GUpnBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=jvezvik3; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:From:Subject:Cc:To
	:Message-Id:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=w0X+x/tVrh8Uccyo/RP+/OE173S+ry/7Njrrocp4d/A=; b=j
	vezvik3JX0TB3fasYLppyRCYr6ut/HY54YNJ2AGF3+kO+H1TLkXJCD/U/jbPbJ7Eh3MhIDrZB/FC+
	LOYYacQ7Sn89Dwcz5R24YNnJpBlhjuoDekh7inZJuszEyfx7bmzxkCfgIgO3he3E/jmOY+Mibow+3
	QfCJWULJhcpwNJUmZLykCCnQ3fPwAUtfVPuZJaPWnVq/YUSJbpXarpWrkgUIjIxcwfkoXE9Q4OO3u
	fb2qNBEv0Q1oqUkYMPcwWAxzT/voQFOsUbCuiqpsKZjUxwNCbrBZzr8nCKEvAR6PXlrWB3bLkSTIg
	bmtDcl71nQFC/DYn6aWOQvzIUEbmTzvDg==;
Date: Thu, 05 Feb 2026 17:09:59 +0100 (CET)
Message-Id: <20260205.170959.89574674688839340.rene@exactco.de>
To: Sean Anderson <seanga2@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, <netdev@vger.kernel.org>
Subject: [PATCH] net: sunhme: Fix sbus regression
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[exactco.de:s=x];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.56)[subject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257245-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[exactco.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rene@exactco.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[exactco.de:-];
	DBL_PROHIBIT(0.00)[0.0.0.2:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[exactco.de:email,exactco.de:url,exactco.de:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,patreon.com:url,t2linux.com:url]
X-Rspamd-Queue-Id: BB1D2F4FE3
X-Rspamd-Action: no action

Commit cc216e4b44ce ("net: sunhme: Switch SBUS to devres") changed
explicit sized of_ioremap with BMAC_REG_SIZEs to
devm_platform_ioremap_resource mapping all the resource. However,
this does not work on my Sun Ultra 2 with SBUS HMEs:

hme f0072f38: error -EBUSY: can't request region for resource [mem 0x1ffe8c07000-0x1ffe8c0701f]
hme f0072f38: Cannot map TCVR registers.
hme f0072f38: probe with driver hme failed with error -16
hme f007ab44: error -EBUSY: can't request region for resource [mem 0x1ff28c07000-0x1ff28c0701f]
hme f007ab44: Cannot map TCVR registers.
hme f007ab44: probe with driver hme failed with error -16

Turns out the open-firmware resources overlap, at least on this
machines and PROM version:

hexdump /proc/device-tree/sbus@1f,0/SUNW,hme@2,8c00000/reg:
00 00 00 02 08 c0 00 00  00 00 01 08
00 00 00 02 08 c0 20 00  00 00 20 00
00 00 00 02 08 c0 40 00  00 00 20 00
00 00 00 02 08 c0 60 00  00 00 20 00
00 00 00 02 08 c0 70 00  00 00 00 20

And the driver previously explicitly mapped way smaller mmio regions:

/proc/iomem:
1ff28c00000-1ff28c00107 : HME Global Regs
1ff28c02000-1ff28c02033 : HME TX Regs
1ff28c04000-1ff28c0401f : HME RX Regs
1ff28c06000-1ff28c0635f : HME BIGMAC Regs
1ff28c07000-1ff28c0701f : HME Tranceiver Regs

Quirk this specific issue by truncating the previous resource to not
overlap into the TCVR registers.

Fixes: cc216e4b44ce ("net: sunhme: Switch SBUS to devres")
Signed-off-by: René Rebe <rene@exactco.de>
---
Tested on Sun Ultra 2 running T2/Linux.
Alternatively we could explicitly size all regions, or check overlap
in startup code (I also already have a patch for that, too).
---

--- linux-6.18/drivers/net/ethernet/sun/sunhme.c.vanilla	2026-02-05 11:50:33.288906134 +0100
+++ linux-6.18/drivers/net/ethernet/sun/sunhme.c	2026-02-05 11:55:22.541384377 +0100
@@ -2551,6 +2551,9 @@
 		goto err_out_clear_quattro;
 	}
 
+	/* BIGMAC may have bogus sizes */
+	if ((op->resource[3].end - op->resource[3].start) >= BMAC_REG_SIZE)
+		op->resource[3].end = op->resource[3].start + BMAC_REG_SIZE - 1;
 	hp->bigmacregs = devm_platform_ioremap_resource(op, 3);
 	if (IS_ERR(hp->bigmacregs)) {
 		dev_err(&op->dev, "Cannot map BIGMAC registers.\n");

-- 
René Rebe, ExactCODE GmbH, Berlin, Germany
https://exactco.de • https://t2linux.com • https://patreon.com/renerebe


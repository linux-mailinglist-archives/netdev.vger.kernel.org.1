Return-Path: <netdev+bounces-261993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EZBM3QXomnFzAQAu9opvQ
	(envelope-from <netdev+bounces-261993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:15:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 653971BE968
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5A30303EA97
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 22:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D26F47A0A6;
	Fri, 27 Feb 2026 22:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9lWYuSh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE2E4779B4
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772230221; cv=none; b=IDhwDre+vod/8CDqJ98mKGBrloheLrabPQs3BfmdjTtzjas8KxSTbNtnzfke65ib4ADD23kdUcyJlYnNKnhBfTHpOdowtqAjTSH00mds/LQ0NNwNc4bh8QxgHC9D4hmxQDClDQSRpRIUHj3g42r7avGKnENmGS6G+9LGf2M4hDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772230221; c=relaxed/simple;
	bh=n6WlcTCaJ6MQnx7xFI+L6aqUD2Zud+lbwncAN2KI1C8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gB+4tCeH5vxjoOY3sh5Fzi9eRAG9FcE8B4bZR2GpkXHjHkiDJomSoxs5hLLgcNCzHOygUjatGn55LGp9sh953Cfcu8LoV908axdZvKhrbHU6Q395qrgn0ht/5kXgLZCobg0v9RC8NFJGlbBi+dupe6RAhhtPQiMROiR3z0Jn7rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9lWYuSh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso22435265e9.3
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 14:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772230219; x=1772835019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DXp31+z7klAp06S26UDQmV/zWsrhpImO6VffGt0EJ3w=;
        b=U9lWYuShvTWkdHpcVdUZ8JCrVa7yXTPySiRb/wVwovq0gPXVcGqiLeNeqlreMfe1eQ
         akEmRw7VGJN6Ef4MKeLH0cnVE8puTz0hHquBafPXgfn8B7bR26sR5pllGqdOSmb3Rr/b
         cvDs7OTz8+Z42Pbwg8njuYjeOl5ETymmSbol20PFP8kz87Yjgj16j+fePE2Q/3HbqHiu
         nECqSTHhxTB4COXlzYcoOs8qzDW3X6rKfaOidSCAAlMXH+6zHSjyFC990dBkiwakgTYy
         Y8/oM8B5zvqPpOB0yhoD47M8MEFbocOF2LWhpQwsZjaVpa1w40R9208JkW9W1Bnlzeds
         xr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772230219; x=1772835019;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DXp31+z7klAp06S26UDQmV/zWsrhpImO6VffGt0EJ3w=;
        b=W77iFHe7DlqyzkkV6fpRHsY+bvdbGDdLrpty0lKyhCGKtdT+d4TPBMUgui64MZXX0U
         Yr9ps7jZ1q5jWGDK4s+uEDgZfG9PtigHRaW/sDlCB07rO258o/McpDoTI9wubq8UqMKy
         M9dLeUN+cHSXNa2NQdFpA2/onlWhxpP2N4FcWv3v7osqUaZ+9XWNp/sMHv8QcZWkIaFm
         Yly3iNcJZ+A8L8R+/gR3c2eh6Ar/5RY+hHIETVfuupG4/76ELcQIlgfrGnPhadDM640c
         UJohEt1SBrN9NnOPd8/WWY+5/XNMDpekBAc2wsJFnfDC5wbAoSr3FrYVkTk0/wTaq7e3
         M5Xw==
X-Gm-Message-State: AOJu0Yzs0X7XEM9VXYIFVEdv1AVV+zqjycAGduIZAKU6FVlqOoeIRuUR
	lbSI5+RfFrMcSm7/JICwZaz6oswSu9VouiGFJCu96W5RkdlY+lhItBDc
X-Gm-Gg: ATEYQzwItJmHUqFixlUwPuVZkCyOTDedrDw5UGabUE0FU09KJJMrZ9rxWmOnW+CAaDN
	cy32nP0bhrNcKtXl1VhmycNarnmYIgm9d854hF8gPvp2tVm+Q4JLeuExDwgC/3Olpz1HNbGpWqJ
	tV+WeNkvdcr4koBSu0qA/FzH2xqBTJxJDW/NGLQUi+PUyIWmIUEsyMETBhP19y4LYl8V07hh155
	fBLQQONeVtMfoEAz/E9pKQQpsrC5ROsg3TPb5NMsmpOQKKsHrSZpU/w6pvfjQp8mSd4nyYYoY6L
	mUUYOC641conJvf4lH1OkO6uWsnlkdIBbg4G72Ybn7vnK68aqCQ23Lq1lEYEPODjP2BDpzqEVSj
	9J2nMlkIgMjkCIzX3phAj1Y/8MzNzzWMOC350ZMdmO/y9aja1sXyjTK7VcMC6K1EsXnxynt6W5i
	bk0LwJLAtvTxdKMTUfTgNbsyyOFfmN530ecFDIV/x4CMjkf/ZKdxi8VQFKUiN/hybBQY4hmWwLI
	z/9p3OZ7RfyAmhtn0su4HqcavD8JDu40cxYsk44APBmbNc9b5q90O+v1Y2eqPzGLw==
X-Received: by 2002:a05:600c:4444:b0:475:de12:d3b5 with SMTP id 5b1f17b1804b1-483c9c323d8mr65037715e9.34.1772230218542;
        Fri, 27 Feb 2026 14:10:18 -0800 (PST)
Received: from ?IPV6:2003:ea:8f14:5500:d4cd:9f12:bbf5:9c93? (p200300ea8f145500d4cd9f12bbf59c93.dip0.t-ipconnect.de. [2003:ea:8f14:5500:d4cd:9f12:bbf5:9c93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c75a523sm9358242f8f.19.2026.02.27.14.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 14:10:18 -0800 (PST)
Message-ID: <7876625a-bd6f-42b4-8eb3-420f39d2f59a@gmail.com>
Date: Fri, 27 Feb 2026 23:10:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 7/8] net: phy: inline helper mdio_bus_get_global_stat
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <799114be-1456-442b-b479-142e7ee9d254@gmail.com>
Content-Language: en-US
In-Reply-To: <799114be-1456-442b-b479-142e7ee9d254@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261993-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 653971BE968
X-Rspamd-Action: no action

mdio_bus_get_global_stat() has only one user. Inline it to simplify
the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/mdio_bus.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 0e2820ab8cb..48c0447e6a8 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -148,30 +148,23 @@ static u64 mdio_bus_get_stat(struct mdio_bus_stats *s, unsigned int offset)
 	return val;
 }
 
-static u64 mdio_bus_get_global_stat(struct mii_bus *bus, unsigned int offset)
-{
-	unsigned int i;
-	u64 val = 0;
-
-	for (i = 0; i < PHY_MAX_ADDR; i++)
-		val += mdio_bus_get_stat(&bus->stats[i], offset);
-
-	return val;
-}
-
 static ssize_t mdio_bus_stat_field_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
 	struct mdio_bus_stat_attr *sattr = to_sattr(attr);
 	struct mii_bus *bus = to_mii_bus(dev);
-	u64 val;
+	u64 val = 0;
 
-	if (sattr->address < 0)
-		val = mdio_bus_get_global_stat(bus, sattr->field_offset);
-	else
+	if (sattr->address < 0) {
+		/* get global stats */
+		for (int i = 0; i < PHY_MAX_ADDR; i++)
+			val += mdio_bus_get_stat(&bus->stats[i],
+						 sattr->field_offset);
+	} else {
 		val = mdio_bus_get_stat(&bus->stats[sattr->address],
 					sattr->field_offset);
+	}
 
 	return sysfs_emit(buf, "%llu\n", val);
 }
-- 
2.53.0




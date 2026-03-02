Return-Path: <netdev+bounces-262674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLktGXuhpWmuCAAAu9opvQ
	(envelope-from <netdev+bounces-262674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 15:40:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5951DB0A0
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 15:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6690312EF32
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 14:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5603FD13B;
	Mon,  2 Mar 2026 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQ09nBsB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5899E3FD130
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461787; cv=none; b=r9cfeuIyjx627dVLziHemVsW2i36nkO1z/rJLuNzTZeCVeie3ZBHIT6bvfLL+0+Qea2YAi2NT+to/3WyjTbthPo49bQmjzWdPFqXKCMQVehU1Eh4eQqcNiaKm4s0mzJ7VeHg+PRWoPNg1yj0un7povx65nukXjRIHOeM8v4vV3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461787; c=relaxed/simple;
	bh=eqdCcUzztg9dkFVpWVnXbBGIb5ze2YX8fLD1r9Emzz8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QRKDv+zNR0L6Ah4Zjm6GWdAciibuXcEQ5HqkMp2GR5xthHVEDA8mR8iJ8rhb3s2Sx+36hDK9WVh/SV0bFTLyjYAc8BLjl0IQLzWKXu7qUF2PURfND5wLDyfnwphl8UiNi8O/426lJPRuhVdLLvZ2TeZvaSh42n7C35+YFnFS5WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQ09nBsB; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-359866a1d02so1190038a91.0
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 06:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772461786; x=1773066586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HXRhGulAtt197gYnJyd1BzBdmELAPmcsmWWQm7dKai8=;
        b=YQ09nBsBnsqHj4+iBuUXZ8RvqYXXm90wO3RFXS8GECmyJ3ZPih6fqyugk0Oba5cGW2
         JxABJkppu+51fsG+WMV2YXuB2Jb9yXqPTtY2uwFKcXtf7srwLC74XbSCos/8Yo0fNU5a
         H8M8XuSKZ099ZoW/GyRItZLCFEFrqKLKuj2Z+gyjqjT8owOd06izGBU1ORrTj8piDGYE
         hWExg4rkvChH2LqmlHxe04CI+3ryZ7sHfmeHwoCIuVaYyiCtz9RCfMU0CA+Ie1RZon8I
         o8CoZwMX4sRjoe3uMgW9FbEzqJ5K6NhPjbQl1MAlFfe3Kh6D4IJ/PFrjj/olpQQsMYi4
         Rpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772461786; x=1773066586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXRhGulAtt197gYnJyd1BzBdmELAPmcsmWWQm7dKai8=;
        b=a02XbQD2kdn64wJAk0TAwNHmWHXLxEsfbqhARuzf5IwKqBIDjZXY5H7Rw7ShbUScF5
         nF9/1nU/WHNYvHIJ5cuYIx1GOQDVMGREEu8Lux5RI9zfSyCa3uzLqMFTvdpslBMIkbv+
         i3JwZYn59sGNIxCNULACuaAQhTZrVdbKdmwwmMFk9EZBQRppah7yyvLCSoVC18c6/4W2
         NJmNFKdCnjZif548z+dWAMZQrptK66t6gYZtLRp36rzfnieKYOKi29vNl1mNbIfXRz+D
         yueNxdNDZnOYm25nYaEKFBFwFEvDWqKMxYzZDx3EI/jS/nyDRRhNtDr0Mnt3o/a8Ae+7
         JtOA==
X-Gm-Message-State: AOJu0Yxs5PvKsXtJmqtrYuaMOafuj9gSAoqmopSl0vDV7JcogsnmZ7ME
	G0HfrTxZNm5Udhz5pAntH9jqqR/iGIKYCICHyRKYZrIZLwFQ5L3UOgaT
X-Gm-Gg: ATEYQzzl9HRMqmpIs8qBdXXXowr5FNKES4xVBvm0IJk9sYA14oq1cHn43XUIvyEb6jW
	jgEBymzGxK/Jmv2+3qpsD87ILS/7ZUPjtk7JhqXf551DkjbTPLwYCHH4p+APPZ43zWmuRTJRTRC
	8+za+c212vZLvQc3ctwoTUVLw+bY3HlFA9ExaovWvIxAFqZv5veEGJDIRdnHrmUYe0otNt60HNe
	NHwZJsqOhsEd0tNXNWJ5OHurDKbR/Ao0yh6i5r0ziXABONEMD9+/Ibah/joBk1HpjSw9FxcKPQh
	KvQ3N5tsng0iDvqdRwp/Nie/2NiscRu6vmHR9QihdnOvU8hhGnWJrLJal+8yWCZ8Ap8cJ+Myyrr
	q2vMM33kgfgO0vCLP4xFSkWd18u+LHBwDE7+KtnTv6ZRC5X3DYlVluVu2BXwqmU5RuTgmbmpKk0
	ikTZ4ntfUUJIxfx1UJ2W47qFzv2BEX6etUo/rm4qrkyICn80X6x85TYBkbHb42ApOpsIsE
X-Received: by 2002:a17:90b:2fce:b0:359:8c21:ef51 with SMTP id 98e67ed59e1d1-3598c21f1dfmr3561329a91.4.1772461785578;
        Mon, 02 Mar 2026 06:29:45 -0800 (PST)
Received: from sean-All-Series.. (1-160-230-14.dynamic-ip.hinet.net. [1.160.230.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35912fbc363sm11341251a91.2.2026.03.02.06.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 06:29:45 -0800 (PST)
From: Sean Chang <seanwascoding@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH] net: macb: use ethtool_sprintf to fill ethtool stats strings
Date: Mon,  2 Mar 2026 22:29:31 +0800
Message-Id: <20260302142931.49108-1-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BB5951DB0A0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-262674-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:email]
X-Rspamd-Action: no action

The RISC-V toolchain triggers a stringop-truncation warning when using
snprintf() with a fixed ETH_GSTRING_LEN (32 bytes) buffer.

Convert the driver to use the modern ethtool_sprintf() API from
linux/ethtool.h. This removes the need for manual snprintf() and
memcpy() calls, handles the 32-byte padding automatically, and
simplifies the logic by removing manual pointer arithmetic.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
his patch was previously part of a SUNRPC/NFSD series [1], but is now
sent as a standalone cleanup as suggested by Andy Shevchenko to avoid
cross-subsystem dependencies.

[1] https://lore.kernel.org/all/20260301161709.1365975-1-seanwascoding@gmail.com/

 drivers/net/ethernet/cadence/macb_main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 5bc35f651ebd..dadfedd6d799 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3145,7 +3145,6 @@ static int gem_get_sset_count(struct net_device *dev, int sset)
 
 static void gem_get_ethtool_strings(struct net_device *dev, u32 sset, u8 *p)
 {
-	char stat_string[ETH_GSTRING_LEN];
 	struct macb *bp = netdev_priv(dev);
 	struct macb_queue *queue;
 	unsigned int i;
@@ -3158,11 +3157,8 @@ static void gem_get_ethtool_strings(struct net_device *dev, u32 sset, u8 *p)
 			       ETH_GSTRING_LEN);
 
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-			for (i = 0; i < QUEUE_STATS_LEN; i++, p += ETH_GSTRING_LEN) {
-				snprintf(stat_string, ETH_GSTRING_LEN, "q%d_%s",
-						q, queue_statistics[i].stat_string);
-				memcpy(p, stat_string, ETH_GSTRING_LEN);
-			}
+			for (i = 0; i < QUEUE_STATS_LEN; i++)
+				ethtool_sprintf(&p, "q%u_%s", q, queue_statistics[i].stat_string);
 		}
 		break;
 	}
-- 
2.34.1



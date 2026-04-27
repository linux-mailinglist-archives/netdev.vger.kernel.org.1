Return-Path: <netdev+bounces-281405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FMME8CN72mhCwEAu9opvQ
	(envelope-from <netdev+bounces-281405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:24:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 08216476502
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C1D23022407
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF2335970F;
	Mon, 27 Apr 2026 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmrdXLXT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D11352F85
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777306845; cv=none; b=ZGJbmNxWrpdIFvI4C8jXJbbdMw15TctJIM1i65SSKiUAhqe30XYWZ3yWHdIHD5azsXpL7H4SmsGB8Dsxlmjr83t5gxa5QWiDVwNcxZQcm4aDJ5Dfj5oqYD0QQpm9fntwAUAJm7O20qCkn1X8kmrT9OD7tU/SQk5OkDICzk+S5vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777306845; c=relaxed/simple;
	bh=7Y3TJuZg/L0ifkW1rtLCRvc0YmCGJffnw+RQpsp3yYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k7mEBGrDFV02CVXhJ4h+bRBPSsv3vliBN+4FFTDCBaMlR9X9EBPQDSC4rXUbkQWfyndBpYUDQqTTwJySOpJJGpMkhf9BLiDxOWg5HyDeKR5Qk36HbrDq2nU0ll35cpbB8lrR2iBLpaqWGpTPf7r8NXf4AV8+3D0v8L9tQ26Pg2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmrdXLXT; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-79ea87af213so159369427b3.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 09:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777306842; x=1777911642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6R1SX8mfYaQyk9uLV5N24I5+ak1Z8uoCYi8CcuK4+lU=;
        b=GmrdXLXTz515EDEHjo3UlyvnBe6nIXvalhFcOtz3okn6+g9FZJcSYyD7VonqyqlAR7
         +xB5rpM8G/Vkr7Fo3Jb0k90hP+Pyi88NHciKbPKCZm2W5sOsplMFwZXeWmxLXvWpqEgH
         gS4C61qCG3fSkIZqQjiFkTiNzhcupvSapAVcgQ7Lw7BeKPx584ah+3dehRqfQ+u2Ag0R
         AihPELSepM7tgysOFmR2PVB7t9Pl9M9tCYzLIBxEJ9PkirKGmWT70WK77xtDYZ4eBH6y
         l/U/lxQxRu6q/7zLm8VyJByobUM5siPjYKlyi2MMstfS9T9iM6JVZOTFOmyVghIU4CPu
         Ji5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777306842; x=1777911642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6R1SX8mfYaQyk9uLV5N24I5+ak1Z8uoCYi8CcuK4+lU=;
        b=GGNZZNRSUrIZ9AEgsXhhgBgHin3t2d3BZiW1HzTPds19S5871Zgvm5kMH3n/GEyefX
         PBGjMTBrMLzU6YYCUT/Hg5GgYWbaiyU26kpSWNzBTpX3Ct7o/MUSaB3Q79bviN6VgX1v
         UQkWvi+M7JNAG0HY4aPJ4H48MFU7JMJnqMLCd8kLRnGEqGd6/MV+3VcUxs7FNSztBo6N
         L7v8Y+97L8zOajaa8t8sU8VuVJQifSHNuwZnKqOu9+etB2gMPLCS/LVpULANMgAM0oez
         Iqx38eTxGMf1Yx7hp4oTBqL8Xku4pezAw+kym74pWRu1WWjHxMOKNvUJZ/LYsQ+Dyqr9
         waeg==
X-Gm-Message-State: AOJu0Ywyb0PiedDF7QaT4qqjqI8h4ESPTXRbI6L6rZm1f1AYBM/K4tdg
	a7tyoh0CBq1zLDJ9NmZZmOUbBa/d9tqgKaX8y9bhAK7NmCD8olS6Fyq3nA6kWkvhwUDozsZc
X-Gm-Gg: AeBDieu2x+LV9zk9WhwftQGDmFV4/jVfu2Yu//D8nEg6m4LVhPvfkuGDTacrhmpErFl
	6B25o2ios5tmg5Fp5X/G2+BZ+taBgumCCXYO29ek6g9WtgysvXCFtwi/iAdhmsu2W4L5ycvonVF
	DpsI+qCEnuxnqqJTa7qUy5jApr8OydWe9IqpMaL1U7meYNIrkd+cDFRTZklIGKb8+uecK8gYefP
	5CEqoMypEI6PlfDr6JWdLt7inHCTVXsaz2frzgTD1bt8a/9l4d2plTqlbbiDzklFclQC3Cv77lH
	+DifVWJoMnVz72yigyvyjdmVJ6svGTtJA5eobopLzi1SpPj+1/8Iu7hG1Ap7/c/yimNr2WjbAvh
	orMRwook9xkTo2iI83zKChvrlnfdw5YqSQJpCQ0cz63NOBi47hS6K4ffzKKThUVTwuVZ59F11VM
	7iOt+xZ+Vy+615o6l1yIvsTyusjoj8aXKjmgmxwWB+hco8Sg7xcrkfrZ+HUL3znaYhrIlGUH2vV
	vQ=
X-Received: by 2002:a05:690c:e3cb:b0:7a2:ce0e:8641 with SMTP id 00721157ae682-7b9ed4195admr339771827b3.18.1777306842374;
        Mon, 27 Apr 2026 09:20:42 -0700 (PDT)
Received: from localhost ([2600:1700:3420:b5d0::45])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee89ac09sm131196407b3.3.2026.04.27.09.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 09:20:41 -0700 (PDT)
From: kernelcoredev <sonionwhat@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kernelcoredev <sonionwhat@gmail.com>
Subject: [PATCH] net: nixge: fix skb leak and missing bail on DMA mapping error
Date: Mon, 27 Apr 2026 12:20:34 -0400
Message-ID: <20260427162034.7502-1-sonionwhat@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 08216476502
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281405-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[sonionwhat@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

When dma_mapping_error() fires during RX buffer refill in nixge_recv(),
the skb allocated by netdev_alloc_skb_ip_align() is never freed, and
execution continues writing a corrupt physical address into the hardware
descriptor ring.

Fix by freeing the skb with dev_kfree_skb() and returning early.

This was tested via code inspection, as I do not have access to the
hardware. If dma_mapping_error() occurs, the current code continues
execution, which can leak the skb and program an invalid DMA address
into the descriptor ring. This patch ensures proper cleanup and early
return on error.

Fixes: 492caffa8a1a ("net: ethernet: nixge: Add support for National Instruments XGE netdev")

Signed-off-by: Bentley Blacketer <sonionwhat@gmail.com>
---
 drivers/net/ethernet/ni/nixge.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 230d5ff99..b64e2f355 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -645,8 +645,9 @@ static int nixge_recv(struct net_device *ndev, int budget)
 					  NIXGE_MAX_JUMBO_FRAME_SIZE,
 					  DMA_FROM_DEVICE);
 		if (dma_mapping_error(ndev->dev.parent, cur_phys)) {
-			/* FIXME: bail out and clean up */
-			netdev_err(ndev, "Failed to map ...\n");
+			netdev_err(ndev, "Failed to map RX buffer\n");
+			dev_kfree_skb(new_skb);
+			return packets;
 		}
 		nixge_hw_dma_bd_set_phys(cur_p, cur_phys);
 		cur_p->cntrl = NIXGE_MAX_JUMBO_FRAME_SIZE;
-- 
2.54.0



Return-Path: <netdev+bounces-260597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aC1SJ+jYnWk0SQQAu9opvQ
	(envelope-from <netdev+bounces-260597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:59:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA1D18A33C
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D95A309BFF6
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8BB3AA1B4;
	Tue, 24 Feb 2026 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5lf/U2e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F493A9628
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771952110; cv=none; b=uyvxTsNTlfMHJnOzOWI0T50tuK/XOLA+v6geHOx1gMMnnG9m0ihazm6xrrXKfL+bsO1b2zauDH6LLYOwDXzwP1HyxzKKGkZEq5HNsQ4MiCwSSxbmDENYojS0VX400f3IeM49GhlpqGJK9IcsHJGqg8R3/FSirzEkpAbJTIXTLOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771952110; c=relaxed/simple;
	bh=6D2xm2u7a0Ard8UD5jhMoGvejwPvgyeFwzrZ6ep9k/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hCF13D3fdzWZpEKSMd8Sy7Lf6AOOFDEj/E3R8KU8VuqpOac0yiWpRmmXXn91K17ObgNuSOy1cQ4lRTzIOaSnCc9L8y2GJTm7t12m7jkkZ/JbTthGmeL6U1gUCZz4feMvbn2MWO2nmoC/7LnQvYaHLOfjQZT32YwtQJYj5tYdlmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5lf/U2e; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2aadc18f230so35402125ad.3
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 08:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771952107; x=1772556907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dk99oPBkOKQC4NJdNNbbUKUujZV8OZzxFj2+2UXmSY=;
        b=b5lf/U2e+Fzcg26x6XgKDfQlnHZEW4cshIEkFjtlRi33fVqo5AS8ha4h8ABOtZaB/U
         xy3UjcOwnWvjtcqFAtYbVsdOSgn/SClA3t5l1GSkiwGooJgqJj13kPmriGJdwpAAMPU0
         ipfXes1XdEzintpKmD+dZ1jBjI1Ccek1GDWOmFy8nFJIsA3TN2EKzryC52qYNvvm0iQJ
         ADF33DVBdCTyGSSmS0GtWDIBtNv2PO5i1yeDJcTsQi1YEZ5vOJIJOk7BFQrfd3Rgm8Vm
         yW40PBck7HXrZmRw+QFJdhc9aD9nKm8kETdQg8BN4rEvo/dwlm2Sl0tot9aJnhrpakmZ
         n3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771952107; x=1772556907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/dk99oPBkOKQC4NJdNNbbUKUujZV8OZzxFj2+2UXmSY=;
        b=wqtbDJIWLCgjlp8Srw/D5gbr3rmeKiRXnlaV/SFGwSFRosaORD5NCi1JbdJmvn5whJ
         EvJw/hEmT2BnxvEQtJhgU4fC6GEafwj2rjh6BkXrsGpJ9qM2IjFaJ9z+9355bVJpeHrI
         x2oUmJf4kwodmKZGCZviJXZRdl55izzyksHPwLbncA5zRj/ql5ssU7wZAQ98lvfKGFkK
         SXQoFkbu4KUI4AaE2G88GplC+eh/2nPQtVGwEYsGAeApmc95/HEHlL6v6qr9UaIgxOVo
         TNaEHJZdVczPt9HPKoTvdsAMF3JV8YOVme0C9v+ITVdRf2ZyBDhnTP2NtcOX5zu6CILz
         /org==
X-Gm-Message-State: AOJu0YytOiKOvBJveFKLZtPdw/OJf0F7JdAXpPCoIvM5TlNYFirIJmKF
	/xQPAypTlg1EV8PRkECwBFG6kVrpKdbjDug24hZqYe1D+5du1KXtRaPz
X-Gm-Gg: ATEYQzzRvq1U5rleH0jhVLEmZD1eo2g4PuOc9x5QZXRF1qvVs4Qi46eTmJO0uDyqbCC
	jN9reGV3lKZaZ3T8lAnBA0e2kacZ3WxICS5R540tM5pqiqIB8MKvEEN/xSWkKjqBKSCKY1Kxhzw
	8PdtepbOGUgmOHD5hrhxxkQVp9jWWUXqCdtLvdRsB7atno5UwJeeR4I2Hu0/cfhsF9PBcb2euel
	Jf7ERcdOMYDftnVtd7f7zt/zhtO6kUSbuplJWuCjZNpYwHn/dvE0e1dDtPuU4tKo4AUbfJmXgmc
	CLNfAjYbLEFrV+PJIXPsSf53qRy5v+rS2bF87VyBPj0aDrXG7v3nsghQmLadJLTu5uWEJEVlUJO
	1zvMGIwGYFgSR0iQQALsFgAGh4sI1/2UN5zef8MlaIpaJFk2FdmuH/49xFdbQekYg8IERki1uTV
	o0mb/y3A+eGk1KHUENaPSephEBQDJFExOwAjWKq5OiW4nqWqIIaDDrE2BFJnxNPha/XZ5Rr3cuv
	w==
X-Received: by 2002:a17:903:285:b0:2ab:2bc5:4365 with SMTP id d9443c01a7336-2ad74464438mr87550565ad.19.1771952107313;
        Tue, 24 Feb 2026 08:55:07 -0800 (PST)
Received: from sean-All-Series.. (59-115-199-112.dynamic-ip.hinet.net. [59.115.199.112])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b7256f32sm12364083a12.27.2026.02.24.08.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 08:55:06 -0800 (PST)
From: Sean Chang <seanwascoding@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v3 2/2] net: macb: use ethtool_sprintf to fill ethtool stats strings
Date: Wed, 25 Feb 2026 00:54:35 +0800
Message-Id: <20260224165435.17648-3-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260224165435.17648-1-seanwascoding@gmail.com>
References: <20260224165435.17648-1-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-260597-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4BA1D18A33C
X-Rspamd-Action: no action

The RISC-V toolchain triggers a stringop-truncation warning when using
snprintf() with a fixed ETH_GSTRING_LEN (32 bytes) buffer.

Convert the driver to use the modern ethtool_sprintf() API from
linux/ethtool.h. This removes the need for manual snprintf() and
memcpy() calls, handles the 32-byte padding automatically, and
simplifies the logic by removing manual pointer arithmetic.

Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 43cd013bb70e..616823e9fc5b 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3145,7 +3145,6 @@ static int gem_get_sset_count(struct net_device *dev, int sset)
 
 static void gem_get_ethtool_strings(struct net_device *dev, u32 sset, u8 *p)
 {
-	char stat_string[ETH_GSTRING_LEN];
 	struct macb *bp = netdev_priv(dev);
 	struct macb_queue *queue;
 	unsigned int i;
@@ -3158,10 +3157,8 @@ static void gem_get_ethtool_strings(struct net_device *dev, u32 sset, u8 *p)
 			       ETH_GSTRING_LEN);
 
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-			for (i = 0; i < QUEUE_STATS_LEN; i++, p += ETH_GSTRING_LEN) {
-				snprintf(stat_string, ETH_GSTRING_LEN, "q%d_%s",
-						q, queue_statistics[i].stat_string);
-				memcpy(p, stat_string, ETH_GSTRING_LEN);
+			for (i = 0; i < QUEUE_STATS_LEN; i++) {
+				ethtool_sprintf(&p, "q%u_%s", q, queue_statistics[i].stat_string);
 			}
 		}
 		break;
-- 
2.34.1



Return-Path: <netdev+bounces-281587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJBEB6IT8GnXOAEAu9opvQ
	(envelope-from <netdev+bounces-281587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:55:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3D647C8C4
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 79DB1300B50A
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D55E2EF653;
	Tue, 28 Apr 2026 01:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFJLtLKr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108D62E7BD3
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 01:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777341329; cv=none; b=CpqTZOpHokcgB56IyfI7Ue24LxzbUmI1UHUrpezOF49yCTSN4Nnj7aZ3uz+vj4DUzXEfqnAE54aByzusER2s5T2/N0nk4837NvLHsjr0n5hVZ5msV/KQH0D3+erz0tw//IG7iLGJ3iuQJuTvgLIcAeMRrH0B4QrOOEzqXf+d/jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777341329; c=relaxed/simple;
	bh=kEC8iz+za6oVFzoBL743u86JXYeZApyXb7bIcdS8eOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMjrVX0udgvDMvO3w8v8UC4FTjuphEL/ycN4hAhCrpwD2H1is6ZKlGul3pi/2DJiXayHPDBewX2zrhuD0OLwPO3h40cxWenZTcHNtoX4Di6G19FBZ0bnaJN9ntd4mh4hXbeEQrNJ/op6X/MyAcY0nchUmSmZ5lNQSNeCds6SZNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFJLtLKr; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2d96243c91fso17729172eec.1
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 18:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777341327; x=1777946127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fARec+nI7yhQfM7l30+YoxkOthmyRbzKG9sUe2e81Lo=;
        b=jFJLtLKro7bXzvQqRH3l1hNwqwbHECBxdIt64TQvmYHkq8TdWYeLQHlFDYUuB9IF2w
         fWixNxxJRdfc0+AXct5s7DMC8PB2uSDCK5lEflR5p9oJvJ5XmfaRGp6ifV68g8jMihfH
         L1WO+BH+fnOA5zYElRIeKNgfb07r374M+cgyeg0/kFA6t/tVtny33QKfa4BEZQxbnw8F
         eap/algqk00rdWBNGVjUM8HGaqGvmNEwEp1QeP6U26Y7ss5D2sLwpRVqZbqjaFbJSo6x
         S75IFtyy2l56/r6pm4Co7cwDKfx4FYNNVwdeR+Vfkysa+ubQto+sjMrh66SuUYJ0loQz
         ZHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777341327; x=1777946127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fARec+nI7yhQfM7l30+YoxkOthmyRbzKG9sUe2e81Lo=;
        b=STRZB26gvrZR6r51qVfElV1PACvTs5cBlvB9xnlRCFUzSTr+Y8sbjkHBaVOtiJjOD2
         WcrHEoHW2BPaZ1HYTnvZJC9DcpYp9lYZ29ZOMpHgeE2ZY4KJY4wJaSli4Q2ngCyOPxXw
         Lut33BsZYH9JuszVIrDY7chL35DrLSlwnRUdsFY6qeMJI/1nPHtvEDsNbLmHjntbG2kn
         CfvP5OoKfawo2RLqS7uLkHxWiKauUErh08Jy3p2ntKkxpasrWlalS6xVsp1LY6Tcak5o
         6ot4Aa4zi0pZkSdGuoibvf5/b2mHPbVqKOemG193JgGKZa0J577mwBLnb/Q2PqqcwaUq
         bdvQ==
X-Forwarded-Encrypted: i=1; AFNElJ/cJyyGPA/LyCc3NejoJ7yzgFLVx77zPycCtKRn6IC8HRYadpi9N6hpUSCaNmTYKYyGYKh8NjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyilskFCyCg/Y2X2N7GMqx6HmnlB7TL8XIjnMdGbFoM09FpUuxT
	cUaVnkJTtHV9wUYb9ExLb22hDmVrfl8H6+NicSjGx5nPS0wVmr1JlbOY
X-Gm-Gg: AeBDiesjttK4qMfagYcPz81kMjH4J0YkvCFzclTywrrx8lxw0UOUdIXdeYaf7DCURMP
	gvcd42SU0RYb+aOEmGFNCWG+IOK4LmT7hwgfnv7MkmsChll2v9tRy12ZDIxZNI/C0MFuoqP9sRu
	XhwlHYfsKzBRKhwUlqXTutLse9aZulx9R9YOwuRmsPct5/rWdsNwwrUIC1pvpS8SAa2nOI0GQwu
	4bUK+LYC8QLD39H/50woPjO5TZgLr5J5NIPnRS6MFNq7Y1QdmNtF8UWRKqB9CU35+5nkITyBFlr
	FIgeqUTbeyyQvYGra6XURtzCXElkIkEZrep9mMZnzYjglgoyCoN3u5A3s7TCuObQIz2lKJm08SI
	YOBiGVi3JB+BNxXfmlDl2iUpoXlTthMQSAmC+7L5jBxjyl4/hnQrLNI0k2r4EAkC+wy9C7Rdipe
	HEq3oJpqhk3AB8JtYTyBrn92zSrQCYSF2PW+l/5KLhsCidZGz0OXzYMHymZH4gDS8mg7XLhxTFF
	r6inHNwvG+0TZMBBgHSAkbH0hV40YN8BXvzhj9FNpGBUHKVCOuCq1Cxm123qCTACaV5gcuPfXRU
	cYtaBWAoyxfXGBMgN/97jdZQ2+ZC/Jdam6zmhOs=
X-Received: by 2002:a05:7300:dc88:b0:2dd:5641:ef2 with SMTP id 5a478bee46e88-2ed0a185d4bmr685315eec.25.1777341327172;
        Mon, 27 Apr 2026 18:55:27 -0700 (PDT)
Received: from appmana-001.i.appmana.com (23-93-84-4.dedicated.static.sonic.net. [23.93.84.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed09f8a909sm1233947eec.4.2026.04.27.18.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 18:55:26 -0700 (PDT)
From: Benjamin Berman <benjamin.s.berman@gmail.com>
To: Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] net: thunderbolt: enlarge RX/TX ring and set NAPI weight for sustained load
Date: Mon, 27 Apr 2026 18:55:21 -0700
Message-ID: <20260428015521.3454006-3-benjamin.s.berman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428015521.3454006-1-benjamin.s.berman@gmail.com>
References: <20260428015521.3454006-1-benjamin.s.berman@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3A3D647C8C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281587-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[benjaminsberman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,anthropic.com:email]

The default TBNET_RING_SIZE of 256 and the NAPI_POLL_WEIGHT of 64
implicit in netif_napi_add() are too small for host-to-host Thunderbolt
networking under sustained bulk traffic.  Running NCCL all-reduce over
tb-lo on a three-node chain (two TB3 endpoints plus a TB4 Maple Ridge
transit) produces rx_missed_errors at ~1 % of rx_packets on the transit
and ~0.6 % on the endpoints, with rx_packets stalling against a peer's
continuing tx_packets.

Raise TBNET_RING_SIZE to 2048 (8x) and use netif_napi_add_weight() with
a per-NAPI weight of 256 so tbnet_poll() drains more frames per softirq
invocation.  With matching sysctls (net.core.netdev_budget=1024,
net.core.netdev_budget_usecs=8000) rx_missed_errors stays below 0.005 %
over a 192 GB all-reduce workload on the same hardware.

Generated-by: Claude Opus 4.7 <claude-opus-4-7@anthropic.com>
Tested-by: Benjamin Berman <benjamin.s.berman@gmail.com>
Signed-off-by: Benjamin Berman <benjamin.s.berman@gmail.com>
---
 drivers/net/thunderbolt/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index 7aae5d915..3a096f7c5 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -31,7 +31,7 @@
 #define TBNET_LOGIN_TIMEOUT	500
 #define TBNET_LOGOUT_TIMEOUT	1000
 
-#define TBNET_RING_SIZE		256
+#define TBNET_RING_SIZE		2048
 #define TBNET_LOGIN_RETRIES	60
 #define TBNET_LOGOUT_RETRIES	10
 #define TBNET_E2E		BIT(0)
@@ -1383,7 +1383,7 @@ static int tbnet_probe(struct tb_service *svc, const struct tb_service_id *id)
 	dev->features = dev->hw_features | NETIF_F_HIGHDMA;
 	dev->hard_header_len += sizeof(struct thunderbolt_ip_frame_header);
 
-	netif_napi_add(dev, &net->napi, tbnet_poll);
+	netif_napi_add_weight(dev, &net->napi, tbnet_poll, 256);
 
 	/* MTU range: 68 - 65522 */
 	dev->min_mtu = ETH_MIN_MTU;
-- 
2.43.0



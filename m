Return-Path: <netdev+bounces-274175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MkRGBBOzWkWbwYAu9opvQ
	(envelope-from <netdev+bounces-274175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:55:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C3F37E3F0
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 092DF3176D50
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 16:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FED63115A5;
	Wed,  1 Apr 2026 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6ASxhE5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B07C36AB54
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060931; cv=none; b=tHnJ5exOCUKmDrnHnce6goH+rZp1xnKRiWz1Ztnm50FWfmlGFvU6yxZi9cEB9K7OfO7dRdF6uFJDfn3dFryo8Jfrw34psa7B+UolmqJ1tVfkRxeZxHgBV+cQYqnpjii6X9Bbymw86c9RxwqjGa9ZWfB12SpNREWsOMQQ/QiJbPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060931; c=relaxed/simple;
	bh=5DQ4kVSmkFexR6vXVTUoJOzECQBWIdhf/bqdkdxx8sM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L8cD+fys0QjM1/vganiietzKMpcB/nJ3+tIacXQWH6WC86Ce22Yyk8XpXa7+1ioSNfAKg+K0KS/tDyQ7f/GkNRlibuT2Wpbj+gJb7kqmx1a9wE6HpxhuOC/0y56y0b/ZPO/l2LwnpN9T8hpHpxZp6xM1Eo3e9x6d9KuH4UA/qkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6ASxhE5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b24fcc2b5dso26215495ad.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 09:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775060929; x=1775665729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5GQlChIfcQRvTnNhxjtzVPuNkSCMc0gjfUOYJuTIt7c=;
        b=Z6ASxhE5YtA2dHSugJdyh1SzhfI14RD5HwQqg64eQDCvxtLRtTtNK9RvMFGhDMVOqg
         KYpzvHuFMFqLUjDcPQ8NJBtNNYWxwMDHS2TPe/go9eOIG4iyWg+dnVYxMiXznFs5uczQ
         PdrdMiHGWa90/jHkSajnn1X0f3QRQdoWYOLE+7x6+6UsvFclwKkmri5+4Z6dFEpEoZaX
         t99/ORTXk5gSE7Rzzj8P3k8RAprNdx5+IXESLj4B91bUbTmYU75Mk9ImWg6v/M4vcjm1
         u+U1ehk9PvvwXtq7jbE3LwQYVzDdP9LajHREI+wS9f7sTQjehpupfUyiGfBV+b8h9+la
         CGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060929; x=1775665729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GQlChIfcQRvTnNhxjtzVPuNkSCMc0gjfUOYJuTIt7c=;
        b=gGpsZf/iHuDW38EV82HHygEq0pLySobP8T2lBn7xwMVnsllkWAcLaMxmPkrJTR0h+A
         wMzjDyYFo4PHFAf1pc2INJuLJ0QWgeYSrcjL6fMP+4tW1wxL0Ssjc8F8gnc9omO13cGA
         lFbtbG9j8cbLyUe7dBGSE5afDrpxmTibtsLu4ePJWxmKkHgjMJFTLbYGqTxQ5k44onqS
         6wjYiBPYpmv8T10us1GQX/cVdytwuhhOVx5WENHDDzmYG+XTpeB9GdwySOjILhBRWOGz
         /XXHPF0t9ZJOmnz/ADQAC8x6XpvwzEg1KSg0xisuAjeef4ZPhsv1PAw9GUxhHL7DEs2I
         xTIg==
X-Forwarded-Encrypted: i=1; AJvYcCUIqd2kX/w/+w1R7i9AFcoOJ1jn5Ax+v8NL7ikySIlCSYquvLy2XGIs2n/G6wCIPCG05XucFNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0+Vz6reNmR2nYn/gwPjbWSo39rm8brxEc4FrE60uPVB1rpOsG
	oque+hCSdHGvKDzgvE3zimJfVDKYKDQrXppmoDN+0OUytypZIojTnEmy
X-Gm-Gg: ATEYQzxdGCqlPkF0Ie7OHVBtpCCv/F+3VWz3MP1f/M1+9Rs0ChJqjc6yywCnxFkztBw
	rrQsMLQ2xaQq1daAieTPDiQePQFBlnw59IBCCk14C734/IfQe38qu8Xo5EMrf3SzlU22ifIsK5d
	u3guP/bBE9YJoIxs+fR2wQ4ZT3E2i21+6cxlJFb0Qe1L7/mqp/EsterC0W6E1XCVK7fdbzG2Lqj
	Xc1fkliVCq+QnVcBwhjL9c4z+lCfY+Pjt1KVgw/pN4HUCqbAgkkvDLbzipJ3RhFz9PxP8Ugmo9b
	GMNgW2PQfb8I6iTKJl1S7kYRmZKquJkGF4hz4GQeuZHEuyFCj2K+xRhN6raRkNKeM+1W95lhMFV
	naRpWXTnE81dpGfibiAgJE2J1GL4UUifWHvdwNXPjW48kHmQzsnNzHfsxut3+9jDWHGOZcksvA0
	/sgA708+FCcczNKdTWphNpuL2C
X-Received: by 2002:a17:902:bd81:b0:2ae:4a4e:1e25 with SMTP id d9443c01a7336-2b269c42a43mr29697955ad.25.1775060929411;
        Wed, 01 Apr 2026 09:28:49 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b274979500sm2840855ad.44.2026.04.01.09.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:28:48 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mike Marciniszyn <mike.marciniszyn@gmail.com>,
	Dimitri Daskalakis <daskald@meta.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	netdev@vger.kernel.org
Subject: [PATCH net] eth: fbnic: Increase FBNIC_QUEUE_SIZE_MIN to 64
Date: Wed,  1 Apr 2026 09:28:48 -0700
Message-ID: <20260401162848.2335350-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274175-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[fb.com,kernel.org,meta.com,lunn.ch,google.com,redhat.com,gmail.com,intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dimitridaskalakis1@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C0C3F37E3F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dimitri Daskalakis <daskald@meta.com>

On systems with 64K pages, RX queues will be wedged if users set the
descriptor count to the current minimum (16). Fbnic fragments large
pages into 4K chunks, and scales down the ring size accordingly. With
64K pages and 16 descriptors, the ring size mask is 0 and will never
be filled.

32 descriptors is another special case that wedges the RX rings.
Internally, the rings track pages for the head/tail pointers, not page
fragments. So with 32 descriptors, there's only 1 usable page as one
ring slot is kept empty to disambiguate between an empty/full ring.
As a result, the head pointer never advances and the HW stalls after
consuming 16 page fragments.

Fixes: 0cb4c0a13723 ("eth: fbnic: Implement Rx queue alloc/start/stop/free")
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 980965274079..e03c9d2c38dc 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -38,7 +38,7 @@ struct fbnic_net;
 #define FBNIC_MAX_XDPQS			128u
 
 /* These apply to TWQs, TCQ, RCQ */
-#define FBNIC_QUEUE_SIZE_MIN		16u
+#define FBNIC_QUEUE_SIZE_MIN		64u
 #define FBNIC_QUEUE_SIZE_MAX		SZ_64K
 
 #define FBNIC_TXQ_SIZE_DEFAULT		1024
-- 
2.52.0



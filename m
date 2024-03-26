Return-Path: <netdev+bounces-82227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C3188CC24
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 19:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545C51C3797A
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 18:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A9E127B7E;
	Tue, 26 Mar 2024 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXps7X+Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22F5127B6A
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478273; cv=none; b=ncSFI6f0IFsl/iM1V6Juo7d1OxZN2FwpYb44CjW6cXSvXSJ4qXez5n3LRfZpl/4po+TfsNppMEUFrTI2t9mdNk3Le4STUlbCu681rQEjuBz11wZ04/sUA3F0IHc9m4TTRpr6fAeOGnQ+wHFLOIFsikwIGW1xy95SNBc7JXRLQsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478273; c=relaxed/simple;
	bh=TDcY/5qFbu8wIhTyT/5Bgms1OMEHGYusRj6LUI4Npvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=joojSgcO6f9BYxt3E6I/7hjEl/OfzFJCpx9fL8IMFuk0riDGHhJJYRn8+wXlTCOmz20UPJdy+2Kobft2XKoIGsl6IwCIX2Q7vmZ2e7EiyhHZWBZp8F7e/qw8Ee0CRoUIbeekuVLSTigQ3BEo+d7H6Y2kagmj9KgHkZm/l5DdR0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXps7X+Z; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78a2a97c296so369246785a.2
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 11:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711478270; x=1712083070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4AnRTXFS7mF94KL1wsjVtqiIwqcoPslZgqV1JNqcFlc=;
        b=PXps7X+Z7FDBqnyB32vFQcj6QXWpX81Oiy5Sivu/Qr+/FYQxgH/sfNHPXlHL+feCas
         nXh8JgXCzfuG6BO/J3wUXMHds+pcElBT9PY2JYW/fQc1fWsyySiJnAwDGOrVHKawF4vE
         UnW5VdDBOr/ALxEsmsBiaLL3dViLTe7Pp7v2rGmoL/FrXcLFI6Rz6Xwc8PXTPPJaAbuc
         yvT99bKMX10gmI/A5CLN4CBBt5sKH3+L+b2ZEg5webG5zSvA0dXMmYSscuLohlLSn6J6
         g1oL8Re5ZyoclDTeeoLBRQAuNywBo4kUUQkq+8l+yoLjXJ5UNmiVoRwrBdXpmf6g1fDB
         7lEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711478270; x=1712083070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4AnRTXFS7mF94KL1wsjVtqiIwqcoPslZgqV1JNqcFlc=;
        b=pVt0CeS5bjowmvaacAqqLP3IedKVMj/a1KnTrgiDLd+MNaIB7ynyHAke3T3UmTBR2c
         bzSTWuWIpFWKGInYZYQeO6EWisAb2nidy+WD20bBQJyKLO5TIYcslJ3HOSI11sXd2cTY
         GbS5TZdIuu+hmstpQoptlzE+hg7qFkam9FTBOlEjtjJUcVAXX1VjE8dFSN+KYQC3vo9L
         zqeFm7pPPv676WyO6GWlirogUrxduD1d/IuNnVslS7Gb1z0iTDXH6ZeWetFh9dzJqfT5
         DuiiBnXLRQ4+eHo1FOU96oABZKJqjO6dP1Zy+5crIOxlY/SqihYg1iQ5GIJL+gKmF3/H
         rm0Q==
X-Gm-Message-State: AOJu0YyZoapquGadhCGlnrno44EeT1M49onFyngouMQsCHCSM2vhkyBs
	mhY4cpp4suBxe/xeqnX6aE6ShEwgm/J2OCHLTnyiaZR2IqZtbzVxFfx7vgpaWfc=
X-Google-Smtp-Source: AGHT+IGPWutz8WHQxUXaWQJv2uPLj1MVZpVn1k++YL0YXjVT2nvy1g89+Veaz1kRmNgbK8dg29tBqQ==
X-Received: by 2002:a05:620a:16d3:b0:788:5e6e:876f with SMTP id a19-20020a05620a16d300b007885e6e876fmr12043404qkn.40.1711478270323;
        Tue, 26 Mar 2024 11:37:50 -0700 (PDT)
Received: from wsfd-netdev15.anl.eng.rdu2.dc.redhat.com (nat-pool-rdu-t.redhat.com. [66.187.233.202])
        by smtp.gmail.com with ESMTPSA id wx38-20020a05620a5a6600b0078a4590c62esm3140611qkn.87.2024.03.26.11.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 11:37:50 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH net] net: fix the any addr conflict check in inet_bhash2_addr_any_conflict
Date: Tue, 26 Mar 2024 14:37:49 -0400
Message-ID: <20eee0606b06a3e0ec7d90a4cb24a86a1905d4df.1711478269.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Xiumei reported a socket bind issue with this python script:

  from socket import *

  s_v41 = socket(AF_INET, SOCK_STREAM)
  s_v41.bind(('0.0.0.0', 5901))

  s_v61 = socket(AF_INET6, SOCK_STREAM)
  s_v61.setsockopt(IPPROTO_IPV6, IPV6_V6ONLY, 1)
  s_v61.bind(('::', 5901))

  s_v42 = socket(AF_INET, SOCK_STREAM)
  s_v42.bind(('localhost', 5901))

where s_v42.bind() is expected to fail.

However, in this case s_v41 and s_v61 are linked to different buckets and
these buckets are linked into the same bhash2 chain where s_v61's buckets
is ahead of s_v41's. When doing the ANY addr conflict check with s_v42 in
inet_bhash2_addr_any_conflict(), it breaks the bhash2 chain traverse after
matching s_v61 by inet_bind2_bucket_match_addr_any(), but never gets a
chance to match s_v41. Then s_v42.bind() works as ipv6only is set on s_v61
and inet_bhash2_conflict() returns false.

This patch fixes the issue by NOT breaking the bhash2 chain traverse until
both inet_bind2_bucket_match_addr_any() and inet_bhash2_conflict() return
true.

Fixes: 28044fc1d495 ("net: Add a bhash2 table hashed by port and address")
Reported-by: Xiumei Mu <xmu@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/ipv4/inet_connection_sock.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index c038e28e2f1e..a3188f90210b 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -299,14 +299,12 @@ static bool inet_bhash2_addr_any_conflict(const struct sock *sk, int port, int l
 
 	spin_lock(&head2->lock);
 
-	inet_bind_bucket_for_each(tb2, &head2->chain)
-		if (inet_bind2_bucket_match_addr_any(tb2, net, port, l3mdev, sk))
-			break;
-
-	if (tb2 && inet_bhash2_conflict(sk, tb2, uid, relax, reuseport_cb_ok,
-					reuseport_ok)) {
-		spin_unlock(&head2->lock);
-		return true;
+	inet_bind_bucket_for_each(tb2, &head2->chain) {
+		if (inet_bind2_bucket_match_addr_any(tb2, net, port, l3mdev, sk) &&
+		    inet_bhash2_conflict(sk, tb2, uid, relax, reuseport_cb_ok, reuseport_ok)) {
+			spin_unlock(&head2->lock);
+			return true;
+		}
 	}
 
 	spin_unlock(&head2->lock);
-- 
2.43.0



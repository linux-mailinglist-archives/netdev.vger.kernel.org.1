Return-Path: <netdev+bounces-240194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE77C71510
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 23:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id D69952DE30
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 22:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449E632D435;
	Wed, 19 Nov 2025 22:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="DFFComOf"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5A132ABC0
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 22:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592165; cv=none; b=Pq3RGWPXX+RwYIB2S4nyzNt6zCuD9UnbCiBSDpAxmYzCd4Vei7JJQBTAkDq7YxCfs0yRTjmMpF1vvWaCWra7QZ8bE1zLx/7iQDeiWvM/5TcFht7yMz29j1K0WmaxVn+/fNxyQBk/avg3qaGnRI+fj0lswD4FkZgEOKx6+AZN3Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592165; c=relaxed/simple;
	bh=izK0+0Bvo7U03sOK72Sga8hjWpAnntIi6bkLeGzufBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EMzoMZA2pwiRcglVSyiS8mDABqclLP9jtZJj7JTtl2JG/Q+pKh6pwIF3jr2XWpVBOXR1BQdU5GM2iAKyAO9kibq7JcRV985tAgeLtUQTkN+VsiAg4nKf9Y2hQ0uWycYJiJQ0Cja+ECAxEUP2GpYNU2KewxdT4Fx5i/NCKC+x4Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=DFFComOf; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqsq-006ktV-Gr; Wed, 19 Nov 2025 23:42:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=DGOZgi3gU5xJrVyv22nL1ESaeH+Ut8t81Bc/Drezg5c=; b=DFFComOf/D7HwUPctBHpq9x4UT
	B7pDg/Yl8ToerSVWw3PB7Lizsh9QgVg8vaYekEfVIgXX7vt6tfBJPSUCUUHxSB4A1AC3m6v2tq5Jm
	FpZKxL3p3K4oQ7/ECDc4C/rHnmzcfVaZS7WwAndCxW7pMLkEm/Ohrh+do18rY0H4nvBotwxcpQibU
	48+VM8TZOXkKGqeercQmNI04pdlRMyerh58luDxTpkYaO5kgNnih7j7RatNQxziDpZASk19nun8El
	7lMK2hSkW8B5BvGvTPhtyZB5oe0aKg9LoMCk0uYkEVL8s2XjI8z9fPKBwQwIsKfDPQ2LMNkvFs85S
	aQwqJG4A==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqsq-00085N-7q; Wed, 19 Nov 2025 23:42:40 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vLqsp-00Fos6-L8; Wed, 19 Nov 2025 23:42:39 +0100
From: david.laight.linux@gmail.com
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 43/44] net/netlink: Use umin() to avoid min_t(int, ...) discarding high bits
Date: Wed, 19 Nov 2025 22:41:39 +0000
Message-Id: <20251119224140.8616-44-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

The scan limit in genl_allocate_reserve_groups() is:
	min_t(int, id + n_groups, mc_groups_longs * BITS_PER_LONG);
While 'id' and 'n_groups' are both 'int', 'mc_groups_longs' is
'unsigned long' (BITS_PER_LONG is 'int').
These inconsistent types (all the values are small and non-negative)
means that a simple min() fails.

When checks for masking high bits are added to min_t() that also fails.
Instead use umin() so safely convert all the values to unsigned.

Move the limit calculation outside the loop for efficiency and
readability.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 net/netlink/genetlink.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 978c129c6095..a802dd8ead2d 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -395,10 +395,11 @@ static unsigned int genl_op_iter_idx(struct genl_op_iter *iter)
 	return iter->cmd_idx;
 }
 
-static int genl_allocate_reserve_groups(int n_groups, int *first_id)
+static noinline_for_stack int genl_allocate_reserve_groups(int n_groups, int *first_id)
 {
 	unsigned long *new_groups;
 	int start = 0;
+	int limit;
 	int i;
 	int id;
 	bool fits;
@@ -414,10 +415,8 @@ static int genl_allocate_reserve_groups(int n_groups, int *first_id)
 						start);
 
 		fits = true;
-		for (i = id;
-		     i < min_t(int, id + n_groups,
-			       mc_groups_longs * BITS_PER_LONG);
-		     i++) {
+		limit = umin(id + n_groups, mc_groups_longs * BITS_PER_LONG);
+		for (i = id; i < limit; i++) {
 			if (test_bit(i, mc_groups)) {
 				start = i;
 				fits = false;
-- 
2.39.5



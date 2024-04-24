Return-Path: <netdev+bounces-91031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C938B10BA
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 19:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB831C22542
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 17:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BD416D317;
	Wed, 24 Apr 2024 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="Oi8lIlyv"
X-Original-To: netdev@vger.kernel.org
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3B416C6A5
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 17:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713978694; cv=none; b=Ebka+adrpbXQ8/zJOdAevyzONe+xkE/MMToinQiRgBQ+w0VxwBsDCe2HXX3BV6u5eXrXJl0U12FG78oVXQiNzWNyt+30+Rfl/GYtywqgnnEaXWLWa5YOe9V0G13I6hu4rjQV9b31Roe+Kez3VZuIAlyLkfcenoaAHDi1yOdbvQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713978694; c=relaxed/simple;
	bh=8fhfv0fmXiUqbz2s9eAPuq6azYJkSIQuH6UwEiX2E7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZchXLJ++zj3UGAfByt2DMKvuqdiSB4E3IsTlO47Ed4ZDMm17j5FU3QmQD+cfnGJ/Vq946NhZUMrbbZpKFcaQtXSx+wvQiJO/BZPgGu1WimFOCvcW1+kYff1YCW2fye1KZnRlILBR9tb5zFOztCHb8J8zik72AnRZ2lx7rFI5sJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=Oi8lIlyv; arc=none smtp.client-ip=95.143.172.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Received: (qmail 29899 invoked by uid 988); 24 Apr 2024 17:11:23 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by perseus.uberspace.de (Haraka/3.0.1) with ESMTPSA; Wed, 24 Apr 2024 19:11:23 +0200
From: David Bauer <mail@david-bauer.net>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	James Chapman <jchapman@katalix.com>
Subject: [PATCH net] net l2tp: drop flow hash on forward
Date: Wed, 24 Apr 2024 19:11:10 +0200
Message-ID: <20240424171110.13701-1-mail@david-bauer.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -
X-Rspamd-Report: MID_CONTAINS_FROM(1) BAYES_HAM(-2.999999) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -1.599999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=david-bauer.net; s=uberspace;
	h=from:to:cc:subject:date;
	bh=8fhfv0fmXiUqbz2s9eAPuq6azYJkSIQuH6UwEiX2E7s=;
	b=Oi8lIlyvDl2uVLg49AvEYofKnAiXEbcKCb0tMQOr+LbRhhAXmVWwEmF47xVma8uJDdV9s0OMMd
	KyrtcjxNJw8PONz0OBvhQsK+RN+W4owFIp+nkRg/61JW8YSEQpRC/I5W0euqCuV2Ti1kqo1u6uOW
	eOjf+79zrZp1g8bntIeSlW3t6ZHetweyAmH7SnVtJ1knZpl7vMFqFjzGCikIGhXh/OUxBdgsKKiY
	Dq+OoEAmDC39B1QLGKFGYY5yT39TDp3qj6FkbH/C9hhheVU+z1ntSBBT1sW6FrK1J46KImp8Auvq
	u5R2LwA9MQL98hlCio/TJXivCVRJwcQ9ObO7ITkTHl1o0StGkMH6N1KDOmdwvQOlNklFtPE79zZN
	6CKypsHvpmAYzHbwCC0zFiGKnzWsacPKViDuUkzJSe9jd+6YICSPbgFMMLgPtnyC4/YX5YXBewrm
	fTV6gHCuWv1msGSowWnxF/rFJWgblxVvs5cVZgY9pq3pT19Epb98uPcJJd2D3TglZBS69wbJSUBr
	uSSPgnX4l2Q9d4iXMOjwkQN4Izqet9b+/Y4EgHReguV8ARt/VYvi/u2RjisIcXya2lQfzlGwoS2Z
	UVHTfkfU8L0FqY9JFgCC2Vyo70Vl8kcZcD77cc6BZoY2EZPIbhgTVwZfsftrCp3gj03WpvDHhJs2
	4=

Drop the flow-hash of the skb when forwarding to the L2TP netdev.

This avoids the L2TP qdisc from using the flow-hash from the outer
packet, which is identical for every flow within the tunnel.

This does not affect every platform but is specific for the ethernet
driver. It depends on the platform including L4 information in the
flow-hash.

One such example is the Mediatek Filogic MT798x family of networking
processors.

Fixes: d9e31d17ceba ("l2tp: Add L2TP ethernet pseudowire support")
Acked-by: James Chapman <jchapman@katalix.com>
Signed-off-by: David Bauer <mail@david-bauer.net>
---
 net/l2tp/l2tp_eth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
index 39e487ccc468..8ba00ad433c2 100644
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -127,6 +127,9 @@ static void l2tp_eth_dev_recv(struct l2tp_session *session, struct sk_buff *skb,
 	/* checksums verified by L2TP */
 	skb->ip_summed = CHECKSUM_NONE;
 
+	/* drop outer flow-hash */
+	skb_clear_hash(skb);
+
 	skb_dst_drop(skb);
 	nf_reset_ct(skb);
 
-- 
2.43.0



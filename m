Return-Path: <netdev+bounces-220533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F54AB467F3
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 03:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3683B912A
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 01:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9F918872A;
	Sat,  6 Sep 2025 01:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b="EDPobhn3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392A31632C8
	for <netdev@vger.kernel.org>; Sat,  6 Sep 2025 01:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757121622; cv=none; b=FtK78LSMUJP+xi4mgF+UFzu0BOiQ9mLkpWbYwyiYOj4NBU7GcZ8cuB/zXuRabS5wQZ01vnslI53XIAop5ftHY/LL7uiLHHp6mew8xrLbJzfVdmb6Br8w/JBNlkHFQChHxFphaM9W0meGnmUXCu22peKOJ3pa40IiFVwopD8dV8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757121622; c=relaxed/simple;
	bh=OZfmvUtSyXTRBokVQWrm6BmwrIq4AfkWxUHBYagVBJY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PWrptUd/iuFoAnIXSNsMuadxl5ds2Bl9uLK9zxE0DkIImdlr6oPgnUBlC6mJTn2PLmD/x4d5FvxZS0m7E7i9+ZzNFVud+PpIrJ0ITOw8hFzAECD1N0bewVRN7TF/YxzcffwvYZ8dmZyL9XXRJ5dG2pf8x4aNzGnxGAG86lYdX5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com; spf=pass smtp.mailfrom=aisle.com; dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b=EDPobhn3; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisle.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6228de280ccso1442247a12.3
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 18:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aisle.com; s=google; t=1757121618; x=1757726418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MhkCEPpqVmmHGdIendUwEnS7TAUpZx7akLTv5G7IgZ0=;
        b=EDPobhn32aZ9nGj5SpTcN5JKbAXkMu3DWrU4z2VeH1PS3Qm9C6jhu0qC1vVaTeLMXU
         YvHxzeHlclV6yQGfrY+yD7iAXxRQX/IzxU7TuVq4kzWUQWBAcgfsAqQjcVbB5pLmpPm5
         H3oPILOM7b6DvrqboaXuqzv/qNiIiKBVLRMY8xG4I/VEPvPPFY0YIINXx63L9TXB7N0h
         M0ODKa13l7qr/CvVj790JJbUQU8zKLdxP9IYWMFytMIcQWsKbqK6LbJmzSc+V3htvtUc
         qSh0z8f4V+ucsSHuWzYmCqh901hCKxUmdSq6mWwH+HejjnVvtM8Ke/dKqILbbIB5Cx8y
         oVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757121618; x=1757726418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MhkCEPpqVmmHGdIendUwEnS7TAUpZx7akLTv5G7IgZ0=;
        b=VuBWhRLK56XzR1uyJbxAMuRUziKZUf93B7x6QMyB243q8ribJ28yW9gzrsubKZpt3m
         NB3oH4jVA5s5BKgWUkhBVSAeiXbRA+5elPCqzYuGmJuaVtwU6oHv3L/JR11R0qz+Wz5l
         TsMqQ3jYFA5KiecmRS0EGhlEQjmWOpv9C7921JwaKkeBkcU0uYx16HUsaTjKi8bcnIu0
         m+tVS4bIBks1wVj/zf3C06iiyNPKT+V030rYxYB3kRd3dLN7pwTIAtrATtTPWorbRYkv
         eZ5kT9rzQsQOHGwQKWizEcGYxQyrKh7Bk0YUBsICCHvZqoZXP+Z+ElRE2XTeiVZTN/Kt
         YH9g==
X-Gm-Message-State: AOJu0YxpL1ObFzda9zyxFrogJk6aV95Hx6VFpB8+qNK2aAPsWiSt+S4R
	G7+ihGb/Oy6qxd895Ada17PWWy8v+rK2zl9HZmoQ8yQto1ZNZPZaLZzUtejLBD/nFid8HK9HBF0
	5gLE0587q7DL5QHg=
X-Gm-Gg: ASbGncu45R1DJuIhJQjSrubPmkxC9mRdLCxxCjASvEIrH/Y0u/F8Po612Z6fdWOcT+d
	f633A5rjUBa5Nl3LMWU2iXgQFSQDvRJsz5wjyrisjpQU4uDmaSF3FWkOupyS3ke+HRX0E6HhDuO
	ZT05m3MREMOr7KmtHILa8x1A5eF1wISFnjXNEfYTB2mmF3osrWmVHGY0Mnfpyi/m8r5m8cJmqxX
	9sRldpMxBqxNpdNqrl9dCay9XZDP0M4TwH0resK9JRMH6SQ+tgZgSy1ERBOgc3XuKJJu3jngT0l
	4lkWVrITnCOepT/YKX38++t+RMc1w8Pn/MAkY97mvdheqWwNYktW87D8LMKgSEl+pz7xIa8Xufn
	bVLcWIyeeCNbY0pWgniEgdNGOn+oxfm8xPfk7OH2B4nkYnFo=
X-Google-Smtp-Source: AGHT+IGFMbR3iirc4diOpoMpZyM33hVySYIhjNMV95KRXjY0dEcC/hyOGyDBHtgZ0shcIt4Vk3AiBA==
X-Received: by 2002:a05:6402:40c9:b0:61c:6fc9:daa with SMTP id 4fb4d7f45d1cf-6237edb2f07mr757777a12.20.1757121618390;
        Fri, 05 Sep 2025 18:20:18 -0700 (PDT)
Received: from localhost ([149.102.246.10])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-61cfc4e50fbsm17060426a12.38.2025.09.05.18.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 18:20:18 -0700 (PDT)
From: Stanislav Fort <stanislav.fort@aisle.com>
X-Google-Original-From: Stanislav Fort <disclosure@aisle.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	Stanislav Fort <disclosure@aisle.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4] netrom: linearize and validate lengths in nr_rx_frame()
Date: Sat,  6 Sep 2025 04:20:16 +0300
Message-Id: <20250906012016.58856-1-disclosure@aisle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linearize skb and add targeted length checks in nr_rx_frame() to
prevent out-of-bounds reads and potential use-after-free (UAF) when
processing malformed NET/ROM frames.

- Require skb to be linear and at least NR_NETWORK_LEN +
  NR_TRANSPORT_LEN (20 bytes) before reading
  network/transport fields.
- For existing sockets path, ensure NR_CONNACK includes the window
  byte (>= 21 bytes).
- For CONNREQ handling, ensure window (byte 20) and user address
  (bytes 21-27) are present (>= 28 bytes).
- Preserve existing BPQ extension handling:
  - NR_CONNACK len == 22 -> 1 extra byte (TTL)
  - NR_CONNREQ len == 37 -> 2 extra bytes (timeout)

These validations block malformed frames from triggering bounds
violations via short skbs. Because NET/ROM frames may originate from
remote peers, the issue is externally triggerable and therefore
security-relevant.

Suggested-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Stanislav Fort <disclosure@aisle.com>
---
Changes since v3:
- Wrap commit message at 74 columns
- Add Fixes tag and Cc: stable
- Drop Reported-by
- Add Reviewed-by from Eric Dumazet
---
 net/netrom/af_netrom.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index 3331669d8e33..f0660dd6d3b0 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -885,6 +885,11 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
 	/*
 	 *		skb->data points to the netrom frame start
 	 */

 +	if (skb_linearize(skb))
 +		return 0;
 +	if (skb->len < NR_NETWORK_LEN + NR_TRANSPORT_LEN)
 +		return 0;
 +
 	src 	= (ax25_address *)(skb->data + 0);
 	dest = (ax25_address *)(skb->data + 7);

@@ -927,6 +932,11 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
 	}

 	if (sk != NULL) {
 +		if (frametype == NR_CONNACK &&
 +		    skb->len < NR_NETWORK_LEN + NR_TRANSPORT_LEN + 1) {
 +			sock_put(sk);
 +			return 0;
 +		}
 		bh_lock_sock(sk);
 		skb_reset_transport_header(skb);

@@ -961,10 +971,14 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
 		return 0;
 	}

-	sk = nr_find_listener(dest);
 +	/* Need window (byte 20) and user address (bytes 21-27) */
 +	if (skb->len < NR_NETWORK_LEN + NR_TRANSPORT_LEN + 1 + AX25_ADDR_LEN)
 +		return 0;

 	user = (ax25_address *)(skb->data + 21);

 +	sk = nr_find_listener(dest);
 +
 	if (sk == NULL || sk_acceptq_is_full(sk) ||
 	    (make = nr_make_new(sk)) == NULL) {
 		nr_transmit_refusal(skb, 0);
-- 
2.39.3 (Apple Git-146)



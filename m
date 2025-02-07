Return-Path: <netdev+bounces-164000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5BFA2C43F
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB5E162C97
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1538F1F8AC5;
	Fri,  7 Feb 2025 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qAxVmq0j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764B71F8690
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936728; cv=none; b=mzAf5Lp4WJQKgW2zdubRKAPliJrKcKnxLx1m+7Y+X2KO8DXjCd7KUAARgCYvdH91BJAXObjiGr6rhEdVaJQ7dmWbEISxmOSs6M4QvTk1VlLWHJQ4QXi80wU2uhGYYKt50MWE2rMpF9MItLMzFwZeFbzTQYu6gOgDwTFoKrGza0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936728; c=relaxed/simple;
	bh=X15HDw4envXWeNx79rdJBepVYk5uFGZKHOBtwpn7d5Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=il7tzG3fL+sV+1PBpAJpbM+XUw59STGpGzys0CfuOmh3kvrwB+8aHvyainNx/ZoC7IEHOXX574uw3drZtLYCivdKMXZ2svd3n3PiGzh/2ykBScdf4DSq2susHPQhvDKpkf7bO2LC7TxeNMmWTOVNrgh1vBvhhlu+XwacE7CQS2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qAxVmq0j; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4679db55860so43516731cf.3
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 05:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738936725; x=1739541525; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fq+5yvGIi4SusKAdwGvHNeaJfUI1Q/8GPelbPpjTlvU=;
        b=qAxVmq0jbRO6XN4d3CiPb2vJQgh5i0a7oGLHZf/NQotHKKrIcuhRoMyKGGbkiSuPd5
         gpDaAKlwrJ3TuzJdMjSyObvS7o6N+T+oPEwNWEEg5KojhLUKp46Vu9thP5Jjzk6ih2W4
         EvRXVI13+du2myHuWYs8sv810Z4sI8YFpdwJPHURPKIyUx3dCBtZFejkzoNdT1Qnw8+D
         BP/kHQLtXZA/q5mjHkWxHKhyJZ6EQW1X0Fs2+5zIonOdv7FjpZjQl42RicNINDd3dUJM
         tfk+mOcFjFJB2bKJ8uUpABYAnZ5uU0CX1g9xgw9i7XhNLjt5b4ovw0isLXoHSx3mm/Q/
         Jh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738936725; x=1739541525;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fq+5yvGIi4SusKAdwGvHNeaJfUI1Q/8GPelbPpjTlvU=;
        b=VSFbEnOfhvcubGrYh/aN6LMnzmIJ/lrzWBHGlQ305M+bLx/HOVw4HXOTiFG/MovFJj
         vcUHhWhJibpR5SH3BVC01P2OLDibonxHyx2aCTkmT9uwQKsrwGUyfmWPO3AerGKaINrQ
         zpDSnxFEZR/HQj5A28TN3jmi+4tI/BmMDSUhJlYxj6maj3hiA5WLqYaU+LYMZj1uuNTY
         VDSdAwnz44wlDXO5bx7DIOtaGA7yGM7HKTvuyPPOXfSw+M7y8+ZCSRyNG9pzwRGNfTP5
         jten8PlfgEnyYY2POCY77bS105cqIGzH6NYkMaxBO115rZu1alKgctbv/I3t6zDFExR8
         apvw==
X-Gm-Message-State: AOJu0YwE3jP48aRgOiyCdw4vszA5MNjObgZNhZjfccxXQiIF1LMwjRc+
	gq1oOeIdYDvKDpD7zn+mqRv+CZJS0kLdM3dCinipFLHiV2rMEmGUMsGx6g2j4C2pgknejq/scpF
	Winw8eD7q2w==
X-Google-Smtp-Source: AGHT+IFFudkVDo9wrnPMf0kGh1EQ7X9uu5u94Br0QaJVC07CGjNmLtv4uEyhr0b4GPYSVnpk4UbwoOYkQAEzZw==
X-Received: from qtbcn9.prod.google.com ([2002:a05:622a:2489:b0:467:8dcb:287])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5f0b:0:b0:467:7295:b75f with SMTP id d75a77b69052e-47167bcec59mr44569941cf.38.1738936725405;
 Fri, 07 Feb 2025 05:58:45 -0800 (PST)
Date: Fri,  7 Feb 2025 13:58:34 +0000
In-Reply-To: <20250207135841.1948589-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250207135841.1948589-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250207135841.1948589-3-edumazet@google.com>
Subject: [PATCH net 2/8] ndisc: use RCU protection in ndisc_alloc_skb()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ndisc_alloc_skb() can be called without RTNL or RCU being held.

Add RCU protection to avoid possible UAF.

Fixes: de09334b9326 ("ndisc: Introduce ndisc_alloc_skb() helper.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ndisc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 264b10a94757705d4ce61e1371eb4d9a699b9016..90f8aa2d7af2ec1103220378c155b7b724efc575 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -418,15 +418,11 @@ static struct sk_buff *ndisc_alloc_skb(struct net_device *dev,
 {
 	int hlen = LL_RESERVED_SPACE(dev);
 	int tlen = dev->needed_tailroom;
-	struct sock *sk = dev_net(dev)->ipv6.ndisc_sk;
 	struct sk_buff *skb;
 
 	skb = alloc_skb(hlen + sizeof(struct ipv6hdr) + len + tlen, GFP_ATOMIC);
-	if (!skb) {
-		ND_PRINTK(0, err, "ndisc: %s failed to allocate an skb\n",
-			  __func__);
+	if (!skb)
 		return NULL;
-	}
 
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->dev = dev;
@@ -437,7 +433,9 @@ static struct sk_buff *ndisc_alloc_skb(struct net_device *dev,
 	/* Manually assign socket ownership as we avoid calling
 	 * sock_alloc_send_pskb() to bypass wmem buffer limits
 	 */
-	skb_set_owner_w(skb, sk);
+	rcu_read_lock();
+	skb_set_owner_w(skb, dev_net_rcu(dev)->ipv6.ndisc_sk);
+	rcu_read_unlock();
 
 	return skb;
 }
-- 
2.48.1.502.g6dc24dfdaf-goog



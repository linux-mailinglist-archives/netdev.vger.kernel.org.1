Return-Path: <netdev+bounces-163089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4B0A29543
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793C81884A05
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA201990BA;
	Wed,  5 Feb 2025 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OtiyYOKH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E375C192D97
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770688; cv=none; b=h98wUFZvgus2u2FdDPmriQzXVApCXQdaoD9rxY/TmthjKWD7/40wDl8Cz3JTP2aKnSx+mKDBwIHi57j9QiHSVckOIgNfLMCEtQ0wr93nu/BdBECDECMwX3t/ReVnvRgHHqbBOpdn8A19hfcZ+AclUy5m3hh78RVeNwjEg4UYiFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770688; c=relaxed/simple;
	bh=Tv9lP/iKol3DOwtqFgPyYFOYlq/ggjrKRjQnoathmaA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M6IHz8jvQvqgGCQtzvr5QdtwSTW2Zw71JaueOiFHKfUSwdEnfUhlmSBit9xTCdJ7VfFHnDCanPDjpDk+tO3mgWf7AI7875xkHTupqGpJW4ZDk3EQCRzDenJqmUkRSDNkLM0RDs1+AQ9L22LccV4FVhyQ4KaFQYigrSzDSwB1M+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OtiyYOKH; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-46792701b64so129335971cf.3
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 07:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738770686; x=1739375486; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8gzgfgZQZl+mi1a/sA+Jd+RkxpB2VmO3rTOvLw+ezUA=;
        b=OtiyYOKHSPSxHwTcmwtGVFxW3AzSSHLwm7BHG6r05wIEmFEOH4MFmhoWyf+8OjaXWD
         mVdylrXN6Npnuju0n/0G/eaDKW3jVNNRw8X4qN9iAQAPb9gOlIL60CfWcIP3b943HXED
         gNkmRlshHbac9JKo/gnhskw3Facx52dIy/rPQFUF5USs7D80cMplz+HZSv4fN0RVZHn3
         5OzGP0OKHL4WhqfwXv4rEDX1TA0PCGiA3n39cErr2WxE+zv0RmggQBxV811chCP7kMzC
         Rf9PAIoIJk7h9s8MuK//0WKR84+7VUD/zbaKHwyfdcgPsEvDnBKCjggYIWK1uj0C7t/5
         ZjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738770686; x=1739375486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gzgfgZQZl+mi1a/sA+Jd+RkxpB2VmO3rTOvLw+ezUA=;
        b=EZgK6yy0BVeb78QYdSrwdrZki8thms3TJJ1JrEm3Urz29twKwRYEe3Jru3GE5dlN2w
         I8uUXIZAtQ01vF5ummp9hAibOj4lCAI25Jg5s4fSMcaICbwplxcvJp0k2FQ6DUMvrRKW
         Sm/h5s6Q/TDMRNkGMhS7ZN7/9qCsDLxN4/I6kieMQuPKZlvD+2HC45R9U/hH4giez3Ur
         0vH9GCEMJ05x1kIq2cfxJTdnX9e/eVaz9eQTfghLULjcYieg78RrgL7+mXNXgQa+u6DV
         xHEyxI63NgLzPCKAvWjzOWZ2TQDHf6QhvNNojldFNFcoAf8Psh7xMXQguJAqXC4FK/e6
         RecQ==
X-Gm-Message-State: AOJu0YwZCoVjHqM3oa/tbUbp1DL0/Jkdiox7pp0EOHYKDeukewoSfF5S
	6RyueeDG3QaGxkEpiwQVfRaDM++WkLM6FgKnxR8e6nQNJB8WUBWuPp81wollg9xn4mcDY/YqPp8
	sGSgx4bT1eQ==
X-Google-Smtp-Source: AGHT+IFjyeiB4mPpQSboKcMqBTl9u1fzTXg5WA3OM8OoEXWq8wethkHISLWfjBSm771GQt6bAntHD7T5sMMPIg==
X-Received: from qtbey18.prod.google.com ([2002:a05:622a:4c12:b0:467:6ece:2e03])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5989:b0:46d:d8be:d2c1 with SMTP id d75a77b69052e-47028009d11mr45316421cf.0.1738770685859;
 Wed, 05 Feb 2025 07:51:25 -0800 (PST)
Date: Wed,  5 Feb 2025 15:51:11 +0000
In-Reply-To: <20250205155120.1676781-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250205155120.1676781-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250205155120.1676781-4-edumazet@google.com>
Subject: [PATCH v4 net 03/12] ipv4: use RCU protection in ip_dst_mtu_maybe_forward()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ip_dst_mtu_maybe_forward() must use RCU protection to make
sure the net structure it reads does not disappear.

Fixes: f87c10a8aa1e8 ("ipv4: introduce ip_dst_mtu_maybe_forward and protect forwarding path against pmtu spoofing")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/ip.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 9f5e33e371fcdd8ea88c54584b8d4b6c50e7d0c9..ba7b43447775e51b3b9a8cbf5c3345d6308bb525 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -471,9 +471,12 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 						    bool forwarding)
 {
 	const struct rtable *rt = dst_rtable(dst);
-	struct net *net = dev_net(dst->dev);
-	unsigned int mtu;
+	unsigned int mtu, res;
+	struct net *net;
+
+	rcu_read_lock();
 
+	net = dev_net_rcu(dst->dev);
 	if (READ_ONCE(net->ipv4.sysctl_ip_fwd_use_pmtu) ||
 	    ip_mtu_locked(dst) ||
 	    !forwarding) {
@@ -497,7 +500,11 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 out:
 	mtu = min_t(unsigned int, mtu, IP_MAX_MTU);
 
-	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
+	res = mtu - lwtunnel_headroom(dst->lwtstate, mtu);
+
+	rcu_read_unlock();
+
+	return res;
 }
 
 static inline unsigned int ip_skb_dst_mtu(struct sock *sk,
-- 
2.48.1.362.g079036d154-goog



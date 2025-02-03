Return-Path: <netdev+bounces-162109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD98A25D26
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BDD73AD19C
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C520920E01F;
	Mon,  3 Feb 2025 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ZJulzLN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037D020E005
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593055; cv=none; b=leGMgFhj7zaT2pr9ngz5yG/IIsqSFK8uvKA+HIyPuotmzQW8v3P9//7MH9czEjJvsbHLTMGhCTTJZtCdVeCkgtumnGrXRXJZuFhqstdNCpjpdLchLvDLcNYz8oL9ZDfJdVqwTXnNq9/EMNjv7QSxj/pbNDgDpc7q+B5oLaZQgJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593055; c=relaxed/simple;
	bh=Tv9lP/iKol3DOwtqFgPyYFOYlq/ggjrKRjQnoathmaA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EvQ+vXWOcPTecSePuAVl54clymh28Z6KQnsAxSXk3yXOzqJOLjHowY31iv1/JxFxqOBcVXUSlLcVnzeQR44VizYMdpUK32gJyTnC9V/StdXOcErtVL/xsef9TWKhYpXMEW0KaD+WgmQjIGQLBgbaa4ORAOQ1qd+FdOkS3JRJVU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ZJulzLN; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-467bbc77b05so89059961cf.0
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 06:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738593053; x=1739197853; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8gzgfgZQZl+mi1a/sA+Jd+RkxpB2VmO3rTOvLw+ezUA=;
        b=2ZJulzLNyBuHGCrXB2cgQL1O534r2GBu32icxmpvlvGFl9hmXiX+Isb+fHfrR3GqHl
         mfhto8tmugdlIIZG9G90LySBrKfR6oxKFH8ibOwa7U/jNELtR8ptAILUxzaEEfxpvf46
         Bflf4mgH+Dj+8vMrdt/v2ruZ5x5rmqZ/WBmoiFR84o6zJcv5k2uzh0pj+lLn94XEmUrR
         Z7dufqmed105ThMvL1fzM1xY6i2YJJw0Q1+YLXWZ835xK8M7nqMDqaDdFDQM7xfubv9q
         QN6l4uAhUq0TAGYvm+6eJxLr+QUeob8HotGllt6gX4zkv9xodpbLZ0pE5lMUUheTh+yx
         b0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738593053; x=1739197853;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gzgfgZQZl+mi1a/sA+Jd+RkxpB2VmO3rTOvLw+ezUA=;
        b=s04OFI2bbehmMy7pJ2YHnXaous6qCT/5PyYg6ddvGFIRgOGPdJQikLLIgqN09S+3fb
         L5BkW3bllFJAXimZ6yiKrnThjVxiUlYI4jBDJimjVWjZAiHM61TdW2nhnpF9ukJtGrXR
         eUWSRWAr7B2Mu3BTJfwdWjqmHEXNzdZ303fTgSd0nhMMJfKdo/007sIBISx5T2ZqvH2f
         d43wyqOJAVIDJnriWuyFKxSkjY6GxpXlKkAMpFLFRX/vhJh9tP91HxraI0nxvsstamfv
         o/Vqwi5UYSTF7V74tXOkpTtvE5JKYwO97pZB6Zdy5/gXfrj5sKfFtvMDcJJ4oDR5zLa/
         E88w==
X-Gm-Message-State: AOJu0Yyv4qk7d8gtHxAsdhMuQtNy/HwIYa8u4qmOEEFWO9QVZWKMvhlL
	RR0uq3glpbQBip/JDXG87cNyNPFx+bQQiYRRmWpvO0dAGSc7fiyRXlQxmnUdbT4SAQSqV6m7wZz
	/n0bTrnSJJw==
X-Google-Smtp-Source: AGHT+IG/N60AqRx2cNDAYYvc4AAu5L9kUhCk2BVNvVat6spIh407EhrBaktSht8QTUTrysO/abd3kWkYCSpnPA==
X-Received: from qtbfa8.prod.google.com ([2002:a05:622a:4cc8:b0:467:60a9:3317])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:8cb:b0:46a:65c:b589 with SMTP id d75a77b69052e-46fd0a81258mr318044321cf.6.1738593052745;
 Mon, 03 Feb 2025 06:30:52 -0800 (PST)
Date: Mon,  3 Feb 2025 14:30:33 +0000
In-Reply-To: <20250203143046.3029343-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250203143046.3029343-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250203143046.3029343-4-edumazet@google.com>
Subject: [PATCH v2 net 03/16] ipv4: use RCU protection in ip_dst_mtu_maybe_forward()
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



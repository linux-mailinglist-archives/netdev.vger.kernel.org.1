Return-Path: <netdev+bounces-162532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEE6A2732C
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D6B3A8232
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FFC215773;
	Tue,  4 Feb 2025 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O5O04nQi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B4A2153E9
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738675452; cv=none; b=Bao5M65o03HL5abPVefA2xzVLmpiE9OgrVYaX2Ubj5R3Eq03GyUaPWZ9fcoGgfRmo/Wr9MnNbMWVsTkmJv3SOqTq3njjzTFVIQwLKoJV8jhkqcA+aKflT6qneOYygiFwc2+143kBzyRYk8XKMrwm86R+wjtwgljNjRixbxrkrEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738675452; c=relaxed/simple;
	bh=H8JH/QPjFfGxbrJtRbDkCum9cREuE5YKVIPC//b1qCs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rLjic5rMLZPc52TIC1SLuA5XANlPrpOd5l1fCWmX8VjGbu4ikhUpNR3/h3jp7dv+R7yfcEQ9np8YAKYRp4YIRi53Z/KyyzEx0/CDo/PjLYR+R8TzOczci1MpuPV+QPpIVQCza/LTNdGkQulJNRwEhrRubNgHsyXMEFYlXzWeneE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O5O04nQi; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7b6fe99d179so1327691085a.2
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 05:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738675450; x=1739280250; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oummPnO89bchIzAktiowh3Jl3EZAt201EnCE7gdN6jc=;
        b=O5O04nQic86XB5MdntECYmoXqyQEEMA6KdQONkmHDW26U87GSU6a/GGoxTyEpRKG0Y
         pK44EPJBJ6OaexSpm7kCp1iMk/xoZ6ISNpABHQo6kVut8WT9H/xmK+CqAR6KKP68qnqT
         2eXDz7Mm9iOu9GtZusAfUrnmoBYk2ODTBfdnbgclUgC6vNUcj6DAeOdUbEKMp26HhT0l
         E3vgKAUOFYtjOmG82hPyHigMs8DAP9BQJuvRGiv6RZ7myYW1SVI7IJomp/58qpNfSlL1
         fxmrXNXQyqH61P8Bc9ncUwijX3Z6d8W2S6gcSlrjZ280SIjlV7dBZd/07plK6YoXQOJz
         htQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738675450; x=1739280250;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oummPnO89bchIzAktiowh3Jl3EZAt201EnCE7gdN6jc=;
        b=mq5+ubauhGJztt9zm3Nd4CZXotD8vi6+RovSTua8chbtV2Q+TZ1XRxyMcs1bUKM8dW
         AclUKKG758la5816Z9sSGMXrQFfY7OhjyhG1WfgzDDhPuh+HRdKsdHtbPbVBJ+pjde8E
         GdfzBk10M60dKpn/6M/iXJEqw69g5Q5Y/704ELfKZ6xanun0O070UAsV0/F1EuGckiJd
         p984Bcl8v2ZBjd3hV+x/Iy/E2zdI8iFLtZDoknf3PQnyBj1itL/pV3CnymAhR7aWbRS3
         fHki67CKBK7yqhPv6AH3ByryJEbAp+UlxNci58KBRw7CS2pcN+ovW2xCB/dUNkEPdbtA
         kpGQ==
X-Gm-Message-State: AOJu0Yz0a6gCbR5qcEOKXUFqZFZxam/GCBIx6abBTImFMJbTSIM7sc78
	k0NDGEpKT5HUbHrW1iXr2s8jzzqjgqDCbRc6AEO+aRHQJ8C9jG7J0XOSy6fBLIW+DrDOpHooeXQ
	IZtjM1uqEPw==
X-Google-Smtp-Source: AGHT+IEfbIWr1pEfZI0s7mw2vNXkXeeRNTzJelaBAaaAiuyQLqSv0o9SQVIDFBmIIEH/CSeCIhr+gFz4s20M/w==
X-Received: from qkbdp7.prod.google.com ([2002:a05:620a:2b47:b0:7bf:f8dc:e8a5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:bd4:b0:7b7:e5b:3b24 with SMTP id af79cd13be357-7bffcda8723mr3706674085a.50.1738675449916;
 Tue, 04 Feb 2025 05:24:09 -0800 (PST)
Date: Tue,  4 Feb 2025 13:23:45 +0000
In-Reply-To: <20250204132357.102354-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250204132357.102354-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250204132357.102354-5-edumazet@google.com>
Subject: [PATCH v3 net 04/16] ipv4: use RCU protection in ipv4_default_advmss()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ipv4_default_advmss() must use RCU protection to make
sure the net structure it reads does not disappear.

Fixes: 2e9589ff809e ("ipv4: Namespaceify min_adv_mss sysctl knob")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/route.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 577b88a43293aa801c3ee736d7e5cc4d97917717..74c074f45758be5ae78a87edb31837481cc40278 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1307,10 +1307,15 @@ static void set_class_tag(struct rtable *rt, u32 tag)
 
 static unsigned int ipv4_default_advmss(const struct dst_entry *dst)
 {
-	struct net *net = dev_net(dst->dev);
 	unsigned int header_size = sizeof(struct tcphdr) + sizeof(struct iphdr);
-	unsigned int advmss = max_t(unsigned int, ipv4_mtu(dst) - header_size,
-				    net->ipv4.ip_rt_min_advmss);
+	unsigned int advmss;
+	struct net *net;
+
+	rcu_read_lock();
+	net = dev_net_rcu(dst->dev);
+	advmss = max_t(unsigned int, ipv4_mtu(dst) - header_size,
+				   net->ipv4.ip_rt_min_advmss);
+	rcu_read_unlock();
 
 	return min(advmss, IPV4_MAX_PMTU - header_size);
 }
-- 
2.48.1.362.g079036d154-goog



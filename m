Return-Path: <netdev+bounces-161804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EFFA241AE
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 18:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35FFE1676D4
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 17:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13A21F239E;
	Fri, 31 Jan 2025 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SfudvH8B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6F31C4A24
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738343640; cv=none; b=RqAoyz/+YI67Xx8iWSsVnwNxPfQkmW8FN7k2+a/pUlTuAHZ3zFn/jJ7cd6kLF7Kx1Y2G1itRr4A0Bfrn8qn5dkQE82D5ZE522QhdJvelEhVyztOAWib6jIeIwSRn1Qtcc/RVRnp87lT/25nib+OS8f9JRFMV52OfoGB+MIlVy4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738343640; c=relaxed/simple;
	bh=TJUuhATaHzNHKt8XVZ3VUbOXK6hsTlECsNjh0vNzD4I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V2cV+fE51b9fxXQl0koLurk3GJ1agMXtSuV55/eYWJ3K3L8kEwRydUAnnEUY+lkz1RQIa6Zzco2Om4egXYqC86wWbIs6TeZYjudt//8cVY21TUdbYsLvazGeh7BYNkLwEQGRRonfDINk7jCa1nOzncOI9T/A5a8ryk1yw0/ogPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SfudvH8B; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-467ae19e34bso67522981cf.2
        for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 09:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738343638; x=1738948438; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g+QIm7omUWzts0y3PcIC44x6+mC9JZr2uTLV0MOND0Q=;
        b=SfudvH8BJA/lcL+LgiRsIk77eM6+aUCN9hkegqeWisCSn5eHeDbVVu+lkeuNIBDD7I
         rzEejOgsALiUGW3zrsOdXXOwzR6UkRK4ScQztXU3NlcTFpuYhtmlYqj9HjQoANL6nmkc
         3tqnjtK/Xk0o5q9ziaoy185m+LyblsHsmMApOtCjf+bFn+b3f1wfJKquhl9fWbRw+jfy
         jUELW7cXkRViicX7o2NFsqvS6xiHi+/hXLNiH5w6kFMxC8ayiLPtFF+MA1jbcCNk/GJY
         DzIaM9D5/biMBdl2dQ0IzbzopWeEzzrqJFRNQyBSmbpZpOt24xtcxHig+wCRuEZcOd9L
         x6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738343638; x=1738948438;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+QIm7omUWzts0y3PcIC44x6+mC9JZr2uTLV0MOND0Q=;
        b=B8CEbH1EfMoy7Y9Sy6wDu1+rRgrtfoVwqPYK8IVXQUOZGeR/j6Qupe9YMdm7UIfJD3
         lcxoovmc4u0qIXcQGkKJY4Fzem2m+fSbZVd895JCwOaDhG+joDuMe1h+Or73n6++l8is
         eozOqH4m57jj/tfOyMtobGMxuOD5/O2ahGPJiWJIiht85p3Xl8cvbc0Y+bcC6z2Yg6A+
         Q+wf0M4ro6YIQviRzWH9nuDZnRX5s66McISa/vfhob9f82rvEMOuD5OOIfXltA14FsUv
         YBmpxkUAoKZrN/FXN25IzQUJ2Ho0T7s3o/P8oYjksmOSJJqd6Gu7ZVp1EShA5E2HOgkz
         ppYQ==
X-Gm-Message-State: AOJu0YzRljoEuvyeUsMVghwva8Ow7fkLxKfclfN3XQf3BIY7fU+a+rTc
	WnkS4txwvS/QF7aS8Jn/Ujo20e4M3etDv6mwr0LVcmAa7aArGtzuTUhWSqzEEjP/HXe9cNfTn7p
	VsYUIqNfBXA==
X-Google-Smtp-Source: AGHT+IHMYi38uhenyJVthKD2lUHrS3Bbq1RyBRnk6ksPdq7kPAQKczxVUKktskuZeU/bYNV6u/eiOPFpL+05Jw==
X-Received: from qtbhg20.prod.google.com ([2002:a05:622a:6114:b0:46b:19df:3299])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7d89:0:b0:46e:3538:5094 with SMTP id d75a77b69052e-46fd0b6da9fmr151960681cf.36.1738343637989;
 Fri, 31 Jan 2025 09:13:57 -0800 (PST)
Date: Fri, 31 Jan 2025 17:13:31 +0000
In-Reply-To: <20250131171334.1172661-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250131171334.1172661-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250131171334.1172661-14-edumazet@google.com>
Subject: [PATCH net 13/16] ipv6: use RCU protection in ip6_default_advmss()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ip6_default_advmss() needs rcu protection to make
sure the net structure it reads does not disappear.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/route.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 78362822b9070df138a0724dc76003b63026f9e2..ef2d23a1e3d532f5db37ca94ca482c5522dddffc 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3196,13 +3196,18 @@ static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 {
 	struct net_device *dev = dst->dev;
 	unsigned int mtu = dst_mtu(dst);
-	struct net *net = dev_net(dev);
+	struct net *net;
 
 	mtu -= sizeof(struct ipv6hdr) + sizeof(struct tcphdr);
 
+	rcu_read_lock();
+
+	net = dev_net_rcu(dev);
 	if (mtu < net->ipv6.sysctl.ip6_rt_min_advmss)
 		mtu = net->ipv6.sysctl.ip6_rt_min_advmss;
 
+	rcu_read_unlock();
+
 	/*
 	 * Maximal non-jumbo IPv6 payload is IPV6_MAXPLEN and
 	 * corresponding MSS is IPV6_MAXPLEN - tcp_header_size.
-- 
2.48.1.362.g079036d154-goog



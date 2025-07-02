Return-Path: <netdev+bounces-203563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49177AF65CB
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22EDE1C44D3D
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA172F6F8C;
	Wed,  2 Jul 2025 23:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I29FTFmd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC952F5C5A
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 23:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497352; cv=none; b=eWeRpGRsmuZAShOtDa/WMm/SPjE0oc1PJIHgHjq4SvTgFezWpBHr19Y9PECiQr83IrDX9MDMbscDNxpjzCQ4THjCfwlU9RVa8c9GZNsqesL0Pxg87e4s/lCAZUlMs3YwArYCY7my4nZ9HBHJ6rt1RhwY7zlp1fWLa93xhqiFTsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497352; c=relaxed/simple;
	bh=CIYQgX7DVtzC/iAsafWtvzoYC6Qa17AHnRDknFz15Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKAO8A2Uhu4oUoxAWdj9ZmsxRSkZw7f0zjNy4biNbSbvevrAnda1ZkE0SIYmYXSz8AcM0dHg+AR03p1mo4ddfilfOSjat8wKTQx4wj3I0DiGPXSRq35a5QU5ti3xP7L1zrGueUQu9LD7UZxCRzdmIHxkFaYI0veDLzPsK627s90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I29FTFmd; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-748d982e97cso4967413b3a.1
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 16:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497350; x=1752102150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFM0haSh469hrlcVZpdpROKZP53FZgyCjF9T8C+dI+M=;
        b=I29FTFmdCp9Zfv5+RGlPT7tY+hqzSaumms3QaesklkAEhVIQIRHXgANIg4sY9A4LMl
         ZBpUGurxy9/kH44Adke8g2AL+AeZgMMosNQudBgucV0c9XEbKkUW2WIRyftxltsAXDQg
         LFetqnDHNq3/y3Fny5HzSkdr+G/PSw3HXVZxVXqPhv/NLQvM1yC/dNSUeQrbrY5Z/iDk
         XQO4Xx2MWJpM3TXQxGXgLyLDKTvR8BikJGn/4pYuLnZHmS95YW9hLlialIC8YUPHX0Qd
         DvP18oN/mdiEDMJz6TdexobSzxHc3S9TcsZ8pBRjZ7Q82roKHL3fTy+EY8KtyVnUND0k
         8DVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497350; x=1752102150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFM0haSh469hrlcVZpdpROKZP53FZgyCjF9T8C+dI+M=;
        b=owk4qo8v7YhF95lY9rY/oNu1ydnaxBGA9cc+nUUUU43Mdd7Or8aCoL0pnC/V2Qwun/
         H4j7cVqZYOj3Y2S6o07IE63BIQfxJCtyEB9H78CIy5LHbb5gKffBYrsxRACL49I352/7
         wxKoizDQRCbp0KAJ6z9aMnmXKb8f9x8g0jIS91jhMrgxTZdl6g2W5dEBSOjdFjA0nNU8
         6w41ZCuZBFvmdleppYxOgAyukMwiL1CFoPLwQt+VjzMYMMeXhRxFAIQmAQcbpwaS0Z6h
         gGB/ITiXU1lP+5UYZgUo3L2hm8uQd+jJiXXNlBwuhD6DZE/6JAHCgRD8YDXSJtReFzt2
         UWpA==
X-Forwarded-Encrypted: i=1; AJvYcCXMEEjcq4CwKKMFEl0IUcDdYe7cix2ubveKsYd9kWCyeZLmWvznfZ3wSikM31CGPBBgwoD1QPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuxDAoyC82NWo4bjnwJ2MvC97LOlPoIB0vnlpCBK6i2TkA4f3C
	iXY7SciCJ3Zp48UVmXHl7bLu1Yk9cIbbnk5mszDZ0i4OSGN6OUB8cYI=
X-Gm-Gg: ASbGncvRMkAOylTg81+zfbi6cwiB/vdSAThJToYUUMZTwAR36tTV/I+tvpoCm+sJrhX
	nBXY2eLLvpuwSsecBKyGS+IQOkDsbdYnpcWppdMlLczzc2aHowQEkEXyoSQ39fTHKuh4h73OR50
	MYoyV89Ho+wpxMYI3rByvLhuxLOjepNECiIybrOdfzCOOQIhBrbPlm+lxnQ5hNTw+3qDziW0POI
	wE0ECL8Jh11bZ6DnTjGmlZ6pT+p4wEJgdmYuPSD7EpIHe61Gk7QO1UMMFGmPn1sbVsMxijyLTxv
	55LPYFbhRYN9W7EvaZeRoDc9etjaOnCrCJ9W2zo=
X-Google-Smtp-Source: AGHT+IHCcIR7RKMx86LeYxZh6fRCrGXs9QGzrmdEjNPb3UTXcAgb5Gui3fGlFKmg6jT84jONh+FCGQ==
X-Received: by 2002:a17:90b:3b83:b0:2ff:6167:e92d with SMTP id 98e67ed59e1d1-31a9d6acf51mr1171587a91.32.1751497350145;
        Wed, 02 Jul 2025 16:02:30 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc70a17sm727071a91.26.2025.07.02.16.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:02:29 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v3 net-next 13/15] ipv6: anycast: Unify two error paths in ipv6_sock_ac_join().
Date: Wed,  2 Jul 2025 16:01:30 -0700
Message-ID: <20250702230210.3115355-14-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702230210.3115355-1-kuni1840@gmail.com>
References: <20250702230210.3115355-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

The next patch will replace __dev_get_by_index() and __dev_get_by_flags()
to RCU + refcount version.

Then, we will need to call dev_put() in some error paths.

Let's unify two error paths to make the next patch cleaner.

Note that we add READ_ONCE() for net->ipv6.devconf_all->forwarding
and idev->conf.forwarding as we will drop RTNL that protects them.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
v3: Use READ_ONCE() for net->ipv6.devconf_all->forwarding and idev->conf.forwarding
---
 net/ipv6/anycast.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
index 8440e7b27f6d..fd3d104c6c05 100644
--- a/net/ipv6/anycast.c
+++ b/net/ipv6/anycast.c
@@ -67,12 +67,11 @@ static u32 inet6_acaddr_hash(const struct net *net,
 int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
+	struct ipv6_ac_socklist *pac = NULL;
+	struct net *net = sock_net(sk);
 	struct net_device *dev = NULL;
 	struct inet6_dev *idev;
-	struct ipv6_ac_socklist *pac;
-	struct net *net = sock_net(sk);
-	int	ishost = !net->ipv6.devconf_all->forwarding;
-	int	err = 0;
+	int err = 0, ishost;
 
 	ASSERT_RTNL();
 
@@ -84,15 +83,22 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
 	if (ifindex)
 		dev = __dev_get_by_index(net, ifindex);
 
-	if (ipv6_chk_addr_and_flags(net, addr, dev, true, 0, IFA_F_TENTATIVE))
-		return -EINVAL;
+	if (ipv6_chk_addr_and_flags(net, addr, dev, true, 0, IFA_F_TENTATIVE)) {
+		err = -EINVAL;
+		goto error;
+	}
 
 	pac = sock_kmalloc(sk, sizeof(struct ipv6_ac_socklist), GFP_KERNEL);
-	if (!pac)
-		return -ENOMEM;
+	if (!pac) {
+		err = -ENOMEM;
+		goto error;
+	}
+
 	pac->acl_next = NULL;
 	pac->acl_addr = *addr;
 
+	ishost = !READ_ONCE(net->ipv6.devconf_all->forwarding);
+
 	if (ifindex == 0) {
 		struct rt6_info *rt;
 
@@ -123,8 +129,9 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
 			err = -EADDRNOTAVAIL;
 		goto error;
 	}
+
 	/* reset ishost, now that we have a specific device */
-	ishost = !idev->cnf.forwarding;
+	ishost = !READ_ONCE(idev->cnf.forwarding);
 
 	pac->acl_ifindex = dev->ifindex;
 
-- 
2.49.0



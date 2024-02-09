Return-Path: <netdev+bounces-70563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C0884F89B
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 16:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E0D21C20AC4
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 15:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B32B76040;
	Fri,  9 Feb 2024 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ib0ke82f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982CB76025
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492674; cv=none; b=Vg1aJsaxZTxcfiV98ISTdVO7jmELBK+MWWYgeEW+qgPjdsvD7omc9JB7vG64A8HQbC7BCcr3gaqyA6/yHz1x//Ir8m7LaBvW/L0JBP95GHBwqE93ChsA7EjcpKEIftj5FPgpcN3lyRTUAPbjQXlfQ5bSEnRnyEg2VZ9OvbnjLOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492674; c=relaxed/simple;
	bh=lTPV5Ih6tWo7DAwcjZncFyI2sd4cJQps9K/5f3KUiK4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bniAkNDQ6Rkfek1Gt5JnPLzosa8S0POzkJzZeRW0U6ojh7173ZedgXfBbkpG+kJY3iylTJHTJJx0acIITATj4tva0Z1wCgquzCq+13RcXrYZaqikwZx2f8PTgNcnyoKYW8WCpE69GzlcSuopyjG5jtlnCm/PJw725RvL2fA6zAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ib0ke82f; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-68c80caa6ccso13460766d6.0
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 07:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707492671; x=1708097471; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6TfsTOXSq9wANpx1Osk4H2RhLxVywzOa++G3J0cKPQ=;
        b=Ib0ke82feUpgSVMqAa8qoAS6cRSUEds8fOnQFa/EaXTWic+Eb6jSGklxhLAgen2rv5
         3uXNcSxXenMgKUSOouwrWuh2m1sqqBKItYvyJA3AJUYXVuGFV+ZcpGuNYvekmkezjDK3
         HwkWFJbmAPCToIjkkD+WfYPIKKRFHoOf8X61zpV74UKrkYN91r7s7Yd8Y+n+n4KLTpZ0
         LJJVpNGD8W7uHdhVs8JkiLbs95H7BDnp0cAUZYvxsGuPoWKu/zFvBqz49Qd8/PWmGFV2
         26Al5CqbIKCvT+D6mCYHRDedmLc/eBeKEJmUM0ilhbzSQ4fk7ezzZSINvVRB+jaSEvVB
         OM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707492671; x=1708097471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6TfsTOXSq9wANpx1Osk4H2RhLxVywzOa++G3J0cKPQ=;
        b=Y+StblECJs3/32biGOrfxy7ga8xlmTulIVUFGNrlb2alfdpjc7r1+KPNxjhJcq1M1r
         gEoeqV/+rBe15PhHPqWjA6tsYxbuNtjQetTHqzV7JskTHicoX2mNdcZKh33F0xWoGh78
         BHS+2gWx/97hMp5EuIAvQLGfjAuTShxmHDIucBlc3B1j4qJ5WO16H36wkxdiQP8nGT6n
         4eznSKbDBOKRdvi2B0URKM9l03GRCHM4ImIpl7iWjG5K5Kl2rnaqRSx60O4yImJfZLBa
         eQ2qsEbYLSlIqjANwZdIwHBkIdLtPCPiVMCq7xN52SfD574c3tXUc4z/dYe5e2f3Yuy+
         Ka4g==
X-Gm-Message-State: AOJu0YxRgAUjZelwK/Ca6CMBNMd75Wo3p5So0Oert8Ka22pES8752w70
	GDW+8jT5UQmQG4Ojh1WrIego7iNl2tuHTqCVRiJGWNP3PXXSmMDAvwA/V05Mf4zBkvjxjW3xYIe
	4FYlmYTQp0g==
X-Google-Smtp-Source: AGHT+IGPCiq4dEY2XsIK61QNJXfodq16WNF83SKbecst2iSIecVrVdauEGC0K/5MvCNgrA9ID63IkY/J4n65mw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6214:20ac:b0:68c:873f:9478 with SMTP
 id 12-20020a05621420ac00b0068c873f9478mr108589qvd.6.1707492671598; Fri, 09
 Feb 2024 07:31:11 -0800 (PST)
Date: Fri,  9 Feb 2024 15:30:59 +0000
In-Reply-To: <20240209153101.3824155-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209153101.3824155-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209153101.3824155-5-edumazet@google.com>
Subject: [PATCH net-next 4/6] ipv4/fib: use synchronize_net() when holding RTNL
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tnode_free() should use synchronize_net()
instead of syncronize_rcu() to release RTNL sooner.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/fib_trie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 3ff35f811765591638c5e03d9211138ca6df3603..0fc7ab5832d1ae00e33fdf6fad4ef379c7d0bd4d 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -501,7 +501,7 @@ static void tnode_free(struct key_vector *tn)
 
 	if (tnode_free_size >= READ_ONCE(sysctl_fib_sync_mem)) {
 		tnode_free_size = 0;
-		synchronize_rcu();
+		synchronize_net();
 	}
 }
 
-- 
2.43.0.687.g38aa6559b0-goog



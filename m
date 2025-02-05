Return-Path: <netdev+bounces-163087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9818AA29541
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80B2167CB3
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F7219259A;
	Wed,  5 Feb 2025 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sJ/3AeTe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583D218A6D2
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770685; cv=none; b=bWjYNnvXfYsAUmn3Uf0VpMCZeeCIGt2Enc/+7kWKJNBZIfR3iB760rMysD3ciWmqx0/bvCWuZx6EZTU4ejwfV16F+y0ELD8ejsFn8fhN5oWjrAUt87khpNoGZgMfl9e4psJ41DMJT55VtijiglczV7GTpALIuxbgmrAuJD0hVUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770685; c=relaxed/simple;
	bh=7jVWSrjoPsJTlYuJUx7Ve86JID2VuVx3RWFZAEwPwns=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MDCA3fr1aPmcVkxWgeqnv01ezIQMpe60FWLLqtGxgwm4bfiv/uWr1SrL8rhQ6GcpjrEyt8DWH0gFBCsbGrotZ2eu1Eb4yyntYn1icLm5/v1+vhS3SCDgiFXgA0R81IzEN1PYjpWgBdMR2fLpet+k4VogM3iNNljuGtPfA4vmLVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sJ/3AeTe; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-467b0b0aed4so137448281cf.2
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 07:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738770683; x=1739375483; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YltdPh2DTLHaaVWal9d771nvesQr3cOmFN62LjAnwTE=;
        b=sJ/3AeTeiSCpOsYHJ4TgS6cXFYWtUQyqafb197XFSyT9xMCrJZdoeLw61xnASwOaRh
         gTmrmc0n4M03MyXTbtdwenYvia5VTLDO0OC902VAUVKW+s4C9mE5oan1rkIoXrMOvUbE
         Ce6YLKUJ/9fJ1kNb/uu+0fIo0YcUmmwoeH2vVlYH83/WQxG5a1jRtJKFz980RJzIbPrm
         IoBRZWH6fgUghqxZn2c2KcDS97pTI+UXm6LVxKpbPtT4bPYWuiYwdTfnqE7hmphNozY2
         O7PjmaQzT5PvEYYXqQPSfcBM/J/uowrGlBvMWcxQITCu0o/688Y4cMUhIRG/X7Gyuf/L
         qBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738770683; x=1739375483;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YltdPh2DTLHaaVWal9d771nvesQr3cOmFN62LjAnwTE=;
        b=UvhYasHZzLoP4/kud0RAOCJSg+dT2MCsJ6B3Zxd4JQN93HL3PhKuUHikqgf8xCJYxa
         ZZbnUimXHREKDa7NswPjhmVywJBX9W2q1uFb7THZUQXKJ5WH6tWJX9UoDt+vgaYgTxrE
         c6SffhjrQgVrHgLVacivG1RBQJNU72hf89O7V+Kweifu/7CLT5mhpopiDm8lyCVxLqTO
         w285+nSmNgcT1G6ynSfapFuFc/Zdv7KJjOX2Lnn/OtPeFB+BSyobvMegZpogQEVOujrp
         ZCbMt/5QNZeG288bwCkpvfk8vrPg/Gwf7AH7A7XMcd5UFmaw2NDMp8N23JBI/P7m5daG
         6HLQ==
X-Gm-Message-State: AOJu0Yxc0y8hhx4g4v/GFEi5kpWvnzF2iZlfoq2ZuKHEgz/FB0ZZX39+
	VKpZC7pfe2OzkfhmFasJhlPvJEDhytFivtqzIqzhqszQVwM1OdMuyQmdc5w33SRKUNmB328OJAa
	xwAiY4yl94A==
X-Google-Smtp-Source: AGHT+IHm3fMPwnevcP+FLKeSdTZciLhxA2Tmq4nyN6eRB9TaEsQ9A3JEwOY6HaRYZ2cQCMfLdZbrVmsnJt/JqQ==
X-Received: from qtbcr16.prod.google.com ([2002:a05:622a:4290:b0:466:928b:3b7c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7fd3:0:b0:46d:d23c:99f5 with SMTP id d75a77b69052e-470282de21dmr46008701cf.33.1738770683242;
 Wed, 05 Feb 2025 07:51:23 -0800 (PST)
Date: Wed,  5 Feb 2025 15:51:09 +0000
In-Reply-To: <20250205155120.1676781-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250205155120.1676781-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250205155120.1676781-2-edumazet@google.com>
Subject: [PATCH v4 net 01/12] net: add dev_net_rcu() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dev->nd_net can change, readers should either
use rcu_read_lock() or RTNL.

We currently use a generic helper, dev_net() with
no debugging support. We probably have many hidden bugs.

Add dev_net_rcu() helper for callers using rcu_read_lock()
protection.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/linux/netdevice.h   | 6 ++++++
 include/net/net_namespace.h | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 03bb584c62cf8a920b12c673dcc438eb1cc41499..c0a86afb85daa2b50e26a1ca238707a24a1842ad 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2663,6 +2663,12 @@ struct net *dev_net(const struct net_device *dev)
 	return read_pnet(&dev->nd_net);
 }
 
+static inline
+struct net *dev_net_rcu(const struct net_device *dev)
+{
+	return read_pnet_rcu(&dev->nd_net);
+}
+
 static inline
 void dev_net_set(struct net_device *dev, struct net *net)
 {
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 0f5eb9db0c6264efc1ac83ab577511fd6823f4fe..7ba1402ca7796663bed3373b1a0c6a0249cd1599 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -398,7 +398,7 @@ static inline struct net *read_pnet(const possible_net_t *pnet)
 #endif
 }
 
-static inline struct net *read_pnet_rcu(possible_net_t *pnet)
+static inline struct net *read_pnet_rcu(const possible_net_t *pnet)
 {
 #ifdef CONFIG_NET_NS
 	return rcu_dereference(pnet->net);
-- 
2.48.1.362.g079036d154-goog



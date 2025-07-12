Return-Path: <netdev+bounces-206371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682C8B02CE5
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 22:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378934E1C28
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 20:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B82224882;
	Sat, 12 Jul 2025 20:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gBDOxEaj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DF022C355
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 20:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752352533; cv=none; b=VNYGxZlkvq3if2nSpgeU0AtBtnYdqJQYsNx/nCw1y3r38M+zErTqkkUS/k7u+DT0QqAsEmWbtn+Y6NwkSKaH5cyIMPphZpxA5cJQpwzErSJeF/ZN+tCv5g9SnYwK7F96jC4nZQbSyBal1NFje2foMVGPRd6j7sewvpOEPnhNSdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752352533; c=relaxed/simple;
	bh=HiOgL44Uh5m1FF3h0XKNYQwKhS8zmVjU/dbAK0jZ0U4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bYNw+s0QSlbIAfhYwRLnipQ5B4FkrziQNlxNAQEH3y3tNvoQIcPtT+JR+uybkAnpU+uDSeZbMavFL/qeyFpTywJfe3og+i/xxKfqtHZ0mNBtVHDCC/KCOomaQtnJtiOog8J6QQZnrKAy2LyKesJPFnPRw/pjGzAA/sq02y4KyZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gBDOxEaj; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2356ce55d33so47075125ad.0
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 13:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752352532; x=1752957332; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2IpGSktAAXtHw5OcAA4Vm/rZMuJO4mZYnClJ1ITqfNA=;
        b=gBDOxEajddcbw+xNf68ndgQ6MDswAEs2ZCzsuBJOwa8HkZP+/VOENYZS96KrUbLSok
         9hzXX8h6MAdjEP8yzxLalutK866uRbqAmHV99c2B97VFiKdqwkf39H2PgMvV+dX9vS3F
         bUDymmK6Y5O3tPQUiaoPEJ7MAdwkfFh6ODbN9tfYuxhrvhXgb6qnNtHzlfPXSg6GlxOc
         5ivvn23HGqGJmnyCGMP0olngt+LVz3XvO7gLJEkYPmF0xyjeoqu7L4cKbQzttL+cIF/0
         T52ewWnzFuNu7q2iBbjz495KjWv60bJY9hD40v6YgPZC5NJHQ9JVvG2FCQRG8uggWzCK
         XlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752352532; x=1752957332;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2IpGSktAAXtHw5OcAA4Vm/rZMuJO4mZYnClJ1ITqfNA=;
        b=Ns/lAKFJZH0qcMVzt5qcHfPTRKKn3r1p2RTBAnyDiRYI1rExs/NztSo5Lwq4WniR2i
         p2EpjVg4ToKzzhqLagYWVdWn6+oer/tJQ1Oi8P4j3yNmYjLwd3V/GJsAIjmNVdtbXPtp
         iQn4bKrnXhuu5v8ax2n/Ut9YVUBciHvzPVSJmw9slJoFllw3DwOoGWIFuI295le/iJte
         oF26KerhwkEk6F7VY2DyyxuuAiAzeyCqTI7MqauTM9BIt/TtGP7lieuZYUd0/zvYprzM
         LTXxfTt+oTC/JUItrUxDswdaIss+T8ngpPYdOR/sy6bRiTmpziv0BZMtThyE59HwPoK1
         0VXw==
X-Forwarded-Encrypted: i=1; AJvYcCWKoBDYFbngVQy3l34TmaYNe2yUyAod8U/ZbW5w56b2g4tzDE6JcZZV0ttexP1PeSeYh6+IjKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFD4xQdbe65PastwZEe90UvdJRRDqCHyltqsfbxA2yCB3ZAyWM
	94GrQcqJ9sxZqipFcYlhtOrCTZJs9TqxrkCuiqwHH7Yw1dk3xqTIlNeY9bUfXcLhOCaRTZ39SLM
	+pPThKQ==
X-Google-Smtp-Source: AGHT+IErBSInFmH1l/m6BEm82M9z8nWsey6+pC8EKWGru7TCwyUyaPpr93+wulEQGar2bD8lMXTeCKCfRZw=
X-Received: from pjbtc4.prod.google.com ([2002:a17:90b:5404:b0:312:1900:72e2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b26:b0:234:ba37:87b6
 with SMTP id d9443c01a7336-23dede3897amr123015045ad.17.1752352531908; Sat, 12
 Jul 2025 13:35:31 -0700 (PDT)
Date: Sat, 12 Jul 2025 20:34:18 +0000
In-Reply-To: <20250712203515.4099110-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250712203515.4099110-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250712203515.4099110-10-kuniyu@google.com>
Subject: [PATCH v2 net-next 09/15] neighbour: Convert RTM_GETNEIGH to RCU.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Only __dev_get_by_index() is the RTNL dependant in neigh_get().

Let's replace it with dev_get_by_index_rcu() and convert RTM_GETNEIGH
to RCU.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index b8562c6c3e8ef..38442cffa480b 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3055,6 +3055,8 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (!skb)
 		return -ENOBUFS;
 
+	rcu_read_lock();
+
 	tbl = neigh_find_table(ndm->ndm_family);
 	if (!tbl) {
 		NL_SET_ERR_MSG(extack, "Unsupported family in header for neighbor get request");
@@ -3071,7 +3073,7 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	dst = nla_data(tb[NDA_DST]);
 
 	if (ndm->ndm_ifindex) {
-		dev = __dev_get_by_index(net, ndm->ndm_ifindex);
+		dev = dev_get_by_index_rcu(net, ndm->ndm_ifindex);
 		if (!dev) {
 			NL_SET_ERR_MSG(extack, "Unknown device ifindex");
 			err = -ENODEV;
@@ -3106,8 +3108,11 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 			goto err;
 	}
 
+	rcu_read_unlock();
+
 	return rtnl_unicast(skb, net, pid);
 err:
+	rcu_read_unlock();
 	kfree_skb(skb);
 	return err;
 }
@@ -3910,7 +3915,7 @@ static const struct rtnl_msg_handler neigh_rtnl_msg_handlers[] __initconst = {
 	{.msgtype = RTM_NEWNEIGH, .doit = neigh_add},
 	{.msgtype = RTM_DELNEIGH, .doit = neigh_delete},
 	{.msgtype = RTM_GETNEIGH, .doit = neigh_get, .dumpit = neigh_dump_info,
-	 .flags = RTNL_FLAG_DUMP_UNLOCKED},
+	 .flags = RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
 	{.msgtype = RTM_GETNEIGHTBL, .dumpit = neightbl_dump_info},
 	{.msgtype = RTM_SETNEIGHTBL, .doit = neightbl_set},
 };
-- 
2.50.0.727.gbf7dc18ff4-goog



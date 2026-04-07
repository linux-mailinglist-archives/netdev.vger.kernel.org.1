Return-Path: <netdev+bounces-276170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIX2DjB11WlC6gcAu9opvQ
	(envelope-from <netdev+bounces-276170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:20:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF58F3B4F7E
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C191D3042E90
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 21:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41BA37CD35;
	Tue,  7 Apr 2026 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XwdWLiQK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23795376BCC
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775596818; cv=none; b=sUj7GWEp1Ia7oTB/oxvZdHBFdmSf5aWamjNQN2aHKMpmVj4JoRSB8jvy6w7sgp0Tu8B1YfjwUYJj9DjZVJG+YCXUpuzFmdQvMYWR1BgvhGpDKG+J4VDtq/jnmsmTcdc3YJxftrit/7ZgWygVFN/aj6vDKHvq2XdVZle5pQdyu00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775596818; c=relaxed/simple;
	bh=pUSzOLdtF+wuXy4SS5pfV7Bls/cZrgxZtaPpNRlpXd0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k4nNm+2fcozgvI8S8knVu810yz4VFT81dpwewDRADG7k/wkIaqVHOspE6kanHuR6w2aBA8D6cWl8tlkBBWaxhN7joNXAkv0tcPwIV2V50QyCQ6eMeuuH9eKdqRnJ73ycJLXjKkf+v0sGUyQr2MuTy1fFdNfj95AFZz5iF/uQ1mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XwdWLiQK; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so3367092a12.3
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 14:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775596815; x=1776201615; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cZOyuCCsUdAnrAip03eRGUyL/K2xukJtHTf2UmxyffA=;
        b=XwdWLiQKzF4AcIT1joLXs1o5ypH28WmC9IQfquaMWdiNdV3CsIQJ6AabchAFp10i5p
         A7j81rm6kBqCW/m6sX6XsT4DbxwbZj2u4jN3fLfmgNs+ZZ4Q8azQU6Yb1qqY930ZRA5f
         MmvSx+VoL4oPae/EW3ASu201D0FHWZ0jMAD2WcTNk5AVhHPD/CALi/9syDfnL80CazZx
         z634Xa8X2a8G8vKOZaV9u9KQFb+gXu9J8YYFs7+LHeYKKnOpqEOAW0oirE68l+MxfP0d
         HO2dQ/56LingdI+NAQN3KEgeDHUb0A/Vfas8VdqdZEA3jthUqMHqvaTNp0kh4RFDoLpI
         6znQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775596815; x=1776201615;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZOyuCCsUdAnrAip03eRGUyL/K2xukJtHTf2UmxyffA=;
        b=oEq3hD7rQq6rVlKm+gl/pGGt5JhEJrU+Jdqhd2eU3HWljdMCGFQ/uK+iWs7AzCVW6r
         Bxs3NvJVwzg0LmI6wyekjYw9a9/YcQ5EFAWxucMfr2mw/yYSMQz1C2l8OR9ULH/GBxcF
         A+8ccZHMaTN2wkhpbtzeap2d0SdJH45cFHJoPQv90ObHE6UVjts/y6mSXqhiQTjpIQ5t
         E5FwIw4wC1xyEaOVkGqiyicktulcyhitKsgpoyrPrW48X0ECBabJyCS0dRPrcbvTpwlu
         LNxWOhByGjz74gTvDXQfXg5e0Ql8/hD53aCLTAwHjcGHW7PCJ0h181k5zBNsWlcKUe4s
         dlAA==
X-Forwarded-Encrypted: i=1; AJvYcCV9hxFvNovF40E/tEsyIqT6E2EbBlBm/56Iq4D9ztb8KB1quAz1JCsWHW+eaUABelLFO0sKRXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ4OiZZWTmj9QxRJnQtkHhsCeMiDEmr2/PxXS34cL0Ag4RdQjc
	FWTjiF7h1zkwCUJb3BkajkxAwJRl+lPfYje3yRH7t+zpbfXwoL3jwOvW21X8lwoDScp768v3zTX
	kige9CQ==
X-Received: from pgcv27.prod.google.com ([2002:a05:6a02:531b:b0:c76:3f60:53ff])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:998e:b0:39b:81bf:15e9
 with SMTP id adf61e73a8af0-39f2f3348bemr18810720637.51.1775596814957; Tue, 07
 Apr 2026 14:20:14 -0700 (PDT)
Date: Tue,  7 Apr 2026 21:19:40 +0000
In-Reply-To: <20260407212001.2368593-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407212001.2368593-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407212001.2368593-8-kuniyu@google.com>
Subject: [PATCH v3 net-next 07/15] ip6mr: Convert ip6mr_rtm_dumproute() to RCU.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276170-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF58F3B4F7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ip6mr_rtm_dumproute() calls mr_table_dump() or mr_rtm_dumproute(),
and mr_rtm_dumproute() finally calls mr_table_dump().

mr_table_dump() calls the passed function, _ip6mr_fill_mroute().

_ip6mr_fill_mroute() is a wrapper for ip6mr_fill_mroute() to cast
struct mr_mfc * to struct mfc6_cache *.

ip6mr_fill_mroute() can already be called safely under RCU.

Let's convert ip6mr_rtm_dumproute() to RCU.

Now there is no user of the rtnl_held field in struct
fib_dump_filter, and the next patch will remove it.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6mr.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 389471e740bc..cd28bea8c11a 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1391,7 +1391,7 @@ static const struct rtnl_msg_handler ip6mr_rtnl_msg_handlers[] __initconst_or_mo
 	{.owner = THIS_MODULE, .protocol = RTNL_FAMILY_IP6MR,
 	 .msgtype = RTM_GETROUTE,
 	 .doit = ip6mr_rtm_getroute, .dumpit = ip6mr_rtm_dumproute,
-	 .flags = RTNL_FLAG_DOIT_UNLOCKED},
+	 .flags = RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
 };
 
 int __init ip6_mr_init(void)
@@ -2751,15 +2751,17 @@ static int ip6mr_rtm_dumproute(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct fib_dump_filter filter = {
-		.rtnl_held = true,
+		.rtnl_held = false,
 	};
 	int err;
 
+	rcu_read_lock();
+
 	if (cb->strict_check) {
 		err = ip_valid_fib_dump_req(sock_net(skb->sk), nlh,
 					    &filter, cb);
 		if (err < 0)
-			return err;
+			goto unlock;
 	}
 
 	if (filter.table_id) {
@@ -2767,17 +2769,26 @@ static int ip6mr_rtm_dumproute(struct sk_buff *skb, struct netlink_callback *cb)
 
 		mrt = __ip6mr_get_table(sock_net(skb->sk), filter.table_id);
 		if (!mrt) {
-			if (rtnl_msg_family(cb->nlh) != RTNL_FAMILY_IP6MR)
-				return skb->len;
+			if (rtnl_msg_family(cb->nlh) != RTNL_FAMILY_IP6MR) {
+				err = skb->len;
+				goto unlock;
+			}
 
 			NL_SET_ERR_MSG_MOD(cb->extack, "MR table does not exist");
-			return -ENOENT;
+			err = -ENOENT;
+			goto unlock;
 		}
+
 		err = mr_table_dump(mrt, skb, cb, _ip6mr_fill_mroute,
 				    &mfc_unres_lock, &filter);
-		return skb->len ? : err;
+		err = skb->len ? : err;
+		goto unlock;
 	}
 
-	return mr_rtm_dumproute(skb, cb, ip6mr_mr_table_iter,
-				_ip6mr_fill_mroute, &mfc_unres_lock, &filter);
+	err = mr_rtm_dumproute(skb, cb, ip6mr_mr_table_iter,
+			       _ip6mr_fill_mroute, &mfc_unres_lock, &filter);
+unlock:
+	rcu_read_unlock();
+
+	return err;
 }
-- 
2.53.0.1213.gd9a14994de-goog



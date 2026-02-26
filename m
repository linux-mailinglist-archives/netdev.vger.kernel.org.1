Return-Path: <netdev+bounces-261129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CP6sJNqxn2kpdQQAu9opvQ
	(envelope-from <netdev+bounces-261129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:37:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADB41A0247
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F87E3016BAA
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B7937883A;
	Thu, 26 Feb 2026 02:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WLK3ux/h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76EA378825
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 02:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772073412; cv=none; b=tGi5JpQnt9xXADVClEt93UUXrZEzCAJVQdaFy7WSG70pGOA9FXopxadAeHbisKXS6CXNhcFUOYot8an9CGxRlB1GZoONQp9OMh9cEmUwkNGmWdpwY/+luRXVI8Vme4Ybk4jPM7tCze6up7s4anAchILw3WuFZx9sGnTikomnrWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772073412; c=relaxed/simple;
	bh=j47ck2c4zpE/It0hrVqY6mYQQHNUr7yOyPdy+JZQSdU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P04H9j8/fAgHWT+2rFCq5wAh+fZyxdVuhS7BJG7O7mU+pyUpJaWjx6IHWn3ebeEE9dKpboW4zqmfwrx+XdHcpmEIxWuQRJdI+BrbwspbDo0wjRxnQn3riEpcnn8eJzQW0gwnwpafzIzWvYr/T0nljg3Hd9NdidCblhLMd1e3QBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WLK3ux/h; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8273937bfa8so195516b3a.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 18:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772073410; x=1772678210; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vb2eCDyF3DfInvTCuVZi8rBubTxIjPk8fiSXXmuQQyc=;
        b=WLK3ux/hCfp5XkC6jDLQgqJiP5IHtyiOhp+77vSgnEXg+v2Wq3tKtiumKI7CAyiRqE
         DkQElZINiNN2HYMoYNM0BSaEhcKiqtNC31yCg3nNFixqxw9Op8Z0ynShqs0Q5x6Oz41X
         kuveVvLCDNCy9IZXFBVzhMgOzz0l1eMsp1FdnTEULmZih/PC7Nfj4JPVR6BsqgYqxlof
         87NxMZfG6LLSQBhTwzQhEcYXDKFmbwvK3P7JlpidYFHkk+qEJxnNBLGMf8IADIBU9sNE
         p8+FSaYy0xpK3q0jvUgj7YbjSnFvg/NT3vGEQYHv9yf6hmxfeokNQJxeoOmI/IlzhnLy
         WHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772073410; x=1772678210;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vb2eCDyF3DfInvTCuVZi8rBubTxIjPk8fiSXXmuQQyc=;
        b=SjuDfC+R770oxD3afhewSCdRgr722QNduzvzzEIzv/nD3rHO0AkgePMrMUIyQvM8ZZ
         tQrpzcx/g4WX77PlC7/0wjyCNCII+dsMv/09Ij33pNbwxL0wSYp+3T/mJoyYQwOPS4F6
         N0OelStTa7O00pUQShXDiP3I6UGzxmQiJL9gAD85S8Cg0oO9ONvpwphbIdkmhtyUS0sQ
         aGwufG4Ezf48oug83kYuanyG2AT84PVWrBbCdtt8Hx0MTW27o/NeVHTr+ZDhhUTBhzPJ
         Gz3bkR75tV788EUsfq1Np6WrwMRnrrPqE/RxlwsQU6EQBZ9G05e2R2234oc6K7tA+mZp
         aGmA==
X-Forwarded-Encrypted: i=1; AJvYcCV216KUDHaajdx/0g0qvPg29dZCwx8YGvilEc/Bf3hBH2UV6T4nn4i5XciWUvnSIwCBDqox7rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyucUxzwYczTlYJlx82QRUeUwddH0lkAQcySZRkyhTt1J8qTw4
	a3wX51dwjwm4/TcO8UE27cj6Ao/kYoW+vVpjCj/kJWyUw9P5fhWOIVYr4nqTp91MUO+xN3iZP3d
	jXAKGaQ==
X-Received: from pfbfa25.prod.google.com ([2002:a05:6a00:2d19:b0:81f:82af:56c1])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a04:b0:81f:45a2:cbda
 with SMTP id d2e1a72fcca58-826daa8a1bfmr12630563b3a.66.1772073409891; Wed, 25
 Feb 2026 18:36:49 -0800 (PST)
Date: Thu, 26 Feb 2026 02:35:18 +0000
In-Reply-To: <20260226023637.1335854-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226023637.1335854-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226023637.1335854-7-kuniyu@google.com>
Subject: [PATCH v1 net-next 06/15] ipmr: Convert ipmr_rtm_dumproute() to RCU.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261129-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3ADB41A0247
X-Rspamd-Action: no action

ipmr_rtm_dumproute() calls mr_table_dump() or mr_rtm_dumproute(),
and mr_rtm_dumproute() finally calls mr_table_dump().

mr_table_dump() calls the passed function, _ipmr_fill_mroute().

_ipmr_fill_mroute() is a wrapper of ipmr_fill_mroute() to cast
struct mr_mfc * to struct mfc_cache *.

ipmr_fill_mroute() can be already called safely under RCU.

Let's convert ipmr_rtm_dumproute() to RCU.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/ipmr.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 53dda438ba32..3af6b3d33cc8 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2736,15 +2736,17 @@ static int ipmr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 static int ipmr_rtm_dumproute(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct fib_dump_filter filter = {
-		.rtnl_held = true,
+		.rtnl_held = false,
 	};
 	int err;
 
+	rcu_read_lock();
+
 	if (cb->strict_check) {
 		err = ip_valid_fib_dump_req(sock_net(skb->sk), cb->nlh,
 					    &filter, cb);
 		if (err < 0)
-			return err;
+			goto out;
 	}
 
 	if (filter.table_id) {
@@ -2752,19 +2754,28 @@ static int ipmr_rtm_dumproute(struct sk_buff *skb, struct netlink_callback *cb)
 
 		mrt = __ipmr_get_table(sock_net(skb->sk), filter.table_id);
 		if (!mrt) {
-			if (rtnl_msg_family(cb->nlh) != RTNL_FAMILY_IPMR)
-				return skb->len;
+			if (rtnl_msg_family(cb->nlh) != RTNL_FAMILY_IPMR) {
+				err = skb->len;
+				goto out;
+			}
 
 			NL_SET_ERR_MSG(cb->extack, "ipv4: MR table does not exist");
-			return -ENOENT;
+			err = -ENOENT;
+			goto out;
 		}
+
 		err = mr_table_dump(mrt, skb, cb, _ipmr_fill_mroute,
 				    &mfc_unres_lock, &filter);
-		return skb->len ? : err;
+		err = skb->len ? : err;
+		goto out;
 	}
 
-	return mr_rtm_dumproute(skb, cb, ipmr_mr_table_iter,
-				_ipmr_fill_mroute, &mfc_unres_lock, &filter);
+	err = mr_rtm_dumproute(skb, cb, ipmr_mr_table_iter,
+			       _ipmr_fill_mroute, &mfc_unres_lock, &filter);
+out:
+	rcu_read_unlock();
+
+	return err;
 }
 
 static const struct nla_policy rtm_ipmr_policy[RTA_MAX + 1] = {
@@ -3299,7 +3310,7 @@ static const struct rtnl_msg_handler ipmr_rtnl_msg_handlers[] __initconst = {
 	 .doit = ipmr_rtm_route},
 	{.protocol = RTNL_FAMILY_IPMR, .msgtype = RTM_GETROUTE,
 	 .doit = ipmr_rtm_getroute, .dumpit = ipmr_rtm_dumproute,
-	 .flags = RTNL_FLAG_DOIT_UNLOCKED},
+	 .flags = RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
 };
 
 int __init ip_mr_init(void)
-- 
2.53.0.414.gf7e9f6c205-goog



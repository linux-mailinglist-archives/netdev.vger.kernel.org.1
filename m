Return-Path: <netdev+bounces-262239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCVhJwhqo2mACgUAu9opvQ
	(envelope-from <netdev+bounces-262239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:19:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE681C972F
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51725308A170
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9533D411B;
	Sat, 28 Feb 2026 22:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HZdKV2hU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0564D3D4133
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 22:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772317095; cv=none; b=nIcGRpFsZgur7sHAj/Ty95A80eYyDE/a4kTHvMd2QlpAJYTgR05D6wF1Mb3pkx1GV1LDJ2eL0B7UA4fI6XjoOqsIJ3W4zpxHNdHBkaqSSOSE3vcERaHWKJibUU9/6BHg+hPV3e/VnxX0y1UUyZlM1I5//nx8p4tALIGqv4ypIJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772317095; c=relaxed/simple;
	bh=Gz3pK/1G7Ng/1dKcHFVxc/I50HJjJbW/Q8r9RFle5sA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rN/gOPzmJ1jGll7kMCyV53lQwYpg0b8B+q0eRYwBjA32wUtDPEI/lLxWdBlSlLxtVyVnIx+pE49Is5gWIbimHEWuBb2632EYsBsFaUnD2FISWOM8tAa4n0Y2Xx83eXtDawk+LuYW+ChPPfAsDAwLGJKVrXDwaNfotrcRNVpyqCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HZdKV2hU; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae3badc00dso6937515ad.3
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 14:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772317093; x=1772921893; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvZ/SPMKvL2wWL4Lbp1193OlkW9X51Bbq77xZaBB+BQ=;
        b=HZdKV2hUiRarYSddpz2BLMvOKtp4DaA4D4X1dX2tV7tR4yV5V4bv5qx6t1vIpnZjyo
         51SJLNqe7p5f/pxclwE21XpFx5jVkJhhTwJM4j26r8rX/xTgIjtxpANGk4Y+viSjSAaI
         PkDYuusMJ8XUlTxhN7z0mmZw8elxaSTY3vS/boABu4t6L3NP+LoRtMWIZ2PFxz6T6/mW
         m0Bpco8JHKkogN0WgwDJLPICjk32R/tJQ/bXo9mGAuMFp3N2pu8aWXAFY2/gb7MK7dZw
         4FefiMrvprkLcnvIL1HjIhtEWAnmCafbkP396+qjbKV5IY7Q2oYbNEgYZhATtHjSGi1y
         nl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772317093; x=1772921893;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvZ/SPMKvL2wWL4Lbp1193OlkW9X51Bbq77xZaBB+BQ=;
        b=Hs68pykTKg+pXXNdLt+6kAIE3qzjE3tDrxklRsqjYf64ZPtU+nBSPgXy8o2nVOL5BE
         drwuyUR32MFGGkJU3fiudW3AAPemJsKmI3TRzBk8yTmU3psJZkruBD7X9aAuuSFMI5bK
         ga4rammBA8wcg0EbLqmcMaNPKycVfXuS0ljonmvsxG4HmdUidlzk9BomLvj0IIJHZB1K
         hhLzwPOf7WM5mouDd4UP59U06sPwETjC82hmYI4Hr/3DhCuYY4ucDIJs/pXJ5NifG4AE
         vb/joR5Rop4rrw65OrGWz3RxasonYM1SUYLpGrM6KQwuS16ykF7UfOqpmATfHcyimUqZ
         KYwA==
X-Forwarded-Encrypted: i=1; AJvYcCWTGK3rwvz85EpCDaeVvKdU6xDUCXZaPt15GpkLwH1Xq4pGa+kfwkOC/0j1xZyZuWZMcXtzTC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYzukBL5erGoPXY2aAEPO8TypgdrzHzLFyFQpYJ2hAh1YdSciL
	nA/WdEIRkUpEy/69CxNRjE6xSSs6+a+KOLq9ZjqoMjbcZh6Da50g/0F2+IhKUYGKpgT4ieqhAfC
	8BW0mSA==
X-Received: from pgbeq21.prod.google.com ([2002:a05:6a02:2695:b0:c70:e97f:35fa])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:244e:b0:35b:b97f:7bd2
 with SMTP id adf61e73a8af0-395c39de3b3mr7621864637.10.1772317093346; Sat, 28
 Feb 2026 14:18:13 -0800 (PST)
Date: Sat, 28 Feb 2026 22:17:24 +0000
In-Reply-To: <20260228221800.1082070-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228221800.1082070-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228221800.1082070-7-kuniyu@google.com>
Subject: [PATCH v3 net-next 06/15] ipmr: Convert ipmr_rtm_dumproute() to RCU.
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262239-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EEE681C972F
X-Rspamd-Action: no action

ipmr_rtm_dumproute() calls mr_table_dump() or mr_rtm_dumproute(),
and mr_rtm_dumproute() finally calls mr_table_dump().

mr_table_dump() calls the passed function, _ipmr_fill_mroute().

_ipmr_fill_mroute() is a wrapper of ipmr_fill_mroute() to cast
struct mr_mfc * to struct mfc_cache *.

ipmr_fill_mroute() can be already called safely under RCU.

Let's convert ipmr_rtm_dumproute() to RCU.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ipmr.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index cb1a5e3a6296..5c8508788fb6 100644
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
2.53.0.473.g4a7958ca14-goog



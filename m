Return-Path: <netdev+bounces-261702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIYqMzsSoWlwqAQAu9opvQ
	(envelope-from <netdev+bounces-261702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:40:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5811B2548
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0196630DAC56
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341BF33291D;
	Fri, 27 Feb 2026 03:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jaxwMDa0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CD63328E7
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 03:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163558; cv=none; b=FSY+dYttTZjhwEpcjR+6MNgFkabDRh/R97l8EWZ8tujz4k1IcsR1KnDhLSFssJHb6tJOQnvGLN7syNNVDJ0B1jaCmAs27j6X5RyHmiN7vpmvv77rn/1YfOekcLgfDeZ1Yw6ju+jL4KMYIqtDDNStBvy9e2MtAx3vzGGxmFOhNqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163558; c=relaxed/simple;
	bh=gpRbFwyeDy2zAwrHJwtVN79D9G9PiOuwTLl2IbzUPu0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gAHykMHtUknCRHL4LrV5oDa2iaU8vNezLJlqewnXC7r1HCOT9adVC2+bkXHPwnczGm9+1kYD8Ri9mv/0+HzJF7RycIac+Eta0HW0sXrowgJfayLA+CTgjeyZ5ruyNFTxeeEaz8WkeT1arEjaXniY+vGbmFgD/R29IG4CI89jdyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jaxwMDa0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35449510446so1390389a91.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 19:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772163556; x=1772768356; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BLeQ/ZjbHS7ScLU8rU/P1RlHQpyznVZ4Bm6+4xapmjY=;
        b=jaxwMDa0ZXHUenydU2D8Rwmffc5Y1AXpBE7C8LPDvukWD8kxhawL63C2RXjau3iwpZ
         jA0vNyqp5NbiueZphetCWEXCeUSCBr6YxrNRCk2Nd1bSH8/DTVm+3s5weKtk7Z/Hi3Cd
         LzNObfc6AESD9pq/Q5iPD/rln2EWmpQSjqFDd/4OwAQ5839EaoKqvdwHoruy09/IKH9k
         7oWov0jYu3nvwMxVCjDqgzlMy3k8XAvDfoQTz6hIjpFZuVOlvAhU907erjFewUzur3mj
         kmjTEaPhRYk9rboEvqGU+PiYWb+gMWKQJzmDG06S+jxwAKPxXEGcpSmqZkxFiH4J45t6
         PtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772163556; x=1772768356;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BLeQ/ZjbHS7ScLU8rU/P1RlHQpyznVZ4Bm6+4xapmjY=;
        b=thWCruELCA3bx8v3bFRae3Z15PRjixKKcHiNmTvbtLKytSrLuYS5pprysNmu5dQngI
         sQGAs4B3u3lk6PmiHzhdzC+I0hMrdrsXrVk5IEOYhWRlRziNuarEokNKWpHg6qtnLUyR
         XJEFmqxrkJvW+Kj9rrYq31I763MCRme1HrQp+gHT7ctZzeCCcpa/nY74eB3g7QJZNDyU
         hrQc93ZUpqN1v3D8pT8jtBTm/HXwIN84fM7ZR2882Q1R7x9z/xiywK78pS1CYvhMDrf5
         f9seTs+KeMaCRPm0+hZVLRUpz1jzAf+P+Rg3QceSCweBE3MpQeXFCjZCVoNv34niP//N
         GtVw==
X-Forwarded-Encrypted: i=1; AJvYcCXf67YhJ7QFAaZrWgojZHQ9/BJI31h0pHh0yC7No136Kqum567nroEI92yx7YkwycqfvxWyd7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwA14k6ZuMCLcD2Tk7SHgyB+DF9CruJeZi+6TPQNh1J0Ac5Msz
	qpNACBWzmf9OnVLXUzCDMvQzblxbAztRhyjVkrrfH/L9+LnmDd6TyFsrKePWKncM95OELhpxRB1
	g96tfXA==
X-Received: from pjtn2.prod.google.com ([2002:a17:90a:c682:b0:34e:b8c4:7cb5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:270a:b0:34c:7182:cf9d
 with SMTP id 98e67ed59e1d1-35965ccaa10mr1267615a91.25.1772163556159; Thu, 26
 Feb 2026 19:39:16 -0800 (PST)
Date: Fri, 27 Feb 2026 03:38:29 +0000
In-Reply-To: <20260227033903.3307272-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227033903.3307272-7-kuniyu@google.com>
Subject: [PATCH v2 net-next 06/15] ipmr: Convert ipmr_rtm_dumproute() to RCU.
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261702-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C5811B2548
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
index 96715e41bcf6..5e45730ed3bb 100644
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



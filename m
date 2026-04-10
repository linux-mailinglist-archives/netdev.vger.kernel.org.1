Return-Path: <netdev+bounces-277582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNCdOkVp2Wn5pQgAu9opvQ
	(envelope-from <netdev+bounces-277582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:19:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AFE3DCD2B
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F0D8305BDF9
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7853B19CB;
	Fri, 10 Apr 2026 21:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V9i1ya2H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166FF3B0AE5
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 21:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855864; cv=none; b=LNxyIVJ7kqCfzKF+CMZCrn4d/U7BgSOXBNH+wMFiAFX0cVM7hfUtlt8Ef4+pR5GqKYDoHEm4NPOF0K0OIFFrKc32unzMYyGi2z5C4C2TTCmxpuMu1PCh2Q63V8xxrg0W6EM5CrZ9NGUlNBrNwOmR2SRJxS9rFa9AAA+mlu5tUgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855864; c=relaxed/simple;
	bh=tKHf4NpRF7BZNhZ2+BE5EHpaH0tYtKwmdst8JxY0TNo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mPwoechZOHd6Hx0n2Dk7zcBUwbwlibcBo22qYnnFSAGvd1g6u4n4zR+OnaXKejEOkO0SqrRBJF8dfaqWLKs52M4OcZ38aAGyMZ3ED9nDSRD67G2NI+4+fVlvurDvfMgNrnXkueRPiI5jXEsEAzbc//E20P8FTgVwoLkuvQf7L+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V9i1ya2H; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35d93a8149bso2789150a91.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 14:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775855862; x=1776460662; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCXo+b6Z7/xpQyc+ijXD3ne9Jw0Zn0S4w1j81yD2FyU=;
        b=V9i1ya2HBbJEXIfVoHTdAjpVgJ8DcOoZwuANSnE6PH5sW8c5BMF7lwdUu3OGjyAvbU
         NXIKDgfr6xiZmzu0qWX+8m9AJE1Ag8m9xgZsNX/4w3+KchD1zXV4xAY/IWZTgxs2l/Sl
         GTVbTeBdnZ7a0Cd3K2GlU8m0CbwuG+DzUYcV9g06RuOMx2bPTriYHD5M0cQhcZseYHHP
         /3yCCMHhGXtXA2+6NSQlbzp0EeqhuCbxTJthxzMdYEGI8rehw7X0JHbG7ER/QeVFpWrG
         HuzxjVYickmoz2x8x9OyFdeIzE/bW24uryCf4kM+sAvZOs5NLCUKzOhxy2WWh1EZdU7u
         ASpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855862; x=1776460662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gCXo+b6Z7/xpQyc+ijXD3ne9Jw0Zn0S4w1j81yD2FyU=;
        b=bxYm2DqaHlIXgJ4kQ5Dy387mwt3mN0pcmS1brWY+KSNt9a8I7pFK1PvhGVG53I6xNY
         yFfHI2YJLqj1X/1xyD8etbvuL/72A4XfYqSn2V41xs7Zit+vMix9FTTz/X1F9qJ4qU4T
         ip5joDO0P1rakOjRLHOuzBdFDcregQ87VDuWtlyrDepE/JgYWCMTSlo7Kl3aOY0kQtc7
         f9eAfIKFUKStms+hVyLX5R5ohTvz12lQ/xklHShoModBaKxlbkAQzQhtUvtPlif3XH4M
         1dsxjWFYVnmx6YZCP4DGoxvwQxOxn0rNyUkKiMfWjDgCgpsB5fDNE4LA5kdhNIQTN7RF
         YqBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtQ5OOM+Dhu+ld1G5vsu5Az6f/6sGqIsT1TV9MMC5Woo4Jt9z8CaNm9vDMWgHf94RlXj9QMtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOTd9vEYITDc6S/URlSNwjtwQS11djTUInfXt//wpkkK6Qt/M6
	lN+WDd6/zWPNdSzcvpoArElclV5hlxHMFx55cs2bgidU4VQWKXRCNGiWcOq7ll1ukKADCOHvS85
	6v8k/qw==
X-Received: from plbll6.prod.google.com ([2002:a17:903:906:b0:2b2:3da9:99b0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf06:b0:2b0:6365:217e
 with SMTP id d9443c01a7336-2b2d5d3eba4mr39935815ad.15.1775855862286; Fri, 10
 Apr 2026 14:17:42 -0700 (PDT)
Date: Fri, 10 Apr 2026 21:17:02 +0000
In-Reply-To: <20260410211726.1668756-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410211726.1668756-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410211726.1668756-7-kuniyu@google.com>
Subject: [PATCH v2 net-next 06/15] ip6mr: Convert ip6mr_rtm_dumproute() to RCU.
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277582-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 65AFE3DCD2B
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
index 0054db00fadf..9d02cd3b274c 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1389,7 +1389,7 @@ static const struct rtnl_msg_handler ip6mr_rtnl_msg_handlers[] __initconst_or_mo
 	{.owner = THIS_MODULE, .protocol = RTNL_FAMILY_IP6MR,
 	 .msgtype = RTM_GETROUTE,
 	 .doit = ip6mr_rtm_getroute, .dumpit = ip6mr_rtm_dumproute,
-	 .flags = RTNL_FLAG_DOIT_UNLOCKED},
+	 .flags = RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
 };
 
 int __init ip6_mr_init(void)
@@ -2748,15 +2748,17 @@ static int ip6mr_rtm_dumproute(struct sk_buff *skb, struct netlink_callback *cb)
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
@@ -2764,17 +2766,26 @@ static int ip6mr_rtm_dumproute(struct sk_buff *skb, struct netlink_callback *cb)
 
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



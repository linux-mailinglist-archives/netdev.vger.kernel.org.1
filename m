Return-Path: <netdev+bounces-293375-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDKeJ/mlG2pzFAkAu9opvQ
	(envelope-from <netdev+bounces-293375-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 05:07:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B064661444B
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 05:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F9273008FED
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 03:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49A6353EF7;
	Sun, 31 May 2026 03:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HmJZIEk+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945CC344029
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 03:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780196834; cv=none; b=hNr3DxTOBna1Y2KvCx3nN3Mr4IJR+7dcwvqq4+Mzwcfzhg3A0TnCf/ApzhlglmdDCjcmU3hBeCbmLe9mRvf/uigsxkLdiUdoFt4FZil/uJTyOsZQW7kq8iRhLoJE/6WsYrXlgzJj9EFLQxFd2cyFHsb10WYE3k5ndqw99DrI1Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780196834; c=relaxed/simple;
	bh=jObXvUmJwSX2RcQ2/1IwXVgIYqTkbTQpMAcZONQ8hPk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qz12Km/lkfv9TqB5v/4fhL7M6+Ef5gtCRiNNiFffD1rBO5AHAKMJRyKzv7EcJdfWsHalvDASreGy5qzVVzz27oZDfkdOUK/xxeiIcP8nrhLksWCH434VgQh00tvwZ1qVZr2G2Bxv/ZYAz6NNcqkMYEMTW835x0rMtg8EV3+AIP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HmJZIEk+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d979441eeso176756a91.0
        for <netdev@vger.kernel.org>; Sat, 30 May 2026 20:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780196833; x=1780801633; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eHS1zH76PK3GplZPAYQZxMnWYQ6i6DemI1XwEHjPHmI=;
        b=HmJZIEk+/d6xqrcdMfwGyYl0DKJbiBQQgNjqWY2peRdMikcMCS+yezpFz3x/FAJt17
         elTOUpqHPtycyUWlsdWM3dum/41zFdIkF9aF7ZTswE9G2j4RvF4BCNM8KlDqlLsQJZdx
         J8Txq1uYe3iWCQCtBWbbUABvUbk/ctboNUi6IooFqjfraA/jraelMacmNc9fiEiXLDB2
         bLkoBOmqEjlJyGV5w01G2fxaRIjNoOBwmzhFRIhDgC1F6E17slfUJ6VcqSIsgw0jjd2f
         jiDmfa0VI+M9zK325/u0ZDN0qKOli9g2bzsM2WZq0JJ/MimzHAtENCWBsyjqLGMgealC
         G0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780196833; x=1780801633;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eHS1zH76PK3GplZPAYQZxMnWYQ6i6DemI1XwEHjPHmI=;
        b=oNsJ1l+bvjfnSABoDABASZ8aScjON1Kud0a6JYQlNlIV3fVqCdA822r3REUTNH4JLu
         nZ5rFbZRl6SgERqTelbH09vCEwixVz9QjNIP2W08ppB4kZtrd+XN6VJ8G6PGMvKpp7WJ
         5UHUyRJBpgE6+ka7no/nwDd3t3E9GW2HhWM6vjr3z2JStvqu749XuBJfkclWEufusj86
         arEjtFbvWihHvODu8/G1weLXmgHXCJa2OQKHzxWOLL644YpP8In9RHeP8RfpbSZnKBor
         81vBKIKsY9G9wuuFSIaex1/74wmCjw0JquVhcRVRfbSy1BeKz19c7CxF3mpLDmcom1bh
         ya/g==
X-Forwarded-Encrypted: i=1; AFNElJ8lrKiTIkXzJMa0H2p0IJTDQCxhvY10hUfTagB7yFPfCkvoXIwZbTqiEBB6wSfhPXsMOkTsz2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtaZo8K0jf58waR5lWTGUpRdpU6ik2J1UPnJ9gPqzPhctuEPqX
	X9RWAxhldBwDwLKwyQy75dCT8/YIrVPqwAtT8pAYI1hJMAvOjlRVjqGlzNfdZwQRg1c2r0MpJai
	ZWG9HATSB0sfowloiFNEzTjX1aA==
X-Received: from pgab135.prod.google.com ([2002:a63:348d:0:b0:c85:9c9a:ab50])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d84:b0:369:7421:75cf with SMTP id 98e67ed59e1d1-36c501eb0a7mr5545510a91.16.1780196832575;
 Sat, 30 May 2026 20:07:12 -0700 (PDT)
Date: Sun, 31 May 2026 11:07:03 +0800
In-Reply-To: <20260531030705.3754389-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531030705.3754389-1-yuyanghuang@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531030705.3754389-2-yuyanghuang@google.com>
Subject: [PATCH 1/2] ipv4: igmp: annotate data-races around in_dev->mc_count
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293375-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B064661444B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

/proc/net/igmp walks the multicast list for IPv4 interfaces locklessly
under RCU and prints state->in_dev->mc_count. Concurrently, device
init/destruction and multicast join/leave paths update the count
under the RTNL lock. Fix this intentional lockless snapshot by
annotating the read with READ_ONCE() and the updates with WRITE_ONCE().

Fixes: 1d7138de878d ("igmp: RCU conversion of in_dev->mc_list")
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---
 net/ipv4/igmp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index f2aca659b29c..fd0faf042fa6 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -1566,7 +1566,7 @@ static void ____ip_mc_inc_group(struct in_device *in_dev, __be32 addr,
 #endif
 
 	im->next_rcu = in_dev->mc_list;
-	in_dev->mc_count++;
+	WRITE_ONCE(in_dev->mc_count, in_dev->mc_count + 1);
 	rcu_assign_pointer(in_dev->mc_list, im);
 
 	ip_mc_hash_add(in_dev, im);
@@ -1790,7 +1790,8 @@ void __ip_mc_dec_group(struct in_device *in_dev, __be32 addr, gfp_t gfp)
 			if (new_users == 0) {
 				ip_mc_hash_remove(in_dev, i);
 				*ip = i->next_rcu;
-				in_dev->mc_count--;
+				WRITE_ONCE(in_dev->mc_count,
+					   in_dev->mc_count - 1);
 				__igmp_group_dropped(i, gfp);
 				inet_ifmcaddr_notify(in_dev->dev, i,
 						     RTM_DELMULTICAST);
@@ -1922,7 +1923,7 @@ void ip_mc_destroy_dev(struct in_device *in_dev)
 
 	while ((i = rtnl_dereference(in_dev->mc_list)) != NULL) {
 		in_dev->mc_list = i->next_rcu;
-		in_dev->mc_count--;
+		WRITE_ONCE(in_dev->mc_count, in_dev->mc_count - 1);
 		ip_mc_clear_src(i);
 		ip_ma_put(i);
 	}
@@ -2974,7 +2975,9 @@ static int igmp_mc_seq_show(struct seq_file *seq, void *v)
 
 		if (rcu_access_pointer(state->in_dev->mc_list) == im) {
 			seq_printf(seq, "%d\t%-10s: %5d %7s\n",
-				   state->dev->ifindex, state->dev->name, state->in_dev->mc_count, querier);
+				   state->dev->ifindex, state->dev->name,
+				   READ_ONCE(state->in_dev->mc_count),
+				   querier);
 		}
 
 		delta = im->timer.expires - jiffies;
-- 
2.54.0.823.g6e5bcc1fc9-goog



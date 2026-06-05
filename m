Return-Path: <netdev+bounces-295561-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8s7tIFYqImqKTQEAu9opvQ
	(envelope-from <netdev+bounces-295561-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:45:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D87A644810
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:45:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Inr+20uM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295561-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295561-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45B363076F0B
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 01:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C663D34B3;
	Fri,  5 Jun 2026 01:43:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39E43DEFFC
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 01:43:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623819; cv=none; b=XYoIl9m/ASkx21sklnsIqPSouui9C/UljYC6EwIaoJhhPJABxucFRYZin5s3EHIe97Fz61w12mwxQNQAaKFsn8zZwXt/ralpYOqxDMnmEJlbj+CoDkui7sXMnU3wxI5kMvk9PXKWH8D7jJw6GgQfxvg511jSsleglq7DyEtdDvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623819; c=relaxed/simple;
	bh=EDdO8sCFNSFFX5asKV9mS604oajtv91yhZtFBop5IP8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=byyhGnmOx3vyG8vpuZxgVgAKvOed21yhPDZGnqFZlAMMqYFzh9hqZFl71b1zNrILmMlL3bXByW7n0yr+cA6bk7YnlbVQgkCkt515s3O2qzIDJb8ft9m9FgTYTXdwTl8tlbftXWmM7lo2j7hLvkEX9fHTuUeePXX4mcsAeASorsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Inr+20uM; arc=none smtp.client-ip=209.85.210.202
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8422a0eee68so1884769b3a.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 18:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780623808; x=1781228608; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iVAJucd+GVsBBf1FGgcJQ8cRedfncMhwEKsquMbLLdE=;
        b=Inr+20uMaAQbLN9lbx+DFFI+p8Zk3FYKooLRjyg6OE4Am/6RDsHF/o0BSUGsmG+Z/O
         dsZFJ59bm1jpBuFcTTtTdSQCGZDr0luWTBaG8GHyE2Q0P+RAgpKpjS+6adNsGkAYGdMq
         h0mcJABbaDZGfoAJ6iDVBtbMPxatAcEQyPgA+K0uu7YG34qma7DXBpU9dFa5HghG4O7F
         w83RbywJrTvPJFsQdAGt9GT4ztpxe/0FmJ9kWsGWCOEhGYaTwUfSFrkBAKubIr29VfbN
         yfBcIW30r6PlFIkFyOauX8jPy+6MD3N6xmR3BWkKXi8MyopaG9JcO3aXyPso9eEm1ppI
         gT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780623808; x=1781228608;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVAJucd+GVsBBf1FGgcJQ8cRedfncMhwEKsquMbLLdE=;
        b=PkqDZm/375aPLOdj0zuD5Ctqvb1FsYsyS7FXC1FQVRkOub6wB7TJ/EQ8boqWbWYeOS
         UhMGsm3R4ufXqOjf8egdjU8lfzwfnKd4fbcG9Hlm6UO3FIo+BIPFze/+sa+ZCsXD9bkb
         4H3/pDKySsyj9woEmL+iMmJuFv0znB+r7q2y3e4/fzDXELpG1pK9BvVquYQCw5oq71hH
         mmkjw/qcIjfwwUfBYDCWEOCXS5UND0TciB75K/0LNCw9dOw9dYHBfSbTzQYvaxURFowB
         s7KFYEOPanCyJMJL3K2A9npQ09a0IjIDLgOJEzeU4g45pLEFiUTWOF/x9i3+nZeM1W3e
         6WVw==
X-Forwarded-Encrypted: i=1; AFNElJ8/l7fLgHR2+foEmoimM7mO+WzrlnsrTjVLcKhanqNub41Ty2GA6NUmAoXtGL/XUpeyzJrRfAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGg7DgjyXHebP5rNR1+SUUNMQ163gFE+uAUbo8GbcOkU4i9qf+
	its+UhBSl7N44qAYC/p5MgyWKdIAjR9L/aUhLol9ZgTJHc+2t90zg+OTHXNLNK2bRoNF0Wg04y8
	k0hpgndc7/RPoP9a2lhSoTRcDmg==
X-Received: from pghl22.prod.google.com ([2002:a63:f316:0:b0:c82:7df9:8c21])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:a8b:b0:3b4:8ec9:514e with SMTP id adf61e73a8af0-3b4ccd77529mr1868150637.4.1780623807839;
 Thu, 04 Jun 2026 18:43:27 -0700 (PDT)
Date: Fri,  5 Jun 2026 10:43:17 +0900
In-Reply-To: <20260605014318.3890804-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605014318.3890804-1-yuyanghuang@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605014318.3890804-2-yuyanghuang@google.com>
Subject: [PATCH net-next v2 1/2] ipv4: igmp: annotate data-races around in_dev->mc_count
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295561-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yuyanghuang@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D87A644810

/proc/net/igmp walks the multicast list for IPv4 interfaces locklessly
under RCU and prints state->in_dev->mc_count. Concurrently, device
init/destruction and multicast join/leave paths update the count
under the RTNL lock. Fix this intentional lockless snapshot by
annotating the read with READ_ONCE() and the updates with WRITE_ONCE().

Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
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
2.54.0.1032.g2f8565e1d1-goog



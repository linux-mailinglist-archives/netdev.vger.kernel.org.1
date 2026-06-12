Return-Path: <netdev+bounces-298470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fudYGEWoK2olBgQAu9opvQ
	(envelope-from <netdev+bounces-298470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:33:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B89676EFB
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:33:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=XKN3QwU5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298470-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298470-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B59723198D46
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 06:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D253CFF72;
	Fri, 12 Jun 2026 06:32:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ADF3793BE
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 06:32:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781245956; cv=none; b=bkbG2v7qAwSrt7gQPBs/fnalt3nRD9eGWTn1cXeI2ZzqSusC1Z/yAWQ4DJRdJYPuamDNJcv6EiSOqInJQMSfuWgjgjy/n8vQhDEDSMicpSTXpwYM5l+OSMW+TFZnrTjUFEwtPZbnPVT7k0FjFOWbBXZsuWaidxSYK5R36vcB3xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781245956; c=relaxed/simple;
	bh=BgqNQ1TPERlMmI+Z+x27oQ6MX6wk7vMigKmMQ9Smz3s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n8N9pMvI1ELPzpCEaRKl5kFFKxpzShRYaFRdbMwQaH7vKhm4+ju9T4Pv2WrZv/NolMleVaMwb0eZdmP5116pTUQiXxS7vOl69p+u5la0Pe7W04h6E7LUgTiNA/MujwwG3ulM4DHPZmx8yq6z4FGf6exmyG3JKoxCxn617VzrOGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XKN3QwU5; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso16022895ad.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 23:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781245955; x=1781850755; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tsYoDx4sqvBz+DlOryLLiimpknJyHw2RjsPX8F21Tcw=;
        b=XKN3QwU5K9UXDFE7HYQvGnlKCZCXqctBQU1DKJWovF9PM6+z/FJkaMlLYotQ74U+vq
         QFdM+11IJshQe6umYdn0079jT0SY7rCwbWxriNyEe4KB0H3WJUXqrYxcZAzgkQbQyna7
         WDN7v4VTJWQmFo33goZfggKSNpQ1S2KKt2IpmzOsmh30Ug4l7SFSeNXYuIonlFadxrji
         AyI/q1DmjCTrLaS1+urahDmgg3xQHlrsC5Fq9S68n6wq1yWeGTqMkfE6+Z1uC2NMUth/
         /SIxPjRoZ42XOuX7qdyU+PKGpEZufNonevwe4MepDkcdwEDSzGh3ScWi3+iCbUCqshNE
         at6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781245955; x=1781850755;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tsYoDx4sqvBz+DlOryLLiimpknJyHw2RjsPX8F21Tcw=;
        b=MNa2UavfIQttLurxYiGAqDgufbB4OeqyUGPcnjyG25CUvmOECq/LcaAFx1dzj2w4Cg
         On1NqQOnjlkqPmcbWgyJQa3xgPqyb3H7/g4bg0k8ZdkInXv/E82NE3S3w0bdjhvoKT5h
         JxCFRt8hUz81XzMnd4ANWZAl8n1T9mkgFsrueUhhYglI5fwtv9OFYEzKcPXYt+GscK8F
         Pduar4R7ysZDHqbm32V+BSrm07EPHZhiAgAkYApbLbYJiEoVKIQrHwYZbF3SbV47dFIG
         pvSms1SQbjieGPKEEoXvoD+Qw5mINoWQd0kNfxW350k9V2E+uH8M+yd6/SMONv87/7Bh
         vpCA==
X-Forwarded-Encrypted: i=1; AFNElJ/BA7C3V0GRJMirtgfx4UBUEs5qrzSOH/8zGaLL+Af6hYZZ0xIdWd4xVS8Zl0DWA80G2Zw9LK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySeE6HJIM1Pyeh5iEKzMxatXKxCYShHSOyBGbSRcq5TdVrMWZk
	5pjNVF+MSQEEX8XikENt21jmxiD03wN9XmWjLiW64Re4kZsL33weYOTY7R67Om66YPiguH5AvNa
	g/i94Pg==
X-Received: from plcx2.prod.google.com ([2002:a17:903:c2:b0:2c1:13e7:a57d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22cc:b0:2ba:4e84:966
 with SMTP id d9443c01a7336-2c4134ebeb4mr19089355ad.36.1781245954406; Thu, 11
 Jun 2026 23:32:34 -0700 (PDT)
Date: Fri, 12 Jun 2026 06:32:07 +0000
In-Reply-To: <20260612063225.455191-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612063225.455191-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612063225.455191-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 4/5] ipv4: fib: Avoid calling fib_trie_table() in
 fib_new_table() for dying net.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298470-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C7B89676EFB

We will call ip_fib_net_exit() from ->exit_rtnl().

All fib_table will be destroyed before devices are unregistered.

During device unregistration, inetdev_destroy() could call
fib_del_ifaddr(), which calls fib_magic(RTM_DELROUTE).

fib_magic() calls fib_new_table(), but we do not want to create
a new table after ip_fib_net_exit() destroys all tables.

As a prep, let's add check_net() before fib_trie_table() in
fib_new_table().

fib_trie_table() is also called from fib_trie_unmerge(), but
fib_get_table() fails first in fib_unmerge(), so the same
problem does not occur there.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/fib_frontend.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index c3e3b5633fd0..d147471d1d8e 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -88,7 +88,8 @@ struct fib_table *fib_new_table(struct net *net, u32 id)
 	if (id == RT_TABLE_LOCAL && !net->ipv4.fib_has_custom_rules)
 		alias = fib_new_table(net, RT_TABLE_MAIN);
 
-	tb = fib_trie_table(id, alias);
+	if (check_net(net))
+		tb = fib_trie_table(id, alias);
 	if (!tb)
 		return NULL;
 
-- 
2.54.0.1136.gdb2ca164c4-goog



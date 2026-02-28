Return-Path: <netdev+bounces-262245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DFGH39qo2mACgUAu9opvQ
	(envelope-from <netdev+bounces-262245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:21:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB831C9764
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 226F930D7EC2
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D5B3D4133;
	Sat, 28 Feb 2026 22:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1qbuL4Ot"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E853D5228
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 22:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772317104; cv=none; b=fm5+axTKcBXVLtnCbtDD7DbHUh4kTD5KZRtxCwGL6jWRb+tZimcBDQD/UO4BnQ5XpkdNjhvnTdUSpn1jteNaEPeoKqoGCcPOCHBkOeD2om5FpClTujOQ+3CjuckHzv1SafibMpXlOVUzLJ8JeMJIKhlcqrpWeyZBBmd0ylgh+ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772317104; c=relaxed/simple;
	bh=F1AqhiFk2hvCBjbauM3QJlHyMI/ka8eAS+LcXarMIns=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X3XAZn76XZRI5xxXjXJM65835Jn4y/jHqP4LdJDzl7JRv9zZxBIVtglEWjGoSZbcLVMST6iESzXvvHO9uRQPnm/F8mM4BILiC4fXoH7YH31e5L0GtKQ4ExZ3M7QYoiwBf1UAToIxHfvvOmWWCzsbhawKF6WccgVfrjGhehPEq1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1qbuL4Ot; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c70fc78a985so1593803a12.1
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 14:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772317103; x=1772921903; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I+loREDJUVOlOdzqw9ue3ts99NkF53NAzJmwhR28zPs=;
        b=1qbuL4OtpFrt8HDxcfg3eFwkQ2ixjH8kesf0asR6G3yRmFlNvfSvT+5lAGdTZG86oi
         xFNF32kjQhebxvJuXxuhc4r73mTBnhX5XBArvNuCwNglJF996zyv915MUHsKFWDltzG0
         cPTt5jssc03RHdAbi3H30GF/BQihinFdMLB/A3tBrKUix+3SFhpqeQPwzi9uz3cv+qtr
         7q8E6tJaXHVWSBabb89KymdWrlUtXOE+/ELsUpxeOYE8X8SxHvRrO8C8b1jfBOQtcH6Y
         1f/wz/lBdP3V8VGbLujF0hjCHr0UbV6KJAB/h9khCEGVx6cU1gFIx/W5QTx+4ic+P0MN
         zkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772317103; x=1772921903;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+loREDJUVOlOdzqw9ue3ts99NkF53NAzJmwhR28zPs=;
        b=nBGumHufOmdTDOBp+0F5ljz/rRj4Z/N4SgTPc1XF3LQ/TWoJ63TSpXYTHOfX+le5SW
         azKhr4tpKOxdaYcbuE/ow5TvCAjfLY1lHdLfEEW1N1MRwHpOqfI0BIp1DNQjTWwUzB1Z
         XhWA1NfPy7sHDoyGQoU+00qarDdd4AUU/w7KB53kF/TXOfGfVW5EFTV8OyLFzYHJu5E4
         h+PopC6diGz5n1U3viKEqwZ5FIWeBUikxcqQtWlZSzBiAf4KwSrEVrCmGZxYDaEM1Iln
         oGpGPyIC6YtwxIpIcYykL0EmdCipKyr94hUHv7oGgIrWJAn1lSHiE67mnizu2r/K2Olk
         kemg==
X-Forwarded-Encrypted: i=1; AJvYcCWS3WYTic83yo0Xqh3CKlCGsMXBNDUSZDcA9DruXU5dEJ8xlhDn+eWwTAe/SKw2M3NOHZINHeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YymNJzDrKCnS9DJF8je0P7t8L1YXt+5g4RhTaSv38jouDzG0+Iy
	+vsmMpf9gM4MIuNbCvCIg3tPXrGWTM5O3w1nIE/+m26skU9xV6u0xqacugaVmitvO3sQMHTxfEt
	WR//CVA==
X-Received: from pjbbo12.prod.google.com ([2002:a17:90b:90c:b0:359:84ce:a75a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d12:b0:341:8bda:d0ae
 with SMTP id 98e67ed59e1d1-35965c9d197mr5554274a91.20.1772317103067; Sat, 28
 Feb 2026 14:18:23 -0800 (PST)
Date: Sat, 28 Feb 2026 22:17:30 +0000
In-Reply-To: <20260228221800.1082070-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228221800.1082070-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228221800.1082070-13-kuniyu@google.com>
Subject: [PATCH v3 net-next 12/15] ipmr: Define net->ipv4.{ipmr_notifier_ops,ipmr_seq}
 under CONFIG_IP_MROUTE.
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
	TAGGED_FROM(0.00)[bounces-262245-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: ECB831C9764
X-Rspamd-Action: no action

net->ipv4.ipmr_notifier_ops and net->ipv4.ipmr_seq are used
only in net/ipv4/ipmr.c.

Let's move these definitions under CONFIG_IP_MROUTE.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/netns/ipv4.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 8e971c7bf164..380ff34c0233 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -279,6 +279,8 @@ struct netns_ipv4 {
 	struct list_head	mr_tables;
 	struct fib_rules_ops	*mr_rules_ops;
 #endif
+	struct fib_notifier_ops	*ipmr_notifier_ops;
+	unsigned int		ipmr_seq;	/* protected by rtnl_mutex */
 #endif
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
 	struct sysctl_fib_multipath_hash_seed sysctl_fib_multipath_hash_seed;
@@ -290,9 +292,6 @@ struct netns_ipv4 {
 	struct fib_notifier_ops	*notifier_ops;
 	unsigned int	fib_seq;	/* writes protected by rtnl_mutex */
 
-	struct fib_notifier_ops	*ipmr_notifier_ops;
-	unsigned int	ipmr_seq;	/* protected by rtnl_mutex */
-
 	atomic_t	rt_genid;
 	siphash_key_t	ip_id_key;
 	struct hlist_head	*inet_addr_lst;
-- 
2.53.0.473.g4a7958ca14-goog



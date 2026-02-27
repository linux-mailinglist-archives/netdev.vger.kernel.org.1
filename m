Return-Path: <netdev+bounces-261700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Nm/KR8SoWlwqAQAu9opvQ
	(envelope-from <netdev+bounces-261700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:40:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5B91B2527
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A07430D5B26
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090223328EA;
	Fri, 27 Feb 2026 03:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O7N9RuTf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55AA3328F8
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 03:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163553; cv=none; b=XhawDEHzkG2Te/mymF8rBk6He3Lc3gYZMpEqWGK7wdLN+TPPm7cT5gxsp4QC2zNHQlie+wd/qI0AHu/fxzywgQr+LjN1vyEsW10ZpOwWOGGObLF7COzRz9FG1LVSOi4qPgY6+5Jy6VB/HHqIi4tRPeNpfnqZ6H+AuakgfJYt88k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163553; c=relaxed/simple;
	bh=Y5OEjKlowxOQWgtDZCbE9HBZNX06jq9JGWhnlo032EI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h5B7u/td0hSYto+XUgG3ubRQAT5okGH7l4O8gO4aLcIt7SMIsfuDGH5G1kcLlPIuAk9KRB0OVtPXBg2fmD9QCxOa5j55U4H+3JIxH/KjNqhkK9PKnRMLCye/4tTla54Yi8YbAtxW37HOhVgbYgRjp3hpEbVoQ2TxE6+7twU0U+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O7N9RuTf; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-358f4ed4eceso1525236a91.2
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 19:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772163552; x=1772768352; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6IaUVVQy0TnvLj+z0wnrvwrT1En/1Q4yiXWv4Lkj7KA=;
        b=O7N9RuTfgbJ0J9VWTJYvWi70x4DXeGqiX2SMr4ayTy4eez2mxnlzLNylUQzqnDNt32
         J2a62cl8lFZBeK9mW82qV2abRzIRNoUCyjki5+XVTGGS4bI//0y3RHL8cFTwdDtZ8dLc
         hLwbvBrCNPuPUVUfMQhSBpdIEk5J/X7xq+xitkjhd0QLr/e0fwga32dbOmWAlUlIIPJ/
         LkO8ihNs7isMQ3bIdNoEAtGwLv3jFbg4p4riYqucaCFOrFJsUqjKLJPcwKb8IdDZGJ7j
         cVtSCrGzUQC1GBbe9HoOhiVbUsOoz6e8p4Z41+4653MR6Q1/I/6MN+HLFEqsEbyMYpga
         IUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772163552; x=1772768352;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6IaUVVQy0TnvLj+z0wnrvwrT1En/1Q4yiXWv4Lkj7KA=;
        b=r/MAktHhnYMQEIa/ROTUMzEMFhkU5dZ/uD+GCoBErv5clB5WLyL1XEHtHvRHHZHBBw
         0GhZ1Yx16Ga9nKTxDInMOpscuQPmTegh0dMOFgms6AD76rSLRkcOqrhOk2aBneyGsxNR
         eXo4G/PTkSY0vL/D3vKiiJCKx2YQlfbg6YX2lkVTmOfaP52QZ6ViMqyx/oycatC9J5tK
         AU49/2xVJ/FnQpsBQNTpcja3HRbmEyDjBdrGVCqn51jrK9eziLrZqArezaNaJLOykx6K
         m28j2smrfNLhmM/acX7y83te5zsUqrLDjSDTVdr7XQn9fyMeEEwvj2R+G/V3zld4bqGb
         pf2w==
X-Forwarded-Encrypted: i=1; AJvYcCWgSXaolLXO9P6/XibUGTe+CxgWlL0Kx4HRRXTgOIhyn9bXQ7hhNbhal47cP2R1oPP9YfvYf3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZxs9Iv4f2/74+c+UVYHcIRFVMkImEH3THusN+rtcUiY+47Keq
	TWzy1LlZRAH9FsAd2UPJU0YytmcNUTBxfyLq8S6Fi6Hz5EH/0CVXxrFbFTcTItcKJ0GASSnRgBV
	uvFSGyg==
X-Received: from pjpq11.prod.google.com ([2002:a17:90a:a00b:b0:354:c2ef:2674])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ecd:b0:356:1edc:b68
 with SMTP id 98e67ed59e1d1-35965c4e55cmr1296983a91.12.1772163551982; Thu, 26
 Feb 2026 19:39:11 -0800 (PST)
Date: Fri, 27 Feb 2026 03:38:27 +0000
In-Reply-To: <20260227033903.3307272-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227033903.3307272-5-kuniyu@google.com>
Subject: [PATCH v2 net-next 04/15] ipmr: Use MAXVIFS in mroute_msgsize().
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
	TAGGED_FROM(0.00)[bounces-261700-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B5B91B2527
X-Rspamd-Action: no action

mroute_msgsize() calculates skb size needed for ipmr_fill_mroute().

The size differs based on mrt->maxvif.

We will drop RTNL for ipmr_rtm_getroute() and mrt->maxvif may
change under RCU.

To avoid -EMSGSIZE, let's calculate the size with the maximum
value of mrt->maxvif, MAXVIFS.

struct rtnexthop is 8 bytes and MAXVIFS is 32, so the maximum delta
is 256 bytes, which is small enough.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/ipmr.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 290180f3fbf7..37c915568a52 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2510,7 +2510,7 @@ static int _ipmr_fill_mroute(struct mr_table *mrt, struct sk_buff *skb,
 				cmd, flags);
 }
 
-static size_t mroute_msgsize(bool unresolved, int maxvif)
+static size_t mroute_msgsize(bool unresolved)
 {
 	size_t len =
 		NLMSG_ALIGN(sizeof(struct rtmsg))
@@ -2523,7 +2523,7 @@ static size_t mroute_msgsize(bool unresolved, int maxvif)
 		len = len
 		      + nla_total_size(4)	/* RTA_IIF */
 		      + nla_total_size(0)	/* RTA_MULTIPATH */
-		      + maxvif * NLA_ALIGN(sizeof(struct rtnexthop))
+		      + MAXVIFS * NLA_ALIGN(sizeof(struct rtnexthop))
 						/* RTA_MFC_STATS */
 		      + nla_total_size_64bit(sizeof(struct rta_mfc_stats))
 		;
@@ -2538,8 +2538,7 @@ static void mroute_netlink_event(struct mr_table *mrt, struct mfc_cache *mfc,
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
 
-	skb = nlmsg_new(mroute_msgsize(mfc->_c.mfc_parent >= MAXVIFS,
-				       mrt->maxvif),
+	skb = nlmsg_new(mroute_msgsize(mfc->_c.mfc_parent >= MAXVIFS),
 			GFP_ATOMIC);
 	if (!skb)
 		goto errout;
@@ -2711,7 +2710,7 @@ static int ipmr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		goto errout_free;
 	}
 
-	skb = nlmsg_new(mroute_msgsize(false, mrt->maxvif), GFP_KERNEL);
+	skb = nlmsg_new(mroute_msgsize(false), GFP_KERNEL);
 	if (!skb) {
 		err = -ENOBUFS;
 		goto errout_free;
-- 
2.53.0.473.g4a7958ca14-goog



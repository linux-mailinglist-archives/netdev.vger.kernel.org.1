Return-Path: <netdev+bounces-279150-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LIpDw1C4WmaqgAAu9opvQ
	(envelope-from <netdev+bounces-279150-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:09:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5E64147A8
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B98230DEE25
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914363EDAAA;
	Thu, 16 Apr 2026 20:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N2worae9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3217D3EDAA2
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369822; cv=none; b=j39UOIY2Q26XqnxWr2BTf5deQ4KRn2e9b5G225veeljxtNb5fl2SrdSAApyPEmErDN28RL1unCFoIbQ5BRy7LsIBu6I3WU75S08Jci81Yed4YM7ApUFf1mlqxxWnBbNItmr1cGx3jmQrDDXQ/e4eBZEHwUlXlXuIvYNyUUWf/+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369822; c=relaxed/simple;
	bh=qY8HkWtP8tWPzrAonGqOBbu4o0gnoM0kRBXIfv6d1qA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bFoBVG7L9EWixx0jhqMZShFW2BNbb0HQy8m0a0iNqRlsO5f7AuuKXWebtQgziHeums1bxw01ytoscPphKJrH2OALU7kA936/awoeiUBiLMBWyNmY/Drqb/RtSAjtekAs+x7apcUW+/LEt7hiTxEUzTms7wJzKP+i9bh2N5hh+AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N2worae9; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50b4661881eso41185711cf.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776369816; x=1776974616; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wdFbUlju5PJVTlC8Kj7WdWGlKy+SiuySC2V9ecBtjTc=;
        b=N2worae9ShtBxjUP7F1TzDDMB4yzY1PNkgpxNZDg2+km06IpSIToGvMQubjcZHs6Uj
         s4kUeEFTkz234vwUXs6x/eO0H4vU1QTy6QKcrYGCVfoJeNk9/zMAOjWjeudOnudA8jvo
         7wcZm5pQVZIxpm603soItMJDRMlyRAv4mOwLfkKN/90yEoC3IoKxdniPqwy1vxEaVQCV
         JvrA6yaHqBT/uMnGsiXBPuFjEYMmJS4yYPwRI1OxTcDuSW1iVNilhctl6GH/0pejtw17
         nQvRz4jib+hUnmrZaUxyT59+mWEWkw8/f97I6ZgQCjYUosb6dl3ehroHcW0nijTUESUR
         RLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776369816; x=1776974616;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wdFbUlju5PJVTlC8Kj7WdWGlKy+SiuySC2V9ecBtjTc=;
        b=C+UD7Bflvt8BxW4gabqQPTgfwnbnp1nnKaCOzNZ0dcIC23OMJAu2fSPb/Ed9174c0y
         znA7fCabRDrXht0DpyZBNBQg6H3VPywO3rnIE3b0PAN/cABQpfji8Y1XJLaaQjhkiYyS
         K/1QpOvs08aDRBpYdW9HY8bqrmyJB7cg0FXV/GfvBNcfuz5p1vUQqHKwtlEOa83DozOI
         Qd9lU5XmrAFQeN3H4/mc2sLY/cp4IO+wDqfbeODimIE48JyfxJIywku+PuShaET0hJrg
         gsWq2CyisZYm4tEqsW03rZmVMJ2KPQ+12Nhm5aRM/hRbKRCtcwFNakUVlof2iFmQxpNU
         NP4w==
X-Forwarded-Encrypted: i=1; AFNElJ9KYSzmsgtnnuFRyVNTyb/rlxVSaDEtDkOKh6hDjc7n11MepSTRdq4/F+eVdbqz35CUq/FyvMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsXccoIV0bwLEolHZ50XIgObEVTf4lfLJ3PWCri+M7g0EfK8Xb
	WL+mDuahF83YanGmjERByLrdvayj+wtl54/eQh7KxfoCV5D3yLWFZpRuf4qsJZT4HTcNxeEYAh8
	jVKyzfAiTP+rMLA==
X-Received: from qtxi11.prod.google.com ([2002:ac8:5e4b:0:b0:50d:6642:db29])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4287:b0:50d:a8f5:1c02 with SMTP id d75a77b69052e-50e34a16658mr9154891cf.41.1776369815450;
 Thu, 16 Apr 2026 13:03:35 -0700 (PDT)
Date: Thu, 16 Apr 2026 20:03:14 +0000
In-Reply-To: <20260416200319.3608680-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260416200319.3608680-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260416200319.3608680-10-edumazet@google.com>
Subject: [PATCH net 09/14] tcp: annotate data-races around tp->dsack_dups
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279150-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC5E64147A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tcp_get_timestamping_opt_stats() intentionally runs lockless, we must
add READ_ONCE() and WRITE_ONCE() annotations to keep KCSAN happy.

Fixes: 7e10b6554ff2 ("tcp: add dsack blocks received stats")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c       | 2 +-
 net/ipv4/tcp_input.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8c84639dc54bb8d8aa6f3eeb2b7c1fea16ebfcb5..57c4dcc8bfe948e895f713cadaad20409a9b8f14 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4465,7 +4465,7 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
 			  TCP_NLA_PAD);
 	nla_put_u64_64bit(stats, TCP_NLA_BYTES_RETRANS,
 			  READ_ONCE(tp->bytes_retrans), TCP_NLA_PAD);
-	nla_put_u32(stats, TCP_NLA_DSACK_DUPS, tp->dsack_dups);
+	nla_put_u32(stats, TCP_NLA_DSACK_DUPS, READ_ONCE(tp->dsack_dups));
 	nla_put_u32(stats, TCP_NLA_REORD_SEEN, tp->reord_seen);
 	nla_put_u32(stats, TCP_NLA_SRTT, tp->srtt_us >> 3);
 	nla_put_u16(stats, TCP_NLA_TIMEOUT_REHASH, tp->timeout_rehash);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index edb5013873e0c4a9ba2f8a81a43eff5fb6e7a47b..65b3ecc6be4b57f97a62d0e5737a96ddb16dd14d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1246,7 +1246,7 @@ static u32 tcp_dsack_seen(struct tcp_sock *tp, u32 start_seq,
 	else if (tp->tlp_high_seq && tp->tlp_high_seq == end_seq)
 		state->flag |= FLAG_DSACK_TLP;
 
-	tp->dsack_dups += dup_segs;
+	WRITE_ONCE(tp->dsack_dups, tp->dsack_dups + dup_segs);
 	/* Skip the DSACK if dup segs weren't retransmitted by sender */
 	if (tp->dsack_dups > tp->total_retrans)
 		return 0;
-- 
2.54.0.rc1.513.gad8abe7a5a-goog



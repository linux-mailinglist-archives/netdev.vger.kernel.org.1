Return-Path: <netdev+bounces-279151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMUWMQlC4WmaqgAAu9opvQ
	(envelope-from <netdev+bounces-279151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:09:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 336A8414799
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E52A30BFDA5
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F5638C400;
	Thu, 16 Apr 2026 20:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z6/myJhj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A0B34B1B4
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 20:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369822; cv=none; b=gEihcEww01BdKWc8zi8Ac2pldg8WY4BBj365IAUJQJrmT98C7eM7N+cwT5FTVmIvT5HHsKNUn5nocRrB5mDLeDZiDZrbVpGxIL34lyIKz7hUo9GK6RbJJVa9lj8ZCCScy+ve4EOfZwX5Qah+xykuxNdkRkwA5gE9EXHMq7rOnRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369822; c=relaxed/simple;
	bh=tcBDLZDz/jJ3rNjcbJoLq378+bS/oyRDX/5C8epBmDk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l2pAb67dBKdJa8bl6wC+PwusNJ7tW0mXgDmz9KEYW7R+4mPP4QjSJDd5rlPeZMp0Tl6kQlks7D7Ac24X6IzYHbBRSgd69Vh1leYLrLQyK+DkCvQyy+zNcR/1VposASvJcgqEYLx8s5hqFmv99ThMa3DVba0Qh89dlXmxEGMCRg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z6/myJhj; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50b31cff27fso44404981cf.3
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 13:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776369814; x=1776974614; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YujhcABrMa8DOVlTldRHe2QbFeXpp02Lv4hICUzYcMs=;
        b=Z6/myJhj2w1ufbf6uFaqmLfPYn5N0lXF+OiMnDAJDtX+eoh76CRxDGZSMtlNMdtnH9
         MS/Be8MICma6EhMhf7/oV/VIKKStorA7yDgRHSJeaEwU5cU05a/Uf6Phe424Z66lLkd1
         Ta8dHT+osN+0JE9miicEgmFaKEqTuH8bLAxNAnjv8YpLdWQZ0Q/gt122bJpVaOn24bcN
         yvh9UJblShnpcgCtWU2cFNbNtshfmflL9mrRnHc37o6VkbC+cCreZ0lxj9AI2Jy7OTM0
         wNm2dDEL5a3zq+0Xnb4pmsbQmhFSEndVjDuQ00O3y0PH8qJjH90q6+GEvK0ZYS5wqowo
         /Ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776369814; x=1776974614;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YujhcABrMa8DOVlTldRHe2QbFeXpp02Lv4hICUzYcMs=;
        b=HSZ+eoDzdqq611NNZnpgQxzthTj7vCMMThdQl6rfH6WSHZ8QE9+CoTvYOXLwPGxi0H
         ghmUDQ4mtgkK9qSIjigKoDmssN953Tfym2oF3ynBtvzTwsSUVF8hQ2Jg52tn1yxGK9w5
         jrifSnt6HG83Xt7NhI9+w1veVoOILkpunhoLJWuKN5ISJksdIvjUzw0f8bwPnv63YAf/
         y4GTYsudCeVh7n9gmQKdGWnYWU9DOjWr1yYlyOafyaHwBj0T389YTUjAmuS4neRpNbAp
         1wcTs49gaF1l2VKaHenDoLG4uNAPpKi2cyqR0LOWZpRNvNinynrSJabn4SKkH9a6byq7
         M2TQ==
X-Forwarded-Encrypted: i=1; AFNElJ9RuWoLwbPHNOJnfNLCHB+8Zioe1o8UOUW5ylWENhniqkJw7Drrl+cHx8Ap9eUpLmR8ZeZgjn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNXjpM+OXhhPHvk4zK5F69DdT3CETREgL7fW/qUFbzw7tTlkgO
	eMM1YW4L3LXYOEYyqebz28U1hRFblFp/7fdNWyMNIQRnUgMSSJAL4Az4EHkLMsu1n3v3289uUaO
	6Znc65cR8BqY9Mw==
X-Received: from qtbih7.prod.google.com ([2002:a05:622a:6a87:b0:50b:b3f4:b4ce])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2c4:b0:50d:69cb:d603 with SMTP id d75a77b69052e-50e34a262e0mr9594511cf.47.1776369814072;
 Thu, 16 Apr 2026 13:03:34 -0700 (PDT)
Date: Thu, 16 Apr 2026 20:03:13 +0000
In-Reply-To: <20260416200319.3608680-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260416200319.3608680-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260416200319.3608680-9-edumazet@google.com>
Subject: [PATCH net 08/14] tcp: annotate data-races around tp->bytes_retrans
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279151-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 336A8414799
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tcp_get_timestamping_opt_stats() intentionally runs lockless, we must
add READ_ONCE() and WRITE_ONCE() annotations to keep KCSAN happy.

Fixes: fb31c9b9f6c8 ("tcp: add data bytes retransmitted stats")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c        | 4 ++--
 net/ipv4/tcp_output.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f999b86851cdcc2a9b9ce379397e55293871c00a..8c84639dc54bb8d8aa6f3eeb2b7c1fea16ebfcb5 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4463,8 +4463,8 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
 
 	nla_put_u64_64bit(stats, TCP_NLA_BYTES_SENT, READ_ONCE(tp->bytes_sent),
 			  TCP_NLA_PAD);
-	nla_put_u64_64bit(stats, TCP_NLA_BYTES_RETRANS, tp->bytes_retrans,
-			  TCP_NLA_PAD);
+	nla_put_u64_64bit(stats, TCP_NLA_BYTES_RETRANS,
+			  READ_ONCE(tp->bytes_retrans), TCP_NLA_PAD);
 	nla_put_u32(stats, TCP_NLA_DSACK_DUPS, tp->dsack_dups);
 	nla_put_u32(stats, TCP_NLA_REORD_SEEN, tp->reord_seen);
 	nla_put_u32(stats, TCP_NLA_SRTT, tp->srtt_us >> 3);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 87af4731df87ea5f310d39b1392cb995d4fa8f78..f9d8755705f762fe4da3064d2b1bfce4828ec0c1 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3645,7 +3645,7 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 	if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)
 		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPSYNRETRANS);
 	WRITE_ONCE(tp->total_retrans, tp->total_retrans + segs);
-	tp->bytes_retrans += skb->len;
+	WRITE_ONCE(tp->bytes_retrans, tp->bytes_retrans + skb->len);
 
 	/* make sure skb->data is aligned on arches that require it
 	 * and check if ack-trimming & collapsing extended the headroom
-- 
2.54.0.rc1.513.gad8abe7a5a-goog



Return-Path: <netdev+bounces-279152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +H3XBzlC4WmaqgAAu9opvQ
	(envelope-from <netdev+bounces-279152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:10:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FCC4147B7
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A052D3168AEF
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B914A36EAB2;
	Thu, 16 Apr 2026 20:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="izfOEg3+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C913EDAA6
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 20:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369822; cv=none; b=IHB/N7QFiclG5+BxtbFeXU4+CNNRdgSp6rQV2Gz2ECulY/+EmW17ctrd9XeYaXKwqnxlkhV0ItPcxF/Ax6Mgj551ECd72Q2UvvRWobsyQ11wtt7CzCuK4jZ6g4E6HBHdBvQ7uJM2VnRK5h/LFSUiyftdCTzbcpalUcyxtGOf9ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369822; c=relaxed/simple;
	bh=XPmAGSEeZUh1EjLYLnMeAuukfbPF+q6AYmVVF1F71J4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nzL4m2hD6OJKQnD9jFoc4Qy1z3wTldzPomOQIFrHrz8kqbTpS702lDGJw3K1G8a/eBWYn+pLkeawm/Y+/7gY4EPSKCveVULJv0NCcmLvYcvtOrvo/W/NlTTwHPHbkve8n+qv+AawLpCYcrdDy7P7Lbh4ORNNEAo1Wke4HEzberY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=izfOEg3+; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50b44f7b7bbso207158241cf.3
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 13:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776369813; x=1776974613; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sC/+P+6taySYYe69fekd8CwtYmWxhDMPMtkyGyQKF3s=;
        b=izfOEg3+tSWJO/iclIJ+pvs+EGYpmebj4oAoVlgUTshpPf5pwM6o3061DnkWQ6e+dZ
         FgF7oSTTDDXz0NHzYxnV5dGXSVh2bW/HB1Hq6/Wd1lIq/eLP3b9gqjB0ROE/TWTRrrkF
         2i/QjZOOohJJ6NwQA+PMa1w8DcnyGPHD9aYQqogTy99CGuXeppMJaW6AFJzs1D1aJ95d
         rREixRCY29iKCV6xE2xhw2904tD8o1UrUXlaJoJg7Cs0yO27LOeED6g4LtqZESUgV68d
         HNITULXjr4W+AnfieurkPyNed0JJY9qn3pzNZXwNvUhnBiP8ocOvFY+BxWlu9T9daPMp
         t0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776369813; x=1776974613;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sC/+P+6taySYYe69fekd8CwtYmWxhDMPMtkyGyQKF3s=;
        b=cUVuGiPDEdS7Ix9a8cdNmT0AiyJwupbpV1X4JdW2iV5M8VRHyZKT2Qvy1TdhYNqMS4
         jl70AIcIl3e2LQ18Pg8SWPmLEZ+aintA9PQU8cZvSxqnyPlDgjNjiGN3ZqOVMpJeDYRv
         qXcAC2u+EZBuyS5ffl48x/dflBgyO3ElLq0kWr8fNCc0yEA3RBJSpPxCeBkLd96JpSv/
         Bamul1vjS1d55gu+La/u+dnH8iM85fKfiYQ6QMzFyaihqcqHxnKl/zoYUVeIY9GdXFe+
         MB3B95t/iFjcn8aLbdQFKKqMgiNBSP+1wusxGWSsO+yrPl9lVFXpneZma/EBl0ZooEI2
         f6Dw==
X-Forwarded-Encrypted: i=1; AFNElJ9jG+VfGkZyWxpeKB2AhcaOsUddQgmXiXagFKKp7Pr7/TMJPN3er7ezPqG/Z3wMpJWQhsHRjsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL0bzrN684yJ9GYgzGnhzMH8V0SQqXNZYhJIsi8OUzXKwvX2qD
	f1+h313JzOI59m+pgSF7ZBfXDpOUPzIDRVSCF8wWg9ywP/in11lVGqEebm7xsX0+hDed75k/eFM
	47aJRktmp8rWlDw==
X-Received: from qtbne27.prod.google.com ([2002:a05:622a:831b:b0:50b:b811:abb5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:a13:b0:50d:db76:55cd with SMTP id d75a77b69052e-50e34a815d9mr8301311cf.52.1776369812691;
 Thu, 16 Apr 2026 13:03:32 -0700 (PDT)
Date: Thu, 16 Apr 2026 20:03:12 +0000
In-Reply-To: <20260416200319.3608680-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260416200319.3608680-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260416200319.3608680-8-edumazet@google.com>
Subject: [PATCH net 07/14] tcp: annotate data-races around tp->bytes_sent
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
	TAGGED_FROM(0.00)[bounces-279152-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: B4FCC4147B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tcp_get_timestamping_opt_stats() intentionally runs lockless, we must
add READ_ONCE() and WRITE_ONCE() annotations to keep KCSAN happy.

Fixes: ba113c3aa79a ("tcp: add data bytes sent stats")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c        | 2 +-
 net/ipv4/tcp_output.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 729936d13a5c6d9c39edc880636e01cf0973688e..f999b86851cdcc2a9b9ce379397e55293871c00a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4461,7 +4461,7 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
 			  READ_ONCE(tp->write_seq) - READ_ONCE(tp->snd_una)));
 	nla_put_u8(stats, TCP_NLA_CA_STATE, inet_csk(sk)->icsk_ca_state);
 
-	nla_put_u64_64bit(stats, TCP_NLA_BYTES_SENT, tp->bytes_sent,
+	nla_put_u64_64bit(stats, TCP_NLA_BYTES_SENT, READ_ONCE(tp->bytes_sent),
 			  TCP_NLA_PAD);
 	nla_put_u64_64bit(stats, TCP_NLA_BYTES_RETRANS, tp->bytes_retrans,
 			  TCP_NLA_PAD);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 9f83c7e4acabc64f0a45e4879c326694a306b368..87af4731df87ea5f310d39b1392cb995d4fa8f78 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1690,7 +1690,8 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 		tcp_event_data_sent(tp, sk);
 		WRITE_ONCE(tp->data_segs_out,
 			   tp->data_segs_out + tcp_skb_pcount(skb));
-		tp->bytes_sent += skb->len - tcp_header_size;
+		WRITE_ONCE(tp->bytes_sent,
+			   tp->bytes_sent + skb->len - tcp_header_size);
 	}
 
 	if (after(tcb->end_seq, tp->snd_nxt) || tcb->seq == tcb->end_seq)
-- 
2.54.0.rc1.513.gad8abe7a5a-goog



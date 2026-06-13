Return-Path: <netdev+bounces-298925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iRE6CPETLWprbAQAu9opvQ
	(envelope-from <netdev+bounces-298925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 10:25:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FB667E20D
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 10:25:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Y6fdZcCU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298925-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298925-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D707230CC10A
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 08:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB17A3D6664;
	Sat, 13 Jun 2026 08:25:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883813D5C15
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 08:24:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781339105; cv=none; b=JtAUZX+o8HkIOc1zxA5MUgcOQstvid7pKNwXRgh07Iv7Dld3I5Sr1buKFxrMM5H4ii4E9/RJsBxLMsomRWzagJym2pqXxugfq9i274mP1onXGt8ef1tydU6AuUZv8082RyPz9HaXXeisNuaMPnJ7yfQm7jCamIJFpeFzXo28zFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781339105; c=relaxed/simple;
	bh=uNZREjdTngEAW+wmgiqIS/P1uka5G/KGrFlcH/PgfwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qNGuE66vKp7krk8CwFnxBYA0Zfb1Phno9cjCYYQCFWSzRgkw/9EtDjV1qoPv3y+nAbuwBAHQl6HS+Pt8k++RaZz51JshACUE4pEwar24bLQcK4J5srxtvMjdzqDnP9/JOSfMQXaCn7vQfX8nfpR4v3KBw5yUe0wBUGth9e8O510=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6fdZcCU; arc=none smtp.client-ip=209.85.216.51
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36b903567fdso2114467a91.1
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 01:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781339096; x=1781943896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SAVQv8WjEXijxzfisDbV6w9rhix2ecFSLNzXIn6EOaY=;
        b=Y6fdZcCUBd/J8Sl7J/ue523hT9ZrKEo6h0wdQJl+zQ53csFyWAWbJv4wZOvIHPZI+/
         T17ePuWoX2W9ApWIjpoldzrrbioO7wxxy5jdRCzvZ7+Zb0ugwDaRw2QLVsuBMHPNoptT
         jbDjFnLYMgP0uYxOAvffzlIDK2ZYshVYQ3KZO0w7o8WwnhQzyzuTajTRINd3KtidoePB
         DcgKleCQ4/9kX+jek33taf823iN40yezN4ttsr/8McvGFwMC4nCUFBOcPh41OiUV0Hzy
         YtglMYhSGjcYkLf9BcPOVWOevO92Do6CAhm/XAmrl5Ajwcx9HKiXyhjDU4wZZBgOGdJd
         Vt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781339096; x=1781943896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAVQv8WjEXijxzfisDbV6w9rhix2ecFSLNzXIn6EOaY=;
        b=hYbcg1EEiJtlcnIzPHGhMenEjhWEYFYo6rYFaejTprQpiloNLIBcp0FuzgQmR0N9JS
         itO1Xl9DW8Djcdd1CoIQ/qDejjYA+2eNNtX34/fHighQ4WunVJ78S7uXvGSKw9HMV3Io
         BqlYmEmVLNxoR7vrBazy64KmJuy0AONG6GmUgzroTf/tKo8cKoE71x2sNXNXZyG0uRlF
         gEN+r8GpSoPzZ9fPnFbZOv609VhJIlLsVZFqbduSf/EG/g/MsKwwFgTP0BstXvvdNyNc
         xMdxEpiL6oMgNOWRLZmmnpYJHf+mJZnUCq6w/Ww8fqxRuMi4VlX4IXXT1Y5yLA67VLQi
         JU0w==
X-Forwarded-Encrypted: i=1; AFNElJ86/nL0ftipDdN0wTkaAfezwhCze8n1mFEGESXSzMtr7eKQjOd+jXP0wAsc5i4BI+s4uEVHREs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlmcrL3214mtnFRStMDw8l8sxKagYzvz86/Pi6oMs0HNjtawNn
	RKAfDSeq2eCnt6+84mwhkDjmgOb/TBeJZ2Xn2jWTPTh30Qr17oH3cx7M
X-Gm-Gg: Acq92OESMdDPRAF56d7ikANDDiYpqMjLZraVWqqgY7HYFsEnOCZkmk6+ur74gSYljDN
	zD+gJCzoheDzUGpoKoFkxQb8f1LcnFawqyblyf1dNFo8fdvqoF1bwXiLMlqFgLnBcOcTYBmhfHI
	3bwTE5LGkefEqmF6h6QHattt/WbY3OHovwxqw22VA8AF7dRbomu/oDFxWo0gheiSgdtSXU7GFCx
	04CkkYaVfxRN9gzbOJk6Pr2ZN91UYmx5JUUvDODfoQzSTyEQepoZK+4PmF2B2oNplLWFf5i9DGD
	A4+g9oKN3upDXHtrX9lzi226DbnOX170sJ/SZgyfwSqH7KkbsP0LXPOsMuPcu4U0up9DOgB28Ab
	OINeJFfo5rLSLClHS8JIOEMR2+fD9Ybrsk1G14q+iPXrxgTFA6DqmFgD31m3Um4sMBpVVEvChzf
	cC/+kgMmCFZRsY3p18xC7eE2B2vVemh+Wd5oEC4SQ/gG3mBIeIQoIh6lG6cOHWFQ==
X-Received: by 2002:a17:90a:d44e:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-37a01847870mr6803728a91.1.1781339096450;
        Sat, 13 Jun 2026 01:24:56 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a25ecd5f4sm5070360a91.11.2026.06.13.01.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 01:24:56 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Liu Jian <liujian56@huawei.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Cong Wang <cwang@multikernel.io>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf, sockmap: fix BUG_ON in skb_to_sgvec() on a resized ingress skb
Date: Sat, 13 Jun 2026 08:24:31 +0000
Message-ID: <20260613082442.3252576-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298925-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:liujian56@huawei.com,m:daniel@iogearbox.net,m:cwang@multikernel.io,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71FB667E20D

sk_psock_skb_ingress_enqueue() maps a received message into a scatterlist
with skb_to_sgvec(skb, sg, off, len). On the SK_SKB strparser path off and
len come from the message's strp_msg (stm->offset and stm->full_len), set
by the stream parser. strparser does not trim the skb, so normally
skb->len - off >= full_len and len is within the skb.

An SK_SKB verdict (or parser) program may call bpf_skb_change_tail() and
shrink the skb after full_len was recorded. len then covers more bytes than
the skb holds, __skb_to_sgvec() walks past the data and trips BUG_ON(len):

  kernel BUG at net/core/skbuff.c:5286!
  RIP: 0010:__skb_to_sgvec+0x78c/0x790
  Call Trace:
   <IRQ>
   skb_to_sgvec+0x32/0x90
   sk_psock_skb_ingress_enqueue+0x42/0x370
   sk_psock_skb_ingress_self+0x1a8/0x200
   sk_psock_verdict_apply+0x33c/0x360
   sk_psock_strp_read+0x24a/0x370
   __strp_recv+0x66d/0xda0
   __tcp_read_sock+0x13d/0x590
   tcp_bpf_strp_read_sock+0x195/0x320
   strp_data_ready+0x267/0x340
   sk_psock_strp_data_ready+0x1ce/0x350
   tcp_data_queue+0x1364/0x2fd0
   </IRQ>

Clamp len to skb->len - off, and drop the message if off is already past
the skb. sk_psock_skb_ingress_enqueue() is the only skb_to_sgvec() caller
and both ingress paths (verdict SK_PASS and the backlog worker) reach it.
The clamp is a no-op unless the skb was shrunk.

Fixes: 7303524e04af ("skmsg: Lose offset info in sk_psock_skb_ingress")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/core/skmsg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index e1850caf1a71..2961178ebd1e 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -550,6 +550,10 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 {
 	int num_sge, copied;
 
+	if (off >= skb->len)
+		return -EINVAL;
+	len = min_t(u32, len, skb->len - off);
+
 	/* skb_to_sgvec will fail when the total number of fragments in
 	 * frag_list and frags exceeds MAX_MSG_FRAGS. For example, the
 	 * caller may aggregate multiple skbs.
-- 
2.43.0



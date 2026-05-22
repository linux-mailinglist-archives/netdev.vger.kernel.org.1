Return-Path: <netdev+bounces-290853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI/oIIFmEGoKXAYAu9opvQ
	(envelope-from <netdev+bounces-290853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:21:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0419A5B60E7
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27841304BBF9
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 14:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FCE39D3C1;
	Fri, 22 May 2026 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+NZZA+z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAA1410D3E
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779458484; cv=none; b=q3YVYPiX2/UAptmsERgyCH8AhrbY8wnzTEZ0SXxBAHmfGBzAWCPg8iRCOntc8O7rQ9GyGpcJVnqlQUqDqA7zb7X67A1Hq3LBU/Yu54lZPBd4Z3GCSrjeWAE2hDbz8dXqOfID4WTFIpIkBeLTB4k/fuBVLuYvnT8tEBTNrjy5Gls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779458484; c=relaxed/simple;
	bh=fs/ta8eTlNchNJaArsAGnEER3GZ1R+4RmEbZCM6gFs8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fGPjEhD4TkWpsDznyh6XL8/3RZTRU9/rmFqaSC0c3po0Xw2Tgnx6r5+GXnasprqSulmI3rdEB4p4Q5nEGKYrtFU6vlZKe07ALRswXvVgX0wLmW2Bq508sqPP8v2ou3iqksWUYfG3agMdzteyDwa3FS23G/vfDjNqi+uClgmOQNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y+NZZA+z; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-516cdd89225so34929651cf.0
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 07:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779458479; x=1780063279; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VT1kGtaD7Jw3U73S4KtEzPxOgq6cSfhZQjpotpbOvys=;
        b=Y+NZZA+zxcVjoTWA/xbgizM0iftkN/XI31liLDCRl9JoSIgvduR0QOiVmG1ZPpNj1u
         7irU4hbNvQbAENKT9cmDtFKZDEkO0Ib2WmWEi2d5PSeAflAKJKoYb9V+M1rrvSHZ4qAH
         icacVvD54aEVONDwAwGsyYNJgA5Uu+9r6JnCL6Rit0/t195s/S7DFZ9KOuxexcpQnu3x
         uB1OQT0SDdYyahibBwJFpW7A1ug0DoeBdPOdCqd/IbDNz9ECFVlMkvAKc997vrWPbOww
         7/CA0DneJ/qHKOb15FsBPAJn+4gRyNGC/Qop5Vhs9J+Qr3MYDhxr7a8U72RtE/AlZ7gu
         g93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779458479; x=1780063279;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VT1kGtaD7Jw3U73S4KtEzPxOgq6cSfhZQjpotpbOvys=;
        b=HY4C8YMLC9e/Gpf1QUs3FMHY/qsV7iUXlar2BGnej1jUhgnoz3/XnYCmhvsJQgNw97
         a6HRxxYTooRNbIv8VIcSumweI+DjCDqXwDi2cPKjEn6K6JgWafnh+3S8a9gRVJgD/88a
         yMJJBYv9pWnyXKIfYkuQ2MycGd7a4jRfoB1P4JtCRVkZVmEZtcCDAnR5QeIz2qrtAFFW
         SwxIo8cE1Yzpri0/D57VHn5tT/ujQVrSnoo7/rZ3nhDRBWjubmaJGOm+QrI9FNXI5+q/
         gfZU8ROGDT/LNRg1jSl5yPMM76Z1j7rW76dY9d724t/cexCXh1lszsFfBKApqV55EEvu
         /2pA==
X-Forwarded-Encrypted: i=1; AFNElJ/gRwezRJNXPWPqzWdQWoEs3IdPVCqw4s5qhVNct4esgygAfOI5gfMcBoMMKKdGa6aUczjvbhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVBa5cwt8VkWbX77x2Ivv++2mfk9yQ0A02XA9LHnzFvShXNyqW
	OC4KOTw1Xa9ofBadPnl7tzIcsUn/ZiGKAPEYMQ5Ihgid/HG1WSXGsJTe+IOzWhNhDzvKFXzqkcD
	SgCU/bTmj9khJjA==
X-Received: from qtpb1.prod.google.com ([2002:ac8:6781:0:b0:516:82ba:172e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:182a:b0:50d:a4e6:997f with SMTP id d75a77b69052e-516d4419a15mr54998241cf.15.1779458446526;
 Fri, 22 May 2026 07:00:46 -0700 (PDT)
Date: Fri, 22 May 2026 14:00:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522140045.1836961-1-edumazet@google.com>
Subject: [PATCH net] inet: frags: fix a possible frag_mem_limit drift
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Damiano Melotti <melotti@google.com>, Florian Westphal <fw@strlen.de>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Peter Oskolkov <posk@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290853-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com,strlen.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.949];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0419A5B60E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

During IP fragment reassembly, when an incoming fragment completes
the reassembly but is not the first fragment
(the head != skb branch in inet_frag_reasm_prepare),
the code creates a clone fp of the incoming fragment skb and
swaps it into the rbtree.

The original fragment (skb) had its truesize added to the fragmentation
memory limit fqdir->mem during ip_frag_queue.

However, the clone fp can have a different truesize.

When the reassembly finishes, inet_frag_reasm_finish traverses the tree
and subtracts the different fp->truesize from fqdir->mem.

We probably never have seen this issue in the wild because
most NIC are cooking packets with a constant skb->truesize
regardless of the fragment size (Assuming MTU <= 1500).

However this could be exploited for NIC implementing copybreak
(copying small payload in skb->head), or MTU >= 4096
and NIC using 1 to 3 4K pages for jumbo frames.

Fixes: 1706d58763c3 ("[IPV4]: Make ip_defrag return the same packet")
Reported-by: Damiano Melotti <melotti@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Florian Westphal <fw@strlen.de>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Peter Oskolkov <posk@google.com>
---
 net/ipv4/inet_fragment.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 393770920abd794a47a933f2694afe3e2d08d25a..3222cc2ac235e9628da88db6637498755749b07d 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -539,6 +539,9 @@ void *inet_frag_reasm_prepare(struct inet_frag_queue *q, struct sk_buff *skb,
 		FRAG_CB(skb)->next_frag = FRAG_CB(head)->next_frag;
 		rb_replace_node(&head->rbnode, &skb->rbnode,
 				&q->rb_fragments);
+		delta = skb->truesize - head->truesize;
+		if (delta)
+			add_frag_mem_limit(q->fqdir, delta);
 		consume_skb(head);
 		head = skb;
 	}
-- 
2.54.0.746.g67dd491aae-goog



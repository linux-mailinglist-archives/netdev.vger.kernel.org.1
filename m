Return-Path: <netdev+bounces-294231-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T/JdN33eHmprWwAAu9opvQ
	(envelope-from <netdev+bounces-294231-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:45:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 808F862E9DB
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:45:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jYNmjA1z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294231-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294231-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D27DA308CE51
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 13:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC503E6DD3;
	Tue,  2 Jun 2026 13:36:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D643E1221
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 13:36:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407378; cv=none; b=DUKSglZ8Xx7vbXcPQ4CWSK8ezt4/A1p3mrxK5/AWtqUjkJ3KcnaxOwGbN5qwQRVWsrFQpz3qzG8HvNX/vP079+N852oVgG8csSSQfpYpVp2tv1zt39GyMjdiZ6uUzQFbbfNo4U5nZBX+b7+hu/CuCX6CZnCCH8cScS6p76n/zoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407378; c=relaxed/simple;
	bh=7Lj0FqVDmeiNPWCn3u/fKwFl3wYP02Jhmq4tu2IuAwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/DMn/Ugz7HorGEAGBcDq+UGvDr3KfFfQiQuh55abmID2dBz+A28FfWD07MGH0fMPjVAR0jh0aZ8wt9CdIONUTgu6Sdpg8LRwb1tx88RsvBfiM23mcuwFaPUh6gfTSVF3QUwgQdmJ9TmkKtr81gan+tvZOPVMlc78M7h7/wqi+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYNmjA1z; arc=none smtp.client-ip=209.85.222.171
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9157d3f2098so77452185a.3
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 06:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780407372; x=1781012172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnT0GMlKGTyqTQGZDUa8kd6IyJCEjxPnkabKrmHLnAA=;
        b=jYNmjA1zDkh2NmlTK4dNah/TJZGUVPPCNVwZ3oWTVxTXPFJsUitP6RhiSQFbI+MYIq
         XrUI5zc01dqSEkMRx5JpFXIKsPyLTW45DfQ4wXUK8bTKPLvONyR/2jUzjRDeDYoYKbxi
         eRwdi4dQm82d4KKZSHcatfq2+yKuiqCdo22SHGMTfBRmfddwQdtHkJwC++t3YI3fgLm0
         db28SbKaWYsfCUr2/zPmLvpwwl5KkZFQgpTe72+O4nQstA68uL6rrbKZRLXVRzh9ekm9
         lhqejdwD8rg/dRZp08PTBkKp/a92QIYggQliGnSis3wuByRf8EOBx5zLj8OaibGWjq/i
         GA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780407372; x=1781012172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vnT0GMlKGTyqTQGZDUa8kd6IyJCEjxPnkabKrmHLnAA=;
        b=Yqs0+y2Nbfk1Di46eqiAG3GK1gsK9tZmdYpH0/t1KwH/1229LBFXNp7C+4cCedQvJH
         CQ9otC+t+6oIn5bvCogkay/kWqSzSjOEu5olDyghd0hyB+BlwdSN7JzHN7vR3+77Ca4v
         Wi2FdwiyJLi8+Tl+dJhOAsVjLLK5e/fKe/2aS1F1dz/8shuaFvrXsF2B3Ew/54MYHf86
         jYfFBolrO55b8nwTfa92NxbL9lIob1WoOsgmvQIq1hgBXPfi6M3io3WPrbQYBaJuPC4B
         wfNLHo+k6GcxAWXZatmQ4aVvOd3MO4vb6ntyPO+zN6ADRvTEPm/m8a4h9G2BAk9peZay
         rkLA==
X-Forwarded-Encrypted: i=1; AFNElJ+j2PPST+vmi9tRkJfFhG2fVeOfAn989ln0JV1QQqlKGp3CTsijRDbIlydWRtz2DjTF0kxJpUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM19FAsFn1BDPxj5d1FSlzuAyRQzKoi3/7yrNGaWsdkZg3BgjM
	SKnLwlc7UACbPin3gm8klBJ5cL0e9iX9e7fznh6Lk/u/ZtLAskofJrfW
X-Gm-Gg: Acq92OGLeUL7N75GUOkIkC/t9R0sbTqdDAHOCqaOJGQxYJv2z0EejjboJ8M7rvM+xoG
	btRhW6piQs0wmpA22r13ox1tULyzw8E3YekWvaHS3jhLw11kVZiPd6IObII7O+d8GhKXhxZ6Hy+
	1rHl6sMjciatT/ASXsaFjjeziJOYuCFZ5f70TvhWBsSpn7WJkO/2Aeb//Fa3ePPIIM9FBepdOZ9
	UL5VTnRWxVvOGgstOml9Pkf1vXdELOLSm6K9WGN/Zd26JtcQKxgw6qF0RnLY1g1UKdEozEPRx8S
	4cBF2u1eMFCe3HR+KDzTM3G7cRO//qEC1XltxaShbBKVyZjY6tsmYdczC0Grvc+Fwypyq0PDgdU
	lhWM3bD/ZiFF6h34J/RdsQMe01ZZqxkXMNDR7f1Ym1dLtQb3tIKxQ27JOhG2Sd/anMo9Lh6j1xy
	uRlE1g7PCqGNFqR+eHC+mp3byBfzIf4wJZUgmxA/s1tOWIQSJcD0iatFjUZlVZS8EfVclDXjYEd
	i7ZIkQeVhNt/9/zLR6qOWOuLus10W8=
X-Received: by 2002:a05:620a:3909:b0:8cd:a3ab:352d with SMTP id af79cd13be357-9153dbabb50mr2601322585a.61.1780407372227;
        Tue, 02 Jun 2026 06:36:12 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915721f7d75sm346036285a.18.2026.06.02.06.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:36:11 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/4] tipc: validate discovery message length before reading media address
Date: Tue,  2 Jun 2026 09:35:53 -0400
Message-ID: <20260602133555.769727-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602133555.769727-1-michael.bommarito@gmail.com>
References: <20260602133555.769727-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294231-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ying.xue@windriver.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 808F862E9DB

tipc_disc_rcv() reads the sender's media address from the fixed
media-info area of the header (msg_media_addr(), offset
TIPC_MEDIA_INFO_OFFSET) and, when the peer advertises 128-bit node
ids, copies a NODE_ID_LEN node id appended after the header. Neither
read is bounded against the actual received length: tipc_msg_validate()
only enforces a header size in the range [MIN_H_SIZE, MAX_H_SIZE], so a
LINK_CONFIG message as short as MIN_H_SIZE (24 bytes) passes validation
while the media-address read reaches up to MAX_H_SIZE and the node-id
read reaches MAX_H_SIZE + NODE_ID_LEN.

A node always builds discovery messages at MAX_H_SIZE + NODE_ID_LEN
(tipc_disc_init_msg()), so a shorter LINK_CONFIG message is malformed.
Drop such messages before the reads so the media address and node id
are taken from received data rather than from uninitialised tail room
or memory beyond the buffer.

A crafted short LINK_CONFIG datagram otherwise makes tipc_disc_rcv()
read past the received message data when a bearer is enabled.

Fixes: 3d749a6a26b0 ("tipc: Hide media-specific addressing details from generic bearer code")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/tipc/discover.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/tipc/discover.c b/net/tipc/discover.c
index 3e54d2df5683a..daf5f11fc82b4 100644
--- a/net/tipc/discover.c
+++ b/net/tipc/discover.c
@@ -217,6 +217,20 @@ void tipc_disc_rcv(struct net *net, struct sk_buff *skb,
 	}
 	hdr = buf_msg(skb);
 
+	/* A discovery message carries the sender's media address within the
+	 * fixed-size header and, when 128-bit ids are advertised, a node id
+	 * appended after it.  A node always builds these messages at
+	 * MAX_H_SIZE + NODE_ID_LEN, so drop anything too short to hold what
+	 * is read below and keep msg2addr() and the node-id copy within the
+	 * received data.
+	 */
+	if (skb->len < MAX_H_SIZE ||
+	    ((caps & TIPC_NODE_ID128) && skb->len < MAX_H_SIZE + NODE_ID_LEN)) {
+		pr_warn_ratelimited("Rcv corrupt discovery message\n");
+		kfree_skb(skb);
+		return;
+	}
+
 	if (caps & TIPC_NODE_ID128)
 		memcpy(peer_id, msg_node_id(hdr), NODE_ID_LEN);
 	else
-- 
2.53.0



Return-Path: <netdev+bounces-283353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG8jNm1s9WlVLAIAu9opvQ
	(envelope-from <netdev+bounces-283353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:15:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4284B0C49
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB679303464F
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 03:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1422D5C68;
	Sat,  2 May 2026 03:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UQv90zqk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2909A2D2483
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 03:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777691657; cv=none; b=VIKusqn1CWZBrizDH9SCRMRKclN8QAIUFs2TpNdxAw9LWGwgTzD106hMgHZYBzScvTZfrm0HOrjUp0rbOmK2vtkG/VPx0FxVfLpUC1WJPs0qEuAjv8jxZHz8ryQupdu5X4o+GE3a3WK9sH4SCtl9vT8Hbua0PuLDVrmXyggNI98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777691657; c=relaxed/simple;
	bh=XnIl7IVVJAYYQ2u2VlKdOgCCn9+B4SY61WoG49qjsao=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TuM0CevhO9nsvC4Xj6fZ/Dyo3pomcjubIUBRKHp1H/9EENig72jPUJGbwlOOTgxRGmk3KSr9ipLOBd5HlIo99oOd43CaDDfj02woLrXgJ8FvEhcaRlsX56ADEdVE3c/FvWZmD7TfPYc+iDE9uXJFag+JGiS5GPKB0bUZr45twpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UQv90zqk; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-358df8fbd1cso3126163a91.0
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 20:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777691655; x=1778296455; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sil/LPPLNF4P5rdAf3jonykQxCMhYWtlRO3rM+5HhD4=;
        b=UQv90zqkHW50e4sGmszWRgd0AP0HsFYY+HpoCqhKQ016+G4+ZP5ubgtSHYnd6foBRz
         cx+alK84UJ7Ix34rXU3TwYHKZicX9v3FGMwUUiSkUSwyf5+UH/rvrwT063K1NBE616IZ
         M+eOgToadxffKK9baQfBBMzATQuic4cHI3US83ET6mbL8mKzNlBt1154g/Hd8OnLnrQY
         gGQuSvbBZZrRpeynSeWxm8d05RtGlSVeLFktQy7yGGxCW5WPicofu2cB1jSeOcMbq2XA
         R6Jq/n893R/6zWnbcCkm1DNcUcCT9iAUl3vP5Zp2I9CpuonxXPYj35iuKMXBojcjAXVh
         s0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777691655; x=1778296455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sil/LPPLNF4P5rdAf3jonykQxCMhYWtlRO3rM+5HhD4=;
        b=Q8tvHz7FWMs6Sh7jotwhCe9R6Dw850fvfF3QA4b7p6SsTSdgZ3y/pCIPc+a7YYMnnL
         c5aFEE0AYqyM2i0kXdDksyyLSv24ZZdPmM96yUCKjOFwo1U3k8BWszk5OfRJEspvzchZ
         Q42h0xgOGj/3LO1OsWnEXIYZezI+wDmaamAj+DtEirSKWlEjBcgBKlPCXKSeElZdYrau
         L2gYB3e6GaBC3IOFh/ITej5Tiddm3528vS4Wujdpl0pAI2JQv3DscUENRV2IcB5oqu5r
         cnLxITYiiL5kC9OW/BjgotTt/ULHw8aIMaiI1/RClg0VLJfKrs+RimR5/sfa0gaNsOs/
         h9Ug==
X-Forwarded-Encrypted: i=1; AFNElJ9HmjOsDWkE5dNNWDFc075vX0AAEDvy2B3Avpxl1PfEWjO2n8NC0iqcRH8ZVzWqRP23eXC0JQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyys49t6eEOEVUZlNOGhSTuc1uQxPPaRLZKBOz14UgjOKp73eng
	icwSrc5ziA+KCON9xtFtUm42nWeOw8sIKnXtXqi7Ni8dstCVxOdMh697QVh6trJ+RUdBZ3sSeMo
	ktWQ+ZQ==
X-Received: from pgar12.prod.google.com ([2002:a05:6a02:2e8c:b0:c74:497:507e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e211:b0:39f:2dd0:65d5
 with SMTP id adf61e73a8af0-3a7f1e7a285mr1436642637.39.1777691655293; Fri, 01
 May 2026 20:14:15 -0700 (PDT)
Date: Sat,  2 May 2026 03:12:59 +0000
In-Reply-To: <20260502031401.3557229-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502031401.3557229-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502031401.3557229-7-kuniyu@google.com>
Subject: [PATCH v1 net-next 06/15] vxlan: Fix potential null-ptr-deref in vxlan_gro_prepare_receive().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4C4284B0C49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283353-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

udp_tunnel_sock_release() could set sk->sk_user_data to NULL
while vxlan_gro_prepare_receive() is running.

Let's check if rcu_dereference_sk_user_data() is NULL after
skb_gro_remcsum_init().

Fixes: 5602c48cf875 ("vxlan: change vxlan to use UDP socket GRO")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
This is 10 years old bug...
---
 drivers/net/vxlan/vxlan_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 0ea88232b985..abf3ae04d75b 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -657,14 +657,18 @@ static struct vxlanhdr *vxlan_gro_prepare_receive(struct sock *sk,
 						  struct sk_buff *skb,
 						  struct gro_remcsum *grc)
 {
-	struct sk_buff *p;
 	struct vxlanhdr *vh, *vh2;
 	unsigned int hlen, off_vx;
-	struct vxlan_sock *vs = rcu_dereference_sk_user_data(sk);
+	struct vxlan_sock *vs;
+	struct sk_buff *p;
 	__be32 flags;
 
 	skb_gro_remcsum_init(grc);
 
+	vs = rcu_dereference_sk_user_data(sk);
+	if (!vs)
+		return NULL;
+
 	off_vx = skb_gro_offset(skb);
 	hlen = off_vx + sizeof(*vh);
 	vh = skb_gro_header(skb, hlen, off_vx);
-- 
2.54.0.545.g6539524ca2-goog



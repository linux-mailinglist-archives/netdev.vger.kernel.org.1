Return-Path: <netdev+bounces-287594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCmqBgB7BGpoKgIAu9opvQ
	(envelope-from <netdev+bounces-287594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:22:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6711F533F21
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A345E31E1440
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6E94279ED;
	Wed, 13 May 2026 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1d6r5F4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E438426692
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677185; cv=none; b=N14cj3WygylStJ8q3DBJ4JICJ9gy7f1DUxJeLWNn1dKfKkbhjUjrDCfbcxlJLkAnyNcKOBseF/KveF4NhNVnSzlsLk8wR2zQgeeeeW6i6xd8YHMgqkhJYeLXnQ6/SwBKmL17DodNUNEqoeZ2X180DTXPrqZkAAd7/4lhQo8hZoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677185; c=relaxed/simple;
	bh=LHOE1mMbJxQim/OpEcoRlURxuH0eMEhtOg9F7R8wTPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DVJcF54vSSGV1LfpPfyNbx0ZSjBS5RPkfa5hmW1evfI4Wiy4JVoxUaHrG0IlCVJCgB0OLLFJSK6K/eXWgZXonc0MUGy6VCfCG91zf79cmmx4yk3WEfQ+cozKNsY3xQlBMPQzH6sOzt8D77ZNZZN6IxDRN2ACTveb+6nbo8N3CbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1d6r5F4; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4756e74f8edso5199086b6e.1
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 05:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778677183; x=1779281983; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f23t0zSaqUAfWSysjbdO/3Qdq/GLiYIEowumVnM/uXw=;
        b=X1d6r5F4OIR/xwrnP96n4s0rJOA+PgXSDt7sPGI4KXgr6Isx55LQ5c39eaMcozXymQ
         5hz8aL0phRxOZ1d9xvalaseN/8BhwzQ5816FtAcwks19DrDdJvcDGWxKBxbyYOoyTL7L
         qKvFQpDJKWsk0qEF8RxwC+mbAYr/tjSa8Ougvs4PDC/xQIPt3wHjB9oER21Q9RetaaGA
         5rp2huZJj7loOol5Nc6u0Om3SqH3sSdWXNApXw8WsehpeB6HeiSRe+hTMqucJfCfFUpU
         g5oXpb8iqkHRHl3KobI9J+T71iSxfKelnW7oFwUC77Y6RNoAGFkS+wxRACfcOqJWrPxx
         1mTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677183; x=1779281983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f23t0zSaqUAfWSysjbdO/3Qdq/GLiYIEowumVnM/uXw=;
        b=bbfDc5qPRy8vJt/2EgiKde+KsKWcJYW89NXx5c09dEmtVUka3TeKjwwH1tLGp91Pnt
         WugTO311jxqUAMwcvHlh8VWWEuKquVqLGAhRYkbYFrqtiKIa+VtmOB9VcMkH3DkgPl8X
         kI7Ft/CxZDdlYImnqmUWTtNlpVF+azcprBAKVD+m0klzxkgY9F7IhWsIcBmVokvJFuSN
         V2Iweb5hMUNZvw6jSqtSq2IsjYpn9icZPpU48xI16mjkWXIk8xr6o0QU2lW6YKpT2Wx4
         HSebxapuyhMLI/UEenhEBZjx5NPb9NOGPZKthVFoWfIBxfv5pXbbXKtTHR3YMWw4WTat
         /fVw==
X-Gm-Message-State: AOJu0Yy6P7FYm6ukwODE/Ie/53IDnz2IZiS36zvuJFg3/t/pJ99sQkIa
	SM/y8W1+gwR3+gjv2SpPFl2jc48nWP+YW8+WPlmROZYL7SEYqnMvHp5/
X-Gm-Gg: Acq92OEI/+GTLUj5lW1dhhLag0dz9EFHDKZNoS5qc8w6+uzDa1iV51KH6BZPH86+Mvn
	p2pnSfROl0JOA6rEN4h+Dlt6LEMuHo3qw9VmRUM5FJHGQ6B13/xDiy2OCaoFgy9ZSDtZzYM3Tvh
	QL23xK+g5F43erZRwzhZhBJJpyG0/LtMq6pRdNrcWau/nAtrIgHZ2tN92zysLd59QblQPWrw72B
	ahoVJ4GMOBIwyARvQfOiUDLlEnGGjnIi8hUICZW2PhWr1jYDBn1WufCb0/TT7WB9SFtFjvW/YNz
	rH4skBpul9wqQrp/x56hN0BoRjs4nCKc5146vts8KZqoJtj6ofwNu0Nc88M/ZpKQnXflOMnQYWt
	4TDFAng+XaKmONDSV2JZGR1gh4XC2CAO5ljXKha3Kky4ZovMm1L2af4n+FqNQGOmE/5kfgi27Xj
	+uL2GfUOLYDuJ37HL1rNko
X-Received: by 2002:a05:6808:5390:b0:479:ae1d:ffe8 with SMTP id 5614622812f47-482b5d460c2mr1560078b6e.4.1778677183125;
        Wed, 13 May 2026 05:59:43 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:41::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76986404sm24249176b6e.15.2026.05.13.05.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 05:59:42 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Wed, 13 May 2026 05:59:38 -0700
Subject: [PATCH net 3/3] netdevsim: psp: serialize psp stats writers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-fix-psp-stats-v1-3-cdb3174f252f@gmail.com>
References: <20260513-fix-psp-stats-v1-0-cdb3174f252f@gmail.com>
In-Reply-To: <20260513-fix-psp-stats-v1-0-cdb3174f252f@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: 6711F533F21
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287594-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The u64_stats_* api requires mutual exclusion on writers. The simplest
way to do this is just to add a spinlock to the writer path, rather
than making the stats per queue.

Synchronization of the reader and writer paths use the
u64_stats_update_begin() api and does not require any fixes.

Fixes: 178f0763c5f3 ("netdevsim: implement psp device stats")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/netdevsim/netdevsim.h | 1 +
 drivers/net/netdevsim/psp.c       | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index d909c4160ea1..bc36033b511b 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -115,6 +115,7 @@ struct netdevsim {
 	int rq_reset_mode;
 
 	struct {
+		spinlock_t stats_lock;
 		u64_stats_t rx_packets;
 		u64_stats_t rx_bytes;
 		u64_stats_t tx_packets;
diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
index 5ff91da24539..56ddbf146489 100644
--- a/drivers/net/netdevsim/psp.c
+++ b/drivers/net/netdevsim/psp.c
@@ -50,10 +50,12 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
 	}
 
 	psp_len = skb->len - skb_inner_transport_offset(skb);
+	spin_lock_bh(&ns->psp.stats_lock);
 	u64_stats_update_begin(&ns->psp.syncp);
 	u64_stats_inc(&ns->psp.tx_packets);
 	u64_stats_add(&ns->psp.tx_bytes, psp_len);
 	u64_stats_update_end(&ns->psp.syncp);
+	spin_unlock_bh(&ns->psp.stats_lock);
 
 	/* Now pretend we just received this frame */
 	peer_psd = rcu_dereference(peer_ns->psp.dev);
@@ -79,10 +81,12 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
 		refcount_inc(&(*psp_ext)->refcnt);
 		skb->decrypted = 1;
 
+		spin_lock_bh(&peer_ns->psp.stats_lock);
 		u64_stats_update_begin(&peer_ns->psp.syncp);
 		u64_stats_inc(&peer_ns->psp.rx_packets);
 		u64_stats_add(&peer_ns->psp.rx_bytes, psp_len);
 		u64_stats_update_end(&peer_ns->psp.syncp);
+		spin_unlock_bh(&peer_ns->psp.stats_lock);
 	} else {
 		struct ipv6hdr *ip6h __maybe_unused;
 		struct iphdr *iph;
@@ -271,6 +275,7 @@ int nsim_psp_init(struct netdevsim *ns)
 	struct dentry *ddir = ns->nsim_dev_port->ddir;
 	struct psp_dev *psd;
 
+	spin_lock_init(&ns->psp.stats_lock);
 	u64_stats_init(&ns->psp.syncp);
 
 	psd = psp_dev_create(ns->netdev, &nsim_psp_ops, &nsim_psp_caps, ns);

-- 
2.52.0



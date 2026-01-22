Return-Path: <netdev+bounces-252212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L/qNQuvcWlmLQAAu9opvQ
	(envelope-from <netdev+bounces-252212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 06:00:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC2D61DCB
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 06:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53EB54EAE14
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9874D46AEDA;
	Thu, 22 Jan 2026 04:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oj13TF1Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC062466B7D
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 04:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769057849; cv=none; b=O0Y5W/D8gIibbK6LbNfIrcAVFXxQGdmutQF41w+/z9CfS3ePsYYuxSW1KJiQeciI5KD65pYg1KUU/BLxIE3hAhlRkFZrtidbfA5MD99Z+0yQFbiQXSGhpyQpdhMKQFu745qsRlqbUdQQ9TYpiIx1ldoFb5NThvB/DPIrwNy5dyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769057849; c=relaxed/simple;
	bh=UMJSClP7j7upAqlGSzYGTdnSJYlhyCcvcq4qs5bxGhg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lzpkNJbpRIOuq77SP3VhCouIicRe+qNc9V2CP8CWKPFnmu2iAiylSqUei4yXk6Hu9ZLWG+5BQpc4kPTgZvZxbPrGRDVnPKiXyvyFIgao3WwwQ2Ra6NTm5qC5D8PB9UaJ3K/0D19SXVcrE0sqiiwaY5rfgqaPg5tBH2S9ynhiA9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oj13TF1Z; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c52f07fbd0so243477785a.2
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 20:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769057846; x=1769662646; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IQRUXbGLE0CQhDN+uBgB1G+ba8M3lmdhA/RKNdo7Cr0=;
        b=oj13TF1ZGzu0VhDH7ksCQMUJTrRVr2H55hFqAKV8z40wwPWFYp9Pa+Ex3/UOLLIQ2X
         XS7khWoTSD3NGk1k9lnZ/nhPZ1Yd9tk7m9wbPpv0/X01uShb6zJ5ol2JIi7RC/x4YtUB
         /yvasXuhQ2UEMAW8U+0YLEs3X3i6AhNlkr3aZqnN2b9YxNV5FX4vC4e9BzBF9i5RBVcP
         1wyqrtb6YVVasXRDcggLJZKDp/lif2sp4k+JBmbbVCmCOAx+Q7Eks9obsXHpCcvRgqyN
         e/sRZOAYzwWwnor9gXvWONCunA3GJuDD39aW/2pzpNeKvwOxHlu1cWqtogl2t+onywir
         Nudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769057846; x=1769662646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IQRUXbGLE0CQhDN+uBgB1G+ba8M3lmdhA/RKNdo7Cr0=;
        b=NUKwxBEhBLAaxCRmvGkPFA8GT/XDyko1SDsMwVUt9kER6xnbMi9goK+AcbRLapDJgu
         23F9KgpYoj00EMdkPuhIPTM1SvMhyQptnTwmglEWJH0yfsfK6NeUPMFwYrUqJhBk+N2i
         3nFfujeIi+w8msoBesZ+67XdzCw2jkzXLJZ1ZZ4shmRzpa5mfim8/s9tvzgsCW66Q569
         1dfv3B9pUtrhiGYiROFnaq7Vw5ahQTgFG6A+2QQbla6lqqkOyVs/Tx76oK5aVEyI3exr
         cxxOKRZ6KqiN4Dwgk/8H4HK1ClFbeowyT+w+fzZUgt70h6lRILnAGi45YRWBCZE9iXbq
         zuLA==
X-Forwarded-Encrypted: i=1; AJvYcCWpgWeJBogGb4dM2H6R7DqACIV7xkJgOQiNHCLvnbX+NxBujtO46bvyNLSPnYk9XU6MMkM1tDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuZ5nH5Iw6M1AEMgxSuMMgjQrjx9NYvXpyP9PpJ042YE2b904A
	ZUhYpa/ZpvTNJizyIaWnN0gOe1/WIvKKkXITZqY8Ox1fYNb22/ZmXvymID7gLbz4038Wesx4hlC
	1cw5hLJLQyyLMaA==
X-Received: from qknpy18.prod.google.com ([2002:a05:620a:8792:b0:8c5:2401:a66d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:bcd:b0:8b2:c2ba:7075 with SMTP id af79cd13be357-8c6a695a918mr2774055585a.75.1769057846501;
 Wed, 21 Jan 2026 20:57:26 -0800 (PST)
Date: Thu, 22 Jan 2026 04:57:18 +0000
In-Reply-To: <20260122045720.1221017-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260122045720.1221017-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122045720.1221017-4-edumazet@google.com>
Subject: [PATCH net-next 3/4] net: inline net_is_devmem_iov()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252212-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 5DC2D61DCB
X-Rspamd-Action: no action

1) Inline this small helper to reduce code size and decrease cpu costs.
2) Constify its argument.
3) Move it to include/net/netmem.h, as a prereq for the following patch.

$ scripts/bloat-o-meter -t vmlinux.2 vmlinux.3
add/remove: 0/2 grow/shrink: 0/4 up/down: 0/-158 (-158)
Function                                     old     new   delta
validate_xmit_skb                            866     857      -9
__pfx_net_is_devmem_iov                       16       -     -16
net_is_devmem_iov                             22       -     -22
get_netmem                                   152     130     -22
put_netmem                                   140     114     -26
tcp_recvmsg_locked                          3860    3797     -63
Total: Before=22566015, After=22565857, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/netmem.h | 12 ++++++++++++
 net/core/devmem.c    |  5 -----
 net/core/devmem.h    |  7 +------
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 9e10f4ac50c3d4381d2404c3b079366dfc08bab7..2113a197abb315f608ee3d6d3e8a60811b3781f8 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -389,6 +389,18 @@ static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
 	return netmem_to_nmdesc(netmem)->dma_addr;
 }
 
+#if defined(CONFIG_NET_DEVMEM)
+static inline bool net_is_devmem_iov(const struct net_iov *niov)
+{
+	return niov->type == NET_IOV_DMABUF;
+}
+#else
+static inline bool net_is_devmem_iov(const struct net_iov *niov)
+{
+	return false;
+}
+#endif
+
 void get_netmem(netmem_ref netmem);
 void put_netmem(netmem_ref netmem);
 
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 185ed2a73d1cfa55858e4e0d42be365f612662fa..63f093f7d2b23f01929b83746ae25779d3f925d0 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -30,11 +30,6 @@ static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
 
 static const struct memory_provider_ops dmabuf_devmem_ops;
 
-bool net_is_devmem_iov(struct net_iov *niov)
-{
-	return niov->type == NET_IOV_DMABUF;
-}
-
 static void net_devmem_dmabuf_free_chunk_owner(struct gen_pool *genpool,
 					       struct gen_pool_chunk *chunk,
 					       void *not_used)
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 2534c8144212c79f09389201ae190511948977fb..1c5c18581fcb146450cfb18a4b1d0ce8a17b96a9 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -141,7 +141,7 @@ struct net_iov *
 net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding);
 void net_devmem_free_dmabuf(struct net_iov *ppiov);
 
-bool net_is_devmem_iov(struct net_iov *niov);
+
 struct net_devmem_dmabuf_binding *
 net_devmem_get_binding(struct sock *sk, unsigned int dmabuf_id);
 struct net_iov *
@@ -214,11 +214,6 @@ static inline u32 net_devmem_iov_binding_id(const struct net_iov *niov)
 	return 0;
 }
 
-static inline bool net_is_devmem_iov(struct net_iov *niov)
-{
-	return false;
-}
-
 static inline struct net_devmem_dmabuf_binding *
 net_devmem_get_binding(struct sock *sk, unsigned int dmabuf_id)
 {
-- 
2.52.0.457.g6b5491de43-goog



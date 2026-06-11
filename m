Return-Path: <netdev+bounces-297978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ksRZDA1gKmqGoQMAu9opvQ
	(envelope-from <netdev+bounces-297978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:13:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B306D66F48A
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:13:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=C4ddX5Wl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297978-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297978-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 238D030065EA
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0AC3B6359;
	Thu, 11 Jun 2026 07:13:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE20D3B442F
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 07:13:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161995; cv=none; b=cQ/59pLm6hFNYrQa1xHxy0uknXr/jzbqFI58vmSOGLWTwZpx3rsyOggiQ6zznm1scohObDeg4fJ1oJpMayGMfl0CbLFX41RU1uSiQ4bmMgUhVGzaPBq0flMXhj5+3rRHvq9NB6fguLMMLBF8YhVXUMdr/+X7lE1069pcBVFfwKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161995; c=relaxed/simple;
	bh=ufFawdkbPQyxtvP/vY4bfmggah69hAiP4MacVPkP8Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zy/sLSp2cKuc8FYurjijBxUl4Zi8MtUxJoQUAIbuiD8hM9ujzZwpPR4QSCyPfqq7yE0ytHtWGTfGmqYXwfbK1kNjpT4ATWQuynYQJfSy5Bh7YcpjXIO9Ptw5DM6vNpZw7DjjqZWvg40j7VbzgVwCbS3dM4IAecRF2aOPJSXhQmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4ddX5Wl; arc=none smtp.client-ip=209.85.128.195
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-7dbcb505578so95364987b3.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 00:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781161993; x=1781766793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vZX9ZLsq7+qZlX0ydHeLJ+45hrHGXpIcH8h2xOtT/8=;
        b=C4ddX5WlCj4AYUW4cKSySGq0wwb9BoMyxb/QwchQ7qagzgnJEcRcUO3RW+9H3NUpRd
         43T8T1GbbTKzD89ouPfW0w7K21sE0afxflf8/wlQS+YbpZBxW+mZiuwbqwx3AEkxclhl
         Rd7MYvoNYuzPdP+BCSfzIy63idieg7yqd0B8zQuNYH0sFjAbRNzSO57MLblOJ1jv1tbc
         5zRQZ9ulaKIxaayCJ113BuDMdLE5f+c0oErDIFd08y1Ge6Xl68+5HfqzRuoO+Rr5ucnK
         +E53mBF45smRdg51AJ76vMTuBsaUP10v2LvV+SAJNoObxR84b5+DFt7PyAwFl+hLNHaC
         ZZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781161993; x=1781766793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5vZX9ZLsq7+qZlX0ydHeLJ+45hrHGXpIcH8h2xOtT/8=;
        b=da7oJrJ8RXM7zQ+RO0th9rrLDzEjGNtz8i8yEev1pa2sbGSkYbu0zYMJDRA/zou9Fl
         3uv0NAw+t1IgVObEbk55GkcZd6h0VsSdEB5Q82Ylli0KjBN7VsgqNrANJnbKnI78/WRw
         7LzIVqPpxrNJjHtf6hI9EVPSwGY0AcUDKuYCJ2hOjtElNQRAP3JawP13ZV7jZdsoRvFm
         jeEsjO1Lmm8eQdumEBmmb2bhtHeGdb4WXmJbCCevW+tD5vDyB0aKmvgdPUsvZYzSDG8L
         LKUc9OsFLYAfDVBWq3JbgXEfpIH8JA8/0OEvIjOqBJZoV+s7cpTohxdLurbQ5H5cmHg7
         2fzw==
X-Forwarded-Encrypted: i=1; AFNElJ9WRWaSkQHJIlwrrkhpiDNdz4+FaZrZBdkdk3cBG0XjeazENiQ3SMh26HMT4e7sNPYnDZOqXjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAHm64Kznh/Z7MkVcnuxv3CVmQvphd44rl7APmjnycQnm3dpYz
	OWrmUPTVhZWxZ/QP7ru2Xg//WqtOV3anYyy1ZSI1l3piaObHtwL/LJm9
X-Gm-Gg: Acq92OG+YBNCPhFziyDVws80s6INBugj/tijsBbG++XZ9r+W0us2CaGlhYdmI/T2OfL
	PpFtr32Op37MESnA1+bGYoIYSaXY9W9hAvveCgzKlLnZdrHbqABhZTLlE6sXLo/m27C7bnXAU4e
	BgosuMxfQnQw05pJ3ca4OF/ocXyNhvkjf7uFmKSdtxVV1LxgjmG+I2ggZBMAEPd+oDpSxG7pZ1v
	SmOS3Pu/cu1x3PAmNTV553xR5MvxS8989RiT7j5GGa095NEtTEJ5cFcXw9kekxW7PH52psSXE+y
	KsBkubvvMUSVznnTZghBmAd+SF0SKb/k75rhxhNUDMBuWZlNM8YQr8O1YpX036svP1Y6h39dq1l
	URNqOGq+i1GkZ3oXkEdbjnLx5V1z2nm47FbrirZMjd+XOU8lZWgCPmVTXvH9iivjPXZxUBu3EVK
	E4mI4i53Vg7arXGCq7sKHeRSqH/B3mGHk3lggZ/AGxfvp7ap7OgRwk0LgoWI3UFQ==
X-Received: by 2002:a05:690c:c4c9:b0:7dd:63c7:39b6 with SMTP id 00721157ae682-7f655007fb6mr16817817b3.9.1781161992785;
        Thu, 11 Jun 2026 00:13:12 -0700 (PDT)
Received: from localhost.localdomain ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7f693504701sm2551487b3.15.2026.06.11.00.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:13:12 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: dongml2@chinatelecom.cn
To: jasowang@redhat.com
Cc: mst@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bjorn@kernel.org,
	kerneljasonxing@gmail.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next 1/3] net: busy-poll: introduce sk_tx_busy_loop()
Date: Thu, 11 Jun 2026 15:12:40 +0800
Message-ID: <20260611071242.2485058-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
References: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297978-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,intel.com,fomichev.me,iogearbox.net,gmail.com,vger.kernel.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jasowang@redhat.com,m:mst@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:magnus.karlsson@intel.com,m:maciej.fijalkowski@intel.com,m:sdf@fomichev.me,m:horms@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:bjorn@kernel.org,m:kerneljasonxing@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,chinatelecom.cn:mid,chinatelecom.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B306D66F48A

From: Menglong Dong <dongml2@chinatelecom.cn>

For now, we use sk_busy_loop() for both rx and tx path. The sk_busy_loop()
will call napi_busy_loop() for the specified napi_id. However, some
nic drivers have tx napi, such as virtio-net. In this case, sk_busy_loop()
doesn't work, as it can only schedule the NAPI for the rx queue.

Therefore, introduce sk_tx_busy_loop() for the nic drivers that support tx
napi, which will schedule the tx napi if available.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/netdevice.h |  1 +
 include/net/busy_poll.h   | 41 ++++++++++++++++++++++++++++++++++++---
 net/core/dev.c            | 26 +++++++------------------
 3 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0e1e581efc5a..8a771b014d54 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -416,6 +416,7 @@ struct napi_struct {
 	int			napi_rmap_idx;
 	int			index;
 	struct napi_config	*config;
+	struct napi_struct	*tx_napi;
 };
 
 enum {
diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
index 6e172d0f6ef5..0959e80272c7 100644
--- a/include/net/busy_poll.h
+++ b/include/net/busy_poll.h
@@ -33,6 +33,12 @@ static inline bool napi_id_valid(unsigned int napi_id)
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
 
+enum {
+	NAPI_F_PREFER_BUSY_POLL	= 1,
+	NAPI_F_END_ON_RESCHED	= 2,
+	NAPI_F_TX_NAPI		= 4,
+};
+
 struct napi_struct;
 extern unsigned int sysctl_net_busy_read __read_mostly;
 extern unsigned int sysctl_net_busy_poll __read_mostly;
@@ -49,9 +55,9 @@ static inline bool sk_can_busy_loop(const struct sock *sk)
 
 bool sk_busy_loop_end(void *p, unsigned long start_time);
 
-void napi_busy_loop(unsigned int napi_id,
-		    bool (*loop_end)(void *, unsigned long),
-		    void *loop_end_arg, bool prefer_busy_poll, u16 budget);
+void __napi_busy_loop(unsigned int napi_id,
+		      bool (*loop_end)(void *, unsigned long),
+		      void *loop_end_arg, unsigned int flags, u16 budget);
 
 void napi_busy_loop_rcu(unsigned int napi_id,
 			bool (*loop_end)(void *, unsigned long),
@@ -60,6 +66,17 @@ void napi_busy_loop_rcu(unsigned int napi_id,
 void napi_suspend_irqs(unsigned int napi_id);
 void napi_resume_irqs(unsigned int napi_id);
 
+static inline void napi_busy_loop(unsigned int napi_id,
+				  bool (*loop_end)(void *, unsigned long),
+				  void *loop_end_arg, bool prefer_busy_poll, u16 budget)
+{
+	unsigned int flags = prefer_busy_poll ? NAPI_F_PREFER_BUSY_POLL : 0;
+
+	rcu_read_lock();
+	__napi_busy_loop(napi_id, loop_end, loop_end_arg, flags, budget);
+	rcu_read_unlock();
+}
+
 #else /* CONFIG_NET_RX_BUSY_POLL */
 static inline unsigned long net_busy_loop_on(void)
 {
@@ -126,6 +143,24 @@ static inline void sk_busy_loop(struct sock *sk, int nonblock)
 #endif
 }
 
+static inline void sk_tx_busy_loop(struct sock *sk, int nonblock)
+{
+#ifdef CONFIG_NET_RX_BUSY_POLL
+	unsigned int napi_id = READ_ONCE(sk->sk_napi_id);
+	unsigned int flags = NAPI_F_TX_NAPI;
+
+	if (READ_ONCE(sk->sk_prefer_busy_poll))
+		flags |= NAPI_F_PREFER_BUSY_POLL;
+
+	if (napi_id_valid(napi_id)) {
+		rcu_read_lock();
+		__napi_busy_loop(napi_id, nonblock ? NULL : sk_busy_loop_end, sk, flags,
+				 READ_ONCE(sk->sk_busy_poll_budget) ?: BUSY_POLL_BUDGET);
+		rcu_read_unlock();
+	}
+#endif
+}
+
 /* used in the NIC receive handler to mark the skb */
 static inline void __skb_mark_napi_id(struct sk_buff *skb,
 				      const struct gro_node *gro)
diff --git a/net/core/dev.c b/net/core/dev.c
index 0c6c270d9f7d..645a2e851918 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6878,11 +6878,6 @@ static void __busy_poll_stop(struct napi_struct *napi, unsigned long timeout)
 		      HRTIMER_MODE_REL_PINNED);
 }
 
-enum {
-	NAPI_F_PREFER_BUSY_POLL	= 1,
-	NAPI_F_END_ON_RESCHED	= 2,
-};
-
 static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 			   unsigned flags, u16 budget)
 {
@@ -6932,9 +6927,9 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 	local_bh_enable();
 }
 
-static void __napi_busy_loop(unsigned int napi_id,
+void __napi_busy_loop(unsigned int napi_id,
 		      bool (*loop_end)(void *, unsigned long),
-		      void *loop_end_arg, unsigned flags, u16 budget)
+		      void *loop_end_arg, unsigned int flags, u16 budget)
 {
 	unsigned long start_time = loop_end ? busy_loop_current_time() : 0;
 	int (*napi_poll)(struct napi_struct *napi, int budget);
@@ -6951,6 +6946,9 @@ static void __napi_busy_loop(unsigned int napi_id,
 	if (!napi)
 		return;
 
+	if ((flags & NAPI_F_TX_NAPI) && napi->tx_napi)
+		napi = napi->tx_napi;
+
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		preempt_disable();
 	for (;;) {
@@ -7015,6 +7013,7 @@ static void __napi_busy_loop(unsigned int napi_id,
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		preempt_enable();
 }
+EXPORT_SYMBOL(__napi_busy_loop);
 
 void napi_busy_loop_rcu(unsigned int napi_id,
 			bool (*loop_end)(void *, unsigned long),
@@ -7028,18 +7027,6 @@ void napi_busy_loop_rcu(unsigned int napi_id,
 	__napi_busy_loop(napi_id, loop_end, loop_end_arg, flags, budget);
 }
 
-void napi_busy_loop(unsigned int napi_id,
-		    bool (*loop_end)(void *, unsigned long),
-		    void *loop_end_arg, bool prefer_busy_poll, u16 budget)
-{
-	unsigned flags = prefer_busy_poll ? NAPI_F_PREFER_BUSY_POLL : 0;
-
-	rcu_read_lock();
-	__napi_busy_loop(napi_id, loop_end, loop_end_arg, flags, budget);
-	rcu_read_unlock();
-}
-EXPORT_SYMBOL(napi_busy_loop);
-
 void napi_suspend_irqs(unsigned int napi_id)
 {
 	struct napi_struct *napi;
@@ -7579,6 +7566,7 @@ void netif_napi_add_weight_locked(struct net_device *dev,
 	napi->poll_owner = -1;
 #endif
 	napi->list_owner = -1;
+	napi->tx_napi = NULL;
 	set_bit(NAPI_STATE_SCHED, &napi->state);
 	set_bit(NAPI_STATE_NPSVC, &napi->state);
 	netif_napi_dev_list_add(dev, napi);
-- 
2.54.0



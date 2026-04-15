Return-Path: <netdev+bounces-278702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGlTDPhL32mFRQAAu9opvQ
	(envelope-from <netdev+bounces-278702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:27:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A891401F17
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D62003069BE1
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3983CEBA5;
	Wed, 15 Apr 2026 08:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLpOBdXu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C081B3CF691
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241640; cv=none; b=PvJI1UvAsWX2dJgw5MkVCHsp5RkQ5kDSTKRTk+9sdhKU5w/hQyh2b6pzKhxVX0lzJUBLf+PX+p8gz+CPkATABffaWrTuMw42/lTnSApMEtUsnxX8rE0G0xl9qlOqmgivrINXp0oYRoJfyG5b4GNjwPH9shfM/rQQbGyXxttSddM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241640; c=relaxed/simple;
	bh=QKTL8wrGcjy+XROomaBzZZvPjePUhieERP66xMR+sYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tknVaZSj9YwkGzuZEZK3wlQLNVzupnUYbPVAi4AEdNo//k7tpi+Dvo09qMqtdVN8wcumyi/t+fdvvX+tfZqG2jueP2m6Fg1OPkLmqpCANA5zuTSrET5ALa9BariTnZoUr3i80ziKsvEKIW/QH6oGG8VJGtQR+Bvw2ruDmPAzCQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLpOBdXu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ad4d639db3so33798545ad.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 01:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241639; x=1776846439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ok+e9//EJiei5glTedFKtnKWpLWhK+RKH8MheLrU5Rs=;
        b=nLpOBdXuSWy+AHSX+nNyLuX/NAy+0dHucC7fhn+QeQ9tZTJGMuSN47Mp9BjCDGlZ3j
         s0FGAT5xY4af1aTC/+bjdW9PhgeeO5F33C/oPvnPC4wXIV4Whggg17iVWNOQFXYgvdfm
         GGqeXQegSZD/mGS6AuDEf4CD3m5atEFfS6C0jq3l0RhNx3p3dRh+r8bMVVF7YWcF/9ta
         tEf/VvBWr3114wrN7uQGD/zpPjDdbAm62MYXdesOzsrSOg9PYXyxeJQXOUWqi/NY1ZLB
         TnhOgxGEpQ8hrbxRPadTMH1RFOYJTt1omiwhC21wwE9hmfkHbTlgaeWftiLun8rpsSCF
         F66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241639; x=1776846439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ok+e9//EJiei5glTedFKtnKWpLWhK+RKH8MheLrU5Rs=;
        b=Tng4oeUNu1I3SQrS+B8qQNg3EcAyJ8jYOlPsPEO/Ak4HFyjx9T/P4n3+QgKZLCbLwG
         Cx0EZXzyIJZ9UlEaaIrLPtu4MGmHJFLbHuhwxPTcsGHfMfX8YRElJJVl4tSUdWPeEHas
         D6vjeh2MUb/ZV3OTpit8b+ZlTZb9mciEFTaGNdR0dTqkxIOhODB2sYRAy3mfvHUapdUb
         uWv6zNR77Ip7chl72YHedyFZOaZ4gyCfcePGFyApW/GtKSntLmW0h/AC5nTIOHg3YX8w
         78oexxw+pmnS62jfb1DedWUeJncwD7vv8XihK2SgGKMmmird7HgvdKyu9GGyuhy5LsMN
         yM7w==
X-Forwarded-Encrypted: i=1; AFNElJ95EH409nEC3PeSp/sjgXCJ7Q4WKBbShh9pMe9Fqpo+X7+MY8wPWkJbXQgehG0YFzCDQYOlP7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhgh6aG1iwQeBA7trkdzAQRXkcL5bs+Q26bqzx9JCSuyWvyhwq
	97Z0T+mc1p506Ia50nuAzZ0lNz6mYTVoIAGoRdNuftzLJSdlY/dV+KB3
X-Gm-Gg: AeBDievVCB3266wNe6LjkAzClXyFu5pRq3Y3j4lJ4gNoiJ0/CB2ue1TiOONRSeP45Zp
	YnDDmdUhwrCjhT1//IUaW+wZLQQN9B4qc+eW/oH2kJlL2rBRNqnyWHOvuprFjnjZK1lbV8tS1Cr
	f9fcOWBE6CRti/RqtG8ffNsvMuuasJ60gq+kT89+jhZEFPwcI/OpnMuzs180tPCMStGxtFCrOr2
	uEKV7MunGpyjtbCRppfGFw2omkqIBCVxp9n1BGAl3Olon/z7Jzq1gAskTwELjmMNKbU26qW8yYr
	Jie0Gv3eJVtUA4IQsCSwgj6O9frrfhwbnSaE/2pZa+n+emOnICBoekUY25l8UblxJlCfXID29vS
	TVh5t1Vj/8E7YtC7Q/Bqtj53gPNVujMWGyb1HsxNRmCiexUK7DRXkpQwe5mkhZzZLrj9Bw2bLn+
	YpQ/wLuF6uEL0qqLxs6SxJR9c6UtcZD7H9K+XI7n3Tky8umE/t+oouPiv8tJ0oqrjC0t6paNd3e
	kGBg8Yz
X-Received: by 2002:a17:903:3e29:b0:2b0:5ae9:ee4 with SMTP id d9443c01a7336-2b2d5975cfdmr145359945ad.5.1776241639176;
        Wed, 15 Apr 2026 01:27:19 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782a93c7sm12174215ad.62.2026.04.15.01.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:27:18 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH RFC net-next v4 02/14] xsk: extend xsk_build_skb() to support passing an already allocated skb
Date: Wed, 15 Apr 2026 16:26:42 +0800
Message-Id: <20260415082654.21026-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260415082654.21026-1-kerneljasonxing@gmail.com>
References: <20260415082654.21026-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278702-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9A891401F17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

To avoid reinvent the wheel, the patch provides a way to let batch
feature reuse xsk_build_skb() as the rest process of the whole
initialization just after the skb is allocated.

The original xsk_build_skb() itself allocates a new skb by calling
sock_alloc_send_skb whether in copy mode or zerocopy mode. Add a new
parameter allocated skb to let other callers to pass an already
allocated skb to support later xmit batch feature. It replaces the
previous allocation of memory function with a bulk one.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xdp_sock.h |  3 +++
 net/xdp/xsk.c          | 23 ++++++++++++++++-------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 965cab9a0465..90c709fd1239 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -133,6 +133,9 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
 int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp);
 void __xsk_map_flush(struct list_head *flush_list);
 INDIRECT_CALLABLE_DECLARE(void xsk_destruct_skb(struct sk_buff *));
+struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
+			      struct sk_buff *allocated_skb,
+			      struct xdp_desc *desc);
 
 /**
  *  xsk_tx_metadata_to_compl - Save enough relevant metadata information
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6122db8606fe..ecd5b9c424b8 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -718,6 +718,7 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 }
 
 static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
+					      struct sk_buff *allocated_skb,
 					      struct xdp_desc *desc)
 {
 	struct xsk_buff_pool *pool = xs->pool;
@@ -734,7 +735,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	if (!skb) {
 		hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(xs->dev->needed_headroom));
 
-		skb = sock_alloc_send_skb(&xs->sk, hr, 1, &err);
+		if (!allocated_skb)
+			skb = sock_alloc_send_skb(&xs->sk, hr, 1, &err);
+		else
+			skb = allocated_skb;
 		if (unlikely(!skb))
 			return ERR_PTR(err);
 
@@ -799,15 +803,16 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	return skb;
 }
 
-static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
-				     struct xdp_desc *desc)
+struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
+			      struct sk_buff *allocated_skb,
+			      struct xdp_desc *desc)
 {
 	struct net_device *dev = xs->dev;
 	struct sk_buff *skb = xs->skb;
 	int err;
 
 	if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
-		skb = xsk_build_skb_zerocopy(xs, desc);
+		skb = xsk_build_skb_zerocopy(xs, allocated_skb, desc);
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
 			skb = NULL;
@@ -822,8 +827,12 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 		if (!skb) {
 			hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
-			tr = dev->needed_tailroom;
-			skb = sock_alloc_send_skb(&xs->sk, hr + len + tr, 1, &err);
+			if (!allocated_skb) {
+				tr = dev->needed_tailroom;
+				skb = sock_alloc_send_skb(&xs->sk, hr + len + tr, 1, &err);
+			} else {
+				skb = allocated_skb;
+			}
 			if (unlikely(!skb))
 				goto free_err;
 
@@ -943,7 +952,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 			goto out;
 		}
 
-		skb = xsk_build_skb(xs, &desc);
+		skb = xsk_build_skb(xs, NULL, &desc);
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
 			if (err != -EOVERFLOW)
-- 
2.41.3



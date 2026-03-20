Return-Path: <netdev+bounces-269819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM4HGaj3vGlW5AIAu9opvQ
	(envelope-from <netdev+bounces-269819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:30:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9622D6A13
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5D883036D67
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 07:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3B727FD51;
	Fri, 20 Mar 2026 07:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6me9896"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD7E2DCF4C
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 07:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773991833; cv=none; b=sdemuqI9vpuEPJxEZtqmAkenB5pgemlIljR6EGGMvebdid8uwYIkG2S8iswfqP5+nnBU3lrKwDK2v+otiNzLVLqaPKtDquC5S2+JGDtWm0RN9/Xm82QjmCnrPI78qns1WYw7XZ6XQmLT49mRPEn3yhAXvbFvdAG4bb4QVjumUr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773991833; c=relaxed/simple;
	bh=VmTtvLpeKQO5Y2kiwXZpXHqc0rLQnZxDq9Sen3bILZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qZg6no+T3Y9Xhc6gZiY7lg4To08Ga8dFE0d2063rF6BwfAwV/XYqibdJswXTMvCx5c2I9c0fYb8FxqP1k2pJuft2/ISGjPCbFzGTF1FoZYzCLks1sUs0rMo9ZnS3MH1aY27AjQtNcNcwfIPO9w0WbmwTgY1OMLikWgrvLXJfAHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6me9896; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82985f42664so1235198b3a.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 00:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773991831; x=1774596631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0EKZSuB/AoQE2+nK92YoyDWIhnKbiEvomcgy+9ah15Q=;
        b=g6me9896UWPSPFiIf1CodM1k7Px49E4WYJI/eavSilMk9yn07ryJHlYpvF6fd/sGsh
         62rMKutxyO+OktntwWtAQPS4XBOAFzv/wgYWQH7eDn0DPIeDRb4krJQOU4dxXv+LEiOG
         FpWc9mYy85JYzB4c+Dxp0LJ5fhBHOP8Fh1CZkFp/VS2qW/pJNUZZeWK1j708MQ+QLlu2
         uHVgQpQWGJ+AR0K/eoaT1NYrIO0S0puCdMo9Mbq8RAiAZlol+Ewl6pg1sz7REI7oLB+g
         2zOnuiA+QODGVR/ucCAY8ZUUH7TgYOhRrv0LpJxJ+sifICSDWpeNMR97w6tfAMaQGXCX
         uuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773991831; x=1774596631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EKZSuB/AoQE2+nK92YoyDWIhnKbiEvomcgy+9ah15Q=;
        b=eBYBoxc67TfCnkDIjnlwVk4reUhm7amnuy+2xljeNZSgQZAvoUUsR2mpgfjzfcIXEN
         SC20lJ6u/RAXLyE1kaN5fRlzRmx1T67P5zQ2Uv37ZUqytWxmT33jxZvghT9kSeGiXUzm
         80SaNaEDZEbaiC9ZY9Jg7JO5olT1wrybDgJl25YOWRpbR1Dq+1Ppx0oVnJsrWu68JGw7
         kWkVNJEkW+HW2v29MXkXt0XTGxjt33Gj7PzaeCDol16hxI67A/gvhfkXTBEqk+RoNKnr
         8/9A6ALjGmJJDFeNB/hoSQSolHS7v2bWHsLB0+NnVNo6CKhW6GemkDHFJq3ydadwAGEG
         BkKQ==
X-Gm-Message-State: AOJu0YzhVatmZYc1uinTWecXiSp3zlo6rpDF5L/tWtwGv31T/AiUub3O
	itSIyDGsrtnQP4BApkzxmTQbabAKLO0qzmZQ0m8kX3gP/euZLcdhoWVB6srJu+O1ryE=
X-Gm-Gg: ATEYQzx6q+AVZHlcs8DSAOeOt2N0yRfeei6/A5DiiG+VI9OGIlc0KxZ37dR6+kqylqG
	TKYDXeeFBZPEilxETutHB3+yzfWA22k+CZhyRIvUwzamlla1ZdVF3lq5JLupLFG/nSAO+5GQpE7
	RNMFuDDcap/rWcTrsHj+ezjIonGZKXAb+pzHpZ8KD6RcTZb+c0rpvDzEhO7RNC62xgbQnHzn8E6
	d3nqOAKpijFYzLMSmBpNaY65gZrTaH+pAVVy/pCUOYKK9hyctBneSixcg6Au/+XKHTTCmPw82gc
	6pHlj+dP/XbdTmwL4MtdCFRhzWkpgDuUgfeJ0eu+veymg5fCkMDNt0EdFJrsXmn3uoNaWCS8F/R
	SpJbdrZRgvT92fDbXjQHk9i3aEo6Dk0OAN4stQEo2wYIrcirrZiQqsO+ZQCgp09r4zyVST1lVve
	VZp3AzjZX2/sGacajfd7QvBNtwdquLiy48SLkCszCjvZbOBw==
X-Received: by 2002:a05:6a00:a85:b0:82a:18a2:91b9 with SMTP id d2e1a72fcca58-82a8c39435amr2028620b3a.49.1773991830963;
        Fri, 20 Mar 2026 00:30:30 -0700 (PDT)
Received: from localhost.localdomain ([114.243.117.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03bbf0c2sm1477677b3a.15.2026.03.20.00.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 00:30:30 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] xfrm: hold skb->dev across async IPv6 transport reinject
Date: Fri, 20 Mar 2026 15:30:23 +0800
Message-ID: <20260320073023.21873-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269819-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.943];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C9622D6A13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

xfrm_trans_queue() queues transport-mode packets for async reinject via
xfrm_trans_reinject(). The queued skb may still be reinjected after the
originating device teardown has started.

Keep the device alive across the async reinject window by taking a netdev
reference when queueing the skb and dropping it after the reinject callback
completes.

Fixes: acf568ee859f ("xfrm: Reinject transport-mode packets through tasklet")
Cc: stable@vger.kernel.org
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 net/xfrm/xfrm_input.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 4ed346e682c7..4b5147cb44b7 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -40,6 +40,7 @@ struct xfrm_trans_cb {
 	} header;
 	int (*finish)(struct net *net, struct sock *sk, struct sk_buff *skb);
 	struct net *net;
+	struct net_device *dev;
 };
 
 #define XFRM_TRANS_SKB_CB(__skb) ((struct xfrm_trans_cb *)&((__skb)->cb[0]))
@@ -784,9 +785,13 @@ static void xfrm_trans_reinject(struct work_struct *work)
 	spin_unlock_bh(&trans->queue_lock);
 
 	local_bh_disable();
-	while ((skb = __skb_dequeue(&queue)))
-		XFRM_TRANS_SKB_CB(skb)->finish(XFRM_TRANS_SKB_CB(skb)->net,
-					       NULL, skb);
+	while ((skb = __skb_dequeue(&queue))) {
+		struct xfrm_trans_cb *cb = XFRM_TRANS_SKB_CB(skb);
+		struct net_device *dev = cb->dev;
+
+		cb->finish(cb->net, NULL, skb);
+		dev_put(dev);
+	}
 	local_bh_enable();
 }
 
@@ -805,6 +810,8 @@ int xfrm_trans_queue_net(struct net *net, struct sk_buff *skb,
 
 	XFRM_TRANS_SKB_CB(skb)->finish = finish;
 	XFRM_TRANS_SKB_CB(skb)->net = net;
+	XFRM_TRANS_SKB_CB(skb)->dev = skb->dev;
+	dev_hold(XFRM_TRANS_SKB_CB(skb)->dev);
 	spin_lock_bh(&trans->queue_lock);
 	__skb_queue_tail(&trans->queue, skb);
 	spin_unlock_bh(&trans->queue_lock);
-- 
2.43.0



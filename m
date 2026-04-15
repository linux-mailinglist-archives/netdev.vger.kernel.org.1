Return-Path: <netdev+bounces-278706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAxWG05M32mFRQAAu9opvQ
	(envelope-from <netdev+bounces-278706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:29:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAE5401F82
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3635430D2C2E
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E163CF662;
	Wed, 15 Apr 2026 08:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKkPxbGf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28253CE4A0
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241660; cv=none; b=WYnt4yAkyFOpM2npyCy0Br3X1qI6CE+fvCCAoXCWEsEbiYFiQRTJEDLbfn0AiA6PQ1LUrXYOkOhIYyfeHzawW8y1BHajh6yTXkBgq1FITCq+6sQYX4fzFjJsiELny4xpxAeBfLd4jgb/wvus/N3fGG4imE69y7giCbU+W0JZDqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241660; c=relaxed/simple;
	bh=jHy49aFblnIvIRVscKFcvbhaJNd8YByECHZ/Ib4UU1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ED+IYOh0f01ii+8iKzYwQYi0wfZv8qCI7A4f3bQiU/bFsTEFPPO3jhaX3Tf3nhDG459x3AR+ZPU2HwNfOySK6rRwZFMTQlTvdZPgEBhWhB7rfudmjDacSyut4hXu1niU4J96TjmK5v3mGYWq988N8y0D3bBglTz+YJIWekuqObw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKkPxbGf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b0afa0210bso30650125ad.2
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 01:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241658; x=1776846458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKGpUVJw2BsQmKke/zYlvHk6/z9E5V4zdWGX8V1hKW0=;
        b=MKkPxbGfjROhdxLqc3xjeR8Cj7PSWwRScLNd3YjPoXb3pubnDknLoC2xBLo4tjjUrU
         AHfafQRrZxD9laMqMzMRbkKZF0hY3Oou3qPG6dLhL+8c3t6Bv74Amnu8kMfdFGWrDkVu
         1OPLeDV9rklQZBVToFWHVxBmKTgb+uhSO1LJN1iZGP4C6iu6X8FkAwjNuTYvObM6wxiM
         /rQeqx4pGYas37N+DzBuLJnhJDlLFcViiYt5ML/4dsXKgNq7HQejjZEOzQ1PM0bX5t6u
         Rt5JK9GyBtwt4DcVhFXiWGjOXqjkKHU38s1GJfQEQq4CcLZfKJPA5gQIGMB7BPUCL3/4
         BnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241658; x=1776846458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wKGpUVJw2BsQmKke/zYlvHk6/z9E5V4zdWGX8V1hKW0=;
        b=FgUMQO84/TAoUE5fIwdGmYCmTgQ7J3sa7olKLDzRuLaKtTXlIGcPavtsFz9JbWd1fC
         6AMtG+5TcQNsdA0IdaQ4TVtJ0eiTduEQCa3WoB6gZKEPninNwumXNaTQsg3qq746cj/o
         0jIc+cfIcgGdClTMEPRvVs2uHYwIcwOqSxZO70z0Ys9jwKnlmrE1T8k10Pu3TkzhrUhW
         i/kYlXngIDN09jvSgR/RIkLu56y3ZRZneYkvRMFYl84I/7zGggwugtuAsc0Zrtsnjzpw
         E1Jnt+hFlyBCltoG+V49GTbyfvYLm1YlIE6M98TrZaa9TmNgEr0wAR+/8bCYknXfvB0l
         E4zA==
X-Forwarded-Encrypted: i=1; AFNElJ+MJ9Dv93RdolX4XY3gxjW/odSmjXIctGcEYMEoNcGGB/k0+DkiUYXQQJ6L6PKddGKEE53Goxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ3t1dzEnVQcjYhyMBHfWXfRIKfnd8D+UxXMWcWaOmzjSKXvod
	ZEFwyEztowYBWXw8EzsBAaoIQtZa8Ts7iIRTJdPmHpJnNAVD7ZC27BwX
X-Gm-Gg: AeBDiev8iep9Ovgzi2Kq2edHlqM40CroqaPOrikPvIQMDfmu2Hc8VUHJ5i4XCYqmFXr
	u0ZncvbRvijcij9BlhM9/jExV0g1S3O1+yNT0uzBwF+Hhvqd7CVFkZtJpF85cpyO17l9fVovt5H
	bsgdyVqGufL6XLczKbtAzdXwTvrXQlNbvEKNlliamMaSd++vQ8+21Odt4YWIl9C6YjwqKUv5tSR
	ws8qHV6/ZHbn9chft0+NwMQ7b1xTZagAJAIig8exAGicxIUODSF55ga36MMkKksfXjGMED87Ran
	i1piISwGXKg0C86LVJM5BeZuemgTO+HoGRrUlAW/vdd/jBA8LOwnkwWZlNpPCzrGQWBdnyjdP+q
	1vNo+ZkPkk6ElDO2fsZC2jt8Z6ybz/h+hsCztFZEfH0YNnFyl2CGO9qqoq2T0OVMVi3wfSb61aB
	04lBjXBgcZld9//0rO+ls2brcSGmCzcZ95AFrp2vcIyTRPI9A2oJXy3JXjwL0MPE1QhquAcg4IJ
	1gOCIJE
X-Received: by 2002:a17:902:a506:b0:2b0:ba14:fc70 with SMTP id d9443c01a7336-2b2d5a8d6efmr152252535ad.42.1776241658285;
        Wed, 15 Apr 2026 01:27:38 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782a93c7sm12174215ad.62.2026.04.15.01.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:27:37 -0700 (PDT)
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
Subject: [PATCH RFC net-next v4 06/14] xsk: support dynamic xmit.more control for batch xmit
Date: Wed, 15 Apr 2026 16:26:46 +0800
Message-Id: <20260415082654.21026-7-kerneljasonxing@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-278706-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 2DAE5401F82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

Only set xmit.more false for the last skb.

In theory, only making xmit.more false for the last packets to be
sent in each round can bring much benefit like avoid triggering too
many irqs.

Compared to the numbers for batch mode, a huge improvement (26%) can
be seen on i40e/ixgbe driver since the cost of triggering irqs is
expensive.

Suggested-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/core/dev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index e33a2406d8ca..a6abd621a7f3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4901,6 +4901,7 @@ int xsk_direct_xmit_batch(struct xdp_sock *xs, struct net_device *dev)
 	struct sk_buff_head *send_queue = &xs->batch.send_queue;
 	int ret = NETDEV_TX_BUSY;
 	struct sk_buff *skb;
+	bool more = true;
 
 	local_bh_disable();
 	HARD_TX_LOCK(dev, txq, smp_processor_id());
@@ -4920,8 +4921,12 @@ int xsk_direct_xmit_batch(struct xdp_sock *xs, struct net_device *dev)
 			__skb_queue_head(send_queue, skb);
 			break;
 		}
+
+		if (!skb_peek(send_queue))
+			more = false;
+
 		skb_set_queue_mapping(skb, queue_id);
-		ret = netdev_start_xmit(skb, dev, txq, false);
+		ret = netdev_start_xmit(skb, dev, txq, more);
 		if (ret != NETDEV_TX_OK) {
 			if (ret == NETDEV_TX_BUSY)
 				__skb_queue_head(send_queue, skb);
-- 
2.41.3



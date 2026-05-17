Return-Path: <netdev+bounces-288780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONI2D4c2CmrQxgQAu9opvQ
	(envelope-from <netdev+bounces-288780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 23:43:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D449A56411B
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 23:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A89DF301B71A
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 21:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B46322527;
	Sun, 17 May 2026 21:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWaBxjQP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63D531F9A8
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 21:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779054202; cv=none; b=u+H8ZicPiJ2fKOyzjAPlzhV4lTWketJRvJFY6BfXJohN6zBss2OnDi9WXCVgm+/BSdaVEwZCUSkNtA0nNu4S4lY5pPVH4QOFFDUyhkph+pDatpCkWm60NjKvtXLTJwBFstonTeXbLqRIzn/yCh7Rq4rrnNpEOBHAyyWxwD9G8io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779054202; c=relaxed/simple;
	bh=x2SnDPx6H1QagNxCIExQTM0vo6QvPDaPGnXJCvJjNMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KRrlF2NXRWf4qyCvRlnrCtcpWdGXbA5fmaQZwbGCX9YoRVLJ5HrQT4sloKo9qk0aUh8CXd+4VRQIdISuu/N4a4ekT9v81jGrcoIG6hC6xSetOvxFdn2cctLVltxZOZZi7TnbZ8P0AYPYm86rm0PctPMX2khL0ZioG6f7gWJ8rzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWaBxjQP; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bc85eda6b6so6683475ad.1
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 14:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779054200; x=1779659000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QTe3wQNFzUmJo4OqUtxIUOB0CH2AbajczwxLdZTke8s=;
        b=hWaBxjQPSsTxT0ov4+m9HsfmhD25+HxsIeCWXohqy7DMFN4VTLfQ8650WtX3SQ8ta9
         OP9aB+qZAZ+RFd5xG2dkMkvVcmN4ZZvbBgSetwGv8YwwFaeEI+Mr8K3JTb5ES3hBJxkW
         rnLXwR3mHnZjVkVN1v6QrzuM0HT3hC676mIIUzB27qShHVoi7rp3RgJ3IQdHKyNfMo9F
         yAj0Lq9X0X7jv0Y5Uq/zEJVewsiNDi/ALPXDO8EWGIr9trAddbefTCbtr+FTQBReSva7
         VHt6lM5q2u4kKgnAgNYN5bW5SMK6LIv5vtSX0q6tO7ZOOBCv1QR4it5IByQZMiszjYUF
         f8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779054200; x=1779659000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTe3wQNFzUmJo4OqUtxIUOB0CH2AbajczwxLdZTke8s=;
        b=KoW0TvpfgwcxEJez1xmb/13lE++vNPtvg6+jcy5PV4IcBQ1nnNMeOthifdkk8tztey
         ryU4yYtLCbRWqcfJ8hoDPJ7VPYuyEg6oswnFnUlSAYNrbvuEL5saVvo6IvZUactszCbU
         fS0rgplRsyxT+E6uFDAP7onFLREnz9n/00ZVcDg9/wEWFtdJUUKAhctRiMWvScmZfqdP
         EFa16wKemOSsWlWRMf6trWJOcMK0DqBAuQV4Iw5s0045FqqEqpFV2hAzaEvxEQBW2U8D
         RfKDwccSqW8mBryrzSOCVUk+Qabvv0JbJQxoBrV5+5DmCIDV1LqSusNzanBF+Gs1iiJS
         WYrw==
X-Gm-Message-State: AOJu0YxJV2HbEClE8yMD/0WNdg3jcHJjyuYVq+Vfe2kn8xf8Mz9vjiHr
	/KuWvaQWATDugvfThRWWL0VtIIuJV9/k10HuC6GukzxipWI7kM9VMECn6ATDig==
X-Gm-Gg: Acq92OE4jkWN5QvkDOeBxoVHYHg8KWpa2qcVGG+xar6Niqg3vVrvUk/D7tvxtI0eAVj
	eXBmsFJJAcm7WnNZs43WEuDPDuXs3ZJEptkwqCWNKpcFT+pw7AYn04XZw6x39M5KK+cGxu7LUP5
	I4M8uqyV5Jd3WmYEuGFvxZ5QRohjJXRsFkWnb6NxvG5IIrcgcDHKnbPJQ5M3z+2ayjUoFH4+1RK
	8m0SlFQ9BnABHMEac4t6fz822gN2Q5I/ZzCTTa6iVAeo8PTniWJqCFkhG8L5zfAIiOD3n1oAa2p
	55L7Ll4tDvhRA3mdomtywPWVjBr7pgG86tH4y8dKwvrUkk1+kdx1tFtY4Tr9uvw3iYCXuemXXqb
	mx1qMaZe8t4RFWklkq6+c7DvX5Rc1VD+owZ2LsSe8B+aZC/zDL4nIjgLsG1OXQplE5kPbcqRCOT
	KfKStmgR9FaVRCWSUn5AEbHt8ngl+WbjRVOWlyQgN+di3vCOTza6XAaJK5V7wsYA9klSMEBIzgV
	HvXgySV0FCXSzzTbkYxLwR+04y9mmpvjQ4=
X-Received: by 2002:a17:903:3c28:b0:2ba:bfb5:9cc with SMTP id d9443c01a7336-2bd7e8d3b9fmr141367515ad.26.1779054199825;
        Sun, 17 May 2026 14:43:19 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe6512sm128545545ad.52.2026.05.17.14.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 14:43:19 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: ag71xx: Unmap TX DMA buffers on completion
Date: Sun, 17 May 2026 14:43:02 -0700
Message-ID: <20260517214302.1450433-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D449A56411B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288780-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Store the DMA address used for each transmitted skb and unmap it when
the skb is completed or cleaned from the TX ring.

This keeps the streaming DMA mapping lifetime paired with the skb
lifetime on both normal completion and shutdown cleanup paths.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index ac4eadb9190a..50136d6ccda6 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -305,6 +305,7 @@ struct ag71xx_buf {
 	union {
 		struct {
 			struct sk_buff *skb;
+			dma_addr_t dma_addr;
 			unsigned int len;
 		} tx;
 		struct {
@@ -805,6 +806,8 @@ static int ag71xx_tx_packets(struct ag71xx *ag, bool flush, int budget)
 		if (!skb)
 			continue;
 
+		dma_unmap_single(&ag->pdev->dev, ring->buf[i].tx.dma_addr,
+				 ring->buf[i].tx.len, DMA_TO_DEVICE);
 		napi_consume_skb(skb, budget);
 		ring->buf[i].tx.skb = NULL;
 
@@ -1133,6 +1136,9 @@ static void ag71xx_ring_tx_clean(struct ag71xx *ag)
 		}
 
 		if (ring->buf[i].tx.skb) {
+			dma_unmap_single(&ag->pdev->dev,
+					 ring->buf[i].tx.dma_addr,
+					 ring->buf[i].tx.len, DMA_TO_DEVICE);
 			bytes_compl += ring->buf[i].tx.len;
 			pkts_compl++;
 			dev_kfree_skb_any(ring->buf[i].tx.skb);
@@ -1531,6 +1537,7 @@ static netdev_tx_t ag71xx_hard_start_xmit(struct sk_buff *skb,
 		goto err_drop_unmap;
 
 	i = (ring->curr + n - 1) & ring_mask;
+	ring->buf[i].tx.dma_addr = dma_addr;
 	ring->buf[i].tx.len = skb->len;
 	ring->buf[i].tx.skb = skb;
 
-- 
2.54.0



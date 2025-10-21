Return-Path: <netdev+bounces-231265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAD3BF6B21
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 15:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD04119A59CC
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F04F33509D;
	Tue, 21 Oct 2025 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gi1JkRra"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BA833343D
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052379; cv=none; b=ufAiMB3JZ9VHS+eEHk6Ofq/5XezFVJyY5p14vWwuJDJP3fY+lLWjcyva+TX1Npsp7uK/5medK/gYT/JQTvMPnkCoM0V0xq21ahyKBhXdK7REKgiM+bebqu+XPh8OLNzWbQ8xJfaU1inXYas6wJI0uuqb50sJsR+fzZH+3itcBFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052379; c=relaxed/simple;
	bh=3vA2quocWxoPw35Q0g5YPXiKaeWvWJs/40Scose6BW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tuotUuOTEoxRSop0tq+Lrw9B20cjzXaEL91HkWyuSxb+mXri2i1RPkCVczzAFIrsHxCsEf1yEKB83jWSpMtNZVvpNDJZES5nfZbKsIM4VVeXirNiQYFz1o0DZGpm2Cirf7x0oS7e0ZygZYIwFZuyM/iagPBAZgCIFKI8lqfvmUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gi1JkRra; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b5526b7c54eso3604704a12.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 06:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761052378; x=1761657178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0J9AlILf7V4D1Au1RXOMSOZ2C2qDTTD0ax0CV2Rs+R8=;
        b=Gi1JkRra8pX14OjAHVSKor8cxThHXe97BfJAHQonQ/QIAxRXZ6aMEHv6/Qxzppf6Jk
         J1789cUusuDkIeJIoSVadUEZN8eg+PX/bw2JbybtGVlHE5JcRbZhq9UL4pEb3fuVzwrx
         u7WPKeJySfCTfenTiZjT9+SlDPXYdbQwZRPZIOP1sHqZ0bNFK6hXJK8ZgSHS712rXgRg
         3DbFxhzy/zLfob1kRZIvzhWeaPG8wzDvpoKxnBYSxJharvjWeOD4y4dy80RtMk80SBxK
         66gI7u4RnHEhjU4j4iyJG9r3hCOIEv3mSWMoXKOBCh80ds49b2l4bBMXeC9r+nj26Ib+
         wuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761052378; x=1761657178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0J9AlILf7V4D1Au1RXOMSOZ2C2qDTTD0ax0CV2Rs+R8=;
        b=Vvd1OewNwNjHeITE/kxCh+hOi1NuoFPwfKr9g15w5ZcuTb0OkMoHutFtFbsHKrIV4T
         e4thj18pavKwNKAJfd2X27+dhyPFbyOorJ8Q4DykXzL5+EEdfnY/Mi1RVRJffRILFIeO
         5ltUt6PANmodv4ZNIEK9/oQXxSHRdvlSorlI1Pj4rt+rRy0g2XxS0c+sf15t/i355aXf
         yOyDfzUtimee3HU9uv96dVFWQ2BeWfg3tUbZY2HGjfFX+lYkA3wB2hWABmonW3cFoH9y
         YGFgv6fVSADA4WJa4i50sPsklW/nqL8MzK0QVm9x9Zm97Z0CUImp1cDed7T4YCANSIPD
         pJ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXL4yEIBmCkyYfNcNnKAUo0QKBaPPMOJzDOwJmqWyyHrLeNCpb0O0CbRxzEnttUfCA7c+6lNVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmt0uuPoyOJR/hQtjlE9aWM62XWwvgS1LtiAJMhBmHFLPS9Fn9
	dVe7vRoEiEvRU4LrakB5rRweo6vHr4n5rs4Qlt+WIum/oDqDspVAW9Ki
X-Gm-Gg: ASbGnctNpLwqKmtosSz2xuByLtAimMcLgcJZ5KM2RZOBfftP0zFrSnma7XJUd7Bo2BX
	hlbn1Qv+uICX0mxyexxkuxtJ4jYzf28AWyxouRvqt+lCyFTydc/7Y+UV6JwWNrWBUq2qKMxk/MI
	1SpNnU7iMa9IVeZwTqGQ/3cD3QqkJncfQyBxiZIjLKuVGFjqMfGA0iLXR4A5jkhd0l/5YTl06i1
	eG7M5y2f23ZfOQO2IoJBQocv+eaexBA8PMQPtdIh0BWZxiZQXKbz55JVkpParR6cQfSSxSzF9vW
	+mCGnAY9ojuhwksNmb7gkWRPMDvU9NyLrL3oVUpfNvcx9M/5ffF61Yn3tXpEQxSnKcEKRIWm1Xx
	5LOIw7arf1cioBKB0j1jYdSspkawPp5Qmes4Wa9lfyF/02zWf4SqpQTta0jfNT+LnwW9Fd6+GxG
	MTf+LsO6TyTteu5+TrQOB/1uqbRWxDaVfO+1Othuga7fXlvO4mcepcoHQzew==
X-Google-Smtp-Source: AGHT+IE4lT5b8cTiZmWZmJX7MrCpLpLchp206t/ZR544MdNKlLrKXcMiO0LVoYY2V7Qz1tJK/WSQPA==
X-Received: by 2002:a17:902:f548:b0:25f:fe5f:c927 with SMTP id d9443c01a7336-290ca1214e1mr240139555ad.31.1761052377763;
        Tue, 21 Oct 2025 06:12:57 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fd9ddsm109248175ad.89.2025.10.21.06.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:12:57 -0700 (PDT)
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
	john.fastabend@gmail.com,
	joe@dama.to,
	willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 9/9] xsk: support dynamic xmit.more control for batch xmit
Date: Tue, 21 Oct 2025 21:12:09 +0800
Message-Id: <20251021131209.41491-10-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251021131209.41491-1-kerneljasonxing@gmail.com>
References: <20251021131209.41491-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 net/core/dev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 32de76c79d29..549a95b9d96f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4797,14 +4797,18 @@ int xsk_direct_xmit_batch(struct xdp_sock *xs, struct net_device *dev)
 {
 	u16 queue_id = xs->queue_id;
 	struct netdev_queue *txq = netdev_get_tx_queue(dev, queue_id);
+	struct sk_buff_head *send_queue = &xs->batch.send_queue;
 	int ret = NETDEV_TX_BUSY;
 	struct sk_buff *skb;
+	bool more = true;
 
 	local_bh_disable();
 	HARD_TX_LOCK(dev, txq, smp_processor_id());
-	while ((skb = __skb_dequeue(&xs->batch.send_queue)) != NULL) {
+	while ((skb = __skb_dequeue(send_queue)) != NULL) {
+		if (!skb_peek(send_queue))
+			more = false;
 		skb_set_queue_mapping(skb, queue_id);
-		ret = netdev_start_xmit(skb, dev, txq, false);
+		ret = netdev_start_xmit(skb, dev, txq, more);
 		if (ret != NETDEV_TX_OK)
 			break;
 	}
-- 
2.41.3



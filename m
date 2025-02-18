Return-Path: <netdev+bounces-167339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65186A39DCE
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2183AAF3A
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCB026AA84;
	Tue, 18 Feb 2025 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nYWcyrtA"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814EC26AA81
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885539; cv=none; b=W8L2ttrTEKMEumjYoqB1Py/2zFTO1MCBqkbS1H7y/6t7pxkKEAj2lj2mkJYJaL5gCN4UoLJqmaZPWrtq86or8Ea529lBVn2mGjWZALgs9417Gk6qusj+K2WDbtgbNEkTDscJBt3puwXgc5aH7mQNRFLJB7njQii9INQQm1uGm2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885539; c=relaxed/simple;
	bh=Y4bb2gMg2fhQX3UumMqYLIY1mVeZXXRdQb69m4+STL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAnAMfoeGeyBIgFf7PA8s95VgH4FX80Yy8QyWp0lKzi5082RXwl5N80YX33Yaiwkx2ASslrDptjELTCg3fDtP0DqEThAMXOII7mrT1no/+1LM/7A26nPh6fThNIZmDKqOCD00R81VGPlfGqttTnxWUOksMnKgdCCrUxNYpbET/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nYWcyrtA; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739885535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYjio39CMFV+Mh6EEVWTUj22Y7RBm4Gi+VVLarh3BvE=;
	b=nYWcyrtAK2xqFBLaFB3HRZ2IxF6NVcxEUBcKDh3zyZQWxiykNSn8cdkIATx4O8gqFXFcFO
	zQKPogA0Fqj2JT0l8VZq+u17y2o8/NEq4uWXQJ9xvnpmCf5lliRWyiM+q2CHGn2pLml/s7
	zOpGSd8FzsLEdoNwn75vLxGoPb6NK8Q=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.ne,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ricardo@marliere.net,
	jiayuan.chen@linux.dev,
	viro@zeniv.linux.org.uk,
	dmantipov@yandex.ru,
	aleksander.lobakin@intel.com,
	linux-ppp@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mrpre@163.com,
	syzbot+853242d9c9917165d791@syzkaller.appspotmail.com
Subject: [PATCH net-next v1 1/1] ppp: Fix KMSAN warning by initializing 2-byte header
Date: Tue, 18 Feb 2025 21:31:44 +0800
Message-ID: <20250218133145.265313-2-jiayuan.chen@linux.dev>
In-Reply-To: <20250218133145.265313-1-jiayuan.chen@linux.dev>
References: <20250218133145.265313-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The ppp program adds a 2-byte pseudo-header for socket filters, which is
normally skipped by regular BPF programs, causing no issues.

However, for abnormal BPF programs that use these uninitialized 2 bytes,
a KMSAN warning is triggered.

Reported-by: syzbot+853242d9c9917165d791@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/000000000000dea025060d6bc3bc@google.com/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 drivers/net/ppp/ppp_generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 4583e15ad03a..a913403d5847 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1765,7 +1765,7 @@ ppp_send_frame(struct ppp *ppp, struct sk_buff *skb)
 		/* check if we should pass this packet */
 		/* the filter instructions are constructed assuming
 		   a four-byte PPP header on each packet */
-		*(u8 *)skb_push(skb, 2) = 1;
+		*(u16 *)skb_push(skb, 2) = 1;
 		if (ppp->pass_filter &&
 		    bpf_prog_run(ppp->pass_filter, skb) == 0) {
 			if (ppp->debug & 1)
@@ -2489,7 +2489,7 @@ ppp_receive_nonmp_frame(struct ppp *ppp, struct sk_buff *skb)
 			if (skb_unclone(skb, GFP_ATOMIC))
 				goto err;
 
-			*(u8 *)skb_push(skb, 2) = 0;
+			*(u16 *)skb_push(skb, 2) = 0;
 			if (ppp->pass_filter &&
 			    bpf_prog_run(ppp->pass_filter, skb) == 0) {
 				if (ppp->debug & 1)
-- 
2.47.1



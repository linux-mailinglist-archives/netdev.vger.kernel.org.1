Return-Path: <netdev+bounces-142547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2A09BF93D
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 23:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5779284703
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 22:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0377B20D4F8;
	Wed,  6 Nov 2024 22:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="C2MQmZ9y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FEC20D4EC
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 22:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931989; cv=none; b=qdYphlbGPuI8Quz3zmpHec4oU+zi/n996s6sNxba4XV+cIF6PI/jqW4YVBhLSBEMvJnxoSJFEtRno/B57XrZWCrtLo1Iy3QTtEHWUFPEdMw4bbauv/j3MSFavGp1dR5s55z/sRAHI2/YvdPZeEXNukiOfmUmDTkdb5+IwZWeWzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931989; c=relaxed/simple;
	bh=/m+0uR0MlsRfpngmViBSR0nIX7YXBrTZrqLMMXQ606w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=elWTtJRVb2api15pHXrOVxaqGO73ZL6YFL+v5OE3y3DwRG87z7y9JOHRY9Q9Ryb8rGx2eE/ABEP3vjYQkPQc+rGn9LSTf/GE52VWdvaW0yFYV7oLpPsav7IvC1mq9S2UEXDZpwKvmxSw9jWCseFUxBaT52qVg4qPXXxJgkP1VGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=C2MQmZ9y; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7181885ac34so253933a34.3
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 14:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730931985; x=1731536785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TeP94uGFKCrHms83cSM4YiyobYdbFTOX87WRlt5MwE=;
        b=C2MQmZ9ysH4LaYMsCpb4UYkomJ58e6HhRecTAObLnn+2p7Hg0rYlBEaobg/IBrwBSD
         GXAHvSkPFVq4RxP8LMW86EC3GLQodabf4R/E6jshoDSJJ+bVhep2pW3hD65qBSL0v8MC
         Jx3y3KMdN4dvfiLZv2djfYgDDmCtgnlrMAZeMi/KMRZFqmoRHYScrV91SX0pD1N/5bGF
         82kZSoMhbedk+ThHWclFGtFD/WNPwk2HvCweXfDtb0qqdkDYk5AlexWrRqL2gmqu7e47
         bxZIo1JJZpi5hvOEgnzetOgxb3G70UcFGma6eUPrl2u1MG0YFXJs/Zn6AyccEb6Yzki+
         8pLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730931985; x=1731536785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TeP94uGFKCrHms83cSM4YiyobYdbFTOX87WRlt5MwE=;
        b=KbrTVDhT7j+k0OUG765VlfKMODscw9WUM41J53JAcO3Cccndz6MRNZ6AZhCXer8ABZ
         OCY/h329PhkHn1lBQHIVFcFsBwqy70bt+2nzCLeAGhkkHp2RrLpI1h66ospK3t2StqAY
         7FLsnskuWK4ikPWb549AoFQsH8Wf9kD1wvWanajTb7VTcGTIRQwAq+YVybgzKjFm8Yq8
         VCLgW4xGvd7skKLB61+aWzVWF3ECdn9pIho/XT3Y7gNoMZn+oMJhRx4WEiSg5CcBStAP
         EF7CZ8Jlpz7M6zlg2fzQHMUYZ+XsCphDLTqGCD/IjnQG82CpoVfwy9KuDDb2XRs5YHeV
         WZoA==
X-Forwarded-Encrypted: i=1; AJvYcCWu8uYzBLgv/5mceEB+UhkeUaaYBICdTCoBax6ZO/bT8UNGUv/7ZBC/M4crcSZ7YUXX3KqEkIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNjTc40c5Hvp9tmGbJd0T3bzuiHRPW4WRtnlkHlUfMlqX74ud7
	n8zfjHf6Lki/6XLHwnBl9qn/ZCDHZrXziZvgIPXDb8Zffp0ZlbVOiVCTxJC5etw=
X-Google-Smtp-Source: AGHT+IEDbyL+ocJjaFcUDxCmW0bULbH4cOPxfLI9IqKQtRqet0QC05czQrSXaQEQ9wLVSuo/eOAQjw==
X-Received: by 2002:a05:6830:6e82:b0:718:5a53:cc61 with SMTP id 46e09a7af769-718682964a8mr41678703a34.30.1730931985518;
        Wed, 06 Nov 2024 14:26:25 -0800 (PST)
Received: from n191-036-066.byted.org ([139.177.233.211])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32acf6c46sm2536585a.127.2024.11.06.14.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 14:26:24 -0800 (PST)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	jakub@cloudflare.com,
	liujian56@huawei.com,
	cong.wang@bytedance.com,
	netdev@vger.kernel.org,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH v2 bpf-next 7/8] bpf, sockmap: Several fixes to bpf_msg_pop_data
Date: Wed,  6 Nov 2024 22:25:19 +0000
Message-Id: <20241106222520.527076-8-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241106222520.527076-1-zijianzhang@bytedance.com>
References: <20241106222520.527076-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

Several fixes to bpf_msg_pop_data,
1. In sk_msg_shift_left, we should put_page
2. if (len == 0), return early is better
3. pop the entire sk_msg (last == msg->sg.size) should be supported
4. Fix for the value of variable "a"
5. In sk_msg_shift_left, after shifting, i has already pointed to the next
element. Addtional sk_msg_iter_var_next may result in BUG.

Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
---
 net/core/filter.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 4fae427aa5ca..fba445b96de8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2919,8 +2919,10 @@ static const struct bpf_func_proto bpf_msg_push_data_proto = {
 
 static void sk_msg_shift_left(struct sk_msg *msg, int i)
 {
+	struct scatterlist *sge = sk_msg_elem(msg, i);
 	int prev;
 
+	put_page(sg_page(sge));
 	do {
 		prev = i;
 		sk_msg_iter_var_next(i);
@@ -2957,6 +2959,9 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 	if (unlikely(flags))
 		return -EINVAL;
 
+	if (unlikely(len == 0))
+		return 0;
+
 	/* First find the starting scatterlist element */
 	i = msg->sg.start;
 	do {
@@ -2969,7 +2974,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 	} while (i != msg->sg.end);
 
 	/* Bounds checks: start and pop must be inside message */
-	if (start >= offset + l || last >= msg->sg.size)
+	if (start >= offset + l || last > msg->sg.size)
 		return -EINVAL;
 
 	space = MAX_MSG_FRAGS - sk_msg_elem_used(msg);
@@ -2998,12 +3003,12 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 	 */
 	if (start != offset) {
 		struct scatterlist *nsge, *sge = sk_msg_elem(msg, i);
-		int a = start;
+		int a = start - offset;
 		int b = sge->length - pop - a;
 
 		sk_msg_iter_var_next(i);
 
-		if (pop < sge->length - a) {
+		if (b > 0) {
 			if (space) {
 				sge->length = a;
 				sk_msg_shift_right(msg, i);
@@ -3022,7 +3027,6 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 				if (unlikely(!page))
 					return -ENOMEM;
 
-				sge->length = a;
 				orig = sg_page(sge);
 				from = sg_virt(sge);
 				to = page_address(page);
@@ -3032,7 +3036,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 				put_page(orig);
 			}
 			pop = 0;
-		} else if (pop >= sge->length - a) {
+		} else {
 			pop -= (sge->length - a);
 			sge->length = a;
 		}
@@ -3066,7 +3070,6 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 			pop -= sge->length;
 			sk_msg_shift_left(msg, i);
 		}
-		sk_msg_iter_var_next(i);
 	}
 
 	sk_mem_uncharge(msg->sk, len - pop);
-- 
2.20.1



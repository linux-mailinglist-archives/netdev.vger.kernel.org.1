Return-Path: <netdev+bounces-208361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFC5B0B22D
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 00:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63C427A1868
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 22:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAA7238141;
	Sat, 19 Jul 2025 22:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lmw6GRfM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FA62F84F
	for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 22:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752962655; cv=none; b=JjLM5u1Cz+OYwiQLV2eu/465M6vWbfeazDNjVvSaQpDSNclIjMlBdmpIvLU29udxAZmaOhYJzyvge3kxSUwuHcVQ8lhaZQEvLVpazbQv0gVamGaCjoi8U3QdVxW1qFduhThaZYauHEVQeR9LsDBdLlZKWdAkjiO4HqAxSMopcuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752962655; c=relaxed/simple;
	bh=2hTb2QC7sL/CMamg/AhPC0pJqvd9FKwND2gkcotQWRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y01z1lYem58Y7ri6fNuykETl5mJLUUje3tDgTEx99h/H4AQd/o25dhRX0H5P72n5+3DNmjA20eNjFIRy0ZDjaLMAJqeB9ZOv6o+t+91zVX9XB/ltz6oAV3wjW4zxoWTvTe81d5UXZSCeiTePaQ42yTrM6dPWVOLIGjB6ef1fBXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lmw6GRfM; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7490702fc7cso1998698b3a.1
        for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 15:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752962652; x=1753567452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vb3DZ0o3a+Dpyv4IF3cbPunb55Xkkpv2ILUuqm/qt1g=;
        b=Lmw6GRfMS6L6VyqzPWCLehYv4dH1ZiEgS5fMj1uSmy59bQ5pLtuQMn0Zm33iTKZVEv
         MhrFzIXuc5WNx/VMKqime8uvwU2l8pCLqLnbKzskAZnqesQQuNJYAr8SUWoR8CWNZsrI
         SNH3G5aS3TLtwsvQrA3oq7wbVcCNyiMDHwZl6S6HXtC3MdrbySCJToygIdm04MWjvHeX
         qNjv8NJPWaNLICq2gEhdTxqb6LOaiQ9/Q40A3xyYrP/Jm6rGWW5H4ZtnxcTXljLimHii
         MkS7FmG31Z28Q+to0M3iEX/LxF3DwKlNHUUwkxUVHS1ztnQfcDnnyoRoOmcDiKW44exJ
         MU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752962652; x=1753567452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vb3DZ0o3a+Dpyv4IF3cbPunb55Xkkpv2ILUuqm/qt1g=;
        b=i5OshV4ej2mA6k8yE/DzSbIILdfLMMStwZcSlqBQrlF8Utvmq8W6cxMCQSy1WNE5GU
         imwboJtAgLIwvjTUm53AEBwefidSaehjNUw4DyBZfg557W5uz9bWzimsIoFE8UfVdqXE
         il0Sdc7iU98ZxcCUkJpS9KfDqP8j/kzNlzdq4Q9w8TQm3BZ8BNe3yUa2392SpcIHq2SM
         R/Em2wf+lIfBnjh2fQbPa8dXvgsImAQnu9lcq/LSNQTnsezwv+uNziU4BT5jr8+5cAHt
         res1UrWrO+NAAOnSWTn8NAeLSBSCToAEcAJ7rM3hhsUUhVmRvOYA0VaXUetzFOoB+/Bc
         MyFA==
X-Gm-Message-State: AOJu0YzYkCKySCE8bxhliilqNmQp29BycaTlZF3J4B6RN+jzfI31IRFI
	KaBh41Qnf4D3xN6gUfhugnxgoljIvWJUeANd+4qzQAnAmE3FKOohe0zK1vn3aQ==
X-Gm-Gg: ASbGncvF3XmPif7LL9cfyjgIDeBONmceOMK1BwfdhMADKChyhlfUXBnS/Mb33s9qLO1
	QgzI6/y2WphHtrhkOzu+dj+UcY2ieeuMfLZ+iFsxOMXS6vocJW7v/pTwuyjILKNwWWl1l8vuE2T
	6CNM9StOtzMDZqS6UNVdGXhxejLHXyFIDudvi0aTQ/bS5WIxw20Em8vzJrYGAGDzq/mV0MJjX0L
	zzgyOK3x6+M2r59ae4D4IXU0+cPjreO86jTI+GHyvgCd+F/XlHd0/C0BMC8rQ+vkdGklMoXI85z
	6xPPH8bEhOaWU2FH/0X4958N1Nria7XAdRGuoMAL1xlXdthUNaGrPeHoh5BVcpIvx1EEolEfL8I
	a2RWnyGyIk8LKeXR3FTxon6iD+3dhfemIN2Za2A==
X-Google-Smtp-Source: AGHT+IH5npskwqGhmV0tIrYTknpfIMTBv7YKRtGr1OVidz1uQSuqgA3Z0iypVGNlmpoEoEUZmND5pQ==
X-Received: by 2002:a05:6a21:3299:b0:231:c295:136d with SMTP id adf61e73a8af0-237d5a04b98mr26714984637.14.1752962652320;
        Sat, 19 Jul 2025 15:04:12 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:b3bf:9327:8494:eee4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe6a09bsm3084040a12.3.2025.07.19.15.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:04:11 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	will@willsroot.io,
	stephen@networkplumber.org,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [Patch v4 net 2/6] net_sched: Check the return value of qfq_choose_next_agg()
Date: Sat, 19 Jul 2025 15:03:37 -0700
Message-Id: <20250719220341.1615951-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250719220341.1615951-1-xiyou.wangcong@gmail.com>
References: <20250719220341.1615951-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qfq_choose_next_agg() could return NULL so its return value should be
properly checked unless NULL is acceptable.

There are two cases we need to deal with:

1) q->in_serv_agg, which is okay with NULL since it is either checked or
   just compared with other pointer without dereferencing. In fact, it
   is even intentionally set to NULL in one of the cases.

2) in_serv_agg, which is a temporary local variable, which is not okay
   with NULL, since it is dereferenced immediately, hence must be checked.

This fix corrects one of the 2nd cases, and leaving the 1st case as they are.

Although this bug is triggered with the netem duplicate change, the root
cause is still within qfq qdisc.

Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
Cc: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/sched/sch_qfq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index f0eb70353744..f328a58c7b98 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -1147,6 +1147,8 @@ static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
 		 * choose the new aggregate to serve.
 		 */
 		in_serv_agg = q->in_serv_agg = qfq_choose_next_agg(q);
+		if (!in_serv_agg)
+			return NULL;
 		skb = qfq_peek_skb(in_serv_agg, &cl, &len);
 	}
 	if (!skb)
-- 
2.34.1



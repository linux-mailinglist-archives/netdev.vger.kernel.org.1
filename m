Return-Path: <netdev+bounces-191357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B5EABB22F
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 00:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53FB27A3478
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 22:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594612080C1;
	Sun, 18 May 2025 22:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBkNeKYc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA75192D97
	for <netdev@vger.kernel.org>; Sun, 18 May 2025 22:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747606871; cv=none; b=BKnOQTcsCFN/C84MXINzEiZtu346CqWW/anqS1XcAgr1LRfGwws2qMUWiC2067m5C4iyROyPaYrz1grNa+ADveTeOnMmLy7blxEP1GvDSUq3KTeSg4mu66MDlZLHHa8lT6+lC6h/7kAP8A1s2iHEb8NGW+whm5/QR6g1+ZSMc8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747606871; c=relaxed/simple;
	bh=/Tx0MkTyKrNFhiLgftFEImSRLjKERA8ez8U7Fc3JJkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JIQFvhjpEpRC51jHY+udYDgAy+JaGIY+h3WTtR59tvzlHKuv3Egb9XTgpfSZSyemWsxLSVJYZn/kP8OOux8pSQGyls7FowTCgSSf9DTrYHbtpEzykyj+Mtk+44dNiSJyB3gbhWrdE7vARhtZ95hkWdQWysixvGGnEnjgi2VEe0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBkNeKYc; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-30dfd9e7fa8so4699180a91.2
        for <netdev@vger.kernel.org>; Sun, 18 May 2025 15:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747606868; x=1748211668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fc8Lz9CBNmIjid8+ps5KG2hCEVWdm1fBK3wLQiuHd+E=;
        b=NBkNeKYcmNxqaFTI+9819D5tjZZkh0UNQGZQ5aABoSUSCIfCN8fRB1wV+dgS3tAow5
         xW5iOeOUqp1fqZsnMAMXkZAWtepTSOSoxlK73WuvNs8bxId7YnQTpF41VVaJFLWSLifp
         ogz+d7UdWdyaNBVc1D7srX4T7JSJNW/cc+Bdn0TXuK/MjO9aVRThWBgHfbSe6c5/CN7B
         EhkYAP1lfZOB0pRm/qO/HTH3WtHvPSYyxm/WCrgX+Tj5dBR/LVX5/y1osCSO/Bxhu6lo
         tOh/HeNSCQYO4OyuCPnH8B1DaHtSQDslyedXFNcp6PZuRkyLFPZQBgaIWS2AX6+78k1t
         GWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747606868; x=1748211668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fc8Lz9CBNmIjid8+ps5KG2hCEVWdm1fBK3wLQiuHd+E=;
        b=NqFKTrfY2Jm3Ln/uz6R0cCwKJ+65Elvxy3xJCSk1c2nupgW+MivQ4wRjLmB447SZFB
         eHOOC5GCCRFAM4RA3RR3cBTE+DgtKlcc6/EA74rb5GBDQ0AbrJNBaLlMZ5tzcS1aQDqJ
         1+adnMGjGE4VGwYkhewC1ZpOfuwyGlopdKQj0R4/9WUNCwBR8+uj/8KpAOsr9oDHXN1z
         DRuQyZOw7J1gCsmV9OJenv51nFltqF8aDSHgoFnlZaGisCYyMlVkyAgBXs9mWBTVEUx9
         yItQTY4VGVuGLHOTqQhh/QyMkwT2wDbrbHNCLYws/j1pkxDU2qw0BIS0PTnp+8brcXht
         6WDg==
X-Gm-Message-State: AOJu0YwWyz5SQBjYik+D+o9BRD226a4YBJtdOihCkGchew/SiCCZnRLd
	bkUC3/qfIoYRCgXJu3yVXHHYicaRn80xRLpzzK9UHJJ7hwJ9n1LzVYt/nqCc2Q==
X-Gm-Gg: ASbGncutNfVk5bnwhPRRKV+jda6ylsPRkRFeZSnvzjyqJZqnLa+E6R5zKKAzQU2U9R8
	TqmApauigo65coUR199/xYa6Ooy4wfJAFpbaymsbe+mw+5Tlnfq0v400S9HR/9cz/qPFTy0nkCu
	WQa+mlYQ2d6KBGYyasd/yhgkeMNgzEfeYer6efMQPdAqMN8IfaiFWc2iAvToaRirWuPy5MOoNTD
	EF5LQp7ON+Z1IAl+C53Xkq2047IbcAsmJCnRyURNm6L81YfMSMBzw6/5iq3PpPwmvRoQLv7yzwy
	AeOhoyJjXKnVAHjlTjEhH0Sos6rD+J+qG1ubMM80rPOI1umcUG1Qd97N
X-Google-Smtp-Source: AGHT+IEY9vZWwi3qL5PmIpc4zr8/hHeYfGnhLdabA2TZ+KelGDkE3Kmr/jg1SC9D3hroZ+QSOmYozA==
X-Received: by 2002:a17:903:1aec:b0:21f:1202:f2f5 with SMTP id d9443c01a7336-231de351473mr116119695ad.8.1747606868555;
        Sun, 18 May 2025 15:21:08 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:b16f:3701:bd1c:9bc3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed4ecfsm47360005ad.234.2025.05.18.15.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 15:21:07 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Mingi Cho <mincho@theori.io>
Subject: [Patch net 1/2] sch_hfsc: Fix qlen accounting bug when using peek in hfsc_enqueue()
Date: Sun, 18 May 2025 15:20:37 -0700
Message-Id: <20250518222038.58538-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250518222038.58538-1-xiyou.wangcong@gmail.com>
References: <20250518222038.58538-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When enqueuing the first packet to an HFSC class, hfsc_enqueue() calls the
child qdisc's peek() operation before incrementing sch->q.qlen and
sch->qstats.backlog. If the child qdisc uses qdisc_peek_dequeued(), this may
trigger an immediate dequeue and potential packet drop. In such cases,
qdisc_tree_reduce_backlog() is called, but the HFSC qdisc's qlen and backlog
have not yet been updated, leading to inconsistent queue accounting. This
can leave an empty HFSC class in the active list, causing further
consequences like use-after-free.

This patch fixes the bug by moving the increment of sch->q.qlen and
sch->qstats.backlog before the call to the child qdisc's peek() operation.
This ensures that queue length and backlog are always accurate when packet
drops or dequeues are triggered during the peek.

Fixes: 12d0ad3be9c3 ("net/sched/sch_hfsc.c: handle corner cases where head may change invalidating calculated deadline")
Reported-by: Mingi Cho <mincho@theori.io>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/sched/sch_hfsc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index cb8c525ea20e..7986145a527c 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1569,6 +1569,9 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 		return err;
 	}
 
+	sch->qstats.backlog += len;
+	sch->q.qlen++;
+
 	if (first && !cl->cl_nactive) {
 		if (cl->cl_flags & HFSC_RSC)
 			init_ed(cl, len);
@@ -1584,9 +1587,6 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 
 	}
 
-	sch->qstats.backlog += len;
-	sch->q.qlen++;
-
 	return NET_XMIT_SUCCESS;
 }
 
-- 
2.34.1



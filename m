Return-Path: <netdev+bounces-242034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F3166C8BBA2
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6A394ED39B
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85052343208;
	Wed, 26 Nov 2025 19:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDzxGqLO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F0634321D
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186785; cv=none; b=TSXHib7V2dSSrVfUhYN9PpGhvuDCs+aTx3Vt1B7VdKHg39gLvfZ/kFFnAxHt30pA4jBH59dqRVRueyo17cA9ZIM+xWvv+NAxeB26SK/OvwIl2ld86I82uhQXSE6cH05eArlQw2i8pTZbCmTF6Ykz2qJljBDX/ZcRAY6TIqDbT/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186785; c=relaxed/simple;
	bh=0Os0/96/WBv/ef/z5EflmYs1MIUyMS2Myc+GiTAAZtg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pfilItHaYaezIpqeptwudAQdPlpSee8hCR2LeJn3Q4TrsnC3z03NcVMweWM7LDOG0wL9Rethw2GOVQHkOF9gsnph9hQubo+7kRmVf8RO15PDo4w6Id8CoYN7WT7GjUayZrOtWWgVHCFXeGsPVFgf+hCXGlZAac6O2KclYYOcPAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDzxGqLO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-298287a26c3so1650755ad.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764186783; x=1764791583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rq3zZ1Perig2nyFgO33szXHRyFoQB66ZQwEgFEk/E6s=;
        b=kDzxGqLOdnC6aMvDb5SzmQayJOeTyoBpbR6NAj0/QdTdYVAWM05f3MtuDcHkd5+1gy
         OY5qOOkj2WzwHP4zNtK8ySMQtKPcDhTw29NNyyNqnR3Au+SDm2luZfxe9u5XyXm1Vb+5
         t0TvoZjXRYGxRu4hBL0Ecgves3bDgdZcuApM396CE4TOFAyTY4+Lxnu3x0xNieRwupHi
         OHwOYffDxj53SlKd1IccejRm+vG6eRd+9zOD3+9SIHl4AW69/R5RKfBR85uaiqybRU7K
         J4Y55n2KQYfZXR2Bvf67V/rk/6hXU8Hve78Vttd9gtDAw8DnnbyOQrzIprLLkJKci9EA
         l7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186783; x=1764791583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rq3zZ1Perig2nyFgO33szXHRyFoQB66ZQwEgFEk/E6s=;
        b=w4rF016mckoUAjta3veHu4aEdY7Iwwbr9zhuWWq0VPTYyvtTUK37jkv0NdtRPf22Fl
         tA+SqWVOGZiUWbcU7ZkLd1DqmlUZi2pveYT47w1L2ZgzFoW0amuj3fBIFIUZ1ShYmnK4
         xkkWb4UfYuI+t4jbwKXr/jwKaOULmTDUx3i5NC5L7JjamcqzfBE5nAbAMY6GtPXR7XjZ
         AFBx90bf1zGeLhHaxAkRMgNwa0aSaw0EbvPQNCkb8yoHERQeJ3fbPdamTKr7TXr7jvIE
         isHJwfuUn5wzZezug6wQWo2idHwq6xPURaxPNCkvMNtn/aXtLy51JZzp5yBH+UB/LUHk
         Zegw==
X-Gm-Message-State: AOJu0YzRIjK/UKsju5d/sozm63f9vEQe2r1FWIlAFGmYyN1BfTgv4X3q
	vKoDJQ9nD+dtQLII4MxzH1skW0MqOSACngxcgB2dz7XOCJcQQZ1GdP/Deuc+p5d0
X-Gm-Gg: ASbGncstP14STISVyH89eAfanibWxifCMajk2bnL9/UVywpSMz9pImgMY5D7Zj2ueg2
	5nQhs8f08IfaEjdWV0TROT5X1f72Qe3zaL7xTAei4bBRDhAB/b07HIrrxJhuuGdCdjcXJirRJrV
	TpSwc4xFyDsxBPSLz7+x9ojfb4PF23dwqjqJXH93tZ9AyogQVM8lC0rafC8majWD7zZGqhz1VDt
	sBScvhty5/aELeq19S05HVRhLfhD65Z9HlpfpMDj96S+oMo9RNz9kfskYoeilAfaIcoXMpMCgcv
	5jarsEn66TA8X2Sf8jeukU/TZ8kL5tiqJMFnpoUL0GBuulAM4YpKm3IkDYsfz+XoTx9D+Q3jeiU
	E+VVu4wgrpUVqA7aPbViFctyIE5FQ3alu082wHh4zsVPaTXPgUg9Gb/CVpFlGQUavvp6T/cHHrL
	d7Ow6biKP+yA7Tk/S7AmSAqKAE5MeJCIJu
X-Google-Smtp-Source: AGHT+IEfpNJA63dVG6r/igP3ShmDmvmUno74yQCsM91q8idHmofF86Bk2J9pD9HcMH0L9zTSAhgfcQ==
X-Received: by 2002:a05:7022:3c84:b0:11b:d561:bc10 with SMTP id a92af1059eb24-11c9d865870mr11284523c88.41.1764186782529;
        Wed, 26 Nov 2025 11:53:02 -0800 (PST)
Received: from pop-os.scu.edu ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93db4a23sm101508235c88.2.2025.11.26.11.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 11:53:01 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	kuba@kernel.org,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [Patch net v5 5/9] net_sched: Check the return value of qfq_choose_next_agg()
Date: Wed, 26 Nov 2025 11:52:40 -0800
Message-Id: <20251126195244.88124-6-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126195244.88124-1-xiyou.wangcong@gmail.com>
References: <20251126195244.88124-1-xiyou.wangcong@gmail.com>
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
index 2255355e51d3..a438ebaf53e0 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -1145,6 +1145,8 @@ static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
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



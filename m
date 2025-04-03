Return-Path: <netdev+bounces-179180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A480AA7B09D
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69E521883778
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 21:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FA61C5F07;
	Thu,  3 Apr 2025 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9JMITgS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EF11C84B2
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 21:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743714657; cv=none; b=haZQanvzQnjdFsYV5ZLM25jHYwczavIpocCz8/i+Uegd6Xcd/OWroVUSJ415Iorr2Kl0LcyZC0TuSCNF2Om7TNif7VkLkC6x3IEKDb16zLk+OmIG5IbYYu+bdP4cBwhPq9sw9cTNGJkd1XClCm5yYpf814bNDPxN2UTMdrhKMVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743714657; c=relaxed/simple;
	bh=r+gikWGzl5MEjUN4eokEcc0n1adpTw2x8VVvehd7OFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K95YaqKKZF2xK44L9TQ9yFkdpYhVnFZZNZab/bwN/Gc7JQblxDscJbGlF2nz54Mo0YivQ6Q1HrBnveJwtWgJ5nYSNzdsr2Akxe/kUPQEekEuoSkWkZDmokHP7f/l3x4P1EbUtBZ/U94ifjHqjL2D54t1zmq0m1axfKeh8kcyEXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9JMITgS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-226185948ffso15286915ad.0
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 14:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743714655; x=1744319455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gpY+rdcx4DmrGbnf0XYjotvrm4FbCP3RPVGPnvtMgY=;
        b=M9JMITgSc7IW1cjO1F//6OQJt5wLlM+FT0ro66dhvOo+mQIl0NHrXSDm3fK9Vxy0Wn
         HTH0TXCXA2VkuaCrgj0nX7QwQ3Oz22HJhwnp/FDq4Deh1tnXqu7ljOitjwRGbtZtAavd
         MMJhvLVoeG22X75WXB8iWfrBwUIxieS903vWRVL8N/23Aw4NsMH86T4VlNvY6hmLEq+n
         xDtUaF0gBQOrrxOvHXK+8GF0DTHbNrzaL+8R52PSYA2nelbLDGK6PqeXXEXI21G0WJUX
         4mNT3BSoqVHc/hcJxiS0J24E4XSInTJM3GEYRLofTRJkTaD3wrCigJTew+sf/36vWojz
         T06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743714655; x=1744319455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gpY+rdcx4DmrGbnf0XYjotvrm4FbCP3RPVGPnvtMgY=;
        b=l4D5gwj2owuXIFphpc0v0I11b22Ad6KTKdNlmoWR6LXKrIIaWHhcFDsWDrd+D/er2n
         NkyF+CUn2IYDytn9BQeRaWipVQRGxOcJWXfEXUV10yxkw7KnBVpJxrYwgaSDnzWpaxL2
         iRuEX2M1U6ivrtUyXQduqLNlGEAqXuJTYf3BfiFsacX6Wt0PhSsYKTuHxKyOOguXoJeU
         WiVKbjyV0SSzGqKPmef311E9zkZzWNQOnfSvOoG07dkn0NqPFbuotwvRSNZamW5jdreN
         juYEXizhe5NuXabNMuXGWskE0DkIHKa74QzvAVUnYd4sEiWLRrZsdZifoMQqc/Cd1MUr
         FHzQ==
X-Gm-Message-State: AOJu0YxrZ2zsIdKunN7SjFS94McPU0m0VhD2uuj0+vaN/UQ3/82JERtq
	ga9ilHq64NCym5M/xQa8Owu6Wy34eop4LcPMpIcKagyQdpDmMMiUOeY49w==
X-Gm-Gg: ASbGncsL+9juLV4EwLJPpbCrMRWfZw9qX0f5SL5QzfkeEN6mYOCmR80ueiuzqqboNyJ
	1hdUPlNYUqhDuQ2EFDAOlVfYroJ6eKmHIBVMfBRRJlYjQ2baclNEo29VlySjxTRzwNrYzIJGrv/
	6LRdgFGfqArvARkAg5OsBYo4EEkkclqoPB6s2cJ+MSXQ6pz5iLbSdhLmzbUUBCUEAYPSAGwNw6a
	tf5TBVQmbl2w9sVJTWPJqSwYLqFhg5dy7SAKztQmndyvsOL8kqILcjoizf96ZYFjA1msywynp1P
	kPgJdRLzeZyje/BGzg1qn9Rg55mSs4arK/LxHgAudU8loMp9z4YTbpE=
X-Google-Smtp-Source: AGHT+IEO9OgFv4cSV1AViYkQf4sLogfZEiVWl0doaF50u/xym88tF/gWAGDGPSjuZO7WUrvIX0Eepw==
X-Received: by 2002:a17:903:1cd:b0:224:1d1c:8837 with SMTP id d9443c01a7336-22a8a0505d8mr6571345ad.19.1743714655210;
        Thu, 03 Apr 2025 14:10:55 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ad831sm19367645ad.11.2025.04.03.14.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 14:10:54 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Gerrard Tai <gerrard.tai@starlabs.sg>
Subject: [Patch net v2 04/11] sch_qfq: make qfq_qlen_notify() idempotent
Date: Thu,  3 Apr 2025 14:10:26 -0700
Message-Id: <20250403211033.166059-5-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
References: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qfq_qlen_notify() always deletes its class from its active list
with list_del_init() _and_ calls qfq_deactivate_agg() when the whole list
becomes empty.

To make it idempotent, just skip everything when it is not in the active
list.

Also change other list_del()'s to list_del_init() just to be extra safe.

Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/sched/sch_qfq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 2cfbc977fe6d..687a932eb9b2 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -347,7 +347,7 @@ static void qfq_deactivate_class(struct qfq_sched *q, struct qfq_class *cl)
 	struct qfq_aggregate *agg = cl->agg;
 
 
-	list_del(&cl->alist); /* remove from RR queue of the aggregate */
+	list_del_init(&cl->alist); /* remove from RR queue of the aggregate */
 	if (list_empty(&agg->active)) /* agg is now inactive */
 		qfq_deactivate_agg(q, agg);
 }
@@ -474,6 +474,7 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	gnet_stats_basic_sync_init(&cl->bstats);
 	cl->common.classid = classid;
 	cl->deficit = lmax;
+	INIT_LIST_HEAD(&cl->alist);
 
 	cl->qdisc = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops,
 				      classid, NULL);
@@ -982,7 +983,7 @@ static struct sk_buff *agg_dequeue(struct qfq_aggregate *agg,
 	cl->deficit -= (int) len;
 
 	if (cl->qdisc->q.qlen == 0) /* no more packets, remove from list */
-		list_del(&cl->alist);
+		list_del_init(&cl->alist);
 	else if (cl->deficit < qdisc_pkt_len(cl->qdisc->ops->peek(cl->qdisc))) {
 		cl->deficit += agg->lmax;
 		list_move_tail(&cl->alist, &agg->active);
@@ -1415,6 +1416,8 @@ static void qfq_qlen_notify(struct Qdisc *sch, unsigned long arg)
 	struct qfq_sched *q = qdisc_priv(sch);
 	struct qfq_class *cl = (struct qfq_class *)arg;
 
+	if (list_empty(&cl->alist))
+		return;
 	qfq_deactivate_class(q, cl);
 }
 
-- 
2.34.1



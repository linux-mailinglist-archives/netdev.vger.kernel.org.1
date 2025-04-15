Return-Path: <netdev+bounces-182532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0822CA8904D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 02:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A35D3A8D45
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 00:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FCE4C98;
	Tue, 15 Apr 2025 00:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="nnXKVr8k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799E34C83
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 00:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744675408; cv=none; b=scyjZ9wARM2op8gCKoedsKxNqBKAEaOi6oGH7D4oEETMCJ8wK9PosWNJ36PJ9PVoeAbFPY/qXmqqeZOONXGgqpNfjv3mJKzMj7XTvZ1VO8xTtwzbq9cUm1NY/26a/YQCa/wgpCT1Ss6nCBJiV9j0eIRCfnLBjJ+MGeFbTIeEuik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744675408; c=relaxed/simple;
	bh=p2CAmXq7+YJkJfWMJzLEGSXBWrqHyx8KOOL9g2iIniA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNb/JiFZomTWZGmQM67gvyBoMYl5emqn4qPfGMpNIGfm6y32tVVo3ucM0muGSMR1BdG/v+4IxVdfGx81qUp5hl0d13p5OHGnDTqYiPD6oXZd35xU7C8C6NunjIFT8c7G0NI17MNi68KvnBhWjgvN2AA0vcQXwBDp4cD5XLIOj6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=nnXKVr8k; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-af523f4511fso4275264a12.0
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 17:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744675406; x=1745280206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhFZ0Hl2z4tcgfTQfMCnzc+ZeLw2j4BWrdeDkYT37/0=;
        b=nnXKVr8kQn+jTkY01bM86N8JJW3k4V9XdJJJ+CGwVkewyEXH2Uhlt+FMQptsMB2RlU
         EDyNvbaOj5S83m6qFqxJ6rqAA5ITPvtKebIhib5KBJ6BoSiL3sNFiXM+sMUeBWJGkXH8
         TiWrr/MrFMoLYbpR6aKHtbQe+S46VxqEfY6DKel5xwuOEMvj/+bSC9IKbyXtqgxcmSFP
         u1r0j/BNf3xbUF8b5XDzRRz4JilyGqIFRiBeh0gUZnUOaoV1N8E0+ky1KshqkaAjt47t
         IFvw3UTz8Lpj7/iBCAx2DwVPB2zTI4uADjmpUjCNDszIxqRdcrQl7RFhnzm2oo4xTT5Y
         DBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744675406; x=1745280206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhFZ0Hl2z4tcgfTQfMCnzc+ZeLw2j4BWrdeDkYT37/0=;
        b=GGQ/kTvWnILH05b9TLdgQlNlXa47BcMeoGWa6aDS5LbPh+JxyuRnvkvJL1BPh9hzbm
         /GOSlaSP/8inDdJZzsgvSWAkot/cgDP/o1iMQQizSCsismRNq34ixaPHhKyoUdm7F0zm
         YnYhszrb5xS3mTRpgQe67NE2hLnH2YlcVRmNu5/CQNeSvbxWRTbwGF/LOLci1kPuRkxa
         hYkhM/6GOZ0y+JKbkfa1MQ28/OgjVdWVR7j+cziYZSo/+YR2LoVsjRKqnMR71cdZJDiD
         MSGDsqsmOjE8RN4/kHh9SCf6mRhMpvntDzGExx06XNCLiCLDpKbj5m+C7jKUcEVxlPNH
         IJ9A==
X-Gm-Message-State: AOJu0YxccCK4GFtxutHHcCvQf+DjKOgPXXvSOM2VJdLVWM26Ml4ppxJN
	WBmBoZuKpc4RVqh0u4t88ekfOaydcTnLNVEJr3bCJ59yWncMwT0OpwqAjk9aSsf8RZfIJ6gIauE
	=
X-Gm-Gg: ASbGncvJ2kReNPOMO84iZpJRuuYAeSWbl5+yRyMXBaFvoOPkeLTaUvK4pfVnGnZK5mq
	QYBt+Hodkw0qwHo3Ml2H5NwiR/tEHA/kwOpNe4m+YqaG6ZNK+T0DF8uVzeDB7+xR2b46GMvps4B
	iTqOcuPNNPBsMaULFRRJnH7kSrH3NmPQGqLDyH8cReHiKa0TiGcaA0C9gZze4+WvPxUnA8mPMcP
	DPNywuppv+U56mmdgy7sCdoLJ2ZLfIoqfpEUcETifiyl21X/6sjBMUOS253vrnyBGb5V0o9Vr7G
	WXWEchjey2+lrZAssXTO90SYGPRG0btHdNSiFbGZlAisWFL7XWVmcAwWCWG61Efm
X-Google-Smtp-Source: AGHT+IGq3VhPi+rpEzUTBvh9HJr1G3e9yc7/cb4V+43s5oRSLiPliRBk7n1N+e6eOpSJQLgEaIHcFQ==
X-Received: by 2002:a17:902:db0b:b0:21f:164d:93fe with SMTP id d9443c01a7336-22bea50832bmr200435905ad.53.1744675406570;
        Mon, 14 Apr 2025 17:03:26 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c3:dc7b:da12:1e53:d800:3508])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c4db9sm7445615b3a.58.2025.04.14.17.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 17:03:26 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	toke@redhat.com,
	gerrard.tai@starlabs.sg,
	pctammela@mojatatu.com
Subject: [RFC PATCH net 1/4] net_sched: drr: Fix double list add in class with netem as child qdisc
Date: Mon, 14 Apr 2025 21:03:13 -0300
Message-ID: <20250415000316.3122018-2-victor@mojatatu.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415000316.3122018-1-victor@mojatatu.com>
References: <20250415000316.3122018-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in Gerrard's report [1], there are use cases where a netem
child qdisc will make the parent qdisc's enqueue callback reentrant.
In the case of drr, there won't be a UAF, but the code will add the same
classifier to the list twice, which will cause memory corruption.

This patch checks, in parallel with the qlen being zero, whether the
class was already added to the active_list (cl_is_initialised) before
adding to the list.

Fixes: 37d9cf1a3ce3 ("sched: Fix detection of empty queues in child qdiscs")

[1] https://lore.kernel.org/netdev/CAHcdcOm+03OD2j6R0=YHKqmy=VgJ8xEOKuP6c7mSgnp-TEJJbw@mail.gmail.com/

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/sch_drr.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index e0a81d313aa7..942073214e80 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -35,6 +35,11 @@ struct drr_sched {
 	struct Qdisc_class_hash		clhash;
 };
 
+static bool cl_is_initialised(struct drr_class *cl)
+{
+	return !list_empty(&cl->alist);
+}
+
 static struct drr_class *drr_find_class(struct Qdisc *sch, u32 classid)
 {
 	struct drr_sched *q = qdisc_priv(sch);
@@ -336,8 +341,8 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	unsigned int len = qdisc_pkt_len(skb);
 	struct drr_sched *q = qdisc_priv(sch);
 	struct drr_class *cl;
+	bool is_empty;
 	int err = 0;
-	bool first;
 
 	cl = drr_classify(skb, sch, &err);
 	if (cl == NULL) {
@@ -347,7 +352,7 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return err;
 	}
 
-	first = !cl->qdisc->q.qlen;
+	is_empty = !cl->qdisc->q.qlen;
 	err = qdisc_enqueue(skb, cl->qdisc, to_free);
 	if (unlikely(err != NET_XMIT_SUCCESS)) {
 		if (net_xmit_drop_count(err)) {
@@ -357,7 +362,7 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return err;
 	}
 
-	if (first) {
+	if (is_empty && !cl_is_initialised(cl)) {
 		list_add_tail(&cl->alist, &q->active);
 		cl->deficit = cl->quantum;
 	}
-- 
2.34.1



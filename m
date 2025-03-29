Return-Path: <netdev+bounces-178214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E57A757FF
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 23:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71C816B64F
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 22:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D361DF755;
	Sat, 29 Mar 2025 22:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWh3evAb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C2176035
	for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 22:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743287253; cv=none; b=iMiMr0Vs4Muq9jsFjhJIYiNMzGDifFT34IwcxPgBHieRt25tvDVRu8ZZkUeXVbg1Am8JCVobvAwVGepwzv1TgokXJvYFjJZhxXobD2sND51P+OcyBov5Hcw6pX9fKdJ9wBR1mnL1zsMVCRixPPJLI8tC0dKZT5KrRJN6X3Otyjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743287253; c=relaxed/simple;
	bh=35e4rZ1qLqvyMbmYhOcgqu1cEqINeeK+c2vplzpgfys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m7n+Uj8MMwc5sJzAI4t+evinmqR0wnr0iqR91BCojOfSOjiEHv6iFiifxoZmTVFmZrHXT3jpD6cZx74oWngOSjNVoadIYi2f8U93o2JoNoc3ENmb9PKnhc3r/oVhpI4pFfKgS29FOm6TmUl5HZvYOoF6cIspDfAsFu9Ifg9YjAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWh3evAb; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2241053582dso35498255ad.1
        for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 15:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743287251; x=1743892051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUg1KR6l/fL7ilHPpnavpewDnm5XIPbgUb3aT5ktoZY=;
        b=UWh3evAbO67pYTIspAGu80vXDdjQW5LboqiV3G9MvArTk1GqLKurMUXJgjdgeJduL4
         3m6XIaJgf+DZZPBBODF88pkDlTP8mNAzKpnAPQV4h9xwl0Xk4cfd3+IJUD5UhemKO7bv
         hTTabEx9coN6ETc2QoflDTtMjpqBOtrcV7jWvaeVxRsozEsn6Xisdz60xc1Jnj+hEkRl
         dy7uH11NjqmPQe6a5fKvVfYJwh9urEKOPocXS9uzDCX6yi8I1edTCFH9EGEsvA5nfLob
         lJg1OF0KVGqvutbmwtta55NcHjtsanc0twNlpzGQZlmD86KrHgN2N8IM0XDC89Di/4au
         Ta3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743287251; x=1743892051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUg1KR6l/fL7ilHPpnavpewDnm5XIPbgUb3aT5ktoZY=;
        b=ke6jf/AAHj0VmlXOyWfLpF2pxUh0YpcCww0s/VoEtaKxqD8kpcTK3UHbG3EZE4bMpu
         MME3VPYHSrdaeZetd4feBNB5wtuIIEG9T6eODv0Z/vxhNxtasNKpAx3k/4q9eBrncvAA
         v1Nb8cPGIv+k1e18hvQtRKjpS8xwiYVW9vF+jxHcfCn1hnoVOCu36nHvGALzlNbnYDBc
         U2vg6fZYgfmxMOrtOmURAwIhBztHTLD9Im37xbdRMcH/9tCWyTEmnmao1RVtN5YXeSiO
         KV17RSFaLt3GqJaDTmKl87TuGVBCFI/gr3TjB7or3COYUSmzfIscZ1slP1AjkZd3VFTf
         FK/Q==
X-Gm-Message-State: AOJu0YyODovAyZ2QrtzpMj+vE186zjaClHgrJpMVLufjSiORPgk1mHFD
	QKMd0B7jE2mXNxRL5JNEJ8IamlVqiCvg60gbL/fIy2U/cJSbDGPFj8X3ng==
X-Gm-Gg: ASbGncupzlBzHpn1bFsl5/f/f0l4dWTqlSNVoWVgL4UkE7Nak87wSo/L76EsHIK2mON
	OX7mGBs8C8ZKUtadoXgulBm8qMxNOs6887K4TSNOuPSQd1DKuh0eaj9PkxjxVo7WMB+C6z6g+SF
	rwM6OFN+Dg1/r6VIINzNI59hdpjqqrQAvpEP865f4lm4oIERE6XpdvsIDrv0VA3v64Dh/JL9H14
	Fndy5bewP1+XtRUfNW4NnXqhWT2u7I0qXq/wuTvw60SJrX5yHS4ML28IB8DqYmUebmp22zk3YW3
	kot21GDsRn5GApnx3IAeRpa3qusxW2756+3t8j4h3x8B8TAefg==
X-Google-Smtp-Source: AGHT+IFP2NC0kd1yujkI1xbcTY5wp0Ns9O5kGL56Dldd5am61UYo07gyLTF8kN0wctAD1D48sz7aNA==
X-Received: by 2002:a17:902:eb8d:b0:21f:564:80a4 with SMTP id d9443c01a7336-2292f9e5139mr59840685ad.33.1743287250899;
        Sat, 29 Mar 2025 15:27:30 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:c022:127e:b74a:2420])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1ecbc9sm41477335ad.215.2025.03.29.15.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 15:27:30 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	Cong Wang <xiyou.wangcong@gmail.com>,
	syzbot+a3422a19b05ea96bee18@syzkaller.appspotmail.com,
	Nishanth Devarajan <ndev2021@gmail.com>
Subject: [Patch net 1/2] net_sched: skbprio: Remove overly strict queue assertions
Date: Sat, 29 Mar 2025 15:25:35 -0700
Message-Id: <20250329222536.696204-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250329222536.696204-1-xiyou.wangcong@gmail.com>
References: <20250329222536.696204-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current implementation, skbprio enqueue/dequeue contains an assertion
that fails under certain conditions when SKBPRIO is used as a child qdisc under
TBF with specific parameters. The failure occurs because TBF sometimes peeks at
packets in the child qdisc without actually dequeuing them when tokens are
unavailable.

This peek operation creates a discrepancy between the parent and child qdisc
queue length counters. When TBF later receives a high-priority packet,
SKBPRIO's queue length may show a different value than what's reflected in its
internal priority queue tracking, triggering the assertion.

The fix removes this overly strict assertions in SKBPRIO, they are not
necessary at all.

Reported-by: syzbot+a3422a19b05ea96bee18@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a3422a19b05ea96bee18
Fixes: aea5f654e6b7 ("net/sched: add skbprio scheduler")
Cc: Nishanth Devarajan <ndev2021@gmail.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/sched/sch_skbprio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/sched/sch_skbprio.c b/net/sched/sch_skbprio.c
index 20ff7386b74b..f485f62ab721 100644
--- a/net/sched/sch_skbprio.c
+++ b/net/sched/sch_skbprio.c
@@ -123,8 +123,6 @@ static int skbprio_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	/* Check to update highest and lowest priorities. */
 	if (skb_queue_empty(lp_qdisc)) {
 		if (q->lowest_prio == q->highest_prio) {
-			/* The incoming packet is the only packet in queue. */
-			BUG_ON(sch->q.qlen != 1);
 			q->lowest_prio = prio;
 			q->highest_prio = prio;
 		} else {
@@ -156,7 +154,6 @@ static struct sk_buff *skbprio_dequeue(struct Qdisc *sch)
 	/* Update highest priority field. */
 	if (skb_queue_empty(hpq)) {
 		if (q->lowest_prio == q->highest_prio) {
-			BUG_ON(sch->q.qlen);
 			q->highest_prio = 0;
 			q->lowest_prio = SKBPRIO_MAX_PRIORITY - 1;
 		} else {
-- 
2.34.1



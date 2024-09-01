Return-Path: <netdev+bounces-124054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C5E967BBB
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 20:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7502B211A6
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 18:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348ED2C694;
	Sun,  1 Sep 2024 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Cpb7GoAb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8F644C93
	for <netdev@vger.kernel.org>; Sun,  1 Sep 2024 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725215098; cv=none; b=IbTuZQwaexIWdzISuQhsX5lGk4SxkaSWMrZfG8lA0qFfMYFJXdYO5ze+UN+lxXhavXZ1Af7PGWUOjwd1Z8YyLiDSfTKZN6CQC/NhXJMmgEGsJoA0bQK0fbXu9IiTrOCVmIMYrV2p0MVxI1PWcbRNeCkKpZboTkyfGww+As7Z1fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725215098; c=relaxed/simple;
	bh=6zYQa4nT4VfnaSrcD1HlapwNYzSVVPbOZyj3YaJAyQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gDzdySkpKEuAF/kYAJv7ZyOt5ylmNwwfUiGRa+HEYvsNbTBwOQheIGbuC2cZ8+QgfPHsCtRc6G4kcV3kLvbAUaueVYHQ4AYQECgZjCWig/2089Aq2MSmEV1jfeWsWe0Y+RiLeKuYfpwpW5yMPAWUlkRBSgLv2Gt+HJkOLyFT56U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Cpb7GoAb; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5df9343b5b8so2320833eaf.0
        for <netdev@vger.kernel.org>; Sun, 01 Sep 2024 11:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1725215095; x=1725819895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5qsAPfgTFLDM5hhz9LviiXNxpu3YsGNw1yjC0HrdlS4=;
        b=Cpb7GoAbS/77896Up1u1Qdrn5S3XmE+OOT6b1W1Mmb8hGwCcen2lG+27720/5aKLz7
         Z6klpjfFNBA0ovRnG7YPfyHien8smB8SUD+XcNxXEp6c8fTGrtRZzSOcZYvmqWCdfPQW
         U4GAF7aJY+elmj4hD2A+mfLI5daFbJz8eFqExkcfpO0lnCSQU2W92AQLzebmpF6/i9Tu
         EE6f9CWgadXWulHFktYNodcVj9MvGpe9e0bhvcMdwNO4nYkZLaCEBzHgv5ddT3C0URwD
         oRoTKeouWPdlc62J3IGRANjh2wMf8PY87OsLHeN7SlT7pfQag5gp1buX11f0B2x0h5Ns
         gqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725215095; x=1725819895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qsAPfgTFLDM5hhz9LviiXNxpu3YsGNw1yjC0HrdlS4=;
        b=EIkkyZm1Un2c1HqFUubu2De435FhBZ/Sh2OqAU0yenolpLK1nnjS8k0q5cmi5SR7yk
         tKNDq9TH0aM3llxQS5AyyFdtb6uf+Ffax+vahzqccJ+VMrBomAkHZyRTIH4uK+h33Ea2
         nawS7d+zBrEVWdO7S+N7MC2CxkVOejmsY+SLkJxUKIBQn1duqQz5Ppkn/MZI8WO+gMyW
         AsBK3GstX+YR/qoKXsrO4bJIX/+FKVgzgLk6aRSVrUnRhfwny1I5DUYrBS0BPOhv279t
         opeRpkOSDBDGibPNRtNchJEgZRwkazaDldJ0KNwwuUn247yAZXvYID/ral40thj9NZpP
         fCsA==
X-Gm-Message-State: AOJu0YxQNp+dQTwNkUhm80HjyJ6G+8V+YOalUlG7ZQQj+S9xCR6aCI89
	U1K8iauPSf/4GAIuePjnJf4yo3zG/AN0bZJc5w2wbZ1zFWMvPJiPX2a3xKWxSDfGh/ab/mdRWDU
	idyI=
X-Google-Smtp-Source: AGHT+IFNDflXD1Uh3SxSyx8OIOMQwxVzSxsa24BT7otnt/iXeaR00ifDaq3OmwjpPjDSety04LD53g==
X-Received: by 2002:a05:6358:198d:b0:1b5:968f:e221 with SMTP id e5c5f4694b2df-1b603becf44mr1275092855d.2.1725215094767;
        Sun, 01 Sep 2024 11:24:54 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85b0fdc71sm7481312a91.1.2024.09.01.11.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 11:24:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	Stephen Hemminger <stephen@networkplumber.org>,
	Budimir Markovic <markovicbudimir@gmail.com>
Subject: [PATCH] sch/netem: fix use after free in netem_dequeue
Date: Sun,  1 Sep 2024 11:16:07 -0700
Message-ID: <20240901182438.4992-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If netem_dequeue() enqueues packet to inner qdisc and that qdisc
returns __NET_XMIT_STOLEN. The packet is dropped but
qdisc_tree_reduce_backlog() is not called to update the parent's
q.qlen, leading to the similar use-after-free as Commit
e04991a48dbaf382 ("netem: fix return value if duplicate enqueue
fails")

Commands to trigger KASAN UaF:

ip link add type dummy
ip link set lo up
ip link set dummy0 up
tc qdisc add dev lo parent root handle 1: drr
tc filter add dev lo parent 1: basic classid 1:1
tc class add dev lo classid 1:1 drr
tc qdisc add dev lo parent 1:1 handle 2: netem
tc qdisc add dev lo parent 2: handle 3: drr
tc filter add dev lo parent 3: basic classid 3:1 action mirred egress
redirect dev dummy0
tc class add dev lo classid 3:1 drr
ping -c1 -W0.01 localhost # Trigger bug
tc class del dev lo classid 1:1
tc class add dev lo classid 1:1 drr
ping -c1 -W0.01 localhost # UaF

Fixes: 50612537e9ab ("netem: fix classful handling")
Reported-by: Budimir Markovic <markovicbudimir@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 0f8d581438c3..39382ee1e331 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -742,11 +742,10 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
 
 				err = qdisc_enqueue(skb, q->qdisc, &to_free);
 				kfree_skb_list(to_free);
-				if (err != NET_XMIT_SUCCESS &&
-				    net_xmit_drop_count(err)) {
-					qdisc_qstats_drop(sch);
-					qdisc_tree_reduce_backlog(sch, 1,
-								  pkt_len);
+				if (err != NET_XMIT_SUCCESS) {
+					if (net_xmit_drop_count(err))
+						qdisc_qstats_drop(sch);
+					qdisc_tree_reduce_backlog(sch, 1, pkt_len);
 				}
 				goto tfifo_dequeue;
 			}
-- 
2.45.2



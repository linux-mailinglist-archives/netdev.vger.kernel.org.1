Return-Path: <netdev+bounces-160949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0C4A1C64A
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 05:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 957747A385B
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 04:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB9219E96A;
	Sun, 26 Jan 2025 04:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYZ4Sr1y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFC019DF66
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 04:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737864803; cv=none; b=XYBTOptdM5uedz/hOB80FtW7AFgRVyg+22AD7lUjhzwoUP33SwcUcc7bA3O9CBShaqRcGiK0Pnvc3lZTbORNFRDRw/SCG+v+8qqE/+7Jwtgs3yPs5kp5aryCGpUmw5l2Mk6GBAswG2ni8s74hhXLzEgUw6sLwH38kBDYvlufIyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737864803; c=relaxed/simple;
	bh=dKBbo/zOKaY/725VVR3ZaE2PLTItUmhVxhmz9H33944=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nzev8tXbtVLfWHUUz6ZOHxneqXuI+gAioNTJxf8b0MjymMzr4BsQTu2o1Q/QPoN5M5asEt6QxEP94yONLZ5TOFOVaT3Rt/vC5MtUiyD3Pj+3S9CLQxUCJx6pqeUpGqHzSceY9f2Huz83E3sLVDiL3qNhmQbfS5M6H2UVIACgkD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYZ4Sr1y; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21669fd5c7cso59252225ad.3
        for <netdev@vger.kernel.org>; Sat, 25 Jan 2025 20:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737864801; x=1738469601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lFN3IzbSH6trKyBzTVcJyUt+VsO7adS97MfPgoyp6s=;
        b=fYZ4Sr1y+Om/+knhCVDytrMkVY0oQNGmIQS9/l49qU+I65TVj4TC+Ol2HNAD4APcIm
         q02e0w36oIpOq+zKBze6TWWr1cpo+JsM43z92cj2VDMGaxIirPekUe4K1xDS3wnYkGhA
         CO1v6NQ1cAMzzGJWt6L2sr4CxfNnFI4D/UdBqNOOaf0ClcsuuvIDRBLlng5dniezg+3x
         CG3ev7D0zSmqlpIH56JBgyB5ewPSygt4RAib/GESwLbGZL74dnNj2M0LqUMeiDfzuBpU
         34J4BxiAaEMEwfdXF89eCP5MCDR/EKDBL/hMNpDCyaDfEABMZeAATMmrKXk02CydqqD3
         mLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737864801; x=1738469601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lFN3IzbSH6trKyBzTVcJyUt+VsO7adS97MfPgoyp6s=;
        b=lhYKaOxyMRE9kBFmJ8UGOYLPmJtYfeO/uiRjnU8IjGSphZROSuKDICNwDcsg0mwxzb
         /RDjoUEW58ZHx4Deh1E7cpB+bPxypET4d6fOUW9iLJZqmn76SPLac69FOiNiFwuctuTt
         AVFdhKEOtOYQSWMg8HQftOLY2a7YfYQJwe+AMvbn72rLjVWSBu2p4VBf9kd+QTkOfe3j
         82z+jLOUxTzxAjmzqNobLVEfJS4CDXo0srgLu3MpMCUo1i/spxFwOgl2nRO83yLOQUB3
         kKtk1NPrbIV6K0EnX8bzWoCLs6ZxonVcdGYAwkmNdocI4O+QyVIi9emzcFBOWXX4oUt+
         cceA==
X-Gm-Message-State: AOJu0YwQUxL4yAzyUxf+wkv6dfVhO5IKgJ5xrc3CvBaNW5WM3yrS9a2Y
	2vhQIG2AQWFq5JZaSZbwKIzDFPktDP8kQ0shgQxkg8pHKfGawHhv/eV2EA==
X-Gm-Gg: ASbGncvPsKq8ppktdPHKq9fFFdW3q1zqXxDM4w6dGR8qwaZQb1R8GtWcLDcoY4EsIY4
	/uND2futER/fd3N24Dp+npZ6ZMf7mxy+AMnOhRkM+5OTifjvdfNcYohaIYAbPyC72OOJaiqFUHp
	hOP27LGuPN0j8JfEwzlovaA38tQiHSuCptacACYk9HJRK4QWP1OVBA20L0T1nsuSAwayvbjoWvR
	I3/wxwzAW+g6HFu8PWsWaYTrO+ZqSt+itzF9yXcRtle+xLdyBiRb+ZJDNA0dXxKEXE0X68HOvR4
	EtyDxDWSi+PYQUcebK8B+5Hh8hCYGcb2JQ==
X-Google-Smtp-Source: AGHT+IGs76ecsSFlyanwfgdCrkDD4gP2uiaMc3zMqI+A+7wcmH4SYapt9RwQds3vCk9Wh17FrA4OYg==
X-Received: by 2002:a05:6a00:3cd3:b0:727:d55e:4be3 with SMTP id d2e1a72fcca58-72daf9e0919mr51544557b3a.7.1737864801030;
        Sat, 25 Jan 2025 20:13:21 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:86c9:5de5:8784:6d0b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a69fd40sm4514213b3a.3.2025.01.25.20.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 20:13:20 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	quanglex97@gmail.com,
	mincho@theori.io,
	Cong Wang <cong.wang@bytedance.com>,
	Martin Ottens <martin.ottens@fau.de>
Subject: [Patch net v2 3/4] netem: update sch->q.qlen before qdisc_tree_reduce_backlog()
Date: Sat, 25 Jan 2025 20:12:23 -0800
Message-Id: <20250126041224.366350-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250126041224.366350-1-xiyou.wangcong@gmail.com>
References: <20250126041224.366350-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

qdisc_tree_reduce_backlog() notifies parent qdisc only if child
qdisc becomes empty, therefore we need to reduce the backlog of the
child qdisc before calling it. Otherwise it would become a nop and
result in UAF in DRR case (which is integrated in the following patch).

Fixes: f8d4bc455047 ("net/sched: netem: account for backlog updates from child qdisc")
Cc: Martin Ottens <martin.ottens@fau.de>
Reported-by: Mingi Cho <mincho@theori.io>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 net/sched/sch_netem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 71ec9986ed37..fdd79d3ccd8c 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -749,9 +749,9 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
 				if (err != NET_XMIT_SUCCESS) {
 					if (net_xmit_drop_count(err))
 						qdisc_qstats_drop(sch);
-					qdisc_tree_reduce_backlog(sch, 1, pkt_len);
 					sch->qstats.backlog -= pkt_len;
 					sch->q.qlen--;
+					qdisc_tree_reduce_backlog(sch, 1, pkt_len);
 				}
 				goto tfifo_dequeue;
 			}
-- 
2.34.1



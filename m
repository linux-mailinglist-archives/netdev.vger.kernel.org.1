Return-Path: <netdev+bounces-162339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76FFA2692E
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 01:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EECA165824
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 00:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF5412BF24;
	Tue,  4 Feb 2025 00:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzqMIW87"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C04C8632D
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 00:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630749; cv=none; b=lCzwoNI6hLVEiCNuMLAHpKsZ23YCXqly8nv+Ov9A/WhAjqPt8vOv0k6p2ScticK2wAuRoxg/puEq55VoyPrHGywaeaa5sMUViWFzIDkzFtE3ZGAJOCM6TQ16uZJR8tD+oWRD4PX5MckgvGxUMO8Ip+4l1CgbXCD9oQimFblqfYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630749; c=relaxed/simple;
	bh=WSA/PFv9lltq0hzEePygiTxz7Ki3MUarpLezLjBVZPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=akcTRFjgNVotUTLNl56jafNH2kos2oFJVmjby+kHDOBOrgM1OQF4RzIF+bYFqmBlMxN4TBMMmm8pBFMXSyWK6O75fdLJ1sXFklejUZ34FIpXgHVduwW6MwGonxrmbUKYNVnweuKuB5sU8YSr/jDYcGtpvObFK2II/3mbECazmwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzqMIW87; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21619108a6bso84499165ad.3
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 16:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738630747; x=1739235547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4j+qmqoQwY09I8DP4lfGxeBXOY3+ArSp5V1tfcv07o=;
        b=gzqMIW873Rd1phu1kqWVQr5+c+QZraICPDblIx/1rJ83NCdvB0yFxotAzkbHW/Fr+w
         kYj5/z33czIxRM2dOnVeGc2HyJgNazq8PDHGvb9FWRLoqjG+fQJGI7apO1F/NA6cJh/p
         yACX/c8sizIWJSxfoTGVW/jEvnBpV8mWgsY9wxThuZYg0Pv7EPuxMThvzad8CVdyh84w
         b52tipPsUImlwg4D3OS4juDsavG1RbWjbqdVbUdhDGqLKbsjZe86MzHSECDG0ggqnxYu
         5sVJfcpSXv4QdtGK2wbn3CNLyle6I4RCcwsAI/cszAKD1Rrc5xjCQr+suJ1rnTW1CvhW
         wrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738630747; x=1739235547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4j+qmqoQwY09I8DP4lfGxeBXOY3+ArSp5V1tfcv07o=;
        b=WDk0C/stR76X81ugbv6SyIZG8cBiZYd6YTbjlvdgw2AOJGABDkXV3u6xOFEbStAbgK
         CpswCNTS46zGfNN6ADTfxX/yzzvRUio+mUtrmSVUpc4vB/Mx0Y3QQoi18o26dfvZ/73i
         NBmr11GBzF9QrQwOYCSaDO6kpeuQmiwBKe7aqfERLmCL/eaOUgGOlMxACtmB7lAha34B
         7gvEqyXIdzn3CM4s7osjajQ2UBshk240kP+0wgO1xTQ9qrSXHZ3KaM+X9upyckLqz3nh
         sLv/WyELEfUcUTncAIjhGlL0suReRAUW6Z284mwK84nz0E2RPI04yxQHogN5xZPn8UOe
         yCOw==
X-Gm-Message-State: AOJu0YwqbCMcKaTSqinDhQFQPZSpIIz2D3D7GfO2/4DNqEsIPtB14fkn
	DcDt0idvl9Oo8/GlgRzjZ5SnwXTbIxV+EsM9cZhXYH8kfvlO3DSociAASQ==
X-Gm-Gg: ASbGncsAgjR3MTpkwi9yY0J6HQdMB75UtQNNevc3NlS7DyKG7YjsSpgl4iMyuCHc3Yl
	50pmYbExyqIWAB81mlGPoKWOcOlxelsLtrwTBk6zFVExAKqzizmPV/kSae+GMzU0vntbB7Pa3KE
	ZGZcrQ5d9Gzk2UdiSjnGf9QC+QnxTEo1jVWdaRtC7NtfgeWzfNG/jwWbDCB+cNGw4O5CXM5/sYI
	4Ailvj4OdcfXsHlaIo/XFlJFMdxisOYqU2eUmeeTWzZjPiNCuPASGTn9Fc3UD0NT2g/sdigpGTR
	dkw3Ln8M+X6gI+sI00pOlDFQB8K2V66C08/70U3Xw0yC
X-Google-Smtp-Source: AGHT+IEPSEN3Ay1LnZn9qzmdlGMWV24D18lyhnzc5mqPN9JXMqRE8Wis4Flm/qRWlgo1GSIW//35Iw==
X-Received: by 2002:a05:6a00:2917:b0:72f:59d8:43ed with SMTP id d2e1a72fcca58-72fd0c0b851mr30022584b3a.14.1738630747033;
        Mon, 03 Feb 2025 16:59:07 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:90d2:24fd:b5ba:920d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6427b95sm9207069b3a.49.2025.02.03.16.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 16:59:06 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	pctammela@mojatatu.com,
	mincho@theori.io,
	quanglex97@gmail.com,
	Cong Wang <cong.wang@bytedance.com>,
	Martin Ottens <martin.ottens@fau.de>
Subject: [Patch net v3 3/4] netem: Update sch->q.qlen before qdisc_tree_reduce_backlog()
Date: Mon,  3 Feb 2025 16:58:40 -0800
Message-Id: <20250204005841.223511-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204005841.223511-1-xiyou.wangcong@gmail.com>
References: <20250204005841.223511-1-xiyou.wangcong@gmail.com>
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
child qdisc before calling it. Otherwise it would miss the opportunity
to call cops->qlen_notify(), in the case of DRR, it resulted in UAF
since DRR uses ->qlen_notify() to maintain its active list.

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



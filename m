Return-Path: <netdev+bounces-46104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890237E1608
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 20:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1681C2097F
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 19:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EBE11711;
	Sun,  5 Nov 2023 19:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacex.com header.i=@spacex.com header.b="fyWEHhNA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52274171A3
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 19:27:02 +0000 (UTC)
Received: from mx5.spacex.com (mx5.spacex.com [192.31.242.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6A9DD;
	Sun,  5 Nov 2023 11:26:57 -0800 (PST)
Received: from pps.filterd (mx5.spacex.com [127.0.0.1])
	by mx5.spacex.com (8.17.1.19/8.17.1.19) with ESMTP id 3A5JIsbl017080;
	Sun, 5 Nov 2023 11:26:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spacex.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=dkim;
 bh=RY+3KPtla6eCZYhFQY7c+G/ogFNLxfccfSjdouCLTZk=;
 b=fyWEHhNAimkN9bY8F0uhMIC0fGR2Xh0nVNkNkNCuEoqfLxzrGxr5geYp1C2FD3qhYyKS
 7hsaRscHgqlGsSehdrsPvzqB5qGdvJ8U7S+9YretICtqiWBGin8T76bHusT7AWL59Ihm
 RqgbPd6tTpHtt5g9KPu8ISykhcX1QKgZ/GtlfpszrmPlFagMljSzWWypg5BhJ5fP6YvV
 QEjWikEeEHvGkFaUj5lT4oij/AHqcNiR95gWkkhDes/1nag727REbgcZPSa4bz7DF1Nl
 97u2vWRuHuIZKuV/uGJK9x4guAZ+ZwrTSw6J48s7ae72f81ZY1Phbg5y74pxSAOOhkoE jg== 
Received: from smtp.spacex.corp ([10.34.3.234])
	by mx5.spacex.com (PPS) with ESMTPS id 3u5kcm0xqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 05 Nov 2023 11:26:55 -0800
Received: from apakhunov-z4.spacex.corp (10.1.32.161) by
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 5 Nov 2023 11:26:54 -0800
From: Alex Pakhunov <alexey.pakhunov@spacex.com>
To: <michael.chan@broadcom.com>
CC: <alexey.pakhunov@spacex.com>, <linux-kernel@vger.kernel.org>,
        <mchan@broadcom.com>, <netdev@vger.kernel.org>,
        <prashant@broadcom.com>, <siva.kallam@broadcom.com>,
        <vincent.wong2@spacex.com>
Subject: Re: [PATCH v2 1/2] tg3: Increment tx_dropped in tg3_tso_bug()
Date: Sun, 5 Nov 2023 11:26:43 -0800
Message-ID: <20231105192643.318753-1-alexey.pakhunov@spacex.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <CACKFLi=ZLAb1Y92LwvqjOGPCuinka7qbHwDP2pkG4-_a7DMorQ@mail.gmail.com>
References: <CACKFLi=ZLAb1Y92LwvqjOGPCuinka7qbHwDP2pkG4-_a7DMorQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ht-dc-ex-d1-n2.spacex.corp (10.34.3.231) To
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234)
X-Proofpoint-GUID: tf4WSUt1rgsjceQbA-wp1M0E3f4c2Wgd
X-Proofpoint-ORIG-GUID: tf4WSUt1rgsjceQbA-wp1M0E3f4c2Wgd
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxlogscore=886 lowpriorityscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311050168

> I recommend using per queue counters as briefly mentioned in my
> earlier reply...
> tg3_get_stats64() can just loop and sum all the tx_dropped and
> rx_dropped counters in each tg3_napi struct.  We don't worry about
> locks here since we are just reading.

Got it. So the core idea is to make sure there is a single writer for each
counter which will make updating the counter race-free. It does not keep
reading the counters from multiple queues completely race free, but, I
guess, the assumption is that computing the aggregate counter to be
slightly wrong is acceptable - it will be recomputed correctly next time.

There is still some gotchas on 32 bit machines though. 64 bit reads are not
atomic there, so we have to make the counters 32bit to compensate:

====
@@ -11895,6 +11898,9 @@ static void tg3_get_nstats(struct tg3 *tp, struct rtnl_link_stats64 *stats)
 {
        struct rtnl_link_stats64 *old_stats = &tp->net_stats_prev;
        struct tg3_hw_stats *hw_stats = tp->hw_stats;
+       uintptr_t rx_dropped = 0;
+       uintptr_t tx_dropped = 0;
+       int i;

        stats->rx_packets = old_stats->rx_packets +
                get_stat64(&hw_stats->rx_ucast_packets) +
@@ -11941,8 +11947,27 @@ static void tg3_get_nstats(struct tg3 *tp, struct rtnl_link_stats64 *stats)
        stats->rx_missed_errors = old_stats->rx_missed_errors +
                get_stat64(&hw_stats->rx_discards);

-       stats->rx_dropped = tp->rx_dropped;
-       stats->tx_dropped = tp->tx_dropped;
+       /* Aggregate per-queue counters. Each per-queue counter is updated by
+        * a single writer, race-free. The aggregare counters might be not
+        * completely accurate (if an update happens in the middle of the loop)
+        * but they will be recomputed correctly the next time this function is
+        * called. This avoids explicit synchronization between this function
+        * and tg3_rx()/tg3_start_xmit().
+        **/
+       for (i = 0; i < tp->irq_cnt; i++) {
+               struct tg3_napi *tnapi = &tp->napi[i];
+
+               rx_dropped += tnapi->rx_dropped;
+               tx_dropped += tnapi->tx_dropped;
+       }
+
+       /* Since we are using uintptr_t, these counters wrap around at 4G on
+        * a 32bit machine. This seems like an acceptable price for being
+        * able to read them atomically in the loop above.
+        */
+       stats->rx_dropped = rx_dropped;
+       stats->tx_dropped = tx_dropped;
+
 }
====

An alternative implementation would use atomic64_add to update
tg3::[rt]x_dropped. It would allow the counters to be 64 bit even on 32 bit
machines. The downside is that updating the counter will be slightly more
expensive. There counters are not updated often, so the cost is negligible.
ALthough it also means that preactically speaking we don't care if
the counters are effectively 32 bits wide.

I'll assume you prefer the former implementation for now, but let me know
if this not the case.

> Yes, we can merge patch #2 first which fixes the stall.  Please repost
> just patch #2 standalone if you want to do that.

OK, I posted "[PATCH v3] tg3: Fix the TX ring stall".

Alex.


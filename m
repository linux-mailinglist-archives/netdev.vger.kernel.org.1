Return-Path: <netdev+bounces-45929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A94FF7E0730
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 18:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577BB1F217C7
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 17:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107921DFC2;
	Fri,  3 Nov 2023 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacex.com header.i=@spacex.com header.b="WAWiV5Aa"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4392C2107
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 17:07:29 +0000 (UTC)
Received: from mx4.spacex.com (mx4.spacex.com [192.31.242.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08488E;
	Fri,  3 Nov 2023 10:07:24 -0700 (PDT)
Received: from pps.filterd (mx4.spacex.com [127.0.0.1])
	by mx4.spacex.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3GiWa6010607;
	Fri, 3 Nov 2023 10:07:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spacex.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=dkim;
 bh=Jqxpo9JM76UDQUoSzJ4bWswVG1V5NnihjPx+B3E+hw0=;
 b=WAWiV5AaBYkTA4iJHnjMAkZMV6Lf8ZaXT+Yp/SkJ7eBNhVAKLlZqFnaW3MDSckmnVfaX
 hRDRrFTngcT2bfbuck8/Nqb3V5s1XbgJHTufXKqsv623zjxVCYSNlriizbLbmfD97PXl
 darkarofvWANMH50AKqSnlDjykKL+pHV9EUibPbJKUeqwAnNqI+PQ61ezeA1n5WX5cWA
 bMBx2V5y49mvL/WJqRhhhcr8AhydpYXInetS3lYSd9oMyydzSb+Njg1XfLP1NBZ//QnL
 UtzRJz58Z0QdOpUvqqtk5I+rHU826dAaW+u9O6tnxsUAYHHegyXDo44O9Yt+Gw5J3EhP lQ== 
Received: from smtp.spacex.corp ([10.34.3.234])
	by mx4.spacex.com (PPS) with ESMTPS id 3u0yqn8mwh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 03 Nov 2023 10:07:21 -0700
Received: from apakhunov-z4.spacex.corp (10.1.32.161) by
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 10:07:21 -0700
From: Alex Pakhunov <alexey.pakhunov@spacex.com>
To: <michael.chan@broadcom.com>
CC: <alexey.pakhunov@spacex.com>, <linux-kernel@vger.kernel.org>,
        <mchan@broadcom.com>, <netdev@vger.kernel.org>,
        <prashant@broadcom.com>, <siva.kallam@broadcom.com>,
        <vincent.wong2@spacex.com>
Subject: Re: [PATCH v2 1/2] tg3: Increment tx_dropped in tg3_tso_bug()
Date: Fri, 3 Nov 2023 10:07:11 -0700
Message-ID: <20231103170711.4006756-1-alexey.pakhunov@spacex.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <CACKFLik-Ey1eptrCkhSEp0Oi66kBKnVWa+yDk7-_uzxqSTHb6A@mail.gmail.com>
References: <CACKFLik-Ey1eptrCkhSEp0Oi66kBKnVWa+yDk7-_uzxqSTHb6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ht-dc-ex-d4-n3.spacex.corp (10.34.3.241) To
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234)
X-Proofpoint-ORIG-GUID: Slrv5khXa-Qp2xS2LvVH4u5DDRv_8ShW
X-Proofpoint-GUID: Slrv5khXa-Qp2xS2LvVH4u5DDRv_8ShW
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 mlxlogscore=972 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030143

> This is prone to race conditions if we have more than one TX queue.

Yes, indeed.

> The original driver code only supported one TX queue and the counters
> were never modified properly to support multiple queues.  We should
> convert them to per queue counters by moving tx_dropped and rx_dropped
> to the tg3_napi struct.

I'm not super familiar with the recommended approach for handling locks in
network drivers, so I spent a bit of tme looking at what tg3 does.

It seems that there are a few ways to remove the race condition when
working with these counters:

1. Use atomic increments. It is easy but every update is more expensive
   than it needs to be. We might be able to say that there specific
   counters are updated rarely, so maybe we don't care too much.
2. netif_tx_lock is already taken when tx_droped is incremented - wrap
   rx_dropped increment and reading both counters in netif_tx_lock. This
   seems legal since tg3_tx() can take netif_tx_lock. I'm not sure how to
   order netif_tx_lock and tp->lock, since tg3_get_stats64() takes
   the latter. Should netif_tx_lock be takes inside tp->lock? Should they
   be not nested?
3. Using tp->lock to protect rx_dropped (tg3_poll_link() already takes it
   so it must be legal) and netif_tx_lock to protect tx_dropped.

There are probably other options. Can you recommend an aproach?

Also, this seems like a larger change that should be done separately from
fixing the TX stall. Should we land just "[PATCH v2 2/2]"? Should we land
the whole patch (since it does not make race condition much worse) and fix
the race condition separately?

Alex.


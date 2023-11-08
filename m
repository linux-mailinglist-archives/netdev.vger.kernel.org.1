Return-Path: <netdev+bounces-46686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1767E5D0A
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 19:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04DC4281322
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 18:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF2A34CF3;
	Wed,  8 Nov 2023 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacex.com header.i=@spacex.com header.b="tdwrwsRH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FDF32C89
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 18:18:25 +0000 (UTC)
Received: from mx4.spacex.com (mx4.spacex.com [192.31.242.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EB61FF5;
	Wed,  8 Nov 2023 10:18:25 -0800 (PST)
Received: from pps.filterd (mx4.spacex.com [127.0.0.1])
	by mx4.spacex.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8FNEgQ027359;
	Wed, 8 Nov 2023 10:18:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spacex.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=dkim;
 bh=W8cvhAaEJYR71hNFqVzlUXZD9kV8rO2LTgZfiSB83Nk=;
 b=tdwrwsRHAlvbhdY4MNIVNyI6nXzcHhxDFdU6XE1jqeMqtlH7I6TMHLijlVy2PyYf+llp
 wSbN9LkpXQzqZH5YVRawJHXWX2+qkIQOv3Pvn0KXpCsi/PFc/35Mu8ygza5N1ilROIXb
 pTjj0h0iZpjGyV2y6hqK+kHwvZPltFABOuhUrEIptTu8qwOpgIypB5B34oO79UKD5x95
 t7NAoLmlmEoyUt6k+8UivZkTVot62Jr7q2TrGvRCvqmCRTnklGK6jbxpZiQHIdCvuciC
 R9JQRMi3jvYPB0VOoDHgfJdH03l4U66aAEJzjW7VrfrxHkYidk+FwBvsQ8G30TrbI25Q Ng== 
Received: from smtp.spacex.corp ([10.34.3.234])
	by mx4.spacex.com (PPS) with ESMTPS id 3u7w34sje7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 08 Nov 2023 10:18:19 -0800
Received: from apakhunov-z4.spacex.corp (10.1.32.161) by
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 10:18:18 -0800
From: Alex Pakhunov <alexey.pakhunov@spacex.com>
To: <michael.chan@broadcom.com>
CC: <alexey.pakhunov@spacex.com>, <linux-kernel@vger.kernel.org>,
        <mchan@broadcom.com>, <netdev@vger.kernel.org>,
        <prashant@broadcom.com>, <siva.kallam@broadcom.com>,
        <vincent.wong2@spacex.com>
Subject: Re: [PATCH 1/2] tg3: Move the [rt]x_dropped counters to tg3_napi
Date: Wed, 8 Nov 2023 10:18:09 -0800
Message-ID: <20231108181809.2405257-1-alexey.pakhunov@spacex.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <CACKFLi=VL8kHH-Q4UQF60tGaK2dk7NgH_9-yJpP7hgn_NE9e7Q@mail.gmail.com>
References: <CACKFLi=VL8kHH-Q4UQF60tGaK2dk7NgH_9-yJpP7hgn_NE9e7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HT-DC-EX-D2-N1.spacex.corp (10.34.3.233) To
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234)
X-Proofpoint-GUID: Q39YampAxzJE5zxxauUO77Ij2rQS7Ijk
X-Proofpoint-ORIG-GUID: Q39YampAxzJE5zxxauUO77Ij2rQS7Ijk
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0 adultscore=0
 mlxscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080151

Hi,

> I think here we need to keep these counters accumulate across a reset:
> 
> stats->rx_dropped = old_stats->rx_dropped + rx_dropped;
> stats->tx_dropped = old_stats->tx_dropped + tx_dropped;

Hm, tg3_halt() explicitly resets the HW counters:

```
	if (tp->hw_stats) {
		/* Save the stats across chip resets... */
		tg3_get_nstats(tp, &tp->net_stats_prev);
		tg3_get_estats(tp, &tp->estats_prev);

		/* And make sure the next sample is new data */
		memset(tp->hw_stats, 0, sizeof(struct tg3_hw_stats));
	}
```

We sort of doing the same thing with clearing [tr]x_dropped in
tg3_init_rings() but it seems more confusing than helpful. First, why do we
handle different counters differently? Second, tg3_halt() is not always
followed by tg3_init_rings(), so the logic is not consistent.

Instead I think we should just not touch [tr]x_dropped in tg3_init_rings().
The counters will be set to zero when tg3 is allocated in tg3_init_one().
Hardware resets will not change tg3_napi::[tr]x_dropped since they are
purely software counters.

Alex.


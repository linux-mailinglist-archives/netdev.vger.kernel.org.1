Return-Path: <netdev+bounces-47421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 124107EA26D
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 18:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF34D1F2202D
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 17:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6DB2137E;
	Mon, 13 Nov 2023 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacex.com header.i=@spacex.com header.b="mz296ekG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF76225A6
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 17:52:27 +0000 (UTC)
Received: from mx5.spacex.com (mx5.spacex.com [192.31.242.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2F510EC;
	Mon, 13 Nov 2023 09:52:26 -0800 (PST)
Received: from pps.filterd (mx5.spacex.com [127.0.0.1])
	by mx5.spacex.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADG7ufB026420;
	Mon, 13 Nov 2023 09:52:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spacex.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=dkim;
 bh=OAedADIDq7Yy/leBF8yLvmN9Q5ZHAfPjVXFuK05A8Vc=;
 b=mz296ekGLs70ZxPAJF0XIvMpdOeHglBRTI+pNcSlk4BrQP6Kr7Iigz1tY1KNi6o+jRRb
 /noTs+2XV351CMpprXq9xMVadi61hb7AQFoY+qvhHe2zFqb69kmT1w+Xa2Pm9+vBEf7g
 OqDpvec4eecutQir9Llv3fqzfU3yCQTkB6e0tnZvMJ+dcMwFGMNn01fOFRHR4WdaYlAa
 SKh1YUoJL1rRAV1qR2+8jTsfP0vCoomdmefdfXxUAGf4WisLB2qihxPE978d9mm3TYRw
 cY+pciNDAMxHo+dFYjrEFn02l4uAgPsNUvAE3nxeZOTUj3s2Jq94/uk930Ui01cWTM0U QQ== 
Received: from smtp.spacex.corp ([10.34.3.234])
	by mx5.spacex.com (PPS) with ESMTPS id 3ua7wsa55f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 13 Nov 2023 09:52:17 -0800
Received: from apakhunov-z4.spacex.corp (10.1.32.161) by
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 09:52:16 -0800
From: Alex Pakhunov <alexey.pakhunov@spacex.com>
To: <andrew@lunn.ch>
CC: <alexey.pakhunov@spacex.com>, <linux-kernel@vger.kernel.org>,
        <mchan@broadcom.com>, <netdev@vger.kernel.org>,
        <prashant@broadcom.com>, <siva.kallam@broadcom.com>,
        <vincent.wong2@spacex.com>
Subject: Re: [PATCH v2 1/2] tg3: Move the [rt]x_dropped counters to tg3_napi
Date: Mon, 13 Nov 2023 09:52:04 -0800
Message-ID: <20231113175204.4193922-1-alexey.pakhunov@spacex.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <7f1604fd-4bd6-4f16-8aed-2586afac7d15@lunn.ch>
References: <7f1604fd-4bd6-4f16-8aed-2586afac7d15@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ht-dc-ex-d4-n2.spacex.corp (10.34.3.240) To
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234)
X-Proofpoint-GUID: _5hxAL3tMxclKqisjqg7aZvMArbTyrld
X-Proofpoint-ORIG-GUID: _5hxAL3tMxclKqisjqg7aZvMArbTyrld
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 spamscore=0 phishscore=0
 mlxlogscore=562 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311130147

Hi,

> Isn't this wrapping artificial? old_stats is of type
> rtnl_link_stats64, so the counters are 64 bit.

The wrapping here is needed as long as tnapi->[rt]x_dropped counters are 32
bit wide. It makes sure the resulting value is correctly wrapped.
tnapi->[rt]x_dropped counters are 32 bit on 32 bit systems to make sure
they can be read atomically.

> Why not use include/linux/u64_stats_sync.h, which should cost you
> nothing on 64 bit machines, and do the right thing on 32 bit machines.

It should be possible to use include/linux/u64_stats_sync.h but it seems
like overkill in this case. First, we mostly care whether the counters are
not zero and/or incremening. We typically don't care about the exact value.
Second, the counters are unlikely to ever reach 4G. Essentially, they are
incremented on memory allocation failures only meaning that the system need
to be in a completely wedged state for a very long time for this to happen.

Given the above additional complexity of u64_stats_sync.h does not seem to
be worth it.

Alex.


Return-Path: <netdev+bounces-47429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1B27EA2B4
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 19:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3B8280E64
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 18:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F2E22EFE;
	Mon, 13 Nov 2023 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacex.com header.i=@spacex.com header.b="d/4lE3wf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D5B22EFA
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 18:18:55 +0000 (UTC)
Received: from mx2.spacex.com (mx2.spacex.com [192.31.242.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124EB93;
	Mon, 13 Nov 2023 10:18:54 -0800 (PST)
Received: from pps.filterd (mx2.spacex.com [127.0.0.1])
	by mx2.spacex.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADG6sPr010913;
	Mon, 13 Nov 2023 10:18:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spacex.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=dkim;
 bh=oBt7Sm3h2IjhuApOOIGiSDMI51d385xVK1eZkUaB7Vk=;
 b=d/4lE3wfrT6EHGQg6TTlAMTwshwfy95v+imXTJd46Th9vPdFm7sjLCqeo94q7vcMZYpT
 /UwfBkRARCgvag0ww0gFs8/BHIxT1+UaL2vbb1HUCS2zu2k+re6W7zqXVRhQTChkiGoi
 XfmbRwjhomM0yEkbpgHFm99UF4hHjzf/bJ/m59xF8wziRt4sX4YI7xEZGivsmJdkG6vI
 KN2jNDTeD7nDPvX/ZfV53ZFBIHL+oKgX5T3hwW/+RaXbOOhmjmp76lMKhIEZ+58Fr2Uy
 FEwgh+5RSp5V0q+ttnEF08aGqpsjCKeO2WwJ6UfnOrtahBGtWQ0g6grScCsuOcnW8Ppk kQ== 
Received: from smtp.spacex.corp ([10.34.3.234])
	by mx2.spacex.com (PPS) with ESMTPS id 3ua7wna78r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 13 Nov 2023 10:18:52 -0800
Received: from apakhunov-z4.spacex.corp (10.1.32.161) by
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 10:18:51 -0800
From: Alex Pakhunov <alexey.pakhunov@spacex.com>
To: <alexey.pakhunov@spacex.com>
CC: <linux-kernel@vger.kernel.org>, <mchan@broadcom.com>,
        <netdev@vger.kernel.org>, <prashant@broadcom.com>,
        <siva.kallam@broadcom.com>, <vincent.wong2@spacex.com>
Subject: Re: [PATCH v3 1/2] tg3: Increment tx_dropped in tg3_tso_bug()
Date: Mon, 13 Nov 2023 10:18:42 -0800
Message-ID: <20231113181842.31936-1-alexey.pakhunov@spacex.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231113181325.26203-1-alexey.pakhunov@spacex.com>
References: <20231113181325.26203-1-alexey.pakhunov@spacex.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ht-dc-ex-d4-n1.spacex.corp (10.34.3.239) To
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234)
X-Proofpoint-ORIG-GUID: T4LbQ1HhD9N6Psi2RUU3JEiVMiv2-VyA
X-Proofpoint-GUID: T4LbQ1HhD9N6Psi2RUU3JEiVMiv2-VyA
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=696 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311130150

> tg3_tso_bug() drops a packet if it cannot be segmented for any reason.
> The number of discarded frames should be incremented accordingly.

Apologies, I submitted this patch with a wrong commit message. Please
ignore "PATCH v3". I'll resubmit with the correct commit message shortly.

Alex.


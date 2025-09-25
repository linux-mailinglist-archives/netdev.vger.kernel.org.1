Return-Path: <netdev+bounces-226506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D2FBA11CE
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 21:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73851C25D90
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 19:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647EE31B13A;
	Thu, 25 Sep 2025 19:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="sD8BGHRU"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022077.outbound.protection.outlook.com [40.107.200.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B84C31D726;
	Thu, 25 Sep 2025 19:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758826851; cv=fail; b=uI4OwQwdtg2JPHBlmwRTKbMUWBY6eio6xhiNshf8SffVvd6oQhtn7xgStMsriPIhXdvPuorPoKTMqyLsloTLKfHgR0qeiyLJcPSrp0DNFIowd/b2RZdZDydUJJ25xgr9Tb3DBwh56wzoJCGAa/9Jpm3EIY2xxdpDdAB0h/shaXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758826851; c=relaxed/simple;
	bh=ubE0fvvoQpMs2+FRTkG14g4acM6NSSMyaYHQjA3zDPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hh41PU+mRCgwiw7vDI6PHN6TWsBd4IpobahSvfpOmn7oIWmzzAqJSmUv9vpj4qnM/vkRQMPrpQ6oAEG6qTXlqHdvqJsH2G2SfAIFWzjFifRV3cVATHlW/eIeNSNcQeBgXHblpOUzKW4yxRT/L6sF8wld0o1LOlcHjaFjNeEoN54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=sD8BGHRU; arc=fail smtp.client-ip=40.107.200.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bud59WOrABjUrvCifHiA/W1FprZgINTk7x0VJhSmO+uqRRNr896bNxvKHehR80ykTlVoLSKX1W9VMC7RR0gmBMvPHKp3o913l1VFZWClf4QU0s3VDeZ6nJ7LnPhB5VI7F/cgaOCpsZGeft9w0zmAgo6pkohFePz39M/v03Y9Qs1t0o54hL2ZqoKsNclRrFZbydyrNtyDkeuHzsOtpoU3jamlMCXE3kiu5i4qstzdp4eA7Et8/E25CcNus9B8c0BJRROGp6ueN8PM8ISXLqbAiiGpPMvMvuG+ZNfxOzMEfV/ir7FpJAK91alCTc8FA7h9+qo5ghqDtKk88wS3XhzeAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmehq7ikn65P/zfvJ47JykRJi818kHE2QSVn6ZnL17E=;
 b=Veb7trkuApW0gYRt4jTjV3QjvALkVKgh5wi2LhJb/C027nMiexLghh9IS72MJoCq6JLc52JzBoiZUUkPOr+xVz6ZQD8DcfRChZNVDb/xg6MycTfuoZLkObrOWagqGnOwddbwqX62DzY/w+okEgrukJ1AUlc6TPDUY7Hs305qhLONZg267j0ul7KIfpKIi6Iu5ksqHFBkC1kjHq2A9oFetzsZdNSceK7b+dV3TutNss8dEvYAu7ruPBRrDoFQJEdDxVaLJY66VS9aXqhN5mGq7giW+KAgFC+ex11wvkChGxQaFTdgMk0RSiLJH1QE+FF8vNxAwkgKPWMAxr0PXzSBrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmehq7ikn65P/zfvJ47JykRJi818kHE2QSVn6ZnL17E=;
 b=sD8BGHRU0tyeFMcffEPQKzEDyPxI5aDvfptK+fIue6cSNw5Z64+x3WhuhsQVhPGLNHc4gshvMlXJ+Ck9qFWlG19XmDjXt6WKl9GvOXctr0fGyIHGxkntr7wBp7GIb7N41QnH5AgoOKTOQk86ixnw1q9Q5BfRrf1WL25u528VU4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SJ0PR01MB6160.prod.exchangelabs.com (2603:10b6:a03:2a1::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.11; Thu, 25 Sep 2025 19:00:44 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 19:00:44 +0000
From: Adam Young <admiyo@os.amperecomputing.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH net-next v29 3/3] mctp pcc: Implement MCTP over PCC Transport
Date: Thu, 25 Sep 2025 15:00:26 -0400
Message-ID: <20250925190027.147405-4-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925190027.147405-1-admiyo@os.amperecomputing.com>
References: <20250925190027.147405-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0214.namprd15.prod.outlook.com
 (2603:10b6:930:88::10) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SJ0PR01MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f15514-cd4c-477f-b65e-08ddfc65d42d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kuixhSn/eVOlvy80OBAHxwyjSTfXyAnO+JhnLlw0cPLOl0pV9YOnjkNMZGvS?=
 =?us-ascii?Q?H7/2Mo4HC14hUul0Tb0faXVzvXsq/XOV8yebqYwoBUfjB7WSsgJtZVShQQQw?=
 =?us-ascii?Q?7PZYtJj5CyyFtHgsyb3PzsUcupi0x6m+nTQHpqyG+Ak5U7gdphg6Q7Af7ZpT?=
 =?us-ascii?Q?8sro3gC8l3YRDXBRtWgrzyhFcwxELpKTb8lxrr+zmXP51Vd3CL1V4yk8BXoT?=
 =?us-ascii?Q?T52CIkE9mpffna7UYIwHMNPUt3pVq2w32xsg+ccxDzvdkzJ+Mtx1+pe/OvqX?=
 =?us-ascii?Q?RObrGJc0oezgzwvj8dJ/dZtHLi44k6uUc/ugityEcMPfF8MFwFpkOpYazatj?=
 =?us-ascii?Q?tVUdP3GFMmTUByo7ZbU41dPI6fRm4T51JPeufZCE1vOAHleVu64K08KLiyRC?=
 =?us-ascii?Q?CCAQBtxFo0f1GveDwmuzJj8lYcivNNupHcuaewLh4HLUyVtbke+9tPTBJVLx?=
 =?us-ascii?Q?hh5SCrnTycpDaZn/CfPg18V1dTbFYAOvteILkwSz5gMv4jFM7VVwbZgvdr68?=
 =?us-ascii?Q?Cco2WX14R4xJnp45jNwpdorepdRft1hBpjD8ZgSdaw6Fr6kNII3N+hWUoayp?=
 =?us-ascii?Q?MSFFa/gfVjT5ToUHFU6Ine9lYkrn8Kf7RE8a1n84rkwQCjjXN7oS8ms21F9a?=
 =?us-ascii?Q?oTyD8wQCwDVzD5snr2qJ+RJNnOkJE8VFxOjPEcKxKtx4vxN9QM3BavAxzMNR?=
 =?us-ascii?Q?t6jlCJK9ycLIVHYadltD7g9WGLWN3PhUwMXQAkZWK85A9AcsOUjmHQCzy1/y?=
 =?us-ascii?Q?jMuUL48Ony0Vb83J0QznAhMSudR0Us5jZkNtWhNnRBOcwUd5e96+4++tIBMi?=
 =?us-ascii?Q?yZGqKyjWxP7WkGTu2/97vKqVLh0nLWuxF3MZSYss6rj/GFWVcLd7gKBwvzY3?=
 =?us-ascii?Q?PWY5QCCcyOdQyhsv+3fLGGpfBuOAXMHFOIeJQSLMtx38I37g/+JN72AyaL1R?=
 =?us-ascii?Q?+e23XyjvYxFbPbEMzRr7pJhr5CFHy5hOJNSyrAWCED+PWZneUBUFNNwuOy38?=
 =?us-ascii?Q?98lhfdzSwHKpeC0d9IQ8dxXpNjTZeBFoXRwJX8wb4r46iVKAyzfUpbwxJjAt?=
 =?us-ascii?Q?8fmX5IG95FqOdmVJGYC1fbrTnhJ3F6DZIQ3ciT20dDbqg2rwwkPduNH+BZDg?=
 =?us-ascii?Q?e9lERvIwHDTWDXVzfN82m9sXu/pXJ4345dCyAgSY+eV1OqKviCDW14JU8vgN?=
 =?us-ascii?Q?vcpPovKIgN0QaUl1u/jpeUxFihNBFP3M2xRWbH4owBC+K6NrCOCSQR9ss+yZ?=
 =?us-ascii?Q?MY6QlZYKDcQXghMDjepuQPBILL0JmLSp33o9fdkBHKcCVg/N9EweBg3v4Ndt?=
 =?us-ascii?Q?H6KrEUEcLedRHwxbYtaStKVS0LuDtuZPN3Mkaacg9VEtW1rKqyg6SLZiPBoX?=
 =?us-ascii?Q?Ys72HN3x6eggev3A6DM1/IASJ9/vOI0ur/Xh2opeCkR3ryKp1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?go2KIF6Vt2nvkm9lzP/s9+sXt8oU9X/QbirGbpGcBIYxi7HjED0c+xnXyqwM?=
 =?us-ascii?Q?NM4YQLViNIfWmyXgFnuX+KPq+kTYr6xL3jlieQ5n+1/oR4gqG9/FkfPGvP6P?=
 =?us-ascii?Q?sAPBKMlE2mSBzCrY6faeOyx5UP/JyNyN4XwJQ3pO5bctKRT9rdvldaV6H0qJ?=
 =?us-ascii?Q?VrnAv9ZIFKSAVC4WCgCQ3zatvz7Ge83YIiZErAB5iL5wnJlrfNvz7uTLwWuG?=
 =?us-ascii?Q?UnATVuAY7m2/irMIMuCK1T9UH3zi41ozmIZpmH55ZF2tr08/lpuYhA1Uc4JG?=
 =?us-ascii?Q?EQ1+v7ZkQlLkzlmjcbiWMUgetBvDFplaDBg/tdW7YeIaubl4ohvEt0WyN+aw?=
 =?us-ascii?Q?3H9KTyfi7ixe7giSZv7/Gn520Wq0BxDBl2CRkCu/6L6/+bdfpmH/R5z9VHYy?=
 =?us-ascii?Q?OvryBiJZshkD2HU3FgTWowKXObHu78Xb7BcSnJIzLGjjZs7jWLwKCosPdd5j?=
 =?us-ascii?Q?KdJv9fHiB3hBINovT1zzf10VBjNx4ozWU37QSAb8YUzW6YxVsuvygo6oM+aE?=
 =?us-ascii?Q?Gvo6B13UDmaAQqPOt7Rb/8eZkZFeNdCSs2QAjF9ZFJvlPK3kkB0QywcsZQbD?=
 =?us-ascii?Q?hy5GIxcrX0JCylJb7pwXZ2zdGwZ+EGtILWmVx0huKDPtN+GGeWwYmisWUtmF?=
 =?us-ascii?Q?UzvqulkFB3GkKCdzko/UkFX1RUPARWrKqZDjXHdQh7W8+Yey5HM8sQCJBrxI?=
 =?us-ascii?Q?1uE7Epxl6uTajyjxjzaGxl0EjBrX0GyhCp9P8S6l4/tgtXGAK4d9JrBcNygu?=
 =?us-ascii?Q?voCs09JrKKvmB60V43u9knK3NQX/DQALmZa5frkTp2naiOl8ao0qJel3H9f5?=
 =?us-ascii?Q?GX/aPzMih6refLq9K+0bYrBvlr1uY8fUiweYycxChTzG1Rb1gnX6M1+IgSIh?=
 =?us-ascii?Q?5mCUThZ4d/In8K3u4miq07+g7NUH34qQ/d/sN5n1vM+N7VzCMHu/NZTtDyXe?=
 =?us-ascii?Q?5dJm3+jHClkzkNpIwgfC2WdJFNMBf89Gss7uIHLaLFzR+coImaM8GIHk8G7y?=
 =?us-ascii?Q?oZWZsSIWQeEQPhXbvdr+K7Nrej5yjxO0AYY5NZmjlMzKM9s0sMKrhqJGX/Xw?=
 =?us-ascii?Q?fgU8Ptcxuj1Tj/4K9Sx7KpTv3X9g6BJITcpIu2JmrN2LWtES0s+qmeNjbhun?=
 =?us-ascii?Q?lf5X1bIgWBt7cwFTu9qEiXErL/ezThqRMDEOiXWdQCJB2KS7ZvL4bpGATau5?=
 =?us-ascii?Q?R3XAMJtI3vDq2BJNbnCjjiZ2AkweVL8JdGOI7k+DbihMh4zPXNRHv0ubivjI?=
 =?us-ascii?Q?T1F3h6ajjxcNHGz2rG5T6zlzET6HWlbTKYggmkaR9jggds1khA028UUg+gnU?=
 =?us-ascii?Q?LVH7v5jcaV69OJDEONwpvyEtdmUY51e6IDcpFQxUqlU68l3FVqR0IXMgufj/?=
 =?us-ascii?Q?87oeqeDCMo+wUsMjGBNQPHlGybuuviUM2amBDGvSK/DQGrQd0qv3pyB9c86r?=
 =?us-ascii?Q?hbsahDKMloeKYX6PoPP20y9lahrzc1Mbyumf/u7ly7twn+zM7CDsmPrX5JXN?=
 =?us-ascii?Q?pLAIdS9uuSWNn4I24fIH4xGXmK4xFwbhw/xJ4PsswVtSEi2fMdydlxjE1Me2?=
 =?us-ascii?Q?dJ0EvX1CdMQM6/v+Dnb7+rKxWOf//eP/PHW5IFWh8kABrR160+YTkR5u1b8c?=
 =?us-ascii?Q?Kzn0p/Qchj9VTCctzo+yGAuiy2HUZMdZi9VGt6mWen1rOwNA3DvJmmRlIDCC?=
 =?us-ascii?Q?e4Otz9BwaxDlxRy37UIBnBZqwUw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f15514-cd4c-477f-b65e-08ddfc65d42d
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 19:00:43.9848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/ZWLKw3+6WgA7x0ujKTxzscICrQyncZtp80gDlpKvFQtSzsqJWpok/phunowm7dmletyhRJbw9QxdyCjTpJ7gp6kuiGEXQVx4tZ950C8W1/m9YhhjQQyItAKz/MKt2n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6160

Implementation of network driver for
Management Component Transport Protocol(MCTP)
over Platform Communication Channel(PCC)

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/\
DSP0292_1.0.0WIP50.pdf

MCTP devices are specified via ACPI by entries in DSDT/SSDT and reference
channels specified in the PCCT.  Messages are sent on a type 3 and
received on a type 4 channel.  Communication with other devices use the
PCC based doorbell mechanism; a shared memory segment with a corresponding
interrupt and a memory register used to trigger remote interrupts.

This driver takes advantage of PCC mailbox buffer management. The data
section of the struct sk_buff that contains the outgoing packet is sent to
the mailbox, already properly formatted  as a PCC message.

The driver makes use of the mailbox-api rx_alloc callback.  This is
responsible for allocating a struct sk_buff that is then passed to the
mailbox and used to record the data in the shared buffer. It maintains a
list of both outgoing and incoming sk_buffs to match the data buffers.

If the mailbox ring buffer is full, the driver stops the incoming packet
queues until a message has been sent, freeing space in the ring buffer.

When the Type 3 channel outbox receives a txdone response interrupt, it
consumes the outgoing sk_buff, allowing it to be freed.

Bringing up an interface creates the channel between the network driver and
the mailbox driver.  This enables communication with the remote endpoint,
to include the receipt of new messages. Bringing down an interface removes
the channel, and no new messages can be delivered.  Stopping the interface
also frees any packets that are cached in the mailbox ringbuffer.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 341 ++++++++++++++++++++++++++++++++++++
 4 files changed, 360 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a8a770714101..f7b9e935543b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14677,6 +14677,11 @@ F:	include/net/mctpdevice.h
 F:	include/net/netns/mctp.h
 F:	net/mctp/
 
+MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP) over PCC (MCTP-PCC) Driver
+M:	Adam Young <admiyo@os.amperecomputing.com>
+S:	Maintained
+F:	drivers/net/mctp/mctp-pcc.c
+
 MAPLE TREE
 M:	Liam R. Howlett <Liam.Howlett@oracle.com>
 L:	maple-tree@lists.infradead.org
diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index cf325ab0b1ef..01855846491b 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -57,6 +57,19 @@ config MCTP_TRANSPORT_USB
 	  MCTP-over-USB interfaces are peer-to-peer, so each interface
 	  represents a physical connection to one remote MCTP endpoint.
 
+config MCTP_TRANSPORT_PCC
+	tristate "MCTP PCC transport"
+	depends on ACPI
+	help
+	  Provides a driver to access MCTP devices over PCC transport,
+	  A MCTP protocol network device is created via ACPI for each
+	  entry in the DSDT/SSDT that matches the identifier. The Platform
+	  communication channels are selected from the corresponding
+	  entries in the PCCT.
+
+	  Say y here if you need to connect to MCTP endpoints over PCC. To
+	  compile as a module, use m; the module will be called mctp-pcc.
+
 endmenu
 
 endif
diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
index c36006849a1e..2276f148df7c 100644
--- a/drivers/net/mctp/Makefile
+++ b/drivers/net/mctp/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
 obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
 obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
 obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
new file mode 100644
index 000000000000..b525df86e459
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,341 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mctp-pcc.c - Driver for MCTP over PCC.
+ * Copyright (c) 2024-2025, Ampere Computing LLC
+ *
+ */
+
+/* Implementation of MCTP over PCC DMTF Specification DSP0256
+ * https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
+ */
+
+#include <linux/acpi.h>
+#include <linux/if_arp.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+#include <linux/skbuff.h>
+#include <linux/hrtimer.h>
+
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/acrestyp.h>
+#include <acpi/actbl.h>
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
+#include <acpi/pcc.h>
+
+#define MCTP_SIGNATURE          "MCTP"
+#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
+#define MCTP_MIN_MTU            68
+#define PCC_DWORD_TYPE          0x0c
+
+struct mctp_pcc_mailbox {
+	u32 index;
+	struct pcc_mbox_chan *chan;
+	struct mbox_client client;
+	struct sk_buff_head packets;
+};
+
+/* The netdev structure. One of these per PCC adapter. */
+struct mctp_pcc_ndev {
+	struct net_device *ndev;
+	struct acpi_device *acpi_device;
+	struct mctp_pcc_mailbox inbox;
+	struct mctp_pcc_mailbox outbox;
+};
+
+static  void mctp_pcc_rx_alloc(struct mbox_client *c, void **handle, void **buffer, int size)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct sk_buff *skb;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, inbox.client);
+
+	*handle = NULL;
+	*buffer = NULL;
+
+	if (size > mctp_pcc_ndev->ndev->mtu)
+		return;
+	skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
+	if (!skb)
+		return;
+	skb_put(skb, size);
+	skb->protocol = htons(ETH_P_MCTP);
+
+	*buffer = skb->data;
+	*handle = skb;
+}
+
+static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct pcc_header pcc_header;
+	struct sk_buff *skb = buffer;
+	struct mctp_skb_cb *cb;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, inbox.client);
+	if (!buffer) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+
+	if (skb) {
+		dev_dstats_rx_add(mctp_pcc_ndev->ndev, skb->len);
+		skb_reset_mac_header(skb);
+		skb_pull(skb, sizeof(pcc_header));
+		skb_reset_network_header(skb);
+		cb = __mctp_cb(skb);
+		cb->halen = 0;
+		netif_rx(skb);
+	}
+}
+
+static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int r)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *outbox;
+	struct sk_buff *skb = NULL;
+	struct sk_buff *curr_skb;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, outbox.client);
+	outbox = container_of(c, struct mctp_pcc_mailbox, client);
+	spin_lock(&outbox->packets.lock);
+	skb_queue_walk(&outbox->packets, curr_skb) {
+		if (curr_skb->data == mssg) {
+			skb = curr_skb;
+			__skb_unlink(skb, &outbox->packets);
+			break;
+		}
+	}
+	spin_unlock(&outbox->packets.lock);
+	if (skb)
+		dev_consume_skb_any(skb);
+	netif_wake_queue(mctp_pcc_ndev->ndev);
+}
+
+static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
+	struct pcc_header *pcc_header;
+	int len = skb->len;
+	int rc;
+
+	rc = skb_cow_head(skb, sizeof(*pcc_header));
+	if (rc) {
+		dev_dstats_tx_dropped(ndev);
+		kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
+	pcc_header = skb_push(skb, sizeof(*pcc_header));
+	pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
+	pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
+	memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
+	pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
+
+	skb_queue_head(&mpnd->outbox.packets, skb);
+
+	rc = mbox_send_message(mpnd->outbox.chan->mchan, skb->data);
+
+	if (rc < 0) {
+		netif_stop_queue(ndev);
+		skb_unlink(skb, &mpnd->outbox.packets);
+		return NETDEV_TX_BUSY;
+	}
+
+	dev_dstats_tx_add(ndev, len);
+	return NETDEV_TX_OK;
+}
+
+static void drain_packets(struct sk_buff_head *list)
+{
+	struct sk_buff *skb;
+
+	while (!skb_queue_empty(list)) {
+		skb = skb_dequeue(list);
+		dev_consume_skb_any(skb);
+	}
+}
+
+static int mctp_pcc_ndo_open(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
+	struct mctp_pcc_mailbox *out = &mctp_pcc_ndev->outbox;
+	struct mctp_pcc_mailbox *in = &mctp_pcc_ndev->inbox;
+
+	out->chan = pcc_mbox_request_channel(&out->client, out->index);
+	if (IS_ERR(out->chan))
+		return PTR_ERR(out->chan);
+
+	in->client.rx_alloc = mctp_pcc_rx_alloc;
+	in->client.rx_callback = mctp_pcc_client_rx_callback;
+	in->chan = pcc_mbox_request_channel(&in->client, in->index);
+	if (IS_ERR(in->chan)) {
+		pcc_mbox_free_channel(out->chan);
+		return PTR_ERR(in->chan);
+	}
+
+	return 0;
+}
+
+static int mctp_pcc_ndo_stop(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
+
+	pcc_mbox_free_channel(mctp_pcc_ndev->outbox.chan);
+	pcc_mbox_free_channel(mctp_pcc_ndev->inbox.chan);
+	drain_packets(&mctp_pcc_ndev->outbox.packets);
+	return 0;
+}
+
+static const struct net_device_ops mctp_pcc_netdev_ops = {
+	.ndo_open = mctp_pcc_ndo_open,
+	.ndo_stop = mctp_pcc_ndo_stop,
+	.ndo_start_xmit = mctp_pcc_tx,
+};
+
+static void mctp_pcc_setup(struct net_device *ndev)
+{
+	ndev->type = ARPHRD_MCTP;
+	ndev->hard_header_len = 0;
+	ndev->tx_queue_len = 0;
+	ndev->flags = IFF_NOARP;
+	ndev->netdev_ops = &mctp_pcc_netdev_ops;
+	ndev->needs_free_netdev = true;
+	ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
+}
+
+struct mctp_pcc_lookup_context {
+	int index;
+	u32 inbox_index;
+	u32 outbox_index;
+};
+
+static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
+				       void *context)
+{
+	struct mctp_pcc_lookup_context *luc = context;
+	struct acpi_resource_address32 *addr;
+
+	if (ares->type != PCC_DWORD_TYPE)
+		return AE_OK;
+
+	addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
+	switch (luc->index) {
+	case 0:
+		luc->outbox_index = addr[0].address.minimum;
+		break;
+	case 1:
+		luc->inbox_index = addr[0].address.minimum;
+		break;
+	}
+	luc->index++;
+	return AE_OK;
+}
+
+static void mctp_cleanup_netdev(void *data)
+{
+	struct net_device *ndev = data;
+
+	mctp_unregister_netdev(ndev);
+}
+
+static int initialize_MTU(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
+	struct mctp_pcc_mailbox *outbox;
+	int mctp_pcc_mtu;
+
+	outbox = &mctp_pcc_ndev->outbox;
+	outbox->chan = pcc_mbox_request_channel(&outbox->client, outbox->index);
+	mctp_pcc_mtu = outbox->chan->shmem_size - sizeof(struct pcc_header);
+	if (IS_ERR(outbox->chan))
+		return PTR_ERR(outbox->chan);
+
+	pcc_mbox_free_channel(mctp_pcc_ndev->outbox.chan);
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+	ndev->mtu = MCTP_MIN_MTU;
+	ndev->max_mtu = mctp_pcc_mtu;
+	ndev->min_mtu = MCTP_MIN_MTU;
+
+	return 0;
+}
+
+static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
+{
+	struct mctp_pcc_lookup_context context = {0};
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct device *dev = &acpi_dev->dev;
+	struct net_device *ndev;
+	acpi_handle dev_handle;
+	acpi_status status;
+	char name[32];
+	int rc;
+
+	dev_dbg(dev, "Adding mctp_pcc device for HID %s\n",
+		acpi_device_hid(acpi_dev));
+	dev_handle = acpi_device_handle(acpi_dev);
+	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
+				     &context);
+	if (!ACPI_SUCCESS(status)) {
+		dev_err(dev, "FAILED to lookup PCC indexes from CRS\n");
+		return -EINVAL;
+	}
+
+	snprintf(name, sizeof(name), "mctppcc%d", context.inbox_index);
+	ndev = alloc_netdev(sizeof(*mctp_pcc_ndev), name, NET_NAME_PREDICTABLE,
+			    mctp_pcc_setup);
+	if (!ndev)
+		return -ENOMEM;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+
+	mctp_pcc_ndev->inbox.index = context.inbox_index;
+	mctp_pcc_ndev->inbox.client.dev = dev;
+
+	mctp_pcc_ndev->outbox.index = context.outbox_index;
+	skb_queue_head_init(&mctp_pcc_ndev->outbox.packets);
+	mctp_pcc_ndev->outbox.client.dev = dev;
+
+	mctp_pcc_ndev->outbox.client.tx_done = mctp_pcc_tx_done;
+	mctp_pcc_ndev->acpi_device = acpi_dev;
+	mctp_pcc_ndev->ndev = ndev;
+	acpi_dev->driver_data = mctp_pcc_ndev;
+
+	initialize_MTU(ndev);
+
+	rc = mctp_register_netdev(ndev, NULL, MCTP_PHYS_BINDING_PCC);
+	if (rc) {
+		free_netdev(ndev);
+		return rc;
+	}
+	return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
+}
+
+static const struct acpi_device_id mctp_pcc_device_ids[] = {
+	{ "DMT0001" },
+	{}
+};
+
+static struct acpi_driver mctp_pcc_driver = {
+	.name = "mctp_pcc",
+	.class = "Unknown",
+	.ids = mctp_pcc_device_ids,
+	.ops = {
+		.add = mctp_pcc_driver_add,
+	},
+};
+
+module_acpi_driver(mctp_pcc_driver);
+
+MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
+
+MODULE_DESCRIPTION("MCTP PCC ACPI device");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");
-- 
2.43.0



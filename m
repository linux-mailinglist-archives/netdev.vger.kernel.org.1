Return-Path: <netdev+bounces-146544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 940919D4253
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 20:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F771F24953
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 19:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0DA1B85CF;
	Wed, 20 Nov 2024 19:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="bVdPML6i"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022128.outbound.protection.outlook.com [52.101.43.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DFE157A46;
	Wed, 20 Nov 2024 19:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732129352; cv=fail; b=iXlzllfs5gVtIzW9BzsGAjVIz355322TcLYd3HvavaPknHgSicbsMonahGUTby9VOlV88CzNqk/dChOUTpxn+hphX8zORhvziaA51xEHLzVRV5IE5Di/lUFZgf9uDSPe6aFFZ92vPGQC9/mls/esqvvHj/C06GDUuCNt5q/7Szg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732129352; c=relaxed/simple;
	bh=MToBTIDXZVv9GC1nLUmsGgTwVqmzbQC7qXXPEROJS2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L0RFfgGBrYHrtuFoeMojvwHWedIOMbEtfT3aeT8LoovRkM5/IMWLWazEkTfGTPwmu0wfvNE892/TOPZu2NXSKqCfOzAIk+JKsSkWTGpxVOstPOnQ8AmWaRrZK70lX1yy3PfeXtqJNTlq9kGqzsN2sBmwKE5iBKE+l3VO01FwNeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=bVdPML6i; arc=fail smtp.client-ip=52.101.43.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OGf/i4Rn3F5qSO26tnzg0Z98FX7ICv+GjA+0vW4G/PGoRGfvSlw/ubz941is4kNZmkPMrSm04EG3wN/T4pVMT01wKNMWQwYwAdOAiVCQhcNlI3ZmH+nnGJ0BLV9++CuHqpM+50Xop9lgks1jNG4mZy1j/MGE7Yrnqp6wOQ5bzejugM3eZ/nsedi0y1q8kUY1bvE6eUmekUXMKzJ/Nm8/bZphadhZQgn8fNb1w2G7X1Yz6Tkp3DlObn57DPMrlKqzAzaDwxvJPMCf7uPI1afGYg+nd2qIckhoXfNJ/EgK7FqHP0DvhE31iLEpy5N0icI5OIVKmkqwPA6R8HzgBrWzQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Hza19w1HWb2/O7bzh+mj9yUePdpxNjXqkMQ4ajTD9U=;
 b=r1ybgzsR0T4E2JfRTk1nEtDWjmJMo2AtL40c6j53h+jTJG2TTfNqkFbIJ+710rHnGLKGOtMJy9JPBeeQPA1HP5zJ30I2DDPqXWMWiWpFQmoNcdiCT7YxLhyy9J01FMvbKwDgL0x6HMIZPmHYr0aOCFYkIglfnwgDjmok/CtWCK85VKlLYbImUOkr+LO3R7Jl9ilERkMq2VGq+j1M+RZ4vXAIdgoxm2Tw5xufdXMDXx62fbwMWGCHsGElvEFxdkhRIly9ylwy4ULgK8asg6lKulw8ZKM83SuT+ftmTgu9dQxx1SZdi7qHTm3ys/7ybqZ+qOcSMqgOxePNmtPGXPfizA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Hza19w1HWb2/O7bzh+mj9yUePdpxNjXqkMQ4ajTD9U=;
 b=bVdPML6iBuBLkEBB35S0F6amEZiRNqayTN5OgWdoeuFmVBqyhZFRMaT03gQ0cEb2eruanGLXJ3Y1pg0AVZXscw7de8lCiveFCsgrRY0OONa+ZQo8rMwMPT9uy0OvbetYpGMPbFV5L50EAl37RCeE/htx239lM2a+5SdodxiGV7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 BY3PR01MB6788.prod.exchangelabs.com (2603:10b6:a03:360::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.14; Wed, 20 Nov 2024 19:02:25 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%6]) with mapi id 15.20.8182.013; Wed, 20 Nov 2024
 19:02:23 +0000
From: admiyo@os.amperecomputing.com
To: Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v8 1/2] pcc: Check before sending MCTP PCC response ACK
Date: Wed, 20 Nov 2024 14:02:14 -0500
Message-ID: <20241120190216.425715-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120190216.425715-1-admiyo@os.amperecomputing.com>
References: <20241120190216.425715-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA1P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::14) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|BY3PR01MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c92248-183b-403e-de24-08dd0995dde3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|52116014|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?opxPU0KXnFcK2qrm8hDajwHB6nEFsDJoMI4cdDzPwQubS2wJuNRgmBKK6B4i?=
 =?us-ascii?Q?bN3tBWYzUH1zvAnmA2UaTqPhHxdf//RkTqdrks0Ucda/5D45aIOkuHmZrzBq?=
 =?us-ascii?Q?NFdD51ZA2QaRauq922qi11WdtHJsV+9vHNM0P42a8em2iyx14QGiN+8VAmbQ?=
 =?us-ascii?Q?sqOSht5pb5IYF9fsV4CVwytynrIGKEH2PqEYg2PwoXIWJdRzKZoGNePzjjkM?=
 =?us-ascii?Q?h0jmVwKpMVfviClzvnEQdr5M9522pE1cu3XkSHSml13gCNPZmMdY6Fsi20n7?=
 =?us-ascii?Q?TfQ1EBd9x3XhcPz5wzDhDyLFn8wlym0H94ugyBROirCRWyFEOuozLQfkgwI7?=
 =?us-ascii?Q?ISBmeebDd54DgBwwShoUtarS2+EoWJxMNmMv0faBLvQoAT199OBtRIg4KBff?=
 =?us-ascii?Q?ZuFcehVyTKVOvfI4t6gAE9mX3YGX9FysfGg7vXTrSY3k3dLQs4TD5dwmA1Ut?=
 =?us-ascii?Q?qY0fFMwp7MLIjvADXEYRIG9otbq0NMQxhoFDucp5GtncvbQOJVQKCJT5Jr3E?=
 =?us-ascii?Q?CCQooS+nQxeCZ7bm4yuqBjUwcHo21d9d3uCDvbyp/WhVDWduPtNiw6oDpfVM?=
 =?us-ascii?Q?WPwyRxaIyysMnuIG2czcrt/M0dZtyQFFjlSPsrM2EjaklWAsbo0pqgKHydjX?=
 =?us-ascii?Q?Lg2pqYsvbHx9z2aXX5zbkGuyc4wQeCsCyucggD8uuIVozqTnFGRoTPTKD/BJ?=
 =?us-ascii?Q?LsiL56vALNN1aoT7cprczOSo7PWmmUrYHNXLRgPog5tVpbOn+oqx2WZfCiLq?=
 =?us-ascii?Q?Xd9pQUZOL//aypS6talnbaUI617zjVGOJgi7i9qB1LkeGIyDZiKPb/ipqj8+?=
 =?us-ascii?Q?gm/KZM+pIbKO3oJGH6TD6YiNyFT/mfwAsAjD7KZY3bKaZI0a3fqEf8XtUryw?=
 =?us-ascii?Q?iYS89Ct0zNS+KBb7KkQtio0tY4BvVamn9r/bmpQc5faudFnHCvFhNKn09I0P?=
 =?us-ascii?Q?V0c0z/7yQYbyPbwQr/0Qm1K5p29pfZAFUdo8T5XlmVSS514tcDvzkxmOPBKO?=
 =?us-ascii?Q?Gc9XOZkAkxawwc3DtRczZ8i3w4DHI15oQgfNzcbTuiyn3NU6RZIVhnZ+srTF?=
 =?us-ascii?Q?IiWJRlhn1HYhm9Zi47kqeZhLJhTKB/pKPMeql9hj6Wgq7/NTgfk+8VjPqBDy?=
 =?us-ascii?Q?rbEF6/j3eLySZuAqsW/qyb4HIIiJAvpJ8ehA6NF08mdcErisQumQQoMUx+7P?=
 =?us-ascii?Q?4nMGTYPaWsk9NgzwOnwPzDBgxZsFEibMSB+i4LNMwWmp1LvUe0mqqfVvJO2V?=
 =?us-ascii?Q?Ltz8I3rTOnxM8RC+/yPGLdssp5qxtls1mG4k98ECLOoidg+0KnK03SnBOLqe?=
 =?us-ascii?Q?37WRi7QqexjZBYLCuKTsGlD/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(52116014)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RxzQ9xBDvP6sX1CJaygtcNJ7K/WtEq8KCMivn2Hw7EnFkBXQuRhzkQ1SyBB6?=
 =?us-ascii?Q?drwqW2Bi/AGg9FlaDn+6W587/We3oiM/xlELP/5Xik/OWivZlQ7r0/podWyR?=
 =?us-ascii?Q?qRetaKz4RzOR8jf1INAqUu8uzxwcUNzWZqvUIdTVTvoY2g6yuBa2bcXIKgQn?=
 =?us-ascii?Q?L9JRk0G7ySDFCKMMtbqplj++t0F1bbH5N9oAl7pzPKm25jFU8fMKPXh78Ndj?=
 =?us-ascii?Q?Z+9ftYF3DnxnWPXolZUPjWIQyZEQMcOl9fas82mbnfvHXx3KASj6BpNZhIX7?=
 =?us-ascii?Q?OyV/3X3ERN2KHik6MAINeaLwsbTXsQLZUtfSIpqgZxZwUFy8CqkAQlGHHE8B?=
 =?us-ascii?Q?YMOmN6lL2OkBj1fdkOsYeDDVdNlT++HxJKp6KKy5nC4hUJTnzzzl1fzEtr4B?=
 =?us-ascii?Q?ibjzDFy/cbS8ytDmhH/Wljg6BCevlX+6A8D5rtPOQSj933jAcmUtYnswRIx0?=
 =?us-ascii?Q?8Lus0sYrB5az9hbbX4Rsnd8c9bMPVG0Z6jLNNr6CRnR7FOmrNTfnQooSf814?=
 =?us-ascii?Q?JhX7vlQf9wXIVA/G8ilMfCi2ymIaFLTkX2DawoWSIfbG73K6z4Kq1OPx3IwO?=
 =?us-ascii?Q?BhBe2atN9nAWgbQYLAqak9GSnzUJg1/TMXy7dvuvNH8J/jXBFRKH6rSFs91L?=
 =?us-ascii?Q?k8XmfJ6y0TzFB2TkMHADKi8MnN3+USgfLrSjtoKHuMxVosr4jZLimjbVEsKm?=
 =?us-ascii?Q?4Osb2ycrM+HQeUCjSR+vOa6TFp556eSH51DuMcoGVbornOeD8/e+9cwG8Aml?=
 =?us-ascii?Q?+zjvvghvPNfylnTTeK0FH2PEOb/oXTY+lnF1eAPeveNg4JX6kzOU3Lplh8DL?=
 =?us-ascii?Q?jjiBD4bC/7H7E9YGhvrH5etQG9MgPZaW6G7V//x4xxCPS3hluvGcS/xZ0vq2?=
 =?us-ascii?Q?Vr2rfGkf5nYS+wkvAPlcllzTF6nHOu34/O84azmqfSyKYmF4s3FvapUx2gFW?=
 =?us-ascii?Q?9b0ctHpwWi0mx/G4G1w9v4RR8IBlSSTnKL8E2+NR8YDjeKYGp4wYXIy5Udjn?=
 =?us-ascii?Q?o6uf554PL7of48tc23gBFiQ5YR+A57OplGC3hDTkl3u3xNcgY/1Xd1wD8vk5?=
 =?us-ascii?Q?rNm9fojT7vc2Ni0IsU2QLZMAekeSn4rnzQ0eV5WOYEPgtlRGPyGya2hVlPrm?=
 =?us-ascii?Q?49Xovg3y6ZTo8UosqJotnfo5KVCXSNLYFEN3RCxHJ/Fi7k1hrrGd2FvsNiFN?=
 =?us-ascii?Q?/IKU2HTk5TB8RoEaJpv0NpK30JgXAKhe6w8s8FpX02s1w2oBbmP09rWaZHgi?=
 =?us-ascii?Q?tBnHfF2fykFWBY3i+jloyTwmwc7MymRhQ8sfCgUUYlDBbrrI0oEOuNCGxVG/?=
 =?us-ascii?Q?dVB/vEAyvyMae3coXK7RKO4X3QN8NaikAse8+P5xwpWxK92U4Ku5Zl8IFNHn?=
 =?us-ascii?Q?hG1WkQ5g+LNwI2fMFwlD73wxkaq5wy4x3O0a8vMa5u0i2i7dAa0wdRRLs458?=
 =?us-ascii?Q?/wu6SQHEkTO1CMpEggQ/kwM44S93MTbX6feA/0ZXVKG7Yo0ygZQnahPzemrO?=
 =?us-ascii?Q?KNlv44QCQcoZQ9dy6wvd6g/5KsiQz5hPTDOE3Xc49+J9C4OLOEqx1xgMiCBn?=
 =?us-ascii?Q?NJjuXUeM19TkhyB1o2ihR2byMavzGPE5M+31ZEloZjqurut8UL3LeA5hhr6c?=
 =?us-ascii?Q?Ek2GDk4izSD+unaO4zNN1xaFNzhLVCNQRqZRfTz6uS8BU4R7weJKjMM8jfEF?=
 =?us-ascii?Q?X4mJsEs093f+Mrc6mAYEGFf9qhY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c92248-183b-403e-de24-08dd0995dde3
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 19:02:23.5611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kM/CBMa4hi6PR4IOm3cyDFwUtpnVeV9EzxT3XSyQxsDKqeQD03TcOckV7hfEWmTnv+sIe0F8sN++hQmmC9g8NJA45+JQDk1Fzj4kD6DpgkA1O0JNzPSJBVKJ6WlHG5l+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6788

From: Adam Young <admiyo@os.amperecomputing.com>

Type 4 PCC channels have an option to send back a response
to the platform when they are done processing the request.
The flag to indicate whether or not to respond is inside
the message body, and thus is not available to the pcc
mailbox.

If the flag is not set, still set command completion
bit after processing message.

In order to read the flag, this patch maps the shared
buffer to virtual memory. To avoid duplication of mapping
the shared buffer is then made available to be used by
the driver that uses the mailbox.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/mailbox/pcc.c | 61 +++++++++++++++++++++++++++++++++++++------
 include/acpi/pcc.h    |  7 +++++
 2 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 94885e411085..82102a4c5d68 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -269,6 +269,35 @@ static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
 	return !!val;
 }
 
+static void check_and_ack(struct pcc_chan_info *pchan, struct mbox_chan *chan)
+{
+	struct acpi_pcct_ext_pcc_shared_memory pcc_hdr;
+
+	if (pchan->type != ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
+		return;
+	/* If the memory region has not been mapped, we cannot
+	 * determine if we need to send the message, but we still
+	 * need to set the cmd_update flag before returning.
+	 */
+	if (pchan->chan.shmem == NULL) {
+		pcc_chan_reg_read_modify_write(&pchan->cmd_update);
+		return;
+	}
+	memcpy_fromio(&pcc_hdr, pchan->chan.shmem,
+		      sizeof(struct acpi_pcct_ext_pcc_shared_memory));
+	/*
+	 * The PCC slave subspace channel needs to set the command complete bit
+	 * after processing message. If the PCC_ACK_FLAG is set, it should also
+	 * ring the doorbell.
+	 *
+	 * The PCC master subspace channel clears chan_in_use to free channel.
+	 */
+	if (le32_to_cpup(&pcc_hdr.flags) & PCC_ACK_FLAG_MASK)
+		pcc_send_data(chan, NULL);
+	else
+		pcc_chan_reg_read_modify_write(&pchan->cmd_update);
+}
+
 /**
  * pcc_mbox_irq - PCC mailbox interrupt handler
  * @irq:	interrupt number
@@ -306,14 +335,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 
 	mbox_chan_received_data(chan, NULL);
 
-	/*
-	 * The PCC slave subspace channel needs to set the command complete bit
-	 * and ring doorbell after processing message.
-	 *
-	 * The PCC master subspace channel clears chan_in_use to free channel.
-	 */
-	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
-		pcc_send_data(chan, NULL);
+	check_and_ack(pchan, chan);
 	pchan->chan_in_use = false;
 
 	return IRQ_HANDLED;
@@ -365,14 +387,37 @@ EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
 void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
 {
 	struct mbox_chan *chan = pchan->mchan;
+	struct pcc_chan_info *pchan_info;
+	struct pcc_mbox_chan *pcc_mbox_chan;
 
 	if (!chan || !chan->cl)
 		return;
+	pchan_info = chan->con_priv;
+	pcc_mbox_chan = &pchan_info->chan;
+	if (pcc_mbox_chan->shmem) {
+		iounmap(pcc_mbox_chan->shmem);
+		pcc_mbox_chan->shmem = NULL;
+	}
 
 	mbox_free_channel(chan);
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
 
+int pcc_mbox_ioremap(struct mbox_chan *chan)
+{
+	struct pcc_chan_info *pchan_info;
+	struct pcc_mbox_chan *pcc_mbox_chan;
+
+	if (!chan || !chan->cl)
+		return -1;
+	pchan_info = chan->con_priv;
+	pcc_mbox_chan = &pchan_info->chan;
+	pcc_mbox_chan->shmem = ioremap(pcc_mbox_chan->shmem_base_addr,
+				       pcc_mbox_chan->shmem_size);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pcc_mbox_ioremap);
+
 /**
  * pcc_send_data - Called from Mailbox Controller code. Used
  *		here only to ring the channel doorbell. The PCC client
diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
index 9b373d172a77..699c1a37b8e7 100644
--- a/include/acpi/pcc.h
+++ b/include/acpi/pcc.h
@@ -12,6 +12,7 @@
 struct pcc_mbox_chan {
 	struct mbox_chan *mchan;
 	u64 shmem_base_addr;
+	void __iomem *shmem;
 	u64 shmem_size;
 	u32 latency;
 	u32 max_access_rate;
@@ -31,11 +32,13 @@ struct pcc_mbox_chan {
 #define PCC_CMD_COMPLETION_NOTIFY	BIT(0)
 
 #define MAX_PCC_SUBSPACES	256
+#define PCC_ACK_FLAG_MASK	0x1
 
 #ifdef CONFIG_PCC
 extern struct pcc_mbox_chan *
 pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id);
 extern void pcc_mbox_free_channel(struct pcc_mbox_chan *chan);
+extern int pcc_mbox_ioremap(struct mbox_chan *chan);
 #else
 static inline struct pcc_mbox_chan *
 pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
@@ -43,6 +46,10 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 	return ERR_PTR(-ENODEV);
 }
 static inline void pcc_mbox_free_channel(struct pcc_mbox_chan *chan) { }
+static inline int pcc_mbox_ioremap(struct mbox_chan *chan)
+{
+	return 0;
+};
 #endif
 
 #endif /* _PCC_H */
-- 
2.43.0



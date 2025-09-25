Return-Path: <netdev+bounces-226505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4789BA11C2
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 21:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092A56C114C
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 19:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51B931BCB9;
	Thu, 25 Sep 2025 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="dYCECRRx"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021090.outbound.protection.outlook.com [52.101.62.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1202621B9F1;
	Thu, 25 Sep 2025 19:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758826844; cv=fail; b=XSHH17WMJvmhMEnoVU1DN4GOqs7v/QEjwIPFqI1uzg5nsHyZ79edCTYvkbKGMu+7GZaK3nRHvYMB8kAFFLe7RFdTVDS6LTMMIEyJxpP10tsxKum4sARVOiswiTASVgQp1pa5GcqzHz2ZL1dqY1rUBDgzuCWPA4rf+OSy6/i5HlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758826844; c=relaxed/simple;
	bh=ZV3xG33PVbtBV/O4yxf9TiGMvblkV5xTaG1TH84rjDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KdROUmaGO/BjEFBdfh2XGc4z4FCFlOW/jweCFP53uK6kCXgy+N7wgV8iy+3zGZjzVXAW0hAqH9qgZEmt77m2FIvrJ0NfNo5bKPo616nMb/s3D6bOJW5s4AEGSkbTtOUZqyKTT3WF3tCljnjYOtgz4OYBVzD+TGhM8yYHZ6VwWkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=dYCECRRx; arc=fail smtp.client-ip=52.101.62.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSj7NBWGYiljZ6Ujl6wSLLuDLSkgC/Ibw/mD9lK/9dUIebaUoBfpBcEo8rcKn/Z6ohovep9dGnIt61oAxKmGaY99RLpZwRTtFyUnZbb3FPPkGWTUutKjDJmRX+mJBxWkPsdXDRStGCjxdgnEjY7NY2/BqNMZXOA9YQ2XjGqPJVT78nc6ZJf8sugaw2W1m+/rtXz27RAIyhpuaFq3jcKuKtgwSfQP/0TCLzuCW1lOSUDSZHZYkGnc+UUzCnrYv9wl6lRyB4ndcsTK+z9EkSr1qN7pOosQ/GSiwmP5pSORpYAUnlHva83CU2rTrh726dxNXcfU/Fszo+LpfjJde+woOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jycDfBGlCZFxhjLBUZd4Ey+3i9OnuuWO7p+tq/6qt+8=;
 b=Tpk2nB3d4VLbtRWXGVQPkiKCPo3RwUI40d8vV/ZiaASAyeXLh6Xgya/DcIP2ElRXFyjuaWoiGJ/hN6DyLa9p9tHQ087JspgN64jENt2mymEDlBPah1PwVk1PRGr7atHi7rmkoi7ZZcNrPTlpUc4Vid9357Ie4Wtp33oubl4aPNRZ8Ggk6vV+lIH8uavEiLCUgcjZFuT2HjGRA7rVPFkKXOjiStR+op0A3akkRH+Pc3/cKbb3lrhXGJxQQ2axEUnPcIyVr1W77E8qaOa4Os4B+FV4b2PqWKJG4IOvszzFtxb9nRFHVOCdv8+IU0f+3OVtJeFunv1lJlH70JTxM+CCvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jycDfBGlCZFxhjLBUZd4Ey+3i9OnuuWO7p+tq/6qt+8=;
 b=dYCECRRxtm4asbqXXDBqsXvhJxcnE28C/1QhcUppSN59T9VoZe9tpfaHPRGWl9CUb0i0igAMQ3zKV2TS32/GE1a/+HKmR3CTbz2lhDjKVtfExrCd9H03BppwxQDhjR3oiH6oSUmZ9vS3NKq+GmAItiFt5MqGzqQszw8iw7mhBGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SJ0PR01MB6160.prod.exchangelabs.com (2603:10b6:a03:2a1::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.11; Thu, 25 Sep 2025 19:00:40 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 19:00:40 +0000
From: Adam Young <admiyo@os.amperecomputing.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
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
Subject: [PATCH net-next v29 2/3] mailbox/pcc: use mailbox-api level rx_alloc callback
Date: Thu, 25 Sep 2025 15:00:25 -0400
Message-ID: <20250925190027.147405-3-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925190027.147405-1-admiyo@os.amperecomputing.com>
References: <20250925190027.147405-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR19CA0019.namprd19.prod.outlook.com
 (2603:10b6:930:44::28) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SJ0PR01MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 04dffc28-02da-47ec-70bd-08ddfc65d208
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aeJcoRszJiJieZGMl8zmyvteUm4k64scg/lh5+4fvICE7PoUTo0e5hNrQkVJ?=
 =?us-ascii?Q?9Z6OhuFF38mil/WpyUo4RnOaNdf0gbXHyV+KOsOZA+rUpMjrTxMm6oenuT1u?=
 =?us-ascii?Q?f8eeDPpztqtT2WGcvEv68tk+EXqorSS9K5mxKjxL4FiKTCNt8DvXiq8IGZAY?=
 =?us-ascii?Q?fqFfiE7G7Bog8YFrrKPU7GW++pbYe5B+Ai8aYScqHjKgheXzLwxX2YcKNQyY?=
 =?us-ascii?Q?qPs2+EZQw640K9IGLl4TbE/kenNcF0HzJt1silKROb/ds5jskcXSYJUixhGI?=
 =?us-ascii?Q?TuIdpiFeciL400aNcYoVh6Vsla4ZBztgMTT+4lh2ahiwcVS9Y5JilfSww0O6?=
 =?us-ascii?Q?a87fQoD308LBR7QDxLyRZn/osnlvY9tPhDVXGDY94tE8wmGI+oqpjtdULa0I?=
 =?us-ascii?Q?VdU4tLxf8a9/4FHR0fGyxgcKyAyO1iMbo2znjNBYs/4Ffc0sOAR6FPDbwtzc?=
 =?us-ascii?Q?ftKfPpvpwXuYr/likhC/xfT0zwXJccHydenN7zIHsIBebsWrHglgEveFb98c?=
 =?us-ascii?Q?nNWNDp/QlLowCd4mK2RgxmY1sVDPulExTsrv/yKDjK48GHRFwe85NxvNe8Cy?=
 =?us-ascii?Q?WdStfqi07idPUbxXf/Qw4/k2nRbch5ekRDqlH8R2rVfbJRoEEjluGZxD9ju4?=
 =?us-ascii?Q?vONnCZAMvWFZgqxnUT+vaZGg+cAW5e+KqMby58/5MpJAtQGnNu2ChE3fvOJC?=
 =?us-ascii?Q?kJmOfMr1JQGFLgWUOB2poVCOvOW0d8MeQMvndXykkN5Ih1MS70UdO0q7AZ4X?=
 =?us-ascii?Q?CeCT5CoHKY96jOwRkAMasvIkEZpiHFCyMZyXKaGn5r/BmWPfTvJq7tXNQ55V?=
 =?us-ascii?Q?oaM96GR4yiYzSHdjUyMrjOS7xofpMSXKlvz5st60Kd10FzNsGa0JeN7H0OPK?=
 =?us-ascii?Q?6QBA3JNzpB80HBwD/Vyg+5UQ9J5SbYrPu5NlyWoG6ozxL0wp/woklGXsubsp?=
 =?us-ascii?Q?mU9voJIVpWTvrGcGYpAzEljpeFjmqncBFYalOn1Lxhq80sgQ84OYtgQwNhZy?=
 =?us-ascii?Q?jmKDBQi/++wWZrZJPKM8ajzqk7wq1QwvPrUTE0tMgS8SAzJXGu5e4B8uoSNK?=
 =?us-ascii?Q?RSVGxOHKv/+XPtQTuRFGnreSV4jxc3wU4OztMjWJPdufQddQOqxv5E4//uAV?=
 =?us-ascii?Q?AAap2kkcJ6iU8Y43bn4Bp5KwP7TT06GLMA+saghmKT1gYtQ41kWqSggKJdfC?=
 =?us-ascii?Q?mCr/mh6T/eJpVuiYoYR2WENz+eZf/2etRiKMyvsiO07CUoamFO7GM9o94Ne3?=
 =?us-ascii?Q?WIk3cRlHK2WncFS5TOELQM5V0f+fVQ+tp9/5cgZzx2x2cj44hZpt/Q6mAsWa?=
 =?us-ascii?Q?teXN3HZOcv45vo+LXgO8NOHguvuwvfS8B2OBFB1itTUX3pXJ4A4a3QPycjO7?=
 =?us-ascii?Q?T5MJBC4MsrnmlubkNlMTaHOSm+Ug5GAEd47xLyyCqqZ0LJZ/UbPWeI2fh/rO?=
 =?us-ascii?Q?aecyYx/g3fqXVM9D9d5Jv9rLwLoud2DJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GMjcuyo1Z+j5KSAOLb360pvNztwMTEaLulFxbFctSoO+7D5LIF+IVWJPi767?=
 =?us-ascii?Q?xcNp4pEPskAH4LDFfpPB9HwraJ0mQOqLEGKJ9N8XOORpdRqpujIDKdnqhqZo?=
 =?us-ascii?Q?N1jyLJjhb921aj6RJ06trAc3GlBZlEo22R7XL6QhLM7rWKRHzXqIowtUSVQF?=
 =?us-ascii?Q?i7qWa484NeyDe0BrdG8kOTu8cwsZx3fS5cz7pQ4acYZsYxaaLFPtFqrgtZ6G?=
 =?us-ascii?Q?OYn1Fe5eS5fPT/yFXqYgmoJvYZxJK6+SZ9YeulifdzUnOdA8R9WfBX2lpn5h?=
 =?us-ascii?Q?QKFxMtRUWMXwcFFiAiAcibMyM4Ny/zijaPlgKW/4XoOsem6v9Zom+oP9l29/?=
 =?us-ascii?Q?GJAzjjTBQPzQE/jiv2wV8RFiZ2VjJJZLL/C6vikZLAi0Ik0cyvquUMu+stWQ?=
 =?us-ascii?Q?x5z/qDRaafGIpWTCBJrPqG0TZM6XsV0HDVxKB2Di8g4EcFXaWsab9V+1/pF7?=
 =?us-ascii?Q?/mebwUyJEdwfrXelHVQGfE5CLW3bpH9vDWi7N4zUgD+BUEqiKzIHIwtWEn3W?=
 =?us-ascii?Q?a/zLEgjbKoYZF1Kgmpn9CrZhUF6qi7XR94SmhN+7ACMVSOoQL5yBdZoCo2+5?=
 =?us-ascii?Q?wWM2DU4nhQnft1y4ZeyKDcb691M7nx2Y5m1MiuGP7560lypFlNcigKO+COiH?=
 =?us-ascii?Q?0ChCA4Q/vmGFpvS0PBqwTxi21pSFn11bFBehvqOdQ5NAJUda45R4HYueu075?=
 =?us-ascii?Q?7B/QPq0MLg6jRWLSUTYQVm1/Q0R7j5FaMiHow5SBQvUY2Q8MVtc/h07QXtYk?=
 =?us-ascii?Q?eZ0r/22I6t+Q7qMuzQ67uEUF0E5QJ6xW9UOF27s3+2e9Tq76M9OZemaTQi9F?=
 =?us-ascii?Q?Pl9LRpIQxW347jy9iXliC3+o0pVUcQ8KJjrpIwG24ACcnp6PTXKz9kwRH38X?=
 =?us-ascii?Q?8TZ1FAu4fGafWCcJeSs4FvXHJY4e8mqztAVluFITvVvm7M1IsfRqnqNmUlez?=
 =?us-ascii?Q?ADLd3UtcDX1MZVMSMYGRd49AR0K35HzanmpRSiwBrZBY5fzddwWvDBaPbHbM?=
 =?us-ascii?Q?Wse7YreESmwXh+DUBoRGm8mGFmeBWsuc6RCNqZQspHtiaj5qbZFHHXWs041t?=
 =?us-ascii?Q?SfzA/8/sx2axvM+75GN6R7qEzdi9v/3i5fIAo+afQfYnfHcpH6yNnyOoi6av?=
 =?us-ascii?Q?k9af3ZP4TxF92UlVxVFw0PiWQqMGUkPAlq2mkvvBSPVD1nt39hPLTLa19DPz?=
 =?us-ascii?Q?gIRk8HaoaefMUHAU1urOCp67iiDikdUTuD9fuBAdz7KkY321GiDE5ZicrlLV?=
 =?us-ascii?Q?7qdufjigMTJLHZUn5P8GJT7xJCF6R12KoNixUIhPhtOrgM2JLGFnNjMEDxIg?=
 =?us-ascii?Q?OJ/svuz0OFp6iA1uPKUqZelNM85JIDbrzn/DjdbhoFV4B3qdWw4EmX7KLl56?=
 =?us-ascii?Q?R7MvCasvJ2iLV7igdzs0M0okRHm66Jd1uldMg2M9M2CNaHtHzIK/TwpnLmqf?=
 =?us-ascii?Q?GvsFCbeXCb3WPWWOGGZDl0cm1LAGtlMfvunkdtBZWcIb8Oj7Tq7xGXRIDpmF?=
 =?us-ascii?Q?cGr9580kFjiyzv39czTF6kluICVMdhY362//wDK4W7GF9SWnV2QJOWVSDcQk?=
 =?us-ascii?Q?gVxJ9pNusk46Rn7shkVcfoLp9kpmWC1wbLITG4RSlAbXnHo+xgr2MyQZcBee?=
 =?us-ascii?Q?uXO6b9veTSB2oglFeoemFbJG/8UMkZzUMupIZ64QSwmlJkMkTSt/vat0UaS6?=
 =?us-ascii?Q?OT2domD4sNRsxwMGaOx91EkWmxI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04dffc28-02da-47ec-70bd-08ddfc65d208
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 19:00:40.4688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4d4ysJXTn7h1jKbAYhcSZxYD92Z/ruxY2B8IJmJow0v8WekIyjXfTBjlDasXtA+eaabFhGVbjA1NehvXJOwgCbbO2Qulqf+j3DRuL95SiIJ6Ur74QAHprotUkBrVupu9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6160

Uses the newly introduced mailbox_api rx_alloc callback. Since this
callback is registered in the call to request a channel, it prevents a
race condition.  Without it, it is impossible to assign the callback before
activating the mailbox delivery of messages.

This patch also removes the flag pcc_mchan->manage_writes which
is not necessary: only type 3 and type 4 subspaces will have their
buffers managed by the mailbox.  It is not required for the driver
to explicitly specify.  If a future type 3 or type 4 drivers wishes
to manage the buffer directly, they can do so by passing NULL in
to mbox_send_message.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/mailbox/pcc.c | 16 ++++++++++------
 include/acpi/pcc.h    | 22 ----------------------
 2 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 0a00719b2482..4535cd208b9e 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -309,17 +309,20 @@ static void pcc_chan_acknowledge(struct pcc_chan_info *pchan)
 static void *write_response(struct pcc_chan_info *pchan)
 {
 	struct pcc_header pcc_header;
+	struct mbox_client *cl;
+	void *handle;
 	void *buffer;
 	int data_len;
 
+	cl = pchan->chan.mchan->cl;
 	memcpy_fromio(&pcc_header, pchan->chan.shmem,
 		      sizeof(pcc_header));
 	data_len = pcc_header.length - sizeof(u32) + sizeof(struct pcc_header);
 
-	buffer = pchan->chan.rx_alloc(pchan->chan.mchan->cl, data_len);
+	cl->rx_alloc(cl, &handle, &buffer, data_len);
 	if (buffer != NULL)
 		memcpy_fromio(buffer, pchan->chan.shmem, data_len);
-	return buffer;
+	return handle;
 }
 
 /**
@@ -359,7 +362,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	 */
 	pchan->chan_in_use = false;
 
-	if (pchan->chan.rx_alloc)
+	if (pchan->chan.mchan->cl->rx_alloc)
 		handle = write_response(pchan);
 
 	if (chan->active_req) {
@@ -415,8 +418,6 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 	if (!pcc_mchan->shmem)
 		goto err;
 
-	pcc_mchan->manage_writes = false;
-
 	/* This indicates that the channel is ready to accept messages.
 	 * This needs to happen after the channel has registered
 	 * its callback. There is no access point to do that in
@@ -466,7 +467,10 @@ static int pcc_write_to_buffer(struct mbox_chan *chan, void *data)
 	struct pcc_mbox_chan *pcc_mbox_chan = &pchan->chan;
 	struct pcc_header *pcc_header = data;
 
-	if (!pchan->chan.manage_writes)
+	if (data == NULL)
+		return 0;
+	if (pchan->type < ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE ||
+	    pchan->type > ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
 		return 0;
 
 	/* The PCC header length includes the command field
diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
index 9af3b502f839..5506490e628c 100644
--- a/include/acpi/pcc.h
+++ b/include/acpi/pcc.h
@@ -17,28 +17,6 @@ struct pcc_mbox_chan {
 	u32 latency;
 	u32 max_access_rate;
 	u16 min_turnaround_time;
-
-	/* Set to true to indicate that the mailbox should manage
-	 * writing the dat to the shared buffer. This differs from
-	 * the case where the drivesr are writing to the buffer and
-	 * using send_data only to  ring the doorbell.  If this flag
-	 * is set, then the void * data parameter of send_data must
-	 * point to a kernel-memory buffer formatted in accordance with
-	 * the PCC specification.
-	 *
-	 * The active buffer management will include reading the
-	 * notify_on_completion flag, and will then
-	 * call mbox_chan_txdone when the acknowledgment interrupt is
-	 * received.
-	 */
-	bool manage_writes;
-
-	/* Optional callback that allows the driver
-	 * to allocate the memory used for receiving
-	 * messages.  The return value is the location
-	 * inside the buffer where the mailbox should write the data.
-	 */
-	void *(*rx_alloc)(struct mbox_client *cl,  int size);
 };
 
 struct pcc_header {
-- 
2.43.0



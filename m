Return-Path: <netdev+bounces-206915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FC8B04CAE
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 02:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764584A62A0
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51928171D2;
	Tue, 15 Jul 2025 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="JLaTZvN8"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023106.outbound.protection.outlook.com [40.107.201.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DE02E3710;
	Tue, 15 Jul 2025 00:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752538225; cv=fail; b=k9hGefv4jigsh5MXY5KMuQRHGlRjYrK3wM6cyj9RPFid1CzHa1Ivyu6DwwDmOr/Hp3ehSlQi8oqGjKY+ArZUFEchTHolwzqE4jLNFUBEN5kxYm5qmppbB2pRkYQk1Kteys8X3hbLwnny6dG7Od83lvCxpCG6UFdgswvvHhojdE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752538225; c=relaxed/simple;
	bh=q9aGkqUdXoCuQcduWQCxXhWCjt0dKkYiOUy7pKN/Y1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D++EBe7KwxxPPL5GJEBHEyeC7UuH6PeRDpf4D7QRrUqfz2260oJb+bbnylKyNIcLpEVbNk/3WsWcmIjsfcURq/LwbBelkXYP20Rgx99u3lYW/FMO7Ej2iCxNyiPIfYd46mr6rjGNzV1HpAyCAeqsRBMr+Vm7dh2TI/RkDf1XOZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=JLaTZvN8; arc=fail smtp.client-ip=40.107.201.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLZNsoTYcOcKLbFdMIqysVdKOu+M6aehFnycBXQARUMbL+RsqUpk11GUFk3XunQIeiT/HPiGOrdd8DjWcmDS1AB8373VYXelUrK34nZkoeIFhpMKmGfcDHcrc+1VWzaTS55uhUOlDPwPfALFTpKEep3QVrXPDls6SBHVcdiW9mzieuRmppbD0+xfTNDX7WW5kgaalO9EGsx9STJvJOq2HGTuzqPgK/p5/BZCGxAuDF+4KvxbRhv+oH27ol8LrBrHBYzZmZVEWAkdy58lCT7beb+l0gHOt1uZWZ5xq3aD0P6dtHf877YC+STk5Z6nR3i8vnRxaau8T499fN8q+AbZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abIq3tdjexqmMwqYsCYOLvYaie3jVotMFTGPpDC51o8=;
 b=ST1HzpF3NZYUVOhsfZMbO4B/rad9yE8E9pTv87v1vAjaKMbhrhFpEUjJ8+AbH7hC0DqdzJWK9kOmVNRqF3ysSJwXfxF85+fbtQ1FjUTcp3DnGMaJIrMAXJcTCbsY4pB3jqdMaQLOFxS4zlPQZawmMKS63tzJxWxmDgQ8LwYwx6H3QWJw2TjA0+4M5zWyFBxzW2iZm7J+hQ0z93XenxDuNGLVlWjKbIQuu/YhaxkX3rvyLBJATYQRQZC1bk6bN9KzEWCmvKQvjfzvfPohj8DFFpmxdo+ILj/x1EZ14/b0O4rE62vwTfoeHwtOGzEdYOefzSEkWMkacJlKk/Ka3ZHI/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abIq3tdjexqmMwqYsCYOLvYaie3jVotMFTGPpDC51o8=;
 b=JLaTZvN8KZMoI0fdkUlbIVbQ4mwAQVNNu6VW6g5SsUz0tiatkWLJP5YTQcjE+bb6oqMM6qV729LgGFA1yokN+Ik1itCJByN5QiLb3TZrstWQ1sBn4iAjqLr1RV56/gEGsW3D42k8JTdlskoXF9Xbm3i4KmOOJpvXzWB0815wTgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SJ0PR01MB6239.prod.exchangelabs.com (2603:10b6:a03:29d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.32; Tue, 15 Jul 2025 00:10:20 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 00:10:20 +0000
From: admiyo@os.amperecomputing.com
To: Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>
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
Subject: [PATCH v23 1/2] mailbox/pcc: support mailbox management of the shared buffer
Date: Mon, 14 Jul 2025 20:10:07 -0400
Message-ID: <20250715001011.90534-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715001011.90534-1-admiyo@os.amperecomputing.com>
References: <20250715001011.90534-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::28) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SJ0PR01MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b0ce6b-1d0b-4bb7-a478-08ddc333fc4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sd/9IvQVQGwMR2mokdXaYsd8AbTY1yUJaBGJ/APHk0s9v+ZI1wnEPpBTsQMd?=
 =?us-ascii?Q?KsnlRA2r2EWAUN8NjapsSsJAdSu5gbq5cBK9EvrG27HMzeTvt8ZQN5l1de0m?=
 =?us-ascii?Q?OfoW+3omnG1KNiQufq54PRzqsRhcU1hn7hQ/lfgZuzA6BQ8ayMQe1tfzR9I1?=
 =?us-ascii?Q?Bixmx4oJLMTW6aw28QVh9MEtPq+2ssMujLsCOjqUjp9BjxfkdGKoDPhoOCli?=
 =?us-ascii?Q?o1umxJ3CnsKtw58AYD285O9YXyhUHkJfXPWVFZDb7tRfpZedOVAc15RIvZsc?=
 =?us-ascii?Q?FKeXg7bAGAKw86dunS5IWZXesCB01OWPM24WU96LUyA/Yig7ZGqh84uWqNjW?=
 =?us-ascii?Q?n5r2AQc/z7jn/smKW0CldJ4cGIOK6TvKP4xSXQl/xrnHof8pi63oUAUOEwZX?=
 =?us-ascii?Q?VrB+QS8kQ9M0M8MMiuQ3aSBvyfJjid4LxZ7S3+oytjud50ODyhxceeTDWCgV?=
 =?us-ascii?Q?kqZrwvEFtf+iaH1NTTjc3eeq2rluuCvjQw8YXkwkHYWzyTP8MgBWHWEl0DFL?=
 =?us-ascii?Q?vLid94AsJY7v0ZeGkLDxgSjd/w6cSfW6dxsLuuzeFpEoxYjJSaV4qddnazO3?=
 =?us-ascii?Q?bHU9hU+7DXm1KHWVtTNnUpZpxI14QhzBQXpnpheZCpwfiuOx0SKPbWpYjPwe?=
 =?us-ascii?Q?RK6o9gHNICfckZHzH95dSiN2iFbUUHR9Q4eJiNIl0nDItcPvnN7DFAkhpB+K?=
 =?us-ascii?Q?wOemnYhR7dmv39Ktno/oXVPnlQ57tgJqiU5GC/B3EOVF/Oc5rGy9f0AvVrRo?=
 =?us-ascii?Q?PFsIvGcnTuVMqGEokQ9Q0zmh0v//QVFw1qcQmDRGiolW/Am1x6ZXQWR6FF1Z?=
 =?us-ascii?Q?L+y70MoCdxXFbK+ODXdAuQ/qQCwodCTrh8OtqPs7xgN0T3gCP28tTFdxmiqw?=
 =?us-ascii?Q?hhdTnCsFtmRl94C42NdK/PUEc30H/cReLWoZc06vEwvF2TI59NaN33TDlOp9?=
 =?us-ascii?Q?CuLBHwaTm6TfYkLG/FVjYwU4HhrOnvO2Ie2ApX9Kyf4gmqPAW/O+RpHDV1ot?=
 =?us-ascii?Q?Gv7FU3k5jki85hfo+/JAQ2Zpm+vvRfR0ULFtmaW1c326SvGF9PFkkyDNa52m?=
 =?us-ascii?Q?OPqyWZz0Xy2KvG/CkILvWrQ2RY6paNvLlgaROgJCQqyu/QdQtqgA5iA55hff?=
 =?us-ascii?Q?PkVvZTV7+bhRL6Jo4jnxCwpOi9FKLjMzWKlaZkmZ5s6U4QzVWUiDRDtkr0IK?=
 =?us-ascii?Q?eebTY2mZICqm2SXLTl7i5OnyNhJc112J5hCFxzHL/eCpdqm1+qSmYgBsVTba?=
 =?us-ascii?Q?P9o371s0g2xqYHVM1ujBFU2XhOYi+ooul+Naw71kXL+oBQvsptporGyuISLo?=
 =?us-ascii?Q?NtVyTwl3ICn5yTwohsoPDMiRGEZCovWH0KCyNHNHwgiAX+ooyNo1T330ESa5?=
 =?us-ascii?Q?1I5TdrSfDtwrJq9TxpBlICT45b8x11UZeptaGmm3+sC5c/7TnCuiNHcXDUVS?=
 =?us-ascii?Q?hB2JFpcy1VQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QHNam7g+8LyxZDsj8GXw+AUvGRNAMC9acdtjKc9gIXalEtKFQ2H4qr98uQ10?=
 =?us-ascii?Q?WiYzGtLLP44PNbRo1XaU1arwXidcKAhKIiNkreHMcMkOzAEnHg5+Wu2XhsCy?=
 =?us-ascii?Q?iXw3UFXGflmBJRS8N2sWqvectt+wQuzvhV2rmR28ZtvCfrnLVikxOx9rfsUS?=
 =?us-ascii?Q?V5L9ZTIPUG8gb9uAA7RTMjfZeBR3FU7B1WmeOjbGVB/hF+CGNtW+vZOe04Bf?=
 =?us-ascii?Q?si1cRgl//G82gC22Gwa1YzC5ilvIMrjtdv+lHr+Z+R7P+rMY6aYBMFdDLzXR?=
 =?us-ascii?Q?hrN0/Z8uKTQo+O/eRQl7m3b9F8AvLkrYWH25N8fT+sDX6GQba0RG68QsBxM+?=
 =?us-ascii?Q?H74gUU99x+CUKPoA3YpKZQU+Umuh3OHlLQv0pqKgqipTlVoXSFjR4DEe76Mu?=
 =?us-ascii?Q?JW58Sai0f8sEit15doqOjEgDur/8E7IUcheC4BfHH6awxvb+rK8VFD7uuten?=
 =?us-ascii?Q?Z58mjR/vCTdEkHbhNH/uv94d3XXnGBCLT/7DnfbOWB6IZUXkEI2TVXtjk+bB?=
 =?us-ascii?Q?jRN3prAXB9WGs7CND3TTz8MevlfNj7hxgovAZsIDPlE6EfR4Kd01+hTmtxYb?=
 =?us-ascii?Q?7m2ROcAB7GsP7u9Tq5RXHe76oIHkat9YXez6pJT8hVdRnorl5tWLaeAozHWd?=
 =?us-ascii?Q?5V6N00nIHZLYt0DcfULwqzyPjpepea51t3Q0TtzG0Rld8oYj8B9SC9YVc7ou?=
 =?us-ascii?Q?JkJ43qHKDgAJI1nZoww5zMl0/kAhb3Cbum57irdRtP6SUpukYuYU8b8ORCTo?=
 =?us-ascii?Q?UYhpiLNEdWO1TwNvw8uKLNfefBuactrd6Ck1MMxapazMRPygCl90Rb0VCUYd?=
 =?us-ascii?Q?dPvQ19+FPOusADmrdYEaaJf9OLc+HJIrYm8iOBbnywMNEasoLsctCbZbOQuZ?=
 =?us-ascii?Q?QzCLZ5cmNDqENC+0KZ5s4m0nh4siyO7tIt+Uc7+RaXij/vvILbuSkyKOAlT/?=
 =?us-ascii?Q?ZhEKdwcC7c51jQzTv5XQoQ8yfX3vc2hdZlyPBdGsV7J3DEPgKm5epweMzfMD?=
 =?us-ascii?Q?ziz2+eq1WfKJfinpKZrt0mbWAdLn0mYTZVZq944+1Ds41S/QKb/bbEGfncnc?=
 =?us-ascii?Q?dJxpF8+KJ/rrTCICucLO0tZKFvNH8tn0XxmJG3sTy1u/p9JipU7ke+hN8rqK?=
 =?us-ascii?Q?+sm22+enn+1FD3LUEI807vyshM1BpOvvgF9BgmiTl1Wx3fUdxr7KSSRGRrEu?=
 =?us-ascii?Q?ZUB7Ijz/n4gAmUiLHiYFRnlt/6R8MX9A3n+U0Wndyf15kN+fRJLDicnIHZJe?=
 =?us-ascii?Q?dlphgp+s960dkK/RIBydAAu5ZbKkN3TPPa+2La1Yc3ADHDVJsLAMcdV9v2bD?=
 =?us-ascii?Q?g4+p9zGQiTCfy2UqrKPlASHmgmJcsjpEU3O0sYLsOCCp55IIcNiLptDLLB4/?=
 =?us-ascii?Q?Dk2MxIYR70JARr57ONRJwHmnCyKSGMPJwsLth2mVwEKj1D0GIYiXn3aq08MD?=
 =?us-ascii?Q?8wItgCFdJfOaOTAv6I7D9k/amPQOgiCdW9Z1r3Y8coMP3b1EDQgnD/eM2aih?=
 =?us-ascii?Q?/44uLZPkGNDc2rKzZv74hTCVFDbfXUdwDoJ/ueqPVEagpuJXEKBH+razEi+a?=
 =?us-ascii?Q?2RJ+yGxMaBq/gXaKa9ZZAq5sHERi5w9Nf9bnXI374hqb/qe3JpCiDLl9NfrS?=
 =?us-ascii?Q?57vfDim5tVJNXtSBj+VDEoV4VQ5b3tTxCVuK6RgtrW6Shgq71CkXTRh70KnW?=
 =?us-ascii?Q?CIw8oU+69oS8Ea1/OXFlvYarDVM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b0ce6b-1d0b-4bb7-a478-08ddc333fc4a
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 00:10:20.1717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ocm6RQKs7pIpA7BOXhtSDjnM3siWyr+kCC2kx3vySev8n6ko9ngU2PfsTMa2HTGnsMxTrv96W+9JdwX33MMk82lkRptX1SHk2bX5wdFs3YmgYL+iSrknqe5pa3o1h24C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6239

From: Adam Young <admiyo@os.amperecomputing.com>

Define a new, optional, callback that allows the driver to
specify how the return data buffer is allocated.  If that callback
is set,  mailbox/pcc.c is now responsible for reading from and
writing to the PCC shared buffer.

This also allows for proper checks of the Commnand complete flag
between the PCC sender and receiver.

For Type 4 channels, initialize the command complete flag prior
to accepting messages.

Since the mailbox does not know what memory allocation scheme
to use for response messages, the client now has an optional
callback that allows it to allocate the buffer for a response
message.

When an outbound message is written to the buffer, the mailbox
checks for the flag indicating the client wants an tx complete
notification via IRQ.  Upon receipt of the interrupt It will
pair it with the outgoing message. The expected use is to
free the kernel memory buffer for the previous outgoing message.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/mailbox/pcc.c | 102 ++++++++++++++++++++++++++++++++++++++++--
 include/acpi/pcc.h    |  29 ++++++++++++
 2 files changed, 127 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index f6714c233f5a..0a00719b2482 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -306,6 +306,22 @@ static void pcc_chan_acknowledge(struct pcc_chan_info *pchan)
 		pcc_chan_reg_read_modify_write(&pchan->db);
 }
 
+static void *write_response(struct pcc_chan_info *pchan)
+{
+	struct pcc_header pcc_header;
+	void *buffer;
+	int data_len;
+
+	memcpy_fromio(&pcc_header, pchan->chan.shmem,
+		      sizeof(pcc_header));
+	data_len = pcc_header.length - sizeof(u32) + sizeof(struct pcc_header);
+
+	buffer = pchan->chan.rx_alloc(pchan->chan.mchan->cl, data_len);
+	if (buffer != NULL)
+		memcpy_fromio(buffer, pchan->chan.shmem, data_len);
+	return buffer;
+}
+
 /**
  * pcc_mbox_irq - PCC mailbox interrupt handler
  * @irq:	interrupt number
@@ -317,6 +333,8 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 {
 	struct pcc_chan_info *pchan;
 	struct mbox_chan *chan = p;
+	struct pcc_header *pcc_header = chan->active_req;
+	void *handle = NULL;
 
 	pchan = chan->con_priv;
 
@@ -340,7 +358,17 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	 * required to avoid any possible race in updatation of this flag.
 	 */
 	pchan->chan_in_use = false;
-	mbox_chan_received_data(chan, NULL);
+
+	if (pchan->chan.rx_alloc)
+		handle = write_response(pchan);
+
+	if (chan->active_req) {
+		pcc_header = chan->active_req;
+		if (pcc_header->flags & PCC_CMD_COMPLETION_NOTIFY)
+			mbox_chan_txdone(chan, 0);
+	}
+
+	mbox_chan_received_data(chan, handle);
 
 	pcc_chan_acknowledge(pchan);
 
@@ -384,9 +412,24 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 	pcc_mchan = &pchan->chan;
 	pcc_mchan->shmem = acpi_os_ioremap(pcc_mchan->shmem_base_addr,
 					   pcc_mchan->shmem_size);
-	if (pcc_mchan->shmem)
-		return pcc_mchan;
+	if (!pcc_mchan->shmem)
+		goto err;
+
+	pcc_mchan->manage_writes = false;
+
+	/* This indicates that the channel is ready to accept messages.
+	 * This needs to happen after the channel has registered
+	 * its callback. There is no access point to do that in
+	 * the mailbox API. That implies that the mailbox client must
+	 * have set the allocate callback function prior to
+	 * sending any messages.
+	 */
+	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
+		pcc_chan_reg_read_modify_write(&pchan->cmd_update);
+
+	return pcc_mchan;
 
+err:
 	mbox_free_channel(chan);
 	return ERR_PTR(-ENXIO);
 }
@@ -417,8 +460,38 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
 
+static int pcc_write_to_buffer(struct mbox_chan *chan, void *data)
+{
+	struct pcc_chan_info *pchan = chan->con_priv;
+	struct pcc_mbox_chan *pcc_mbox_chan = &pchan->chan;
+	struct pcc_header *pcc_header = data;
+
+	if (!pchan->chan.manage_writes)
+		return 0;
+
+	/* The PCC header length includes the command field
+	 * but not the other values from the header.
+	 */
+	int len = pcc_header->length - sizeof(u32) + sizeof(struct pcc_header);
+	u64 val;
+
+	pcc_chan_reg_read(&pchan->cmd_complete, &val);
+	if (!val) {
+		pr_info("%s pchan->cmd_complete not set", __func__);
+		return -1;
+	}
+	memcpy_toio(pcc_mbox_chan->shmem,  data, len);
+	return 0;
+}
+
+
 /**
- * pcc_send_data - Called from Mailbox Controller code. Used
+ * pcc_send_data - Called from Mailbox Controller code. If
+ *		pchan->chan.rx_alloc is set, then the command complete
+ *		flag is checked and the data is written to the shared
+ *		buffer io memory.
+ *
+ *		If pchan->chan.rx_alloc is not set, then it is used
  *		here only to ring the channel doorbell. The PCC client
  *		specific read/write is done in the client driver in
  *		order to maintain atomicity over PCC channel once
@@ -434,17 +507,37 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
 	int ret;
 	struct pcc_chan_info *pchan = chan->con_priv;
 
+	ret = pcc_write_to_buffer(chan, data);
+	if (ret)
+		return ret;
+
 	ret = pcc_chan_reg_read_modify_write(&pchan->cmd_update);
 	if (ret)
 		return ret;
 
 	ret = pcc_chan_reg_read_modify_write(&pchan->db);
+
 	if (!ret && pchan->plat_irq > 0)
 		pchan->chan_in_use = true;
 
 	return ret;
 }
 
+
+static bool pcc_last_tx_done(struct mbox_chan *chan)
+{
+	struct pcc_chan_info *pchan = chan->con_priv;
+	u64 val;
+
+	pcc_chan_reg_read(&pchan->cmd_complete, &val);
+	if (!val)
+		return false;
+	else
+		return true;
+}
+
+
+
 /**
  * pcc_startup - Called from Mailbox Controller code. Used here
  *		to request the interrupt.
@@ -490,6 +583,7 @@ static const struct mbox_chan_ops pcc_chan_ops = {
 	.send_data = pcc_send_data,
 	.startup = pcc_startup,
 	.shutdown = pcc_shutdown,
+	.last_tx_done = pcc_last_tx_done,
 };
 
 /**
diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
index 840bfc95bae3..9af3b502f839 100644
--- a/include/acpi/pcc.h
+++ b/include/acpi/pcc.h
@@ -17,6 +17,35 @@ struct pcc_mbox_chan {
 	u32 latency;
 	u32 max_access_rate;
 	u16 min_turnaround_time;
+
+	/* Set to true to indicate that the mailbox should manage
+	 * writing the dat to the shared buffer. This differs from
+	 * the case where the drivesr are writing to the buffer and
+	 * using send_data only to  ring the doorbell.  If this flag
+	 * is set, then the void * data parameter of send_data must
+	 * point to a kernel-memory buffer formatted in accordance with
+	 * the PCC specification.
+	 *
+	 * The active buffer management will include reading the
+	 * notify_on_completion flag, and will then
+	 * call mbox_chan_txdone when the acknowledgment interrupt is
+	 * received.
+	 */
+	bool manage_writes;
+
+	/* Optional callback that allows the driver
+	 * to allocate the memory used for receiving
+	 * messages.  The return value is the location
+	 * inside the buffer where the mailbox should write the data.
+	 */
+	void *(*rx_alloc)(struct mbox_client *cl,  int size);
+};
+
+struct pcc_header {
+	u32 signature;
+	u32 flags;
+	u32 length;
+	u32 command;
 };
 
 /* Generic Communications Channel Shared Memory Region */
-- 
2.43.0



Return-Path: <netdev+bounces-144657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF619C8104
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 03:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A4E6B22C11
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 02:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5909D1E7C34;
	Thu, 14 Nov 2024 02:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="XsL7/aoi"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020097.outbound.protection.outlook.com [52.101.56.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C5C1E412E;
	Thu, 14 Nov 2024 02:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731552585; cv=fail; b=INMaxhuc6RwMsygQ3vE96RNrBEt0pGCn2tIZtpDZ5qNpOCTgWNW1wnXhbdJLTWcebYtw/kJrHi1m6+yE5nVBt75ySesZdRW4wSN8sPeUMJHH0kiXRuXxu2ZrZDrVRcpf87SKF9DGeFD52ZtrzbcNGO6VbFsA3XguHNI9TtM3uSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731552585; c=relaxed/simple;
	bh=UCWHLgKFxfR0U90Jnrb4jVsp5bG5P+hY8xeuYOq7jDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nchWQP6y7BNc1+yEtxQ3X6kjdm8jhAYviOYOzRAU6RRJPpghiVqXMJ/OqdCbCamHpbPQMvyCqgUr5ZgZUqJ+pIbNdBz/NOCdT0RZYZo2Rhsy9fxfgXWCiqeTjVnrcKndigRXm/0pq6c1xMceBKVEOoT8eDrboD0MFZm6dbXzKZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=XsL7/aoi; arc=fail smtp.client-ip=52.101.56.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRY4Z7YTQdb6beOVIYR6Xo3cuineiFDMY8ZOdqgBvTWcgk2vrxply+Y1KJ2ny1+uSwvegFf3ZsnLWVI9N4bRAKco2pIFflYsaMlTD1hkt00SA6L8bRHzurPDFl4nOcWn0liEePUCekXK+zvQQOFpVcXuzSXUbMOWhEMpF890AzQo3Q6FWztwYaYrWKUTe8vvAsTNbnFzraAeK62/7RBwn2/N7jk6ByRcCjnu0qcjuKOsbFufPkEppomhNZSK+cKc9tkxGg6rTYorTZS/s7FsdAUZhIkEZQT2uWwwvjA/6B5V/z9LepGg2TphwBUrDFzy/LJ++0xuQsIz9tGdGKo1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1H0cLOeMkrLKyVGCJSuwU+NQT9ERDqzAsMTEVAVqQE=;
 b=rIY9y8dgO+kdLdta7hHBLHVMazXQE0BWMteppPP10XHB1uSgMIaQ8vcpd9NGzkGYMWrIc6vRdP3t24fs8szfGZUSSnOwEQN7K4hyydEP07gIW6+W0H3K9zjD0xT3FwXUZiKicKHFVeUjx7kJybdQgOoS3YZht+5tErtZzhh59zypRaCeXgSJMVGrMXeNzzcd5bdXBhLF5DTYd5v1Y9UFm51ed7126oI1sOru5FkH/aunV4KmMbyHmTiqXpQroXgNzjJTCW06S7rrvlhXmW45lZqFuXuSkRrdbhyj+sT99WoHiGyb3vYxo5wF7dbOehgc1On7C0IZGdy3eyI3+rk/5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1H0cLOeMkrLKyVGCJSuwU+NQT9ERDqzAsMTEVAVqQE=;
 b=XsL7/aoiPNfeBqsWPZryVCTbEbOIG9AlkLS81wlAHD4zzOYk78tUyUIpupCNn0dIH0YZqahoWoqw5nateFgEpPNsEUeOL/t4t4dmY+FNjZWCiX6tp1180rl5kHe07huuHqxplHSC2BAhIQsPq5t1rS+g/NBIEyaJIefU6VQfxcc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 MN0PR01MB7804.prod.exchangelabs.com (2603:10b6:208:37f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Thu, 14 Nov 2024 02:49:41 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%6]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 02:49:41 +0000
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
Subject: [PATCH v7 1/2] mctp pcc: Check before sending MCTP PCC response ACK
Date: Wed, 13 Nov 2024 21:49:26 -0500
Message-ID: <20241114024928.60004-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114024928.60004-1-admiyo@os.amperecomputing.com>
References: <20241114024928.60004-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:254::33) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|MN0PR01MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: 71df0128-0e98-4d28-5d36-08dd0456fc8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Oc0C2qXf1+VWei+HFhu549Zcthl8U04NublpUCYJwYqMmQWSd+fZBWTIugBD?=
 =?us-ascii?Q?veMUrGqop64dQffVbH150y4ggmJgQfEegadgnsmbYKfVL/8IH+Tto1e4DcJi?=
 =?us-ascii?Q?7luGBkwhXpfYFuW19wNqGnP4oFyuekGsNLMomvRkoFBrgeXhkLIxRwLdJxzQ?=
 =?us-ascii?Q?uQ1l6Wvmq6coVn0duFxSF24w8/OkGYG9FpTqTKxagd2k6w7mTCipXkgrvpUZ?=
 =?us-ascii?Q?JjVyutX/3KHKWuwIBwlpgrCOX9RHijltTNH5q+B4F+aZYVMr4tXLbfCjicqt?=
 =?us-ascii?Q?eYuLV4PoyNZY+WRpLmhy45g0JvJCShMHSfT3CynDv3Ve1fOZpwGNn5yr+9/v?=
 =?us-ascii?Q?Eml1Z0cGEK4ouaOTgSFOr+RP32BGmVV00jobafN56ShI126YkvfPboaAKToe?=
 =?us-ascii?Q?uH9Jv3lKfyWgLsgSxOHRkyWUAa67udDRgcB+B8wFjngBCkb8F9ok2EPQx3Mz?=
 =?us-ascii?Q?/SDqFQ7Ca22XvzDK5fmVL0YTSQvtNTDmy23Y7Bxh55p9qcYql+W+bme2QVH8?=
 =?us-ascii?Q?MvNy110hO9Y7X8bBVKG3LAOxDIB8+v+62lCdarIsouuTdFmLWVfHdMehYgbR?=
 =?us-ascii?Q?9/25RoxoxrZa3CRyoVC3QJzPC+qdDWJwtUYk/QKfvtZ7HLvjnzow3e1jPAje?=
 =?us-ascii?Q?L8CydSDlHL+fzAlmUbfBvTq9EzOMxN5UkGcEVVoON0RPBahn5wHcPTMjPKas?=
 =?us-ascii?Q?9Gby2LUkz0P40jgHdyjFATnHgAN0u3MnsMQr2Zln3+qZ4Pyhc1RSODLWbZgt?=
 =?us-ascii?Q?jOBArW0F3f7RY7s2Xf4UYnJyWlkUAMRqbVblwYzgAaU5GRiMVINLdHs+DJpv?=
 =?us-ascii?Q?r+EKeubNITtqKYO7EdPuPNu+Fvm9M86U+vzw5ghS9cYmUYKIiGXd15U2UE9B?=
 =?us-ascii?Q?5dT0tPbGWPfEDgjF5Ro6Fv6KJ0H1OljbxLW8WanoFc9+dMIbvWT1AhzGxmAn?=
 =?us-ascii?Q?Z1WLSSUvgLHx01lt0izCVirEgiMWIo88mqQKbRktkfzcRQ3iH2rzCjIX//EQ?=
 =?us-ascii?Q?cny6hmAFi3WNTSUskDhKniHTNnqZq/Rl5U2hsPuBxSBE8l7iUfxhOznkDAXN?=
 =?us-ascii?Q?bdLSQbJ3YpOLhfV1/JyNYNj1/+WhFBUnYbvbiJoTA+oxChz8eByWuypopqd0?=
 =?us-ascii?Q?JMSU50INQd4YtBiL5ZNxK497InskZf8pxkDg/QnEVUN1mrZCMT+Le3/VM/1r?=
 =?us-ascii?Q?wQ+/zH7To2CvpQKNO3jvOWNXud5cJZ+t6uSdU/GZnnsjPBYvr8XfQaPXX8Ex?=
 =?us-ascii?Q?LREkug13w6XXt59BTnGBnr7S7PAFXYFLlrOYkZu5oaKMTjH2IMF0W+sKnDNg?=
 =?us-ascii?Q?KVGYoj8nkhThtnUmdcgVJ/Mq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OHtclUPQQw7LWbYxKBE8AHN2MmyD8fKERnS+5gtZjEkMg1bvPnIliNQ/jR0D?=
 =?us-ascii?Q?gUEJKFHn6r+I/CqQnnrD5VCiD9vyPQQrtlhhVoJJ4ubOY8JnwPsQNy5lFVa8?=
 =?us-ascii?Q?2TYo+jaS+doM6tNkAIsp9evJY34iE8WLtM/pW4nuy92Tzy0ot0Xb/OTHMYZx?=
 =?us-ascii?Q?fvsDsKgvgv3Sjhp9LTJ2bkL2QGXvMlrFZ4VgMWx9TY+kCkUAuUvaZZy5yip5?=
 =?us-ascii?Q?zK49hTSo9FLj9vfX9mKKSNmA0GYYjX4Ouw6CZyiLlPWMT5E0FgZ3D38fxYMA?=
 =?us-ascii?Q?W6BuHFT604DKG5jQZyanItgT5/WP9O67jdR09bVa+TcIqmGSBIkZ22GYymad?=
 =?us-ascii?Q?jTCMqCAgjgWjXolXNLvhu0/jvdCF/VCfA9fvwZ077KE5Bcj96FJeRNObCncd?=
 =?us-ascii?Q?/v1pj8zC6AT1qVHZc1pBE6bOnJHdLtyVm2CxyDP9oALuqiu/gb0n65RWbBpW?=
 =?us-ascii?Q?4rHgPl3J3QltXl85oAtnvDwWdyTRXQS9ctLGF5GbMU/T7ls9ht4Dv9uB3PVP?=
 =?us-ascii?Q?/H/gKot5fJKCPQaoOXSiCNIG6r16SCV1zFRMK7zpTgXOnRrHJfjLyy6hycdT?=
 =?us-ascii?Q?PezfHGIWhz3bePw+iHM4HNBJzgw7F1Wnz/yuzep22EZU5F4R38jHU3DPqKuI?=
 =?us-ascii?Q?92ilbWbmoU6Rjc4VtbCtEeC5SHBxe7DQH67y9GkbbsEUk0ImQSIlSB33Vd5P?=
 =?us-ascii?Q?NH/8uHRr5s3CVdpKcYikkPItuOE9hiNkWRGdY9cPV6TZH+UyIzXfbwh+wWTE?=
 =?us-ascii?Q?BgJtxV/nhiUoisNv1JjaDyw2e8vc1K4oWIDnu0MmrGvW2YK+MOGcA2NNNh+K?=
 =?us-ascii?Q?U2lLXxkkAmvAJAEIB6ERNsPIHCArKOFQvM4SDU5hy4GSCWuA6EfZavBx4SW4?=
 =?us-ascii?Q?xfB2H+sKNRkc91xWz84QicHPnD/JpPiFwWScGWk1MgfAo0vmb05aoXoITbKT?=
 =?us-ascii?Q?9J+fsHbZUGY5QfPNE5LLUpp6qEggqsnck2B+id/P85Pz0sgNKybH6Y4IlKxw?=
 =?us-ascii?Q?kG7LWNo/Y4XOj4qnFy+NIO4aCtXMicZtGgeIXGp6Gurz2OI82YANq1yT3pYM?=
 =?us-ascii?Q?JgLPqE0dmx0u0yKFIrmb9EC/LwX1pLXGVh2RdwaCqqYqMYZq7EK4rYoy6Erp?=
 =?us-ascii?Q?zn1kZYGrnnDgkcA1qsnRuANddfYix7qg1s0/cGrHlHFyMhfiLkSwbYSCUpFd?=
 =?us-ascii?Q?qUBlpxdT47ulcRcqfQTjuW0TWauktZmxzWAkB+hL2OyAgSQvD67qcm4xfjoF?=
 =?us-ascii?Q?5Tz+I/7uG+0OB17ZIJfBFV8mA1yGlKKkCeoohfSu15COLr/54KGGaCN5fNL3?=
 =?us-ascii?Q?DXUIMn8eF63gZZ2qS6tl0muI45NSAnPr4tOV2d3jzC9o+KbQunxrOWonGjV7?=
 =?us-ascii?Q?T0OoFd6JbObOaLaVss6irx+rfcRbbs/WdXYomZ8f48S/StHx1WZOA7aWO9l+?=
 =?us-ascii?Q?ne8npfRbKSL0RKAOsP98Spi91nejgyCXsx2BM2+LamJMXUWTEIcS73pcv7C8?=
 =?us-ascii?Q?UgVccZMxeguwEVpO3tp8FdnXczvkMlwz48Zg4fndaa2mXAjkzgjbnVb2UIOo?=
 =?us-ascii?Q?9wCYqRGhLklXGuc4pWzWYnbUwKxl7wrplaFUiJMKWlMrMtOviiuGbTMcdQVS?=
 =?us-ascii?Q?kmTL6O+9zV5AI6aTYEs6TTT0rLGjwi7fS2jGPAJBEN+62C571ouBNSA8ScNJ?=
 =?us-ascii?Q?hLC6FDDkdrQAX6PdDpDP9p4+gdw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71df0128-0e98-4d28-5d36-08dd0456fc8e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 02:49:40.9210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ei3GYlV4i4Wmc2W4+2eByXy/di22Q2YoaCSI+4gTsXX5qzHCCH4EBPOY95A0YA8mUXaT/VD0c5cCss518c3apkRtvO+o8QRhU7tC6NswNczLiBmBIUyO2aVbuxsQFcvm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7804

From: Adam Young <admiyo@os.amperecomputing.com>

Type 4 PCC channels have an option to send back a response
to the platform when they are done processing the request.
The flag to indicate whether or not to respond is inside
the message body, and thus is not available to the pcc
mailbox.

In order to read the flag, this patch maps the shared
buffer to virtual memory.

If the flag is not set, still set command completion
bit after processing message.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/mailbox/pcc.c | 62 +++++++++++++++++++++++++++++++++++++------
 include/acpi/pcc.h    |  7 +++++
 2 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 94885e411085..3a5779925eb2 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -90,6 +90,7 @@ struct pcc_chan_reg {
  * @cmd_complete: PCC register bundle for the command complete check register
  * @cmd_update: PCC register bundle for the command complete update register
  * @error: PCC register bundle for the error status register
+ * @shmem_base_addr: the virtual memory address of the shared buffer
  * @plat_irq: platform interrupt
  * @type: PCC subspace type
  * @plat_irq_flags: platform interrupt flags
@@ -269,6 +270,35 @@ static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
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
+	if (pchan->chan.shmem == 0) {
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
@@ -306,14 +336,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 
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
@@ -365,14 +388,37 @@ EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
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
index 9b373d172a77..f61c481eb478 100644
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
+int pcc_mbox_ioremap(struct mbox_chan *chan)
+{
+	return 0
+};
 #endif
 
 #endif /* _PCC_H */
-- 
2.43.0



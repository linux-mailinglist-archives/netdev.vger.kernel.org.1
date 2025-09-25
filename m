Return-Path: <netdev+bounces-226504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEADBA11B6
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 21:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8446F17FB5A
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 19:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F9431B130;
	Thu, 25 Sep 2025 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ofxrBzYW"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020143.outbound.protection.outlook.com [52.101.201.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E4B227E95;
	Thu, 25 Sep 2025 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758826840; cv=fail; b=GKKrvDM8HwWzZ0ZUWAOo2eoJusmMsZ3STaszUiCqhIocSuGdyhcLgpPPO/6ZAolIYVlApw7iFSF/Qxer0wHkl/+DCr7KQi2vwS84rGm3uI+ZOZx9+KGzjJHYEUWlj/bE3PzxcshSrEa1NnIqTf6bZLt6QZveZncrszt98eQPr18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758826840; c=relaxed/simple;
	bh=cN8DKJLz9d1KY6MBdmnELf8kGoUj7CwC1hb/8UHXo8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ph2JI2OAbC1eWqzTV9SWqFMU5sDL9aNOs/Kc6msB1UgcE2wUjm4s3PvIDo0VPShndy4+IU6IvUjDY5WUPtTXJyziwp2K/UaYSASXv++sQ1FsTjS93keO6g04pstnWESr7dOkUCRIObd9Pje8CrSJwNznUCSVC3MslC8HSbDKI2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ofxrBzYW; arc=fail smtp.client-ip=52.101.201.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPzC16rrau/RouaFACiEV+zUH0WOP+3H1do/+/u+iBNHTvs8dyFyMrRNw1VXY9sJy1DWYVJk8gaSxx+88JWZIVvySt6byMrbiv18ovapd3rMONM+K2Q1KfSkctZ4jJ2j1WZHaYhgfKbZ+pV6B1qaiDgpaGWjjKTLEzIsJ+3FQarhzWbnVV6EpgKi0VNJiihLNoOxEY/FQggLADIFfgFlVDmhJ6Yvsvhzpv1MHGKxcLaMETZ9dKe3Mqm0TXRNQGESKl+qTS8Lkv9yIqm3tP4GHZnL8Vob4lEF1HB3RvAjyiayc5D+LNebg/oNeZC1UrKuuHOGjc8IrVrh2VVdiKaVuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZalEeRoZFufC0ht6s19Dnr3xBqJjC6TWx69Y5/sDSA=;
 b=G867deq+jTI07RAol26sTqf78gITbmub1GpxaEzJY0XZgzFgshLQxICurnZ5JWWC4FaGlvjk5y01MeQwAAX4WgPmBzt65M6/P+vfql4W0V8treBRQSE3lzx01moO9s//1YBG37GbdNOUCVmQCkQ8W17zoZH4rK3YVrNWZ/eUom2o8q3JeY0fZiFslmkhLLHXQx6YZVMCcpUkhnqw4a1dHU2RxCZFgfnNMruDUAUIfggHITHp4hLB6vQRodKGVktS9gSQ4BrUMkpfIXpxkiujg//vzQDFZa3JNjABEygaS21KfshLLzXenkF+nLQOZnGGSoxYrXDpa28mtahw1rBPpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZalEeRoZFufC0ht6s19Dnr3xBqJjC6TWx69Y5/sDSA=;
 b=ofxrBzYWasloLwG8n5UKK3xeUg6sLXSKUsc/4cbmZnADAYXbt0vcE4K8T+gJeYbWSEmD9XIUitunMp4U9TxUidHMS8+d8qH+A+JzY63/tt13GzMcxMfdu9/23jcSG7r9qjdVYw5Ol5ykRBwRSXzZ2XX99MPjDJ/toa9Jv7b1TIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SJ0PR01MB6160.prod.exchangelabs.com (2603:10b6:a03:2a1::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.11; Thu, 25 Sep 2025 19:00:37 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 19:00:37 +0000
From: Adam Young <admiyo@os.amperecomputing.com>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH net-next v29 1/3] mailbox: add callback function for rx buffer allocation
Date: Thu, 25 Sep 2025 15:00:24 -0400
Message-ID: <20250925190027.147405-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925190027.147405-1-admiyo@os.amperecomputing.com>
References: <20250925190027.147405-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYXPR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:930:d0::10) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SJ0PR01MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 5df81f8b-c908-46ca-c550-08ddfc65d00c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?48faFeHYKhFkTXQA2ooFVdj9eyC9x9Y6swap+cM7YxWFKNaKBFZIacwZaq77?=
 =?us-ascii?Q?7vaacAcqpa7fiS1pw9QQxq6ZBxRhEnck2wpe+OxgN5aVUYhIZ25UDq382Llr?=
 =?us-ascii?Q?RBwL9rc9r9vNpyx8IEmIfAC0joE2bGGS7SvomKhao+Zvcx+ScawSDFKmSfvE?=
 =?us-ascii?Q?jqrWwfS2kwRH6qMrauHK4F1EgH9LD2c2qAmnXW33qCMjLuN+fhAEK2cJ3so8?=
 =?us-ascii?Q?k0tWj/liJheb8beNSc9ep+gtKUvJCioAUOXKweCpte6tqSJY+himYGLBOmZ/?=
 =?us-ascii?Q?2VcXuHxesBK9FvZevxck6upUReKmrx2JRGk43OvTVQ8+B0Oymtyjl3BPMumc?=
 =?us-ascii?Q?bWbvclnuk2287luBbSoeqjFs+UQea0jw501zO2jxN5tbI+qAAknv8K2bt6pV?=
 =?us-ascii?Q?WiCT9pnVgo1U6pITrgEmD4sv4v5TlZhsffIyDA9AbeypUZ6NsCkhebr2gfGw?=
 =?us-ascii?Q?pohGEr1tt/pbxJu8mDAaNTgF5oI3hnqyzoLpCuxxc/KzxtS346Zl9DRsjqSZ?=
 =?us-ascii?Q?roXYmYOs3aOLsjCl16ViMBG2hinLCzYqKMiJdPpZXlybdn9gdfoGOB4yG8Sb?=
 =?us-ascii?Q?AAgg6BYW9Q74WmxTcg/FGlJkieVd6NNXgP1lWaAk4O7zSxBl/GbitmEDgHvj?=
 =?us-ascii?Q?E40ftFl/QSZrhALqsBxYhMzYT3Ub4sssHAZBYGDBthkkwUkga8edcVwxbqnP?=
 =?us-ascii?Q?JAZmNZYtWG4fULIQappOSO/tw7HwwirbPNB+ui887RnbmLbxfKKF8XweAbBs?=
 =?us-ascii?Q?5k+XYyKysAFEMZFmhv3lZ9AGRBLxXmPICup4/BjgtRvT0TvzPxv3LfZV8ktq?=
 =?us-ascii?Q?MqsTKBjy7OQP7/SxnYXm1eAgYel+FhCFwS2uInl9r1F3rrQLVlaLe/yPJceS?=
 =?us-ascii?Q?pMhshEPk2P4Hd43ZncGOtfXkfysZFAGOoLu74hJX3AW68yBOaQOsjSo4eiu0?=
 =?us-ascii?Q?cnuMpIBvKvEBgxV3wTOVPwSXPOpkofUJY5g4f6yzzwHksTZs3KhT/vK2Waie?=
 =?us-ascii?Q?H5y24sgyz3JGCZ4stjbkXheQrkDV1JEhkwCjQjoRsKu5Dk4dBr6v3yjIYN2z?=
 =?us-ascii?Q?JpNhHy2Kqh90PYLK6+YUBl2Y96OBsuZ+yFKoj89r4dMxN1hmKpQdwv46U2wj?=
 =?us-ascii?Q?9+zy+L10TlgdqqFKTFTZ6B42V3SGV4MZ75HfRJshBnYsKMUnbuMQntKlTRaZ?=
 =?us-ascii?Q?4cwUH5MaGj3z9gCdIT8P9bevkSAe5FKjUzyHr4xDEBSfZLshtlTyIrZmmcKU?=
 =?us-ascii?Q?NGQDbkxW4MspbGqcwKbQ/ElpDtBKFmbYhvvv8idoYbTVyozbaYMIw3KD+kmQ?=
 =?us-ascii?Q?K6AgyS6jCp4cDsdOPaL9Rf3D9kkRZALMzxidNd+h+twHHQh2U6onjm3R3yQu?=
 =?us-ascii?Q?16j/oolT+6FKINeksmWOXmZgeCKVYOuo1YbUFvq3nJEHu2PCfxAOA92YkBaP?=
 =?us-ascii?Q?9VEtV6EBhpz/M8mURtOFZ+XGG9jr3cog?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J8hUuxylvEGNwGuHgFcRRbwe+8kl9qKVTlQc+9bIIsEGgWknxzHw7bUXhzfR?=
 =?us-ascii?Q?CB+XfbPu2W4HcEsGWOa8XfcL4h3DBKiZGR4xTI3pbO5kjlE1cCw7z3NMdCM7?=
 =?us-ascii?Q?vbMzUWAKLAB8tK8nTsU0CyFc/IES81w0LEigGjykoMRzFGNGdcUjgByFkpiz?=
 =?us-ascii?Q?Ws/AgzxzHY1lJWMaSbHPWG3Lu8RfsLdEme/PhKXV7w8Enxd2gmCsNDXYw3qH?=
 =?us-ascii?Q?2s7JzIFHKIS5aWXWjb+G94PuGeGfm+POR4OF+MXTP1zS+eYA7tsLtWxts7ck?=
 =?us-ascii?Q?78qJvidbFSaJchb4ASruAmzQoVOcGc5lbzFMvlHii4b45KtaXaS4fiT6JmEa?=
 =?us-ascii?Q?faw7ywCnh4Molne993ZKsmeSv3VPB3BzYzFNoxBQhZglZwsOmSOaNDTTGGas?=
 =?us-ascii?Q?srWk4tSkoOJnQK0HIoQ6LWQB5DWQTBNSvx0IY+23+fmS1oEmMFuD8uVbVUPk?=
 =?us-ascii?Q?sjuR+HUYcKyNQQSpDo8XQN1vbMxKdOkFNxVu8ySeKwOrqg3HigTVs3ejG04f?=
 =?us-ascii?Q?o3WHwwHlGGKZ+OX00hz3bnIcTFhqN7IRbp2lLJqdRlxVLOPq96ujWQ+9QmQr?=
 =?us-ascii?Q?mWZH/RCxRXoDyRwS60GttkV2XTV2H9/IKbP4ke6ZFoAgu7QMkwhg4hKvG3t0?=
 =?us-ascii?Q?spt2YW6siPlfLkj8RLDA6wMJ0ZosI4lp73xOA855/aw9Q2JovWq5SKYHzfhN?=
 =?us-ascii?Q?UgFxzKQ4rLb4gwdQ5KGxz4NsCatDAd3xjKm4lbUkRU64sLYxhVtIezrDPysL?=
 =?us-ascii?Q?J37TI5mKONtLjmwlygMVbm3hWz2ey+A0maEvJu4F9GcguxMoSkw+juEyJTKR?=
 =?us-ascii?Q?gNwVng85Bxl3ediJBZWsv2usSfaUXhdHiaYE8my2pWMgpcebRv7GaGxKqfXR?=
 =?us-ascii?Q?Et8H46OS6vT3gw52XAw0wHXvf+b5DSkzbDHRL6L2MCM9Jx8Gg3aOAUBW1ozf?=
 =?us-ascii?Q?bMYho22qHZ1wVKOshOyhQpbQwwhf64h6Z0UZBvaCKZE6TC6y9mqYmgwk/eTn?=
 =?us-ascii?Q?267ckmHUZiElYvejxC+XjXfLQjJ0rEQwpbmhI6Z5kNxoIFkfl23uRo4D5qTg?=
 =?us-ascii?Q?SA2LKlpcBQR1F79VaTIG65GlnYH1kvKZnkI+oL0ctQjoDr4890ndnbdEITNO?=
 =?us-ascii?Q?eZVqe/XnkpMcE4Kxgkvd9/54+r0YSXhxuEzOQd1IAMSmdKBhMq921Kilbut7?=
 =?us-ascii?Q?/mD7ag6vg/wYXO6oMe+u6JNZZB4oYd5I0AC2WhY+wwq2xhpyi/NIeSbowfTI?=
 =?us-ascii?Q?OLYlXesGscyOuRESljh2fiwEJB1E8olJxs80EYaMkVhTIhw+aqugW9bNC3B1?=
 =?us-ascii?Q?Yy2qk+8/8usBRrDYsMrLxccXhV7KQc8jUivyp/ShbXGtBJS9v02iZMoez+u/?=
 =?us-ascii?Q?0fravOF4I24vE8SBmKJOiJP2QN5aLzq60dQfStYvJEIFG82cS4at0/AiVhXu?=
 =?us-ascii?Q?R+nByJjP00CqgcHfQM/NQS9GYwgMVph27SSN72AgB9n65FkHJsMa/B0SGXpe?=
 =?us-ascii?Q?Oqgc6oq9RErijGjSRxsIMiJKC/z+4UFr/QBiTsm3/+vkcxSmQOOeHaqry7l5?=
 =?us-ascii?Q?UvgO1FztlfVLch3PFAkcQUju1U9I2mR72R3RptNiwWaUjqK29BDCjS5ioXUo?=
 =?us-ascii?Q?I7juqshes2zjx26nvKdHPxy9IuaGoynUBvpglwtU0muydnBfbiyqtH+VgRL8?=
 =?us-ascii?Q?FCod19hQv3FpnIxF0OEJC5tgJvQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df81f8b-c908-46ca-c550-08ddfc65d00c
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 19:00:37.0577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lsOleQ22gcQDNViFKQbzE15RfGW9xz5UiiIBwAKuagRzHCT/CGNvgEnA8xIISoJ7lZDhxuGIrf27jvSod6YsekQhJ2rR7H29GpbcK5BGSLBsAgxPnTm+hkf33Wi9J70
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6160

Allows the mailbox client to specify how to allocate the memory
that the mailbox controller uses to send the message to the client.

In the case of a network driver, the message should be allocated as
a struct sk_buff allocated and managed by the network subsystem.  The
two parameters passed back from the callback represent the sk_buff
itself and the data section inside the skbuff where the message gets
written.

For simpler cases where the client kmallocs a buffer or returns
static memory, both pointers should point to the same value.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 include/linux/mailbox_client.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/mailbox_client.h b/include/linux/mailbox_client.h
index c6eea9afb943..901184d0515e 100644
--- a/include/linux/mailbox_client.h
+++ b/include/linux/mailbox_client.h
@@ -21,6 +21,12 @@ struct mbox_chan;
  * @knows_txdone:	If the client could run the TX state machine. Usually
  *			if the client receives some ACK packet for transmission.
  *			Unused if the controller already has TX_Done/RTR IRQ.
+ * @rx_alloc		Optional callback that allows the driver
+ *			to allocate the memory used for receiving
+ *			messages.  The handle parameter is the value to return
+ *			to the client,buffer is the location the mailbox should
+ *			write to, and size it the size of the buffer to allocate.
+ *			inside the buffer where the mailbox should write the data.
  * @rx_callback:	Atomic callback to provide client the data received
  * @tx_prepare: 	Atomic callback to ask client to prepare the payload
  *			before initiating the transmission if required.
@@ -32,6 +38,7 @@ struct mbox_client {
 	unsigned long tx_tout;
 	bool knows_txdone;
 
+	void (*rx_alloc)(struct mbox_client *cl, void **handle, void **buffer, int size);
 	void (*rx_callback)(struct mbox_client *cl, void *mssg);
 	void (*tx_prepare)(struct mbox_client *cl, void *mssg);
 	void (*tx_done)(struct mbox_client *cl, void *mssg, int r);
-- 
2.43.0



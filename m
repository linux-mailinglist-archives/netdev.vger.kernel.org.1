Return-Path: <netdev+bounces-242538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7738AC91AE2
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 11:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F39D3A3E76
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 10:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BC0307AF9;
	Fri, 28 Nov 2025 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="aMNzyiMK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31CC3054E6;
	Fri, 28 Nov 2025 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764326252; cv=fail; b=rhMKFio9GqIeYHZGDfrSUVz1mQy6Quhk33Z+lZZ0CTg4qkgeadmeP8VjfcOBPUcI80S8/Yby2D0NrljLr1HkBeLPqudGVS/O41c443V1/Wow0oU0t5l+ihpx+iF/OX/ad2VdafhAd98Mu7qNDxwlQocJmKpq0nZuWGLUwiGu4kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764326252; c=relaxed/simple;
	bh=JIPt5QYsFCEL9l/OxWJF1lfoRTUE7ZFOEK2yvOkZRcw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kKzAkbaM1p1o1ZDARy+jc7auYkXKAzj2PFDdxUhUirdS4tG3LeSci8AUwFMJodDii0hgAeYHrT/hcCP3AT3hipwoqX49oUqLcHV2/hnmYNSqj6P9nGNMkytM2K1Igp5IkRPRcwmfuhwUuImSKvFsTdEolEMG8we+nl8JzzwhhWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=aMNzyiMK; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AS7aJPo2188486;
	Fri, 28 Nov 2025 02:37:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=ulVGvMX3B
	bQHPXFpXmi1Ml3e+7Lh2cSdBXDcxhD/ZCg=; b=aMNzyiMK5P69o4U8cp938H4oK
	3OcHDHqkWcaLYdmzhryK5nzaPrKKS1BbanvL6ZMutdjb4L/4FxNH91GBCtY1nvBS
	HNLbBGhJ9mLzArqMRHAOqjEoVcjOGYV3hgZHjgxO2pWrSAUQJOyKkipXmJl4ocRc
	ydj2bJaMAVTsb50JeDGGwP3SkqVpln7Y1M+KCYL5fZy8MG56jcvnCiLTyFLEn3bk
	gbvSAvJmQd/kqOb3i8915Yi7Dpr/pYYl0D1Mfh5pCyTXAW5Hewzy5ppKKqge/k/L
	LMIUyn5iVcMak9eAEucCfwdXlJ5K5lIhY1t2ube8ya3KTrq7JoagdBKifV5bg==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011055.outbound.protection.outlook.com [52.101.52.55])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4akdjjeg0y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 02:37:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbPA99tbJC3U6F6ZFqTrzauaYG7EfwSsjTwZEMj+hZF5rr2irsrrtz9ggZN/e1vHtnE1LhB0sG3QxtMIWQlApFzZS/XS9CXPWLglqJoPUgdPitT0I4r2BMiHoqZreGECDvSVAzGLTA/+jZOTe+Dfi2qHkNSGUTJ+gsLkFrmz+JC7Ue1rvfaR7U9vhp7OVQ7AKsGoYK971WGobQ/1XoYCXIq4hD5ok0/E7Vx6LykatlOlENK1VNe/jLWCRp2UNWbkY/2ZYwszQFo6ezWUj9tcAnYTLeKqyGeOdVZWvKeXOIL9WV7cPtRqsSPLMkhg0EAVkywRp2g5SqEihZq6iafNOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulVGvMX3BbQHPXFpXmi1Ml3e+7Lh2cSdBXDcxhD/ZCg=;
 b=RJcZSAtajosZn12Dx/TY7JMVhROM22kTwy0U8gMKG0sqMxxuH+yBT5CMwleXmtDVn65qT8AEjOpK4totz4EqO2s9A394ILxTaq7crz9G1MAYIqxQvwKQr1+YAjPD9tnIEYPQ+ilThXIExRNDuXYJy04mpET4b1AwmhIktnJyG7DCkN3UFDWAqquo07nMdXEh5zXFqTYcNLO2GTIwhhlajdy3E3DMyqDWVy+u/0OPRmPV9rM0t/SRcoS3okahhwaRXD8oiWWPQxgueJKc3pcPEywM3iXBVs4N+zowPq0Bi5PVSPOXb/m3YvB1wCsb7pVO/7iA+yR0mgrOZkKFqfIN3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA4PR11MB9201.namprd11.prod.outlook.com (2603:10b6:208:561::16)
 by SA1PR11MB7062.namprd11.prod.outlook.com (2603:10b6:806:2b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 28 Nov
 2025 10:37:10 +0000
Received: from IA4PR11MB9201.namprd11.prod.outlook.com
 ([fe80::a51c:d456:b4dc:d6f6]) by IA4PR11MB9201.namprd11.prod.outlook.com
 ([fe80::a51c:d456:b4dc:d6f6%7]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 10:37:10 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, Kexin.Hao@windriver.com,
        Xiaolei.Wang@windriver.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net PATCH] net: macb: Relocate mog_init_rings() callback from macb_mac_link_up() to macb_open()
Date: Fri, 28 Nov 2025 18:36:47 +0800
Message-ID: <20251128103647.351259-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0015.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:117::10) To IA4PR11MB9201.namprd11.prod.outlook.com
 (2603:10b6:208:561::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9201:EE_|SA1PR11MB7062:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a95a53-50de-4c90-2dac-08de2e6a15d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jLkEcdsQflCz8Z08yqu/cLDVbzS3HJnIU+6thYn9Au9R6HgE3KOKOaUjkRfo?=
 =?us-ascii?Q?H8V4w03aMfL3US8+JF9Wi+5BRVMiN8EQEsl40/PKRRrXsjeowS1rbrr3i+z3?=
 =?us-ascii?Q?0qqqdKa7Rt/pZ9cIuZTmZse8mimSMne76OOW2UNQ2j3pfr1q6s3O/NIf9vba?=
 =?us-ascii?Q?dwsWOddlFMRPWvXLwONaZwcK12IjJD6gQ3xFgiIr6ptLo5NfVEeL3tWOJsZ/?=
 =?us-ascii?Q?7eDU+Dw67IO9RIhAGNEgEB02n/NDnllOQ+9nan///5Riwdf0Yh29+nwE8UU/?=
 =?us-ascii?Q?2GvV2pbrcaCH2/gtIlSimXjcLhFxMsuBdgn4pqG8fGTiybEkWohp7hi+lmqU?=
 =?us-ascii?Q?algjBshioSqm3aZd2TyM2hiDD8F1yiUIL3CqjdbdI4icFuHK4+nSSHY1lL/F?=
 =?us-ascii?Q?vizvvkapMVgbgwmGiBuxlBvsf+kIn6XKUbv62HTW6lsgCBaA7LM/tTVH68ZP?=
 =?us-ascii?Q?LrS7xAjHz6FPyvk6lC0xzSDYmb7P2W9D+Qm+F7btdPIn8JmmM99/alDpTAoH?=
 =?us-ascii?Q?MCAGcmDTDe7wSytg3VIgvHP8KKx//IKoH1MTU3UiWjkj3MUSMgfUplpJ6mYM?=
 =?us-ascii?Q?+O7V9DmXMfOiRNdJARlPEB8hrsHqLBjvk1k0nEfNy1CfJ47hAUztC8Wcq/KY?=
 =?us-ascii?Q?GotfZHoM3oPbAZd6P6jVe075YrhkKGjq7XvN9JdWOn/wPwNsGT0Z86THWOG0?=
 =?us-ascii?Q?4cR5GGELSwLvn3EExylg7Xan7upaFMNmZWPktFJuxFVRVwFrbdIFCZcbjsWj?=
 =?us-ascii?Q?3aV6wVq7cENQfGL1iFvCGOH5WgC+HUZnZQik9xfOxvA/TnvilwyPOIixmD7h?=
 =?us-ascii?Q?ehWO963m6S81KGAOHZX41BWxTBrXA/BtFI26Z2bAITAQJNe8YuYhoCZmgSZR?=
 =?us-ascii?Q?vx9URMmDPBzzTyCp38Erpdy11lqAnnfKEzqPyISQd8o0uNUt5Xsm2F0RDaNz?=
 =?us-ascii?Q?TnQT+ZrOiTkbxvcQwKGbzP0CBnCvgsTV5SdNQlmc8q9CBk2WfsFZ9YGJOjuk?=
 =?us-ascii?Q?H9GxaTqr3rey8/5X+Y666mY4paYLlv8D6XkNoETQJthHNrEgguDq0E6om8hh?=
 =?us-ascii?Q?g71FwfXLv9YydZvaqxYD2rgRIBEYe4AbpokSmhj/iA4Jap5fiDBJfTnTs+eB?=
 =?us-ascii?Q?IpcpcXsB6bIMGVKr2YFXzQuojY7qeRJwkDvCj0ntxVoMN9FI9agc+NZAZ51o?=
 =?us-ascii?Q?9uWc8q16oKtju+GxpG3EmR1ApAX7jgT4g8sqzI3PflzQxtWP/ZoD29PkS+Lo?=
 =?us-ascii?Q?VSadLkU4PbCUa1xyV8UBCC6DfVf8TVxYkiQxrdMK1+GDwxWuPZ7w/NJHhbXL?=
 =?us-ascii?Q?FDllKMpIGQWNx/Ce/vzN1i21hUBG+4Gnuf/V2Umpm9hlA7Vws+haXyjjUucE?=
 =?us-ascii?Q?t0ZnHMUeA++cYrDja6NT8NwSFI/WF7kblxearoFX8FMGh9kCFfmXqMxny9IX?=
 =?us-ascii?Q?VB0d5UckwQte0ah3HU1wNmzcMcCC2GBQSuohvBtR5kG0qvl+aCwj4DsZK3Iz?=
 =?us-ascii?Q?E8pZhfJcKiA+ZHIHbqxBRJmHy2uSeJNT7Bjw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR11MB9201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LPB8CFh2TGPgeLNVSO5fUsvijBEdhY4igaV+k8fopXehjl6LkpqvkZ/J3ayG?=
 =?us-ascii?Q?R61RlrYqI22pMyR2+B/6Vo7hs/iqSonzXytelKFwVW9eV2wiO4zQH8baNA1u?=
 =?us-ascii?Q?t24scjr5vUWPDKA90aQlhncbL6CMpaLCtfg2HGWXW3LHG7KUz6kIwWT5u4ag?=
 =?us-ascii?Q?lbI6zIteKdLfVEa1TF89EMWP73I/En9rf5RAGKnDLDO2cHPQPU2fzPUM5ceb?=
 =?us-ascii?Q?FqsTa+u0Rbe4eYDAoJqeGsZ93IQtxoNNqDlbfsrrMK3VPA/nz8zZN147yY3m?=
 =?us-ascii?Q?wfObA2Ks32jNPmg9L82wuFarUoMEiRBluQcgfUBKZyWf7Ko9TUUKiL6DmP3w?=
 =?us-ascii?Q?OkWSoNyJeO+Sj5Eyxoj+WvpzJt/M54M9KOxGFREe6ZILb8lDwI3IXHDRrtpd?=
 =?us-ascii?Q?DEVhJtW6QY8Xwc8VfR6hiwo1CNtDRaQLGA4jlTvU65GSkQALhx1dKmtBUWZD?=
 =?us-ascii?Q?uBu65AwIrGV8tC1bXuv4pGK5HeFhL/bIsBtkhFE8ITt1HHjZI2zGtj5CEDpf?=
 =?us-ascii?Q?ykA+/s5STOuW4woXa9SWmUjcEhAit+HJjYX8MAlkGpdcj4BX9hZZT71eI9tD?=
 =?us-ascii?Q?JBsDGIWwjOCG+zE1lK7HT4nvBx6hbDcHXWdJQBtigZMt9A81zK3g4m4rnBGA?=
 =?us-ascii?Q?budOXOw1QfsUGjArlTlXKIv18C/q5eNPep6kZIOXGEnk3F9eyr9i1dH/rQw7?=
 =?us-ascii?Q?s26wifJUoBUES9Vi3eORXhYxo0qWTLrc7E/1QIJJj7eACTXGntXN41056aCY?=
 =?us-ascii?Q?Mtyei8riGT4pEO2xfY+5OEkckURvC7ObemRvTm/AJ68HlIOFo4ilchDQyG9q?=
 =?us-ascii?Q?YgyNnCTnZRlKVvmkWAPzwtdhDwZLSahTYIJnanIf2u7ztnFlvmPGawRI/uzu?=
 =?us-ascii?Q?BCvcD5AZpwZaN+Dy3njPuzz9MRxen2YYonAoSvqbxMZz22w5xfHESsJaH0J4?=
 =?us-ascii?Q?NOWNV5kap9ZE8KxOgcXGTv1q0+Oxtvm7fVaOc0kmLlMShvuynLOnaBDzLrOC?=
 =?us-ascii?Q?2EOdsL8aEAsN8ITrXccxQonAcmemrgWAJc+Un4qMLLkLNZdZ590ioqEFEfll?=
 =?us-ascii?Q?pjzQctTuErMsj17oF6xkGJrj3V8YKpJdm/XPPSSeXKCJxcaG/xoAoKOd7Y9r?=
 =?us-ascii?Q?QdrSXCJp6+q1DKb8Mt/JnJWo9gdHxXALsuwZ6atzNC85yDpb+SucwlO8qfsr?=
 =?us-ascii?Q?ANTJRzbK5L+r8zWuMcwYVJdVTDQAOHoNkofv5AEwsMNJFgc/ekvFtYYuLDOZ?=
 =?us-ascii?Q?d9i4/j/0wu8qUzoGF89Dr04rQmkwGnB+eqVZ3DocyIj9Wf89rEuFsNlDaWSV?=
 =?us-ascii?Q?a9qTx3o92FwSGLQNLBhC+zx4pGtnwwmwI/cGA6ZmuVydvncEA9yxDmngcN9I?=
 =?us-ascii?Q?mKS+ppceCnUt54X0Fh/dQlNaFtVDYqTouY/07CCDR76ktW/CrQm4i6cy8FZE?=
 =?us-ascii?Q?odrIyGFs0M4/xfowt1JKNWCg+/H6VZQmJcI0kYKfbFnxgcMDpj14kGzm5FjT?=
 =?us-ascii?Q?P59+wKHgl9vtCtf53gd4FWXAcaSeWMTXH0tZc3Ft5uU8/KmbW8+PMl+6zElK?=
 =?us-ascii?Q?vG50pNZM+lJHbScQ7nSEyd6qn8oBirY6FxIxdn2UbqpB5vs/c0rA27BSYz0C?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a95a53-50de-4c90-2dac-08de2e6a15d5
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 10:37:10.3338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXhuhhByVTO4FuaSkHYcGaqJm81GDWzUE5PzNUHbb3f/vCc/lK2s3wf7LuIvv9xOM+HbXrcbHAucdxtmzLlYV+PsjMTa5XcoH5vi5TlPs/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7062
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDA3NyBTYWx0ZWRfX1K3P7LZY29SX
 2iJG7S0NSJDnHjd8BLF8UpJHcAq03/yqAQm3DUfLGmCuJ2PBzALb2GJAOa/5ZmUDWp4oymCzvAM
 hbn7MionrwaBbGAVTuVBCqN8P2j8BQWPPpcuI1RpT1i/Mwk6P/PZiTZn8m2bkNjvYrJHqBE0HtW
 QgIWEloKBdGDJ0ZTEi+oZRta1Eiye7MH4dU6MIISaFZhDWvcBxwfHlVMZNHPUowrabDFDt+qqpi
 HaV5fNO4dufjtmuiYTws4GON/egwMV49CdBg6Gu895pZnKY4HezSyP8ChwKD2F+XInnV9R3meGe
 R8Gwf1KIu+4whqZBi0Pnadvo0LhdYTEmaF5z/Qy8y8s9pEp+KatxHomkyLUvgsIv7CYVh9qMpSW
 FCELDJ/SCT+n6b/dqn9uxDjaF1BoRw==
X-Proofpoint-ORIG-GUID: XBNMCV3LbV_WeL1Gziq4Emy7-0ptFRPr
X-Authority-Analysis: v=2.4 cv=Wq8m8Nfv c=1 sm=1 tr=0 ts=69297b59 cx=c_pps
 a=8eAlC+B4wJl04ff18yArKA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=jC-9HDJIDFR8ZNNSwUgA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: XBNMCV3LbV_WeL1Gziq4Emy7-0ptFRPr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_03,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511280077

In the non-RT kernel, local_bh_disable() merely disables preemption,
whereas it maps to an actual spin lock in the RT kernel. Consequently,
when attempting to refill RX buffers via netdev_alloc_skb() in
macb_mac_link_up(), a deadlock scenario arises as follows:
  The dependency chain caused by macb_mac_link_up():
  &bp->lock --> (softirq_ctrl.lock) --> _xmit_ETHER#2

  The dependency chain caused by macb_start_xmit():
  _xmit_ETHER#2 --> &bp->lock

Notably, invoking the mog_init_rings() callback upon link establishment
is unnecessary. Instead, we can exclusively call mog_init_rings() within
the ndo_open() callback. This adjustment resolves the deadlock issue.
Given that mog_init_rings() is only applicable to
non-MACB_CAPS_MACB_IS_EMAC cases, we can simply move it to macb_open()
and simultaneously eliminate the MACB_CAPS_MACB_IS_EMAC check.

Suggested-by: Kevin Hao <kexin.hao@windriver.com>
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 65bc73f6fa30..7df2ad093bab 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -775,7 +775,6 @@ static void macb_mac_link_up(struct phylink_config *config,
 		/* Initialize rings & buffers as clearing MACB_BIT(TE) in link down
 		 * cleared the pipeline and control registers.
 		 */
-		bp->macbgem_ops.mog_init_rings(bp);
 		macb_init_buffers(bp);
 
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
@@ -3049,6 +3048,8 @@ static int macb_open(struct net_device *dev)
 		goto pm_exit;
 	}
 
+	bp->macbgem_ops.mog_init_rings(bp);
+
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		napi_enable(&queue->napi_rx);
 		napi_enable(&queue->napi_tx);
-- 
2.43.0



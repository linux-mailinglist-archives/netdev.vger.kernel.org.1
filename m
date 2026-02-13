Return-Path: <netdev+bounces-258571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AvWHVXMjmkRFAEAu9opvQ
	(envelope-from <netdev+bounces-258571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 08:01:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 912BD1335D0
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 08:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9379F3010809
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 07:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5C614F70;
	Fri, 13 Feb 2026 07:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N98J+pLv"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010060.outbound.protection.outlook.com [52.101.193.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33791A275
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 07:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770966089; cv=fail; b=IoqursmYTP1d7j27RMD12ZcAS2ua0MaY0Xtc0BkJYYxxpittQcotBIAr6axdNkwLWxCzkTlbgkKPX+yUY9mrR4me48qFUPR/qPbsvzsXnvXtzOVrrq3ZSGc7mYQODYiW9oUmPr2i7eGYbsaWP0UzozwXMWbNXKylIvu3dbZT2RM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770966089; c=relaxed/simple;
	bh=q0gaWmH5SjTvP3vgdMu30qblLoa2bO537zM1whYbCcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=owduxxO62nQSYAqbfgVj2DGpDeb5acwJTYIhxpAMmGzHezN24GTq4BwV/Zx1zSiP908V9j6m8UbHPV3pnT2AybgxGfx/Eug4WRvasVc+Mloh0bcsKoKrrNI4Y6Fyyw3HFaeHKdt9X19DU3EyeDwULPNID7dV4kdkfoixJlJjbPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N98J+pLv; arc=fail smtp.client-ip=52.101.193.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0Pp3aLNw5kmqhhvWXfb0kTe0DoNRW6bhGI2Vu8sBJqsEa1AiW/cxPzpTZbnPpA7GX4as9nayp1gge3ZT1PuWTNSRX10N0dnjoCniJ3H39VIfkEBi7wndUgnRcNbzRFt7nrlf4wy1btABjDH4x+4RXX+9BF4Ic0j+V8pwt52Vg/kBDwQXMUh+Km3zUKIkIq6b+lNONY2Z/b0K3H9cURG7czHuDmtna6v+zbwyoHULPkoDSAq/sm6Rl1rf3wh3ZfSWXbeP9hkOtta5o6MHkkr54Uxn2saFHfCoNVODksvoq8COzsL4i+/BG7tpUkGrKExgvMXlvU3+ylwJzDmdIYtjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEPhCzFFCF4VXMhgPOUp4gtpTjMmDhyFHfcxe4FVrvQ=;
 b=E3D6GcZk+aZpzzrejzYX8em9088wLcvyysHEBAaLHcvWL8Y4v2JsGF5d6yYY5iVSOE8VhqnOVu9yWfOrDfXO2l1HVEIIcIKdqAaWd1tfOQoj6C9K3uVO3i2j8poGOsPbBbZgAV/Q1zC/ACQCctYqD1SpReAfyXpXekMRl7GcPLSK9oMl9bz7/649XKcUTQiVkYXS4HYXmOv5z5vGd+h4+UabgExrUsuFpJycTSG8Q61o4TMnkKfYH2QD7J2k6jxotCusntnUgg3zy6DZHB3kXbJ2TNNI4fX5RT9ud0t6pyZHjfnxrhLOlVjswBVGQHafoAM9FVoIZtbcoPlP0baWbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEPhCzFFCF4VXMhgPOUp4gtpTjMmDhyFHfcxe4FVrvQ=;
 b=N98J+pLvMDwmxk88Cw2w86T1Se/looeXx8mhooa8+vWupSRbqs634WWIb+tcsA03wfuV7wdYyGfKapfHRerHriqngcR9bX3vilQxUlFoQHkPgNRVtFbet7Kkd1ew/wXiCk324ZLe5GY3YhQzBQ72A4PkH4FDn+gxr6eXkEUOPueJD3BH19Db1gTvWaUvbTgmnCKSuCYBNyNulgegILtlN8IRPZiF2Xvn4DJ/On9TicEGh5CNf1ZCqVGpNfNSnBToUQIXegqShu507rnk9mIX7w0leT+mFeETWXGldrfPAcmYyL++Z5XBwC/HeWuN1/XWciDFswW5S6+EVM8cLa+umA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13)
 by LV2PR12MB5846.namprd12.prod.outlook.com (2603:10b6:408:175::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 07:01:24 +0000
Received: from DS0PR12MB7928.namprd12.prod.outlook.com
 ([fe80::5420:4724:4733:9abd]) by DS0PR12MB7928.namprd12.prod.outlook.com
 ([fe80::5420:4724:4733:9abd%4]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 07:01:23 +0000
From: Nikolay Aleksandrov <nikolay@nvidia.com>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	petrm@nvidia.com,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <nikolay@nvidia.com>
Subject: [PATCH net v2 0/2] net: bridge: mcast: fix mdb_n_entries counting warning
Date: Fri, 13 Feb 2026 09:00:29 +0200
Message-ID: <20260213070031.1400003-1-nikolay@nvidia.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:a03:505::19) To DS0PR12MB7928.namprd12.prod.outlook.com
 (2603:10b6:8:14c::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7928:EE_|LV2PR12MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 9715858d-1928-40e3-faf0-08de6acdb2ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R99pCbPIR15imAKl+TV5hd8SS+upfBzrGiGGKJJJzU/V+2+VNORtKUUqtJol?=
 =?us-ascii?Q?Dlx9Y4kc3kNeTb1y+jcCS7T1CBTbKuTRhyBK1UTo4eDnoA6JEAM43hg1Dcau?=
 =?us-ascii?Q?VfTN5864O8hLP4Hjg2sEm1c9VdbwWDq7wIwfTZHIksBPyy3NTgEpbKH4uDHF?=
 =?us-ascii?Q?Ntg6dbrRhaSA6pWaV7fhVJRhozpjudgLslC1Ij2YoFhmNitOJ529XZqylwmt?=
 =?us-ascii?Q?sTDHKnJs2yhKEw/4aKy8QYnCHxqAGlwXufwPCht6ysWRMfq8djbcPdUMsbnf?=
 =?us-ascii?Q?5ebaqPC00bjk4r7yx4lstLjYlg08FxWuO2BIXT78q7K61hc6fCamhPBlBbZn?=
 =?us-ascii?Q?uuWRHryZyKwNzxrgeOxXDJHw+YJRl+aKk85/glLFyOxSPp7FrawYaisXmslJ?=
 =?us-ascii?Q?jAD106xVds9dMF6oRvP0jwQ90037jdOyWiAFKd08LTIyzWZxRPi1eWIVRTXj?=
 =?us-ascii?Q?qZWQNGbxou7GAwCdctT0rcnHkq2i8tWpuRthd1UdYiZZUKz7hIE7p1N0XRhK?=
 =?us-ascii?Q?Uiqwi9bifw+JkODZJhzNlJg3jk4g9AgtNT5Yfu6ESI+N8cYFVmNOKkkMvUgQ?=
 =?us-ascii?Q?wPFOzIR3dH8/bzzwBRlYX9q0WufhGDUwe0rV9OG1/qXLzyb6SIz7SXgOXsCc?=
 =?us-ascii?Q?OHes7d1chPlRh12NmKUwv84DJIkmas8SxMzD5M8vl8m2v74/fHLnu8cFwxPZ?=
 =?us-ascii?Q?fhsvYEOsR66VH6z5SnyDVfaSiGu06dgAgLPQAxEtOMouqJVHnAIGsrHNWxv0?=
 =?us-ascii?Q?lofO0U/wPq3Uno2XVw3mcJQaBUebbbY84FjVd/I+QM0O0EyFiJpHxOSt1cRF?=
 =?us-ascii?Q?UI3/L7tTPwFay/pMpXariLh/jXNa9rkKtathT6FyZbN6sPs4C6xGpzsUKtpj?=
 =?us-ascii?Q?6AWrhNN4YQMmQE9MHOXvgr2WkMPZtFQIIr7MCu7DrBpjfSW3j05Odt86I1Et?=
 =?us-ascii?Q?UmmAYVGfJX8Bdzv/JBcDXEzjaQ+Bi4bk9tP+KXJ9R+ZZ3PwKbGY5MF/vpqXG?=
 =?us-ascii?Q?vgKb6gQEBuWWhBoOwWIb3MvsntdleT/pIRCphTKbTKRPl1Q8dWINiqChz5Pq?=
 =?us-ascii?Q?WNAK0nCKNxBwM5nFG9J9SJrdCexqqCc4DtwTVeCJ5h9cYas0lQdLzcPAIsTI?=
 =?us-ascii?Q?zTZwgYaPiu6ECFVaOrYDXN7dQ/kD90PIlVyzqsjymBZ8FksxkF87xJgU9Xl+?=
 =?us-ascii?Q?QMljZID7EIxFOyrZti7UMp4vA3xk7WimE2TJ4SvLg9CyuTaPbZHMouvhKRiJ?=
 =?us-ascii?Q?3iHHYuanf9I4xe1a+OalOY4g/jh0hKiglW4xohXb5rYpRfJmt7gEPTDGvD5A?=
 =?us-ascii?Q?ZiSxYKwuenJlwnjhCwZMKga9GrmwUiMLP8Dkj9726mO/92bNUmtN7/sB/iY4?=
 =?us-ascii?Q?ZvESa3HYNq3Qd28CtNaUgLV9P7fnkoGSobivbFiYaI39y6V+rufHX5clq8rK?=
 =?us-ascii?Q?IfqW8Jo10LQQL9ET3GT2v09/mdApNY/di2t9Lh1FirWyulcjdSg1iiFH58eA?=
 =?us-ascii?Q?MSOdFhg0LsyVqiI1V8y4F6U6M50ZlS8ZXxxDLdppfbJv7Aq0TgN6fGBpqDdY?=
 =?us-ascii?Q?KQ7NO9JjtBwLk1szpX8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7928.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fM6p9e2q+ir+JBJmFUMP2OqoBPpVlcYIvntN1x1TvLj0yQCOtvnzaQ0J0eKT?=
 =?us-ascii?Q?rx26tDIMHJ+6rjD8fXxKWEQt9EtYb8sc22FJaowDeZX+YdjYuIDcjuBzkfGY?=
 =?us-ascii?Q?eUsbHUAhV+AC30lky1NmKSUQDA4kcs8Y7cU8DcdI7et4Ndtk1m6idqMb45kH?=
 =?us-ascii?Q?x6HU7B5x48KeDHkagYN4/6ecTjBSqCssQO2vpUsqO592lPt0nV6pV44M/awz?=
 =?us-ascii?Q?AVHgoPN077P2IC0mj3cVepZSxh2OoK8Jc+D/4tnG8RWrqEV4KYLGeEe5EQ2A?=
 =?us-ascii?Q?1dT4dgkbKOcuoVLYD454ot3Oh0UyQxRFs59U9Nm1TZo5KwC2wre1jkHbsL+s?=
 =?us-ascii?Q?H/+qMCZmtmFFq3gu/W7BGUZt36b0hyvVOgcmIuktc09I9exZg8XmmZX1zeoT?=
 =?us-ascii?Q?EcpFaPWlmDN9Npc1bNyiWy0DdOJDsqULTN46W3+tAAu+uZagU9AWx5ufsS7c?=
 =?us-ascii?Q?06TUppnb9b3FjVdTGsn9xHncPRWfaht65ESykNygqbcI3JxmV0a5L2OIKeKD?=
 =?us-ascii?Q?SrDqtYJa4Tjgq/4VmYnKv3R5HBKp/hJfyTkMcZLAO54w9h27L4QDR7Hq5ROK?=
 =?us-ascii?Q?2lsP4XTkzjZ2vbvkmlnt86JlyF5UWM2ZiI6241BKy6j6zCX0/HzSBjfFQ6re?=
 =?us-ascii?Q?bikblVRjvjGNJaD2JrJZYb9tUSFld7kzlThv/MIP2TFwrXnPJhXI93vBLquV?=
 =?us-ascii?Q?Gs14GWS1EduVVPlsIwAyVJ+pGfWxAElSndSlJ9VDArxqOiLzcpzR95ncqun1?=
 =?us-ascii?Q?wSkdMSj52J2NKIt/X+viTq+RJ/2H6vYeFNrlOB6t1ydrW3M4WVu7RaSh7qAx?=
 =?us-ascii?Q?QMCziYzIzJNjod3QUFuTA/E1GVpbuGmEK5/EzVNQEVuPu4wQCE2+bjE4KT2h?=
 =?us-ascii?Q?DAVdc6leF/15ux9/ObAkmmwP4gkP14/oEg55s9S+L+FpVa7k2e39PpN10u7K?=
 =?us-ascii?Q?kqNsBP5FTzqCbzlmjAIasnj4EMsMHtmMG1G8PkpsNlIF9xVe9v5tp5fT2jfv?=
 =?us-ascii?Q?rsVAaWkVKOAcmyZPTLgwNbtbc7ymUyeUfdmBBV6GAXj+IrlenodNHBuVIK11?=
 =?us-ascii?Q?nTi1BtsxEVXPorss4kfPOnPyTVQoBqieugVN8SwveqNAvivDQdv4yVZDdNeX?=
 =?us-ascii?Q?Mkwjh7M0yy7hLHVfZcInkeqd39/0DOh/TUmhXW5QMUuTLaOoA97HG+fxBOMU?=
 =?us-ascii?Q?vs9Dq0bIimbJ6hgrF1Bw+4biQ3JLmBjRcy7fcX4M6BnomYB4FEUx6ykmswKH?=
 =?us-ascii?Q?akFQXx9727hs8hsMiQ0Zp3ZuLDsCU/8q6WRY+s4Wtahn3dnC3FFU7b2itkAp?=
 =?us-ascii?Q?pmesHk8gGDSWDJbUeS51ozTSg1x7O9tDWARHqQWamcBro8/zduHu0gnhb+/6?=
 =?us-ascii?Q?eAsq97TpH/yTssTFcGIHO54Gf282f6MeSXr6M6l2Yyd7BW0HTlcQ1mhBc+V+?=
 =?us-ascii?Q?FkXeLe0ZtQ1/7BFmYx4kM18wHH65PnPwr+25q5oU5eG0+D9+1pX8IoDB0+s4?=
 =?us-ascii?Q?8GnECDQo4YoB/npO0DbzZ+XlSwCb83ttDREIFnxhceKvCPSeKI9twAyUJyIy?=
 =?us-ascii?Q?7X4gjRP3aM6V358ZXVB9lrUmnKxPq64SCVUGRPlCc7S5DvmhB+4wh9GcYHU1?=
 =?us-ascii?Q?dhmnFc673aDt0Mpz79kFuzlMGmUGI1x/Hy3EHZim4bpuH5t+zBXE5JRhlTld?=
 =?us-ascii?Q?6grM0lZvn7WT/ouQ1hh4c0MHJb+Jug7dzQWEcuWAqWVtrgBhGTZfERZXNdO4?=
 =?us-ascii?Q?VU8xU0zfRA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9715858d-1928-40e3-faf0-08de6acdb2ae
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7928.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 07:01:23.3564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: daOHxvuDVpp94xWi/8dNa9wDNlq9bpH4kq0qxDfiQakNP0zaHfU0yXdk4QgeyoLmBYrU2hJmftV2Ol7RjzQczQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5846
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258571-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikolay@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: 912BD1335D0
X-Rspamd-Action: no action

Hi,
The first patch fixes a warning in the mdb_n_entries code which was
reported by syzbot, the second patch adds tests for different ways
which used to trigger said warning. For more information please check
the individual commit messages.

v2: fix 2 typos in the selftest, no changes to the fix

Cheers,
 Nik

Nikolay Aleksandrov (2):
  net: bridge: mcast: always update mdb_n_entries for vlan contexts
  selftests: forwarding: bridge_mdb_max: add tests for mdb_n_entries
    warning

 net/bridge/br_multicast.c                     | 45 ++++------
 .../net/forwarding/bridge_mdb_max.sh          | 90 ++++++++++++++++++-
 2 files changed, 106 insertions(+), 29 deletions(-)

-- 
2.47.3



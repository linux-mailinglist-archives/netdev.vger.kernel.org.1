Return-Path: <netdev+bounces-258099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QI55CE5Fi2mfRwAAu9opvQ
	(envelope-from <netdev+bounces-258099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 15:48:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F7811C0D5
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 15:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 218BC3042469
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 14:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249F32F3618;
	Tue, 10 Feb 2026 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s/T/PedZ"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D280C2DF153
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770734916; cv=fail; b=EsTzx/PMNJD+kTZNYoYf8amNW6B9CQL7L6yn6OAxlrlPNSDXyURkrGjS4FarkLmctbqcMpvDmNEupF4fddoISDuekzMH+0c4eO/0F/semtGxCuOItdgR1WbY3Lv5ZiVq59G3IBjNTFl6ztJnm3URu0pHcqhFGV/i4+4JZiBRtVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770734916; c=relaxed/simple;
	bh=AWcTiI3UvJGZeK9Nge/0mCiIW0NQYNGcgrfd1TuZQ3A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ExZozDFRgcA4OWrXHN7B6ASklXg6VooI7txplg1ep8bIL7ie3nW+gDRd2wvc83LyN93UdhG92W3n9vAt542CnPhCn7GkIaQTadA6PNozBfm+8lQAVt2Q2e2pZsh7OhB1FVClozkhrjB5AhQzvp0vzG0J9ZrJ8Qy892AVIHd431Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s/T/PedZ; arc=fail smtp.client-ip=52.101.62.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNVf91WliPCPGQcqkU4+Q6d+5ALHLIMdAIpVH1nl8HhGMjhz1IEohkLGiUsYElaiL/OwHEfZWZ9xMw0WLJ0lSN1X+zwp3I8tKeQXV4xAfszmdunfIkbijNIHhlh1aYX09YsvFYhvCFb5fsXvumGVgZ3W+fuQMHNiOwre6xU5D2na2ExdotFejLeylzwH0qnXaA8r++NRzTXiEs1Y4B3J0KqUDfxbd/hXeB7CZ8JWU5wET3BatN+A40RGNRMl32jC8xY2TP5bSRrjvJLTePAIsp37Ni3Wc+5yse9fCjnuuJ/U7LLgRNuczyHe/iQ4CPeUnx90NZiIf3pEGMfgAFjohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpmoWDvqd7YJP6GJbf8ZQLpXkmFHrfHcdz1L7K6W4kM=;
 b=hFj2jbv2GcTTEWUCg/oonEDH5UNPnjpErjhxemHu3ahI/22g3Nz82VLC//kMxUeRxO0CnVZ/+kmdSSMcucWZjve3rW65nj/KywIQgG/l4eJgNXdfHffZ/tQ4piDwPJCS1Fmgrvd6f7ro5KHcNgLqlRRkV0+JJ+xhheXMv0/ONjf7GYuTbFWo0cJDk3ryxfZFL9w2j7ALSdiQrLMzS/owCfyJhTTGPDk3aJJSBLnDjm8e+SCJ02JsxgVytW/LJ4KK3sJcDkBzxdLZchDBvuE+Gs94e0Ow/nOCK5OrCl3wex8iVCjKe3X+d5UIwFCEDGdv+i46siQ3oqFKDyhsEdRdng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpmoWDvqd7YJP6GJbf8ZQLpXkmFHrfHcdz1L7K6W4kM=;
 b=s/T/PedZg6q1APYO0Y2saMnMiExAm5r4LyQbj9rlAjXHJuC1e46uJYsRpiLMRqoVGoktoAR1yNawaOm+n9wJM57s6GkHyNi9I5FKmZq8jtpIhtRUkZH16BKePGlxx+yTpFGUiNA3FVftw1MOEl+cu0ZyLf9pPT+pT+x0ZQsNhLoatnJVOnYA3CuxUBUsmjpE6Bl/fmf5bW3sB1UPW4FJ88Km9Gh+wt6XCnDEQ09goh0F4/dge8C0epFms11QLCdKSM0GzbmE4GHiMerYYJlaOREJcSaRlfHPFzL7NNcvv5a7m5Uzpq59KTN9H5S2S5cf9TaUFUc2ABQLG5jaaV9rfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13)
 by CYXPR12MB9339.namprd12.prod.outlook.com (2603:10b6:930:d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 14:48:29 +0000
Received: from DS0PR12MB7928.namprd12.prod.outlook.com
 ([fe80::5420:4724:4733:9abd]) by DS0PR12MB7928.namprd12.prod.outlook.com
 ([fe80::5420:4724:4733:9abd%4]) with mapi id 15.20.9587.013; Tue, 10 Feb 2026
 14:48:29 +0000
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
Subject: [PATCH net 0/2] net: bridge: mcast: fix mdb_n_entries counting warning
Date: Tue, 10 Feb 2026 16:48:10 +0200
Message-ID: <20260210144812.1056554-1-nikolay@nvidia.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::29) To DS0PR12MB7928.namprd12.prod.outlook.com
 (2603:10b6:8:14c::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7928:EE_|CYXPR12MB9339:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f16d53e-808c-44a8-5427-08de68b37421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7bYA4xlYhOClcz9Nxspkpjq5C2AaXYWdRkVHFu9x1jN+80Eq3eSRNia6oW24?=
 =?us-ascii?Q?z8mFUvJWFKhAKORuiExpKACpWAEDc6UGDlGSlbaIexaGYcoyjFLqBBHcupxn?=
 =?us-ascii?Q?xcYwOiXjlEoqmYRwm7lEtDl8hD67XGHW4X2PbrAtphbKWjyWIonSFK32Pf8B?=
 =?us-ascii?Q?Iw/TBU/XC5unKMTUCuPdfAFs9WTDy8d21l1z15GhmPxGRlXwJBTFLAzCnGoq?=
 =?us-ascii?Q?URNo1hJM8YyWL/2VQKgVITj1YiIWxtn4+s/CXLkogd9QIy0JpBdm9EAUVZhe?=
 =?us-ascii?Q?Im05z5Aq2KP89Nrxc4hG3ONc3j97WJJFk7psFjQbOSDGZlJ+JZGsfiI4Pm8f?=
 =?us-ascii?Q?3AFTF91FRYA5NOGvxuRM3u8btkb8VtRDxK/FKCEow0O0dayv3pS7dB3Ya+m5?=
 =?us-ascii?Q?oUYUJiTiKmjW+tswT2TO5jzVBTkk1s6kkJtzqFTD8WB34VaGQPdt/Yo91nYn?=
 =?us-ascii?Q?Ch5gcp4OiEmhRInNBYp6FlxPOEtgWCvK+FK4EKwgvaBcuOwkSZvPp86DKRyv?=
 =?us-ascii?Q?UlckcPbekx9Fp79UFyLd5K6QxgPuems1M+rG+IOTPkgESJBETmjMUzYH/iWi?=
 =?us-ascii?Q?D1O5z2nR7SWairTyb4ZcvasbVG93ZQkJQl6u5AUBR+Hf1kYZUOIoDiFf86G9?=
 =?us-ascii?Q?BNMQ9UlsyLidT+I33OxjQUpimhrnFDpxZVKMWBlDDyygxFG7Elejkz6V8E8z?=
 =?us-ascii?Q?wWMnHXTs9bBaUr6bY6vTzKuvZoAoCSSzFXtMmPAVx0rXdjUd060jpMRZEExQ?=
 =?us-ascii?Q?sHpgvY5LSYiuW6/j1e/IWQF7HmO1Mwim7KvPMoU3JCFgzinKk2CBFAX0+n5l?=
 =?us-ascii?Q?xLixUSKTk6RM36q8FhqPgIJ1rEUnV//PiPW8snbzzqu+nm28E7bJraTUhAym?=
 =?us-ascii?Q?NZBS3qOTSxbA1awtuSeQHjyE6wU0IKgJgiz/05B88mYYG6GNVptWk0Le16sc?=
 =?us-ascii?Q?r0XGEgHtW8guQ5mvGDAt+V6fpGJpSLH6K3eEGebRQ1g4uuASpx71qimlPmYR?=
 =?us-ascii?Q?uqlSTmFmLwkzRgszN4aWulrXm1wd2YIusiGerGRT+RTwlv6JVMxSbAQ0Uv/l?=
 =?us-ascii?Q?3VI/iZqgMkxug+WQEXKOo+ReCEuNjts2NqJyb/MB3QFb2Tvs4FGJXTyuyd4z?=
 =?us-ascii?Q?HzsCoVfk24tYSjZiZ4IpceaJbrpauaCVXBE5KLTJPsWx3M6Qat0pOmE2waVW?=
 =?us-ascii?Q?S83lFd4oB831cO2YK4tELwTz70i1GmLI3XaYQmF7b3bCJONh5DB5XpivaHTH?=
 =?us-ascii?Q?p3lzbiflaKu39ljKC5rmfamBeYTJOL3fhqvi5Z7yCpyHy5ZF5aYmU+EadaVq?=
 =?us-ascii?Q?rRGO1wawbsWkelX34fjeOEbZm4hRxomsa6ZtazEHStkrUebqm0a7yUTJRcEE?=
 =?us-ascii?Q?G9a8P8bO8bKBX0knKH6zghF+DhsTnqaFP3WQi411vw9Ta6dDVbizJUM0/5U0?=
 =?us-ascii?Q?zDYV/RBvANrusUmyUVSs113EmHNE8W5TM6d+ax99o5uUaZANdWiSJsBIAia+?=
 =?us-ascii?Q?agvq69NmC3id1DUh8EvOxDkqvPsDl1PFl2NzbF3DnGP8DpJf0MDn/jLKx8Jv?=
 =?us-ascii?Q?PPVypiyPUGSDKzyijZI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7928.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fPEIweUOEpaBoQeNRE2cg4ltbAok92DZ8U/q5nOU9ZjLwvLtrJeAzng6pUaq?=
 =?us-ascii?Q?2OIORjPZhlgjXWcW5EilO91Egq8xyt+4IcUSdNypOYOMW32tAgo5BUELCD9x?=
 =?us-ascii?Q?Y25i+qzCvJF+Npr2J7zwYr09cLI2cxA14VCAt/htT1nWLwRpJXJxKpyNik0V?=
 =?us-ascii?Q?ybgaGdShOGrop1rBd8OWL8vGZP3X7S2wVCZoCaRYP7bZa6VOAt6EBi9EHj/w?=
 =?us-ascii?Q?VDF8LIwxTs5UEmjlskpef4Bp41TovjykNSoaB2ETmAMdnB+KDYI4QzZNgA6G?=
 =?us-ascii?Q?OqYlMJtg1cbFNUJkM+IG5qxMrdA7cbFPvoyt26TTzcLfLxTV+JAjjfFFOx8M?=
 =?us-ascii?Q?3gEPEZR+vbVaVOaITGz425vxNYFrUgOz3QP6EEso6h5PbvP4eXYPWu7geaIM?=
 =?us-ascii?Q?vHYhkGIMuELT2ytVbfTSRwIHN+zZ6vcKGpABmrahTINnoCG9CXVcqteBAGaO?=
 =?us-ascii?Q?oaevfF9XekwJkr4lExMWTwBiF8bmOcmsgpkWaUC56PFQ98JtrKK0Hsg4hw01?=
 =?us-ascii?Q?AdYH5lThcVnUAmp2IHVubtMxasnRzMlBlAzu42ZWilVNwygVbGLUphP7g78+?=
 =?us-ascii?Q?IZlwwXj6dqdJTcV0w0eOEWWdcKl6bdRtSmcgm+yKz8Htz6YrOLZApuOOyvWt?=
 =?us-ascii?Q?3+8mnhR00vb3UF38ZQCLHHKnRFOQv3S8WNEzoDbBfWXwStMm1NeAwHE1tET9?=
 =?us-ascii?Q?iohdQPI3rWsYD62VLzCqKfO1+m9VuywdXuNIibqUNeb1Of/vhOCdGakyuS/B?=
 =?us-ascii?Q?EkgGM6a5spQIHhALoZZK3SqTc+nFkKNM9Dsi95d4kX7eqWORkK+eJ/OUX7K2?=
 =?us-ascii?Q?vWVLgbfPHjDtPYKena3Xx1czHIa8pof6zGT9chjIwHuIpK1eG/W2oV0yL4sk?=
 =?us-ascii?Q?ZVdiFPO3pRxlvP8GYbNcnuvXo51leybymq4n11IdJHTBMgA6/4xFkVT1wfc+?=
 =?us-ascii?Q?cT4a8yoSjPQYJ55hnrPOzStbuu/mQuQDcEONi5jxf4TdWZRgYycIw7XBpkP+?=
 =?us-ascii?Q?LNGzAHPY4TCuJhY8rwpm5SLeTAqKwq4kZeiZf6v54Gvz8Nbg8vn/f+Z0m69m?=
 =?us-ascii?Q?gFHOMV3iVNGiDEz0w+D1sOykvxfCV84uJbpCfsCLHV07/dg9U4dZ5C7luB/n?=
 =?us-ascii?Q?iIKIacXogXfdbRU/9gWondpOlV+2+BtAeGf72UUD9Dfc6DiGkGKwtmZCiVDM?=
 =?us-ascii?Q?SecU/EVc6Uu6O4/rFVoGqKeZ06hsmAn0Lww75fJwj5Kozakd30kfm207yr9U?=
 =?us-ascii?Q?YW4NbnhI2htw4iCLsMa5Qw0glpT4HA1vTWl4n17Oe20l4WGHlIi7OAMkgKRu?=
 =?us-ascii?Q?03RwSpWbOKswbkDTR9tvQ4vlzlm+BIBH3C2Xiygt/cEG91tq6hmKSDhjE8vD?=
 =?us-ascii?Q?kPh40NDXvRdcc9CTXBhd3tHx8ikUy+SVjy3Di8ng1ib2MjdgvLCH0hpli5kZ?=
 =?us-ascii?Q?Vj5MhZu8s9CqacFytS0RnNmuyJtF75awhxQtN1pZH8DhVVJSmF1q7HLNu1W2?=
 =?us-ascii?Q?rdnCfZcpmdbnYJTr8j8czW7AFGV9q/XcVN1Gv6/VpUhSLRnUTiqY2NzVzi8W?=
 =?us-ascii?Q?VDnMiJX9eEHjhQ7y+GkIO9ferXwqo6bt5QOflu2i9P1JRwb0NlbPWVu4RBV1?=
 =?us-ascii?Q?eJ8/JBcVji5tFH4GBlalCzQ303t5U/qNxzmmbZtJLI0J/PN4EE1Ce8hizSdw?=
 =?us-ascii?Q?WgLYlrSP+3OsqYgsm42xV+UoMYnGXA4klnh7Pj3PuLTHo25y0YJbZ+LzA/T9?=
 =?us-ascii?Q?W9JiGIXwfg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f16d53e-808c-44a8-5427-08de68b37421
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7928.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 14:48:29.2798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OsvipeJTHGI4OcAPkiZXC4jqdP+G/E8q6hWLASWH94/qDcX2Sidu0U4zy36WReqrOcRDYzQGjbfVD6yvEmTpVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9339
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258099-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikolay@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: B7F7811C0D5
X-Rspamd-Action: no action

Hi,
The first patch fixes a warning in the mdb_n_entries code which was
reported by syzbot, the second patch adds tests for different ways
which used to trigger said warning. For more information please check
the individual commit messages.

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



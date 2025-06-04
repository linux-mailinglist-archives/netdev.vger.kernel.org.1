Return-Path: <netdev+bounces-195086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B632DACDE14
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 14:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFCBC174BAC
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 12:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62C828C849;
	Wed,  4 Jun 2025 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OP93OA75"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA82256C79
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 12:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749040436; cv=fail; b=Jcxj0A43+As2wjF5gfHLMj7XYC1/S1FSGLAr+pGLa9uW+eC5UMXzgvAZOhoi//ExphQoui18kAOq+zV5n0vFKnpYWtbBDnFagjLnvuxHwApPMIO+x5TNy/j3kjNUHt1YDpCo5BA7UxSKJlPD/ooQIb249Ttc9kkGOU5cHu1/wPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749040436; c=relaxed/simple;
	bh=nv1+4cS93NqTodjjnzqN58YXHljt2wVTNm9iCwHAwRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=dbMpiMXoaJ0eI/sp2s07oA+zXMK6YshOfpbxYdKWBS+uApZt8gMgK2vFZRCepvelMqoD2PCHorgaga63AezjX3WQv4bOUW5hy2dCvBgin+FFkMWZfY3GqlKBXIGYjKosWi5Sgr2DwkZY1osgeRY2HfBjWlM8FCPb85Y7FtdAJOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OP93OA75; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Exkt8lH3QYXYNxNQO4JEz8sL7JwR0+Tyb5z+higy5CcSQAcsY6JFvvlEB5yRJoD+cIE3t+Kpuyc7VVbHRtW36BU4JQf9qko++d/aY4Xfelhl/XQwxUL2N9t28mDagrPJcGSjMecMjguicUx6h9f6y4elZIyfvfJC3/8tc4c6zby3jsF4zzfiu4fg/OoeM+ZuzCoZQjAb2/15rTJNIdjQ+GZEJzOwX6jMRLq6BGu2GCHZOe5e3GHDj/cffCXxC/Hjf/wbLfopfVBnl/cSq/NCeHGJEEoTFXebWPl49NIKED1ew+8ms5B3WWuHZTPM6hy0KHxWn5z7d+3piK22e0S/nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nv1+4cS93NqTodjjnzqN58YXHljt2wVTNm9iCwHAwRc=;
 b=jC03oyvHz75P0Kdr5LcNBKbYkAYOPzbKqnCRQ0PjnO4wSxoGfkHnHjKgnxS5hUCA+myvpNFrC3E20VuPj1SEq+0UeSU0bhQU7M7jeU1ARuwcsa2UPUpgNeVsZJiN18ybBSBhLZcpxQYRgXlK0JB9SWd/C0KTqXm7aSLkALHxaorhwCHNDscsbsk4YQSLF+kxKh/RF7ynN1+H0PdYyUky5PW7U4WK65bXXpEM9piJ6JSTFqz6WXQRvGTl2W1YW+BPD0D7CAiPmnj+RS0jtatbbkyPQkq9bvOBkA668wZJaaZ/8cUUf4jS8aOXSFxZWNPK5G9JXMkHtjvh3semrDa4gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nv1+4cS93NqTodjjnzqN58YXHljt2wVTNm9iCwHAwRc=;
 b=OP93OA75sEobMKg/yNgWi6j8lMNsBpf8x2UKBDMAFecQXP8RqkDrMM+kIlgBfouK4NhuRy/zg/LPcScw2hFvePEu+BsS7Xm4szaFoQ+gX6Ib1TH7EuT6ytdIMjQ9eaX9XhWsWZD+aZ3xyaU+t6mlGdV7OXwkCbmyqYbn7TpxMfNhFi5tbTdi9nqXeSbLeH74RAngc5YvBth6ueAVeJ8UOa+VlZ3sCSrQKb/yuHaTX2VDBnr9ZMxTsAtFNi58x/+0KeC9/Ljq39EzL7Sj7V49eILaAFnOgbnTg9lUSpDJm7IZcNgC9mzAiUXVQI+gS9vqNWvmk6YjL1IMbj/4Fb3RaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by MW4PR12MB6974.namprd12.prod.outlook.com (2603:10b6:303:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Wed, 4 Jun
 2025 12:33:52 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 12:33:52 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org, Boris
 Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com, smalin@nvidia.com,
 malin1024@gmail.com, ogerlitz@nvidia.com, yorayz@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com, tariqt@nvidia.com,
 gus@collabora.com, pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org,
 jacob.e.keller@intel.com
Subject: Re: [PATCH v28 01/20] net: Introduce direct data placement tcp offload
In-Reply-To: <2531psgzo2n.fsf@nvidia.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
 <20250430085741.5108-2-aaptel@nvidia.com>
 <CANn89iLW86_BsB97jZw0joPwne_K79iiqwogCYFA7U9dZa3jhQ@mail.gmail.com>
 <2537c2gzk6x.fsf@nvidia.com>
 <CANn89iJa+fWdR4jUqeJyhgwHMa5ujZ96WR6jv6iVFUhOXC+jhA@mail.gmail.com>
 <2531psgzo2n.fsf@nvidia.com>
Date: Wed, 04 Jun 2025 15:33:48 +0300
Message-ID: <253y0u7y9cj.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0019.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::14) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|MW4PR12MB6974:EE_
X-MS-Office365-Filtering-Correlation-Id: 091242a6-d668-4ecf-38b6-08dda3641071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IrMSoRN67VdoDMYevWZUG5RBF6jEYkTu8c/JHHAT/3FQubPZsza2kzCObKGG?=
 =?us-ascii?Q?RkaSAF2mWe1OSyP8QDX/9q0gJGtaQvzvb40t459OiDRkOfAiHO+I5eKFDB+Z?=
 =?us-ascii?Q?3e1T5xtWPWCeJcRYkzLXGytPiO8XAEbaZkl2Np2HhLitqAKjKSp3LmEkeZ8P?=
 =?us-ascii?Q?K5yIJoU7hWtpQpXu6VP6ek80LOKdrTsTk16xN2n3ikD/9FcdOWp14Voupk+S?=
 =?us-ascii?Q?DlSDvGAjvF/FAQSi6BznY1+SRL5oppeIf+WVIoa2xSwdp6wcxkryD6/XyIsQ?=
 =?us-ascii?Q?QSSLmNCBOj9Z16A0kRj9uFcwfivYDKs+cNplcp+bFm377edZHua/9qh5C2QG?=
 =?us-ascii?Q?m6C1A79fqEZsl1Gnw/6cQAwKFB485vZSNvmJV/6ZIO8RV856aMllewQq2xkC?=
 =?us-ascii?Q?lsL3f/ho/1UnHGlif7PLMbqvJG4d5h9kQPzM4ljhLNOsgcZzKqGy7nZO6GLc?=
 =?us-ascii?Q?Vi91Rwoi1FCy793U9pZCrzRAbolY5bJuqd8pW7VRaHjVgIYVyCGIkEZbUB09?=
 =?us-ascii?Q?SN5irF7k8uKN0EmHspVuUw+zMow9edNMT7oFSEAwUaoozB5C+8PqFLo4hd1C?=
 =?us-ascii?Q?OqBC1j6SE1OmNf2tuncevkaRRuQzVuc0UKkaUrtdCZIG0M1iSHr4DhlYUFSw?=
 =?us-ascii?Q?gJoBL8BzfkaIy7moc1msYftIMznqMTRa1nhZha7ceJWtRg4b7FENwM1zQuVM?=
 =?us-ascii?Q?BdHd8Et+Hs1UnIIr8kD1599D4v90dkzUxj1kUlvBhQuvQmuPPq/M62of/y28?=
 =?us-ascii?Q?XqQcimsU9rnufiF1D1hUqBeknNvKGae4AFY0uCstVn0SWFMpLacCAi7gUN4b?=
 =?us-ascii?Q?RlSVg/3adfjjtlLZWlHMpT+LwWszfd4imOIi0BH96KM3vNm43WQEV2dH+yf0?=
 =?us-ascii?Q?MC5XOAkwCvsNRyY88efys7czxAMzhxyc0wiWEBHL4+nyUaidzFfFzP9QeUyD?=
 =?us-ascii?Q?2NSBWVGOAlEDk0kCcXLwtl94SUVgU4JvISq08WCUsZlL4aqNjKy/P/5OaAha?=
 =?us-ascii?Q?IIzBMNQVzMLC3d5rV5hm4rkFECiXj0LJBMVWIJHDB0Ctxz1SqhH0vfTSmW4i?=
 =?us-ascii?Q?UbU8Kk+z1mTxMFuBRWUs5b6qiOVHIhboAGDNhwRi1dd8DAWu0azSN2LXDCyQ?=
 =?us-ascii?Q?GffUouYdJBC3W8pKEO+KRJC+NJ9X8alo6f15D1knYeArhnJEaw8G9pmmm1af?=
 =?us-ascii?Q?fYymuUgWX3bRCa78bO5ltBpylBK2yR0oXQ520L3vh6jN/e5lJ+7knjxkgFZO?=
 =?us-ascii?Q?UrHy2EYZsQKECclWbUTYVZfBIuJnYzCyuvd7NcSDarZtwt43rP0UxaJDDvW1?=
 =?us-ascii?Q?lVhpmoZ+/XRFU6i8PTuwQOn2SoxkaixZ7NW4o0YqW+zfp83jKW5C9lit/LXA?=
 =?us-ascii?Q?jKDM7XcbEGg1wIFgNuX2MrzNvbyFlHQVb63hWlkjvXJtWIPADV22JBzL4x/2?=
 =?us-ascii?Q?Onvw4GF/iv0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V/kKuzmaymKcDIOo3LZE/2R9JUTBll4lHi5SfZkaCIlAebz6Hudrk/ms5wM1?=
 =?us-ascii?Q?sGhfocomWaXwDRgQQTuoLyF1bPI3kL8GeEPaEqHZ65gZVKGhaXuLHiuF1CNV?=
 =?us-ascii?Q?f9rAILKBgkSzHILUTIj2tt9IWWVl4Ikzkzhrn/8uqdgEgQb3eIPFBl8BA+M0?=
 =?us-ascii?Q?BmfBkjpvGixvcMrxJBRMiRsrf5/kl/Sehz2CVRPnU5z4V4MUNgwMNKZbsOS8?=
 =?us-ascii?Q?fUegHMIxY63aVZLx1IN66Ura/Ii4oYHUB1GUOxOpbM0lu6qZCrvvHV4lE97h?=
 =?us-ascii?Q?asHNNvIfHiZdYY1g/DC5gsRQfE5vE+NcbWq1bt4AZgCxblTv4c8sjTty9Wgt?=
 =?us-ascii?Q?WsJ/d6DFARAPCJ0ozzRKUQJXygtDCCm14upY6yQMuR/xAdTXoQWspT8XbFuO?=
 =?us-ascii?Q?cDTFBJWR4Who8aKXOpk64F7suwwt9hJ8YARQfkh+NX15wAFogKrwpNDBlGWo?=
 =?us-ascii?Q?gzqZZL6zZCrBTg+m/FgBxVwmtI60lBhgFLmMAp30JedPxnr0klSJWzYSO0Fl?=
 =?us-ascii?Q?nhwZ59lRu02t7gFZuOTTPPID3VCGBSPzJ0SDn6JgWXXmdhi31oFk836uLbP4?=
 =?us-ascii?Q?iTyiYzcgGiCtr5onra/T5U4y7pfExRf6n2lL30oW8g6W1RGE7fM5NSS33iFz?=
 =?us-ascii?Q?N0vC6K0ToLxvquGBURno/O0xiVpGD3QEFHhCunIlt99HHdyXdsEtARUeZrmO?=
 =?us-ascii?Q?HcJXMgS6NrUtpwe5NQ1vsnP3SaOmjEJseRInz5GpA/gBU9ICwQzjH+RDOuQx?=
 =?us-ascii?Q?+XrLhukR9YYR2zb6lS7R0P306s53uUw/QfMdEE+JFOGaB2LXkx8ijgrE7CDv?=
 =?us-ascii?Q?/i40v6UmuVwXsRiNuljg88CsEzxfrbPuKMkXxfRabMM5aSTKz28d3Pxxqixc?=
 =?us-ascii?Q?OICoR47vxEyOgyoUYFlDbAO5IQMSFe+Lt03yCUgaywhsfSw7MTP3ae8/XAhJ?=
 =?us-ascii?Q?aBz+H1pbnjJ2X9C8lFFQbT8amj/cMmuhPD9ZRFXVdyln9DH/FA4M1SlqYBXK?=
 =?us-ascii?Q?4qQ4q6dYtdrABOMRl5HU1Q/QJf2/TbNZm1mtx60juXAs2byE3QrG/c6miVLG?=
 =?us-ascii?Q?LZDtNIe92urbnTvwcNcEwQHymK/BXdhY8P1ORc0pLO6ZfjPQtheD/hRFQjPB?=
 =?us-ascii?Q?XOMOCi5wC4MestFO5THXfAZjImuiB9V0YVirFPfqoWloNMv9PJwbaMCM6JpC?=
 =?us-ascii?Q?sFadzZwqD0uiAK2ubNhc+NNvpk9ihCk9XmwiTMtuxnl5Xcxj6h6aueLa/dTQ?=
 =?us-ascii?Q?og9ZV9HPw/VJouUuqi0S7aLKT+OfxN4z+0ka+XNJRxn3qlua5GXDFDJrZvhN?=
 =?us-ascii?Q?cGLRA32Elgheepw/5RfZn63U6l/JBGigbaD38HN0FbT64mJrmDYUM5d6rdNE?=
 =?us-ascii?Q?KsEgIK89QrbU7w9QdsLd8ViGwhVv4JrNQXWGXj4RVfsK+pnHLGISG9pgp9JY?=
 =?us-ascii?Q?rmGuRUaQ4iEHUb4kMRg2DW/CqnAkgbosNMiuI+ifNvYdXSlr4i+TmhAwN6ZI?=
 =?us-ascii?Q?9c6R21jNeb7JR9GTf8nD/6CWR9BGuMk6BfF2Ts//LSx3u4JXsiKZa91RSV+t?=
 =?us-ascii?Q?LR4y1nJLHW8a4iMU09XZIwWng2H/K9/jV4NQuRxv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091242a6-d668-4ecf-38b6-08dda3641071
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 12:33:52.6389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5XMPoX5xKyxOB8LSYg8npROvD7WL5C5bSLrch63nfxf69PWWougXiK2YhPz2IbXK2vtmAOk4J6M1AM1jqLwChw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6974

Hi Eric,

Any comments on this? Maybe I can clear up something?

Thanks


Return-Path: <netdev+bounces-281440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLgwCjOp72mpDgEAu9opvQ
	(envelope-from <netdev+bounces-281440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 20:21:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CBF478774
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 20:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A155430086B3
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7283E6398;
	Mon, 27 Apr 2026 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eVj4ka/t"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012019.outbound.protection.outlook.com [40.107.200.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F3B3783D8;
	Mon, 27 Apr 2026 18:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777313409; cv=fail; b=AsR2mM6qnPaq9dBjq1nmVspg3/n/nt2GgVp42NWXaOHdhcfBE4dSRffGWDNnmhyehmZ8osWwsTxwWiSLq4kzJI0+oMZmDZzxpY61dHvynX4bbpkCPmO5Kuyp/e+axvqjJ7zc5E8bBd5XIMiPCHSg9KBsJvPl0jAB9w3GQxc1oHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777313409; c=relaxed/simple;
	bh=0uaVteh9hx/7zDlQZO3FREYFQ/q6RXJWA5ozMDxnHZk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A05TsbwB6Oms1Is3SLp5f926oWo4CVt/KCBD+efTqg4Kvoc1ZL1KN1R/QSbUycXo3dPPIngRStGXjxja5MzhqGYvslW+y1nYgPbyNjwDNcu4RYRPAZvhmngPwnhaTK7ceF67gVZKEOlytXuTcp/i7Es2N7FXmwMPNgsjUyqQ4SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eVj4ka/t; arc=fail smtp.client-ip=40.107.200.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Axxl9geHjlWJG0F5iiajwnsJ51Wr5n55IQerc7SWduLGA/Qj8e0WLVT5ogpub0g448zZaXey2eRZvqkVT3EoddlJiOmuGmpS1s05YOw8s07tr7BOSJcr70dPgS657FklrKaTtoer7MgaZw7vyFJUx/O/IccE/83FM72KoWlLjfmJgOrsqIA7soowaU7mQ+dtvjFzjWZ5L84ITw5uuNvw0fSUQUZqgi+PeVU5AeKLJBTG8pfLi+UBKMyH/KuOD8qzAqLAYlQUUu/qNTEFdh0igTPuzVLlXMdgAfc6EU8ybjOvcgOo0L2iUurgq45N5/FWaU1DgD3wiN4uXSEWIBkMTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/+Z6ALF7viIqtE7+GOEKb2zWFB9X6FQrzLGWLBiD74=;
 b=OqGQMb0vuB09GBp8RxF6Cx50q09tEWRDPde3heg5BrSdeKPgyscPjRkLfEcadbtFDVTWjkj5faCaAG/tFvJYJ7zHXf2UkMTQoael9b+V+DG3daDKh54B7SSRn6d574VfnHl+jL0mPUmufCbxzsrg87KGEsPvOrRvSPszn1naohcAo2BGAJJpVi6gJSiJdVfZ50bj9vxZoMUJg3CsEzPKMiXHyxsNWtOEN0CRUGY28UCiuuoC0HdojSPqWCpHXIeY//z76jGr+Ym+UKvJaKG67fpWkR4zaQTTTPsbxIq+UHsN+wnqw98dfLixLlxW0qf/PQympT3iEPmV0AX/SlNynA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/+Z6ALF7viIqtE7+GOEKb2zWFB9X6FQrzLGWLBiD74=;
 b=eVj4ka/t+wMi8wS3sKgHvb5cIqNnQA3zqtb2E0AWvfwbToZEVbkOWcSSCrZkqZPlwzjX0G461yXU3x/AIl2OoLosP3wD09Qq06ah8JOzewdtV0MHPlomThUVJ+qcencAd374RXeNVQhcMwOQOUt/I5h97l5Ed7Y3vdh+pppwKvdFI3T976vlmNKVWoBSUc8f2p7NmKGkHn5TFO9XyiNWbVHtziDJJCHNfMjcBHVt5l3RUSvDpKq5vqpBN7uJ3QpsMinXnZqTW7BQAA3/nPeireGu26MQQ7LnQVRAZVhs3VkpAFUT7eQlhcM1BZ/lyjdNON5UNvHGjjKvCL2JwnD5Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15)
 by CY3PR12MB9655.namprd12.prod.outlook.com (2603:10b6:930:100::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.12; Mon, 27 Apr
 2026 18:10:04 +0000
Received: from DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385]) by DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385%4]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 18:10:03 +0000
Message-ID: <5293b717-6a8e-40b6-bd6b-61043a062451@nvidia.com>
Date: Mon, 27 Apr 2026 21:09:59 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] aquantia: Sunshine/Moonlight UDP video streaming
 broken since 5b4015ad833c ("net: aquantia: Remove redundant UDP length
 adjustment with GSO_PARTIAL")
To: Matthew Schwartz <matthew.schwartz@linux.dev>,
 Dragos Tatulea <dtatulea@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc: regressions@lists.linux.dev, netdev@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <6c3fb15e-711d-4b8d-b152-e03d9b05293f@linux.dev>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <6c3fb15e-711d-4b8d-b152-e03d9b05293f@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0023.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::12) To DM4PR12MB5248.namprd12.prod.outlook.com
 (2603:10b6:5:39c::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5248:EE_|CY3PR12MB9655:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c5683e-d9b5-408a-e4f1-08dea488348d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wVLlo73l/MDievVuTgx5VQRkSyNbQYE6pM3i11uAcr3EclC1riT97XDbhi9vwGLWJhx8YJ1PtKRL3zg0MWHsTKAczR6+PCBL6EpfdbIrUfd4kLw6l114ZD/vwEZwvaa1YM6u/e5eE8ZLyoW+F6/5VW2DVMBJM2J54qx5+tkZ0dOS144d7AbNm/fheWocJZSaD6JcsQuCGkVS/f+tNwCV0yMy6dN5GDtTfOeKCVgdn3Y8jfI4UTTQnrgCdQ+JD8z6esNJEtmyQGV9B2U5v5Hy4zIdhZev7xRfJ2BkYCA+ndpAzR7K0cIWnIU8fo0AN1sWfNpufVRCFglo3aZLdTwDX4j9uT9qN/rYlkrvPfjFvDm+/wdsxtMlGwHJ1oQ3YHsW4S23O9Mo+COT4e69lS5ENfX6gcC81rnlHPA6TCRPyI4mpG/+OKhP8ABhNsWtihkC1F78CocwvbrbqICdH2G8ee1Fg+jjBj+lglghSAelMR9u6CWhfju4McpWEG4kBXszbVz4GaMnRrxpon5FS/ifkcZIkGH9CDptVW3Tw5luG+mPiffBMhNa9wOM+oT9zcx5kBbyg/n/t8dq0rS/mhs8E3GyqQdqymQ6bdfXqqLQ5gvvQRkYhcmfYbWJch0SAF4NXXmPdEFQH2Z/eQ2vit9mCf9bEp2ArGtAmw/0i63vX2lLN7nX1y5XLAo6qllQ7ebUeN7lm4cearBnrS9710x+VzdPIaD9759sMuysRu1Vp8k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUZuTk9mcmJFRWZ6N0VOQ0Z0V1lFZndJWjBRUUtoc2g4RnVVUWlnVWNHZnJK?=
 =?utf-8?B?bEMxWXR5djFQYzN3S25VUExxSzhLWTZucEFoRnNzdnJ5SEUvNk1ZRm9hM2p5?=
 =?utf-8?B?QXQvRE1HT0dkUWRzYjJKZDRRK2dBRFMzbjBKNEhwUml3ZkYxc2xGZ1l0dkd2?=
 =?utf-8?B?Vmg3MENBajVkanJqVDd5QnA4UmUrd3lnSVQ0TUM4WDRsM0I0MldrM1p4bXdQ?=
 =?utf-8?B?WTFXbFYxVXZ0VERWRllFYmtvM3Q0UWxrcGJLT0k0dU4ySG16M2VoMGtJckdk?=
 =?utf-8?B?bSt5YTkwYzlzQ2R4YmE0MWxpNnV0T3VyM2pCNllIeU5uangrZEVKV2VkTEVB?=
 =?utf-8?B?Zm9WcGdMMXlBeFFrUExaVWl6QVVNVDliNjJZZ1lIMmxHYXpqOXorVVVXQW5m?=
 =?utf-8?B?Rnk3SnEybXVvR1QzMURzMVhXZmtTdHByNHJDaW5OcVJVc1NQYTE0aXM5dkNu?=
 =?utf-8?B?VlNOWC9GK1k3OGZlaXRSOW1GUXJpTnBzcENYb2JuMGVKUjlVZUhScXFvVFZk?=
 =?utf-8?B?dytBbXA1R2xpdGtjb0lnQ1l3bUh3djFLQUhBaGtlQ1VzcnFSblF1TXdkS28z?=
 =?utf-8?B?bkkzdmxyYzUzT3haaXRvKzRYanA0dzZRK2lxOW9MNTlJWHNRWklkaUx6a2Mv?=
 =?utf-8?B?S25TNG1McW9KWkV2ckRyZ0lRWUQ0dDc1bjNqU1V4am9LS0QrbG42SFVqalpr?=
 =?utf-8?B?aTRTcmd1MlZZVVJwSnlCOHc2OUZLdEVraytmVGVIYmRhTHBGcjVXU1NJQmtj?=
 =?utf-8?B?bXJOVWgrNkZwNTgzR3g0M2RYTXgxR2I4eng4WFFWTjV0ZzQ2TWphWEk4Wm5H?=
 =?utf-8?B?ZHlEQldzVmNRMGN4bXMvWG1WYmg1ZE00aENyYW11ZzNrcWFoaW9GWDBWMVZO?=
 =?utf-8?B?OWJmSnkyUlhwbys5UnhidE1MWmEwbDBnTzJMTUR6Y2R4Zi9CdE8zc3ltR2E5?=
 =?utf-8?B?THBKNThHQjhoVisrR3NGK0dtUk5ENHllUzVyVWxBanNoNUpWK2RFNGgvaThK?=
 =?utf-8?B?L2RqK1BhUUpzQ2FWb3QyamdaMmJRWWx4N0dLRDhwRFBNU3NjV3NLelNtdHJI?=
 =?utf-8?B?VVh1NExuZnBabDZHWmFtWGw0TUNnZTk4ZUJ2WlByM1VCR1lSY0dyU0J6N3hE?=
 =?utf-8?B?c3Y3ckNuc3lqbWZ4ZXM0S1ZMeCtpTDJmTFpxN0NMaThFcE5BY2l5Z01nN1JP?=
 =?utf-8?B?ZEEyV3Y5QTNKU1NXWU9TQldXdXFYS0Y1a2J5VXpvR2cyeFFOTVVQUzdQMFF3?=
 =?utf-8?B?UjdoVG9hczZUc1hOMTRjcmxBM1V4d095MjV4OW1JWFB6bXNadnUrK0JGTi9h?=
 =?utf-8?B?MnpSV3pCQTVhTWtaMXZUdzJnd2YvMjU2QTY2SHZNUU9Mc21STFg3c2RIN3FG?=
 =?utf-8?B?VFE3NmQrMzROcGdnWitRTmFnQ1pZVzJQRjBORGdBZHlHc1BNb2grUzFLQjhG?=
 =?utf-8?B?N3VOejl0OElYYXNQdlZ6V1lYRTE0eTYwN3FJLzFPNlNhcGx5dWVPMzA1VG82?=
 =?utf-8?B?UDFPVk5vVXRiVFRWSTc1SkFsTkYydGNNSmpjZzFpT0hQT3kwMDg2d1p1UlRV?=
 =?utf-8?B?ZmhJd0dXQXpqamVWQ1ZIU1JldWthTGozMTJGdlBpdTJpZVJqQzQrRk1IVzA4?=
 =?utf-8?B?OTh2SXNRNlR6U09SWksvdnN5eGVncVd4MWptR080eXZodEd5SHZ4RklGbjFm?=
 =?utf-8?B?U2pSamJCZzllQVVqbWJ0Y1pNQ284MnNoVGhIeTJwVDR3eFdBK1YyLytqbzRr?=
 =?utf-8?B?UkswaHM5R0FvOVNTOU1QRlk5REt6dzV0QmwrMDc5ZlBHVjhMZUl5N0hLZW1E?=
 =?utf-8?B?dkxCa1UyYTNUbWI4MXBjdXdNeHFSRzFPbjh5TldvQ3czd0Q5VVBzZ0duM2dy?=
 =?utf-8?B?VFkwVk45djVyUUhvMlZFS3lJdjJBVWUxYWZTdXgvUTNrK0VXZC9yZkZ3THFE?=
 =?utf-8?B?aFA3MmFxNEt0dnR4ZGprM1UxOVBzSEcwcEt6QTEzOTFTQ1pZcWRaQ0cxQ0Rx?=
 =?utf-8?B?YjRkWGZrejZtcXhFSE96VzAwSnp2NFlOT2RqOTVOSmc0eEFuQ2ZqNnEwKzJI?=
 =?utf-8?B?MGNnWnNYZU9qRDVpU1BvbUdvc3NoZmRjYXVLbnZhemFYT2hFVUQ3TmF5N2RR?=
 =?utf-8?B?S2d5OEd2UE5KVTRCOHZYVldiVFRZM3R3M0R2cnczRjNQZmNZSW9hbnNXbmVR?=
 =?utf-8?B?TmNmK0JZQnhVRldvWjZNNU5BSlpGc20vcE5rNmVUWTJDTmhSZUF3dWRNYW0r?=
 =?utf-8?B?Z1ZqbkpldkQ3V3pGZHI5QkJ1bGVxQlJ3cCsraFNtbVdQTzZPYVpFRHdHYTVV?=
 =?utf-8?Q?xSRNf4dU+oiLCz5x3q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c5683e-d9b5-408a-e4f1-08dea488348d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 18:10:03.8736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZvlbaBdsXVbkkdto49zgTffd6/0buj/bngSDlqXWX/pQH8SlwefKNoWfQxBXrbni
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9655
X-Rspamd-Queue-Id: 43CBF478774
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281440-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim]

Hello Matthew,

On 27/04/2026 2:20, Matthew Schwartz wrote:
> Hello,
> 
> When using a previously working setup of remote streaming from my workstation to another device via Sunshine (the host server) and Moonlight (the client app) on my home network, I no longer receive any video output on the client app after upgrading my host workstation to kernel 7.0. Reverting back to kernel 6.19 on the host restored my setup to a working state.
> 
> After bisecting, I landed on 5b4015ad833c ("net: aquantia: Remove redundant UDP length adjustment with GSO_PARTIAL") as the first bad commit. I confirmed this by moving the cable to my second on-board NIC (Intel) on the same workstation, which restored video output without any other kernel changes. My affected on-board NIC is Aquantia AQC113 [1d6a:04c0] (rev 03), atlantic driver, firmware 1.3.34, MTU 1500.
> 
> Looking into it a bit further, ethtool -K enp97s0 tx-udp-segmentation off also serves as a workaround on my Aquantia port without changing to my other ethernet port. The working Intel NIC reports tx-udp-segmentation as "off [fixed]", so traffic falls back to software UDP segmentation on there.
> 
> Please let me know if there's any additional info I can provide.
> 
> Thanks,
> Matt
> 
> #regzbot introduced: 5b4015ad833c

Thank you for the report and the bisect!

I will take a look and try to figure out what's wrong (though I don't
have real hardware to test on).
Is the userspace app open source? can I see its code and try to run it
myself?

I will be OOO for the rest of the week, hope to have some meaningful
reply by the end of next week.


Return-Path: <netdev+bounces-277129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMeNC44d2GmZXwgAu9opvQ
	(envelope-from <netdev+bounces-277129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:43:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD253CFFBD
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 984BF30138B7
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 21:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9150F3446C9;
	Thu,  9 Apr 2026 21:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="t3VKkscH"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021134.outbound.protection.outlook.com [40.107.130.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF4F40855;
	Thu,  9 Apr 2026 21:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775771017; cv=fail; b=kIpVkW5C/Qi/2SY4WZv0asuM2MrXPFohjt8QvZo5XtImQJzXSuA8kAJU3t9Lrc5U1ERuDhU2Zy6eeM+F/Ad6gpUHtgS7y+eFyHx6nAKpMb3n75y6f21B9uYZ2cegspuTBhLgi+4xRrK6eA1Whkxvny1rTxaGu5xvfLUGj9q6RRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775771017; c=relaxed/simple;
	bh=jdP1HgnFUID8sDQ4Nb/qDbCahLkoBdlr2BM4HwKHrwU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YOGdp7QQBkUw/IIFzIk4l6UjZSv351PN4YRbXwU9VI7jXVTptAklqlTebKnI5+BaKuLbQZLbduyirCpLekGJp9AsPPLV/xrtVXLrxw1h8sRmEBDsSCVSnrfFmykFPHQ27TyofVHxCYUtKCB8ri2UFbF/RucpJEwoJFosHOkjXTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=t3VKkscH; arc=fail smtp.client-ip=40.107.130.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlMtCfIcL9abqX7RNJ62sc4ZqCaphmumnXRTW58u9+UUgPPF4X/rX1HWQ7By9MV4BT0Ci07r8X4E4zDoPmx4Nz1UnyJLT03Er4NppjBAO0VU+uxF46ReR0cyAZNAaeM/Y6kBmVzZBeAm9yTrm1y2NUk1Um7/H9B0jUyk28+IXwyFKWX3zv6oaPZWNeQafE3BBx566MFPHUPuHWrp7z40FhsjI0ia1GNFSxjhe94ZzsE0U2RtFgMl9sGjHl9e20tR9A0Sv9F3XcN0WI4vdo7IGqLDg9wBtlDgNQw+KmyKfVCEtqFTo0tjoJnp/kxi/vzbo9UKzlN9W4myY7F1iqB4yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Pbl2Iter3uBBJb3qLxV2joIepzlijG4FvKAIZz0qrk=;
 b=BNVXye1GldNCbFV96fB3utM7d1IOkh1H70G++4PcnkDOMrQ4pHCWo092qv91xL0MwLTbA3itEtjWtK0GS7fZnBTt5z8NdxDV+0vJjOLWA+w2OjG6LWlqM02J3pNs9tTQ6+q1uIOU56WU08QML27YRBEA2Dd1HWcvWeQze7NuEuQYVMoO/DEF0VX9UDH2jocH4m1rsKZSYDcK9J12r6bnyg+IdUaIkVl0qcS6sgFaBLxq8CK5oh2oLYoKB5Q8hWBOIQvrRCTl5KXcf4nEz5C37MRWGNadp6vUMYaMN3AhGSq6KiRea0w0cU+Onszuz3LysSlwad6VNTuztySphfLhPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Pbl2Iter3uBBJb3qLxV2joIepzlijG4FvKAIZz0qrk=;
 b=t3VKkscHlNuGkXBCihhkXmPII83m2NcJ7s/gRXPieV9GjlgMDDiVm3jbKwVP+4B8NGxjjVI1dXNo91AsCOEOWM3kun50XMhvdQuf8oB+23D/Smw/H2CjfOdUV8wfEY5Cofl8/6uUFItkrlX0nSyZnRop9ZqTyoGw7CUdXhWbnl+/i1+7b1NTxLH53ym9twxz5fudRUJN3m+Jtiz3UWkSTpfQlATaYkUTSjNId0dKUQqZVissYPStQxd4lVOQ54DK8KMeLxBQcMaQAk6iAaWXQQthXSZwxy1Fqahwq7x3FVuUFn/fhf+gb2pwvh1A4eWRKFY5ichUKkAsVpTvsECt5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PA6PR08MB10708.eurprd08.prod.outlook.com
 (2603:10a6:102:3c7::20) by GV2PR08MB8051.eurprd08.prod.outlook.com
 (2603:10a6:150:79::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Thu, 9 Apr
 2026 21:43:30 +0000
Received: from PA6PR08MB10708.eurprd08.prod.outlook.com
 ([fe80::1999:c6db:dc55:494a]) by PA6PR08MB10708.eurprd08.prod.outlook.com
 ([fe80::1999:c6db:dc55:494a%6]) with mapi id 15.20.9769.041; Thu, 9 Apr 2026
 21:43:30 +0000
Message-ID: <e1900253-3d99-4198-a32e-50c423530d24@virtuozzo.com>
Date: Thu, 9 Apr 2026 23:43:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: fix skb_ext_total_length() BUILD_BUG_ON with
 CONFIG_GCOV_PROFILE_ALL
To: Paolo Abeni <pabeni@redhat.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Arnd Bergmann <arnd@arndb.de>,
 Peter Oberparleiter <oberpar@linux.ibm.com>,
 Mikhail Zaslonko <zaslonko@linux.ibm.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
References: <20260402140558.1437002-1-khorenko@virtuozzo.com>
 <20260402140558.1437002-2-khorenko@virtuozzo.com>
 <4f744383-1dc1-415a-a8da-5fe8f59daa35@redhat.com>
Content-Language: en-US, ru, sr
From: Konstantin Khorenko <khorenko@virtuozzo.com>
In-Reply-To: <4f744383-1dc1-415a-a8da-5fe8f59daa35@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0176.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::13) To PA6PR08MB10708.eurprd08.prod.outlook.com
 (2603:10a6:102:3c7::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR08MB10708:EE_|GV2PR08MB8051:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb7c798-cf2a-40c0-e7ad-08de96810a9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KnE95WhSPcabDblMY0kJzb27WdJE+OpQuVJIzEvc0hshAMXbKGHA+qEsQ+qpOH0bVzynPuN/tW85Ge+1g9w8YuGTnYYZjRtyOugX7EY4q8lMy2q2qTqZYvEw6bxuIrreGMtNZEKGiAMg1I+uJYloKL3L0qnBmJBq7dHC3dPx4vCVhJP7NnZCoOB+qAoiNgeLxJtlD+GpcJesH05SZNM40oRLOcPYrz8qrQOPLzHDnQtGghzg55LhoEMqYzYEVNlrcljPDNWnqWT3C2YcugAVJU+sI2z09bgE7WkfWRQPrpk7XWbnII6PEHFpiTHkr5d3j/fvn4K80zgkt4AMvj3BIfyjydVvQMJm0r+NzID0yI3JZ/6N+wfb4XbbWTFLWdC/9hrvB8JsZ7Avfz1vXiWwN7v6RtMu1qZSmjQNn78U0IDQuhoVxWkCUwcTI4B4aGlV/Yz87C4sAjde66QNpcc2yOBD/1bmTNpmZ1ga0yrbsm5nWsjDxcCYqfC81Fs2JfhnkLYY/IqmWtC9ReglLf+b2R4LEs+HaljE07yzFS0zjEKgiBowy7j4P9gs1Vsmkkddflz7krahUsZwzHGGqia2EHAqOBxPJxIGJQeu/5QnahGZw5ME1VQscJwMcSwRaB0LW6YJ10bqGQYJJwaTBh1squUyMlWi0/kQmNX3Aw2R4O4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR08MB10708.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clNBbnlvWTQrT1hUOHJKUUZpQjBzMG9hQTE5UWx1R2xRWmRYUHMzOVdXOUF0?=
 =?utf-8?B?Tk14MC83SHFHcHRvZTNMU1FmQnRRQUJCVnVvY3BZVkRFeXZyb1BNYVRhbDJP?=
 =?utf-8?B?ZHU0TlNRRmR2cDJGaTk0eXd6VlZvMTNXdzd2ZTl3d3RyZ0IzQ3lkQnF6TjRK?=
 =?utf-8?B?aTFZSFNVRkZqZVhOR3VDRUcxamJrbzhtdWNPZVBUN0xWb0FhWjlZTk1tQ2k3?=
 =?utf-8?B?RkJoZlg5WXRWekZiL21UVHBUd0Via1hIbXRvNlB2eTVrRzNOc3ZxeG5QWGJj?=
 =?utf-8?B?OFdraUcrdUg4MVg4QTdhdHlXUGx3K01hTUVKVzZtd2R5SFhEMzZlUnRPekpa?=
 =?utf-8?B?VFljenB4WUg5UWVCcy9qMTY1NXA1K0NqN1hkbGxlcURDMTZOOTArRWh1c1kx?=
 =?utf-8?B?MXhpRVdqRUJ5QmlSVzFMSDU4Z0Z4TS9qZ3dyZ29CR0RRVmMvOEFrK1RhVk85?=
 =?utf-8?B?blE5cUxNYWdxc1M2NWw5aUxXSTk1Q3VsbzI2TS93SmRwUC9IOU9Fa3pXSlJo?=
 =?utf-8?B?SEU3Vno1RXZMNEtFRDE5dWhYSkZGMFU1NWJ5am1aT2RaZDFDenhhWjVqdzFt?=
 =?utf-8?B?MHMzMTJLZG1zTTFYa3ZsQ0pwT2VrSXZoMm5MblhFQmVCUVM0MVI3U0wrMnNX?=
 =?utf-8?B?QTZWYWJvV3krenZYY2dhOERCVkNEUjRMRlMwN1dTbGdTa2hkb2N0K1ZGckJH?=
 =?utf-8?B?UWJmOWxheEtYK3JFMzgxLzdaT2IvYkNZeW81RDRxRmN3eGxSbjhMY0F0UWtG?=
 =?utf-8?B?REx6c09hNUlRaERnVkxGT0pvSkhhRm1JZld1dDhzS2dlelZsUSs5OW9vRS9J?=
 =?utf-8?B?VStrSGhSczVydmhBL1Zsd3BkWG01cSsrUkVvUGZZMWtCT2trbkh0QnU3eEZM?=
 =?utf-8?B?eGI2bjJOdWJxaWJoV3kxMk1GdWQ5UmJieHB2L1NDck9mNFUvbExERlIyQzZK?=
 =?utf-8?B?S2g4VUx1VGN6M1NoYWZNODBsMk1RSCtXOTd6V1piQVRmckhvUmNaWGRGUE1X?=
 =?utf-8?B?c21GQ2p0Yjc3Q3NROEJEQ1I3UlVxM0JVb084dTh1UUtzS0trSS8ybWtXRVZs?=
 =?utf-8?B?NG5xcmgwdEV3VzZaTjRHYlRuVnlmWmpkOHJGS3RFNFdnQ2dSbTZYcnFTczZu?=
 =?utf-8?B?KzRvRkI3RnlxN05qb0VvNU9KUHpyYmRRM3hxdzlXM1A4M1BONmhZOFFDSXRC?=
 =?utf-8?B?M285anRIZG5xenpCZzdHS0p3U2dHNGkrNWNTY2tmQ1doeVlZWEJkeFVBdU16?=
 =?utf-8?B?QXdhelk0Z2dwN010bnFaOW1hN3B3aUltQ2pxbkI2YWRvNmVQR2JPZUd1Zy9B?=
 =?utf-8?B?TUJlWjVQRmVtU3dhRGdaR1Q0RkdkN05ORm5UdWNGOEcxN0FLWWMyYXFaM1E2?=
 =?utf-8?B?RHZzOHkyRzNwaWxaZ1IyaWpLZWxneHovbTVjb1dXeEVsQmtBbnI0ai9TUmpE?=
 =?utf-8?B?V1UyZTZqME1uL1d0Y3dQeU1tVC9LYjNNNjRXSDJpTG1EV3hlWVkyb21EV0kw?=
 =?utf-8?B?bFIySUF3UVNtM2l3bmhQOTM2R1VNWkRJVTczOUxMSWhCRFhoamFMNTV4aEV1?=
 =?utf-8?B?bDVFekYwRk1YZEtENFUrWXRQMEwwVGlOTkpoNkhiNWc0eHN0UXFJREpZU21n?=
 =?utf-8?B?MERreGI4MVhzM0lKSk1vS1JIYm1KY0ZodWVHN3B1R3ZVRHhPQTZsem1sbnly?=
 =?utf-8?B?REEybSsrQ3A2Vm84S2tzR3RVeWlDd2RDVHRYVE9kcUZpcEhPWTdZaytEK0Fy?=
 =?utf-8?B?RXNlUXNqQ0lyeE4xWHVoY1krSVg0OTJRUVRjK0txdUJ3aVhKaGlwbkd5d08y?=
 =?utf-8?B?UzNzQW9TS1ZVS0JYWUg4ODlUYkpvT3FqdHQ0QVRlNWF0UlhFbnl5TUdUdHhH?=
 =?utf-8?B?SURGSUEzOXMybWZLQU5tSDZiTXBuNC9jY3NMMmRyY0o4bDVzRFlNQS9FdGtD?=
 =?utf-8?B?SFBReE1zY3hWWDc3RjRkNkJZZGEyeGx5Q3FwK1JZYVZaa0h1bXg4Rlg3VnRl?=
 =?utf-8?B?NDhaQUkrYmRpcTA5eU02R1N0aTNna09YdFVET3F2UHdiZ1c0YlRpdzRDUGM1?=
 =?utf-8?B?QjlGT3VveElLZElIRCs5dWlhVVhhVHBKMmtMOUZ2QkhPUUZrVWJjOXJNUVlI?=
 =?utf-8?B?bmlHeUxpcGJpY29IODNDa3krUzZEanQvak8wY2dGUnFUcnl3eHNqWGE3Q1d1?=
 =?utf-8?B?SEgydWx2cFZhd0dGWTF3dFJMZFovSFNZM3ZiWXNWQVRTR3NFdnk2Ulhzd1ZH?=
 =?utf-8?B?d2hFdHJTTnI1U3N0aUh6eDYxVUY0VWpnUWl3VWlKaFBoYS91MzByQ0pGVCtG?=
 =?utf-8?B?aGZMT0ZQa0FuSXVDZzljbzdVWWVQbHVUTmNlZlpqZ2xJdW1wbXRadz09?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb7c798-cf2a-40c0-e7ad-08de96810a9a
X-MS-Exchange-CrossTenant-AuthSource: PA6PR08MB10708.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 21:43:30.8107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8XLRBh/PIOzEimF0eQ8l2bixZ74YRGu3AjPhHAqN5dtLzAhJL3VHNC73vw+hPZgdv2fiaAFtnMAF9mGVFphSGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8051
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277129-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khorenko@virtuozzo.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 9BD253CFFBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/7/26 09:55, Paolo Abeni wrote:
> On 4/2/26 4:05 PM, Konstantin Khorenko wrote:
...
>>
>> Fixes: 5d21d0a65b57 ("net: generalize calculation of skb extensions length")
>> Fixes: d6e5794b06c0 ("net: avoid build bug in skb extension length calculation")
>>
>> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
> 
> No empty lines in the tags area.

Sure, will fix.

> Also given the commit description, isn't the introduction of the 5th skb
> extension a better fixes tag?

Well, if we did not have 5d21d0a65b57 ("net: generalize calculation of skb extensions length"), we 
won't have a problem even after 5th skb extension.

On the other hand, yes, the defect reveals itself only after the appearance of the 5th skb extension, 
so we can also treat it guilty.

i will change the Fixes: tag.

>> Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
>> ---
>>   net/core/skbuff.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index 0e217041958a..47c7f0ab6e84 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -5145,7 +5145,7 @@ static const u8 skb_ext_type_len[] = {
>>   #endif
>>   };
>>   
>> -static __always_inline unsigned int skb_ext_total_length(void)
>> +static __always_inline __no_profile unsigned int skb_ext_total_length(void)
>>   {
>>   	unsigned int l = SKB_EXT_CHUNKSIZEOF(struct skb_ext);
>>   	int i;
>> @@ -5159,9 +5159,7 @@ static __always_inline unsigned int skb_ext_total_length(void)
>>   static void skb_extensions_init(void)
>>   {
>>   	BUILD_BUG_ON(SKB_EXT_NUM > 8);
>> -#if !IS_ENABLED(CONFIG_KCOV_INSTRUMENT_ALL)
>>   	BUILD_BUG_ON(skb_ext_total_length() > 255);
>> -#endif
> 
> Sashiko notes that there could be still build breakage:
> 
> https://sashiko.dev/#/patchset/20260402140558.1437002-1-khorenko%40virtuozzo.com
> 
> Could you please double check the above?
Sashiko is great!

The concern about KCOV is valid in theory but doesn't apply in practice. Here's why:

__no_profile (__no_profile_instrument_function__) indeed only prevents GCOV profiling counters
(-fprofile-arcs) from being inserted. It has no effect on KCOV instrumentation
(-fsanitize-coverage=trace-pc), which would require __no_sanitize_coverage instead.

However, KCOV instrumentation does not break constant folding in the first place.
I verified this with a standalone test: a __always_inline function with a loop over a const array 
(mimicking skb_ext_total_length()), compiled with different instrumentation flags:

  * No instrumentation: BUILD_BUG_ON passes (constant folded)
  * GCOV (-fprofile-arcs -ftest-coverage -fno-tree-loop-im): BUILD_BUG_ON fails
  * KCOV (-fsanitize-coverage=trace-pc): BUILD_BUG_ON passes (constant folded)
  * GCOV + atomic (-fprofile-arcs -ftest-coverage -fno-tree-loop-im -fprofile-update=atomic): 
BUILD_BUG_ON fails

The difference is in how GCC instruments code. GCOV inserts global counter increments inside the loop 
body. Combined with -fno-tree-loop-im, these counter operations prevent GCC from proving the loop 
result is a compile-time constant.

KCOV only inserts __sanitizer_cov_trace_pc() callbacks at basic block entries - these are opaque 
function calls that don't participate in value computation, so GCC can still see the loop iterates 
over a const array and fold it.


 > I think a 'noinline' in skb_extensions_init() would address any
 > complains on patch 2/2

Yes, will add "noinline" to be on a safe side.

--
Konstantin Khorenko


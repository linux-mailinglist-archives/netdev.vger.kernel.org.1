Return-Path: <netdev+bounces-270209-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNPeN/6Xvmm2TwMAu9opvQ
	(envelope-from <netdev+bounces-270209-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 14:07:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B2F2E56C1
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 14:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C38B03025733
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 13:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D75313295;
	Sat, 21 Mar 2026 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KuIRs2bO"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011035.outbound.protection.outlook.com [40.93.194.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1352D7817;
	Sat, 21 Mar 2026 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774098335; cv=fail; b=oG7xA5S9xXJbMH3GmXs1AjWCzq4m/pgO6i7zd5rbWmyOoF5cgBOZVj0jWmQLdpt7T/kYt+q1jBRQkHpOjnpfynv8zocbVJm3/xWNmXrT7eeunGuYr3A+J9A6b2BEOFlFvW445R+26durh3UCtZoEdoaoHkXxyLrB4FXBYO77ovI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774098335; c=relaxed/simple;
	bh=GiOp91SIXQmrKcUhykwHRPyOuXSCaCyaaKe0hxTHvBU=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=HwWTpeWx7sRqqXyXkSi3+rEpyLQmrmfi8T4ywoq5omdJsGJsWH6MecBUb5HrNm+Hi74NEYiYgmA+pTuPFQcGznT5vwVRyAqsU+BxuF6qGRxB+s001Pg98J2MD9bMwZLSiMjUPycbDXKE1gQGYmqpKVTWU9cQ2SR4934vN8S662o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KuIRs2bO; arc=fail smtp.client-ip=40.93.194.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czYZuhZGeuJmDRZyuogCjVR3F+87CqIeesvZrrUxCuaCTjr/+Nkp9D5TruSSfMbB8MvpNXW4DSkRyzmxErIxf6oKhS2XRE8LSK6qqUtXP1f+x8ZznNHXyYQNun46Bn5dLfadsGm9Jd3GgHEtdnVbLHkB+cMvslQjznhtinSUVNMHsMsjxgBBZIUDkOZvMT/r1GQR7D58yGxzAz2YwZ9vXNpy7Sfo6HUYf7Uv3ys3a21zi0B8H7kyzgyDgmMGbjT2397I53RXp2roq/KuWPU9yX3rShrBaFBmprpEXC3oTt4h5UwdNOaBbz91UUXDOMirbO9woTAXKZyx3DnvEjXVpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUekRUr+ok4QqyJFsLhEVgOOUAybLXTJn63y4DHxdCo=;
 b=qg2O4ivKucdSk/xtq1dS1T6j5cLOpPuv0ebnDB0Ibq+TbuEPrbuJodmTNW/Yn3fZ7L6ACZnMkirwMaa4RWziC6LCy4OfDfL9HAtl45CKu0+yIGpN9AzYixgDJ6QKEwcQSsgCuz+xbTeiNiKMnAmgugB6ZfW4dVQZgxo/v8VHffAkmn1JcZvRwMZvKvQVGfQXR6RGrQ5urEnDHY/To6JRwga0z/FM7RWvIIxTXNMhl7MuU8SgN00xAY74oHmwWMr4vvam0rCJ64wu/K+AZb6AYP7+SsIH+k1/JrbKpu2WoqgTAUmwg1i6bzXKHS9G8E5Kv/5RWSBTAR+a9N/2FnJdQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUekRUr+ok4QqyJFsLhEVgOOUAybLXTJn63y4DHxdCo=;
 b=KuIRs2bOz0MyVQSPGuRLV5eoADD/Dqg64AKE8AUU4CCNkAiw38WNjbzh9pGVZFA5W4qGWB6oO4ByOEjCP4O6QFC950j6bzf2TvyQLbDbrPEteJFHw8fFS+vr+rjN5X/ShDBUSYOVfiou3TcXsOyHyorh2bvhWZ15VhDOwzy5IiJ950XOOntlqyG2bCmuGV2Sl/Nzf9UxGjgA0aJMyFOTJPY3wr/1wRRxfbF0s4rLNVfZuL8HONXcGdpGHmW7H0BrGMGsDZvNqoYsV3QUZ2pq1JdfDIDOCaUeSDnTc5t61N96mKUJ1zCnIEpHer3TdaqbcZuTbov5JBsCrjOISJqfbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM3PR12MB9288.namprd12.prod.outlook.com (2603:10b6:0:4a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Sat, 21 Mar
 2026 13:05:27 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Sat, 21 Mar 2026
 13:05:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Mar 2026 22:05:22 +0900
Message-Id: <DH8HDA6Q6FU3.3JR57W97IO1VE@nvidia.com>
Subject: Re: [PATCH v3 4/4] rust: make `build_assert` module the home of
 related macros
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@kernel.org>
Cc: "Gary Guo" <gary@garyguo.net>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Will Deacon" <will@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Mark Rutland" <mark.rutland@arm.com>, "Ingo
 Molnar" <mingo@redhat.com>, "Waiman Long" <longman@redhat.com>, "Tamir
 Duberstein" <tamird@kernel.org>, "Yury Norov" <ynorov@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <netdev@vger.kernel.org>
References: <20260319121653.2975748-1-gary@kernel.org>
 <20260319121653.2975748-5-gary@kernel.org>
In-Reply-To: <20260319121653.2975748-5-gary@kernel.org>
X-ClientProxiedBy: TYCPR01CA0021.jpnprd01.prod.outlook.com (2603:1096:405::33)
 To CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM3PR12MB9288:EE_
X-MS-Office365-Filtering-Correlation-Id: 48122ad4-350d-42e0-0e1e-08de874a8508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6FsHXy6OD2czH0qjNIm2qx6HPTCvmGBJzViUvADsScbB7bN0KWJc/7VleTOJuW6SZHg80XtjD1AwzLJXNMb7JBh0iARmHx8Z3y13cUztyfIzW7HW5hLPky1FZFCyz7WeiKL1GzHPaSau4kPlhtUaWF1ujE/TZ3GM20DFAava2GNf8FUsY3dv2Q/BvDlToaWbjbT3anWskqQgWvLdjMdyiY8R1QZSdpoLumqGC9hR6byGwGc6CbLF6VCIRGjKa0u8uVzYe07I8FAe1mBRLwSeWSdkzqq7XmktvJDqAfHMaAwFPbSuDJVEk1y3Lih4XtGhN+3jbLpS59nOqFs+ZfhNgNhu2G0om+61zirDk+G+ySj+xgu1Tqr6xa7cRwdjKlG+1yVTVpYpOvVsZN6LVeTD6sPQldvRuLNuUIosGEySLnv4hNYZEJDnh74lhTqV37iHDou3ggxrabo5VDHZiZ0rPM6YYlpi4H6VzrI54s/7rKk+cRcer6nPQ6y0aenjwslr1jGf7vp5jeIXeFVpqCh+rjp1ioOklZp8qBLFrAb+Qxv8LXGgDK09KFjkSLsOvfwAh45mooSBDbZjHHC98p2sZlz3G0G5gdgYA80nzBIdt3dA7UKwj8pHTXMpuEs4Me6tS3R6xpMkrni7LpGGNGg6Lp0VoxWtSLclcm6ePKKi2RRrrhaQZTPeQMEXRDk9baVluK+wSQs/k7u6o5fzNsrhh55Lc2gTP1F7PQX/ts4EGLk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTh3b1A1VGkrT3MyN3I1M21WOFA1N0lxNEZ3dGs1aVFBclNLeDEzNUZ0N0Qv?=
 =?utf-8?B?UXBJSTk1NlBvNU5BN3lCZWUrMzlJTGZRbmhvcGczMUpjYW5HeUoxbmZudWNs?=
 =?utf-8?B?SzNrckFiQ2xmMFBuT3NWRTQ1VG95YjVscUc0RklCcWxaQnEyN29yZ3pkZDlZ?=
 =?utf-8?B?ZkZ4QUtsblNCYmQ4VHVxaTBBaXRJV2I4aTRIbmdVSlpFNlVUQnBXM3ZWc0J3?=
 =?utf-8?B?VUhueEh5bFZLT3JNRVRRd2V4aktLZk1RUHl0ZGt1WDFvZ2w0dzY4bXV6TG9E?=
 =?utf-8?B?M2dHcUhLK3dERGJqU2VmVUFHZGQvZTZUeUtiYkttQlRYaVVReHdFSFl5WWpY?=
 =?utf-8?B?ZnBUTU1QSWdSTTZzeWhlWHE1eGE2aG1wY3ZGWkRFTFFDVCtXcDNOTnBjUUM4?=
 =?utf-8?B?ellqUHhNM1hSc2plV2E3eUdMN1JDa3B0bGttR1FFckZ3aVUrdkFTYWVtSVRx?=
 =?utf-8?B?WmtnV2c4STQ1czZXSjhMVUZ5SUFYVlc1OWZTdVdCdm1PNmhGNEFRc1lGTmMz?=
 =?utf-8?B?Y2lPeGlyemhYaithRUJhZlNCcUJXaDVqK3BjbnAzMXhDR2d5Yy9sNjU4SjVF?=
 =?utf-8?B?MTZ2T2l5WHFUZFY0L0VWaExPUEQybzRyZUxOS0pKU0E1TXpaeXZycDdKTTlW?=
 =?utf-8?B?bkpYaWIrNXIyaFc1NW5sbEdUU2hZUkswZmF4aGdIT01SbkNYYVdObzNEY09K?=
 =?utf-8?B?QU9mZlV5SVlNK1JHMUlhT2dIV010bVY4UStsZm8yaHdCUkpFRUFOYWE3NXhN?=
 =?utf-8?B?VjNWaVcwb1dpQXhaQ3dJNTZ6V3UvSjdmZzRacy9GS3BmY3lTNGNxNTdCZDZI?=
 =?utf-8?B?anZ5SGVSZ3RYRzAwR0Jab1hjb08vaHlxNVhWS0ZGSSthQ3pWMGhEOVRhWk8r?=
 =?utf-8?B?QkxiNHNTaTdlUXJVdnFsUXF0a2pyQjhoa0x5VnVYRmQydmltUTh2SkY5UzlF?=
 =?utf-8?B?L2dsOGhMZiswOEloNmNnNis1cW1IZzVyMVNDSXdnZE5iQlFwclFYcnpwamM0?=
 =?utf-8?B?NjJoaUxMN2NUcHY5bFB6NGRDdmQ3b2R4Mkg3UXA2dVpKM3JQdDkxM2plQ2hD?=
 =?utf-8?B?ZnRaUmd1NkJ3cGQwV1BuZWVaRWVJMVZvcUtqZVlTYThoRk9GSXl2TnpqN0R3?=
 =?utf-8?B?RE1hL1lSWktqaW1yeEM1NE90ai94ait5ZnBLS2JjUWVUdnhOUlR3WjdOWXdD?=
 =?utf-8?B?MWpWRlorbkpFQ3c5WEtFeUQwbjRLMWoxd0VML21ORXliUHVRNE55R280NVdS?=
 =?utf-8?B?QUkvRS85TXZjaW1kWHEwUnZmVlZZdmRDRHIrc2pHWkM3MUVyTFVVOTFNYXZp?=
 =?utf-8?B?TDlTcktrRjlHTWhsdUJkTnk4VGg2YWxvU1JUNm41MnZldHdLK0NXU2FXQ0Vt?=
 =?utf-8?B?U1B3K3FBMGpxYVpWZGg2WGl0N3pUQXkrUE9NSVFiVmlQV21ZcytDSXArbmEv?=
 =?utf-8?B?TXBaYUl3cHhzanRlUXVGRjFzNVRFZEtCSmRaZWt4Wkxjei9WaXBaQTgrOFZX?=
 =?utf-8?B?eFEvUGxlc2d3clM0L3VVOXJHdE15NkxCMnQzYTBHT0UwZXptUjcwdnY5ZmRm?=
 =?utf-8?B?VXQyNHBPZnA1MU1YL0xhUHRsbUtBNEd5SzYvVldBQlZJNktWVzFxMzM4UzBL?=
 =?utf-8?B?K3YvejFPNzRNMkV0VHRZUVJLWDc2cFVJbi9ncjFrZys4ZXd1bWh1MmlYYThT?=
 =?utf-8?B?c1ZMc3NHNGNzYnNmSGVSVlR1V1RsQTlSNXFndjFQS3ZDYXVRVWdMeUxkdkpz?=
 =?utf-8?B?YTZhdFVNTG4xN3ZUT0ZxR0xHdW5HbmJQT3lrdWd4ZmFPVG1OR2x3N0dLbHVG?=
 =?utf-8?B?SVlqeGpMaDRDbWx4TS9yNzdydTQwZGVzdGRTWlNCR0MyMCtzWkhLY1ZKUHJB?=
 =?utf-8?B?RlVwRkZJZTVqVlM5SnAzbi82MnlBbVIrRXp5OU1hY2JHUVVFTkhLZEJGU2Ew?=
 =?utf-8?B?eWpzdERSZXBqN2dUSXo1NjU5RnFqMzBHaUVPdGh1a3k0MkRxTmFwRlBFS2pq?=
 =?utf-8?B?TzU2b2NIUkgyV2o4R2huZUN0eWMvdXBSaHlsL3c1cXBERTcya3JqSHZHTXZX?=
 =?utf-8?B?dHZRYTB6SGxhZDRhR05TMEovYlpmL3E0dHBHNHZtcnNIK3dVeWFhTCthZ201?=
 =?utf-8?B?bU1iQklqbUcvZ1FwckJHeHlJU2xkS1h3ZjZWNzBzWHFRbEtLNUZwRzdqZDc0?=
 =?utf-8?B?alE1SWtlYVAwQk5zZTVya0Ryd0FsMEdHaHUyb3I3bHY2REZ1alRpd1l3ZzR1?=
 =?utf-8?B?eUZ2cHlIdDBtUTZKNnltaEE2V1NXQVAxeEx6QUl4WFliY0JTcHhPQnNZT2x6?=
 =?utf-8?B?dS9VOHlLT1kyUVFYVnZNWGtVWWoyVXlqTWNMZmI3bW15S0RBbFB3bEF2Q3Uy?=
 =?utf-8?Q?YTv8fl5q9kXHBnaNDoFAMmWK+QEMQfgEGlHoSVpZsx/GE?=
X-MS-Exchange-AntiSpam-MessageData-1: 3jizDN8DRueX0A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48122ad4-350d-42e0-0e1e-08de874a8508
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 13:05:26.7663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/s35k6lchMXi47UJU65J+KMj80Z37GAk2lgP/ySMvPfeXYMh0veyWEC0QvpInMdSC28x5pclLGdgFxObQKP2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9288
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270209-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[garyguo.net,kernel.org,protonmail.com,google.com,umich.edu,gmail.com,ffwll.ch,collabora.com,arm.com,infradead.org,redhat.com,nvidia.com,vger.kernel.org,lists.freedesktop.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,garyguo.net:email,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: 33B2F2E56C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu Mar 19, 2026 at 9:16 PM JST, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
>
> Given the macro scoping rules, all macros are rendered 3 times, in the
> module, in the top-level of kernel crate, and in the prelude.
>
> Add `#[doc(no_inline)]` to the prelude so it just shows up as re-export.
> Add `#[doc(hidden)]` to the macro definition and `#[doc(inline)]` to the
> re-export inside `build_assert` module so the top-level items are hidden.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  drivers/gpu/nova-core/bitfield.rs    |  4 ++--
>  drivers/gpu/nova-core/num.rs         |  2 +-
>  rust/kernel/build_assert.rs          | 19 ++++++++++++-------
>  rust/kernel/dma.rs                   |  5 +++--
>  rust/kernel/io/register.rs           | 19 ++++++++++++-------
>  rust/kernel/io/resource.rs           |  2 +-
>  rust/kernel/ioctl.rs                 |  2 +-
>  rust/kernel/net/phy/reg.rs           |  8 +++++---
>  rust/kernel/num/bounded.rs           |  2 +-
>  rust/kernel/prelude.rs               |  3 ++-
>  rust/kernel/sync/atomic/internal.rs  |  9 ++++++---
>  rust/kernel/sync/atomic/predefine.rs |  2 +-
>  rust/kernel/sync/locked_by.rs        |  2 +-
>  rust/kernel/sync/refcount.rs         |  8 +++++---
>  rust/kernel/xarray.rs                | 10 ++++++++--
>  15 files changed, 61 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/bitfield.rs b/drivers/gpu/nova-core/bi=
tfield.rs
> index 16e143658c51..c3e1235ad7fb 100644
> --- a/drivers/gpu/nova-core/bitfield.rs
> +++ b/drivers/gpu/nova-core/bitfield.rs
> @@ -170,7 +170,7 @@ impl $name {
>      (@check_field_bounds $hi:tt:$lo:tt $field:ident as bool) =3D> {
>          #[allow(clippy::eq_op)]
>          const _: () =3D {
> -            ::kernel::build_assert!(
> +            ::kernel::build_assert::build_assert!(

Given that the `build_assert` module now hosts 3 different assert
macros, have we considered renaming it to just `assert`? Otherwise the
naming implies that it is more connected to the `build_assert` macro
than the others, which doesn't seem to be true.


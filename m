Return-Path: <netdev+bounces-166929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE9BA37EF2
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 10:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADBDF1888CA7
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 09:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291CB215F56;
	Mon, 17 Feb 2025 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q0T3mdpW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E49192B63
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739785813; cv=fail; b=dDNgpvWuh90e7xX1EyRIZze+J1+5TFkHIMgz3IfWMH8I2+G7bEt3pG0UYS16DqrraYXkKVa7sEFEBvBrVJWD6drBVhc2mtPk+BRtcqpHBED9O3m7lUPXJoe48tib4kvp83V91nc4Ij/vw77yACLGjsVEsbbpYbpRcFUIWuFfL+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739785813; c=relaxed/simple;
	bh=f5sTPc2Dzt362J1qTJq5+4WbHLtM1zPxWqITYwoBJ5w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=paEriIR2uAmEz+W/P0wZSycQYhzjcvSxvGOspOopEnhEO65TnxyER1Zg/CtNBwMwdEm8xcdakQymUNA4M/wnIuKf/TX6MlQYKo1uKk8ZYMUY3iQjCuoXano9PlrIPJ6U4IiwXU4HnliwKSMcEsdjPxFeq/yLz7D9PqvnLXAlswI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q0T3mdpW; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLXfLho/igfJtIksBqCeAzv3P/esg6/oSsw/hgiwXPNjlW8aNmBExptUUFDEJRY6mwItbsAh4P/P6/E/SvbiEm6Jc2tM4t8/uQhGXEokvRUO6nmcR3ZA+4tAqAfAx33Q7gzaZ4C9dAkdzstHj3eDt8tlxdI5RSSD1RW01MLeWffpbtwMsR4PyK7uAhEAdk/8W95G6MWpRwsRIaYcBqwtVTe4oDuw7zbrzPp02NtlMPcn9FHzvCxAI7vqQRMnDCzXfhR02b9i36tNYU77mlZuTRcjhubRyX0AEvSLYlihZpYcoYoFScFilBiq5ULtenVg/z4+akmcvf358aEaT2BRXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7D/PKnefn2O05nMQ31KCWmFxzuQb9NQ+oFhrXnYBSg=;
 b=fRcrwYWo6m2S13wXrLrXqs2+NKE5vgzlFyPTe/Eg3K9nOSEtXCo4p/TxscD91+zx7weVkIhXnNcPTo20amkCQ1T0UqTME8SPQN4ta+2+mYaso9Yu3Jo0zmWBsOxKDzuKBoEuPORaD+BLKUx09zOJAaleJokHTrFeSiEZxbLZFvLRiJ61p7/5V9y/JI3Kd3qyTT2E7uXmq7MzUu3cKQ409t90l2yP1qr48h6fWbrQa2D3eKhocbxGaETucGoCYWiOYj4EBRcXuhCpp931bxIQnclgjE77+3MGWWtAw5nI2Hi9LRnT//KzjUIPjwjxzL2Quh5pPqWD8Bx6D1ArJ4Vzng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7D/PKnefn2O05nMQ31KCWmFxzuQb9NQ+oFhrXnYBSg=;
 b=q0T3mdpWMWBDWGIMbRc5lUer3EHRrzbou1cgpIJQYVdL+ZjqpsLAu0B+5CDehCDlAw0N4uKEiIEU8GTFVnDiqi4peSkVmio7y3e5OJzydfVXcLcOROPFJ76Mm9e4xY7RZMHnqORrZ4YtipfxMwzIbKZWVecl3sW+XPoNOqlUcDkfcRrZzqDN2VrgLocJstwkOzQwrEDRlkS8fbUlQM3qj3tPi4kVkizE2re+FAcSXu/yIJ2ldLG51waPzwfEpXVD1AMBPu32FdJGmKw2j3uiHcrPhxokrSAG/EB1PByE+Ne6OZtCmHlCS1LDehEJG8TuJJ7iwBHdZN3hDHn15RJYxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by PH0PR12MB7080.namprd12.prod.outlook.com (2603:10b6:510:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 09:50:09 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703%5]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 09:50:08 +0000
From: Wojtek Wasko <wwasko@nvidia.com>
To: netdev@vger.kernel.org
Cc: richardcochran@gmail.com,
	vadim.fedorenko@linux.dev,
	kuba@kernel.org,
	horms@kernel.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	pabeni@redhat.com,
	tglx@linutronix.de
Subject: [PATCH net-next v3 0/3] Permission checks for dynamic POSIX clocks
Date: Mon, 17 Feb 2025 11:50:02 +0200
Message-ID: <20250217095005.1453413-1-wwasko@nvidia.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0078.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::18) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|PH0PR12MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f3787ec-32d1-44f1-4953-08dd4f3876c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUQ5NGxtQ2RveTIyWjhXWFcvVi9jUTZqV3FGZ0MrUnRkdDF0U0R1QWNLRHlP?=
 =?utf-8?B?cTVCL0FGdVFWTjgyVlp4am84eDl5SG15ZTZkbnczcHlRbHRZNDYycllEVVBr?=
 =?utf-8?B?Ukt5MFFQdUFtKzJLbExSazNkQU9Iakp6NzlvMXpDWEJUL1I5MFhRK2tXSnkv?=
 =?utf-8?B?MVVvazVTQTUyb1JOSFN1L1d5Y0VzMnJSREVzMHlKcStnck96U1BIQ3ROWjVT?=
 =?utf-8?B?WU9kK0VSWjlkOHUxenFxUEdaZlFhSXhKb1JWcmI2bCtvNi9JRG9QOTNQcnJr?=
 =?utf-8?B?Smk5NmRMcTljbGdnV2pvUUMrN3JJNnBRVitvemJNTDlxc1lXYW1sMzFzTFBw?=
 =?utf-8?B?UDRsKzllY1c1cUJjeFVjSEJPREd2UDVveHBEcTdCK0U2a3FqejlNYlpZeklS?=
 =?utf-8?B?YkEzRnd2cGgwWDFRdmd2OWpSMDZLUHZTNHJONjd4QklJMUYzVm5LUlExbEEz?=
 =?utf-8?B?bTZxZklNT3ZSbEpKOGtodXd2UW5STnNsV2gzMDduTkNUWm9uQ1QrQlhSNXZm?=
 =?utf-8?B?WlUvdE14QTdsdy8vMjRBcUJ0TVVUcGV1S3UyY2c0Sy9jZ3FwOHV4eTFVL2ZB?=
 =?utf-8?B?VUtoKzdtaHF2MDNIc1Z1L0J3a1FFRTBLVGorMFYwcElsYk1IS1JnbnNEKzQ4?=
 =?utf-8?B?TlJ0d1RwSlN4RE04OHRKcExtTDVoemh1SjZzam1QVS84RnRSRERDQWtCczRs?=
 =?utf-8?B?RElRS2o5M0o1U1lqMWd1YlhEeXBCQjR6QWo0K3ZMQlQyR3dXZ2pNSzNlMjNU?=
 =?utf-8?B?eWFYdnJDNmpFRFhKdS83cFRsUjRGTDJxT1h1dSsybXRtK2ZLOGQ4dm10Wmtn?=
 =?utf-8?B?azJaZStpVWhiWjMrWHpvRzFsWjFHb28xNlBIbmF3dXhvZXNnNFlnUXAzM2Rw?=
 =?utf-8?B?UHZXSWhDbW05eFRocUxvaWZvSG1OM1pjWlVTR2x0QjFqQ21jMUorOE80amlu?=
 =?utf-8?B?NHZCQ0dOVGtmYkJtaHNmZGxjT3pBSlN5R3FxeXQ1NzJsd2FFcU5QMVh2NTZF?=
 =?utf-8?B?K1hUeTF0cmNOT2daV0NYdWYvaUljVjl6VUdKOWw0N0Y4UVRSa3MxUHJPMGlL?=
 =?utf-8?B?RjVwY0RMYjlhRTdQUDNmdDRNTFI0VjlpbWd1d1RtU2MrZWlTTHVmcFlldDR4?=
 =?utf-8?B?VEE2V0x1NTgrZW1ZakZGaVgvRGVDNXNsOE9JZGE2RzBNbW9mWnFocW1ETCtw?=
 =?utf-8?B?elBNU0loM3BPMEg2ako0QVh4Q2liak1kQzRIakRNOUNNRGlONUpQVVRMdXRB?=
 =?utf-8?B?b0pqVlNGQ2VmcHlJZklQN2pUeDlUMXNnSm5ZMjNLZ2M4NW9IR1FUNFpnT2Rt?=
 =?utf-8?B?elFPcEh6WWQ0OGdnM1J3d2c5WVZMSCt0WnVmOFF6cFZFZDhQbno1RncvVHc5?=
 =?utf-8?B?a0VrWlRFTUhqaGtOWThkSmpYb0ZrTjh5alZmdDVqOFpKcHJjUFQ3QWtLNC93?=
 =?utf-8?B?RGRZSUxwZGx5MXBSMHZNZjA3REQxdzdmMVJoVHFLZ1V6VUFQQjNLdUpCL3VQ?=
 =?utf-8?B?U3VadFdCZmR5akExV1M1NTJBbkdTa2xTMjJyRFdZcmhqS2xheEtpNHIrV2du?=
 =?utf-8?B?eVluaG9aQks2em5KaWFJSTFaUnNZLytpOGh5K0pUOUJLU0hUT0YzVXdSTmpj?=
 =?utf-8?B?MlJ0V0NJalgxTVU4ZEpjQWRGUndsaGhwbE5yNjA5QTVnR2dMeU1FRWRyMk5P?=
 =?utf-8?B?SmgxTHNTRlMvQkE5SE1OOWFScTcwcVF4M05QWUtTZmdUQzF3RlBpaHZSWGNn?=
 =?utf-8?B?WFc5SFdza2pqTGp1eStIZ2swNlVBVGxwM21rZXVUSVFpQUJUTkpKS20yd0Mz?=
 =?utf-8?B?UnVNbUE2OFlQRWxYWHJBcWExVEYyWDZFTG5sRUM5MGhhbTNSRGUrVGVjdnRr?=
 =?utf-8?Q?FR7nLIq1Y65Pw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkpFYmxaRDVWSHpOTXcyS1hVSVBWK043WmI3SXJxMU04VnZ2OXFGME1xck9C?=
 =?utf-8?B?QlV5LzFjSnZac09Gcjd6NkZlTW1OQnEyTWE4S1FGZE5PNFFsTkhocFBtOHJy?=
 =?utf-8?B?NE8zUlZmbFNkZWlLSkJacjFZT2puYjNCaTNMSzFIUzFLcmMxajRFREtNUXRC?=
 =?utf-8?B?RFdTelFuemhkOHdXUWkyZ0U3K2tnWnlCM2dNMUtmQUl3Z0NDWGMyTEhCbFFE?=
 =?utf-8?B?YVh3dFVXQjIwNnp1OGhKWXc0THVMRnZSek45ZEk0TXk5S0sweEEwVHR5M1Av?=
 =?utf-8?B?bWlkY0M1OWxYSU52WEtZOFNkTGM2MmFqM2E0SFZ5SytSV1JUaThLVVhmazZY?=
 =?utf-8?B?YWpmSFRreWhDSWRTMmhKNWdKdzVzOVVTaHNvK3hncHI3bjQzU0pkZGNvVGRs?=
 =?utf-8?B?YU1CTDFtNm15WG1sdkEvTS9FZEV0SEthdHFOZ3RCQTE2RlZiRlgxeERLVEUz?=
 =?utf-8?B?dUVQOW1vVGxQbEloUjhIT1k0SkpSTzh1ZTY3Ky9FdGJHL2ZNUy85ZHZBS0dn?=
 =?utf-8?B?LzA0dHRZYUxVblN1bXpBSXN2TmRKNHc5ZlQ0Z2swNGFSYzloWmptdzBiWitU?=
 =?utf-8?B?VUdyUS9zcmdXbzlMSGtobjRybm9NU2pyWWE4bkhFTTZ5cVVOQ0ZaTEg3clBF?=
 =?utf-8?B?bThHandQb29peTV1N3lBN3JNTmkxVEVrd1dxUkxsbUZvU2J6WHNVbkRXWFo2?=
 =?utf-8?B?YzZ1ckMzY3dybnBvcnBsZzZ4UWhtZGtEUXhaVmx5aFdyd0tYWWhGeklVcnhP?=
 =?utf-8?B?YlpkZ0JXcTRpeVFvNUN1VC9DbFl1K2JWaTFXN2tZdHB3MDBNTTlwUnlSZC9N?=
 =?utf-8?B?Q2RYTlJ4QlBTcWRrbFpOTDlUT1hEWlAwZjIreGdmUDVrbFhCQUdRdHZDSjJj?=
 =?utf-8?B?aitHZ205SzMrOEQ2dzN1UTY1bEFxVTFxdi83TEtZMjIzbDVqbkVUazZBNVpC?=
 =?utf-8?B?d1oyWUozVlFZZ2J5MXk5cTNlTnRVdXJ6TXoxM0MvSHNnS0s1TDVTSjIzNjk1?=
 =?utf-8?B?MWdpN21vNkFFZjNOZXhqN0RpYTk5d3R0QUFRMzVzT1VxSkN2bUNseFJXRkhX?=
 =?utf-8?B?UkxNUzFsTjZpbzBXVFMrc0o3VlZ4TVlicUgzaWhlckxvWS9hZTNEaW5Hc3dy?=
 =?utf-8?B?Umdrb3ZpZWErS3A3MU16NWtkU3hkWnlCclBCT2pwK3JFaTRPL0p0ZXg1eEs0?=
 =?utf-8?B?NWZXYXdqTDFWZkpRMG5zVFBxdUdyMTZuQTlPWEhrbzFxaUZubHZPQlhpUzFQ?=
 =?utf-8?B?Zk5oRDJmcXRVRm9DbDBlZDdxbFNPZkkxbU0xMFY5RHFJUmNuR2tySkN0ekNi?=
 =?utf-8?B?V3IwQklqdkxzRUE5L1NpRFdjaFVrMUQwYmJCM1BFcC83dzl3bjRDMTc3WFhF?=
 =?utf-8?B?bGNhRW1zaExwamdmbC9yUlBvdjk3WFNSVm9xcmwrZi9QZ2hFZVVEU3M2YndV?=
 =?utf-8?B?bzhHekFGUXNVUmREOFlwb2FVU0tPNyt4YmRlUUhMZitkUndHOEZiKzdROGp1?=
 =?utf-8?B?emdmWlRvcFJ6UkdUVDJmNkRpZVVuRC91ZXAzN0Y4OWZtZUczL2lGWHpsajdT?=
 =?utf-8?B?eUZ6MzUyc0VtV2pSaFQ4MGNQWWVXeEZOb2xQazVwbWJVN1YvMXI1TFk2WlVP?=
 =?utf-8?B?KzVnaFdrVnh3TDQzZGRjQWhCSzVCUllScXpUUGx0ZUtJZ3VqT3NJNGtBamZC?=
 =?utf-8?B?SmtwUTMzd0JwbWtmdVBuZ3Y3bFZhZDhaS2dYeFJIUFJ2ZU51WlB6Z1hTbVkw?=
 =?utf-8?B?QWt1T0VQRTBrWDQrV2h4R2RSNzdrOHU3ZWJBRmFqY2RacFJxT29yYjROaHox?=
 =?utf-8?B?dnMvaHhiUzh3ZjBzZWo1S2dsSkhxRkN1WWg2NnJYMEE2ZGJxUEZOLzlLTGVU?=
 =?utf-8?B?WGp6cVJ3VXBBTWVQUURpSlhwZ0FRTW9Eb1FKSTRYbmtlbHFLdzFjR2hocTdj?=
 =?utf-8?B?VEJKTEx1MmRpSi9pRGVWc3hYK0t0U1RrcXhHQnF2OEJndkVWaWdwNk04NHlB?=
 =?utf-8?B?T2pFMjBRc1hVQmJEckxhbGJ6TDBiYnAyWHNDSHN0ZWw5czJNQkJUaklWNTZp?=
 =?utf-8?B?c1IxZmNSTkQ1TENNWU5VM3I4TFZ3T1BwZ3NxQVNYL1JVaXAyMEs0ZU9NdmMy?=
 =?utf-8?Q?d5jxiO+sd7qZLG4EVImGv+uFx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3787ec-32d1-44f1-4953-08dd4f3876c5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 09:50:08.6999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 466oIeN/jWkd00RrHLe7KzZC4mqNRmnjSXuTf/3bttICm7G7zO2y2Ym8mUyJX6tNLtHTGrlSSyyVZcyQl3nlnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7080

Dynamic clocks - such as PTP clocks - extend beyond the standard POSIX
clock API by using ioctl calls. While file permissions are enforced for
standard POSIX operations, they are not implemented for ioctl calls,
since the POSIX layer cannot differentiate between calls which modify
the clock's state (like enabling PPS output generation) and those that
don't (such as retrieving the clock's PPS capabilities).

On the other hand, drivers implementing the dynamic clocks lack the
necessary information context to enforce permission checks themselves.

Add a struct file pointer to the POSIX clock context and use it to
implement the appropriate permission checks on PTP chardevs. Add a
readonly option to testptp.

Changes in v3:
- Reword the log message for commit against posix-clock and fix
  documentation of struct posix_clock_context, as suggested by Thomas

Changes in v2:
- Store file pointer in POSIX clock context rather than fmode in the PTP
  clock's private data, as suggested by Richard.
- Move testptp.c changes into separate patch.

Wojtek Wasko (3):
  posix-clock: Store file pointer in struct posix_clock_context
  ptp: Add file permission checks on PHCs
  testptp: add option to open PHC in readonly mode

 drivers/ptp/ptp_chardev.c             | 16 ++++++++++++
 include/linux/posix-clock.h           |  6 ++++-
 kernel/time/posix-clock.c             |  1 +
 tools/testing/selftests/ptp/testptp.c | 37 +++++++++++++++++----------
 4 files changed, 45 insertions(+), 15 deletions(-)

-- 
2.39.3



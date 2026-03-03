Return-Path: <netdev+bounces-263372-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AC9mBqEup2mbfgAAu9opvQ
	(envelope-from <netdev+bounces-263372-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:55:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 271381F585F
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A583300B9D8
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 18:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC3F382394;
	Tue,  3 Mar 2026 18:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fUSKJ9OV"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010056.outbound.protection.outlook.com [52.101.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2A73537C6;
	Tue,  3 Mar 2026 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772564121; cv=fail; b=V0zKgp+OrD1mlObl3bjjVBxAftntg1uZIN8U0B/Gr0eJUwoFx9Iazdwciwq3B2yls+GH3gQkll8yZpraVGEzJ64raugh5r9aikyxyUdRlHLfSfru4i7URg/Gy8Cq311kvT/3/UU6kg85n4kMGgFBVpozxZLKwoQW8zuqVZdxLBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772564121; c=relaxed/simple;
	bh=FljI2nc6ott0VR/Tsu2RVGSd3uY23PIlKYMhxhupcmA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZoBjneLSyZWww5s7+tnYV0ovcu3X3Bw5TR54H3eJRDlVV4+Lg6kGXKbdCL60l6JRaFxUzija8DvezMcI779RoNYE0iBZGinmpSyCB2MLHJ2EUwv+Ru5eZmYjmWScgZE4b00Ql3R/yVG5S1HZ0hQ76DLlu7S4/U+6giO2ohcZw48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fUSKJ9OV; arc=fail smtp.client-ip=52.101.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTgeI9SLq4xo5CNXDRMupoJOoZKZZri6BAD4omYstAqnvPlWjlnQ74/g2hhH85LqPi8OMRLTeyEaSiHA4Wsl2C4u6wyJCeHTt3RluZrR44Obhg9u2KPB1P4e5dhvuW6mozJXJitKf++9UVeJtvTGafwvT/Em6idYUjrnwwc4DYITsrVZjbDtfl0usHzFT9vKl2RXZBAgKdmvQZ6nw+nHASk+ya1052dg4B/10w2JitCUHfea9gV+H0n+PItpG6u3d37KXGj0XTzEadzFYp1y9WfKfblLQtcoCXtIK06GTpCIcJ6ZFY1Ewx3ohA5QlNPrRfHg7eZpBHHwW3CPdry9ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0teS3uMui9o3IAlKuJaFTm+pesZLJEyR6/FIKbdZNwU=;
 b=eimKSPKoIFu0p4+wXVZJX74wFMhOKiTsOwXQcOIQE385MKUU48RpeVYZW3y1X6Rm+/BR3zzstcg3UHuPG6kyu3u3FXXMhN6owjzMKm2UASgkIEa/mCd4vZ2h7MBFO1qff1zMj1ELNbIMNsOmcPSIp2N9FjX8IiUGzILkk8qjoQ1VTTHkCDw3f6KuUzROI5S4GR7Uurx4cDSMb0qRiwBlW1jnRU1tz0ttrFatobNvsRDirBlbNLkimx29eNqIcA+RdEi9Q+/3J8Y1KvKFC/lSi/MF1V6+627BCXb6rrBEMQOeYBUr6TFrbJChG0Nl5OrCQo/KIWZNJhl8/qeDnXgYLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0teS3uMui9o3IAlKuJaFTm+pesZLJEyR6/FIKbdZNwU=;
 b=fUSKJ9OVyuwHVqVd7M+n1YlTlyVx2xSxdrwwjoa2UfmPIrkvcvBjLrmGtqeKnj3KrHZ59q/ICVLUqNHVMvj21qd5TZJYfuo7L+pDdMHW9BqBurvG+yYtY2n0RzhH0EEGCiDaOInxMbjSwLWyWoKFQo3IZgUUoE4llfLxCz5nsuuZh8O8TEDVFZRlI3n/2woS9V6mJiQIWl/YpEG9bQaH+RvbytoDhdqgBY7uemlSenGtmBJGO4U+Bswxpbca41sBcnhW3vkxqG7ESS2ExK2Lhi7x0t/O2C17nNBjGpJlex/XzxW+auvyctOiSzbX8zEIEwBcHznNDDwSnp2UJBTSeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by SN7PR12MB8026.namprd12.prod.outlook.com (2603:10b6:806:34b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 18:55:09 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 18:55:09 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Yajun Deng <yajun.deng@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH RESEND 0/2] net: cleanup bitmaps printing
Date: Tue,  3 Mar 2026 13:55:04 -0500
Message-ID: <20260303185507.111841-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:408:e6::17) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|SN7PR12MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: 13edf495-46ab-47de-e406-08de79566480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	Ftr8bIm5YVQtr6YGdryUdz1xMZ4+UTnL4e4XAm77ql5QUwYtRL3ip0ZzoLHOaNuDGLWoCoRulHMLicq/JuI2YLhM1Y29XaD5n+C/avSJxagXjpPYzhvHX1f1NNauNvBnVEY09tkJH/ExYcY8NYX+yMpqojKJiXx/NHncdPQekMTGOpc5+PFlDwaUA9qiBIu7MuSU/BE64aXTXEY/xZWmE62bXE/dXiKsWSG5d23DMwQO4OmJP0N5ru9TxbCNg2t38AbXlLjRmaksL0j6+RHkMxS2/JBPoGQoGkSvsbN9sYYk0xoKP7j+TfDTLcNsI0IUYZzPbSv2YRHCSG+UPg4Cf7nieka61BwdAP3z/Dy1zMDYgyMiYMvmhyImBzy3X2I99xiWrLPkOoqiltwjjqfsQkhi6X6yNJYnqRM2s4QwlYbdL+fp71h8AMiqDOfjeqaryr05WwmTjO39EGZGnxrbt6x50a+UxI32ciyp1d2ZVGhmU1E4walLEFuwO30hkKZqDWBsWPz6v6CDrcSa+Y6IuZpXG5DK1akOuaVYPLy3bV6g5Q6Qk7FO+y8aRfR+hLKauq5UDanWOBLz/z8gO8kpwe4hgHBH3i4OQ2qy5g4gkzUhdP+IZohC+TNE6IjOJpthBJaJ8iucjDYU12INjcHhn9btoE+TkLJNOPGtKiW7PytBUqvQWfn3E3OafokUEO9LZjz3b4hzkICAdeKyk6l3lTyx6IkBKUdOix44UaWyRGmBNam40Qkc2sodpUnCQDPfPpGqdl18FP68I/qfTKTppBDiLG0Kf610hcSbtEGh4Pw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDZyenpTRm9OT1dIZ09lUUo2ekN2VE9KV1kraFA1UHBNeDR1Wks0YldUbU1j?=
 =?utf-8?B?K1BiTXc3YWdMTUQzS1pTekRic1BHMEprUi9zdDlHZXhnTUVJNCtNMXpLWjFv?=
 =?utf-8?B?aW40WVQwai81U3l4cDlVWHJvOXdaaS9qRTU4cS8vRVNqT3c1Z3NvSDJZUHVq?=
 =?utf-8?B?TE1oSVU3Uk9sdENCSGl2bEZFV0pYYW4wLzN6RzBNY3VES1hVZitqWlNHbEJC?=
 =?utf-8?B?eFVjdGhjczlyUVoxWWVpdmw4L3E1YUZhVFRnNWRNL05KZjlMNEdaUS8zdGcy?=
 =?utf-8?B?WkJnOFdOSzRQZFBnMXhzZjd6ZEppTUlVTlArMjhTVjdiSVpUZE9kalhzeDE2?=
 =?utf-8?B?VGtMenNYdnBvaUFvZU50UWhRQVBiTXQ2cW10SndzRTNXQ05EUjVNc0JMVjBo?=
 =?utf-8?B?ekxscnNlZXBPYnBzMW4wN1VyTDFuMVZRSzkzQ0N0emtMYjc4V1VMOUwyQTc2?=
 =?utf-8?B?cUo5Z1JIUnhYSUw4YmhEQVp3M0NzYjg0VHoydGNaeUpBakx0ajEvVDN1TE4r?=
 =?utf-8?B?OWZkdk1idkowRGI3TFFjTHA3VnVkbmU4U3Y5RWdTQ25Mazgxam9mL2hUVFVY?=
 =?utf-8?B?bWtocDJUY3pBLzJia0J6U0F6NFVaMHIxU2RJOVdBcGNvSGl5L3Nyd1EyZjAr?=
 =?utf-8?B?bHF1NjhPZ1c5S0Q3cmRKcTJGR3htdUM0Z2REbWI4NmxhNFZCYVZzV1BCU2xj?=
 =?utf-8?B?MmNvYVl0YlBjRDJHN25Pa0FKV2t4ai9OTmdDRVo0N1RrRWtVMC9NNWQ5dE1R?=
 =?utf-8?B?am1xZ3ZxL282dWFkZXNkRGFKZmFTalJHVkF2UXZwazdyTjh3T0w1RWNXelRq?=
 =?utf-8?B?bVNBTUljUU8zSGJ0ZzJtMHdzbmVrV1c4ZnBtY0kwTmZIWUxPcEQ2MENoZ3Qy?=
 =?utf-8?B?L1FDZ2pzRHEwaU5MdlFTT0QyM3F3N3pBNjRReWRwY2t5RVZpVUFValhHQWJZ?=
 =?utf-8?B?K252dGdxdmhDUE1TVVBzdmdUYXdDMEZ6VXdoL3pmVGhmR25zcVJURDhKVmhN?=
 =?utf-8?B?djkzbzBlK2xhSk5nMkx1R29ROC9lVGRKMlRrNFI1UFVYeEJBK1MwU3dSajEr?=
 =?utf-8?B?STl5RHR4akw3WDltdjZuVkFKaEtkeWpiM3JkbTdWM0tSa2ZpNjVMemxDcjM0?=
 =?utf-8?B?NHViR0VVbldmTFNlRno1eEw5cTNxWS91L2VrTUdZaWJuSTd0NXE5RS85N3ZO?=
 =?utf-8?B?UDdmVXBCUjJqMHVDQ2RFMkhBd0hNdDdsUXFvbTJGL2lWazAwVWRZQVE5b0k1?=
 =?utf-8?B?U0hPcmtydE1rekpkUURNN0RYZ2ZHS3BEY2tzV2hJWG9UUDRXbDBncXdCYit1?=
 =?utf-8?B?V0d3MkhrSm5uQmFpaDFBOUIyR0pkMnpOWndGODVicStXN2FzT1dnc1VoNUdC?=
 =?utf-8?B?WSt6ZHdFako5TU83Wko0eVpMTm1vRXlncEcwM0laWm1lNTdVWEJ3OUZWVEtC?=
 =?utf-8?B?N1U3TjRHaTJaRWZ5aGZjMDVCcVgvb21BSzNlNHZaMGtjM0I2U0hwRjF0KzdU?=
 =?utf-8?B?SGtkZUpYQldBVmIxbGxyUjNHdWhtaEgvU0tzU21pQWxudERjTU01WVhuTkVR?=
 =?utf-8?B?bnFqVnprQVIxRnNZT01mbG5tdkZIcUlyWUladmhzaE85ckdtTlVDL1haRnVq?=
 =?utf-8?B?dVZZc3dsem5XWkpGNzNYNXJnZEJuQnpIbUlSc0FQck90cWlhTVAxUFZySlFp?=
 =?utf-8?B?RVZZeUo5ODZpQTN2b09VZTd1OUV6RERWQlNYNGl1SXRoNHpGMlo3bzJ3bmNZ?=
 =?utf-8?B?NERnbkNpVFpUb0tNUSs1MDhMZ0taWVhnTVU2OS8rbk53ZWFhVVRRc1Frencx?=
 =?utf-8?B?cy9qNXlFUHJXblVVcENEOFR5WVRUdnFrVC9ub29IeWY0Z3dVbTZ3YmQwaWpo?=
 =?utf-8?B?ajhHMFAySHhqQ1lsc0c3NDR1SnJqYnBSZTZ2eXNGd24vUE9ZVEhkaVFUSUxj?=
 =?utf-8?B?TmlqNExoeGdJcVZla1RZNTNJSFVPdGdlY1BuTkZhZXNvamF2Z2ZVVWxDWWky?=
 =?utf-8?B?T0EyYVhEWE5iaTZUc2JkbWo3UklTMjRoRDcrREVKVUM5UFlORzJNakZMMDgy?=
 =?utf-8?B?UXcrM1M5UlFJQ0gxSnJ4SUpvTU04ZFVsdWJTTzlOcjhGUVBEOE1sa2NzemVh?=
 =?utf-8?B?bWxkMmZtMmw0VVAxWmdiZ0xmTGI3OHZoeVcwbmtDY2R2cmQxWkUvUlV5clpk?=
 =?utf-8?B?cWZZcEZzd3JJWE9VRGxEU0c1VVlLbXVQai8wRlcyMy93SnZZd1BSQ0RsUVNB?=
 =?utf-8?B?blU4Z25ERlhhbUNSTkRFUjlvYlRrTmRueHRUbVlDWWdhMFp4dzB0U2pGSzlL?=
 =?utf-8?B?bWthUXgvTDhnVTdVWHpvRGF1SG1NOVprSFRvUllwUDNnbHpBQzNEUHRBQWdU?=
 =?utf-8?Q?box+ePoxZ2jyd2Fui24nX0Q+tB3SHXnK1fHcv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13edf495-46ab-47de-e406-08de79566480
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 18:55:09.4874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8WViLH73UxLnOSXU/NrSgh5wSiRF4Len9PB7327PdPLYJpwTuXO3RplT0jamIT9key0UUhwLL3FlNdML975Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8026
X-Rspamd-Queue-Id: 271381F585F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263372-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,weissschuh.net,gmail.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Action: no action

Bitmap API has a bitmap_print_to_pagebuf() function that is intended to
print bitmap into a human readable format, making sure that the output
string will not get big enough to cross the current page limit.

Some drivers use this function immediately before passing the result to
scnprintf() with no modification. This is useless because scnprintf(),
and helpers based on it like seq_pritf() and sysfs_emit(), take care of
not overflowing the buffer by itself, and perfectly print bitmaps with
"%*pb[l]".

This is a resend of networking part of [1]. Patch #2 switches from plain
scnprintf() to sysfs_emit, as pointed out by Thomas Weißschuh. 

[1] https://lore.kernel.org/all/20260219181407.290201-1-ynorov@nvidia.com/

Yury Norov (2):
  octeontx2-af: siplify rvu_debugfs
  net-sysfs: switch xps_queue_show() to sysfs_emit()

 .../marvell/octeontx2/af/rvu_debugfs.c        | 28 ++++---------------
 net/core/net-sysfs.c                          |  2 +-
 2 files changed, 6 insertions(+), 24 deletions(-)

-- 
2.43.0



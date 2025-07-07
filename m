Return-Path: <netdev+bounces-204451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF87AFA94B
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 03:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3B5163E6B
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 01:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11253273FD;
	Mon,  7 Jul 2025 01:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="FQxfsqel"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023139.outbound.protection.outlook.com [40.107.44.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A377483;
	Mon,  7 Jul 2025 01:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751852939; cv=fail; b=HuPUNBimjERi7BwDv7TG/St0mgLfWvEKbuShSEh6jvxvZ6E73mbb4nfzWrYwZngU7c23IlSNgka2iz0Fun0T2sDB2Yuw+ImWpYRJwDnFxhisv2c2YDU+LNKhW+T0cjE2yCUl308PDGQD1JXQ3PeKF38oivYBeRyqAKafc6kROP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751852939; c=relaxed/simple;
	bh=uBT1pM082rcCtcdBi825sEAWf6/4xaX5RQvd5+fc3/E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mheLcwKtAlDhbgn5r48cUKzC4CieLBNiZhFK1ARz2JaswCNb6LtCAPpaz1l08TBNCGSB0wjK4SPThQJq8xUib5XOCn3BaIXz03C2tcBE8sXaGSDOy9ZaEta7OUuXdtjGFL+Poq8TYvBVF0i5Uwuo5UWI/PfqvWeCC4gapv7CQU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=FQxfsqel; arc=fail smtp.client-ip=40.107.44.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKgoVjWlQOfd8S++hMiNUhiN2tH8fONUe4qiFfsNed7quHZToV2hhGRRN73EBFmWkWhQrFNeLGWBgEpCBdeH5gX+10FYJ17S64KoHIu8o0Em/aDnEYXEp1tmzsnaJC4Qo4I54XVdmgtElsF2NgIeCQkCGUSSiihOEebLLQ4IfU8dfbmQRqOZjNc3YJtFN2cCZ/w7i1587O4H2IYrqPNZwCFOjPdfnqGcfNdiOAeERgH6W7QB5xNFqBF9ZTDZQKiNMB/zfrevwAWMmdseYOsgG0l83kev9G2eVxCUgRyhA90GqoNO+1xjS6EtvHVh3cVG/9SD4Sy+pTPo3YrxMBwqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7F5e9T8kUDHlluqM1t4YmSkuLkXOzvw7ivkRclubns=;
 b=l1QWqNnUE0cUQGPXAyKoWYzJyP7ZSLF+igNVEpIOwiS/xYXtGWf2yQVuAE3QV7hqRfoNs9jrjRLq/0srhDQCKn1XZAVEL+hEg9f4KMr/ZFQDSfRS/SWibJCCvj9ZPSmIZsNNCZesSMBdHoLKdnIjOQF+oD1Lv4ma28/7FNy/nf8zi22cJvLFbTTragj7cL51bXKM4dHNZExwSoP+q1quY3HcfpVlzM/NoHyG0JNtxHDRZXEa8OyiomjuhAQBNDdyl50PPsn7or74T2Mcf8ygU+fDzUjqromgjasM1Dh51BzyOQfW+P+CIrs9TrezAWaEGLQnUNJrjUQz6nhhmk4aEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7F5e9T8kUDHlluqM1t4YmSkuLkXOzvw7ivkRclubns=;
 b=FQxfsqelU+T56eQW1npCbpQ9X4ETU7lHZ6jLwuSv457hP1maeazIUejZejEu5am7c6xDkh4IScm58jlC6z3BK4gIb3UvwlxYqwGOccIYkLin22ecvD5ER885dIpNLxrzK5anIDVuVXogeqvPyw0W5VMfmL6cybT2D/RAb39DvYcapaCGN3DmPxseZHIHwx1ZEK3vKAUSatb7TGwDDxwF/XwJo8oeryAGr84RuVqf7uz11Omr+OvORTguK7afI6TRnhMxLDmTfhD55DKFpDRFRc43RSV6NLpWuvTCty2mfyiQOU/Ts2TuHm1RInojtPl9yE2BXRULXxhfyOZSZqr8Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by SE1PPF3E08D6FB0.apcprd03.prod.outlook.com (2603:1096:108:1::84c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 01:48:48 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%7]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 01:48:48 +0000
Message-ID: <df9f6977-0d63-41b3-8d9b-c3a293ed78ec@amlogic.com>
Date: Mon, 7 Jul 2025 09:48:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: ISO: Support SCM_TIMESTAMPING for ISO TS
To: Pauli Virtanen <pav@iki.fi>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250704-iso_ts-v3-1-2328bc602961@amlogic.com>
 <bebb44579ed8379a0d69a2f2793a70471b08ea91.camel@iki.fi>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <bebb44579ed8379a0d69a2f2793a70471b08ea91.camel@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::9) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|SE1PPF3E08D6FB0:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0b2ce7-9afd-4d48-ceb5-08ddbcf86a5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmxOaDVPMjRIbFQ0VGRveTloWkJZdEtMclpiV0IrYlkyVWE4WkxheGIydFQ5?=
 =?utf-8?B?ZWtsOFhmd2Y0Z09uTjlxaldpQWhETjk2TTR3aUdaeVlyd3l0WWNMTWRtSmcz?=
 =?utf-8?B?NUIwUTZDejFROERWV2w2UW5BdEpKbXlwbWUzSmdPdktaaTVRSUh0a2FDWkRO?=
 =?utf-8?B?TXdIOXJ3RkZMWEtHSmw3b05DV0JKemdxNit1QWY4cG9vVFR1d0krQmJNVzZi?=
 =?utf-8?B?NzRvSmp0SE1xVWQvSXVmeUhKZ0gvWnVmUjlOL091cGN3d2pFazZMcHJrNC9E?=
 =?utf-8?B?RE5DMStKRUlQZk9iZlhwTzNsOE5OVm9yK09wMWdVR1pzaTREYXVIVVNPR2dX?=
 =?utf-8?B?cEpXTGhXQnROM0V5NWcrYzRDY2NvdVhONDB1azRCSzRjbm9ENDExREN6Vjhu?=
 =?utf-8?B?S3lRZzlXSmF3WmkyYzVHQlVzb241akRYOHNnc203WHhFQ2pLWGZoR2hId3BN?=
 =?utf-8?B?NDAyTHRaQVdRM3ljYzhyOUVZaFpHQWE0U3NXUk5yS3NIOVZFZWdZS0FUUGox?=
 =?utf-8?B?ZlRINDdaUUpTZmh5TExpVWkvd0YyaDEya3gvYXBCcVIvMkFxckVydFZqTW42?=
 =?utf-8?B?TW9tZmpHSDU2bDBmeWtDckVtWnFyMFRNSmpFL2lqekVOTE5EWVl5RDZYUmpZ?=
 =?utf-8?B?b3RJa3paZEk0ZmRNODliZjlLaDdvMUJNc3JkZXhGa2IzTi80andPeXQ3cUJQ?=
 =?utf-8?B?ZVFLd0VTaVd2Yk00eitiQjBCV2ozdGpvMGlmb0ZvQ0R0RGZqYXhpb1RQVE9O?=
 =?utf-8?B?NFpqNmtJQ25lRmtTbzlHVXUvVmNCQ0RvSFJadENBUFBXSE9ma2Vkek5XaUhW?=
 =?utf-8?B?My9Lb2FSQVZ0azFRUWRPOW8yVFRCWVdQY3JRUVRab3FrWW9oeldXYnBRQnQy?=
 =?utf-8?B?WnluVnIrazcyQVg0SmtoM1lmVEs3Wlh4N0JvQTRka2dtalNvOWJ0UC90U0I0?=
 =?utf-8?B?VzEyNlRycERJT2FyUGtXRG9Ma05wVDFLNlp4Z1JvNkpjWDF2UUx1cmtsb0Ni?=
 =?utf-8?B?dXNHTGVBLzNaMEhycEwyVmZxN3JWdXJoUWhLU0FwT0lnc0NyQUhYVjFvTkJV?=
 =?utf-8?B?U0VmRTVxSStkZFJYanVRUys5N2xCUHlWWGxFS1lXWHpGYVBmaitSQWJoc1VY?=
 =?utf-8?B?eTdKOFdVbG42eVFZS3pHdkNHWWN6K2lDZWdQUGFkLzZtR2FvcW1aQTN6eHg2?=
 =?utf-8?B?YnRKNGdUUFoyalBDVExGdEt2U2QvRWdaSER4U2poSnFRUnpLVWRXRHVERFNj?=
 =?utf-8?B?eVp2RkV6WFBLVjFsb211cU5JVklMeEpBR0VEeEgvMVdWa09lV01YUmRyWi9q?=
 =?utf-8?B?Y2VjSjMzcXFXZTBmYThWNmdVN1dFOGJmM1MzbTg3Um1JUzNoRUpOdGhtd2F0?=
 =?utf-8?B?RkJEWG9SSXpCYWM1SGhIRHkwZnJnZXZRbmJ2UTJmWkpSSjB6bW90c3F4QmVI?=
 =?utf-8?B?VnpVUHhXdXpqMVg3bEVNZWdBUVA4Q3AxNnRkWkNxUXFpVy85Mk1xODhvWUVv?=
 =?utf-8?B?dUdUVHVtUTNsZ1Ftc1laZm1NcTN5MGFtb2xqNVhDc0RwMUQ0Si9INXBURkNo?=
 =?utf-8?B?L0lYMTd5ckRjY29uTG1DYS9KKzZSZzgxdXBSNlNmUEhqMjNvUWFCTTAyTUJv?=
 =?utf-8?B?TVRVM2RybWZZV2s3eCtGckFmbjR2Tk1ZMXk1N1JpRmQ3NSthVG5NS25yVU9H?=
 =?utf-8?B?WXJ5L2o1Zkdpb2YwSHh5Ym1ZRFM1cmVHeEJyOEU1ZURFeWp1L3NsSXBQbmNz?=
 =?utf-8?B?dWNob2gvUHk0eE0vNFo1akx2M1RFVFVZaGxOdDNxNndHNzNjaGNPa1NZdFlN?=
 =?utf-8?B?SmROd3ZUbTVGMUhNK3RnazZRaDBtWm16UWRqc21qN25OeHJzRzNFaHo1Qzkx?=
 =?utf-8?B?UlFZVFBWYUUvUDM4T2NaK3l0ZDQyRjFVWVAwUDNKTFZPejBXeEpMU2xDQ0I1?=
 =?utf-8?Q?2ZXx6FnXmQA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RllSZkszWWpYNExmTDVhUmdrait5TzQ4L25kbVhIRmU5RWtKT3gxWnluU0Ri?=
 =?utf-8?B?aGlEeFFoYVpYU3FjOHNaYVE4ZEVGS3FsQ1dTbkFYNU1rZlpyaGtjQ3Z3dm1k?=
 =?utf-8?B?ZlNnN0l2elQ1cXNadjNXT2swVHM0UHVGenh2ajcwLzNUdmRhR2tlMHlYZXEx?=
 =?utf-8?B?MFZ4dDZvQ3BSN0J2UGtIcmdNS2JqUFhiM2M4YTlseDZlTkVnQlFER2Y3L0tp?=
 =?utf-8?B?azZZVEFRTnNIcHZ2NTVDUGJtSDhRU2U2a2xpelhiOG5uUmhUTzhGSFdKNE1Y?=
 =?utf-8?B?cTVva3NmRWViLy9uUWJhWU56SkNaSGduR0tIUjNlWWtNSmpRcGc2dHMvT1hJ?=
 =?utf-8?B?eGdaVHdEcGJwcXZjRTMvaFd4dW9IMk00cTdDRzY2TzJXVFo1U2dERXZNcjlG?=
 =?utf-8?B?NEJxcnRuNjdialltQmRqMi8wdU5LL3Zsa0UzOTVDTDNkaGFwUXFvZkJTUUpq?=
 =?utf-8?B?TVNtUFhrZ250WnlrU1AyR0dudzhLUkhRUkNYWGRMRHZ4aVE4K3E4d2tOc0xi?=
 =?utf-8?B?RmFZbVBJL2RxVmptemxRQ1NiQTUyYXNOdzJDbHFRSGU2SHBsbUdLVjZZNHYv?=
 =?utf-8?B?SVNnSGxlVEdZSlBJOTdENmpUakVZY2FZMkoxVmpsdkpoNVdpQk1mdG5HS21X?=
 =?utf-8?B?T09YdU5BVVNsWTJRTTE5V1FsUk5iaW5KK01YeHBxNTErNVYwRWNWWUJ6anVi?=
 =?utf-8?B?anExeURoZGxZY0Q0dmdxblBtVzNEUy82NTY0WGcyYmp5LzNPVHhqTlJMWDYz?=
 =?utf-8?B?RFBLQkIwdVh4RzZkNUhwejYwODdpNjFaUWtVbXBpMUhlYWRIMzl3UlRHdjZz?=
 =?utf-8?B?UUVQMnVoKzhlczhycmlmSTJDR1VpR05MM1hQMGdleHZoZHVUNDU5MXNFV25F?=
 =?utf-8?B?R2FjQmlXL0xvODJzbjFjMGJCMWtJcmFPekJ6TnNHc1B0VUtUY1gxaTNrN3Nl?=
 =?utf-8?B?V2I0MnEyYXJWbmErb3p3Y0F4Z3dMeG9TTmUyNU5yYVBncStoS2MyR000Yzlw?=
 =?utf-8?B?QmNoRC9WblpWY01rMmtSUGVkRDJ4SGptQ0Vuayt0Y3JDY0dheFlSV0hGSWJH?=
 =?utf-8?B?aEo0VWkwellFSzJnUDJCdFR4QVJPZnFEVXlvb1NKVXlyMFJhb0h0Wi9GSVc3?=
 =?utf-8?B?VkhyUnlaM1ZlYThlNWRvdVJ4TzczV2VoS3NmQ2tFbVMrY3p5M2FkK3NUQlBG?=
 =?utf-8?B?QWw4dHNONW0vckZLWmU4WXdmN3orS2tCNSsvanB6VnRVNlpIK0EzVW5kVGhk?=
 =?utf-8?B?aVRVOWorSUh1VnQ1eWc0V0x1VDlOWE1JVjR0SzhmdGd1bldjR0xHTDNZdTNo?=
 =?utf-8?B?RmYxSkNROGNtY25DT3pFS3pObHo4b2VGUjNrVVVhL2d4SFpab2RINkNTTkZ2?=
 =?utf-8?B?RVRwNG5FMHZ0djM4NnllNWxhZzE1cnpJaXV4UW4wQXIzamxBajJpbHdweFFQ?=
 =?utf-8?B?Z2VSbzZUQlB6anZqWjUwb0xvYWV0TS9HUmhPUVIrY3JJaDlBZTNtUjlDNFkw?=
 =?utf-8?B?NmJsVmtwbWxpVVZ4MXl0ZXQ3bVhDaVUwYkhQdVN3d2ZjSXVlYUt0dmhUa0dv?=
 =?utf-8?B?NVc0ZlVUUVQ3cFFMVHpsdVJEMUM3UHpaWWhMRFlEYldlQkJ0NHNYVFV5MkZX?=
 =?utf-8?B?b0hPUmRiNTRpL0tCL0p6dlN0bGpoZFdFRUlvRjhvNjBGclVZM0U3N29JYXNF?=
 =?utf-8?B?dHFwbU5nZUs4dyt4U2x6TjRPUENqYXJHQWxTL3drOGh2YXIzdXArQVZNKytU?=
 =?utf-8?B?YUp6OEZtKzE1UGpWbXhqSElMbC9XZGNpNE5aUDkvT2M3N3FZcUpIbjJqSEU3?=
 =?utf-8?B?czBQUDRrMUpNcGNpRXliYjB2T0hscllkYW1UbytoaGtBWUhBN0NGaTdab3BK?=
 =?utf-8?B?VXpLem5ZejZwMHZWOHp2bFZHdFRsblk2Znh6S29ENEpCOHdUcnVZTFgvc2tw?=
 =?utf-8?B?ajVvaUxMYTlsU3krRkQ3Z201T2VkQThxMWpTZkJYVGRXSUdGNmw3K1hDaElz?=
 =?utf-8?B?TUhOS0x3MGk3M1ZTVWM3RlNiOEVKaldCcEFEVWQzdlFlaEFhbkFDc3QwNDQ5?=
 =?utf-8?B?dTM1c0oyVzJXZ1ZRS0s0VjhrYmxON3VwZkM1RTlRV3kvejh2R2lnRDFmb2Vy?=
 =?utf-8?Q?C5PChHPZhulynJy/P31hlTE3y?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0b2ce7-9afd-4d48-ceb5-08ddbcf86a5a
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 01:48:48.0185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/DMhPrP9Y6hxS2hL5vP5pXOpZDtg/07Tz7FRxJoB+Lar3s2jtGKRbDm9b79iLTG351plIFU3LEtmSxtSNYGTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF3E08D6FB0

Hi,
> [ EXTERNAL EMAIL ]
>
> Hi,
>
> pe, 2025-07-04 kello 13:36 +0800, Yang Li via B4 Relay kirjoitti:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> User-space applications (e.g., PipeWire) depend on
>> ISO-formatted timestamps for precise audio sync.
>>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>> Changes in v3:
>> - Change to use hwtimestamp
>> - Link to v2: https://lore.kernel.org/r/20250702-iso_ts-v2-1-723d199c8068@amlogic.com
>>
>> Changes in v2:
>> - Support SOCK_RCVTSTAMPNS via CMSG for ISO sockets
>> - Link to v1: https://lore.kernel.org/r/20250429-iso_ts-v1-1-e586f30de6cb@amlogic.com
>> ---
>>   net/bluetooth/iso.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
>> index fc22782cbeeb..67ff355167d8 100644
>> --- a/net/bluetooth/iso.c
>> +++ b/net/bluetooth/iso.c
>> @@ -2301,13 +2301,21 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
>>                if (ts) {
>>                        struct hci_iso_ts_data_hdr *hdr;
>>
>> -                     /* TODO: add timestamp to the packet? */
>>                        hdr = skb_pull_data(skb, HCI_ISO_TS_DATA_HDR_SIZE);
>>                        if (!hdr) {
>>                                BT_ERR("Frame is too short (len %d)", skb->len);
>>                                goto drop;
>>                        }
>>
>> +                     /* The ISO ts is based on the controller’s clock domain,
>> +                      * so hardware timestamping (hwtimestamp) must be used.
>> +                      * Ref: Documentation/networking/timestamping.rst,
>> +                      * chapter 3.1 Hardware Timestamping.
>> +                      */
>> +                     struct skb_shared_hwtstamps *hwts = skb_hwtstamps(skb);
>> +                     if (hwts)
> In addition to the moving variable on top, the null check is spurious
> as skb_hwtstamps is never NULL (driver/net/* do not check it either).
>
> Did you test this with SOF_TIMESTAMPING_RX_HARDWARE in userspace?
> Pipewire does not try to get HW timestamps right now.
>
> Would be good to also add some tests in bluez/tools/iso-tester.c
> although this needs some extension to the emulator/* to support
> timestamps properly.


Yes, here is the patch and log based on testing with Pipewire:

diff --git a/spa/plugins/bluez5/media-source.c 
b/spa/plugins/bluez5/media-source.c
index 2fe08b8..10e9378 100644
--- a/spa/plugins/bluez5/media-source.c
+++ b/spa/plugins/bluez5/media-source.c
@@ -407,7 +413,7 @@ static int32_t read_data(struct impl *this) {
         struct msghdr msg = {0};
         struct iovec iov;
         char control[128];
-       struct timespec *ts = NULL;
+       struct scm_timestamping *ts = NULL;

         iov.iov_base = this->buffer_read;
         iov.iov_len = b_size;
@@ -439,12 +445,14 @@ again:
         struct cmsghdr *cmsg;
         for (cmsg = CMSG_FIRSTHDR(&msg); cmsg != NULL; cmsg = 
CMSG_NXTHDR(&msg, cmsg)) {
  #ifdef SCM_TIMESTAMPING
                 /* Check for timestamp */
+               if (cmsg->cmsg_level == SOL_SOCKET && cmsg->cmsg_type == 
SCM_TIMESTAMPING) {
+                       ts = (struct scm_timestamping *)CMSG_DATA(cmsg);
+                       spa_log_error(this->log, "%p: received timestamp 
%ld.%09ld",
+                                       this, ts->ts[2].tv_sec, 
ts->ts[2].tv_nsec);
                         break;
                 }
  #endif

  @@ -726,9 +734,9 @@ static int transport_start(struct impl *this)
         if (setsockopt(this->fd, SOL_SOCKET, SO_PRIORITY, &val, 
sizeof(val)) < 0)
                 spa_log_warn(this->log, "SO_PRIORITY failed: %m");

+       val = SOF_TIMESTAMPING_RX_HARDWARE | SOF_TIMESTAMPING_RAW_HARDWARE;
+       if (setsockopt(this->fd, SOL_SOCKET, SO_TIMESTAMPING, &val, 
sizeof(val)) < 0) {
+               spa_log_warn(this->log, "SO_TIMESTAMPING failed: %m");
                 /* don't fail if timestamping is not supported */
         }

trace log：

read_data: 0x1e78d68: received timestamp 7681.972000000
read_data: 0x1e95000: received timestamp 7681.972000000
read_data: 0x1e78d68: received timestamp 7691.972000000
read_data: 0x1e95000: received timestamp 7691.972000000
read_data: 0x1e78d68: received timestamp 7701.972000000
read_data: 0x1e95000: received timestamp 7701.972000000
read_data: 0x1e78d68: received timestamp 7711.972000000
read_data: 0x1e95000: received timestamp 7711.972000000
read_data: 0x1e78d68: received timestamp 7721.972000000
read_data: 0x1e95000: received timestamp 7721.972000000
read_data: 0x1e78d68: received timestamp 7731.972000000

>
>> +                             hwts->hwtstamp = us_to_ktime(le32_to_cpu(hdr->ts));
>> +
>>                        len = __le16_to_cpu(hdr->slen);
>>                } else {
>>                        struct hci_iso_data_hdr *hdr;
>>
>> ---
>> base-commit: 3bc46213b81278f3a9df0324768e152de71eb9fe
>> change-id: 20250421-iso_ts-c82a300ae784
>>
>> Best regards,
> --
> Pauli Virtanen


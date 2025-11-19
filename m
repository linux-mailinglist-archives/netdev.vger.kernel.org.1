Return-Path: <netdev+bounces-239835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 304B8C6CF08
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 07:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 03DA83546E5
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 06:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2240C328B69;
	Wed, 19 Nov 2025 06:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NT2Hn4as"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F06B31A056
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 06:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763533594; cv=fail; b=VAEoafskH4e3gqbReXtZ3YNcrmqAbfvL5zKVY2zYIFUnADEJMIaMdYv7MiERD7s9iR7IiKhwEzZ7zIWoGIFUzQ0VukK5Y4XchSsz1Th1DpP8pgxKuJqTkmT0+0r33QzR05aqrJ6TSgnnJtLHkdHPJLusxjB/aLrPIGWM+oB9dSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763533594; c=relaxed/simple;
	bh=sVAQ2KZw6h9hKQY/ue6toKN7gl3AJEX/k8wEdAQOIzE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M4EFzNPsyEOhzbuGMlHy0MABT2BYLoFRoV0KQ5XV3aLhV28OY+j4bOM7/sCLJN7vZmiB5ow8v+6EgmlKbh4V/G40San6+U4LmxpG4JxTBdwaD8vFwkx+MrCzWLQnvBNAQan9akib9lz2d7oJcxxjE3NBBHlWJ5MMMm9T+CZ3qsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NT2Hn4as; arc=fail smtp.client-ip=52.101.85.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5x4dhGNAujWDS+WdNtxqJUu3+Cev0jZUGv9tKV7Q6Nj+mz59sBIu+m7UedFaR+uQm/lHHKzxSwZWJL6OZNWchujq8qJPvPVafFHpbUGSCknGzwzqbH3eTtHc4umCWeIOsP/WRzqpZCxdVYgkau2JOPKR9ltqvSr1VZ+YRED4kl9gzJtlCi9Df+QFQzmUdYocV6d4znhQgyLhSaoSAY7TSqz0Ph4ekoLXLT0BQHn46GTFEIUjzYoeJA3VUHaDPHp+NgHk51jPeKvaVkO9KId12nZXIMmZ47Hc1h/pUhvIPVavvEZkwmJsdJxock+iuSqztkW9DNI7MKl7tcd7b/RvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DU73j+BXHH3NXRbQYu64+lRPKkI/zGWvo2J2TNY4St0=;
 b=JLK0yR5xL+6sZWe/8sS0qv6TLr0eQ3BDgQu+u4MG7LeWO2KyDMx+hwdL0Sduu1jq6YGS9NyWikrd///spFUA+wQH03jN2u8/dwx8clm27owmyDggMa4Wzg5r98q3DtIWEt+oi4FAZ1soVwtOHQSgFNjCOTL4yqda67dCVjjo5MdLqx9RAWL65u3BAiO27BPoCBlYVMk0LvU19fhSUnLwEZqgzivB/PM3DaIBQ2+PHq6IVPtrVtRo4pe5CQMJuwfpOzuJ7guZOZ69MOfufLsNILBm8EZnTOAFAMHLZ7RhXbZXX6IYwNNAnKVCElOI3zmDUG2qdCXvkxKFSmmt/kFImw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DU73j+BXHH3NXRbQYu64+lRPKkI/zGWvo2J2TNY4St0=;
 b=NT2Hn4aseNDtj+ezmsv9iGWojXYgZQOXwwoDszrAoKGsHQ7KwdNwJ6hYl/PsQkDHygVOvrLqyl7NRvJiTkbKxV8T+05K5FNc+fKyRssNuY2TTBkgUYPRf51PhowLDc9z4vqPxosPKKyxtDLSiJcfwzkN3gXF7g12vmxovacTaQu90oGnLAh6DFdtrKDcB7NhyacSC4+5KMJQJ9eMFMzGqGXXnKj+JFhUlYN3ejTBEstt5wqA37ZnrzBzPjWTmLygJ7TeMYaJsHGwnP49awSVYpTQS21pUoCkn1M2QW3NPxTi3CHi520xRqy2KS9YutKh3iSJeO+BXvrMmaYkXL5QKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 06:26:27 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 06:26:26 +0000
Message-ID: <cb64732c-294e-49e7-aeb5-f8f2f082837e@nvidia.com>
Date: Wed, 19 Nov 2025 00:26:23 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 08/12] virtio_net: Use existing classifier if
 possible
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-9-danielj@nvidia.com>
 <20251118164952-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251118164952-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:5:bc::30) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|MN2PR12MB4424:EE_
X-MS-Office365-Filtering-Correlation-Id: b50371c7-7907-4580-bd0c-08de2734917e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emdndlFlaVJkRWMzUWdrcDVwaDMxaE9GV004YXcxYWJQNm1KUU15NS9XcURL?=
 =?utf-8?B?ZW5NS2ZvVVZhTzRXaHN1Undxckh4WFJGeUtWaEgreEYzRStJVHUycXY3V204?=
 =?utf-8?B?UDNhOWlVdG1KR2ZrNno5ZUVZcE9NWk9ybVBmcnI4ankxR1g2MlJSaHhlbm5s?=
 =?utf-8?B?dk1OM2IzcWJNbU1jRmt3a1A0NU9CMXMyeElHc1c1b3dmTWd5cHdjaGdwUG8y?=
 =?utf-8?B?WmtmOFc1L3dNWlAvVnBOUnRKNFgydCthNERzbEF3M2piODc1ZTZTbVF0cStp?=
 =?utf-8?B?THlKRDJsWGRrOWQ4QUpwcGVKcjlocE9nK3NLVHYrTG1qVlRsLzZ2Qk1tdGpl?=
 =?utf-8?B?YmpqdHh4OXBVZmxsSUZ2VzhpUmQ0Z2h3YjQwajg1VDUzNjFFV0R0Q3JESUxM?=
 =?utf-8?B?elBHZW5aV2FGSjFPR045K2xwdGlDWkwzQ0kvYno1OFNwY2tSdkcyTXd5SXNO?=
 =?utf-8?B?Y3VyaEJ1REhvWCs3aUM0STBKN2VLU1lGbzVqTGJTS0pxOUJrSm5EdDhOSUI2?=
 =?utf-8?B?NE5mcGs2TldJMFg2VzlPU3ZubWJvb1FtRS9oS3d1aWNaa1Y3KzU4N2NZbnY4?=
 =?utf-8?B?aEM4TlY5OGZ4REtIWXZjR0J2OEEzUnFqSlQ1MUtYM2I3UTNkTDlyaTZOMEF0?=
 =?utf-8?B?eUFSNnNCQzA5QUZHVGFLbDZwMk1CdEZWN0lZRS9kbTgrV2VvYTRCTHB4Mlhv?=
 =?utf-8?B?YjVMTWdRL1p0MzN4RVA2ZDVzNlFMN3hwQUxyL1ZnQ3U2OFlzSHg4Nnk0Q3hL?=
 =?utf-8?B?K2tqR3hUdW5WN0lCMzZVQzlwYjlkSEwyZVBpTGxIQlVuSkQxbGxpT2sxWjVZ?=
 =?utf-8?B?NFFUVmFFVGs0M1JmQ2FaNTFSYVloR1VMLy83SDVkNTlqUTZNcXVwRUttUHAx?=
 =?utf-8?B?WjZSdm85cXdvallpQWg5TlVWaXZMRFI1bkVBTEd1N251OWZnRlBDQXRIQUhT?=
 =?utf-8?B?ZklwYVdBNGhpTzFqamZYV3E1UWdjMGtFVmNRMmZ4cThISnRsM2E4ZUg2YWlK?=
 =?utf-8?B?OUtRSTRiYWUzSUlpeWcwRmF6MzV6MWUvYmx0cEsvN05SRWptNHFCOU5oNEZy?=
 =?utf-8?B?bHdKUTdXZXF0cDVYV1Q0U2ptVWtpZWUvOS83ZVpYK2FKdEViUWRRcWoyWFh1?=
 =?utf-8?B?eFZVM1pKcUJWcWRnTkF3cmRkcndXS1BXZFc1SUZHMUQ3TEx2WXpGR2YwWlZN?=
 =?utf-8?B?NngvNTk5K0hMaEEza2dqVnJkNW81SDkzLzdXU0xBNkI3eldBeDJNUTlRTk1T?=
 =?utf-8?B?TG5wdTdmMURNOGwzbFFYV0MxUU5kdnZpVmc1WVcvRFkvTUpxOEZFcmNkeFc2?=
 =?utf-8?B?djl6WEcxZGJvdDV3YWdFUnMwL0ZHU3ZvMGZPaEpGcEs2M1R6S0hrK255Z2Jq?=
 =?utf-8?B?NG9QUTFrMzNka3FaYTJ1Ync2VitIeVBlQmwySWEwRHZtNEhRWXo2SVBVWlJm?=
 =?utf-8?B?am5YNmVDSFdOUWNiSHVvdWR5Q0V4UUlVajIreVRUT3VtcmZ3SXo1V2g0SDhB?=
 =?utf-8?B?SmJIaEVkaVVnV0pnS3h3UVZXZDZXREgrWW16SGhVNXJORVBobTFSdElsa0tU?=
 =?utf-8?B?YnpkTi90bDU3dTExdmYvc25MWHQwVWwxTmJ2ZmNtb3FwNm5QZnlxUFVpajZu?=
 =?utf-8?B?UjJoeEgzcXZVTk1EMXZPTkVIMHcxSklqQ0dyRmR4ZHRkN3g5Rm5vOTBnZTNQ?=
 =?utf-8?B?MTgrN3IvaHA5elZmNVJhUWplZFZaU2VMbzBkaUVPSHF6UFNHZG5CVW84WXB4?=
 =?utf-8?B?Yk5CL29zM2lHWTRnN29EcjlOWU5ZZGFNRUNOQ3h3MEs4dXNnNnNmZDlHdnFj?=
 =?utf-8?B?QWo5RzFGeUhRUENzVUp5K2d1NTRlYlFaMUtTWmlrNUlHU3lNNXdJNFU2QlFa?=
 =?utf-8?B?OFZuWGY5am1HWnJ2S2diRWFpRlltV2gzdTNmVStSQ0h2VllzaTRDUEZhMkR6?=
 =?utf-8?Q?ATu0aTcuWdGoA/HhNRm5dUJIGPoXXkjI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U21aVmlSYWtMRTJDU1Q2Y0V6R2E4KzJRTDV0VXoyTzZvVFhOcVRIZTd4WFNx?=
 =?utf-8?B?aU9ESU9qc3FKenZnbm8rQllSVXZ1TmlrbHo0RGE1MnNYNmh3WkRDRHpXZFFN?=
 =?utf-8?B?NHo4YkpPUmIxZWFDamJWelRuanlLamNtZHMxeVhWZmFabGxVcUtKZjFRTGZC?=
 =?utf-8?B?UzRMMFdWZllOb2tRTjBabEppV3lqNkp5b1N1WTEwOGVzcmhiMkhkUlB0blRX?=
 =?utf-8?B?aHpIWjZ0VDlIQlhrSjI5enA2MzRybVc3L0RveFlMWUx4Y0xYVlo3d2gzWlpu?=
 =?utf-8?B?V1Bvek1ROXFJQ3dQNGRFa2pmSGFyUW9TWFV4dEMzSG9jSUx0VURyM3RLKzQ5?=
 =?utf-8?B?V1F4RnlIK042NHNxVkFJTkRRRDJCVXJFa0Qwb0JITnN5czQwckx6djdzVlo2?=
 =?utf-8?B?ZG9MeTMzVFAzb2pQMUlodm4rZFRGOFVmQjZlRk1ZTXZpb2tmUXc2REg4aVBT?=
 =?utf-8?B?eHVrZkZxd1BGbmNWcjk4K0hTUFpRV0NFT2R2Mys0QXJMS2pVT0J5U3gyWVpp?=
 =?utf-8?B?eU5nK044N2w3VzNPRUxhYkRnYVp1YnBucC9ySlFnM1o5SmVadzNSR1owaXRa?=
 =?utf-8?B?QTJwN2l3UGJMeDhKSDVTZktpaDRSSFgxa3I1M1UrU0ZlTExKVnRiMWNPYjFs?=
 =?utf-8?B?R1l6cEVpUXRKSmUvZENoUEc4TXdPNXpRdkVMenlkVDJHY3FydGl1ZmI4MHpr?=
 =?utf-8?B?MTExZURGMmNPSXNaYnN4bFBGZGlZY3ZEVkY2NHdmYXNCUElGaEllU295MEVN?=
 =?utf-8?B?d3BUbERETlVuR2dmYVZqVWdIS09YZ0sydUw3MnJnSUVKaWVIc1VsSTVjUDNQ?=
 =?utf-8?B?aTRSbXdyVUdhOXJnaXcrdTFGVEJCSWEyQ0xEUzdkaThXQWtVZVBFTnp4ZU5Y?=
 =?utf-8?B?aCt4NmRsUWpvSEk2YTBCYVUyQ1lSOVJBRUNhTWZkL1V6ZmtpUkxrd0poa3h1?=
 =?utf-8?B?ZnFsOXk2ZnhZdE05M002dGM1K1E0cHlLYkEySUZIczhEVEVaa2tOMHV0QWlT?=
 =?utf-8?B?MXdyTjNlOExDaTdjQUFaUFp4bStvZ2dNbmNCK3VmVFpTRWVhUDZULzllKzhU?=
 =?utf-8?B?L0VMNW80TlBjSG1hS0MweElrRlRLQldjRXhFY3dZYnNTNEFVbmZkb2tHdk1T?=
 =?utf-8?B?VWZjWkJ6NDRKc0FtelRsaEhMTHhOdzZKQ1FZa282UDhpelhMbk13Z3hPMzhL?=
 =?utf-8?B?NnAwV2JzblJPZFVSVUlnWVE1NWlWZzJKaWIwaEdvTGdSVkRCbzZFZVJGanBL?=
 =?utf-8?B?YXAvSVBYdmV1VUxtcnhKeDhraU53bHFiTUNxc0VBQ1Qyd0tVdGNRNkNoWWRw?=
 =?utf-8?B?TTZ1bmpwUEpzUU9QUGo2amhIQS8vM3hQVXErR1ZtamExT3hHeUNGSlVHOEJo?=
 =?utf-8?B?NDQ0ZlU5UFJBSTQxeEt5eEpidmNpMEpjRXdVTGlzV3Q4NWVFcHpXTjdxem02?=
 =?utf-8?B?UTVFeEZjaFN6THpFbjJCcTczNStFTWJHYWVKblNMRWZXRjB3TlFaSEptMXoz?=
 =?utf-8?B?cEdRWjU0bkxxZDNrTjExd2U3cDIxM0NDczg5SGtSU0htSVFNcVNMdmxBcDZC?=
 =?utf-8?B?RHIxMk9xQVhPUGZsN3pYRWZTdHJwT0p6a2s4VVpITHhrNUxNZDY5SzJIN2pl?=
 =?utf-8?B?Z3pVc1p6Zjh4MkhuM2RhZ1l1MmN2c0t6NFNlSWVWNUUwdlVRanNVN0RUSzlN?=
 =?utf-8?B?QnVGV1pPZWFNOGRCRFdXSGQxZit5N1l0dzRkbFdnOUpTK3gvT0ZsWkpveVh3?=
 =?utf-8?B?aU5EZG84N1hsbVBVU0Vlazc2V0c5K1Q3b2IwNDd1K3pQVGxEZENxSUs4UXhs?=
 =?utf-8?B?WFlMWCsveEJLV29kWTZZUlVTMUpYQlZjMFVaUG5LNGtsSDJnbkxaY3JYNGlZ?=
 =?utf-8?B?VDlXTkVkbkhCeGtPSnVlb1ZYcEE4M3F2R0dDV2pUSUhkYUN4Z0RwcndGUWVU?=
 =?utf-8?B?TksyWHUyVGN2WFdsRDBRRnhLQ0FjeW9xTEcwYlBreW1xTDlmTFVPTUtNR1FG?=
 =?utf-8?B?TjBVKzMzcFZrcFN0UGkzS2NkT2kyNVdEU1VoNHFtQkpIUTgvMzlPUW5OMFZG?=
 =?utf-8?B?ZGNQaUpvQm9OdTVZS29ybi96c1k3OFgrckpxbXVuS2sycE9lYlJlMkNZSWJx?=
 =?utf-8?Q?f8dI1gBJ0Ju9sGeABZCllwK4/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50371c7-7907-4580-bd0c-08de2734917e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 06:26:26.7638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0fp2sVU4bc3UEtWdT/uUz7hfQzjHzUQ9mjP5nSrFuj7iFgbVJN5/GM2eet9FHVUdS86cqu3Na7F1ejFPsoGM0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424

On 11/18/25 3:55 PM, Michael S. Tsirkin wrote:
> On Tue, Nov 18, 2025 at 08:38:58AM -0600, Daniel Jurgens wrote:
>> Classifiers can be used by more than one rule. If there is an existing
>> classifier, use it instead of creating a new one.

>> +	struct virtnet_classifier *tmp;
>> +	unsigned long i;
>>  	int err;
>>  
>> -	err = xa_alloc(&ff->classifiers, &c->id, c,
>> +	xa_for_each(&ff->classifiers, i, tmp) {
>> +		if ((*c)->size == tmp->size &&
>> +		    !memcmp(&tmp->classifier, &(*c)->classifier, tmp->size)) {
> 
> note that classifier has padding bytes.
> comparing these with memcmp is not safe, is it?

The reserved bytes are set to 0, this is fine.

> 
> 
>> +			refcount_inc(&tmp->refcount);
>> +			kfree(*c);
>> +			*c = tmp;
>> +			goto out;
>> +		}
>> +	}
>> +
>> +	err = xa_alloc(&ff->classifiers, &(*c)->id, *c,
>>  		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->classifiers_limit) - 1),
>>  		       GFP_KERNEL);
>>  	if (err)
> 
> what kind of locking prevents two threads racing in this code?

The ethtool calls happen under rtnl_lock.

> 
> 
>> @@ -6932,29 +6945,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
>>  		      (*c)->size);
>>  	if (err)
>>  		goto err_xarray;
>>  
>> +	refcount_set(&(*c)->refcount, 1);
> 
> 
> so you insert uninitialized refcount? can't another thread find it
> meanwhile?

Again, rtnl_lock.


>>  
>>  	err = insert_rule(ff, eth_rule, c->id, key, key_size);
>>  	if (err) {
>>  		/* destroy_classifier will free the classifier */
> 
> will free is no longer correct, is it?

Clarified the comment.

> 
>> -		destroy_classifier(ff, c->id);
>> +		try_destroy_classifier(ff, c->id);
>>  		goto err_key;
>>  	}
>>  
>> -- 
>> 2.50.1
> 



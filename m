Return-Path: <netdev+bounces-257926-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNLmJI2viWndAgUAu9opvQ
	(envelope-from <netdev+bounces-257926-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 10:57:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E994910DD9C
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 10:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F87230075D9
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 09:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387E3365A17;
	Mon,  9 Feb 2026 09:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lkvrUKEo"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010014.outbound.protection.outlook.com [40.93.198.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DEC25A2DE;
	Mon,  9 Feb 2026 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770630853; cv=fail; b=hoqUz/ySeo6Ab6a9FVokGnqDomTKaQM92vkL4/M0otIlfqz1UIjxmKlye/nuK3lf5lsRnr+zMt3ff4Nj/LQ1sJGoIwmC1jm/Owl+6RptmFpvin6Aohb2vI0D/gPkeQugpnWY1/SR1EL8GHfutxpbXT3wApTjPef0CHpMF+2PBjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770630853; c=relaxed/simple;
	bh=YIqLAejiUM954/rI9PvfPKfXnDeKUQNtV8//EZZfYdE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NSZJc6cCT/lxdwzmVtjkRpj7gLbJeO2BhL46yytcqz44UOOupww5GS02PFtFoZvoBLz0/WBNxHvl3HClaa5EsYd0KQJqka7XTqQCi22ydVLNxxwdLEfjAWN/mE7BBHsrmB7JMrR3tZwDOeRaMUNn0Y+MGVFX5f+/5kHO3hkv650=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lkvrUKEo; arc=fail smtp.client-ip=40.93.198.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtbLeZWegETBHC7kvF/L1LhTInNZvULnfaH8o4keZ6V5K+WoUP/xWgvjexf+bwiQV/MRv3RPKYMUvOHQ1q/axfZqvdHYagDsAEWiBLQ/5A8jBHtIqh+GE4zxWcyb13uNWvmel/GUtCghzNHGhYYqMkoBr5yrx66+TYw4VedBWvptR0eymPXJw+HWbw4WokrocSziVGkBWauwQk4oDqb0TDHeHAfeGq1iwjOPQElS+CMGDUz4jXS9NiZ9XfUDljHK5u6hGQz5NUX3AhfYqhtp3aIx6V2BUYS5IgTXQNx7ckHxN6w8TO+Sn16GjfMhpvnEJONlxoey5uCzgnWRpBO/cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIqLAejiUM954/rI9PvfPKfXnDeKUQNtV8//EZZfYdE=;
 b=mLcAfJ9G//NmUOuKjmdKpw4yFkIC8K3yZGlp+sURqdr23qljBXwb+//JWcRtrID+EFZgqAQ8EN4Hb1ZssKjHY4U8Ufad8hsiSFPNv1Pz1xW0jY/TsDxre8xHCIlNjPzIxZOs4RTq2tw8UXv2uhJXxFkbogj3l+HNmvPQdIDEj1M9WhTppUsiQYn7XznbjIncsNVO4Xwy/00DZ7E+l2kwSh3W1v9suGUl5n5GfWIZKPI7fe+Q3QlMeppe78j3zA/1nM9xT/EhrQiQeQavOZ/d0W17eyO7bQJrd/5QfPQzuPQtdKDK8WnRSllhkeruQfuIticP+2BJaH6QrKUd4uAmcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIqLAejiUM954/rI9PvfPKfXnDeKUQNtV8//EZZfYdE=;
 b=lkvrUKEoVeOvTOYS4PVk6ESkOyTwBI6CTuuo422RniPF9w96CwC22lk/eSdCM417tjibsjPUCJo4+dJ++kbh/s0HDgFk4b/nG7t3ux8LMo6geqHuYonsE8aRZnxXF8GOhF8/3jAIiCdabQw8rD1pelkVTW9jwc4byWT4289ZBzmCvER6+qsAchujRcS0xjaJgPj9Valg1Irpwef20mpqNJNeSQSkDaLI7Z8hSYcttzh1gOFlCnQiUOfJ/zO4pt62l61hwjA7GpHG8DdkuFgDQtSFumZqlLmFPWkAJstj/30nxhEhyQ+ws3/7HaFE2dBEFXMq8LCXLG3EPQS0bmDTEA==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by CH3PR12MB8581.namprd12.prod.outlook.com (2603:10b6:610:15d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Mon, 9 Feb
 2026 09:54:09 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699%6]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 09:54:08 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "horms@kernel.org"
	<horms@kernel.org>, "shuah@kernel.org" <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Petr
 Machata <petrm@nvidia.com>
Subject: RE: [PATCH net-next] selftests: drv-net: port_split: convert to ksft
 format and mark disruptive
Thread-Topic: [PATCH net-next] selftests: drv-net: port_split: convert to ksft
 format and mark disruptive
Thread-Index: AQHcl9ApQ5KwWGwSEkO8syMC7EMOqLV6BPwg
Date: Mon, 9 Feb 2026 09:54:08 +0000
Message-ID:
 <DM6PR12MB4516D06845B4A6D2691E46F4D865A@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20260207012151.3972723-1-kuba@kernel.org>
In-Reply-To: <20260207012151.3972723-1-kuba@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|CH3PR12MB8581:EE_
x-ms-office365-filtering-correlation-id: 24466be2-6096-4ba6-0717-08de67c12b49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NFBINkdmVjlFbnhQNjdocEJrNE15dGxrS29wNFk0dmlreUpzc3pIT1FUZHox?=
 =?utf-8?B?cTNHWExXTEtRV05hMlFuYVlYWnV4Z1Zib2JEQlVrd1pOSFBWd2swVzNsRUlm?=
 =?utf-8?B?bCsxdU5WdGdGZVB6MzJDTE80a1QzTHozb1JJNGs5emxKVlB4RHZIVDRscG5u?=
 =?utf-8?B?SDI2d0V5NitxaC9wRDJRYXJvTVYvaUxqOEVMS1ZodEErVnd1NXp2ZnlNYTRr?=
 =?utf-8?B?dXNrQXQwSXNJTGhlWldUYzZxZXA5VjVMYWZVNThuQXcrSERJY3NxSHVVc1FE?=
 =?utf-8?B?NXBudVFCQkpFWVN0dUg0S09vSlRDeGo3RHJudm1EY2RMSCs0T0FlalhUdExP?=
 =?utf-8?B?Z05BakorQjFtNkpoOFJaOXIrMHRrd21CaW16K21GMVpIVFMyNlg0Q1JPaGNu?=
 =?utf-8?B?RlV3cTVSV0JvSDhGb3RpUGpIVTJiVTVXbXY3VEVGNFBhcVRVUnJ2cTVSUGVl?=
 =?utf-8?B?MzVFUjRWRzZVdG1LYUlDaDN5WFNKc29LdW1GRHg3S3RQSDNsK1lETVRodSs3?=
 =?utf-8?B?c0g5SE5TRXd1aStTTFNFWEduQzFmSGVmcTZNaytUL1RlbEFITHpGcmd6ajdN?=
 =?utf-8?B?VHBzdDE3Y3UyTFQyalUrN0owQmxYalZqWE9EVFpDRlF0WFBoblA2LzQzQk9m?=
 =?utf-8?B?SnpyME5WV0JHQXBPZVIvZDZvVlQ4ZUVHdWZJaDlldHVDOGt5MVl3RjZDWTZG?=
 =?utf-8?B?Y0hCZU0xRXhHTmZFS2Vmd0RoYUgxSmZlTzEzdUlwNUhYUkIvekw2VU40T2hl?=
 =?utf-8?B?YkpYcE0vb0VOd0VERCs3eTFBZldvN2luOHBLdy9zZTUydFN2TEZSRWxPWHdp?=
 =?utf-8?B?WWlZakduMElMVXptUVd1eHZGbG1CS0tlSzJoSnNRYzZzbVR4NWd0bWNZZ2lk?=
 =?utf-8?B?QnNCUHc1cnJ2OU1HSHpuSmVtUDNoQSs1aVNuMVFJNWo0K2pxYituZGdBa2Ra?=
 =?utf-8?B?WUxabVhxQnJWN1NRK3MvNnlFdzdQcVNCd21tdVAwdG1QNjNPMVZ2cVZkTFdY?=
 =?utf-8?B?cTBsT1VZOGZNUmhkTkxCNDZDc0RMV1ZnMU54NDZLZjR2RDlCMlpqcmliKzFL?=
 =?utf-8?B?TkFIcko5RnhLT2szZncwTHA5Tk5SQm1BOEtVYlRycHUwakVFcUpyMzMzeWR5?=
 =?utf-8?B?WE1JRVVvblpiTDFPdEZyOXJ2Z3NNVWN6T01keGs4NDk5d0lLZTA4eVdTT0or?=
 =?utf-8?B?VGh3K1FxSjdMemthOEFFRGVHSjNNMzNpTU9nZGQ2cU9COElkVGUwU0kzb1pa?=
 =?utf-8?B?eFkxcVBUbWZ4cnQwbzhFZGNkY1R5Tzk2VWZ1cTFOeVpoV3VRUUpOYTY5d3RI?=
 =?utf-8?B?RkNoSTg2Z3Exd3RoUVJTcG05ZE96Vm5Jc1VpTTlzTCtPeG5ZcEUrZE5yTnds?=
 =?utf-8?B?YmYxTllOdnYrTFVkSmFkYUZMbFNsYXYydlVuVEowQWJlU1JvWEkrZC9lcDgr?=
 =?utf-8?B?K3JTbDZubElFR1BFY3hGOXIwaTl0b0pmeWtuK2VOaVI2Um5Pa0Y0NlJLSUdx?=
 =?utf-8?B?a3lUU0VKNk54WlVrbGI0TlI3RnBnNVY1cUV6aDFmY1RVTDcvUkFPcndXcGVl?=
 =?utf-8?B?UHB3WUNqS2ZmeHNjOFhHUC9leFdpS1JBbHlsUTcweFIrYkEvSzBuWGIwd1ZC?=
 =?utf-8?B?NTdVYmZlSTJFNzN2WEtMQjJyRytsNmhvL2lIVkFBeXFNdGtqQmd6RzArNFJa?=
 =?utf-8?B?Q01ySEVoUVpuTnc5STZKa0gwVE1FRVRhTGFSejEwdzRGaE9xMXV2Z3NFS3dw?=
 =?utf-8?B?TS9LU3cybTR2RFIwN0FrT25xdW9CdWxEOTduTXpYbjhQQXB4b3M2YjE5VEFW?=
 =?utf-8?B?SUVTYUpaQ2RXY1pSUkx1WklCb2xNeko5UFdLMVFkSnpOV0dxZ0VMby95bm9Z?=
 =?utf-8?B?REZPN1N5T0ErNG5ZNHI0RU9EcGdQV2dKU0hNYmluTVhLdGc4a0dUUFdDb3JZ?=
 =?utf-8?B?QW14ZGxiMlZyaVNSMUN3NGhsN1RwRnU2TjBFS214Wk1oTURzeG9MODZWT3ha?=
 =?utf-8?B?a3FxRGdsWklFbmo5aVdoUFA3WEg0Wk5XVlVGcHJldEF0ZXBIeWtFb050ZVRz?=
 =?utf-8?B?MHc3NVdZT3h4emZkdG9JNHFpSzhSM25hMmgvZWZ2K3Yya2VNRkZTVHNxYlZF?=
 =?utf-8?B?MzNXdXoxbTVVQUNneFJzODRoSXg1RFJMZ0lrK2tsWHVGdVNIbHlhbm01S3Ez?=
 =?utf-8?Q?GTJMK2/MekzT1umQv9V8doo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SW5wNWNRd1JiYlN0c3BUa3JFTGIzcGdHbDFUTzhxY1F3Z0JadWJNb0l4K2hQ?=
 =?utf-8?B?ZzB0cHI5L3NwMitQaU0yUVBYWHNsNTFKYnJQZkhoaENQMTNvbU5ScWlQS2hu?=
 =?utf-8?B?djF4YWJ6VEJLTFJhNkRCclFvVG54SmtQUEZmbXBnTXMwSG9EM0ZJY3hLd1NU?=
 =?utf-8?B?dlpFUGpmYjJyQTljYlVFVmRjMnhrLzRPd0oxUFQzcy9oTzg0U25OWVBDUDhY?=
 =?utf-8?B?Z1J3amIybU14RFpSYnEwZUZVRkZvRUJmRzBmL3lwb0NnUk9Kdmhjb3oyYjBR?=
 =?utf-8?B?WnlDNEwwV2hhczhVbmRpZkN3VUdjY3JucVFjRW82THA0aHFCVVM4VEJhbVQ3?=
 =?utf-8?B?ZVFwRjQvVy9KNklKdlozbnZUQlI4SG1kOWNmRHpkR0Q0QXpTWHgvdEFEZ0lj?=
 =?utf-8?B?dld1dzZZd2xZWjZWWEExb0gvOXppZk1KT3dLamdnYzg1SW5BL0l4ZnA0b3gy?=
 =?utf-8?B?SFg4b1NMUXNYZ2NEZFVaL01xcnZkaG16Nnp2MzFuZVNYam5MbS9FMXZuVE1a?=
 =?utf-8?B?VUpPM3hsMC9vekFyVGsrQmJ4ZmRETlFxNW5BelJVOU9zT2lXbldUUlprSDFP?=
 =?utf-8?B?L1p2bkRwMVNhQ08rUlJ4UTZybWhtZm1MYVVnaldFc2NxeDIycHFObDZwVkg1?=
 =?utf-8?B?Sy83dGEycTZXNURBRExQWUZqS0RTNkl5VnVWRUNRQi9rOWMxN2k4d215SW5p?=
 =?utf-8?B?WG0wT3ZVKzRBT3J0MjJJT2JJM3p4Q0YvbkV6ZGxJU01VQXFITDQ0TW5Td2lH?=
 =?utf-8?B?Nnh3eVBOaWVGWVBsS2NCZkJOckMzU2R1U2ZjR0wrcGVla2dac05lVGFNdlFi?=
 =?utf-8?B?K095VkNDZDdNc3dwa2pla2duUWN5RHQ5MWU4M1MvWU9nZDFsY1llYW5aSUU3?=
 =?utf-8?B?YTdiWG5ZR21MVThJV2VUNVVDbWVBMFU1RWhadEVDd3pzY3VBeFJmZTVsWjBn?=
 =?utf-8?B?bTFXbzdhOWI4OTRBMWo4WUVDRVVZVWVpOTRodVQzNnEyUll5TzZldGJpZ2pt?=
 =?utf-8?B?WEZRNlBhNHJEVEkvMS9hL3Zrd1pwcXJGeHF5cnN2YU9EYjVEWGtXak9GUEhU?=
 =?utf-8?B?SlBPMVVtaUZENU9aZExqK3lncEFCK3VVTHVUelIrcEhseElOS3VhbXZIWEs5?=
 =?utf-8?B?WHREMFBnVTZnTG5EYkxxTG5YRW1ONGsyYVVwODdqZ082WUtlVDkzeEtyb1J2?=
 =?utf-8?B?ejFoVStuTTA3VTRRMzd2VnJjZGQyd3B4c3VMWjVPZm82dDFlbXVoWVppY1JK?=
 =?utf-8?B?ZjVieGp1TlZ5OUVKZTNEOGF0QmR3T2V2VHMrNTJ1Y08vVnNvcXNpZVhKWW4v?=
 =?utf-8?B?QnVxbHRyWmNBa3RKOUloVFhNdlh0ZU16WE11c1ZmN3BzWEcwSzh6RkdxY0NG?=
 =?utf-8?B?NysxMXl4ZVdjSjJSMVFYSVM1VzlObzhFWXpqNmxjbWVaRUV1TnpLOXhTckZ0?=
 =?utf-8?B?dG1ZNWhPTFIxdFhIUldJSGJ4bncrRmt2QTFITzVTZTd0Q3dNcm5TTHdhVGhL?=
 =?utf-8?B?SDA0WWVXSUswNTlFR0JRTFdoQ2I3eUVpZzVYU1ZWZnhGOUFWZXF1RFRHSkF5?=
 =?utf-8?B?cGZWWDFhelpjeWpOOXB5ZHlmSTdqOEZUSjFJdnFLZXd5YlQyRW9Ma2Mxazdt?=
 =?utf-8?B?bGQ2aWwrdHk2WmplMlNJQ0gyRDhzZTAvM2tNNVBUKzgwRE5jYlhtNTg5YXc2?=
 =?utf-8?B?WjZFYWFjYmw2cE40U3Z0UElVL3BvNTB5UXNzSnhiYUJ1ckhJeW9TZmg3aGhR?=
 =?utf-8?B?SG1Za1NNRExJdVhOdDhaT1pFbnZSR2lLTjAzVldNc0QzcXVIdEFFLzBQdHJ6?=
 =?utf-8?B?bHB4L25aOXR0ZlBEMkt6b1FVeWZuNWlBdnpSSnNHeFVQaGpOUUtiZDdyT3o3?=
 =?utf-8?B?YWsvUHFhMSttdUdhamlBcXVOa25hbjcxYjJqWVVDVXI0UmF0b1hRdTVoaDNr?=
 =?utf-8?B?OHllT0s0SGhsSDFyRWNxdGQ3ejdzb0FoRGxvZ3lnVFF2Vk1EWnFVeS9Pb3hO?=
 =?utf-8?B?eFA0Qm1nYUN5TWliNUh6VE5mWjlYUmtFUXM2N293OHRSWEQ4T1YvbVQxZk5K?=
 =?utf-8?B?YXFGRG1KQzR1YmtvTEJtZEFucTFJc3U1OHg5ampuUDIrN2E5WUp0OWdVV3o4?=
 =?utf-8?B?QXlYWEgzNmZ6ZitYZTRzRkdSSUZOUHlGeE9odVpJaUxiRjJRNkF0eS9tM2lE?=
 =?utf-8?B?eU40TXNienZQT0JKQWlUM2UveEc4TWJoUzlTQkVCUUNodnFJRTF0V3Y4ZElB?=
 =?utf-8?B?Nm1ubVUxMVdIRk9BYVdsTzlTSjdEcVVqUG15VVFtT1ZhQTRRN1pBZFhoeTZS?=
 =?utf-8?Q?GBITyVID671iyjtMi2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24466be2-6096-4ba6-0717-08de67c12b49
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 09:54:08.5607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QSXHlgxWkXazlrOfs69jLktJtp+UkzgWh6Rk6gsFWNsr4OW7Ff2UKOrXFALkfqrFswbnHZ7i82xomK61QHYayA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8581
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-257926-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davemloft.net:email,lib.py:url,DM6PR12MB4516.namprd12.prod.outlook.com:mid]
X-Rspamd-Queue-Id: E994910DD9C
X-Rspamd-Action: no action

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTZW50OiBTYXR1cmRheSwgNyBGZWJydWFyeSAyMDI2IDM6MjINCj4g
VG86IGRhdmVtQGRhdmVtbG9mdC5uZXQNCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGVk
dW1hemV0QGdvb2dsZS5jb207IHBhYmVuaUByZWRoYXQuY29tOw0KPiBhbmRyZXcrbmV0ZGV2QGx1
bm4uY2g7IGhvcm1zQGtlcm5lbC5vcmc7IHNodWFoQGtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrc2Vs
ZnRlc3RAdmdlci5rZXJuZWwub3JnOyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsg
RGFuaWVsbGUgUmF0c29uDQo+IDxkYW5pZWxsZXJAbnZpZGlhLmNvbT47IFBldHIgTWFjaGF0YSA8
cGV0cm1AbnZpZGlhLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIG5ldC1uZXh0XSBzZWxmdGVzdHM6
IGRydi1uZXQ6IHBvcnRfc3BsaXQ6IGNvbnZlcnQgdG8ga3NmdCBmb3JtYXQNCj4gYW5kIG1hcmsg
ZGlzcnVwdGl2ZQ0KPiANCj4gVGhlIGRldmxpbmsgcG9ydCBzcGxpdCB0ZXN0IGlzIGluY2x1ZGVk
IGluIHRoZSBIVyB0ZXN0cywgYnV0IGl0IGRvZXMgbm90IG9iZXkgb3VyDQo+IEtTRlRfRElTUlVQ
VElWRSBtYXJraW5nLg0KPiBJZiBzb21lb25lIHRyaWVzIHRvIHJ1biBkcml2ZXIgdGVzdHMgb3Zl
ciBTU0ggb24gYSBkZXZpY2UgdGhhdCBzdXBwb3J0cyBwb3J0DQo+IHNwbGl0dGluZyB0aGUgb3V0
Y29tZSB3aWxsIGJlIGxvc3Mgb2YgY29ubmVjdGl2aXR5Lg0KPiANCj4gQ29udmVydCB0aGUgdGVz
dCB0byBjb25mb3JtIHRvIG91ciAiZHJpdmVyIHRlc3QgZW52aXJvbm1lbnQiLg0KPiBNYXJrIGl0
IGFzIGRpc3J1cHRpdmUuDQo+IA0KPiBUaGlzIGlzIGNvbXBsZXRlbHkgdW50ZXN0ZWQsIEknZCBh
cHByZWNpYXRlIGlmIHNvbWVvbmUgd2l0aCB0aGUgcmlnaHQgc2V0dXANCj4gY291bGQgZ2l2ZSB0
aGlzIGEgZ28gKGFuZCBwcm9iYWJseSBmaXggdXAgdGhlIGJ1Z3MgSSBpbnRyb2R1Y2VkKS4NCj4g
DQo+IENDOiBkYW5pZWxsZXJAbnZpZGlhLmNvbQ0KPiBDQzogcGV0cm1AbnZpZGlhLmNvbQ0KPiBT
aWduZWQtb2ZmLWJ5OiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPg0KPiAtLS0NCj4g
IC4uLi9kcml2ZXJzL25ldC9ody9kZXZsaW5rX3BvcnRfc3BsaXQucHkgICAgICB8IDI0MyArKysr
KystLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA3NyBpbnNlcnRpb25zKCspLCAxNjYg
ZGVsZXRpb25zKC0pDQo+PiANCg0KWy4uXQ0KDQpGZXcgY29tbWVudHM6DQoNCjEuIEJlZm9yZSB0
aGUgY2hhbmdlIHdlIHNpbXBseSByYW4gdGhlIHRlc3Qgd2l0aG91dCBleHRyYSBpbmZvLCBsaWtl
IHRoYXQ6DQokIC4vZGV2bGlua19wb3J0X3NwbGl0LnB5DQoNCk5vdyB0aGUgbmV3IGluZnJhc3Ry
dWN0dXJlIHJlcXVpcmVzIHRvIHJ1biB3aXRoOg0KJCBORVRJRj1zd3AxIC4vZGV2bGlua19wb3J0
X3NwbGl0LnB5DQoNCldoaWxlIHN3cDEgaXMgYW4gZXhhbXBsZSBmb3Igc29tZSBpbnRlcmZhY2Ug
aW4gdGhlIG1hY2hpbmUgdXNpbmcgdG8gaW5kaWNhdGUgdGhlIHJlYWwgdGFyZ2V0IGRldmljZS4N
Cg0KT3RoZXJ3aXNlLCB0aGUgdGVzdCBmYWlscy0gaWYgbm8gTkVUSUYgaXMgY29uZmlndXJlZCwg
dGhlIGZyYW1ld29yayBkZWZhdWx0cyB0byBuZXRkZXZzaW0gKFNXIG1vZGUpLCBhbmQgc2luY2Ug
dGhlIHRlc3Qgc2V0cyAnbnNpbV90ZXN0PUZhbHNlJywgaXQgZW1pdHMgYW4gZXJyb3IuDQpTbyB0
aGUgbmV3IGNoYW5nZSwgYnJlYWtzIHRoZSB3YXkgdGhlIHRlc3Qgd2FzIHJ1bm5pbmcgYnkgbm93
Lg0KDQpIb3dldmVyLCBJIG1hbmFnZWQgdG8gd29yayBhcm91bmQgdGhhdCBieSBhZGRpbmcgYSBj
b25maWd1cmF0aW9uIGZpbGUgdG8gdGhlIHNlbGZ0ZXN0cyBkaXI6DQoNCiQgY2F0IGRyaXZlcnMv
bmV0L2h3L25ldC5jb25maWcNCk5FVElGPXN3cDENCg0KMi4gVGhlIHRlc3QgZmFpbHMgZm9yIHdh
aXRpbmcgZm9yIHRoZSBjYXJyaWVyIHRvIGNvbWUgdXAuIEJ1dCBhY3R1YWxseSwgd2Ugc2hvdWxk
IHNraXAgdGhlIGNhcnJpZXIgY2hlY2suDQpUaGUgcG9ydCBzcGxpdCB0ZXN0IGRvZXNuJ3QgcmVx
dWlyZSBjYXJyaWVyIHRvIGJlIHVwIHNpbmNlIGl0J3Mgb25seSB0ZXN0aW5nIHBvcnQgY29uZmln
dXJhdGlvbiAoc3BsaXQvdW5zcGxpdCkgZnVuY3Rpb25hbGl0eSwgbm90IHRoZSBkYXRhIHBhdGgu
DQoNCkkgdHJpZWQgdG8gcnVuIGl0IHdoaWxlIG92ZXJyaWRpbmcgdGhlIE5ldERydkVudiBfX2Vu
dGVyX18gbWV0aG9kIHRvIGJyaW5nIHRoZSBpbnRlcmZhY2UgdXAgd2l0aG91dCB3YWl0aW5nIGZv
ciBjYXJyaWVyOg0KDQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZHJpdmVy
cy9uZXQvaHcvZGV2bGlua19wb3J0X3NwbGl0LnB5IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
ZHJpdmVycy9uZXQvaHcvZGV2bGlua19wb3J0X3NwbGl0LnB5DQppbmRleCBjN2IzOGY1ZTk0ZmQu
LjM5ZDgyZjJkOWQ4MiAxMDA3NTUNCi0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2RyaXZl
cnMvbmV0L2h3L2RldmxpbmtfcG9ydF9zcGxpdC5weQ0KKysrIGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvZHJpdmVycy9uZXQvaHcvZGV2bGlua19wb3J0X3NwbGl0LnB5DQpAQCAtMTgsMTIgKzE4
LDE5IEBAIGZyb20gbGliLnB5IGltcG9ydCBrc2Z0X3J1biwga3NmdF9leGl0LCBrc2Z0X3ByDQog
ZnJvbSBsaWIucHkgaW1wb3J0IGtzZnRfZXEsIGtzZnRfZGlzcnVwdGl2ZQ0KIGZyb20gbGliLnB5
IGltcG9ydCBOZXREcnZFbnYNCiBmcm9tIGxpYi5weSBpbXBvcnQgS3NmdFNraXBFeA0KLWZyb20g
bGliLnB5IGltcG9ydCBjbWQNCitmcm9tIGxpYi5weSBpbXBvcnQgY21kLCBpcA0KDQogUG9ydCA9
IGNvbGxlY3Rpb25zLm5hbWVkdHVwbGUoJ1BvcnQnLCAnYnVzX2luZm8gbmFtZScpDQoNCitjbGFz
cyBOZXREcnZFbnZOb0NhcnJpZXIoTmV0RHJ2RW52KToNCisgICAgIiIiTmV0RHJ2RW52IHRoYXQg
ZG9lc24ndCByZXF1aXJlIGNhcnJpZXIgZm9yIHBvcnQgc3BsaXQgdGVzdGluZy4iIiINCisgICAg
ZGVmIF9fZW50ZXJfXyhzZWxmKToNCisgICAgICAgIGlwKGYibGluayBzZXQgZGV2IHtzZWxmLmRl
dlsnaWZuYW1lJ119IHVwIikNCisgICAgICAgIHJldHVybiBzZWxmDQorDQorDQogZGVmIGdldF9k
ZXZsaW5rX3BvcnRzKGRldik6DQogICAgICIiIg0KICAgICBHZXQgYSBsaXN0IG9mIHBoeXNpY2Fs
IGRldmxpbmsgcG9ydHMuDQpAQCAtMjA4LDcgKzIxNSw3IEBAIGRlZiB0ZXN0X3BvcnRfc3BsaXQo
Y2ZnKToNCg0KIGRlZiBtYWluKCkgLT4gTm9uZToNCiAgICAgIiIiS3NmdCBib2lsZXIgcGxhdGUg
bWFpbiIiIg0KLSAgICB3aXRoIE5ldERydkVudihfX2ZpbGVfXywgbnNpbV90ZXN0PUZhbHNlKSBh
cyBjZmc6DQorICAgIHdpdGggTmV0RHJ2RW52Tm9DYXJyaWVyKF9fZmlsZV9fLCBuc2ltX3Rlc3Q9
RmFsc2UpIGFzIGNmZzoNCiAgICAgICAgIGNmZy5wY2kgPSBvcy5wYXRoLmJhc2VuYW1lKA0KICAg
ICAgICAgICAgIG9zLnBhdGgucmVhbHBhdGgoZiIvc3lzL2NsYXNzL25ldC97Y2ZnLmlmbmFtZX0v
ZGV2aWNlIikNCiAgICAgICAgICkNCg0KSGVyZSBpcyB0aGUgb3V0cHV0IGFmdGVyIHRoZSBhZGRp
bmcgdGhlIGNvbmZpZyBmaWxlIGFuZCBvdmVycmlkaW5nIHRoZSBjYXJyaWVyIGNoZWNrOg0KDQok
IC4vZGV2bGlua19wb3J0X3NwbGl0LnB5DQpUQVAgdmVyc2lvbiAxMw0KMS4uMQ0Kb2sgMSBkZXZs
aW5rX3BvcnRfc3BsaXQudGVzdF9wb3J0X3NwbGl0DQojIFRvdGFsczogcGFzczoxIGZhaWw6MCB4
ZmFpbDowIHhwYXNzOjAgc2tpcDowIGVycm9yOjANCg==


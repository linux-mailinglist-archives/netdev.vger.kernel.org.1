Return-Path: <netdev+bounces-226625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C1ABA30F1
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 11:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F75386096
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 09:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C8929B205;
	Fri, 26 Sep 2025 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mylYtrY2"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011001.outbound.protection.outlook.com [52.101.62.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5ED5FDA7;
	Fri, 26 Sep 2025 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758877284; cv=fail; b=rUJHskrlFap8DFZenb7L7ABDlW83P/7+3CwHNUj/uFC9P54Mk/Y6KtY43O234d3rTnqLz1fi++VSvwi2x+HWyiudFXbaETQ/eVdB6Zpw5zAL6jIPqXuGFPBe2EzqdkeHXdIxtParFOx53kLcge3OEhH5ClY7et2WK1UzSHjKIbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758877284; c=relaxed/simple;
	bh=hUmtjpf2eEoXCfFFL7TuP7Z3etvYPAlRy/TI8a+Q9kk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=msZWMhEaO/Ppc/tFFfmwA9zSvvoLV7kgNOC71cSVCjVj1uZqoVPxPk3A1Ipdpde107g4bnUlkxlnoq8jM3RpmoYYNj2dYrn4j9/NqSj7jnk6FwAXC/gerVsiZZAQS/UM8LAX9sm0G3OoZWfujRYTTIUwuhunRjDPkOMoeWsiamo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mylYtrY2; arc=fail smtp.client-ip=52.101.62.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFkv/zpEcWTrsM5H2EQWllFb+yQLndz3VYfQmISXJu2ohL5zue6hozhkjQTKXOlD2Mt7jt9Ea6D6vvIuzeLDFCHHF29T0d84Gv8acplr3TRD38oZ+o67P5Hcx0X5DrcNsVVhut2cH6uHCwFSnqB4BL+e/L/mgJmSHpWBhe1y6kAml+ucWDYKYVTTH5x/Otf0GiuD5vOcdmtJK0H3vr5JsoBuB5SypgSuP4RUSOcYpY+KkcPxUdTLzYZeTETz/aEKcp2ucx9FHU/qcUadsAYolWESPI+HQcpAWk6eavBFj8bgMAFvohVy4siDFBx8RYaMu3kVMA4ZoAcmjusOak5CXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVjz+At7AaHO3CYLQT9M4JTEaKC8EsCU7lmsuDF6Y+M=;
 b=cGUpqzdFQsNtTBNWviYeFWUmgLdpQwtIPwEz/o/YzjA1Db24IXHhjfYznuL/2ItMOmbKE9+E6Q4iLdMOVNOUiL40ckcoTKdKzm+agfOoVb2Qfezwk5USc5ARDnRAa+g+MxI2SkkOCFeQnFCDPLyWFdAf00Fo06cpBW4CxnlUueDMS99MCtBqQbmMwgyVSDDLHMVH1/Ifb1De+wz6+5eid8n71SLi6O+VAHY85Y3hvLU7fgU+6A9SvGfdblgWQjQoAnS5LGfXJlO1uaUAmEQJMVc179NskAzkApjkk80zFMDjFJLk46fYwC2EUMV6AT2lcLizm1RMxc8EBECB/S5G3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVjz+At7AaHO3CYLQT9M4JTEaKC8EsCU7lmsuDF6Y+M=;
 b=mylYtrY22sDBIUVtS1oWsosW0pCHbKTizkKlIfJfG3xlCeCApr/4oPkaoOLLdmENTvpfryZRbNmNdoxw2bvimHEtrrcUR5XV87/RLOIccXdePAjt7GoPd9j6C0eRl9r0DGZbpKu+U68ZtvNc7WBXKiv32RE6mE6GrojfoO8/8gs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH8PR12MB7326.namprd12.prod.outlook.com (2603:10b6:510:216::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Fri, 26 Sep
 2025 09:01:18 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9137.018; Fri, 26 Sep 2025
 09:01:18 +0000
Message-ID: <5860ea5f-3a49-4c54-aff9-4be0801eefa5@amd.com>
Date: Fri, 26 Sep 2025 10:01:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 16/20] cxl: Allow region creation by type2 drivers
Content-Language: en-US
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-17-alejandro.lucero-palau@amd.com>
 <19928767-6ef6-4c98-b469-6c04148d697b@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <19928767-6ef6-4c98-b469-6c04148d697b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0184.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::9) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH8PR12MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 5885da7a-be80-42f8-ad78-08ddfcdb41a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXhWcWJ3L3l2ZWZia08vdmFRY241U05tZ2R1SDNzenhjK3lkSW9lbjNpQkN0?=
 =?utf-8?B?Z0dQR0lSZGRtZGFORjZtaVZnRVd0OEJkeWZhN2liQzJwRzJZU01HaHBXcmpT?=
 =?utf-8?B?TUN6T1dqaVhMY0FFdzRSSGROeDViMy9ITXByVm9qanFZL3Jja2h2Z3BqUGRr?=
 =?utf-8?B?cTk5a1BtMlFkNWx4RjRTZW9EM3FwcURiVWVRVGRtWE91ZHd3bkoweVBSeGdV?=
 =?utf-8?B?OHBOMTlnNHVNeVJKcU0vRmZQakU0RG1ZbDQ2SCtIb2NBMHhUcEtzOS9SRGRI?=
 =?utf-8?B?M3JGakNPcTRaMUk4TTJEU0lmMlJZa0FFRHdMZEJQLzlkNE4zTVZURDhsajR2?=
 =?utf-8?B?dXBGV24wbTkwWVBlWVRjOEZ5dExMdXR4ejYrOUsrcVVmWG5JNHVjSXhsbWIr?=
 =?utf-8?B?aTlzcHdyRmJwWUlrQTJqb2Z1T3JFZXVZa2MwV0Z2OUo2bmJrSmlib0x1d20x?=
 =?utf-8?B?NnNJek1vblVrVnZzREpqUnVjTHAvZDhlZGdmUlRWanFlSjVMYldUdFpvRmg2?=
 =?utf-8?B?dW5YVk5jQWUzYnY2UlpBa3h3QVR2c3VRdFFCUTVCU21QNkZ3bnBhSkFvUVc5?=
 =?utf-8?B?QVJLa0dTV3JKUzZYaHZrTVdqV3ZsTmkxR3NQRW5wSDdjamNPYU1zN3NJS3lr?=
 =?utf-8?B?NC93ZmxKR0dOQ3BRODBVa3JhOVBLSGlPT3ZTZElWTlRrZXZnbTgwMlFJRmFa?=
 =?utf-8?B?eEZSOHNoYW5IZmhuUm91eFJhL3Y0YTZmV3kyZytNazk4VURIVG13Z1BYVDRW?=
 =?utf-8?B?ZXFObmI4aDJjcDhEemFXMGZyd1pqSy9qRW9ZZlEwVGxFZ2l3SktuQUI3bEFa?=
 =?utf-8?B?eGtBZlhkUW9OS1pFVDVrYWpDZ0xyN0trQXN1eElkMWw2R1o2UlV4T3JjV2U3?=
 =?utf-8?B?OWNoUUpuZ0c4Q1I0T0dUbzg2Nkh3Ri9aTjRWZnU4SmZ6bTRWQ2lDbVBIQzU3?=
 =?utf-8?B?YUxWd3AyVnloSnEyUUpNR0x6cWZvRkFnSGoxN292K3B1U0pwK0NVeTNzbjFk?=
 =?utf-8?B?QUhSZWw0ZEVoM0kybVllWlBjTWFZOTRub1BIKzl3WWdpc2ZUWmdhZU5wQkNi?=
 =?utf-8?B?eUozYitvQ25rYzI5RGdLc25XblFsOWxGc05SbG5hRXk0bFNWaitpbG4wVW43?=
 =?utf-8?B?cmpFbTU5ZyswZ2w4cG5JMk8zdS9sZGY1S29JOVlFcTFjQWdraG1sYmRhdXp0?=
 =?utf-8?B?Uld2YUJYQ3VFdy9kRDdhOUJSN2dTcEd1dU9LN2ZxQkNhQ0ljekJrUkg1RVRM?=
 =?utf-8?B?ZEMvUWZwZXoxVkl3Vkd3NWpaa2RUSXBEUWk5cnIvS3pvbGFPQTdhVmM5dk1u?=
 =?utf-8?B?dWhjUEZBenlaTk9nV3NTTkhCZTNKMVNVNDQyNVpzUmZ4LzhXRzBFWW9ZeE82?=
 =?utf-8?B?QWtMZzFWWFJXMTZYNHVZaHJoNGtiemhwZnpocXFLdlNUV2htVmlCVGl3SlZX?=
 =?utf-8?B?QnJVdFhTeEo2N2g1cHFKMi82UjZ3a0gybWJMaWVBSWdpMmJYbDh4Yit1U1U2?=
 =?utf-8?B?ZXVpZVFneXprZG14RU1hUXg2VmV1SkpLYVNFWWk5US9QSWJOWUF4b1dYQURX?=
 =?utf-8?B?Z2lhOXlxMTZ5MjlkcTBqdGJtQm15QzQzdTRFT0JYZis4YWRucnNvTXZNSVdU?=
 =?utf-8?B?WDIwZnNHeElRMEY4UkdRdnpiaXYyeVFPeFdiK0U4R0FGSHZWakI4VVpuR2lo?=
 =?utf-8?B?RTBqZVp1QXNlc2pRRU1zOUFhTmNLWWdSaFZmWHJ0SmhrZmx3MGtYMmxyUGJY?=
 =?utf-8?B?bnA4S0Vld3c1VmY4bTZYRnpDRm5reTZ6RGZjL255SWllUklrQzEyUWV6anc5?=
 =?utf-8?B?ZjNjeTU4Z0Fwa3hyZkJ2dCs5ZWJhREJsUno1VTZBbklxQjErdHkvUW81dm8w?=
 =?utf-8?B?Mk9ZNVU1WnQzTHZ6dWd2ekpVSzZ5ZXhqOVVTTEd6U1JtdlozVnNCWThFNzFi?=
 =?utf-8?Q?YCNBMctfiqk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFhWOGIvaE9jT1BBaENCNjZvWUFlcS9zSXJOd2NqNmFUamdGSzJNZ3dXNUxx?=
 =?utf-8?B?OThGM2pJUE50eHdFZVExc1pvcE4yVTRidU5Oc1hUa2V2bGh6S1ZtblQ3NjEv?=
 =?utf-8?B?OWc0OFhlSFBnMmxJS0NTc29yai84MUJObHlCWmZpSnU0REtuclBld01mL0ww?=
 =?utf-8?B?K3p6SGFJcitLKzNzVWVUWEltSzZZWEJLeEdXYkp5Y1NPdnBwNERlakFTRUVU?=
 =?utf-8?B?M0cwQ1pMWFlHRzFENS9EKzBIRHBNdHlENllkTmNYdWdrWk42aFU4QzhNdHVw?=
 =?utf-8?B?b0IzdEg1L044TENaZkZlSWc3RE9LSEFpRU1FSUZScnZSRTI5MlRWNXFublFR?=
 =?utf-8?B?TnJLVTh4YVJNbWc0U2g1RXVzRkw0TTJnYzVpUS9NWTVKUmNYbURIRWdRVkNr?=
 =?utf-8?B?SkYzNWhYNFNSdHVLbExuZ2N2V3FaMEtSWmI2dVYxZEh0UXNxSFU4OXRnalIz?=
 =?utf-8?B?MWR1cm5pR2JyQllQVlAxbGFvWGlRZXNsdWkzYVVxU0ExRlF0bExyRWNKS2wy?=
 =?utf-8?B?T2pBb25lQzNwNlZDajk2aVRmNWpBYXpReDUzMkI5bjhJRnRCNXUxZ29ISVVt?=
 =?utf-8?B?ZUdLNU9SMnZJMk5mZUQ3M3U5RlhWcUMxbkg4cC85bGVSNHhKbUdjK2U5QTFC?=
 =?utf-8?B?TXdvajhUb21PY1ZQUG5XeWpGZEx5SWVLTStlVTVudFY1QXBIdVRYa3IxSy9a?=
 =?utf-8?B?c3RaSkxKVUZjTkZsWmhXRlByeGE0UnBMZjZGbVVyTGljY0tCTEgvZDRxbWJt?=
 =?utf-8?B?SVVQY1FZNmxGVTF6clpTalY0VTUxek1IUDdnMURjSXZDbjcwNUVFMDBwSUI5?=
 =?utf-8?B?Q2xMSXZNcFRmamRsK1lsUXd1amZvUUdVQUdaY1dCazE4dGZmN2czeEJRRk9M?=
 =?utf-8?B?dlJicHJxSjB6T1E1MmNSQmp6b1R6MytSdm84WFg1V2k1Z1FWQVdSejNiVjVP?=
 =?utf-8?B?bXErNUowZ3lsMjlrKzZZTmpteXpJV0FXUFk4MEplNGEzWi96ZmZDYkxpRXhV?=
 =?utf-8?B?Y00ybGtnT0VSQUJaN1laV2Y0VzZWclBFUytYS3JOSk5EbmpvbFpyTkVSbWZq?=
 =?utf-8?B?OVlTZHNWcTNNYU15OVdoZm9nbWhTbXRZaWk2aFlRUE5PTXFWbGs2Z2tCOWV0?=
 =?utf-8?B?ZEZJdmgrRWMyVDFieEV2MVEwMmNWZWRsQjNsN3V5Sm5vQ1pQTitQWjRJdVZq?=
 =?utf-8?B?TFFRdm5QOFUzSDRBRzdET1U0WUEvem5sM1ZSTjlWRVVYZjBqTVYzV21PdHNw?=
 =?utf-8?B?aVRrYWltVFIzaG5ZcDRVZDVxTXF5WFhsS2ZCV1Zya2FKUUx6WHcza2hnSGdI?=
 =?utf-8?B?T2FwaHRyVlZPOGF4VlhZQmZHV1ZGM3dKOGY2Vzc0Vmx1RDVoT3FFWEMzQXNr?=
 =?utf-8?B?cVhsakZpK2tIbXl6S2lTK3VVZXZSWXU3VjN0THNFSkhLN2FzVlJXMXB2WXdM?=
 =?utf-8?B?NXh4TmxSZGRIeWFJdUFVay80NDZxYkpTenVjL1Z6TFFRbjRwSk14MDFCbHBJ?=
 =?utf-8?B?NHlNWkpGdW52c2wvVUhsZXVyeVpsdHJzMG0rLzJ3Q0hWYkhJSkZ4UjZ3RkNt?=
 =?utf-8?B?T1VBNXpmeTFvWTA3aU5uM0tQeDRwbUFwRERyQXk1SS9sV0xlKzdnTm42UW1i?=
 =?utf-8?B?L243Vy9kWURrR1ZJUndaSkhRam5iSnp4emZCd3YzZVFaOWQxM3I2MkY1Z1Bt?=
 =?utf-8?B?cXJUaVdJMVEwUjVCRnZoUzE0aHdjU3kvaHYycktvSk9KOXg2YUdwTytOT1Bm?=
 =?utf-8?B?eWU1UmZ6N2d3V2hzZExKUVRjTWtxUlVFcjhBb3ZQMDB0M3BGcjNzUStQdW95?=
 =?utf-8?B?NjZIRmdCV3M1d0t1RHE0a25pNkNTRlFtL2RlTE1vaHBHR3RjR3FNYWlKVXR4?=
 =?utf-8?B?TlBBZmJ4WFJPaDlPcGx0bUN6RUV2ZU1ZVGVwNkNqUVNnZ0p6Q09VNFgyVUhr?=
 =?utf-8?B?bm9uUENOVThjN3hPd245d21PQ2hyYi94THh5OHZZa3F0YzVHd3Q0MXEvVlEy?=
 =?utf-8?B?WkVOY3duN3VaajlyU3NjL3BXUzE1bUVoeTZ4b0p3K2hmbU1OeWVzelpKb3lM?=
 =?utf-8?B?cXl6elhXWGI1cDNrR3FPY0YzTmoxS3Rzckd3MldLdnBVWW9QS0FwUEVwOTdi?=
 =?utf-8?Q?/VsXHZZpF64AvI32pShfu8ZiJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5885da7a-be80-42f8-ad78-08ddfcdb41a6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 09:01:18.8253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2hUQTIfpI+XNdwjjao9RrKkWnZwLAVX+ELwDDig38V9PblE44PKKbzXBm1qleCTNwQDvS6PNlVxIgSlrzm0cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7326


On 9/22/25 22:09, Cheatham, Benjamin wrote:
> On 9/18/2025 4:17 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Creating a CXL region requires userspace intervention through the cxl
>> sysfs files. Type2 support should allow accelerator drivers to create
>> such cxl region from kernel code.
>>
>> Adding that functionality and integrating it with current support for
>> memory expanders.
>>
>> Support an action by the type2 driver to be linked to the created region
>> for unwinding the resources allocated properly.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
> [snip]
>
>> +static struct cxl_region *
>> +__construct_new_region(struct cxl_root_decoder *cxlrd,
>> +		       struct cxl_endpoint_decoder **cxled, int ways)
>> +{
>> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled[0]);
>> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>> +	struct cxl_region_params *p;
>> +	resource_size_t size = 0;
>> +	struct cxl_region *cxlr;
>> +	int rc, i;
>> +
>> +	cxlr = construct_region_begin(cxlrd, cxled[0]);
>> +	if (IS_ERR(cxlr))
>> +		return cxlr;
> I think you can use a cleanup helper here and get rid of the gotos. If you return a return_ptr(cxlr) (or whatever
> it's called) you can still return the error without doing the drop_region() cleanup action.
>

I like the idea which should imply cleaner code. I'll try to do so for v19.


Thanks!



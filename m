Return-Path: <netdev+bounces-229452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B03F8BDC6F5
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 06:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 34F09347F2D
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 04:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB712DE1E4;
	Wed, 15 Oct 2025 04:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lzOsl1bL"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013044.outbound.protection.outlook.com [40.93.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0E41A23B9
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 04:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760501574; cv=fail; b=USReKv6dWeFun+AyYvNbhCSoN+l2DbfxRlV3bBosSIWhvsHuTQLFv6lWAxHgjR4z8XEre4MOJAA+bw6xnyIGQ76XhjVBDQd8dPUes9SKe6DgAI6MExkOFnoXgAmsAk2x0hsHYnXxjzgm2qelBaQPMPX2kGjaIdbgW8N6s4r0yFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760501574; c=relaxed/simple;
	bh=k7tZ1URWD22Sk18lKqbvWF/1G/W01h18KX0q6j8XgC0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FV0hAEDAW6I8af/X7cgy7zkGY9AbsE1bhrevzucr3XYzjCnT50q3nOwpDW8XEMNhCe/dcbpEdDrghG9c4KucM1hBjJLhEs7icuGu2zS68W+2ZWA1vNqGjXKcaKBlMQ2M84uO1nipzQV55xMx+GS/m0EHE2cuZJMMVcTzJ/Ny1sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lzOsl1bL; arc=fail smtp.client-ip=40.93.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMaZrHxtUvsSczmaL5FNKwR15wNTBgkWmiwq+j0/6Qvyzd4/7pGmW9HcqZqBqA0KG1SqUj5nIlZSGv+AY/Cu3ofljCX+B2zUhIJdJBJlOGLnvwZfDrE3pKvm82PZF43aq7Da7R8BiFTGCkfaWkz3XQFzDa/4Vd+4pqn6y6SzD9T2GGjwVu6hoWlkfc0MgOWU+5TTtRkJHhlXL5cPfjFJcfdRTBUNeX3TsB0auHc5CK09gjKqsnW5gvJExgCt7PBpOvUgMhQKLCLFKN37Sb7ZTuqZ4J3kGptexMjIvlaC/HkysH+jY8IKu/raD9NIZbLFs2kRA0Gyyj/q4PFI8qJceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1FH8twg0g7MyiSNtHXXOtSntu/Y78xvngzamv9OIJI=;
 b=k5s/bO/qkfy04Ls4mcv4jsiiiuQFeWtqhI8uQS6ze8a8mpa3rg1pp3yA3FQU3/5V7iMlcyXfkvaTeqVUfL4Q1q18aSQh2hya4kfjThO3TXl8L3o2U41d64Cd9c6jiHBret7GsZ6FkWc/a4QVUrX/1czXcWodx8ySEfcN87FIPJFU3htwQR0qJ1riaISIlzxpHZouKvLqVjaJkT+cW1sE+CRzgYwKRTpRxN7RkcDRQ2pl9CPQD3lrMdLC1XPGiXg2XAEedPJJ2hkS7WEsXsyjOfIVflcDE/iyNhOBOdkq16UP+Ee/FieUVEjxPyYzjpHZ4G2BtzCoa1SRphVa2JDuEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1FH8twg0g7MyiSNtHXXOtSntu/Y78xvngzamv9OIJI=;
 b=lzOsl1bLgKMr/M00jWNHpaoT81pgtYe+g8+oHFacOgeEC6KOVfA6asnccYS3N9HoihH7toIPYfH1IPt5TO2pe2O+SM76i5DKxH+IOItzhuta4oRIitaevZjKJBOvGE5BaVbkQvmKo8NpD78OhK2zYRfo4mZT8/RfcK19FqNURoU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 04:12:50 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%6]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 04:12:50 +0000
Message-ID: <7855fb73-6fab-40e4-8ad7-75f6223a00b9@amd.com>
Date: Wed, 15 Oct 2025 09:42:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: amd-xgbe: use EOPNOTSUPP instead of
 ENOTSUPP in xgbe_phy_mii_read_c45
To: Alok Tiwari <alok.a.tiwari@oracle.com>, kuba@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux@armlinux.org.uk,
 netdev@vger.kernel.org
References: <20251015025751.1532149-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20251015025751.1532149-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::14) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|IA1PR12MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c66d074-e915-4b87-03b8-08de0ba11acb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzJvaEs1Qk9tb3NRK0pKNDlEbUg5OVByMlhFQzhWY1NjSnhGbTFlMGZ1cjd6?=
 =?utf-8?B?dlFKZkhvZmJkS0Znb1M1cTNvdFFyVithNWN2RStTeVF4TmVZMThPN3MrcklP?=
 =?utf-8?B?TEMzQzhtRDJZWjBxK2ZEOUNjNUFmMFl5QnViZnBkRGNxYlNQSWdwcUh6eFps?=
 =?utf-8?B?ZmtyZGszQ21mZEFkdEVMZmVQWS9SeWk2R0hPMFh6MkhMampnYnZkTlZZRkFm?=
 =?utf-8?B?U1grZld2Yno0RmlyaGpmT1Y0enVaVzZvOUlBbDRVL2U5M0k2MWo2WWI0d0dQ?=
 =?utf-8?B?OFNYZEdKenRPOEpGbXhTTVNPaS9GaFFDdXQzYmNKaFFldjF2R2hIaW5VTVNK?=
 =?utf-8?B?MXVhdkMyOVRkQUJNd0F5RFVveHcrSm5ndTVKc2lUNkF0d2dwSjhPU0lZLzBi?=
 =?utf-8?B?MHpxdE52UVdUb0QrWmRhbmFkKzIyYTJJWm8vYm5OVzZPT2VIaldrcXNWL0R0?=
 =?utf-8?B?ZzlkbUFZWkdYamh0TFYyU2J5dEpnQ3RiM29SQnlTVDUxdnZsNEtaMTdoQk1z?=
 =?utf-8?B?dVFsUG1FZ1UrUTJhcVlybWR3bHBKbDArVmh1dWJjM0VJakRES1lBWkRQa1o4?=
 =?utf-8?B?MjBQaUVlTWgyVUVna0kxalk2Q0FUMHJBM0FEcjZVVzRyNXJPN2dUdW52bWV3?=
 =?utf-8?B?UUN3UkRmaGFwRG1sQzVreVZxTWtJTnk5NW9PMTlpZndDdFBROXZKRU41QVpD?=
 =?utf-8?B?TU05Uzd6ZHBNVlJ0bWErSTBhSW1DYlJLVjVyR2Y5NjhQREs5S3ZoV2E3ckJm?=
 =?utf-8?B?eVlzQzhqQnhkR1JCcUN5MFFZWlpwTDNxV2Z2UGdPeUFtUU84TytnZEhmWFpM?=
 =?utf-8?B?U0pvSkJtT1Q3TURxZWIyLzdxQWZYWGc2MEpybCtXcFlxWCtxcElaWG9JMVN2?=
 =?utf-8?B?aERvOW5PSlpEcnRGb24wRlRvUzcrQWl3UlY3b3JCN01NZTUzWEVoZFBBRGdK?=
 =?utf-8?B?Vmordm5BTWgvTWJxbWNQdzE3Rjg3dGlCZkZzaGJyY2RRVGNQNlhraW9yWnB5?=
 =?utf-8?B?N0s0c09ycEpTZTN3azJQYjNPZm5EMHNmYjFYa1hLYnlpREZmRnVrN0JnS2lE?=
 =?utf-8?B?T3JZYVlBZVBBY2VzM3JoZEpBbjBoK0Jqb2dmZ3lGL2NCMjFPaityUW53NTht?=
 =?utf-8?B?M08vbVpSdkY0OUdRbnU5akhtUTZEVUpTaVpUT3R4V2dtTjRkTmFuSTlvWVl0?=
 =?utf-8?B?MG9LT0hZdE12V0x2ZUowM3Vja3NaQXQrTnN3UDJyU1grWStPcVRGMDJCZS9o?=
 =?utf-8?B?VjREMmJEN3pTbnRHd1JmRS9Wa2xLRlZRa3dLTzJpQ3ErZEt0VUZTVjRKMzlH?=
 =?utf-8?B?ZHF4TnRjT0V2RTQ5cmVYeEVKVkpGYVlqMlIvSWhSQkhXZ1ZRKzRwdEJaUDJs?=
 =?utf-8?B?d3NFMU9ER1BSQVVqWGtneGY3Z3l0bUlwKy9tNDAwOXhnRU4rdXZlaVV5ZS9p?=
 =?utf-8?B?UVY2N2xBbEFTMTZZSkRVVElwcUhJbG5KQ2tOYisyMnVsUFZVdEduWW9SejJl?=
 =?utf-8?B?Mm0yNGVZZ1pxKzRES0xCSmpvNWx1OXZyK2Z0a21rTU0wc2tBTlN5UkRDaGVT?=
 =?utf-8?B?bk9tenNhYkl1NVRQeFdxNi9SRHVRMXRwMmJmT0dNYjVxTXBUU1JRa1UyVWw3?=
 =?utf-8?B?V2NSYXpyNzkzMkQ1dFNWc0crbnBoOWhFcXZJbVF4MGNwY1RoTnB5MExVUGNa?=
 =?utf-8?B?cG5aVno5NVpOYS9VTEYyM09hS2ZRZnAwZEY3citnb3NLSGVTNk9oMmdmSStx?=
 =?utf-8?B?U0xRZHkvSGplb1BWQ01sVk1kVHBFVllBL0orVGJnRnFzdkVDRFdoS2JNN3JB?=
 =?utf-8?B?THZLMnJMb3NkcnhRckN0L1RYd0NIZm1sMnZia29nWXNYL2hmQUliUnU3cjNB?=
 =?utf-8?B?UVB2RTNPK29ReWlFMzRZL2kzbFB4NnlpRVRHc0l2NmFVMEdXeW9yYnRYM2gx?=
 =?utf-8?Q?bLF1g2N2LKYK8tYHC6TO2v9XFBaUscLR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REsvZXV3NitGdUxjWjFYdFZiaVZZT0xiL3RNWStaczJBOGhjRXN5Y3pJRmxm?=
 =?utf-8?B?N29IYXJzNW80dGhVSnZVeW9TcXMzNE5GVHk0MG5MdFlBeXlTRnozcnk3WkFw?=
 =?utf-8?B?dE5RVG9TRU80YVdoK3BEeWJRWEkzdC84T3UxVFZKQVJVTWt0MlN4YnVFTEpL?=
 =?utf-8?B?RisyRzhBUG1jK29xcG1ubWFWQ21sdmZ0bkRUTzY4cmlvb3NyMGZRM0R5SkIw?=
 =?utf-8?B?N0RRZDdFQUIvazNNckJkTHhZSjVRb05NUzczTnJ3QzZrRk9DZ1ZIRlFxMnlz?=
 =?utf-8?B?M2Rpb2lNTHdFb3ErZmlJYkg5cEJqRmVFVW5VZFdWdWg5UGVZaTVIOEpjaHRU?=
 =?utf-8?B?bWU2TXlXdUxMOU5aMFNrd0h2SExBME5VWkdSdWJGZk1HNzFVSFJIL1kva3Uw?=
 =?utf-8?B?VGdPNjBZdVVMbzQ4dFhHdXVNb1JkbXQ2T0trZGxZVDJVN3Raa002V24yN2hI?=
 =?utf-8?B?RmtYMUhRVFJuMzlEUEVZUHMwMDhKQkdYOFlRUXk4RUNjdXVxR0JDbDZiSHR1?=
 =?utf-8?B?NHAzQnJscml3clp4a0hnTG9YQlN0OFFicDc4MStKWDFqQThCQ2MvblVyZkRX?=
 =?utf-8?B?MHcwb0RHcUVSUGh5K3g0a3JXamlSUWQ2NUIwbmhLQXpZNUk0ZUV0UjZZSWpw?=
 =?utf-8?B?MEx2eEZBMmRYaXFDS2MzcEdwVHU5QnZLY21VTFYrYWZUeVhXaUNLa21xait4?=
 =?utf-8?B?V1ZDSVlLaGF0NmFZYi9pRC95eVJtRDJKNVplbUhzOGV3RllVMWxYRDFkZ0gz?=
 =?utf-8?B?VzFDNnVYbmJrdkZVWGQzcGlCU1NRdGhqc3IwcTJQSzhhajVoRmJkN1NtYzd5?=
 =?utf-8?B?SE9rREhvNDhmeXlPaGh5VDFNNzhybDZGaFNEQTh0L09NY2JYSHIzRkFOUzZE?=
 =?utf-8?B?VlFlalE4aHZJYVRZdnZ5ek8vS1dlM0tKd2FoTFZ5VmRPelFNZVIwaUhxL254?=
 =?utf-8?B?YmYxc3ZQRERxSjR3WjZTMDN5bWhObjdpSlkyVTdLWjVNL1BDeFJXNnh0SmIz?=
 =?utf-8?B?SXZubS8yMGp4VTh2cCtVVVMrQ0ZoUkxkazhzSnN4T1JPWXdQQ3hqTGV1anhh?=
 =?utf-8?B?MXVoNjhSYmtXUHVlbUdBWTBOb0REdGxDdjdCUmZUenZEYTZwSWxjc3VmeG5G?=
 =?utf-8?B?eEV0aGd2ak9xOEg4QjI4akxydVg2QU5YU3UrQVh2OTlGU1J6bG9pZUdWWlJW?=
 =?utf-8?B?dUR1WTlEYnIzV09BL2N4Wjl4OHBWaGRGTHN4OE43UFRLWlhSWXU4cGh0MDFR?=
 =?utf-8?B?L1V6OHZ6M3Voa2FxYzhZT2RCVTZkVlF3c2NPV3lPVWtpOHhYSllYZXlBWHBQ?=
 =?utf-8?B?dXdrQ1k4Y0VseXduOWp3TjUrTmh1UGMvVmZqUk1KcEsyUUphQkhBdEN3NWNY?=
 =?utf-8?B?emliTm11L3JENjZuZHVyZWMvNGZlUWVSbzM5d0poQmRGS2tndGNEM1MzeHR6?=
 =?utf-8?B?ZHk1a3JlWm1TR2t1cEdRNmp4NmZkcnhKOG5aRit1Rk1OSUdEVXpvd2piY1lj?=
 =?utf-8?B?cHpFRWYxekVDeXlOUVV0WFZDUkhaYUwyL3djREdEUmpTTnhtc2JnNktWSFdk?=
 =?utf-8?B?MnVNWU9CMW5oTEhuTzc5ejNPOUYvV0xzQ1AwV3Q5b2pnb1UyTFhSbjhXSTlQ?=
 =?utf-8?B?ZFRmTEFjTUJZNnNKNlAyVG5qUDVuWDZIaEFmZG9QbEN4ZzRkaktya2lrbUsz?=
 =?utf-8?B?UkJIRlk1dUowM1BiQnRNT0NqTEdRbVlkZEo2dmhzUDhxQ2NRS0ExU1dTUlMx?=
 =?utf-8?B?aWhUOXF1d1BCaW1nbnEyWXEwRDl3Y1JRd1ovN080NjRpKzRPWDQ4YmtweDlo?=
 =?utf-8?B?RU5VOGRwY2J0VVlXdW1GT0pFTHA3VXFqUkxxblFuY2xQWlk4K2Z6amFGRk9V?=
 =?utf-8?B?cmt4TzVSLzNHdFlXWkdaVjkyQXRXN1d4K3BiZktzZGc1eTdDdXFWNlJqblZB?=
 =?utf-8?B?MmlpRkRiZElDaGdaamNhWi9LcG84U3RCZDdTeTJBR0VUMXhMbGwzZ3lXMHNy?=
 =?utf-8?B?UGtDOEVkcnFiNDFzZlROR3ZWVDloRWF5LzVzYUhtRUQ0Mlo1d1VXNmpuOEpu?=
 =?utf-8?B?WWpYQlpHVFRaMjM5bVgxR3VFelMwMTZiUTF5UUxjV1lyZ0w5QlhGV3BCZTBN?=
 =?utf-8?Q?MEsJXBobX2iK0bn9vKCv9YSAK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c66d074-e915-4b87-03b8-08de0ba11acb
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 04:12:50.4399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsYTXM+EsQvfVao5evz0xbc53npV2Rt3qCDJkOTtaIlO8dQ6F15sbmvUwsKAJbQsQo4/M9AuTRO5AUa8iL/zvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309



On 10/15/2025 08:27, Alok Tiwari wrote:
> The MDIO read callback xgbe_phy_mii_read_c45() can propagate its return
> value up through phylink_mii_ioctl() to user space via netdev ioctls such
> as SIOCGMIIREG. Returning ENOTSUPP results in user space seeing
> "Unknown error", since ENOTSUPP is not a standard errno value.
> 
> Replace ENOTSUPP with EOPNOTSUPP to align with the MDIO core’s
> usage and ensure user space receives a proper "Operation not supported"
> error instead of an unknown code.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Looks good to me.

Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

Thanks,
Shyam


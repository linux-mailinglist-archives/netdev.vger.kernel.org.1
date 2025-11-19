Return-Path: <netdev+bounces-239853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E53C6D2C9
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7EA5D3847B4
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 07:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778C432AACA;
	Wed, 19 Nov 2025 07:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ssv2Jt4J"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7BB32A3D1
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 07:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763537618; cv=fail; b=PWJrY8/Dn2BGaOTk7CzmZ+ZI18oUUkfVZWurrlLVvnfPtOyoFAeXFn+iLoTFnW+K0Pm/gC8ceE+5M/565k9NdoPKeTjEfN3JK9Mp6bH3EtV9kI2DRBWh4l9jzNcnO8ICatUZav3kUMMQaoM4EocJVQoVJU7iFfEWTh00UyJ0zDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763537618; c=relaxed/simple;
	bh=xwFWDAl5tLhZ7+Rqzrd+SBBtWTxHjMpOovkNVAlIUgk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F0ygHm7XDX7QMWQSzBxkEqGYTwb68c2JjPTChkgNchbJzgjhdvfBd0LLlbIbwpKHOwtEF6Kt0fGfiiIAoauO2KVK1I4GojS8IKGFPSNEoa9gAiIfqMNoXEqawxmx6hWdkaSCo3aDeMPP+Upo9BNKS62gz/UfF2l+HbrJ9QJ4LxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ssv2Jt4J; arc=fail smtp.client-ip=52.101.62.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XX16epBPeym/2S+aBnjRIsy8SftQzGdJe+pUvbMnvGfX08fe4/2eUhEwDJIJAGHBIwEuE5Fc2daNcBA0hXkWAobg6VxOel+AB6YDpNfloj5l9lbGGsJ1Qq4MCpoylmEd8VITISDWuEmBTkk197uW3pZq6ndW+LWVPQ2d649dWi9qbGtkn8OPOqt6WjOxo3qZewiLj3FlAdsbEjxn24zGECbdxygPTL5QctFAnzK2/DNyM52V2dm/NX7Gw5boZCBupa+1y0fVkqmhL49k08VOXB260oAw0Q+wfY3wf1L6tcYkuTnztZHC+GVLzIHBEDnNwyYwIUu62UQ54jz/AROV7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrrvNRuUIHDX/NRBdEfHDByY4bk6O9WLR+kP4eenSas=;
 b=gywgiwVuf4HcIl2EeqfAF/+f99ZCFOZYXj0nUBcou+NMq5C2MTX1OpGLrsJ11ZJlTmAWaQLopNhWMEQVZIYyTflFRpJfqrTfVVYj6StjdSqsAz6bMaL/nSotfDAlv1Pe5KauUli32Bx5KtVe05YZUjiaDtB2iKvs/H+5sjFEJpkpVFu5P27xvwK81RO8XmiQ2edk2Ph2db93dGNUMlWV7dNUmzr0/AyfxOeeMJIkefvYiYv3gwWwUoNZGElcU+r6HfLN3gok8uJKXtz02iBhZWggiGLQDe5x2Uf0L473IdnPytgTarXVVvMjnBvlbNyNsAmWpo9C+L83kQ9H2cBbBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrrvNRuUIHDX/NRBdEfHDByY4bk6O9WLR+kP4eenSas=;
 b=ssv2Jt4Jev8RDTbpJHhuIJmKB4o2AcnBv1xShZauEyTphVDMoTkc8qiIaLTwwjzQ4lS6C//XGdRtJlFpqkPTDOXHl4YW9RZ1bpd29BKjKxSolsy52yZV8SuREDyefGOvtN173QuvL5MnJMprFMFZmqfBqcRIdOcK0RhDXioRf3teT85fIY5wCkFHZAdPAf6uauHA0z2MD7ZcCctrVlddAp5YGKCDtu7ZCwSmEBIGxqjA/yjM7tYBaVXUwThyt8uFHrlBT7NfKt0lzqIBUKBnV0BZpQTvAfCIRmGXNY7Xapz9+NyKDOpa5l3Y/X/PK/stG8hkzuepmdY2V1gYAMrwmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 07:33:34 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 07:33:34 +0000
Message-ID: <e80a7828-f42f-4263-89c1-66512b2dde6e@nvidia.com>
Date: Wed, 19 Nov 2025 01:33:31 -0600
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
 <cb64732c-294e-49e7-aeb5-f8f2f082837e@nvidia.com>
 <20251119013423-mutt-send-email-mst@kernel.org>
 <e23b94ab-35f6-41fb-91f9-1ba9260fc0ed@nvidia.com>
 <20251119022119-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251119022119-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:806:f2::26) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 71aad602-46d5-48d5-bfbb-08de273df1e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnB6MXBvelIzTlpxc1UrdUd5Y3NzRDE1Qy9sWS94UlNzN2VrU2VtWW4xT1NR?=
 =?utf-8?B?MVZmU29nYXR0eHpWQmJkMnIzYStweGFJaEV2YnBXTXJhZG9ZSmE5eUx2RVNa?=
 =?utf-8?B?VlRkZ3NZOThVUTZvTFdkQXEydVo3RTFwYXcyUFRHTUp6RjFQQ0k1ZFRvR3cv?=
 =?utf-8?B?UWh4VkF4Zk9YL25nRnJKblFrL1pENUlNT3o2eDZ1MjdCUk1jbWVsVnhJK3g3?=
 =?utf-8?B?TS83MU9tRC9aWk9peEpzelRBb3huY1ErTGxaa1puS3J3THdra2RJalVZbDZM?=
 =?utf-8?B?aDh6cktsTUV1NmhrR05Da2FZSHRjUzE1ZkgxazIvNFRoSVRVeGV5TVh0T2xB?=
 =?utf-8?B?VEcwSnBEcWNSanFiV1VnVmcrNEtUNUtzRWtIZTZJNCszSGZYTGN1MUVoaVFu?=
 =?utf-8?B?WEtWdlBVYk1DWnhEaGp6ZkUwbXFTbk56RXl4Z1ZYYWFjR2oxTHZkUTdDbnpU?=
 =?utf-8?B?SHEzaHNOQ2xNZWErS0gyQmkxRmM2T2hXQlM1UW5iUkI0bThMVWRNcjZid1JD?=
 =?utf-8?B?QmZMZUl1a0RFWFNuNkQ2VlhSZFY0ZHViWk5uMmVWZEhYNm5XZU9COXkzR05S?=
 =?utf-8?B?anZZd25pQjVlK280SmNVbkZqYkU0bWFtd2VVbXZoL29sTHlTU0VOaWo3dSty?=
 =?utf-8?B?a0JabkRXSmJlQWdHYlA5dEhIRUlrdlA4NGg1MWszWWxBZE9PQlFKbnFCTzZS?=
 =?utf-8?B?MXBzc1VoM09vNmdOV2srM05ubmlpS2lvMnZIN3E5RUtwWmRlbDVLMFJ3alVj?=
 =?utf-8?B?REx6MU9ROWt3bmFMSGdxcVNxakVodnJhUzJTNzUrYlh0dnVZVHZqRjVQUENz?=
 =?utf-8?B?bGpBVlZKTnFicDBualJPWGtKSmwwQk1LTFdRREU1TURQTHdqRUg5d25qYnRt?=
 =?utf-8?B?OXFWVlE3L1ZpQ1AxRGZ6K282RGlodGUzUDU3QXlPTjNLdjFSbHBFM2ZmQXkw?=
 =?utf-8?B?d2dTV2taTVhLRjYxNXd4MW5sbElRK1JkU1ZUclhpZ1YyaWUyUWdFcHQwK09C?=
 =?utf-8?B?MnREVnp6QUh5cG9aYXUvbkFMNkFoWnpuRVZ0bU1zT3IwY3pMZm1hU29xWGNl?=
 =?utf-8?B?MWl1K05kekMwT0dPRzFlWlI0OE92NU4yaGY4OTFPM1BVaXBVUnllaVFlRnp3?=
 =?utf-8?B?UlFRKzBWdzJ3UE9zNEhTZU1pb2lXK3doNUxzN2tnYXZlc292MGVici9VMzFC?=
 =?utf-8?B?MHV1Sm5iUnljUVlYdHV4UFRyM1NMR1VDS2ZySWxqVHd2NWFZY3NuRzg2bFM0?=
 =?utf-8?B?MkhKL01QOThBR3hDbjA4dXZ1M3U4T0dQd0M3SExjOW93L1FTaklOOW9tMnh1?=
 =?utf-8?B?cTQ5Y0ZWckxMMlVhM1VoRzlmR1o1ZEllRmJMUDE0UEEwVXFiNTd5UUZ2Rnho?=
 =?utf-8?B?K2w2Qm13cVZPQUplUFk2TzA4b3Zqc0U0aGM4N3ZsZHFDSm00NnFxRlZZb2Nu?=
 =?utf-8?B?a1M5L1BuOExOeG1Eekc0TEdjc2R3amtOYzNZeWZLZHpqUWZHM1EvTGh5MVVH?=
 =?utf-8?B?eHZpOUlxYUVjL2NPMVcxUXFGb2R2MDdQRFowbzIyOTkvdXhKUVNFNDc1ZTVJ?=
 =?utf-8?B?ck9UQTFHOG9XNFl5bUNNaUs1YlFqMXlzc2RXUzE2TklXLzRkR1ZKSEt4THpZ?=
 =?utf-8?B?N1NrUkt3dzdMRG1oKzlUNTdZSU4wUnFkaUczZ3dVTmJKNWw1RktSenI0WVBl?=
 =?utf-8?B?QmpFK2tLRzRnazFuazc0b3pDVmx5bW1NazExN0UvR0pyU01hZFc2eTFIMkN1?=
 =?utf-8?B?TFZLRnZrTTZ3dHNmRFJXRTJNbjBUelNXaFZTbDJxc3ZoMFZySGNaaEJaT1cy?=
 =?utf-8?B?SWlET2lkMGhEbmozZFJLaTVXVjFRWDFlMkkzMXRiWHczOVVnZjB6UnhxU1Fq?=
 =?utf-8?B?RnRoajFlSGJxdzk2UlVaRFlVWkg4NFBPQjJZVDFWQWF2cEpkbkw4NmtWZVJW?=
 =?utf-8?Q?6ccs8la97yG0ijhybv8le3kCoRhb6UNl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1NodmpTeEhpYjgwRkJscmhJZXk4U0hHMnN5Yk1BRXNEMkxERit0RVdPUVY2?=
 =?utf-8?B?YWlncUpZT1NTZXNnVlA5UW42dTM5Mm9BWmNGUUpiS2xPOEN6Smd2THJFa3N4?=
 =?utf-8?B?ODN1bzNDV0g3RDZ3VEd0MDcxbUFKa1pBUllxQjI3WXBqVnB3Z2tpa3UzWEo2?=
 =?utf-8?B?S2xyRXVYVGdrUTYraExYK25NREtMMXJ2ay9aK3VMWG1KZGRBSjRkdGRacld4?=
 =?utf-8?B?RVBkQ3lhcWxXVjUxMncrdVRweTdGSGdnZ01oVHRxSGE0N0xWeVB0RzJpT3Jw?=
 =?utf-8?B?UzlaTkpiNWhiNWc4eTRQS1hlWlR1bXViUHVXcTJMNDJNSzcrcVdNK0E4R0h3?=
 =?utf-8?B?dCtPdmFzb1lQWUhqSmsvdlF3WkJScDBxU2phYmEwRURoSHBvWVZZQjc5dncx?=
 =?utf-8?B?VE40MW1qaGlqRi9IWmR4eW9uTjNaNWc5Y3pwcGs3NGhKWjBTcUhlNHVReSto?=
 =?utf-8?B?azVLZFF3RGFFcHUzUVoyNWNoUS90UkRzaE5ORk1hbVlHK3BiZFc3dnJ6aUxJ?=
 =?utf-8?B?OWJrOXNSNVNyNkJoSUxPV2FoR3Nac1BJTzErSHU2eEJFLzRIQVJhRTE4cEFk?=
 =?utf-8?B?YSs5YzNXRldpWGpsTXFIbzFhQTFOcmwxR1o4QmhKK1EwVmNGTkVKTWtZeml6?=
 =?utf-8?B?ZmpaNktodXRCYjRvWExTWm96ZnUra0NxWnZ0RjJDalphamF3RllHOFV4cjhT?=
 =?utf-8?B?aHBnRjdIeVRPZEZFckdvdE1URFVXdWxXbGN1S0ZTRFVLSXVEc3UwbkFhbzRL?=
 =?utf-8?B?WUhrZWlneUZ4cTZ4cWJpQXdMTHROaW0yUnJMYkllZm9yWnZRdm9obmtTaXh2?=
 =?utf-8?B?Ti8wamErK093QURBVWFhOWJ2OTBCd3FYRG9pTm5LTDlXMkZ0SGUraVV3dTVv?=
 =?utf-8?B?S0FJWS9naDQ0d2tnZUp1U2tCbytSVW9qd3VSQ25NUFM5UUxSWFd2ZUs2WVpP?=
 =?utf-8?B?QkVxRm5SamcxdkJIMXVrYWFpSk5XTXZWaGlJOVArc29OUHFpMEpKZjZydzI1?=
 =?utf-8?B?RSt4SE9qNmRIRmpHRStMTjFpR3htckM5RGkzYm9IblFneHhqM0l1TmdDQ2pF?=
 =?utf-8?B?NTM2WlRzQXdqNVFMZ0JDcGd6OU4rb2lMZFBoMEJOc1Q4cFcvUjVUd01jREtO?=
 =?utf-8?B?UlQxY3RRa1A0M3FvTjlqS1ZRdDJ4a2JNR0gzc2hmb1lJTWJkQitFTE5mUzRE?=
 =?utf-8?B?UGVMWVZ0QnBZczdnbTc3eEJJZUtlbWFyUXY4ZGcvaVZPOXpCMGZNNlJESk1M?=
 =?utf-8?B?ZE51ZjVKUzM1NFA0TUEyQWFXQ2hpSUEra3VoTk5ma3V1MUNHQ1QvTmVuL2Zv?=
 =?utf-8?B?aktoOVNxZTEyNld2eU9kQnBnWmpTbVpLZVJQRlM2Zjk0UURpMTJqTWxxa1lr?=
 =?utf-8?B?dy94NlNqaTNFcTRqYnQ4SmpVOFltV0VYR2Fxekt5WGpzdUpqNnJlRkdUUlVB?=
 =?utf-8?B?WUhmcFV3NFVBRnl0c2gwOUM1dDAydXBTYWpWQnJENFdycFdHM1dYZHF2a3Zu?=
 =?utf-8?B?dXJScjVSNkNSbFZMdzFZRXpvZjNIU3YwSHR1Z21henBybUYrSVQ3cERrdU1T?=
 =?utf-8?B?aCsweUdqdFNyaExycE1DK2FzeWljQWlZT203WDg3azUrVTMzTTJlRkU4V3R6?=
 =?utf-8?B?QmhwVFBVNFIvKzF0dXlQSE5LcDlxSGtERkZDaHBGZkVsRjdvaGhYWityeFZS?=
 =?utf-8?B?TGl4UFhIV0NmVVVibkc0dkFMaVB6YjU1M09UNHNodVlFUTluMWRxVWd1L3Bk?=
 =?utf-8?B?Vi9TVFh4a0U1Z05zYVZRUmVDekhKUHF3cUhKaExwVzhUQ3Z5MEFaSmc5a2lN?=
 =?utf-8?B?ZStGSFpPN2xqNGFQOFkvcXdJNGNNQ2xuTW9WRENhS1BFd3BuTHFmQkVSS09E?=
 =?utf-8?B?emM0aThnTEx4Nk5uQUpBM2J2d2J3c01tTGVzSTFIV2VHRmpBeXpOTVVrRXN0?=
 =?utf-8?B?em9odlRIQ05oRWZ5enBiLzI3YzFwZ3ZqTzFpMDNZVHV1UkIwcnZibzNOcHpw?=
 =?utf-8?B?S214YUN0MTdlVC91dVBYYVZBTDYxWlk1dmdZQ3JTam54S2xaV2VoV3pPM3ph?=
 =?utf-8?B?aWJNUS9PNFp6elBjL2F0MngyWXFDVThabUlNcUV2MnVSaTc0SGZPNUhZdzF4?=
 =?utf-8?Q?XV/xh54T++scK89cU1ZFIAkJK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71aad602-46d5-48d5-bfbb-08de273df1e4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 07:33:33.9533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1CPCg2UC1DL45ndmWnP9kb+fWD/224/vnFA9mvHbMPxap30Ct0qbWYfxnNrP9OXJCEvsiNob8WwJ9dUc3VJREg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346

On 11/19/25 1:23 AM, Michael S. Tsirkin wrote:
> On Wed, Nov 19, 2025 at 01:18:56AM -0600, Dan Jurgens wrote:
>> On 11/19/25 12:35 AM, Michael S. Tsirkin wrote:
>>> On Wed, Nov 19, 2025 at 12:26:23AM -0600, Dan Jurgens wrote:
>>>> On 11/18/25 3:55 PM, Michael S. Tsirkin wrote:
>>>>> On Tue, Nov 18, 2025 at 08:38:58AM -0600, Daniel Jurgens wrote:
>>>>>> Classifiers can be used by more than one rule. If there is an existing
>>>>>> classifier, use it instead of creating a new one.
>>>>
>>>>>> +	struct virtnet_classifier *tmp;
>>>>>> +	unsigned long i;
>>>>>>  	int err;
>>>>>>  
>>>>>> -	err = xa_alloc(&ff->classifiers, &c->id, c,
>>>>>> +	xa_for_each(&ff->classifiers, i, tmp) {
>>>>>> +		if ((*c)->size == tmp->size &&
>>>>>> +		    !memcmp(&tmp->classifier, &(*c)->classifier, tmp->size)) {
>>>>>
>>>>> note that classifier has padding bytes.
>>>>> comparing these with memcmp is not safe, is it?
>>>>
>>>> The reserved bytes are set to 0, this is fine.
>>>
>>> I mean the compiler padding.  set to 0 where?
>>
>> There's no compiler padding in virtio_net_ff_selector. There are
>> reserved fields between the count and selector array.
> 
> I might be missing something here, but are not the
> structures this code compares of the type struct virtnet_classifier
> not virtio_net_ff_selector ?
> 
> and that one is:
> 
>  struct virtnet_classifier {
>         size_t size;
> +       refcount_t refcount;
>         u32 id;
>         struct virtio_net_resource_obj_ff_classifier classifier;
>  };
> 
> 
> which seems to have some padding depending on the architecture.

We're only comparing the ->classifier part of that, which is pad free.

> 
> 
>


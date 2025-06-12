Return-Path: <netdev+bounces-196945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C01BAD705C
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3088D1BC6B0C
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C9F230BDF;
	Thu, 12 Jun 2025 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HMVXmVzH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E8522F76C;
	Thu, 12 Jun 2025 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749731227; cv=fail; b=QzUgyN39GpqOY/UeEw36+faAb7cSioXVIeEBtXOuYK+UAVBDFEziF83hsy/hb13XYLnIos3+MyqT7Necx5Ud9jKX8APsQRL8OGgoAJsmolInmohHphrNfx1jr9Sgd1inorpFHANhLeP5NBprp05aIXteIdrOTUo7PkV62bBPduM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749731227; c=relaxed/simple;
	bh=QWWrqOTqxeYg/Lk0y1ZQo9r0Ir3mA+wCuJEgMKW1s00=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SfBgdYzBzKLLbHbvQoWf8YjwaL4KipT1hpnfNHHO+t7v6uxrpNMDOS2uPUPaHfDsKbUS82+dog5B8OVoGBx4eqfXPx9pLZX914cOch8xEDxtX/rLlU9PRFcMztTIe9zHTb4P4WEC5r6eDz3pAzXvzuQH4v0soDzQLkjkza7oo54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HMVXmVzH; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvBypL6B0SBn9S2Xx82bk+DJJDxbXLfQDKTxIw4JNnFdFO2Ov0BOxbc7TCv7qP+N2N+GfaqrhM8n0oQDeKQih2rDRVmqWIlGN8EcvcSs+x8z+VkY++KPeTc4yraYHlOV1nII7eC++6HC27zldrvCN4euo2RlUWR472QStQ0c6CxqQb1iagvzQInq7Ky18uHGl5z4egt4PcwJXy1pywbkguIugihXOEqkFXFMmU5puopoEwGfrv1103rqwnUK/CeP7WOVqqRC7Hm9st3N4XWFSadN00mRpizX/CSo/xthqtEao+LXPUlpAOcqg36j0J+19vph4EHOdoqZCTFU7JxLog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVsKJxaKwe0EJ6fh5GLbw3N02smVQd6gfcpxOalilSI=;
 b=HYyY8uZy3PNiWtckWBoiNSLhoTq8/MZ35o5l90GkvLtB9uCN/fWkN3ZnhaBWpMuIwZDY/fViCtsSaJLz0sRp6vaR7NeQjrXIS8FmTc/tYo+/9X2LEXuIIYDDgJYuz5+Ut2mUKkSE0uZABwYUcEBFDH8rdADjIbbvhnNkoUDc/rXfU+UkqGLEMSikN2tB0qd6pioS1HLN3C6uSb9baTJV704UImOMFtWOnYZFMAD2reZY4AboK+jWKGRIdTSdfIjjpJg9GJroh/4Dzk5PJnIFS+qdZdtYU/nlYjqAG4HogxSrmw5/Nb8fhuTxqt9sXi88kUSerCtgOJ9BJbO/5CCGug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVsKJxaKwe0EJ6fh5GLbw3N02smVQd6gfcpxOalilSI=;
 b=HMVXmVzHNL6vrCfRMPr/Jnxu1XVniz35qbDCJqerP5+RgPRi5ICKZifKZZRNCcyQR4EEGPEX3fnW9J9SL5oyLJ+pUI1L50ch1xV5XuZLscivQzfovPDtlrvtP9wDF5DWOk1KlCiXyio9j34AcDJbCX5mJV3Vb3mlGen+LTVzzpFDhUm2oJLfCwkyUfASIlXHRnn/dGS06XI6zFi95+WyiEyAZVo1qJlqI+VcLtHN9N04xUess+CMO8zQ5+R+/1nAKbNpG765BncY56z46PfbPwbPmd4ORTNf4KebL/AV++gxKY8BBdtE+TOYFrjoV4CdEqakLcNDhSoHAdkDQ8Ijeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH7PR12MB6978.namprd12.prod.outlook.com (2603:10b6:510:1b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.24; Thu, 12 Jun
 2025 12:27:02 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 12:27:02 +0000
Message-ID: <e720596d-6fbb-40a4-9567-e8d05755cf6f@nvidia.com>
Date: Thu, 12 Jun 2025 13:26:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: Fix PTP ref clock for Tegra234
To: Andrew Lunn <andrew@lunn.ch>, Subbaraya Sundeep <sbhatta@marvell.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org,
 Alexis Lothorrr <alexis.lothore@bootlin.com>
References: <20250612062032.293275-1-jonathanh@nvidia.com>
 <aEqyrWDPykceDM2x@a5393a930297>
 <85e27a26-b115-49aa-8e23-963bff11f3f6@lunn.ch>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <85e27a26-b115-49aa-8e23-963bff11f3f6@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0093.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::8) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH7PR12MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6d85f9-a66e-4d40-e1c4-08dda9ac6f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnVWV0k0dE5JZVBHNHlOUjRuN3cwUmErRU1MWUp4Z0libzlVdnNjZm1yZG9U?=
 =?utf-8?B?bGliYUt1Y0w5Zjh5ek12ZFZQTlNKWGxkVVZSSXFtYzFHOVdCamNReDU3Mjcx?=
 =?utf-8?B?MVFyai9OQmxUM245S3VBakc2bGRwMzdWQ2FmL3BDU01kNXl0NXBZdDdYejl1?=
 =?utf-8?B?K2VmaDNMQy9xaVhGSEdJNk9ZclNLMythZU0zTDJiOCtmWFJCS3dpSkRJTEUw?=
 =?utf-8?B?QitYYlQ2OW05VHlBNHNGbkJyN2pPTTVsNUp3TUttYXBHdFA1U2pudzNReGN6?=
 =?utf-8?B?S2Q4U1FvL1pTVllYZEs2bGI3MG9GU1Fia2RLUXdFZHE4MnQrckVQVE04Rldu?=
 =?utf-8?B?VXFPTWVWMjN4aDkvTVprYWIxSzhNdUpBSVFkK2xmdlg0Y0JEaHhnanI5VjFr?=
 =?utf-8?B?dW55U1U1dCtwd3I5YXNJV3V1UHdKVFUyLytlendQeFIrZXd2WE5xWmIvTlky?=
 =?utf-8?B?OTFuUlU0RDUxOVN4WXZZL1NyV29VcHFaSTJoOUdockJHS25KMFlGVE45RG03?=
 =?utf-8?B?SldKVHVrY1FER2NxVEF3RHBSOWtEZkV3Nk9CNk1GRDJaa2ZpV1Exd1hlazdO?=
 =?utf-8?B?SmZMVHVUaHJFN0VpR09wZEZhSTRKS2VLZWYreEtDaFNHQjY4YVZHMkFGSEww?=
 =?utf-8?B?QVRqVllKUDkwRXJXdjBKUlkvMHU2RlhGclJtbUpDTXlmL2psUjFUd1JCUk5u?=
 =?utf-8?B?VDVqdjRKbVdBTnJUOTNRM2F5MmxuRTZ4RUxpQWtCdUIxTUhOYWxXMGR5VG8y?=
 =?utf-8?B?QVBaRFBJRW1IT05TalVFbW5hSHYyUmx6dFBrbVJRYkJvM1VTVStQWGE3djZ2?=
 =?utf-8?B?c0J1bFdKc2N4c3RSUXBsVUdkMExaTVFXclF3Z0c4VFVXUjVYaWh0Mi9NQU1x?=
 =?utf-8?B?WUVwKzRVM3ZIdHVabUltK1VVMUpmd2g4bUhIVGR5L1FkQWJMTi94a1A2bGhh?=
 =?utf-8?B?WWdnNlh4QnlDY1FycnRydkZKanRJMENTckw3THBheHU0L3FDWGNXVmxxY2Mx?=
 =?utf-8?B?bmpPOVhwVWhGOUxlNFJhZzNLTDlqeWtzQmZCREVnZ3QwS2lmY0dYU2I3WTBE?=
 =?utf-8?B?M3IyazVyVFNKcFpuZzAwRVhvNXpCRWIycXB6L2I0dU9nY09sVE14U04wMjNH?=
 =?utf-8?B?VlllN2NheDljTFhuYTN5Yzl0R2dPeXFrdVhRMGtlb2pVL2YzZkFKeThmUXgx?=
 =?utf-8?B?b1FLMGxWdmd1RkYzUTFhV2ZSV3BEUnJCYmdxcWVhWnZ2ZTdRRTVvTFdEVmhT?=
 =?utf-8?B?bjA4Z29YOFpvS01IWkhGR1ZtdHRzK0p2TXNFcFdkalVjS0UxL2JRQytBSE55?=
 =?utf-8?B?bmlyQ2tmcEp1MG83b0pVbnQyKzh5dTRmd2dhVUJNVE1kQXoxTGRXbUd3cWpW?=
 =?utf-8?B?YU5nZ1EwaHB1ZnpsaWREeXFSc1BOVlVHUkUzT3FxR0E4STYxeTZyb3V5ei80?=
 =?utf-8?B?N0tkWFk0Q3d2Nld3ZzI0YU0xMTljeHZ6MzFjNU9KaXhhaUtkQWh1eTVNU0o0?=
 =?utf-8?B?dnpQeTZTb09lVzdoYkJieDQ0SHJ4ck12emlqVEpBWG9YandWVERVeHcxOFZO?=
 =?utf-8?B?NE44S05yU25adVN3bitiTVM2Sms4NHJZYUtIL3ROa2dBeGpISU5XZXlDRHZx?=
 =?utf-8?B?clkyS0dFTWYvYjByUnBld0dmVFI0MWNhMGQ0dFBLTGp4bVB4S28zVDQwUkRH?=
 =?utf-8?B?R1VtdFlPVTB4VDhvYThxemcwaW5oUmRhNHJlU292SUlzaTNQcFFMTVlYdHZv?=
 =?utf-8?B?UW56ZDNzanVFQ2twQ2R2ZzRCcGRGMDFXdGdCaXhJYlIxenNtcDFKbUdwVEZ2?=
 =?utf-8?B?aTJvRlNNb0ZEZGZ1YXVOQWk3NEErNE1jWkdSbDl5QWFWSHNmQjNSV3VGL1g4?=
 =?utf-8?B?RmQ4WHZhYUw4bXpSZmFoZEgvYk41YVhxaVlpY0ZFUncwemhubFVwb0NEMWNh?=
 =?utf-8?Q?i9NYlLm4LUc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzRiYzV6SUpJdXppUDkxSFZLSm9TQTkzejJaVC9IRWFpRmFpUjY0dXB3eXpV?=
 =?utf-8?B?cEs3YzRaOEJGZWxzZm8rRUQvaFgzQmE1UXZOdU9hRTdhN3o0dmNyNmFob2dh?=
 =?utf-8?B?OHJORXZGTW1xTFVmRWJkYzNrWGZVZ1pFMUV2cEx6OHhsSmRjcFIxQUMrc2ND?=
 =?utf-8?B?eVdrYit6S3g0dEg5Z2d6cXkyNWdhbDVoOE12bmxHdTVUV2lJSTl4dUdnTGU4?=
 =?utf-8?B?NVBLZkV4bU83UzdQSU52SjBNd3F0UldKbE1yS2RJTVJzZ1Jrc0F3dmlWL3Bi?=
 =?utf-8?B?MDJWNEhzUVNJcjNjUmxRR3RJQlZPSkp6UVl0VmFhWWgrYlVvcEM3SjQ0Mkp4?=
 =?utf-8?B?K2NodlpGbU5SZGNobVhsQ29WbllIQ0N2YXM5QUxNbjJ5R3NGYzI4bGhqUWJW?=
 =?utf-8?B?TTRJZVh2NnVSTjE0ZlhZQ2RtY1RBODdZQXFONnRZeWU2OUhKeG81NHY3RzVT?=
 =?utf-8?B?S1NxQVJ6azBXOHEyYkp1NlgzeXhySGduaUkrODR0eFZnR1JCaGF1dzlMeGFK?=
 =?utf-8?B?QUdDRDNwWFZLclRMWTJ6ZlM4UXdPY0pVZGltOVZoUVRjbVl0dlBzY2NmTGVO?=
 =?utf-8?B?Z09Fc2xhNnVINGZMeXJUckIrL1E0c2JlSG1OSzJjSERLYURiUlJ1WVFHcDlt?=
 =?utf-8?B?Z1BHbkZlbVNDbTJ0OFpnU3ZKOVJCRlpSUzRzeG03cDF0cllRY2xxY0pxSFVu?=
 =?utf-8?B?dkRuU1gvS0V0dUtKL0R3L1pvbytpemJ4Y1BESXBWeDErdnpkaFdvOVgwWmt3?=
 =?utf-8?B?NlVPeGd3aHNmWlVKVUNSSHkxWlNxNWJweC9EVkg0UE9DSGVDcFlTdDRBOG9D?=
 =?utf-8?B?WVJQSkFkRzltQkwrdGhFNEE5dnhpWkFZbXNxQUdxTGZkZW15NzEwc3pNd3Ay?=
 =?utf-8?B?ZEc4RGRnd0RHb3BYcXVkbkVlR21Pc2x1QWpYaFBrcDhLSFZBemdmdS95NGlI?=
 =?utf-8?B?WVRaeFJNL3loT2EvU0hVekhpcEdYRnBNNkpzSDFOSVhYL3d2WWJxZlRkOUNO?=
 =?utf-8?B?d3YzOXpsVkJaTitxbGdFcjlEQzB6VW9QcGJqaHlvTVBWdGF1YndpOW5sdG1O?=
 =?utf-8?B?OUdUR05qT3hPVHYzQS9TQXArWkhmUWFuTFJtNXNrVFNhNjNML3FPbC9xNUtM?=
 =?utf-8?B?UFczaFVQR0hNeEd1TEw5WkhFcjRxeGVBT1N5NngzdE1tMVMzN1liN1hTVExa?=
 =?utf-8?B?MnJwK25kY1lJWE1UTGF5MzVKNStrMlVtYWcrWHZBZmowTGZSK0FBc1FWeG1G?=
 =?utf-8?B?c1R2TkVzT1IvVEVaQzFpdFkzQ2tGdTBqcUtpaUovQy9SK0JYYmhGRFM0UjRW?=
 =?utf-8?B?UmlGY1U4dHRhTlpVMGhwT1VzWllFSk1yS0djWVB0M1Z6cXJMUHgwTC84N280?=
 =?utf-8?B?SjJaem1neEphRnUweEovdURyaFZqZmpYTVBWMmFFa3JsVlIrVDFmcUp2akpE?=
 =?utf-8?B?cW1WS0lFQ1c5eStCRVd4MHYzeXE2Z05xaFdJajlKS01Ya1FHemlDRHlsTTQ5?=
 =?utf-8?B?S2xKa3I5N2pVeXNjSlVVZy94UGEvVjNRc1NscGNleWRkVzdmMlI3UVM4QkNL?=
 =?utf-8?B?Z2V1TWtxZnM4N1pBNnVuYnFad21teFNYNWNteTBwVTVUN2JxZXE3ay9NUlMx?=
 =?utf-8?B?RVBaUjVZSE9RUFlvZmdMUEU4MFBTL0FjL29abEpxeWR4SzhXUklzODAxSUw5?=
 =?utf-8?B?SHFjRWNnN3duRVN6OXA1YzBRQ0VPOTYwTkxzL2ZYU1NYRnNlZktwVDZiS3Yy?=
 =?utf-8?B?elhJdmRGL3YwUzR4ZVhjYmIrZmg5a04vZ0JDU0syUWlSOG8rMFY2eCt2Q3Fu?=
 =?utf-8?B?bU40dXNTQldaNk5GM1A4NW5QVlB0VzI4d2ZRMmdEQWtqaXQ0TGQyUllRQlNW?=
 =?utf-8?B?REMzNnZVdVhCZUsrRnpWelM3dUVLeU81UFZIK2cvTEV4cnA5eExQbUlySkxT?=
 =?utf-8?B?SU54RFhoZlBpQjVQNUNvQ3NSM0hKTTdtS21EOVVCY3hBS3FjYkhrcWI1UmQz?=
 =?utf-8?B?T1pUWndWUk4xN1Q1YnpwSlVEb0l6TG1yczZZUUVWYWtWTi8xZ1ZoS3JvaDY0?=
 =?utf-8?B?Z0hjeUtEbWVaWWNEaFduNVRJQU1kS0ZhaXlLZjZ6ZjJmNEFOSDhlTzJEbWJv?=
 =?utf-8?Q?CEDncWwgVdDivH5ENmFELJmE4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6d85f9-a66e-4d40-e1c4-08dda9ac6f0b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 12:27:02.1348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2aOPZjcGbvIxVmL6kxTJa40KgRQ11k9uTsjUcPxmOVhSYu4c414HCzH9ZfCEOhYM8/OmPOWrSJ9cMSOAmGeFIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6978


On 12/06/2025 13:10, Andrew Lunn wrote:
> On Thu, Jun 12, 2025 at 10:57:49AM +0000, Subbaraya Sundeep wrote:
>> Hi,
>>
>> On 2025-06-12 at 06:20:32, Jon Hunter (jonathanh@nvidia.com) wrote:
>>> Since commit 030ce919e114 ("net: stmmac: make sure that ptp_rate is not
>>> 0 before configuring timestamping") was added the following error is
>>> observed on Tegra234:
>>>
>>>   ERR KERN tegra-mgbe 6800000.ethernet eth0: Invalid PTP clock rate
>>>   WARNING KERN tegra-mgbe 6800000.ethernet eth0: PTP init failed
>>>
>>> It turns out that the Tegra234 device-tree binding defines the PTP ref
>>> clock name as 'ptp-ref' and not 'ptp_ref' and the above commit now
>>> exposes this and that the PTP clock is not configured correctly.
>>>
>>> Ideally, we would rename the PTP ref clock for Tegra234 to fix this but
>>> this will break backward compatibility with existing device-tree blobs.
>>> Therefore, fix this by using the name 'ptp-ref' for devices that are
>>> compatible with 'nvidia,tegra234-mgbe'.
> 
>> AFAIU for Tegra234 device from the beginning, entry in dts is ptp-ref.
>> Since driver is looking for ptp_ref it is getting 0 hence the crash
>> and after the commit 030ce919e114 result is Invalid error instead of crash.
>> For me PTP is not working for Tegra234 from day 1 so why to bother about
>> backward compatibility and instead fix dts.
>> Please help me understand it has been years I worked on dts.
> 
> Please could you expand on that, because when i look at the code....
> 
> 
>    	/* Fall-back to main clock in case of no PTP ref is passed */
>   	plat->clk_ptp_ref = devm_clk_get(&pdev->dev, "ptp_ref");
>    	if (IS_ERR(plat->clk_ptp_ref)) {
>    		plat->clk_ptp_rate = clk_get_rate(plat->stmmac_clk);
>    		plat->clk_ptp_ref = NULL;
> 
> if the ptp_ref does not exist, it falls back to stmmac_clk. Why would
> that cause a crash?
 >  > While i agree if this never worked, we can ignore backwards
> compatibility and just fix the DT, but i would like a fuller
> explanation why the fallback is not sufficient to prevent a crash.

The problem is that in the 'ptp-ref' clock name is also defined in the 
'mgbe_clks' array in dwmac-tegra.c driver. All of these clocks are 
requested and enabled using the clk_bulk_xxx APIs and so I don't see how 
we can simply fix this now without breaking support for older device-trees.

Jon

-- 
nvpublic



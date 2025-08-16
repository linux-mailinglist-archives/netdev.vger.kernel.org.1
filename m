Return-Path: <netdev+bounces-214286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E068AB28C2B
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 11:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907303A91A2
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 09:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEBF23A9AD;
	Sat, 16 Aug 2025 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XlKX/sAB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E1A2222C3;
	Sat, 16 Aug 2025 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755335153; cv=fail; b=BprHWCO3PbkP/H+WZ8tdxSmDTCEPd2xgyJ6OBxvMfgBoh4CY05R1wVWTjzIxDEqwC2kDKplRRt5ydJc/1GEXQoWxlw2f99TjEX4WnY1BX7CgkIhTgH75MsfbPxnruI1T9zeJQEbdbvHREmwmY2AfB2wGncFk++R3cD0cxgj19tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755335153; c=relaxed/simple;
	bh=eEZ9ePdxq0r8mqoaDoV//umMueGGdQOrApspCPpGh94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m3joVIuw6wXEdLOVQ+zma3e20EClr53Mx9RAJdrbQmzEhItnmGQqs99fJX1X7ERfEDEgw3oQlwMziBhJbQmnTHP/9cqHG5Zy0d1iKmJy94jOuEtWs5e+3Sp+jSurI6xhO5Gw643KCjBX9fQrOezlRXk9zcbhSkdG40PIeA+l5Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XlKX/sAB; arc=fail smtp.client-ip=40.107.96.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bj8gfxqS2wcivFR3ABEn4NtVmIC87PfypJLZngeLNfwG0FPUnu3IABUFUVyEGg0sI7nHZXnGD5PoPcaxEK87TLnblGdr7Wl+Mir+OSnZi9YAjoHhLzQgFLb3ToPw46rdOtRwrw0OF6ytMfxoZWuO8SdohIzSxwCBGlIH83qcaGCRuHWJZ9Lj3J1NkllCdxVsrPqczKBQhI8EbeuSjG5Za8hSFlUBatY75WJLQ2xzjgt9Z/RQwBtQckpV/emiYPSvJ9tDuRy5Aqyu7TqNUeM6DnWu6iStmcuRfTGWZ7wm1/gTxl6TPTErQLJEVA+ZcgfSqDJs0Q9kiruXaJShtCJ8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gNVnKruWf3FokzT5SCTIOuJE+wUkom6xI0sUrQy4AM=;
 b=s+02gLExt1hLvuU21i1WOW9sB/ioIUde+/257htsYvdESKYUEHBJU0rkR7ONluxoPnpOJQO3GH0mJ+h8i6iGqZQZ45RJUe2LYXdTyjBpHxbcxZBUkrCidNizS+7Ly84eKO4NC3YTcQXWwJbsaYifcBM1vAZ2Rti+1a0EfNBxHug5q5Mjg0P+bwNEp7CWYYOUVMY2Roe5flOHJsP4CnjBj85YhBatjXRKRm5GgG+JUmmrb1xbYr/JCbkw3AML/4ZGrPfy/Hj4BLG6KLCdT1FgFR+d0rAOIKl8xpUB5Ug96zSpRtK+bywyd1fClGyIZ3sw3e7TzXu02+ryQe0DBYdDww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gNVnKruWf3FokzT5SCTIOuJE+wUkom6xI0sUrQy4AM=;
 b=XlKX/sABxnQ1Kh7b8NVN4fhkmOYdJI7Rk5AGoKB8uMeKL2UHm6jTQprWgE/7gSgGDcJvqWw4Mc/UErPPOV8OJ7W0hvr1a77a0AHlJ70Jo5ZibMzz14nkoS747eB7PELHXxobwkcPmubqBsT8RV46pVjJ03c5dLmrxoVDGijmE95CSb3ZlR5faxmMx6zo1NUCwD5ncaVLxFd76sWZ5Nq8XYdbd6nSN4l2jYw4yC7f+Jc1s6/BguSzKVlnmrP0BvnRIlg2oBJ3hzaexA8npxypT9E7XLfU2mqqUo9xSzBmKMCs2CKp73/uf8McbZRScWtG0NEMl3pi2ZaKjheZnJhcYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by SA3PR12MB9178.namprd12.prod.outlook.com (2603:10b6:806:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Sat, 16 Aug
 2025 09:05:48 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9031.014; Sat, 16 Aug 2025
 09:05:48 +0000
Date: Sat, 16 Aug 2025 09:05:40 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: almasrymina@google.com, asml.silence@gmail.com, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, cratiu@nvidia.com, 
	tariqt@nvidia.com, parav@nvidia.com, Christoph Hellwig <hch@infradead.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v3 7/7] net: devmem: allow binding on rx queues
 with same MA devices
Message-ID: <n6sgvidgswqc456fo7tizxsqeq5vjwiqnef3mfr5fgifcnkdcp@3ntalkm56cr7>
References: <20250815110401.2254214-2-dtatulea@nvidia.com>
 <20250815110401.2254214-9-dtatulea@nvidia.com>
 <20250815102433.740eb2a6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250815102433.740eb2a6@kernel.org>
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|SA3PR12MB9178:EE_
X-MS-Office365-Filtering-Correlation-Id: ecf6dea2-ec10-4ee1-354a-08dddca4178d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2h3VEVqTEFZNEFSMXJTaTRuZzVRVExaeXJNMjZRY1g3ZFZDY2xDcVRWMHhO?=
 =?utf-8?B?MDR4UjU0ZHlKM2ZNSkUwSVFxN09Ia1FGTzltNTdCWlhob2tvTGNVUko0VUtq?=
 =?utf-8?B?c3VvQ0NTWXArZnhXdE1TR2J2TmFPU1Q5MXN5T25xcnVHR0wvQjZ3L0tRNlh1?=
 =?utf-8?B?c0Z3RW5velZXalFlT2tiVUFlU0tCZzU1Z1QzeXBQNjlXTDRZbXZWUXJWajA0?=
 =?utf-8?B?YUlabkV6MldMaGRnampPNFdZdHRUanFQekovWTVCQ0E4VWZoS1F1Q21tQTNN?=
 =?utf-8?B?WnhRQm9rZnprZTNLbnpZYUVOeENOUlEzRkt5eDFKdUt4bTlJTEI2UlczOXlw?=
 =?utf-8?B?Mk5qSjMraVJvUXlOcE5sUXJpOWdYRXErMklmQkhHaXl2d3hLL2Z1cTduOUYz?=
 =?utf-8?B?TTVjOGNoSUJFeUFxWm5EZkxISGJGc3FEbkhzemdLbjl0RTlTTFVwdFhrd1R3?=
 =?utf-8?B?bEZmWjdDVExpUVZBODFjc3ZHNXhadnhtbDlaTWxIYkVXamoxZUdnanR3Sk1q?=
 =?utf-8?B?bDY5Q0FvOWdwbmpIV0JvdlBWcDBPN3BmOEgvSE1rUzhydUxWN1haTHYwSzF6?=
 =?utf-8?B?V2RCNkZQU2tPMC9zc2hxQWp2enVkREFYSlVWTXFYVDZpZHZSZDBGYkRUVmZ0?=
 =?utf-8?B?WE1KemZPZDcwKzVXR1E1b3VHeERjc051UWV3ZFVDcWJ1MVl3UW5rN1dQV2ov?=
 =?utf-8?B?NGtPazNsQTVSNmoxRHZqMVZyb2VNbWc5T2ZwK2RPQzRFR2V6UWZ5ODVxMTY1?=
 =?utf-8?B?dUNaQ0NNVzFmVUVVTk1sQkZmVU5xT3lreDBsc0p3alFEMVFhaHp3bkhXeDVT?=
 =?utf-8?B?UHZ3Ry9Xd1Vqd0tscTkzMzlVZGhVVURRUS9LWjJuMUR3dDVBL0V1V0g4RTlj?=
 =?utf-8?B?QU5tNFdqaVphaWs4cXhZcmNUMDV0b0Zya2U5T3kvRlc1TkU2cnRUWFY1TXNE?=
 =?utf-8?B?L1duQUp1Y2FidTF1bTFhWjlUVVNDQnJpZ1laNVJtV05odk9rSXcyUlZtemYr?=
 =?utf-8?B?ZnlpZjE1RS9FR2NYdlI1N0xFamFGVFJQdmxyR1FMSXJFMEI4REhUaU00Ym8y?=
 =?utf-8?B?UFhoUWUvK3p5SWhsVWxmT2VycnBkaTYvcUxpL3hwSTlXWFNzZ0dqaWtsOW1N?=
 =?utf-8?B?WmJ1TnFrRHVBYTBxUDErU2h3bEo0VkUxTmNmc0c5cVNzV3pUaW1oN2VtdGhl?=
 =?utf-8?B?QU9KMkZxUmNMN3RyVHIwK2RwQTdING04MmltMXRKNEFQdnFEbkZmSVZSeG8w?=
 =?utf-8?B?bWJNdXE5Y3lFQzZPdnBqdkwxWWU1bTZCTldOZHBDcDBaMEVENmFtYnFPSTR5?=
 =?utf-8?B?RHVtaUw3QWpLd3ZlS3V2ZGRaY2tyV2w3dCtHRDE4dDNPd0YyOEM4MTRqblVp?=
 =?utf-8?B?L1JlSzR1K1Q0SjJqaERWVTUxTFFFc3daMU1jK3JOUjZvRjFiZDNhZEpRV0J3?=
 =?utf-8?B?Vmwzb1c3Zy9YYnBseEFRbXNzZFZFSCtOSDJwSFFvR1VHbEhLc3NicjM2VVRk?=
 =?utf-8?B?NS9HakU5azlxVHg2bDBjRVpVT2VuWG1EdlRic1ZMaFl4Z2pTNFI4RU5SN3F5?=
 =?utf-8?B?dEFWUnFQNVowOFVaVWd2VEorMVg0Rk4zdVZFZXI2N0E3a1BScHY2Wmx3andB?=
 =?utf-8?B?VkUvcnFyVHR3OEVqUEtFcG16aWpUVHhyS3J6YUxZa01uYll1QTRHZE5rWjVn?=
 =?utf-8?B?VmFkNHdwZVVNNXhFYXkrTmc4b3ZEcWs1azdtblZoUzZQUElJMTRQMlhrejh0?=
 =?utf-8?B?ZkxuZno1d2xXVHh2U2hTRUw5MG5XOE9BakJ6QUFlSURmWXR6dTg1MFBHMGdI?=
 =?utf-8?B?TE1rcUdGRDdtTFgrSSs2UktHcXp4amxLNU1VakxBbnJJS1Zmak9GdXNUYmIz?=
 =?utf-8?B?K2lEU2d1NmZCNDh4dHU0UFBsNjBVL3JhT3hhUno5L1FLRlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3JVUTFvT0NJWkxJSUVmNGlSVUFUY2x1dHdWVExQRnlNNWFDZ2lvRnc3Qmky?=
 =?utf-8?B?eEpqOFBYdk5Wbmlqald2MXRnU0k0N0t5cUw5dVpZZmdEOHFSZm10b2xaaDc0?=
 =?utf-8?B?Ty9YdVhyeURCRlI0K0UzdER2THJ6VHdGTWRsMTd0WnhXZHIxUzdaVGdyNXNj?=
 =?utf-8?B?dVFsa1ZlTUljZ2g5RHRPeW9lKzJCSm5NK2g2MkMzUTdRQTFRQ3VIYVF3RVRy?=
 =?utf-8?B?US9oUnlxRGFGMWk4ZkFxV2dJbEl2SnZTQXlUeWFFYnMzVk51TXlGK1BSZmtk?=
 =?utf-8?B?ZVBOTTZpYWxGUEJNeTIvbUNFVFM2QkpxT2pxYUwyelVNRHR0Y0NpSG5OaVE1?=
 =?utf-8?B?M1g2SWduRU9NVmRUaTZCRHh3ZEZGQlJkQUpndXE4QmpubitEQjVMVHM2dnQ4?=
 =?utf-8?B?MmkycVNDV2kwNFBLRG1mcVRKMDlJQjMxOTU2U2s3akdGR3pSKzlaRThoelRP?=
 =?utf-8?B?OFJndjluYnhHVjVURkdoR0dLcVd1U2dJVThWT0Z4dVJyNFlPOUJJS0xGUEZQ?=
 =?utf-8?B?WVNPVTlKVm1rWDRuaTloOGlDRUtQM0ZOdURtbjYycjFZQnpsVCtGdmdabm5m?=
 =?utf-8?B?Zk9seWpIY2hicG1FaVQ0RU4rclJ0blJkVjdhTGZyazNFc3NKdHFCWWR1Mk0y?=
 =?utf-8?B?VkRhM3dlbGhHajk5TGhnbXByYjkrMWRSUldmRyt5bWxwTUtSVkM0V3ljRDF4?=
 =?utf-8?B?K1gxNy9nZkFSTEpvM28xV0NFKzlUOVFpa240cEtydTQxaVM5d3JPdjY5KzA3?=
 =?utf-8?B?N0ZOQnUvcGVmanpKZFFyMEwyUU93d1haMTZsWFVSVnRranBBQWQ5MnNreit2?=
 =?utf-8?B?U3FWaGs0RDRLdUE4ZytkazhMc0JEcUduRmNaSWlUNWpUcVdYdHFhYXFSU1o1?=
 =?utf-8?B?Q0xqVjFSVHVhSGdrN3N6Mi9nUTZWbGhGMW9NVmNKVXVDclpPUVpGREc3d1dS?=
 =?utf-8?B?eCtaeWxhUHJUc2xZdFJGalpqOWxuZmRVTG4vN0hEV0JQUkZJTmxrd1hpQ3hO?=
 =?utf-8?B?T2s2dEcwZ3lmTlZCd1Z6cnBBblU4RWhRbzRwckxyaVZROWc2YXRGZ0U3TXhu?=
 =?utf-8?B?NE5JQ3JJWm41SEVId0k1NFI2NDN0Z0xkZ3hTcVNDWDUraVh6SWdxUThtRm1R?=
 =?utf-8?B?WlR4VVdZdlZSZ3pudG5hMHlvOStHT0E4Z2tXdVZkZS9vRG9Jd2QyTzZwajFr?=
 =?utf-8?B?a1IyWDFvOEFVbmo5d3MzWENRTEw2K0dud21IR1FsRmtzY1AzT0ZrTnovODN6?=
 =?utf-8?B?MHhDSFZPcDF4OFZ1eC90ZFdSaUNuM25jMCs0cU4zdHJ2T0h0UVBDM0J4c2U2?=
 =?utf-8?B?VTZ1TVhnM0JGSyt5ZjFsaHFWN0hNM2ExUkpKM3dmOUxVZWJKdmZuZUtvQks1?=
 =?utf-8?B?RGtDTW1pSHljRjNtTEZ5YUt3cEI1UjFzRldENFV6N1FUdVhlMzVuUk10bWNn?=
 =?utf-8?B?NDlxVTJwNWlLYmJDcXpGTytKZGtVQjJjMThpZzBvUC9sTmhRM3hGYWhoNjBB?=
 =?utf-8?B?aENvUWpJVDdsRS8yVWJJNlRpaDl0TmJNd0NkMm84UXorYXRFckVZS3hmNFNx?=
 =?utf-8?B?R3dEdWt3b0hUVmQ5M3pKTG5NVUdvaW1OSXlBajJZM1lsWXNEMHh4TjJZN1RL?=
 =?utf-8?B?bFRmSTV6R1VCTys1WURLOFdHUnF0MUlqYlFFK1cxVTcvRGFrWkpFTit0WVgr?=
 =?utf-8?B?NGxBWHBwbWdhRVJWcG9FcUJtVk9Sb0FjRXB3UmI4b1BnZmdFUzZNek9EV0tI?=
 =?utf-8?B?cFVMaGQ4SllPWk9zdi96WjhJcXl3bTB6SWlzOXVsOGY3Rk8yWFBTeEFreHFv?=
 =?utf-8?B?Mk5YamRPTlB4TXZweGJXRDFaSDhlM2FRUVpUMHB0dEgwdVpoMmZLTUNnejk3?=
 =?utf-8?B?TUVaSnhhK1BJWXhNOWRKTEROemdYUUNWY0RmN05nMlJMTVRnYTRCNnpiTFh3?=
 =?utf-8?B?NVhxa1dmcmx6UXlXOEl6U3JWeFlqclpoNWxGakRlNFd6WjU1T0RvSURvdUU3?=
 =?utf-8?B?YzFCc3FwdHZlaWFxV2taQzdiVnZDTVJXbTlENzJvMTdVL2pQWjhva2YyQnRX?=
 =?utf-8?B?N2VPRFhaRjBFclBMcWROc2VwNEhIQmFhMDN0dkkxc0lDcHJGUnhzRUtVVDJa?=
 =?utf-8?Q?km7C/XGgkwyIYfezgilnqlEPL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf6dea2-ec10-4ee1-354a-08dddca4178d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2025 09:05:48.5707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4hxCBvtCU3t/CPS9+IVT1UHQEp61sTCBlptx6YKLHq1QPQHdkIE452Z3LvYqk5MJ6KoufehnxYo7BqrLxYQJsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9178

On Fri, Aug 15, 2025 at 10:24:33AM -0700, Jakub Kicinski wrote:
> On Fri, 15 Aug 2025 14:03:48 +0300 Dragos Tatulea wrote:
> > +		rxq_dma_dev = netdev_queue_get_dma_dev(netdev, rxq_idx);
> > +		/* Multi-PF netdev queues can belong to different DMA devoces.
Just saw the "devoces" typo. Will fix this too.

> > +		 * Block this case.
> > +		 */
> > +		if (rxq_dma_dev && dma_dev && rxq_dma_dev != dma_dev) {
> 
> Why rxq_dma_dev ? 🤔️
> Don't we want to error out if the first queue gave us a DMA dev but the
> second gave us a NULL ?
>
Hmm, yes... I didn't take this case into account. Will fix.

> > +			NL_SET_ERR_MSG(extack, "Can't bind to queues from different dma devices");
> 
> _FMT the conflicting queue IDs into this?
Sure. Will print the last dma_dev index and the current rxq_dma_dev index.

Thanks,
Dragos


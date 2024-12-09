Return-Path: <netdev+bounces-150101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E4B9E8E7A
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 10:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A847E28187E
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 09:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C83114A4DD;
	Mon,  9 Dec 2024 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0QBsiozM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E3B1EB3D;
	Mon,  9 Dec 2024 09:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733735660; cv=fail; b=dUk3Jgl/qSdmzgK01e1eAi3CJ87J0ggEA1MghhWEyKNutzg8mDzNomsIy/W1U2+NueolV167+Q8Lom31pL0nUH8NmymDg7QAqCxAoTX/GIRu+xJEh4M0w28oEUvf7mNZA0Yvo9bqXC8FtevAdgN4lAzp0fR6BaE3bRU0fUO7l/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733735660; c=relaxed/simple;
	bh=940mGEKx65adZQRrhIikfZH5l1mxNY92jp4ejxFoG3k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZZxn7gOXoU9T/DU1mqtHYhKjuMquIjPAGcMI7XIwcLrxxFjdZCiMhF+43y6wW59UhUeSnQupgsVzHQUKxu8tGXJ8MFvW2/bjSp7+OYqSRpsAupw6ewZT/jUekSa1eNIg3pJhjZ0vmYZ8GSfaGoZa712oi75HklDFbbf3o7zBM1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0QBsiozM; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIAMT+yIu5qeeIdV1A8rEFzNf/UHCJpyv+3NbGV2G8t0cJ1xQ8ZMzWqTvW7DqieypKQwGFQwQdUshSMRQouYPuMuVqvTdqMaN/FPvHBQXZqKyZrsGJLoSyk+Nkf5DuzRVCrQ2aUkMsIaFMDNpMAztpp+wdVivJnvxnlN2MDpE3DdJ09wctoPm78fCBqkC8ZtMn+MLgsPDmhHXpwMM74knRa5T/io+y/gumMVPvq4wNqaInVXRxI7/oeAFNClrPSTbR7CvxrrIyu0LW7eU3CpOC0Y4UZWzKtZ0dLReuU6HtLlKnN/Zt2ce+jf/mQR/DNJ2kVjTnrpUj3RjGXo2aXAFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5BGTooDuAMBVqZK6zDISoV6HYwQPT070igu2sj2bAU=;
 b=Mu8Am7B3EPJZtqoGGSR9OMCjYLCdqbdSraWec5qKkHbR0uJvnVKvkRVIm8Iw2J3VxcLO/hXU/vu3qsD+e0WoW6KXRNUvzXu6eLZ6EbQsfFF3KcaBw2DnMV38c8m+pWWT2Z6pt8ARBdjXEHzbKoYphTmwkFTkKJdEnnRZ1+ggQstee94GadPFDu+roN7Pn6xwFLVBjsJoa+wrkQXOnJtOOtMYjZ+gfUNgQLjWaiNYnot+N4dPztCLjB5Woj3wlERuDdfJCusvsGzNFAOMsCz5HbDEuNDoOyYmySSos6sQvdNuShMxE7blGre3z35VNjD+IandbOhUNLDYn6Ry8o3Shg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5BGTooDuAMBVqZK6zDISoV6HYwQPT070igu2sj2bAU=;
 b=0QBsiozMO8bpveFF9Kxs1iGz9wLLfOFmCt8RnkXBBwV6Qss8cgSacWJ0MYHE3NWYFMlgeVZcaant616jGc46WZUvTIK4y2LHzT6u4+SfmI6gXQoiwMK1EmAB8MjMX4seEF8IhdMyAi0ZtJuo/QYZeWGiDUVmB8/TBXtDKHQFK3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB6908.namprd12.prod.outlook.com (2603:10b6:510:1ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 09:14:13 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 09:14:13 +0000
Message-ID: <6b3147ab-99ae-b5a3-df5e-0db611229356@amd.com>
Date: Mon, 9 Dec 2024 09:14:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 13/28] cxl: prepare memdev creation for type2
Content-Language: en-US
To: Fan Ni <nifan.cxl@gmail.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-14-alejandro.lucero-palau@amd.com>
 <Z1Ms2YRAMFxmd11Y@fan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <Z1Ms2YRAMFxmd11Y@fan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0024.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: b3bb0e57-65c1-4ca8-5df6-08dd1831d91a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2FIWnVtUWFPQUNRakdSa0M4RGtKMzRRNjdmRFltdW5xbWw2SEMxN1MyTW4z?=
 =?utf-8?B?Z1Y3d0RDSmRWUVhTdEtUVmZUVStqMTNNS3NJODRQbUhtRWIxaVVMSE4wM2lW?=
 =?utf-8?B?RFBZTlA5QTB5WGRMOTM3M05DazA2NGhvSW0vNTJpV2FvMm9SNVF6T05KUllR?=
 =?utf-8?B?cWFUdlIvYkNsbVVpWHJDeTdPK24rc0NVRWtTRW9OVG1tb0NmODVFZVEya291?=
 =?utf-8?B?QkJQQWJpbkw0THZLUHQwUUduTUpBbDBFUUZqcjZwQWFDWUVKZ0tBdjMvY09m?=
 =?utf-8?B?T2V4VzJiMnpRYml2ZkEreXN4b1cyU2pwWllYUXE5eVlEV1lIbDRsRjZDM0NM?=
 =?utf-8?B?WkRwdnpJa2pIRS9yeEd0SGxabzJGazJyeVNWMGZCUEQzM0w3T3UxNm5TQTZq?=
 =?utf-8?B?QWM2VUxFUUNzU3dqa0d2RlRzOVBJTm5PWG5Wdk9BSldPUWlFUXZxVnl4VzJq?=
 =?utf-8?B?ZzdhTk9ScVFlb0xYUlJmd2thdEY5YzZMMkl0ZE1tRnF0YnBDcGREYlNNZ3ll?=
 =?utf-8?B?Tkk0SmN2NkdDOWp2Q3R1RnREc3VOMUc0cEp3cjljd1JqN0F2dXpEdURUTXdu?=
 =?utf-8?B?bzlmLzVZZlVaVTBxbUIzVklmZ3hQekFXSUswN3lEZkhrREhuMmlHTk9PeTEr?=
 =?utf-8?B?R3hGRUdWM052a3VTZUJ0TnNzNmdpRXJTOXZIT00wUGR4QStKSERDbTJrZkkx?=
 =?utf-8?B?bSs3Y2RwNDZjUVZBK3RZZnBBSG9NU0gyYWlnb0lWVk5HaitBY1VrZkZrekJB?=
 =?utf-8?B?UkZIUndoZ01Ea2c0bk9HNHJaNG41ZzRyMlR2UEtRTHphKzcycDR3MCtHOGdL?=
 =?utf-8?B?UEFsN3gwY254a0JsbWI5MXpWVUxoMlVpdUFTcTNQdmNZQWxLT0RwQkJqK0Ft?=
 =?utf-8?B?UWY0U0xYWHl3ZWx5K0JEMWNRZytLRnNSQmQ0OStCT1Fjc2pQNzNTbjBEY1Ey?=
 =?utf-8?B?cHZ5MDduQXRIUDZya0pyRFB0OGRiY2tiTHZKU3hLY0hEVW1nSEhPdUFtTWVL?=
 =?utf-8?B?dXdkWVBEWXhqQkFhbC8zb0t2dDl5Rld2TUN6RWY4YzBzYkFQZUcrNlM5d2Ev?=
 =?utf-8?B?Q3ZvMFF4ZHdqNlR2Z2JvTWdFYWF3bXplWmk4Yk5EUDFobzJRanIvL3JvUFIz?=
 =?utf-8?B?eWl2RXdQWTZQT1hTQXlGQUdCdTNlTE0rODUzSkt3M1dQaVJMaE8yc29BQjlN?=
 =?utf-8?B?eDk0SnVaREZrQVF3K3lTWTNMc1RSMkNzUmZPZGM1aWdoWXhhUm90MDV1LzZm?=
 =?utf-8?B?WFhCc2NBVmxldHNEL3JVcHVWK2R0RlRTZkUxenVqUmhiZjZjaCt4bC96Zm5L?=
 =?utf-8?B?NGZPa2R6Z2poSU9ySkxjTlZDeW84Wk9HRDJUQkNZOWRieUhoNUFjd0Y3QkNr?=
 =?utf-8?B?MTFXU3ZTVFZFeldxaXNVUjlpVWZCcVJSbHBZQk1yTFlBTC90cis2NU15V2g2?=
 =?utf-8?B?dmZBYjBDZVJITkJOZlluVjJFUU16Qi8rL2tGd21aY3YvUnVFNmlUTURmTDdr?=
 =?utf-8?B?TnNrclh1aDlOTEYrbEtjS2Zic2FRKzBSMFZsTjE4TkEyTEVQb2VaZFh1V1hP?=
 =?utf-8?B?UFhUQmhlMkllVFk2SkhkYlZ0d2pqU01NRHM0SkRpbGJpY0VtemVldE5nRjBz?=
 =?utf-8?B?dWFjb2FxWllxaE9iV2lYaUNZOHRxK1RBSmZlbHpLOFU5V1NaTFg4UHFvSmcz?=
 =?utf-8?B?eWJmWnRteWJTQXdGK0FZYVhkb2lEQ1pBR3kzTG9KYUMzZ3QvU0RPYkt1TlFJ?=
 =?utf-8?B?ZTNHVnJWY2xzdHlpazJ3b0hTbUJObURJY01OL0NZeEFrTitPaUlpYWI4bW04?=
 =?utf-8?B?dExaZHM1UHhuOGl2N0RqUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFhJZEF1dnExbGlTOTU0UVZxM1ZYazY5aUJEcnRSOFVWUXJLUXF5cUUvcUFW?=
 =?utf-8?B?SklTaXRoNlcvWTZ1WmIvWUhMdGliK2RDeTFXSk9XSWFsVnhSRG9mRTVLczlo?=
 =?utf-8?B?NnBkdlZMMEhnRXRuNml4cEJUck9CR2tPaFJOMng3N2hKLzR3YzJkYXM2SE1j?=
 =?utf-8?B?UlMwc1c1WXhkTmNIZDF0NjF3MnB5UGRRQUhyd29vNXpxU3BVMlllaDJnKzBk?=
 =?utf-8?B?bStMaW9FSVVkbldHQkRKT3hHTFpld1N0Zkp1dEk5eEVNYjYyTm9hMm93RGZu?=
 =?utf-8?B?VWpFR2tPZ1dDQnFjRU8xbEF6b3Z3N2prR2Z0RUorVlBwY2dwR1NoN2UybjdB?=
 =?utf-8?B?ck92Z1RBVVVNOThpRTZ2RVBXNEhLR29IWWNpanZtbzMxWVJHMUc0a0NQek9k?=
 =?utf-8?B?aTVDbmdSbHNLNFZ3NEEzMEJSSUMzZ2lFbzd2ajNqVU1qSlFHaXcySGw1MWxa?=
 =?utf-8?B?YWMzNkdNRU9iKzdXS3gzU1VzSHora3RSc3NpYUpCZjQrZWVUOG9iYlZIK09N?=
 =?utf-8?B?dkxvYm56T1M2aXI1c1Iyd3UxNi96MEd4ak5wSWJsTUs2dFM5Sll6WmJFVzh4?=
 =?utf-8?B?Y1ZoM1pmU3BJaHZ5SUhFZ05jRUJhUDMrcTlJNm5YaHJQZHVKaCtPZVF0ZlFX?=
 =?utf-8?B?MG4xcFhHL1RTMXgrZ3dndDFwR2ZQUnVEaVpkckx3YXJDSmRXOFFlQjhCNVZh?=
 =?utf-8?B?ZHMyd0cxN1JhTXdZclVNQ004MUtobFYxQ0NNQVQzL3ZueG1kM2VUUzhSeCtB?=
 =?utf-8?B?eHV3MzhQM25MMGhibVRTaVZ6bEl1QWZnc0M3eVZ3aG5wQ2hnN3hmRDVhODQ4?=
 =?utf-8?B?eGNha1ZyaWRRWXNxUHE0NGIvZDNtTEcvSW1HVXdKdUdzYXNacitCRkZqNDFW?=
 =?utf-8?B?blhzL0pGVjViNmY0UTA4VXlEOC9Qd2ZUZ3RsVFE3bU9ETSt2MUdBcnJNdFlC?=
 =?utf-8?B?SzVMalBtUE93MnVmMFFGblVuSFNsUjN2Q2JJTzJPZmZJaTlwMHQxWWlaRmVz?=
 =?utf-8?B?SlZmRHJCUDREWHR0dVAxUjFCNzBIYlZGbE50TEp3U2ZxVFo0TnJNdzB2Rysx?=
 =?utf-8?B?MDhIS0pzRzFXN3QrdndldkorL1ZYaHVKVmFRdTUvcys5a2UrRnJJaEM4UW9P?=
 =?utf-8?B?VXlYRFNuVm1yTmhtWklkcEFrRXd0UktLZ3Exa1JpaDVid3czZXZYQXBGTndi?=
 =?utf-8?B?WHB0OVdxK0xzOWdOdVd1RVlDVDhSVFRheUlSR1FYQ1BBV0NCU3NmZTVUUWt2?=
 =?utf-8?B?QVp0a3hxbmQ2ZXNCM1NkRXRYai9xVzBUMlBZYjBkQmtKMEgxaStuL1ZEcm1P?=
 =?utf-8?B?UnZiMVJnbklyL1o0UXkyY2Y5ckRmTTRUNnlzcEJlTVBmVzNtUi9EelZ6dDZn?=
 =?utf-8?B?R1ZYUmNhVk4vWlhwZHB4TEZkemNSQXJUUHZMN0tJVW03djlaU1ZiSi9qYnF4?=
 =?utf-8?B?dUYvbkgrOXJCOG9UblZKRUNuOEFjMTBYVUcxbXN4WnlLWkZ1NHBzU3VTdFRK?=
 =?utf-8?B?Sk5yVGFUeHAyMHpDRG81TGZEU1hEcEVSSGo1R21tTWNsOE5SNmhRQXdjN0U0?=
 =?utf-8?B?YVpCdkpEVGNjOEVKRXgyUnQvN0FjS2U3N3p2c1NuZWpqRDJ1NlNFTDFtelNS?=
 =?utf-8?B?STZDbHBEOUpzaEtOUE4xaUE0b3VVakJlZXBKTnRUeU8wckFTWjN2WXFqUDdG?=
 =?utf-8?B?MytORXhSVlhOZjBJc2tmd05tMzhtK3NINy9rK1RlcXlrSXNsSnVCenVDYUl6?=
 =?utf-8?B?dHhGN1YyL0h3ZENTZzVRdnROMzRSTnlVRWI5YURkcm1iMU9RU0Q4ZUNVNzZR?=
 =?utf-8?B?Z1AwRDZQN000aTExZG84UjZWMGo5YU80ZHBWZVZYekdXY3B1MGNuZWFLa0Zy?=
 =?utf-8?B?MlE5cGlNZEZVYjJEU08wankwYU1Ma21pejlTSzZNYXFRZ1VBNHRqT2lnckxp?=
 =?utf-8?B?OTYwam5jN3JVcVMzbVRjL3lucEo1ZXdYZWlvVGo4dUFnNUxwbUZuYU8xWjN2?=
 =?utf-8?B?ZnpBb0p1OS9USGFwYmd1QklQaWhJRmNlZUY3OWptMnNIOVRsdlc4T09Xb25S?=
 =?utf-8?B?eW1nenJkeHkvQy9pNFVsQWV3d1lST1c4SWhJOGxSa091cGhkQThMMUZwL0VH?=
 =?utf-8?Q?B1KpF0P9ViIJmY5bxgAOO9ZUo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3bb0e57-65c1-4ca8-5df6-08dd1831d91a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 09:14:13.5122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/EhSVG33Wt56RKvuCWFecLM2xwP1zQbN/aJYk/TdOfrvpCeOaE3LYTbB8VwPGKVlO3zhfNllu7xhEVka4tGVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6908


On 12/6/24 16:56, Fan Ni wrote:
> On Mon, Dec 02, 2024 at 05:12:07PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
>> creating a memdev leading to problems when obtaining cxl_memdev_state
>> references from a CXL_DEVTYPE_DEVMEM type. This last device type is
>> managed by a specific vendor driver and does not need same sysfs files
>> since not userspace intervention is expected.
>>
>> Create a new cxl_mem device type with no attributes for Type2.
>>
>> Avoid debugfs files relying on existence of clx_memdev_state.
>>
>> Make devm_cxl_add_memdev accesible from a accel driver.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/cdat.c   |  3 +++
>>   drivers/cxl/core/memdev.c | 15 +++++++++++++--
>>   drivers/cxl/core/region.c |  3 ++-
>>   drivers/cxl/mem.c         | 25 +++++++++++++++++++------
>>   include/cxl/cxl.h         |  2 ++
>>   5 files changed, 39 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index 2a1f164db98e..f1c5b77cb6a0 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -577,6 +577,9 @@ static struct cxl_dpa_perf *cxled_get_dpa_perf(struct cxl_endpoint_decoder *cxle
>>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>>   	struct cxl_dpa_perf *perf;
>>   
>> +	if (!mds)
>> +		return ERR_PTR(-EINVAL);
>> +
>>   	switch (mode) {
>>   	case CXL_DECODER_RAM:
>>   		perf = &mds->ram_perf;
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index b14193eae5fb..4bc946388384 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -547,9 +547,17 @@ static const struct device_type cxl_memdev_type = {
>>   	.groups = cxl_memdev_attribute_groups,
>>   };
>>   
>> +static const struct device_type cxl_accel_memdev_type = {
>> +	.name = "cxl_accel_memdev",
>> +	.release = cxl_memdev_release,
>> +	.devnode = cxl_memdev_devnode,
>> +};
>> +
>>   bool is_cxl_memdev(const struct device *dev)
>>   {
>> -	return dev->type == &cxl_memdev_type;
>> +	return (dev->type == &cxl_memdev_type ||
>> +		dev->type == &cxl_accel_memdev_type);
>> +
> Unwanted blank line.
>
> Fan


I'll fix it.

Thanks!


>>   }
>>   EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, CXL);
>>   
>> @@ -660,7 +668,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>>   	dev->parent = cxlds->dev;
>>   	dev->bus = &cxl_bus_type;
>>   	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
>> -	dev->type = &cxl_memdev_type;
>> +	if (cxlds->type == CXL_DEVTYPE_DEVMEM)
>> +		dev->type = &cxl_accel_memdev_type;
>> +	else
>> +		dev->type = &cxl_memdev_type;
>>   	device_set_pm_not_required(dev);
>>   	INIT_WORK(&cxlmd->detach_work, detach_memdev);
>>   
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 70d0a017e99c..2a34393e216d 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -1948,7 +1948,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>>   		return -EINVAL;
>>   	}
>>   
>> -	cxl_region_perf_data_calculate(cxlr, cxled);
>> +	if (cxlr->type == CXL_DECODER_HOSTONLYMEM)
>> +		cxl_region_perf_data_calculate(cxlr, cxled);
>>   
>>   	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>>   		int i;
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index a9fd5cd5a0d2..cb771bf196cd 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -130,12 +130,18 @@ static int cxl_mem_probe(struct device *dev)
>>   	dentry = cxl_debugfs_create_dir(dev_name(dev));
>>   	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
>>   
>> -	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
>> -		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
>> -				    &cxl_poison_inject_fops);
>> -	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
>> -		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
>> -				    &cxl_poison_clear_fops);
>> +	/*
>> +	 * Avoid poison debugfs files for Type2 devices as they rely on
>> +	 * cxl_memdev_state.
>> +	 */
>> +	if (mds) {
>> +		if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
>> +			debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
>> +					    &cxl_poison_inject_fops);
>> +		if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
>> +			debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
>> +					    &cxl_poison_clear_fops);
>> +	}
>>   
>>   	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>>   	if (rc)
>> @@ -219,6 +225,13 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
>>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>>   
>> +	/*
>> +	 * Avoid poison sysfs files for Type2 devices as they rely on
>> +	 * cxl_memdev_state.
>> +	 */
>> +	if (!mds)
>> +		return 0;
>> +
>>   	if (a == &dev_attr_trigger_poison_list.attr)
>>   		if (!test_bit(CXL_POISON_ENABLED_LIST,
>>   			      mds->poison.enabled_cmds))
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 473128fdfb22..26d7735b5f31 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -45,4 +45,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>>   int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>>   int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>>   void cxl_set_media_ready(struct cxl_dev_state *cxlds);
>> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>> +				       struct cxl_dev_state *cxlds);
>>   #endif
>> -- 
>> 2.17.1
>>


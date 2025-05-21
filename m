Return-Path: <netdev+bounces-192222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B10BABEFCA
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDADF3AA25E
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 09:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437921494C2;
	Wed, 21 May 2025 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q7ZM5JDX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B685246786;
	Wed, 21 May 2025 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747819834; cv=fail; b=fesqmZrsOjMBfaK2vTp7ev5XTV/ZMF7GEXRUj8+d7HJ7c7MdeJMu9UBBK0pf7ikB9vQYKhRiT54IOlXCUxkmayLrrCyw+1K/EgYkP0i8AKNaQRm6q2059TL6HcTKu3y9JY+wxGRQGo7Q0ulV+9BfK0cAmmDPf+mKvWm/L4D/KFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747819834; c=relaxed/simple;
	bh=D0nu8sm83MqwkhjRDvZgWaWaZ8kCincmMJ7oSfyligI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jNtLLl9v53czLdgff+6Nhf3PK3ofn9fQQ++2QQFHHlyUtl/d2ohschFgd1WR+LOEGyfWXadusr3PvagnI/6KRT3YmU8+Z38qyRWtNZAkT4V67cVrRosali2y8OpsInRTS3D+DuehHg/VEYkVKiXdtUywBdFX50UNlF6C4ji/WYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q7ZM5JDX; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IaKZ2WJKPpSANkE0JD0eYwxUQIG3zUlq5rhnXDqFYfVgdtw6mBP4vRR2+Y6oFug5ec+8//01mtXrgq6EUZor1VaoFX/7AiS2yKVRgcOR+Rci5dHNq0+w9cRf71faN8zOQqZUw59yeDH5oShiLZ7zCwEgGaR60flUcOXBUUbDIlZQMoW/MDorczHT2IntMGlH1Zn4vST9fEuF4p6uWb7ZujxaUxfZKWJf4TC56/FqRHqHmOdWJxsX5GGgG0BGcD9QJQ9deISeAAFZlHS5JjVZolew5B+IvwolvIWps+V0Wh4q1r/H4Jhb15toyFpLDAF3WmXwRrxqz2COCu5afphMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYdPziptoJGVGYthL/ymXl7ZRWIIPCPjjdZEhfoZS90=;
 b=T4HigttcZp9T2ZZsEWGQyvLd2/3081+gLjuarAAHHu6E6dxVpsQ+Vf58c1cZOeLnwM5toQVbrZaIw19QKNuNQ+GXF4yGwMgrARoGqIThaP+FKhMHK/bbauBdJOEPGroRhPWpUSgba+DhhTqH8wS6QOXaPPwde7I7crJq+ZTL9s7g5/Xm1dpJZVgzLknZ/eiQEKTBKU02HV5cCA69uAJPcUftt6Hm4FM0Rgo60jg7Ua8kmB3sCwjWVuTSPYV8v+YHucFscEQi3Jb8Jr355iENwH6taPCKmBQ1diwT8IO+BxHbYJkHmrC5mGDuJCOsPfioIyOQlx/r/PKyC+ZV/Y+BLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYdPziptoJGVGYthL/ymXl7ZRWIIPCPjjdZEhfoZS90=;
 b=Q7ZM5JDX0nLKkf6P2zosoVUApZhhKbuPc01nNLrZZxltq/YwZ1+4abNyyJJikY/Sw3MX83XgQfviP1QcWe74Snylc00aMj+8UbAeuaewfy5WmpXGmMYoabm5+VTxAjBE/VPI4eQeV2OquiFfuKVmqe6ciKwzONmfbMprwzf3oXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA1PR12MB5639.namprd12.prod.outlook.com (2603:10b6:806:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 21 May
 2025 09:30:30 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 09:30:30 +0000
Message-ID: <3d2eb2d2-f269-4921-99f1-c6deb973cf42@amd.com>
Date: Wed, 21 May 2025 10:30:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 01/22] cxl: Add type2 device basic support
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-2-alejandro.lucero-palau@amd.com>
 <aCvsTqArfcKJQDBD@aschofie-mobl2.lan>
 <27f3bdd8-d3da-4dca-bcc4-5bdf7b3ebb35@amd.com>
 <3dcce508-c94a-4614-acf6-123a3ca6eb6b@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <3dcce508-c94a-4614-acf6-123a3ca6eb6b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0248.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::21) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA1PR12MB5639:EE_
X-MS-Office365-Filtering-Correlation-Id: a7326073-210d-413d-cbc0-08dd984a2083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2NRSzZGamllTnBXZEdUTWR6U0RUWG1PNnRpWXhZRFR6K0c5eGw5emxVN2dL?=
 =?utf-8?B?aXNUOTFYYzAzeE0rTkYrRU1KQ2MySElLWFFBUWtoanB5MzdsQVFudFQzZEJG?=
 =?utf-8?B?clFjVnlhSm5oQ3hCU3lvRXB5QXAzVS9pbUc5ZU1TdmQrK3dnaGsrd3NHYitV?=
 =?utf-8?B?RCtNY01TM1RhODB5WU5VRmNqTmVQVDNBSEdQY3FHSldrWERUQWMybmV1cWVP?=
 =?utf-8?B?RjNkSlNMZkMrcEx0Tk9pRDNWejNOcHczK0NmZjRjNWVzSjdnRCt3blJsU0lU?=
 =?utf-8?B?eVpBcjJHdzNaejcxZW5uV0FSaFBxUUpxNEw3WHZaTFJGa3I5YWtBd2VKWmR6?=
 =?utf-8?B?YnBJUnQ5WTUzdWVYa1ZsS2VmQ0FzSWpvNCtBSHlSeEozZmM2MTlxcDE4SElU?=
 =?utf-8?B?Nk9VVGxGT0tSUXpIbVc2eFp4WE1qYWVsY0Q5QndxQ29LNUMreWNiekcwOTF6?=
 =?utf-8?B?OFNGZ0RJK1p3YnY2a2Z3aDg1WG1yUVRUSmQ3ZVZvcHRPVzExWStLeXB5cUhE?=
 =?utf-8?B?bHdMWUlVWlZsVVgweVgvT3ZQQUZ1OUt4OHh0YlZ2TU93a2thOUZlTnFCQXVj?=
 =?utf-8?B?K2ZhV3N4RHU2SCtiTHZqOThTTDdIOGE5bmRnUWRJWC9RdXlJbWNadkx0K2ov?=
 =?utf-8?B?dDBONDBQNXNOV0RHR284czJOb3BmYUtoOWtUbjRCWDNxYm9IMC8rallNVkR1?=
 =?utf-8?B?SmppbCtSRGpLc2hzeU5WOEJOSDhOMENsNWZYazgrTDBqY3U5cGdNZWdJYWhW?=
 =?utf-8?B?dTcrU1g3eHdqRGVIYjRkcnhUOUY1MDRodHNDd2VnOUZ2RUlqYTBhckVYT2RX?=
 =?utf-8?B?NXpwZmRHL3FaYlFWd0NlTTFXbnA2MnJsOFRFcHhRcjhvUTZlbklXYXliVmRS?=
 =?utf-8?B?RjRwZU5TcTVBdlY0NlJDRW1Cb0psYm1semphVDJ3MjFMQ2lJTStqRlRKbkV3?=
 =?utf-8?B?TWEzWThmSlo2WmovUS9NdzdrTEdlNCtNOGt2Nk1sZkhmWGFGalRybXlXM3Nv?=
 =?utf-8?B?RkxNNDdxdFErbTd2R0M0ZHF0SlZvY1A2eU8zMkFCaWYzYVNFZW1SZGdmUzU0?=
 =?utf-8?B?Zy9iN1RWUFVFQ2kvSHJTUm1QbU43MVc2dkd5cCtlWWhGNk5jaXc4UWtkWUVa?=
 =?utf-8?B?UVF5cnpOTEtxTkpmUGl1WDBtbkFzcDU2ZHpFeUNiQUQzb0hvbURRaTh5OVh1?=
 =?utf-8?B?cTRwV01yaEgrUk14emJoVVJnTmZJaWQ5WWdZYzdnV0s5UCtxZTc5YlZlWGdD?=
 =?utf-8?B?cEFhQjUybzI3a0gxaDlNLzlDOGUxbkN4S1l0ZytuNnBmV2NoMUxEK0wyOUxP?=
 =?utf-8?B?ZDJVQ3FHZjBkMHovRkhWaFBsaEtRMlhWcTdYTHEyUEJkYlgzbTU2VUVQdXpi?=
 =?utf-8?B?b3RuVVhJZks0SncwOGI2aGh2b1dqcVhUMTVYZGNzYVNDdFFPM0pHSVVrdHRX?=
 =?utf-8?B?Q05IOUJuUFN6QktrcGJZaGZ5bHdUTS9NcVFjQVhwSVJEWE1Bdi9pMkk5Mksw?=
 =?utf-8?B?N3paL1NpMmluVmJ2SmNrakRLWTNJMVhGS0plUUhxZE1wVlRBRFlIbWp1VnZy?=
 =?utf-8?B?NFZObTdMMjh6QXJUK0pXWWlyZm9NYURJZmJBb2hWOHNlVmtMRFIzcjVZU2RW?=
 =?utf-8?B?SXdJcDV6OTl5eWZLL1ZLbVlJQTJhT1FjUlZLR3hCUHJLY0xMRkVpd1FhbjlH?=
 =?utf-8?B?UzBwcE56YnpzM2Urc3duKzZsZERPUnRKN25NR0lQeis3WlJSWGJENmwxRXR5?=
 =?utf-8?B?MVg0NDBnS01aZVYvWGthbFF1UWpnbHN5aUZGeXdLckJ6MUZHbTFEdnVYRVBJ?=
 =?utf-8?B?NllyQmx2QW9HTloxeHZ0STk4MXFUS05Sa2VzV01OdXpvRzUvb2k0RWhKWkxy?=
 =?utf-8?B?Tkp6RzZMZm45eHE2WWNSRTlWeVoyRjRFU1lUWk9HZUlVUjFhYVhjRDRrS0c3?=
 =?utf-8?Q?F8GKwH5I5yI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eCs3NmtIUXBsSTNCNG02MVBQZUJVVzBKZzVscGFCbkZGQWZIc2k4dzU4SDNi?=
 =?utf-8?B?MHBxRWUrcnNuVkQ2blBYZGg0WUtacUFiZ1A5OVBWbUVlOHIwZnFMNU5VTE02?=
 =?utf-8?B?YXF6QmYvYmoyL3JNV01EZ0hlQW1MSFN2MDRBZzJoWG5YKytQZ0RZNDZqNnlG?=
 =?utf-8?B?WDJhdXlRMkJMQktvYWlsK1pLRDJhRXplWitvcndSY3FmWEZPWGhoK0p4WjNV?=
 =?utf-8?B?eXFETEpEMUlEVDdIT213MldleTBLb2lBTFU3eEQxOUFvbXZwbVhMWktydVN6?=
 =?utf-8?B?bGFPNWZIbEJIelJzNFUyV1ZSZWxYUzBCdWV3cEswVWs4a3c5aTlpbjc0Z0FB?=
 =?utf-8?B?NERqdDRQSk1EdWpQb3pIMjNxODdzdjNjSGVsS1h2eGhrMzQyTlgwQ2FqanlX?=
 =?utf-8?B?UUl4c1lFU2dsVmtEemVybWZ3YklDOHkxU1RYMm5ETmFrK25MOGQvU3hLb2Qx?=
 =?utf-8?B?amJ1MkU3dmY1Qmk2ellpOE9qb0tVU1cydXRJeUVXRktNZlcveVFaZFEvSWFx?=
 =?utf-8?B?SFN3YlhWdGQ1dHIrWEFaaWFhQmRRNUNoTTFFUUdjSTZueC90b2g2cVlBeHN0?=
 =?utf-8?B?UXNyN1RKM2hKeW9maFpnbUlPTjJVUi8rcmllUGRzNUpRdWY4aVRlR3prZUJ1?=
 =?utf-8?B?UVEzQXh6MjNJR1lmRGlBZTNWdTAxcDJrdU9qMnplZnJEd1RRa3J5ZXQvQ0FH?=
 =?utf-8?B?OXBZay9MaWFjdmVyWG5zSFM2MWU2TFVWOEdTTU9DY2J0c3lxaTlNMXFraDNU?=
 =?utf-8?B?bnRTcWxndXVXZXJhczZWbnFOZDRrY0N2VER5OEMwWlpRUEp2OVJoQ3ptV1ZE?=
 =?utf-8?B?cExGQVlYdTNXSFRvckI1OGdBaEpZS29tRXp1UUowSUlIaUdsOVh5MlpFY1Iz?=
 =?utf-8?B?WXFvcHl2d3ZOaEZUSWc0VGZ1bHdZRlE3aC9GR2xnd1QxNnV1TUdpVkVIQWFm?=
 =?utf-8?B?bGt5RmZYQTlnQSs4cHNmRnE0RDhHT3JZWnZvcytwV29DYWU3cHJaaUx3WERn?=
 =?utf-8?B?K0NkUU9naTVJM1RaR3BMSjZ2YlBUZ3dkL3FhS3V4K2JJczVjYnlSS1oweU9w?=
 =?utf-8?B?M29LNFdSWjMyMGppQUJodkRyV0ptV3RtZHNJSUxkLys2S05Sb09JV2dSMTFk?=
 =?utf-8?B?RE1BYkdNRm83Q1M5OHJYUVpRZUNvQ054eFpsaU1aWks1eDBITkNNSmFZSFVx?=
 =?utf-8?B?R2NZMnNVSDB0Qkh2UnR0STlOQ1pPbW9ZNlVuaGNvNVFnQURsQzU3TEU4U2hp?=
 =?utf-8?B?MmRMU1h0MWZNTlR5MTZIdU5uR3M0cmthRGFLeno0RzVjWEtoTnRXaUZQNitR?=
 =?utf-8?B?ZTdzZXdFUjRMUDkzamZITUpuWnVVWUhqUWxQTWcwTVBwWGZKdkVROU13N0V1?=
 =?utf-8?B?M3ViWC9za09CYTR3N1IvZDRaZ0NxRTRieGhnVW9reXllNGhxeG14L3NGZ0NP?=
 =?utf-8?B?Q3d6a2JTMlRRNUpmTEd5SnpIbklFZjI1YVZ0c2xjeUtreTViTTZHbFRXVVoz?=
 =?utf-8?B?TDJFei9mbk9XbmtwYWNmYXZkaFFCRjhqdTE1S1dpWGFGaCt0dmszcWlVaW0v?=
 =?utf-8?B?VmVkM25XZkNnUnJzTmprbUJiaVdsWDZJNjduczlpcXRIQ2hRWTVtTmozRWJk?=
 =?utf-8?B?cEwxNm1vcllpeWR5OWp3a1VLQjV2VFNWeWhGMlc1WEdwUU9lbXlmQ0lSMVhD?=
 =?utf-8?B?T0FydmpDYjRSQWdtdnZTYVlScFl4OFpKZjJqZy82YXZCS3NPcDBlbURITmtZ?=
 =?utf-8?B?MFgrS2czUzZvSG84dEgwSkFrNDlsd0h0UGgrMC9DUHF5ZGRWYWdQNjdsbG9z?=
 =?utf-8?B?TWpibkQ0emdtV2tQdmFPN2JHZXhRelp6enhUZDFUendLaFdTVENpUnFPWDlV?=
 =?utf-8?B?MkNtMmgwL3dVR3h2eW40elo0ZURCeFN2VlpoU2ZwWTVlbjhYcU9CaUZ3ZDdH?=
 =?utf-8?B?UENLVW40YmFnbWFmRkJaZzdFMUhxMUZkSi90dlppNmRJdGFYbFNwTDM3ZXZD?=
 =?utf-8?B?N1BpMEU4U2FrWEszckFIMUdWcFUzZDZrNVVWdlZ3L2hONVl5L2NHNlJpcUo5?=
 =?utf-8?B?eHBXdFh1c1lIeXlJTTZUcTBKckx4NWpEVVIrc0JYRXRoUC93cGEyZkJrQ2xv?=
 =?utf-8?Q?HEnhSR5NG65g0jQNSx20KILin?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7326073-210d-413d-cbc0-08dd984a2083
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 09:30:29.9423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D6hlQEdLLmLUftAn3Zgs3ztCp36MuryBX9aFYYU15ZzcEvVdZ0s15OPZD/EKwq64YDl+zOT0BLImMW5GcpAb9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5639


On 5/20/25 21:06, Dave Jiang wrote:
>
> On 5/20/25 12:18 AM, Alejandro Lucero Palau wrote:
>> Hi Allison,
>>
>> On 5/20/25 03:43, Alison Schofield wrote:
>>> On Wed, May 14, 2025 at 02:27:22PM +0100, alejandro.lucero-palau@amd.com wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> Differentiate CXL memory expanders (type 3) from CXL device accelerators
>>>> (type 2) with a new function for initializing cxl_dev_state and a macro
>>>> for helping accel drivers to embed cxl_dev_state inside a private
>>>> struct.
>>>>
>>>> Move structs to include/cxl as the size of the accel driver private
>>>> struct embedding cxl_dev_state needs to know the size of this struct.
>>>>
>>>> Use same new initialization with the type3 pci driver.
>>>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>>>
>>> snip
>>
>> Thank you for all the review tags. Much appreciated.
>>
>>
>> I'm afraid Dave merged the patchset some hours ago. Maybe he can still add your tags at some point since I think he is using a specific branch for this merge which will likely be merged to another one in the next days.
>>
>>
>> Dave, can you reply here for knowing you have read it?
> Hi Alejandro, sorry about the confusion. The branch I had you test was a test branch for my local testing before merging. The code has not been officially merged as it was not pushed to cxl/next branch upstream. It looks like there are some concerns we need to address from Alison and Dan.


Hi Dave. No worries.


I'll address Dan's concerns and send then a v17. AFAIK, there are no 
concerns from Allison, only review tags.


Thanks

>>


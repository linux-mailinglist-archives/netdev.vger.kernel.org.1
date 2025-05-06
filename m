Return-Path: <netdev+bounces-188317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B48BBAAC27F
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 13:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F33C1C26F59
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 11:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EE1279787;
	Tue,  6 May 2025 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qy5MOflZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95826278E5D
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746530724; cv=fail; b=qi6D+rOP5C8xbm9yAd898idvsH4A7TF37yQ8c4D/nMCDfVqBYc7CnEu2cxweX2oErbLz3wIb6GqsDWnVfvXhLzXERoWEl5zGDDHrFfeNE+ZBaBWKqVAEBouJG6y4jPMFIJHlvMfl5Y90UHfBU1iTa8cS0PczSfcRuZiZ3iJOtdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746530724; c=relaxed/simple;
	bh=xJ/R0y07jIrsL1A2/T6XCOwbsaoPQZ6EIyPxY1XR4WI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D0cX358CiP9dYgknpLFKI10z4scJegQIhmG2ocAsw3KB4qjFWu2v9ugDP842GJpZYyfRCP/1vtO34qCeJ3Jj2d/2fK9uFZxIEdd5sBZZGi6OYNe5smDvOrvSWYPelOFnjz2KJQUuHAGBeoeFEi0/nF3URjaBmA/SDMeU+dwAjw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qy5MOflZ; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUDV19w5L9xmGxjfA6Q17ZcLi/mU6bcU3WQEO/N4VKj/0YRe1xUVMq2bF44SIUseq6aNXFgWCrEzO/Cl5eXuyzp+9vdUI55UmEyxzC88ieaZxTZZfTL9Pu5a+Fig9kNOBJMpALkL+YkR7CsxknEVnxPAZsyv01GsM6zi60Rso/xKYhBwknv7h93MUee5TMy6yD/tYrD5jCm/bgZA+UJsok0vgm+q8kHOpqgTjqtz8KkEakekmsh5i+FD6k7cRvBuTIVI3/q/y8eKpMOmxcs32hX7ZdPUAEJDZbXuEtDhSqKcGYr8a3jhMyzABTHdwUN5vvYxXk+3gNT86JEzUUjo7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2yzsfV84eSuX78QDcFYfbjo8/6wktiaja6jc+Nt6L0=;
 b=Ky/fx5TktoMe7TrCOk723SFpxWWl5xERBfT2OcnNfaj51Poqo9hVMs0aMFoDgPfLGYrZAzW/5cV2/CKI4LcM6988XXougO07plKiIS2aVpw/9m/vI7lRQshCcBvs0stohmb7L5nFFy6Axy/WUzCcuZ1fGloTV2ZV/TpbCejSCDqltsjWRGtEwLFLvOMY3pt8HWUPbSXWrSlT1ZudP38YiqFKmWCjGAl6ZwzfgBi7GxBzFMq1P6vwErOOVexvSzO6/bKBlNeyVphQNYS4JHBlfCAd7pqJUNbWSPweJgdg++JrFHh7Jf/Om+LTOogvLhPyX0T4q0r2iC79o9fuxNPTjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2yzsfV84eSuX78QDcFYfbjo8/6wktiaja6jc+Nt6L0=;
 b=qy5MOflZCZ/VI+h0O69BRDF3/9aeqoCNsyig5pV147nehMGtZtvcPGES+kG3u32xv4cHrNIKqvz9SMafuQA9kR6viBdmQpCbtMrfRNvU97yUa5fvOfTczTq3v+FrJTZt9Pey7yh25y7k0Gbc4r3OEbZbB2xCz/86cHpG+lQwXRJ9WXjwnUQvhY0tRDgZXfcWnCUbzgVVg5nJi2BWNn1T7oYoZZtlEQDsjtpeu+TWByz8CK58fIX/PYB00ALunAI2S9MQz4ShAUAuuAlNPiXOqRRp4sgiCgOaekqcdhmwLqkZ6a0rT2J1XPrE91d8RI09zr/f28tEvYueJo7ZjXvpsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Tue, 6 May
 2025 11:25:15 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%3]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 11:25:14 +0000
Message-ID: <c19e7dec-7aae-449d-b454-4078c8fbd926@nvidia.com>
Date: Tue, 6 May 2025 14:25:10 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/5] devlink: Add unique identifier to devlink port
 function
To: Jakub Kicinski <kuba@kernel.org>
Cc: Moshe Shemesh <moshe@nvidia.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Tariq Toukan <tariqt@nvidia.com>
References: <1745416242-1162653-1-git-send-email-moshe@nvidia.com>
 <20250424162425.1c0b46d1@kernel.org>
 <95888476-26e8-425b-b6ae-c2576125f484@nvidia.com>
 <20250428111909.16dd7488@kernel.org>
 <507c9e1f-f31a-489c-8161-3e61ae425615@nvidia.com>
 <20250501173922.6d797778@kernel.org>
 <d5241829-bd20-4c41-9dec-d805ce5b9bcc@nvidia.com>
 <20250505115512.0fa2e186@kernel.org>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20250505115512.0fa2e186@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::9) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|CH2PR12MB4133:EE_
X-MS-Office365-Filtering-Correlation-Id: d61decae-041d-4841-94d4-08dd8c90abc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0JpOVV0VGh5ZUdDTHlCcDJmMU8wQnhOckhiZ1F5YzRXS1pJSHNlK3dadGZN?=
 =?utf-8?B?aU1YdUltN1BucytRdGY1RTk1L1MvQnpOWDRRVnViVXVKM0dCY2JqVWdlanZB?=
 =?utf-8?B?a1BhWEVrcSthcnBVdlNNVkk5UWFKY0RLRG1Idy85WHF0dE9sOHB1YkY1TG14?=
 =?utf-8?B?WHg3Y24wOXJjdmIyVnV0S24wcG5HR3lsWXUyOHRudzhqUm9NaWE3UTlvODBN?=
 =?utf-8?B?MVJDeVdCSTM1ajZpOTQxTzJCK0xObE4wcm9iQjRQUlZjb0JWN2dkSG8wbWxi?=
 =?utf-8?B?THlmMGlpdWhvZ29aUlF1Smt6ekxraEVTWmc4TFdKM2V6UjdnREdCV25na1Q0?=
 =?utf-8?B?Q3pTcWU0bUMyQnluVC80NXh0TEhvK1NmSm9wZSt4cmFiRWlCdVNTZTNSRU9i?=
 =?utf-8?B?N2c5MWZwNjdVa2V3NzRCdENnOFQzMVZtYlNjK1lWcDNWUWpWSE05YW9NQ2Fz?=
 =?utf-8?B?QmExTGQ2TlBUaGpnTXR5S3FEZWVxNzAwQVI1ZDFnSlA2dFd0ZjJ2dnZ0bWR1?=
 =?utf-8?B?NEZ1YnhjMHlwVVl2OGJBb2R6cUdZd0ZXV09LeGJINVNGZWM1emJQZ25LU2NP?=
 =?utf-8?B?N2MxS3RjV3BXMU05aTRocWRzSm9nWlQ0Mlgyb2hnbUJsaEpxWms4K25rbVlq?=
 =?utf-8?B?eCttVkhyNVNKRFNHbjZ3MGV3OHFpY0FwYzZLT3VjN1o4aVZxSkNEV3FadTV6?=
 =?utf-8?B?ZjFlaktISWJHTmhmbnJiOXprZXpzUFgvdUZzUGtTMHdCOVdBdHBiNVBQbXlG?=
 =?utf-8?B?b3YxTWQ5K0wzakwxZlQ1Q1FuckN1eVd6MVNtRVRXVG5sK2tjcFpHQVRQZytG?=
 =?utf-8?B?S2FLdk1rSkpHalhKbUdCQmdnU0NsQXROczNqbWFlQTZJTnpWTGVpYTA3Qk1B?=
 =?utf-8?B?UDZiTXJYTURaanczTnBIczhWMHRxcnlqSGw3akJHY1V1Ylg1aDNHT0RHNkdp?=
 =?utf-8?B?ZEZwSTIrbDdqbUNuNElySkpnTm85b3Q1YUNNTlU1TVk4SnJ2REdKS1c2N0lh?=
 =?utf-8?B?YVk1M3VQUnlteTlXZ016YnpjTkFHUG1Tc2RVWVU4T1Z1S0hiT3c3d2h0V1h2?=
 =?utf-8?B?SkFOMytETFd4b3pNalNTVDlkamJIVXltTlZmYjFDSmZ6NWZKb2RwdnQvY1ph?=
 =?utf-8?B?Y3daWkFwMTY5MldEUVRXc3dLVGVsK2JMMlhWOVFCY2xJcHFTbU9FZ0RjL1cy?=
 =?utf-8?B?ZXQ4b1FwQnFyVGM4a2ZkYXJMUlZ3Sk1zWDUxcTlRUStrdklqNnJ3NDVMS3Bn?=
 =?utf-8?B?VFR2T2RCL2VWa1lsdlJOekZhRmJjZEl6bERvbG5tdFloMXZGSEQ2aHcvRXd2?=
 =?utf-8?B?YnZva0ZmNi9KZnExV2o0L1NMOGhIRHZwcjZNV2JwWXJ1SDJpSDZRZ3ZZVWdG?=
 =?utf-8?B?Tys3RlErWEFqeUt1UEpNZTlFaDFpZDE0UEx6RktEdmRjemVIM1hPQUk4ejhZ?=
 =?utf-8?B?QUlZMVhmdkpuWjRVZS9leHM2YVM4b21oWEwvMGN1UEpMdHNDdFBKSnhVdlU4?=
 =?utf-8?B?VzFvNVVXVzQ4eEw3bGM5T1EvRWlucEZseWpUMWVaMUhHcWZhQ3dac1VaalNU?=
 =?utf-8?B?dXBLRm9aODVqdmJud24wV2tUeFNLZitEVjY1bzRxZG9aM1JhRVg4RW9UeUVZ?=
 =?utf-8?B?S0xJNDNTU0xyVy92ME1RL2M4ZW85ODlTRjdnUWR0QTBHV3pNSG5YZU1OQmNP?=
 =?utf-8?B?M0IzN21FTzhvam5aR2VxbTdXaXV0YkhzQjQ5bUN4dGgwV0YwbmxNSHZpQzVj?=
 =?utf-8?B?T1VwNlFKT1NGcnFrcG9FN2NDTVAvTTdiUkdXZXpBWWM5UUFYUUJmZHV6Z201?=
 =?utf-8?B?eG5QZ3F0UXZwRVlQckRZc2hFUFI4Rkt2R1JENmpyNGFYSit0VlBYZ21VVzhm?=
 =?utf-8?B?Z21MdnR5YmZmZ2RBbzlQbFcwQXFEWnBNb0pMb2FVVkhLYldIaEJYekJtY0ZR?=
 =?utf-8?Q?aGr41Ut33ko=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTVzWkQxYmdSQUo2SEdLRU9RM2graExJZjVwMTZ0bHc1eFYxWW93ajRJY1hI?=
 =?utf-8?B?MkZqaWVSUUFCbFg0OUVzMFd0NVZUdUpjMU1USUJyV1pOKzNua2ZnZUhoSkZ4?=
 =?utf-8?B?Y3lKZzJDemI2b3VpbW5PdTJocGMyYkUwa2RWZ2FpcURPVjdiL1UzcmlXcDlL?=
 =?utf-8?B?UExBZmtrelFqTEx3L3F2aWxiWFg4eE04Q0ZRbHNuYWtnU0hobU5CRmhkMk5i?=
 =?utf-8?B?SFF0RThxb1diQ1NyWS95Vjg5aHNxU1VMZWJTcXcxMzhHZU9yMjZKUDlQQXJh?=
 =?utf-8?B?UVZoYnJRTXJJb1RvcnYzQjZqZHVtMFNTMmNaTmMvdjcrMlVvZ05Ic2xTYkZh?=
 =?utf-8?B?QlZCUHptVXN4eVBBd0E4WDJSQWdyT0dQaDV4RFl1aUN0NlBacDRNNWNSelRW?=
 =?utf-8?B?RUkvVzZ5NlJrMklqTEovQWMzZmVlVlp6OVpKSzVzZTZCeXZmRlhiY3BreWcy?=
 =?utf-8?B?dDJ5Qng3aVV0d0pVdlRiTUxNRThpMnpHYmpVSFdKR1pUaWQyTnhQbzRZN21U?=
 =?utf-8?B?dCs0N21mNVU2T2QzYTZKZGJpajhwSHdJa0RReXp6TXhEcWZ0VW1Zd0RuVU5S?=
 =?utf-8?B?L2VUbVhtNjJUVEdPa0xmQUVBS2JMRllFZE44TXQ2ejh2TnhiTmJJb3I0bXdw?=
 =?utf-8?B?b295aHNNdGRIL2t5NzQvUGNQVHVjSTBYNGNFdmx6VzRLdWxBUTFVNFNpYllL?=
 =?utf-8?B?a2svL1dKTnRZSks5K3FlSnlIOFM1V0h6dXVzVVBJakp3b0RzZ0JYMWJSMzRh?=
 =?utf-8?B?QU9wcUR0b3VzSE5LSmdtZGRKWWR1bWlRc1kvOWZmaWdGZ09RU3JUZGJXRno1?=
 =?utf-8?B?SDZsd3J4Q1JZR2FtdFdHb1NGYWZJRmgyNGpUYjdNWTh3S0NlL3BaVWRhM2xK?=
 =?utf-8?B?Z1Mrb3FIbTQ4bEYyeTkwdGRWWGZYa0wyK3c2dDRuWWZhRlJkcFNCalh3RGFu?=
 =?utf-8?B?UTAzdSs3ZFo3WEFDaThjN3NiRE5SOWhpQkNNWGhaMnZmejJVSnJRNjFwTjNW?=
 =?utf-8?B?RlNndEJUdktBWXF0YnBicGZ3QXBNM3d1SHo4VGU4aGZpYm1hdDlGaS90RHoz?=
 =?utf-8?B?c3o5OU1ISU52UTVYbkt6ZmJDaHFsZ3dxSndyT2xSOFpXa2VxdmQrL3RoZ21t?=
 =?utf-8?B?SzFhODczMTJLak9qUU9xZ3JvT09oemNYVDU2QmZZdDNQeldxdjlMNExnV1pw?=
 =?utf-8?B?cTFWTE1EdnRmSXZ2UEVsYWxmWVhnNVZoRGlKYUpjVzhydHRSbEI1SDJRQk5O?=
 =?utf-8?B?UWJMOUZYc2RtTHFCOW03MEVFTTdaaWtiTkhySXNRTDl3VmRNalNZd2RNaXdB?=
 =?utf-8?B?MW1SUHU3blZuaUYzQzFNczB6MVVnNmZxQWxXUDR2SzU0Wmo3L09NWEFDazEr?=
 =?utf-8?B?QTYvQ21BMU5SSnRPU3RuVjlwaTJvZzhoTitpajg0NThMY1FLcGYwZi92b0tq?=
 =?utf-8?B?MjFzc3VxY0RuVk1QTkRtV3ZHZm5nUGsycmtVSUJqdS9NWW1HYjlaSGl2Mm13?=
 =?utf-8?B?cWFVVEYrTnp5S25EM1hDZDFRUlRzUzVwelFVMGVkdGh5dDVtL1dyWTFjWUZR?=
 =?utf-8?B?VXcvdHlLd1ZncEp1SmNvNzh6UGQxa2hueHpzaGtBVFBHSWVubmsvMXN4b00v?=
 =?utf-8?B?aWlJbDNWdmMzalYzd1dRbThlZGZLbDJIaVhCNGtuUDJCQzVNejRTbzR1Wllv?=
 =?utf-8?B?ZGpEN0Q5THhsRXRwTFJnT2dFWmVEZmVSanhGV01DTzNIWXFKVGMvNHdYUzRV?=
 =?utf-8?B?T2JENytYWDJsM3picWR2RTMveHZLV1UwTm5kUW5nRHh2OHRkS3FXd1VocUdI?=
 =?utf-8?B?NTFZYUk4Y3BZbEZ6RjFQMHNYWWlPanU1a2ZpVzBuWXF6dmd4QXZKczQwaVNB?=
 =?utf-8?B?NDJQU3dNYmRFeXdpTXVLMmxZeWc3UlNqaEtsQU0xQTZFNWFHYS81TGpZSWpz?=
 =?utf-8?B?SzFyYThCNHNXZHhhcm5VTXJzamtuckdLcHFkTG9iTEJCelE0bmxJU1ZHQVkw?=
 =?utf-8?B?RGpmQlQ1TDBUaUtRYi9keEwvMFRUb2p5VCtPK3o3Y2RwdmQrVXBGc1Fnb3Iz?=
 =?utf-8?B?bEZIbDJjb0VVbVhWa2svaU8vekxzSXVoRXZNd1R1dkRCRFFUWVRMYUtQdEU4?=
 =?utf-8?Q?qfJkh6aAgbn5HgSxikzDb9RB4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d61decae-041d-4841-94d4-08dd8c90abc2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 11:25:14.4392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1zcHOcG4icA0tubpR5x1RLKQ80pacKSdaMdHG9AOxQUbjA5TiK68GJWfPOhztxrRUndqNqAQ0vhRSn/9AoErw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4133



On 05/05/2025 21:55, Jakub Kicinski wrote:
> On Sun, 4 May 2025 20:46:51 +0300 Mark Bloch wrote:
>> On the DPU (ARM), we see representors for each BDF. For simplicity,
>> assume each BDF corresponds to a single devlink port. So the ARM would
>> expose:
>>
>> PF0_HOST0_REP
>> UPLINK0_REP
>> PF0_HOST1_REP
>> UPLINK1_REP
>>
>> In devlink terms, we're referring to the c argument in phys_port_name,
>> which represents the controller, effectively indicating which host
>> the BDF belongs to.
>>
>> The problem we're addressing is matching the PF seen on a host to its
>> corresponding representor on the DPU. From the ARM side, we know that
>> this rep X belongs to pf0 on host y, but we don't which host is which.
>> From within each host, you can't tell which host you are, because all
>> see their PF as PF0.
>>
>> With the proposed feature (along with Jiri's changes), this becomes
>> trivial, you just match the function UID and you're done.
> 
> Thanks for explaining the setup. Could you please explain the user
> scenario now? Perhaps thinking of it as a sequence diagram would
> be helpful, but whatever is easiest, just make it concrete.
> 

It's a rough flow, but I believe it clearly illustrates the use case
we're targeting:
 
Some system configuration info:
 
- A static mapping file exists that defines the relationship between
  a host and the corresponding ARM/DPU host that manages it.
 
- OVN, OVS and Kubernetes are used to manage network connectivity and
  resource allocation.
 
Flow:
1. A user requests a container with networking connectivity.
2. Kubernetes allocates a VF on host X. An agent on the host handles VF
   configuration and sends the PF number and VF index to the central
   management software.
3. An agent on the DPU side detects the changes made on host X. Using
   the PF number and VF index, it identifies the corresponding
   representor, attaches it to an OVS bridge, and allows OVN to program
   the relevant steering rules.
 
This setup works well when the mapping file defines a one-to-one
relationship between a host and a single ARM/DPU host.
It's already supported in upstream today [1]
 
However, in a slightly more generic scenario like:
 
Control Host A: External host X
                External host Y
 
A single ARM/DPU host manages multiple external hosts. In this case, step
2—where only the PF number and VF index are sent is insufficient. During
step 3, the agent on the DPU reads the data but cannot determine which
external host created the VF. As a result, it cannot correctly associate
the representor with the appropriate OVS bridge.
 
To resolve this, we plan to modify step 2 to include the VUID along with
the PF number and VF index. The DPU-side agent will use the VUID to match
it with the FUID, identify the correct PF representor, and then use
standard devlink mechanisms to locate the corresponding VF representor.

1: https://github.com/ovn-kubernetes/ovn-kubernetes
You can look at: go-controller/pkg/util/dpu_annotations.go for more info.

Mark

>> As a side note, I believe this feature has merit even beyond this
>> specific use case. 
> 
> I also had that belief when I implemented something similar for the NFP
> long time ago. Jiri didn't like the solution / understand the problem 
> at the time. But it turned out not to matter in practice.


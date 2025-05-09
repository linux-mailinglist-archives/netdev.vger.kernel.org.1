Return-Path: <netdev+bounces-189354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F0FAB1D78
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 21:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E871C450EF
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 19:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D70225E477;
	Fri,  9 May 2025 19:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="m85CwzOZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2112.outbound.protection.outlook.com [40.107.212.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFCC23E35F;
	Fri,  9 May 2025 19:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746820156; cv=fail; b=uOVtFYiO0RzaMvdQNUSE2b0jMw+exHODwXq9b9QH4gpNa629cqrZfdU5+6h43g1skvoQsPoc6AFQ4DDbGGLblUYhI5u99roXY6Y0sDxBHsJVrZ5+XC/z71id54v8F4p4tqfnCgFaJ6w3BAeThB5B1ExpSYynMkjFmjlo07t1Kpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746820156; c=relaxed/simple;
	bh=zslTtY/YZEoEdNdYarRZV7sZtzgW4TdinNOOvnzGvbg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JTiMmKZO+5LzqHT53RyfJFUg457pqRJFnDa/UgW/KoVoTs+g3j9J0dSDYY7mb2wEQgkXBnx918QRAXVrV0oLRw6sG7LaXKvQFCTX1huNcGM9kRyNbdmaco7n/trtFCY0kpiDmvAuDNU7o68m6iHGLoC8pMzD3s+qq59WyuSekOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=m85CwzOZ reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.212.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0QFQPzjhEfiG/DgjvL0DUarbfvtl9hJnLbVUVu/KuY1CcWc+HvMkgdiH/eiiF/7YZXqPoh6DHVW+SGQ54Vr8vtBrbl0IKlrN20NspEOGsdzz51nbMvKHeC9+CGSa0SiQSUlyZzjkf+D0D2psNBtLN+kPnnXfiO7hDJiyBiC4jkNCkozTr4loUvVm5VZ/OD0GmHHbcDSb7DyxZ9oIEdFNwfuS2I+eZcSYfOLy5rS9E1iA0gDhKM08AZjzm1iCUX2UJGfxsWiJDwk2IirhqYxJZln5kxAuJIbFmtdBb8ugdCl/umwLR+UY1folItF9nBdrJnCTg6NZbGRadEGDeu0hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rt5A2kHZANvemfh5Bz6vnNsTFJWp0MZ+q/q9fpPO08=;
 b=w84Uh/0Bqz7saSI+v71g2Iw3yGQmD2K70tkqV2sMo45mg1OWL5AR1TJMB3FoaUDqWLQFjLyynWaxlrXZrwyaxMLg21ygBPLqdZg9P4BZoRu6CINV+f5BQFxdhE3pzXn3gwBFtDt/eUQ/cz0Dghdg5XbdncqpFSCadDEIdSuZumwCtp2gI2beC1EcwtvYws+CL6oyRimej9KgGcrGt2nNNoBXEMGKNZz/pZjg3BICvuEdShM0x6I6p+7JAzgcn1IeB6/EOU8EXG3/0UB38yQEXQfLaBONzo51gllGx7NYFemnbJ6kX29AVWoEfqES4IX0rGenu1eBXZuZxSPTNhmorA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rt5A2kHZANvemfh5Bz6vnNsTFJWp0MZ+q/q9fpPO08=;
 b=m85CwzOZZ4R2wBNx090rBck4RobDVq0V7ZNIB4XcEn2XxMIU5tdVQY3xiI7oxPMWqS2VpVNQ/0lVZFpZVC6wAOqq2PK930TsZh3pNczKvqYk87d6ouZOxvQ2eUVfXt2NKArpSLNKgDWtHJvay/emFB+tQCTjkpEmKRDHeJiy4JY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 BY1PR01MB9043.prod.exchangelabs.com (2603:10b6:a03:5b1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.24; Fri, 9 May 2025 19:49:07 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.8722.024; Fri, 9 May 2025
 19:49:07 +0000
Message-ID: <349cd626-dbfa-424b-a6f5-8008aa910f87@amperemail.onmicrosoft.com>
Date: Fri, 9 May 2025 15:49:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v21 1/1] mctp pcc: Implement MCTP over PCC
 Transport
To: admiyo@os.amperecomputing.com, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250429222759.138627-1-admiyo@os.amperecomputing.com>
 <20250429222759.138627-2-admiyo@os.amperecomputing.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20250429222759.138627-2-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:a03:255::19) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|BY1PR01MB9043:EE_
X-MS-Office365-Filtering-Correlation-Id: da779cc8-7992-406c-9ff3-08dd8f328f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MndLTHdLR0lVcm9yR0gzU0VoVWorNXNBK3pYOEdQZHAvR0tGZ0NkYTlJUmVK?=
 =?utf-8?B?b1dCNEI4WmdrR3RIQURjTG1heXc5R09lZlJYS1UvNnR3OVZuVzgyTnM4a2M4?=
 =?utf-8?B?Z25TWnFwUm1DWG9CbW5BY1o2d1NXckQvYTBkdmNPVW80NUlIVUIxdmUxN1My?=
 =?utf-8?B?RnYyYkJBTVBXWm1lMkppenRqQjk1d21mVmNOdG9USkNVcFZ6bEVDTUJCSUpG?=
 =?utf-8?B?NWo1aEFlR2JhMk1UTStCaXZnQXUrODVjd2kvMDRWSWxiL0VkMjEvT0N6d3dX?=
 =?utf-8?B?QWwzVWhjcmJwazU0RjY4enVJNlBqTzR6ZnRJNE5XSHhhZGl0T0hOSW1JL3Q3?=
 =?utf-8?B?NDBDRmtDSEFxN3RMaFllWWtCNk5RelhvOFlRYll3UUFUUE1zUFdhNExyalNr?=
 =?utf-8?B?YlpydVoyL0JhOFZiKzBZUnEwbUg3ejdiQWE1aWJnSytLVEJ3WldoV1RNbVdL?=
 =?utf-8?B?VGZRZGVyVXp1ckFxMisrTVFmZXpuYlpsSHhHVFBqTVIzYXNXYUhCbWhRNWMw?=
 =?utf-8?B?eW9ZUWlwVEQ1ZjVhOHF0T2ZGc3J4dEZYdjQ2RC9pZ1E2ZS9qS3A3S0RJbURY?=
 =?utf-8?B?V24ycEMwV2N4bWg1blFDKzhGRWNTTnBLc0psazJyUHliaVdWaW1MSHJwTksv?=
 =?utf-8?B?TG5LZkUrYjZjS0NKRDlFaE1pTVREWFBIY1VoRnUweW5HY2UxU3k0aEhQZ0dT?=
 =?utf-8?B?cnUzNkVwbHIydCs1ajJIZlk2aTM5WW5NT01vWXdVVmxNY3NWa0hrUE1zZ01R?=
 =?utf-8?B?ZnI5VUlZd2w5b05jY2lSZnczNHJENHpHZ2IxN0RaUTZGQ0x4ZHV1c0F5RmNY?=
 =?utf-8?B?d0V3aW1ydzA0cDk3cGlVdGRKU1ptS2FraDhyZjRUZUtGbUFFOW00L3hLSlN2?=
 =?utf-8?B?RFBaaHNOWHhDbWE4TTdYRHEvR0JQeXdCR29ldzdtdDMydlNRb2FERUJMYjha?=
 =?utf-8?B?b1BQbHBVOXlpVmRpaUZIVVdpVnZicndsMTRpMmFrSmxmL0ZvNTZxd3VyNTVt?=
 =?utf-8?B?T1FKVldyeEhRampxQjB3UnQvSllvRExBd2lvSFBVRkRGRkRNdnJjRHcyOVlM?=
 =?utf-8?B?aHF3OUVEQXZSaGwvZ2NWWWY3NTlua3ExaDhhNFdLVzd1K3JPMDB6L1g1UHRq?=
 =?utf-8?B?QzZPQ0dob1pjVElDNkRSWlk3dm01S0Z4anlZM0VqMFZ6bUV5L1p1NjNpMWJH?=
 =?utf-8?B?bzFTNHkySkcwWUdsUjYxTStyRm4yRWJYVHlkM3pJb1lFRnNBZU5wOHBTbVY5?=
 =?utf-8?B?c0U1RXBuWG1vNDJqcU1pMVREak1zaGx1MFhwUFZXZmxYTldzYU5sRE50eENY?=
 =?utf-8?B?amlGQ0JCQ0ZOZGc5OUJ0UlFTenNFSktWKyt4VHdmQTdGNXNWWEY1QWJhS3JI?=
 =?utf-8?B?R0QrL1ZmWjkraTdYc1JJNFhMUUs1c3REUHNoSDMrbWFvYVhIZm03dXJWbldL?=
 =?utf-8?B?VDNmdCtaNUVRSkxNUjN0SVlTQUJsMmRTVGYzQWlYUUhaVExsWTkxUGNQbG1s?=
 =?utf-8?B?ak1nd051c3UwMmxndTZWd3djbnBENExqRE4wVjlpTEZ4SGlyc25mcXQ3UElN?=
 =?utf-8?B?Z0FVNVBoeDVhd05udVR0M3lvMzNwRkVCS2tFZ1hWNkFEWHViVHM5czQyQVNP?=
 =?utf-8?B?cm03c3JkNjAxdVNFSGZMOTRFUjNzL3QzVDZ4YUxCTlJUbXoxVXhsaHdXazVz?=
 =?utf-8?B?bVQ1ZXJ6NjNNWlJaUWg1OTlMcHZjSG53MzNvNHc2WlBYdUxGb2hFVWg2T21p?=
 =?utf-8?B?aXprNnhwdVhmTEw3MFhGVVlWd09KeUZSVGtOUnpOa1VRcUtSZ0hiSjVDYnlS?=
 =?utf-8?Q?RGqxM9SbViiS9EF4jvlHALbK02NjIa4lg0t5s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmtRWThDTkxTKzBiSm1WdmZXTzRENmVpUVRBNWJVamVzbnl2WlNwcncvWUV0?=
 =?utf-8?B?Mkk5Tko4SUlhQzBqQ21RYXhnNUdUOHMwVlRTQk5SaXNONTBibnFEOUpSakxG?=
 =?utf-8?B?Y0JCSkREVXBLNlBwak84ZG1EeFBUcHQ5VmVYOWVYNGNET1VkekY2dGNxbXRW?=
 =?utf-8?B?NzB2NE5FZGRSTVMwQk9kWSt2Q1BwOFVUUlZzek1RTmNyNlJIZTZDTFZuMWZy?=
 =?utf-8?B?TVd0SXU2NG9Kck5sUWRTWmNoaTNPZVk2WUgxKzRydTd6ZlNGTHFDT1RNdG5C?=
 =?utf-8?B?U3VSNXRLckFER3dPZzN6NEFuVW9wLy94aHlvMjBtQ05YU256R29peFMxL3h3?=
 =?utf-8?B?ZFI3YzlrNWwxbVg1V0ZUL0d1MVdYblN6Q3o1N2FVc0VNOFZBdkE4ZHlFQitx?=
 =?utf-8?B?ek9zc1ZIaUR1M25IWUhjV0N6TEdwWjBZYzJST3BLZnZJd3ZFNWNuSC9MNmU0?=
 =?utf-8?B?Vkczem14NGN3aUNBSzcvakl5RTZLY2l5K0RyM1JiMXZPRDhHSk53MFdCM0lE?=
 =?utf-8?B?eVpCZ3h0Z1hnMFdlcXEvVjZZMGZaOUl5ZlRzQmRIR0pJUGs0N0RiclUvMTJY?=
 =?utf-8?B?all6UzMzZU8yVURPUWk1MEhVOUdSaC9WWC9rdjFieTNkUDlCbmE5Yy9KSnlp?=
 =?utf-8?B?S1pWdFZpMUdRRW9OOHdGbks1cnBwNEV0RmQ3NEdJZXYrVStuVUxBdE9FUFdR?=
 =?utf-8?B?dWlSUEhDMWE5VEEvZkR0RHZYSGhsK0laSUpDK2tQYWw2VXdzQlpjT2wvR3hD?=
 =?utf-8?B?ZldWSk9weFdEWDZpN3ZuaE9GTkFmbFlxemdteENTU0NoOWFEd0o0a3JCOXFK?=
 =?utf-8?B?ejlWcUFiRGsxTG45WGRoVk9pRU94OXdQN3BiZlRkaUdrVUY2K2I0eDQ0dkRv?=
 =?utf-8?B?VjZEcmpLM3lGZ0JVTjBlNE9IZmp6MURtQ0tpcGJKT3oxcXZRNGwwOU9oMlhv?=
 =?utf-8?B?YUNvRFZQOFJJY0NHSUszYmVKdGE3Z2dta252NWY4d3NvNnNEeDVCK2d2a25Y?=
 =?utf-8?B?MWxiMmZMQkxqS3ZLZ3NLYXF2emMwa1cvU2wxNjZiMVZvSEhYQy9UTGcxalox?=
 =?utf-8?B?aW5pRzN5WFNkRlVEa0NvQXVEeFJFbzd4NUhXTENDckthU0pVaklVMkZnNDNB?=
 =?utf-8?B?OCs0MmlIWUxsY1pSendVY0M1WGkrUloyL0srbjRIS01vZ0l4cGxQZ20vTnZD?=
 =?utf-8?B?bjF1bmxuY2p4K1FkRnJoQlluMThNd3l3NkhqbGwvc2ZqTFRCZFlWTEhSK0I3?=
 =?utf-8?B?NXpPM3UyMmRXZC84eTJuclNtcG1QMlhhVi9MZFYxOGIzOEhZQWp0WEJxZkFK?=
 =?utf-8?B?U0NtMmZiZWVjZlJqejladXd2QVZtUzhCajYzWUppallQUWpaRFNsZmFZdkRS?=
 =?utf-8?B?Q0lydlBNV1d3cDJ2WktaMnZCQWtSTFdVVkVRM0RlN3V4MEduakVwT25NREFr?=
 =?utf-8?B?ZjZ3OXFhNlhmQUZZdDRTQTRJSitTUnVDOXJRRzB6U2t4S2NQck5YanBGdGRi?=
 =?utf-8?B?aVFUOHYzUTE4d01ubnBUWHZxeWZCTUFGQ1dXNVEyeGd5dTh4dXFiYkNtYWJ1?=
 =?utf-8?B?b2dMaGhDK3dvZk5BbTB1NE8vWVBUTHdKT2l3bzN2ZE1kYmpCWHpUNjBOQ3pW?=
 =?utf-8?B?VkhsS3U2bXZnZUZoYWZWMHMxbi9teC96bGVWSGNLWmIzSXpjcFhzZFhWbDFW?=
 =?utf-8?B?WDIwMFlMdjdLU21tYnVXRVlTbkhQbUpRWXZobDdVRTdFMEdGZFgrcldEWnA4?=
 =?utf-8?B?WmkvWHlLbmg3RXJmNHRTRmJLNnQvTWlCMStNb0J6T1V4USs5ZW1GcjlYZ1pE?=
 =?utf-8?B?WTdRSG9Oc3QrcFVWUVVDbnQ5QlZYWjZNbVdtSXFFMHowN094YytOait4cnZN?=
 =?utf-8?B?cmVEVDh3dUZnYUttemluOG14L2pqWUZ0dFVkQUtOSjQxaFNzMStEQ1RjSlky?=
 =?utf-8?B?OXBZMFZQZitNKzBpMUp1clFoazlhR3dVdUI3V0kxcmVkMXM4dG5YRWl0dGxN?=
 =?utf-8?B?c1BLQnNiMmFyck1TQUovTVhMdWpyeDNZUnllckoyUm5BSnZWMVBYZVR6M3F5?=
 =?utf-8?B?SGJBUWc3bkJmMUkrbDRoWmdiM3BUSU9KRTQva1VYdHg0SitQRmd0cGlwcmJ0?=
 =?utf-8?B?UDBycUxyeVpoM3k4TWxid3gwRStQbHM5M1ZGYjhEUlN2RUZhRUpYTDh1b0pM?=
 =?utf-8?B?RTJmclhzanlDWkU4R0NKa3dESCtZbEU0NkJkLzRaVFRROXRiZk42RGplZWdE?=
 =?utf-8?Q?BiEjoEwuRMI8N/GfFaW7rVbtVppoJvtGqyNzKtnUrM=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da779cc8-7992-406c-9ff3-08dd8f328f33
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 19:49:07.2098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MGLRS38oFzXUNvbwyKJr9QtJz21YWuk/jDMoSamWQDkdPStcPAxSdhw2TFpsqPaSbUarv1MLs2KPfRX1pcjRLNFHZmKIGFrb0ysV+JN3gQ6ze1yAHW1q/A/v9M3f3KXv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR01MB9043

Should I consider this one ACKed?  It was ACKed by Jeremy Kerr before 
the last round of changes.

Is there a likelihood of this getting in to then next release?


On 4/29/25 18:27, admiyo@os.amperecomputing.com wrote:
> From: Adam Young <admiyo@os.amperecomputing.com>
>
> Implementation of network driver for
> Management Control Transport Protocol(MCTP)
> over Platform Communication Channel(PCC)
>
> DMTF DSP:0292
> https://www.dmtf.org/sites/default/files/standards/documents/\
> DSP0292_1.0.0WIP50.pdf
>
> MCTP devices are specified via ACPI by entries
> in DSDT/SDST and reference channels specified
> in the PCCT.  Messages are sent on a type 3 and
> received on a type 4 channel.  Communication with
> other devices use the PCC based doorbell mechanism;
> a shared memory segment with a corresponding
> interrupt and a memory register used to trigger
> remote interrupts.
>
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
> ---
>   MAINTAINERS                 |   5 +
>   drivers/net/mctp/Kconfig    |  13 ++
>   drivers/net/mctp/Makefile   |   1 +
>   drivers/net/mctp/mctp-pcc.c | 305 ++++++++++++++++++++++++++++++++++++
>   4 files changed, 324 insertions(+)
>   create mode 100644 drivers/net/mctp/mctp-pcc.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a7545b5abef9..7a3096a025ca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14207,6 +14207,11 @@ F:	include/net/mctpdevice.h
>   F:	include/net/netns/mctp.h
>   F:	net/mctp/
>   
> +MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP) over PCC (MCTP-PCC) Driver
> +M:	Adam Young <admiyo@os.amperecomputing.com>
> +S:	Maintained
> +F:	drivers/net/mctp/mctp-pcc.c
> +
>   MAPLE TREE
>   M:	Liam R. Howlett <Liam.Howlett@oracle.com>
>   L:	maple-tree@lists.infradead.org
> diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
> index cf325ab0b1ef..f69d0237f058 100644
> --- a/drivers/net/mctp/Kconfig
> +++ b/drivers/net/mctp/Kconfig
> @@ -57,6 +57,19 @@ config MCTP_TRANSPORT_USB
>   	  MCTP-over-USB interfaces are peer-to-peer, so each interface
>   	  represents a physical connection to one remote MCTP endpoint.
>   
> +config MCTP_TRANSPORT_PCC
> +	tristate "MCTP PCC transport"
> +	depends on ACPI
> +	help
> +	  Provides a driver to access MCTP devices over PCC transport,
> +	  A MCTP protocol network device is created via ACPI for each
> +	  entry in the DST/SDST that matches the identifier. The Platform
> +	  communication channels are selected from the corresponding
> +	  entries in the PCCT.
> +
> +	  Say y here if you need to connect to MCTP endpoints over PCC. To
> +	  compile as a module, use m; the module will be called mctp-pcc.
> +
>   endmenu
>   
>   endif
> diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
> index c36006849a1e..2276f148df7c 100644
> --- a/drivers/net/mctp/Makefile
> +++ b/drivers/net/mctp/Makefile
> @@ -1,3 +1,4 @@
> +obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
>   obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
>   obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
>   obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
> diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
> new file mode 100644
> index 000000000000..aa5c5701d581
> --- /dev/null
> +++ b/drivers/net/mctp/mctp-pcc.c
> @@ -0,0 +1,305 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * mctp-pcc.c - Driver for MCTP over PCC.
> + * Copyright (c) 2024, Ampere Computing LLC
> + */
> +
> +/* Implementation of MCTP over PCC DMTF Specification DSP0256
> + * https://www.dmtf.org/sites/default/files/standards/documents/DSP0256_2.0.0WIP50.pdf
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/if_arp.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/platform_device.h>
> +#include <linux/string.h>
> +
> +#include <acpi/acpi_bus.h>
> +#include <acpi/acpi_drivers.h>
> +#include <acpi/acrestyp.h>
> +#include <acpi/actbl.h>
> +#include <net/mctp.h>
> +#include <net/mctpdevice.h>
> +#include <acpi/pcc.h>
> +
> +#define MCTP_PAYLOAD_LENGTH     256
> +#define MCTP_CMD_LENGTH         4
> +#define MCTP_PCC_VERSION        0x1 /* DSP0292 a single version: 1 */
> +#define MCTP_SIGNATURE          "MCTP"
> +#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
> +#define MCTP_HEADER_LENGTH      12
> +#define MCTP_MIN_MTU            68
> +#define PCC_DWORD_TYPE          0x0c
> +
> +struct mctp_pcc_hdr {
> +	__le32 signature;
> +	__le32 flags;
> +	__le32 length;
> +	char mctp_signature[MCTP_SIGNATURE_LENGTH];
> +};
> +
> +struct mctp_pcc_mailbox {
> +	u32 index;
> +	struct pcc_mbox_chan *chan;
> +	struct mbox_client client;
> +};
> +
> +/* The netdev structure. One of these per PCC adapter. */
> +struct mctp_pcc_ndev {
> +	/* spinlock to serialize access to PCC outbox buffer and registers
> +	 * Note that what PCC calls registers are memory locations, not CPU
> +	 * Registers.  They include the fields used to synchronize access
> +	 * between the OS and remote endpoints.
> +	 *
> +	 * Only the Outbox needs a spinlock, to prevent multiple
> +	 * sent packets triggering multiple attempts to over write
> +	 * the outbox.  The Inbox buffer is controlled by the remote
> +	 * service and a spinlock would have no effect.
> +	 */
> +	spinlock_t lock;
> +	struct mctp_dev mdev;
> +	struct acpi_device *acpi_device;
> +	struct mctp_pcc_mailbox inbox;
> +	struct mctp_pcc_mailbox outbox;
> +};
> +
> +static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct mctp_pcc_hdr mctp_pcc_hdr;
> +	struct mctp_skb_cb *cb;
> +	struct sk_buff *skb;
> +	void *skb_buf;
> +	u32 data_len;
> +
> +	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, inbox.client);
> +	memcpy_fromio(&mctp_pcc_hdr, mctp_pcc_ndev->inbox.chan->shmem,
> +		      sizeof(mctp_pcc_hdr));
> +	data_len = le32_to_cpu(mctp_pcc_hdr.length) + MCTP_HEADER_LENGTH;
> +	if (data_len > mctp_pcc_ndev->mdev.dev->mtu) {
> +		dev_dstats_rx_dropped(mctp_pcc_ndev->mdev.dev);
> +		return;
> +	}
> +
> +	skb = netdev_alloc_skb(mctp_pcc_ndev->mdev.dev, data_len);
> +	if (!skb) {
> +		dev_dstats_rx_dropped(mctp_pcc_ndev->mdev.dev);
> +		return;
> +	}
> +	dev_dstats_rx_add(mctp_pcc_ndev->mdev.dev, data_len);
> +
> +	skb->protocol = htons(ETH_P_MCTP);
> +	skb_buf = skb_put(skb, data_len);
> +	memcpy_fromio(skb_buf, mctp_pcc_ndev->inbox.chan->shmem, data_len);
> +
> +	skb_reset_mac_header(skb);
> +	skb_pull(skb, sizeof(mctp_pcc_hdr));
> +	skb_reset_network_header(skb);
> +	cb = __mctp_cb(skb);
> +	cb->halen = 0;
> +	netif_rx(skb);
> +}
> +
> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
> +{
> +	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
> +	struct mctp_pcc_hdr *mctp_pcc_header;
> +	void __iomem *buffer;
> +	unsigned long flags;
> +	int len = skb->len;
> +	int rc;
> +
> +	rc = skb_cow_head(skb, sizeof(*mctp_pcc_header));
> +	if (rc)
> +		goto err_drop;
> +
> +	mctp_pcc_header = skb_push(skb, sizeof(mctp_pcc_header));
> +	mctp_pcc_header->signature = cpu_to_le32(PCC_SIGNATURE | mpnd->outbox.index);
> +	mctp_pcc_header->flags = cpu_to_le32(PCC_CMD_COMPLETION_NOTIFY);
> +	memcpy(mctp_pcc_header->mctp_signature, MCTP_SIGNATURE,
> +	       MCTP_SIGNATURE_LENGTH);
> +	mctp_pcc_header->length = cpu_to_le32(len + MCTP_SIGNATURE_LENGTH);
> +
> +	spin_lock_irqsave(&mpnd->lock, flags);
> +	buffer = mpnd->outbox.chan->shmem;
> +	memcpy_toio(buffer, skb->data, skb->len);
> +	rc = mpnd->outbox.chan->mchan->mbox->ops->send_data
> +		(mpnd->outbox.chan->mchan, NULL);
> +	spin_unlock_irqrestore(&mpnd->lock, flags);
> +	if ACPI_FAILURE(rc)
> +		goto err_drop;
> +	dev_dstats_tx_add(ndev, len);
> +	dev_consume_skb_any(skb);
> +	return NETDEV_TX_OK;
> +err_drop:
> +	dev_dstats_tx_dropped(ndev);
> +	kfree_skb(skb);
> +	return NETDEV_TX_OK;
> +}
> +
> +static const struct net_device_ops mctp_pcc_netdev_ops = {
> +	.ndo_start_xmit = mctp_pcc_tx,
> +};
> +
> +static const struct mctp_netdev_ops mctp_netdev_ops = {
> +	NULL
> +};
> +
> +static void mctp_pcc_setup(struct net_device *ndev)
> +{
> +	ndev->type = ARPHRD_MCTP;
> +	ndev->hard_header_len = 0;
> +	ndev->tx_queue_len = 0;
> +	ndev->flags = IFF_NOARP;
> +	ndev->netdev_ops = &mctp_pcc_netdev_ops;
> +	ndev->needs_free_netdev = true;
> +	ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
> +}
> +
> +struct mctp_pcc_lookup_context {
> +	int index;
> +	u32 inbox_index;
> +	u32 outbox_index;
> +};
> +
> +static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
> +				       void *context)
> +{
> +	struct mctp_pcc_lookup_context *luc = context;
> +	struct acpi_resource_address32 *addr;
> +
> +	if (ares->type != PCC_DWORD_TYPE)
> +		return AE_OK;
> +
> +	addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
> +	switch (luc->index) {
> +	case 0:
> +		luc->outbox_index = addr[0].address.minimum;
> +		break;
> +	case 1:
> +		luc->inbox_index = addr[0].address.minimum;
> +		break;
> +	}
> +	luc->index++;
> +	return AE_OK;
> +}
> +
> +static void mctp_cleanup_netdev(void *data)
> +{
> +	struct net_device *ndev = data;
> +
> +	mctp_unregister_netdev(ndev);
> +}
> +
> +static void mctp_cleanup_channel(void *data)
> +{
> +	struct pcc_mbox_chan *chan = data;
> +
> +	pcc_mbox_free_channel(chan);
> +}
> +
> +static int mctp_pcc_initialize_mailbox(struct device *dev,
> +				       struct mctp_pcc_mailbox *box, u32 index)
> +{
> +	box->index = index;
> +	box->chan = pcc_mbox_request_channel(&box->client, index);
> +	box->client.dev = dev;
> +	if (IS_ERR(box->chan))
> +		return PTR_ERR(box->chan);
> +	return devm_add_action_or_reset(dev, mctp_cleanup_channel, box->chan);
> +}
> +
> +static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
> +{
> +	struct mctp_pcc_lookup_context context = {0};
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct device *dev = &acpi_dev->dev;
> +	struct net_device *ndev;
> +	acpi_handle dev_handle;
> +	acpi_status status;
> +	int mctp_pcc_mtu;
> +	char name[32];
> +	int rc;
> +
> +	dev_dbg(dev, "Adding mctp_pcc device for HID %s\n",
> +		acpi_device_hid(acpi_dev));
> +	dev_handle = acpi_device_handle(acpi_dev);
> +	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
> +				     &context);
> +	if (!ACPI_SUCCESS(status)) {
> +		dev_err(dev, "FAILURE to lookup PCC indexes from CRS\n");
> +		return -EINVAL;
> +	}
> +
> +	/* inbox initialization */
> +	snprintf(name, sizeof(name), "mctpipcc%d", context.inbox_index);
> +	ndev = alloc_netdev(sizeof(*mctp_pcc_ndev), name, NET_NAME_PREDICTABLE,
> +			    mctp_pcc_setup);
> +	if (!ndev)
> +		return -ENOMEM;
> +
> +	mctp_pcc_ndev = netdev_priv(ndev);
> +	spin_lock_init(&mctp_pcc_ndev->lock);
> +
> +	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
> +					 context.inbox_index);
> +	if (rc)
> +		goto free_netdev;
> +	mctp_pcc_ndev->inbox.client.rx_callback = mctp_pcc_client_rx_callback;
> +
> +	/* outbox initialization */
> +	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->outbox,
> +					 context.outbox_index);
> +	if (rc)
> +		goto free_netdev;
> +
> +	mctp_pcc_ndev->acpi_device = acpi_dev;
> +	mctp_pcc_ndev->mdev.dev = ndev;
> +	acpi_dev->driver_data = mctp_pcc_ndev;
> +
> +	/* There is no clean way to pass the MTU to the callback function
> +	 * used for registration, so set the values ahead of time.
> +	 */
> +	mctp_pcc_mtu = mctp_pcc_ndev->outbox.chan->shmem_size -
> +		sizeof(struct mctp_pcc_hdr);
> +	ndev->mtu = MCTP_MIN_MTU;
> +	ndev->max_mtu = mctp_pcc_mtu;
> +	ndev->min_mtu = MCTP_MIN_MTU;
> +
> +	/* ndev needs to be freed before the iomemory (mapped above) gets
> +	 * unmapped,  devm resources get freed in reverse to the order they
> +	 * are added.
> +	 */
> +	rc = mctp_register_netdev(ndev, &mctp_netdev_ops, MCTP_PHYS_BINDING_PCC);
> +	if (rc)
> +		goto free_netdev;
> +	return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
> +free_netdev:
> +	free_netdev(ndev);
> +	return rc;
> +}
> +
> +static const struct acpi_device_id mctp_pcc_device_ids[] = {
> +	{ "DMT0001" },
> +	{}
> +};
> +
> +static struct acpi_driver mctp_pcc_driver = {
> +	.name = "mctp_pcc",
> +	.class = "Unknown",
> +	.ids = mctp_pcc_device_ids,
> +	.ops = {
> +		.add = mctp_pcc_driver_add,
> +	},
> +};
> +
> +module_acpi_driver(mctp_pcc_driver);
> +
> +MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
> +
> +MODULE_DESCRIPTION("MCTP PCC ACPI device");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");


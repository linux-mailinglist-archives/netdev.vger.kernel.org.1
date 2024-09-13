Return-Path: <netdev+bounces-128233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECF3978A7F
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 23:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13EC1F244C3
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 21:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE53514F102;
	Fri, 13 Sep 2024 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="6HOELQXB"
X-Original-To: netdev@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020074.outbound.protection.outlook.com [40.93.198.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2352D1494BF;
	Fri, 13 Sep 2024 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726262477; cv=fail; b=nfVgmBfZQ0q9vaTejOrueHZIxs4fmfpVrgunn1EK+SQQSeAul+7r4h1ejpzQdeTTQQ6rujI+Idyyi6UwO+sjG3xNFEXlZN8pAERRo7rMbKDuX+WhjwfWhnsgx64OQbxjVOX5tnGFkLmmLpFkHDbUoXWxjdGBejkvsta+7cn1YYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726262477; c=relaxed/simple;
	bh=SblnQGEMidt8dw5R5I88ZPKAfnBUMIDrexglMPgUn1Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ulYJgqiIKRszW+QC4Pj6XNND+2wvw8SK2xi9HIAoqRM31VlAy/KReGexhLD3WEoFSwIgv3mQiK2nNglnM9J/h/8LNAi0tKG3LCtLJsnNAL89Jku3RmGr4gk9xp5kZVpoP1IEmng84L/toP+4i2aN+vkT8txXs0pF1x9/Mq3dIZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=6HOELQXB reason="key not found in DNS"; arc=fail smtp.client-ip=40.93.198.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lO4wch+4J4x39XT3XRRI/k1RbEmBx8BIOB+94BlTdCb6wtjdvJfemd/dJuHxapOQM+NlfdkbDWgk1hKFZxucL64rV9bWbU83gFF89ZnsrovLe845DUTaAqGhUOjUi990Is+FV7XDDqukvnRaCsoJwZz/5n6sqkVmfSMIxtyKPdfFqKJC5wYZQguybzYWbLIKLSmxA25LS95ZIgJVDPMz8TeSUu1SnUZnZCA9RkhuDa7+Svi3xENFkH4M2H0f/GCfZWXISq9cy4HdrP/LGlEcy2vpUZWNVqTqUxmkkd7ppJlMcmGSJjG2NjY4cvuqlbPoMpzBr7GBd+CH6lxL09+H6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTD4GnO9x4orFNDZ+fmMEJ2vArsQe2+vsrD/ec4BsUs=;
 b=bciU/QdsEIYX5r6HOTma6FXCt1CxfugLYuMvDhxMnMcnMTvBYI2+XUoBIe1FCugJyUo13VhnsM3O9o5SIJqICwhfws2C7j2fN+0D2AjRCBgj9inYbOnOBAK/Qz1FVUEqi6oaVO8PxqqnJlgg8LM8Y8d0+AIEsyalRXVZU0F2Gy97uT4vevDIBVi5j/NfIeKMMhDN18TECPlYqOffTYXBv3MSZbiBLiUb0t8a2x/F+F0o9duFsv3Bba5jU3P/eCMu0urIQ92J8L5Y8P7xdxBxTzssWPfLyGm5rbYevrNDbZfWGsya5ZTKeUyProvNHe8vv0wzJzxuWCyAfdX6GcXquA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTD4GnO9x4orFNDZ+fmMEJ2vArsQe2+vsrD/ec4BsUs=;
 b=6HOELQXB7cKD9kGYipwHzQbfXiDg1RxziCpKoDq9fLZAl5bumn3oXmL4U0oc6LRBG/oajcvAlE7GQiY+v5goa8zLVGT4knG4j2eSg4gHad8CnQ59UDVAkIG0KKuSRcKf4qjMNp33UfoOkT2cNXo1YThqva7kSeOWhXo3TEP5UDA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 MW6PR01MB8414.prod.exchangelabs.com (2603:10b6:303:23d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.17; Fri, 13 Sep 2024 21:21:12 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%4]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 21:21:12 +0000
Message-ID: <a3f91c94-e829-4942-abde-193462769cba@amperemail.onmicrosoft.com>
Date: Fri, 13 Sep 2024 17:21:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] mctp pcc: Check before sending MCTP PCC response
 ACK
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 admiyo@os.amperecomputing.com
Cc: Sudeep Holla <sudeep.holla@arm.com>, Jassi Brar
 <jassisinghbrar@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Huisong Li <lihuisong@huawei.com>
References: <20240712023626.1010559-1-admiyo@os.amperecomputing.com>
 <20240712023626.1010559-2-admiyo@os.amperecomputing.com>
 <20240801124126.00007a57@Huawei.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20240801124126.00007a57@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0290.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::25) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|MW6PR01MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: d1163ad1-0e74-440a-72d8-08dcd439fdec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3FiRWkyZzl2ZERGVVNJY3BiSmlGTGdidEtZQ2dvaVh2MFM1dFJ6NGlqajZw?=
 =?utf-8?B?d2RTdFN1OS8wa3BOWFF5YW91MGFjb1gxZnhsWGhDQVRZV0ppODdVOVo0eDU5?=
 =?utf-8?B?Mm1PaFBYNzVVd1F6c0VITUd3T2M3QVNMT3pEbEs5cGhMVG1PVHE5SCtMWkhm?=
 =?utf-8?B?MmM4a203WW9xdlgvZlJSblF6QkVhcW5QWVJKYXFTY0ZVOC9tUnBhdVM2dkRK?=
 =?utf-8?B?aFJoSStWZ1JHclRyeDhUMTFIRExMQmJPaDdhdlJlUm03emVtTnRxaWh1b2w2?=
 =?utf-8?B?RWlkbVF3UjBpNVJIbFVueTJmbnNtZmRWSGE2K1dvcDdMZXIvajU4MG90eGJ0?=
 =?utf-8?B?T2VKQ2x4WDN6VjZ3Y1VtT1ZuRVJxby9UUGt4Q1BTWE52MlE0eVY2OFZQL25t?=
 =?utf-8?B?S0d6QVRvbjM1MjhRTzNyZ1ZQUnZFSjR1aHdqZTdtS1R0SmNnVTY0S01FdUM0?=
 =?utf-8?B?YjhkQ1d1ci9LeW5lTkY0QnJ5dEZoWGFRbU1VS1A4ZGZqblFmMU83MThlbXJa?=
 =?utf-8?B?cHZYTWFBRzQzU2EwV2NWam5DTFNjUWRtV0lZcjRTU1VhY3NuTXdodmkzZERt?=
 =?utf-8?B?ZStpNjVXNC9OZlphcEkxMTlKaGZtNWx5dVFLMThVeGNTSUh1cDhGcFBMS1dF?=
 =?utf-8?B?cUVFRGhZQzVIM2dpUmFFeFJrZ055Tk5JM2tIVDhBV3l5Zjg3SDZaanZTTlRy?=
 =?utf-8?B?NkZaRGJEeFNwUEprSkpMNzVzdlA1bjB3d25GSFpkUlIrOTZldkFBbC9PS0lv?=
 =?utf-8?B?aEN5N0J1YzZrZ2tyYllWWEt5R0ppNmRFSy93OTBlZWFVb1c0TzZUaGM5eUpH?=
 =?utf-8?B?RXFvTXJSZkh3WFV6ald6VUpXZTQ3WmFqNFdBTEJ3OUZ0WnNienk1WVhpeFlW?=
 =?utf-8?B?UHFKa1ZtT1hmVW4zNUxzUEVJTVgvWXdjM0NpT2JMWXFVbndLQ3ZxR0ZjRzVU?=
 =?utf-8?B?ZnRMdCthcG1jLzE3RklBeEg4bERBckI3QXd1bzJadWExTnpGOEw1ZFR2RDJ3?=
 =?utf-8?B?bGpNMHRLMkR5QmZIdmdGVjl2ZFZEc2dRaDNSTEJLZkR4ZTBqWE5lK25TUy9a?=
 =?utf-8?B?bWtEUzhUZGtqRllqSmJ5Um01S1FlR281VTVZUlRaNCtVcjdDZ3Z1M1RkSnFT?=
 =?utf-8?B?SVcrL0txWTZqckVFZWlIQWtHRi90MEs0NUVHQmd0TmdRTUhxY21zbHlFaE5X?=
 =?utf-8?B?bTZQR05ualIwamZrTVRDL1gwR2NhWU9vc2MyVE9yUkU4akY4WlROTnFENGJQ?=
 =?utf-8?B?dmNvbHBCSS8xTG95T0VSdWVWYUpQRDZZU3BpOHNlek9CUERZWFpUWFRmanZj?=
 =?utf-8?B?VGJIbHBqbi9sVE9MRk8yY1VlUno5T3pWcDdiR25QYXNpaFRjWVF3RWl6Q0c3?=
 =?utf-8?B?Y2VWMHovMi9FUWtNL0JSbG9pYkRERVhPYjMvQnB2RmNMZVNudjh2WlBXN1RB?=
 =?utf-8?B?ZmJBWU8wQzJURERUanZsTWY5cFlHUWtQRjZoZWx1eHhkMThjeHBJT1B1LzR0?=
 =?utf-8?B?bUdPdWcyczVPOUlnWUpxRXA2MVFuRU9GbzhJdjRUcVFPRzZLMmdRUG9LMDdE?=
 =?utf-8?B?NVRIem85OVFtN0UyTFhRUGFwV1oyVDhsNjMraHR1dlBock1aL0VwMWNCQjBB?=
 =?utf-8?B?WlZWMTZ4a05Qck1acnh0cktadjFVbk05eVFzeVJrNjhFMHFQOE9jRzBpQ3ZT?=
 =?utf-8?B?c0lkaHZyZUc1cW5aL2RPNGtGVWVQUjlwZWtHRG0vRXdud1FiS3hZclNwWHp0?=
 =?utf-8?B?dzF4QlJreXNiZVBxRkkwOVVZTlljT3BKRVJTd3RkQWhlV29RMlU0cXVteEFQ?=
 =?utf-8?B?ZzlLbXExaG55QXpUZGN1UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWwxM2RpLzl3a2hHdmo4Q0Z4amlmWDBLck5sWlRDUUFIOUROdEt5dGNJWm42?=
 =?utf-8?B?SUp2enhzVVhYaU5sSy9reW90OEl0VW5XcVZnMCswdTVYWk5uYXZ2eWRuWGhB?=
 =?utf-8?B?dnd3R1grbGNjWjFONEZDaU1lTkMzdnA2amtHUXhiUzM5WUVLRUxnTFZWakNw?=
 =?utf-8?B?bWc4bFM2Z0FVYi9CNkg1ZHVFZkpoRVB2M0VnTGo4WjdmSkFFU0REQUZCdUlx?=
 =?utf-8?B?YWFYeUZ0cmE5RE8vZU9QUXlQbEZ3dUlmVnVCQTZxc01nQ1M0RFJ2U3I1UE9i?=
 =?utf-8?B?amNlYWU2TU9EQzR3aU5nZWdWc09ZOGcreFB2dmo0MG5hckJyQ1BWaHJ4bE0z?=
 =?utf-8?B?Mk5oWDFuYTlxVnRVSkdodys5VGg0SE0yMnZEKzBqTGJldEUwVER4VDZDdnlV?=
 =?utf-8?B?K0FhU0xkZWhNbm0zbm5aSGg2U0lPYWRXdmwrVnI4OURvcW5SMXhyQUJWYWNW?=
 =?utf-8?B?Ulc0TEdlVXBwc3FtWWs0TWxLRCs4WWlUcTFxRkpHUURVZlZxZ09LaHhaRlRC?=
 =?utf-8?B?eEtQU1hHTDN4QXUvT2M2bFNRYVJIWGFwclpkSXJ6cmZBNkE0RUJKSG1ZYXRV?=
 =?utf-8?B?QVVRU3Z3VVVzL2xMcXZxN2xIK3pRa0ZiRkMrcE9LeUpqWHpDb1pmcDZBbGlq?=
 =?utf-8?B?RGdhVlppVE81Z3R2RGZHeERraklUYjkxZGxnNlRCL284QnVaalp1MUMxQkVo?=
 =?utf-8?B?b2lSWWljT1FYNTN3bis4Ykd0aDhGMXZkNyswMUF3cG8zQTYwWUVIb0JIVStL?=
 =?utf-8?B?cEUvT2FnY0JaWGdKRXFWNHFPWjdJV2RZa3lEVUMwaWFwcnRFby9JRmNLRmZN?=
 =?utf-8?B?cFBnM1VpQlhGYWd2S1crKzlJV2huRmdOanVJcEdieXBKRkpySmk2WjhIWGpD?=
 =?utf-8?B?Y29jOVBQaFBFOVliQnh1YzVKUjFZYmpDbUw5WE5xcHRWOThidm5ydU5MNnVX?=
 =?utf-8?B?NVZEMlZ6L21NaXZLcnpmbUFDWGVCaTJmWTk1U0NwTG1LRHg3RytqM1l4U1V0?=
 =?utf-8?B?RmNPOVh5bmtwNGhzeFdCb0JWS21ZK1liK1hXelZGUk9CTjJSSHFhZjI1VEFM?=
 =?utf-8?B?YXJMa2dSRXA2cEJjWjlSKy9wd3lrb0ZOSWxlTVArZlU2QVllZzlVeU5UaDli?=
 =?utf-8?B?ZFFUTStYUFQ0NTBJL0pVdHdkRExuRVZLZDllNVpSTi9tZGxFZlg1UVZFR2du?=
 =?utf-8?B?bTFPWG1mKzVoQTJ1Q2loZnRBYlJ1M3JkTlFDRUxaZm44b0ZmN0l4UFZvSTFT?=
 =?utf-8?B?Q0xCeXVGa3ZNVE8zNVdmSEZ4Kzc5MXFwbjlBMEM3WlBOb0txNzNFZzlRQjhF?=
 =?utf-8?B?cjBCWHBEQzY5a2YxVGowQlFCejdlMmllUFlBaXhkUi9PU2NtYTF0eGZDbkVq?=
 =?utf-8?B?Qkk4ZXNuL0tjUmZSMHhMbUtZSElvM2t5aVMwQytZSGZOVXdOWGdZTGNTUjVl?=
 =?utf-8?B?c1JlNWhuYytoMy83YW5ua1F2SzNTRTNHMFR5ZzBwYTZsUWQ4Yml3YXQxSzFM?=
 =?utf-8?B?RGNQS2ZGRy9WN0k4Zkpzcm56ZVE0RGVVdnd2N0pjWXQ0NmZwc0taYVpyczF3?=
 =?utf-8?B?WHQ0VXhjamNUMVpKbDdGWFhpTnhpRWdRU2RWUnFjblJMUit4bFQzemFwNzJp?=
 =?utf-8?B?UXZrU2dNYXJlWWtVbjFyTXl3YkVGMWM5ZEsxT3lnTVBWUStIa1VCYVVhcGdT?=
 =?utf-8?B?eGVyeHF3SHEyNVdid0hCSGFUUjBGNkdzTE5MNkhROEdGWXNRS2wwRDJJZlRE?=
 =?utf-8?B?WGJwWnhoei83WjlDc08vU1MvK3czQjdSaWRqbmVwa0FMZWQyMEp6VWI4M0dT?=
 =?utf-8?B?TkRrcUpQNkNGV3FsdC9jRWFNdFRMNkFEblM3UVVlUGRoTWJzcWgzcHNZTm1J?=
 =?utf-8?B?akdiVlZPZkJkYmE4QmlkWXpMRlNIdXp2Ym1hTGxnVFdmaWV3SGhpT3lGSVE2?=
 =?utf-8?B?SnpEbFFrcXBjcDFDYXlTWHBGMjF0cmFQUlExRWFiTXRXZFRJeDJtOEo4Mloz?=
 =?utf-8?B?ZU9VQjU0SDNadnJHR2R5UVhmQ2RVaEl2ZkhxbmFrdFcyYjRrRUdac21HK1pC?=
 =?utf-8?B?QnYvR2lyc2lZZ216M3B0RjNxeHVLeEZTZlRiRklWbS9qZ3dsaTRIczBrMjBD?=
 =?utf-8?B?U3Y2ekhabE1kVUo2eWFaTTJ3ZVpkbHphVm8vV0ZSYnp5THFNRE1WS0NnRzI5?=
 =?utf-8?B?aDRxaUZ5QUZGOGNCTnQwalVWRm9Nci9heHVQZ3hpenZsOXlWUGZrZEZDN3pq?=
 =?utf-8?Q?SWzV8qftn/AcNv1IJ6f/vXYn3/ruCLeOnk8mIS9UP8=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1163ad1-0e74-440a-72d8-08dcd439fdec
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 21:21:12.2055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBkSF49J5C5XBIuWo8TLG642XGji6Hhjag1bb/3QT1hI+a+5WYwVsUq5AcsUm5awigRgp0soHaiBwpw1Yww6xtaWp6EbkBfCKvTYwjjxsmgiXNFHBEZevlNUDOBnJND0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8414

>>+ * @shmem_base_addr: the virtual memory address of the shared buffer

>If you are only going to map this from this pointer for the
>initiator/responder shared memory region, maybe it would benefit
>from a more specific name?


I am not certain what would be more correct.


On 8/1/24 07:41, Jonathan Cameron wrote:

>> +	pchan->shmem_base_addr = devm_ioremap(chan->mbox->dev,
>> +					      pchan->chan.shmem_base_addr,
>> +					      pchan->chan.shmem_size);
> devm doesn't seem appropriate here given we have manual management
> of other resources, so the ordering will be different in remove
> vs probe.
>
> So I'd handle release of this manually in mbox_free_channel()


How fixed are you on this?  mbox_free_channel is the parent code, and 
knows nothing about this resource.  It does no specific resource cleanup.

The only place we could release it is in the pcc_mbox_free, but that is 
essentially a call to the parent function.

All other comments should be addressed in the next version.



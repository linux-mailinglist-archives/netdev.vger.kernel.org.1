Return-Path: <netdev+bounces-245437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD86CCD64A
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 20:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F88B3016BA6
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 19:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F1A19005E;
	Thu, 18 Dec 2025 19:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="rk4qDMjx"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023133.outbound.protection.outlook.com [40.93.201.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB77474C14;
	Thu, 18 Dec 2025 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766086281; cv=fail; b=pS4LkaWHWD37x3J1JQBPsLbIK9NGEZOxwwaaej7ER4QlBAW6KYcf6dCQ5XQ237kk4K5AbMl6dD47P0YuKvbng5BzRfP09AW2OUdumXelLnyfxNk77K9v5uVJ2gAB9Hqnl4tVWwaOd1tpHZM5d16vBIppnozP5OIloBaoeG9bFM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766086281; c=relaxed/simple;
	bh=oJb6NF5kfM1+sUHNQs6aiTS1gY1Dmwy7W12zKyC9MuU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dT+adZ3s0BTDvmU2+7g6oO20CrKzzEbaxoIsLut1YavCSRbawFtmwHZGQDyAn8ArfJgwb3ByG/hRUerpB5Wu6fl/5iRieDFZIbfPEYCDolX0Uw5Ga6goK3rJpgnAEoRXJ9Xc9h+JvIyfwhhzH/d1lm8whNBATxW/BRllMq0Nrhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=rk4qDMjx reason="key not found in DNS"; arc=fail smtp.client-ip=40.93.201.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cz+hMYzP/BS9zjSgxR7OUqLugbc110jSxK6dKsLv7CmZoGVhC5VRn7jfJ7weOkZSVKtf28uQ04W1jWYNklFom/KMbe4fi8++YJPdec28eQTR/IdScNIPFr1OVbHyJg9t950WuYQTg10skEMyYXxuhxppq69z1IakQ2NAryvdS/5kMuH9gE8GYZF/SIhGRmusyR+q6e09X7Yh0pEj7L1MwfrQWj3SI9SHk+melx1VaVTgDYtyvqfota+NQYVNb5EBdJ/7FM+PfwjeSJNI6AAYnPVYMeowdpVhWGJT07OEJQHup8P/plTbdy8LINsrj159R+MY3/yyWG6wix/2uzAZ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZVdUdTs1ToAzSH9YZBCeD0EWgVVyKOrNPcvAA/y8lg=;
 b=aMbJ35YoH1FbW+wGI42idJDx5JAW6TZVZPLz9K05mENYElwPHLRw+hpGrqMWpQxfsEFBloQMCnjp4jDNNlPQ+QvrKRVtRAB2TXWQaNQXXRY4pMAbPHKtbO6dCcl6UNpGxPEK3y7cy8M1uWN/2hzcDi79dIYOK5tL+fE4kcu8QiUaXBTW+1kjbB065WM5/0FHMns2kdxBHea/DCJQDZcsxT8jfjxTuNQBFoU/Kc360hPJSEZ7x4IPu+cNPcKrVRDYpJrce2NUMhsLGSueemDvukvGH6cs2cwBGkEJXpBj1xM9yzOhRVstGAHSR8xrA/VczcxZCDEFitIBcOuuvKFrfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZVdUdTs1ToAzSH9YZBCeD0EWgVVyKOrNPcvAA/y8lg=;
 b=rk4qDMjxBKxMGqD24dmOppu6qLJjfoAEj644hy5hOutEEAZOnnTWNSF9BrxWmmzl8Upcs4HdnMK5DkGs9raYKzH7w+KrBm7oflMrdntKFKzCqZmYz723Bh4inHZe64u7MF/4RM8VK5QaBYJFbAXv3hSDQ49YXAPiqgG1icI+2v8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 PH0PR01MB6263.prod.exchangelabs.com (2603:10b6:510:13::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Thu, 18 Dec 2025 19:31:16 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%5]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 19:31:15 +0000
Message-ID: <fc6aa01e-d35e-449d-a752-00f91491f16a@amperemail.onmicrosoft.com>
Date: Thu, 18 Dec 2025 14:31:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v30 2/3] mailbox: pcc: functions for reading and writing
 PCC extended data
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Adam Young <admiyo@os.amperecomputing.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Robert Moore <robert.moore@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20251016210225.612639-1-admiyo@os.amperecomputing.com>
 <20251016210225.612639-3-admiyo@os.amperecomputing.com>
 <20251020-honored-cat-of-elevation-59b6c4@sudeepholla>
 <78c30517-4b16-4929-b10b-917da68ff01c@amperemail.onmicrosoft.com>
 <aPeSfQ_Vd0bjW-iS@bogus>
 <3ae91e09-2f52-4ca4-b459-3b765a3cad0c@amperemail.onmicrosoft.com>
 <20251024-resilient-sawfly-of-joy-33dcdc@sudeepholla>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20251024-resilient-sawfly-of-joy-33dcdc@sudeepholla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR15CA0042.namprd15.prod.outlook.com
 (2603:10b6:930:1b::26) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|PH0PR01MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 38d42a20-b894-4ee5-79e1-08de3e6c02a8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkdOdEQ1TkFvSXNzZjhLYjVBRnBCSmxmZ2hYLzdnbHEwNHZaS1kyeVJLc2g1?=
 =?utf-8?B?VEdnd3VSSTFOUFVZKzBra3UzWlR5RFdzNkRLSHZWczJjNlduUGRUWnJiT2xP?=
 =?utf-8?B?cDJvYlhiaERQUUJ5V0ZHMmVDbU1hQjVWREtwTHhZRGljdWM2RWNqMm5vb0tP?=
 =?utf-8?B?RTA0YWlCNmZ1WHF4Q0dIS2g2UGJaZ0tvWisxclZZVTYvMVg3OHRJUXBtdXM1?=
 =?utf-8?B?NFlFL2J0WUZnVG5TQndkZUZSeTdabnBQNVY5OXcwWmNyWHRjb2JoMGhodHQv?=
 =?utf-8?B?SFFCblovUWpVYTlFNkQ2dHZHZzFaYzE5anpXTjhxNytFRUwxKzVZQnRMZVdy?=
 =?utf-8?B?dnBOR044MXhhQXI4bGxKNXZNWndFZ3lidUtmdTd5Y1ZaaG00Q0w1eTFpaWcw?=
 =?utf-8?B?Y2IrQ0IrSy9DZldIbll5bGgvWm5ZbEdDdFpGMVNWN0xha2YwNlh4bHdJK3Uw?=
 =?utf-8?B?dlE1WWxwK0FJQmpCL1J2ZWVFOUU0ZW82TUFjOFJ5dUl1bHQzamE2MHhLelJw?=
 =?utf-8?B?Wk81N2FMei9sbVlOeVQvczBLQkJPMlN4eWY1WGZNcWlnb2JYSnI2VkMvNlFE?=
 =?utf-8?B?aWg3c3NNeG9ZRjlGYWxvYlRwL2RHRm0xbFdZMTJqWUQ2U29jcXN6b083QTBk?=
 =?utf-8?B?YWpRTlR1bDJ5d1JXbEROU0wzV0YzTUcybDZTQ3Q1QW14dTdPWVQ2VnV0Y0g3?=
 =?utf-8?B?dXNtUk9Ga2pWRytWNWtsRTUwa1FlMVhKNXBkSG41ZEVPNUZveVRraWJjUUdj?=
 =?utf-8?B?R2NHa0F2VVl0aEVXWDh6WEErZDN4SkhrMTBYd1lwUHUzNWVRSmZ3T1BEME5v?=
 =?utf-8?B?QVViOVBHc2pBdDdJNVo4RkZPL29BRVE2Z1dCV1FUWlNNYTF2TVQ3SUpNVHZL?=
 =?utf-8?B?Ui84SXR2dXdZcUVKdElKeVBvTS9XQ3QxMUo2N1luYk50dlVvY0RWb2dvM0s1?=
 =?utf-8?B?TDRrcXVrdmdBQ3BaRmU5eWpxbzVMcWlhTy9EaytiZUU0Q2ZzeDJ5N1QyV1VP?=
 =?utf-8?B?cGt3SWRNbzNjb1JxY0ZFMTB2QXhEZGxvMVVySkRyTlpuTXFXMlpCSXo3ME9B?=
 =?utf-8?B?eGdQSkYzNzBWd29xc2dyVkowVTgzbTJnVFk3SC82NGFWbHk1bk5CT3VzWUhs?=
 =?utf-8?B?eXg1amxkbzhUOWQwd3RHQTZtTlFCLytPQzE5ekFLcmpCbTZzM2ZNMU5Sdlk2?=
 =?utf-8?B?WlAwU05qMXYrZFBBUzZGazdZeno5UlArNDgzMXFkZnAvOTR3WFR0RkpGM1Rk?=
 =?utf-8?B?SVdWWEdiVmp0NnVTZ1NzK2VzVkVWQmcycndRZC9xcWdaam5aajVnSStteHJF?=
 =?utf-8?B?MVVNNXk1Sk0xeHRkSGhLdWlxMHZ4MTBtTkV6ajF0cFdjbTg2dmM2L25hY25R?=
 =?utf-8?B?Ly95Tmxvd1VKZ2FJME82RUs0QkFYVjZCWnU5bHJaOC9JeFNCWXk4Q2pqNHN2?=
 =?utf-8?B?amo3dnNtQmNWakVKZndSWkZWQytyQ3M0ZkswdlpaSERFNTAzcTJLQy93T1I0?=
 =?utf-8?B?QlI1a29PM0ZVdUFVb1QzelpzZDcvUjlaM1poS3doUWdqWEpqajR5aTBzZUg0?=
 =?utf-8?B?ZG1FREIxZitPWmFDMi8rc1lEb3Uwa25tcWVLTzJSbEZLV1I2Z1ZGSk5aU0pn?=
 =?utf-8?B?VC85dEdYRkNjdkcyL3hEZHp2dUdFM292eDVhOFNyNDJzY0ttK29lWjZUUnlI?=
 =?utf-8?B?Y0JZbmJoSzBxcWJsYWF6a3dtZDNFRHVEblk0anNvODhyQWJlK0lBVFk3azc3?=
 =?utf-8?B?eXBaZndBYUZIbDlXUEJybWo2d2prNlM3dW8yVnZGSkY1RDhSQlg1cE5wenZo?=
 =?utf-8?B?UUowaGl0YjI1WUlqQlBXTXhmeUVuWk43Vk1Jc2dQV2ZPTjZvM1hKRTQzV2c4?=
 =?utf-8?B?d01TcDVMdHFteDB0M2xQNEdDWVgrY0t3V0dXQ0VITnpZRHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXljcERyQ2srdGMwVFZUZ0pac3dtMVlLNzVwVXJoVldzN0tVVFIrc3E1dmpI?=
 =?utf-8?B?UFQvbFJYRkdqc1Z0K3R4UXptWld3R3BrRHFzYVNSOUJOdmNBbjNCd2hGekNL?=
 =?utf-8?B?UkV2QmN2VFUzczJMOUpzU21XSVdYQ1FUVWttaTV4dHl0b3VDWWNIc2J5MlJX?=
 =?utf-8?B?NTRLY2MyTi90d05hOGw5a3hhOW5tdjdKRHloM0NVRlpJVzNhd2ZUanB1U0o3?=
 =?utf-8?B?dTdUQXphY2JKK0UxMFprZjh0bEpSdzllVjRJNGpNL0tFR1Rjb0MrTitMYUFQ?=
 =?utf-8?B?eDlsN2RReWJpZ3JHTlUyT2ZLVnVwMGZMczdNWE9QU1JtVXg0aEVOV0l1c3dw?=
 =?utf-8?B?SHRWY0UvV3VvdEZPOVZuUU9adVlrMzNjWUdKUE5JZjJpaGFDejNlUUFzbjl5?=
 =?utf-8?B?ZUQ0aWNJY1pmdy9TMUdqZHNFWlYxUDQycUgzL0lCTTc0dnF2Ylo2b04vcnlm?=
 =?utf-8?B?elJ2V01ORGdURmdIcGhQOFNTZzg3MmhLMGRkQW1YcjRJcFpmT0t2elNyVGlm?=
 =?utf-8?B?RmZLb3F2NjBOaUlhd0VITGw0RU1QRTlaa2pqUWZKS1MreHp2YkxXNWxDQ2M5?=
 =?utf-8?B?STlBYnpQc2Z5TmhZLzVxU2FHS2JZTVk3QmhQdFpUTVRibWtoU0VMTDFBTnFl?=
 =?utf-8?B?Tzl3eDhoVWI4MFFHZUI2S0UxN2l6V0R0azVhZGp0d3plcUhRbVVaQ1k5eFZh?=
 =?utf-8?B?YkFwMWwydWsyN1RFRDlwdWd3Wk4vTllDR0YvZUNyK2s3VENHd0hpbWVyWCth?=
 =?utf-8?B?Y0p1YXZtVzZ3Q1VDMlZ0cE1udmY1T3AvTjdvOEIxckxTbG9UNnV5cVdxVVQr?=
 =?utf-8?B?bEZVUkZwMWJUUTVpM2wwRnRzbEpkZllWOVlpR3cvOE9OY3Q5eWFqa2FqZlRt?=
 =?utf-8?B?NWJWMW9TSnVoR2dtK3BwQ1I3WE54Qjdzb0Y3NUwzaEg1NlkwQkEzTlBWTkdl?=
 =?utf-8?B?cWY5VFdBaGZWWkhITGZxZk9ZbnltNTloSkVXbk1FRW14bGh5UXlHVlBPRlpM?=
 =?utf-8?B?U1FBQXRRbUJ5aWUxNXJIT2JabE1wak1Fa2dYREFNQUZ3Zkl1VGlUYTlaR2E2?=
 =?utf-8?B?Yjh1WEo1VG9TQVJJZEtRTkw0K01ZaXJKbnMvZWxLdUE3Ry85QU8rMnJ0TFNx?=
 =?utf-8?B?YkErc2hnQ29yTlNqQnlRSkkvRmRyRkFETG5sc3hrdTAyd2wxWHVIcnVjb1Z5?=
 =?utf-8?B?ck1mdlgrUnpDSDFOelJhVG4vci9wM3VUb3hFaUlkbjBVVC84N2h0TTVBbXo2?=
 =?utf-8?B?SThMejFkWkNTNDVZY3RId3N5a1FQemRrblpaMTdmQlZxcTkvN0JqWE9pemhm?=
 =?utf-8?B?MEZscVFCek1BRHdkMXNhWFpMUVNBSy9wNjBsODcwaUhNeVdndmZNckxWYXNV?=
 =?utf-8?B?bUpER0kwMVg5OU5iOTJiMkJWdXBSWUF1YjJ2eXV6ZEptVXAwcjZ4anFGWEdC?=
 =?utf-8?B?dFVNUHJUdHVaUi9Qc0g3WHhwYklqMk91cHhhRWxGYTZ0OWlEM3hUb09Jb0Uw?=
 =?utf-8?B?N3lyQ2JVOTJveTJwcEdCc0sxd0JsRTZLZGRPMmZMa1dSQjFzRDk0cFpnQlZ4?=
 =?utf-8?B?UCs3UTVPVStJc3UyR2tVVWVScEh1QWVxT1Bva08yMm1zcDdBenczVnN6ZUdW?=
 =?utf-8?B?dzlST1E3STNDWDZkM3doT0NNNnFCdVVyTFkwWm12d1JxalYwTzZOOVFnZnZ1?=
 =?utf-8?B?UHd4T0V2eHZLRXRhdW9RaFFQaTBpa0I0NGRtWUpNVUhPNE9mSjZxNUhRYWdD?=
 =?utf-8?B?Um5PYmhrdVVZa3VvRTd4dmVudnlic0JZSHh1R2EyOGZKRUdNWVNDRVRrOGpp?=
 =?utf-8?B?K1dSK3EwazJoTjZsME1yaktoR2tXYkNmSkFwUUIrZnRiVlRUU0s5MWhRUGEw?=
 =?utf-8?B?R3BSMStGOU5GQXVtYWZZQmlXSEtQTG1SbklxWEQvQnZ6bXhHTStUSC9SRWVI?=
 =?utf-8?B?TUEyTnR5Wmk1OVBWVHZMRDlUZDc4L294Q3g0dkg5YkxOL3BSeFNWYU5VZW9v?=
 =?utf-8?B?bkRDMzFCNTRXbW5OaHdpcndKb0pzOXVZZzIydEpsb0tSZXRDcU16QjZJWm16?=
 =?utf-8?B?Tm9aMCtNRHJQay9vbDE1dVBUVlEwdmo2QWMrOGNIRUxsMk0waVMwSjVQM3Uv?=
 =?utf-8?B?b1djZndHNlA2Mlh1d0YyaS85QUJqWTQ1Vjd1em01UTZZYmJLYmR2VDlrdHgy?=
 =?utf-8?B?QjYwdlJ6QzNmQXJ5OG1ZUjlKUzFURTdkcTFTejkzVjR4QU0wb2k0T0lKVVZz?=
 =?utf-8?Q?4ydCGtJ6mHn/bHVAUG7nVkYrGdGLGhMA8M/n3Q7CmI=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d42a20-b894-4ee5-79e1-08de3e6c02a8
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 19:31:15.7902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtbCiKxA5s4GyMq6KlN4Dmvv1DtA6KSFG/7mZBuD3t6gDQluIBQiQ38kk4kpXRtFNnyd0De8EZ+mfetsqSKF+J94JiCnYdiwqyB74YaQR27QSJPQ7KGYFixrX2cCSqXf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6263


On 10/24/25 09:50, Sudeep Holla wrote:
> On Tue, Oct 21, 2025 at 01:20:50PM -0400, Adam Young wrote:
>
> [...]
>
>>>> Because the PCC spec is wonky.
>>>> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html#extended-pcc-subspace-shared-memory-region
>>>>
>>>> "Length of payload being transmitted including command field."  Thus in
>>>> order to copy all of the data, including  the PCC header, I need to drop the
>>>> length (- sizeof(u32) ) and then add the entire header. Having all the PCC
>>>> data in the buffer allows us to see it in networking tools. It is also
>>>> parallel with how the messages are sent, where the PCC header is written by
>>>> the driver and then the whole message is mem-copies in one io/read or write.
>>>>
>>> No you have misread this part.
>>> Communication subspace(only part and last entry in shared memory at offset of
>>> 16 bytes) - "Memory region for reading/writing PCC data. The maximum size of
>>> this region is 16 bytes smaller than the size of the shared memory region
>>> (specified in the Master slave Communications Subspace structure). When a
>>> command is sent to or received from the platform, the size of the data in
>>> this space will be Length (expressed above) minus the 4 bytes taken up by
>>> the command."
>>>
>>> The keyword is "this space/region" which refers to only the communication
>>> subspace which is at offset 16 bytes in the shmem.
>>>
>>> It should be just length - sizeof(command) i.e. length - 4
>>
>> I just want to make sure I have this correct.  I want to copy the entire PCC
>> buffer, not just the payload, into the sk_buff.  If I wanted the payload, I
>> would use the length field.  However, I want the PCC header as well, which
>> is the length field, plus sizeof (header).  But that double counts the
>> command field, which is part of the header, and thus I subtract this out.  I
>> think my math is correct. What you wrote would be for the case where I want
>> only the PCC payload.
>>
> Why ? How does sk_buff interpret that as PCC header. Something doesn't align
> well here or I might be missing something.
>
> I started writing some helpers and this comment made me to rethink my
> approach. I don't have any to share and I will be away for a while. I will
> try to review any further changes from you but expect delays.

The sk_buff and socket api allows you to specify the various levels of 
headers for a nested protocol.  Just like udp inside IP inside Ethernet 
is a thing, the packets here are mctp inside pcc. The the networking 
stack can look into the packet and pull out the MCTP information when 
routing the packet is routed to the link device.

Since the mctp over pcc driver is PCC specific, I want to be able to see 
the PCC header in a tool like wireshark.  If we only return the MCTP 
portion, we will lose some tracing information. Admittedly, not a lot.

This is fairly well tested in my code base:  I can send and receive MCTP 
messages through the Linux kernel network stack.

The header has the flags, length, and command blocks.  I think we agree 
that PCC mailbox should not hardcode  the command.  The question, then 
is if the PCC layer should be responsible for the signature and header.  
The alternative is that the read/write functions will handle the PCC 
header information.  I think the only real drawback to this would be if 
the driver wanted to be able to set the flags.  For now the only flag 
that is defined is PCC_CMD_COMPLETION_NOTIFY, but this is a driver 
specific decision, and needs  to be accounted for.

So I would like to keep the signatures of the read/write functions as 
is.  We can inline them if you think that there is benefit to it:  as I 
see it, it exposes more internals but reduces the number of external 
symbols for the PCC Mailbox.  This is your call as the maintainer, and I 
can make it work either way.  I would like to submit an updated driver.











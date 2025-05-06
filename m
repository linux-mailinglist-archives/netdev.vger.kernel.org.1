Return-Path: <netdev+bounces-188383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B41AAC9A8
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 17:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46CB43A5EFE
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 15:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8D9C8FE;
	Tue,  6 May 2025 15:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dhx0IeeI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0612B283C91
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 15:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746545673; cv=fail; b=bS08XEtkGi953rd+Omo+UeAPwvcwsoyhZxWfaHyH9UgOFlIvhhNFW+v32ErTDyFMTtewdSeBrJaXVgFNHYKseykJi0Fxr6MJb9fsp6ofOFR9LSQxGLmIWWS/dAvYcfj2O8E6iB+NneEscN1SAjSvFB8dRFhtOZ+f9VgelCf0lkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746545673; c=relaxed/simple;
	bh=frBZYVVJ6Arcn3rurRicLDIz62mVTu10eefvHsXrULs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=um0X+DggE+rKpiok4bOtMN79ep9ax8C+GRL6bsuqOzYwXmZ5xV/sdaUSScc2Tt07XJX7y3oNDOY5kbSHBiDF3IOz3W3mQbE6D3NS7QLb5BifU45URDGfAUyv/tjfw5PXjwk3XHzxzjsQEIvaUROuIE6CA8Tnrrsw6YkunUPiwoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dhx0IeeI; arc=fail smtp.client-ip=40.107.212.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYs6ShCO4sKlgil4vDGWSgR/gkz3SegBejGI/2BiKnL0Pbe2X4tJZRVK3Q/WV35aOKlS8kgymMikFfZhwaXTt6LKj+1ARXBfcuKbz3BT98P9xxQfscFGSNGzJTy6AaRMI2SBCb3wV3Vw9fIj5mviTHNnuuil6fd8+J6qSG9bgdTVUDb+V6zNG9HDbzBv2PBBQu4vHy/RrbLVvU/XC4T/s9RB1Z+6DjTnBuRQU3dILHwngjO+xkJWFgmrrAGJhAhiFf4Gsn5+BcvfYHQonB9CusYvR+0i/00pVpSZH+iKKwo9SlX8zOVEsQcPozKp5Uclbw41qtBxaxFNwijcaUp9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omB6kaFmWtdKURmm0/gJGXrLuoBuxk9eQSQ+iUZFhqM=;
 b=qt3kThfgBluwezoH0Op5ksnFsVShrsdH9K/9AYZ4eK8E29sSGpj9T2jN1RvDHvkwejAKbPsGqCOw7TbfmT7WfmilWm49qURsxv1pKZQ+jaA+OZB3yPhxViyDP6HZ3Y602GCJvzk864dPxpl8KUF0cqkRXQaA2FLgD8x+scWNo/aZqpShzma1BXAAf0gmIIoR3fzM/97x76A4v52pdAPTCLqZ7ar11v2rWiJ26DTmu3OJSOy5OMl2//z14SFq7Y5gK0uEJG3Xoh+i1dCsCgp0vwF09pZFD0PTWxFtjR9dt99ssdbdJH8+vt4S4DmvO0VHNH82PoB1NESyX3R48zdcZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omB6kaFmWtdKURmm0/gJGXrLuoBuxk9eQSQ+iUZFhqM=;
 b=dhx0IeeIPqAdEGGKaY3Vaws1w5ckVl3FcPo3xhWNmSoPCWrlsNjTGQFTUf/uqLZCkrZr5VGvte+fKk7veOuflD2L+TpB3teHVoJv2wFX22CU/i5ilSa8m/6ugi7MxCuIq9NLOxVZVW4m4ImR3wt+3A0S4QbYbLjrgI9Jxo0GKFcqPZohm8yq8pHCQ/WX78ZWW5UpMtmDPLgPe2OAvcwJnimFhI2qB8iOsrmToR7pH1Vp9wpP6jJe+nc9ZwGwnks0mw/8kj0msOYBy6Hag3Bcl4ZOag5E6ovwHlnwh/KKOoCv4bLCvFoVSFFtx4XT8hBnYJLjfLz6dIkvOKl69FUiAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 6 May
 2025 15:34:24 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%3]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 15:34:24 +0000
Message-ID: <aa57da6b-bb1b-4d77-bffa-9746c3fe94ba@nvidia.com>
Date: Tue, 6 May 2025 18:34:22 +0300
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
 <c19e7dec-7aae-449d-b454-4078c8fbd926@nvidia.com>
 <20250506082032.1ab8f397@kernel.org>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20250506082032.1ab8f397@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0208.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::18) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|PH7PR12MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: b1c9d977-7f50-4c62-429c-08dd8cb37abb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qmh2YnFMTVJ2T3RVS2lvOUlEbjUxcjdxdTYxbzRFUnZKTmFtOFZrRFNDd1Yx?=
 =?utf-8?B?OXRtQjJuVW4wQjN0L1YxUUZhVXVVSjJLZXVUdVNJWDZaUGFlc3dWZDh2Ym4v?=
 =?utf-8?B?bXdVc20rNTZLdHRoRVAxZHhnWExBVlFGNk16WWs1Mk8xOTZWN08vc3dZeVVl?=
 =?utf-8?B?WG9XdTdSMkhNMzlrbkZvS2YybTIzVFJrSFJvNjRSYlBCeWZiYVZWaHFvbnFP?=
 =?utf-8?B?R29ySUNmWC9DOVAyQ1VpYTg4QmFQcnlEa0NJclVIWmZRdkRlbFZVN281QXRJ?=
 =?utf-8?B?RmUweHlzNCt2bUtwV0Nsc0JWdnUrcW1CVWpkN1BwNk1UTjJNR25uWlB4aW9B?=
 =?utf-8?B?Mzlyd3QzL2ZOOWdHVGFMSExtRHRpbVZKNlQxbUt6Ui9lVWdtZkZRYnBjczNC?=
 =?utf-8?B?dlYvZzBxMG8xdXlNUHppMTlGT1doYTNsOGdHNkp1aGJGMHExRGN0OXJkMkYw?=
 =?utf-8?B?bWJyTktGOUlZZTN6bmhTL1cvLzUxc1hWd09PNDEvcExmZHNlMlU4UkpRZjFJ?=
 =?utf-8?B?YmJiZWlEcW9UR3o0OVlWOE9pb0dLQmtLTks0L2IwaS83OVhUUTdWUStLb2g4?=
 =?utf-8?B?dEJqa1lSMlBkSDA0dm4xLzZaZmVkRjZKKzhNRi95aERJZ0FNNjBNSHdvYlZF?=
 =?utf-8?B?V0NtZXNxNEdpaXYvc1Zxd3FPVWp2MkEyOGpoZ1FDY2V2ZmpXQmFVbHdxTk1R?=
 =?utf-8?B?bG9rbWY2cFF3dS80WGRuZjM5cis5Vkc2NnNSS1hwTlNMaTMyOG9uRi8wMzNU?=
 =?utf-8?B?aUpMNkhZcmgxYWN5RG1td2FQK0NrdmNrNzltaHVQa1J3bGNQLzcxdE9QSEJl?=
 =?utf-8?B?NFFhK0tnS1puYlhpSVk5YkdqQzBiUEQrK1RYak0rTmkzVTdpeDBMY3pVMXFz?=
 =?utf-8?B?ZDY4eWZ4VTI0c29Sd0YxYVc4TWNTOVpXUFdqMTdHT2NhNXhiQ2piZDhVM25w?=
 =?utf-8?B?VGhkT2lnWGlsK3lUeEF4TDRnbTRlbXZFS25FcXJ0SnIwZEJVSTRzRDk1anlI?=
 =?utf-8?B?SlFqcFBqU1ZKMFdvSW0vRjZjL3RtV282QlpPRE1laDdWR2ZmOWhkcHFXUERy?=
 =?utf-8?B?UEIrNm40cFRtVWlndGF6YUdxdURxczNtNDdPWHg3ZXFOaXFwZHovZWgxUWtI?=
 =?utf-8?B?TGg5SzJXQWJjOE0vTVRxMEQveEZZZUpwZ1crUHY0SDRNLzFoZGF3Z21aMCtX?=
 =?utf-8?B?M3JwMVdrWjhkdVZVYmV4WUtORkdqM29Jc2F5K3Q2VXhFQTJyVFAxRENhUWwz?=
 =?utf-8?B?R2FreEJvbEZucjBoOG45QUUvVlZDbjRpOFJQSktZa3hmLzkxM1dxc1FZNkdj?=
 =?utf-8?B?eWpsMHZLamxocWtvTmF0OTQxdlhzY3ZFL0h2dXZDM1p1UlJyWFJXVmxnM2V0?=
 =?utf-8?B?QlF5UUdrMmd4QWtxdzY0NERTc3MzaWt6MllKTVUxY0FweHduYlM5V2xGYzlY?=
 =?utf-8?B?MEFTRnVhMmpTblk1MmlUTW5MSzZ6bGN4d0dENHIzYnNmWDl4ZEF1V1BrOW5l?=
 =?utf-8?B?Y1VwUTExNDZPSzhTK1RPcGRVaXpxb3RvM0ZnSDJhbkMvbVRnS3VFdktmb3Mv?=
 =?utf-8?B?SnhZdS9mUkNtelJiSGtnbHVzVFdlWTdSQzZmcWRUdkdlZy8xMi8wc1JxLys1?=
 =?utf-8?B?eko1UE5za1V4Y2NkM1R6UmxiU0VhOFhqY2RIaExaVWdEdlB2S09obWVHbC9J?=
 =?utf-8?B?aFh0ZVF3bjNxa0lhby9UUTBGNnpXR3RnUHVzWkhFeGhhZ3dlSXBqZDA3cDMw?=
 =?utf-8?B?UUJlb1QzVFhSTm80Mk43dTFBZm9jenlRNDdhR0ROSHNEaWhjTU5obXhzMzRi?=
 =?utf-8?B?LzlSWVV0SFZJTjF2M1gzYWFVdE9HcFNKdzcxMzRVN2dUY2pndDNkRDh6NThp?=
 =?utf-8?B?S2orZ2tsVW1GZXlDNWNYZnBTSkxleU5hS1ZmbUJQTUlJK0pQNlZZN2h2Uzha?=
 =?utf-8?Q?E0rV//6BfMQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFBKSndTWHRoVEhlWnYzOTRQbVd1T3dQc2VPVGJrSEZZNzZHeVE2dkd0V2px?=
 =?utf-8?B?MWtPRVNlanRBMDJibDIxT2IvUnBpNk1uSWpXWlkrK1MzcXQrKzdLSlBESDhS?=
 =?utf-8?B?SWNzai83c2xBTlFnR01WalRFTEcxMlNSclU2ajRWaVR6SmNyNklNSmM2emVX?=
 =?utf-8?B?bjRBcGw1SEtKVTVpVTcvREZQbEFoK2xCaFhubGdYYlNEbC9lYlpwcFh0NDRk?=
 =?utf-8?B?WEFqbGYxZG51VVdBY1MxQXFFWTFseDNwSUZESkhEby9DNmNFN0RVcWNCL2xJ?=
 =?utf-8?B?VjdRS2UxK2pIQXQzRmRwNXBjSmZWSzc5NnlmVTVlZzhhRmQ5Vkl3RzEzem9G?=
 =?utf-8?B?MWFTM3NBeGlQbnh1VEJLQytLSUtpdjRQVFdtcy9jTGZTS1lQUDZoNVI5eVNr?=
 =?utf-8?B?eTZyUGVLWW5YZ1BweXE0VjhVLzUySzN5VHByMFJsWlZsUGlEd2pnUGU2bVg0?=
 =?utf-8?B?SEJyMnA4ZjNpdU1EU3hsRHBFTUgveUUvajdJQWQrMFZhZS9vQXE1RjdlaVdi?=
 =?utf-8?B?T3J0eTAxYTVKcDdFaUY4LzgrSlVXOTNGWldDR3R2blVxVU9ETitwa3k2Q3My?=
 =?utf-8?B?KzRsd3hERWxIdHp0MkpUUkhmWkQ3RXdDVXROd2NiOXlYMlVTSXo2TGRESXhv?=
 =?utf-8?B?TStSWkhaTVFqY2VOSWw0QVIwb1FnNGJnZCtxYitmTkVCY0NBeVNWWlZzaEVi?=
 =?utf-8?B?dU9FRlViU3NhKzQycDhIbVZDSC9rbXFSTzNGVEJidmE0N014VW0xdDFvTS9q?=
 =?utf-8?B?Y0FGS1BvaC9EcDlzN0k4cDJRWnYwSE91djNLcTcwc2tLT3E2T3pKaG5zQ28r?=
 =?utf-8?B?YzJrV25Na1lKK0hyanNsUis2Vjl0akxPNGtBVnVhVm9zVGNNVmJsQStaWkxO?=
 =?utf-8?B?aFY3dTNzanczdllhOUFVMi9vR3Z0cXJPQTVNZXVpUzgzL3lrakRRUlhKS0I4?=
 =?utf-8?B?UW42RjJnc1p2RkF5amwxbW5EL3B6T01rajdaOUl6UzdQZHA4ZEc3VUE1dzRr?=
 =?utf-8?B?SXNxNURJRGZhRVN2WVR4OWFlTVU2ZXQwbndLMXhJRWtabGx0WTRtK0dNalhO?=
 =?utf-8?B?ZFp4dXNCNUxuK1NxMXpoa05ET29yY1pYUDRPUEYzZTdJaTlneU05cnNIZWJE?=
 =?utf-8?B?emhianZVTWgybk4wQU51ZGtjeFBMWnljaU55Q2QycXk2SmRQU01ROHBmMG1v?=
 =?utf-8?B?aXhwRGhFU2RIaElmM0F4aGRUUytZU1FnSjIrbCtnL0ZTQUJRNjBYenZ5Nk9O?=
 =?utf-8?B?TkdzWGxVSTN0OXNpSjg5WXNabWhDV1dsWmhhZFdYVkRzQUFUaWE1Nm1IMXhX?=
 =?utf-8?B?R3V2TjRlTmpXN2pQZGQ4OHF1dXI3MzF2eDY4OGh6dEJxWTRYd29MVkhrbmJ5?=
 =?utf-8?B?MVVLMTMzTW9UUWVIM3VJSWpINmtCSFJUazk2R2ttWUJ1WXdZWDV5RElkeEZn?=
 =?utf-8?B?WFlxRm40SVI3eWt1WDJJdDQzbEgwVldQb1NRdE90K0RpOVBsbE1mNXFTL1RB?=
 =?utf-8?B?bTV4c2ZGZWg3a1IrL2RrRTZ6ejNPekI5bTM0WDhQMlVURjVITlBHRm1QemZx?=
 =?utf-8?B?ZElUWFNwN28zeW9HS3BETVllTmJSYzRwb0szb0pXSTVNT3UyYXo1aHpKSXQy?=
 =?utf-8?B?dWE3Tmdmd2hCUGtNRkFzS01JVDhHajhBcFh5QlBxNmxHYi9ud3FpanRlSXdD?=
 =?utf-8?B?VlhtUlNIem15TnJjU1JTZHpXaUJsczBOWnhkT01iRVlpM3c2UmFUaWJTTDhM?=
 =?utf-8?B?TGE4N2gyeTRjdGRBL1JzV0wzTHdBZXppaXJBZVQ1c2ovcG1uL0ZHbW01a3Vw?=
 =?utf-8?B?U25xeURoMkNKdVlPdVB6UHRwOTBHR0NvZ2trRzNKNldPMi9td3Y1ZTJHV0Za?=
 =?utf-8?B?M0dSWWU1UXVrM2ZGZEFlU29vNkVQNzVOYWJkdGxETW5TTGVDV0dDNE5MalVL?=
 =?utf-8?B?UUtDeFJMTUlQMFdrZVRKWW4yemVxektVUDV4L3B1cHk1K3VwbS9OMEIwWGZF?=
 =?utf-8?B?NFUveWdHQTd2MXZQUUFLWHZFRjlRSU9sRXMwNjBIY2VweEVJYjhzY3h2RFdH?=
 =?utf-8?B?L2dSNTdZbXk5a2Z5V0JPS2pYZVhzSEQ5RGo2cmtjVlplNXhSOHRGbllrUHZ0?=
 =?utf-8?Q?opCIoDd8GuIXtN/WalqqHVcyC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c9d977-7f50-4c62-429c-08dd8cb37abb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 15:34:24.5775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: opeW4QjjtY/euUK5qB0I/4hi7odBYxABPqHSvdqjSLjOrukux+Fls9QH3Yl/mtvn8jzjV+43gBGdlapsgfWi6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428



On 06/05/2025 18:20, Jakub Kicinski wrote:
> On Tue, 6 May 2025 14:25:10 +0300 Mark Bloch wrote:
>>> Thanks for explaining the setup. Could you please explain the user
>>> scenario now? Perhaps thinking of it as a sequence diagram would
>>> be helpful, but whatever is easiest, just make it concrete.
>>>   
>>
>> It's a rough flow, but I believe it clearly illustrates the use case
>> we're targeting:
>>  
>> Some system configuration info:
>>  
>> - A static mapping file exists that defines the relationship between
>>   a host and the corresponding ARM/DPU host that manages it.
>>  
>> - OVN, OVS and Kubernetes are used to manage network connectivity and
>>   resource allocation.
>>  
>> Flow:
>> 1. A user requests a container with networking connectivity.
>> 2. Kubernetes allocates a VF on host X. An agent on the host handles VF
>>    configuration and sends the PF number and VF index to the central
>>    management software.
> 
> What is "central management software" here? Deployment specific or
> some part of k8s?

It's the k8s API server.

> 
>> 3. An agent on the DPU side detects the changes made on host X. Using
>>    the PF number and VF index, it identifies the corresponding
>>    representor, attaches it to an OVS bridge, and allows OVN to program
>>    the relevant steering rules.
> 
> What does it mean that DPU "detects it", what's the source and 
> mechanism of the notification?
> Is it communicating with the central SW during  the process?

The agent (running in the ARM/DPU) listens for events from the k8s API server.
 
> 
>> This setup works well when the mapping file defines a one-to-one
>> relationship between a host and a single ARM/DPU host.
>> It's already supported in upstream today [1]
>>  
>> However, in a slightly more generic scenario like:
>>  
>> Control Host A: External host X
>>                 External host Y
>>  
>> A single ARM/DPU host manages multiple external hosts. In this case, step
>> 2—where only the PF number and VF index are sent is insufficient. During
>> step 3, the agent on the DPU reads the data but cannot determine which
>> external host created the VF. As a result, it cannot correctly associate
>> the representor with the appropriate OVS bridge.
>>  
>> To resolve this, we plan to modify step 2 to include the VUID along with
>> the PF number and VF index. The DPU-side agent will use the VUID to match
>> it with the FUID, identify the correct PF representor, and then use
>> standard devlink mechanisms to locate the corresponding VF representor.
>>
>> 1: https://github.com/ovn-kubernetes/ovn-kubernetes
>> You can look at: go-controller/pkg/util/dpu_annotations.go for more info.
> 
> A link to the actual file / relevant code would be more helpful :(

This code listens for events on the ARM/DPU from the Kubernetes API server:
https://github.com/ovn-kubernetes/ovn-kubernetes/blob/39e94d80c286f69c5416166d8acda5d1d2f9add5/go-controller/pkg/node/base_node_network_controller_dpu.go#L100

I’m not very familiar with this part of the code, so I asked our
k8s team to help me identify the relevant function. Hopefully, this
is what you were looking for.

Mark


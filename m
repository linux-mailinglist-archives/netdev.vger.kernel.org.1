Return-Path: <netdev+bounces-234133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4214C1CFCA
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 20:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 629854E2758
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 19:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782CF2DC76A;
	Wed, 29 Oct 2025 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N7qu4Tq8"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013025.outbound.protection.outlook.com [40.107.201.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A6F2E6CD7
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 19:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761765419; cv=fail; b=K6PKJyQY5FqpHDRv9EVul6a6/KN+WC4ZOqP7Tqr2jFd7yikOQmxx5TGmhnY9bB2kQGj7CV4somglb3OnhGlI9m9kOm7uFOk+6A1CET/jozVhklxo0HNRJwjOMcors/SOPLOW+M68pJ/8FRJUuGV/rlcQ0f7Y5TK9CWTOI3fC7mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761765419; c=relaxed/simple;
	bh=il25Ce8QQvrI+w7mOZ3PmVFVdI/S31qac3yRQjsDgTo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SRqC/CdeBag5HxOkHyU5Zvk2+S3jLi82Fmjdikt6UBuv/TqDTheMBRTH/d7a7eBGDSFFiiD+pgV68+3TOEKofMoNEXPwNEMJ6iqGrBH0+lg4Lqb3bdQkPNZev+JPX8YjUaXOV9pZulOcvtmJCyUpiGvB2s/pWvwxq4R3hCSkfrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N7qu4Tq8; arc=fail smtp.client-ip=40.107.201.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSlKXVywCJdDgD2sDPEkw7YpZ8MdYaA8lZ7ztmg9Z6pjx5UdrFOjfNxB+UUxmPJ+uqtqnLwEwZjC+Wgrc1HZjRprmTK4i+vxebKCgU9oNj5WNwCIPnCt2Nurcv50H/rKdiQRBbLh6j9j4j4F8TYmbIS1lohD/pouoQACIZ4h8Bu9lObXx4rIjtnDTamzlIyo1fF1oAeaSTg+OKcMbQb2VwhthbOlbLQu89OVHjp4pSDRrxJGqShTGjIvJchGHRXCOMFxl2434THLxiOVP26CXGPNvjtMTQEhTRLqq401iSTUS05ramLW/rJ2Nnj4lzhtm8+qkP2D0a4LHlWN5uV3AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvrivBWhENHoBfUh7ZYrZXFAFbm3UF5DuiD52ptDVdk=;
 b=d/jSpkXblxublx+3T8tjJhxotkLwdNWT9kuC6b3s//CGwzCaTZoINBPkozNsl+DKrPL0YBPcgLf8ccfRnoLDjqvZ5Og8jEDEO/LJCd3qfqrmCFWzSzYyVaFss/3ej4cIKd603vLhuLfaOig8Cx4/y30m0FHFxYI2VtHF2p3pRTu9wFn+/3DZ5g99UNyf8dX8/GBK7Xxx0hWS+Re/CC5UmvEauh23HToMdQjcykrnGzzVNrZrmMGrx3IpJDR1Mz2dm4mQ0/PIRkx2uAz45aI7ldhMnCOn+PJQ1i4IOxoqpKMLSd0pzu0SMUEfi2j4OX8p2l4LR+BeO9m/1Cx3ACstwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvrivBWhENHoBfUh7ZYrZXFAFbm3UF5DuiD52ptDVdk=;
 b=N7qu4Tq8pFLMvOpSENjbTnCrULQJaXaBdBEozij08oaFHfnYrCR0qfPp5PMNMYtS9kOfux05diXqINRKLf8jUFRreevWzCG2gQJaY2w1csI8RXx0ejYh35/RUQfJIjcsuoymGGfAefVhhEIW7jK+Il70zdyHEiOMB3CJ8QNM4UA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by SA1PR12MB8966.namprd12.prod.outlook.com (2603:10b6:806:385::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 19:16:55 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%5]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 19:16:55 +0000
Message-ID: <dcd07fb6-00ff-4af3-8d88-750f7c32519d@amd.com>
Date: Thu, 30 Oct 2025 00:46:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/5] amd-xgbe: add ethtool jumbo frame
 selftest
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, maxime.chevallier@bootlin.com,
 Shyam-sundar.S-k@amd.com
References: <20251028084923.1047010-1-Raju.Rangoju@amd.com>
 <20251028084923.1047010-4-Raju.Rangoju@amd.com>
 <20251028191416.78de3614@kernel.org>
 <56a8ffbf-7e4a-46fd-9c7a-ad3c32c5eb0a@amd.com>
 <aQI9YANbRWL3LFvf@horms.kernel.org>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <aQI9YANbRWL3LFvf@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::27) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|SA1PR12MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: 1467457c-f90d-46e9-4bb0-08de171fb914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEZpZitJR2RVZGR1ZEpzQitGTldLRkdPR1hsbkpGZ3BhY0ZHcFJ5RnRtMjZW?=
 =?utf-8?B?d1puc1hibHJ2NUloSDZrUDJ3OWI1Q09VZUxaSk9MVWxmTHBNYjJuVUNzQVdi?=
 =?utf-8?B?RnBLWVNwUVB6c3U3Yzg1SDBveWkyS2Y2NnhNRUQwS05TZFI5M1BydzRNY2gv?=
 =?utf-8?B?N2MycmE3RmFKSVBzWnJ3aVYyWlk4Rmdyc1MxaXQ0M3FGWXh3NHZteHQyTU44?=
 =?utf-8?B?M05lbnljaUM3NXAyeS9pVE4wU3Z4T2htd0N4a1Yva3l5eGFxV2hnNUR6Z0M3?=
 =?utf-8?B?VCtkQUFQaThMem9oYXhwV0x5Q3VkOFZPSXI4N2h2Nm13OGl1TGo1bDcvaXQ4?=
 =?utf-8?B?RmI4cWh2S29XWjk1ekZsQlBETXF3MWdUbjM1Vi83bDNBRXBORUNMQjVwUm55?=
 =?utf-8?B?ZzVPQU9HSzJ0cnBLTFVrQ00zeWtOVWNCK2pMaEJja1VnMUxsZHc2bzQrWG5Y?=
 =?utf-8?B?WlZNT3V6bHEweWlFZFF1OHBFak1NOHlVSndNREtrUmJOR053bGt0NmQ2ZDdZ?=
 =?utf-8?B?bHZ4REQ4RnhIL1VQUEUzT2ExMEhQRXF5RnZyV3ZRR0F6M1JLRXdpRlFocnB3?=
 =?utf-8?B?WEx4VzZLUkZha0VRNVV2TTk3YUhWMlUxSXZIa210R2FkRkM0R3lxL1V0L2tD?=
 =?utf-8?B?N25EdkdXQmVCUkoyTkhNQ0VqQnN5Q2FSMjExYXB6ZG45QW14dSt6RlJWQ3JR?=
 =?utf-8?B?S204TnhYSkpWaGdGelQvRDNVSUVJYW9JUmtNZ1Z1c3ZpVThOeVBxT2l6WmNy?=
 =?utf-8?B?U1l5VFNFWEdCdUlpWmpnQWJvVmdpbjFmSmg1TjQ0YlljMitVZkhWM0hUQWg4?=
 =?utf-8?B?QjRZdGpwR2xMUXp3eUdhbHJ5UVZYVzJUUjJvUzlaS0lTWHkvc1d1QlZoYTFX?=
 =?utf-8?B?eHBmY0dUQmlieE9NNkViVVNUVW1wWkRmQ25UNUVlcld1UmttNSt0eWRobVdl?=
 =?utf-8?B?aFhvbnA2bUp1dFBSeC90NUNWS01EakRKODNUWUNtWUhkMUhEQy9UNjZUSzlF?=
 =?utf-8?B?eG5uUkluTzNRaGVaNUxjMGpkd252enNaTC83TUJTS0RZdEZuUU90TEpyQ1du?=
 =?utf-8?B?UlVDRnJHN01mRFROOU9rbGhwRzd2QXR3cjFQOWM2MFg0S29jMnVZV3VjZ3BT?=
 =?utf-8?B?Ty9kMlNkNjYrUGZ1WHV4Q1BTelNGVkljMyswQ1lsbnZzdS9YK21hVldBdEtD?=
 =?utf-8?B?MTBSYkx2dTBUaVRrSUdCakdxVUk2SkxHV0Z6ejUzdHNFR1lHd3krYlhGdXIz?=
 =?utf-8?B?YUpDRktnN1dWSmxUbjdwZG56UHAxSVdMY3FvTUZodk00VXp2R0FKUEI1WEFT?=
 =?utf-8?B?aEJYQ2dQdGNPcno3YXY0WVpsNWtsRWxTTG0xN3kxUERTTHlKVWttNWc4akRl?=
 =?utf-8?B?bHBDZndiSkE3V1pyek5KV1o1dkI4ekN0Q3NTZldsaEU5b1Y5TE9iU0JwU2tQ?=
 =?utf-8?B?QkVrSEhMMmI2b2ZWZmQrRmtvZ2lhQzJhVndrZFMvUTNyTFVWVGhsQVNNQWIy?=
 =?utf-8?B?WVNUVkxVWUd4SElhZGh0QkVyNjlJdysyTDZmZVFSRkV4aWg2NDFGdVZqK0pz?=
 =?utf-8?B?OVlTVmRsTDgrcVZvVmFqNmdQSE1JR0hMcllVWXVsc1czZ0YyMGRGc3lIbkxw?=
 =?utf-8?B?ZVVLdUdURHVuZ3lVeFAwWFhRM0FqdG1KSHNHYnQ0RXgySzg1ODNaREwvdC9s?=
 =?utf-8?B?anR0blBQNHFTNTVxQTU0blhxWmxZZzNkREpNb0o4Z1Yrc1BIdEFMYVozYUtu?=
 =?utf-8?B?clFHaHZOeVlHRTVCMS85VHViZ0p1d0hDQ01sdnVmT2oxSGlUOHFMMzNuRGZV?=
 =?utf-8?B?NHVTUmdIYmdtUDc4anFTUXZjK0Q4VGlCRTd3M1Q5MkVJUXFWd0hxQTFZL2E4?=
 =?utf-8?B?SXBmaDlFbFh3SEgxeWdsa3dXL2UwMTBsTTRFSmErUG5UNUxBMW9iQ3RiSlRh?=
 =?utf-8?Q?+ql3PDvP+6wvzUbMBIZN5Z3YGLSwoW/d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzV4U0VDMXN3VFN3a3Q0WUo0UFhiUmF5bGZKaGZPYmMyby96TEdhOG8vRVZ6?=
 =?utf-8?B?V2QzZUFSUGN4YTJ2Vkc4SWpMdVU3TmRRQ1pGRnFMeUZpOHdKTm5ic2twS3V5?=
 =?utf-8?B?Y2tXNVJqMWFqemgwQ2JZdmVOMVhqY0crZUZiSkF5N1JVQXF3bUhTY1ZJYjVX?=
 =?utf-8?B?K2tDWG5IWkw2TW1YOW1LZDFSSG9XbFZPTDVsWGVJMUZ6TzZBQ1VVU1A4Z2o0?=
 =?utf-8?B?WDQweS9TSlNIUzFpTk1wZHFlRFkrQk5QYzM4R2tOcWhIcmlGNHFBRHpWY1JC?=
 =?utf-8?B?Ym5aUU5lTEpuNjVsMjlMSzFFWDJsbVdzZGxYMGRaNWVsU2piTndwTS9nRFZB?=
 =?utf-8?B?c1EzUnVTWjErZmZjcGZkVWRkRGJQV24yRE5DOFIwVm0wVUVuTjZjbENTSDZK?=
 =?utf-8?B?NjcyVDdlUHdzNzFJckRySmtqV01NTkc5SDF5UnpJT2orVTJ2TkdJVDJWVE5I?=
 =?utf-8?B?bk1kUnVuWTdNYVpDOXlJOUw1UzBNQjVaT29SYXRpLzlmZGVyRnUzcXM0dWNC?=
 =?utf-8?B?WXBXd0R2VTB4K2ptSXRqR1AvNEhNcXVpSnoySVBSck53ZXNWdk1BQjU0SVZy?=
 =?utf-8?B?YVd4U3RyNm8yYWFkeEd3ZTF6ZmcyTUFhYXlHYmtVVkNpYm9ORUY1OFVZcVlm?=
 =?utf-8?B?cHhuQkRlZ21kQ0Z3Q1VnQmhUOXhkR1lpUTI1K1MyTlVqWUx5TlBNWjg1bHd2?=
 =?utf-8?B?cnlLWHh5V281R2pOMndtRFFMZXZDUnpFemVKVEo5L25WYmhLN3VIOVVJVXJh?=
 =?utf-8?B?ZTlLL3UvRUpGOEdTN0JWTkhQUENBdUV5MERQbE10VGlLdmYrYk9KdmRTaXZU?=
 =?utf-8?B?ZjFyWTFrQ1lsN0JvZ3RBZ2ZKL3lJWVpINEtkU0hrRkNkVXhNc2Y1ZlRPdU96?=
 =?utf-8?B?NzZWVGpNQ1UrVEErWmMzMjgzTXlVNlY2djkyYm5OSENDYWI1WU1URndzVE53?=
 =?utf-8?B?NndiS3RTVGphQzdxL3FTNlFuZm5wK3dRUmk2czZnZlduMFhFRlduTUtES3ky?=
 =?utf-8?B?OHgzbGF2M0xlSnNzQjk4S0JKOWJTZ3lSdEthcDQrSkpOdlJDeklVRXc5Zm5i?=
 =?utf-8?B?dTZyOFNVdEpJSHAxL00vVEZVTVJza2NmQ2lqbWI4QWtiejdJelYxK3JsZjVN?=
 =?utf-8?B?R1pFZ29XRndzekpYamFiZlRZY0J4Qm95RThiK2haeHcrR1piVWtuVkQyeU1k?=
 =?utf-8?B?anU4Y1FDVDEvYi9JMTlYYTBveDBFc0x5Q0xBLyttVHFxamVaMjJ6WWw0MDJB?=
 =?utf-8?B?dmxqMmY5aXBHV1ZMS2pmbzYyaWNTNXF2b2NWMGNaRWxYbVIweUNNamFFTWpU?=
 =?utf-8?B?S3N0aFlkVFpqM2EvYmlsUFVCREJ2WTVJL1hyQkdmSTZqb2NqeVVERkhyYzZO?=
 =?utf-8?B?OU8zaUJzTHZKTWJvUStKY3piUWdMTUl6YUxhZytia251bjRxOTNJR09zYUxm?=
 =?utf-8?B?OXRxNzNNMDJENGN3dWxZTWJ6VmlUNDRSYjZpejNhYlhYRzJ3anYvVU1jZk1z?=
 =?utf-8?B?YW5GYlQxQUFMd2NKM3ZmQUpoWkxiTFVtaUg0K0pBQzZOQ2p6ZnQ4VjJRc1Bp?=
 =?utf-8?B?dUZIRzlvQTZRQkpEeE5yWkNtL01udFI4VzVKZ2lrbWtWWUFPQzdseTNmclZx?=
 =?utf-8?B?ODd6c21zdWNNTHhpZXB3NlF5Tzd3VTcrd2FoNTJvcmRhTmJtakZ0MUJsQTZN?=
 =?utf-8?B?ZXRBdFJ3bjVVakp1NFZreFdWWFhYUk9qZ2FLaHZXSGN3N0lTQlozN1dmTUFT?=
 =?utf-8?B?WmQ2RUowUlNqVks5dEpuS3M2akphalNISmZtM01FYU9ZRlZCTGR1T3FLd0RM?=
 =?utf-8?B?d1JOeURSaVZ5akE4WEtmc0dhSTI4YW1rV25uY1U0RUUyeUljVzF4R3VRbkc0?=
 =?utf-8?B?S3JXbzJGc3d4SnZWRWZLcTRrQ2ZPZ3dDY0RIbnRxZkhUWWplV3RWNGVyTWw2?=
 =?utf-8?B?MFd4QkRLd05UbXlDenJHcm14UHYrb3U5dnlvdDFKc3BlRE1NSmlkeGEvZXha?=
 =?utf-8?B?ZWN3KzNpZkNBZ0d6bUxiQ0VFK1BIaG5EN0RRVElHWXNhOG5NMlZZR1Z2OVF3?=
 =?utf-8?B?UG9MM09NcjRJMVZhN2t0SnZMKzBuOVZZV0o5TGJsYWtJM3crS0htQXhDbFVw?=
 =?utf-8?Q?fgz110VOmceTVt+ZHCTYHSuDM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1467457c-f90d-46e9-4bb0-08de171fb914
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:16:55.4046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZ7KJ7RiLH5N50dwmOFmgRB6UXcMdYSH541tUgXAl4wImHLRfjckzhhJsqDhpxdVZuU1tH9a4AduCfMSg62+1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8966



On 10/29/2025 9:44 PM, Simon Horman wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Wed, Oct 29, 2025 at 10:25:03AM +0530, Rangoju, Raju wrote:
>>
>>
>> On 10/29/2025 7:44 AM, Jakub Kicinski wrote:
>>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> On Tue, 28 Oct 2025 14:19:23 +0530 Raju Rangoju wrote:
>>>>         skb = skb_unshare(skb, GFP_ATOMIC);
>>>>         if (!skb)
>>>> -             goto out;
>>>> +             goto out;;
>>>
>>> double semicolon
>>
>> Thanks Jakub, Please let me know if re-spinning the series is needed.
>>
>>> --
>>> pw-bot: cr
> 
> Hi Raju,
> 
> The annotation from Jakub above would have marked the series
> as Changes Requested in patchwork.
> 
> So I think that, yes, a re-spin is being requested.

Hi Simon,

Thanks for clarifying. Just did a re-spin of the series.



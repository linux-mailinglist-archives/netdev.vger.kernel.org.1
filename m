Return-Path: <netdev+bounces-202760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1325AEEEAD
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 08:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D5C1BC4B6F
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 06:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0F22594B4;
	Tue,  1 Jul 2025 06:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kX9rwAJP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCC42586EB
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 06:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751351171; cv=fail; b=OozCJGP9XVkG0jKCAML0OJXpc3j12umrwwLccU19WGVc1u1m2AbUl3BU3iqSNxIF0AhFIB0bhamHhsL29RdpYssLq7j4r50FeEOcbGrqTVhFjxRcgyAshJDjJu8jE+SStUqJ35sX8TwrQt+US9ZTkLnNHJRz602neVn9tBpA5cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751351171; c=relaxed/simple;
	bh=8jWG1dW5SmqJZz4bvFu2pTHrtIb33Tk51ND8FTR1Keo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MSbz5awO0FalrIuZ8/yWoQ2P2rTUbX5RDdTUp5XuHd8uMgvwo1OVpRjRcsiTEKg8bmbuNqU6tI6dr8GbOB5YdY7saQtoBvbCz5H+yEshRfrvc3SxpJuIrCgm2acHjd1/3uVfCJ1KP0MlS4Wwtzn9wYT3ZgBeTyPPorMV6T/GBTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kX9rwAJP; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXBdJsg+F8U9efzEJg4HLJGsBCEkMK4a8kufX4K7Q5xjHXhPJjC7rQSRKBvtGALwj+H8PWjhmh+KYs+KykPAPt6RF91t8XzR24SlZbc1TaM5tqlO71MPZDTIlVGjpedPpz5JzMr2V6f3GscsEMuGENzUBv34ho+NdhJbeQVvq+PIXipTBZ6eKvkZQn7ElqtQiXPlQ12wpMMsp76S3js2FVUXGbpdp9vzYeeIJnEQGVq5TtmkCV8V+PnsH578wBfSjsRdmaFhKLllCrOQtc7xGteQIWsDEzf58aZr6qoLolfeN6w3g0MMosFD6y7n0qRcUmhjKy/reAxGdmqdRm5cSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhahAJEciX0wvaN83+Zv3sXXxZwE9t3OzaWCVyYwE4o=;
 b=MggpybfKT56X2wa/6iv53UaLImf6ONucDJq/WT7m2iS247NcdnSPswmBYK/0mlN5GK2+sDsDoe3sAURDbrrM8e5HXiTLGMcPDKKgi9hcatcDUxTQca944ANeULBw57XMK04/wvuovz2swLdt0f4W+rVjieU6e2BQqja4gy7fUYVZs6OipzWsDTO4Opv5jHt9IoSW40kYqZntlimDbebzag5w75QPyvJTrxyYuGBoXMvv8JXrmOKY40Res4M1NSkGLglOmLr9L9KtlYhHeixNgrV14hBvmZorHitR5DvF45Z9+c9sQgL+1s47QkHPZn4yDDe0R4PZerLfLLsPxcUpsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhahAJEciX0wvaN83+Zv3sXXxZwE9t3OzaWCVyYwE4o=;
 b=kX9rwAJPSbgV24b8zxCtLMnL15/apHVP9KhlDDm2/ATj0iaj0ztdEIPsvhkgs6bBSmNQd+zO9V1bD34bpfSNHIUQsUsF3TWF/ZeDWL5BtSi7WtWThPlfP7TTBBMu+mpa9nkIfAuRGRu0QDF7Oze2wDj0jz10DyZRYctsdsVsVyT8uEFmRS9TScfIr9k/NJE2nS2+c0J71uGFF8Ucg4qixvbnyfH8uzU+XPb8fXiWUayGE52zwam1KJ5jnpcczh5rQ53G1TOwHKXqgt12qdHjkOMITyr27f5kM4IZW/Y85G7wdFZh9RrXS+UXHs1dhdjt3ZdcCmMDqSmxFZTuxGaeMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by SN7PR12MB7275.namprd12.prod.outlook.com (2603:10b6:806:2ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Tue, 1 Jul
 2025 06:26:07 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8880.030; Tue, 1 Jul 2025
 06:26:07 +0000
Message-ID: <7e620889-8d09-40bd-b609-407161daf094@nvidia.com>
Date: Tue, 1 Jul 2025 09:26:01 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] net: ethtool: remove the compat code for
 _rxfh_context ops
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 bbhushan2@marvell.com, tariqt@nvidia.com, mbloch@nvidia.com,
 leon@kernel.org, ecree.xilinx@gmail.com
References: <20250630160953.1093267-1-kuba@kernel.org>
 <20250630160953.1093267-5-kuba@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250630160953.1093267-5-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::13) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|SN7PR12MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: a40b7954-033c-4f55-4490-08ddb868299e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2Q2bDdXZVlMVkMvNndaY2JST3RrS3g3bjQ5SVRDR3A1SDdIY0JVR3B6V1dD?=
 =?utf-8?B?b3gzOG5oSUx0aldSSm82ZTZsbWZ2ZXlUTCtCN0ZUQlk0OXBXdkJoNmlQU2Zt?=
 =?utf-8?B?aXVWWmFBMG51UWV5OG9UT2sxZmV0VjJFR2Y3YjlhQlRDM2ZmQlJpU0ttWnhY?=
 =?utf-8?B?d1ZwRUlWZUpUdlpneEdYZEs5LzZBQzdXUEc4bTY2eC9RVDZ4NXh2TjY4cytT?=
 =?utf-8?B?SWJLTzgzWFZFOERYc1pDdU9vblNOWE13ZG1oWHNFZllIOUVtRUVuSXkwZGV5?=
 =?utf-8?B?clNsMjdKa0ZSbnJlalc2NHh3SDlLYXBCdGhucFJJRGtqSWRIbEw5UlZoQmlj?=
 =?utf-8?B?TFYwVi83OXNkZk52bnk0UHlqaGg1WUxIWWpva3hBdm1HSWRLRVZSaDdoRDV4?=
 =?utf-8?B?VWw0UU1jTTFFR0hXa1UwSDJVUHQvaFZCZmdqM0NxcFI5ck90S0tsa1NPbFp6?=
 =?utf-8?B?VHp3NTBCUDBQUnBPTDhycysrSHozQkVTb2hwblduTXpheU1WZ2huZGtOT3NJ?=
 =?utf-8?B?Qi82czUyZjdFTGVWa0xvMmtzYXF2S0FqYjZDdWRGenVVM1ZRR2g1b1g5YStl?=
 =?utf-8?B?ZjJ0TCtkVks3UFZJSHNpdGNoTnJ2VUZmaDRUUHhZWERWY0ZxTmllM0c1V1NN?=
 =?utf-8?B?eEhJZ0ZMQ2U4c2wybk56ejFUZWtYd1ZhT1hEbWJTZUpmbDJ0Sm41bmxEcVZ0?=
 =?utf-8?B?bzFoTXJzS2ZRV0NNdGtKUWJyMmhpNGd5MHl5R3dFTVhmalIxL2ErWUJLbXZH?=
 =?utf-8?B?bWQ2SHIvb2JmNzFBcG5raTNzOFBnMnFHWm13UFMyU2RSVTFGMkxwbDZYTlVj?=
 =?utf-8?B?cDFWR3RPNnlaeEkvblo5MnI0YXlOdnhuUTR3ejdtTTFHZW1nc01sNHlNREFk?=
 =?utf-8?B?MmpRTXg3cTZGY09CZ0NudEM1ZEI0WitqSnhUMEpKYzJubW9qSGFybHNHVzRY?=
 =?utf-8?B?Y0VhbWw5SGV0eUVlZkl5SlY3UGlCSTh0SzVQQ29rK05XcUhhb1lBWFJZelJO?=
 =?utf-8?B?TjI2YzlDbnJjVkZsWW1ZMldTV0JsQ2cyRHBBYS9Pd1pMMStaK0NsK0dmQVRi?=
 =?utf-8?B?Vmk1aFZWL3J2bXpRNVVoQUdsK0lvT0RYRDRsandocStvQ3NYTHFmRmUyYUVx?=
 =?utf-8?B?YUtHMDczQ2o5c0lHN2VhS0RxTkNjYTFXZWx3d3V6NWxaMG1kZWNzU3pJV3o0?=
 =?utf-8?B?RERmcjVnOGJVNmFzZzlGMXJzSDE1NzRQUVNNRnI0ekpQWTlSZ0E0Yy9sK0tO?=
 =?utf-8?B?MGxNSGRGS28wandtZVFsS1g4bHNyOUl0TjcxWEY1REZQR05ham9PSXN1R2dz?=
 =?utf-8?B?Y2NUSlVIaFIzSWxaSytGd3B0U1NJNCtqMkpLVkQ2K1kyajd4VFBFSGlMc1VV?=
 =?utf-8?B?K0xpSEw5bEFNV0lhWlJqYTc4TkZkOFZkbStEbEpzNC9VYWhKZjdoSitEUU0x?=
 =?utf-8?B?WGR5K3pYdjgzVkFKbUxGc3VRVktNaDhCVUFaTnhsb3I3Q3dabzlpellMeTNU?=
 =?utf-8?B?V3ZzRFE1OWN2dFY5MlVRSUhUbTZyUllTa3dNZFV1ZmFFQVlrVkNWeFprK3Vq?=
 =?utf-8?B?NHl5V01ocTBFUmZFd24rZlFSY0xmN0hZWno2UkdFWEp5VnRlOEdaUC85Qzdi?=
 =?utf-8?B?Q0JVRXVxcktqQlAyNi93T3ZaVXdWSm9WbnFzWDJhU2JVWGp6YnkrbDJBaDlC?=
 =?utf-8?B?b2xzRTB3TEY4RndJeUhONWwzNWxwemFJQStKWVp6TFQ1NXhxcHNYOFFYYnJk?=
 =?utf-8?B?V0JsM1dJVnFwSEhNZ2ZxM0RXdlRJNGNJdWJybXJLYUlVcko0Rll0REs3ck02?=
 =?utf-8?B?U0lZeXo4UmVobEMrSEoyMHgzUzU0T2dqWTVHNmVTcEZucU9RejhTQU5kMWIv?=
 =?utf-8?B?VkN0cWpUWS9ZRnloYzR0QVBjM1dtTnUwRHBqNFlLWS9nSEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXMwS0sxYzdXY0hEYlBVQnRXWVFQSXV0V1Q3TFdhbW95UFM3VWlmaGhNekhp?=
 =?utf-8?B?NXEzRDlqdnY1UmNRS00xUkZXbkk1WTMxWU5SSExkYzgzZWttcUcrUnVRUGFY?=
 =?utf-8?B?alFwd1gwUFJDRnREZjI0bmNEZVhMcUlodlRNL1FXaHFCTUgwT2JSRFJaRzhC?=
 =?utf-8?B?ZXM4THlnWEJjZlBKN1JSUXNva0IzRXpWKzN1cVBNb1JHVFVsUFZ3OExnZGl5?=
 =?utf-8?B?R2xscklySDh1STFqS1ZUa2tKTy9EanRDNGFFVm1MU0tDWnZhUG9HZzd4S2ln?=
 =?utf-8?B?YW9KY0JqVkZGamFLQkFGaEJMelFJUzdCRHZud01ucXZib2dWdXVNQUZxanZU?=
 =?utf-8?B?UGxRYXZ3ekhxOXFVWFIzMEkxWFVFTnZDL0Fzam45QjhpSTZmT3hPVytSU0E1?=
 =?utf-8?B?cHhVV0ppZlI2MUZhUTJNdUJwODl4NFRRUE5XS20vWUhGYklNbHZKWkhHZFd1?=
 =?utf-8?B?SXIyYWJpditZTitpdnhSTHVzT05ZeHIyKzV6R3NLMjVEN1M5TFViV3dlZHI4?=
 =?utf-8?B?YXQ4dnQ5bEtDTHVXYTA0M21LL3pneStLeXN6dkxSLzhSK3NwNjUrblN6RGlN?=
 =?utf-8?B?RmVRYXpEeWZkNW1aRjA5ZGMvZXdpdlFSYndEQzhDUmhnWmFQZk4vZS81SlB3?=
 =?utf-8?B?bXNEN1FCUDN1WVF2QnZOUmtGVGZ3bUZOckFhSCtpd1lVNXBmNjRObXlJMHBn?=
 =?utf-8?B?VllXWUFFVERwQTdVRVNPWXBDaWVCSy81dm5kakcwYkZsYXZ6aklnbWlIVXNZ?=
 =?utf-8?B?cG9SUmRyUkQxNVNXa3dNUHZZbCtKVFJhMjIxQnhYeWJCNXVNdzBTenBJbnJX?=
 =?utf-8?B?MHFoUDZlSGY3cjNKdy9VTXFXYzE3NEdGaFZ1Y2JNeFJveERJTFFjMm5wTEV2?=
 =?utf-8?B?Q2ZlQllmV25LVmdPb1grZi9OWVQ3NitKQ1c0TVNjM25wc09ZOVVVNS9mYUt6?=
 =?utf-8?B?R29IR3RjWjZpY2hCajFndVBvQWczK3Q2R0M3bnh4RnR6a2JkZXllaG5BR01K?=
 =?utf-8?B?OFFBck13YlQzNWxoRkg2ZnFwTmxiY0dpWGhxWkFTa1drVzhhbkJ0akFaZmg1?=
 =?utf-8?B?QVUxY3pUM29Nc1FMdlNoRlhKTlNhTFRGS3hNWVVETjlQeEptVUlRYnFTZVRy?=
 =?utf-8?B?Rk5sNmxIRXU3NEVXNS9jaVJad2k5QXlCblppVjFXVGN3YWFmYVEyN0V1bFND?=
 =?utf-8?B?VCtIWXdQeVJMMDlqQ1ArMlgvMDdEcXpSK3JvOGhiUHNFS3R4ZFlYWEg1TGpZ?=
 =?utf-8?B?Z0pJd0k1SjY3QW95MVZ0SnBRbjV0Vlh2UFk4QWNTNzVBVkkybW9xNGdjMFd5?=
 =?utf-8?B?TGdpZW95N093UG43d211M1ZnWFNTcXVhMXp0Q2RDV2U1UlViM3luQzk2d1dW?=
 =?utf-8?B?OVorSGJaWXNkOG9URFJDL1BFYmc2YjZobE5mZmpQdXpMazRSSkEyVy9CRU9w?=
 =?utf-8?B?QlRsdUNtZVlZQnpsK3VYMWJGaEMzL1lhK3ZPdzhvVUx3aFU0ZWZEd2dBcTFU?=
 =?utf-8?B?cGdrZHoyLy9Oc0dVMVhUd3FhNlM4eE52WExHV0dENGlUQVBSNkVvN2Fra2JY?=
 =?utf-8?B?UDFLYURYcDZCOWV6bjRGQ1prOS9vNDNldVB6alJsZGFQYkdvSXBOekpmd3A0?=
 =?utf-8?B?S01LYzBCYjMyZHhjTklTcFJjUlZhUFl4eEdMUTRpRnhOaDMyZ21adVk0RE5o?=
 =?utf-8?B?REwvbnk4SU1vblZ4dnBMOUQzRkR5cGNMTG9TdStzb2FFOXJTakpHcnA5cHJE?=
 =?utf-8?B?Q2RlSTVFVUdOTG5PMC9PcVUxbjNyUzFEYzNaVGtXY2FicXlmTVVJd0xGckNu?=
 =?utf-8?B?THVnVEVDdXBZbVc5N1BFRkltZlVKVlJxOFB2NGo4NFk1TDJoSDFLNFNWemNi?=
 =?utf-8?B?ZDlwQVZENlBTYlRmVms3R0JVaCtYdkJBVERoWXpsUlpOY0tjMVhlT2ZnWGZ5?=
 =?utf-8?B?Uzc2Y01uL3ZSUEkyRHJRVFJ3R2VwZXZ4ZzJ2L2I2NXdwam1ZbERoT2ZLMXhX?=
 =?utf-8?B?aVo3K3g0TEEzWU5lN0V0bllLTzM3aXFzYkhBVGR1ejV1MGZObmdlQkZSR3g3?=
 =?utf-8?B?MW9KdEQwak9XaDRmOExjV3RBOGFublB6L3c2TXNsQVF3a2VqUGl3VjJMb3cv?=
 =?utf-8?Q?cCUOh6XKhee+S5u+/rJAfkNn5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a40b7954-033c-4f55-4490-08ddb868299e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 06:26:07.4107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IfB6vm1w9WybpyEaPwwN+OlSgLaST9hopjTqzHGTBGqhNyRyMddEMJ4jQ2XOflSM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7275

On 30/06/2025 19:09, Jakub Kicinski wrote:
> All drivers are now converted to dedicated _rxfh_context ops.
> Remove the use of >set_rxfh() to manage additional contexts.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Gal Pressman <gal@nvidia.com>


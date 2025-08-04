Return-Path: <netdev+bounces-211556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC40FB1A16F
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 14:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7691A3AF7CB
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 12:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A356258CF2;
	Mon,  4 Aug 2025 12:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.elte.hu header.i=@inf.elte.hu header.b="vn9h8cfL"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023132.outbound.protection.outlook.com [52.101.83.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3038D24E4C3
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 12:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754310741; cv=fail; b=N3Ixo6kX8Q+GEzaHHHI0UCEshDSZdjrqZJcbJREj106TFlGLfgG7yIab5/nw4FYrtMRn89v3SFRydexD+3pt/kmvHr8yHh8rrq/ze2XIxtLhilZU3EylTffLUqYjv8SXp2yRlU2MUE2wsfay+W44/332RZNNTuJ5G8sPRu4sGpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754310741; c=relaxed/simple;
	bh=bml6b3fBzkkNVDodDwZlDbLN9rTCOLN0yIL0cypTg1c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EVByYIEC/8fxXIPZtQrrlzF/AyrGaLxHRMM0q0zkKA+gA6EXchFP8/VZx2gQq2ZMfNr/mkNw284+sBHlBtZuQRDJ9ufLJOoPbPV/Z6SdGV0qkuQ5wzsTyVv3iU/ePsG7p443qa8tB+7rUV8NEKtNUgkcxWivYoFlf8/D40TjY8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inf.elte.hu; spf=pass smtp.mailfrom=inf.elte.hu; dkim=pass (2048-bit key) header.d=inf.elte.hu header.i=@inf.elte.hu header.b=vn9h8cfL; arc=fail smtp.client-ip=52.101.83.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inf.elte.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.elte.hu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEYZJkBXOZEl3+/mI5io1C9quSnQmt+L5NaQXTbB7/cEtFXO44BerHsCvPtFyIl0twtQfs82tGrh3u9ji+i9R4/Lt5YJSB7LyOdhtZEefuX+0nSTCE6AahWHofTT1zhCEEhnuSc30OFw/dlpkAUzYE3S56QH6N2hhPD5ilLO3vNGgpP4J8YqstWrDimbDXSmXTBx5MXlXND6ZwSt0CMddJZfGY6KVNL2mDUmEjZV9oKfHfUvfkoDh2LshDJUNlWtf1JFN4H6f+sDmpPFDf338dEl8fb4mWEztOL1mMz5yUJN1Ct2GcreQHPicbuCrWZ3JIc40M1DDTUIBhFVMaZj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bml6b3fBzkkNVDodDwZlDbLN9rTCOLN0yIL0cypTg1c=;
 b=cZEoesRf2FJsxJsTeS1QCq+JnR7luPhqGxyxqURySOGNd4S78RySHQRojIq2hWG0ayJX6i3D/F32zAyk/At7OMSu6oFBUn6nepCynIbzQrWTpEo+otjwWH3ajj5ogP71/TO6aqulRXNtDHl4V6OlhlnoaVF3NXQ/iFSmpE4NhjCr/rmz+7qE8mTOR8Z1E2IWfP/soJuyKmeBDg2Wm6zMHMLFfE9uqnd+3UU7H33pEg3jQL+DI/3pb7OPGJLmis5pVfwGB8K4FQNUUcRU3fE9JN6soFFJiByE1OwH7QZgal+Pj+4gfr0rOr3iNCCzg3IkAqgMgg/MRfbUt7oGudCmoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inf.elte.hu; dmarc=pass action=none header.from=inf.elte.hu;
 dkim=pass header.d=inf.elte.hu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.elte.hu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bml6b3fBzkkNVDodDwZlDbLN9rTCOLN0yIL0cypTg1c=;
 b=vn9h8cfLEx/Eq9JkTn6DAN1g+tMTCuNlb4wyHWsECCVHWyxHAvpaEzzbRQqqi3wakY7nncodBMUXGnRz0rzIi7v5DTIlmDKY2Fg4LoLmyEUOG87jezbs6o7iyhNP4M3M9l0s+vuCFBOE36irOmIfI9UlUFSt7wOZwaRC1xxAF24ZB8QAS5jQCufQuiwqKb5Vrdr8cRO8UGmExkVkUuB55L9eBYYkY6EnzwLOmxamcvUbUw7c2sG6Nrt0LcbBjqeA1CuBbMl2ERSvno8V37/JK4PEUOlGdIQcNyYeo76fxgU3ELuUSz53bGrNPok82Gk2JyfAbxHPU+N0p21PeJFhUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inf.elte.hu;
Received: from DB9PR10MB6740.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d0::10)
 by VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 12:32:10 +0000
Received: from DB9PR10MB6740.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5125:d772:4906:ba16]) by DB9PR10MB6740.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5125:d772:4906:ba16%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 12:32:10 +0000
Message-ID: <0e09d1c68582806f5dd693b0c23a4725835e900b.camel@inf.elte.hu>
Subject: Re: [PATCH net v3] net/sched: mqprio: fix stack out-of-bounds write
 in tc entry parsing
From: Fejes Ferenc <fejes@inf.elte.hu>
To: Jakub Kicinski <kuba@kernel.org>, "davem@davemloft.net"
	 <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>, 
 "andrew+netdev@lunn.ch"	 <andrew+netdev@lunn.ch>, "horms@kernel.org"
 <horms@kernel.org>, Maher Azzouzi	 <maherazz04@gmail.com>,
 "jhs@mojatatu.com" <jhs@mojatatu.com>,  "xiyou.wangcong@gmail.com"	
 <xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>, 
 "vladimir.oltean@nxp.com"	 <vladimir.oltean@nxp.com>
Date: Mon, 04 Aug 2025 14:32:07 +0200
In-Reply-To: <4a000ef11bb148fa8955385155714056@DB9PR10MB6740.EURPRD10.PROD.OUTLOOK.COM>
References:
 <4a000ef11bb148fa8955385155714056@DB9PR10MB6740.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
X-ClientProxiedBy: FR4P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::12) To DB9PR10MB6740.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:3d0::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB6740:EE_|VI1PR10MB3167:EE_
X-MS-Office365-Filtering-Correlation-Id: e92f4876-70c1-45af-4830-08ddd352eeb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|41320700013|1800799024|366016|376014|7416014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWpLek5meGFacmNGUnlMTnZDZVY0RFhRUmNPeGI4OEJUaUdaVmVZVXU2cy8w?=
 =?utf-8?B?WVpuM3ViQllkRnRWcm5uQzU1SWtPak8zVUlWQUtGZGx2SktyWW5zSFJzMnF6?=
 =?utf-8?B?TTViSWw0RTJJMnhyVytXMWwvNDMvc3FEZGxkbnhvWm9IN0RuSHVDck9YMmR4?=
 =?utf-8?B?VjlXK1liQWtTWVNYWkFrRFdvU0hiRktQYnNtaGtheWxPNEcyM2Z2SThPZU5p?=
 =?utf-8?B?NEM4ejF1OUFiUndUR1VoVnZPYzNLaFdtMll4eVlxSC9lZC9LdWtTSzBHSVpS?=
 =?utf-8?B?NGFHbTBYeHFZNXJyWHVXVG50bzZyUHdydWFtR2grVGxvWUMvOTR4elhoeCsw?=
 =?utf-8?B?NnJFb0EyaVNJWDVkaTg5UkFqajZaMkJraUExYWpSMFF6aGplZ3lGbzczVTJv?=
 =?utf-8?B?MG4yNWYrbkI2OSsvSVh3U3VacitxV3dJL3BwZWlra0dwdzd4Vm01cVNVeUgw?=
 =?utf-8?B?U0NnT3Bra3E1cjQxWE9yb1NuY3ZqMGg5cVo4WFRJRElSRzhTZWFhc21sR3N0?=
 =?utf-8?B?MEZvMEJuMDh2WHNpNFI1QVdvMDZlTGxwcmxQbmdmYTBVSk15TFZEdGRlZEh6?=
 =?utf-8?B?eHR2T1B4REtQOUVqQmJFVW52WCtQMlNuQlVSWm5CTi9lMmo2V1M3UW9ia215?=
 =?utf-8?B?Zk1XZjRKdGJCeGpCWG03T2hJb0FYOGtuaGI5bkJvNjh6Mk1GQzJrUm5scFJR?=
 =?utf-8?B?eDE3WGxpUEVSSFhUZisxSlpLWUFTaWFqdldXbXFRd0tkbXRXLzBlVzA1VXJU?=
 =?utf-8?B?cW5tMzNPQXZUSnIzNFZ0Zm1odnN3ZGdLVzU1a1QrWUhRNjl6N21mNkZ4SnNi?=
 =?utf-8?B?dU5lZzFxYVVoZmlhbG5scjlJT1VxNnoxVFNRNzFDRzNVaVB1UFkyTTF4M2hL?=
 =?utf-8?B?ak1CeitDblJUTi9lMy9scXNTUlZVWHA0OGFZTklnbUx3dk9Ya0E5LzNqRGsy?=
 =?utf-8?B?clRpR2d5UU5YUXVCTFRuK1cyTkg3TU5DUDFhRmllQVVyV0NoVnZ0UWNIWjVi?=
 =?utf-8?B?VDNFcGhGa3orK0hrSjRHWHFPa3BOODJqMUgwZngxNDVkRlhWNnpzeTgvQmI2?=
 =?utf-8?B?WnlQOFJFT0FYQ2NGOUI4YmMrYzRQZHlMeEhWL2xROUc5ZGZPVVRINzlBS3Q1?=
 =?utf-8?B?bUFtRzhqdC9qNGErMlUxUS9VeFVTT1NiWGN4OHdqOGpvZC9pY2ZQK2RNcjVv?=
 =?utf-8?B?RjN3cjhnSnFsbHdkQU5sM1VaZnNxM0VaRnNKazJkOHI4emFKYmh3THhta3Ns?=
 =?utf-8?B?eEZZSFNnTHJmNkM4WFcrUDBnTTc1U2xmZUFGaGVKSFplSHc1QnNRZnVia29E?=
 =?utf-8?B?SlNhSSs2a1dhWDFET0pmbXVza0lRaUh4U3VYZ2t6anRERjJyY1B1U3V2c0Zi?=
 =?utf-8?B?Njg5MG9QVHFjVnZtd3Z3UzNrd1prZlVwdUNQMlEwUzU2RXNEUUNsZ3BBNnRY?=
 =?utf-8?B?bDdEa3ltK3RLeFA3ODFPa2dKSVBtcDdySENiNGJTTGFZR2VVMDI0eHFPNnJn?=
 =?utf-8?B?ekxNOFVjOS9Mbk01Tm5Nd05JdEorNG4yenRJVzBQL04wZHE4R1ExdWxLWmpy?=
 =?utf-8?B?QmhjUzc3emlLUWU2V042ajN5UXA1K25lYlcvYmRoUHJCTkU2M24xd0VYbjd2?=
 =?utf-8?B?NDBod2Q2MGVhaHRhRHJOUTZ1MmhuMDNsSCtFZE14MXdkZ2ROeElaQkMweTVP?=
 =?utf-8?B?RGowNkJLSUhTbXF0UEFTVlQwekh3VlhFZTBtcGdpMG95aTV0OW5tK3JtbTJE?=
 =?utf-8?B?MmlrSERzM0NLb28xY2FpN0lXS3kvZHR3NDkzNHFsV0ZqUWkrWnEwTXJ4VGQ5?=
 =?utf-8?B?UGRTcnRyWHlDYTFtUzJDZCtsNGVxc2Y1WnFGMWttTnA2OEExOWw3a0Y2bEJy?=
 =?utf-8?B?UENteUZMeVNTa0t6UUt3N0c5Q0VKS2ZlOTJ2UHJyb1VPN3p2aHFhb0s3THNw?=
 =?utf-8?B?WllXMWhUS0tMYUdFamEwRkVpVmYydis2ek5sWnRzVlRnYnFtSmVScTJnNDc2?=
 =?utf-8?B?aGE5OVVvOHhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB6740.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(1800799024)(366016)(376014)(7416014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUp3UHY5SEMrN1hhQ1JmcmJER2ZGWGZzOEdKYjNac3pQRDBrOElldWhUdTU1?=
 =?utf-8?B?UHJQRFNBNmpyK29xdjNGMU1VTk9zd2V6Z2h1QWhEQ2RNbkVHeHErd3pKU0Q5?=
 =?utf-8?B?M2ZaMXdqanJDemo0ZGFJMSszNG1zaldRQzEzczNhdnE3MXZVQ0lwbDU4UFFV?=
 =?utf-8?B?ZFNDclhGTklMT1NCRzhvOUJra2MxVlFabjBRNmxvblNEaklXNXRNYndrbk5M?=
 =?utf-8?B?QzJ0ZmtFeWF0Sm4rUnRNQ0p3TGFzQmlPYlVHZGdUZUw1SnVIT3FUUDRVKzd1?=
 =?utf-8?B?S1VjcWcrWUd3Y2RzL29FdWtLVXZvYXVQbTFIZkJxbXNwbmdvQkpRZzR4MGNk?=
 =?utf-8?B?WVQzaUhMQW5DQ3VsdE1qZU1RZGFCbFRKV3ROZTNGWGdOZGxKL0dQZjFRV3Nq?=
 =?utf-8?B?NHd6N283QjlOci9IbU12R1E3NUQ0U2JqMkdtKytYSFVVNENNVHN3a1pSM0dK?=
 =?utf-8?B?SE9pcGlxMTY2VmFUTFRuaVRLeU1yZkVsSFk2NDFPeUNwWlp4UW95ZmVMcnpI?=
 =?utf-8?B?akYzYjUxK1M4aDZMV3VMNGxjWm1ETHk4UzlGTXVxeW44VDVuLzM3VWVDMTNw?=
 =?utf-8?B?UXVLcjJqNGVCaHV4dzVYMk80RFZTQ0RxZzdFNHU2NHVnV3prQW5pNzR1cjBr?=
 =?utf-8?B?TWl1RnJJUDJwZ1l4V1g3bWFodkNON2NIK3ZLUHpZc09ncFdYU0RNbUd3UzBQ?=
 =?utf-8?B?QjJUb0VkYVBzS052RTNJOFA0MDZ5VlJsVk5ObGpyYUI4UU1LamxxMTBUOHB3?=
 =?utf-8?B?SHExQ1hYRUtqa3NjZG53SHdtQTZIZCtxTDNFYVIzbnhRbXRVWmVUc0dVR09G?=
 =?utf-8?B?Qmo2YVBSQkVybGllekZwMm12UWxFR0FjRlk2OFdjQUR2Q1dSQW43WmpHV29S?=
 =?utf-8?B?SEpmWGt4c1pDMHQ3NXNwTU5zbXljSTd1UGRIdkszdjlXSlMxUURXVGhzRWE5?=
 =?utf-8?B?YjlPME9zTXVXa0JicXF0cU9FTjlQSkZqUDVzUk5BbEt4WldxV2djVmRxRXdy?=
 =?utf-8?B?NVE1N3RoQTRGSjJJK09ZMG9yd2VveWZDeFMwa2ZtNWo2Q0FTcHhxS0R3NUJH?=
 =?utf-8?B?d3lRVWhvNHFuL0lWL0U0UzcvQjhDQUhCWk9zRDljRGdGZHpJUGpGcjhNc0tC?=
 =?utf-8?B?aFhGT0dEdGw4THNpYkgyVHdnUHR4QTlWb0szVjA3M0lyeDc3SlUwUzhGbTdz?=
 =?utf-8?B?WXB6emNQYXFILzloV0gxajl4cnRWVHBEZmFVRE1WMVNqSE5oZURZY2dkemRZ?=
 =?utf-8?B?eDY2UVRzdExMZlNiK1huZW1qelZQc2d2SlJwRXFsOVdyUnA2YWJMSCtYWmNy?=
 =?utf-8?B?TnVhV0lYNW9SakxIcWJWS2VvajN2Zmw5SkNLbjJvN09OejZLSjlwbVpmSTFR?=
 =?utf-8?B?VjdhTCtWZFRFeVg0bUorZk5HVXg5R250ekI0Y1lLcnlRalFDMnpNUmRxTXJC?=
 =?utf-8?B?RG5PZDZuZ2tzdFQ3L0FKWEY2bjR6ZHY2cVE1c1I1TGM3eDZYMjBZZTZaZUFY?=
 =?utf-8?B?Tm85YWEzNmJXMFRyOEVOU3N4aWlFTFdrbi93cllRMStzUldXR2FIUURWVGxn?=
 =?utf-8?B?WWJIcE9TUHlTWjloYTRhWmNMOUhFdStFUWdLZ0xzNVNrYTBwR3NwY1RIRlJT?=
 =?utf-8?B?QzNkeGRtL2h0NXhyc0x0RC8zQW02Wkh2Rm1taFluQXdVN09jRU1MdjlQSlJJ?=
 =?utf-8?B?Q2tRTjRtRkZnWW5qaWR2WmFPTHZqTWxvZUV0QVpQQUNRZ1lNcG1EdnFCTS9M?=
 =?utf-8?B?MlV6ZTRmbS9tTmJLa3ExY2MvYXVidS9sMDZKOTVNSkdrYndROUo3NGNSdE4v?=
 =?utf-8?B?clh1amhJb1B2d3NWb1B1Yk9PVWxYTGxSTlBGK09WU0lkTHA1TVBQOWYwMVRG?=
 =?utf-8?B?OGZWWmYvM3lwNmNlRllRRDkwem9XWFVjcTVmdmpBdDF6eVpGT3ZjM1dDeDNx?=
 =?utf-8?B?U3hkKzRyTGxjTmJLaHF4N2hqNWRDSUN1bGI1TG5TK1p1N20vRm9nbkZaU2hO?=
 =?utf-8?B?aGlvcjNwdWFwZGJOemp6aHVrNkRQNkswRW5DU3VTcDNtcXV3KzNTK3RoOVU4?=
 =?utf-8?B?TkRoTXhpOW4zcEsyWCs4Zk1waEFxaEJ2aExWSnVBSGNsQlN3NkU0L1BKaXFM?=
 =?utf-8?Q?m4riY18tpRQEeruFjBnDA61I/?=
X-OriginatorOrg: inf.elte.hu
X-MS-Exchange-CrossTenant-Network-Message-Id: e92f4876-70c1-45af-4830-08ddd352eeb4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB6740.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 12:32:10.4330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0133bb48-f790-4560-a64d-ac46a472fbbc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsHqwDYqcz3zs+hGLwmCe9zHvZHur8VDkVc0RKX5V9daT5DFt7D0PcCx7bFyTxvh+mtXxFCLAe0C2F6+VEGqMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3167

On Sat, 2025-08-02 at 00:18 +0000, Jakub Kicinski wrote:
> From: Maher Azzouzi <maherazz04@gmail.com>
>=20
> TCA_MQPRIO_TC_ENTRY_INDEX is validated using
> NLA_POLICY_MAX(NLA_U32, TC_QOPT_MAX_QUEUE), which allows the value
> TC_QOPT_MAX_QUEUE (16). This leads to a 4-byte out-of-bounds stack
> write in the fp[] array, which only has room for 16 elements (0=E2=80=931=
5).
>=20
> Fix this by changing the policy to allow only up to TC_QOPT_MAX_QUEUE - 1=
.
>=20
> Fixes: f62af20bed2d ("net/sched: mqprio: allow per-TC user input of FP
> adminStatus")
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Maher Azzouzi <maherazz04@gmail.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

LGTM!

Reviewed-by: Ferenc Fejes <fejes@inf.elte.hu>


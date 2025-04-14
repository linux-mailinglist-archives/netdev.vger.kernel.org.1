Return-Path: <netdev+bounces-182106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2430A87DD9
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA4318918AE
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 10:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5C426B947;
	Mon, 14 Apr 2025 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZaeUVo44"
X-Original-To: netdev@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011024.outbound.protection.outlook.com [52.103.66.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACEE2580C3;
	Mon, 14 Apr 2025 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744627395; cv=fail; b=cgYFQuQusrSsFd4ZT/aV+wqXZd5tblZ5HTZyNjIUS7utWH9pBZ/LE/gN1t4zonBQYUaG6XtCHtBbrnr+GaRXcgWeI/3k34P60v9wI2Om1JhhLBOifDfY9A+RK368df66kO9MxDGvx32+nustu4fChBtqBeOR0tE/zPN/jWBVwEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744627395; c=relaxed/simple;
	bh=wm110QOsyZnELGtkusSTyPjeDWAxUIRZtclAEwO0Dag=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=To2I9QBclJj5ht1uTYCNgZXpTDRriy/IzEhqM85byZuajQB3XBh0rZCYpnHzoGKBS0zfD98kmZNY9JVBFmEh9Wa517lRUFxa3m8yIn0s+EGEPyJkyc9nbGOCfU6HkKp0/TeJijcEPNN98GNMxm2tU6wV8I7/Bp6ZTHiBI1/BLZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZaeUVo44; arc=fail smtp.client-ip=52.103.66.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLqsMUXvqNYDXgNdmj1O3XWK5ZiFtsPGMsKJkd7tPNseHo0ui0I4xVvEm0FfGsL1Q36z+Hzp4JkHdF6YkN3Ma1N7N7EBCnplYco6V6Lo/T4w4it8aOLVhAv3oYDcA9sfduCku8ueiHVh1urETc+hGtfAWwr9Tv0fpdTNW3t6HOaCPcHdM5sAFGvYkNURvm0ucYl8SjBEo4VAqlwhPXQv3u551gT6BRpfr/xxmKI5dpzAdr/S0gvPZcO76lcq0tZ8uc5Vu1r8zrVdV8MkSjxiZ0dUUjpX0BesSl9WIXO9kYBMlCkhMonztfTDs0QkZnzkN6aoci0RzIVzc2IxnmZmag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wm110QOsyZnELGtkusSTyPjeDWAxUIRZtclAEwO0Dag=;
 b=c9SvsWoUkgV7Z8lh3ZFPE8XqwfyHGva5c8q3DkavcO8w/FYCbqpRUbrXnnZq20Cc7Oon5UjsCnET1mBkUjpzFadvu+b68A6MfHx49ns2rjQcqN2b5u/XpocMexAZJtvWPybTFDbksgaUs5mZHBqrX8L4WF7bzl4TxBl0UPIK3/c5pCCFsJZH8zLbMGQo3eZzjalX5AcrhXtxX0Gr5D/lKz96MfWqI4X6oE7A7/dYM/3R/afiLz/5rg8nQ9t1MgTPgniHZX2p5sOB7lUJ+JxBTEcc483ncamibDmvfRpdlXmvW7o9OUHGgjY3/m0N5vlSwPZB9VlD4gZXpnlceLEOqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wm110QOsyZnELGtkusSTyPjeDWAxUIRZtclAEwO0Dag=;
 b=ZaeUVo44TYPTtrN6wiaG1qGfzJjfXDG/ev3LTztJeK5WCsAaMKr9QVK64CweJNrbX5L5OTXMiPoUdSSuU1vebk2bM+eJGk5CqDVE0e0dKLxCYiNBKlMULnHbINTZIn2OjTkCN+pXDkjcg8vamcm3HqtLL7ebHSBsWB5ag8dK9PsAk5CeidZzsygOmBh4lomjBl8r0cFpBm1ab+8Kxyb+ZNE1B5UMXMPqCelh0LqRFBLrfGwE+ibNq0NVrw75o42iC90x8C0isJElYtZ90Bulgcilvyjxl2rlQ4plOPbRIVnxVspFzuGGy8Q1KmRKOl66wBX3XOXQXJlAxdh41Sj6bw==
Received: from OSZPR01MB8434.jpnprd01.prod.outlook.com (2603:1096:604:183::12)
 by TYWPR01MB9356.jpnprd01.prod.outlook.com (2603:1096:400:1a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Mon, 14 Apr
 2025 10:43:05 +0000
Received: from OSZPR01MB8434.jpnprd01.prod.outlook.com
 ([fe80::7c3f:73bc:3c62:fe7]) by OSZPR01MB8434.jpnprd01.prod.outlook.com
 ([fe80::7c3f:73bc:3c62:fe7%5]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 10:43:05 +0000
Message-ID:
 <OSZPR01MB8434D0CB20CCDB33D1D9DB2098B32@OSZPR01MB8434.jpnprd01.prod.outlook.com>
Date: Mon, 14 Apr 2025 18:42:56 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, razor@blackwall.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH net-next v2] net: bridge: locally receive all multicast
 packets if IFF_ALLMULTI is set
To: Ido Schimmel <idosch@nvidia.com>
References: <TYCPR01MB84378490F19C7BE975037B1698B12@TYCPR01MB8437.jpnprd01.prod.outlook.com>
 <Z_zKfOHxHRr0EC5Q@shredder>
From: Shengyu Qu <wiagn233@outlook.com>
Content-Language: en-US
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <Z_zKfOHxHRr0EC5Q@shredder>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------n6yJrmfeiEImXQpml3VmRxvq"
X-ClientProxiedBy: TY2PR0101CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::28) To OSZPR01MB8434.jpnprd01.prod.outlook.com
 (2603:1096:604:183::12)
X-Microsoft-Original-Message-ID:
 <7c569347-8ece-4ed9-a534-9618897747e3@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZPR01MB8434:EE_|TYWPR01MB9356:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ca461a2-98cb-4bf3-6a59-08dd7b412329
X-MS-Exchange-SLBlob-MailProps:
	V85gaVfRD4++ew0dOHhl6Xscvu48sr33tCXc3iwU+fGg4pS0F4dVV2ftEPC5yQJaX9uOSAQA/28o4FeKjhq92OTG4BxsalrR7qAYQ4wsiCKZnyuCujnZekB5qSZV06lbsyd97oYLbneje3wcVZoCY5GahjKfnv83kMwqvNcDKh2wVW7LUUExxODxuXDfYZGYbi87E2P0AebsUFj2RBvW7rWiLs80XVfXKgvlRFWeuSdnDpBNgX1UtuC0EePFlwLSGWihDmnIIo6F5stegw273yxoeNl/KpryfyQrpvzOh/4lGwscsyzRVBMGZrO58D8lWHy4Dt+kksFH7eb9rpgrXsnhJZpmfd2CYwK/skpgV4cijaaMTEscHxxMpYbnY/oiZ+0n+WdjGqxd2lSwmr5sM3dTh36XQlfe0L3FD3MW+yDgLz9n9WzwuFn2k1keb3QfIKFzhf8iaUgnC3t8DE9AituaFzmjvz2xW9ifpXzfDXyd3Y7H/pLlaI1ZBj7gB2Z12zpd8qymt7kc/TK0X1VJ2hUKvPJI7CylORmdAiApxke7IuSzLHFEWchPLl8zyHbqmvKNwiWnsD2BOR5EZWcy9Lh2Zo7Il1TD4ygHalvVPY8XNqlC0PAhUamdqCL5PJMCTAXzWagrATQs+hRxaH6hxofVARzSt6/FErkLVMieZSMbVyqiN0KvASdu4NqtCqaRnGTUQNlziLbAMfy5n2MAl7T1A/O9E4ZBPirlnQjtJxoSOMb+8IM8LWoyxQjNc12iYIudU72SO2w4MveD1Yc5OXU3su/txDuN/VrX3hNoK5CpUflnSZNEiHEZqeTPLrF5h3ESleyu/gBe8GmWQRKJ7w==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|12121999004|19110799003|6092099012|5072599009|7092599003|8060799006|15080799006|26115399003|26104999006|1602099012|20055399003|440099028|4302099013|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzAyUUhnU0RPYXVYWktJeFhFUUFNM1UrUW1DNlovRG4vVERaUVZSS0tJd2tX?=
 =?utf-8?B?aXhSVUxwdXAzczA5R2JOWkhhNGxUdndxNGhSQ0ZUTHBrUWhXVWVGQW11UDk1?=
 =?utf-8?B?UmRTWXlxRmpaRTRCZXdhUUZpR2FtYVBQcTRlYnFuMXRGZDJyMldZR05rNFMy?=
 =?utf-8?B?d0R5anZRY0x0MzBFSWROM1pBNkp4K044MmtQZzl6SlJBV3pyMXNEV3FRcndU?=
 =?utf-8?B?YnJINUVEM0hsVHY1YXQ4bms3WkhUdlBmNTZubjZId1dMRXpwK0IwUitxRFhF?=
 =?utf-8?B?bnRQdWpYRXBuMEJiZGNENzk2L3ZOL1hvZ1crb3Q4TGpxNVVESDZjTjlDZjVl?=
 =?utf-8?B?TGE5TXFuYWJXTnQwWVp1NElLZVdVeExJOGhKMFYrbDhvOCtma0lsbjh3aEZn?=
 =?utf-8?B?RUdmdVpRWmJ1SmVrb01OSTd0UGFXODd1dEVVYitCRnY3RUd3MVJoUm5mOC9V?=
 =?utf-8?B?dndsTEx2Q0NQNllwVmNhNVVGL0wwTXpWbnIxMXNUSEIvZjhnZ3VhUTI3Mi8r?=
 =?utf-8?B?U3BqbkxBTGdBWWJZMTlWWWs1c0hsK0VmaUg5Q3JON3g4WlhWczEvOWk0S29U?=
 =?utf-8?B?Y3NtYUgrcU82Y3c0MWpFbHQ1dE9WbHhlcHcvM095ckRONk9ZOHlJUzUrUUpX?=
 =?utf-8?B?YmpteG00WFAzS0FLb1YzakdJaWsyemZsVXRFTWduWjh5WUhxU2NqeEdiM082?=
 =?utf-8?B?VXM5TWwvdjRPTG9HRnpsLzhqVnE0QTFncWxsTGR3Z2NqbGRsUkRCSnN0bC9U?=
 =?utf-8?B?ZExjR3plamhGc0JEOUtmSVFmNVcwK2ZlcTR1d2lISk1GVktiU0JFeXZQcmIz?=
 =?utf-8?B?bktLdERUWFhpQ2QrOW1BNGRtMW1HUnFPcS93QVBxZ01ZUm1PNWNlNmNvR3Jz?=
 =?utf-8?B?VjYrcFRwd0VoQWpZS0ZLa0FWdE1wTE1lQXVmUVdqc24rcjYyVVRTNDkrbEJj?=
 =?utf-8?B?VUtVZmVGZGZ4SDBjZEtqeFg1Y1RHZjZPRU15UGJFZDd0SytpazgwZjU5Lyto?=
 =?utf-8?B?a2ZWUjN0azE3SVpLSnd1T2pXdmV3UEp5eEl0ZlYwcDJIRUZGRVFheWwzMGVj?=
 =?utf-8?B?VE9lckhLMzl2SzNNdDc0a055TEhMZEIzRzlWUTlFdG9xOHMxUUQxQlJ3QjhT?=
 =?utf-8?B?SGtOekRwekR5TDU1Zng4RFAwK3FsTHJ1cnBVajR2dGo0bjZZZUVpZitpQmZi?=
 =?utf-8?B?eFNCTnpuMUR4UWxPQTJpdldnRERHL21OU3R0WUF5eHlCd2xaRkpORDJiTnB4?=
 =?utf-8?B?VG1ody93VVhhQlV1T2tqWnZFWlRCQm15azVoaUk1UTM4VmF2R0dncFphNHVw?=
 =?utf-8?B?cGxXc3NLT2Y3UlgrWnFkd2FDaHJGYWdCejdoZ2lKSitYZTFlc2h5S05EZDM3?=
 =?utf-8?B?eHgzL25jZFpsZSt5VFk2NVhHNU5sWWhEMVhRWUQ1cXdzQVluc3labWJRTU1Z?=
 =?utf-8?B?Z3FBSHVOTzExc0VHV0ZCZkVSZzVrVlZGN2tUakpYcHpBNmhObi9haEZUeng0?=
 =?utf-8?B?K1dIdS83ZzlnRC9QTzM3YlAyeUFRL0s2RmdlRXRSZFpQZEJPemdqZThPdlh6?=
 =?utf-8?B?VFp6Qi8xbSs0bHB4VWdadVZkb1JzZ1EvV0tPMlJob0pmekZqd3JFMjgwQUZP?=
 =?utf-8?B?azhCOHJ1MEVzbEVvcDZSRjB6L1FDL3lhcGNDRytlS1RCeHp6dlBmeVpoeENs?=
 =?utf-8?B?ZjlSNkxFclU4Tmx5M3FyRng4NTVkYnV0RmNxNFhIWEYwS1dVMzFlTU9Qc2ky?=
 =?utf-8?B?SHc3d1pBdlZUVklXUFpaM1NTMGRLZEI5ZDhQYWpRZndoSmovZlF0c1crNTN3?=
 =?utf-8?B?a1YvdFVxZDhvRk1JZnRmQWdHSG9oWDRqWkR6TFplNWU5S041dktkRFdkZmp0?=
 =?utf-8?B?Qm5PNGR1NDZXNVJQb3l0Zm5mS2hhaFphcmd3R2YzUk1EWWZXY0wrYjlYYkNl?=
 =?utf-8?Q?M5o5MwJpMbXh9pJVzhNNEH4HF0CMITiJ?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHlBU3pZc1VNYXduTW5TWFNGVHBWUDhRZ1Q0bU9LNmQwbDFZekF3T2VGSHJ0?=
 =?utf-8?B?VmRjMzRPNWFjNjNSN0xUTXdkTjRyY0V4WlZRUGc0c29VekNtODkwS0NOM2E5?=
 =?utf-8?B?OFVaMGQ2QkVnckM5eHk4Tzk1SGgzN1k3amdlUXllaHJ1SGQycVBxLzNHYXFT?=
 =?utf-8?B?V1N4bW9jNm5TZlc4aW8wUlFldkRYYVRNQlpMVnh6bUJ3WXVrbWMzblhHbngy?=
 =?utf-8?B?c2V5cDlwM2dvUjNqa0tEbmhaRTg1ekpIMGlTTzlRc0VpWHUybVBiSzZlQ0FW?=
 =?utf-8?B?Q3l3NWkyWlFyNThMbFQwbFl5QnJnNDFrR1RsLzlxSlhDYXBVT2tIR0JZd2cz?=
 =?utf-8?B?c25HRGRiM1pFMFpOcHpTUDg5eDFrY1hqVHZvR252SFNEUlBPdDBQUkp1RHEr?=
 =?utf-8?B?eUxialk3eFp0WXBYUTE1VGFqZ2tOdEpvMndtNTZjbEFhRWZjWW5LcXNLTW43?=
 =?utf-8?B?T0F4V3JKMjR0YjVYMklnekEwQ1drTm9IZk1SbXB3STZHWG9JaEpha1VJVGZa?=
 =?utf-8?B?QXhxeW1abzJ3NEh5NEloWTF0Z3FEYVMvZ1JqVnpqQ082UDNGNlFReEFIblZ1?=
 =?utf-8?B?OGZTcVpVbnVXaUVrV2d5c3MvTHBHMjdJaUhuVUtkWkZQVjYwcVo1SlRUOEpB?=
 =?utf-8?B?bmdOclU2TDBxNktwdy9kcjMyODZsbUhDNEpPYWdlMElHNDc4MWhHV3Z2L095?=
 =?utf-8?B?UmFOaVRLQ0xsRlFobUdMdlNxbGxVSE9ES3dqMEhuai9UUERyd2hNQ2xqbmg5?=
 =?utf-8?B?WmNtb2w3TXVnY212Yzl6QlpYOWVXM2paRWFIWVVtRnh3cnRST0RHZjlIZEJw?=
 =?utf-8?B?bTQzSUxBUVBQa2cwOW5Ga3JwdUdVSHppalk3eTR1RDM0ck03VE1GcW9lVGor?=
 =?utf-8?B?bUk1T1B2bmYzaTBrbFhPSmdHWE5EWlNVWVBweTlxcWZpOGNjcEdaYU9OR1l1?=
 =?utf-8?B?RFgwOEdyUE1IdENwOWJiR2VHNzVmQ24xdVlvWEpvTjRwdVVKb29PY21rbENw?=
 =?utf-8?B?ZCt3V2hIazJobzN6RXR0RVRmQkRiYUd3SFpiMFdXTWFiZE1lRXkyL2F2STlY?=
 =?utf-8?B?VUdvTWVWbWkyV3FDcVFYNDQ1WmdnUWRmL08xakRWTC80REt0eFAvRURCOS95?=
 =?utf-8?B?WmcyOTJuTXdhSHVvVEpUMWxVbnNTdSt4T3Rid0FDSVBmeHRpTU9WcEJVd2dZ?=
 =?utf-8?B?S0NPbW9hNXA0dWFJMGdpdzFuNlhwY2s4S29rL1o4OTdMVzdaMDFYRGI5Y3Fy?=
 =?utf-8?B?b09kRzk1UGNoeWVIcWc3UXZXQ09ibVFIKzZ0N2N0Qzk3NHpkcU83ZFhyd3BO?=
 =?utf-8?B?cjVuQUxWdk0yNjd5VVlBV1doT01NK1VPNnhxbnBJS2xnN2cxaDBvQm1DMHFi?=
 =?utf-8?B?M2wzMnNMTUFyTHRKcUszSUdMd0czeERVbHBLK2ttYVdDYmd5UXlOcG9EOGhj?=
 =?utf-8?B?aS81TGNJOHVCZDJNc1VNbEJxQ2MxTFJlaVNWd2V4UHJ0aHlzd1lib2IzWVov?=
 =?utf-8?B?bXMyUElRMkdSQ1hwQzZCN2pVZ3B3cCtTTmJlNERqTjYydkd0Y1dLM3NQY0Ji?=
 =?utf-8?B?ZSszMWhOQ0NGc3U4Y3pxM0lsb29CUzVscnBSRm1VS2d3clpwdngvVS8wZ3BS?=
 =?utf-8?B?eDlaZDJtcFVwQzVwQlVKdGtXSm1OSEtQUkxJZTdmWndvUFFHMUxnQTd2Rjhv?=
 =?utf-8?B?WFZMUjBZeFdDZGhYdmgxSDlqZUVmLy95Y0htcFAwMFRnRndvVlJOVmE3aHFX?=
 =?utf-8?Q?wPOEtn6WC/ua/c+Fso=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca461a2-98cb-4bf3-6a59-08dd7b412329
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8434.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 10:43:05.2888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9356

--------------n6yJrmfeiEImXQpml3VmRxvq
Content-Type: multipart/mixed; boundary="------------T2nkRJu5wfUkJn0qxAIChVF8";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: wiagn233@outlook.com, razor@blackwall.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Message-ID: <7c569347-8ece-4ed9-a534-9618897747e3@outlook.com>
Subject: Re: [PATCH net-next v2] net: bridge: locally receive all multicast
 packets if IFF_ALLMULTI is set
References: <TYCPR01MB84378490F19C7BE975037B1698B12@TYCPR01MB8437.jpnprd01.prod.outlook.com>
 <Z_zKfOHxHRr0EC5Q@shredder>
In-Reply-To: <Z_zKfOHxHRr0EC5Q@shredder>

--------------T2nkRJu5wfUkJn0qxAIChVF8
Content-Type: multipart/mixed; boundary="------------cz53AwVQvGJ30XxGrjFa2TvH"

--------------cz53AwVQvGJ30XxGrjFa2TvH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCuWcqCAyMDI1LzQvMTQgMTY6NDIsIElkbyBTY2hpbW1lbCDlhpnpgZM6DQo+IE9uIFNh
dCwgQXByIDEyLCAyMDI1IGF0IDA5OjE2OjEzUE0gKzA4MDAsIFNoZW5neXUgUXUgd3JvdGU6
DQo+PiBJZiBtdWx0aWNhc3Qgc25vb3BpbmcgaXMgZW5hYmxlZCwgbXVsdGljYXN0IHBhY2tl
dHMgbWF5IG5vdCBhbHdheXMgZW5kIHVwDQo+PiBvbiB0aGUgbG9jYWwgYnJpZGdlIGludGVy
ZmFjZSwgaWYgdGhlIGhvc3QgaXMgbm90IGEgbWVtYmVyIG9mIHRoZSBtdWx0aWNhc3QNCj4+
IGdyb3VwLiBTaW1pbGFyIHRvIGhvdyBJRkZfUFJPTUlTQyBhbGxvd3MgYWxsIHBhY2tldHMg
dG8gYmUgcmVjZWl2ZWQNCj4+IGxvY2FsbHksIGxldCBJRkZfQUxMTVVMVEkgYWxsb3cgYWxs
IG11bHRpY2FzdCBwYWNrZXRzIHRvIGJlIHJlY2VpdmVkLg0KPiANCj4gV291bGQgYmUgZ29v
ZCB0byBleHBsYWluIGluIHRoZSBjb21taXQgbWVzc2FnZSB3aHkgdGhpcyBpcyBuZWVkZWQg
d2hlbg0KPiB5b3UgY2FuIGluc3RlYWQgY29uZmlndXJlIHRoZSBicmlkZ2UgYXMgYSByb3V0
ZXIgcG9ydC4gRmVsaXggcHJvdmlkZWQNCj4gdXNlZnVsIGluZm9ybWF0aW9uIG9uIHYxOg0K
PiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2Lzc5MzJjZDIzLTU3MWUtNDY0
Ni1iNWRkLTQ2N2VjODEwNjY5NUBuYmQubmFtZS8NCkhpLA0KDQpUaGFua3MgZm9yIHJlcGx5
LiBJJ2xsIGFkZCB0aGF0IGluIG5leHQgdmVyc2lvbi4NCg0KPiANCj4+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBGZWxpeCBGaWV0a2F1IDxuYmRAbmJkLm5hbWU+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBTaGVuZ3l1IFF1IDx3aWFnbjIzM0BvdXRsb29rLmNvbT4NCj4+IC0tLQ0KPj4gU2luY2Ug
RmVsaXggZGlkbid0IHNlbmQgdjIgZm9yIHRoaXMgcGF0Y2gsIEkgZGVjaWRlZCB0byBkbyBp
dCBieSBteXNlbGYuDQo+IA0KPiBGZWxpeCBwcm92aWRlZCBoaXMgU29CIG9uIHYyPyBJZiBu
b3QsICJSZXBvcnRlZC1ieSIgbWlnaHQgYmUgbW9yZQ0KPiBhcHByb3ByaWF0ZS4NCldpbGwg
Y2hhbmdlLg0KPiANCj4+DQo+PiBDaGFuZ2VzIHNpbmNlIHYxOg0KPj4gICAtIE1vdmUgdG8g
bmV0LW5leHQNCj4+ICAgLSBDaGFuZ2VkIGNvZGUgYWNjb3JkaW5nIHRvIE5pa29sYXkncyBh
ZHZpY2UNCj4+IC0tLQ0KPj4gICBuZXQvYnJpZGdlL2JyX2lucHV0LmMgfCAzICsrLQ0KPj4g
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL25ldC9icmlkZ2UvYnJfaW5wdXQuYyBiL25ldC9icmlkZ2UvYnJf
aW5wdXQuYw0KPj4gaW5kZXggMjMyMTMzYTBmZDIxLi5hZWZjYzM2MTQzNzMgMTAwNjQ0DQo+
PiAtLS0gYS9uZXQvYnJpZGdlL2JyX2lucHV0LmMNCj4+ICsrKyBiL25ldC9icmlkZ2UvYnJf
aW5wdXQuYw0KPj4gQEAgLTE4OSw3ICsxODksOCBAQCBpbnQgYnJfaGFuZGxlX2ZyYW1lX2Zp
bmlzaChzdHJ1Y3QgbmV0ICpuZXQsIHN0cnVjdCBzb2NrICpzaywgc3RydWN0IHNrX2J1ZmYg
KnNrYg0KPj4gICAJCWlmICgobWRzdCB8fCBCUl9JTlBVVF9TS0JfQ0JfTVJPVVRFUlNfT05M
WShza2IpKSAmJg0KPj4gICAJCSAgICBicl9tdWx0aWNhc3RfcXVlcmllcl9leGlzdHMoYnJt
Y3R4LCBldGhfaGRyKHNrYiksIG1kc3QpKSB7DQo+PiAgIAkJCWlmICgobWRzdCAmJiBtZHN0
LT5ob3N0X2pvaW5lZCkgfHwNCj4+IC0JCQkgICAgYnJfbXVsdGljYXN0X2lzX3JvdXRlcihi
cm1jdHgsIHNrYikpIHsNCj4+ICsJCQkgICAgYnJfbXVsdGljYXN0X2lzX3JvdXRlcihicm1j
dHgsIHNrYikgfHwNCj4+ICsJCQkJKGJyLT5kZXYtPmZsYWdzICYgSUZGX0FMTE1VTFRJKSkg
ew0KPiANCj4gVGhlIGFsaWdubWVudCBoZXJlIGlzIG9mZi4gQWxzbywgeW91IGNhbiBkcm9w
IHRoZSBwYXJlbnRoZXNpcy4NCldpbGwgZml4Lg0KDQo+IA0KPj4gICAJCQkJbG9jYWxfcmN2
ID0gdHJ1ZTsNCj4+ICAgCQkJCURFVl9TVEFUU19JTkMoYnItPmRldiwgbXVsdGljYXN0KTsN
Cj4+ICAgCQkJfQ0KPj4gLS0gDQo+PiAyLjQzLjANCj4+DQoNCg==
--------------cz53AwVQvGJ30XxGrjFa2TvH
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
scUnWnv8sErY943hM8MUsMQ5D0P2
=3DUrys
-----END PGP PUBLIC KEY BLOCK-----

--------------cz53AwVQvGJ30XxGrjFa2TvH--

--------------T2nkRJu5wfUkJn0qxAIChVF8--

--------------n6yJrmfeiEImXQpml3VmRxvq
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmf85rEFAwAAAAAACgkQX75KBAfJsRmF
Jw//X3E7rhq9Yfsf9v4osFO+u/HBUgw9a52ztXA40/0qtOY2jLI8mTqVlO8Cjh6hSuweOctRB5/F
b09623Q48CcAENnR0iPKr7sC2AE06vepLoIiwLdae1ds3ORMyxZByFGfKeWmU7mw0vEhgCoYIx7N
pYILfl+wAAd/vQa+b/o3KasFua1Jw4nT70IOMvq7Ta/8cTeUP3Bs3cogpLzvT4N/aLs0Eb6vnlSd
kJrQLzDwYMFhBla7NOSS3qL75r/WaMxTwUuvCn1JOzdT5TxEJ/gMKuSYVHoBFyjcy1BT64aJiKAv
nZnCGzlSlj0I2eMELrGtpic459XVxnZ9/quvTH+pWL0mv2nMNXe2GwQg5DeATrBXfTePUTC8MV+x
+dNL/Cr5Qjxee69E0nEKS7AY7Fo43FsHqEQJF8JDFaVPiId62XzF4iwYdn2CTAk6S9VuONQ4MsVI
oLevo9O6h2w+a5bHgOSHRqRBB96OGwv1Cpzulq7QqezsAhdQmXpEMSYzCRwTKxKGhKjEZCRFPGou
/C2w2tL7gcrse7Wvw2p38G8WpeqZuGK9a+u9uve5cU+gAkORuTK/pehH1tH0z5Y8qlHBav7maEzL
a5Zz2i+yby9A7hbqChYkvJ0PuO66OYUQdY3Gc1Bz2rqjbbBTZg10WlWCynV4f3MxbysXbH2+YP7W
5QQ=
=NgUL
-----END PGP SIGNATURE-----

--------------n6yJrmfeiEImXQpml3VmRxvq--


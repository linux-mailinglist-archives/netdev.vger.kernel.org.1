Return-Path: <netdev+bounces-204883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AB3AFC679
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06B727A2BB7
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32292264B0;
	Tue,  8 Jul 2025 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="WWvCisVq"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010006.outbound.protection.outlook.com [52.101.84.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8645719D065;
	Tue,  8 Jul 2025 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965296; cv=fail; b=pA7lHJLsgYgc1HMqBSOlFkhdhEEiGBA1bT7ivZTiqUiAZh5gWc/ajXTwbBMvs4X0iljqBOJ6khNLytPTlO/jTuieCUrgJh0JMFL/SHxHzzc5lnWkzXf5ZxNPkSP6kWYoZaRDS+3G5H/Quofqiuy7spR46pAh+PyDOBBMIrv88XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965296; c=relaxed/simple;
	bh=GpkYFd73U8SS6tnsgHsfvPw27rUUIg0ELImOl60jOT8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XOlTlTQZZU6zw7T8Z5YK6BbO645TpLzpHp1rT9EmwP3ABa9enbeZDvV8iNxEXg2f7gK2PslJLqzvl9j5nUfWCedNlzvLWkWM8YjthMXxyMBZlxVLbgddf7sOJtbYleAWdPyp9nM1wgelO15h04XIzQTCKUc5+lJoIfZYUQyJcpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=WWvCisVq; arc=fail smtp.client-ip=52.101.84.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbzQ7YEtWyoyLPNmW9pG25L5Jo83Jiz7ve/A14pBRkSafm3zwgGJYaJk4IRoUkSCi19gk/kImiiZ5x5vW+NeA/rROjIhRl40zDpmRWKtuUzFqVGugHdMhabjsSfU7s/cjotDXUU1V4Fu2+GYE4ZqJ/UIy99msq/YTpzC3OU5EkopDuG23row5uzyDqa3qqTx+mhrxowIEkOHFPVbItCI5nC0jFEr+Jv5ezP5EijEg8RYHJ+PrMWILlhS9xUVsTpbUL3f2drokGP38Ao7KS313rxj5iDyReQfHC6Y/2C/8dZnTUQYPAU9nLCZEMAx3vWnt7HSgz77d4O6lyRbs3v9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ak+DtnYQM0ql/jKuK5zuEgzf3Xe8Sprn8ZrU1TWQ1A0=;
 b=DRzxR7AkHby6ZGfHlL3ySn6z0hNqrx+plH5b1HNZI1SPSAWhDdCvguCLXGwBKd7K+uV9Za1mAh4hgwScf4/nnAObxdt/6Yg74WgIQIurJ1lLGbFbxOA0LKElRBRKY5DurQ+2er4shVZFGwZQStTQLogn9/tj3PabKI92BQqwkgoqzfdvu+NG/1wSgDqfoeSshirPW/gEaaaJMlbJqzuAjWF+UDGmK4CUuRPimiknl5rp3L0B6MQorj7kBiHjO/cTpsZb6SnUBas1neKKFljbNqxClaZGS6UhoVzHLnIMH1928afzk3VBj3lBuSogzo6qgZUKEl9XYBmNdlit3msrmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ak+DtnYQM0ql/jKuK5zuEgzf3Xe8Sprn8ZrU1TWQ1A0=;
 b=WWvCisVqf0gs6WBvQRpTq4mb0obdzEx5V25V2baGlOTGLwlcFiSj2Bx88OSSiil4vxFUqwaCEdt/DrEzZkLVwAb5jm/OzS/CQHMGdyhLM/Y8hrC3/3kex0vMLeFSTO1IYr+12V7NaPto+X4ahPz/nou9W1c46LkQBy7FibvhWVw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com (2603:10a6:10:488::13)
 by AM7PR02MB6226.eurprd02.prod.outlook.com (2603:10a6:20b:1b6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 09:01:31 +0000
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d]) by DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 09:01:31 +0000
Message-ID: <727872e9-6043-4dec-9ea5-4523d9c08f18@axis.com>
Date: Tue, 8 Jul 2025 11:01:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6 0/4] net: phy: bcm54811: Fix the PHY initialization
To: Jakub Kicinski <kuba@kernel.org>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 f.fainelli@gmail.com, robh@kernel.org, andrew+netdev@lunn.ch,
 horms@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org
References: <20250704083512.853748-1-kamilh@axis.com>
 <20250707125335.213ed1d7@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?S2FtaWwgSG9yw6FrICgyTik=?= <kamilh@axis.com>
In-Reply-To: <20250707125335.213ed1d7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0326.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::19) To DB5PR02MB10093.eurprd02.prod.outlook.com
 (2603:10a6:10:488::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PR02MB10093:EE_|AM7PR02MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: 240d983f-5705-4106-594a-08ddbdfe07e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|19092799006|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGNHMjhPTmhoRCs4emhiekZmM0t3WGV4bTJsSktRbXh3UG9UUk1FV2NLcXEz?=
 =?utf-8?B?V09xQW1pVTZLczYrU3ZDNWJ5Nk9XSjlFcFNNYWlhWVVrd2h5ZnRLZ25iOGtK?=
 =?utf-8?B?VGU2R0JhdEJCK2ZMN3BxSlY1TVVRM3U5dzRXdG5sWHNOTXdsNTlmYTBsd0NO?=
 =?utf-8?B?bFlKZ0dLdmRsd25uNnErN2JwbjFyRkljNit6NC9xOU1teXoycnlXdWx2T0lF?=
 =?utf-8?B?eGFHMG5rdGZiSFk1djAyMUZDRU9BQlNFZEFXTnBYcnJLazJQbmRVTE9HRDhh?=
 =?utf-8?B?S20xbW15QnRFc1EwYnZ5R2Q0VVhEdzY2d0J0UzhNUnJoMmFFMDBUMmR1ZXhs?=
 =?utf-8?B?OUkyNEpsd0pXYk5kNEo1N3pTSVU0N1NRVEJ2S0Y5SUFsb1NzdUpVelE4T0g5?=
 =?utf-8?B?TERWNFNuL0EwR0IwOWRTS25mVEdBckU1ZEtjQktVdGYyN3FRbU13S3drdnJk?=
 =?utf-8?B?V1RwL01Kck8vajlNNzlDczVseFlwNGFPak9JVFczZVJvL2MrZTlES3hLaE5D?=
 =?utf-8?B?OG03Ym1OV3JVYlFXbTl2dUJveStFdEpmU0ZHdTVOV2t4WjFlczBlZXRsM05B?=
 =?utf-8?B?YlVXdlh5QnN0VndzSTNkQkJDMDBJQ3ZaSlJqdWhBRHlaZlAralVlNVF4V2hE?=
 =?utf-8?B?aU9nU0RzQ2NlaUVqWUFZOGVTVHJmbVRjSVpHYXc0RHI3a01xc3FPcHhLY2Iy?=
 =?utf-8?B?T1VKMU5yU3p4MDNzdGtMY1NIakNnWTMrTWhUSlVTaTJEUE9pWkp0ck50N3JS?=
 =?utf-8?B?cGdOeDJZc1dpOThJOE41dXpTSDBDZ2FsZ2hHOU85L1hDMFpqRTM2ZC9jR3Bn?=
 =?utf-8?B?dVF6V3dtcDVOZy8rbGpDc2JDaWY5aUFxYXJLdGtxcTVPOVNYV2t6cjhSMTZt?=
 =?utf-8?B?cVFoSHUxY3h2cEN5N2tyZUZSd0s5VkF5UEVkQzFnZTF4SHk2MlZmeHhBc1hS?=
 =?utf-8?B?MGppK3BHYWQvWXJoY1REOGVRdHA3eGlsSExIUFA0WWRpc0Q3TGE2c0FNVmor?=
 =?utf-8?B?d0xMbXp5R3B3Q3duVTRqL0pldlpvRG4zbUNBYktUelV4b3BlL0E2T1p6ZXJT?=
 =?utf-8?B?M2gyOHNJa1FRSjQ1M0k2dHY0Z1Y2MllZanE0alI3TFhMaDhUZUx4eGVtVjFt?=
 =?utf-8?B?UFBuYjZWZmczMGw3R1dGNFplWmt3d0hkcUo1OExoZ3gxVmJZbStGUmdWZm44?=
 =?utf-8?B?cTlhS0UwWDhxUy9YaDhJTFQ4TG84ZE56Wi9zeEQxenpKVit3T3kzbEZzYjhP?=
 =?utf-8?B?b1ZkK08wVWlMTkpmcHZqZ2FVTGR4UGNQbVkwSG5jRVhZR3I1anBCOWk4ZmFU?=
 =?utf-8?B?TUt2ZEZaNDRqV01xRThiUDM5T3poUEZtWjBwSXF3ZkFMSW9VVWtnK3J1bGIy?=
 =?utf-8?B?QUNvemVkSXpGYzJiL0xLVjdJbGpLR3hRM0N2V0NkZjVZT3dPd0U2TERRRHRy?=
 =?utf-8?B?UGhMZ2lqU3J0ZkRhZ3hNazV2eTA2ZSsyRi84d05Va21LN002SWQ2TDdLQzlq?=
 =?utf-8?B?TmFDbVpJcHFtdWw4eXAvejdKOTAxb0VkRFppZzN2OGJCSDJYK0N5bXFXNjAz?=
 =?utf-8?B?QWdMdUNuNE9Zd2V6aE5oNVU2VW9oakltSTBSL1dEanQ4QWw0YXE3Z04xa2lR?=
 =?utf-8?B?MEJkMjF2cGVkYXRWd2VJbXBQUGdUN3RWbkV6cVYrSmM4aE1weEx6cHNNKzB3?=
 =?utf-8?B?KytuZ0F0ZlZjaGJOVVE0Z3Fxa1VZZEFlWG9uVlJYaGdZa25EWVp4MXhzM1U0?=
 =?utf-8?B?M0l4Vm9ucmNlWnd0bGhJSEZSbUR2M2xmVWZGT0gxcVRia0twQ0Z1MmhhNEk4?=
 =?utf-8?B?Q3dwWUlTd3c5ZW9va1cyUmtNaDFWY2liM2JpZ3VQM1RkeUtzaGtlUUxmYmlP?=
 =?utf-8?B?WlAzR0I3T08yZGJTcytiNGRySmlwS25JdUwrcit6NHZ0WFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10093.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(19092799006)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGFCcGs4K21EUE1na0JsQmtVU3VaL2piRSs4S05BV2NZZ0VtemtURkdlMU13?=
 =?utf-8?B?TTVocTkzb21UcWJsYm8rZWtuZmFYVU5xUitYTXJUWGoyeW1zY0EwRDFsaEpt?=
 =?utf-8?B?eUR0MDNQY1UrRVNVK1dRR0xoV0xTQ2tLY29WaU5OWmw1WDdsY1pZNWYzalNw?=
 =?utf-8?B?RU1lOWhPSG84YWJhaU4rbVljaFNWQ3BCKzgwMWhnaHI1UnBlTzhyczFzMDJh?=
 =?utf-8?B?M2ZWMTNvSlZkNDhtZHBEZTVpeWpkTTlTS2MzYkxCVWtzYTkvOEhqN3pDR2Nz?=
 =?utf-8?B?Q1ZpYkhiVERPWlAvdmc4UFBVVjVMSUwzZ2xPbFRwVVlDbGh4aEtva0RpaFow?=
 =?utf-8?B?bDJOMDR3RmJ0RmdabUpzRGsxblJSd0ZNV2dKRTRFK0NKemtXOWxYUFJqUFUv?=
 =?utf-8?B?V1B3SDA5ZnVsTlI3TlVCVXhWVzllTGRGSkVIbVl6YlBLN2ttMkVrQ2toQTd4?=
 =?utf-8?B?VDg2RFhxb2pVNXE5QVFKZ1hoT3R6dDY0WFhiU1NmYTYyMUZTbFk3Uy95TmJa?=
 =?utf-8?B?NkMwT2szUVNtZGM2SnhJNC9NckwrQW01bDd1bmNDMHJMWStldHFHZHEzQmVQ?=
 =?utf-8?B?V1AyM0VpVVFtbEgwV1ViTmJmcitvS1BjZTNlQyt0ZnpBdC93K1M0TnFWL1VE?=
 =?utf-8?B?ZEhvazZiL2NtQUYweTAvQkdIcWgwZ2JGTFQwM2ZsSi9xbmM5Q1BKNVd5ZGdo?=
 =?utf-8?B?OGNIRm5TN0h6N1VOWkg2ZXE5b3gxWFB1WGRSOXpzSjFWa1UzYTRueTZQY0My?=
 =?utf-8?B?TlA2SERXTmpNZkEydVl6VzRRaXFka1NUZFNwUlgxMnJrZWZ6eXQxSlovcVZT?=
 =?utf-8?B?WDgvb1p4V3cyc1VWaTF5emxSL3YyRDhWbFkzbVppSEhPdkoweW5HT1RXaHd3?=
 =?utf-8?B?ZFo4SFNLbWtrV0I2b1FsbG1EUFNRMUFrM3hiQVhmNHhHS0ZnSkVkZTV0UVlt?=
 =?utf-8?B?bENXT054OEowZmJJWnE4dFVTbTNEWWl6cTVZSmNJanZqK1VBOTh6SlBsYUZI?=
 =?utf-8?B?dWR4VGx5bGtzdDk1SzB4V1dZK1ZoNUpQM05aOVBCWTZRbTBUb3VHQU9Xb0Nn?=
 =?utf-8?B?Nm80dzJNeGVUM2ZzM2hjSFZYeEVTbnNzdFhxU2VGM2Q0YWhWTmZVWGR4QjIr?=
 =?utf-8?B?bTF5Y0ZaOUR4QUs3NTJlWEsxR2pRQ1VwQXlYOWtmY1hiN1hoR1RVM2orekcz?=
 =?utf-8?B?OXpRVXBESTBRakpuL21YY2d0ajNLd21mais0M3hDYktRTllTT0tEczRmL3l6?=
 =?utf-8?B?QXY3bVFqQklRS2hvVXNIL2ZYSnJwTUY5SGNwaTJhVEoyajhtNFZuZFlUd1Rl?=
 =?utf-8?B?MlJ1T21vaGMzZHNVaXVRd1dNQjNOaUorcGw4TnpHUnB1eHpLUjFjeWRhSFhW?=
 =?utf-8?B?Z2dSVlJ1cWJpZVpZWS9pNUxaKzNCWms1K3ZOTEo2K21xQzdpZGxJNmFRU2ZS?=
 =?utf-8?B?OGN5WEM5VHBLc0xYQ2lGdm1ZMmc3dGJEVnYzL2xtdlMvNnJmaUhLRHZYZ2k2?=
 =?utf-8?B?dWFSQ3BZajVFUnhTSkIyZDdNY0hlTFBuKzdQeDZUQkE2dXRJTVJxdXRxdW80?=
 =?utf-8?B?S0pJZXNwQkxGcHpjalhGa1p3UlBnbHNmRTY5T084NFFFeHdUdkxRUkxDTkRQ?=
 =?utf-8?B?a2RuSHdwMno1Q1hITFE5b3RUeCtwZWk5cGVIRFc1UnhtZE5OS2hrdjFLYjR3?=
 =?utf-8?B?OC8yeTd2RnhzNXJmREMydzJnNDhiYTFNUkcvTkVMVDZsUW9yZVpYM3ZRQ1l1?=
 =?utf-8?B?Sks3Nm9kWUFpYmRQWDV5QWcvd0JjYk5iVkxCcjFzL0phaUlqd2RSVjJyditM?=
 =?utf-8?B?bG9CUXB4NjFFcDBFWEF1U2lXemQwemRjTmZYaS85L2JTOFdWbFUyVmtYRDZW?=
 =?utf-8?B?OUhpU1UxdFRvSUpJZHNwK2hqT3dmNHY3K05mNEZLQTFvcjVKZ3hvM3ByaTQz?=
 =?utf-8?B?Y3BqUXYwV1pOaGRraG9BK0MzMUZrbE5NSXhjd2hpV05vWGFSQ2wwckVPR2dG?=
 =?utf-8?B?a1lIbHl2N0o4Q3IzWW84U0dTR2FPYTJnV0xnTjhxVHBOa2tmRyswK2FDQ2Zj?=
 =?utf-8?B?VU5WbkJvUmNUaDBZb0NKVFhGY0RHSTZaSy9sazc4aUhVSGtsYXdFRzF2enNP?=
 =?utf-8?Q?CXkCdbSmTEfG9efJNgBUazi6a?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240d983f-5705-4106-594a-08ddbdfe07e7
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10093.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 09:01:31.0782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eH1u0KWv0SsQQAgMzOhnGTWIYVkdjGhh0vOt+/GjirK3yWjAqH1Mw3L/+Ilml/zu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6226



On 7/7/25 21:53, Jakub Kicinski wrote:
> On Fri, 4 Jul 2025 10:35:08 +0200 Kamil Horák - 2N wrote:
>> Fix the bcm54811 PHY driver initialization for MII-Lite.
> 
> Sorry for the delay, I went AFK for the long weekend shortly after
> responding to v5. IIUC bcm54811 basically never worked, so I think
> net-next is appropriate for the whole series. Please rebase and strip
> the Fixes tags.
OK tried to do so as best as possible. Keeping the Reviewed tags, hope 
it is correct even when we switched to net-next.
The PHY still initializes and runs correctly in the kernel built from 
net-next.

Kamil


Return-Path: <netdev+bounces-190771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1149FAB8A97
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 17:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC489E69A1
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 15:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA13218593;
	Thu, 15 May 2025 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b="EgAcwcwh"
X-Original-To: netdev@vger.kernel.org
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11020080.outbound.protection.outlook.com [52.101.169.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BEF217666;
	Thu, 15 May 2025 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.169.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747322453; cv=fail; b=DAKu9Ujpj07AB4bxRO6d7mnR/FE9i8XMRDX/AKWFQOJZ6PvDrlN+8vpjnCGBYqmLyJJFaLx6A7R76LI5Mu31WdXx0vweoaFiFSONi4DnuJjaCzAiLft0OpJcI/WAt3/FJrKgBxddeB9ppniQapI3kfkhG0EIWuV2vfri5FnfJ8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747322453; c=relaxed/simple;
	bh=AfkjEfFNvUkyJa3U4wl+vqvZei6Tm2yP4E685CibNbo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QxT8nMLnNULajtTtyyWkpg+LAqMUsa4GOTdTvZcmi2YIJbbLkG7aLb7DYRIBjr2enm853DBEUMC3krOJiwfmsHK4A8tAVttxjrQ6TBpdsakNgWE8xOvruyojLC6n/sSrCvS6uob/3HRb8QnJysT08GV8U7r2gP4rdYltt6N/dFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com; spf=pass smtp.mailfrom=adtran.com; dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b=EgAcwcwh; arc=fail smtp.client-ip=52.101.169.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adtran.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kShYxlfpdNZ2hFc0kGzgGVIVCWaXi4+sqLw782mwgYXtBixRqWOH199BsqAxdwvrPBCBrshcoSyC8CuTQ41alnnvQH51aV2lXfeED6WjFYC6XdHJOCiQ5UuGTaBA2aCWcgAbb6fAUDtnpQkP1xBXYF4GTFJBA5Jy5rRWp09R41dFUjReIoBNGIFnpUGWaGgTBpksAgPw3vSH564vEtVplJDmMvD/vbR/hGNiN/Wbt0XpCYYXODlgVpP+gVcEhDHTZ9bZMhSeVVFCGT6SLbQ6FLpCD/bsK41HNKzhOeo4YQeJlFHR09QXN7gEMiWyt4cYdEVyNhBM1PEYS2zv4xz2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfkjEfFNvUkyJa3U4wl+vqvZei6Tm2yP4E685CibNbo=;
 b=lr5/DY1mwDC630BQ3U1Ms6OSKSCalfQw/GvsVPEVhutHd17kZ56MyCtJVDrGiPqBLITal7PV3Lh+8n6gLZ69XC4rKy+cc8Ei51hQZeMF5vgoapIipMCWBPy7oI0Pwwbgx98jxA2eVIQOqfArtMust8jGEiCU4/FK8vTfsv3Rdw1rRLtbqCDhK3xmyIFtG3CgoV4mnBk+Snda7x5fzCjVjf2kb4ot4//fhxJ9i0Bz8CPSPqXG1tDj1bFYUtli/DfPe7XrJe23KL0jbXEGiPN4fsi6RHbQ8bg+5kLVibKvOmynCvbVFduMaoZXHBorhqWKHD/8AlD7axTZmT8ZkBa6lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adtran.com; dmarc=pass action=none header.from=adtran.com;
 dkim=pass header.d=adtran.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adtran.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfkjEfFNvUkyJa3U4wl+vqvZei6Tm2yP4E685CibNbo=;
 b=EgAcwcwhwtuXPdK58cd0+0xpbMtyFHv0FNVmOGXtw8k3w9GXvF551OkgPUrApDC38JWtQWmPWL7vQ0CePsT9OahKQSi7MPKOOfufVhzRTDaknJRUbv3eOP/no9F73cIWvMzvTmHkqUepk0yN/GeS18gHT+L5Pc80fBvyfRM92yk=
Received: from FR3P281MB2217.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:30::7) by
 FRYP281MB2238.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:41::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.32; Thu, 15 May 2025 15:20:49 +0000
Received: from FR3P281MB2217.DEUP281.PROD.OUTLOOK.COM
 ([fe80::c74c:31e4:c86a:ca51]) by FR3P281MB2217.DEUP281.PROD.OUTLOOK.COM
 ([fe80::c74c:31e4:c86a:ca51%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 15:20:48 +0000
From: Piotr Kubik <piotr.kubik@adtran.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Oleksij Rempel
	<o.rempel@pengutronix.de>, Kory Maincent <kory.maincent@bootlin.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL]Re: [PATCH net-next 2/2] net: pse-pd: Add Si3474 PSE
 controller driver
Thread-Topic: [EXTERNAL]Re: [PATCH net-next 2/2] net: pse-pd: Add Si3474 PSE
 controller driver
Thread-Index: AQHbw4oP7kmltPptQk+Wpi6abB2GU7PQNWOAgAOdZoA=
Date: Thu, 15 May 2025 15:20:47 +0000
Message-ID: <45525374-413a-4381-8c73-4f708c72ad15@adtran.com>
References: <bf9e5c77-512d-4efb-ad1d-f14120c4e06b@adtran.com>
 <036e6a6c-ba45-4288-bc2a-9fd8d860ade6@adtran.com>
 <4783c1aa-d918-4194-90d7-ebc69ddbb789@kernel.org>
In-Reply-To: <4783c1aa-d918-4194-90d7-ebc69ddbb789@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adtran.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB2217:EE_|FRYP281MB2238:EE_
x-ms-office365-filtering-correlation-id: fd52dd24-5bf8-41d8-b0f8-08dd93c411d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?RVRyVFdOQU1HNXQ4cWkydGozMUgzdEtwcnRERHRkc3Z2amMvWUd1REFBRFN1?=
 =?utf-8?B?ZnIyNENqQzVPbFBvM2tQckRvT3dEczJUSHRTL3NOZFQ0RjJoYnRmV2Q3NGhL?=
 =?utf-8?B?ZHAwYmlqaUJZQTRVeXhJclpZbitBaUNjMDdzR05rZC9QRU9kOXBLOVU0OEg5?=
 =?utf-8?B?aThIY0tnNmRDV1dBTFR0Yld5a0hpUlRmcVkvbEQ0OXRCM2swSUIwZEVOczhv?=
 =?utf-8?B?bzhxMlhqWHllYTRkUytLVXFDNzlkeHBsdDhEMmc5Q25kTnQ3ZkpZZ2xvQVcy?=
 =?utf-8?B?K0xueFoyRnVCL25vUk9pV3JqNjlrRk5PSlpSV3JWamEyZnhUR1Vwc3lUR01a?=
 =?utf-8?B?c2xiaElrWDdWYTEwUTYrTlF0cW13UjBvMnBUVG5vRy9ObEF0N0JOWi91Wm8y?=
 =?utf-8?B?aUx2SlRIaG5YTjBaWjVwT281bTcwcUEydEFqNys3M1hNK1gwd2RzNGl5NFV1?=
 =?utf-8?B?b1RtTDBZYzUvaVpzMWM0T0YrbkN2SUoxOUovVGhxeS90bXU5WVExZUx5L3BP?=
 =?utf-8?B?cDFMVk96M0dDdGJhTkFhUEZvdS83bi90M0FPMlYxbC9US2pGOFFHblhqNDhs?=
 =?utf-8?B?SXBWV0NkYktjL1RpYTRTYVdQcWU0S0JQV1JERCtHbWlOdjZzY0dqWms1bGxt?=
 =?utf-8?B?V3pQT2dJb0l5eDNqM2g3NzJSczdESkZXNGtuYlpEbjJndDZ2U2M3bm9mbEJv?=
 =?utf-8?B?M3JrUkl4TzdCMDJLWFB2Z29QYnhHTllDYUNtZk1Vc2hobmZZVkFEVzRDdk1y?=
 =?utf-8?B?a1ZRMm82SCtvVi9wYnRXaFZCeVc1R2F4OHQxZjZ4b1J5OHAzb0d0VDllOEQx?=
 =?utf-8?B?ZEU2U1QyWVZLRGI0c1FhbkxlQzBNR1JGQ21vNCtKSWRFVTFMWXI0K2I4Rk9Z?=
 =?utf-8?B?RVdlcktRU2JsN0NDSFFPbHBxQTZ2OG52N3lNako4aTZpY2FWOGlybmNWenR0?=
 =?utf-8?B?ODhLSkkwRFNFb2lqS3FSSEZvYy9BaW9haGlaa0JxMUYyMWNTTG84YWI0cWFw?=
 =?utf-8?B?ajZYZDBPUXlQSlZ0V0J2c1M3VDh5YThMcjViNVllbUxqM1JpMmY2Q3BaZ1lL?=
 =?utf-8?B?KzNoTFJkeFl3TnU3dzhnWjY2ZHF2SXg4bUp6VVJjeVBrbjhyc2VaeW0wbU1N?=
 =?utf-8?B?OHZhS1dIdVEvZzJFLzM1NzJWZjdpY3FUQW5wbE4yNHFoSDhlMW9sV3UwRzdp?=
 =?utf-8?B?L1hlY0pFZ1dHRmw1dzFQQ2pySjE3NzFhWWhad0U0NyszMmFsczR1S3V1SndY?=
 =?utf-8?B?bGNzM0w4MWRVemFGdzIvMGJscTJHUXNzREpCUHlhVVJ6aEVTckN0WTJESEtp?=
 =?utf-8?B?LzRwcmFsbjNvZFVNK2JOcEZiN1p1VmtxcjNkZUZIcXJFdDMxN2Z0enNMV0JX?=
 =?utf-8?B?aG04UTlvcXhQTy9JTUtpS3ZjRUJQL082Q3pRcHUxaFBZKzJyTFVsZ3RYYlV6?=
 =?utf-8?B?Wk1RTHRESnJKQjY0YVJmb3RjZzZoLzdVQTB0NmJadHEwUzFGSi9OZTFMU3NF?=
 =?utf-8?B?aFFqZGh2UnVCa2M2cE9tNUNQLzEyMjIvMWx0WE50ZHpnWFJ4TzRkWlF4a1dk?=
 =?utf-8?B?ZFczbnFaNldJa0hqV0FXYTFPQjdtSWp4QzNVMVp2VVRhb1Ixd2ZtakczbWJ5?=
 =?utf-8?B?MStWV29CN3hYb29PZjQ1U3ZKempZUzl3bTI0bndzc2hLUEtJbk0wOUV0djUw?=
 =?utf-8?B?U2NIUUI2WUF6dFlwa1FRQ21zQU5KSElOMURUM3JhKzFSeG1TZFgrcnVGbC84?=
 =?utf-8?B?V3hFbm42YkUzeDB0ek5qNGRuWWxHS3kxL0o1OUVsUUs1VlMwTVI4QWZWQmVY?=
 =?utf-8?B?YlRVcjBnZW9ZbFZaYlZ3QnRvbGRJYjBFclRmVXBnSDh6RmV4T0x2SkE3bHh3?=
 =?utf-8?B?LzFuenhkbGJidzZUdlZyYVo0VjNTb1Bka0hvb0lEampKM20zSkljSWhuSlZ2?=
 =?utf-8?B?R0xwQkJRUTZNRGM2a2FNNGJFQ29ic0hLZGJQU1JsNGUrRGxTVWNYaVFaQ0NY?=
 =?utf-8?Q?zHuAyvktUc02J03whG1WxAzWr78fEc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB2217.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bzh6bzhDUXJJZUN4M1pxeE93dVpnR3lZV3pscFNiYXc3QVNxT3dLMGswcWNl?=
 =?utf-8?B?VGFKWm5tU3VhNGVyT1FaUGxaTXJXS0hHbG9MeWNVSUp0TlhCcXVvNVBYQUpH?=
 =?utf-8?B?YjNNcUtidVZnTktSTHF5Ymk1bnRMZXB5NkhpVCtlSm9rbFdIK3prcXpJUjVa?=
 =?utf-8?B?aWgycjF5a1JNdDBqMlBNbXEwVFF3R3pqbjIxOGJLREV6UkVUdkJONWI2VVhi?=
 =?utf-8?B?SFp6ditNdXVHRG1Gd3pxaCtmTnVOYnI2NWQ5Rk85UkRqSW4rT3l5SXZKWXlH?=
 =?utf-8?B?aithOUNkd2s0QklGdkVoTUZzS01GSXA2UEs4NW1BVUdoYWdHWHJ3OFEwdTNR?=
 =?utf-8?B?eDFrSXJRZnd4RnJaR3VWek95bmVLUDJlaUR6QUh4QndTVlByUGxDRGZIaFJV?=
 =?utf-8?B?ekJnWCt0ZHFxMDJlY292UmFmSmJkN3VQbEV6RlcrcHorU1l1S2FtazUrbVRN?=
 =?utf-8?B?V25lN0hNZEx4bkZuL2Y0RHJ3MEs3UWxEaWRPa3MwM0dvczRDaGhXVG1mMW03?=
 =?utf-8?B?UGdJdDZaaFhRd3JJdnlhZnNSZk4rdUEvbENicGNvWmovVDMxWElhd25oUUpG?=
 =?utf-8?B?Myt0YWpMbG1SbUJLRzVIUHJKVE0xb3I5MFE1Q1BHTWk4TmtIc3BGRnErSk5l?=
 =?utf-8?B?N0o5bEU1SGYvWkd0dnBPYjVkTGYzSDRjaWxuaXpZVU41SjZrdU13S1FuejR2?=
 =?utf-8?B?MEFWSFF4TGRWQ3dvNkxmcXRqV2F3NmpLbmFYUlpYaTBySWtvQWhpc2hYeHBS?=
 =?utf-8?B?QzdFajVxcW5PdnZBN1RtNSthQUxkSkFXMUhacCt4N1VhTVh3VDVNbWtXaUJw?=
 =?utf-8?B?MVJvNHJMZ2JhUnZYRzR4YmVqaVdNVnNXQ0F6VDNiSkZqTEdlTlkydmQ2UE15?=
 =?utf-8?B?RnVYWHpsbjkvVWpzcFA0VnJjUmcxRWZnNzNrYnlNMmJaOWlYNkdBM0kxcHo2?=
 =?utf-8?B?eC9kRW13WW11cm1hY1dkSXljUStBWmtGVmd2N2JIYzRrWmxtVUVpa0hzSW5u?=
 =?utf-8?B?QjVLSmJtb0xESTFkRThwQ21IRnFmZEl2Z0xyQ3JEeWR5MEMvQ0FNOEliRDJS?=
 =?utf-8?B?QmpRSEFaTHJGUUFPK2w2WHZNaHBVVDEzaThERzhEWE90bGhSNWx0aVZVQkpY?=
 =?utf-8?B?bE5tWi9OOHVzby9QdlVTLzgyWWk0QUE0NGp0ZmFrTmkrc2Y2OVJkeDBFb1JV?=
 =?utf-8?B?TmFSQ1RMQmo5QTdJTEQza0ZuMnJITkdiNzlnN0tTQThLeHhob0VPK2txdlFY?=
 =?utf-8?B?QWlRdXFRbjRoWUYvay9VM3ErUGRSZmxEYWY3bWl5RlRMY1k3YkhzVzhseU53?=
 =?utf-8?B?VS8zUEZPQUZYVE9kY0dVQUFISFBoRTFqalpsamVBWU53SHBIRTcrT2RqUWds?=
 =?utf-8?B?MXEvYXh4clhuVTFFVkFtd0kybGhqdW43bmZVTVFUeUNIMENRMEs0V1FrYi9Z?=
 =?utf-8?B?a3Ara0ZtYkNGQjBGRWFiMmc5QTJyUkdQVVNFM1owejBSenFGZzN1TmNIU2xm?=
 =?utf-8?B?VXFwd1BvOXh2cnMrdnZMSGhuczhqSHp5Sit0RllVR1FhMEFYVkV5VXZDTm9V?=
 =?utf-8?B?aVdwbmFXZU9FTCt2dFdZaFVQRlQzK28weFYvdXFkb2N3OTFRS21UL0UrWVNG?=
 =?utf-8?B?WmtqMGxCZHpjbm1TUFhFWlN3QVZDYURKeERValAvQU5YRnAyVENsN0Z4N29t?=
 =?utf-8?B?eVdmSGNsOHV5dlkyNGZ4bTFPc0YxOVVkMW92VXc1b2N6MEx0M3NqeXlHc1B6?=
 =?utf-8?B?Tk9WMFB5SFBQTkpzSXYzUytHaTBzZEQybEpvRUZ1cUo0RlVyRHdad21ZNjhr?=
 =?utf-8?B?c3hKUkU0UVJnL0RkaG9WSWZLanp5VGF0TnhBWThTcVdpOUtqYmxvN2RWUlpI?=
 =?utf-8?B?ZWZoV2R4OUV6emd2YmdUcXU5V1duaVp1ayt4QlBNa1RrRzB3cXdMZFFtMHVx?=
 =?utf-8?B?M3dicC9ZNFphbzZZVVFreGFGMW53SDZpcmtuVzUrN0VTdEdrdmxVODlXT2N3?=
 =?utf-8?B?U0VQUFJLMGg2YVAwQjA2aW9RaTkrajF2bUZQSVAxQTc2aDJpWm52MzRZWks5?=
 =?utf-8?B?OW1nd3JzTU9lQmhlSW0xNXlMZitrZ1hFeHVhdDFhSGozTVFabnZYTVFEZjBY?=
 =?utf-8?Q?H7ze1hYSlZatcMS+LLo7OJW/0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CA4B309D2BFC94383256182ACB20DB6@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: adtran.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB2217.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fd52dd24-5bf8-41d8-b0f8-08dd93c411d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 15:20:47.8527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PBhazdpnfVRYcCE9odbbsLX1SZywrKjEaoVz974g6kdfT26bl4+1Z4/UWIYVUEW5R2yaINm3DUipLy7e1JU4ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB2238

VGhhbmtzIEtyenlzenRvZiBmb3IgeW91ciByZXZpZXcsDQoNCj4gT24gMTMvMDUvMjAyNSAwMDow
NiwgUGlvdHIgS3ViaWsgd3JvdGU6DQo+PiArLyogUGFyc2UgcHNlLXBpcyBzdWJub2RlIGludG8g
Y2hhbiBhcnJheSBvZiBzaTM0NzRfcHJpdiAqLw0KPj4gK3N0YXRpYyBpbnQgc2kzNDc0X2dldF9v
Zl9jaGFubmVscyhzdHJ1Y3Qgc2kzNDc0X3ByaXYgKnByaXYpDQo+PiArew0KPj4gKwlzdHJ1Y3Qg
ZGV2aWNlX25vZGUgKnBzZV9ub2RlLCAqbm9kZTsNCj4+ICsJc3RydWN0IHBzZV9waSAqcGk7DQo+
PiArCXUzMiBwaV9ubywgY2hhbl9pZDsNCj4+ICsJczggcGFpcnNldF9jbnQ7DQo+PiArCXMzMiBy
ZXQgPSAwOw0KPj4gKw0KPj4gKwlwc2Vfbm9kZSA9IG9mX2dldF9jaGlsZF9ieV9uYW1lKHByaXYt
Pm5wLCAicHNlLXBpcyIpOw0KPj4gKwlpZiAoIXBzZV9ub2RlKSB7DQo+PiArCQlkZXZfd2Fybigm
cHJpdi0+Y2xpZW50WzBdLT5kZXYsDQo+PiArCQkJICJVbmFibGUgdG8gcGFyc2UgRFQgUFNFIHBv
d2VyIGludGVyZmFjZSBtYXRyaXgsIG5vIHBzZS1waXMgbm9kZVxuIik7DQo+PiArCQlyZXR1cm4g
LUVJTlZBTDsNCj4+ICsJfQ0KPj4gKw0KPj4gKwlmb3JfZWFjaF9jaGlsZF9vZl9ub2RlKHBzZV9u
b2RlLCBub2RlKSB7DQo+IA0KPiBVc2Ugc2NvcGVkIHZhcmlhbnQuIE9uZSBjbGVhbnVwIGxlc3Mu
DQoNCmdvb2QgcG9pbnQNCg0KPiANCj4gDQo+PiArCQlpZiAoIW9mX25vZGVfbmFtZV9lcShub2Rl
LCAicHNlLXBpIikpDQo+PiArCQkJY29udGludWU7DQo+IA0KPiAuLi4NCj4gDQo+PiArDQo+PiAr
CXJldCA9IGkyY19zbWJ1c19yZWFkX2J5dGVfZGF0YShjbGllbnQsIEZJUk1XQVJFX1JFVklTSU9O
X1JFRyk7DQo+PiArCWlmIChyZXQgPCAwKQ0KPj4gKwkJcmV0dXJuIHJldDsNCj4+ICsJZndfdmVy
c2lvbiA9IHJldDsNCj4+ICsNCj4+ICsJcmV0ID0gaTJjX3NtYnVzX3JlYWRfYnl0ZV9kYXRhKGNs
aWVudCwgQ0hJUF9SRVZJU0lPTl9SRUcpOw0KPj4gKwlpZiAocmV0IDwgMCkNCj4+ICsJCXJldHVy
biByZXQ7DQo+PiArDQo+PiArCWRldl9pbmZvKGRldiwgIkNoaXAgcmV2aXNpb246IDB4JXgsIGZp
cm13YXJlIHZlcnNpb246IDB4JXhcbiIsDQo+IA0KPiBkZXZfZGJnIG9yIGp1c3QgZHJvcC4gRHJp
dmVycyBzaG91bGQgYmUgc2lsZW50IG9uIHN1Y2Nlc3MuDQoNCklzIHRoZXJlIGFueSBydWxlIGZv
ciB0aGlzIEknbSBub3QgYXdhcmUgb2Y/IA0KSSdkIGxpa2UgdG8ga25vdyB0aGF0IGRldmljZSBp
cyBwcmVzZW50IGFuZCB3aGF0IHZlcnNpb25zIGl0IHJ1bnMganVzdCBieSBsb29raW5nIGludG8g
ZG1lc2cuDQpUaGlzIGFwcHJvYWNoIGlzIHNpbWlsYXIgdG8gb3RoZXIgZHJpdmVycywgYWxsIGN1
cnJlbnQgUFNFIGRyaXZlcnMgbG9nIGl0IHRoaXMgd2F5Lg0KDQo+IA0KPj4gKwkJIHJldCwgZndf
dmVyc2lvbik7DQo+PiArDQo+PiArCXByaXYtPmNsaWVudFswXSA9IGNsaWVudDsNCj4+ICsJaTJj
X3NldF9jbGllbnRkYXRhKGNsaWVudCwgcHJpdik7DQo+PiArDQo+PiArCXByaXYtPmNsaWVudFsx
XSA9IGkyY19uZXdfYW5jaWxsYXJ5X2RldmljZShwcml2LT5jbGllbnRbMF0sICJzbGF2ZSIsDQo+
PiArCQkJCQkJICAgcHJpdi0+Y2xpZW50WzBdLT5hZGRyICsgMSk7DQo+PiArCWlmIChJU19FUlIo
cHJpdi0+Y2xpZW50WzFdKSkNCj4+ICsJCXJldHVybiBQVFJfRVJSKHByaXYtPmNsaWVudFsxXSk7
DQo+PiArDQo+PiArCXJldCA9IGkyY19zbWJ1c19yZWFkX2J5dGVfZGF0YShwcml2LT5jbGllbnRb
MV0sIFZFTkRPUl9JQ19JRF9SRUcpOw0KPj4gKwlpZiAocmV0IDwgMCkgew0KPj4gKwkJZGV2X2Vy
cigmcHJpdi0+Y2xpZW50WzFdLT5kZXYsICJDYW5ub3QgYWNjZXNzIHNsYXZlIFBTRSBjb250cm9s
bGVyXG4iKTsNCj4+ICsJCWdvdG8gb3V0X2Vycl9zbGF2ZTsNCj4+ICsJfQ0KPj4gKw0KPj4gKwlp
ZiAocmV0ICE9IFNJMzQ3NF9ERVZJQ0VfSUQpIHsNCj4+ICsJCWRldl9lcnIoJnByaXYtPmNsaWVu
dFsxXS0+ZGV2LA0KPj4gKwkJCSJXcm9uZyBkZXZpY2UgSUQgZm9yIHNsYXZlIFBTRSBjb250cm9s
bGVyOiAweCV4XG4iLCByZXQpOw0KPj4gKwkJcmV0ID0gLUVOWElPOw0KPj4gKwkJZ290byBvdXRf
ZXJyX3NsYXZlOw0KPj4gKwl9DQo+PiArDQo+PiArCXByaXYtPm5wID0gZGV2LT5vZl9ub2RlOw0K
Pj4gKwlwcml2LT5wY2Rldi5vd25lciA9IFRISVNfTU9EVUxFOw0KPj4gKwlwcml2LT5wY2Rldi5v
cHMgPSAmc2kzNDc0X29wczsNCj4+ICsJcHJpdi0+cGNkZXYuZGV2ID0gZGV2Ow0KPj4gKwlwcml2
LT5wY2Rldi50eXBlcyA9IEVUSFRPT0xfUFNFX0MzMzsNCj4+ICsJcHJpdi0+cGNkZXYubnJfbGlu
ZXMgPSBTSTM0NzRfTUFYX0NIQU5TOw0KPj4gKw0KPj4gKwlyZXQgPSBkZXZtX3BzZV9jb250cm9s
bGVyX3JlZ2lzdGVyKGRldiwgJnByaXYtPnBjZGV2KTsNCj4+ICsJaWYgKHJldCkgew0KPiANCj4g
Tm8gbmVlZCBmb3Ige30NCj4gDQo+PiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwN
Cj4+ICsJCQkJICAgICAiRmFpbGVkIHRvIHJlZ2lzdGVyIFBTRSBjb250cm9sbGVyXG4iKTsNCj4g
DQo+IE5vIGNsZWFudXAgaGVyZT8gVGhhdCdzIG9kZC4NCj4gDQoNCkluZGVlZCwgd2lsbCBmaXgN
Cg0KPj4gKwl9DQo+PiArDQo+PiArCXJldHVybiByZXQ7DQo+IA0KPiByZXR1cm4gMA0KPiANCg0K
VGhpcyBpcyBhY3R1YWxseSBub3QgbmVlZGVkLiByZXR1cm4gYWJvdmUgd2lsbCByZXR1cm4NCg0K
Pj4gKw0KPj4gK291dF9lcnJfc2xhdmU6DQo+PiArCWkyY191bnJlZ2lzdGVyX2RldmljZShwcml2
LT5jbGllbnRbMV0pOw0KPj4gKwlyZXR1cm4gcmV0Ow0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMg
dm9pZCBzaTM0NzRfaTJjX3JlbW92ZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50KQ0KPj4gK3sN
Cj4+ICsJc3RydWN0IHNpMzQ3NF9wcml2ICpwcml2ID0gaTJjX2dldF9jbGllbnRkYXRhKGNsaWVu
dCk7DQo+PiArDQo+PiArCWkyY191bnJlZ2lzdGVyX2RldmljZShwcml2LT5jbGllbnRbMV0pOw0K
PiANCj4gU28geW91IGZpcnN0IHVucmVnaXN0ZXIgaTJjIGRldmljZSBhbmQgdGhlbiB1bnJlZ2lz
dGVyIHBzZSBjb250cm9sbGVyLg0KPiBGZWVscyBsaWtlIHBvc3NpYmxlIGlzc3VlcywgZGlmZmlj
dWx0IHRvIGRlYnVnLi4uLiBVc2UgZGV2bSByZXNldA0KPiB3cmFwcGVyIGZvciB0aGF0Lg0KPiAN
Cg0Kb2ssIHJpZ2h0DQpzaW5jZSB0aGVyZSBpcyBubyBkZXZtXyB2ZXJzaW9uIG9mIGkyY19uZXdf
YW5jaWxsYXJ5X2RldmljZSgpIA0KSSdsbCByZWdpc3RlciBhIHJlbW92ZSBjYWxsYmFjaw0KDQo+
IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQpUaGFua3MNCi9QaW90cg0K


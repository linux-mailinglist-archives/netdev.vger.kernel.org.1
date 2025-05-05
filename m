Return-Path: <netdev+bounces-187750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA43AA970B
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 17:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A94170682
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 15:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC6C25A2D2;
	Mon,  5 May 2025 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HySKWUKT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3644A17B425
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746457965; cv=fail; b=ZiA4uO0jugS0H8ZqDalM8yIfruLLRF52YMt+WBy/Hzj6NFe6DpiSvY9tcxseA0MNX25sYWDa9wGIAekKNmdm1xiXaMNatM4l4L2QsvD++QGkKOuf2iYOM1F+4Ri4Vvz0As5HJioLurAjPIb92LKrSJj8raIxGK8fKBqlc7hKi1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746457965; c=relaxed/simple;
	bh=b9l256GwMG3OAycJEDbIS1utzWNLdxUYPLdwlvoacGo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SwYEGkUFTFcL3qLZDoPibzV7E4KFIXSOjVM65HtyUE2D70U6De5+zh+5zqw9C/gxeHDKDce77RUWGmtWWXOPNockQsukz8vOA21PEaibg3HNTtkWkNBQVIhOAu+B/jdiWKW6qHQ8lRL2e4K54g5wsxdkc6gqjDKMOFLYjXJxkeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HySKWUKT; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YiGCu1VByduaB1uGy+kwhWmQb9kY7nA5VAjFFn9XlFK2fh/nBVtI4o5iVvOBg4unffqtwMhg0yQ+I4qhM7v+C7vIqcRykRlzdwAw6m7VaZUu7AApQ8R+n3ubzfkxCLsEra9CGrUwKv/ma2bovBo8zqqxjc8IthGjeEy6hF4pAiGmtlizZwfpIjOl6zwVZTWY7PCs2cZ0KkZu82kq1rByzRfPXLEp1uQh7c/RaDL2CdPx0yam+Yqa4cvzUbmmtJoy/lBSlp95vFM5FIw6SrvkRUTRqcOmdluYm/d6RXNOMmXxUh5lLhDKtICbTLCTelCzbgDyOY7sAOuUdvsuvAYBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9l256GwMG3OAycJEDbIS1utzWNLdxUYPLdwlvoacGo=;
 b=ueGkG1Thc5MGRexNgfGm9XHGS9A5gE/DM+eDchPqsleDGlhpsEX+tBMoKcdZxJcZ4o60zq3snDQaoy7RURHnlcfFJ5c14IX2iFsyaPuqGZk6MmqrUO+kdgSf+qJMP1dy64VCrDUPLrXaf3pJGmFO5+dmU3Njifb/WpsJlHEPvC14+cM4vVafUdodGjRSPbIF943m050YT3XZo8TJx3qBwiJWwjs/5gvl9srhGD09N2SuIsVlWPCehNaUyCHymMZgZ6pp+dFuT9yFWT7TJQqGtVUnQBK3LAqD1PQCqoUCWzuzM7EB5yZFdaJ+LgVzxG2VcKL9KczudNvL6BsEqyIPJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9l256GwMG3OAycJEDbIS1utzWNLdxUYPLdwlvoacGo=;
 b=HySKWUKT4BWTRuWdCCct3ra6gKv77pxMb77U4y0YsFmPvKWGBpMym7fsos/LR/CSn5/+qI+XX6DlOJLPcnAHkCXyY50aObVdU0aiq3E2ObezW/5ZOIY3BTHEwV1SWnT+5UP3ieHRVOSJgneNEi2+pf/3E1EnMp4fea/V43vVoYOpY2VtNsG0J08+XQL/fdp0D6G4OrbJExKG0K9wNsxSBISkydK6ej2DJthHu2amd5Yop8Rb0T9mGkKp2hsrLKCE8SUhDmvjHn5tQSt7xmgn8xlWZU/VKxbo98+7ADcGroIOoCr+be1fQBr+2seC3ZGkPPSa3RT2Ih8Hye3RtRcISA==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 SN7PR12MB6691.namprd12.prod.outlook.com (2603:10b6:806:271::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Mon, 5 May 2025 15:12:40 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%4]) with mapi id 15.20.8699.024; Mon, 5 May 2025
 15:12:40 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "stfomichev@gmail.com" <stfomichev@gmail.com>
CC: "jhs@mojatatu.com" <jhs@mojatatu.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "saeed@kernel.org" <saeed@kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next v10 04/14] net: hold netdev instance lock during
 qdisc ndo_setup_tc
Thread-Topic: [PATCH net-next v10 04/14] net: hold netdev instance lock during
 qdisc ndo_setup_tc
Thread-Index: AQHbje0DX5+rdJVuAUCwIzeB0fSvMrPEav8AgAAX3oCAAAGOgA==
Date: Mon, 5 May 2025 15:12:39 +0000
Message-ID: <a834c663507a78acaf1f0b3145cf38c74fe3de09.camel@nvidia.com>
References: <20250305163732.2766420-1-sdf@fomichev.me>
	 <20250305163732.2766420-5-sdf@fomichev.me>
	 <eba9def750047f1789b708b97e376f453f09bfa4.camel@nvidia.com>
	 <aBjUFyaiZ9UHpvze@mini-arch>
In-Reply-To: <aBjUFyaiZ9UHpvze@mini-arch>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|SN7PR12MB6691:EE_
x-ms-office365-filtering-correlation-id: bb79bbb5-9ac1-4063-bd2a-08dd8be746e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZWplaXozYXRpZEFJUnJGUFFTTHVCenJPVWxMUlY3WjZqM3ZCYXlwMU1CcVhT?=
 =?utf-8?B?akpGVEgxdi9INVEyV1NnWXZ4NksyUDFmdzdlTHRoMnBuQXg1SzZLTC9FWDBm?=
 =?utf-8?B?WFMyeU5Sbm5VUE1VSjBMK0VDeHBtallaa3hONFFwSDRidXNtaE9TNTJ4YVBP?=
 =?utf-8?B?STJtQU1YMnNHUFAzUGJ0T041REZyK3F1UitySEZNZy96ZmhWcndnVUZ5VHBB?=
 =?utf-8?B?Rm52TXFMMEduYnB6dmkyaWNEeEpPNHFTY043b21oOXNEU1p5UGpDNytzYjlS?=
 =?utf-8?B?emkrTCtKK1FtQkNtT0NqelJVRTIvTHJxSGhzQ29ldFo5UVYvRzgvNmRZUW8x?=
 =?utf-8?B?MVJkQ01HSzZibXJ0enovWGsvRjhTNlFOeUNhS0NQWGxUbFBES1IrVElUZHhH?=
 =?utf-8?B?VkNlMkJ0cXlkdEdoNGdxaC9sSVNjNHU2Q21DRmxRUm15Rk9DZnBKS1VkQ2dY?=
 =?utf-8?B?WmQ5VFpldHVjK3l1NWpqS0dYMWh1MUVJWmZIcnRSRmpOL1YvTDFnTkg1dVVn?=
 =?utf-8?B?TkdiYWp1NVlmUHpOZmo2cjhWWEtER2ZtN2EyeHRVNXNRYWtCTTBtVDViVFBM?=
 =?utf-8?B?M0E4VVB6K2h3c3BkQjcwK1ZSUU1HazVhbXNIeldmd09VL3hzN2VZQUFhNVJk?=
 =?utf-8?B?a3RUVGQrUHcrUWRHSXRVd25Mdm9IZmNuWTdibWNHdkROZ0lVL3RDUmVDcyt1?=
 =?utf-8?B?OEs2UXRERWVBTVNuK2FvUXE3VXhSRDNkZCtlNUNwbEtGc0VTUkVPdTYwWFFS?=
 =?utf-8?B?enFPZ3dHaERQenRRTDJ3RUVpVUw1S1J5enZzVTBIYnVXSVgyOFlPcFJXTnA3?=
 =?utf-8?B?eWlyQkU0M2dEQ2NEZFZZT0NOK3dyY0NtRnZTV3M3WHZvZ2hibnB3bkJZWWx4?=
 =?utf-8?B?RnpYV3VxTlFnU0VleEZVNTVLMDFxRVJYT0NybWxHZXVPTmd0bVhUUFFVbkk4?=
 =?utf-8?B?K2NJT1JtKys4TWxxajZQNkczMFhWKy9wTlRieWo3SFNJVUFNeFcvUkZEaldz?=
 =?utf-8?B?RnBBbEFSRTNqblBTN0pybXhLK0RyaG1vQ09lY3h3MHE1eEZyVlZBWmNTQ2lK?=
 =?utf-8?B?Sm9vZWd5cmcwakZkdFdhU29GSUI1b1gzbHRaeFpqZitMTGcrbWpUVzBVRXVH?=
 =?utf-8?B?eUVNSUNTMC9Fdm9CUDRLdGRRMkw5WFlCUGRoQUEvaVR5TnhZUlJnellzV2c3?=
 =?utf-8?B?TlcycHNsK3daYTVKYjhaMWlyNldxOTFyeS80cmNOMk54ekpRN0gwMDN4Zkw5?=
 =?utf-8?B?Wk9xa2FqWTZOd3JpOXpoalVSY1ZyMjlva3gydDJ0YVJYMkhDSjlSYVU3a2ZL?=
 =?utf-8?B?VzlCVlVOSWsxd0RUdXpOVlhmVDAxYTFHcWtlYVZ2VnRJQWFNWGRndDFKajM5?=
 =?utf-8?B?QUMwN0R6UndjL3hEQkRESXlmYXVrRkMyUEdHOENJS2p1Lzd1Sm55M0pjNCtE?=
 =?utf-8?B?R1lhR1VVZ2d5SHprN0h2TVEvNm04aUIzOE9BaEhwSjhPK3FVUjVnTCtjQ3VF?=
 =?utf-8?B?L2ppVnVqM1JpT0k4TitybmZUTVJ3Z0pjeTREWCtpeEdPb0ZNSGlPM3IzZWkr?=
 =?utf-8?B?TmhRdkxaZVRGNi9JelVuejE3NXljQjNDcFR5Ym1xVGZYZ3NIbzRkcHNTSnpl?=
 =?utf-8?B?NUJkM04zQlBMQmZyeTNoQk1mTzg1QXhDWGV2cFROWkUxZVdqK1lzMGZzaFph?=
 =?utf-8?B?T0ZuMDdFbGhLanJqZEt4ZitrbWIzdlQrcGhuMXMxalorTnl0T1QyNnVXd21R?=
 =?utf-8?B?dWt3NzJRalZHSmNnOU95am5iRHpFcmd4Ukg0ZE5EMC9UdlAvb0w5SFAzTzlh?=
 =?utf-8?B?YUlQb1BlWFQ1T0U2N09uUzBsMjcyZWlRQXN2Yk1tTng2YmZZVGQzcTUvaGJY?=
 =?utf-8?B?aHBLUlkybTRFR3FpNFFwYk5aVFdMdXBDazVQQ0doelRTdDhBYk8xdW01Qzla?=
 =?utf-8?B?Ni9SMTBaVENmZWlwYitWeXhSZTBETUVEVDF6NG1iVEMyS1RHTUhpSGlDS092?=
 =?utf-8?B?akQ1Z2wwRDNRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QmxCQWhESGZFdGlIWEdUWVdIcDVhMGFFTkowZk5nYzFBY20yNHRqUVpqakpM?=
 =?utf-8?B?WmlxbWtnT2hIODR0ODEzeDMrUElOMjM2eEtPcmRaZlU5bUtlS3hreGQzRDBu?=
 =?utf-8?B?SkJSbGtpbFBrdWdSTGRnOGZodHNnZ0ZuRUh1dlJPdmQ1bnRFcFdFQkpVZmQ4?=
 =?utf-8?B?WGVVV3dWVlkyNGxpNjFTc3dWYlQ5Y29nOEhVYmx4K3FNN3lVKy9vbGx3SGcy?=
 =?utf-8?B?QmVsNmZDV2tqckxLTWI2NXBpMGhoM1ZEU0RvQnhjWXdUTnpoaVNEV1RLbXJk?=
 =?utf-8?B?ZU1XUStHNDNyYmtlTGZvd0hFN0d2eU5JaTFENXpYUms0Y0R0ZFI0VFNGdnFK?=
 =?utf-8?B?VWZmZGxNanNiNHh0ZDdHZ0x2M2dwVmFNNldnM3BKMDA5Uk8rdk9MWnhFb3Na?=
 =?utf-8?B?TFNwVFN4TXMzNXZWQ3BJbFNKc0RtNERVdTFXTmNFVVowelZlMXlMUG9Za0E1?=
 =?utf-8?B?WUF1UXV4R0VaS2Jtd0EzeHNxTmVpUnl5VEVJOWNwakZmMUp5U09GK0IrNGxn?=
 =?utf-8?B?aXlrVForMGttYzRjRWZlMzZzWnZ5NktyOHd6ekpmSVpCcUJuYzRsSUJXYWdJ?=
 =?utf-8?B?U2tZZ3J2djllRmxyQzdKb2kvN3JMN1hjaTYyeU9LOWxXY0paQXEwbElldHVl?=
 =?utf-8?B?b00rbFR1SlJLUWdhRy9vTnFNeGJwYVJWMTlPUXd2MUlZeTZqeHU2M05UL3VR?=
 =?utf-8?B?eHRaeFJ2dXlPeFl2NFVwWVVkdUxvS0Q1MUI4WlZiQ0srZDJUWFpXZFpoQ2hL?=
 =?utf-8?B?V1VrT2tMSmtSYTlRZ1g2STljMUJyZDlSMXRJalNvd1Ivd2VNc3B5YitZcWk3?=
 =?utf-8?B?UkI4YW91d2Eza0ZqeHAvTWVUSVFYaUJxSVg1NmJTRVVyVGRxK00zaC9VcGhI?=
 =?utf-8?B?UTFJODBtb2RkRzVCdHkxL0lpT0NCQVlOT0VQajJ6dzQ5Tkk0YWFHOWR2TEJC?=
 =?utf-8?B?ZXplVENMT0NaRHpVcFJsNERxWERQTjU0UDF0OVhQMGx1T0FtM1JxZEcrbUFT?=
 =?utf-8?B?MzJVcDdqdHkzUlRyNlpHaGFya1JaRkordTFuOEZvcnZ2T3BVZDRlN2hIOTg4?=
 =?utf-8?B?Z1hBdThwc09aQVYwSnFnT1FyMElLeGdrTkJTOXZCOWpqa0g2TzNuYTg2OTJk?=
 =?utf-8?B?YVZWK25WRzdONGlHcGRkOW1JRkhpYnpqTkhKZU5qKy9QWVo4czRSVmh0b2x1?=
 =?utf-8?B?SUZWY1ZOVEVyL0FqWnV1MEl1dVFtdWUrQ3REMkVkZWVVa1R6c2p6VndDVmRJ?=
 =?utf-8?B?S3pYaWkxQUM5bDE5bGNPTDU2OUR0Qmg4STFuOEE3ZWhxeGZQQnRTcTZZY0Ry?=
 =?utf-8?B?MXg3b2NxNE1rT3lVM2dPYlYyTWFrK09kek9ZUnFSbkFteEhNRlRrMlpxaURE?=
 =?utf-8?B?TWJnRnZCOW9YNDcxZFppSlpjcEwxMU1jWTBIZ1JJOGgwK3NKMVpjanNycXhE?=
 =?utf-8?B?WHd3Q0dTUnVyZm01dkFDTmxIMkMxQjFwUXl6d0Jyc3ZBdm9KZnBCdWJKTXJq?=
 =?utf-8?B?bUtEUkh1OUl0eFl6UkwxUitBWURJMGl5Y1BHL0czeThvZjMveDJHZ1A1dk8w?=
 =?utf-8?B?Q1N1TnlKaDVpRlJIcnFqQU1VcFBkRWdGZDNFdmtIc0Jjd1pGNm1La0YwWWxl?=
 =?utf-8?B?MnZnVHRTZ1dDU3psdnZ1eFpPVE5WSEc1Wk1SRmVic2NONk5BYXgwbFlQZzha?=
 =?utf-8?B?bEFMeW1IMEJ3UU1wYWVKKzVhRXM4WTJGUnhqdDc0QU12N0FsZElYMkNnL3Nz?=
 =?utf-8?B?WHdpSUNOcFpKZ0tDUisrTklZeW1qMjFXZGxsbmZsZzR2NlBUeXkxakxUQWFt?=
 =?utf-8?B?ZlMwN0VYTzRIY0ZyZ2wwMTMySzhnVTF2clhudTNkbEx6eWNidHczTWVXa3R0?=
 =?utf-8?B?bkE0ZXpyamFrVHozcTJybFpWS3ExWFFrTTd3UnU4WXBMTm1KM0hxV0I1aG1L?=
 =?utf-8?B?TDNaZzFUbnd1eER6a29xL3BXQzlKQ2w5TUozRi8vblZNaHFzMzh1TzBMU2Qr?=
 =?utf-8?B?czJILzFNbSttWFRkdFFJR0M4R1BwYmV0VVBQK0l1c3l3ajI2Z01qbXpicVJz?=
 =?utf-8?B?eVViYmZzM0FyMTFBVk9LMTA4ajMzN1A5MEU4RExDYmQyNFZVMGJQMTU0T2pm?=
 =?utf-8?Q?0QjsQchDBQVgnHQV/EVLyzPjQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D093F984CB1C154DA9D5C5BBA702A677@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb79bbb5-9ac1-4063-bd2a-08dd8be746e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 15:12:39.9357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0209ug7/j2Or9DE2VrKsE8XY4LwXtjJejGbhXMPC2dTK0mV4wctIw5FajdUnG+eikLggxC942w+t2eiBrACoPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6691

T24gTW9uLCAyMDI1LTA1LTA1IGF0IDA4OjA3IC0wNzAwLCBTdGFuaXNsYXYgRm9taWNoZXYgd3Jv
dGU6DQo+IE9uIDA1LzA1LCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+ID4gZGlmZiAtLWdpdCBhL25l
dC9jb3JlL2Rldi5jIGIvbmV0L2NvcmUvZGV2LmMNCj4gPiBpbmRleCBkMWE4Y2FkMGM5OWMuLjEz
NGNlZGRmN2ZhNSAxMDA2NDQNCj4gPiAtLS0gYS9uZXQvY29yZS9kZXYuYw0KPiA+ICsrKyBiL25l
dC9jb3JlL2Rldi5jDQo+ID4gQEAgLTEyMDIwLDkgKzEyMDIwLDkgQEAgdm9pZA0KPiA+IHVucmVn
aXN0ZXJfbmV0ZGV2aWNlX21hbnlfbm90aWZ5KHN0cnVjdA0KPiA+IGxpc3RfaGVhZCAqaGVhZCwN
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHNrX2J1ZmYgKnNrYiA9
IE5VTEw7DQo+ID4gwqANCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogU2h1
dGRvd24gcXVldWVpbmcgZGlzY2lwbGluZS4gKi8NCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBuZXRkZXZfbG9ja19vcHMoZGV2KTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZGV2X3NodXRkb3duKGRldik7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGRldl90Y3hfdW5pbnN0YWxsKGRldik7DQo+IA0KPiBUaGVyZSBpcyBhIHN5bmNocm9u
aXplX25ldCBoaWRkZW4gaW5zaWRlIG9mIGRldl90Y3hfdW5pbnN0YWxsLCBzbw0KPiBsZXQncyBv
cHMtbG9jayBvbmx5IGRldl9zaHV0ZG93biBoZXJlPyBPdGhlciB0aGFuIHRoYXQsIGRvbid0IHNl
ZQ0KPiBhbnl0aGluZyB3cm9uZy4gQ2FuIHlvdSBzZW5kIHRoaXMgc2VwYXJhdGVseSBhbmQgdGFy
Z2V0IG5ldCB0cmVlPw0KDQpHb3QgaXQsIHNvIGRldl90Y3hfdW5pbnN0YWxsIGNhbid0IGJlIGxv
Y2tlZC4gSSB3YXMgdHJ5aW5nIHRvIGF2b2lkDQpyZXBlYXRlZCBsb2NraW5nL3VubG9ja2luZyBm
b3IgdmFyaW91cyBzdGVwcywgYnV0IEkgZ3Vlc3MgaXQncw0KdW5hdm9pZGFibGUuIEkgdGhpbmsg
dGhlIG9yZGVyaW5nIGFsc28gY2FuJ3QgY2hhbmdlLCBxZGlzY3MgbXVzdCBiZQ0Kc2h1dGRvd24g
YmVmb3JlIGRldl90Y3hfdW5pbnN0YWxsLCBubz8gVG8gYXZvaWQgaW5qZWN0aW5nIG5ldyBwYWNr
ZXRzLg0KDQpJIHdpbGwgc2VuZCB0aGUgcGF0Y2ggdGFyZ2V0ZWQgdG8gbmV0IGxhdGVyIHRvZGF5
LCB5ZXMuDQoNCkNvc21pbi4NCg==


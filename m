Return-Path: <netdev+bounces-123247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBAE96442B
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637271C21F29
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 12:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2131AD3E4;
	Thu, 29 Aug 2024 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nephogine.com header.i=@nephogine.com header.b="TP8UQPTJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2102.outbound.protection.outlook.com [40.107.93.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546B31AC8A9
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933738; cv=fail; b=uqyPAIShtTkTyr4zpOolMTCwCjT0cOhG5rcF/T21jSZ9RgSLjNacK0BRwTG+GmPbnDxeizfkAE8rzFrIf64gfUkoGJdnz+XLlxiDMwUnxAgqU3YSn9Hkj1jxVavneqWGIF8IpFlK4klUIYHOmPf/SMO4/DrimMXuxoaKAXmqpCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933738; c=relaxed/simple;
	bh=E1QhJBuZiwJ3RUa33z5wFUB8lKnqOvJHYaUq3SltmtM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hM+7L8/FM/jZMnLZay0bE4WponZIgYOrhnHfxYfMs5zuOm9db4SntDEavb088Aef+FmZSDtjaP8nvbwM7h4hCEC6fnufGqO9EciLMh+Uzvth345VgWO1k9GQi4B01sNVsx2BL5hZBnClSG6YdyGwM92SXNvFY2ZwqA59eM7TG9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nephogine.com; spf=pass smtp.mailfrom=nephogine.com; dkim=pass (2048-bit key) header.d=nephogine.com header.i=@nephogine.com header.b=TP8UQPTJ; arc=fail smtp.client-ip=40.107.93.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nephogine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nephogine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMLa2xIpZSDngUMOhk4jMxT4r39CcwKqEBvuBWoG/oLj+7BTLG6cTmK864n+8yribk0RkuKANw6+qrNrSgmtSW2vmrWXFIPh3x2krsN2RPw/j5Z+CVmUkk63Lm+UR/4H0Xk3KNQfE/Vm2KlR3wiuo1ZtEGgZFGgYmrLtz+WtRCMi/b1GXQVx6krxxoduUFfgfRooMJYVLxaZlnyG76UIE8VTiKy646Z8sMW0Jy9qhOmBLRcizkWaz5jRXb2i/g4cAl+Jz6VSvp+N9k3ea+Hf7wrjawsd/qBKxTXieQFlGiLBQQwNEeBnjG5UBoOIa80EcHZjistWOWMAC68BTprkHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1QhJBuZiwJ3RUa33z5wFUB8lKnqOvJHYaUq3SltmtM=;
 b=IeI6nS9IFHuAJaGmYYgO6yQt2dwwPUu1D5bSNvQGGPaNUrUOyI2FbDx6he3HensZiFBy1fYg+10LhGRphNESedK63SlZ0N2IC32/7PCteIb5mQAGxWAxe88ppKdq/+HFDz3aDYZ1JrNiArp4ALPiUhWodU5+kwVJTbc1rLEMBk7fsKfDi4EZIqLRmj/V43Q+yuG8xiD5NbUMinQOuDj47/XDauVuDBxnrsGmldzLBSVmWDKNo49/paXa7NdhXc5s0dKwQEn/NiHq4Q3llfbuh6qeAwpGCUYRJWX3A6KgY1MCwCAWrZ7Jfi/+6jb/kPNovLPj0fZS62H8+cxIwUBs+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nephogine.com; dmarc=pass action=none
 header.from=nephogine.com; dkim=pass header.d=nephogine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nephogine.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1QhJBuZiwJ3RUa33z5wFUB8lKnqOvJHYaUq3SltmtM=;
 b=TP8UQPTJQ94HexEJvogpxdK4UuLl9jECkoFHRd6Yvsp684cA4+7W6DgJxN/aBmg7bhBssXsor9mqzs90rabxZ9tLrnSpXxuQHtaNQJSPzJFHFVnsSGc25hqng3q/DyxWZjaCP+VkehH6Q4Xsq0Ef0GaGEhsJTVjrvJDbe9kixf0JkZzBEToe07dCB7Q/7inYt75x5QfodjJvEg5JZEqgpw1j/DR48NXeaSpsAyXrdiZ7Kq+rWUky/AFt1d8vjZ8mWkSOqClTkbaVJTdaFl7Sa2l2IrRRJ71qkBmmuCFdqddRdqcc5zRtBcq2WWxzMnsQBaQwzHvOIXpBavtCVM24NQ==
Received: from SJ0PR13MB5475.namprd13.prod.outlook.com (2603:10b6:a03:425::19)
 by MW5PR13MB5925.namprd13.prod.outlook.com (2603:10b6:303:1c8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Thu, 29 Aug
 2024 12:15:34 +0000
Received: from SJ0PR13MB5475.namprd13.prod.outlook.com
 ([fe80::89e7:f6f0:fe74:999f]) by SJ0PR13MB5475.namprd13.prod.outlook.com
 ([fe80::89e7:f6f0:fe74:999f%3]) with mapi id 15.20.7897.014; Thu, 29 Aug 2024
 12:15:34 +0000
From: Kyle Xu <zhenbing.xu@nephogine.com>
To: Jason Wang <jasowang@redhat.com>, Louis Peens <louis.peens@corigine.com>
CC: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>, "eperezma@redhat.com"
	<eperezma@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	oss-drivers <oss-drivers@corigine.com>
Subject:
 =?gb2312?B?s7e72DogW1JGQyBuZXQtbmV4dCAzLzNdIGRyaXZlcnMvdmRwYTogYWRkIE5G?=
 =?gb2312?Q?P_devices_vDPA_driver?=
Thread-Topic: [RFC net-next 3/3] drivers/vdpa: add NFP devices vDPA driver
Thread-Index: AQHa+g0mFDMUB3ouO0mfRl7ZdtBJ7A==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Thu, 29 Aug 2024 12:15:34 +0000
Message-ID:
 <SJ0PR13MB5475A711FB88A2B3CCBE48FDF4962@SJ0PR13MB5475.namprd13.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nephogine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR13MB5475:EE_|MW5PR13MB5925:EE_
x-ms-office365-filtering-correlation-id: 45e177e9-59ac-43fd-2036-08dcc824488b
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?UEJMRnp2RnNyOHNXVEUyQk5wc2M1NVRCdXE4Ym5mUWRoZ2t2cTJKdCtKYVRj?=
 =?gb2312?B?dUE4T29DS1VhZnJ3blhQS09QYWp3MHdWVGUxRFFtcURIdEJlcjRBTElsMGh3?=
 =?gb2312?B?Ym5kK2pER2FpWE1hcmxveUxsSFZjR3pFdFVjUVp1L3ZrRWMyemc4SmRnVlVP?=
 =?gb2312?B?d2NXWTdTSnlDL29wQUZBNk05OGpPc1ZFdUhFeWxjWTZFTnZ6M2l5MkdUblRZ?=
 =?gb2312?B?YUp4NUVGWGk2djhNTkdsY1VRM1hEVFRkQ2RVTWpjcy9Na1krNkM1NW4wQm0z?=
 =?gb2312?B?SXlBMTMxNnlHc2tSMWN5aHhlTzhzbG85bDExdzF2TXF6a01uV1dwdysvUkNx?=
 =?gb2312?B?cEtzclR5bTU2V3ppTVpzRWxBZS9zQ3ljNUtNSWZoRmdnaEdpQkQvQ09ZT2lZ?=
 =?gb2312?B?VnFqRWh1Z1ZjMnp2OGdFVVlpMlI1ZjR1Qmp4c051QWx6dEh2OEcwYVdZZ1Mx?=
 =?gb2312?B?aEZKQ3poaWR0S1NtRGhHblg5UVA0c2NHeTNqNjVwYW8xcHVxRDR5T3U4WGJB?=
 =?gb2312?B?VWZ6TlhtT2pCeXVUUjJPYVF4TnVVbXJCTDJCNFA5SEpQTFBrVGMzMzNkWUY2?=
 =?gb2312?B?YUJYZGpDMkRJU2xpNnA5NHh5ZVFPU3J5dEd6WG9TQVZXeCtxSGV6U1pLckhu?=
 =?gb2312?B?dHJaUi9WcURUMFNxMVlkNURQQThTWnZuN0dIazFJbkRKUlhBRGFJYkJiVU9N?=
 =?gb2312?B?T0kxRGdScmo1VkJ0cFJlQzVzc0pJczVNWkdvdXQzNkJLbGI5ZStzMTlWSXN1?=
 =?gb2312?B?Z01laDlPTS9lZ1RhdkIrdkFrdUZ6MEx5WU8rcHN3NkdFY01zamNIUTByb2JF?=
 =?gb2312?B?dHJNNTBsY05aRm5UZ2dXUjU3aWxBMWtzTlJ0M2RKY1lWSHp3cVM3NGpIdUhp?=
 =?gb2312?B?OTNQRDhSUWp3cWE2bW9KNWhkbC9DenNaNWV3NUpRc2NTY2pxQmhCY2VXZTRa?=
 =?gb2312?B?TElqa3RqalVzamdjak1JZS94YVpMU0I4NnRvdmJzNjlLZ2VSN3Y1cENNZStP?=
 =?gb2312?B?aHFLbVBhRThVTnRzVlJYN08ydmxPT1Rsck1aWmxTM3IvZE01SVlrNjh0MW9Z?=
 =?gb2312?B?b1Q5dHNZWVNlMnJsOTdWNFFoMzMvcCtqbUkwUVJUSXpCNElFdmtXNkRpcXF5?=
 =?gb2312?B?UFl2ZFE3SDBjeWpQY3h2OGEyaUd4REtUSUdFWktqUlRQQnNmSGUyOE9zNDBK?=
 =?gb2312?B?aEhLTzlOaGxtd0hyTWN5NUxOMDNLZGFiekNJSWovaFAvamdDaTcyTkYyRnpj?=
 =?gb2312?B?K1B1eWVPUFpTSlVWcWI4V0JqZ0Y5L3NqbzBXKzJ5YVpDeVFkejlLVDZMM2hG?=
 =?gb2312?B?cVRJenVXTm05Sk9pdUpyTXpYL0NVbnZIN2YwcXd4emxGR3ZnL0tEWHhNWUUv?=
 =?gb2312?B?TXEvL3B6enY1cjAyaElaQStiaGErTGRRNUhiVFpIaU4xZUVHYWpQelR0ak5U?=
 =?gb2312?B?bXE4OVZReTBUVjhna1k0OW00dlRxcklHejZtUnd1bTVYUENEd2ZjWCs4SUkw?=
 =?gb2312?B?M29kd0pqZzdlVzNZTlhqbDZ3cTh6TjZQczMrejJkSStCUzY0ZklDcnhDUjd6?=
 =?gb2312?B?K3Z2K2VBK2hFbGZkSE1DTzJHYXh1NFRPeTRKd0VIODZFamphWEVkc25DOHdh?=
 =?gb2312?B?ckZPV2piV3lPUjBienI3Y0xEUWkyN3pGVmJKdkVKNWRzaWV6VU1vRlF0UGtK?=
 =?gb2312?B?OURZTHdveVZEelhRYUQ3bmsxQm1Eak9YSHQ1U0pHeXRWaGNFYTQydXRxdDdr?=
 =?gb2312?B?SFJJdkpkL0ZrV0s3S3Z1eUlHUXp3Q3pTR3ZzQ0lJOXZGeGtCM1V4WEVpYVRV?=
 =?gb2312?B?ZlFoV1ZIWXVxZFRTa04vaW9MWHdtbjJEU1p3T210RzFiWEIwUllLUUNzWlRa?=
 =?gb2312?B?MGFIWW9QSS8ycDllRWZ1dXhkVkszdWV6MHcyNjZWdDZITkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR13MB5475.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?V2VMekZ4amVCUGUzNVArWjhSU1JwMDgxcytsdUVDeCtVeUxBQWZBcGNEaGow?=
 =?gb2312?B?eFY0TWs1NjNMamlJRWl0TnJVZGdGVGVkRi9IZlFhc0puTUY0NGlqOHJkNEtI?=
 =?gb2312?B?ejBaQ2pHNzYwTUYrdkROWGF2dzhOOGNrN3FXUjNDZ3BLKzBMbXRpRWUvNFUv?=
 =?gb2312?B?dlJaSzlEYjNQcDAyYndQTXdBWjZXMTdybWYrc2k1S0FueXV3SEcwWnJ2LzlH?=
 =?gb2312?B?YWdadzRtTnBDdXFITGg4NlFIelpQQitKTDl1eXBSeWpUOFUyWEp0STRDZ1dX?=
 =?gb2312?B?ZHh2QU51QnE4ZkI3TUdNWHdsRFZsTkRvZ1lIWEZDeFJDczFTOEFwT1JLcERE?=
 =?gb2312?B?UEpUWnRERjlsOGc0MHE0Mm51RkNFZHRlZmJyVFgyVzMvcjZKSkZ2aktJSDJl?=
 =?gb2312?B?SFIvT21XTjdoRDh1b21aRkl1VW1mNGhOcFJDQjcxL2RFM0F3cWZUbjVjTnBp?=
 =?gb2312?B?VHNIaWpGbnJtTkVGNVA3T1dOeXQzempUUDRZN0JjMTF3Vy9nR2VObjIya05u?=
 =?gb2312?B?NW1QdUJidnZMNFVBbDFhUm8ybENwZ2w4R2h3c0tCZDVDL09uQnRZRzZHSVhY?=
 =?gb2312?B?KzI2cHFzSVluYkFZNXdNYitHMFZENnJwbE1vdXZCUm9QeFdyV2I2dTNVNUVP?=
 =?gb2312?B?eVltTlpsVmNPQlFnRUd2dGZwcTFtZTZaOHIzVFNKYWExWHJRaUlaYWNPcnlT?=
 =?gb2312?B?NU80cWRaUW1HUzlJK0ViYW1DeThmcHB2azkvR21Sa0gxMlRRVVR5S2h2UjMw?=
 =?gb2312?B?VmEvSUFoR0Rsc040U3JaajQvMGFwampNVUcrQ2JOUGg1djU1NE1NOW5nVDBn?=
 =?gb2312?B?cUhMRzJnZW4wekhjOFFsSUtKZXIwNVhYZTlvY1Uvekxrb0ZPS1NYSFNZZjhn?=
 =?gb2312?B?WWJBb085cEM2eldoQ1NENExPWFBxeGJGZmJpajlObW5BYytlRDVrOVRRNDBZ?=
 =?gb2312?B?b1NSRWdyTnJSWWduQ1NSSGg1QzhJUzRFd3BUbThoN1E1L011WXRIZnhnT1Nu?=
 =?gb2312?B?WkNPdW5Qd1FJeUljbklBZmRaUWZsWTAyN0oxV1U2MWdvUlVXdkhVbERHeDBF?=
 =?gb2312?B?WFpROEJnWmN4QUs1dXVBMVM2REFpT05tRXNtUXNoWnJNR2FRcDdHWEdMWFZx?=
 =?gb2312?B?MVJYL3FmcTBlZk04aUJSNW1WL04wdXhZV25NSWxocWNQRWNkUnRmOE1sK092?=
 =?gb2312?B?bEM5NWpUUnBXdnN2Myt0ZWtkZDdVbzBTT044ajlrQmJmVE94L0NUaEtVaXdW?=
 =?gb2312?B?OUtKS0E3bi9FSEdqaktZSEU5QmkvS2lrSmUwSWRMMFNUNU1qejFvWnJWUkhs?=
 =?gb2312?B?RlUxUis4MkE2aE8rcEc0NGg3OUY4WTFNSEVETGg2QVBEeDJpSnNCVDdVOVRU?=
 =?gb2312?B?ay8zRUNLZkkyZ1BOT3dVWGRLVDc3bzFDbWNlOEovU1BtOGRJWlFabW03WVQw?=
 =?gb2312?B?bzhZUkRZdU5HVUFqMlJYZExwVlp6MFpWRW4rN1ZaM25MQlBsMXJtRWx6ZzM1?=
 =?gb2312?B?Vmk4MEFNWEE0RmZlWmRXellwOTJQVHVLR0s5eW5VODBXRWRzTVdTUzF0bFFF?=
 =?gb2312?B?UFlmTCtXNWJVdnNzeEQyMURMZFFsbWsvTko4SjJUaG9BaVdET1RMOHN6UVpG?=
 =?gb2312?B?Z01CeklUT1Y5bXp6dXNFT2ZYYThHbkt2cS9SVDJMSG9Jb0J0bGozOC9Ua1N6?=
 =?gb2312?B?UzZhMTM1SnF0NWN5bWtBOFBlN2ttVG9kU2N2akdvODhyT0hLalF1cVdHNGJC?=
 =?gb2312?B?eDFVVGhQSld3T0dHakFTSVJPTkZlaDdSS2V4ZXdkYzduY3lTSkIxWk9adnNk?=
 =?gb2312?B?SEpqRHhuS3RPbWovVlhXNVpVSDdiMzVxTWZHcUlUbmMvK1VObDVGSFVLWEZ2?=
 =?gb2312?B?Y3RRRi9HOFh0TUpkTFVYZ0hzTytsZWxsaWMzd282eWxiSThRaVhTTkpKVkpk?=
 =?gb2312?B?WTR4MmkxQ0h3TnNqNHBxbU14N1BzWUZ4TXlET3ZDOWh4REJjTEpBd3lYRHZp?=
 =?gb2312?B?c1hhRUNsZUhsYXNORUdvT1diT216OXY3VnpuemVZK1MrREFMZDZRMllZQWNF?=
 =?gb2312?B?dno1UjVibUJjejJmY2R0UjV6UUY4elVlSEJXQ2FmRkRhdFMvNitNSEdzbVdH?=
 =?gb2312?Q?pxmHqbVZYnH6acLZe/br2MFCW?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nephogine.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5475.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e177e9-59ac-43fd-2036-08dcc824488b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 12:15:34.0904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X3PoxACHRuqmO0Fc40TMKwfrThJhWn8hcPH4csVX+ehQt2ZA2bMP8TpNJtpd+XAJ+UpEWPe4dX7INxmcHgzt+Mgx+9E+0OGJHqEmMYAbxwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5925

S3lsZSBYdSC9q7O3u9jTyrz+obBbUkZDIG5ldC1uZXh0IDMvM10gZHJpdmVycy92ZHBhOiBhZGQg
TkZQIGRldmljZXMgdkRQQSBkcml2ZXKhsaGj


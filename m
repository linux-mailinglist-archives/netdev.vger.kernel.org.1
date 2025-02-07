Return-Path: <netdev+bounces-164150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 083DEA2CBEA
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 19:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5F216A419
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 18:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C95C1AD41F;
	Fri,  7 Feb 2025 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="t4Jgsa0N"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D6D19CD19
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738954011; cv=fail; b=PRnu5kvwlcpaQjAOM7DcgsKnTW3yKnGo2hYjsddA9FlEA/p75okldoXU7Mx9XbpU/wb/x6G6DnKD9hTlHu7S0mIs71hgtwl8KYS3XwX7ytCSRVgNfmUDSfGbnPPXgwMHWXXvheYGREZv2+68RpHdLmQ9RTqsCadsOC8JlGEw+Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738954011; c=relaxed/simple;
	bh=B4DUastctlCSzczxAUM8gr+IIhbLJAqOSVYUAHuFr9s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D+3ufKioJvF/rprjX/6eDA5iqcbgQKaDOy3J1y/7eGBEFkgUrxL5ze3Bl1fzlvcStq9Q3ulEN1Ix1DshSTd7DmeMlW9B5XePSBxXeKm3Nv7JYhLVedEkg4v6LkBXu6IVqkOgjBgDWuYnLeSD+qVmWYCyC51iFyxHfcpvJTTuyEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=t4Jgsa0N; arc=fail smtp.client-ip=40.107.236.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrCr5T4YFv7WGzdpiVZiA9cwEfGoxwUYKwqXmSNLA92epUrXjGm4+AfUL0sFVdbYppPAKpadsYpAHRcNexV12M/vC/HE/ZPRaN4tHptdVOswlQmli+A7knKv0p8ik+Gl2ycRNVk2idgAbJ2fryF5af/gPXUQYd64tt4VwG4MQERNaSegq6bfBg2OG0dpQrvYnUMygdrbN819Q4GMxqilM4RQqgoBohk7dRNBwciP7sJ2Zb2CqUhBNwWyuKnGltJzuy2xOhH/UT3031U3mGqN6TRRxqe0CYJhCzmFYLDlP1W64y4FUdGCvAkr/YJxKWKpLEil2RXVJIwKjZ5jFHXY3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4DUastctlCSzczxAUM8gr+IIhbLJAqOSVYUAHuFr9s=;
 b=txO0OaWqNuhyuld3s5boIU8ToAhMSQtsVRPV1Gd83efT3Enz9zRrh0IRjgXR/4kKw/j12LKQqCiv6A+s76fkJNLv5oFW5qUgatAyaoRbvTK98XIumLnXFXM+ZLRDBxTRRJAuFuX1Sz69WNwm9LccJU3r+YIo4YOr3+RIlSoFRxCfTwMMgAXkyEHLGZrCOHqWyMADnP3MxgTdU2MdmiX75gUiNsz1hxL20Jf3dirj/0vrNQ9oDB/jVyAMENwlI5TfXnY5otenlUxK88XcImIF88JMXitbwQ8lpcb/wRjSHuIG2dSaI6nJ/po5IyR+g5wQTtR6myaOVQCOLrjnXXUZKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4DUastctlCSzczxAUM8gr+IIhbLJAqOSVYUAHuFr9s=;
 b=t4Jgsa0NbLkGHhM4aLdhht7d2iJGKUehfai9nchyPRwXXLqzSozhfKpDTWwWXRqIJarU8YeOI4xcZjgvi2ypM4MQoswSUO/Gka3Clo1wCv+M/KCTVSOPrF9OaHiK9x1WQFkHnP+/bpNsz0DTqPsetlOKwpf/Iq8SfbLsCPmMX5Z+4A7O1RHtMu5S7QwuJqU7om9Zv0dBlxEHGtES+TIWuWSNE4q1mUDCgMmLKQw5Wzo9V1XYAIgTUU/lITvuk12oX/3xKihoFL/hRExZ6JCvMYnX40X+lnAF3WLHxEIGLWLhJwQSLcB+nzSwDeEvQiF58Wtul7dXlCmpiocns4eWQg==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 CY8PR11MB7339.namprd11.prod.outlook.com (2603:10b6:930:9f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.11; Fri, 7 Feb 2025 18:46:46 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8422.009; Fri, 7 Feb 2025
 18:46:46 +0000
From: <Tristram.Ha@microchip.com>
To: <rmk+kernel@armlinux.org.uk>
CC: <olteanv@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<Woojung.Huh@microchip.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
Subject: RE: [PATCH RFC net-next 3/4] net: xpcs: add SGMII MAC manual update
 mode
Thread-Topic: [PATCH RFC net-next 3/4] net: xpcs: add SGMII MAC manual update
 mode
Thread-Index: AQHbd9HOt0Tm4eBP8EO6Ba8hN6cKqbM8MY4Q
Date: Fri, 7 Feb 2025 18:46:46 +0000
Message-ID:
 <DM3PR11MB873625080E84FB02511CDE94ECF12@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <Z6NnPm13D1n5-Qlw@shell.armlinux.org.uk>
 <E1tffRO-003Z5o-8u@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1tffRO-003Z5o-8u@rmk-PC.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|CY8PR11MB7339:EE_
x-ms-office365-filtering-correlation-id: f2c70a44-2ca1-4a9e-1b57-08dd47a7c600
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SEhTZy8wejlVcEtWdmY2bUpLdmN1czk2WmRLaTVodU92VUFOYW13b0VPcVBz?=
 =?utf-8?B?MVQ2citEZkVBRFR5RXp0bndTRFBuR2x4UHVMWTBVMEpzTDg3YmJoV3FRc1kr?=
 =?utf-8?B?cHlTNFlDMi9UcldVZnFDK2xDbGMyY2NNQmFGMm52SnVHNFI3czJtM2xIQzRM?=
 =?utf-8?B?NGl3QVltUHFvd3JSdjNWWXNRVnB5TGZBakx3b3BudlpGL3FlTWdSY1l2VXg1?=
 =?utf-8?B?Skl2K2w3eThwa25nN1JUOE5BR2lHUWZGWHFYV0V2OHV6RVRKWXdlTWlKOVEr?=
 =?utf-8?B?WXhHR1A0b3hId2hJYlNpaUJ6TjVvbjRrQVNZbTRiMWY3cTNqMDFWcnNKcXNX?=
 =?utf-8?B?WjF0RzhnNTVkNVhwTWVveWk1NW5rdFZLQ0cyL3Y4eCtOdlJPUGIzcGZ4akho?=
 =?utf-8?B?VHUrdVpKWXEybTJKN3JIaHE1Q0Z6ajNlN0lGVHE4R0JkZFltMFQ3eUVQNXUw?=
 =?utf-8?B?VlVzZDB3NlRVbk5aWVFvRTN2ejd6dTBoNExQbUVTVnVtblUxckhqc0xtUDdl?=
 =?utf-8?B?QmEvM1dETnFXUDhtUUQwODR1TE52c1ZJQ2FsY0l5L1NtUFZzSEV4bnJMTkNx?=
 =?utf-8?B?SGgrVjlvSnE5NUJwS25sOHh5amZjM3drY1AzZlIxdFVsV25vVTF6SkJPUHVG?=
 =?utf-8?B?OC9RNU9pc1FDaFl4dU0raHQ4OVEwanB5LytsWVFlL1MvWW5SZXFRQzVvRUo5?=
 =?utf-8?B?VHRRazdPdVZzMVQyaHVNV0hUbVhjWXhjbHhJUHZLTExUWTRtS21Lb3FZUmY0?=
 =?utf-8?B?Rm95TVNpMWhVUkZ3TlMrLzAvZHNlN0E2ZXhxcGorYU1JTXVkQXkyQnNBdlRT?=
 =?utf-8?B?REdXdjNVdzRVR3J1cXlkSmJoL1k1WUtsbWcvdWxIcVZoSGFPa1hzYmlqbWxH?=
 =?utf-8?B?ZXVBKy83ZzJSRHY5WHdWUS93cEs2Y2p4bXh2L0ovRzBQNURURTVCUWpCNFAy?=
 =?utf-8?B?UStldHgwRy9QVTNiRzk1M3JoM3p4QTdha0x2UDRxZ1JoVDM5cUt4amk5cUNz?=
 =?utf-8?B?YTU2bnpQbnN5c2JlTjkvSmdtNVZFNHpWYmxiVzYyVDYxSkVxVi9QRElnczFQ?=
 =?utf-8?B?QVpjNVpEbG81bThuSnRla1puNTA5Rk5LcVI3ZVlTVVhHTWFXdWEyVkdpa1Zo?=
 =?utf-8?B?cVQ0cHlyK2oxME5uNWd2MWlQQUIrTXVuMnQwU3NST2h1OVowcnNUenpLR01D?=
 =?utf-8?B?YmRTZVV4dUFPdllvMlNOUzkrcmtwNmhUOUtiVnQ4bnJHb3huSEhCUXVDYXZ4?=
 =?utf-8?B?NUhYRTlIVTlmVWhveGVnZ29ETWZDUk9JZEZNTTNVMTIvOWdzVVdCMHNaOVBE?=
 =?utf-8?B?dFI0b1RudS8wRDlwandsc2JqdWIxdVZVdkFySU93U0Zwc21meHc4N3dSb2hs?=
 =?utf-8?B?cEpTWmYwYnBrcWNyY21lZVlCeTZ1bElEZHl5Q1ZneXhNKzVtUFNERTg4QTYy?=
 =?utf-8?B?Y2FPd2tBN0FIQWxpTkluR05BS3V6MEZYT2FZRS94SjdjZlBGRThVZ1VGZzFO?=
 =?utf-8?B?YS9zTDVrOU5EQ0x4a2dRVk9aamRNRkhYbExjL21qNWdQaTF0YTVqSzJoQzhv?=
 =?utf-8?B?ODhXOVowOTNUUGVzNnRQZ1lZVjExaDJOT2lVbEFPVFVZRkJCeG5kTnFSOUU3?=
 =?utf-8?B?NUtYRW4wcXpSOVZxYytXK0lNb21IeE53Y2tvU2tFUWJqekNUSVA2VnFyTjNx?=
 =?utf-8?B?ZGdsQkRHRE9aY3hZNUhyT292SmE1MEx3YXAwYWE2TjJ0WjcxTEc3ZnRVWEhV?=
 =?utf-8?B?eHVBT2QzWHRhUDNPYmZPYWNKRXlFdE1ydzRhRHJNSlh2UjhMbjliM3JKZUlB?=
 =?utf-8?B?dXB2Yk9Eb1U2TkNKL0FlZUJ0Y21jVE9FOEVvVXNZUmEvUWpoVElWWlVLaHFo?=
 =?utf-8?B?eERQendtU0diUzJBeFdvay9EdFJGd0llMzdWVkQ5MjhNUEdINURxWldKNSsx?=
 =?utf-8?Q?kERjyXccrVFMmWfJj7gh0Bb6Hp2y8Ru0?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aE1ldUNZcXhaNjlMMW1DTW1BSVFJWUd1ODJ3WFpLTFhpNDFsVVg4V3Vpdnlo?=
 =?utf-8?B?ZUg4dVJxRGtxOVo5L1Z6V3FjZTdWY3RMVDQ5Um91ZkZZQTF5NUc3V2RxV2VE?=
 =?utf-8?B?WGNjWDhxWG90djhtUUxYY2xTaUxoOWFnZXdYODAxa3ZJWWYway8zbkxUbExr?=
 =?utf-8?B?NTNCKzJmUGxDbEJzbHl0UisrSk5TWU9KNHFqVlRqd0ZrdG5UVHk4ZlVpaVZm?=
 =?utf-8?B?RFlOdktWK0xKYW5hK3NWbU5OcTd2ZDhMQWhtY0FGSDdNVWtmU3BtQXBtNWpt?=
 =?utf-8?B?YkZqbGQ2cEc5b0hhNkpNSDRYZlBSY3FlanFrMlI4dzVCUFJSSnhEN2U5cUJI?=
 =?utf-8?B?ZUN1SnFmT1hnSm1iYjU3WXkxWXgwWDNJb3Q5c2pwWFJNbW9WUkpuUmhHNFgz?=
 =?utf-8?B?Mk1OcTR1cDRsNERGRnNKV2ltTkszK09ONmRnRlRqU0RRS3VYQWxIUFdvNS9p?=
 =?utf-8?B?emswcHNXeEFUT3p5V05hd2RtWXczZ0hJWFp6L1JLdHNmcDJKUkxnRkdwWUY5?=
 =?utf-8?B?TnUrUnFaUERkZHhtZmZwblBkTzJGUWJMNXVrK1NrSkxudTV1Rkg0eUZicUI2?=
 =?utf-8?B?dkJWQWlSUDUyUmRvVEkyLzhRYjk0VTRjS2RnYk5wR1lHWkpFLzdTeDd3SW5B?=
 =?utf-8?B?a2dPbGFnZk1VZ2I5R1crU0ZBT3RCTGxHOG1yMGVwTjhDMkNLbE1kWFJ0RCtk?=
 =?utf-8?B?ZFZMay9UNjYwdllHaGdWZC81WjBxbXJqSXZlN2syK1lpVzVmNWN1cVdRendF?=
 =?utf-8?B?bXhqZzdtREY5eUhwVGZiNXZFZ0cxTHZlMnRkMFBiRGlINWdoeXVtVFRFdHpk?=
 =?utf-8?B?RzRwVCszVGthWW85ZFcxYnFiMHM3WWVyNkdnN1lJdnFyaDNyZ29FdS8rWWM3?=
 =?utf-8?B?TmFpV2JUNVZaZ1IyZjFxOG1CK3VINUV5Nzg1V0pZVnlFc0c5ZjNDVkl1Tjk3?=
 =?utf-8?B?Q3Y5VTNLZTdUR1ROVkIxdlN5WHRMQWMzbDJjb1VLL1BZNmhKWEdZemdoVnhi?=
 =?utf-8?B?RjFwR1l4NjZTSWRyREU1NWQwcE51Wk85R0dWclgzSmM0a09wUkFzbzVWTENw?=
 =?utf-8?B?a2kvMEcrdFA4NUM1UkZ3a0hkVUJCN1hDbzFVcjlDZG5xMlF5ck9HRU1sTktY?=
 =?utf-8?B?RlBjcHdvdWt6R1dsR3NJT2ZaT1l0UG5DQUhRcHZHTUJtY2hMNUc2S1I0OE96?=
 =?utf-8?B?Ums0cWhxTTMydmliRVh1MlBBY0FKRWcwM2FrcFphVEh3bEJyRlBIZFczbUZp?=
 =?utf-8?B?bUNUK3FDRTFVN291bGNqOFNFLzNhazNxTTBra3RXR1JSTmM1V1ZTb0pzWWtp?=
 =?utf-8?B?QUxYZ0xwRkNkcWtHTjBSYXZhN05OQmpMZVd3OVlUZ29Xbld3R05tdVhCZDd2?=
 =?utf-8?B?bVdac00vcUxMTWZ1TERhQzJrMkRZQ051UTRsSE1qckdQVEQreGozRVVmYmZs?=
 =?utf-8?B?RGd1SEx2bXhHYVhWQXR1ZWwyamY0TTZSZ1Z5VFI2U0EyNHpzSU1Dd3FmV0xl?=
 =?utf-8?B?N0dnUE5ZMUlXeUxvMHFVMmxZK0x2bTcvTXJvbXB6cGt0MGtBcmNJOURoem96?=
 =?utf-8?B?VStLVkxESWI0V1pYVm1OV3JTR3RManU5RzQ0bHBBZ2hxdUc5cU9WTXRxalVX?=
 =?utf-8?B?YnBzRkt0OGVURDk0NHB3OHphajNsY25GcXBXVXdMeXF4QWVIbGNBQi81YTdV?=
 =?utf-8?B?QzZrMzA0STlyNHlFS29vakRTdHpMaVhwYU9MMWxyVUpqengwRk9aeDBVL29H?=
 =?utf-8?B?S3pBSFAvR0hJbHlUREVNZzhRSTFzV2VBZFVTQ2psQVVRMGptSCtMV1FzV1Ay?=
 =?utf-8?B?RWVjNjhnaCs0cjF6UG5IcDlodHhUR3pGUm9rNU5lNjVuYUxQR2ZRc2Z5Y0wz?=
 =?utf-8?B?eGUzOThtSStWSTRyWTg1V0NNVFppVjdJY2t3OVRlZ25mejN5RzRpMEZFejV3?=
 =?utf-8?B?cWNUcU5zQVE1b3E5UkNOTEVtQ0w0eXEzNVdLU3FoS0JxWnp3ZXVmamFib0Zh?=
 =?utf-8?B?OVVhM1VMc1VhMStGMEk4Y3dXQ25NM3pKNmJtZ3pObk45YklwR3Jxd3owbGJu?=
 =?utf-8?B?MEp5YnJHOFZGQ0xBRFdjdDNZb0x5SDd1djhMd0NkZURCdkdLT2ltWVVrVEtV?=
 =?utf-8?Q?DQqvlxR5evNJbBgwEj3o0XQQg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c70a44-2ca1-4a9e-1b57-08dd47a7c600
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 18:46:46.3299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: enWem4XDp3cGqDakQ7gHfWVde0Vs4jEbjJ19O1hIXv9wjfuFzn06dnw7OyvOXmdfRGZ1Rp/g2oLsH+dEUPLyuU4YUgs6y60hAIq2yYjbHaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7339

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSdXNzZWxsIEtpbmcgPHJta0Bh
cm1saW51eC5vcmcudWs+IE9uIEJlaGFsZiBPZiBSdXNzZWxsIEtpbmcgKE9yYWNsZSkNCj4gU2Vu
dDogV2VkbmVzZGF5LCBGZWJydWFyeSA1LCAyMDI1IDU6MjggQU0NCj4gVG86IFRyaXN0cmFtIEhh
IC0gQzI0MjY4IDxUcmlzdHJhbS5IYUBtaWNyb2NoaXAuY29tPg0KPiBDYzogVmxhZGltaXIgT2x0
ZWFuIDxvbHRlYW52QGdtYWlsLmNvbT47IFVOR0xpbnV4RHJpdmVyDQo+IDxVTkdMaW51eERyaXZl
ckBtaWNyb2NoaXAuY29tPjsgV29vanVuZyBIdWggLSBDMjE2OTkNCj4gPFdvb2p1bmcuSHVoQG1p
Y3JvY2hpcC5jb20+OyBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+OyBIZWluZXIgS2FsbHdl
aXQNCj4gPGhrYWxsd2VpdDFAZ21haWwuY29tPjsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZl
bWxvZnQubmV0PjsgRXJpYyBEdW1hemV0DQo+IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIg
S2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pDQo+IDxwYWJlbmlAcmVkaGF0
LmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIFJGQyBuZXQt
bmV4dCAzLzRdIG5ldDogeHBjczogYWRkIFNHTUlJIE1BQyBtYW51YWwgdXBkYXRlIG1vZGUNCj4g
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQNCj4gaXMgc2FmZQ0KPiANCj4gT2xkZXIgcmV2
aXNpb25zIG9mIHRoZSBYUENTIElQIGRvIG5vdCBzdXBwb3J0IHRoZSBNQUNfQVVUT19TVyBmbGFn
IGFuZA0KPiBuZWVkIHRoZSBCTUNSIHJlZ2lzdGVyIHVwZGF0ZWQgd2l0aCB0aGUgc3BlZWQgaW5m
b3JtYXRpb24gZnJvbSB0aGUgUEhZLg0KPiBTcGxpdCB0aGUgRFdfWFBDU19TR01JSV9NT0RFX01B
QyBtb2RlIGludG8gX0FVVE8gYW5kIF9NQU5VQUwgdmFyaWFudHMsDQo+IHdoZXJlIF9BVVRPIG1v
ZGUgbWVhbnMgdGhlIHVwZGF0ZSBoYXBwZW5zIGluIGhhcmR3YXJlIGF1dG9ub21vdXNseSwNCj4g
d2hlcmVhcyB0aGUgX01BTlVBTCBtb2RlIG1lYW5zIHRoYXQgd2UgbmVlZCB0byB1cGRhdGUgdGhl
IEJNQ1IgcmVnaXN0ZXINCj4gd2hlbiB0aGUgbGluayBjb21lcyB1cC4NCj4gDQo+IFRoaXMgd2ls
bCBiZSByZXF1aXJlZCBmb3IgdGhlIG9sZGVyIFhQQ1MgSVAgZm91bmQgaW4gS1NaOTQ3Ny4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFJ1c3NlbGwgS2luZyAoT3JhY2xlKSA8cm1rK2tlcm5lbEBhcm1s
aW51eC5vcmcudWs+DQo+IC0tLQ0KPiBUaGlzIG5lZWRzIGZ1cnRoZXIgaW5wdXQgZnJvbSBUcmlz
dHJhbSBIYSAvIE1pY3JvY2hpcCB0byB3b3JrIG91dCBhIHdheQ0KPiB0byBkZXRlY3QgS1NaOTQ3
NyBhbmQgc2V0IERXX1hQQ1NfU0dNSUlfTU9ERV9NQUNfTUFOVUFMLiBPbiBpdHMgb3duLA0KPiB0
aGlzIHBhdGNoIGRvZXMgbm90aGluZy4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9wY3MvcGNzLXhw
Y3MuYyB8IDE5ICsrKysrKysrKysrKystLS0tLS0NCj4gIGRyaXZlcnMvbmV0L3Bjcy9wY3MteHBj
cy5oIHwgMTEgKysrKysrKystLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygr
KSwgOSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9wY3MvcGNz
LXhwY3MuYyBiL2RyaXZlcnMvbmV0L3Bjcy9wY3MteHBjcy5jDQo+IGluZGV4IDlkNTRjMDRlZjZl
ZS4uMWViYTBjNTgzZjE2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9wY3MvcGNzLXhwY3Mu
Yw0KPiArKysgYi9kcml2ZXJzL25ldC9wY3MvcGNzLXhwY3MuYw0KPiBAQCAtNzA2LDcgKzcwNiw4
IEBAIHN0YXRpYyBpbnQgeHBjc19jb25maWdfYW5lZ19jMzdfc2dtaWkoc3RydWN0IGR3X3hwY3Mg
KnhwY3MsDQo+ICAgICAgICAgICAgICAgICBicmVhazsNCj4gICAgICAgICB9DQo+IA0KPiAtICAg
ICAgIGlmICh4cGNzLT5zZ21paV9tb2RlID09IERXX1hQQ1NfU0dNSUlfTU9ERV9NQUMpDQo+ICsg
ICAgICAgaWYgKHhwY3MtPnNnbWlpX21vZGUgPT0gRFdfWFBDU19TR01JSV9NT0RFX01BQ19BVVRP
IHx8DQo+ICsgICAgICAgICAgIHhwY3MtPnNnbWlpX21vZGUgPT0gRFdfWFBDU19TR01JSV9NT0RF
X01BQ19NQU5VQUwpDQo+ICAgICAgICAgICAgICAgICB0eF9jb25mID0gRFdfVlJfTUlJX1RYX0NP
TkZJR19NQUNfU0lERV9TR01JSTsNCj4gICAgICAgICBlbHNlDQo+ICAgICAgICAgICAgICAgICB0
eF9jb25mID0gRFdfVlJfTUlJX1RYX0NPTkZJR19QSFlfU0lERV9TR01JSTsNCj4gQEAgLTcyMSwx
MSArNzIyLDE0IEBAIHN0YXRpYyBpbnQgeHBjc19jb25maWdfYW5lZ19jMzdfc2dtaWkoc3RydWN0
IGR3X3hwY3MNCj4gKnhwY3MsDQo+ICAgICAgICAgbWFzayA9IERXX1ZSX01JSV9ESUdfQ1RSTDFf
Mkc1X0VOIHwNCj4gRFdfVlJfTUlJX0RJR19DVFJMMV9NQUNfQVVUT19TVzsNCj4gDQo+ICAgICAg
ICAgc3dpdGNoICh4cGNzLT5zZ21paV9tb2RlKSB7DQo+IC0gICAgICAgY2FzZSBEV19YUENTX1NH
TUlJX01PREVfTUFDOg0KPiArICAgICAgIGNhc2UgRFdfWFBDU19TR01JSV9NT0RFX01BQ19BVVRP
Og0KPiAgICAgICAgICAgICAgICAgaWYgKG5lZ19tb2RlID09IFBIWUxJTktfUENTX05FR19JTkJB
TkRfRU5BQkxFRCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgdmFsID0gRFdfVlJfTUlJX0RJ
R19DVFJMMV9NQUNfQVVUT19TVzsNCj4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiANCj4gKyAg
ICAgICBjYXNlIERXX1hQQ1NfU0dNSUlfTU9ERV9NQUNfTUFOVUFMOg0KPiArICAgICAgICAgICAg
ICAgYnJlYWs7DQo+ICsNCj4gICAgICAgICBjYXNlIERXX1hQQ1NfU0dNSUlfTU9ERV9QSFlfSFc6
DQo+ICAgICAgICAgICAgICAgICBtYXNrIHw9IERXX1ZSX01JSV9ESUdfQ1RSTDFfUEhZX01PREVf
Q1RSTDsNCj4gICAgICAgICAgICAgICAgIHZhbCB8PSBEV19WUl9NSUlfRElHX0NUUkwxX1BIWV9N
T0RFX0NUUkw7DQo+IEBAIC0xMTUxLDcgKzExNTUsOSBAQCBzdGF0aWMgdm9pZCB4cGNzX2xpbmtf
dXBfc2dtaWlfMTAwMGJhc2V4KHN0cnVjdCBkd194cGNzDQo+ICp4cGNzLA0KPiAgew0KPiAgICAg
ICAgIGludCByZXQ7DQo+IA0KPiAtICAgICAgIGlmIChuZWdfbW9kZSA9PSBQSFlMSU5LX1BDU19O
RUdfSU5CQU5EX0VOQUJMRUQpDQo+ICsgICAgICAgaWYgKG5lZ19tb2RlID09IFBIWUxJTktfUENT
X05FR19JTkJBTkRfRU5BQkxFRCAmJg0KPiArICAgICAgICAgICAhKGludGVyZmFjZSA9PSBQSFlf
SU5URVJGQUNFX01PREVfU0dNSUkgJiYNCj4gKyAgICAgICAgICAgICB4cGNzLT5zZ21paV9tb2Rl
ID09IERXX1hQQ1NfU0dNSUlfTU9ERV9NQUNfTUFOVUFMKSkNCj4gICAgICAgICAgICAgICAgIHJl
dHVybjsNCj4gDQo+ICAgICAgICAgaWYgKGludGVyZmFjZSA9PSBQSFlfSU5URVJGQUNFX01PREVf
MTAwMEJBU0VYKSB7DQo+IEBAIC0xMTY4LDEwICsxMTc0LDExIEBAIHN0YXRpYyB2b2lkIHhwY3Nf
bGlua191cF9zZ21paV8xMDAwYmFzZXgoc3RydWN0DQo+IGR3X3hwY3MgKnhwY3MsDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18pOw0KPiAgICAgICAgIH0NCj4gDQo+
IC0gICAgICAgcmV0ID0geHBjc193cml0ZSh4cGNzLCBNRElPX01NRF9WRU5EMiwgTUlJX0JNQ1Is
DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICBtaWlfYm1jcl9lbmNvZGVfZml4ZWQoc3BlZWQs
IGR1cGxleCkpOw0KPiArICAgICAgIHJldCA9IHhwY3NfbW9kaWZ5KHhwY3MsIE1ESU9fTU1EX1ZF
TkQyLCBNSUlfQk1DUiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICBCTUNSX1NQRUVEMTAw
MCB8IEJNQ1JfRlVMTERQTFggfCBCTUNSX1NQRUVEMTAwLA0KPiArICAgICAgICAgICAgICAgICAg
ICAgICAgIG1paV9ibWNyX2VuY29kZV9maXhlZChzcGVlZCwgZHVwbGV4KSk7DQo+ICAgICAgICAg
aWYgKHJldCkNCj4gLSAgICAgICAgICAgICAgIGRldl9lcnIoJnhwY3MtPm1kaW9kZXYtPmRldiwg
IiVzOiB4cGNzX3dyaXRlIHJldHVybmVkICVwZVxuIiwNCj4gKyAgICAgICAgICAgICAgIGRldl9l
cnIoJnhwY3MtPm1kaW9kZXYtPmRldiwgIiVzOiB4cGNzX21vZGlmeSByZXR1cm5lZCAlcGVcbiIs
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBFUlJfUFRSKHJldCkpOw0KPiAg
fQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3Bjcy9wY3MteHBjcy5oIGIvZHJpdmVy
cy9uZXQvcGNzL3Bjcy14cGNzLmgNCj4gaW5kZXggODkyYjg1NDI1Nzg3Li45NjExN2JkOWUyYjYg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3Bjcy9wY3MteHBjcy5oDQo+ICsrKyBiL2RyaXZl
cnMvbmV0L3Bjcy9wY3MteHBjcy5oDQo+IEBAIC0xMjEsMTUgKzEyMSwyMCBAQCBlbnVtIGR3X3hw
Y3Nfc2dtaWlfMTBfMTAwIHsNCj4gIH07DQo+IA0KPiAgLyogVGhlIFNHTUlJIG1vZGU6DQo+IC0g
KiBEV19YUENTX1NHTUlJX01PREVfTUFDOiB0aGUgWFBDUyBhY3RzIGFzIGEgTUFDLCByZWFkaW5n
IGFuZA0KPiBhY2tub3dsZWRnaW5nDQo+IC0gKiB0aGUgY29uZmlnIHdvcmQuDQo+ICsgKiBEV19Y
UENTX1NHTUlJX01PREVfTUFDX0FVVE86IHRoZSBYUENTIGFjdHMgYXMgYSBNQUMsIGFjY2VwdGlu
ZyB0aGUNCj4gKyAqIHBhcmFtZXRlcnMgZnJvbSB0aGUgUEhZIGVuZCBvZiB0aGUgU0dNSUkgbGlu
ayBhbmQgYWNrbm93bGVkZ2luZyB0aGUNCj4gKyAqIGNvbmZpZyB3b3JkLiBUaGUgWFBDUyBhdXRv
bm9tb3VzbHkgc3dpdGNoZXMgc3BlZWQuDQo+ICsgKg0KPiArICogRFdfWFBDU19TR01JSV9NT0RF
X01BQ19NQU5VQUw6IHRoZSBYUENTIGFjdHMgYXMgYSBNQUMgYXMgYWJvdmUsIGJ1dA0KPiArICog
ZG9lcyBub3QgYXV0b25vbW91c2x5IHN3aXRjaCBzcGVlZC4NCj4gICAqDQo+ICAgKiBEV19YUENT
X1NHTUlJX01PREVfUEhZX0hXOiB0aGUgWFBDUyBhY3RzIGFzIGEgUEhZLCBkZXJpdmluZyB0aGUg
dHhfY29uZmlnDQo+ICAgKiBiaXRzIDE1IChsaW5rKSwgMTIgKGR1cGxleCkgYW5kIDExOjEwIChz
cGVlZCkgZnJvbSBoYXJkd2FyZSBpbnB1dHMgdG8gdGhlDQo+ICAgKiBYUENTLg0KPiAgICovDQo+
ICBlbnVtIGR3X3hwY3Nfc2dtaWlfbW9kZSB7DQo+IC0gICAgICAgRFdfWFBDU19TR01JSV9NT0RF
X01BQywgICAgICAgICAvKiBYUENTIGlzIE1BQyBvbiBTR01JSSAqLw0KPiArICAgICAgIERXX1hQ
Q1NfU0dNSUlfTU9ERV9NQUNfQVVUTywgICAgLyogWFBDUyBpcyBNQUMsIGF1dG8gdXBkYXRlICov
DQo+ICsgICAgICAgRFdfWFBDU19TR01JSV9NT0RFX01BQ19NQU5VQUwsICAvKiBYUENTIGlzIE1B
QywgbWFudWFsIHVwZGF0ZSAqLw0KPiAgICAgICAgIERXX1hQQ1NfU0dNSUlfTU9ERV9QSFlfSFcs
ICAgICAgLyogWFBDUyBpcyBQSFksIHR4X2NvbmZpZyBmcm9tIGh3ICovDQo+ICB9Ow0KPiANCj4g
LS0NCg0KVGVzdGVkLWJ5OiBUcmlzdHJhbSBIYSA8dHJpc3RyYW0uaGFAbWljcm9jaGlwLmNvbT4N
Cg0K


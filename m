Return-Path: <netdev+bounces-274509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAlBLYVbzmmgnAYAu9opvQ
	(envelope-from <netdev+bounces-274509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:05:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37454388C7C
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A14931D43E3
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391303DA5A1;
	Thu,  2 Apr 2026 11:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E3OuvKoP"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B503B3DD510;
	Thu,  2 Apr 2026 11:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775130780; cv=fail; b=emDaNLxr98c3e5n8nNGLgqCPnN0rNcaAukkhwYfKRDVOMhmEkjnzW+OhM+Cg2bHRll1Kh8Ewj6irdTDGHA2kcQFt2LB/4FseUQNET9ktWXp7hYuX8wyVOniTvxjZP2FbpcfW9uMLMJ3331XKW9S1UZExfiKdhnUmq3xFjl/kR5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775130780; c=relaxed/simple;
	bh=DYENphiZvo7DBHY71y0QAVk0BXzO0kGZtAqiJI/VigM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AHRtPnMijNC43YskqexFP9Jf+Ou9PwtBCkZEpzT3eZXV7WXrRSeTPvQNf0cByUZfeyjs3dgwNWflQkTxYjRWwPkpSs1EKGyDy6eq4hrtpFdBhgLYiJJauZgk/jV+LdGnP0XyyHAwybzgXnFfHvA6UKzTnOMaklzLry+FdFiQP7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E3OuvKoP; arc=fail smtp.client-ip=52.101.48.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkMmiE5kdt87yEeNr0M9fgYNVvWzcZUxeeYrA98uchPdqoAVpEV+8Yqm2qJX2cLJl7r5v0pUX7Qcxg0fH6wgAWWdX9dTanymNfQtqG652JEogFidjTIwWUFpAO9MLD58mN875YAlYndXj7X4wwJW1nI0f6fqgpuogLwf5nOoFtlULtK8HoMVMBv1AbVntk+yYUUGpDiW0vIxGbSmOBqUM2oA3HuW6Gs6xR7tR5/3yy40lgkFlHR8fc1iEsfDmNI+6YvHp4h+F0YbWTcRx9US+312fzSzaa9wGqoRVdrR9bhDIYifQd8rGKgrWL6kB0mQatFKUa4heHg8no2nSG6m7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYENphiZvo7DBHY71y0QAVk0BXzO0kGZtAqiJI/VigM=;
 b=VeTDOcU5qm3ISJPpqWSXdqlIyfsSYc9UDfIJ2OCZKokh5W9+sp6ovK14LFURHayrIjYosG4NPcKWwHLIsQ9V5qlJYLNeN8tJZoPKI5K3zP4OEwgAP+0hWk9bq+dTQVKzZ5MWJr5ElQeFAFnKPs3MkoTKNczjX9wAWh7d2FI9m09XOuwQt81HUWWpPUMFPs0LFWkiN+v2UN4+35TLIMxa735I6tBT8PBGlFo71ltuzHzCPIjtMBK2mJtzbxj/eqIME+7vpIFgOFW6E4psXqpCMos3TBB47aJKqd3ob6AAbFYSnvebLzk+r5Ps8qTEZIJx4qvtmaKIdh29dzftM4Immg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYENphiZvo7DBHY71y0QAVk0BXzO0kGZtAqiJI/VigM=;
 b=E3OuvKoPqVlaDXqrrUPOpWRa3dyQRvX3N+eN/4KRPFfRuuqNdHiIFNG7JjXDy4KbvTAyV275EV3wRG0TzGF5RfTmCmQOA/TlpoVR5n39S1DLoqs6Ilg6d8MdqNhaeC8GBoxgzSTiORIGW1JvP3zQ7Fok5dP3CyDgUCiARIU5E+YINV5JKPokzM4TvzRytJwTfdYlsAmoYd+ZqS9yNlBS+yWFTGI9fSTx61ulZOWhQvPs0Tk5fcAtgfpCEfOEcp71tB0uXOaZQTTXV1H6s9v5X43ku8Hlqib7WAvCYb7bG2vksTQhowEML38ibh3l6Ng05l8kENmaulECdHhrGm6tNg==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by PH0PR12MB7839.namprd12.prod.outlook.com
 (2603:10b6:510:286::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 11:52:47 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d8b5:cf72:3e36:3701]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d8b5:cf72:3e36:3701%7]) with mapi id 15.20.9769.006; Thu, 2 Apr 2026
 11:52:47 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "sd@queasysnail.net" <sd@queasysnail.net>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "shuah@kernel.org" <shuah@kernel.org>,
	"dw@davidwei.uk" <dw@davidwei.uk>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net v7 0/4] macsec: Add support for VLAN filtering in
 offload mode
Thread-Topic: [PATCH net v7 0/4] macsec: Add support for VLAN filtering in
 offload mode
Thread-Index: AQHcwpFwzckmRZpqckOLHZ7D3OLjiLXLpxyAgAACLIA=
Date: Thu, 2 Apr 2026 11:52:47 +0000
Message-ID: <023651d1fd91f99982d3c3253e4d685ecacf6351.camel@nvidia.com>
References: <20260402111034.1494714-1-cratiu@nvidia.com>
	 <ac5Wt4vWxHMTcsae@krikkit>
In-Reply-To: <ac5Wt4vWxHMTcsae@krikkit>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|PH0PR12MB7839:EE_
x-ms-office365-filtering-correlation-id: dde65530-33f8-4a95-1235-08de90ae5bb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 o9+/gjUVC2J2vwt5swna3EGxlwgXmW2DRX+I304famIFFwSzLVVQT4cmGUaPlOwkbZBJ345nPIdQdhEg0ZfkOcpjPoz0MCN1+B48GGMfCdNaG3ptBIl1S4IbF81XqoBBPnhoWkGuJmBST+LgUDauiSqvgvEa6QVI8gg2Y1R/XdrftI1907F+ctt7s7qVt1PfzFDEckP96upXER9azYg4+zJ6n942s3Dfl5RZdyRE2FblchUcorYPzsd/I86rOpwTsnACMQEX+K0JJu7Yw0PK0zRQpADzO6v9879KC3KUb89lmI++BH6m1MNiHc6nz+FGGRhi/26cZ23r7gNqWgCSzOsLJwSbzRjttDSc55saIJp3zsrVarKshnkIodkh7ZrYpYQd/ShOAGtQX1uVv/HvKCoHsDznVb77OcofjWOQS3mgB5U0hxiorGbU1ZuHd9LtpkU6ihtTEqnstMzCOBA3ORPmb6xbq3l/zzE6z8N3MMyF05KWSDDubid5fmqyIveAEsJA+QKSEzeB3FvHbtbRc3Z4ft8ki2IsV+z/H/cgq5bbpwq+/ZegDuDOIEAGdjHG0n0h6Dl1FpAcerBbGnkd366qzEkdIAULVTjFNasyxQGn9CLMHDLyxIROzv/YzGOECNr0WzAMlojju35pOkjy7cfR17rJxkfvQNIca0VWnqp9uJvjVERrmmPZId+YLrNVNkeWmtTFNGXbn8pIJuFngaPduRxpDgQhEdQ2hA2/wu6PUNwY9tpMIi57TNkSGIDywo9wY1fn/Xk7WxYlGtKMxMO1D5l6goDfS2jihFBJr4I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1NIRWx6aHhpWDc2RUxXaXZldGRsTVg4QTdBKzJDZ3BUM2RieTVFRG9uOUJr?=
 =?utf-8?B?MzBqNUM4bXF1OUh0bzBrQ0R2VGNjbndvbFd5QTBNcnZMdURFZnVoUXFTVUFK?=
 =?utf-8?B?QnRCUEVTUUNaU2xuU2EzRE1ZQ2YyWEsxeTlMRUcyL2dsR1laR3paa0pUdDI0?=
 =?utf-8?B?V2VlU0RodEFySHJxbklQbTljWElTY2EzSjVMRGpPQ3NRK3VsTWJkQ3VnWGpG?=
 =?utf-8?B?UCttV1p2ZjlOZFBpTStMZDJEY1dzQVlwN0t5RzFycEFXdDcyQjJjdEZhZm13?=
 =?utf-8?B?VXFRRlBQbXQ5ZTk3ajZoZHVETmVxMmttTVRuYWU2eU5vSFhxMmZJMGtyMzRS?=
 =?utf-8?B?UXBwVWx2bXZ3ekdjSlRPeTJmTXl5aVovajNOQkVSc1BMcE1VN2ZCbHJSeklk?=
 =?utf-8?B?K3d6YXZzYTlCdWxYdXlQR3l1aXlIb2tDcEd6bTdINUk5NENraDEvNmxsUzg5?=
 =?utf-8?B?R1lvMmZzcDVrNDRLdHoxSzBPYjdueXEzMU5aUUpWMEdRSmY3ZDFhRUs4MWJz?=
 =?utf-8?B?VFMzNzd5d2VLL0JURzR6WE40SDlwUUs1SkpwVWtQeGN1UzN3THpwUEJSNkxJ?=
 =?utf-8?B?enhqeUhnY3ViZU1GRjFIT2hSOHVrSmxxMk1rcXVQeFFjZ1hUUU1xV2EveEZo?=
 =?utf-8?B?Y2FpVW5sS2JHbWVtRGJ1R01jaHJRRUEwSGlCb2c2S0xtZUJOZk9vNUpOQzVn?=
 =?utf-8?B?V2xJRXhUOEw1cVVsWlVBdGpJd2VyWlJvS3JMK1pHSGpkTjYxdnJrZ0RmVTh3?=
 =?utf-8?B?bU8weFBWakRpZG5QOUNUYVZMeFMxVnIxUDB3amt1K01VN3VmbHN4TEpLU3Jw?=
 =?utf-8?B?RXhkaEpWOE1yMUc1aUdvOTM3amcvU1JXaVY5cHV2TVlyQjJNeVF0WmFXaDNt?=
 =?utf-8?B?WE1SOU5PRU9VWTFSbDUwaDFOZ1F1WEtqK1o0blM3dzhPRWRCU0dCRm1tcHB3?=
 =?utf-8?B?MmlxL1hMVmk5RTJwL0YveDVqRU5kUklRUXFyZGlVY2g4a0ZNS2lqRUlmNStr?=
 =?utf-8?B?QVloWkxSdnd6YWpqWkkwNjR4N0JPb1lFbHZHR2xtZW0rTzB6d3ZPRU96L2ZX?=
 =?utf-8?B?UXJWWFcvVmc0UnpEMlRnZFhPYy9ueDRtdkM1S2dHN1AwWjdGTFJ6aDVPU1o5?=
 =?utf-8?B?SlJRdmVub2RTNG5vZDNkY2l1bFo3RVFNbStIVUp3L1c5MktRaVl0NjdlNjg2?=
 =?utf-8?B?REtKaklSN0JNOW12dlFtUWVwWGlQRjJYd3JFeXh3MVg1SGJJRDNtUHhhUU5p?=
 =?utf-8?B?V2RTK3BEd3FEVGtaNlQyQnlmT0lOTXZSREUvMlNDbUVzcXYyUE56R0VIYW5U?=
 =?utf-8?B?MUV1K1FaM0YxTVg3aFc3RjlWRkxlbmM0enl4YjBEdGFrQWpPY0cvWHlWMnNN?=
 =?utf-8?B?d2cxRkhpWkQrTzh2V05LempKMnJaKy84aTJEZlRPTEZtMVVBbmZFUTEwSHJi?=
 =?utf-8?B?WHR5M01HQzBOSXVSd3QyK1lXdGRNNENEa0YrUUQ0ZFg3R3pHaEx2VDJ1Y0xq?=
 =?utf-8?B?RXBpS0lOaklnaXB2eFUxRVB3ZWZzb1N4MWdHWXcrbVJJS1lCS0o2MDBUSFhR?=
 =?utf-8?B?dEdhL2xVd1ZiMEw3Mm9pNS9ldFNnZSs5Z2RUNThmNm1FL1dSN3BVU1I2THM3?=
 =?utf-8?B?VXdkaklQZXhQWThsYmlCUkgrejA5SlpxZXlVMUR6TGVSdFU1TWQ4Q0JjMmNt?=
 =?utf-8?B?ODNqWXhvQlVEdlpmeVdNZnVzMHVRNEV1T29LbXF4VHo0eFJvMndwV2RtSTBl?=
 =?utf-8?B?MkNuUXNockZNaWVXbmRWR241Tk5Pd0dDc3cyKzVlQWplRVhaM0cyazRoRFRi?=
 =?utf-8?B?dWlBSFV2a0RCV1hQYUpCMG0zeHkrTkluc1VkazFrazg3N0c3NTdJSEkydlpx?=
 =?utf-8?B?enFDV2dWTjVoeHp1TFN5cFNEa3c4Zmc3cGpNYmpHZHMvcll2dDlYdWdnQ0dl?=
 =?utf-8?B?dVFVVHkramh4aFpvNzBub2FYSzdxQm9zb1pRSE4rclVRbU5ETTk3VFhqM0V4?=
 =?utf-8?B?aWRHUmt0VkdPdkprY0VhZnlBc2E5SXFReDNVd0ZqWnQ3aUZQVm5XeUNxa0kz?=
 =?utf-8?B?bHJNNWJ3SlpabmpnZXVTV2ZYSzdsY2NKbVJGVlFHV1l3UzA2NzUvbWhwM01r?=
 =?utf-8?B?dkJHZDdJMmk4WE9rMUxuVmRVZEIySW5wNG02R0ptV2RBTFI3R1dUcGdUU0U0?=
 =?utf-8?B?a0xrS0IxemJ3RG1IUUpqRHgvR1hTMGZhUzFkT1ZQbnIzWWR6K1MwbEswMzVK?=
 =?utf-8?B?WktRVHcyTWNCNVIrbHNrSUJLV295aW13Q2JCak5Jd0NhaU9CR3Y1TXdQL2g0?=
 =?utf-8?B?dlBNa21md3cxRFlqMHU1TlFyYTdZNGtEVE1WZFdwN25NNCtCeTNsQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32DFADFBE97E0749A20B76B697FC9860@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde65530-33f8-4a95-1235-08de90ae5bb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 11:52:47.0217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDcxRlK55YDgPM+W8ewT6H2bb0+Q3mZONWe4bGQ0ZhHbv8I5bOOH3Xc93zVQnRmANYURZ1xTMrQvD5pePAVSLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7839
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274509-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 37454388C7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVGh1LCAyMDI2LTA0LTAyIGF0IDEzOjQ0ICswMjAwLCBTYWJyaW5hIER1YnJvY2Egd3JvdGU6
DQo+IDIwMjYtMDQtMDIsIDE0OjEwOjMwICswMzAwLCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+ID4g
VGhpcyBzaG9ydCBzZXJpZXMgYWRkcyBzdXBwb3J0IGZvciBWTEFOcyBpbiBNQUNzZWMgZGV2aWNl
cyB3aGVuDQo+ID4gb2ZmbG9hZA0KPiA+IG1vZGUgaXMgZW5hYmxlZC4gVGhpcyBhbGxvd3MgVkxB
TiBuZXRkZXZzIG9uIHRvcCBvZiBNQUNzZWMgbmV0ZGV2cw0KPiA+IHRvDQo+ID4gZnVuY3Rpb24s
IHdoaWNoIGFjY2lkZW50YWxseSB1c2VkIHRvIGJlIHRoZSBjYXNlIGluIHRoZSBwYXN0LCBidXQN
Cj4gPiB3YXMNCj4gPiBicm9rZW4uIFRoaXMgc2VyaWVzIGFkZHMgYmFjayBwcm9wZXIgc3VwcG9y
dC4NCj4gPiANCj4gPiBBcyBwYXJ0IG9mIHRoaXMsIHRoZSBleGlzdGluZyBuc2ltLW9ubHkgTUFD
c2VjIG9mZmxvYWQgdGVzdHMgd2VyZQ0KPiA+IHRyYW5zbGF0ZWQgdG8gUHl0aG9uIHNvIHRoZXkg
Y2FuIHJ1biBhZ2FpbnN0IHJlYWwgSFcgYW5kIG5ldw0KPiA+IHRyYWZmaWMtYmFzZWQgdGVzdHMg
d2VyZSBhZGRlZCBmb3IgVkxBTiBmaWx0ZXIgcHJvcGFnYXRpb24sIHNpbmNlDQo+ID4gdGhlcmUn
cyBjdXJyZW50bHkgbm8gdUFQSSB0byBjaGVjayBWTEFOIGZpbHRlcnMuDQo+ID4gDQo+ID4gLS0t
DQo+ID4gDQo+ID4gVjc6IA0KPiA+IC0gQWRkZWQgbWlzc2luZyBldGh0b29sIGZlYXR1cmUgY2hl
Y2tzLg0KPiANCj4gU29ycnkgdGhhdCBJIGNvdWxkbid0IGdldCB0byB5b3VyIHBhdGNoZXMgZWFy
bGllciAoLUVCVVNZLA0KPiBwcm9ncmVzc2luZw0KPiB0b3dhcmQgLUVOT1RSRUNPVkVSQUJMRSks
IGJ1dCBwbGVhc2UgZG9uJ3QgcnVzaCB0byByZXBvc3Qgd2hpbGUgSSB3YXMNCj4gc3RpbGwgZ29p
bmcgdGhyb3VnaCB3aGF0IHlvdSBoYWQgYWxyZWFkeSBwb3N0ZWQuDQo+IA0KDQpBcG9sb2dpZXMs
IEkgdGhvdWdodCB5b3UgYXJlIGRvbmUgd2l0aCB0aGUgcmV2aWV3IGFuZCBqdXN0IHdhbnRlZCB0
bw0KZ2V0IHRoaXMgZG9uZSB3aXRoLiBJJ2xsIGFkZHJlc3MgeW91ciBjb21tZW50cyBpbiB2OC4u
Lg0KDQpDb3NtaW4uDQo=


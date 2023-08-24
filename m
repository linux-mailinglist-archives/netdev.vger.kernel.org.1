Return-Path: <netdev+bounces-30375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BC07870AF
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56AF91C20365
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA462891F;
	Thu, 24 Aug 2023 13:44:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896B428904
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:44:12 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaf::60f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6938D1BE9
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:43:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyOUFk31QyFUez1DBAbvZGjTgmFvSiRujE6xq6QqQPYQnSfaw5GcJR8DL5vGqNXQFQpcmjhE/3vdZUhb1XGSy0VuxBcH3l2K++Ik1R3O9E0Xh/rfUHyyeFVWFXd1+XvHB5VqZ68oChEDs/P7TU+dmQu/Jxb352QnRnTE7nMIX/u3rh4L9JmK3L5C894xXO0N+jKxf4VDgwfyuKONS2r4yKePjGhDExdls9uSFMgAkQDpBFg2DhQP4ENfOCwt7MXsLRTWqzWQZaV8ufRoWHIb0TpNay0RnN2rzEyiueGtehEEToSfDkbs0R0iAn9wueelfjGDePax1kz3sMIS6lBizA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vI6T6KX8tkEURYFcD7XjlkfdJ6CQnGCvO2wwBV92Y3s=;
 b=jcX5UwPTPZh3o1VpchCgh85Zppxq0psNbTZqAXjYoHLEkQdgI3U1pvbKZWOZa/OEw5Bo1w18Sdcr6hlv3mU0T8bYpHu/3YdT0NSZhzjB7k/AB3N9jgRP2uuYXV8vfSix/eb4fVqmq/tC4yP+Kmbhy71eMofj2vQwq7QItrAU8a4RrHP1nsaqJJPxFmOIA12C+K+1rkxSAVPj6fZa7zZr09wgXovW4icWBFA9mzLuvJor+neFETl0Nqdj1zSbBsIlWpxydnSC10I3/LQRsTCuEoKKz1EJUrtCXuX+Xpyhc8VvNr9r+h74dKV61iSkAVtQ1HR1ledUwXBdQvb6hebZAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vI6T6KX8tkEURYFcD7XjlkfdJ6CQnGCvO2wwBV92Y3s=;
 b=GmgZnb20h0OVFRfZPCeyFYZUo3sxCcqpNepShcRRAaPNfsUFyBLSW7iyfl0M6YnpEjB81cyqZaLDgLnq/AuTqaa1aPuFF+cl/nfPXrnTDebwz2MTDmCvaHxVL96ii0BSek19iN6Yeuy93ezZLo15uR26GPoWIw1dvdxsV0IXKeY=
Received: from AM6PR07MB4070.eurprd07.prod.outlook.com (2603:10a6:209:35::24)
 by PR3PR07MB8258.eurprd07.prod.outlook.com (2603:10a6:102:179::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 13:43:02 +0000
Received: from AM6PR07MB4070.eurprd07.prod.outlook.com
 ([fe80::4100:841c:d853:e6c1]) by AM6PR07MB4070.eurprd07.prod.outlook.com
 ([fe80::4100:841c:d853:e6c1%7]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 13:43:02 +0000
From: Ferenc Fejes <ferenc.fejes@ericsson.com>
To: "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "sasha.neftin@intel.com"
	<sasha.neftin@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "anthony.l.nguyen@intel.com"
	<anthony.l.nguyen@intel.com>
CC: "hawk@kernel.org" <hawk@kernel.org>
Subject: BUG(?): igc link up and XDP program init fails
Thread-Topic: BUG(?): igc link up and XDP program init fails
Thread-Index: AQHZ1pDmOz9Pvylx6kScR1ZDFaQwug==
Date: Thu, 24 Aug 2023 13:43:02 +0000
Message-ID: <0caf33cf6adb3a5bf137eeaa20e89b167c9986d5.camel@ericsson.com>
Accept-Language: hu-HU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR07MB4070:EE_|PR3PR07MB8258:EE_
x-ms-office365-filtering-correlation-id: 50432ae6-8c83-4c99-c97c-08dba4a8097b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 QWDkb5mslZKf+en1vc+InzIogcbMtlD+DkH8GzeNGEC5ebKdp4Tu3jHFEpEr7WOko3/ppNSZrR081jKNJOv/AMrzGENxl9jZLwhgg6K/B0RHIIBlaqFJa7khgcON9SnXsTjCCOGkQ5jHvOzBzyAROtAK8+OrlC0sBLwR7mIb9ckOZeijWJfsDDDolSJ1niLcc+zkya3uCTVbcKY1FX4N+/fnoWbSZQqr2a2uidYWjLHl5gvngzIsma3MQSuTy3S04sCYQDkDk+slxmB2OXozL27cwyXA7XBRRH4YrXotfcs9brvp24yvuztrLtldqX29JDNrlKVnvNSry6yCPx9MGnccoMFrij2ztV/JsZP1R5Vyc8J0iagiNIexrYuDGnzh+DhvFiC06eteGZ3Mfb4zxdj/gMwOjxGCN4oR/bK/xjt/EqDq4a6AyHShhKcvkKtfo+UvoiT6lqCxIFsL3DNQPfa3qXXJe9WTtbi5AbGs8VjtnmxfCfNtJIBX4PK1BzDMAPJ9h8iB8Pq/8pYzqeYgtJQ8D/RhmiJrZs+j5kCpw4tSYXYhJmiBAXvPoP4l+ZeeEjdxXFYNlXock2rg0W805K4SgZFmG5/oR4WnIRM0O9vP6ODHyJoFm91xO2e8oEusc92upE4mCKrY9GGJd/8ohr+HxwUiMYLsSsv2EQUDdxvDgzu7GyWGu79S+RBEecdLsQc4smMY7rid+y7KVh1kQg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR07MB4070.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(376002)(366004)(186009)(1800799009)(451199024)(2616005)(5660300002)(4326008)(8676002)(8936002)(36756003)(2906002)(83380400001)(44832011)(26005)(71200400001)(38100700002)(38070700005)(82960400001)(122000001)(66556008)(66946007)(76116006)(64756008)(66446008)(66476007)(316002)(110136005)(91956017)(478600001)(12101799020)(41300700001)(6506007)(6512007)(86362001)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bHZDQUhyQTBITmtsOWtvZURUREJreWE0SHFpTllGYVllS3ZZcElJZG95VU1h?=
 =?utf-8?B?OGZLaXJObEVFNGJwc1JTaFVmeUFjN1NsU2UzSVlkRG81cWdNelZoNVJTSUlK?=
 =?utf-8?B?ZlpKblBucjRRQ0dpdzVSY0crMzgrWVVNOVRhV2VYQ0FEend6Y21VV2VWSkpt?=
 =?utf-8?B?ZWN2c0kzOUtrWUFMU1ZwSFF5S0E5eGNKdkZ2UDFiSW1lclA2Y0FDVk9Wd1dL?=
 =?utf-8?B?WkJYUTVLcitZWVZCTHAySXlQNE1UVGptenY0T05VSnpRcllFb0FEMldSZVNV?=
 =?utf-8?B?TWNBOUZCdnR6aVlhVWJWVkQ1VjNRZ250RVI5U0JxcVhlbEZ4TnJVbjgyS1g0?=
 =?utf-8?B?cDdhUWV6THdHR0NhN293eU8zZFMwd3h2TWRLKzg1QmV1QzhMT0tFMkI5eFBJ?=
 =?utf-8?B?K3ljQVpZTEs4WWtRM2F4c0hLVGdpWWRqYzhIZGlOWmRxdjIvY0tTdGI3aFZR?=
 =?utf-8?B?N1QxdWR6eG9vMk5VeVQra2VhTjRUTVZ4L2NFQThEaktpUUV0Y1JxQWgwaXRP?=
 =?utf-8?B?c2I4RFlGSGFoUktUNzdjWVZJMzlORC9MUVk0TDF1RWU2TUw5SUZCekV4UUJ2?=
 =?utf-8?B?Qm5SS1lEQlFmLytkQ3pESG9jdVhZdXBLSW1wbzlIeFJoMTBSRG9BMGd3YmRk?=
 =?utf-8?B?OFFubmtKUW16UjFoM3J6NmRXWTl5bGtJVjNnWVlyTWJTelNnZCtiMm5ERHJE?=
 =?utf-8?B?TzNzT2NhMVNmTTlHSzArc1o1K1U4OTlmdVZTMmY2cFlpc0wvMjVRRHVSS3FC?=
 =?utf-8?B?alVOMWgzR2dPM1BLM0FUd1A4dWpQUTZBWDVaTXFLN1RpeFB6dHV2QlNTVGZQ?=
 =?utf-8?B?M3FoWjc3OEwyR0FNdmUrUFFIWlZXeU5LZThzWmNaTFNQcWtlazJ4L3pWTUNh?=
 =?utf-8?B?NGphS2RmSEw0Y1F5Q2MyK2ppTXgyMnRKRm81SkNjeVVpcUYrNC9WcjFkSHVY?=
 =?utf-8?B?V0dlWjFPVTYySHVmT0JCQ0RCSkJVbjJydWRxMllrckgwNWNQZE5FMFNJUWVF?=
 =?utf-8?B?VFQzZm5YV1hDWWNFVnVNTklvQk1EL3k0VDUwbmdWMU94WEY1UXR0TVI0QUJO?=
 =?utf-8?B?SGRCZEJaRFMwaEdiT01KQ0xUUzFEdXhmUld6S0UrNkV0dW1mRDVZQjVjbllF?=
 =?utf-8?B?aE5TR1ZuVG01R1BOSWdWemRQWGtnbGFXSFJENWQrVDJkaFpIQjRheDZGbkkr?=
 =?utf-8?B?czVsNm05OTM1emxid2hlaFk0VVJBc3VCSUNwdEVtRmQrd0wvSkE5MWFjYUFH?=
 =?utf-8?B?ZTVsR3FuKzZHRVNVSUI5cGNqa2tibnhjNGZ0a0tNWmpjYlBIbXR5V2ZGYkhJ?=
 =?utf-8?B?eWY5c2VyR2xlbFk3QWV4Y3dLZGR6SHNiUUE3S3FySU1Qb2psSzF6dGFaNDIw?=
 =?utf-8?B?QU9Ta1pqRTgzVUgwbUo5Q21jcUM1eC93VE1QY0dFcmx5QWtXZnM3SjltZnEv?=
 =?utf-8?B?YzhDUlNSYlhJOHBVSjl6a28xRk5ONjdla1Uyc00vUjBiTmJCdVZEYkZRcisy?=
 =?utf-8?B?U0pZT1ZWa2t3bHdnL1VOSUgrVWZWSnpvTGZBTlRRaVA2eG1IL2NpRVBiT2Yx?=
 =?utf-8?B?eW8xOGZPYy9wTXZacVQrdEY4dVh4VURMZGNtMTJnTGZGczdFRzVqWG56QWta?=
 =?utf-8?B?VWNYK092N1FadVgrenpJeHM2ejFKbGJxOWJJNzh4c0hhUkRQWFRNem5QTk5S?=
 =?utf-8?B?U2plTkpUa3BrMUFCeXJjeHRhYmVPTnp6RUV1OTY5cGdNUkZDbW9pSStHVGZI?=
 =?utf-8?B?Q2s5c1VmVnRETGZidXVuMWRkS2RvY3kyTG0vRTFxa0JZbTM0NU56V1JrSmRI?=
 =?utf-8?B?K0lncGsrRU1BMkQ1V1kwRkRJRkNBcit1L1ZVM0UwZFo2dHVMbzB5VE00L0Y3?=
 =?utf-8?B?TGc3blkzMU8ya09hVEJiYlh6aWptZTk4dlVTNTMyMm9nWHVyOFQ1OEZuY25Z?=
 =?utf-8?B?ZzFVaTlOK3VJM29FWkhDQjZqWDliOVk5ZDNVeWV2MkhHbmVsWkxnMklyUHZj?=
 =?utf-8?B?UVFNUmkxMkRxU1AxRkpXU1FKZVpxQXJBZzM0Slk3TzVwMVZnVml3RWc5bUdo?=
 =?utf-8?B?YlRQcXZLZkh2cTJPZkZPNHNXWFpRL3Z4aWdTVnQwS3BIQjRua1dnZTRkN09D?=
 =?utf-8?B?SGVnazNhQWJ6TEt1TVNSWUxEVGU2N2NrQWVBZzJiZTNTTitxc09kK2V4T0RG?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20485B79F09D5A44A0713D732D392C97@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR07MB4070.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50432ae6-8c83-4c99-c97c-08dba4a8097b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 13:43:02.3431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: djgqRIGyGzVAk+j48enTZ38U0KTAjWQQS0anpsLmVLSxuph18uMbixTJdHofvdOVPyN+3dSQG9Zg65/SqqorjtEqEYeAH8asiASGda/zkpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8258
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

RGVhciBpZ2MgTWFpbnRhaW5lcnMhDQoNCkkgbm90aWNlZCB0aGF0IGlwIGxpbmsgc2V0IGRldiB1
cCBmYWlscyB3aXRoIGlnYyAoSW50ZWwgaTIyNSkgZHJpdmVyDQp3aGVuIFhEUCBwcm9ncmFtIGlz
IGF0dGFjaGVkIHRvIGl0LiBNb3JlIHByZWNpc2VseSwgb25seSB3aGVuIHdlIGhhdmUNCmluY29t
aW5nIHRyYWZmaWMgYW5kIHRoZSBpbmNvbWluZyBwYWNrZXQgcmF0ZSBpcyB0b28gZmFzdCAobGlr
ZSAxMDANCnBhY2tldHMgcGVyLXNlYykuDQoNCkkgZG9uJ3QgaGF2ZSBhIHZlcnkgc21hcnQgcmVw
cm9kdWNlciwgc28gNCBpMjI1IGNhcmRzIGFyZSBuZWVkZWQgdG8NCnRyaWdnZXIgaXQuIE15IHNl
dHVwIChlbnAzczAgYW5kIGVucDRzMCBkaXJlY3RseSBjb25uZWN0ZWQgd2l0aCBhDQpjYWJsZSwg
c2ltaWxhcmx5IGVucDZzMCBhbmQgZW5wN3MwKS4NCg0KdmV0aDAgLS0tLT4gdmV0aDEgLS1yZWRp
ci0tLT4gZW5wM3MwIH5+fn5+fn4gZW5wNHMwDQoJCQnCoCB8DQrCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCArLT4gZW5wNnMwIH5+fn5+fn4gZW5wN3Mw
DQoNCmlwIGxpbmsgYWRkIGRldiB0eXBlIHZldGgNCmlwIG5laSBjaGFuZ2UgMS4yLjMuNCBsbGFk
ZHIgYWE6YWE6YWE6YWE6YWE6YWEgZGV2IHZldGgwDQp4ZHAtYmVuY2ggcmVkaXJlY3QtbXVsdGkg
dmV0aDEgZW5wM3MwIGVucDZzMAkjaW4gdGVybWluYWwgMQ0KeGRwZHVtcCAtaSBlbnA0czAJCQkJ
I2luIHRlcm1pbmFsIDINCnBpbmcgLUkgdmV0aDAgMS4yLjMuNCAtaSAwLjUgI3Nsb3cgcGFja2V0
IHJhdGXCoCAjaW4gdGVybWluYWwgMw0KDQpOb3cgaW4gYSBzZXBhcmF0ZSB0ZXJtaW5hbCBkbyBh
ICJpcCBsaW5rIHNldCBkZXYgZW5wNHMwIGRvd24iIGFuZCAiaXANCmxpbmsgc2V0IGRldiBlbnA0
czAgdXAiLiBBZnRlciBhIHdoaWxlLCB4ZHBkdW1wIHdpbGwgc2VlIHRoZSBpbmNvbWluZw0KcGFj
a2V0cy4NCg0KTm93IGluIHRlcm1pbmFsIDMsIGNoYW5nZSB0aGUgcGluZyB0byBhIGZhc3RlciBy
YXRlOg0KcGluZyAtSSB2ZXRoMCAxLjIuMy40IC1pIDAuMDENCg0KQW5kIGRvIHRoZSBpcCBsaW5r
IGRvd24vdXAgYWdhaW4uIEluIG15IHNldHVwLCBJIG5vIGxvbmdlciBzZWUgaW5jb21pbmcNCnBh
Y2tldHMuIFdpdGggYnBmdHJhY2UgSSBzZWUgdGhlIGRyaXZlciBrZWVwIHRyeWluZyB0byBpbml0
aWFsaXplDQppdHNlbGYgaW4gYW4gZW5kbGVzcyBsb29wLg0KDQpOb3cgc3RvcCB0aGUgcGluZywg
d2FpdCBhYm91dCA0LTUgc2Vjb25kcywgYW5kIHN0YXJ0IHRoZSBwaW5nIGFnYWluLg0KVGhpcyBp
cyBlbm91Z2ggdGltZSBmb3IgdGhlIGRyaXZlciB0byBpbml0aWFsaXplIHByb3Blcmx5LCBhbmQg
cGFja2V0cw0KYXJlIHZpc2libGUgaW4geGRwZHVtcCBhZ2Fpbi4NCg0KSWYgYW55b25lIGhhcyBh
biBpZGVhIHdoYXQgaXMgd3Jvbmcgd2l0aCBteSBzZXR1cCBJIHdvdWxkIGJlIGhhcHB5IHRvDQpo
ZWFyIGl0LCBhbmQgSSBjYW4gaGVscCB3aXRoIHRlc3RpbmcgZml4ZXMgaWYgdGhpcyBpcyBpbmRl
ZWQgYSBidWcuDQpJIGhhdmUgcmVwbGljYXRlZCB0aGUgc2V0dXAgd2l0aCB2ZXRocyBhbmQgaXQg
bG9va3MgZmluZS4NCg0KVGhhbmtzIGluIGFkdmFuY2UhDQoNCkJlc3QsDQpGZXJlbmMNCg0K


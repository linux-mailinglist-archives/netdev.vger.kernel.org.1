Return-Path: <netdev+bounces-266668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEg3LrmDsWmjCwAAu9opvQ
	(envelope-from <netdev+bounces-266668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:01:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F9D265EB9
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6469431107A3
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EFB3E3C51;
	Wed, 11 Mar 2026 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fuMUlx6Y"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013014.outbound.protection.outlook.com [40.107.159.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436823009D4;
	Wed, 11 Mar 2026 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773240723; cv=fail; b=R68gcox/rtr6M1reBEvzDLmNUSoeRaziS5qg2s1RZOd7T8tIti/PS3xc+kYSN04+8kqwMxwsntcrtA95Px6Anr+g6irTrwoQy9bbJwfKByTqWUI0Rp+1NFoW8eRzuPA8Hp10nPvhW7iWe4HcgxLVIpZOh+uznoMCUmBlN4+CCdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773240723; c=relaxed/simple;
	bh=wthAECyhIVWoFyJZ7fSavqwwgVNREKoT1IIVXhssLkQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HsV4KcfIeJa80kYNEsL4fjLa709/NSdTLODnevWjrO4YEKb2+nYiRVfDbPkP7g0D5OjIX6/Uj+qdoHXa3trWj4REUX3aYrYhWe+y9BFZZhDY6ghETP+Lq/Lo4ckYVcWSx1Zb4y6ZYlG6u0978icG7PhoOqM5pankcvMg+wXdl04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fuMUlx6Y; arc=fail smtp.client-ip=40.107.159.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEMJByiEFKgD3W4OJ5FFmPGLJk4COlk/6MYlBrSD8KKSs2zVeL660jb+sR7Dba+8YQdiiYNJcEaMk2EpRgpNdF6LBqZB+bZVvREybzjb0R0yI9uCJS3kk5/7jRIDY+Zy3fwDqXtaNaVrG5yywuSKDIXeFfK26yhWCSxYAUT/lblds/3Y/8SuIAvHR9fF8VFaT+Me0iXD3Ebv344iirmQR3oqg7fL9lowgHZdwYalt6hQZ1ffp7aQix9u5+7I5+t0cCw7ugtnV+gdK9yYA8R3gj+SlKsTc6jBduuGVH4ZY5Ae16VejT9YftZpkRgfN322lseBkTSFvC7i/kHdYHPiZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HI5pQZw6QKOSqbMo6pPtdDTVXPQGtN+mOtIoN+bG+B0=;
 b=C70Z9JdCefQ2Jdx3zgVIL1DCYT4LoHM75UAPe1QRjqDNHretVMYLaN+yXa9c2AG/J9lIS7J13vhraJdxcgj0p9baTnwHhYjyUYcv2wQtilDsv6Q62tPulKD0SLC2nmNE02i1Wm4qA+HmM+4Xrte2mIdBemVIMDCHfbpxEo8RPPMRyLwbRkdJwvGwCJvq2AsIR9O7tPtsBvUJ62Vv85SuNTxCmCv3sDHVzmKUHbouwphzv1vy02yh/QiDUuybDJnIgzjIpZKmA6HHwDL4RYWwZDo7HW5pXyfwMm2UTCzO6Ar5/m+P0K6RBqHe8p7FXIeCscJlt4ueg2B8ckCgJQK6zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HI5pQZw6QKOSqbMo6pPtdDTVXPQGtN+mOtIoN+bG+B0=;
 b=fuMUlx6YU0OAXe5PB+Z0gyt5fOoQzCD6dn1o34ubPPZA+7xMKql404kLkYCpBCFZjMTwSkbS470iTW/Ew5EMFynRo0nIebitKbbrb6OTWceVLRm1R7HKFmyLeJLvg+6X8tEIB+QGy1rrPyHIv2r8hNXsb9inQPXmo6+N7T08WpeRu4+/QViAGR7245CzOWc081cKpddboGpUQEVoRkgbs2wDeGUbhP0VpDJ/24tY4j1vJpJ7/yl5uWVLrJQKrH235xYc11hXfb2f+f5fxmjJ4gx79AiRS5RNIUX3o2eblp7eV2BRr015o2VvVGHF5xPgP4HWyoNWnBD+IGXqsZ9v7A==
Received: from PR3PR10MB4270.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a2::8)
 by DB9PR10MB6004.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 14:51:57 +0000
Received: from PR3PR10MB4270.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bcf7:efb8:212:4fdd]) by PR3PR10MB4270.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bcf7:efb8:212:4fdd%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 14:51:57 +0000
From: "Bouska, Zdenek" <zdenek.bouska@siemens.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Richard Cochran
	<richardcochran@gmail.com>, Song Yoong Siang <yoong.siang.song@intel.com>,
	Lai Peter Jun Ann <jun.ann.lai@intel.com>, Vinicius Costa Gomes
	<vinicius.gomes@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"Bezdeka, Florian" <florian.bezdeka@siemens.com>
Subject: RE: [Intel-wired-lan] [PATCH v2] igc: fix page fault in XDP TX
 timestamps handling
Thread-Topic: [Intel-wired-lan] [PATCH v2] igc: fix page fault in XDP TX
 timestamps handling
Thread-Index: AQHcpj1ShQMklK5X6UG86S4EbCzDnrWTPMOAgAL4PcA=
Date: Wed, 11 Mar 2026 14:51:57 +0000
Message-ID:
 <PR3PR10MB4270AE69139227E56F4D4842EB47A@PR3PR10MB4270.EURPRD10.PROD.OUTLOOK.COM>
References:
 <20260225-igc-fix-xdp-tx-tstamp-pagefault-v2-1-bf797ec20f3b@siemens.com>
 <5d2c5f84-436f-4681-ad81-9900a8563b61@molgen.mpg.de>
In-Reply-To: <5d2c5f84-436f-4681-ad81-9900a8563b61@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=46ba3ac2-d69d-4d84-8b63-839bc8b76bfe;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-02-27T08:11:56Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR10MB4270:EE_|DB9PR10MB6004:EE_
x-ms-office365-filtering-correlation-id: a7c10c5a-51fd-4295-277d-08de7f7dbe6d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021|56012099003|18002099003|22082099003|55112099003;
x-microsoft-antispam-message-info:
 ybIgap8ocPAHmFsCS+9UuHY/RmZfAlFEpL+wS3/jppFogRWud3RZYEOR3yRbOuZBYV5L0nTb6+P2Dg4Sevc61sbVl0xCuCnYrYviga/FJZnMYpDxxCa1OXtj1OeeWFlNV66ACZ7UlEfKs4gecdSUTRQBlXg2o6Mt6+gze6rL47xjobAq461lxDGKkePBQ4EcTiSHWB0fQabKCtAl36Vq9Uap6h5NJA7hfDG8l0ASZTRON4JIFCHHpoHuvd+L0xgCGZnHBeAM9h9S8dn2OYT33z9pV3J0CQy2dnxSIPXLSqLPR0NAdSisHPvNKCgM5leHZ8jg5xRDOs3ZF/ct4o5z1iGaKoMsz9yYPryoqtivEj2m6yY5TS7cmdTQrD2Gvpq84vbqgvH4HRXOWG1sJz9lYBK1T+vF5OFeGsiez0LEVpWTvd/R5Om4SpP1WzXYFlq39inf5tF9z9UrrNT7XbciMNgANeg9siyQuJlv/QXot7gN5LnrXiWEeK8LZj1r75DZ2KxYDbnJRTNFUp4FpcZXW8AJhtS3LCZpnDjUHw3jkVsk33kmsI6EO3SdyzhzNG1B/gkNmdRNe/Nrfcpu+F6i4VzAxEGrF8RT0hFSONic2/MimJui8SaXKvN0VzajtoinaQ95EgnPs53BPLQoP5tpJNgBIqXmSrt05Ls5Wh49XeTxcoLPfWoktDjcDEQARi2i42/xZnR3eryKuJb8quI4zcVc4kiEa6f7kUs9qZE+XQT2utcwCZmKuQkXhDvHriVBSNYFoNvW7dyVRBd4kblO4LfNip4XgVYfVBoCegZtxXM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR10MB4270.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021)(56012099003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?P5Y2kS3KGD9rabXia07nGA05P/kGDW7GXCdYrAwVxfgztfV7b5/2hRE+xP?=
 =?iso-8859-2?Q?fgpTZSC0Q+ey1MaykraYiI8NOP7cf6tOyb8JynYWfWo43+Krl5foU0vj3y?=
 =?iso-8859-2?Q?Xrjl3ZegnpvCeaIWhrAEUM6HzlCvW8Eh9qLUxVgEg/2ajxLx++UqDTZcst?=
 =?iso-8859-2?Q?AdZSYGps2wf1eY2qlYcRF6Mde5ZPDZlluzgVYvkJ7HDeaU1lRIqcA+Pwqn?=
 =?iso-8859-2?Q?xTwlkNamG2fs2kaaoQRMZnfGVAMHjcmbflliGCxtyxQxuhbyOfjOhCaUPS?=
 =?iso-8859-2?Q?GbbKaqhY39xSCio2a37S6IKI9IyIHuUm5HPMPp++o0g55SEwiKLCWOP4dF?=
 =?iso-8859-2?Q?IRhUTW8fSNQ4JM/XdGQ3Anjm3t0ILy8S/5/AhjHn70msy6e4l/8LXVlFQZ?=
 =?iso-8859-2?Q?WnDMquD4UrACwPMT1geb5qXjtJJ4l1WKwJ5woXEwzD5ytLkoUXj308mIt/?=
 =?iso-8859-2?Q?06y/zdyhYH7rUk6VHRsB5Z+/gavcVMAOn66pEfHvlLkwiqdfvS0fHv+g2W?=
 =?iso-8859-2?Q?Ge4NDahpA+efHZKj+WuVg4FbAXDr7KM3ceeLASVeVrL/PRVVcbco4drTSA?=
 =?iso-8859-2?Q?r8yrXlKFwtO6miBqtTUewJrsHt4t9JnKQLJ7NJpuxtn7Zz1x6aEj2d48Kh?=
 =?iso-8859-2?Q?WtHWiVAsT8KOC/R9iP4nHbAbIGVCL+hPz283o6tnMfV8WkuYXRwumGrxGl?=
 =?iso-8859-2?Q?35folmxV8a8dshJ14spuPyljmYgEV/4Pwyw60HBUeWynH+/xdlw8Du+rFT?=
 =?iso-8859-2?Q?Es8NkM/2hMOSAjxaX7r05/KAgBdCVDLxFpc4AN144Fh8naCM2VaF0WvV7q?=
 =?iso-8859-2?Q?PFx57dys6YPaMth9HWt7wFPLTzrJ9/Phq5dhgTErW1ZAtWvr2+X74O+ScI?=
 =?iso-8859-2?Q?tcSxq9l9Aa3yOWfmaULxa6Q7DG6Ctdy5ViaCj3tv+XjHpxTg2zWMbVHd9+?=
 =?iso-8859-2?Q?d0bDZGJg81ZtLZt1uwEDpHsPO8egG13Cub+qOtkWqEGY2Hi4WvEg288wCU?=
 =?iso-8859-2?Q?Kpfzo+4Mx5MqdkY9z3j2y9wWxbIiO+HSYkTiuyKk1NocTjBZjZFHQMSPIQ?=
 =?iso-8859-2?Q?U12StqsJgad5EBLlxTT6glKjF1ndp3gqQ1uyXRN4oHvJDCWYobXp/MfUD6?=
 =?iso-8859-2?Q?wZXwObDaRSyeeWhi2NHloDp5hse5M2DUQjGdpethURht2gsuRVFoEK+RAA?=
 =?iso-8859-2?Q?GnEXr2BQ/3i2arTstkUaI7QYgrXYNvNwP3ZtOlV7MlKRsYxtj3AAVY0VN0?=
 =?iso-8859-2?Q?xNryZPmX3gnmAX8BfcsvFo3GwiW+u2GkbDzsAbZmucLw4rAEVqoZbqBUZe?=
 =?iso-8859-2?Q?f/UxIEdPyPW3TI0Mcbk+3+T1idZp/K9zM89xkCDvUC04t6f6o+Fz0kXbp4?=
 =?iso-8859-2?Q?tWpYS0A3cFh/1JYs+zC3F7Q1uYfNhTzwMQxNo2U5p/Y23ly6BRSfgn6Ktd?=
 =?iso-8859-2?Q?qoKZ5tc20VlGj/hp/Ji9SJuMq4LbQBhTfCCh+WLDFaHluHj6pfq7l2NBMq?=
 =?iso-8859-2?Q?rNFfER8xIaX0McopLFO2QcRcROIfBxOOsqwwSLODn3nlCDD0rxIq+Lsn0Y?=
 =?iso-8859-2?Q?UH+h8RARNh1W1Y4KmGT0YvNt0MZ+s8DGfeoX2hAWb5prKGvv5Ebul7UkHu?=
 =?iso-8859-2?Q?nZasKlPFW+y7mobhEKO3RY38UsLB6gM0LVe77yxrnHhyyvevZ9znpnny6e?=
 =?iso-8859-2?Q?opFOzAfYBYWHqkBvSoMO5oE8tzPpYOXJcw04LIMh8Rpa5vAK0o522vqaHl?=
 =?iso-8859-2?Q?uyeYTbvuhZqOMej+/cJ5uUo96DfS/ienLzhB98n0rcNcN9/7L6T3+PkM0q?=
 =?iso-8859-2?Q?o2EZVaoaJQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR10MB4270.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c10c5a-51fd-4295-277d-08de7f7dbe6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 14:51:57.5599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 38fyxdos69XVr+3N8jB8TLoMCcPBcc3c0yXf6cKvh+dzbjPFKPK9QHOiKQTYj8J/F9ywROQEqsN6U6/w94MRTEKHmW2rmx8Rs36F9crIcUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6004
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266668-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,lists.osuosl.org,vger.kernel.org,siemens.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zdenek.bouska@siemens.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[siemens.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,siemens.com:dkim,PR3PR10MB4270.EURPRD10.PROD.OUTLOOK.COM:mid]
X-Rspamd-Queue-Id: 32F9D265EB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Paul,

On 25/05/2026 11:51 Paul Menzel wrote:
> Am 25.02.26 um 10:58 schrieb Zdenek Bouska via Intel-wired-lan:
> > If an XDP application that requested TX timestamping is shutting down
> > while the link of the interface in use is still up the following kernel
> > splat is reported:
> >
> > [  883.803618] [   T1554] BUG: unable to handle page fault for address:
> ffffcfb6200fd008
> > ...
> > [  883.803650] [   T1554] Call Trace:
> > [  883.803652] [   T1554]  <TASK>
> > [  883.803654] [   T1554]  igc_ptp_tx_tstamp_event+0xdf/0x160 [igc]
> > [  883.803660] [   T1554]  igc_tsync_interrupt+0x2d5/0x300 [igc]
> > ...
> >
> > During shutdown of the TX ring the xsk_meta pointers are left behind, s=
o
> > that the IRQ handler is trying to touch them.
> >
> > This issue is now being fixed by cleaning up the stale xsk meta data on
> > TX shutdown. TX timestamps on other queues remain unaffected.
>=20
> If you have the commands to reproduce this, that'd be great to have.

The software which I used is not public yet. I will let you know when that =
changes.

Thank you for the review!

Best regards,
Zdenek Bouska

--
Siemens, s.r.o
Foundational Technologies


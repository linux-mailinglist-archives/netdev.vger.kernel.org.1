Return-Path: <netdev+bounces-119153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460769545E1
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 11:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89A49B217DC
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 09:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141C1770F5;
	Fri, 16 Aug 2024 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="i21t+EEA"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020131.outbound.protection.outlook.com [52.101.51.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6546D20E3
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800983; cv=fail; b=r0mFdNRgzpm7fqVoFnGRZIFUq9cJKrGrwCp0SROhP1h3seHxIw8XAF+skM1HfcporTgRnOLpZ9nJ7WydE3e4SDf2q/axCElq7tFZ0fKYfw0L0bDuktVHihJa6ximwZ2jmnki93S9gX5ohLzdTxHDyzvMdAZ5cAV2iw/xZA8iCz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800983; c=relaxed/simple;
	bh=3sJzbO7erOmpxqcSokgjt2zKb6OQkUI8GRzPZcHBs/w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZFU6Ap9ervPAHfc2XsuYRrvm5QKVRGCv1RADeQJJX+CCPwO4/MEj1nm1G4CLes4uhQC+Tx1USWpfy/OHkquJLlLhr54RLMdvwlm6JjUW2Ftf+Ym641KpQkCn08kz21SOzTUdpwRRrOLIeWM9kTIwi0/3k6qpIb1EBqJUeO2fhZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=i21t+EEA; arc=fail smtp.client-ip=52.101.51.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/2ja2ObwNjg1p158dk1HGeF7sfzsuer/hOY1oyb4rw+kDTKqAoAh/F8YAAHdGa9cqTjhQ1ROJcmdsGDuU2u44BE0mMiEZmuQgVVF7UZggrGn29KCIl9bGoy9uK1loAXep1c+X6INl8EGwkHYVPdbmPd9jH/yHkjna5SRFAGhxhH5PxMa8dR40nCJyuQcYUsDcw32yhRdCRgDPOsEWbGJlvn31vo9rYO/a3xXCbX0SwgatRqDveQ5YMBCusEjVJ7kGuIPUwM6lLoce7wk0n2faaJyOe6GwpekWY0e80uK2Gug+lc64PjeBuJJGzMSAKqU3CcfEiSMLNyqD0/2DQ6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZh7mDm5oC5bO30IbKv3lgrtL0tYkwuA564FvSv+gD4=;
 b=ljDJP2BcVPFuO7J5LFAgRp+zqez6ZZnvTCCLuxOOo3ar6IJbc0R871olOqtG03I5CZL0sKLJTzw1dh5CY+oC8ev9Y3scrU4bZrRgj43avLz/NBLSWIQoDRTkZQ0JhCgR57Ltp7gUXlv4P97zelqhfIFoVNCBNCqnfFy1Q2nFlNLT1D6LX+E8EbTgZmR/MIUm5m1Oy0P+rR9LsCoFvjjrzmyijfaB12mXh0FIkb8tB0pRPH35SOhU8SO2QXhbudFXikv3qzBHyjEDJI0kl7vxo4uR2bTHq4tXkTuvsw+UaMl8ZmapcAlZKLD+Fht4fPzyGiJ1AuteBGOms5dEXb1roA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZh7mDm5oC5bO30IbKv3lgrtL0tYkwuA564FvSv+gD4=;
 b=i21t+EEAOvZ6DrrnSV2o22GOb1Dnke52yiBiC5z1LENuHxztd8mnU3hU6QfkWLjZfbfdA9pOozupQfUwm0gkt9biqW15Pg+Aqrfu5Kz1iszJauY0T5WUab8GPpxe9aP4V8AFhRo8dZ4bwUBG0iSWlcfanXL+eCAjZG2m5O+3LBY=
Received: from DS7PR21MB3388.namprd21.prod.outlook.com (2603:10b6:8:80::15) by
 DM4PR21MB3393.namprd21.prod.outlook.com (2603:10b6:8:6d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11; Fri, 16 Aug 2024 09:36:18 +0000
Received: from DS7PR21MB3388.namprd21.prod.outlook.com
 ([fe80::3eb8:a22f:4c94:e659]) by DS7PR21MB3388.namprd21.prod.outlook.com
 ([fe80::3eb8:a22f:4c94:e659%4]) with mapi id 15.20.7897.009; Fri, 16 Aug 2024
 09:36:18 +0000
From: Dimitris Michailidis <dmichailidis@microsoft.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [bug report] net/funeth: probing and netdev ops
Thread-Topic: [bug report] net/funeth: probing and netdev ops
Thread-Index: AQHa77+/Un6S/Jd3ekyM7P3YQ7MFTw==
Date: Fri, 16 Aug 2024 09:36:18 +0000
Message-ID:
 <DS7PR21MB3388BCDD652811D1D9B090C5D9812@DS7PR21MB3388.namprd21.prod.outlook.com>
References: <f9fa829d-2580-4b49-b0c6-cf2e2a8f6cac@stanley.mountain>
In-Reply-To: <f9fa829d-2580-4b49-b0c6-cf2e2a8f6cac@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-08-16T09:36:17.341Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR21MB3388:EE_|DM4PR21MB3393:EE_
x-ms-office365-filtering-correlation-id: ed340e80-3ca3-4a1c-7acd-08dcbdd6e189
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?F2yNvoQifpX+KXi8s2ib9dznqDsDT2eVIvj7C5wxsBCs2xmPjoWfnP9k/w?=
 =?iso-8859-1?Q?Kn38odpPDqmyovjNO89nfY6YuO8oYTSYoih2NG4Ua+nPkCwV8R2hse8jPT?=
 =?iso-8859-1?Q?yQnfiS728J6jG+FEh64by2KrfYL4RzV7/Go9Wg+mOQzPz2TJFFaE3KmxZ7?=
 =?iso-8859-1?Q?CdLDZhRNNxxUvr0cp9rNdMfFh0SByP0MaVPn/jkLw+TOxaudWCSrGBWtqX?=
 =?iso-8859-1?Q?CdOcECIAlnUu1d5Qu0xv1R5uS/5Q7m6+sPRrfZmbiTZAMUIVzhsuRrqZyD?=
 =?iso-8859-1?Q?TugO31AJF3pQyfQAuia/ZXuD0e0hxwzmwcSChmGxAc5JfqKb6Ma+WlNkEU?=
 =?iso-8859-1?Q?YKx36fwyEUyJKhtgPL0yXRaNb5ip60Ifhm694xI8C90Rsu4q5r/Eqny/qD?=
 =?iso-8859-1?Q?n2FVGaMpuyN5PMizo4iTD9SL4IiTwadkHGNlV7uLCZnJivzEYjWh5d0KDx?=
 =?iso-8859-1?Q?GOY7gtxEG4FstL5wb80FLxEhwlL+m8QGiMZcgRSdmuSsHo/i7O0YbP58dO?=
 =?iso-8859-1?Q?zJPXBeAQ3p+N9YvGn/R3dQaqHbIRwW5+whw1g1IMD25rldk+oosSi9EMM2?=
 =?iso-8859-1?Q?K1HsIv8uCcFYbN1CXBWSGNOzZ/7aHEDsAsE/wu45LE+Dj/NeJTk4OofACB?=
 =?iso-8859-1?Q?FgfADjff3RucfKXPqymjM03DSSDQ5UHHBc4aHC1ivxf1Eu2jhSMtr7M2o/?=
 =?iso-8859-1?Q?38zj0GGOcqj/7Qek517aSElBa74hUAMc+2ksERwuVIF4uSFqVDoHKDimtm?=
 =?iso-8859-1?Q?Pz9lY9gg36/RvfU+SVAmXyo31hPkE5g7JODWKPsvWQgN4nGeJqLFmb1eFJ?=
 =?iso-8859-1?Q?v3Ji6a2tx+Jxlbj6GUopkrVcTE17hXVBVrUmZgpF1Kx0jm7fA6GTCkM1Oi?=
 =?iso-8859-1?Q?BCSB7ZMEUDIV17IoEXFTvyAUAZUY7L4vdxKivoqMtF96gRjzOn1HkxuiJj?=
 =?iso-8859-1?Q?j9MfdHDP21e2A5e1PKN1nO5Rhm0h/nSLCU5gXaoNRE37CiLovlrpBvCIbs?=
 =?iso-8859-1?Q?whZqbz6B02vEfg5s9eWaclUGPuGh0RhFdg+5yaMN1CEkweoVWYuTE393YI?=
 =?iso-8859-1?Q?4SDdIWczQdxNYBWjQtMSM6pdeM4CtskOIr914qWe1CLXq6LAq0BkA3iPPE?=
 =?iso-8859-1?Q?Dm4LUcoMTczxeBrG9I0dbGEqscJ2Ut4EZV3ngjf51ZmUj0weaMxhJS7wWq?=
 =?iso-8859-1?Q?83JxvRdPlcSKU10luLB7gwqI32UVhnIaTkS1if9VFlj9WqZvxcoc1JppiM?=
 =?iso-8859-1?Q?eCvATuNh2TXJGM/Adwp2y50z1clY0P0fvs4J8/C9J/we6Tk2Utwt8H8beT?=
 =?iso-8859-1?Q?gLWeEVV1aJuenwV9T9/5PZWiE409G0dZsmAcoTeGKsdQ4fve+M/kws9/AW?=
 =?iso-8859-1?Q?/LQAT1BJYuuVDyLBWaplNmlzYiwB5dKWi8zsJnQpKB8L4jowT4MQkcQ5Tm?=
 =?iso-8859-1?Q?H2TfN86GpJ6GJvlgY9hIg0me23OUtFNseU5SUQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR21MB3388.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?UPohYVuNeIv623xBJXYEV5ud2qoxhQf4LFwb1RiQcPVhVpGfznxK72NrxX?=
 =?iso-8859-1?Q?/jN5pmZ/eK/j3lswXBrKzdKBN/midezLADYdD15G036HTKiQTqJrGsy6OV?=
 =?iso-8859-1?Q?Rg702bzqBSMV/sZHiL3sDTwAhuCz6sFcBQx+0WBO/Y7696tXcZS4xT/+ET?=
 =?iso-8859-1?Q?9G2E/e2LdcWf7XWMaiiyX38j/TIdI1kgkpcMyU9TU61dBiu/iHYj6FYond?=
 =?iso-8859-1?Q?0+PBIHz1LElKktM5TPR/2Kbx6gQVEjpW6YlkYjz06ixGLDqVLHK3Mbfp77?=
 =?iso-8859-1?Q?tLVzn000BN7b+jyG7S3xnRCAhtFb2vTnIDzt9g7YUqGWdNd1+gsI3luOcs?=
 =?iso-8859-1?Q?SNniXAdGP1iJpHMgurQhgoOQlsRHsaOodL29qcKGqKDgGhGCQlfqUexvuf?=
 =?iso-8859-1?Q?OQjNkW+KlWO5Js/mtrwEFLxV+eHq/ytVJJ2GsRuyCWfU+YymUlrc7dKqUi?=
 =?iso-8859-1?Q?OC63VbDmuMyFscruBP8b/rrc13n2C+J6VzhXms2tjJtXGnzWsJi0PWTMt8?=
 =?iso-8859-1?Q?ueQ6fEWTYz8MB0M4sssvPEP951iJ5mAQxifLqbOLp1Tbjy/vCqU+AzdtRl?=
 =?iso-8859-1?Q?SruDwCaLPNqhySy8LPBwlLRcs36lfYFjxYm1o2QowN/1SSGxAreFmgRLrW?=
 =?iso-8859-1?Q?4wvl+LPuiLXVqEkA2Jd6Hqg7p8k4Kk3bfUmZZpUXjqexWnDEizdT/MiDXq?=
 =?iso-8859-1?Q?u4vMdYtplTfKJYdjj9Ey/7yZPp9PPClH78xC9BFX8exAl5m5upoPkJM5hX?=
 =?iso-8859-1?Q?b7OBGuTW23Dah7ckUBVgk0NLvD7mZJyx8zingb9AA7+Zv9fx6X7smTXxiF?=
 =?iso-8859-1?Q?RJ3LouwuIF4kPUMQhzz9Iy96v7iTyPKY0FtTEmx5bdL/WPj6hznZFJHuGd?=
 =?iso-8859-1?Q?yu7+Zjffu3STy43EmWuIdshI5aDbk1XvV6a0C2qHLMBckb4mNRdKa7S5GF?=
 =?iso-8859-1?Q?Bh3W0f8/BiKJnvbJ+8jEF9zI/pX9mW8rYJeNKudRuE1gA+WEFnJ/LdgCx0?=
 =?iso-8859-1?Q?WyXdOteb1R12STVVJhEL7d4drSUYyg1DfvTz0vMBUICALWi6S+r78jzRaE?=
 =?iso-8859-1?Q?pdN4oR8RZOnbbikSg+kNo+PHZq0vw7zVw0oom3HKOOEqwqGAAJw4WaJgqv?=
 =?iso-8859-1?Q?gAFx0tOazFDRbFDVUL/ZRMq1vqNQTZENUkUQbVchabeg9oDmnqJuK5N+Pe?=
 =?iso-8859-1?Q?4LEzu+U8LlSCV3yxxwbE7CVB6EcB2gGcfEuLxjtuLcIkYlfGG+/ywXoBRl?=
 =?iso-8859-1?Q?edUJ1d51RWg1tJkSI4GQK88LezH6jIjRoomZFAFfFbRgd1B8MhJmACiZ/P?=
 =?iso-8859-1?Q?6ElTM7cRDauuWJzTBPEjqj0H83ifwsiBifYBi709qg1wMyDJQCiSlPmCC3?=
 =?iso-8859-1?Q?xMhMvGDhNHs8onkJu6+JcTQSuW1Ow+apsfJrS4VD6804MFKaeLsZvvxwvT?=
 =?iso-8859-1?Q?HBJ0NOBiNlsGtWw8e2OjKIbgImdsvcJIgaATUjlE0wg4Hfbl3yEwn5YLmB?=
 =?iso-8859-1?Q?/AzKdDE7t1SEeYLpJorfpLn/Sd+u2AVDcba8w5PhRWaSPS3EMLcjojmFar?=
 =?iso-8859-1?Q?nONuzV9KjClpDMKxddtgO707MiaB?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR21MB3388.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed340e80-3ca3-4a1c-7acd-08dcbdd6e189
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 09:36:18.4273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5NacNxHZWV3m3oPAOMR5+hDXOmmBo/Iqbx6dMjx01366Cqy4PLCf9gee6Q05dqUIx0cG89xDdPwfpgzD2xDDaexoBr5Z0CDjsEbt6R+pbic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3393

On Thu, 15 Aug 2024 14:29:38 +0300 Dan Carpenter wrote:=0A=
> Hello Dimitris Michailidis,=0A=
>=0A=
> Commit ee6373ddf3a9 ("net/funeth: probing and netdev ops") from Feb=0A=
> 24, 2022 (linux-next), leads to the following Smatch static checker=0A=
> warning:=0A=
>=0A=
>        drivers/net/ethernet/fungible/funeth/funeth_main.c:475 fun_free_ri=
ngs()=0A=
>        warn: 'rxqs' was already freed. (line 472)=0A=
>=0A=
> drivers/net/ethernet/fungible/funeth/funeth_main.c=0A=
>     441 static void fun_free_rings(struct net_device *netdev, struct fun_=
qset *qset)=0A=
>     442 {=0A=
...=0A=
>     468         free_rxqs(rxqs, qset->nrxqs, qset->rxq_start, qset->state=
);=0A=
>     469         free_txqs(qset->txqs, qset->ntxqs, qset->txq_start, qset-=
>state);=0A=
>     470         free_xdpqs(xdpqs, qset->nxdpqs, qset->xdpq_start, qset->s=
tate);=0A=
>     471         if (qset->state =3D=3D FUN_QSTATE_DESTROYED)=0A=
>     472                 kfree(rxqs);=0A=
>                         ^^^^^^^^^^^=0A=
> Freed.=0A=
>=0A=
>     473=0A=
>     474         /* Tell the caller which queues were operated on. */=0A=
> --> 475         qset->rxqs =3D rxqs;=0A=
>                              ^^^^^=0A=
> why are we saving a freed pointer?=0A=
=0A=
The field may be NULL on entry to the function. The assignment tells the=0A=
caller that queues were freed as this function doesn't use some other=0A=
success indicator.=0A=
=0A=
Note that if the caller passes a non-NULL value to begin with, this=0A=
assignment is no-op and the field still points to freed memory, it=0A=
retains the value it had upon entry. So, the assignment doesn't make=0A=
the field more dangerous than it can be without the assignment.=0A=
=0A=
Though the value is the address of freed memory, it can still be compared=
=0A=
to other values. It's just illegal to dereference it.=0A=
=0A=
>     476         qset->xdpqs =3D xdpqs;=0A=
>     477 }=0A=
>=0A=
> regards,=0A=
> dan carpenter=0A=


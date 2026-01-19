Return-Path: <netdev+bounces-251237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 046D3D3B602
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 051563008C94
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93D338E5EA;
	Mon, 19 Jan 2026 18:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=psu.edu header.i=@psu.edu header.b="2ih3n5Sk"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E3338E115
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 18:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768848223; cv=fail; b=S8a+yZPL/ghfPoD9UlY26EvSXVxVEZ+Qh0EwnISjc4mdXtx7S1dSit4AEPpxeo2yHr3mXc6STecQM77dpGtZ0vtpfmySFD0sryN1d/9+sLoDeAkAkbCpGM8Fit9VyUDFLkULX3SrBOGSE+q7W0Fk0dgXvuVrqnM4O8pzihLqdjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768848223; c=relaxed/simple;
	bh=l/pVLZmnuNr2mwTBIw57ZdjbPUS47fku/K4Uq7JJbwA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qWHWBP4dpRIhx9ifeSxXbGA0ucBoNo6loL2S4mu0NxYEdbKxekEX97xUdrKo8T6w4jXil1u/6l/Ok0i6TY9PAeALs9BBXjLI+lSmPfiudUU0ImTDwmzPaz7z+08Y51lXEzS6nmdLPO46rJpxe0r2BX/xvX6fHdNyRwyhQe8fafw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=PSU.EDU; spf=pass smtp.mailfrom=PSU.EDU; dkim=pass (2048-bit key) header.d=psu.edu header.i=@psu.edu header.b=2ih3n5Sk; arc=fail smtp.client-ip=52.101.48.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=PSU.EDU
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=PSU.EDU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZmrUkYPUFezV7ETxQohTWVo4+9+lKvWh3Leox9prsmmFvIDqpx49eIYxRxYFK5Xb7+ahfk3FyOFo7KnV2FzMjqKFFJChUHdPv8k8s0J+ylOAwnDXXEi8rM9cI0DjY1Ju9Ul0ohnb/fFOWhX56xXjPBL5XlcJ7h8Hq4KIr0fCWB2OuOr8WCMkVj0qFxOHircJCKXAu1PM6Lq+XgIB+6n/YmIRUAErXFfXzNe836GWOoK67VuASrWvMwAQG87I2e8YYR0kI0lDvBIRHjPJuO203Vyvc2jZe76ARDNvwv8mUYCkaOl0u/LesbODGuf//+hOKrBj2Z+zA7RoNBRC5y37w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoYsvxaGghkLIiCUXbr+Qh84kcjKXWZnZeOOYuLxcKU=;
 b=AovODlsPNQaH7D5hYyeddoOc5mjnBd6t+RrbOXd84UZABlkgAuccQOrAEiXDTx+bu2vTAhHulnBxt1UP9ahEpYBLB9FTw+9lBd3DDXp2irJp4zul7QxIC2ewgYyjsQce2oep6XwM97/ANSajcyOCuFdLP7Qg9xDx3N/XYgpsdcX5Ss3NBCu5o39BXezcLeRPvEHtipOy8JeislZCLmmVJDt5kpZ1bUt7fdvnkb4dikhSkxTlcLLUfHkEl531OJ7uvaEC7jGpW2rq7Yc/dzg47XeoFE0F6OBYxYFF9cK2w8elnHqB3APvsmGEj7R661Ftdnrr4w4yZmLFNvJMr7IhuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=psu.edu; dmarc=pass action=none header.from=psu.edu; dkim=pass
 header.d=psu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=psu.edu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoYsvxaGghkLIiCUXbr+Qh84kcjKXWZnZeOOYuLxcKU=;
 b=2ih3n5SkxzFtTGdCzjv8nbhSBV9v5r3B1R0I2ezW3PCYEp0RRFdVjmAy6TrDAAuVl0mN+teI5AOi9bA6Xze984NBewzqXNQJ61cAVO7hoLk2doftMPANM2JYCrbLA1XE4ImvqO3I3IRMaLLa6h6yxspjsVHpbbypUf876dPIUh4cFIjdidDVELYkoq7SjKPu2/eGroW5ZvPwOO+YLF3mgRYqyfgHxyPJAtiX8biZdx9+eWWacwA2jTNq8T/mz4CeDs/UOxLUdRGGnrSajwMoA+PCwqO1qh4Lz4IFdHJ+F/FQBWGninWUsJfZHgvNTkJn61IaVHUa8WIEez1GQEpvQA==
Received: from SA0PR02MB7276.namprd02.prod.outlook.com (2603:10b6:806:e6::17)
 by SA6PR02MB10551.namprd02.prod.outlook.com (2603:10b6:806:404::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 18:43:39 +0000
Received: from SA0PR02MB7276.namprd02.prod.outlook.com
 ([fe80::8d9:7aae:131a:e46a]) by SA0PR02MB7276.namprd02.prod.outlook.com
 ([fe80::8d9:7aae:131a:e46a%6]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 18:43:39 +0000
From: "Bai, Shuangpeng" <SJB7183@PSU.EDU>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [caif_serial] Question: ldisc_close() drops tty ref but keeps
 ser->tty published
Thread-Topic: [caif_serial] Question: ldisc_close() drops tty ref but keeps
 ser->tty published
Thread-Index: AQHcg04dJlQOHn8mh02qUc1JonE4k7VZ4GWA
Date: Mon, 19 Jan 2026 18:43:39 +0000
Message-ID: <6D59E412-D61D-461D-8025-38BBB3BD3F15@psu.edu>
References: <3510D1C9-7B5B-4A44-ADD1-0C4CC48CF3C7@psu.edu>
In-Reply-To: <3510D1C9-7B5B-4A44-ADD1-0C4CC48CF3C7@psu.edu>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=PSU.EDU;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR02MB7276:EE_|SA6PR02MB10551:EE_
x-ms-office365-filtering-correlation-id: f14cfdcd-2e10-4cb6-c80c-08de578aa9ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|786006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?QChRTBRzFFm4Hidr8GRS+7N/lCU/UF4IxCaRL207DAJoDi78WuInZKQ0zpeu?=
 =?us-ascii?Q?F/y7RC51BispohGEV2CbAc5r5tXNCRj/pAwmf+j6qk/CE9/o1TwKvxrr6J7n?=
 =?us-ascii?Q?jWaURGRq2oKd61xi/CqBwCiAUOjILGpnlc8w9ynurUPhJ8d0TTaFoRANXMqI?=
 =?us-ascii?Q?OcAPbBwoXOsG/BIxL8NLV4TqUiMwA4jclClMIl4XaMykdasD1tgW7Gg3cmov?=
 =?us-ascii?Q?h+HHj/LpklWrVROFowrOTfdPgSI/sRYhmhyvjjtYlOz+DkiJs5rdPZV5Yim8?=
 =?us-ascii?Q?F7d0AayG+8rjbh5SgtDLwYva9gX0RqXzbWNzyhpxDC8GbOVIVAu4WNza9P1k?=
 =?us-ascii?Q?Yf1GftcxA7LwbrwmjdxcQmKsAnEupub3/NZ5Sjx18njoXoHvyAfkaSpHJJI2?=
 =?us-ascii?Q?TsKQXeA9iRjOca60O9Vnug+T/X2JqB3FhDEs9ooPkZ8f1gz40/H0s6apKwMQ?=
 =?us-ascii?Q?pzg+N/4QabwYoM2ewBxJjUVF1adbRqvkRSmqAUfSgLBw+XVr1nP3uo3aSQzB?=
 =?us-ascii?Q?fVYcrAjB8EMlHatDeoCA1qJ/K8JhRu3vjGIyCw0626UcD4RwnTkRKCClbJtk?=
 =?us-ascii?Q?G39TPWKEBTxmfxS5AC6XE/JYgRIJNHpq5ehGixLCGJsfFEQ+a/wcgG99HWPh?=
 =?us-ascii?Q?UGDoBMzezPotw6QcFIpefker/B0j8EOnygMTxbnmVuKhLifBEK4tknxSlkaD?=
 =?us-ascii?Q?A1sLScw7WxbWWPbQK4ZS9aGQO3pw+cb5UbV1UOFgmMbappbk4cQ3GgIHores?=
 =?us-ascii?Q?+SIjFpU8JeBWpD8cBGNXx8vNuqtiSXyNLwPiHt4+sEjpcFgoSd7EmdcRyWvc?=
 =?us-ascii?Q?FEMlAgEMknb7ZY6saZV4vLyIu5crdIm5ia5KomTJzUV+zMarq92wvbxDT3Oa?=
 =?us-ascii?Q?Z+89P58t3BOuity0snv3XQL5R7dfjB/oIUfmwWvAkgBkgYQY5TPfevB5FlY6?=
 =?us-ascii?Q?9D+bqm/dQ5PxCpsCDnCXLz2ZBHWYm5GZF4PfDkuy464JWzzG52Y3ewQTC/Ea?=
 =?us-ascii?Q?M023aLN//rs9Wwma5VnLEseVIDDjxknm0Ll7e5JepMkRdAhWXXDfMHQVHzu0?=
 =?us-ascii?Q?Pi1etb3AZygmbp9frLuOwJPB7whAauUuBrcq3FWQ3VdUoeoPoSp2ow86Xm+W?=
 =?us-ascii?Q?NWGYkzUfI0/3DI4nctxGkjTKlVZC8Dr4Bx9P/fdeVppLmLYaz/ZF/n7vHAn1?=
 =?us-ascii?Q?wfIAXE/KIHW7cbsOdPSe4Z31W/2/brFvydN0JRw+F0VJU8hENdgITQ2ml9nA?=
 =?us-ascii?Q?iinbNId3N6PyGnV61q4n8gUs7opyHLjCno50t1KJcgcLFQTHgjpNZMLHRZPD?=
 =?us-ascii?Q?DMhB/1PIUSfz5mOzqLrirctEMwkZNtcMrhDkZWGOn8cixffxo7XoL8N//0/Y?=
 =?us-ascii?Q?3jD5VIelX3lvT6MLI/Fe898rR/xb2lEWyEab4z8lii5GSEYp0rQlvyDV2GZi?=
 =?us-ascii?Q?/YoqeLpXYEXvL//vcVtU/uXZ7aup4m8ea+8gJEyaVVHMEz2OYHR7T3qtjGh8?=
 =?us-ascii?Q?IIcTDcFQPdHFuutTjr5cJMUkDQ+9A9ZBOZKeh20YrtG99VZdfQSdKTozIpzR?=
 =?us-ascii?Q?MiuJOPJ1hWz4Hbrs3kVjpttiGmj1H9y/ntW3NUxHXq4V6g4ahXQEXkwU3tFU?=
 =?us-ascii?Q?b8fWfDeAjGAzNNtmZTDTXqY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR02MB7276.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(786006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZJ71+UhmFmQDSeWcPg5tcFMK5PIqdXen8/ACLFKmbDisrn1/i+0aOyWbiQTk?=
 =?us-ascii?Q?eOqU7eDxiVyeDr10s2NT9xsHRTkyOHuAXi/GDLJu0NU1Sz2fIV2KbQBi2cnB?=
 =?us-ascii?Q?OQRkfO+TlcrWpJu8cWk/Y626zV/nBBjdMCuvg6FuGeRtdYsCttyXX/6+XUxN?=
 =?us-ascii?Q?y0wEc/RsZ3a+nUFRETDEAiphfpTWAj1kJ/QeGJxmzfst4bd7hZ2K1m0Z7o74?=
 =?us-ascii?Q?gYOxD7wZm4BSgHGI2GiXT8Dno0e9N0+Q5/TjDYnrSqPli2PHZ+7oP8MqR65k?=
 =?us-ascii?Q?oRyo4PB/QJ8jH8s6+y+iXwM8hhjYWSfClaGLuIA9beyvKUxVO8DroV/E0Eop?=
 =?us-ascii?Q?1petua7lRbTiiQ2rN/TntJR/KQOWbiLCj7kMVfmXcOUsHPkZp3iita91ORxe?=
 =?us-ascii?Q?+cqxFX6r4dnkmCptu3CwBNyj9AEu2GzKxWcHpsJINRIbKQArHBMZas6G8Ydh?=
 =?us-ascii?Q?jPlS2EPZ/yH5wUIxVwHVioFkoeBb8kGy9SxwfRjEpUj8T24cVpPLdhjW7t8o?=
 =?us-ascii?Q?M9cK9MBiMvP60ZnuwdQfDlwy1Y+sg0UU+fCLCIHlF8CmdjkaL1cLtfXt8ei6?=
 =?us-ascii?Q?xQzLlgjoohikej6dsZMzoGDQ8HUg5WNkBuz1nl61H9xzW3/LBCSJBt1aJBzd?=
 =?us-ascii?Q?U5oPBwhx7hk7Fs+Nzs7bxDkkF87fmYqFctqxZJL+1ZIHgyIIkOHz9O9AtWI/?=
 =?us-ascii?Q?QH7LJJzlQM0nt9XltPThGzJYJCPY4EsQ7vE9PjE/y3jD4RXVemw9sVqHcY0U?=
 =?us-ascii?Q?oyZXGoFeH+bli21vi5jIR1cCwyoSSiPxAe/ccSWSUeqD0hx7Yrz20+hITPy9?=
 =?us-ascii?Q?L69gwEHw6F+mwuP996ofJnFxtm8U+idhYl0ExqUoij2kRI0IMliHcJufmfk5?=
 =?us-ascii?Q?ta1Nj2qDuLaOII3YsJxoD3m04pIztgmJwtLPwGS10odng3z/r5mTLVTITgly?=
 =?us-ascii?Q?QF29ELjKVAOKqWoom70Rs9i+q/SkSw/rJm/cUBwV3CWGtUhh4TkTWdsO++0j?=
 =?us-ascii?Q?zXenAKuNWGxSVQWcviZJ6k2KIepgaPE71DEJ95+Mmy/0OSlwE/X9LjDOxtP8?=
 =?us-ascii?Q?xod4H5kY75bkaP9tyyufuqj0BzK0JbnPwVm1KMsbT9boDLCTpz5jSAnkAFmx?=
 =?us-ascii?Q?fJeENA0Wkk7egyrT0CqwgPuOEl5ocyYGnoTDbf6tYKWxofM6XM6E3JyVok+/?=
 =?us-ascii?Q?Q8T9iEvuDXSt12QOO+wn6AEJr9AvUPB4xfpEvGUtZjYRiwktqq0y7fPMLQEQ?=
 =?us-ascii?Q?1IJlzmMXJ28xsWfIFdg81YnE8BxpMd5jDL6ShOMUwZ3xNtf7fBrWS5wKo1FZ?=
 =?us-ascii?Q?Tc+pVyqOihpt5wkSwps9DANz/hRVy3nUZ2HBnt9aLCLX4S2uuOvPT2hFt2gD?=
 =?us-ascii?Q?m2o79ic7GazSPr/UH18gvNEV1ycu2e1E1ajJC6WcYhUKjSu+EM0IYdLALAjW?=
 =?us-ascii?Q?0KXDZrPuOkPmPoJvkj4nF92BTIvD+K+X351/+mrRUDgrs2j9N7EMmqLh28ve?=
 =?us-ascii?Q?BSgiPEmDHZJ4vmggjDiigixJvVOPECYn3yhhZvmRqrfIpMb/Nuh0uEfjNYjq?=
 =?us-ascii?Q?/dKQINv4BhcthQsUtJECGNisIjxtRenrQJb4t+Ud5633KzMTYJzdLXwwtG5I?=
 =?us-ascii?Q?9mOThkZ6GFKXSyXBAcsoEYh2Ti+TM3mG3+qiXra+mKXpW3XsJj6zrHUotGGx?=
 =?us-ascii?Q?/6tAkZCvwEf+nzLDeDu2QidQ4B8Edhk0mhHFgWyXQRUEoPdF98BB9EayIpmV?=
 =?us-ascii?Q?c5meoijpRw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <47A2B6445A05DB4E80455E6F241E7828@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: psu.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR02MB7276.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f14cfdcd-2e10-4cb6-c80c-08de578aa9ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 18:43:39.6816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7cf48d45-3ddb-4389-a9c1-c115526eb52e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ovdh1Kdp3pP+6gpXmXqMbLBFf4l131RUspHeHZMQ11oKMUQA3agqEc8l9/7FjtR7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR02MB10551

Hi kernel maintainers,

We report a UAF bug on tty object caused by this imbalance.=20

https://groups.google.com/g/syzkaller/c/usNe0oKtoXw/m/Ogt5bJ-RAQAJ

In short, after tty is freed, there is another path that can access ser->tt=
y and trigger a UAF bug.=20
The UAF bug report contains more details, like stacktraces and reproducers =
about the bug.

Best,
Shuangpeng






> On Jan 11, 2026, at 18:00, Bai, Shuangpeng <baisp@psu.edu> wrote:
>=20
> Hi netdev/TTY maintainers,
>=20
> I am looking at drivers/net/caif/caif_serial.c: ldisc_close():
>=20
> static void ldisc_close(struct tty_struct *tty)
> {
>    struct ser_device *ser =3D tty->disc_data;
>    tty_kref_put(ser->tty);
>=20
>    spin_lock(&ser_lock);
>    list_move(&ser->node, &ser_release_list);
>    spin_unlock(&ser_lock);
>    schedule_work(&ser_release_work);
> }
>=20
> In ldisc_open(), ser->tty is set by taking a reference:
>=20
>    ser->tty =3D tty_kref_get(tty);
>=20
> In ldisc_close(), tty_kref_put(ser->tty) drops the tty reference while
> ser->tty remains published. This can create a window where other CPUs may
> still observe a non-NULL ser->tty pointer after the reference has been
> dropped, which could be unsafe under concurrency if any reader
> dereferences ser->tty without first taking its own reference.
>=20
> In addition, the ser object itself is released asynchronously via
> ser_release_work, so the struct (and thus ser->tty) can remain accessible
> for a relatively long time after ldisc_close(). This extends the lifetime
> of the published stale pointer and widens the potential race window.
> Would it make sense to clear/unpublish ser->tty in ldisc_close(), so that
> other CPUs will not observe a non-NULL ser->tty after the reference has
> been dropped?
>=20
> Thanks,
> Shuangpeng Bai



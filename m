Return-Path: <netdev+bounces-188994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED3DAAFCB4
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A583A519C
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583B92676FF;
	Thu,  8 May 2025 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OW6VGqs3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD6E2417EE;
	Thu,  8 May 2025 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746713889; cv=fail; b=ELAcrxhq3P6NBCKMs+MULf44qRj8J+FND2/3dF6xuauzbKLMhuUrasVGIgrRq8IDe1LCDsBB6Vd0kMB2RsDZVTgu17X8/cVIBi/ujF13LOioH3rZGWej44R8StR7OKU+CPDncg1RB3JUCoNHa4UxZTQIo+Y1aX5eGC0WjOm/JCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746713889; c=relaxed/simple;
	bh=SlmP45iNi/q+E31oUtVNbpjA5tjTBeAEQe41WtXGH3E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JDgqFpvculAVhExvvQVb9GtdP/uWXFFxuDQCuCCoEYlH8BcasYZCNlJPdtQ5Q6UrvFEZ7dBtY76vqPT6V25+itWkqh8qf135wSFv+Ki1Ct/2Csf6QienR8niv3DehWyTy5kc/HDgxg1UkzDCf19jJmmyNQVfhOlmF/0Q26J4rNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OW6VGqs3; arc=fail smtp.client-ip=40.107.95.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/x7Xdb3U1CF55j+pQDspQXLf9NQTWKYEjwtBwEjObDKImfKQCcQf6gGNTSqt2/p3CTIj15R+e4D1KgjkcVnc2DGgcQYL0gZOTE1M+vYFecEbbyDhvROfvrZoIc+KZVRZeXrEHc3FO4mphRUBirjT7Yoz8g/swXf2RCa5Ty48la3b7tARRZFvsU6l5wr2y/WGWO5tiuiKyYp55pikHP3pmMEgZNJZewNu29pL9R7xz09G3MAV/79THkEqrIb5shLYrJ2PJ0f1cZTDQCFkUrxU37Yk1b18IDXL5UnCeWwTKjbnF07WuXo8yd2amqkaGyoxg7u4v7d0eMVUBtFJspLQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtwSV9bZOYSomxQ+B0lunFiMYZ3ZuHQobKIHW9AYRgY=;
 b=yBANXhiCa/L0K6bcK9YRqWxsSnuDYia2CkhKrko1y+G9qAULWgak8NpKWuHsl/g85gomrAdw8u/SI17PGpUDZ8nmZ1LIRCNJ6/2Mj31bnautb/W7R85pMjVqz26NvYrbHwfqXruk5CuKqR7okL4oWqD56Qse7SMV4fKI8zreQD2kOu/Ig6L0s/Uz+IXrWV6PQyNV7bIrwkq5rgiHSOz1n2FjD+1FDtD8oYvBIN6fmLF6MLfRdoe32mONBANE3gXMOY6aUcpGEK3WY5Ep1Ex7cT0P09qIvb8RYSXOK+3vanukeLLYFaLzF8DxhkmI0Dx7gqt3hBZsyU85qCxqBmI+Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtwSV9bZOYSomxQ+B0lunFiMYZ3ZuHQobKIHW9AYRgY=;
 b=OW6VGqs3ohWsWwxkJyo+aMDSyUb+X/pzvMhSvYlnExpmYeZhf9XpEWDx1l4APMX0MsBy4fIobLLA6myOrHK/I4+zb9NR6LCrcH0SUF/rCjH8r8RkXL81T5F0Fn3joDGiCy/RbG3uHkNwdXvKFbn2LZtdVUdiKXVn0tb886boqJygaSy2h5lcnLnfFXINjc+a/0HDaKMG7LypzAGR3dYQlB7DI0LV8osRSRijEcGbSnhdgtQSTDwWDinGJmpVEijiP3djHEvdUPmLTsxAek9J7qOUFttkntBjlyO0HXaEznlZHsrFhoYoIs/Lo8u46ZXd67rbKKi7sE0hVz7JWn4+mw==
Received: from CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9)
 by SN7PR12MB7251.namprd12.prod.outlook.com (2603:10b6:806:2ab::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 14:18:00 +0000
Received: from CH3PR12MB7738.namprd12.prod.outlook.com
 ([fe80::fad1:1acb:f5eb:98ee]) by CH3PR12MB7738.namprd12.prod.outlook.com
 ([fe80::fad1:1acb:f5eb:98ee%3]) with mapi id 15.20.8699.034; Thu, 8 May 2025
 14:18:00 +0000
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, David Thompson <davthompson@nvidia.com>
Subject: RE: [PATCH net v1] mlxbf-gige: Support workaround for MDIO GPIO
 degradation bug
Thread-Topic: [PATCH net v1] mlxbf-gige: Support workaround for MDIO GPIO
 degradation bug
Thread-Index: AQHbPTCwkw/5mDAiDkuucKlF479Xq7LJ1/+AgP/0uKA=
Date: Thu, 8 May 2025 14:18:00 +0000
Message-ID:
 <CH3PR12MB7738C758D2A87A9263414AFBD78BA@CH3PR12MB7738.namprd12.prod.outlook.com>
References: <20241122224829.457786-1-asmaa@nvidia.com>
 <7c7e94dc-a87f-425b-b833-32e618497cf8@lunn.ch>
In-Reply-To: <7c7e94dc-a87f-425b-b833-32e618497cf8@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7738:EE_|SN7PR12MB7251:EE_
x-ms-office365-filtering-correlation-id: 0f687ae8-bf33-4a33-9806-08dd8e3b2341
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yv9zoa2UzJPSWNIdW7JYzRiv/dudo9Z5JWecep7nuv9CLLjBFcjTaWG9WVM2?=
 =?us-ascii?Q?mKp1jeWXbpc/1mB4URJEdNmgqH45x80C2UH354qMIeqi/fHvKzIq41lPqa6T?=
 =?us-ascii?Q?GVdsQs7qiybzZXpB6PG3j56T3yU9v4eGKGYfgOl4SwHLrWIQZyi5h54LeyUv?=
 =?us-ascii?Q?LLi727LN2moI/uUdLPjYiY/ESGQTEzDFnkMMqs02HPLdxMmfehp2WMymtD3/?=
 =?us-ascii?Q?bY60vxsoTui+ewtMP7kM9m3jg5YLXnVCkhT1C62Q0YhQlyjuRlfDKunGqAkP?=
 =?us-ascii?Q?r1mNmkort4g31F+CY7BK1b0ZEVRRYW4aGo9FmMQvcUTQypNUOBFZs6x4NlDL?=
 =?us-ascii?Q?OwijZrQv2L5n1SFueeMDlx9lOv0fBO0C8iXI/qmhO9a6vjijeMMMYPK9GbdC?=
 =?us-ascii?Q?urI18kD1RTese9EUwDVoNZ7ICORMcqSrzfasIUQX8VuBMxvdcc2bWYYAvqQD?=
 =?us-ascii?Q?ZVPr3Y2ROtUbQu1mgH/thbfGjDIOPZ7rVSXHew4du0RqKdkk9Z9DHY42EWhM?=
 =?us-ascii?Q?GfMxRRai8JjjtB9QGEGrrb9hQhN1v7uGxo+E29gOSsp2bEXICLdSL/vWh7n5?=
 =?us-ascii?Q?BH+iPd+BV7sHm5+Uvs2YwmNYWy8zoXPXzoXOR1y8uzbMUKmcv9dvQTXXsJ9J?=
 =?us-ascii?Q?79UKJ49Dx1W38jE01+JLYEo6LB99+JJaCZE71NECeaBD8rc+rKOYluz7qeVI?=
 =?us-ascii?Q?hE3oCc8moT4BlMTXq89M1XpgvRM5g1Y3xNldsW8zjmq+AXAc53ImzRFLWwlI?=
 =?us-ascii?Q?Zq1d7mr/v3HOY0OBwCyuqhaICiDbxQXw9CSSuVoI2LWJGexF/04p2hvYLri2?=
 =?us-ascii?Q?zefZlFjB0fLiEfRmLd8K8P4Dahsb6kp5QlTLVvDLEvVL11bwtSA7gR+2jlMF?=
 =?us-ascii?Q?z9O/aGbO+K5Zj6czvinPJZ9/9y1NW4UO6GAhTg+wVv//xhE/45JFWvxyaRRX?=
 =?us-ascii?Q?yP5Sn95TiTyKFqpW7m5h8r5VaGgzwR0CjHecCngVDnAC9wEjIWnBZA6qR9cC?=
 =?us-ascii?Q?2pdzI0ZFjmDFV6vev36qW5mrnODSgADqf1ibaPxnCVusyC1ejtzxCW4ZvOOs?=
 =?us-ascii?Q?i4m9LgrJbqwxT1Owt14avCKNnPK26V1ceD6kiq6+cGVh9cLII2l8V9O1H5DO?=
 =?us-ascii?Q?uHqteUynkuxCGBAzoBQXzTlCg8sVlrdNTdZTv7PDSVss9JAFJwK6R2Q92Tmm?=
 =?us-ascii?Q?/872yjxrP9f9D/OwddMuxLM0oInUNoiRyJevk9L6AcKt7XivkBBsvHwGXLnn?=
 =?us-ascii?Q?IRgqDZ/uNJjNRCWZEQu7PP5NCDSZiAbO/kSTGehQpT35ezVqViFFkUVtr3Bm?=
 =?us-ascii?Q?dL0S26ufzNiRdiYa1Hax0L6ciUMtcr28c09CPKkwUHo2KCSBtsOh0dM1/2Kn?=
 =?us-ascii?Q?CeH2Ej/HRzzVHl8fpoTOB/gpxcimNe71Wo60zwLriDM/QSZ6hk+Whgm48T7S?=
 =?us-ascii?Q?c0LvT9eKumD/lg6h2DlYclq0S60anc2+h4ypz2ahxOuxUWOomLX8YRPr8KWg?=
 =?us-ascii?Q?/V/cr3B4DBq15lM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7738.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YetEC3QJE9BgnM9o6+aGSoX6dV5RrogCg8eakoTeVjcO8fn55sWsaeQfNv+l?=
 =?us-ascii?Q?gE6hg4DkrOS7cYkWzgjcZLMATnt8K3E7YXB7ShQe4/K9Dq0ovH8MdNaLWanh?=
 =?us-ascii?Q?WdeWtTVFRyuy8ijlqZs4wlfHjvfIWmi9dXqR4ACRxdoLWUDK9s/aWdOH7oGw?=
 =?us-ascii?Q?Six4rqfPmEUVM11A7ejA7zfLW/wLRSJDviQr3hNKALXyQK4qBbutuf5xoN8E?=
 =?us-ascii?Q?c0Hy16aHdezVHnPpzrYK+SAGoNm04k4zDjRtA6KzWbhrqemRBX+Tnu+OS2Bo?=
 =?us-ascii?Q?BhgqCSlCl7fnXDxg1tm6ECFiSRhBoRXldv17vOyB6NsHh9EZTz+uF8yLbkFB?=
 =?us-ascii?Q?8a25LXZkKiYq3SDjGAn/FTGcEWVBIcl6iDkTjEGLKQs0DLZ+60k8BsvbXjGK?=
 =?us-ascii?Q?DJrEEf5UL/op1tXC7LTGOLawbwUJPAeA6feYNp2o4kFOLmc2uzA/1rD0Lg35?=
 =?us-ascii?Q?EcgcimWPbnbe/1fkHQix8i+/XC1lSpsdq6YyEsJodBZ6BzTuH6hAfXBIccu5?=
 =?us-ascii?Q?gsFBDKoKNR6y/7AsdOgUoFg1dmfAYVjAF27cFmXgZ6296ZcBOPFvZO6cmYjo?=
 =?us-ascii?Q?qE2I4yRQDIWGie20ODFmWuxAUEQIOnNrFkd+XC8Lj8U/OEOkjDHGQXEPsZB2?=
 =?us-ascii?Q?wAWJxFCOqjrJoT3jmUkbQhUqkrIPL68SKG4omxLFmPwa73YpUTnfmCFWGloT?=
 =?us-ascii?Q?YYxfgfHTxweE7H7Pa+e3OxrGi4P5bpvZ0jtBZdL6r33NbCqeq8bb9YfDMO+7?=
 =?us-ascii?Q?rWPlSwgWarxJEdf0l8hvLo3zN5y/MjZQezPl3ZBw3Ubr+5pD/msYbRbFS6sa?=
 =?us-ascii?Q?qPxy8E/hIxlO3uJBHBQp+aSUI67w6ag+NWzuq+4Cc12yccXrq/m2Bc7tFvAm?=
 =?us-ascii?Q?1chEk7/mEmtK05WAM9I6QoM+SfN8WMLhNVmNYtGnCzwXO9MIF/QfALPXfZ20?=
 =?us-ascii?Q?+gEp3hSGoGMPGztRdnkFfIMEgsek0nPld7qw72xdQRrWFN/yMlD1zFGz5kUR?=
 =?us-ascii?Q?vVdFiO3U/6wb8tj+KEquXodnCQdIgZUzxzjXuu7IhYevlR1cvGlBG5zdxGwC?=
 =?us-ascii?Q?dGPJBQ+e/jTCMvL30HPSvayGKgxnUk46wQ1sYQ4/jzrMEbHlmDhdjeI24SQv?=
 =?us-ascii?Q?aDG9Z716BxAN2ZqfpQAst1uluD8dHo/Cabyz29Jb2KC6ZfqwH7ARHAv56FFM?=
 =?us-ascii?Q?40QmrC9rQRDDY3F2kKVgNEbyuSFVNWyXd2kozyqtXLwhbtSpMPm62cYA/+Rw?=
 =?us-ascii?Q?RKHD92mU1x5OFdCmxJ9tje1jNY5gFjaJvFmXipwkzwWe9siDjNp3TpbOOoW7?=
 =?us-ascii?Q?Q+bKYAHBypqWBkWSkWVFy9sJb7EiKbJXjCh5K2tu8OmKDIc43wPaJTkgBpUQ?=
 =?us-ascii?Q?XP+Sq31f2s5A0bfqI0pb0mAOGsTIDTIY1b6LFOkqGp2btaowlE7G+Yxa1kjl?=
 =?us-ascii?Q?yrtBIvp4FGm1ozacec2YydAW51goD8Wh1rOvsWhzetodJCiefiVf3ko4YjLr?=
 =?us-ascii?Q?Dt1iIDTji4F5WB/fz06sWVOqiyLq7HNB6n/LYRObxinfNI9k0+iFrqxqW2yc?=
 =?us-ascii?Q?6ykf9MQJLkjwzLGmYWI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7738.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f687ae8-bf33-4a33-9806-08dd8e3b2341
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 14:18:00.1695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8yeZXGMHTRuDZsGuJEeikUVJa2EJEZ4L9bxg+WyT2NOoVovyDGJxBpZpKmtEg67vU0nS25FE3zlkubMQlmNANg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7251

> > Once the BlueField-3 MDIO clock is enabled by software, it is expected
> > and intended for it to keep toggling. BlueField-3 has a hardware GPIO
> > bug where constant toggling at "high frequencies" will lead to GPIO
> > degradation.
> >
> > The workaround suggested by the hardware team is to lower down the
> > clock frequency. That will increase the "life expectation" of the GPIO.
> > The lowest possible frequency we can achieve is 1.09Mhz by setting
> > mdio_period =3D 0xFF.
>=20
> 802.3 says:
>=20
>   22.2.2.13 MDC (management data clock)
>=20
>   MDC is sourced by the station management entity to the PHY as the
>   timing reference for transfer of information on the MDIO signal. MDC
>   is an aperiodic signal that has no maximum high or low times. The
>   minimum high and low times for MDC shall be 160 ns each, and the
>   minimum period for MDC shall be 400 ns, regardless of the nominal
>   period of TX_CLK and RX_CLK.
>=20
> My reading of this is that you can stop the clock when it is not needed. =
Maybe
> tie into the Linux runtime power management framework. It can keep track =
of
> how long a device has been idle, and if a timer is exceeded, make a callb=
ack to
> power it down.
>=20
> If you have an MDIO bus with one PHY on it, the access pattern is likely =
to be a
> small bunch of reads followed by about one second of idle time. I would o=
f
> thought that stopping the clock increases the life expectancy of you hard=
ware
> more than just slowing it down.

Hi Andrew,=20

Thank you for your answer and apologies for the very late response. My conc=
ern with completely stopping the clock is the case we are using the PHY pol=
ling mode for the link status? We would need MDIO to always be operational =
for polling to work, wouldn't we?

Thanks.
Asmaa



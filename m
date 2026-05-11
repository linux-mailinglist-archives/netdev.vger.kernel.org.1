Return-Path: <netdev+bounces-286433-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULckJOVLAWqnUAEAu9opvQ
	(envelope-from <netdev+bounces-286433-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 05:24:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1F0507975
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 05:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E75130073EF
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 03:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5462837C0F6;
	Mon, 11 May 2026 03:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U5NYELuA"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012043.outbound.protection.outlook.com [52.101.66.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D6B37AA8A;
	Mon, 11 May 2026 03:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778469859; cv=fail; b=EAvhVTgkshT7S3kuy9SeCghJDmXcE5qrv3lKmyIk4oSJuRQpDnlroJsT8t024gcaYrySpzRE6YdUFdNxNWRSh9te5h2CozDpKGbHL/geO3BbIgLYbqnkF0wDaEQbe33nNGbUcSLQOh8cYcyUX3l3EVz5wGwjfa/CMXv129y4KvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778469859; c=relaxed/simple;
	bh=3xNYEEq6dr76Wl4oVBXu0QwZO1UNAlS0bJ0s4knZ0/s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=orBy0e/uAsapZWNXVH6Jp09DCslOwvx+Ik5tmpNpHNeo0rTqrJhlnM8WpjII4X8bosEef9UheDwIOQaxhevBu0yrsFld3nqE4C+dcZIq6qj8F0S1Z9RBpM/EDkGvGkPiuzek8gtepP/5CPJRF0UzKdBrdrA5bwjGbYYQ5tu6O34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U5NYELuA; arc=fail smtp.client-ip=52.101.66.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhx/YkaY94y1ev+OIP9YdaJBAVSDwBrbZ7UB8UnN7R4/zaZJl5i3JsDaVCIXnIBWuI/DigWVvl4VFJT8iQHHTn4kcS03mne8hs3qLAttRzcc4QrCEvB8YKAm5kgX1IcnR8kOOK9Rqlpi9u9yXcthSwzC1SEL0Zgu+WPFFpgS0GgF1bODwORxwGiiH5iq/5sff6La1E0X0jk3hprq5QyC+/m35cGo+JA97TOmhO/n+UsoJF5eYyATpW9AJnNO12sUzItcQ+nBTciGGOzMrrIIOZ02QcfblM+2A9yA98K4Nl00ECMkwZMo5HMjwETJrmfFCKYesSp4crypeuy4kEZgjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHqAcWG+CHZUM+k58Ae11bPs7zg90su5861ckaEQa20=;
 b=QjDfqUkCgpti5bGcDiCZVHa0K8HWUJlqeNrTDydokOxFRdkAuJE/WUDt/yA4LMesSeDiUtF8JbKp/Eul5gjmc02KiaixlpuYj96UuK2SvOcyWJTJtxLyQF+hA27ZPs4VkA8ecVqr1SkI2C6L/+7SlBuNWhZfBEwHFhunkRJT6py6C20y4FkbuhpwnQgSYN9mCur/xTQUdF0bDJ7xj3DQFU1JMw6JIir1+Ui6oDuK7Fzg9jj1fkf+jplw0zOkDBHpIw5LJhu3uAcsxJlGueMgro4Vjgwk5pIfAtKKqU1RD9uzo2TUEaXFHbs213qO8nzvIWHAJGhh0g9q7XrRx+aMMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHqAcWG+CHZUM+k58Ae11bPs7zg90su5861ckaEQa20=;
 b=U5NYELuAmQEufRGMGotwpO142jxbl5/6Vhc6oD1/IoKuzIWa7E24amLZR8DtLbi/zJuovpKvGomRO4RBfqfcKMmE1IaGBUU6Z9xVpmxmZJfl1wSUrjN/bflNwkeEyZf/gWW/oloj3ENfheT/Vj2QEO03ffoG4HdT9o1zDrMrOSN02Ec65gur6CnoBJM4oJ2D7AD7T1UK+3XYA/C+EDt+kg6VEUClscb+TU0qxE66IPUHV7MsBMHYIhx4e/AAR3m4Q/hVzjQp1c00tibhMiM9oFp8icqo659wXHapV8HSn7ai5Pw3yxrkkfV3loxgQccm5rtOz/IEDziJ45zi1NsxdQ==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 03:24:15 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 03:24:14 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "sashiko@lists.linux.dev" <sashiko@lists.linux.dev>
CC: "robh@kernel.org" <robh@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "Frank.Li@kernel.org" <Frank.Li@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, Networking <netdev@vger.kernel.org>
Subject: RE: [PATCH v6 net-next 14/15] net: dsa: netc: add support for the
 standardized counters
Thread-Topic: [PATCH v6 net-next 14/15] net: dsa: netc: add support for the
 standardized counters
Thread-Index: AQHc356w4gnydCGti0+5DvSwEQw5J7YHFeGAgAEV3jA=
Date: Mon, 11 May 2026 03:24:14 +0000
Message-ID:
 <DBBPR04MB7500D5D6CEC358A5C49DEB8488382@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260509102954.4116624-15-wei.fang@nxp.com>
 <20260510104840.437A8C2BCC9@smtp.kernel.org>
In-Reply-To: <20260510104840.437A8C2BCC9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|AS8PR04MB8199:EE_
x-ms-office365-filtering-correlation-id: 1df56eae-e89b-47c8-4d3d-08deaf0cc728
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 iIhcAjiTY8DmKNGmKEIGhX2vWB8xzbgQf5VWnPIP8FadpWA0KmdWxNTU1aO4jkOgnR5zVnbT5wjl7bl4h4VaCSksiW15D8/K8IC7fL0DOMMa16+V2BgYWfdl953kzFh4i4aqz0wBn/oq72+u7YHso9Kk1hqjjqbtl3sGyloJvIHN9az21F0QmYW5SjTukGyb32AtWp4OA+5sIOo1PWM44n20ZelNt+xcXlVqZ3eq93Stuz+cdOUllNAJCJl2ViB5rZE5I2YRzFT+MnAAjHxHsn/FNY0jgVJBABwWiHVHBrISLefVqKcfh02znc+qPsrGvXQFhkN2ddhFVj3/u+D8jloHsOUhWTygkTzgx8M41F/vcpDtBTLGocvwg3PREWKXkafWIsFUcO9P33V+okpK9QALl4YHN29+Hjx0LI3W8P1MAtftWMxNtq7vZRCPwDkjrmZCKaDUyxPIBWsYfstMlqRiHYs6TiFOrQPIgXFvcfAn+5NWA/F4i3OPodtZtNc/8B0mV/vJNPWxgVk0mqzzJgi5vTeGktO5Sc8G5yXm2YOp3VkJAnx1Xz+JRLG5KhEh11U3DdrZ7ZhUbqx6MLU4N62x/R3mRvOk1sJL/1NqRlQlz5fliRIgy9DKIpqG/jAdTDU8mi056wOe28RMzPedfA0tq5OPSHNMZTotib2A6QyNI1N7/z4mKMf7wUXYa0r/U0OCYb/epfzD2BxJ+ODQjURMuHtR0S4pWMfTJ/+bX3a+8y0t//oIEbVFpo+ZJxRw
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?n6YcAfl1V4XCN0HCqomm5Zn9+4ov66SZ2tpp2BhTN8g8ZwyJI1TedeACE5tN?=
 =?us-ascii?Q?adqCQk61VhFETEULkhC3gTUpGe0LP9hFn5NXV35eMnqYodKRcGgdVIaFLSBV?=
 =?us-ascii?Q?s2zuTi9QFUxdGoxmWNRNctceRjnQXla61z2vbBI45LKF2544oaM67LeDgWyY?=
 =?us-ascii?Q?YHqmJ+ZkNPUUJKDhjfbNP5+880Z3AVJUIqKD4RGsnDnOn+s/m5gUex4RYgmj?=
 =?us-ascii?Q?WJX5k05ewy20+P683C3R1OY68vKbMjpUYdJQfTXuYKVvSY2XzH+Dm+Br8Fyi?=
 =?us-ascii?Q?8/NKhRspiTMfI153bSmZojUVd8ng8uscmnwgu5zZgGnxKj1fT44zZsB2mj4O?=
 =?us-ascii?Q?+FnqBsXH2yncLVo+GLlthAgsDEvpyf/zkF825oV5GKpXIQ+mO73/A7eymB/o?=
 =?us-ascii?Q?LKtNDaNxYSaqoLotmhtEBG4DpLz8uBBNEWQ4FAlj2xSB+4eP2tc6YTW/UkVF?=
 =?us-ascii?Q?mLRODcDAvX09KnwHWQuYh51PSzBlPMggM+Bgyh+058Nb3KkdY1r7PjlW8Khw?=
 =?us-ascii?Q?6tQ6ibAZaoWTgdlI03zj2lk+1YVLv2QUcCegDmL+UEpv0eGfg6zbhUfu2UFM?=
 =?us-ascii?Q?sms6ZSMtqzxPXdQSES0LtXToXh2kXWxS8/SvIztPTBed5ZTpxztIGHoiAkIv?=
 =?us-ascii?Q?6XkpouuAueJgAnnbPfDhnVjNUrDTuwHEMkp7AYPnH9FddEm5UIHEppQ2abWX?=
 =?us-ascii?Q?g8r272brLNTDayKHcu8ae/fmvxsOEU21VX8GbouTFrsgyFhEzkOg0W0HWf5I?=
 =?us-ascii?Q?rasghRr2R0sU2yYQ1rUnQkw+TSEkOzMSqZ+YpG+lTSFvCa4KDb0PM6H1trrz?=
 =?us-ascii?Q?YIRcD3yBCsEGgAPdL7ErQmnQ/qP/sU+RlItgukd6ByULpGznjw6ekUl1ltfM?=
 =?us-ascii?Q?YDs59dKhfdUDHesYPYFz5nuKXXL/IGo668DJoo42NnrCJFjAiFzrM59f3APr?=
 =?us-ascii?Q?qme2I02ohsFygFeVS8SCJpSarjT5g/jdPEsX9T9I0RA3ylGYuNscjy+89tQL?=
 =?us-ascii?Q?M3M5Ckqoe9RPWtP03OjKSlkGHQbPp++PT4iZS4rAQHGmvnr89WsPxuzuOvgR?=
 =?us-ascii?Q?DA1vD76h5vW8PyFRDYpqY437HbuMZw8JtkGSQnsmwg6uyvKZ1Qr4ksxYEWdv?=
 =?us-ascii?Q?hFlzFbd+xxWLCekKG/9ZMue9qoCz/tNXTEWonNB+jHNtjdvl/7fv4iHllRec?=
 =?us-ascii?Q?BqaGtSZXAWGPi9Tfcrzyz5gDsqbB7tekAQkiZvSOtJ8uON+B60S6WVe9kdjw?=
 =?us-ascii?Q?5O9pYFAUeRJZwbnh5ak6wj9695bXljHAnsr9sJFY1LEze5wZj7c8GaIz0eQE?=
 =?us-ascii?Q?4y8N+upGU7uJGefsAar8yfxeG8QhAh6FY8yDSu0rziq2zDjQIm+ktRrlIPDC?=
 =?us-ascii?Q?RozZu7y5Tv0fSpv5OnmEiGJGwszNJfkr/ZqxMOyA4gjQuennuDFF4RyrgwL1?=
 =?us-ascii?Q?egN2TJ+MIW/hU57aLJTLK/OWRl+ufQemY+96xkPmk07MQlVLPyopOCARepaq?=
 =?us-ascii?Q?zCez0f+nabvp4UDd5mxLqYT0eBsKOiUPHpwjJlRWgrI0Q24ZaXO0bdzW1d72?=
 =?us-ascii?Q?mpPdctYOAegxslwzWiPm6pxjVSax7p/Qys9oEi001E3IE5aXGVulE659MlEY?=
 =?us-ascii?Q?Qjr7ImsUejNTOtKVqIdKHU2/gycsfhxVch3Al9LJayvE4blshWrPIAp/icUD?=
 =?us-ascii?Q?KDaCgtgI0T5Dnbxuu+UYXrPnJS6mBc8bKFL8ZemapdZ0Suv3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df56eae-e89b-47c8-4d3d-08deaf0cc728
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 03:24:14.8607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NC7EaclOIF6I9UCM2nazPo1yPPbv0N5kao2qxofEqJE6DNW1bQLAZXdnYZ2zSwLZiwlQ/aqIItccmQHYLohKsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8199
X-Rspamd-Queue-Id: 0F1F0507975
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286433-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,DBBPR04MB7500.eurprd04.prod.outlook.com:mid]
X-Rspamd-Action: no action

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to
> consider:
> - [Medium] Reading 64-bit hardware statistics registers via `ioread64()` =
can
> result in torn reads on 32-bit platforms.
> --
>=20
> commit cc14b24b819aeb13f3bfcafbea26c9b2150e232c
> Author: Wei Fang <wei.fang@nxp.com>
>=20
> net: dsa: netc: add support for the standardized counters
>=20
> This commit adds support for 802.3 basic and mandatory managed objects
> statistic counters, along with MIB and RMON counters for the NETC switch.
> These are 64-bit registers read via a newly added ethtool implementation.
>=20
> > diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_g=
lobal.h
> > index fdecca8c90f0c..5b8ff528d3699 100644
> > --- a/include/linux/fsl/netc_global.h
> > +++ b/include/linux/fsl/netc_global.h
> > @@ -5,6 +5,7 @@
> >  #define __NETC_GLOBAL_H
> >
> >  #include <linux/io.h>
> > +#include <linux/io-64-nonatomic-lo-hi.h>
>=20
> [ ... ]
>=20
> > +static inline u64 netc_read64(void __iomem *reg)
> > +{
> > +	return ioread64(reg);
> > +}
>=20
> Since ioread64() is backed by ioread64_lo_hi() on 32-bit platforms via
> <linux/io-64-nonatomic-lo-hi.h>, can this sequence result in torn reads
> when accessing the live 64-bit hardware counters?
>=20
> If a hardware counter increments from 0x00000000_FFFFFFFF to
> 0x00000001_00000000 between the lower and upper 32-bit reads, would the
> result be incorrectly returned as 0x00000001_FFFFFFFF?
>=20
> Unless the NETC hardware provides an atomic shadow latch mechanism for
> these
> counters upon the first read, might this require a read-retry loop to ens=
ure
> consistency on 32-bit architectures?
>=20

NETC runs on ARM64 SoCs, so please ignore this warning, it is a false posit=
ive.




Return-Path: <netdev+bounces-102433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2CB902ECB
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 04:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7374128416C
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 02:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2816C16F85E;
	Tue, 11 Jun 2024 02:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k7N9eT09"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB36152161
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 02:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718074729; cv=fail; b=ZN9ETw0NQ8HuP6tRRaUEjBobhrUoT/cXvYqDPKklOehVBhVGTp7ZCsgWAzvCCoAkLT0Ydy0e8ezlXygdoYH66Uq0/7O+/1f2GZr7i0Tz0LCNzhZ/qhAF/IO8mYI7i7M4YS9uOgz7xO5kkWVnwFZiihHIvSdbhh7fD5ZsQDDGsBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718074729; c=relaxed/simple;
	bh=1h1O1eMeFaP30sK9uaaLzEP4N1UkJ4gazTArcRc5ZHY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c4Dwb6vx8rFZCgvCw/bMQ8VQjB4K75jFEf2yj670MGFmY8rt30R0Lh9wAHTQSu9H5tw4KFC0FdbBDLdiySZbHduf+ssuA61biU8a9pN60fiMk6uozNcsgFCfq45VZcKxjSqVCvOE+uZds2gPZSsyYavoHmT+AYYsz8oTj5FZbm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k7N9eT09; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQdKcVlBkVOLESWa8boK454PcI4lRfYslcw25OoCKy5+a/4MlHTjX4DWWK5lD3AU5B5tGABK83T/mHaIK0tZju9ee/PfF+OyEhrKq3i6UbuhfiZ+LoFxlwHvBywdHio0TnHWuLsuE/P2ROaO3fBHbWoWBFlypErA1XeXJKGkL/NgrV7z1TUc4E6Z06mzqjs5dMF/ilqVC6lVnXBSJ3wMMH5scpIIG7urRwF6ZIAZeS0PcTZ0LworkWoMoHuneZ8Q6ZCRQjP1C3k+MQiTdkyHb45OO/7Dofr0Pg/MqcwrLhbyxrmn8Z7z9WPiwteDkbrwTwUK/5Hv4n4D4N+wHKXKMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ip/ov8h/Bwfg/ii6k0S+AE4gO2AIqoCHoGUXeOQUP3M=;
 b=NDOdB95kRuO0OVRn/u3BdWDCymRsXr1dqYgAJy8fgP6iiLJTa4g4G48RxdsqKKQudHgB1fLQ5nC0IyLOyIA+C8re0V8tuuvccdOcNsZHusKwQEqaZJIWyQkjme4pu2E0FI2JUFx3VeI4/4xclNDv/fEy+64dgPer9v6borC/T9I4v4Wy6TqaN2kqmCncaZXy+n52kVNm0qYHD2yRjKOaBYaHAYNIP2kYGY9pNmSDwrlFa0nwMHgfrnuddFFAH7S+X7/+DS+EqXRgB/sR8c5BoD9rAw8mekB81AAeABN/gDF3AC8TuvfiKu5WRoiWvWU/goZZaZ2UY2O6TlDGlypvgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ip/ov8h/Bwfg/ii6k0S+AE4gO2AIqoCHoGUXeOQUP3M=;
 b=k7N9eT09Cc+FVM8qv8l1bOM/LoLuUiUwTP9duz2D0pCex+zuga9nGoyugcVjN0N/pDqAWPBpqMCfIJiaTztkHDT9sjBrgDsUxlpPuNTx804jid7k0gZiyIf/P5JVwsVHkfOiBLJl6wAlLROOZN38anlTY/pcWljfaa26ewzf4ZV9Coo3JRDQLR3aoKTPue7Irgsmcez/jVi4QACpCr9fLxf22mWr/WWU9P779nDMN/urHaEl6XxHzvpdwEG1BVjWoWrdIUjQlDV0cS0noL7JYIjzVG0+JnwNT5FaUhRjo8xB9JlPtl+dtusUquBV0vkRUxSPKt0SOTe89h+d5yRL8g==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 02:58:42 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd%3]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 02:58:42 +0000
From: Parav Pandit <parav@nvidia.com>
To: William Tu <witu@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [iproute2-net] devlink: trivial: fix err format on max_io_eqs
Thread-Topic: [iproute2-net] devlink: trivial: fix err format on max_io_eqs
Thread-Index: AQHau2v0ykh3hTGLsEaijxSeXgGZArHB35Rw
Date: Tue, 11 Jun 2024 02:58:42 +0000
Message-ID:
 <PH0PR12MB5481D31D2F573343D021F989DCC72@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240610192451.58033-1-witu@nvidia.com>
In-Reply-To: <20240610192451.58033-1-witu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN0PR12MB5905:EE_
x-ms-office365-filtering-correlation-id: 1005624f-2ffb-4dee-0a61-08dc89c26724
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AykaCgyHUdNtU7jERDmDd1mevuoE1/5ayDjdXUe5kQAYerkap2jE0nUZ4DTN?=
 =?us-ascii?Q?iZQ5clOYs9yADdgx0lW1esLHabnasz693c4rXoZtjAGPS47cacdyo9Y+9CnQ?=
 =?us-ascii?Q?V7rIiuAfK3ecXeOUNTiV6fkUjFc6XyQ8u1ZO/kGDF2nJ5CZH7JK+o4J1MuSG?=
 =?us-ascii?Q?Z/IMahKH4+HC0cZwKs2z3yNiSOf3ZMvge2Q6/tmn0AYT85dQ36Ssrdm0wDE5?=
 =?us-ascii?Q?4CbNUxUwEOOGYyh3csRj1gPiE/N12eaRf+EoJgc6sE6keHHF1xu9ncSlaVR8?=
 =?us-ascii?Q?ke5bKUF7isyjsAQgM45jkN1DOmzYZbS033gPh+HniB+6RupNS+RtE2sw8Wrx?=
 =?us-ascii?Q?aHPZ8hZnjap273B8Oebpruwtje7BaBLJYtOTjW9Qva1bwIrGUFGDAjyRxI42?=
 =?us-ascii?Q?AIQuFG0JogU8l+H90a/JSYOmTjCyYyOZfaFqu3HYl+7+TGvZQY0kjUSGU33p?=
 =?us-ascii?Q?vzL+xsutLEORH4wYV0sVSHf+zuws4ecNI9QVX20OKFY4ukn6QUUYs7t8AHeE?=
 =?us-ascii?Q?8gsDdGSTgAPHyMGLI6V08ltCsF6Nf1pyiK+FYqL8EAaKC+GaevTnCNbkDzut?=
 =?us-ascii?Q?bAgHcI0Mn1aAFHubkdTonRFzid1GkBAks6q+NkO0Aex5yWocZwSO7JLCzqir?=
 =?us-ascii?Q?jXhG7njn7pYfHTJbrYwLk6WZIuCnKbcws7+2xrJGZyzaCxprnr2h/aI4kBbY?=
 =?us-ascii?Q?J4gWDV1D+grm92hvB8jw0GXlJG2l1Pqwd2jWfkWgWHZ9jGz2LaQ+71zdFByO?=
 =?us-ascii?Q?2ETUD0BNBDdQeMMK68aASG7OiG5iaJKVzxFEks0iyLcCb6vcJDFd3XO+I6RF?=
 =?us-ascii?Q?9VmjumRrF2Xff65bIttfR7aVPIFhTbaB1pB7HFByNMNQcpFUUXtS7fo4wfGd?=
 =?us-ascii?Q?uixwRb9enhec4ibvLDefwHkFulwNr7K01jdrsOszUEHmE+FjLjrONVFBIoHV?=
 =?us-ascii?Q?w0g7OEUmVcCmy+wAz2okSmHqGZi+0SHl/AOditc8eF/AxCOO8f+s2a3lLzs4?=
 =?us-ascii?Q?0iUfcOvuUGUadiNAAfgtgAcfIDnWRrp9XWpgqI9YW9Mjkzre3tr4D6gQ0bCr?=
 =?us-ascii?Q?03YNlkYJVBz5RQt4ZsfqvRTb7p1VoDuqlGx9l/v0c3RO/zfVs2gfXB8e0rnU?=
 =?us-ascii?Q?GNnzadAaXSUjEGvgBfm6jN1xqzDV/tFjFYfaplsnysALIf/8XEMEdtooBEyz?=
 =?us-ascii?Q?8Wq+OxEFOPwHf1POOT38kdpkZfXZ39dnvWa9fRHF7lQCECrs2HH2e4KB20+V?=
 =?us-ascii?Q?sHJX+QS7ndqOMIClajwOaMweoFa1Rz2+7ZNMZ6+3CxCnqCavxtZdwZIZ8h9G?=
 =?us-ascii?Q?Ll8s0vND7+5JKc0p8AjxU/Jha6GP0eNhzqkUrydF/Q0wki6vIE9RQAttQw7C?=
 =?us-ascii?Q?UojU3Jo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?k4Zc4OCwKAcCKmtUTbjClausbmapTfFVrsa+QsPMQXoxjaU44uHRJlfWuiJZ?=
 =?us-ascii?Q?W28Wd3Q9Coe9gEEEM+ySLNuMHndex0wW/rcuhQTmRSvBvwYm/W8QA+eBAe/N?=
 =?us-ascii?Q?gfplPsxSrKKm7pUoaB7NcddIN05aer1iZRklsVdDt/FfLIKlBjr44K0QFOR7?=
 =?us-ascii?Q?pIZ7TFgxjmHtyd1NsH6SgWe7AsUjUwcGGUkD9kxxFfVQe4dtrmMa8IwpGBcw?=
 =?us-ascii?Q?tMBc+lievv9Ok+09igFnc3vZ2Cp8RzZ8db2Cd1PZsSEPIzvc3rK94ndXZFxk?=
 =?us-ascii?Q?d6tikT9U9rMviRzUDkXwIwrDa/K/iYjmNFHgfOk8drFcIwBFXTWzuZAdWdBi?=
 =?us-ascii?Q?V7uaMN1my2fzbV23zay17mOMuuRb/ZmQny/VfqvLKWTO+r1uyDPRe3UloEgY?=
 =?us-ascii?Q?VygzbYaZ4eeaBI6xmyLTmTuuCyqCkICLD79Omlr9ETPZJPzuSH9HvwiAp7zq?=
 =?us-ascii?Q?BE8lB9+QgFJjRHTIQ2l52XW79xAKYyX/m+na0sF+0D2PyPw7FOtj+y6v3dR1?=
 =?us-ascii?Q?hhaBmKaUDb6VTpXfoQ7Ecvi2V/nk/unmTWGeUomBu6QlSJz++NttbUCd3tda?=
 =?us-ascii?Q?k1Y7MVSGEKfxOARoMvPBF+txITHqUYe3+MP6pW7xMLFvCiPexIWp7b1qbZhc?=
 =?us-ascii?Q?w1nfpj8Liyox0W7RL+QIi7uQXg+uQs7cGj90JB1rc/6zVb2MBSC+cBK+Tka1?=
 =?us-ascii?Q?Wi3d77HnOCocg1ii8wvSeqtWtrMc/c+mdKFyvzD8yhOjhMeE0lfP6/Nr6Tff?=
 =?us-ascii?Q?Zb6CIpquDtBUHS8z1R0DZwKRe7SPUMmE5pxm+/FbK5EiPFRj3Cu/6XzdVGZe?=
 =?us-ascii?Q?H07RwORxlPDm60V6ncQLwJd+JuSSyQoenP1ei2azQEmg3XBk+AxYGDb4RzJk?=
 =?us-ascii?Q?ddxcMwj3VWKMGOyOHM2RONrrnrrXjIMWRvGH5Gp0LfhjJwIxVfnUtUjJBMCF?=
 =?us-ascii?Q?AyaVxxl7shoYu8B8ouhmuBSN1xuXn98MKQbWkdjxYkLZK/9tpOzd60ddF6Wh?=
 =?us-ascii?Q?HFUUr+PFZWKTDVGEjuGfHI2gE5sRyJS0jsSL/r1s8cX3vLnAAvyJ2OMEIqz+?=
 =?us-ascii?Q?Zb8zUD3lWND5sBJKLJO7xxwcb7j/Vk/FTXBZoEcvFxE+cqmJZA+XckBVthlB?=
 =?us-ascii?Q?GEHHcUbw8u1jJ3uumvc8AzfgUq7TO6gpu5/I+s/DWDE8by1N1j8OB+Neas5Q?=
 =?us-ascii?Q?Huz1qviWF7/4LwyvBNT/RlAMVwEFJJ1GP30QCJn2EHTqFLDEW5qQ1rcyjErU?=
 =?us-ascii?Q?N5On8NoXhrKE0lfn8M+ilAtoHf44TT/YBhHEEEsrhlGKgfQCzxtiQLo0KvZD?=
 =?us-ascii?Q?0qA3vKFMUNv8GM4VQZ88gkNDeN6s0fn+mVrXJXWibApaLgzxVzS4lah3kMYL?=
 =?us-ascii?Q?t91/xfPTXQavPrcfLtU51e5hFYp0lYUujV9UDjE0RYsG6TfsN+iT0zsBQYAp?=
 =?us-ascii?Q?OpFisQ5Xm00nO0kq9dEZpfcXoETfWcwl9nR7Ip0KktqkMuOb03BzsTQ/gyi5?=
 =?us-ascii?Q?kBFbng1dEaASIqj/ZfgugLaA7C7k0nuL/1gJnSVsdwxgyuPR9PhJSjePYuhS?=
 =?us-ascii?Q?4ACizpZnnPQIB+DDemQ=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1005624f-2ffb-4dee-0a61-08dc89c26724
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 02:58:42.6245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GcVjIpO0DieBiZBMt6iqjLKfbLAgZMaK2Qanlco5HxpePDe1mfL7+UVfV/vOECM6JxjDJouQ0jW2rYEb7q17UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905



> From: William Tu <witu@nvidia.com>
> Sent: Tuesday, June 11, 2024 12:55 AM
> To: netdev@vger.kernel.org
> Cc: William Tu <witu@nvidia.com>; Parav Pandit <parav@nvidia.com>
> Subject: [iproute2-net] devlink: trivial: fix err format on max_io_eqs
>=20
> Add missing ']'.
>=20
> Signed-off-by: William Tu <witu@nvidia.com>
> Fixes: e8add23c59b7 ("devlink: Support setting max_io_eqs")
> ---
>  devlink/devlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/devlink/devlink.c b/devlink/devlink.c index
> 03d2720225a2..4929ab08ac40 100644
> --- a/devlink/devlink.c
> +++ b/devlink/devlink.c
> @@ -4761,7 +4761,7 @@ static void cmd_port_help(void)
>  	pr_err("       devlink port function set DEV/PORT_INDEX [ hw_addr
> ADDR ] [ state { active | inactive } ]\n");
>  	pr_err("                      [ roce { enable | disable } ] [ migratabl=
e { enable
> | disable } ]\n");
>  	pr_err("                      [ ipsec_crypto { enable | disable } ] [
> ipsec_packet { enable | disable } ]\n");
> -	pr_err("                      [ max_io_eqs EQS\n");
> +	pr_err("                      [ max_io_eqs EQS ]\n");
>  	pr_err("       devlink port function rate { help | show | add | del | s=
et
> }\n");
>  	pr_err("       devlink port param set DEV/PORT_INDEX name
> PARAMETER value VALUE cmode { permanent | driverinit | runtime }\n");
>  	pr_err("       devlink port param show [DEV/PORT_INDEX name
> PARAMETER]\n");
> --
> 2.38.1
Reviewed-by: Parav Pandit <parav@nvidia.com>



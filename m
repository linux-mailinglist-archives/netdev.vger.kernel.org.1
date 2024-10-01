Return-Path: <netdev+bounces-130701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2A098B3B8
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 07:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 698FD2830CC
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 05:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9401BBBC4;
	Tue,  1 Oct 2024 05:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DiFuxIjG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5241BD50D;
	Tue,  1 Oct 2024 05:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727761039; cv=fail; b=rde649F/wGWbjEaApa9dXKUabbleVWKmhOBqeGcUUbKOjM6jfGKCfXR7qZkMBazoAnrIo84JDos6mP+VbOfnx7S0AWh3rJ1loWvwwlQ9EjYhZ6pRUUSKwVGinDgSOA3igkjzvDoWzX3dJMkG412WbSycWTLXHeaydPkeJbnQw0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727761039; c=relaxed/simple;
	bh=eQMQofAwJSdYK7jr42X1rx9LGofLyLia8AH6ez20jHg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hWK0HKwwGH4d1X96Jra1FPhyBnwVW7jB27QAHmFyShu2Rk2rrXiVMqbTd7YJcPb1HiLOb3yQjuffD2jpEY9Y+9bhn0qAYUkaWklwyGmRz3BNREBkgJk/OTrc6Bb2gedyRi4RP2MI71FZtJ8ZeU0zyB4YyWzgYLYPxkSTa09dhP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DiFuxIjG; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9tiG2+BqV4rsO7nwclEqmkVsJYpg9kVHyFPTMLnamkuSZdIHA90RBzk0TtgJeORV8x1+eVQImmoHKVK6PRzJwO9Wfo96imgIly+6aHOm4fewkKsWxLnwjouY9WJsulv5s8IWLmVfZ4FXHVlzhoS4ql6dicwtxowhZ9XfWZkaC+M2co8w5+UdT84lt72O5HcozoGxUQ74QxDa/3NnLI6nShVvjLPIMHcUHHSguWdEULRinkOhc5M4eX1oG4FsF3WPrl1LVhnWRkyzhew2dRbX3cjN03JhwvGvxcrH6btLg2Wk3d+cPWKpZ6J0prli4KLAIlOWUu1GGZju0vCMwYqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hsn8Ew76F3mAxHDHcu0UZMO8OsOGrXN9p4BSJameETE=;
 b=wiKGSmHF8jwJ3PVNvgTqIEITZ6YMTic8ZMPFoIzsaPgtHJcyDpxmv1oal4xHXGajQtqNkU2v6b+FC2TIv72mk8948VjVXEAF5opINKOf3GQ4XWEiSVCLAJeK2QMg1AKxusoU+tr/5ndmkT4uvwZXVIv8BWF3UccmsYZyWOCN1TXTN/B5yyOykmS4V9e5KiGpIJK4jyRu8OtA/0Z/eizNdEKKpzTMVBNBHa5uQ6h2SSshTZXqkHlbTikg0kT0pmL0JUEiiLLb8Sd4aH9aoOb1B8kVVgATcCYVhPcTh4Q2ZqV7FyffgKGG80U3xAAQjGc4MZ2pz+6/ugD7TEM6B1XP3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hsn8Ew76F3mAxHDHcu0UZMO8OsOGrXN9p4BSJameETE=;
 b=DiFuxIjG20Tz5WzcUWCIu53v8jYkPiE7e3fzKai6LoPWWL8ZjX3q7zcQ4SJYsiQofxQR3/iXTFA3XZ8i1eL+zea5jkEmcN7IHq+TbcT1yaE/U0d/K3dRHQvqKrCGCalUDzwgSJ7HlqJOjxQ441rVRHXv9L9Qt99w33M0jX6hWfjm+GMZbQqG58a9lo2jFLbzUwC9aCWNj7GueVzfhcObGaeAj/2miSSHk6CV+JRVVW2HjTj9SmlLFPxylvWED9kuIrGiTgH7qMtkvvSeCJKIO3bNGsSBbpv1P0+QZFekgZiLxrhlKIreR9YMORq2Fs1XNeqACpJx45FFpBy2pzKxBQ==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by DM6PR11MB4628.namprd11.prod.outlook.com (2603:10b6:5:28f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 05:37:14 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708%2]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 05:37:14 +0000
From: <Divya.Koppera@microchip.com>
To: <andrew@lunn.ch>
CC: <Arun.Ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] net: phy: microchip_t1: Interrupt support for
 lan887x
Thread-Topic: [PATCH net-next] net: phy: microchip_t1: Interrupt support for
 lan887x
Thread-Index: AQHbE01nB5y9tkf9zECXlzvwEYnrpLJwiVaAgADXxWA=
Date: Tue, 1 Oct 2024 05:37:14 +0000
Message-ID:
 <CO1PR11MB47719360D9B331C4A723F7C0E2772@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20240930153423.16893-1-divya.koppera@microchip.com>
 <31efa9fa-f4e3-4538-b09b-b1363e419079@lunn.ch>
In-Reply-To: <31efa9fa-f4e3-4538-b09b-b1363e419079@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|DM6PR11MB4628:EE_
x-ms-office365-filtering-correlation-id: 39e9a49d-7524-4bbd-ed7d-08dce1db1ad0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OZ0oVCbuOT2eH1mpcNvJNDrJD6d5V8ceBdAT4Ng6ZhVE2fIoYfxLIdbsDsqn?=
 =?us-ascii?Q?VEHfiTibuvRDEFaAkYQutoL6HgnqcAqnphMOXvUpXUGMwzky+LQKjYZjtNyB?=
 =?us-ascii?Q?fDpgKM0Ol4i6zQ4ZrYw+IscxCi82Sap3PBbLLFeE5hDUr/9PwO4JlYbftXf9?=
 =?us-ascii?Q?HcUtT2tTg0EAlLId9Iyp7cLJVKc1Ea1Iv2B+LfNxKoAseXwpiRUlddZKc9VK?=
 =?us-ascii?Q?AZ2Tgu2xPhqbMvrfFr8EmBus1aVI2/DSFLqx2+pZM8EQGetnfjaxyn4RS2Fs?=
 =?us-ascii?Q?MsZAlQWK6NP95+CgaUlXF4i94HzLJLIVKIfOlQC4PcBAU5DqLTTyiK/sTJxR?=
 =?us-ascii?Q?cyLzQ2Ic0sm14lR+bALdolKSZaRXJ8IQpheVPUlOvNUxqFkhx/+nd6AYyjBl?=
 =?us-ascii?Q?cLu7g/M9Hbn3FDWSzzpWQI+PrP/Nfi/Mkd4vVao77pz5ibcpl4mKjlgKmPVE?=
 =?us-ascii?Q?JAXBKGYzfJHvyhWMnmKq7LtPOGqjkoEK0QWy9xF4VX444H+zgv5OhTlOOFa1?=
 =?us-ascii?Q?kWNQNMuAzMlY5SiVzxSgAhwFds6YyMpTvpXObIJAXemJQ3fr9WiG+hNaIi/Y?=
 =?us-ascii?Q?PhW6mfoIhArYnQyZwAmnTmGY+JyQbJJBMoQcV4rKwA7D8HtuzOJcGn6fCsUf?=
 =?us-ascii?Q?7iLBec0E1t3grzWRGFcnOKJyWH99q0Z/z1n8HDY1cUD3QHmrstcAtwFwsIqM?=
 =?us-ascii?Q?zpbQLVBmmXvjJafIgkvlbQwSZv+I2x5PC9rlgs8FXcNtYdEFqmMur7UWZITz?=
 =?us-ascii?Q?3uf/PvoOdAOUbVfWPT69lCqvWrE2zc0I0/+WmMC7VkzneUABNfQOU0y5oc2p?=
 =?us-ascii?Q?ZEfVvhtrKWMr3kNuQLu8S09A7W3IUcGOuc6s5ipfIx9cqwnLJpg8pMvhoIE1?=
 =?us-ascii?Q?6UiBJ1yQbAOFECxfM4dHscYv9fd5UJXfE/qLdER9yaHaVTsaIOgHnLxNHhqb?=
 =?us-ascii?Q?H+mZnOLrrYfgkXd3YGD47f5dEHdkvmL7aqunep4y4J7NiehVq3ZkOq1SIYnh?=
 =?us-ascii?Q?A+mJfR3VDY9ssK7VTMAc8czFuOlEatSDPgMyhW+mJT7t7KJIFC/rkXOu9B8b?=
 =?us-ascii?Q?cuh8v/qRrUV49qThakJQntfgJoITorm1u6CsVjYyx5yfe4kHmrINPk4V+Ii0?=
 =?us-ascii?Q?j+/qDb24lUHfTAXUgoJzkT/1OuOOU7CkV9J8Iy5WFfN+FOr3oWoF2wXTAHkE?=
 =?us-ascii?Q?SnF6K/H3L8WiFMBKpbNBr6RSzXOyHqKOCvlSpRmQrlUQqbXn1hCjANsg5+g/?=
 =?us-ascii?Q?aF0X2efoDYwDRuO7ukhMBKv+qKrA86wTXLiOH12+DrqvissQccIXE4dn7jKL?=
 =?us-ascii?Q?hQLlnHZZi8Hi41B7vLgq0hCQWLWXNsQgCUvFu+QgpMp7NWuesiEdaed3uMs9?=
 =?us-ascii?Q?1TUWpPzSl8T3a0j/vfctMlJcJnxkjL9E0aJ4vxcbeQp3gXZfyw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cW7ILbxzvb/jcsr4XzAF4QTCqNiTmkgta8weAbKI255R/S/ku7wFOvHBBgAI?=
 =?us-ascii?Q?GwOuK1U7dwy1OIUz9nnl1vpKmrMs5BR/5dePnAnRftZzqQKA3t5U0ncemuA9?=
 =?us-ascii?Q?bcsjCkelqdb1kpiEBKDtXNG5biT1B080DAni4jZLYrF68XQrZdEai96rZuRn?=
 =?us-ascii?Q?2yl7N3bz8l6SzIiMsnBo7RRswfxBTR89L04ncinkSCJRYY48tPCJv0Nn1st5?=
 =?us-ascii?Q?IwM4Gf/fsdrag+waRlsQzS85DhRVwPzjgIg1o89mpd688tukrC2QhnX7qMZA?=
 =?us-ascii?Q?X7zMRnKGefrakBwwOwRdCVG4qPpIt62PTgtLSUtNGauHs8NFGTkE+xOmde8z?=
 =?us-ascii?Q?+WVhWTLlrTtLkz8GLqWxkPXVDSJrPU5dlt6+QCjX7AYryjjyBKJ+DcEibkII?=
 =?us-ascii?Q?yeurfb9y4nHPJcOHo5gXVdXjKGbmMB2s7tC4OWurip6VOqA3KLg8SjwZKij7?=
 =?us-ascii?Q?zoc7rPuNHooeqH6AyLWiQZHxoV58Gxk/Fzyrth/gc8Y8iEIaCf+IIVC4au+S?=
 =?us-ascii?Q?eRyZtaOjY73qp5a7gaD8KxbwRyCW0T+SJZ4A8pBMAAer+lojq4naB+Fuy+q+?=
 =?us-ascii?Q?XeKmWAX9UWZu7he9awbWrhqO8CAPL4F798Sy8s0gIdZiZkw4X1czwuMUG33e?=
 =?us-ascii?Q?DITI/afKR39G8YQswQP2Ctw5yMf+yxqABYk8YGXvxbIvyAKdUqs2+MGH8uXj?=
 =?us-ascii?Q?mfWLGxCyuvFs9T794gDaEUa7WI+nEq4O4JA38EKNAdPIHFF7BgAzY73yGaqN?=
 =?us-ascii?Q?LxfUIYhS/F667L+/zakgTqnWG0VpAdh4JCKXjUxvqGaSyyP1Gv/0+F3crANp?=
 =?us-ascii?Q?Q+0wBiXKw+igNVmWn7DC+CqTL450sbrK/z+idOFT0HOrVHJ/gbXAFeXd1VbH?=
 =?us-ascii?Q?VM4VDE71dqnfXsBqjBohUtzXWVcTJa2NP6u5PDgXwKiBQhbUDRC30xuxmnZ1?=
 =?us-ascii?Q?lJ5huiSSo5Lq/Ib7+Ws8CMa5icHYubBsAISndtUPzZDnNpa2wIF5o18gOQMh?=
 =?us-ascii?Q?h+BJlULQmkS8CaSBgYs3UVP7hLVuzCAYPwROdlfqEJK7opw2gPhi7cN5U+ik?=
 =?us-ascii?Q?COKchbJ89vLKkibpT2o99wvSbrIPQiXjDqiEziSncdOhrUp0Ihb0E/G4eTEy?=
 =?us-ascii?Q?n5Kuks8YXoba+/N0HJ1eLvFQfmP9WSOo9fBGZMXaXJKiUoIsfS0yIfcb4lek?=
 =?us-ascii?Q?z69kUNl0SdjtfUFwX8JZiHPNm8PHaWyeJUS3pbZCs7A8KV46RaGg/x3mcr2w?=
 =?us-ascii?Q?0rocD7QZMecp9WYIDUqA6FcaSxmHi/H5PgSYdK5totSxRKasIZf/Q8/HlDIZ?=
 =?us-ascii?Q?2/SB/SoiElYvmg2CrFVwbgafQrK+zC2XuvAkbdLkMtoy+2ykmwDrhetIq1+8?=
 =?us-ascii?Q?43PHj1xiy5+C+8k8Vyd3/ZqoJdu+XM7lG8/B4YBAEoYxsF9lN3RdP7aIfDt3?=
 =?us-ascii?Q?N+z8UwZe3ocnXAOd9M5rrioF/W2SBkJNsxpifYaus1XE42xkfDNbiYufdDIq?=
 =?us-ascii?Q?xCbksn+ONKUacux4+SDtQrOt5sP/fzG1gDQElDjElo80N2tdp15euaL6phhv?=
 =?us-ascii?Q?JF/LrUNf31gy1Z9qduZR8Lzym/hhQeBDCbN2LcB/Na+Zla8WQJrDzR+TPR1W?=
 =?us-ascii?Q?Aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e9a49d-7524-4bbd-ed7d-08dce1db1ad0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 05:37:14.3275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SR73KytwVFoyvVPLRvsHSyZj4Y+RFBYGUL14QBjwvxfVfTPwj1uKeeysZFQz9Krcyjwry6KWtJ5A58D8RlM8lsW62P/ozwcmkoqX/FcmJYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4628

Hi Andrew,

Thanks for the review comments, I will apply it in next revision.

/Divya

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Monday, September 30, 2024 10:14 PM
> To: Divya Koppera - I30481 <Divya.Koppera@microchip.com>
> Cc: Arun Ramadoss - I17769 <Arun.Ramadoss@microchip.com>;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>; hkallweit1@gmail.com;
> linux@armlinux.org.uk; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH net-next] net: phy: microchip_t1: Interrupt support f=
or
> lan887x
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> > +static int lan887x_config_intr(struct phy_device *phydev) {
> > +     int ret;
>=20
> This driver consistently uses rc, not ret. It would be good to keep with =
the
> existing convention.
>=20
>     Andrew
>=20
> ---
> pw-bot: cr


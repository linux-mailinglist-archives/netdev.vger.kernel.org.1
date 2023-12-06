Return-Path: <netdev+bounces-54469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A988072EF
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 15:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3570D2818F7
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 14:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701812FE32;
	Wed,  6 Dec 2023 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="S8rBgBnp"
X-Original-To: netdev@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DF0D6F
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 06:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:
	In-Reply-To:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=rbkAiLPdDrwrZVIVpdNrtBGZhI0eH/KAjwBpTQgvY30=;
	b=S8rBgBnploD47E11aEuR1wZ44zwfoW1WgLrtpRsv3vmibZ/YY1TjiFHMuOdp5lTpuBYktzsUeec
	QT2S6rw08B2uV+xI1ZpUePyMGMC5Dc2DcWjU4Hu5GXU/fG3hssRaCKytjup1svjVuFuNcKXnpO9mr
	P2cQX/b6mxJnL4rz2h/17qVHr+s6sx9NPpCAzI0EZCTgGEc1H49WpzflvIZ+khduQ9D+5uqYKGY9f
	hH+aYMfIzwubVyeJ6ENdOCN8iJ8mhOOOmkLkyFMYSLiQAGQNaUwwqdrE/dI7zICwTIrEBfLSVumuG
	ACPtGF3H8D2UHchHXc9QM6lOagk26juGeKAA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1rAtAZ-0006ZW-3z; Wed, 06 Dec 2023 15:46:35 +0100
Received: from [2a06:4004:10df:0:acbd:6a4c:7b86:d1fa] (helo=smtpclient.apple)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.92)
	(envelope-from <sean@geanix.com>)
	id 1rAtAY-000353-MY; Wed, 06 Dec 2023 15:46:34 +0100
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH] net: dsa: microchip: fix NULL pointer dereference in
 ksz_connect_tag_protocol()
From: Sean Nyekjaer <sean@geanix.com>
In-Reply-To: <DM6PR11MB412432B1ACD79A975202D0F2E184A@DM6PR11MB4124.namprd11.prod.outlook.com>
Date: Wed, 6 Dec 2023 15:46:23 +0100
Cc: Woojung.Huh@microchip.com,
 UNGLinuxDriver@microchip.com,
 andrew@lunn.ch,
 ceggers@arri.de,
 netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8C611683-B511-4580-B265-5691E3725604@geanix.com>
References: <20231205124636.1345761-1-sean@geanix.com>
 <DM6PR11MB412432B1ACD79A975202D0F2E184A@DM6PR11MB4124.namprd11.prod.outlook.com>
To: Madhuri.Sripada@microchip.com
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27115/Wed Dec  6 09:44:21 2023)



> On 6 Dec 2023, at 14.35, <Madhuri.Sripada@microchip.com> =
<Madhuri.Sripada@microchip.com> wrote:
>=20
> Hi Sean
>=20
> -----Original Message-----
> From: Sean Nyekjaer <sean@geanix.com>=20
> Sent: Tuesday, December 5, 2023 6:17 PM
> To: Woojung Huh - C21699 <Woojung.Huh@microchip.com>; UNGLinuxDriver =
<UNGLinuxDriver@microchip.com>; andrew@lunn.ch; ceggers@arri.de; =
netdev@vger.kernel.org
> Cc: Sean Nyekjaer <sean@geanix.com>
> Subject: [PATCH] net: dsa: microchip: fix NULL pointer dereference in =
ksz_connect_tag_protocol()
>=20
> [Some people who received this message don't often get email from =
sean@geanix.com. Learn why this is important at =
https://aka.ms/LearnAboutSenderIdentification ]
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
>=20
> We should check whether the ksz_tagger_data is allocated.
> For example when using DSA_TAG_PROTO_KSZ8795 protocol, ksz_connect() =
is not allocating ksz_tagger_data.
>=20
> This avoids the following null pointer dereference:
> Unable to handle kernel NULL pointer dereference at virtual address =
00000000 when write [00000000] *pgd=3D00000000 Internal error: Oops: 817 =
[#1] PREEMPT SMP ARM Modules linked in:
> CPU: 1 PID: 26 Comm: kworker/u5:1 Not tainted 6.6.0 Hardware name: =
STM32 (Device Tree Support)
> Workqueue: events_unbound deferred_probe_work_func PC is at =
ksz_connect_tag_protocol+0x40/0x48
> LR is at ksz_connect_tag_protocol+0x3c/0x48
> [ ... ]
> ksz_connect_tag_protocol from dsa_register_switch+0x9ac/0xee0  =
dsa_register_switch from ksz_switch_register+0x65c/0x828  =
ksz_switch_register from ksz_spi_probe+0x11c/0x168  ksz_spi_probe from =
spi_probe+0x84/0xa8  spi_probe from really_probe+0xc8/0x2d8
>=20
> Fixes: ab32f56a4100 ("net: dsa: microchip: ptp: add packet =
transmission timestamping")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> drivers/net/dsa/microchip/ksz_common.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/dsa/microchip/ksz_common.c =
b/drivers/net/dsa/microchip/ksz_common.c
> index 42db7679c360..1b9815418294 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -2623,9 +2623,10 @@ static int ksz_connect_tag_protocol(struct =
dsa_switch *ds,
>                                    enum dsa_tag_protocol proto)  {
>        struct ksz_tagger_data *tagger_data;
> -
> -       tagger_data =3D ksz_tagger_data(ds);
> -       tagger_data->xmit_work_fn =3D ksz_port_deferred_xmit;
> +       if (ksz_tagger_data(ds)) {
> +               tagger_data =3D ksz_tagger_data(ds);
> +               tagger_data->xmit_work_fn =3D ksz_port_deferred_xmit;
> +       }
>=20
>        return 0;
> }
> --
> 2.42.0
>=20
>=20
> Instead of calling " ksz_tagger_data(ds)" twice, NULL check =
tagger_data before assigning " xmit_work_fn" would help right?
> Is there any reason for doing this way?

I have submitted a v2 of this patch:
=
https://lore.kernel.org/netdev/20231206071655.1626479-1-sean@geanix.com/T/=
#u

/Sean



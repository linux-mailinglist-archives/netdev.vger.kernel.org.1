Return-Path: <netdev+bounces-31022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC0378A97A
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 12:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1C31C208E7
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 10:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038666AB8;
	Mon, 28 Aug 2023 10:00:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83416AA6
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 10:00:19 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79545107
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 03:00:17 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-8-TGqkI5SJM1mCeElt0jlUJQ-1; Mon, 28 Aug 2023 11:00:13 +0100
X-MC-Unique: TGqkI5SJM1mCeElt0jlUJQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 28 Aug
 2023 11:00:15 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 28 Aug 2023 11:00:15 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Tony Nguyen' <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Radoslaw Tyl <radoslawx.tyl@intel.com>, "greearb@candelatech.com"
	<greearb@candelatech.com>, "jesse.brandeburg@intel.com"
	<jesse.brandeburg@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Manfred Rudigier
	<manfred.rudigier@omicronenergy.com>, Arpana Arland
	<arpanax.arland@intel.com>
Subject: RE: [PATCH net] igb: set max size RX buffer when store bad packet is
 enabled
Thread-Topic: [PATCH net] igb: set max size RX buffer when store bad packet is
 enabled
Thread-Index: AQHZ1s0SCB7wBXMg2kyry1grla+28a//fdDA
Date: Mon, 28 Aug 2023 10:00:15 +0000
Message-ID: <c4c5a28345c34c428d612993a3c79264@AcuMS.aculab.com>
References: <20230824204619.1551135-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230824204619.1551135-1-anthony.l.nguyen@intel.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Tony Nguyen
> Sent: 24 August 2023 21:46
>=20
> From: Radoslaw Tyl <radoslawx.tyl@intel.com>
>=20
> Increase the RX buffer size to 3K when the SBP bit is on. The size of
> the RX buffer determines the number of pages allocated which may not
> be sufficient for receive frames larger than the set MTU size.

How much does that actually help?
In principle there is no limit to the length of an ethernet frame.
So the code has to handle overlong packets whatever the receive
buffer size is set to.

Modern ethernet hardware probably has configurable rx frame length
limits - but with old hardware the drivers had to handle frames
longer than 'buffer_size * ring_size'.

=09David

>=20
> Cc: stable@vger.kernel.org
> Fixes: 89eaefb61dc9 ("igb: Support RX-ALL feature flag.")
> Reported-by: Manfred Rudigier <manfred.rudigier@omicronenergy.com>
> Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
> Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker =
at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethe=
rnet/intel/igb/igb_main.c
> index 9a2561409b06..08e3df37089f 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -4814,6 +4814,10 @@ void igb_configure_rx_ring(struct igb_adapter *ada=
pter,
>  static void igb_set_rx_buffer_len(struct igb_adapter *adapter,
>  =09=09=09=09  struct igb_ring *rx_ring)
>  {
> +#if (PAGE_SIZE < 8192)
> +=09struct e1000_hw *hw =3D &adapter->hw;
> +#endif
> +
>  =09/* set build_skb and buffer size flags */
>  =09clear_ring_build_skb_enabled(rx_ring);
>  =09clear_ring_uses_large_buffer(rx_ring);
> @@ -4824,10 +4828,9 @@ static void igb_set_rx_buffer_len(struct igb_adapt=
er *adapter,
>  =09set_ring_build_skb_enabled(rx_ring);
>=20
>  #if (PAGE_SIZE < 8192)
> -=09if (adapter->max_frame_size <=3D IGB_MAX_FRAME_BUILD_SKB)
> -=09=09return;
> -
> -=09set_ring_uses_large_buffer(rx_ring);
> +=09if (adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB ||
> +=09    rd32(E1000_RCTL) & E1000_RCTL_SBP)
> +=09=09set_ring_uses_large_buffer(rx_ring);
>  #endif
>  }
>=20
> --
> 2.38.1
>=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)



Return-Path: <netdev+bounces-22199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCED766721
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8AEA1C21163
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 08:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48224101F3;
	Fri, 28 Jul 2023 08:29:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAC41844
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:29:56 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6566E3A9F
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 01:29:53 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-59-spQ2bcCCN6uK73WIrMkiVA-1; Fri, 28 Jul 2023 09:29:50 +0100
X-MC-Unique: spQ2bcCCN6uK73WIrMkiVA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 28 Jul
 2023 09:29:48 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 28 Jul 2023 09:29:48 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jijie Shao' <shaojijie@huawei.com>, "yisen.zhuang@huawei.com"
	<yisen.zhuang@huawei.com>, "salil.mehta@huawei.com" <salil.mehta@huawei.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "shenjian15@huawei.com" <shenjian15@huawei.com>, "wangjie125@huawei.com"
	<wangjie125@huawei.com>, "liuyonglong@huawei.com" <liuyonglong@huawei.com>,
	"wangpeiyang1@huawei.com" <wangpeiyang1@huawei.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net 1/6] net: hns3: fix side effects passed to min_t()
Thread-Topic: [PATCH net 1/6] net: hns3: fix side effects passed to min_t()
Thread-Index: AQHZwSodHT1OfdHQgUOtv3IG+DBXRa/O1ztQ
Date: Fri, 28 Jul 2023 08:29:48 +0000
Message-ID: <85e3c423aa5a400981ae5c53a29ee280@AcuMS.aculab.com>
References: <20230728075840.4022760-1-shaojijie@huawei.com>
 <20230728075840.4022760-2-shaojijie@huawei.com>
In-Reply-To: <20230728075840.4022760-2-shaojijie@huawei.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jijie Shao
> Sent: 28 July 2023 08:59
>=20
> num_online_cpus() may call more than once when passing to min_t(),
> between calls, it may return different values, so move num_online_cpus()
> out of min_t().

Nope, wrong bug:
min() (and friends) are careful to only evaluate their arguments once.
The bug is using min_t() - especially with a small type.

If/when the number of cpu hits 65536 the (u16) cast will convert
it to zero.

Looking at the code a lot of the local variables should be
'unsigned int' not 'u16.
Just because the domain of a value is small doesn't mean
you should use a small type (unless you are saving space in
a structure).

=09David

>=20
> Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> index 9f6890059666..823e6d2e85f5 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> @@ -4757,6 +4757,7 @@ static int hns3_nic_alloc_vector_data(struct hns3_n=
ic_priv *priv)
>  {
>  =09struct hnae3_handle *h =3D priv->ae_handle;
>  =09struct hns3_enet_tqp_vector *tqp_vector;
> +=09u32 online_cpus =3D num_online_cpus();
>  =09struct hnae3_vector_info *vector;
>  =09struct pci_dev *pdev =3D h->pdev;
>  =09u16 tqp_num =3D h->kinfo.num_tqps;
> @@ -4766,7 +4767,7 @@ static int hns3_nic_alloc_vector_data(struct hns3_n=
ic_priv *priv)
>=20
>  =09/* RSS size, cpu online and vector_num should be the same */
>  =09/* Should consider 2p/4p later */
> -=09vector_num =3D min_t(u16, num_online_cpus(), tqp_num);
> +=09vector_num =3D min_t(u16, online_cpus, tqp_num);
>=20
>  =09vector =3D devm_kcalloc(&pdev->dev, vector_num, sizeof(*vector),
>  =09=09=09      GFP_KERNEL);
> --
> 2.30.0

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)



Return-Path: <netdev+bounces-34979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CE67A64DA
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 15:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F68028156C
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 13:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAEE36AE2;
	Tue, 19 Sep 2023 13:27:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7EF1863B
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 13:27:24 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDA2EC;
	Tue, 19 Sep 2023 06:27:22 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rqj9b5SvDz6K5nL;
	Tue, 19 Sep 2023 21:26:27 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 19 Sep
 2023 14:27:19 +0100
Date: Tue, 19 Sep 2023 14:27:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, "Jesse
 Brandeburg" <jesse.brandeburg@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 8/8] e1000e: Use pcie_capability_read_word() for
 reading LNKSTA
Message-ID: <20230919142717.0000247c@Huawei.com>
In-Reply-To: <20230919125648.1920-9-ilpo.jarvinen@linux.intel.com>
References: <20230919125648.1920-1-ilpo.jarvinen@linux.intel.com>
	<20230919125648.1920-9-ilpo.jarvinen@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 19 Sep 2023 15:56:48 +0300
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Use pcie_capability_read_word() for reading LNKSTA and remove the
> custom define that matches to PCI_EXP_LNKSTA.
>=20
> As only single user for cap_offset remains, replace it with a call to
> pci_pcie_cap(). Instead of e1000_adapter, make local variable out of
> pci_dev because both users are interested in it.
>=20
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/net/ethernet/intel/e1000e/defines.h |  1 -
>  drivers/net/ethernet/intel/e1000e/mac.c     | 11 ++++-------
>  2 files changed, 4 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/et=
hernet/intel/e1000e/defines.h
> index a4d29c9e03a6..23a58cada43a 100644
> --- a/drivers/net/ethernet/intel/e1000e/defines.h
> +++ b/drivers/net/ethernet/intel/e1000e/defines.h
> @@ -678,7 +678,6 @@
> =20
>  /* PCI/PCI-X/PCI-EX Config space */
>  #define PCI_HEADER_TYPE_REGISTER     0x0E
> -#define PCIE_LINK_STATUS             0x12
> =20
>  #define PCI_HEADER_TYPE_MULTIFUNC    0x80
> =20
> diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethern=
et/intel/e1000e/mac.c
> index 5340cf73778d..694a779e718d 100644
> --- a/drivers/net/ethernet/intel/e1000e/mac.c
> +++ b/drivers/net/ethernet/intel/e1000e/mac.c
> @@ -17,16 +17,13 @@ s32 e1000e_get_bus_info_pcie(struct e1000_hw *hw)
>  {
>  	struct e1000_mac_info *mac =3D &hw->mac;
>  	struct e1000_bus_info *bus =3D &hw->bus;
> -	struct e1000_adapter *adapter =3D hw->adapter;
> -	u16 pcie_link_status, cap_offset;
> +	struct pci_dev *pdev =3D hw->adapter->pdev;
> +	u16 pcie_link_status;
> =20
> -	cap_offset =3D adapter->pdev->pcie_cap;
> -	if (!cap_offset) {
> +	if (!pci_pcie_cap(pdev)) {
>  		bus->width =3D e1000_bus_width_unknown;
>  	} else {
> -		pci_read_config_word(adapter->pdev,
> -				     cap_offset + PCIE_LINK_STATUS,
> -				     &pcie_link_status);
> +		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &pcie_link_status);
>  		bus->width =3D (enum e1000_bus_width)FIELD_GET(PCI_EXP_LNKSTA_NLW,
>  							     pcie_link_status);
>  	}



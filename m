Return-Path: <netdev+bounces-81357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 036B7887649
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 01:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB66283074
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 00:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38827621;
	Sat, 23 Mar 2024 00:58:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.dudau.co.uk (dliviu.plus.com [80.229.23.120])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A08D7FD
	for <netdev@vger.kernel.org>; Sat, 23 Mar 2024 00:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.229.23.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711155517; cv=none; b=O4cC6Qag1zGG7bNuHLLGvlT3NkSon9rwtfi/RUtOiq9ZDn9WcHOF9vafr+xM38eWfiO8L8uVNLgqNcY8gO9zIfiQ/G62QWUdBb+kwZLaIRg4t5Fkn1j5izrkDiAstkxV2WzFcG/KL7D+l6kXeaPetp840wOhedaN00XtbYEZmz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711155517; c=relaxed/simple;
	bh=tTZvu1ZDJN3HWNJZoYVrNXO74a3tb2J38WsCswp92Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWnO3FXMLng7Qw4M8QMDhzOZF736zfoeNO7y0AU9RcGjHXFLXum8tQKlrg9P/WQ36HEFmp3eFHrRq/3kBp8AJ+U+DsJvIIKqeeVJhOW0n4/SQhWrwmpJKfgGDJU/VGB7Fp4Tl25t9Fin7oHaR8zNpzxAv9Qxd4KWwe0X6yR6MdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dudau.co.uk; spf=pass smtp.mailfrom=dudau.co.uk; arc=none smtp.client-ip=80.229.23.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dudau.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dudau.co.uk
Received: from mail.dudau.co.uk (bart.dudau.co.uk [192.168.14.2])
	by smtp.dudau.co.uk (Postfix) with SMTP id 68ABB4172F42;
	Sat, 23 Mar 2024 00:58:25 +0000 (GMT)
Received: by mail.dudau.co.uk (sSMTP sendmail emulation); Sat, 23 Mar 2024 00:58:25 +0000
Date: Sat, 23 Mar 2024 00:58:25 +0000
From: Liviu Dudau <liviu@dudau.co.uk>
To: =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Cc: netdev@vger.kernel.org,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Haijun Liu <haijun.liu@mediatek.com>,
	Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
	M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
	Ricardo Martinez <ricardo.martinez@linux.intel.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH net] net: wwan: t7xx: Split 64bit accesses to fix
 alignment issues
Message-ID: <Zf4pMcnEvCt/N25b@bart.dudau.co.uk>
References: <20240322144000.1683822-1-bjorn@mork.no>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240322144000.1683822-1-bjorn@mork.no>

On Fri, Mar 22, 2024 at 03:40:00PM +0100, Bj=C3=B8rn Mork wrote:
> Some of the registers are aligned on a 32bit boundary, causing
> alignment faults on 64bit platforms.
>=20
>  Unable to handle kernel paging request at virtual address ffffffc084a1d0=
04
>  Mem abort info:
>  ESR =3D 0x0000000096000061
>  EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>  SET =3D 0, FnV =3D 0
>  EA =3D 0, S1PTW =3D 0
>  FSC =3D 0x21: alignment fault
>  Data abort info:
>  ISV =3D 0, ISS =3D 0x00000061, ISS2 =3D 0x00000000
>  CM =3D 0, WnR =3D 1, TnD =3D 0, TagAccess =3D 0
>  GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
>  swapper pgtable: 4k pages, 39-bit VAs, pgdp=3D0000000046ad6000
>  [ffffffc084a1d004] pgd=3D100000013ffff003, p4d=3D100000013ffff003, pud=
=3D100000013ffff003, pmd=3D0068000020a00711
>  Internal error: Oops: 0000000096000061 [#1] SMP
>  Modules linked in: mtk_t7xx(+) qcserial pppoe ppp_async option nft_fib_i=
net nf_flow_table_inet mt7921u(O) mt7921s(O) mt7921e(O) mt7921_common(O) iw=
lmvm(O) iwldvm(O) usb_wwan rndis_host qmi_wwan pppox ppp_generic nft_reject=
_ipv6 nft_reject_ipv4 nft_reject_inet nft_reject nft_redir nft_quota nft_nu=
mgen nft_nat nft_masq nft_log nft_limit nft_hash nft_flow_offload nft_fib_i=
pv6 nft_fib_ipv4 nft_fib nft_ct nft_chain_nat nf_tables nf_nat nf_flow_tabl=
e nf_conntrack mt7996e(O) mt792x_usb(O) mt792x_lib(O) mt7915e(O) mt76_usb(O=
) mt76_sdio(O) mt76_connac_lib(O) mt76(O) mac80211(O) iwlwifi(O) huawei_cdc=
_ncm cfg80211(O) cdc_ncm cdc_ether wwan usbserial usbnet slhc sfp rtc_pcf85=
63 nfnetlink nf_reject_ipv6 nf_reject_ipv4 nf_log_syslog nf_defrag_ipv6 nf_=
defrag_ipv4 mt6577_auxadc mdio_i2c libcrc32c compat(O) cdc_wdm cdc_acm at24=
 crypto_safexcel pwm_fan i2c_gpio i2c_smbus industrialio i2c_algo_bit i2c_m=
ux_reg i2c_mux_pca954x i2c_mux_pca9541 i2c_mux_gpio i2c_mux dummy oid_regis=
try tun sha512_arm64 sha1_ce sha1_generic seqiv
>  md5 geniv des_generic libdes cbc authencesn authenc leds_gpio xhci_plat_=
hcd xhci_pci xhci_mtk_hcd xhci_hcd nvme nvme_core gpio_button_hotplug(O) dm=
_mirror dm_region_hash dm_log dm_crypt dm_mod dax usbcore usb_common ptp aq=
uantia pps_core mii tpm encrypted_keys trusted
>  CPU: 3 PID: 5266 Comm: kworker/u9:1 Tainted: G O 6.6.22 #0
>  Hardware name: Bananapi BPI-R4 (DT)
>  Workqueue: md_hk_wq t7xx_fsm_uninit [mtk_t7xx]
>  pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>  pc : t7xx_cldma_hw_set_start_addr+0x1c/0x3c [mtk_t7xx]
>  lr : t7xx_cldma_start+0xac/0x13c [mtk_t7xx]
>  sp : ffffffc085d63d30
>  x29: ffffffc085d63d30 x28: 0000000000000000 x27: 0000000000000000
>  x26: 0000000000000000 x25: ffffff80c804f2c0 x24: ffffff80ca196c05
>  x23: 0000000000000000 x22: ffffff80c814b9b8 x21: ffffff80c814b128
>  x20: 0000000000000001 x19: ffffff80c814b080 x18: 0000000000000014
>  x17: 0000000055c9806b x16: 000000007c5296d0 x15: 000000000f6bca68
>  x14: 00000000dbdbdce4 x13: 000000001aeaf72a x12: 0000000000000001
>  x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
>  x8 : ffffff80ca1ef6b4 x7 : ffffff80c814b818 x6 : 0000000000000018
>  x5 : 0000000000000870 x4 : 0000000000000000 x3 : 0000000000000000
>  x2 : 000000010a947000 x1 : ffffffc084a1d004 x0 : ffffffc084a1d004
>  Call trace:
>  t7xx_cldma_hw_set_start_addr+0x1c/0x3c [mtk_t7xx]
>  t7xx_fsm_uninit+0x578/0x5ec [mtk_t7xx]
>  process_one_work+0x154/0x2a0
>  worker_thread+0x2ac/0x488
>  kthread+0xe0/0xec
>  ret_from_fork+0x10/0x20
>  Code: f9400800 91001000 8b214001 d50332bf (f9000022)
>  ---[ end trace 0000000000000000 ]---
>=20
> The inclusion of io-64-nonatomic-lo-hi.h indicates that all 64bit
> accesses can be replaced by pairs of nonatomic 32bit access.  Fix
> alignment by forcing all accesses to be 32bit on 64bit platforms.
>=20
> Link: https://forum.openwrt.org/t/fibocom-fm350-gl-support/142682/72
> Fixes: 39d439047f1d ("net: wwan: t7xx: Add control DMA interface")
> Signed-off-by: Bj=C3=B8rn Mork <bjorn@mork.no>

Tested-by: Liviu Dudau <liviu@dudau.co.uk>

Modem still fails to transition from D3hot to D0, but that is unrelated
to this patch.

> ---
>  drivers/net/wwan/t7xx/t7xx_cldma.c     | 4 ++--
>  drivers/net/wwan/t7xx/t7xx_hif_cldma.c | 9 +++++----
>  drivers/net/wwan/t7xx/t7xx_pcie_mac.c  | 8 ++++----
>  3 files changed, 11 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/wwan/t7xx/t7xx_cldma.c b/drivers/net/wwan/t7xx/t=
7xx_cldma.c
> index 9f43f256db1d..f0a4783baf1f 100644
> --- a/drivers/net/wwan/t7xx/t7xx_cldma.c
> +++ b/drivers/net/wwan/t7xx/t7xx_cldma.c
> @@ -106,7 +106,7 @@ bool t7xx_cldma_tx_addr_is_set(struct t7xx_cldma_hw *=
hw_info, unsigned int qno)
>  {
>  	u32 offset =3D REG_CLDMA_UL_START_ADDRL_0 + qno * ADDR_SIZE;
> =20
> -	return ioread64(hw_info->ap_pdn_base + offset);
> +	return ioread64_lo_hi(hw_info->ap_pdn_base + offset);
>  }
> =20
>  void t7xx_cldma_hw_set_start_addr(struct t7xx_cldma_hw *hw_info, unsigne=
d int qno, u64 address,
> @@ -117,7 +117,7 @@ void t7xx_cldma_hw_set_start_addr(struct t7xx_cldma_h=
w *hw_info, unsigned int qn
> =20
>  	reg =3D tx_rx =3D=3D MTK_RX ? hw_info->ap_ao_base + REG_CLDMA_DL_START_=
ADDRL_0 :
>  				hw_info->ap_pdn_base + REG_CLDMA_UL_START_ADDRL_0;
> -	iowrite64(address, reg + offset);
> +	iowrite64_lo_hi(address, reg + offset);
>  }
> =20
>  void t7xx_cldma_hw_resume_queue(struct t7xx_cldma_hw *hw_info, unsigned =
int qno,
> diff --git a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c b/drivers/net/wwan/t7=
xx/t7xx_hif_cldma.c
> index abc41a7089fa..97163e1e5783 100644
> --- a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
> +++ b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
> @@ -137,8 +137,9 @@ static int t7xx_cldma_gpd_rx_from_q(struct cldma_queu=
e *queue, int budget, bool
>  				return -ENODEV;
>  			}
> =20
> -			gpd_addr =3D ioread64(hw_info->ap_pdn_base + REG_CLDMA_DL_CURRENT_ADD=
RL_0 +
> -					    queue->index * sizeof(u64));
> +			gpd_addr =3D ioread64_lo_hi(hw_info->ap_pdn_base +
> +						  REG_CLDMA_DL_CURRENT_ADDRL_0 +
> +						  queue->index * sizeof(u64));
>  			if (req->gpd_addr =3D=3D gpd_addr || hwo_polling_count++ >=3D 100)
>  				return 0;
> =20
> @@ -316,8 +317,8 @@ static void t7xx_cldma_txq_empty_hndl(struct cldma_qu=
eue *queue)
>  		struct t7xx_cldma_hw *hw_info =3D &md_ctrl->hw_info;
> =20
>  		/* Check current processing TGPD, 64-bit address is in a table by Q in=
dex */
> -		ul_curr_addr =3D ioread64(hw_info->ap_pdn_base + REG_CLDMA_UL_CURRENT_=
ADDRL_0 +
> -					queue->index * sizeof(u64));
> +		ul_curr_addr =3D ioread64_lo_hi(hw_info->ap_pdn_base + REG_CLDMA_UL_CU=
RRENT_ADDRL_0 +
> +					      queue->index * sizeof(u64));
>  		if (req->gpd_addr !=3D ul_curr_addr) {
>  			spin_unlock_irqrestore(&md_ctrl->cldma_lock, flags);
>  			dev_err(md_ctrl->dev, "CLDMA%d queue %d is not empty\n",

I don't think any change past this point is needed. I don't know how the
PCIe translation adddress registers are defined for T7xx devices, but they
usually are 64bit aligned. In my local version of the patch I didn't had
the changes below and I had the same results as with this patch.

I will let others with access to the specs to decide though.

Thanks for the quick patch!

Best regards,
Liviu

> diff --git a/drivers/net/wwan/t7xx/t7xx_pcie_mac.c b/drivers/net/wwan/t7x=
x/t7xx_pcie_mac.c
> index 76da4c15e3de..f071ec7ff23d 100644
> --- a/drivers/net/wwan/t7xx/t7xx_pcie_mac.c
> +++ b/drivers/net/wwan/t7xx/t7xx_pcie_mac.c
> @@ -75,7 +75,7 @@ static void t7xx_pcie_mac_atr_tables_dis(void __iomem *=
pbase, enum t7xx_atr_src_
>  	for (i =3D 0; i < ATR_TABLE_NUM_PER_ATR; i++) {
>  		offset =3D ATR_PORT_OFFSET * port + ATR_TABLE_OFFSET * i;
>  		reg =3D pbase + ATR_PCIE_WIN0_T0_ATR_PARAM_SRC_ADDR + offset;
> -		iowrite64(0, reg);
> +		iowrite64_lo_hi(0, reg);
>  	}
>  }
> =20
> @@ -112,17 +112,17 @@ static int t7xx_pcie_mac_atr_cfg(struct t7xx_pci_de=
v *t7xx_dev, struct t7xx_atr_
> =20
>  	reg =3D pbase + ATR_PCIE_WIN0_T0_TRSL_ADDR + offset;
>  	value =3D cfg->trsl_addr & ATR_PCIE_WIN0_ADDR_ALGMT;
> -	iowrite64(value, reg);
> +	iowrite64_lo_hi(value, reg);
> =20
>  	reg =3D pbase + ATR_PCIE_WIN0_T0_TRSL_PARAM + offset;
>  	iowrite32(cfg->trsl_id, reg);
> =20
>  	reg =3D pbase + ATR_PCIE_WIN0_T0_ATR_PARAM_SRC_ADDR + offset;
>  	value =3D (cfg->src_addr & ATR_PCIE_WIN0_ADDR_ALGMT) | (atr_size << 1) =
| BIT(0);
> -	iowrite64(value, reg);
> +	iowrite64_lo_hi(value, reg);
> =20
>  	/* Ensure ATR is set */
> -	ioread64(reg);
> +	ioread64_lo_hi(reg);
>  	return 0;
>  }
> =20
> --=20
> 2.39.2
>=20

--=20
Everyone who uses computers frequently has had, from time to time,
a mad desire to attack the precocious abacus with an axe.
       	   	      	     	  -- John D. Clark, Ignition!


Return-Path: <netdev+bounces-148991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A312B9E3BD9
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC7B280D7D
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 13:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3FB1F6680;
	Wed,  4 Dec 2024 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRg329UB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C991714CF;
	Wed,  4 Dec 2024 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320648; cv=none; b=saUQf3QuKRy4PvVp7MZD5whwWroSFQ2v2zjtrvoGpxS3Ex96tlbOf0NYjg2s+irYRFqs9Sclahuq9ysSxqBJ+iU8/f+RYqjncdMAev8/gaNqokl5pmX+QPJ9rqZDE6wJuRzXCB3BDK7gs9rsnLFFZpJLFL9gnpG6GwxeP59djmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320648; c=relaxed/simple;
	bh=6+TBcPrfe/oXABK/XUblh6pvMZCC+EgX4etXvq21B3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhGEsn3cofYqbeMnVG3a/y6nWaH+wahAdEWCsu7x85uaX8rPiZDxKQtTcMRu5hDeVQ2DUZ3LZwRV4/Exl+sEjdVQDoXKqxN8O91g1oYFd0nTWHUvol/5vwcjPOBkUCrQww9B6GmY9VZKvAGDDnLpjQncHSAr8inTWFxnPf8QScU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRg329UB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434a45f05feso83164745e9.3;
        Wed, 04 Dec 2024 05:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733320645; x=1733925445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XC2czeLIMR1ljMUddmL8ssFZF/jsYoIl4rjVYGqN4Ys=;
        b=eRg329UB59PLSJMpFcLpNWeYFGiwiRBx+Rxg3/woRS0EPCVSCKuu7ktAKKmgFdYRfK
         QEVWnFolZRHQcNtxZRK4WL1hGxHo9T4zgSjcbVtifbBDX9J0FbUhgIuUyNDs5IiR6ABU
         lQRWduMELRDAzwuKVJFdYxxZqXDRt0/R9lxliCAG8qqgFjSOIY0tww1vCuY+Tck17aqR
         oUgarrnoGRwbIPp29ehuuN4h4ybwyucWHc/Ldha53pCShTdVL0HFQZyJkFiRKZDlIbpb
         XPhN8hBzbKtcf8pt2TyND2qhbTOK/j6GPw4KS8JjgIbBbfyXxKsO1q/RiLXrgOgMNpgU
         1wgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733320645; x=1733925445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XC2czeLIMR1ljMUddmL8ssFZF/jsYoIl4rjVYGqN4Ys=;
        b=eQy2gGn/PDD2S6CqJaVpLi/lpB3hN+KZEB1LNHWsgt0BUkCuGzfwZOPX9m9j/lnfki
         3J1lGK7X90TOI7y79jUp8L/4G+0X5MINMzsU1/qi175emY4j/KI8b6ZLEq1l903c+/F/
         aUzy0HcKDQZ3/cQZWdteNrRBJy3k+r6LbOl32oekscGIHuqj6LtDvq9O6qKxBntb0e4E
         aBXZ3B0FHAOovBX3TCz8jx+TxlnLAq67Nj2OM23ZLJsM2buzxqTRm0a61cA8bmh+9gxp
         DkVMY2InQOLjtAP0j3OEqCdWnD2b9QD94uOzB2RFOSzzVCgh+tx/vvcqHZlnXP16nS6h
         5ZYg==
X-Forwarded-Encrypted: i=1; AJvYcCUxfes8xVVSQ+OtOUD6Hxga3qPidBuNPKnNFTR3nSH7N1rydLBkEskGByVXrJVQBp6hfl8UTyhwRzjKGzM=@vger.kernel.org, AJvYcCVDDx1/TUGpqrE9Yta8vM56AI4e0RhJlTZOvPwohXcoOjtUv/BcCi+Y0NWpfDCjOgbDpc3xotwag5ECyyM=@vger.kernel.org, AJvYcCXHDFCA1dgeNN5ztxo4fbmmjwLO2dwofcMqnVkU5iANNnyJMwKgKFVNyb7TQyrsnnc2r2fyueme@vger.kernel.org
X-Gm-Message-State: AOJu0YwKny65xZGaXcIP+2QhDYDcZc/RMa7fCuSexIVswOJ9He85aNUG
	L3JT8xj0P8kMQ4HFxD2SQVMcV+U8y2cWHIAPQNJNLaPsutOOKNrgCX+TlQ==
X-Gm-Gg: ASbGncv2bN6GVa+AqpMTC8r9dH4Ip5qUtbADkNljuBiCA56gX97vGEj37JIVeH/4Df+
	Gt40LT0dW5qIRqg5dQy3w+4CferDiPU8fOF6gpZHOJ74nhs9t2S4PKwR+Pn4zFDhgmkPC6LS3zj
	kvO9UA+G2IRYjxIvuI+qNN2nyiS4Zu1spvl8ZJu+2AScXqgr8w1xjr8yB4YCfqBD9oN0xjBmkFh
	ujS3Jdg7dELb+PE4lCrrhYqcp5AT1DIvouiEVJ4olKeXvf2Ad2CouBDVGj1DKnElXAIwiLGe9mP
	KGbp+k7/Lnm20pEugtLAPas8ZaPvalIfUiX9
X-Google-Smtp-Source: AGHT+IESrS7F5pAFW9SFnplSDX50OEMdHr9ntPWIG4+JKzyt3WAMSzmP9BE88ArVJGsaiGG1mZzXtQ==
X-Received: by 2002:a05:6000:156c:b0:385:df4e:364b with SMTP id ffacd0b85a97d-385fd3cd9edmr6104259f8f.12.1733320645039;
        Wed, 04 Dec 2024 05:57:25 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e2c84d52sm13683244f8f.49.2024.12.04.05.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 05:57:24 -0800 (PST)
Date: Wed, 4 Dec 2024 14:57:22 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com, 
	Suraj Jaiswal <quic_jsuraj@quicinc.com>, Thierry Reding <treding@nvidia.com>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH net v1] net: stmmac: TSO: Fix unbalanced DMA map/unmap
 for non-paged SKB data
Message-ID: <klkzp5yn5kq5efgtrow6wbvnc46bcqfxs65nz3qy77ujr5turc@bwwhelz2l4dw>
References: <20241021061023.2162701-1-0x1207@gmail.com>
 <d8112193-0386-4e14-b516-37c2d838171a@nvidia.com>
 <20241128144501.0000619b@gmail.com>
 <20241202163309.05603e96@kernel.org>
 <20241203100331.00007580@gmail.com>
 <20241202183425.4021d14c@kernel.org>
 <20241203111637.000023fe@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vsdx7r52oh4np25i"
Content-Disposition: inline
In-Reply-To: <20241203111637.000023fe@gmail.com>


--vsdx7r52oh4np25i
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net v1] net: stmmac: TSO: Fix unbalanced DMA map/unmap
 for non-paged SKB data
MIME-Version: 1.0

On Tue, Dec 03, 2024 at 11:16:37AM +0800, Furong Xu wrote:
> On Mon, 2 Dec 2024 18:34:25 -0800, Jakub Kicinski <kuba@kernel.org> wrote:
>=20
> > On Tue, 3 Dec 2024 10:03:31 +0800 Furong Xu wrote:
> > > I requested Jon to provide more info about "Tx DMA map failed" in pre=
vious
> > > reply, and he does not respond yet. =20
> >=20
> > What does it mean to provide "more info" about a print statement from
> > the driver? Is there a Kconfig which he needs to set to get more info?
> > Perhaps you should provide a debug patch he can apply on his tree, that
> > will print info about (1) which buffer mapping failed (head or frags);
> > (2) what the physical address was of the buffer that couldn't be mapped.
>=20
> A debug patch to print info about buffer makes no sense here.
> Both Tegra186 Jetson TX2(tegra186-p2771-0000) and Tegra194 Jetson AGX Xav=
ier
> (tegra194-p2972-0000) enable IOMMU/SMMU for stmmac in its device-tree nod=
e,
> buffer info should be investigated with detailed IOMMU/SMMU debug info fr=
om
> drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c together.
>=20
> I am not an expert in IOMMU, so I cannot help more.
>=20
> Without the help from Jon, our only choice is revert as you said.

I was able to reproduce this locally and I get this splat:

--- >8 ---
[  228.179234] WARNING: CPU: 0 PID: 0 at drivers/iommu/io-pgtable-arm.c:346=
 __arm_lpae_map+0x388/0x4e4
[  228.188300] Modules linked in: snd_soc_tegra210_mixer snd_soc_tegra210_a=
dmaif snd_soc_tegra_pcm snd_soc_tegra186_asrc snd_soc_tegra210_ope snd_soc_=
tegra210_adx snd_soc_tegra210_mvc snd_soc_tegra210_dmic snd_soc_tegra186_ds=
pk snd_soc_tegra210_sfc snd_soc_tegra210_amx snd_soc_tegra210_i2s tegra_drm=
 drm_dp_aux_bus cec drm_display_helper drm_client_lib tegra210_adma snd_soc=
_tegra210_ahub drm_kms_helper snd_hda_codec_hdmi snd_hda_tegra snd_soc_tegr=
a_audio_graph_card at24 snd_hda_codec ina3221 snd_soc_audio_graph_card snd_=
soc_simple_card_utils tegra_bpmp_thermal tegra_xudc snd_hda_core tegra_acon=
nect host1x fuse drm backlight ipv6
[  228.243750] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G S           =
      6.13.0-rc1-next-20241203 #30
[  228.253412] Tainted: [S]=3DCPU_OUT_OF_SPEC
[  228.257336] Hardware name: nvidia NVIDIA P2771-0000-500/NVIDIA P2771-000=
0-500, BIOS 2025.01-rc3-00040-g36352ae2e68e-dirty 01/01/2025
[  228.269239] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[  228.276205] pc : __arm_lpae_map+0x388/0x4e4
[  228.280398] lr : __arm_lpae_map+0x120/0x4e4
[  228.284587] sp : ffff8000800037f0
[  228.287901] x29: ffff800080003800 x28: 0000000000000002 x27: 00000000000=
00001
[  228.295050] x26: 0000000000000001 x25: 0000000111580000 x24: 00000000000=
01000
[  228.302197] x23: 000000ffffc72000 x22: 0000000000000ec0 x21: 00000000000=
00003
[  228.309342] x20: 0000000000000001 x19: ffff00008574b000 x18: 00000000000=
00001
[  228.316486] x17: 0000000000000000 x16: 0000000000000001 x15: ffff8000800=
03ad0
[  228.323631] x14: ffff00008574d000 x13: 0000000000000000 x12: 00000000000=
00001
[  228.330775] x11: 0000000000000001 x10: 0000000000000001 x9 : 00000000000=
01000
[  228.337921] x8 : ffff00008674c390 x7 : ffff00008674c000 x6 : 00000000000=
00003
[  228.345066] x5 : 0000000000000003 x4 : 0000000000000001 x3 : 00000000000=
00002
[  228.352209] x2 : 0000000000000001 x1 : 0000000000000000 x0 : ffff0000857=
4b000
[  228.359356] Call trace:
[  228.361807]  __arm_lpae_map+0x388/0x4e4 (P)
[  228.366002]  __arm_lpae_map+0x120/0x4e4 (L)
[  228.370198]  __arm_lpae_map+0x120/0x4e4
[  228.374042]  __arm_lpae_map+0x120/0x4e4
[  228.377886]  __arm_lpae_map+0x120/0x4e4
[  228.381730]  arm_lpae_map_pages+0x108/0x250
[  228.385922]  arm_smmu_map_pages+0x40/0x120
[  228.390029]  __iommu_map+0xfc/0x1bc
[  228.393525]  iommu_map+0x38/0xc0
[  228.396759]  __iommu_dma_map+0xb4/0x1a4
[  228.400604]  iommu_dma_map_page+0x14c/0x27c
[  228.404795]  dma_map_page_attrs+0x1fc/0x280
[  228.408987]  stmmac_tso_xmit+0x2d0/0xbac
[  228.412920]  stmmac_xmit+0x230/0xd14
[  228.416505]  dev_hard_start_xmit+0x94/0x11c
[  228.420697]  sch_direct_xmit+0x8c/0x380
[  228.424540]  __qdisc_run+0x11c/0x66c
[  228.428121]  net_tx_action+0x168/0x228
[  228.431875]  handle_softirqs+0x100/0x244
[  228.435809]  __do_softirq+0x14/0x20
[  228.439303]  ____do_softirq+0x10/0x20
[  228.442972]  call_on_irq_stack+0x24/0x64
[  228.446903]  do_softirq_own_stack+0x1c/0x40
[  228.451091]  __irq_exit_rcu+0xd4/0x10c
[  228.454847]  irq_exit_rcu+0x10/0x1c
[  228.458343]  el1_interrupt+0x38/0x68
[  228.461927]  el1h_64_irq_handler+0x18/0x24
[  228.466032]  el1h_64_irq+0x6c/0x70
[  228.469438]  default_idle_call+0x28/0x58 (P)
[  228.473718]  default_idle_call+0x24/0x58 (L)
[  228.477998]  do_idle+0x1fc/0x260
[  228.481234]  cpu_startup_entry+0x34/0x3c
[  228.485163]  rest_init+0xdc/0xe0
[  228.488401]  console_on_rootfs+0x0/0x6c
[  228.492250]  __primary_switched+0x88/0x90
[  228.496270] ---[ end trace 0000000000000000 ]---
[  228.500950] dwc-eth-dwmac 2490000.ethernet: Tx dma map failed
--- >8 ---

This looks to be slightly different from what Jon was seeing. Looking at
the WARN_ON() that triggers this, it seems like for some reason the page
is getting mapped twice.

Not exactly sure why that would be happening, so adding Robin and Will,
maybe they can shed some light on this from the ARM SMMU side.

Robin, Will, any idea who could be the culprit here? Is this a map/unmap
imbalance or something else entirely?

A lot of the context isn't present in this thread anymore, but here's a
link to the top of the thread:

	https://lore.kernel.org/netdev/d8112193-0386-4e14-b516-37c2d838171a@nvidia=
=2Ecom/T/

Thanks,
Thierry

--vsdx7r52oh4np25i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmdQX78ACgkQ3SOs138+
s6H14A//WJdngiCjkoLaMyqKdSOl9WxX0+1nSuh2I5NrS/SxKcYds82Uk1/5viSs
JusZ/snx+m5+/RNO+FROgTTJJW0ZydDg7WGmJyRI/9Vg6nFE70uVWinTEsVfH+/7
f5a3erkivAOBN/TH488Lvrpq5bXxyEaJGh2gbzEHLoHPEh875VA3nZNrwCn+JLUn
u+eghjKB2I40+GnxwjM7VztGcDg9S7eB3EU4YRfUx87Tqyq7b7UIqa9jjgj4fcU5
7Bp6B/7cALh5RabcfFVZEIox3JvnYElVTDub1+oO9GYQxOk2T9z18NMi0SRIdwmG
zLUN+tooFEe9CPpaFwpvZT1MWkYlFVcgivbXx0bi6P8QFCxlUC/YTs1V6wqCUdu1
SGhWdvmlmP2BuoZL68PsFhdI5+fItGtLwV1vhQUGK3uJeGE8KsBJ37d8JY26ICQ3
+5PwFVcmNq5uzONQ4zwVkCHts7U2rJ4n6bQAkJCKI3D7HDSCtHhprzoL0FqKSi0c
8iFj1RCXw1NBRk1a8zEsGisDiRkAGYoRU6ZSlNe9rZowQkRfEPa2ojZPLklrwx7k
nKOyWfgznCB3u3gW5DBq+tuTI8fPkOMthKmq7QtU7WUeDZLZaOop4jmFwqA9z8DC
e5s9X+4D/lC7eJ8h6DGplrY2aDRYnyAMJHfMZn+i+4IzhZm1MW0=
=3eW4
-----END PGP SIGNATURE-----

--vsdx7r52oh4np25i--


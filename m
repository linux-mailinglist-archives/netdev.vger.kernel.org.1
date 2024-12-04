Return-Path: <netdev+bounces-149062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE729E3F1B
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 17:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC32F285379
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 16:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0BB21D58C;
	Wed,  4 Dec 2024 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9ALDFXx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDF121C19E;
	Wed,  4 Dec 2024 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327921; cv=none; b=toUU4c8am0GMjCWfo9XIKu29FHDXbQzkk1zlwkK5mUm7LURtAv3ilLJtQ2few9lqogNJX8JUhqgLjCtbZkT6NTqmsiN+UmoDvZWb7NNKn1waYvLGT/WeA3id+PtoSi3IFXv8J4XWejAkNxp94XbJupo7m5llsTsYBV6cWGYaJOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327921; c=relaxed/simple;
	bh=p9c/ZCJ0YcgR6fKgUZ+J4K0/c4sUkn5qxfyogvlb7Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTPhzJfEFQY79IWJBk96eNkggdv+YjBZxEK5906OH62r6db8TX9NvCAYTVxRGB7WDgKYyMDltyOLBORlu9VzFBejNs5X9u1uWnxCP7TgR3H9N0pqymmKTI3WWq50VE92axJArDlea4l1f+5NHrGLPqIf4EmehPP3rO8dicAApvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9ALDFXx; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-432d86a3085so58892025e9.2;
        Wed, 04 Dec 2024 07:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733327917; x=1733932717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mMG9VWcGW6XK+xMZkzrylicgj/+zPFuMCrXN5cYEltk=;
        b=D9ALDFXxlvYqo2W0JUR2ocCmK6d8tUOoozoZco2UfMhlLL8Qd+I29XzLDr3zqungjl
         AG+qcUNT/5fGAB8pK6d3uDoK2EL4IaRkgT2aIJPDiUsStUlrZAFspxx95fCiKBjmgPR7
         5EAuoj66GxU2Sa0TmRHi5o1W2Fkb8i6paVpZfRuDSvnotF7gVCuhSDnEe1xP4PANmCrY
         gOgCiDFFQHns6h5ASFtGAblbN6+ZrXGXTrp8QuhrSj4ORX647qaKbWQ6wTS/eAl86aXX
         1qGxUUN7Wl81r811xGCaeaVuEpgZ3k1WiY1x+nv6o8/t0DexEyAYO+z7oBqatRttnbD5
         56bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733327917; x=1733932717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMG9VWcGW6XK+xMZkzrylicgj/+zPFuMCrXN5cYEltk=;
        b=WpUdXXpQ5I+Ru6lDvxoBLUylSJXnbTZcSxtg385yqh4sDNPhSf9Z9UTGmmOcIxyi7Y
         5rbosc8UyuZn7JVEqnSnxsFF/ZEXAo9lV+UqQSFlw6kYDIX9+hWjP0eMVNpMPIA419C+
         M1q8L63bcaNH/ghvWNLZHMupYkmGIld4MMRTMar4m+32/Aj0c4RRL8oWifWVB39WVCSU
         Z1Y5wZMsz+eBnzsMtIfwxDVLkuvHFZifehFsWPzFsycSJxQjV9/R0jm8t/NOdDBh++UV
         AvbMnn3aMKIh8UvTYNRpdwIAhzPCodiQ2qT+URmXNIef5Vz6ByqeekaQofFR6TCfqQ++
         kQHw==
X-Forwarded-Encrypted: i=1; AJvYcCVexYiUEdWksDeOpu/Z0X4uctr2TGFDeHeQvfrxC6jpYsmeOT8Xzo++0JAvCqTHGFpHWamn0Fedt6a4Q8Y=@vger.kernel.org, AJvYcCWS1Ib/JvJGbBQn3ssBrs7ZgYugQ0qE9SU9JHu/e2mmZB/0L2zP4qwqoFMhaIKAJCPjOB0w/tOF@vger.kernel.org, AJvYcCWv4a+uKspXkNWVKSPRIHRsa7hx5uE1Vh1/nBuzO/yI4dtxQAQjWGapZwMj/ebMsb8c8cKfO54z0GkxMK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGZbJ48Q8cK8np8ChehZdHy495c7daMoI03ezF+hHNd/swBK5X
	IZNYLWbmVZjWOxLBmJKHf+S0vHizM+bncRcu7Zr0Xfhyoelr0b01
X-Gm-Gg: ASbGncvs544cQV5xUJUiN+wqAnE87YOoidR7hyeY94IsVHrxkRG4rcHMQff3J5eQ0Ec
	Itq5pBMLfygpzTVydVS3mp1XcOzsSCeymZhcYHaDl5gguXZ/anlpimqvmQ2uMMFCmI/OlAwfDkj
	CA75wT9uvBweHcx6HXaUxjd/gnC9sSbxijJxKMcjI4uoWlBtsorT+QRrrJ/Phi8jwjbUzbxVTxo
	rlLLAJPoFgrfKjQRY6257VT8HZjs9e6rqZ0ZblLGYa52zk5gnfVWfp898c6bg7XnYOy2Ky9Ya/H
	Xkqh7f6x8aAyJch1iAgLkw+WYA/w7ca2Ojws
X-Google-Smtp-Source: AGHT+IHO71cSsB7ROtvHoZs2gzZ0MtQJUhn4XUUKyoKwjM4QzdG/kDeL3+etQeFOAswozQMP3lNc1g==
X-Received: by 2002:a05:600c:3554:b0:431:6083:cd38 with SMTP id 5b1f17b1804b1-434d09b0020mr60787685e9.6.1733327917130;
        Wed, 04 Dec 2024 07:58:37 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52a46e6sm29690685e9.30.2024.12.04.07.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 07:58:36 -0800 (PST)
Date: Wed, 4 Dec 2024 16:58:34 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Furong Xu <0x1207@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jon Hunter <jonathanh@nvidia.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com, 
	Suraj Jaiswal <quic_jsuraj@quicinc.com>, Thierry Reding <treding@nvidia.com>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH net v1] net: stmmac: TSO: Fix unbalanced DMA map/unmap
 for non-paged SKB data
Message-ID: <2g2lp3bkadc4wpeslmdoexpidoiqzt7vejar5xhjx5ayt3uox3@dqdyfzn6khn6>
References: <20241021061023.2162701-1-0x1207@gmail.com>
 <d8112193-0386-4e14-b516-37c2d838171a@nvidia.com>
 <20241128144501.0000619b@gmail.com>
 <20241202163309.05603e96@kernel.org>
 <20241203100331.00007580@gmail.com>
 <20241202183425.4021d14c@kernel.org>
 <20241203111637.000023fe@gmail.com>
 <klkzp5yn5kq5efgtrow6wbvnc46bcqfxs65nz3qy77ujr5turc@bwwhelz2l4dw>
 <df3a6a9d-4b53-4338-9bc5-c4eea48b8a40@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lrjlcvs3uibftgsq"
Content-Disposition: inline
In-Reply-To: <df3a6a9d-4b53-4338-9bc5-c4eea48b8a40@arm.com>


--lrjlcvs3uibftgsq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net v1] net: stmmac: TSO: Fix unbalanced DMA map/unmap
 for non-paged SKB data
MIME-Version: 1.0

On Wed, Dec 04, 2024 at 02:06:00PM +0000, Robin Murphy wrote:
> On 2024-12-04 1:57 pm, Thierry Reding wrote:
> > On Tue, Dec 03, 2024 at 11:16:37AM +0800, Furong Xu wrote:
> > > On Mon, 2 Dec 2024 18:34:25 -0800, Jakub Kicinski <kuba@kernel.org> w=
rote:
> > >=20
> > > > On Tue, 3 Dec 2024 10:03:31 +0800 Furong Xu wrote:
> > > > > I requested Jon to provide more info about "Tx DMA map failed" in=
 previous
> > > > > reply, and he does not respond yet.
> > > >=20
> > > > What does it mean to provide "more info" about a print statement fr=
om
> > > > the driver? Is there a Kconfig which he needs to set to get more in=
fo?
> > > > Perhaps you should provide a debug patch he can apply on his tree, =
that
> > > > will print info about (1) which buffer mapping failed (head or frag=
s);
> > > > (2) what the physical address was of the buffer that couldn't be ma=
pped.
> > >=20
> > > A debug patch to print info about buffer makes no sense here.
> > > Both Tegra186 Jetson TX2(tegra186-p2771-0000) and Tegra194 Jetson AGX=
 Xavier
> > > (tegra194-p2972-0000) enable IOMMU/SMMU for stmmac in its device-tree=
 node,
> > > buffer info should be investigated with detailed IOMMU/SMMU debug inf=
o from
> > > drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c together.
> > >=20
> > > I am not an expert in IOMMU, so I cannot help more.
> > >=20
> > > Without the help from Jon, our only choice is revert as you said.
> >=20
> > I was able to reproduce this locally and I get this splat:
> >=20
> > --- >8 ---
> > [  228.179234] WARNING: CPU: 0 PID: 0 at drivers/iommu/io-pgtable-arm.c=
:346 __arm_lpae_map+0x388/0x4e4
> > [  228.188300] Modules linked in: snd_soc_tegra210_mixer snd_soc_tegra2=
10_admaif snd_soc_tegra_pcm snd_soc_tegra186_asrc snd_soc_tegra210_ope snd_=
soc_tegra210_adx snd_soc_tegra210_mvc snd_soc_tegra210_dmic snd_soc_tegra18=
6_dspk snd_soc_tegra210_sfc snd_soc_tegra210_amx snd_soc_tegra210_i2s tegra=
_drm drm_dp_aux_bus cec drm_display_helper drm_client_lib tegra210_adma snd=
_soc_tegra210_ahub drm_kms_helper snd_hda_codec_hdmi snd_hda_tegra snd_soc_=
tegra_audio_graph_card at24 snd_hda_codec ina3221 snd_soc_audio_graph_card =
snd_soc_simple_card_utils tegra_bpmp_thermal tegra_xudc snd_hda_core tegra_=
aconnect host1x fuse drm backlight ipv6
> > [  228.243750] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G S       =
          6.13.0-rc1-next-20241203 #30
> > [  228.253412] Tainted: [S]=3DCPU_OUT_OF_SPEC
> > [  228.257336] Hardware name: nvidia NVIDIA P2771-0000-500/NVIDIA P2771=
-0000-500, BIOS 2025.01-rc3-00040-g36352ae2e68e-dirty 01/01/2025
> > [  228.269239] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [  228.276205] pc : __arm_lpae_map+0x388/0x4e4
> > [  228.280398] lr : __arm_lpae_map+0x120/0x4e4
> > [  228.284587] sp : ffff8000800037f0
> > [  228.287901] x29: ffff800080003800 x28: 0000000000000002 x27: 0000000=
000000001
> > [  228.295050] x26: 0000000000000001 x25: 0000000111580000 x24: 0000000=
000001000
> > [  228.302197] x23: 000000ffffc72000 x22: 0000000000000ec0 x21: 0000000=
000000003
> > [  228.309342] x20: 0000000000000001 x19: ffff00008574b000 x18: 0000000=
000000001
> > [  228.316486] x17: 0000000000000000 x16: 0000000000000001 x15: ffff800=
080003ad0
> > [  228.323631] x14: ffff00008574d000 x13: 0000000000000000 x12: 0000000=
000000001
> > [  228.330775] x11: 0000000000000001 x10: 0000000000000001 x9 : 0000000=
000001000
> > [  228.337921] x8 : ffff00008674c390 x7 : ffff00008674c000 x6 : 0000000=
000000003
> > [  228.345066] x5 : 0000000000000003 x4 : 0000000000000001 x3 : 0000000=
000000002
> > [  228.352209] x2 : 0000000000000001 x1 : 0000000000000000 x0 : ffff000=
08574b000
> > [  228.359356] Call trace:
> > [  228.361807]  __arm_lpae_map+0x388/0x4e4 (P)
> > [  228.366002]  __arm_lpae_map+0x120/0x4e4 (L)
> > [  228.370198]  __arm_lpae_map+0x120/0x4e4
> > [  228.374042]  __arm_lpae_map+0x120/0x4e4
> > [  228.377886]  __arm_lpae_map+0x120/0x4e4
> > [  228.381730]  arm_lpae_map_pages+0x108/0x250
> > [  228.385922]  arm_smmu_map_pages+0x40/0x120
> > [  228.390029]  __iommu_map+0xfc/0x1bc
> > [  228.393525]  iommu_map+0x38/0xc0
> > [  228.396759]  __iommu_dma_map+0xb4/0x1a4
> > [  228.400604]  iommu_dma_map_page+0x14c/0x27c
> > [  228.404795]  dma_map_page_attrs+0x1fc/0x280
> > [  228.408987]  stmmac_tso_xmit+0x2d0/0xbac
> > [  228.412920]  stmmac_xmit+0x230/0xd14
> > [  228.416505]  dev_hard_start_xmit+0x94/0x11c
> > [  228.420697]  sch_direct_xmit+0x8c/0x380
> > [  228.424540]  __qdisc_run+0x11c/0x66c
> > [  228.428121]  net_tx_action+0x168/0x228
> > [  228.431875]  handle_softirqs+0x100/0x244
> > [  228.435809]  __do_softirq+0x14/0x20
> > [  228.439303]  ____do_softirq+0x10/0x20
> > [  228.442972]  call_on_irq_stack+0x24/0x64
> > [  228.446903]  do_softirq_own_stack+0x1c/0x40
> > [  228.451091]  __irq_exit_rcu+0xd4/0x10c
> > [  228.454847]  irq_exit_rcu+0x10/0x1c
> > [  228.458343]  el1_interrupt+0x38/0x68
> > [  228.461927]  el1h_64_irq_handler+0x18/0x24
> > [  228.466032]  el1h_64_irq+0x6c/0x70
> > [  228.469438]  default_idle_call+0x28/0x58 (P)
> > [  228.473718]  default_idle_call+0x24/0x58 (L)
> > [  228.477998]  do_idle+0x1fc/0x260
> > [  228.481234]  cpu_startup_entry+0x34/0x3c
> > [  228.485163]  rest_init+0xdc/0xe0
> > [  228.488401]  console_on_rootfs+0x0/0x6c
> > [  228.492250]  __primary_switched+0x88/0x90
> > [  228.496270] ---[ end trace 0000000000000000 ]---
> > [  228.500950] dwc-eth-dwmac 2490000.ethernet: Tx dma map failed
> > --- >8 ---
> >=20
> > This looks to be slightly different from what Jon was seeing. Looking at
> > the WARN_ON() that triggers this, it seems like for some reason the page
> > is getting mapped twice.
> >=20
> > Not exactly sure why that would be happening, so adding Robin and Will,
> > maybe they can shed some light on this from the ARM SMMU side.
> >=20
> > Robin, Will, any idea who could be the culprit here? Is this a map/unmap
> > imbalance or something else entirely?
>=20
> If valid PTEs are getting left behind in the pagetable, that would indica=
te
> that a previous dma_unmap_page() was called with a size smaller than its
> original dma_map_page(). Throwing CONFIG_DMA_API_DEBUG at it should
> hopefully shed more light.

Bull's-eye! DMA_API_DEBUG does flag this:

--- >8 ---
[   60.469121] DMA-API: dwc-eth-dwmac 2490000.ethernet: device driver tries=
 to free DMA memory it has not allocated [device add ress=3D0x000000ffffcf6=
5c0] [size=3D66 bytes]
1
[   60.486534] WARNING: CPU: 0 PID: 0 at kernel/dma/debug.c:972 check_unmap=
+0x564/0x8f0
[   60.494493] Modules linked in: snd_soc_tegra210_admaif snd_soc_tegra_pcm=
 snd_soc_tegra210_ope snd_soc_tegra186_asrc snd_soc_tegra210_amx snd_soc_te=
gra210_mv
c snd_soc_tegra210_mixer snd_soc_tegra210_dmic snd_soc_tegra210_sfc snd_soc=
_tegra186_dspk snd_soc_tegra210_i2s snd_soc_tegra210_adx tegra_drm drm_dp_a=
ux_bus ce
c drm_display_helper drm_client_lib drm_kms_helper tegra210_adma snd_soc_te=
gra210_ahub snd_hda_codec_hdmi snd_soc_tegra_audio_graph_card snd_hda_tegra=
 snd_soc_
audio_graph_card snd_hda_codec snd_soc_simple_card_utils at24 snd_hda_core =
ina3221 tegra_aconnect tegra_xudc tegra_bpmp_thermal host1x fuse drm backli=
ght ipv6
[   60.549857] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G S           =
      6.13.0-rc1-next-20241203 #31
[   60.559504] Tainted: [S]=3DCPU_OUT_OF_SPEC
[   60.563423] Hardware name: nvidia NVIDIA P2771-0000-500/NVIDIA P2771-000=
0-500, BIOS 2025.01-rc3-00040-g36352ae2e68e-dirty 01/01/2025
[   60.575317] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[   60.582273] pc : check_unmap+0x564/0x8f0
[   60.586197] lr : check_unmap+0x564/0x8f0
[   60.590117] sp : ffff800080003b50
[   60.593428] x29: ffff800080003b50 x28: ffff0000825309c0 x27: ffff0000825=
313c0
[   60.600562] x26: 00000000000001b9 x25: 0000000000000001 x24: ffff0000801=
1b410
[   60.607696] x23: ffff800082059ec0 x22: 0000000000000000 x21: ffff8000825=
b25c8
[   60.614829] x20: ffff800080003bc0 x19: 000000ffffcf65c0 x18: 00000000000=
00006
[   60.621962] x17: 645b206465746163 x16: 0000000000000000 x15: 07200720072=
00720
[   60.629095] x14: ffff800082074960 x13: 0720072007200720 x12: 07200720072=
00720
[   60.636229] x11: ffff800082074960 x10: 0000000000000299 x9 : ffff8000820=
cc960
[   60.643362] x8 : 0000000000017fe8 x7 : 00000000fffff000 x6 : ffff8000820=
cc960
[   60.650496] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 00000000000=
00000
[   60.657629] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff8000820=
64900
[   60.664763] Call trace:
[   60.667206]  check_unmap+0x564/0x8f0 (P)
[   60.671131]  check_unmap+0x564/0x8f0 (L)
[   60.675055]  debug_dma_unmap_page+0xac/0xc0
[   60.679239]  dma_unmap_page_attrs+0xf4/0x200
[   60.683508]  stmmac_tx_clean.constprop.0+0x1ac/0x7bc
[   60.688474]  stmmac_napi_poll_tx+0xdc/0x168
[   60.692657]  __napi_poll+0x38/0x180
[   60.696148]  net_rx_action+0x158/0x2c0
[   60.699897]  handle_softirqs+0x100/0x244
[   60.703821]  __do_softirq+0x14/0x20
[   60.707309]  ____do_softirq+0x10/0x20
[   60.710970]  call_on_irq_stack+0x24/0x64
[   60.714891]  do_softirq_own_stack+0x1c/0x40
[   60.719072]  __irq_exit_rcu+0xd4/0x10c
[   60.722821]  irq_exit_rcu+0x10/0x1c
[   60.726308]  el1_interrupt+0x38/0x68
[   60.729886]  el1h_64_irq_handler+0x18/0x24
[   60.733980]  el1h_64_irq+0x6c/0x70
[   60.737381]  default_idle_call+0x28/0x58 (P)
[   60.741652]  default_idle_call+0x24/0x58 (L)
[   60.745920]  do_idle+0x1fc/0x260
[   60.749149]  cpu_startup_entry+0x34/0x3c
[   60.753068]  rest_init+0xdc/0xe0
[   60.756296]  console_on_rootfs+0x0/0x6c
[   60.760135]  __primary_switched+0x88/0x90
[   60.764146] ---[ end trace 0000000000000000 ]---
--- >8 ---

This doesn't match the location from earlier, but at least there's
something afoot here that needs fixing. I suppose this could simply be
hiding any subsequent errors, so once this is fixed we might see other
similar issues.

Furong, I can look into this some more, but I'm not at all familiar with
this part of the driver, so I don't really know where this could be
originating from. Any pointers would be appreciated. Also, if you think
there's anything I should try, I do have this setup that I can test on
locally.

Thierry

--lrjlcvs3uibftgsq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmdQfCYACgkQ3SOs138+
s6FjWhAAni5ilnFd5G+xoW+k7BqHpNA7A+YjYGceNk3Ae7gX/rgCXRHqjnoCFS/o
qqLEJr/IQ7HvXYyBbfXEaGtXTX3v6QM/RXPqZOAFt4K/e7+4X0zJC51UAmdtcGpp
jV0FflBnCVvMd+LdLqAN7OEIQnFyXp8wb1+k3V9BOqj/CG/V2QbIyJU3Ff4v0GlX
ljiHkd3gQcd5te7e0u5H4O9tf794jEc2iQBf+wKeEZLN5Dqkf8XRDpP8GSWiwVhx
EgqjxxaVLcRZb0wiPmulyoWx7iKi0a1He1SefSbAqTkxuLP7iaXmMtffrZfYEkyT
W+MLvtEmpp1+7MSL7I3JD/UYXh5gXqIE3I/flECwPcpH+tTmmW+NvA5kmvS/Z7y4
aYnAez5jv65vGpwFMkFZTbw7oaPV00BKpXliyCe25ghDwKA2NOHlR1qt1bz+d/jE
gUYO2wWBWnX2zpuUfYEVzPjKWsFSsand4WUwRQOcsGNk1UKXMI4aoTagOU1vG2aZ
DIHJFVQx/bHAZh025m30UdcKr8mwpQHQHkOGEmmxJhxW5YzHHOLNTU7ANPXawPUR
Uvqqql88Luxfw9EU+DYABmP6kFll+Gh2kOs81IjZkc4uyrNNzGL6/ydluzntwoEq
TiP+c/2g0jY+/mJquWKvs2S7qjv9h5L/XG4NKeOX+xxN+mYxNAI=
=HkJp
-----END PGP SIGNATURE-----

--lrjlcvs3uibftgsq--


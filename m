Return-Path: <netdev+bounces-156346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A51A06255
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35EC188A2B9
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D897B1FF5FE;
	Wed,  8 Jan 2025 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAIrnvMy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A381FF1BF;
	Wed,  8 Jan 2025 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354457; cv=none; b=S/JSJfm/Pf4JwVankuuVHqFRod2bYan0tqrOhyi0jmZ89vEwvInCNyFEHzevjlw0k/Im3TFZCxPe95Nr8DuLpSMwpEdapiqP/+gfqqRge12vlHbelsEDfqTVtz658HAX/ISV3Z3H/xcd9fLlwpBm/pCgKZgsgf4zoigbskESTFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354457; c=relaxed/simple;
	bh=z9TgFh043/DXdBn5gBXcwWArZNoigSNcpIJBh4NgW50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQlez1e8GSSJz/1F/RJiq6H9J54yBjGTVkw+L2LquGj7+dN1LYIt4P8xkqncAluK+HRp72JyCXyWg7BSCXmmAwbXp9GElGIG6/lCOK0Mteha31srWghtDyKA2NC6hIyEYSrTlYp7id1lNGcFlBjMl8MBdsLSg250SylQ3dd3dOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAIrnvMy; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4361f796586so235595e9.3;
        Wed, 08 Jan 2025 08:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736354454; x=1736959254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/guJsq6cwbtb+0dBqQXpmlgg1lrvBQhk8AS5wE9Cuks=;
        b=dAIrnvMyW0QCDBAM1eEArPJthvFY+JSAfRoOW7tEa3CgWJrDCF4oKwSPeEXpI70EQE
         o0AXK/QImmbQZvZbZZPoQhNSuUoqegr7hPyFo44tc/Y1t+5JoBjQ14T65QINRioyvxlH
         4g3rTu9VfqI+KB7MnwLm5TsiGyg+sBDYKLeUBKtc5CGw6IwsQnHZzFSen0prvcqx/eOq
         Hzhw80oPhWf3+GQBYvqhUVFMPNbH0lPnaWoKgfprE5JH684eSb3oWqJaWV+eIPKWMGb6
         i+oAP/jsXvxBmBEsDn1UrAhN+1yqtn0QAY4g4smRUg03QhrbhZ3eUor2XYttsKbQIs0J
         tv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736354454; x=1736959254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/guJsq6cwbtb+0dBqQXpmlgg1lrvBQhk8AS5wE9Cuks=;
        b=egiUq/ERKrxElurzgZRWqQvlu0qh3gGTmL1UflpS9qTMdcsy1sikBEXTLVCKfXSYG4
         VcNYHHHq507upsuUKPCxLPLGaCVTv5ufrCD/fST6ozFr8tQFcyyHau00HQkljNwHHvDV
         cDz/v4JIagRkdMMFyKcBY69EbJDSqhOizpBoAPImjXpWRF8kxhxEso5Nla2ta6OzzVRT
         6AZZoIXas0tfnfNvsMpDC+7d5pSHbBsd++FshUeHoB/p22Jfom9CV0xFw375bHECZYLy
         umUDCOt8Gz6pSgBhLMQ+JMRm3/IBEUtKPq/xuSG14BBSL5eqSdFp1Z5l5+fd6Lk8aNX0
         i58Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBrbOetcq+6ChLj5ysg7ch9WXkkgkGK6/03s+USKpk063J/m5DRdxz/aTH3EjLweYL3jtljgVEuNk1ejQ=@vger.kernel.org, AJvYcCUpENc4zONaGimbl/mPdIgBKi+RF3uyMx+fFnYNS9KEgDsT3oWrO/Im9yWy0rcuTMBCcZ/ESiWr@vger.kernel.org, AJvYcCXNAlEC57vwLSmV/9OmSKI7DIQfAaWM2DEbla3r0ezzeagsBEPo9uX3G5HhTSRBdFWg8wENu8hTf/vbiRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh4PuQ/ywQ7l65W2HB64XJ4oz2cZs3y0Qwc5fJkaxtZL62IfJR
	Sw+ZU6T0ZQ4lA6aTXvNqUh5QSwxIClhuHd+5WupGd19GfdlKyrKx
X-Gm-Gg: ASbGncu6FnaT32HQtq/9LAMdVzOrDFSv2hErRReCU7K14yVNMuUlxPoWKrzBhy2Nsi1
	4ZNsuNZ3DPYdo0Eq+NhXho96T8chKutS5znj7ooOMwbTkjLq752g8GOcyGm2JebW7NE0rxcx7v3
	5raIqxR2RBjmSivi0FgWA6zlW4ooIoijN/I5Ybh0DwPBlchA1ha4cRR7ydDjY/077H/DatKw+iX
	lIKxUUVVefEQEHiehUGz1c7RUvdKmmRKQMzETEEfYEuFSzuCybsiiWw4k7JCX24QsQlgd2hStni
	IbvFLzMemVbCfNf7QciOMbTgetkDiooV7wp/zHQLFCk=
X-Google-Smtp-Source: AGHT+IHwgwBkdW+ZmyxGIwkpvXTrRhp+gIkfwI9CQ0ow6tLc8HtKrjisdX6JVQfYI8d0IFvq2vZlGQ==
X-Received: by 2002:a05:600c:1c9a:b0:428:d31:ef25 with SMTP id 5b1f17b1804b1-436e26975f1mr33250855e9.12.1736354453763;
        Wed, 08 Jan 2025 08:40:53 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e92794sm25856885e9.37.2025.01.08.08.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 08:40:52 -0800 (PST)
Date: Wed, 8 Jan 2025 17:40:50 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Parker Newman <parker@finest.io>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH net v2 1/1] net: stmmac: dwmac-tegra: Read iommu stream
 id from device tree
Message-ID: <oz6f5mcxi7jxyubrd6dpdltusogv5ortbmll6rom5c2bja2x7o@brsqolpmp5x7>
References: <6fb97f32cf4accb4f7cf92846f6b60064ba0a3bd.1736284360.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2uonbsu5shywby2b"
Content-Disposition: inline
In-Reply-To: <6fb97f32cf4accb4f7cf92846f6b60064ba0a3bd.1736284360.git.pnewman@connecttech.com>


--2uonbsu5shywby2b
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net v2 1/1] net: stmmac: dwmac-tegra: Read iommu stream
 id from device tree
MIME-Version: 1.0

On Tue, Jan 07, 2025 at 04:24:59PM -0500, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>
>=20
> Nvidia's Tegra MGBE controllers require the IOMMU "Stream ID" (SID) to be
> written to the MGBE_WRAP_AXI_ASID0_CTRL register.
>=20
> The current driver is hard coded to use MGBE0's SID for all controllers.
> This causes softirq time outs and kernel panics when using controllers
> other than MGBE0.
>=20
> Example dmesg errors when an ethernet cable is connected to MGBE1:
>=20
> [  116.133290] tegra-mgbe 6910000.ethernet eth1: Link is Up - 1Gbps/Full =
- flow control rx/tx
> [  121.851283] tegra-mgbe 6910000.ethernet eth1: NETDEV WATCHDOG: CPU: 5:=
 transmit queue 0 timed out 5690 ms
> [  121.851782] tegra-mgbe 6910000.ethernet eth1: Reset adapter.
> [  121.892464] tegra-mgbe 6910000.ethernet eth1: Register MEM_TYPE_PAGE_P=
OOL RxQ-0
> [  121.905920] tegra-mgbe 6910000.ethernet eth1: PHY [stmmac-1:00] driver=
 [Aquantia AQR113] (irq=3D171)
> [  121.907356] tegra-mgbe 6910000.ethernet eth1: Enabling Safety Features
> [  121.907578] tegra-mgbe 6910000.ethernet eth1: IEEE 1588-2008 Advanced =
Timestamp supported
> [  121.908399] tegra-mgbe 6910000.ethernet eth1: registered PTP clock
> [  121.908582] tegra-mgbe 6910000.ethernet eth1: configuring for phy/10gb=
ase-r link mode
> [  125.961292] tegra-mgbe 6910000.ethernet eth1: Link is Up - 1Gbps/Full =
- flow control rx/tx
> [  181.921198] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [  181.921404] rcu: 	7-....: (1 GPs behind) idle=3D540c/1/0x4000000000000=
002 softirq=3D1748/1749 fqs=3D2337
> [  181.921684] rcu: 	(detected by 4, t=3D6002 jiffies, g=3D1357, q=3D1254=
 ncpus=3D8)
> [  181.921878] Sending NMI from CPU 4 to CPUs 7:
> [  181.921886] NMI backtrace for cpu 7
> [  181.922131] CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Kdump: loaded Not tai=
nted 6.13.0-rc3+ #6
> [  181.922390] Hardware name: NVIDIA CTI Forge + Orin AGX/Jetson, BIOS 20=
2402.1-Unknown 10/28/2024
> [  181.922658] pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [  181.922847] pc : handle_softirqs+0x98/0x368
> [  181.922978] lr : __do_softirq+0x18/0x20
> [  181.923095] sp : ffff80008003bf50
> [  181.923189] x29: ffff80008003bf50 x28: 0000000000000008 x27: 000000000=
0000000
> [  181.923379] x26: ffffce78ea277000 x25: 0000000000000000 x24: 0000001c6=
1befda0
> [  181.924486] x23: 0000000060400009 x22: ffffce78e99918bc x21: ffff80008=
018bd70
> [  181.925568] x20: ffffce78e8bb00d8 x19: ffff80008018bc20 x18: 000000000=
0000000
> [  181.926655] x17: ffff318ebe7d3000 x16: ffff800080038000 x15: 000000000=
0000000
> [  181.931455] x14: ffff000080816680 x13: ffff318ebe7d3000 x12: 000000003=
464d91d
> [  181.938628] x11: 0000000000000040 x10: ffff000080165a70 x9 : ffffce78e=
8bb0160
> [  181.945804] x8 : ffff8000827b3160 x7 : f9157b241586f343 x6 : eeb6502a0=
1c81c74
> [  181.953068] x5 : a4acfcdd2e8096bb x4 : ffffce78ea277340 x3 : 00000000f=
fffd1e1
> [  181.960329] x2 : 0000000000000101 x1 : ffffce78ea277340 x0 : ffff318eb=
e7d3000
> [  181.967591] Call trace:
> [  181.970043]  handle_softirqs+0x98/0x368 (P)
> [  181.974240]  __do_softirq+0x18/0x20
> [  181.977743]  ____do_softirq+0x14/0x28
> [  181.981415]  call_on_irq_stack+0x24/0x30
> [  181.985180]  do_softirq_own_stack+0x20/0x30
> [  181.989379]  __irq_exit_rcu+0x114/0x140
> [  181.993142]  irq_exit_rcu+0x14/0x28
> [  181.996816]  el1_interrupt+0x44/0xb8
> [  182.000316]  el1h_64_irq_handler+0x14/0x20
> [  182.004343]  el1h_64_irq+0x80/0x88
> [  182.007755]  cpuidle_enter_state+0xc4/0x4a8 (P)
> [  182.012305]  cpuidle_enter+0x3c/0x58
> [  182.015980]  cpuidle_idle_call+0x128/0x1c0
> [  182.020005]  do_idle+0xe0/0xf0
> [  182.023155]  cpu_startup_entry+0x3c/0x48
> [  182.026917]  secondary_start_kernel+0xdc/0x120
> [  182.031379]  __secondary_switched+0x74/0x78
> [  212.971162] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/t=
asks: { 7-.... } 6103 jiffies s: 417 root: 0x80/.
> [  212.985935] rcu: blocking rcu_node structures (internal RCU debug):
> [  212.992758] Sending NMI from CPU 0 to CPUs 7:
> [  212.998539] NMI backtrace for cpu 7
> [  213.004304] CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Kdump: loaded Not tai=
nted 6.13.0-rc3+ #6
> [  213.016116] Hardware name: NVIDIA CTI Forge + Orin AGX/Jetson, BIOS 20=
2402.1-Unknown 10/28/2024
> [  213.030817] pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [  213.040528] pc : handle_softirqs+0x98/0x368
> [  213.046563] lr : __do_softirq+0x18/0x20
> [  213.051293] sp : ffff80008003bf50
> [  213.055839] x29: ffff80008003bf50 x28: 0000000000000008 x27: 000000000=
0000000
> [  213.067304] x26: ffffce78ea277000 x25: 0000000000000000 x24: 0000001c6=
1befda0
> [  213.077014] x23: 0000000060400009 x22: ffffce78e99918bc x21: ffff80008=
018bd70
> [  213.087339] x20: ffffce78e8bb00d8 x19: ffff80008018bc20 x18: 000000000=
0000000
> [  213.097313] x17: ffff318ebe7d3000 x16: ffff800080038000 x15: 000000000=
0000000
> [  213.107201] x14: ffff000080816680 x13: ffff318ebe7d3000 x12: 000000003=
464d91d
> [  213.116651] x11: 0000000000000040 x10: ffff000080165a70 x9 : ffffce78e=
8bb0160
> [  213.127500] x8 : ffff8000827b3160 x7 : 0a37b344852820af x6 : 3f049caed=
d1ff608
> [  213.138002] x5 : cff7cfdbfaf31291 x4 : ffffce78ea277340 x3 : 00000000f=
fffde04
> [  213.150428] x2 : 0000000000000101 x1 : ffffce78ea277340 x0 : ffff318eb=
e7d3000
> [  213.162063] Call trace:
> [  213.165494]  handle_softirqs+0x98/0x368 (P)
> [  213.171256]  __do_softirq+0x18/0x20
> [  213.177291]  ____do_softirq+0x14/0x28
> [  213.182017]  call_on_irq_stack+0x24/0x30
> [  213.186565]  do_softirq_own_stack+0x20/0x30
> [  213.191815]  __irq_exit_rcu+0x114/0x140
> [  213.196891]  irq_exit_rcu+0x14/0x28
> [  213.202401]  el1_interrupt+0x44/0xb8
> [  213.207741]  el1h_64_irq_handler+0x14/0x20
> [  213.213519]  el1h_64_irq+0x80/0x88
> [  213.217541]  cpuidle_enter_state+0xc4/0x4a8 (P)
> [  213.224364]  cpuidle_enter+0x3c/0x58
> [  213.228653]  cpuidle_idle_call+0x128/0x1c0
> [  213.233993]  do_idle+0xe0/0xf0
> [  213.237928]  cpu_startup_entry+0x3c/0x48
> [  213.243791]  secondary_start_kernel+0xdc/0x120
> [  213.249830]  __secondary_switched+0x74/0x78
>=20
> This bug has existed since the dwmac-tegra driver was added in Dec 2022
> (See Fixes tag below for commit hash).
>=20
> The Tegra234 SOC has 4 MGBE controllers, however Nvidia's Developer Kit
> only uses MGBE0 which is why the bug was not found previously. Connect Te=
ch
> has many products that use 2 (or more) MGBE controllers.
>=20
> The solution is to read the controller's SID from the existing "iommus"
> device tree property. The 2nd field of the "iommus" device tree property
> is the controller's SID.
>=20
> Device tree snippet from tegra234.dtsi showing MGBE1's "iommus" property:
>=20
> smmu_niso0: iommu@12000000 {
>         compatible =3D "nvidia,tegra234-smmu", "nvidia,smmu-500";
> ...
> }
>=20
> /* MGBE1 */
> ethernet@6900000 {
> 	compatible =3D "nvidia,tegra234-mgbe";
> ...
> 	iommus =3D <&smmu_niso0 TEGRA234_SID_MGBE_VF1>;
> ...
> }
>=20
> Nvidia's arm-smmu driver reads the "iommus" property and stores the SID in
> the MGBE device's "fwspec" struct. The dwmac-tegra driver can access the
> SID using the tegra_dev_iommu_get_stream_id() helper function found in
> linux/iommu.h.
>=20
> Calling tegra_dev_iommu_get_stream_id() should not fail unless the "iommu=
s"
> property is removed from the device tree or the IOMMU is disabled.
>=20
> While the Tegra234 SOC technically supports bypassing the IOMMU, it is not
> supported by the current firmware, has not been tested and not recommende=
d.
> More detailed discussion with Thierry Reding from Nvidia linked below.
>=20
> Fixes: d8ca113724e7 ("net: stmmac: tegra: Add MGBE support")
> Link: https://lore.kernel.org/netdev/cover.1731685185.git.pnewman@connect=
tech.com
> Signed-off-by: Parker Newman <pnewman@connecttech.com>
> ---
>=20
> Changes v2:
> - dropped cover letter
> - added more detail to commit message
> - rebased to latest netdev tree
>=20
>  drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--2uonbsu5shywby2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmd+qpIACgkQ3SOs138+
s6FilhAArehaljH1La9BTRwP2lKEUwFU5AjTkeTdvAeg+h0For7hW+0icZCCsu/N
7RPZ5oKSzU0lqQKb9MBMSO29ecbkvR0OnZnKtN8LWibwOaMo0Tw+l1y+/h9vbiF8
MPQpKgIDqm/Qtk0VsEHtys6PnU4jTdFo5CF3abq+KyU0wmh94VLu8zWZIOqNns8p
GonxHxaFivU5jIVrTYZwwTo3fZf2k2xJJf02L05K8+SNew/0NNDOubTCE8U/akWk
hjPKr18wehk1DDh5Uheen2dPsPVIKwkikmAwaa6lwU7SnTDH0PEALw3TtlN16cDi
AMthb5rg0O+7rw7maUAb3nmZVAVxv9/jIHvd9eMPV+JcsNiZABJ5cMh28Op8mD+P
lf7Fm20l9ZijGKgIxG9vsQ46yLL0+8sGtW6utG17l1/OoU5rConONY0M0Fb800pY
Ph97Ufxq5xDmK8zTA58pLLJkgu9uVpxes0kpk5RByOAbBA/KyiBNlTEW/FOY2uWg
8sHxX8l8rZo9OKnGWFihJQJl+DTW8VXN7oY92Pt23jlXrMwfiwPnf+a07TLQ0nRf
ZePp7G6OmyfmInQaMsxFeyn7voW64gIdoY+7X+t2y7M68BiwP7fQil9w+VGFjaRH
V3nN10wsEpuU7UgcW4wYxDm+edGupkzySs413scbgzD3ue7WSic=
=YtPl
-----END PGP SIGNATURE-----

--2uonbsu5shywby2b--


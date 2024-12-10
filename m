Return-Path: <netdev+bounces-150806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6459EB99F
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 19:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B062815AA
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9381BEF70;
	Tue, 10 Dec 2024 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="HLsKZhmZ"
X-Original-To: netdev@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D406623ED41;
	Tue, 10 Dec 2024 18:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856626; cv=none; b=Wxj9BCWr0werohhBxLRumrV2c0AvibYTUrmoOh5/GySZ/qUGuXxN6A/69BT0owo4TLuXpqynGq2Otsc+RBlxQLTgFq7dmMTHxkOdMc1LAF8StUw2Epu9IEelJxWMv4c2R1w/vglzAeHm5qPt0b1jyprHvtIoXb/H0Je0Uczo1O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856626; c=relaxed/simple;
	bh=jeb8RjObl9n/RpjrBee2UUV1rzl2k9GmIRAso3y1rqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gVynpkFZKBCOzlY3hsNXCzRPrUJgb+MiLWcHVOR+jN6lK+hzOI9MdPQ/fqqNX2R8YqrThF+wb7zQNYMY7oFckN78M0ee0JjSgxygVYTozH9gJ7kVZEsDFz5pLExrav0QSpw3s6ExanwqePLbWGSX6YSuFMOFjhXVn9R2uBNR4Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=HLsKZhmZ; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1733856574; x=1734461374; i=parker@finest.io;
	bh=sXGDoDjkGFFSl51u8zxIYJIcqrg3qf0vQUL25ISmdXo=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HLsKZhmZn5EV78icqXKZwd+lbxo6+tUK0g14xjb6HGLXz6inIBXEiEShNnb2zk0c
	 w/JERmS2bidwQuhgYmZ9+uZfwgprFCP3L4K/IQXyLXpH2i9w7GKAJEhXjbmvWgFTg
	 Rnd02iyDf9oplvzRUA7iwrPA14ex37NLpFQsbGYT5ltovGzh5tUZW0urijPNDlixx
	 oxdfezbNhYSy4L78sHkb/OS5XZcKsWGSUqpdysK2AnYlmHRoUUgC6EF1DUxTvvNM5
	 fwtMgdVUUuxwiBQLJdtFuUS7rD8oN7r9+YX3UW8x0hKtcxog6w8pcR7PRmdViNP4i
	 RRFJ/eDCu2l8ksVxvQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MGknn-1tPoFQ2dNJ-009LJs; Tue, 10 Dec 2024 19:49:33 +0100
Date: Tue, 10 Dec 2024 13:49:30 -0500
From: Parker Newman <parker@finest.io>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Jonathan
 Hunter <jonathanh@nvidia.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v1 1/1] net: stmmac: dwmac-tegra: Read iommu stream id
 from device tree
Message-ID: <20241210134930.0f963709.parker@finest.io>
In-Reply-To: <vyzrfrkvwwbi66zemgjywdzpk75mebr47vxaon5jwnn2vprahl@ndzjlez3ywgv>
References: <bb52bdc1-df2e-493d-a58f-df3143715150@lunn.ch>
	<20241118084400.35f4697a.parker@finest.io>
	<984a8471-7e49-4549-9d8a-48e1a29950f6@lunn.ch>
	<20241119131336.371af397.parker@finest.io>
	<f00bccd3-62d5-46a9-b448-051894267c7a@lunn.ch>
	<20241119144729.72e048a5.parker@finest.io>
	<mpgilwqb5zg5kb4n7r6zwbhy4uutdh6rq5s2yc6ndhcj6gqgri@qkfr4qwjj3ym>
	<20241204115317.008f497c.parker@finest.io>
	<uad6id6omswjm7e4eqwd75c52sy5pddtxru3bcuxlukhecvj4u@klzgrws24r2q>
	<20241206084203.2502ab95.parker@finest.io>
	<vyzrfrkvwwbi66zemgjywdzpk75mebr47vxaon5jwnn2vprahl@ndzjlez3ywgv>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YH2jGO95AdX7oPzjLch72mMQO5TSMAiGw1gFaJeEQ8bYIyNDqgc
 6uSgtqvI9N/SkrLZTX1E6RaIcOyizSttMBzs8K0GBkymI7PI0gVKjgBjRbWt3v15dHMwrUB
 TDTfMznV2ZtimFGzzYvWbxC4eUDek+mUYN1VTrm0ECvtnu7DTYIgGlzGfwNRmcwPHn31lYI
 dWAAq4hReSBo5+Qe1ui9A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:f1o3tPPtBnU=;vSmAOKOkEElLwW6kf2XQdeBsfMF
 YUVRGvNG7ndwxxTCRvVKx/FNa2Uk71AGWTIFfjo2LzpPv1+BZAx9WkTiVS6J4RYSrkz4eU51c
 32Auwoj6FUbodmHP2jKZltaXeYzefZ19oTIeJJfXZP8axMGz9Kh0ILZrbrVDt0P6zlRWOCy/u
 w9w2nH7t6KYUXoEeoR45iZ2Wsb6rhPSGUatO3xlpW6OnLEG2r+r8CLQDftt4rSnvi55j3gOmg
 kNltiO1AvMAIxWzl+92m0AdEUACxRGwDRT98o7U3tL/tB0fs7m3eLF70xIu6j8Ft8ryZMfOIe
 NKNVI9zqI3qo0GEHpJ2XG221RutkKlLT7mb3QgPL5NgYrI1W8o049e4f5hsoQ483zsGGD6vI9
 qtzuh89Ie9ldy52m9IMnhCJfDuaWMLvFPwV1QATZWTxWLAKnJ2TS5kjl2Tg9YgWjX3PugEr7H
 RTth/KNa805ChPXzsOYpvVrsKfAQtbsV1LytI36zIHmNTBihX9yKrQpXxF4EwGfXNtYbG5tap
 1FBFVfjrsNKknJ4l4UhP8qKRdgZ52RM+jXNNNzJ0E0WWcTiDD6Yipt6yyK9oH9qG8bE6YjQBL
 qXVD1fYaEQS7Limq/9B+YNvE2v7DqWjyIOF/FTuA3PBC22mRsapTYi3pw3+NKeGbrDmmsYkER
 3ewSj/2jNeLfHQS0r24wbE0kHrKlX/QiY6kJIk8poIps92+CbpKrG6oc350RsFIwIu1TS++Yi
 Mx71vH8hU7D984VM1K+gsU8pRwOFGzXz/wpjL32kRWqWfB4/71683mP0Lu4rXOet7Bk6TxmWP
 F7ObvdQTAjCtg89IsysBes7aCmCspujilY1QnZGcNL6c0yUCuQEXMA5Esdh3amv22/fuOf9X7
 zZ7D3j0HNfpYWUZ+PKxBa+ihw4MiE1pG9cK1tJGQxGoqdCNGWwVsfzNcrS+VRMyL33K3vkxei
 tD/wv+p87Khm+pmE+ALTWWPcm+14b43Ago1aY6YRD+4KpoJfoJen0EaguY8Da9n3bqgGws3vk
 /zah2f1Zk6OoHdiiRB4iCWz42O9QGDscsOrbzr+

On Fri, 6 Dec 2024 17:01:01 +0100
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Fri, Dec 06, 2024 at 08:42:03AM -0500, Parker Newman wrote:
> > On Wed, 4 Dec 2024 19:06:30 +0100
> > Thierry Reding <thierry.reding@gmail.com> wrote:
> >
> > > On Wed, Dec 04, 2024 at 11:53:17AM -0500, Parker Newman wrote:
> > > > On Wed, 4 Dec 2024 17:23:53 +0100
> > > > Thierry Reding <thierry.reding@gmail.com> wrote:
> > > >
> > > > > On Tue, Nov 19, 2024 at 02:47:29PM -0500, Parker Newman wrote:
> > > > > > On Tue, 19 Nov 2024 20:18:00 +0100
> > > > > > Andrew Lunn <andrew@lunn.ch> wrote:
> > > > > >
> > > > > > > > I think there is some confusion here. I will try to summar=
ize:
> > > > > > > > - Ihe iommu is supported by the Tegra SOC.
> > > > > > > > - The way the mgbe driver is written the iommu DT property=
 is REQUIRED.
> > > > > > >
> > > > > > > If it is required, please also include a patch to
> > > > > > > nvidia,tegra234-mgbe.yaml and make iommus required.
> > > > > > >
> > > > > >
> > > > > > I will add this when I submit a v2 of the patch.
> > > > > >
> > > > > > > > - "iommus" is a SOC DT property and is defined in tegra234=
.dtsi.
> > > > > > > > - The mgbe device tree nodes in tegra234.dtsi DO have the =
iommus property.
> > > > > > > > - There are no device tree changes required to to make thi=
s patch work.
> > > > > > > > - This patch works fine with existing device trees.
> > > > > > > >
> > > > > > > > I will add the fallback however in case there is changes m=
ade to the iommu
> > > > > > > > subsystem in the future.
> > > > > > >
> > > > > > > I would suggest you make iommus a required property and run =
the tests
> > > > > > > over the existing .dts files.
> > > > > > >
> > > > > > > I looked at the history of tegra234.dtsi. The ethernet nodes=
 were
> > > > > > > added in:
> > > > > > >
> > > > > > > 610cdf3186bc604961bf04851e300deefd318038
> > > > > > > Author: Thierry Reding <treding@nvidia.com>
> > > > > > > Date:   Thu Jul 7 09:48:15 2022 +0200
> > > > > > >
> > > > > > >     arm64: tegra: Add MGBE nodes on Tegra234
> > > > > > >
> > > > > > > and the iommus property is present. So the requires is safe.
> > > > > > >
> > > > > > > Please expand the commit message. It is clear from all the q=
uestions
> > > > > > > and backwards and forwards, it does not provide enough detai=
ls.
> > > > > > >
> > > > > >
> > > > > > I will add more details when I submit V2.
> > > > > >
> > > > > > > I just have one open issue. The code has been like this for =
over 2
> > > > > > > years. Why has it only now started crashing?
> > > > > > >
> > > > > >
> > > > > > It is rare for Nvidia Jetson users to use the mainline kernel.=
 Nvidia
> > > > > > provides a custom kernel package with many out of tree drivers=
 including a
> > > > > > driver for the mgbe controllers.
> > > > > >
> > > > > > Also, while the Orin AGX SOC (tegra234) has 4 instances of the=
 mgbe controller,
> > > > > > the Nvidia Orin AGX devkit only uses mgbe0. Connect Tech has c=
arrier boards
> > > > > > that use 2 or more of the mgbe controllers which is why we fou=
nd the bug.
> > > > >
> > > > > Correct. Also, this was a really stupid thing that I overlooked.=
 I don't
> > > > > recall the exact circumstances, but I vaguely recall there had b=
een
> > > > > discussions about adding the tegra_dev_iommu_get_stream_id() hel=
per
> > > > > (that this patch uses) around the time that this driver was crea=
ted. In
> > > > > the midst of all of this I likely forgot to update the driver af=
ter the
> > > > > discussions had settled.
> > > > >
> > > > > Anyway, I agree with the conclusion that we don't need a compati=
bility
> > > > > fallback for this, both because it would be actively wrong to do=
 it and
> > > > > we've had the required IOMMU properties in device tree since the=
 start,
> > > > > so there can't be any regressions caused by this.
> > > > >
> > > > > I don't think it's necessary to make the iommus property require=
d,
> > > > > though, because there's technically no requirement for these dev=
ices to
> > > > > be attached to an IOMMU. They usually are, and it's better if th=
ey are,
> > > > > but they should be able to work correctly without an IOMMU.
> > > > >
> > > > Thanks for confirming from the Nvidia side! I wasn't sure if they =
would
> > > > work without the iommu. That said, if you did NOT want to use the =
iommu
> > > > and removed the iommu DT property then the probe will fail after m=
y patch.
> > > > Would we not need a guard around the writes to MGBE_WRAP_AXI_ASID0=
_CTRL as well?
> > >
> > > Well... frankly, I don't know. There's an override in the memory
> > > controller which we set when a device is attached to an IOMMU. That'=
s
> > > usually how the stream ID is programmed. If we don't do that it will
> > > typically default to a special passthrough stream ID (technically th=
e
> > > firmware can lock down those register and force them to a specific
> > > stream ID all the time). I'm not sure what exactly the impact is of
> > > these ASID registers (there's a few other instances where those are
> > > needed). They are required if you want to use the IOMMU, but I don't
> > > know what their meaning is if the IOMMU is not enabled.
> > >
> > > There's also different cases: the IOMMU can be disabled altogether, =
in
> > > which case no page tables and such exist for any device and no
> > > translation should happen whatsoever. But there's also the case wher=
e an
> > > IOMMU is enabled, but certain devices shouldn't attach to them. I sh=
ould
> > > make it very clear that both of these are not recommended setups and=
 I
> > > don't know if they'll work. And they are mostly untested. I've been
> > > meaning, but haven't found the time, to test some of these cases.
> > >
> >
> > Yes I agree, all of those situations are very niche and not recommende=
d for
> > a Tegra platform that should always have the iommu enabled anyways. Ad=
ding an
> > iommu bypass would probably be outside of the scope of this patch.
> >
> > I will not add a patch marking the iommu as required in the device tre=
e
> > bindings when I submit v2 unless anyone else feels different.
>
> I was able to find a bit more information on this. Starting with
> Tegra234 it's usually no longer possible to even enable bypass. It can
> still be done, but it needs to be carefully coordinated between the
> secure bootloader/firmware and the OS. Basically the secure firmware
> can lock down the ability to bypass the IOMMU. If the firmware was
> configured to allow bypass, the driver can then do so by writing the
> special stream ID 0x7f into the stream ID register.
>
> On these newer chips the memory controller override no longer has any
> effect and writing the per-device stream ID registers is the only way to
> attach to the IOMMU.
>
> There's still the case where you can disable the IOMMU altogether, in
> which case the IOMMU will still be bypassed, no matter what the firmware
> did. My understanding is that it doesn't matter in those cases whether
> we write the stream ID registers or not, they will simply get ignored.
> With one exception perhaps being the bypass SID. If you write that, then
> there's a protection mechanism that kicks in.
>
> Well, after all this this still isn't entirely clear to me, but I think
> what it means in a nutshell is that a) we'll want to keep the IOMMU
> always on for security and because the firmware is by default configured
> to not allow bypassing, b) IOMMU isn't strictly required because the
> IOMMU might be completely disabled and c) we shouldn't need to
> conditionalize the stream ID register writes.
>
> That said, the tegra_dev_iommu_get_stream_id() function returns a bool
> specifically to support the latter case. So the intention with the
> design was that drivers would call that function and only need to write
> the stream ID register if it returns true. That's not always great
> because you may want (or need) to rewrite the register after suspend/
> resume, in which case you probably want to resort to a cached value
> rather than call that API. On the other hand the API is quite simple, so
> it could serve as a cache as well.
>

I guess I could add an IS_ENABLED(CONFIG_IOMMU_API) check if
tegra_dev_iommu_get_stream_id() returns false in probe?

That would cover if the IOMMU_API is not enabled but not if the Tegra's
iommu is disabled in other ways.

-Parker


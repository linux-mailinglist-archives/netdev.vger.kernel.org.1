Return-Path: <netdev+bounces-228287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E50BC675E
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 21:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 672A64E4DA8
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 19:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCAF2459DD;
	Wed,  8 Oct 2025 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kq0B6iJA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8763623E35B
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759951342; cv=none; b=H911qfHo3OQhMRl05Oqdb81kt/QfriHFuH8ab4jfQA9ab02MDhO7/IExHJAGyuVgD+eGXbdlhEzGKEdvehkTEiPCKiuReZaaPW0qJ3EvDjrmltD4ND9FglHxA/uN2QUbiAotgbLlymC4fy1qM68JdMROQU1o5MJblKYsjepTUvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759951342; c=relaxed/simple;
	bh=p1FloL7u6sitnIwamS/IVFzvRYrDtxts6lZC0tFc+cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZdqPnvokSW2z2hqAZWzVgUkdswjDxmlwB2P5kL2c/jmVeCrx16PfhCrqgwgKTthTnP4yygPMF/yq3E9g/lc+tvo6PlqwAwnT/hWbzib6A21Mt5PA56lQ98DKxEtGughQatVN4K7rNP8JokD1U+y6KEnmfKJMAL2IvvGYXK7JgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kq0B6iJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3C9C4CEE7
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 19:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759951342;
	bh=p1FloL7u6sitnIwamS/IVFzvRYrDtxts6lZC0tFc+cs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kq0B6iJA6YXOKEhi7Xg6iqp8W9wOglKdHu6myHJdLcfhLEHPOtLPuwRDwwZGvffG1
	 7qK5mAQ1HHLd3HnUM22z1ZBhDXj+NJOxEeS+GgPYh77HMTDx/JbK3H89xq7xaOlT/5
	 Lh7tC2UD8+weqYVUqHftiJ/B0NlX1aKmrm00Xol+VEw5YMRouT+Yx2CkU/wLiyjxQP
	 USgz/tVfp0MhmLGk6j/+zK92GtJJVGsI5vsRXW83yK27wf+ZC0RW22kH+g/r2pJuoJ
	 0Fp/kOuH4B8BEtBKkMviDJ628dIcLDUkd1lgIr09DdP1Bzd2O/fDvVuxocji7a7AgW
	 E4EUZTCP3bd+A==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b4aed12cea3so24897066b.1
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 12:22:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCnd+JeM2ULOvE6+KMsA/L24508aXqFQyzNpG64bLAgeUn+2PYOYR26p22Xi4mWo/qvCpq5Wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAP9c6wzK/IBp1o47AqDDJxK/BuJWvRH7WM/YpQlIi2K468ZQd
	u2+BZzPFJRXFtbWZvd3QHqlwDEb8aOka7CtCRIyWQ/dHPrfPrDROLRVru8Hw87vvjEkSV3dsfbt
	jlf142NKgx7eoGpdR0pcCacgjrNVCkQ==
X-Google-Smtp-Source: AGHT+IFdFngGNxCZPPIQLNIfjr5zUkVQ8HeDdnCrjhFQ2p+SAA5LToy7AYRsDpPb5xEu412/9NqTwzHKyFIOThsSahI=
X-Received: by 2002:a17:906:d8c3:b0:b51:24e9:7ddc with SMTP id
 a640c23a62f3a-b5124e982d4mr280318966b.50.1759951340737; Wed, 08 Oct 2025
 12:22:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001183320.83221-1-ariel.dalessandro@collabora.com>
 <175943240204.235529.17735630695826458855.robh@kernel.org>
 <CABBYNZKSFCes1ag0oiEptKpifb=gqLt1LQ+mdvF8tYRj8uDDuQ@mail.gmail.com>
 <CAL_Jsq+Y6uuyiRo+UV-nz+TyjQzxx4H12auHHy6RdsLtThefhA@mail.gmail.com> <CABBYNZKxGNXS2m7_VAf1d_Ci3uW4xG2NamXZ0UVaHvKvHi07Jg@mail.gmail.com>
In-Reply-To: <CABBYNZKxGNXS2m7_VAf1d_Ci3uW4xG2NamXZ0UVaHvKvHi07Jg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 8 Oct 2025 14:22:09 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+aO8Fdq_7PHvh0aTb00qvGdKe2RDRotYcWjqGHppyL4g@mail.gmail.com>
X-Gm-Features: AS18NWCo7ZqN6wGn4m9B_o_gy6tmLf9kYyB6Mb5gzMeUUTNc9Hq9pXF9owcdPo0
Message-ID: <CAL_Jsq+aO8Fdq_7PHvh0aTb00qvGdKe2RDRotYcWjqGHppyL4g@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: net: Convert Marvell 8897/8997 bindings
 to DT schema
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>, andrew+netdev@lunn.ch, 
	conor+dt@kernel.org, kernel@collabora.com, krzk+dt@kernel.org, 
	angelogioacchino.delregno@collabora.com, kuba@kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 9:33=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Rob,
>
> On Fri, Oct 3, 2025 at 9:38=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
> >
> > On Thu, Oct 2, 2025 at 2:18=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > On Thu, Oct 2, 2025 at 3:14=E2=80=AFPM Rob Herring (Arm) <robh@kernel=
.org> wrote:
> > > >
> > > >
> > > > On Wed, 01 Oct 2025 15:33:20 -0300, Ariel D'Alessandro wrote:
> > > > > Convert the existing text-based DT bindings for Marvell 8897/8997
> > > > > (sd8897/sd8997) bluetooth devices controller to a DT schema.
> > > > >
> > > > > While here, bindings for "usb1286,204e" (USB interface) are dropp=
ed from
> > > > > the DT   schema definition as these are currently documented in f=
ile [0].
> > > > >
> > > > > [0] Documentation/devicetree/bindings/net/btusb.txt
> > > > >
> > > > > Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.co=
m>
> > > > > ---
> > > > >  .../net/bluetooth/marvell,sd8897-bt.yaml      | 79 +++++++++++++=
+++++
> > > > >  .../devicetree/bindings/net/btusb.txt         |  2 +-
> > > > >  .../bindings/net/marvell-bt-8xxx.txt          | 83 -------------=
------
> > > > >  3 files changed, 80 insertions(+), 84 deletions(-)
> > > > >  create mode 100644 Documentation/devicetree/bindings/net/bluetoo=
th/marvell,sd8897-bt.yaml
> > > > >  delete mode 100644 Documentation/devicetree/bindings/net/marvell=
-bt-8xxx.txt
> > > > >
> > > >
> > > > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > > >
> > > > You'll probably have to resend this after rc1.
> > >
> > > In that case I'd like to have a Fixes tag so I can remember to send i=
t
> > > as rc1 is tagged.
> >
> > A Fixes tag is not appropriate for a conversion to DT schema.
>
> Ok, but then how do you justify merging it for an RC?

I don't.

> Or I'm
> misunderstanding and that should just be merged to bluetooth-next and
> wait for the next merge window?

Yes, this is 6.19 material.

> In that case I can just merge it right
> away.

That's up to you.

Rob


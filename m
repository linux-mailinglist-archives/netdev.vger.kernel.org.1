Return-Path: <netdev+bounces-193534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BEFAC45AE
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 02:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1B117B15F
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 00:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DED5C96;
	Tue, 27 May 2025 00:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljrz1bIC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177E61862;
	Tue, 27 May 2025 00:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748304996; cv=none; b=BflS6ebncKju9xcPnhEoXlMBNraWOTjV8EuIApkNtjhOHlpMo5lpJ+eQ8VjOlMEcMGQS8OKJR90elRH2aLjPhqaJtXN2duR5ot0DH+MI6uv3H77XnIK29VzTBpvc7ysAq3DjV91krNWtV1GVl6fY5aY7N2DZ117qmT8/WpdnxI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748304996; c=relaxed/simple;
	bh=oIVrYMYQVGQ0H7rAxEnKQPj9zoT4OSei4WPqmdSh5G8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHDZf44OAq9muwMeMez6y08NT1sM8OPge9rADClKmS8OE6GLlBDuDWfZOvlA1rkPh28/wabKa7qdmGj6uuxU9YQOvT5u57oi7XvfFTvM9Zk1bndEsh7Rm7aqynQ1wyofVn7m95Z3BHg40JdXbitvI5+/WrTZJgfZuiPtEM0jYvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljrz1bIC; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4e59012c7eeso17009137.1;
        Mon, 26 May 2025 17:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748304994; x=1748909794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOcEbDk1qfiDcX5DWviKvVm3NUschFW/SlGs49rdunw=;
        b=ljrz1bIC1/LdOPFH9CEKVzO0vsvXySXkQ+n0hbLhNdxznsUsmxxqkC+fDln0jjWNh6
         S7Na1tzi77UV1LQIlnRbzFmKyjNfzACzqbIf3ozs+nglxVsVnY41f1FjlwwebY6rq+w6
         YEFXTIDnqAfmdoJXiw7hvjIG/ghNxAFl9CKL4RXgKB7VTQdjDQGmJg2WdMnGJNFZxgw6
         FyPc7gBSCd75vFuaURv/t+8eRfHRbqfSj+PjZB3XxT8T7QfQ/vs8P/jXqeBdYCjqEgkz
         3YOqRGcH8B4ydtJP4NzUJ5WReJcedVj0xmW0HUvmoc7lSWOaOM+oNMTLCuQMFmS5brfE
         Vc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748304994; x=1748909794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOcEbDk1qfiDcX5DWviKvVm3NUschFW/SlGs49rdunw=;
        b=mWXTfw4bLHguVUHKBod1Vov5NG+iAIVR5O+w1auxSKNoLXMdOXe/3dnDz3nntQR6my
         FTrmjCsvj13CQobgkW/xyf8TCWq6mrlv0tjOPV1mICOHMJxiRBAR9Xa3aJwmUhql4JwF
         q1TQGfwrH+8O3udHkbgQoxk58XK/MDKcw6WdQLL9TR14oMJL5NLmE2fEtGU+UwCz8R08
         4qF1mte0RPoWasQyPTVtds5qa9V1cC2P7afjzkdw8pZ8cFJMes9zftthuMrUNO34WBoz
         vTUxbWEvFKNX0AUa94HfEBm4dxT+XEyl8+LYQLKPJmGz1ZfQs6we7VcIaA6Qsm92XQEM
         LSeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2u7IhXbFQ4DFYtkmkv88+yInceDJNepN5xMosEnIjuDPDjC2kZ0SnvHgElaRSlDtuCD0YwZNW/HTr@vger.kernel.org, AJvYcCVdfp+ALR3CwJqkoDD2987GZMBbijR8PS/s3smbLBzRPJHCnlqaWKKoZdbCXoh/9rj7p40B0pHv9a/W33Xo@vger.kernel.org
X-Gm-Message-State: AOJu0YwxQeKjrd/t+TDBfzuj0jKECdIrJdN9ydD0LOjTNdwsFVeDuXrW
	OKpvXld+ebnLTb1oR9Cp9A5MmjwylOWSOQrPSpvYxh6lvwq1Lg35C6ZtOlBCNVUDWEOEVQFW36t
	r9imTqFpgVfg0ViJtaHepadwKjZYDdgk=
X-Gm-Gg: ASbGncs6M5Bnbea9QA6HzS4duL7cWz8BiWp912ZPaLkqNn1HEvOuuR2cDaYTOrYneFs
	soaqNreDjfNZQxd8vpZFCaN7e0zeEoFmkUTdPjpXXMojDfo1QEk3eWNXwzGqJp3lWKboc3Vd0Y/
	qulTd2q+I1kB4C6JYhlNZAJthLKrdEwvZAhw==
X-Google-Smtp-Source: AGHT+IHSdJELAoc1OfbG1X3kZVb5ldqSTuSeYhI72dMXIJ0HLefmckoLWqzNnulr7EDgBDJ6rEKu7PIcDwC6U64zr2w=
X-Received: by 2002:a05:6102:cd1:b0:4e2:91ce:8cad with SMTP id
 ada2fe7eead31-4e4241911f0mr9215317137.24.1748304993817; Mon, 26 May 2025
 17:16:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526182939.2593553-1-james.hilliard1@gmail.com>
 <20250526182939.2593553-3-james.hilliard1@gmail.com> <959e576e-bf36-4d01-9ffb-023931b61574@lunn.ch>
 <CADvTj4oqjCkMeK0p8ZBa8PQmctc77hpiFK2pqgBJaxRFDgQoDQ@mail.gmail.com>
 <d4109cc5-83d5-4acd-b0fb-39a50043060b@lunn.ch> <CADvTj4qdoD-mo7CxNW8VitZf+wXTiZ7m28R4JPQ9kQJGhUH7bA@mail.gmail.com>
 <d9d0881b-12cd-40af-bb22-d84236d2e04d@lunn.ch>
In-Reply-To: <d9d0881b-12cd-40af-bb22-d84236d2e04d@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 May 2025 18:16:22 -0600
X-Gm-Features: AX0GCFsNBL9BmJB3bZajN52hoBf0v04Bs4dxVYW5eiTI4xBSNVhcu5-DVu6exkM
Message-ID: <CADvTj4qZz5q7x3_+OB8FiSnkEehzzjikVcCaqdcwHDYesMzpWw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] dt-bindings: net: sun8i-emac: Add AC300 EMAC1
 nvmem phy selection
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 5:45=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, May 26, 2025 at 05:22:48PM -0600, James Hilliard wrote:
> > On Mon, May 26, 2025 at 4:38=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > On Mon, May 26, 2025 at 03:32:03PM -0600, James Hilliard wrote:
> > > > On Mon, May 26, 2025 at 1:36=E2=80=AFPM Andrew Lunn <andrew@lunn.ch=
> wrote:
> > > > >
> > > > > > +        phy-mode =3D "rgmii";
> > > > >
> > > > > Does the PCB have extra long clock lines?
> > > >
> > > > I'm not sure, it's a copackaged(maybe on-die is the wrong terminolo=
gy)
> > > > PHY I think so I assume the clock lines are internal, in the device=
 specific
> > > > dts we set something like this on the emac1 node:
> > > > allwinner,rx-delay-ps =3D <3100>;
> > > > allwinner,tx-delay-ps =3D <700>;
> > >
> > > Those values are just weird. The RGMII delay should be 2000ps. 3100 i=
s
> > > way too big, and 700 is way too small.
> >
> > I think these may not actually be required when using the internal
> > EPHY's now that I think about it again.
> >
> > > I think phy-mode =3D "internal" would be better, and just hard code t=
he
> > > delays either in the MAC or PHY driver.
> >
> > Hmm, would that make sense even though the MAC driver also
> > supports external PHY's?
>
> If an external PHY is being used, i would not expect a phy-mode of
> internal.

Ok, I guess this is a bit of a separate issue vs phy selection right?

> > > Thanks for the link to the old thread, which was 5 years
> > > ago. Hopefully since then, a bit more has been learnt. Quickly readin=
g
> > > through that thread, i don't think an MFD is not the correct solution=
.
> >
> > Well the current patches I've been playing around with for the AC200
> > phy are pretty similar to those patches still.
> >
> > Here's a branch that works on both AC200/AC300 but only if I do
> > the PHY initialization in u-boot:
> > https://github.com/jameshilliard/linux-h616/commits/acx00
>
> I personally don't like depending on the bootloader. I often replace
> the bootloader, because it is a crippled version that does not let me
> TFTP boot, does not have flash enabled for saving configuration, and i
> want to use barebox etc. I think it is much better when Linux drives
> the hardware, not the bootloader.

Yeah, I'm just using that for verifying the PHY selection logic at the
moment is functional and that Linux can handle the PHY's once in
an initialized state. The initialization sequence I'm using in u-boot
is pretty far from being suitable for upstream as well.

> > > In the last 5 years we have had to deal with more chicken/egg problem=
s
> > > with PHYs. It has now become pretty much standard practice to put the
> > > ID values in DT, to get the driver probed when the device does not
> > > respond on the bus.
> >
> > This is what I'm doing right? I mean I'm putting the phy ID in the
> > DT for both the AC200 and AC300. When doing the reset driver
> > for say the AC200 I would wire that up to only the AC200 phy
> > node and not the AC300 node(since the AC300 reset is MDIO
> > based while the AC200 is i2c based).
> >
> > > The DT node can then use phandles to the reset and
> > > clock controller to configure them as needed, the core will probably
> > > do that. I2C is a bit messier, you probably want a phandle pointing t=
o
> > > the i2c_adapter, so you can use i2c_transfer() on it in the probe()
> > > function.
> >
> > Without a MFD or some other node that exposes a reset I'm a bit
> > confused about what driver would actually issue the reset.
> >
> > Yeah, we need a phandle to the i2c_adapter, but since the resets
> > would be under the AC200 PHY node I assume there would need
> > to be some sort of intermediary driver implementing the i2c reset
> > right?
>
> You need an reset controller, yes, but is that an MFD? Or just a reset
> controller? Where does this reset controller live?

Well at least the AC200(the i2c one) appears to be a full MFD:
https://github.com/DeciHD/allwinner_docs/blob/main/mfd_xpowers/AC200_Datash=
eet_V1.1.pdf

The AC300 appears to only have EPHY related functionality:
https://github.com/DeciHD/allwinner_docs/blob/main/mfd_xpowers/AC300_User_M=
anual_V1.0.pdf

> Question like this show we are missing the big picture. What are all
> the different parts, how are they interconnected? Once we see that, we
> can give you better advice.

If you look at the block diagrams here it should hopefully give you
a better idea of how the AC200 and AC300 PHY's are connected
on the H616:
http://file.whycan.com/files/202304/V85x/Linux_EMAC_%e5%bc%80%e5%8f%91%e6%8=
c%87%e5%8d%97.pdf


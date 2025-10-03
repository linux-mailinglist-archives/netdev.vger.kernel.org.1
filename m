Return-Path: <netdev+bounces-227789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2118BB72F9
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 16:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6894019E6A87
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 14:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4F2347DD;
	Fri,  3 Oct 2025 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgtkU7tp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155B015E8B
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759501981; cv=none; b=S8+g0WzvKzSeBJ43dm8nQJZnv2c0YAvUwGXKbsK9scxuJkDFmf3568gSAUClfYIoqmnQsALT8SJJ+CLB1dV0dalnPbR5s0m9iXDuu525XVRgne38kHYCKtSxM8pFttp0WT64cf6FiMVRY5TR3ta2/8m1RfU98g06xNlAmkClOrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759501981; c=relaxed/simple;
	bh=ArI0GMic8uk/1kAkM79WN6gznjdosKe4PSqQZ8k9PK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXXACoBVGX7/2j63dvnlEB3X25tejJbWfoERfrVNnwR87/qLpOExx1l3X0RvIW26mbCmAonW0vV4o4utPNqAFAbQVvqWFcVmCCbvTAN8WCEIuwR3qhIXFgEZcwuKnnFFe2tfD1sssckkzBg8YMUhMwOsmVy7FFx4kTMysMnsA/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgtkU7tp; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-36a6a39752bso25289211fa.0
        for <netdev@vger.kernel.org>; Fri, 03 Oct 2025 07:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759501978; x=1760106778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mxBl+91XREs3rrt+Mm+HGe169ZpfgbUuMF9IKmnb3I=;
        b=fgtkU7tp8t9FJx+n6MdmpSaI96wKnMB946Ia6juEpMapqFaiDzBKU6Myu/l99TPONl
         X5NzYAznh9OzpsvyXuK+O8vHNGlTTUQ1WjUPFWSSi1o3O4pVptvRrU7M0ADp7xg313qo
         Go50Y9Q+75bf4JbHAzc72ujOQu5a5jJUpSrzrR3PA09KstyJbTEkjzZNOvf5fBxYqROX
         5v8IYWSutFofAk1ESXC42mRAIHRn3kXhGopqySi46gJwiXHBTy6/rvHRwNdFwxLx1PN+
         M4zyU0ka9hzeLELILZOgUcgvH3jnrvBJJn/8HxfwzfpX0Iloz7Z9St9zi8x8iRLHF+7d
         r6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759501978; x=1760106778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mxBl+91XREs3rrt+Mm+HGe169ZpfgbUuMF9IKmnb3I=;
        b=DYmDj33tRgzMHWnSohYPrIwzaf3yygjmew7bqtix98LXZKrZuZaBPxIcdj0jIoMsZ4
         s+7W4FflMNuu110+lSvR5QJTONkd1ZrPwYaochsVjXQbJXJBHScOTTaNQI5PaIATNxjy
         7ztoqW3C7kM/CtEmFjtfxrJshA2Kbwt5milKroO2mYWe2KI7Ld4NN8NM/Ynkv3zLMg7C
         hMr82v7du1FvgWiIEGpqYikMoV4D4GrteJSIDDkQm07ncPBA+immBPjlq7u+S5e7vwXa
         z5i24FxV9S0P4xgcwXvuhxhvhKwsi+CHEz0f1uucTrnkJs4qOXqyXGWOLGWZRhSyUHx1
         jELg==
X-Forwarded-Encrypted: i=1; AJvYcCW4NnTR5XvJ6fH7YHOUuR1q9PIInlR84N0y6iyCi2RimUw5wxskWjDkDqupaUhPWAy+cMRA6rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9p75GZvfMQVlFaqy1tZf2d86O3LkAsISeUoSFhVhIblbDKOCh
	T74hlGLtkzJlFoEDSBNJjhU1szW3oeF0mZeW0BzgPCdGEfxDL7zCl1lj5GgaFF/RNQVJoQ82/op
	0mV1L9tJHT/WVgrhpmcUBbX0kPE+KV5s=
X-Gm-Gg: ASbGncviRJCesn40tEb7xk7VCSstJevvmpkl/eTYcsOmf3JCeMpZ/o0Rl1h+/k1uUNb
	KE/oQSXgKIZ3UOwjU7/EiTpjjupZxQDxX1XYR0GopkPFfKiD8YOECD9KJNxqeFslSoHwNXBlcG5
	FIlrm6oUWm5IfRnlkF8+44gFwL50BxvfFFElSc2ReYUKjXlDV2WumTfsxf+QOVDY14HCw1e3Lv2
	T0SJDeJawL7+BAHGA2CWkc4nvLmVxQv7uSE9zvc
X-Google-Smtp-Source: AGHT+IHMEYf9LUvT+7M4GPywBvEmEbLwMBFLFIBedNHzqtzmaPYWYwMrkMOiqneX0J3Yyd6PeW5sBlD7r5kNWSSHALo=
X-Received: by 2002:a05:651c:a07:b0:372:950f:2aff with SMTP id
 38308e7fff4ca-374c37eb5d7mr10596021fa.27.1759501977328; Fri, 03 Oct 2025
 07:32:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001183320.83221-1-ariel.dalessandro@collabora.com>
 <175943240204.235529.17735630695826458855.robh@kernel.org>
 <CABBYNZKSFCes1ag0oiEptKpifb=gqLt1LQ+mdvF8tYRj8uDDuQ@mail.gmail.com> <CAL_Jsq+Y6uuyiRo+UV-nz+TyjQzxx4H12auHHy6RdsLtThefhA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+Y6uuyiRo+UV-nz+TyjQzxx4H12auHHy6RdsLtThefhA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 3 Oct 2025 10:32:44 -0400
X-Gm-Features: AS18NWAxN1IhfgHRDQEAVNRk-gv2qRra_zfz_DZsOprYcJI8wwK8KzxwPe_vG4Y
Message-ID: <CABBYNZKxGNXS2m7_VAf1d_Ci3uW4xG2NamXZ0UVaHvKvHi07Jg@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: net: Convert Marvell 8897/8997 bindings
 to DT schema
To: Rob Herring <robh@kernel.org>
Cc: "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>, andrew+netdev@lunn.ch, 
	conor+dt@kernel.org, kernel@collabora.com, krzk+dt@kernel.org, 
	angelogioacchino.delregno@collabora.com, kuba@kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Fri, Oct 3, 2025 at 9:38=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Oct 2, 2025 at 2:18=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi,
> >
> > On Thu, Oct 2, 2025 at 3:14=E2=80=AFPM Rob Herring (Arm) <robh@kernel.o=
rg> wrote:
> > >
> > >
> > > On Wed, 01 Oct 2025 15:33:20 -0300, Ariel D'Alessandro wrote:
> > > > Convert the existing text-based DT bindings for Marvell 8897/8997
> > > > (sd8897/sd8997) bluetooth devices controller to a DT schema.
> > > >
> > > > While here, bindings for "usb1286,204e" (USB interface) are dropped=
 from
> > > > the DT   schema definition as these are currently documented in fil=
e [0].
> > > >
> > > > [0] Documentation/devicetree/bindings/net/btusb.txt
> > > >
> > > > Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> > > > ---
> > > >  .../net/bluetooth/marvell,sd8897-bt.yaml      | 79 +++++++++++++++=
+++
> > > >  .../devicetree/bindings/net/btusb.txt         |  2 +-
> > > >  .../bindings/net/marvell-bt-8xxx.txt          | 83 ---------------=
----
> > > >  3 files changed, 80 insertions(+), 84 deletions(-)
> > > >  create mode 100644 Documentation/devicetree/bindings/net/bluetooth=
/marvell,sd8897-bt.yaml
> > > >  delete mode 100644 Documentation/devicetree/bindings/net/marvell-b=
t-8xxx.txt
> > > >
> > >
> > > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > >
> > > You'll probably have to resend this after rc1.
> >
> > In that case I'd like to have a Fixes tag so I can remember to send it
> > as rc1 is tagged.
>
> A Fixes tag is not appropriate for a conversion to DT schema.

Ok, but then how do you justify merging it for an RC? Or I'm
misunderstanding and that should just be merged to bluetooth-next and
wait for the next merge window? In that case I can just merge it right
away.

> Rob



--=20
Luiz Augusto von Dentz


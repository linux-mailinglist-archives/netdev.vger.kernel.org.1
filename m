Return-Path: <netdev+bounces-235937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F79C3750B
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 19:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 117B94E4D5F
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 18:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9AB287267;
	Wed,  5 Nov 2025 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="moYvwvA2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8233F280339
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 18:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367508; cv=none; b=Q+Pl8sXJpfisaQ8ftYcdOszTp1ygu+5aIDNlE2H9Cra41yh8SgSe2XIYjzjAAxw8SOb3tNLsc6xah4OuykN3G/xqJ31SisY+ws0p4YgQChgCA3c8xDMtat86FTvJbZ1Ma8Sx1YIqIUMXabEJZMndeAiYkqmjQZfLoiPl3ukNHeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367508; c=relaxed/simple;
	bh=cSUvPFHauqZYS/CgsZ8XBajx3T1TWYSiO6rHtLaKjfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFS9bnep10r4h0DD+ZNKi3etRxoJwkJuB9d9O5iIqJSXnxCSNiIqabbeshDhcqb4ZWF1peZSM9Yi4vTpVPF+I2JKCc9fL3zHNTuw2awbZLasjBzVL0UeHFtgRbwxC7Em0pTW6ph/uLOd1//eeQbYnwuhSOOqAG7NskK29lIFVYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=moYvwvA2; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63d0692136bso195808d50.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 10:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762367505; x=1762972305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlbREYCC7hZZFYU/7VKZMqA+QAfKisdyFnGiY5+x3Ac=;
        b=moYvwvA27zXvENPapH0CaBNoJCOO2eyxO4MW9MSUXnxSYepCGfx5rRQ6FgVuG/lt2X
         45x4G+Ctsj8Hd0Sg2DAqgO2m2eBINFzXrXkUfARBiR+MH1y1hthM4QYAJ+EERt2F+Z0g
         wX/5Ev8R59JN71QtkO808CVEmEcRE+s7rVj237LHFL/lap/bLtD7Rgqgq7H/cNKNYQiR
         rOKj0LOmWWseMg8CnEPFyxf4Q3cGbn1yxP7CEYni0kG0XWZbLLRwzHOxcenHcWPP/ry5
         54ewXiBejpDc5AbWydwntAfQzC8b489rHVa2OhSvIoaJ4jI9xRCOGosICz6iRgRsD7+U
         XY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762367505; x=1762972305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlbREYCC7hZZFYU/7VKZMqA+QAfKisdyFnGiY5+x3Ac=;
        b=iaYAKo+mU35I4Y4zbxvxtE2URegAAa9hY5bHf655tNcVxh8qNbl6vYln5xJa75t/PT
         EcTStRk5h8DaH0N/0abPxk8c8ofp8eztoJIVtXu5vql+awb6IyVRbOZj+DHMKvsEOTL4
         wQQuohVQ1AO6Rzi6cvrEV8yQCeTw29iiOGpkMfGzx00YHnZqmrM9GEN5wo6rvqObMZ65
         rFho8PNyXsjZ9/hK66oLSa4g0AEiTW6Q5FdDwQV3OCQwqk56G/9Wrj9pVUw5VXf9olbC
         VtKPCpWy03fA6Ybkxffqk5bXbFrJfB8TouAhn5jDeEsfRWfDN5lWAbGc1cwMcJjOTYdK
         HXnA==
X-Forwarded-Encrypted: i=1; AJvYcCXIM9GEOgASO/gvZhz1RFwxofrd6uC+uu+9UxHz15rfr5p6R0QR++G+09U1Se0GDzmuFkVZ9wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzanrqBOGZjPl/sRNmPnnOVXifESHbu5TkIrQF5I9LB+IiWC+vU
	QkJMMARVFxaxxWRPaT3TEM0D1l4DaYgLwzUkJCFl4/zJMDlP8xuMghDn8G3undOmDvOcVE9EreQ
	Z5sjh2WZDD2uYTwgKuj91f6mpWEu1hac63PTmqQhm
X-Gm-Gg: ASbGnctJtSLh083CpSUPHuxAgyAd4FPdPZo4IqTA/pffX+FFQX/RdetrEKuq7iuUzXK
	TZC+ucE8JbkCCM7gEo2trvXFMrbA+VtgdXdSo6n09yPq7JnVCmIQaZwC7PaKb4SlsEN8+qqrqdp
	xyUm+8w2uzvBDllHqQtMNVE+WNpf8QKehs1crr8ucybxmjq3zcp+GarBGjsb+eAT0xH4hLWnnuX
	qpk3012iDPaFDmsDj7YDG1Y2Y1Z0SjxxDzpg3T7MgY8hDXwncPOSjHyd1tmihnqsjCfsFU/yyRc
	hU+e1eqI9+qmJGEj3CD90YXb7di9SYqzuiY3
X-Google-Smtp-Source: AGHT+IEOY8cyE6iEXUXwkiFxfgFzq5OVSEUXJFxiV5kaSFWjZNeby5wEMszhmBL8q+8wcQrvfgB84R8XK2eZFBODVvM=
X-Received: by 2002:a53:c05a:0:10b0:636:d4ab:a507 with SMTP id
 956f58d0204a3-63fd34ccd13mr3319244d50.16.1762367505139; Wed, 05 Nov 2025
 10:31:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022182301.1005777-1-joshwash@google.com> <20251022182301.1005777-3-joshwash@google.com>
 <20251023171445.2d470bb3@kernel.org> <CAJcM6BFTb+ASBwO+5sMfLZyyO4+MhWKp3AweXMJrgis9P7ygag@mail.gmail.com>
In-Reply-To: <CAJcM6BFTb+ASBwO+5sMfLZyyO4+MhWKp3AweXMJrgis9P7ygag@mail.gmail.com>
From: Ankit Garg <nktgrg@google.com>
Date: Wed, 5 Nov 2025 10:31:32 -0800
X-Gm-Features: AWmQ_bkub-0DPZQYHW6NWgclx5Hi6PlhiC9qH2yVCOKIyjJd37QVjH-PxzZDmqc
Message-ID: <CAJcM6BE7qg464oLOJZtVEdYjaki422fxvUWFsA_=CjOAJeqZ_g@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] gve: Allow ethtool to configure rx_buf_len
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joshua Washington <joshwash@google.com>, netdev@vger.kernel.org, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Jordan Rhee <jordanrhee@google.com>, 
	Willem de Bruijn <willemb@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 11:17=E2=80=AFAM Ankit Garg <nktgrg@google.com> wro=
te:
>
> On Thu, Oct 23, 2025 at 5:14=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Wed, 22 Oct 2025 11:22:24 -0700 Joshua Washington wrote:
> > > +     if (priv->rx_cfg.packet_buffer_size !=3D SZ_2K) {
> > > +             netdev_warn(dev,
> > > +                         "XDP is not supported for Rx buf len %d. Se=
t Rx buf len to %d before using XDP.\n",
> > > +                         priv->rx_cfg.packet_buffer_size, SZ_2K);
> > > +             return -EOPNOTSUPP;
> > > +     }
> >
> > Please plumb extack thru to here. It's inside struct netdev_bpf
> >
>
> Using extack just for this log will make it inconsistent with other
> logs in this method. Would it be okay if I send a fast follow patch to
> use exstack in this method and others?
>
> > >       max_xdp_mtu =3D priv->rx_cfg.packet_buffer_size - sizeof(struct=
 ethhdr);
> > >       if (priv->queue_format =3D=3D GVE_GQI_QPL_FORMAT)
> > >               max_xdp_mtu -=3D GVE_RX_PAD;
> > > @@ -2050,6 +2057,44 @@ bool gve_header_split_supported(const struct g=
ve_priv *priv)
> > >               priv->queue_format =3D=3D GVE_DQO_RDA_FORMAT && !priv->=
xdp_prog;
> > >  }
> > >
> > > +int gve_set_rx_buf_len_config(struct gve_priv *priv, u32 rx_buf_len,
> > > +                           struct netlink_ext_ack *extack,
> > > +                           struct gve_rx_alloc_rings_cfg *rx_alloc_c=
fg)
> > > +{
> > > +     u32 old_rx_buf_len =3D rx_alloc_cfg->packet_buffer_size;
> > > +
> > > +     if (rx_buf_len =3D=3D old_rx_buf_len)
> > > +             return 0;
> > > +
> > > +     if (!gve_is_dqo(priv)) {
> > > +             NL_SET_ERR_MSG_MOD(extack,
> > > +                                "Modifying Rx buf len is only suppor=
ted with DQO format");
> > > +             return -EOPNOTSUPP;
> > > +     }
> > > +
> > > +     if (priv->xdp_prog && rx_buf_len !=3D SZ_2K) {
> > > +             NL_SET_ERR_MSG_MOD(extack,
> > > +                                "Rx buf len can only be 2048 when XD=
P is on");
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     if (rx_buf_len > priv->max_rx_buffer_size) {
> >
> > This check looks kinda pointless given the check right below against
> > the exact sizes?
> >
>
> My intent was to code defensively against device accidently advertising
> anything in [2k+1,4k) as max buffer size. I will remove this check.
>

After taking another look, an additional check is still needed to
handle scenario when device doesn't advertise support for 4k buffers.
I reworked this check (and added a comment) in v2 which hopefully
conveys the intent better.


> > > +             NL_SET_ERR_MSG_FMT_MOD(extack,
> > > +                                    "Rx buf len exceeds the max supp=
orted value of %u",
> > > +                                    priv->max_rx_buffer_size);
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     if (rx_buf_len !=3D SZ_2K && rx_buf_len !=3D SZ_4K) {
> > > +             NL_SET_ERR_MSG_MOD(extack,
> > > +                                "Rx buf len can only be 2048 or 4096=
");
> > > +             return -EINVAL;
> > > +     }
> > > +     rx_alloc_cfg->packet_buffer_size =3D rx_buf_len;
> > > +
> > > +     return 0;
> > > +}


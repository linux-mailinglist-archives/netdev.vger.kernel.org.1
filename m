Return-Path: <netdev+bounces-124047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 333D6967689
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 15:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86B41F214AA
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 13:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C90016DC33;
	Sun,  1 Sep 2024 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioTpWbir"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC8737708;
	Sun,  1 Sep 2024 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725195740; cv=none; b=FbnVTSBYiSYWBZhm7qrSJ+b3iC8f/BwMw3cHyOkMbfwBCPuJmSyW6b7vSN43E2KD/1is205jEXbOKLJfWc/rX6wIshuP4BHUvJBe0IkpfMtpPpSia/sHykVVudNGLedDeyEA1qUs99p7fZS5H4q3qCDgT19XRB4N58rz2LFbx1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725195740; c=relaxed/simple;
	bh=PNbxf1rSKAY00qxhZoff33fom4ubLfYBHRBjUBuV2vQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aIcEsuEwGSpmbxLErkhJjmIoi0TrUMJYlIOuAISxCctrxZ5xiYUTeBZZ28XcaOz3mglcI+WHF353k+HB2F/PSMrtu8/8y4HikrTWsz9wAfiWahtyQxVRzSQMhGTI3cLMWJKip0mJCxEb/1MXEs+sQf5M1BLb0p/srGsB3hMu7OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioTpWbir; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-6c91f9fb0d7so32187317b3.3;
        Sun, 01 Sep 2024 06:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725195737; x=1725800537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HH2pWOg+P80bkafsVqTkVXDmM8KTsEkn3/rXfjJU4I=;
        b=ioTpWbirVx9OCFH5Qzp5nVbw1Fa8lbC7Fxn1xgy5zWNvJstJlIrP9qFMB2fhRHDnEl
         RANlVlaPGlPXOTbpcOpQwIGxKlAC6R22jMjzniDXoiug0dcHxQ4iH7pD6zt+Q9DnV+fl
         a+H3qBuuVv+Q4cPTJi3KszqrZtEwOQNkUeo7JuluUfAnvWWlg10uUy/fATgV6dCIX34v
         WnuRvX8cnn1NIdkWeFI+4xQR51FRqa2hQgvLLMt4QrWgLTSYQVgSQZ61ADpqJL3MeQq7
         UkVjS34p8/H9qpVBrsWXVp8SvWc3BWAbba29e+9BJxoK97/6YrOgGMufogEemVzRUUaC
         dMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725195737; x=1725800537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HH2pWOg+P80bkafsVqTkVXDmM8KTsEkn3/rXfjJU4I=;
        b=aH0HslFHAblDCK4Ol+h9kGmH0ozn1C/oOnBIhSwQ2VyCylWKJvCV6i+gDx9yhWGRTQ
         CbYIFMx6GghqX8I+fS4y74UNVYDAYJ9wIk+g2zkmneKeEGFYaxhSzsqZbQhJVe5z/6bN
         R3wGVukg9XgsRWSqjGs09KOSh/hf8Cka6HNHz6SHracM3TlI5920rMsMEWH0cxyUPbGM
         70mzXk7x6M41r9E/D/gMcaJiUIiMXYy7SQIRbR4eIXtTV3ae3AifS3RviBWroQYHD7td
         0IrRUh1Mitnrq8aMeL/GH4igEzvWrfSB6Pie1ALAkX28ga+0VX3+ysOvH0JtdPe5cBKM
         ZMIw==
X-Forwarded-Encrypted: i=1; AJvYcCX42WTzoiMyX8TP4Nw9JKZy/6pr9q3sRTpB1eJb5Q3QDA4sW9je06nPco4iNgYCbHNQK1nsJFK8nJMZWlA=@vger.kernel.org, AJvYcCXMmz0UVOCHHOf6BPNe3ytUVZaOIaeb+F6C2K5fw7kMl8LJY4dGs6wtvvUezvTGVIQy8wDF48Kn@vger.kernel.org
X-Gm-Message-State: AOJu0YzV/QQgwRryAEnfLy4bsXUGvhQtpS7cZ3wuJ9in0AvUpZW+qtbm
	9XSBE/CLWg5Fdi+8PTYquHoJXIAOmZEC/ta/9KVXgpXqn+DH44NU32sPOleycQMWzZCwW5xxyVn
	piU+5V80R5uw1y3CcgsTCYiS13+w=
X-Google-Smtp-Source: AGHT+IEpyCkUCfGzf5U1kDr0lEO0j66kgZTOfcK8v2Nc+j9a1GDf2EYIDabousK2jjD1SDPIW46r4vxFHYI3y6izqa4=
X-Received: by 2002:a05:690c:6d8b:b0:675:a51b:fafd with SMTP id
 00721157ae682-6d40f535fffmr90737907b3.31.1725195736704; Sun, 01 Sep 2024
 06:02:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
 <20240830020001.79377-8-dongml2@chinatelecom.cn> <c5896f81-5c32-43f0-8641-81fdb4710a4b@intel.com>
In-Reply-To: <c5896f81-5c32-43f0-8641-81fdb4710a4b@intel.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sun, 1 Sep 2024 21:02:17 +0800
Message-ID: <CADxym3YkROBgjbd0-h6nk2nxKkzofjCdJ6k9PLE86BQzKoxKUA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 07/12] net: vxlan: add skb drop reasons to vxlan_rcv()
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: idosch@nvidia.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, 
	dongml2@chinatelecom.cn, amcohen@nvidia.com, gnault@redhat.com, 
	bpoirier@nvidia.com, b.galvani@gmail.com, razor@blackwall.org, 
	petrm@nvidia.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 11:04=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Menglong Dong <menglong8.dong@gmail.com>
> Date: Fri, 30 Aug 2024 09:59:56 +0800
>
> > Introduce skb drop reasons to the function vxlan_rcv(). Following new
> > vxlan drop reasons are added:
> >
> >   VXLAN_DROP_INVALID_HDR
> >   VXLAN_DROP_VNI_NOT_FOUND
> >
> > And Following core skb drop reason is added:
>
> "the following", lowercase + "the".
>

Okay!

> >
> >   SKB_DROP_REASON_IP_TUNNEL_ECN
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
>
> [...]
>
> > @@ -23,6 +25,14 @@ enum vxlan_drop_reason {
> >        * one pointing to a nexthop
> >        */
> >       VXLAN_DROP_ENTRY_EXISTS,
> > +     /**
> > +      * @VXLAN_DROP_INVALID_HDR: the vxlan header is invalid, such as:
>
> Same as before, "VXLAN" in uppercase I'd say.
>
> > +      * 1) the reserved fields are not zero
> > +      * 2) the "I" flag is not set
> > +      */
> > +     VXLAN_DROP_INVALID_HDR,
> > +     /** @VXLAN_DROP_VNI_NOT_FOUND: no vxlan device found for the vni =
*/
>
> ^
>
> > +     VXLAN_DROP_VNI_NOT_FOUND,
> >  };
>
> [...]
>
> >       if (!raw_proto) {
> > -             if (!vxlan_set_mac(vxlan, vs, skb, vni))
> > +             reason =3D vxlan_set_mac(vxlan, vs, skb, vni);
> > +             if (reason)
> >                       goto drop;
>
> This piece must go in the previous patch, see my comment there.
>

Yeah, I'll do it.

> [...]
>
> > @@ -1814,8 +1830,9 @@ static int vxlan_rcv(struct sock *sk, struct sk_b=
uff *skb)
> >       return 0;
> >
> >  drop:
> > +     reason =3D reason ?: SKB_DROP_REASON_NOT_SPECIFIED;
>
> Is this possible that @reason will be 0 (NOT_DROPPED_YET) here? At the
> beginning of the function, it's not initialized, then each error path
> sets it to a specific value. In most paths, you check for it being !=3D 0
> as a sign of error, so I doubt it can be 0 here.
>

It can be 0 here, as we don't set a reason for every "goto drop"
path. For example, in the line:

    if (!vs)
        goto drop;

we don't set a reason, and the "reason" is 0 when we "goto drop",
as I don't think that it is worth introducing a reason here.

Thanks!
Menglong Dong

> >       /* Consume bad packet */
> > -     kfree_skb(skb);
> > +     kfree_skb_reason(skb, reason);
> >       return 0;
> >  }
>
> Thanks,
> Olek


Return-Path: <netdev+bounces-124044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898C9967678
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 14:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3841C2134E
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 12:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D6317CA09;
	Sun,  1 Sep 2024 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrMVLzaK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE09D17C9E7;
	Sun,  1 Sep 2024 12:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725194849; cv=none; b=JuppHGjsv+uITmlkfu2tbQLuN0htivlOOVx3FuO1j3tNeRWU89jak8zfaMjlgLvnxBaxWpHcjoftBpKgvUU/51WRlaMsTGgbz3HKXubdxG0WbJ5abp1ZIpmRFez0WowvI2PDIwMEaNfwjSvv6n+RdaNYrtOaLFMqTSObOqKV5bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725194849; c=relaxed/simple;
	bh=nPGiBCSvIoiWIanYCrheWYVIfLnNxinUYWAcmqkIz88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLwH64bBnogZhyp11F4jrCfnjsxG4D8Rn50wg3kwwpZXGcAppruFeJ/71/+zkf6ABdcTRBFpDXNtOh6+axksdDjFxiqt8K2OCfpMTVH0Iw0z5t3dzjj2h96kEd6fdqQ/uE1d64MXLN4dXiMOXc7Llz4EJTXdpz91jzJkbhKRsRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrMVLzaK; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e116d2f5f7fso3302851276.1;
        Sun, 01 Sep 2024 05:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725194847; x=1725799647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHmm78AxfkjScifpOWWCL/6fatIT1hXdExxsyd3u11Q=;
        b=jrMVLzaKbN8qjlt9305CulNUyAsL8CytSZ3c2rGaz2pDkFeOePnHhqr3ILvcX/6/46
         LMoWewMjKLebbYNJt+gtfw6o0/6sriQbs0LUAjSMiWJUOhqJBbJDiPx9Ebp7nReRgelI
         57reCjbbGUFMkc4iImHS3iAYRv24fawcd57RaV0cjEQDou/QNZJhtR3Mbxd5IW4OXMAo
         TOLk4eNS7OykpOC2ZYNy2LluVrLieaElmWwJj6r8HR/GChG33ditmJ4FITzu3AwDHsU0
         5jy5AnuiRA06q+mQqGhUQkN9bfZZf+UejDCV+jX+OfaPrvgLTetqegCyTS1MWo3a3Xt2
         4MOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725194847; x=1725799647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHmm78AxfkjScifpOWWCL/6fatIT1hXdExxsyd3u11Q=;
        b=NUbn9PHw/k/GMy4zUeHMyEK2at5K8vjHI0Mldgca3XBbOvpGu6iBYwtqVagvgiijvs
         92ORi7pO5LeVYUxKIO/EFQcNpNFA8tiXqfufY97+eYnKxin0fQq2tQs0Q5ycTXOAqeJS
         T++zHok4r7bNy48ZJAdnxINrARrOrPbKxFgK7qSpJbSQzaWQsryo6iI9lwzs9bOBbPr9
         18JCQsxukjZqm3gdxpw0AhOypPj9ge3f8OI6mXgUsewbRRQFwviZUXcuUbTCP4S8GDXl
         h4e48fnLtKm+RF0hNjjlMPXY4iFIiJXGR5VEI+s+HCaqCzj/8NoaeuuYx+YzE0sK4uf9
         e97w==
X-Forwarded-Encrypted: i=1; AJvYcCV11O4EyW8U39zVDl2fJnX8Uns14tWZSQl53nwFksBVFoaFdk7uNiYYTr5jFaxQ4fqepkM9BxEk@vger.kernel.org, AJvYcCVG5QdfYMZd3JAfdC3b15Qm1ar7J9AqwXINz7cvcwO0mHAOaQH6PkEV0FAMFfKqj0ZCUJCmp7Urw1P3sEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDWaa7kns23U+V80oQahyip01m2KhecC1I0RPguvmR+dKDFwFD
	1zLmrDWSdpGUG8llZrcesUBHV3g6KLBAq8Is0xklukP5uk+iSdcN32k3qdqIBl9d6H4Fh3zx1G+
	6zf4vJof8S7M69RXltMXt0nUo4QQ=
X-Google-Smtp-Source: AGHT+IHjmEcFFUq4ZxQo2tsoaaIHNGbE1+hQvw1ooNKHA7RbciTsOi9FdgRNAL5CqxJcJl+jLPXbdoVjE//jlpmUKkU=
X-Received: by 2002:a25:dd06:0:b0:e1a:824f:1217 with SMTP id
 3f1490d57ef6-e1a824f12c6mr4452118276.18.1725194846788; Sun, 01 Sep 2024
 05:47:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
 <20240830020001.79377-7-dongml2@chinatelecom.cn> <20240830162627.4ba37aa3@kernel.org>
In-Reply-To: <20240830162627.4ba37aa3@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sun, 1 Sep 2024 20:47:27 +0800
Message-ID: <CADxym3bkVFApps1wJpSQME=WcN_Xy1_biL94TZyhQucBHaRc5w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 06/12] net: vxlan: make vxlan_set_mac() return
 drop reasons
To: Jakub Kicinski <kuba@kernel.org>
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, dsahern@kernel.org, dongml2@chinatelecom.cn, 
	amcohen@nvidia.com, gnault@redhat.com, bpoirier@nvidia.com, 
	b.galvani@gmail.com, razor@blackwall.org, petrm@nvidia.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 7:26=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 30 Aug 2024 09:59:55 +0800 Menglong Dong wrote:
> > -static bool vxlan_set_mac(struct vxlan_dev *vxlan,
> > -                       struct vxlan_sock *vs,
> > -                       struct sk_buff *skb, __be32 vni)
> > +static enum skb_drop_reason vxlan_set_mac(struct vxlan_dev *vxlan,
> > +                                       struct vxlan_sock *vs,
> > +                                       struct sk_buff *skb, __be32 vni=
)
> >  {
> >       union vxlan_addr saddr;
> >       u32 ifindex =3D skb->dev->ifindex;
> > @@ -1620,7 +1620,7 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan=
,
> >
> >       /* Ignore packet loops (and multicast echo) */
> >       if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr=
))
> > -             return false;
> > +             return (u32)VXLAN_DROP_INVALID_SMAC;
>
> It's the MAC address of the local interface, not just invalid...
>

Yeah, my mistake. It seems that we need to add a
VXLAN_DROP_LOOP_SMAC here? I'm not sure if it is worth here,
or can we reuse VXLAN_DROP_INVALID_SMAC here too?

> >       /* Get address from the outer IP header */
> >       if (vxlan_get_sk_family(vs) =3D=3D AF_INET) {
> > @@ -1635,9 +1635,9 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan=
,
> >
> >       if ((vxlan->cfg.flags & VXLAN_F_LEARN) &&
> >           vxlan_snoop(skb->dev, &saddr, eth_hdr(skb)->h_source, ifindex=
, vni))
> > -             return false;
> > +             return (u32)VXLAN_DROP_ENTRY_EXISTS;
>
> ... because it's vxlan_snoop() that checks:
>
>         if (!is_valid_ether_addr(src_mac))

It seems that we need to make vxlan_snoop() return skb drop reasons
too, and we need to add a new patch, which makes this series too many
patches. Any  advice?

I'll see if I can combine some of them into one.

Thanks!
Menglong Dong

> --
> pw-bot: cr


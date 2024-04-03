Return-Path: <netdev+bounces-84525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9E9897285
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 16:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD197283A1A
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082F11494B7;
	Wed,  3 Apr 2024 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L4Icyhi0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE36148844
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154361; cv=none; b=VOWcwPCfxj5rKd3y0YN61AZ09jmANWTGvh8915BzZSl+XGrwncLzl8zGja64M/HpXsKdfQ+dNb+hNgptPbCELHj5iSWXBzq5pxsdWrQz0FjZrn+JxSvkx+/wFUccKDtYNGZMPROTUcKJCeU9sPVU3rF4WajZvDbuzQlKyMpFKts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154361; c=relaxed/simple;
	bh=IX4LUdR04Syan1a4s9sO9BqeSC6JPvLmXrElg/Dm7dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmjDWTgvPscZj1Bx+q0mcDPDZ/g7ftQFz4sh2UOcfpsqTtowuPzeAg62lgivg+J7sWRiXnyzK91Z/JoZlWfVWMYOTHcBCl2MaWyn7btbfVoTBjW/+or7NXFW6r9TYtVm/6mCzqPggjrPCiSRAL1q2QUuR56HiCttkF0JL/YgwvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L4Icyhi0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4156ae9db55so75875e9.1
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 07:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712154358; x=1712759158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mc9dM74+iN+1v+oRiYRxH2284jI2phdiivENSUtW8rs=;
        b=L4Icyhi0/bRzrMONe3fNcl+tWSSY4k2HHMDB7JJIuVBGgjoTh+hxufhuzvxdne04jp
         GVRzzg1cb2ZIiPnpMdEI/VgAid2OiyV8uynRfzXE5jhFWI47hbXq8PW/c/NR65URMoKu
         U8DW/tGdK08ixra5XotFUBPdEQhkjakKcJO985pY9rmU+/T39gGNcT8TmwL0HVvp5Sq6
         dhZSN3O9EOj5TVDEFjZ/q7UzDYTbAQsM8x5ALJPHgX5hHQ3NxObHfgj3HD5C0iN9Z5Mj
         BP9aBswHx0uoXBuVRO+qA7ae2rbnvsPwNhJQ6o7Rd0eAI+BGYTxAL+8E/ugGuT7BjXp4
         klxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712154358; x=1712759158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mc9dM74+iN+1v+oRiYRxH2284jI2phdiivENSUtW8rs=;
        b=dDCmkvILIJrjZuU9e7VOR3zksvBacEAw+tOTYI8+TMZQyP48Z6Ly4FTQLEV1JgI6D5
         Lb9VGA62NupRUiTuMSYgYpwhjgSu3A+H5Y7TEr4l/7UlVXScXioFHL+VAl9xrLN5u3Tk
         oGPK2sQ88C/QhZH+633emE978W+Q93cj+1i1aK4duh0/vLU+cFNJ5Qj+pIAsplmEI3Xw
         NOVTr5ZY0DFMvAK4ii5XvjgB/X5GWRDTudsm+aVQYCW7ttmKQaIUET4KCwwlDYxfRo6W
         J/TH3PlyCVFqYgXiiZrBU+d6nT3oxstn/TlZfNZ7p4/d6KEWyerMejvQOFYg6CORglzV
         K45Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrSOjMB6Q+cid4R0pG+FPvjSuuygk4vH2pT7u7xs5ozHRUsig9xTPKrHkyBa85VAqhLcWNgJHeDCxvFjynpetvPIU824Ao
X-Gm-Message-State: AOJu0YxIOfwW53xwZ4TdjA9QpnotnchZQanQU5Htw0o+jwXOzf4AvGmd
	PKUGh2Ys2euQpOnmeU+1PQrwKyE0qYb8qun+Xwi8R23QxnA+d2OWHfCNmxCMuEDd2VPFe2BeMsQ
	99H5+KxzmyFWYX59YypumiS/Afa/0T3qCl0x8
X-Google-Smtp-Source: AGHT+IF+K7tfKH/9aTONyxeMerby2FWM6DmOA6HpVdeLExX7Snb9PXKfQermY5hNfORSOyHz59TbiOlSxvG3i0UOViI=
X-Received: by 2002:a05:600c:3ca8:b0:415:4436:2a12 with SMTP id
 bg40-20020a05600c3ca800b0041544362a12mr170412wmb.3.1712154358216; Wed, 03 Apr
 2024 07:25:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403113853.3877116-1-edumazet@google.com> <Zg1l9L2BNoZWZDZG@hog>
In-Reply-To: <Zg1l9L2BNoZWZDZG@hog>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Apr 2024 16:25:47 +0200
Message-ID: <CANn89iL72ia+aCaRxPvBBaOcbKU_VTLZSPBjiUAQ14dhpSJrfw@mail.gmail.com>
Subject: Re: [PATCH net] geneve: fix header validation in geneve[6]_xmit_skb
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+9ee20ec1de7b3168db09@syzkaller.appspotmail.com, 
	Phillip Potter <phil@philpotter.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 4:21=E2=80=AFPM Sabrina Dubroca <sd@queasysnail.net>=
 wrote:
>
> 2024-04-03, 11:38:53 +0000, Eric Dumazet wrote:
> > syzbot is able to trigger an uninit-value in geneve_xmit() [1]
> >
> > Problem : While most ip tunnel helpers (like ip_tunnel_get_dsfield())
> > uses skb_protocol(skb, true), pskb_inet_may_pull() is only using
> > skb->protocol.
> >
> > If anything else than ETH_P_IPV6 or ETH_P_IP is found in skb->protocol,
> > pskb_inet_may_pull() does nothing at all.
> >
> > If a vlan tag was provided by the caller (af_packet in the syzbot case)=
,
> > the network header might not point to the correct location, and skb
> > linear part could be smaller than expected.
> >
> > Add skb_vlan_inet_prepare() to perform a complete validation and pull.
> > If no IPv4/IPv6 header is found, it returns 0.
>
> And then geneve_xmit_skb/geneve6_xmit_skb drops the packet, which
> breaks ARP over a geneve tunnel, and other valid things like macsec.

geneve_xmit_skb() uses ip_hdr() blindly.

How can we cope properly with this mess ?

>
> > diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
> > index 5cd64bb2104df389250fb3c518ba00a3826c53f7..41537d5dce52412e15d7871=
ec604546582b10098 100644
> > --- a/include/net/ip_tunnels.h
> > +++ b/include/net/ip_tunnels.h
> > @@ -361,6 +361,37 @@ static inline bool pskb_inet_may_pull(struct sk_bu=
ff *skb)
> >       return pskb_network_may_pull(skb, nhlen);
> >  }
> >
> > +/* Strict version of pskb_inet_may_pull().
> > + * Once vlan headers are skipped, only accept
> > + * ETH_P_IPV6 and ETH_P_IP.
> > + */
> > +static inline __be16 skb_vlan_inet_prepare(struct sk_buff *skb)
> > +{
> > +     int nhlen, maclen;
> > +     __be16 type;
>
> Should that be:
>
>     type =3D skb->protocol
>
> ?
>
> Otherwise it's used uninitialized here:
>
> > +
> > +     type =3D __vlan_get_protocol(skb, type, &maclen);

Arg, a last minute change did not make it.

>
> --
> Sabrina
>


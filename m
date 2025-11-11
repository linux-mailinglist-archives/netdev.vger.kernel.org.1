Return-Path: <netdev+bounces-237538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D87C4CF71
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF0534F92A3
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7647A33B6D1;
	Tue, 11 Nov 2025 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dR5JJLwf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C545433A026
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855622; cv=none; b=VsKWkY5XpMbt6i6DM7ffx0sXwwUg1gEjXuWfoVX/AE0M+mF5qo3KJhXCj6qTJnXBlXKg/jZXx7/YB82S2nuH2gmJVL/VIQtdZ/MBpwRSV9QGhoLHs7UxH5bJw+QTqNDw3qLAVOn/oz1u+igvMdn8a90D/mmIUQaBN+jqzDSQG94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855622; c=relaxed/simple;
	bh=D9DSXHRVJFLfhBvf9Xi+1f1QYXFfOuwhDhDl0ec9+ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UYLsVUgjuMNpLiJNOSwElTY/5Whh/jbEQsBmv3WsLJvHTa497jznRL6F02lvn1z6XeFw+C0BYioypBLXORnuXSW05giMTSAiH9RGMqzHfpQItruMqOcNgHAnx8ezRWmkA70NSX8+JlrcobBqUyWJurC3IGHGwSCp5y821sQlgiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dR5JJLwf; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7869deffb47so38795207b3.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 02:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762855620; x=1763460420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmIn+rr47OIki868fF0YXvVBbJdq9zqT2ApwBKYAGgw=;
        b=dR5JJLwf/PgJSENbgeRN1zMr67kFgnNJZIpIRiNy3X1u+G/zygXyqxfPtE4ncT4CFm
         kQ9ezWp9mkM9UjPieYfUoarZZxf5IKqCpyMik4Tsd4njpok8G4D2hmbHejAatt7t1gJY
         q2/vQ4aNFGe0B8OYtfLFKMx1Dml8H7D/UdPVnB0896e/x+ZOqc7zCa7l9qpnrTs+Lzfa
         SsedkyPr875lcTGH8s8CwsCms2aU/NEwb0VEfpn2B6mJrKEk/osQFyOJgg9NFa1VtoRO
         M4rsWfvP73xw4qWugDdL52PbHjvBC1bXfCvf2Ujes7Wl69wWpV7/NsRyNTtsqGqjqmai
         72cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762855620; x=1763460420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XmIn+rr47OIki868fF0YXvVBbJdq9zqT2ApwBKYAGgw=;
        b=p+EbSZTvsFK0CdZJgLft0cAM2BvfOHsr2MGlImNrbr3ZlgXGfhnBBLB7fCnp/5P4Wn
         XPftLbsEAUkjVYVlx8Iw+CsFRxNlN0JI5tSFi15p01UGTLXWwKwmbyNrlFRV9MAuZeYx
         VblzPhY0Z7KxS3mrymGA/zmZti5QdmFhq1imTF1Ais2qiHlsfkVruVYYZtblmvBB8Gjv
         9x20ktjvBwtPTVTmKbkVvKL60zBPBlU+8AGeufobBY/P9CAiz8754R5U9dSVL53gDEtK
         t0JJ09vw1Bx1TO03sLFyK3rNgv+xPuYUfga+5hpBf+iyW37leVxfMFzrWn7ts2pKYyhW
         gbEg==
X-Forwarded-Encrypted: i=1; AJvYcCXA6kMjeuaCwbKLRzLJjknWd4k6OdofwAbWjZxKj5gurIMMywOUiowYwIHeHKjuzoTdP0/BuPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYSkjWFYrYhy++DELXcSVwJR5SR9RUvFzNUnhLKB+hCYAVGzUz
	vbaSc4QEBMVTt2DVSbllQxgUxroE6A/ZqMjHASBZXDMPwyrXR78f6pH0BuJTfhS3EYRsWz+SNry
	9joLo2eyXM/ZIZTbYs0cHK8S7uyjnGHGpPw==
X-Gm-Gg: ASbGncvj/ITjsVt7zKWexD/9BzfHedmXqlWHOeQCjc4y8/yPfoIj6TqZJF5u2tPx3GH
	BZEx/+IJREN3f0b103ExACFGKCqsGHPKqCmCGdJ47WQj+88WDi+iCgjuvlyHsOmSOF/NwMfp8nb
	tE2//KzhMuRUGyoPHercCg+s9hgsIhtWPJhT+fAd9quUvGc+wVIVkycdZVyMDAvVTtdq25qhge5
	HY60V9aM9jMSEYlFMGWkL2iinffNqbLGVqfS1sAxcoK3CyX9SE6prcYXWA=
X-Google-Smtp-Source: AGHT+IE5CdgYP4S6eVmoXO/ZsyBjFqfgRd/wYKtWoj1g+kp/Vi0+gR3ZGX/nKQXM51ALznSDaJ1HWFPt25Qweg0Vcgg=
X-Received: by 2002:a05:690c:6ac9:b0:786:5be2:d460 with SMTP id
 00721157ae682-787d5350cdamr108183427b3.1.1762855619827; Tue, 11 Nov 2025
 02:06:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110214443.342103-1-jonas.gorski@gmail.com>
 <20251110214443.342103-4-jonas.gorski@gmail.com> <20251110222501.bghtbydtokuofwlr@skbuf>
In-Reply-To: <20251110222501.bghtbydtokuofwlr@skbuf>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 11 Nov 2025 11:06:48 +0100
X-Gm-Features: AWmQ_bmSO1z1LVSBIAI4czPL30v972CtnbpO3gCqbxlnpZfY5KJuoptPPMAGhlw
Message-ID: <CAOiHx=k8q7Zyr5CEJ_emKYLRV9SOXPjrrXYkUKs6=MbF_Autxw@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 3/3] net: dsa: deny 8021q uppers on vlan
 unaware bridged ports
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 11:25=E2=80=AFPM Vladimir Oltean
<vladimir.oltean@nxp.com> wrote:
>
> On Mon, Nov 10, 2025 at 10:44:43PM +0100, Jonas Gorski wrote:
> > Documentation/networking/switchdev.rst says:
> >
> > - with VLAN filtering turned off, the bridge will process all ingress
> >   traffic for the port, except for the traffic tagged with a VLAN ID
> >   destined for a VLAN upper.
> >
> > But there is currently no way to configure this in dsa. The vlan upper
> > will trigger a vlan add to the driver, but it is the same message as a
> > newly configured bridge VLAN.
>
> hmm, not necessarily. vlan_vid_add() will only go through with
> vlan_add_rx_filter_info() -> dev->netdev_ops->ndo_vlan_rx_add_vid()
> if the device is vlan_hw_filter_capable().
>
> And that's the key, DSA user ports only(*) become vlan_hw_filter_capable(=
)
> when under a VLAN _aware_ bridge. (*)actually here is the exception
> you're probably hitting: due to the ds->vlan_filtering_is_global quirk,
> unrelated ports become vlan_hw_filter_capable() too, not just the ones
> under the VLAN-aware bridge. This is possibly what you're seeing and the
> reason for the incorrect conclusion that VLAN-unaware bridge ports have
> the behaviour you mention.

Ah, right, no call at all.

But this is about a bridge with VLAN filtering disabled, so filtering
isn't enabled on any port, so ds->vlan_filtering_is_global does not
matter.

See my examples in my reply to 0/3, which hopefully clarify what I am
trying to prevent here.

> > Therefore traffic tagged with the VID will continue to be forwarded to
> > other ports, and therefore we cannot support VLAN uppers on ports of a
> > VLAN unaware bridges.
>
> Incorrect premise =3D> incorrect conclusion.
> (not to say that an uncaught problem isn't there for ds->vlan_filtering_i=
s_global
> switches, but this isn't it)

This should happen regardless of vlan filtering is global.

But I noticed while testing that apparently b53 in filtering=3D0 mode
does not forward any tagged traffic (and I think I know why ...).

Is there a way to ask for a replay of the fdb (static) entries? To fix
this for older switches, we need to disable 802.1q mode, but this also
switches the ARL from IVL to SVL, which changes the hashing, and would
break any existing entries. So we need to flush the ARL before
toggling 802.1q mode, and then reprogram any static entries.

Best regards,
Jonas


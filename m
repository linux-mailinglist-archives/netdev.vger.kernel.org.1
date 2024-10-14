Return-Path: <netdev+bounces-135181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B6599CA4A
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 14:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1578D1C22345
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 12:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983521A7056;
	Mon, 14 Oct 2024 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0zJyv4O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1423D1A7044;
	Mon, 14 Oct 2024 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728909359; cv=none; b=DaMAd5YV4IMlFnESKYFIHcsHoQ4cVNUAPnyStJzHUH6DOLtRldla5410EZzNZhaRf3y3axzJT3Qcu55w9dSXvexYBQsNn9bxdLl0kWU3ja0Bm4XZecxece70U3jHw7+KDT3C9aN3h5aj92oKk83UobmCI9f7DJSpVy6mrBjurI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728909359; c=relaxed/simple;
	bh=RD9APMEsoPVA/5hGXWUbL9d/rug9Ubvl4HYw3pfdORE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EkBdD5GwrlDFY+HpQgpjWpeKRmbC2Wym3leiQ10nXnjKuG2HGV15xxEYmNNFIW3VTmooKGbZcqMkaTHUb7K+UZxszzzSnTaUTpPf+YWqrYPbVix0BJCbcrshHAbY6SpA99MSR1rYtONhP9u/QJ5Z+FtvTXpJmUnRB+Hh59HFb7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0zJyv4O; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-6e390d9ad1dso8000437b3.3;
        Mon, 14 Oct 2024 05:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728909357; x=1729514157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5I+tt4GTLSPWCgZImioc7R6mKrFe9ctiV2Z/FXxf/MU=;
        b=M0zJyv4Oc/hTlgz57DuVY/1QBAO8+do094R7zClZQYIJJfh+XY6fmzKlk+fLu3LFXJ
         f/bLdaUaLwGOurCf1l9w84GyMHK2YRKhTB48U0Io6iJgdP0Gu+GxC/CIVG1xEZkxc11Z
         /HPg0YjfeFlPhno0v+oqTv6t13tgiu2FpCoHieqXZAWd5VG9bv8U3KLqWM9EsNSOppqB
         dflaSs0prkuDOWdNvwrXRPiO8bbJz1APEGdt9yJ/R/Rodo4OuKHbrIEJhLHPS3YRfu7h
         Z5F8n0savQWrVLQqXt66+36Gsz5Ikg/ztjcG6oFC3fV9fbJ474q/VdL4sQhREGSgwR/h
         hmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728909357; x=1729514157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5I+tt4GTLSPWCgZImioc7R6mKrFe9ctiV2Z/FXxf/MU=;
        b=YD7NfLueG8uvgKvp5BI668r+Cg04SOi8rAhoyip6mjdSOdAkNOfMVsYAlaTycQQjO3
         d82VSvhweQIh+XZu9JAKTzX913aj9jnqRC+5GwDU9j+hpLNnDnfyxFQ3FDtM+/ymOUHs
         5V7UXnWO4RY8duWk7bXVNVr4WSmRDswikV6GldwOJS5zFkAMhzX9Fxo0BZyf+nlbUZ7U
         /PMMBhNLcbXabWa/m5UpofqEQOnFtaJ2HtdtzgblSlBvs8ZA6j4gw0XFPI7RCwVpwJta
         OsbTErPkegPNrVadCsMrcMaQzcULG+0mhvgdp5Ur3Ldce8Qv64gWg88ajsFEnsxg2aeB
         eX7g==
X-Forwarded-Encrypted: i=1; AJvYcCWsMiVri1LCr9h+YixFEQ5WVDo9CfPF4dC2N4Ub7oQlBH1zEeIrQhsSNydFPV6L7vGMlIKySUgpKFCXrio=@vger.kernel.org, AJvYcCXisldELnIxECc5rnO178stARLHV5FoVIoF7KMh/pihscw3nIwWtGPoel60lW4UodB0t0CV46W6@vger.kernel.org
X-Gm-Message-State: AOJu0YxhoG2WOEOjjLPTh+4oeaDwec6o+dNwL+aVRqwDFacEN7bq3ig6
	CQlaubIN7K5ldo9rr0SQBrkgEt5rc6Eqfy1ediL94a/tvQToJl6mrC8zdlwux/2o45wqInFfUYT
	oBq5CaccScNLpZz0hsgI2jefOFYk=
X-Google-Smtp-Source: AGHT+IE6AfdPQ4/fitj+/zsHuyQFg5X0c03U34vcdVdsdW9Bwh0GUmiCKDHvuYAQOQLdboY6O4SiPXqN+pyRRwiGhYo=
X-Received: by 2002:a05:690c:368f:b0:6e3:33af:6b64 with SMTP id
 00721157ae682-6e3479b96c7mr91890247b3.14.1728909357094; Mon, 14 Oct 2024
 05:35:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009022830.83949-1-dongml2@chinatelecom.cn>
 <20241009022830.83949-9-dongml2@chinatelecom.cn> <ZwvAVvGFju94UmxN@shredder.mtl.com>
In-Reply-To: <ZwvAVvGFju94UmxN@shredder.mtl.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Mon, 14 Oct 2024 20:35:57 +0800
Message-ID: <CADxym3Yjv6uDicfsog_sP9iWmr_Ay+ZsyZTrMoVdufTA2BnGOg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 08/12] net: vxlan: use kfree_skb_reason() in vxlan_xmit()
To: Ido Schimmel <idosch@nvidia.com>
Cc: kuba@kernel.org, aleksander.lobakin@intel.com, horms@kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com, 
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com, 
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 8:43=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Wed, Oct 09, 2024 at 10:28:26AM +0800, Menglong Dong wrote:
> > Replace kfree_skb() with kfree_skb_reason() in vxlan_xmit(). Following
> > new skb drop reasons are introduced for vxlan:
> >
> > /* no remote found for xmit */
> > SKB_DROP_REASON_VXLAN_NO_REMOTE
> > /* packet without necessary metadata reached a device which is
> >  * in "external" mode
> >  */
> > SKB_DROP_REASON_TUNNEL_TXINFO
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > Reviewed-by: Simon Horman <horms@kernel.org>
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>
> The first reason might be useful for the bridge driver as well when
> there are no ports to forward the packet to (because of egress filtering
> for example), but we can make it more generic if / when the bridge
> driver is annotated.

You are right. As we already need a new version, so we can
do something for this patch too. As you said, maybe we can rename the
reason VXLAN_NO_REMOTE to NO_REMOTE for more generic
usage?


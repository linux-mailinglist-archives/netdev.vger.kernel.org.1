Return-Path: <netdev+bounces-140796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403839B815A
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 18:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCBC4B21616
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 17:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50D51BD515;
	Thu, 31 Oct 2024 17:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeQXuXJK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C24B1B3B2E;
	Thu, 31 Oct 2024 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730396115; cv=none; b=E/X3v8MPZ2EFr3OsSKXOb2x6kEm+ExZGwpTG7UXzSW/eqZvfr0OZZtJ20UgnTmD0Oi9qaWQdEkPjuqHgSPqYc9oxa1pWZoBpNEOf5tJLnpRWqaB4J8jm9BXjZpngY+xKBvf7SRpyvippFGQdK4G3QQriVx1WD8PcIi+GMJRcf3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730396115; c=relaxed/simple;
	bh=aBWESOzd7N/pbfVrKdMUCheeocM/cpc6oHBINJWuzco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciCLWA4+OYQrszl8rRO2CukgWKfxpkpTWme3GSUtVe+sZiMPt7PAK47KTJkwMK7kxzTPCMV+kivP848LmujNHgqqSOC0bVnuEcU8AQqNL/+qWuWneVx4U0m1trltCZWnlij+XqgFvi9kzRxcWNJj+GFK2gHawq8EbDevpKMHcz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeQXuXJK; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5ceb75f9631so598364a12.0;
        Thu, 31 Oct 2024 10:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730396112; x=1731000912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8PwQNBC8Vb1geUW0osrVUKtHqt6tlwDdu2JuwyUsvU=;
        b=jeQXuXJKcZaYtXKH7WAIpbK6Uqo4NxXqYjWH765sAXEesarpOOro3KUiGws3zl1O5E
         F1gOmNKGNgwv+dSW/u5usQi2tJtpWtLyc8JAvi4cH4gw1QEEkX1yCKsqFwEcXLryjTPt
         jZ5jJDCYPq3WGzbceiwmYoINfieyuL8lG+vFNz10vHUADqmfCTymg18vH+Q9aZh1giE3
         wcLzm+Dx99B6YQOouiAF2Oz5+ZDVvbYv8Z/9AHhNrOoC5Aqijd31KcERmYt2aF/lsV+5
         npn86aUdPPHEiVCYe+EQ7v2ej6llRLk2bMl0Bh66pWnqDTm9SOLsICdCrY80xioL3cao
         su/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730396112; x=1731000912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8PwQNBC8Vb1geUW0osrVUKtHqt6tlwDdu2JuwyUsvU=;
        b=C9tUipBayMdxb2xi53+fQuS8OrQZ4n4H3iOlH9jgXxNFsd7YjHSUILqK268nnYhTt4
         yY8ApHmw7OP74uJt7vypYyVJc7YNJ2vVfGo+JVcc2efzTskOqskKLzK8RQqGNiJIBQGh
         1aYCr/Uk9XqznD8RiYjZf0YnRXrhRywW4SoHiTOQ4LJDEj/xzgH88eTvkyDmLVw5Mq6z
         9RvLoLdPnC1XsdyW1lPWde/gFGCTUwTMKLW1NFzj0OOSBjcNjHnoqIKvNzb+dthm9tZh
         wAc4Vdcxvv5wJBNX1P0DglHNMtMti2raYR78j6jU6l948Z97cOGEC1tW5FZNCKzE/SDT
         Bsgw==
X-Forwarded-Encrypted: i=1; AJvYcCU7Kix+5J/VzHpL0anbAIRQiLWgWMI/7mMU5cEZ9wgbH+sxwqkuYC5ktp6bf4eOfxHd3P7VPQEd@vger.kernel.org, AJvYcCVXxdlVCN2r+3Q9Uu+cBffcvAJCl36havFEa6rFbpMZqUEX6F4uENwgLbNgCdI7FmHN4EKwvaGyPnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr+XKmE+DtSrmK0FVn/76uJb0tbXKd/LBjOLB1jkF5Ni2AFixU
	M6Ob8AC8BEilCO/16/W6Dg7EAhg6Z8hLDquu+7UMDMkRFDZ0mYqLS6DrgYnQsIQRu/TmUiP1XiF
	gPyeBCuzPPEff7SmZqxlCrCLbsOE=
X-Google-Smtp-Source: AGHT+IEnoZ8MPaYY//akVMB5nt/k779nWzq8xlqx0EVbQkH3liBtlBO7u+I7oE8r0ZyVTD0EpHmPzaJL6qSjvhywLR8=
X-Received: by 2002:a05:6402:90e:b0:5c9:7f91:d049 with SMTP id
 4fb4d7f45d1cf-5cbbf89d331mr14117198a12.11.1730396111525; Thu, 31 Oct 2024
 10:35:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003160620.1521626-1-ap420073@gmail.com> <20241003160620.1521626-3-ap420073@gmail.com>
 <20241008111926.7056cc93@kernel.org> <CAMArcTU+r+Pj_y7rUvRwTrDWqg57xy4e-OacjWCfKRCUa8A-aw@mail.gmail.com>
 <20241009082837.2735cd97@kernel.org>
In-Reply-To: <20241009082837.2735cd97@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 1 Nov 2024 02:34:59 +0900
Message-ID: <CAMArcTVXJhJopGTHc-DqK1ydCkaQj5-VRGoJ-saGNGeTLXZHcw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/7] bnxt_en: add support for tcp-data-split
 ethtool command
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	almasrymina@google.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	donald.hunter@gmail.com, corbet@lwn.net, michael.chan@broadcom.com, 
	kory.maincent@bootlin.com, andrew@lunn.ch, maxime.chevallier@bootlin.com, 
	danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com, 
	przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com, 
	paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com, 
	aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com, 
	bcreeley@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 12:28=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 9 Oct 2024 22:54:17 +0900 Taehee Yoo wrote:
> > > This breaks previous behavior. The HDS reporting from get was
> > > introduced to signal to user space whether the page flip based
> > > TCP zero-copy (the one added some years ago not the recent one)
> > > will be usable with this NIC.
> > >
> > > When HW-GRO is enabled HDS will be working.
> > >
> > > I think that the driver should only track if the user has set the val=
ue
> > > to ENABLED (forced HDS), or to UKNOWN (driver default). Setting the H=
DS
> > > to disabled is not useful, don't support it.
> >
> > Okay, I will remove the disable feature in a v4 patch.
> > Before this patch, hds_threshold was rx-copybreak value.
> > How do you think hds_threshold should still follow rx-copybreak value
> > if it is UNKNOWN mode?
>
> IIUC the rx_copybreak only applies to the header? Or does it apply
> to the entire frame?
>
> If rx_copybreak applies to the entire frame and not just the first
> buffer (headers or headers+payload if not split) - no preference.
> If rx_copybreak only applies to the headers / first buffer then
> I'd keep them separate as they operate on a different length.
>
> > I think hds_threshold need to follow new tcp-data-split-thresh value in
> > ENABLE/UNKNOWN and make rx-copybreak pure software feature.
>
> Sounds good to me, but just to be clear:
>
> If user sets the HDS enable to UNKNOWN (or doesn't set it):
>  - GET returns (current behavior, AFAIU):
>    - DISABLED (if HW-GRO is disabled and MTU is not Jumbo)
>    - ENABLED (if HW-GRO is enabled of MTU is Jumbo)
> If user sets the HDS enable to ENABLED (force HDS on):
>  - GET returns ENABLED

While I'm writing a patch I face an ambiguous problem here.
ethnl_set_ring() first calls .get_ringparam() to get current config.
Then it calls .set_ringparam() after it sets the current config + new
config to param structures.
The bnxt_set_ringparam() may receive ETHTOOL_TCP_DATA_SPLIT_ENABLED
because two cases.
1. from user
2. from bnxt_get_ringparam() because of UNKNWON.
The problem is that the bnxt_set_ringparam() can't distinguish them.
The problem scenario is here.
1. tcp-data-split is UNKNOWN mode.
2. HDS is automatically enabled because one of LRO or GRO is enabled.
3. user changes ring parameter with following command
`ethtool -G eth0 rx 1024`
4. ethnl_set_rings() calls .get_ringparam() to get current config.
5. bnxt_get_ringparam() returns ENABLE of HDS because of UNKNWON mode.
6. ethnl_set_rings() calls .set_ringparam() after setting param with
configs comes from .get_ringparam().
7. bnxt_set_ringparam() is passed ETHTOOL_TCP_DATA_SPLIT_ENABLED but
the user didn't set it explicitly.
8. bnxt_set_ringparam() eventually force enables tcp-data-split.

I couldn't find a way to distinguish them so far.
I'm not sure if this is acceptable or not.
Maybe we need to modify a scenario?

>
> hds_threshold returns: some value, but it's only actually used if GET
> returns ENABLED.
>
> > But if so, it changes the default behavior.
>
> How so? The configuration of neither of those two is exposed to
> the user. We can keep the same defaults, until user overrides them.
>
> > How do you think about it?
> >
> > >
> > > >       ering->tx_max_pending =3D BNXT_MAX_TX_DESC_CNT;
> > > >
> > > >       ering->rx_pending =3D bp->rx_ring_size;
> > > > @@ -854,9 +858,25 @@ static int bnxt_set_ringparam(struct net_devic=
e *dev,
> > > >           (ering->tx_pending < BNXT_MIN_TX_DESC_CNT))
> > > >               return -EINVAL;
> > > >
> > > > +     if (kernel_ering->tcp_data_split !=3D ETHTOOL_TCP_DATA_SPLIT_=
DISABLED &&
> > > > +         BNXT_RX_PAGE_MODE(bp)) {
> > > > +             NL_SET_ERR_MSG_MOD(extack, "tcp-data-split can not be=
 enabled with XDP");
> > > > +             return -EINVAL;
> > > > +     }
> > >
> > > Technically just if the XDP does not support multi-buffer.
> > > Any chance we could do this check in the core?
> >
> > I think we can access xdp_rxq_info with netdev_rx_queue structure.
> > However, xdp_rxq_info is not sufficient to distinguish mb is supported
> > by the driver or not. I think prog->aux->xdp_has_frags is required to
> > distinguish it correctly.
> > So, I think we need something more.
> > Do you have any idea?
>
> Take a look at dev_xdp_prog_count(), something like that but only
> counting non-mb progs?


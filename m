Return-Path: <netdev+bounces-133849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFAF9973B8
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51D128837F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943E61E2617;
	Wed,  9 Oct 2024 17:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoNiUHwt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111221E1051;
	Wed,  9 Oct 2024 17:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496054; cv=none; b=OTsvNhPl5a3SoNG1wfB/l4qWrYwghg9Ly+M1+P3Eb7E6Cns016jjxnOzwb8T4rKINqgQj6DAifXOqDE93VqtlkW43CCD7BH0pqz4nMLpt7Cf+dKta+sgt9SJ+OvXsxNCeTZrVhbkyBvMOlncTXqHPdh2HhUkfsEJTAJueYzcHv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496054; c=relaxed/simple;
	bh=K37iXdvvL1R4BM6Q9TRQSGCY12MoPF6iqHxeCNtAEX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRPx3P7OZI7h89rcLCU66H1mO2cAMYRGaxkpuxKMAvuir40ZWtkw7ybqph/ebmujrNb453dM/pinqsGOiy20E72+3fi8zOcNy08NyriXn6wnq0Mzz5x8lETY0lzPEXmfDVdTzVgaaH4rx0Z2wT9zOHJPZBJClHyQka6rfNopW00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoNiUHwt; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so23482a12.3;
        Wed, 09 Oct 2024 10:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728496052; x=1729100852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQIRNmq3rFplEVbPziydfZiGPMJqFFcq3ay2W9V6Dt8=;
        b=SoNiUHwtgYrcxQkAVVonK0gEl0PIEHMB6mOUhwopdrmfb8bOpoJG3Fcgejxdy/SDZh
         HMKw0P9k/VzK+FotaGoF4vhd+wW4Vj1qIRYtW3Lpvpcry7u2X+lCpTP1Z4mP+qx6ZFlK
         WE4cnMcKfADv0IoBVhktL7J4OKxtNkCdUFt7CqeIYBlnvifEhhP3Jyt86xsva8IrutPJ
         aB1p5fMWV2CjPFYbM86gytCEkOKAYS5o54v7j2/rY7cK8d+hqY8glPo0B2Lybpnn1/lB
         Hd1JRx9RRUUc5+GKEB8rV83ONY1Wef85me8Ru1vdt/VRMGi+hnsVn6qkVNPV9QNMGw8z
         z+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728496052; x=1729100852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQIRNmq3rFplEVbPziydfZiGPMJqFFcq3ay2W9V6Dt8=;
        b=DE6cgs9Or/oDT5d+iCUY0JBjgoBLGFtAK/351jeiU88e0wxD7jNITOgyQ8TEsAu0jJ
         IjcwZS4WjzLFDTiIYX1ubp6TlFsVVIUe1GCOjZh2qFGDetKMwWNeU4BOUGNUolKpnTbk
         HnFXWUTOJQIrV6H0t0vg2/N7MgBYISCVFpw4QdH/dUs/8pAr4hxDoNLrXkhMGTzx3Ji4
         pxzMrYwOYQdtsvMqO6E567kZrjw/66+27bkFYX1CbY1zc9Y6p0oVnNOEIXBNHGNu8O42
         KJbd6DM8mLcV454TbQZ0pvZXkBUIIpqfo9+n0MtyZ6T4gMAR3Qlv0M8j/szV8wCyitUb
         OhLg==
X-Forwarded-Encrypted: i=1; AJvYcCWeVVzh32o1EExK0nBfBMCHSetmVn/VZqpPIGJllHdAiXDk5Ab1L1eC0EWbruNJM8/+nZy6qIO3@vger.kernel.org, AJvYcCXeid0387bz7PlKM5d2bDZb3hIpcE7gGlCbpAW58OftzSVaS7TKynDWiLOTALyZqkPU9NBjhQl4rc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtX8axK97ITnXsIBb1r67EEJHbugjwWn7mGcf8vQHQ5K+7sV0N
	Ct+n1Ryffk9H0rfJ+NlWoUzOkfm2BhhO5ohO7X0CiPx+nR0Q20epubexjIbXtEd3EjTb/OMxz7M
	1Ho1CPIhoUMYTnT7SRYCP5dXTSC4=
X-Google-Smtp-Source: AGHT+IFH9RaUlsO+z0rzgmrDGer59ojA83L7geZKPFqeGnN6Qpm6PlJ8nAgfBjIjRCx6Pya9dQyPsN1FgN0P7oPs444=
X-Received: by 2002:a17:90a:bb94:b0:2e2:b6ef:1611 with SMTP id
 98e67ed59e1d1-2e2b6ef16cemr1959030a91.18.1728496052307; Wed, 09 Oct 2024
 10:47:32 -0700 (PDT)
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
Date: Thu, 10 Oct 2024 02:47:18 +0900
Message-ID: <CAMArcTX97qsNTtgkaS5-jrV4bC_2ftS_0ZcS2vd_utYEceG7SA@mail.gmail.com>
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

It applies only the first buffer.
So, if HDS is enabled, it copies only header.
Thanks, I will separate rx-copybreak and hds_threshold.

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
>
> hds_threshold returns: some value, but it's only actually used if GET
> returns ENABLED.
>

Thanks for the detailed explanation!

> > But if so, it changes the default behavior.
>
> How so? The configuration of neither of those two is exposed to
> the user. We can keep the same defaults, until user overrides them.
>

Ah, right.
I understood.

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

Thanks for very nice example, I will try it!


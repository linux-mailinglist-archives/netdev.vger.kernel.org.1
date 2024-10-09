Return-Path: <netdev+bounces-133725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F07996CD1
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B50281161
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE621993B6;
	Wed,  9 Oct 2024 13:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi6OYb35"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C893319924E;
	Wed,  9 Oct 2024 13:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482073; cv=none; b=lKEV5IKnRb9Sp2tUV2mKv4UxD69PP+QLPWU1XdQlxaaN/Zmn53J/bdWZJ0O4ThzzXkvT40A7KtXU/JwzoxOh4le2ro5hAwm6/AEdu/dIghVm8WmZj8T5nWc3m1/S74aZS+ZWpCzOdOxlDaygs+naHtGxHG6hing9BnVw5o4X2bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482073; c=relaxed/simple;
	bh=DLUxj1QpXcALt1BYmUq7sAlHYzpC53S44ER7P9Hixl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGe3IM3dxoWms3I1p7C/U2gUXotytFTk/+pg7a6MmHv3UewxQv52xbYj/A+C+NHeKoN0ab5IYqhQIEmLtnv9oakyssIOr1nHYV5zQhqsIFXR5Gq8FyDIMN4TXuMpaaF9FS95Qar/LYWU5bsiXAAcmoDGeK17b2IMu31XaJSX29o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qi6OYb35; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e0b93157caso702417a91.0;
        Wed, 09 Oct 2024 06:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728482070; x=1729086870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pyLW9a6lrN00PH16ImjCSZBswmH53POX6zszKYt0JA=;
        b=Qi6OYb35sjEi0kLEtjNeKaL9MV/8ygIMjzm/iqMXtlPd873gZwE5HwHTfuyKpHWEvx
         tlPPhmT33VwOV+tUrLJAAmODbE/6rG7cP8PmgxoquzpNPVm4l1kNgZcEvXJC5N4deeMS
         IA6D8PoND5pFDo8p+jG33NXdAio9BnPuD1d8a6yAuB3zjI1XjdEnpJB9D5wxqGUyLUOJ
         w+uhzBlhlB/smZWmgOeWXCqlGdfTUR4O1bdEH1Hxg7idbi/crCc99ZfO9u3o4E/GFzd6
         tA7VWXJ/yPLkN+0+Qs5CcznjQOQnxgDFctfWObLKUwJuO3NjPRFfnUA2UnzMAM0ri8P4
         qzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728482070; x=1729086870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pyLW9a6lrN00PH16ImjCSZBswmH53POX6zszKYt0JA=;
        b=vLAQYqRTuV62uhYI4B3ziIZ6dzUJhnISgpks9snKT2e9GayKZixQhOQcN7SeslFgUu
         udxYW3i3q12I+kP5waJod1vDy4/K7efbnPE6TWrQD1++xoxD+v2/X/oj1XWZTsZLS4Hk
         cFgfEzOIY6Q7wHDiRiMxgtK5vLhZiYQRZRqRswllnR1gnPYTcJoGgzrP0f5wbizPJ/3C
         AKC5JFmohQGYYSMetoEUExsbdqoRT2uFMMAXGZWBKnVFfHbu7/SMopqJs1uu/+Nq6AB4
         0u1sIKbnj+uIJfBrHOGc5+V+FMP0Im9DRffZpL3DlF9eCQF7vKf4Qocc+27y6BjbsQVJ
         4hMA==
X-Forwarded-Encrypted: i=1; AJvYcCUbtDcB/Epoae+tDpi3zWMVcWEJozvWOTBwosh9tk4pCtlDUc3c9g2glocOo08pYsMW4KoDDUdP@vger.kernel.org, AJvYcCWUAuvFD/iYvmuusf2bjWOd4VGQX3dmfpgnpccLgPda+8/uOgVhVAuHE6kWcH+gQ0fVWNx0gVrYPB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvpSuV3y/ctr03h+KG7eL+PSAROMB5KZF1v2N5zFuZlSFH5FEl
	8njfU7fmyWM4Y531xl7e1CGF1XG3rUrKpvGJtgvLKGI8g2PuSqSddWSJjtKlQo6ibyFlpd+s0YB
	DYGIhEfpRhDI3w8HYL6JxmyyXwpI=
X-Google-Smtp-Source: AGHT+IFMCaKvNsK5UpbJHwGy5zDxB8XYQy7Z82bp1DDriom8Gmx2woGLhozTzh5eGdUz4twuab9GbqN0GdYKcqUpLxk=
X-Received: by 2002:a17:90a:6387:b0:2d8:b510:170f with SMTP id
 98e67ed59e1d1-2e27df999camr9088553a91.20.1728482070202; Wed, 09 Oct 2024
 06:54:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003160620.1521626-1-ap420073@gmail.com> <20241003160620.1521626-3-ap420073@gmail.com>
 <20241008111926.7056cc93@kernel.org>
In-Reply-To: <20241008111926.7056cc93@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 9 Oct 2024 22:54:17 +0900
Message-ID: <CAMArcTU+r+Pj_y7rUvRwTrDWqg57xy4e-OacjWCfKRCUa8A-aw@mail.gmail.com>
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

On Wed, Oct 9, 2024 at 3:19=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>

Hi Jakub,
Thanks a lot for your reviews!

> On Thu,  3 Oct 2024 16:06:15 +0000 Taehee Yoo wrote:
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/driver=
s/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > index fdecdf8894b3..e9ef65dd2e7b 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > @@ -829,12 +829,16 @@ static void bnxt_get_ringparam(struct net_device =
*dev,
> >       if (bp->flags & BNXT_FLAG_AGG_RINGS) {
> >               ering->rx_max_pending =3D BNXT_MAX_RX_DESC_CNT_JUM_ENA;
> >               ering->rx_jumbo_max_pending =3D BNXT_MAX_RX_JUM_DESC_CNT;
> > -             kernel_ering->tcp_data_split =3D ETHTOOL_TCP_DATA_SPLIT_E=
NABLED;
> >       } else {
> >               ering->rx_max_pending =3D BNXT_MAX_RX_DESC_CNT;
> >               ering->rx_jumbo_max_pending =3D 0;
> > -             kernel_ering->tcp_data_split =3D ETHTOOL_TCP_DATA_SPLIT_D=
ISABLED;
> >       }
> > +
> > +     if (bp->flags & BNXT_FLAG_HDS)
> > +             kernel_ering->tcp_data_split =3D ETHTOOL_TCP_DATA_SPLIT_E=
NABLED;
> > +     else
> > +             kernel_ering->tcp_data_split =3D ETHTOOL_TCP_DATA_SPLIT_D=
ISABLED;
>
> This breaks previous behavior. The HDS reporting from get was
> introduced to signal to user space whether the page flip based
> TCP zero-copy (the one added some years ago not the recent one)
> will be usable with this NIC.
>
> When HW-GRO is enabled HDS will be working.
>
> I think that the driver should only track if the user has set the value
> to ENABLED (forced HDS), or to UKNOWN (driver default). Setting the HDS
> to disabled is not useful, don't support it.

Okay, I will remove the disable feature in a v4 patch.
Before this patch, hds_threshold was rx-copybreak value.
How do you think hds_threshold should still follow rx-copybreak value
if it is UNKNOWN mode?
I think hds_threshold need to follow new tcp-data-split-thresh value in
ENABLE/UNKNOWN and make rx-copybreak pure software feature.
But if so, it changes the default behavior.
How do you think about it?

>
> >       ering->tx_max_pending =3D BNXT_MAX_TX_DESC_CNT;
> >
> >       ering->rx_pending =3D bp->rx_ring_size;
> > @@ -854,9 +858,25 @@ static int bnxt_set_ringparam(struct net_device *d=
ev,
> >           (ering->tx_pending < BNXT_MIN_TX_DESC_CNT))
> >               return -EINVAL;
> >
> > +     if (kernel_ering->tcp_data_split !=3D ETHTOOL_TCP_DATA_SPLIT_DISA=
BLED &&
> > +         BNXT_RX_PAGE_MODE(bp)) {
> > +             NL_SET_ERR_MSG_MOD(extack, "tcp-data-split can not be ena=
bled with XDP");
> > +             return -EINVAL;
> > +     }
>
> Technically just if the XDP does not support multi-buffer.
> Any chance we could do this check in the core?

I think we can access xdp_rxq_info with netdev_rx_queue structure.
However, xdp_rxq_info is not sufficient to distinguish mb is supported
by the driver or not. I think prog->aux->xdp_has_frags is required to
distinguish it correctly.
So, I think we need something more.
Do you have any idea?


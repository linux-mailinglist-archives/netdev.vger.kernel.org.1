Return-Path: <netdev+bounces-152730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D9C9F596A
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 23:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92F207A3CC1
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 22:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED761DD54C;
	Tue, 17 Dec 2024 22:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCHkY8KM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86EB7C6E6;
	Tue, 17 Dec 2024 22:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734473620; cv=none; b=Swz7oRAltIeLK5teyW1YjtPYF8xf3SONNV1dpRSpSxLQOP4lNaidocTZnQxFtdrVkm/XRAMSnkqt7i/9ZYl4e00zCRj5YN4tzh2LubqcyfpyeZQN0KN5jPuBPogkwx8s6KQQlWocX5aBbtZ1FWdC4L807Jq/Y482toAKmANJTvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734473620; c=relaxed/simple;
	bh=DITnIQxNjJGVwuWIq3JaG5pspxw+ruBZ/g44geDsBws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R16B79zwoPml8hJ5/LOiZPykwwqz1yEPer0A7mTv/+ucVMGgkr8r8i+w172DOwBk9sZBgEkk8H/NBjNl6KFFwPCPQodw2hbSj5DzMjtPKYc1925uLLBcXsfxC3k7L3yCQpWsGn24YugnPD/M6XDalgYfWskFpMUFTQSnlYrPAhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCHkY8KM; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3eb9ba53f90so1630219b6e.1;
        Tue, 17 Dec 2024 14:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734473616; x=1735078416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9QuBOniyMYck+y8PUbC//+oM4oKOj8t9nBe0JYSFFE=;
        b=XCHkY8KMKnc6AGjfS1r9jafSIm3cH30h+bx0P6UgQUgSqUxuscVGemHYAnxGVqN2ct
         IQ5ia+1z82ycCCZeB/uZPIDvzKqReN4N/PhW7QScahEUIpouHvctDIkEhTwR9nnVJJnL
         hkvdTcJyV1CCJat1kGISdj+QchpPV++N7BGxNS+2Udd7Kh4IM9r0r6IyeZ+H1noLBDvm
         icdYoFvbaSW1i23WyinNk53BV2XhwDb++GM83r2or/FhWkHy9HNgaWRsMP1z5TxX1Tnk
         eg3PxcNFKDM2rr4B/lsCiywyl8kEGim5Gb6bLEpINkXs61e3KaV+ES3azKyU4tJ9Inh6
         Vqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734473616; x=1735078416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9QuBOniyMYck+y8PUbC//+oM4oKOj8t9nBe0JYSFFE=;
        b=wm/zzHrpYwbOkIWvBJ8gkEDPLWPqcQ93HILqIRKol9/reTXR6oD6duciMOdts2yf1l
         WcM6ANFMa9tIbCAlmGRFWMbH05VkAldyCpgAwN0i7awH2R08+vOIW79K2oLFn7tSB8ko
         +NhmMmv845YEUpHLkmDnGSshd2HAA9xP4JZeh9bDD/simFXEL9OiX84Sq5F0WFafLaVU
         ojm3xoYwLc2t1WQsrKdRhqi0MPvBmXUA7JlkLWgnvH9j2UFaQhyjBHCaWRJgjFwsC4CK
         02JXLcyPn5OI2Nief7l56l7hu45iQRfkiN8VyXVLZa32HDpwK6u6R9xadl/zNNaTrj5s
         PCUw==
X-Forwarded-Encrypted: i=1; AJvYcCVobFcapeXUH79A7DTKpO/jx923fZ/ge8CAYpliWN7pW6rRXdSQXMBLXKlALAreI5+o/lLC0YGM@vger.kernel.org, AJvYcCVxmbFOlB5oh8tzfEZTrKxViqOZHo328sXZ6Z8Xi1KreYxXW68C47IiJV/W/pxBpIBbneHYpmXbtRIn5OY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylQf/D/0ZCltI5K/TLIMd0iTGvGTdmQ1MngpmmVSKmOq/5OT+E
	Fy1pKQWLbXVkmn8crUkWnFtrQqYwMCxwx1JD/JBHgRxWcArDKGxGwYz6YQeDp+iXkLbUDY3xNX/
	WxDpyrz9dGnogQLL3wa5EDjkXBx4=
X-Gm-Gg: ASbGncsmpGGJSTXMcFoGxzhDsS0A1qcc6yz2HdHgLZ7dMHBNLs1U43xNb9hTw0paCP5
	1y8jb2e7HxbMXn2YshVzPATo1hrLSHgvhSzDh9Uc=
X-Google-Smtp-Source: AGHT+IF/zHxTNCbH+0IG4qfG4nasiicCiiEwLg7lIZarUEHvAnsCaIkPrT1dguYfLdST8cwE0omtiGPoDFTN/CE+GSQ=
X-Received: by 2002:a05:6808:3c4d:b0:3ea:4595:13fc with SMTP id
 5614622812f47-3eccc09aebcmr459934b6e.16.1734473616594; Tue, 17 Dec 2024
 14:13:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216234850.494198-1-jmaxwell37@gmail.com> <aa49d578-dee4-4ee8-b17b-b6e941d9126c@intel.com>
In-Reply-To: <aa49d578-dee4-4ee8-b17b-b6e941d9126c@intel.com>
From: Jonathan Maxwell <jmaxwell37@gmail.com>
Date: Wed, 18 Dec 2024 09:13:00 +1100
Message-ID: <CAGHK07COaxjj4WJvDKFLj=ev9j-jRxuw5bXh_zCZtL75Twu7rQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [net-next] ice: expose non_eop_descs to ethtool
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 1:49=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Jon Maxwell <jmaxwell37@gmail.com>
> Date: Tue, 17 Dec 2024 10:48:50 +1100
>
> > The ixgbe driver exposes non_eop_descs to ethtool. Do the same for ice.
>
> Only due to that?
> Why would we need it in the first place?
>

Not just that. We had a critical ice bug we were diagnosing and saw this
counter in the Vmcore. When we set up a reproducer we needed to check that
counter was incrementing. I added this patch to do that and thought that
it may aid trouble-shooting in the future as well so I sent it upstream.

Regards

Jon

> >
> > With this patch:
> >
> > ethtool -S ens2f0np0 | grep non_eop_descs
> >      non_eop_descs: 956719320
> >
> > Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice.h         | 1 +
> >  drivers/net/ethernet/intel/ice/ice_ethtool.c | 1 +
> >  drivers/net/ethernet/intel/ice/ice_main.c    | 2 ++
> >  3 files changed, 4 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/etherne=
t/intel/ice/ice.h
> > index 2f5d6f974185..8ff94400864e 100644
> > --- a/drivers/net/ethernet/intel/ice/ice.h
> > +++ b/drivers/net/ethernet/intel/ice/ice.h
> > @@ -345,6 +345,7 @@ struct ice_vsi {
> >       u32 rx_buf_failed;
> >       u32 rx_page_failed;
> >       u16 num_q_vectors;
> > +     u64 non_eop_descs;
> >       /* tell if only dynamic irq allocation is allowed */
> >       bool irq_dyn_alloc;
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net=
/ethernet/intel/ice/ice_ethtool.c
> > index 3072634bf049..e85b664fa647 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > @@ -65,6 +65,7 @@ static const struct ice_stats ice_gstrings_vsi_stats[=
] =3D {
> >       ICE_VSI_STAT("tx_linearize", tx_linearize),
> >       ICE_VSI_STAT("tx_busy", tx_busy),
> >       ICE_VSI_STAT("tx_restart", tx_restart),
> > +     ICE_VSI_STAT("non_eop_descs", non_eop_descs),
> >  };
> >
> >  enum ice_ethtool_test_id {
> > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/et=
hernet/intel/ice/ice_main.c
> > index 0ab35607e5d5..948c38c0770b 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > @@ -6896,6 +6896,7 @@ static void ice_update_vsi_ring_stats(struct ice_=
vsi *vsi)
> >       vsi->tx_linearize =3D 0;
> >       vsi->rx_buf_failed =3D 0;
> >       vsi->rx_page_failed =3D 0;
> > +     vsi->non_eop_descs =3D 0;
> >
> >       rcu_read_lock();
> >
> > @@ -6916,6 +6917,7 @@ static void ice_update_vsi_ring_stats(struct ice_=
vsi *vsi)
> >               vsi_stats->rx_bytes +=3D bytes;
> >               vsi->rx_buf_failed +=3D ring_stats->rx_stats.alloc_buf_fa=
iled;
> >               vsi->rx_page_failed +=3D ring_stats->rx_stats.alloc_page_=
failed;
> > +             vsi->non_eop_descs +=3D ring_stats->rx_stats.non_eop_desc=
s;
> >       }
> >
> >       /* update XDP Tx rings counters */
>
> Thanks,
> Olek


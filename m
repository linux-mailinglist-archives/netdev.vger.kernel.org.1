Return-Path: <netdev+bounces-146608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E969D48CA
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 09:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA7E1F22527
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 08:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CEC1CB511;
	Thu, 21 Nov 2024 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hoe7pcd/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E311AB512
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 08:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732177665; cv=none; b=iserD7cCofcASxJcXJKLCF1HQxYAofSIH53hUSZwAxo15GHaFx7GkTu/1Z66OUlPevEWv6siP/okMGWA3JjkeUyOXmGeumQKyMbXqMZoNJT85gppyKPSbKQDukcEPwl165eM35t4cABnQiiTGyur39LUvOlCFBKOgV0ctHL+C7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732177665; c=relaxed/simple;
	bh=lKTpgMrHK1vk98LRyvQDELMUJG3A74b80MRDxC8T4Oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dT7QaMLzaTKKDvA0EUDDGIfyf79NYHlLPPpiLaQGm1wUcuovlt1TKnTuakst1OAY9auI7MpAql9w+rzTOuArvG+A8JvNrRIK86b0b2fTLDOa/ONkruSoyzpITdjqiDdA7TuhUDL8ob2sENpYAWfqAe0aXO8Jxr82MiWkXQsAagU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hoe7pcd/; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e64ed090so2e87.1
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 00:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732177661; x=1732782461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRg7xTjQ2nlsBAVH9bgeyIfgoJqhIRxj12tN752RQqQ=;
        b=Hoe7pcd/wLWkwujo6vPeagQ6QwrI8ef1l/5sgmXEBkvotf6McYJfX4ZMfwB8XsKFSw
         qQ7Jl+hdm95OtDiaEOUbe7GU19GTz5KAo9DJUW5B2Jh97phf344egMA08wxGjqPxW9Pe
         bLBk+wkimWE8m4awWsz0IrHFZgyAeA6tgmCoHLzm8tnV9tnELS76rfdsUaqgvBa5FwZf
         Nhz2HEL1L6GLcaj7vFhO4Pw939c0iJ+0P6OKGa3yY+d+nDZnyhxnL4TXPN1eFKzdqUUP
         Uf1L7BTZpW/rb/a/WlqkCKT5EGLU8VnsfW6ldx3LzwvcrPqbTQHkVQZshBk1KjCWmh/+
         9qfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732177661; x=1732782461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRg7xTjQ2nlsBAVH9bgeyIfgoJqhIRxj12tN752RQqQ=;
        b=Y8lEA000UAKr+XadqFncfwROw3wFOBoE6yEdIHh57DdmwHHptdz0uc1kApCLK3ffeu
         59g8rRjCVOgHnQ+dwJ8nbXrWqxlQRQ9nJblY+WGFJLD2VzS/aD+eUnUG9zdwP74KCOQ8
         39XkevvM7p7932GJsyDHNeb0tOjrj2k/QlqoP/1IokLYGBznpCWAWaZLAPtUoy9daYHQ
         Bea2sNcb4LQUwqc/7efKBckTVwgmpemQ6wWomVXSVxvgOTNpARJzg9trnO+mm0BAgelm
         pkI88oorcGSMYzoPsALFhSzDliVto0U+lj+FRuMGo/3cR1wfOyTuXmZ0iVDzeSVHmc9H
         BTbw==
X-Forwarded-Encrypted: i=1; AJvYcCW4VmqrcZs5+KLRDcoFxyf44FizVXIOqKBSapppCazhzW5EXmzD8oIxSoPRtm+vjbReKGPKyAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoX0W4czNwKXPMtmweivI12qbJDFLcCZSTjgvwm4MLTXS8FQ9j
	hZgKVXb1lY/itQ4RVxzspptW1MB8t6orA0Qcu4O2ZNqXOMcrwZBrN6iNvOQWT+dbDNDb23RRJhe
	53oVyMDkFqedgfGmEMbtFjS31HISGtgNgsnOt
X-Gm-Gg: ASbGncunGxDuS2ld//xkmLqE87Xylf2yUQ13f9WGV/hNqfwQ2QqEKByyEXXRmMMB3mF
	kAtwa6kzUDrX4u6yPSRXWfklmDLf02AavlrwFt0GzMXEyxi5ommVjcZFGAXy305/2
X-Google-Smtp-Source: AGHT+IHoLR86M9WJHBN1aE8HIks1cdEVP05lDMDIAQsdwXJ4btmhzaYKhYDDRCgwSggPerYF2RUIz692njPARYmRNV0=
X-Received: by 2002:a19:f006:0:b0:539:e116:26a0 with SMTP id
 2adb3069b0e04-53dcef77a09mr131e87.0.1732177660081; Thu, 21 Nov 2024 00:27:40
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121054711.818670-1-yuyanghuang@google.com> <a68fb3e3-e461-4192-9c5c-d3b0864dbeb3@6wind.com>
In-Reply-To: <a68fb3e3-e461-4192-9c5c-d3b0864dbeb3@6wind.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Thu, 21 Nov 2024 17:27:02 +0900
Message-ID: <CADXeF1Gv1GPyXsvuq6fKZiCOAfWnO5Cqbg5xppwPsgz050W3yQ@mail.gmail.com>
Subject: Re: [PATCH net-next, v3] netlink: add IGMP/MLD join/leave notifications
To: nicolas.dichtel@6wind.com
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, roopa@cumulusnetworks.com, jiri@resnulli.us, 
	stephen@networkplumber.org, jimictw@google.com, prohr@google.com, 
	liuhangbin@gmail.com, andrew@lunn.ch, netdev@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>, Patrick Ruddy <pruddy@vyatta.att-mail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nicolas

Thanks for the review feedback, I will modify the patch and submit it
after v6.13-rc1 is out.

Thanks,
Yuyang

Thanks,
Yuyang


On Thu, Nov 21, 2024 at 5:24=E2=80=AFPM Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
>
> Le 21/11/2024 =C3=A0 06:47, Yuyang Huang a =C3=A9crit :
> > This change introduces netlink notifications for multicast address
> > changes. The following features are included:
> > * Addition and deletion of multicast addresses are reported using
> >   RTM_NEWMULTICAST and RTM_DELMULTICAST messages with AF_INET and
> >   AF_INET6.
> > * Two new notification groups: RTNLGRP_IPV4_MCADDR and
> >   RTNLGRP_IPV6_MCADDR are introduced for receiving these events.
> >
> > This change allows user space applications (e.g., ip monitor) to
> > efficiently track multicast group memberships by listening for netlink
> > events. Previously, applications relied on inefficient polling of
> > procfs, introducing delays. With netlink notifications, applications
> > receive realtime updates on multicast group membership changes,
> > enabling more precise metrics collection and system monitoring.
> >
> > This change also unlocks the potential for implementing a wide range
> > of sophisticated multicast related features in user space by allowing
> > applications to combine kernel provided multicast address information
> > with user space data and communicate decisions back to the kernel for
> > more fine grained control. This mechanism can be used for various
> > purposes, including multicast filtering, IGMP/MLD offload, and
> > IGMP/MLD snooping.
> >
> > Cc: Maciej =C5=BBenczykowski <maze@google.com>
> > Cc: Lorenzo Colitti <lorenzo@google.com>
> > Co-developed-by: Patrick Ruddy <pruddy@vyatta.att-mail.com>
> > Signed-off-by: Patrick Ruddy <pruddy@vyatta.att-mail.com>
> > Link: https://lore.kernel.org/r/20180906091056.21109-1-pruddy@vyatta.at=
t-mail.com
> > Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
>
> net-next is currently closed, you will have to resubmit after the v6.13-r=
c1 is
> out: https://patchwork.hopto.org/net-next.html
>
> One comment below.
>
> > ---
> >
> > Changelog since v2:
> > - Use RT_SCOPE_UNIVERSE for both IGMP and MLD notification messages for
> >   consistency.
> >
> > Changelog since v1:
> > - Implement MLD join/leave notifications.
> > - Revise the comment message to make it generic.
> > - Fix netdev/source_inline error.
> > - Reorder local variables according to "reverse xmas tree=E2=80=9D styl=
e.
> >
> >  include/uapi/linux/rtnetlink.h |  8 +++++
> >  net/ipv4/igmp.c                | 53 +++++++++++++++++++++++++++++++
> >  net/ipv6/mcast.c               | 58 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 119 insertions(+)
> >
> > diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetl=
ink.h
> > index db7254d52d93..92964a9d2388 100644
> > --- a/include/uapi/linux/rtnetlink.h
> > +++ b/include/uapi/linux/rtnetlink.h
> > @@ -93,6 +93,10 @@ enum {
> >       RTM_NEWPREFIX   =3D 52,
> >  #define RTM_NEWPREFIX        RTM_NEWPREFIX
> >
> > +     RTM_NEWMULTICAST,
> RTM_NEWMULTICAST =3D 56
>
> > +#define RTM_NEWMULTICAST RTM_NEWMULTICAST
> > +     RTM_DELMULTICAST,
> > +#define RTM_DELMULTICAST RTM_DELMULTICAST
> >       RTM_GETMULTICAST =3D 58,
> And you can probably remove this '=3D 58' to align to other families.
>
>
> Regards,
> Nicolas


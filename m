Return-Path: <netdev+bounces-110576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646C992D361
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 15:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F991282E0E
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 13:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A6C193084;
	Wed, 10 Jul 2024 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jLX3OLpI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1D212C491
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619525; cv=none; b=T24q4vl2AQ0Axsz9IwUgckjbY2pN9VD8LPxEH80oiE/ZOFdNBvUJ0FYt0yxIHo0YlusbGOAane7jTAGkMMxY5KYlkP3JY9l/lZ0SqL1/uKn2hbMZFs/goErFlT05eu9Em4KAewNcoixur5n1Kz7xZU1Swurklvfofme4eiyYDkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619525; c=relaxed/simple;
	bh=j0eXykdnRIlbr1rB3yho86bg+xuhpJM7RF/337+HIGU=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WE5Qy6WKo3E2JmexjoAk5hnwrlGT+SzaEjEuj+Q3MeH8yXcm+xQ2/ld6SlBXCM0Xm9Z5jB/d7rbr6Q2dQYwoJ1Dv726zU3WC1Sn8bjmRQt8wdOUCcxNc56Xy+1yHdzA6XX7NfNjPzbV6tntSaux8EcdRtSDzHvJei8Cp4ywOq60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jLX3OLpI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720619522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ApMfsMbUlfLMAL+cNRnf74nXamuHyvNu+25SQh6Wu4w=;
	b=jLX3OLpIzx0gynF/8GlAUfuS4dTJaZV5HuXjhrIHfHwa8eAhxXb2T53IPKQawV/QjJDpSt
	qZ8vTvmV2hCkJzJHgu0nEDHP5j1h3iCtL0cBjItNpX88yUCUIRtwCNpO5Bk52etQOt8M+X
	qn+mVlJpwzsrMTF3o/7LhAH9kTqPP8o=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-iprIiEpIPCq7xeYbawlOdg-1; Wed, 10 Jul 2024 09:52:00 -0400
X-MC-Unique: iprIiEpIPCq7xeYbawlOdg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b5ddfea466so77692396d6.3
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 06:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720619520; x=1721224320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ApMfsMbUlfLMAL+cNRnf74nXamuHyvNu+25SQh6Wu4w=;
        b=M/p9sbsdh9X9YHm9hw4zRCY2+21JqeEpD0Mx1tbyWehag1Cpi+QMoPvFr9MjTDgJ08
         N0dx0MQt8X3QrVu1myPZoMKR+5A68uM6NVFw5gHiJvZ1ASJdaZTF7P9eeDdsU/Few2/g
         /IDubZSqlSKPiN+PvgMEdL90W0EH6po2FTtYz5P5rABgH8n2L/qU+arN3dGRGGw1THDm
         GGy8vn35MP6onu0Xztd3seXpoakpIXFgGOPDF1Tcli2lOr7iackCpFwhkeltTWpdtWgU
         mTl2nTHUxgx7O8cvnsNEdYIE9M4cKIeeNbDSBpBjMJQcF8zrxkCvID9ToEMIJfySJgl8
         t8Zw==
X-Gm-Message-State: AOJu0YwrSv+8sNR7OZ/TjFrTOPMOc9X8+kYVv5/x6otdVV0BLGHkcK8d
	wGlnTA5z7oimzc0kSlBI3ZvNF3fhbKoyCoFnGfWKTHOFJHmtey5suatvtmnoLW2lOMWyvLiu77Q
	SJlaxfMN7XuKS0d33hTMb1fGDW22Dovs6gSocJqWPA10wnQ1IH1IM7fZEDKV16tjjylzVVVS4kx
	fhbHAKNmKTUOGKzKu70ic9VVICy2V7
X-Received: by 2002:a05:6214:626:b0:6b5:e3fe:e734 with SMTP id 6a1803df08f44-6b61bc7ef71mr59088416d6.3.1720619520268;
        Wed, 10 Jul 2024 06:52:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEa/uNBVy9JK1Eb3gOwOVU+yq2jPR+jnCOWvV4+ZWsu0Ac7Bh4ZQxgFgXkK6zrvJbrbrjP9wgEgnpY0qMqgDRY=
X-Received: by 2002:a05:6214:626:b0:6b5:e3fe:e734 with SMTP id
 6a1803df08f44-6b61bc7ef71mr59088266d6.3.1720619520013; Wed, 10 Jul 2024
 06:52:00 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jul 2024 13:51:59 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240710090742.1657606-1-amorenoz@redhat.com> <172061821475.5582.9226948763101271068@kwain.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <172061821475.5582.9226948763101271068@kwain.local>
Date: Wed, 10 Jul 2024 13:51:59 +0000
Message-ID: <CAG=2xmNR8Uw2Ecw=NS5BoRGoWWp7hJgd4zxKTRbSrq+VVKq5Uw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: psample: fix flag being set in wrong skb
To: Antoine Tenart <atenart@kernel.org>
Cc: netdev@vger.kernel.org, Yotam Gigi <yotam.gi@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Aaron Conole <aconole@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 03:30:14PM GMT, Antoine Tenart wrote:
> Hi Adri=C3=A1n,
>
> Quoting Adrian Moreno (2024-07-10 11:07:42)
> > A typo makes PSAMPLE_ATTR_SAMPLE_RATE netlink flag be added to the wron=
g
> > sk_buff.
> >
> > Fix the error and make the input sk_buff pointer "const" so that it
> > doesn't happen again.
> >
> > Also modify OVS psample test to verify the flag is properly emitted.
>
> I don't see that part; although it can be sent as a follow-up and not
> part of the fix.

Yep. Sorry I was planning to add it to the fix but thought it was better
off as a follow-up. I should have removed this comment.

>
> Thanks,
> Antoine
>
> > Fixes: 7b1b2b60c63f ("net: psample: allow using rate as probability")
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > ---
> >  include/net/psample.h | 8 +++++---
> >  net/psample/psample.c | 7 ++++---
> >  2 files changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/net/psample.h b/include/net/psample.h
> > index c52e9ebd88dd..5071b5fc2b59 100644
> > --- a/include/net/psample.h
> > +++ b/include/net/psample.h
> > @@ -38,13 +38,15 @@ struct sk_buff;
> >
> >  #if IS_ENABLED(CONFIG_PSAMPLE)
> >
> > -void psample_sample_packet(struct psample_group *group, struct sk_buff=
 *skb,
> > -                          u32 sample_rate, const struct psample_metada=
ta *md);
> > +void psample_sample_packet(struct psample_group *group,
> > +                          const struct sk_buff *skb, u32 sample_rate,
> > +                          const struct psample_metadata *md);
> >
> >  #else
> >
> >  static inline void psample_sample_packet(struct psample_group *group,
> > -                                        struct sk_buff *skb, u32 sampl=
e_rate,
> > +                                        const struct sk_buff *skb,
> > +                                        u32 sample_rate,
> >                                          const struct psample_metadata =
*md)
> >  {
> >  }
> > diff --git a/net/psample/psample.c b/net/psample/psample.c
> > index f48b5b9cd409..a0ddae8a65f9 100644
> > --- a/net/psample/psample.c
> > +++ b/net/psample/psample.c
> > @@ -360,8 +360,9 @@ static int psample_tunnel_meta_len(struct ip_tunnel=
_info *tun_info)
> >  }
> >  #endif
> >
> > -void psample_sample_packet(struct psample_group *group, struct sk_buff=
 *skb,
> > -                          u32 sample_rate, const struct psample_metada=
ta *md)
> > +void psample_sample_packet(struct psample_group *group,
> > +                          const struct sk_buff *skb, u32 sample_rate,
> > +                          const struct psample_metadata *md)
> >  {
> >         ktime_t tstamp =3D ktime_get_real();
> >         int out_ifindex =3D md->out_ifindex;
> > @@ -498,7 +499,7 @@ void psample_sample_packet(struct psample_group *gr=
oup, struct sk_buff *skb,
> >                 goto error;
> >
> >         if (md->rate_as_probability)
> > -               nla_put_flag(skb, PSAMPLE_ATTR_SAMPLE_PROBABILITY);
> > +               nla_put_flag(nl_skb, PSAMPLE_ATTR_SAMPLE_PROBABILITY);
> >
> >         genlmsg_end(nl_skb, data);
> >         genlmsg_multicast_netns(&psample_nl_family, group->net, nl_skb,=
 0,
> > --
> > 2.45.2
> >
> >
>



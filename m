Return-Path: <netdev+bounces-242053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E60C8BDD7
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 21:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1CFC0353E55
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FE030BB82;
	Wed, 26 Nov 2025 20:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="PO8EWsrk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35637232395
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 20:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764189114; cv=none; b=P5EBPMYjFb9729btF/ZEc4MEZVQcH8JXoO3dtrVM+LY0qIW74h93+2zIIag2ysn/B8Zn0ENrqgxLDyoT4C4Q3xmnDGlzykpoM7u06b0EgQJVynjYh8He7qsYRAUQYQNfMIXdZwbcDjZgnF7eGF69es+5yT5BPfjTFBXfp1ptTOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764189114; c=relaxed/simple;
	bh=UQllPhJHlZ1X0fPemjRXs4JB8iOR7CR+siF8nJhvhTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+NBVnAALHeaOjYgPdM1L7B+SIo2ZFTrn55zsV1iJXjsFyaFlxnjNRETuJsq2CHBwtx8TbZAJX9JGXcMfkDlG5cYfa5NvBsENhEMOdOvspkyw5bNO7aivGZOhZ5XMUM3h2w4M+04WbBts0zOEzL71FmCCOQrq5Mears1pw45DSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=PO8EWsrk; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-642fcb38f35so136927d50.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 12:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1764189112; x=1764793912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UW5IV+8AW7SeEgzAgpUpOsNyNhOxsTuAZo86xDtV2Hs=;
        b=PO8EWsrkR+8kvqFLFNP7ABwhSir9K3QtDxpZksk157jDncRE4fT2U8Lzx3EtYbvqFr
         Hog8xoW27SGU1geMfDu2d7qec1UuBPxWVKsevz3XJwFt2BNTUIzd5AlIUoHaAnNNAM77
         t2g2wcYgI+jHol3M1THvlT2lqEojF1OkOW/HXAn4189+w35fO5nAnlSZKqszNHr/sJmZ
         LyuOriLAK4bw9Y//cVPeox5r43+nSSFd/JmQcAUYAO+QdNambd0Un8FD7/ab4HR01oBV
         M86HMN8uzF3OqAzmL00fLO/MH5M4/nAinIB8214uKThfma+2v1IgPpEVf9ior8TUWrBv
         unpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764189112; x=1764793912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UW5IV+8AW7SeEgzAgpUpOsNyNhOxsTuAZo86xDtV2Hs=;
        b=rY5PXmijAASLvl04yXau/esmYhIer8jfRi9NZEmLFn+diDIgZPxn+z6L72kkP/pNIB
         vR+2JixZsJIPjS0SuFfpq4Bhl39VcHafUvv86M/OfITjViSpRkKEr/UHlc3fHrFwMRzD
         mwnCpHDiThIZ4NflJpwOwAuAF7sUlaly3TvYypWCTpn+r4XfnVz6BB23vwQTvaxqE5+t
         SaqfmKxFSZKDUdTty8j1aNyfJKhTL6tINeXwDPQsmdWrr0zJigXZ6ZDO8C2ZwpPM3H4P
         KA6v6E2SSDmGl2tVPtK4EJy7cgq0BazKuzv9Io0odsOboKGIG8KaLMvgLuGevzQZCTDM
         EaLw==
X-Forwarded-Encrypted: i=1; AJvYcCXHyS8km8h3MtwrT7TGhJeYUO0XGLzn+rwHBMqvIMQSIVFdhgRq5ZCW/3HAgyZK/0deE/cfg50=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLuyvUmcqdXvjmKECz7K+YjkJVN7RvQe6I2MdRkos1Pqp19H8n
	jSjVryb8SItYgHQ0y2lEtqN0zbbNZ+PAufEXIXRYAolbsO1G45fIIUj0DyaVeh4s5iLcbFE5Yxg
	INAqYc0DkwoUQ/enovBf7BWp8/RFpHg+R7RHHtO0r
X-Gm-Gg: ASbGncuShWHtmec7ClhHxrhb1FqglXupCeyIBaq79WtOy4k3hfI+eNIGwy33Q4Sq5H1
	nLNfxYsZesHcm6FEsM3ZBH9UJ6FYUeeXnFZlVdayMXj1+ZZpLmgcLxgxqXnY1adgsa5RUUkmGwk
	l2qD3hcejYz2uxAtiYgHnPi9QVPu4iAV92bHAzChCiNKBBXCBmrpoMhUXp23RbVBK5c5WYSiqRZ
	ttp/KpOWsx0pHIGC7GlpRCpbcFrhWHTenhIN34ghCycmrtB4Qg7Tm3y/Z/p04i7lHzEY+N5NqoV
	UEjuAD8SAn4bcEMNSsoR
X-Google-Smtp-Source: AGHT+IHiwjpgWWefTWxfyJu1HuLMopXBz4LiZcpnxKvs1005dKVeFuhKM47fDa7Mpr+4CSLOdsA4QW5SlmBvMvHpE4U=
X-Received: by 2002:a53:d049:0:10b0:63f:9e85:80fb with SMTP id
 956f58d0204a3-64302a4a93fmr13368537d50.29.1764189112049; Wed, 26 Nov 2025
 12:31:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125224604.872351-1-victor@mojatatu.com> <20251125191107.6d9efcfb@phoenix.local>
 <CAM0EoMkaRoW3ZrAkKzGa7O6wLr_nkYeQpeXbUiw_SCrsFoAQXg@mail.gmail.com>
In-Reply-To: <CAM0EoMkaRoW3ZrAkKzGa7O6wLr_nkYeQpeXbUiw_SCrsFoAQXg@mail.gmail.com>
From: Victor Nogueira <victor@mojatatu.com>
Date: Wed, 26 Nov 2025 17:31:41 -0300
X-Gm-Features: AWmQ_bnRNr5UnNQTuiooHlE9iCC73SURdUXglvzVa1dDvHjbCp7ZbWMWE5FSFzA
Message-ID: <CA+NMeC-AWyQnrQsR+i+mgzdb5KyZVe1_994_DhZ4Ne7QaOZPgA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v2] net/sched: Introduce qdisc quirk_chk op
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, horms@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 1:29=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Tue, Nov 25, 2025 at 10:11=E2=80=AFPM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > > [...]
> > > -     root =3D qdisc_root_sleeping(sch);
> > > +     qopt =3D nla_data(opt);
> > > +     duplicates =3D qopt->duplicate;
> > > +
> > > +     dev =3D sch->dev_queue->dev;
> > > +     root =3D rtnl_dereference(dev->qdisc);
> > >
> > >       if (sch !=3D root && root->ops->cl_ops =3D=3D &netem_class_ops)=
 {
> > >               if (duplicates ||
> > > @@ -992,19 +1006,25 @@ static int check_netem_in_tree(struct Qdisc *s=
ch, bool duplicates,
> > >       if (!qdisc_dev(root))
> > >               return 0;
> > >
> > > +     root_is_mq =3D root->flags & TCQ_F_MQROOT;
> > > +
> >
> > What about HTB or other inherently multi-q qdisc?
> > Using netem on HTB on some branches is common practice.
>
> Agreed - this should cover all classful qdiscs. I think the check
> comes from the earlier discussion which involves offloadable qdiscs
> that have multiple children (where HTB fits as well).
> @Victor Nogueira how about check for nested netems with duplicates?

Ok, will look at that approach for the next update

cheers,
Victor


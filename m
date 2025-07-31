Return-Path: <netdev+bounces-211291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E445B17A22
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 01:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABEFE567EE5
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 23:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE8E289343;
	Thu, 31 Jul 2025 23:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mKxOBEWG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE85D1D52B
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 23:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754005169; cv=none; b=fUmEbR4yAKPsJO2IUr3oS+2VNSObdFJN1Rd38f+W5atpFWCU4/MXYAFi4e6aSdcGrT2CvhCkVLa0pXm2stJdauSttPVHPX3qn+kSF54geieRzwXqj96hq3cAHwc/w0vEmRJvyH7PrGi822kUxocDvyyLAXgcsHlyNFvBqfZXYqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754005169; c=relaxed/simple;
	bh=XiYdRgMv9HIW4BPae8lgI8oLBOea0jkFdzZQnLrkAzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HAKq0DLBuu3WoqhGD0zQ6aXXfVySLDidkBPLzL8WoXJ0vYzuFCZOt29LpztIeKdCO6fex5Zz0LehT0PrBwclZoZOHbiGncmrfBtEJso5UFFz2QWRuJVPha9XBzJxy3b3zh1OG8xs/DP+BeVmu0AvB0W2Den2vpwhvGljNnmyvxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mKxOBEWG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24070dd87e4so68055ad.0
        for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 16:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754005167; x=1754609967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iox7rzWt6Nz9d+DtK+rVNuSYzSLi92zHWBPLdFmZV1Q=;
        b=mKxOBEWGJxRoyZ5p6oFvrSUMx0/RAG8DFU47HImYmoxzCvLlhGEWcdQ3nPIV3AFLEa
         7202VqvSECt8i1iq2vIF+aK6p/k/TmyMVPNR/3fc7868SeIsxvJkSgd89jp1YBZD6ZM7
         vhuPfnzbiYN+tclsgj28s0IjVmZgHVqbB8z79FXxN/pptOxswL/YpTWcr9XfRXBWb84o
         +3q6gpV/QjvRiCHzWARAdD1/72lT77RF5NPI/bMGSCeMhRiltxmCYgDqz101x3a/jYEV
         7mgC4ANyzszneSKmSlhmrXMnx0k7lR4vRUktapGz5gqXsJGt1V3Wzn26kXnNfOSx7eb6
         zE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754005167; x=1754609967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iox7rzWt6Nz9d+DtK+rVNuSYzSLi92zHWBPLdFmZV1Q=;
        b=RK0/IZPSuP80etcpaEc9F7OSLJCHNV82ly+VSgqc1T5jkut3MUYkppI5cMAf6f49Aj
         awMoBrpJkSHUZvK5uHtl1tY3JMuDR1hOdfidulmonodTHrQjYl62bwV7/zWDcusVrFsS
         k5103bPjxfpe+oDQ7bOFsom4Nbl5WLGBz/MiVJgR9Zss3wegxsYGmRZcR4K7e46rCwIj
         GjLYbXM/9qj60lTFFDear6qh+D0MW9oG1ld82YhE5XC2IQL3Hr0JcAMLCPwix+M30ygf
         Foh8wWIvDKwamOclp+/U1v3QIqwpEUZ5Hs1X6Yd+giVCTPmHPUpryU5lLXvmMzMY4vuY
         lJow==
X-Forwarded-Encrypted: i=1; AJvYcCWsIdHlrT+DAXywrCl3dw8JIOL7rCM8ikWlC9/Lm0cVd28c6cTngdx4QtroZ9zoTREbCKdxRrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW0Y3yzjGDeq3EoAT56Q/CBXSMdArbcWaoVgaS/1YJ74gTsPVE
	IRjcLqYzprHna6Oj5s2Pi2r20GkOnDzodE5lg2xLsX45uxDI4ANEsi+7aR9S1y3l0kRa1Soloju
	L9zEiH7+OoiGQ0wSF2QYthLDmjftnDjI+EhK54L1V
X-Gm-Gg: ASbGnctB2n+JdxHjfOhr2iUIlXACaJInxNV3+JGczLX74XWE2h/7IpbqeHrsfb7BNN5
	+p13YN03MzggM/xchMyH60n0v6oI5H6MFANcHlnK1sC9LTB10dl4CClWijGdM+7LWGY+HAaTZHy
	OQLj1ghqu3qrCU5+Km10K4JnYVrqATTVPkjMLMEsnXBL8wrIcqrfjVa8Y0uF2+Da6jJ8Iqt+jbD
	octngTQf4XjlWvUYwmhaL8hTR07GmkeLfmwjfN38R7J0L9+QA==
X-Google-Smtp-Source: AGHT+IExV28mKKw+mgRSOcsMgxgeYGngxSUdgBbPA18e4e6tdg1xJQSTx820JMVKa12E800SQBB/F+qNgVTMSJ120Gc=
X-Received: by 2002:a17:902:e80a:b0:23d:eb0f:f49 with SMTP id
 d9443c01a7336-24227bc72abmr1588395ad.14.1754005166812; Thu, 31 Jul 2025
 16:39:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730182511.4059693-1-skhawaja@google.com> <20250730175541.37cfac15@kernel.org>
In-Reply-To: <20250730175541.37cfac15@kernel.org>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Thu, 31 Jul 2025 16:39:15 -0700
X-Gm-Features: Ac12FXzxNuo2o7edzgujfgwH1vpMTsTtnOEcpIgUkvDn0m6PUHbKovS6xLbComA
Message-ID: <CAAywjhQGFP-A2=F=x4ZGjcKKqTBZNJVcV1jyPYZG+1vwr1k4zw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: Update threaded state in napi config in netif_set_threaded
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, willemb@google.com, almasrymina@google.com, 
	netdev@vger.kernel.org, Joe Damato <joe@dama.to>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 5:55=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 30 Jul 2025 18:25:11 +0000 Samiullah Khawaja wrote:
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 1c6e755841ce..1abba4fc1eec 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -7023,6 +7023,9 @@ int netif_set_threaded(struct net_device *dev,
> >        * This should not cause hiccups/stalls to the live traffic.
> >        */
> >       list_for_each_entry(napi, &dev->napi_list, dev_list) {
> > +             if (napi->config)
> > +                     napi->config->threaded =3D threaded;
> > +
> >               if (!threaded && napi->thread)
> >                       napi_stop_kthread(napi);
> >               else
>
> Could we possibly just call napi_set_threaded() instead of having the
> body of this loop? The first "if (threaded)" in napi_set_threaded()
> should do nothing.. and the rest is pretty much copy & paste.
> The barrier is not a concern, it's a control path. WDYT?
+1
>
> The test needs to be added to a Makefile, a few more comments on the
> contents..
>
> > +def enable_dev_threaded_disable_napi_threaded(cfg, nl) -> None:
> > +    """
> > +    Test that when napi threaded is enabled at device level and
> > +    then disabled at napi level for one napi, the threaded state
> > +    of all napis is preserved after a change in number of queues.
> > +    """
> > +
> > +    ip(f"link set dev {cfg.ifname} up")
>
> Why the up? Env should ifup the netdevsim for you..
Will remove
>
> > +    napis =3D nl.napi_get({'ifindex': cfg.ifindex}, dump=3DTrue)
> > +    ksft_eq(len(napis), 2)
>
> So.. the tests under drivers/net are supposed to be run on HW devices
> and netdevsim (both must work). Not sure if running this on real HW
> adds much value TBH, up to you if you care about that.
The addition of a test to drivers/net was suggested by you in the last
review and I sort of prefer that also as different drivers handle the
netdev resize in a different way, so having this test in drivers/net/
gives more coverage. For example the issue this patch fixes is not
reproducible with NetDevSim.
>
> If you don't move the test to net/, and use NetdevSimDev() directly.
>
> If you do let's allow any number of queues >=3D 2, so ksft_ge() here.
> Real drivers are unlikely to have exactly 2 queues.
>
> > +    napi0_id =3D napis[0]['id']
> > +    napi1_id =3D napis[1]['id']
> > +
> > +    threaded =3D cmd(f"cat /sys/class/net/{cfg.ifname}/threaded").stdo=
ut
> > +    defer(_set_threaded_state, cfg, threaded)
> > +
> > +    # set threaded
> > +    _set_threaded_state(cfg, 1)
> > +
> > +    # check napi threaded is set for both napis
> > +    _assert_napi_threaded_enabled(nl, napi0_id)
> > +    _assert_napi_threaded_enabled(nl, napi1_id)
> > +
> > +    # disable threaded for napi1
> > +    nl.napi_set({'id': napi1_id, 'threaded': 'disabled'})
> > +
> > +    cmd(f"ethtool -L {cfg.ifname} combined 1")
> > +    cmd(f"ethtool -L {cfg.ifname} combined 2")
>
> And if you decide to keep this in drivers/net it would be good to defer
> resetting the queue count to original value too. You can do (untested):
>
>         cur =3D ethtool(f"-l {cfg.ifname}", json=3DTrue).get("combined")
>
> or simply assume there is as many queues as there was napis earlier.
>
> And then a defer(ethtool..
+1 to restore the channel count.


>
> > +    _assert_napi_threaded_enabled(nl, napi0_id)
> > +    _assert_napi_threaded_disabled(nl, napi1_id)
> --
> pw-bot: cr


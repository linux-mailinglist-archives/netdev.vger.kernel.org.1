Return-Path: <netdev+bounces-196555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D1CAD5425
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 13:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F463189934B
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5099A239E72;
	Wed, 11 Jun 2025 11:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maMqG4yG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C052E2E610C
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 11:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641885; cv=none; b=qvZbD6Lgu97KmY50K5rc4jPpBTQtHDDfGcBul8zxhRIdk5fz/R+o6w8WlTReTj1jv/QjWh2dJPk4POaOQdW5RemM5QLLcovVAtF8aI6snu5exhHQIk0eEoWilo3XAbptlE2ZsRhBslGl6IHk9SJutaaFSNTjRp6ouODgMNAunKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641885; c=relaxed/simple;
	bh=qap9bI0p46tJApW3L0tCgkySL8aCGLOSH7McxaahVK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FatBRI+UQjNczIrqcuJ6RnFa38JwMpqF/lz6J0XZgA2NebC+WhgjohLqQYllXylgwynYaJs9I/JXbldNQJlcYWNjTFc2CD0SqXfCXusZEbVP0D3fr04p75LG671T8PghUkJm23kLrvCsrkjBMbEJPi/cAIX1oa2P1ZIQzvQettA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maMqG4yG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234fcadde3eso76606165ad.0
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 04:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749641883; x=1750246683; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JG3mCYEPphC2ZkMEntWXdjyQHdQxfOXnhZYdholxh+A=;
        b=maMqG4yG74JtjUeHcSspgsryGf801FzTo13BM7TUUVitTjxlgeihbBF4f8mhvl6DZm
         GRIb+rh5uvBxiG1Pnt3+s317ffOoNl3++UfCwmxtiBMc2hxAOYLgyT3op9sp9tBoEaqx
         4emRCV9ahccK/Ed3GWPeVcOfeinM7c5rSL+LwoUKgv6mOwp0cQyQlW2Ow1mbS44UccTD
         +9dPBZxaQ35A8ZypATn8n7kTZbzIs1rYYUCttK1QrwuSW1zIEQGzsFVYeyQw1XUB3cQI
         uszyFunS8w2e3q+tXinExOWvnf7fHLeDGxgTVdUjAElj0WGmVH2Uy2dXdsLfm0W08ONV
         0gbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749641883; x=1750246683;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JG3mCYEPphC2ZkMEntWXdjyQHdQxfOXnhZYdholxh+A=;
        b=EsZJb8EoF2KdQOG9VoNs1XG5mS2eTCaylLGGd8uIwSR/F+c1yyphqe3YOFqLPqYgIk
         fsGKFBfG0X4Fel9G0EFaOePaY9T6Z/OvlwH0Xc9oRkXqYb1V2mXKMvl2uDA0NJS+jA7k
         oRfNNf7IbfE8D4zHBiYn4P3UBcfUXUL5eKjddeQmASnGXkwq25jRfEnTMYvCJGJIxy7R
         Tqf5amUKmNGGcW72/fCAEb4aw2PQOheV2aNOmJTW9H3u++00D/frGhY6pbB8cbxdA2B2
         uKR7ar2ZBKj5D6CTb8THR3NDakjv8tn33RR85l4adZX6xPObitqEgaCCZn4/6TbaUzdZ
         dAEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4JL4I8ejpGHW1lK3RKaIe7itAaf95AxnwBEI7FXnhyZPhjddWsbpkC8KVqXWcNKaflfTaK/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTiGWG5xHtQt2P79z/bOG+1GMzyeM4Qle7CT9CUYV4bTzTIaYo
	7jylAHpeCjAfHQWie1l1KqZ9sEo8ftG4D+gF8hmff3C2tgXqkKkmagZc
X-Gm-Gg: ASbGncv2OrSb6uPalRFhzhAnGDiIw1Pe5iIe6Ebz1DlwlO87j1eEjKFi88xI37LpGOW
	RdGC1gd306B/K4npLc4xR6twNl60vpJg0u3HlCdh3H8TspxPlNkCa6v8NDRurTAcQqWMFlB06d2
	DyHNT8TPml8BUXYQA+hlfGsJ+uOR8bcbrVm21VRj4j2zqUvCLGzsszyfBTAxK+KNGgRdWt5ds1f
	1f4d/AsrKIAppwXKDnYgqACNsk1XNL8ZWjR0iUMy2StSxqqQEQdgn0Of5AnfZyqIau0mX0W86Q1
	FNH9z9aR7c5V1+RDvG1sskmjoq1/uRpyoFondfRXtSA56Brva5+1KUV9iSy0TTUD2PW4VxGaC/K
	QnQ==
X-Google-Smtp-Source: AGHT+IHa5vVJL3hqUkC2v8ImIpQlZub0+CQiU4Mhy0pZVfkH25rb4zxOGKCpmegSw2Yeerfuk+g+Uw==
X-Received: by 2002:a17:902:ecc2:b0:234:8f5d:e3bd with SMTP id d9443c01a7336-23641b15558mr42275705ad.39.1749641882540;
        Wed, 11 Jun 2025 04:38:02 -0700 (PDT)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603092f05sm85493175ad.68.2025.06.11.04.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 04:38:01 -0700 (PDT)
Date: Wed, 11 Jun 2025 07:37:57 -0400
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, vinicius.gomes@intel.com,
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org, v4bel@theori.io,
	imv4bel@gmail.com
Subject: Re: [PATCH] net/sched: fix use-after-free in taprio_dev_notifier
Message-ID: <aElqlbPP+9UcInJa@v4bel-B760M-AORUS-ELITE-AX>
References: <aElUZyKy7x66X3SD@v4bel-B760M-AORUS-ELITE-AX>
 <CANn89iJiLKn8Nb8mnTHowBM3UumJQrwKHPam0JYGfo482DoE-w@mail.gmail.com>
 <aElna+n07/Jrfxlh@v4bel-B760M-AORUS-ELITE-AX>
 <CANn89i+Lp5n-+TQHLg1=1FauDt45w0P3mneZaiWD7gRnFesVpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+Lp5n-+TQHLg1=1FauDt45w0P3mneZaiWD7gRnFesVpg@mail.gmail.com>

On Wed, Jun 11, 2025 at 04:28:44AM -0700, Eric Dumazet wrote:
> On Wed, Jun 11, 2025 at 4:24 AM Hyunwoo Kim <imv4bel@gmail.com> wrote:
> >
> > On Wed, Jun 11, 2025 at 04:01:50AM -0700, Eric Dumazet wrote:
> > > On Wed, Jun 11, 2025 at 3:03 AM Hyunwoo Kim <imv4bel@gmail.com> wrote:
> > > >
> > > > Since taprio’s taprio_dev_notifier() isn’t protected by an
> > > > RCU read-side critical section, a race with advance_sched()
> > > > can lead to a use-after-free.
> > > >
> > > > Adding rcu_read_lock() inside taprio_dev_notifier() prevents this.
> > > >
> > > > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > >
> > > Looks good to me, but we need a Fixes: tag and/or a CC: stable@ o make
> > > sure this patch reaches appropriate stable trees.
> >
> > Understood. I will submit the v2 patch after adding the tags.
> 
> Thanks, please wait ~24 hours (as described in
> Documentation/process/maintainer-netdev.rst )

Okay, I will submit the v2 patch tomorrow. Thank you for reviewing it!

> 
> >
> > >
> > > Also please CC the author of the  patch.
> >
> > Does “CC” here refer to a patch tag, or to the email’s cc? And by
> > “patch author” you mean the author of the patch
> > fed87cc6718ad5f80aa739fee3c5979a8b09d3a6, right?
> 
> Exactly. Blamed patch author.

To avoid confusion: when you say “CC the patch author,” do you mean 
adding the author to the CC tag in the v2 patch, or simply including 
them in the email’s CC field?
> 
> >
> > >
> > > It seems bug came with
> > >
> > > commit fed87cc6718ad5f80aa739fee3c5979a8b09d3a6
> > > Author: Vladimir Oltean <vladimir.oltean@nxp.com>
> > > Date:   Tue Feb 7 15:54:38 2023 +0200
> > >
> > >     net/sched: taprio: automatically calculate queueMaxSDU based on TC
> > > gate durations
> > >
> > >
> > >
> > >
> > > > ---
> > > >  net/sched/sch_taprio.c | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> > > > index 14021b812329..bd2b02d1dc63 100644
> > > > --- a/net/sched/sch_taprio.c
> > > > +++ b/net/sched/sch_taprio.c
> > > > @@ -1320,6 +1320,7 @@ static int taprio_dev_notifier(struct notifier_block *nb, unsigned long event,
> > > >         if (event != NETDEV_UP && event != NETDEV_CHANGE)
> > > >                 return NOTIFY_DONE;
> > > >
> > > > +       rcu_read_lock();
> > > >         list_for_each_entry(q, &taprio_list, taprio_list) {
> > > >                 if (dev != qdisc_dev(q->root))
> > > >                         continue;
> > > > @@ -1328,16 +1329,17 @@ static int taprio_dev_notifier(struct notifier_block *nb, unsigned long event,
> > > >
> > > >                 stab = rtnl_dereference(q->root->stab);
> > > >
> > > > -               oper = rtnl_dereference(q->oper_sched);
> > > > +               oper = rcu_dereference(q->oper_sched);
> > > >                 if (oper)
> > > >                         taprio_update_queue_max_sdu(q, oper, stab);
> > > >
> > > > -               admin = rtnl_dereference(q->admin_sched);
> > > > +               admin = rcu_dereference(q->admin_sched);
> > > >                 if (admin)
> > > >                         taprio_update_queue_max_sdu(q, admin, stab);
> > > >
> > > >                 break;
> > > >         }
> > > > +       rcu_read_unlock();
> > > >
> > > >         return NOTIFY_DONE;
> > > >  }
> > > > --
> > > > 2.34.1
> > > >


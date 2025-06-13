Return-Path: <netdev+bounces-197325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C96CAD81C6
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 05:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4AB3A2D2D
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 03:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584761EF387;
	Fri, 13 Jun 2025 03:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yw7jLQAu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71531C5F2C
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 03:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749785783; cv=none; b=QN4vmUmYx83LYtXVRzjbnUK6Ng2gLJ67BEBhoHVsRNsD+34FNfd2M/bsjndXRjvEITzw39GVP5z1RTJ2kZcvt2feW92hqOZGCvgz3bIAFC4CzsK6yCG/sA9/QxjBD75DEqBnuD6RG9EElX44pCqWx9oLekZBVj6ijCYhD2Vl9PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749785783; c=relaxed/simple;
	bh=kYHRLLAJxe7Vh7BJ8jSmEFtV5ROZliDqqeDFNBYS2uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8CuCwI80yXhKMdj5M1kJqe2MqyJtvxWokiJK0OJNW1hbX/+cNnY5m+Qmzvpgh4H3pesY9kpjOgLPjf78hyAvT8laQqo6aTS25Ugw0lpRLx9aaoDPYoX+MIRzfBP3Lq9R3nqSnor0HZOmkCY4ffcEuglJkFkGgQHhs7+WwHCE6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yw7jLQAu; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-742c27df0daso1371320b3a.1
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 20:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749785778; x=1750390578; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vtNEkxBQCH6v59Ewg9tTHLjferurgBX8JW8JNspBDxQ=;
        b=Yw7jLQAu/IdJrMZr3YVs+8b1I1gtrqgUaUQhEkuItuVbCrODvqw7lS54Yc/wVaiQhR
         vJZwzZl7bp1Q6DN8FBcbgkD7UZi8FAWasERb0ysL9ogAkM5l08Gpfft74PppYJat2sph
         obpfTO+BjwrT/3qcOZuToLwcrj5HIR6gm+xX9f6xEaoBtr0hE57tCzfnEtDJAl4r3rXg
         MIPrHNq/nIl6EKH3rVKgaGKjgjJKlT6GQzF0oR+3M2qI7jS5fk6hnt+VZzoCyxEVNRFC
         VCrVCN6OuYiXVCtSp5IiZxR4JVVBeZVJ9n+EekBofa59i0/Ozyn3m2uljxGKp64Xlhfu
         IWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749785778; x=1750390578;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vtNEkxBQCH6v59Ewg9tTHLjferurgBX8JW8JNspBDxQ=;
        b=Ex7rIE9hNUujR5jvqwb3AHdEOb3wRjHfb7mAoTVGHWhiMc+pCCACToyPekf525NBPy
         e0DIyNOYGTWVBvUti8SU2iltNjP3s635eSB1aT+SFAEKWG645XVKTYnQGnnYEMy3jaNu
         7YdCixDqdTvZHUP6Ov7KHbA9SNYmPrLROg/lr72FU3cjwbZKIXfE0m8x+NxW2gcoYAFy
         ziWgiW77LqvyakVKshgwTviJggzlIWDrm/rnmR1k1TtM/HHcUkydB6W/Bz9AhwDhXy2w
         ZHQ8jKqhRFDLwewjIDwLrNMkuzSj2AHxw6ZdkeygJdclhbdPOiNUHwSdHEbXDc9TGYBS
         Tt7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzr4mNDUcs9A4WJtQcK4/sY7kwzIU2XvmBg2o0wCdvojHiCPpJ8MHyMdzKPal7pRbq8sbftZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwazotgMF9rnM0aAivjkm7BZjqjfWkpvq4Kpv3mUiW87Trbo552
	RZ349g+DgBNbT8flTl6PREn3V6YMrTfFR09NXrbM8+SflknABwenkBK5
X-Gm-Gg: ASbGnctT4lWdPG3xGZQSRXhg9ZNzOpF/4/AR5LT1nyMBm4Ipo5vpbzKxK7xfmv8deFw
	g/ZzxsTLZ6GsW4KwJD7UQvWr32/fx1JZCvlLEwmCMG84AdzFCmIKoo/g/s1tx63cKx8QZqLTLNF
	Y0oAslv2a3rEfSDqtKlknFLsCKwd8FBUCE+GfR6iGGSuVtXS/CPSwKZSUkqA1ZsJyujyiOCOgGt
	XVbVxAM4sAvncK/TnfMN91rgsQsDLJZquwpkZRSmCbvkXm5SBDdd/VG2BS+lJ4PIHmV34j0ZHaw
	zMic2GiaMGcx1UWYjirRHDd1t8+euo6QQrb7cbxqWzCY581fCEu2Fn9ylF96UH7ZrjpJCgFYyKm
	HiA==
X-Google-Smtp-Source: AGHT+IFpHP1bs7FC/lUBSmbjohlLQ7WvCpFXntX4XU5Lgqz71ecrUn/wRMmuCyJ0o3ktm67Kp2J1xg==
X-Received: by 2002:a05:6a00:3c95:b0:748:3964:6177 with SMTP id d2e1a72fcca58-7488f71eb8dmr2493036b3a.19.1749785778006;
        Thu, 12 Jun 2025 20:36:18 -0700 (PDT)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900b28b7sm564465b3a.136.2025.06.12.20.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 20:36:17 -0700 (PDT)
Date: Thu, 12 Jun 2025 23:36:12 -0400
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: vinicius.gomes@intel.com, jhs@mojatatu.com, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, vladimir.oltean@nxp.com,
	netdev@vger.kernel.org, v4bel@theori.io, imv4bel@gmail.com
Subject: Re: [PATCH v2] net/sched: fix use-after-free in taprio_dev_notifier
Message-ID: <aEucrIuj7yxTX58y@v4bel-B760M-AORUS-ELITE-AX>
References: <aEq3J4ODxH7x+neT@v4bel-B760M-AORUS-ELITE-AX>
 <aEs3Sotbf81FShq3@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEs3Sotbf81FShq3@pop-os.localdomain>

On Thu, Jun 12, 2025 at 01:23:38PM -0700, Cong Wang wrote:
> On Thu, Jun 12, 2025 at 07:16:55AM -0400, Hyunwoo Kim wrote:
> > diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> > index 14021b812329..bd2b02d1dc63 100644
> > --- a/net/sched/sch_taprio.c
> > +++ b/net/sched/sch_taprio.c
> > @@ -1320,6 +1320,7 @@ static int taprio_dev_notifier(struct notifier_block *nb, unsigned long event,
> >  	if (event != NETDEV_UP && event != NETDEV_CHANGE)
> >  		return NOTIFY_DONE;
> >  
> > +	rcu_read_lock();
> >  	list_for_each_entry(q, &taprio_list, taprio_list) {
> >  		if (dev != qdisc_dev(q->root))
> >  			continue;
> > @@ -1328,16 +1329,17 @@ static int taprio_dev_notifier(struct notifier_block *nb, unsigned long event,
> 
> There is a taprio_set_picos_per_byte() call here, it calls
> __ethtool_get_link_ksettings() which could be blocking.
> 
> For instance, gve_get_link_ksettings() calls
> gve_adminq_report_link_speed() which is a blocking function.
> 
> So I am afraid we can't enforce an atomic context here.

In that case, how about moving the lock as follows so that 
taprio_set_picos_per_byte() isn’t included within it?

```
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 14021b812329..2b14c81a87e5 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1328,13 +1328,15 @@ static int taprio_dev_notifier(struct notifier_block *nb, unsigned long event,

                stab = rtnl_dereference(q->root->stab);

-               oper = rtnl_dereference(q->oper_sched);
+               rcu_read_lock();
+               oper = rcu_dereference(q->oper_sched);
                if (oper)
                        taprio_update_queue_max_sdu(q, oper, stab);

-               admin = rtnl_dereference(q->admin_sched);
+               admin = rcu_dereference(q->admin_sched);
                if (admin)
                        taprio_update_queue_max_sdu(q, admin, stab);
+               rcu_read_unlock();

                break;
        }
```

This change still prevents the race condition with advance_sched().

> 
> Sorry.
> Cong


Return-Path: <netdev+bounces-185773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09817A9BB1A
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 01:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EAD44A633E
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 23:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F212E28468D;
	Thu, 24 Apr 2025 23:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="NxHfS1DR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA4E21B908
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 23:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745536417; cv=none; b=dZKJ7qLnr2sLUXlCjFcHdEj36oodVftMH08p68srqUyWjv/2OgRmRdIaimuemvQIiW84AHwTZSb1qls3Zjs2fg9tfvmJT23041t2araiVeshmgLFPVWoK9LhAT9G9Of8IoWPwr9BYpwzaI55RaYphyMsgctgn6poG2Lo922sFCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745536417; c=relaxed/simple;
	bh=sx2bvQeAlCs3ENhan5VM6h7IsnQrtDskHwetoCSeES4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtBG1wXuvUXiLl6HXCuWOIm4fEdnWXowrFjCFiUf4mfw0dpevtby+szfp27EAV9ATGyPug1afxZMcOMiS4tiajSRNeJv/BmFIC9h/7JrtfiITyaZX90e3FOhH4ckeB5caZv3/elD0OXs9mEljw2ugcUz8N+XVcnbXQPFnFGjKd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=NxHfS1DR; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-739be717eddso1221549b3a.2
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 16:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745536415; x=1746141215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pM9k3Gqg0EdJV98XFmVPRc7Ag/gAg9YVplByvfEvSFg=;
        b=NxHfS1DRj2WeI9Fla0y3mI0LYlnaI3r4dkjD3pix94Eyc9bNsAxE492UrJDKiHlYlr
         a2vaNPmsQ9lXYYzNIlVq1CGhZn96kSdTvRsgXkEpDjcaoe65WF7lAOFyWwA7XWVRPo96
         dqmIzl9wB0kLswcFovURYI2Ueicq6mTLiVFt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745536415; x=1746141215;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pM9k3Gqg0EdJV98XFmVPRc7Ag/gAg9YVplByvfEvSFg=;
        b=weYeigeoXDnauIp7dXiATFO9RlPLdiJhPiWXz7i7vMEDqryCvZ2G12qVrYQyFgETsX
         uuw4o81ZmhP4hDYt/rHsr7Wc9iby8382++SFbtwrBplidyXKbFug5a8vgQYZiaXVzsPk
         4ZDMoRVG+HTlM+3728MusxDfNCI+MLPnJt/cvbV6zEmGdsWpiyW6qybdHiWObjTfy8Om
         Y/EX6Fz7RIiyZdpzAhHdGaQp6HfC5jyz/F1DLvJxuOMBIT2jZjxQVySAtu/swp8oQPfV
         Ia9XOPGr785LHJ20vpGX8pLwb67hhWKoVYm1h8PfwBeBpsF670adcxhMAPat7+Dn7Q+L
         QH6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXRfFWSLKh4CEoQncZyfvDMN4K6qpy6v2OUtYTCQIePZDIIn6MOE8OkWSo+588aiVqVqGe+WE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVFDG6d1d8AYI3I4J5TaOaVxYjQI5k0qAgTmiE7ZUS4hAGVhh1
	SK3VJv7tZRDTSYty4i4srHcdcww/xDqFuu54q/qV2BSm5U2Wa3l9S5EqpK7TRm/vhz615jBsR/Y
	T
X-Gm-Gg: ASbGncvvCZKaTezsGQjhmOWoZUDjc5L7DuaqV8OwMvpx+ON9OZcMfIevGXbmQp7CdEe
	rZloECBVdYmKvsQV8ykjUNnJoFToPmheqq0ZssNzNN2D5kW5EqgkGvkJC4hDwr8l85bLZNPvSVU
	f4myvPr/wbUVHzE455Klqgg148WnFqB46USGqvO9xiJ4YoGMpyao71BbpOqDUoJxCHi662Z5xRo
	tyuIy+RUbT45kF5MelTO7+E/A8x6OaHtLVSaAkH0bB68uyOHZ0D6fV385OexFHHOaC23mhmiLbL
	tyshShTZsGSgTdW/gQ5zBQuwkRxcTlVKIrE2YePQ++O5w0K600N56lW/XSfFjs2ebRHybMxOTWP
	8wljmkUc=
X-Google-Smtp-Source: AGHT+IEBc0MthhgbhPxqVPTdSx4u/Mncq64q2qwpLdUx+61PjXGj8gJ+brHQdy0HgHzvCY+aB9oEQA==
X-Received: by 2002:a05:6a21:6d97:b0:201:957a:b08a with SMTP id adf61e73a8af0-2045b764617mr66384637.21.1745536415128;
        Thu, 24 Apr 2025 16:13:35 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25941bf7sm2039935b3a.68.2025.04.24.16.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 16:13:34 -0700 (PDT)
Date: Thu, 24 Apr 2025 16:13:31 -0700
From: Joe Damato <jdamato@fastly.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5] Add support to set napi threaded for
 individual napi
Message-ID: <aArFm-TS3Ac0FOic@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
References: <20250423201413.1564527-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423201413.1564527-1-skhawaja@google.com>

On Wed, Apr 23, 2025 at 08:14:13PM +0000, Samiullah Khawaja wrote:
> A net device has a threaded sysctl that can be used to enable threaded
> napi polling on all of the NAPI contexts under that device. Allow
> enabling threaded napi polling at individual napi level using netlink.
> 
> Extend the netlink operation `napi-set` and allow setting the threaded
> attribute of a NAPI. This will enable the threaded polling on a napi
> context.
> 
> Add a test in `nl_netdev.py` that verifies various cases of threaded
> napi being set at napi and at device level.
> 
> Tested
>  ./tools/testing/selftests/net/nl_netdev.py
>  TAP version 13
>  1..6
>  ok 1 nl_netdev.empty_check
>  ok 2 nl_netdev.lo_check
>  ok 3 nl_netdev.page_pool_check
>  ok 4 nl_netdev.napi_list_check
>  ok 5 nl_netdev.napi_set_threaded
>  ok 6 nl_netdev.nsim_rxq_reset_down
>  # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> v5:
>  - This patch was part of:
>  https://lore.kernel.org/netdev/Z92e2kCYXQ_RsrJh@LQ3V64L9R2/T/
>  It is being sent separately for the first time.

Thanks; I think this is a good change on its own separate from the
rest of the series and, IMO, I think it makes it easier to get
reviewed and merged.

Probably a matter of personal preference, which you can feel free to
ignore, but IMO I think splitting this into 3 patches might make it
easier to get Reviewed-bys and make changes ?

  - core infrastructure changes
  - netlink related changes (and docs)
  - selftest

Then if feedback comes in for some parts, but not others, it makes
it easier for reviewers in the future to know what was already
reviewed and what was changed ?

Just my 2 cents.

The above said, my high level feedback is that I don't think this
addresses the concerns we discussed in the v4 about device-wide
setting vs per-NAPI settings.

See below.

[...]

> diff --git a/net/core/dev.c b/net/core/dev.c
> index d0563ddff6ca..ea3c8a30bb97 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6888,6 +6888,27 @@ static enum hrtimer_restart napi_watchdog(struct hrtimer *timer)
>  	return HRTIMER_NORESTART;
>  }
>  
> +int napi_set_threaded(struct napi_struct *napi, bool threaded)
> +{
> +	if (threaded) {
> +		if (!napi->thread) {
> +			int err = napi_kthread_create(napi);
> +
> +			if (err)
> +				return err;
> +		}
> +	}
> +
> +	if (napi->config)
> +		napi->config->threaded = threaded;
> +
> +	/* Make sure kthread is created before THREADED bit is set. */
> +	smp_mb__before_atomic();
> +	assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
> +
> +	return 0;
> +}

Hm, I wonder if dev_set_threaded can be cleaned up to use this
instead of repeating similar code in two places?

> +
>  int dev_set_threaded(struct net_device *dev, bool threaded)
>  {
>  	struct napi_struct *napi;
> @@ -7144,6 +7165,8 @@ static void napi_restore_config(struct napi_struct *n)
>  		napi_hash_add(n);
>  		n->config->napi_id = n->napi_id;
>  	}
> +
> +	napi_set_threaded(n, n->config->threaded);

It makes sense to me that when restoring the config, the kthread is
kicked off again (assuming config->thread > 0), but does the
napi_save_config path need to stop the thread?

Not sure if kthread_stop is hit via some other path when
napi_disable is called? Can you clarify?

From my testing, it seems like setting threaded: 0 using the CLI
leaves the thread running. Should it work that way? From a high
level that behavior seems somewhat unexpected, don't you think?

[...]

>  static void napi_save_config(struct napi_struct *n)
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index b64c614a00c4..f7d000a600cf 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -184,6 +184,10 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
>  	if (napi->irq >= 0 && nla_put_u32(rsp, NETDEV_A_NAPI_IRQ, napi->irq))
>  		goto nla_put_failure;
>  
> +	if (nla_put_uint(rsp, NETDEV_A_NAPI_THREADED,
> +			 napi_get_threaded(napi)))
> +		goto nla_put_failure;
> +
>  	if (napi->thread) {
>  		pid = task_pid_nr(napi->thread);
>  		if (nla_put_u32(rsp, NETDEV_A_NAPI_PID, pid))
> @@ -322,8 +326,14 @@ netdev_nl_napi_set_config(struct napi_struct *napi, struct genl_info *info)
>  {
>  	u64 irq_suspend_timeout = 0;
>  	u64 gro_flush_timeout = 0;
> +	uint threaded = 0;

I think I'd probably make this a u8 or something? uint is not a
commonly used type, AFAICT, and seems out of place here.

> diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/selftests/net/nl_netdev.py
> index beaee5e4e2aa..505564818fa8 100755
> --- a/tools/testing/selftests/net/nl_netdev.py
> +++ b/tools/testing/selftests/net/nl_netdev.py
> @@ -2,6 +2,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  import time
> +from os import system
>  from lib.py import ksft_run, ksft_exit, ksft_pr
>  from lib.py import ksft_eq, ksft_ge, ksft_busy_wait
>  from lib.py import NetdevFamily, NetdevSimDev, ip
> @@ -34,6 +35,70 @@ def napi_list_check(nf) -> None:
>                  ksft_eq(len(napis), 100,
>                          comment=f"queue count after reset queue {q} mode {i}")
>  
> +def napi_set_threaded(nf) -> None:
> +    """
> +    Test that verifies various cases of napi threaded
> +    set and unset at napi and device level.
> +    """
> +    with NetdevSimDev(queue_count=2) as nsimdev:
> +        nsim = nsimdev.nsims[0]
> +
> +        ip(f"link set dev {nsim.ifname} up")
> +
> +        napis = nf.napi_get({'ifindex': nsim.ifindex}, dump=True)
> +        ksft_eq(len(napis), 2)
> +
> +        napi0_id = napis[0]['id']
> +        napi1_id = napis[1]['id']
> +
> +        # set napi threaded and verify
> +        nf.napi_set({'id': napi0_id, 'threaded': 1})
> +        napi0 = nf.napi_get({'id': napi0_id})
> +        ksft_eq(napi0['threaded'], 1)
> +
> +        ip(f"link set dev {nsim.ifname} down")
> +        ip(f"link set dev {nsim.ifname} up")
> +
> +        # verify if napi threaded is still set
> +        napi0 = nf.napi_get({'id': napi0_id})
> +        ksft_eq(napi0['threaded'], 1)

I feel like the test needs to be expanded?

It's not just the attribute that matters (although that bit is
important), but I think it probably is important that the kthread is
still running and that should be checked ?

> +        # unset napi threaded and verify
> +        nf.napi_set({'id': napi0_id, 'threaded': 0})
> +        napi0 = nf.napi_get({'id': napi0_id})
> +        ksft_eq(napi0['threaded'], 0)
> +
> +        # set napi threaded for napi0
> +        nf.napi_set({'id': napi0_id, 'threaded': 1})
> +        napi0 = nf.napi_get({'id': napi0_id})
> +        ksft_eq(napi0['threaded'], 1)
> +
> +        # check it is not set for napi1
> +        napi1 = nf.napi_get({'id': napi1_id})
> +        ksft_eq(napi1['threaded'], 0)
> +
> +        # set threaded at device level
> +        system(f"echo 1 > /sys/class/net/{nsim.ifname}/threaded")
> +
> +        # check napi threaded is set for both napis
> +        napi0 = nf.napi_get({'id': napi0_id})
> +        ksft_eq(napi0['threaded'], 1)
> +        napi1 = nf.napi_get({'id': napi1_id})
> +        ksft_eq(napi1['threaded'], 1)
> +
> +        # set napi threaded for napi0
> +        nf.napi_set({'id': napi0_id, 'threaded': 1})
> +        napi0 = nf.napi_get({'id': napi0_id})
> +        ksft_eq(napi0['threaded'], 1)

If napi0 is already set to threaded in the previous block for the
device level, why set it explicitly again ?

> +
> +        # unset threaded at device level
> +        system(f"echo 0 > /sys/class/net/{nsim.ifname}/threaded")
> +
> +        # check napi threaded is unset for both napis
> +        napi0 = nf.napi_get({'id': napi0_id})
> +        ksft_eq(napi0['threaded'], 0)
> +        napi1 = nf.napi_get({'id': napi1_id})
> +        ksft_eq(napi1['threaded'], 0)

I ran the test and it passes for me.

That said, the test is incomplete or buggy because I've manually
identified 1 case that is incorrect which we discussed in the v4 and
a second case that seems buggy from a user perspective.

Case 1 (we discussed this in the v4, but seems like it was missed
here?):

Threaded set to 1 and then to 0 at the device level

  echo 1 > /sys/class/net/eni28160np1/threaded
  echo 0 > /sys/class/net/eni28160np1/threaded

Check the setting:

  cat /sys/class/net/eni28160np1/threaded
  0

Dump the settings for netdevsim, noting that threaded is 0, but pid
is set (again, should it be?):

  ./tools/net/ynl/pyynl/cli.py \
       --spec Documentation/netlink/specs/netdev.yaml \
       --dump napi-get --json='{"ifindex": 20}'

  [{'defer-hard-irqs': 0,
    'gro-flush-timeout': 0,
    'id': 612,
    'ifindex': 20,
    'irq-suspend-timeout': 0,
    'pid': 15728,
    'threaded': 0},
   {'defer-hard-irqs': 0,
    'gro-flush-timeout': 0,
    'id': 611,
    'ifindex': 20,
    'irq-suspend-timeout': 0,
    'pid': 15729,
    'threaded': 0}]

Now set NAPI 612 to threaded 1:

  ./tools/net/ynl/pyynl/cli.py \
      --spec Documentation/netlink/specs/netdev.yaml \
      --do napi-set --json='{"id": 612, "threaded": 1}'

Dump the settings:
  
  ./tools/net/ynl/pyynl/cli.py \
      --spec Documentation/netlink/specs/netdev.yaml \
      --dump napi-get --json='{"ifindex": 20}'

  [{'defer-hard-irqs': 0,
    'gro-flush-timeout': 0,
    'id': 612,
    'ifindex': 20,
    'irq-suspend-timeout': 0,
    'pid': 15728,
    'threaded': 1},
   {'defer-hard-irqs': 0,
    'gro-flush-timeout': 0,
    'id': 611,
    'ifindex': 20,
    'irq-suspend-timeout': 0,
    'pid': 15729,
    'threaded': 0}]

So far, so good.

Now set device-wide threaded to 0, which should set NAPI 612 to threaded 0:

   echo 0 > /sys/class/net/eni28160np1/threaded

Dump settings:

  ./tools/net/ynl/pyynl/cli.py \
     --spec Documentation/netlink/specs/netdev.yaml \
     --dump napi-get --json='{"ifindex": 20}'

  [{'defer-hard-irqs': 0,
    'gro-flush-timeout': 0,
    'id': 612,
    'ifindex': 20,
    'irq-suspend-timeout': 0,
    'pid': 15728,
    'threaded': 1},
   {'defer-hard-irqs': 0,
    'gro-flush-timeout': 0,
    'id': 611,
    'ifindex': 20,
    'irq-suspend-timeout': 0,
    'pid': 15729,
    'threaded': 0}]

Note that NAPI 612 is still set to threaded 1, but we set the
device-wide setting to 0.

Shouldn't NAPI 612 be threaded = 0 ?

Second case:
  - netdevsim is brought up with 2 queues and 2 napis
  - Threaded NAPI is enabled for napi1
  - The queue count on the device is reduced from 2 to 1 (therefore
    napi1 is disabled) via ethtool -L

Then:

  - Is the thread still active? Should it be?

IMO: if the napi is disabled the thread should stop because there is
no NAPI for it to poll. When the napi is enabled, the thread can
start back up.

It does not seem that this is currently the case from manual
testing.


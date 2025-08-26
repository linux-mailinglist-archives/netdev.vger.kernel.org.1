Return-Path: <netdev+bounces-216822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93622B354DB
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 08:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819EF1B62801
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 06:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421CF272E56;
	Tue, 26 Aug 2025 06:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JasLZ8/G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8001F8AC5
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756191397; cv=none; b=XQlRkghO4EIKZkCjJ4B10SvWf7FBjoGhKrJes5K8s7+TDYwjZ0FbJqkoOGt0cbrsbyIAYQgP/7YoClBzDGKQYAzEVga/eaz6WQpYZjWYfDy/9L3v1nyRneIaz4DarFP38M6ELlzvligs6YJ6n5lNAZ0sBWMQnv3lPyn2F145ByU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756191397; c=relaxed/simple;
	bh=O8B3Rw3CbOb4VWcmTO4uLJ1R5Rwc28ztFL1OPmXhgH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qr9QfGSGr6TqUKz7t7EZ1PtoEapwytprXDg6GM+wtI4ACvT/KUvLltloT9WFxX9NUPV2uL4GnzGHp82wn3ob7jPUwPeMNxMEr+UK4Ip02Q4y+aESp103+1XbvntwH/a85F2HMIBR94u6qSfmdTtBAU+Sisr1JJKHlRGFnenpTl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JasLZ8/G; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2487a60d649so166875ad.2
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 23:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756191395; x=1756796195; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BA179GeF+c+hdWoc2Lv4LRHYD7Mz3K9CW6ZaoSqZyzg=;
        b=JasLZ8/GfnSuKuiIDGSNuTmQ+SFJuVymJgCWQbvDZkhQeydECUDVMZecR8wzXGc0I+
         GYELYZmIrloHoraDcCYedH11wZwyzkSktoWrSMeO8XNF9y1xsqREOYB4uE8JTZodPyoz
         sLYtKpjnVl6N9RGkPdk0du10K2zuXnpPghLaTV2Torvq2ix7ZFN+PcNwUiGgKbWHKew5
         wtIbFdWL9wStm351lBFCezoa843pvKNxhFwE0PKQogU2xCUSR/4DPtHfAdyL7XHYU0QZ
         eApzYCoZtp9mXoCr/fhOrEgHgNM552PhiAIVvxRFihbFhL3CSXPVFygx5QQ4P+gqHFRF
         8/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756191395; x=1756796195;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BA179GeF+c+hdWoc2Lv4LRHYD7Mz3K9CW6ZaoSqZyzg=;
        b=Skm3Ndtb6Xbw27HyaWe73Ucu6dBiXYKlfM7vgYcPj2kSCCpCF/L+WGF9YgR4NAE6yg
         QSgJPbdbU3iDZxeoGxWi7fme5oPoo1hN2yhNt4ICoZcOmTWqAPSoE3ZNwwhyMdCF+bC5
         F58nAqLMCMxc1LC7IL8UCdr6CqLDKViZwMiAd1VGdEzvnrEl1bbHvaIHCvjgrOxyayUS
         VRgALXfGp7O6eN73e8eektcQ3FaMk1ULltCWH7QPBeOyfc5DEHw8D9t5pGuaHEQtB6sa
         LNKxuhpxW4LnaaTiEsPUGFR2v/aTyh1egSFIRvGjOvpOD3Hjbks5YpGvQRaqZOnrw/zL
         FGcg==
X-Gm-Message-State: AOJu0YyBFvZ3DaORbZZDk5BMQ/WIxKavZ3wXuKEJ0BRTKn+6Wuq2qNnp
	3n+p8PulpNpSlGjaGwoed+ZgDWmA7TW5rnyzsHZDrKAacn/08I3WYZxE
X-Gm-Gg: ASbGncsHgXDyz2vs9AQtKMII+RfBdPx9dtQrDvtu3ZsCEcYu+jWFmBiLReehpN9rEBG
	hblbIgFnIimJydvgzD+/bUvldaf3bb/e+8jEHL2fxqQhxYaWWZqZhIx8+Q9UAMp5HXkQpr4BcAz
	s3ncYqry4jj6sMB1g+vePrq0uwQXdiyqpE0Cow9EHxCspwPXeEGB+5oZCs1ZzP0zYp77o/UxwWp
	EVdcsFWDy5BzfAyf1dJXz3nPb8DQUDK9kQdDhj8ZrFORl1YMTfJMAgwkE1u4+bfywSc+JCnlF9u
	vM/fYIJP71cxfOdnqtMuIHok/0gli57BCmeipc0CaGYCODVfK6oAau4tg5qooDsDczMqo59yyxz
	pRStOeRt5IgrNhchVc5LiDTHrqc4=
X-Google-Smtp-Source: AGHT+IE0XBJwuTtPi3GxpxXc+xQYb2QkLtZl5oeGdwYC83Y/HD1ijvbQA8vt/26sC5aJVHmTkA5YdA==
X-Received: by 2002:a17:902:ef06:b0:242:9be2:f67a with SMTP id d9443c01a7336-2462ee0bec3mr203371135ad.11.1756191394796;
        Mon, 25 Aug 2025 23:56:34 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687c75b5sm87152945ad.66.2025.08.25.23.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:56:34 -0700 (PDT)
Date: Tue, 26 Aug 2025 06:56:25 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jaakko Karrenpalo <jkarrenpalo@gmail.com>,
	Fernando Fernandez Mancera <ffmancera@riseup.net>,
	Murali Karicheri <m-karicheri2@ti.com>,
	WingMan Kwok <w-kwok2@ti.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Yu Liao <liaoyu15@huawei.com>, Arvid Brodin <arvid.brodin@alten.se>
Subject: Re: [PATCH net] hsr: add rcu lock for all hsr_for_each_port caller
Message-ID: <aK1amQLIsi0hRvg3@fedora>
References: <20250826041148.426598-1-liuhangbin@gmail.com>
 <CAAVpQUCiDeVxitKR6EUMv+2CmOkQiFU6RHPZ-rOQVyzbGe2LQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUCiDeVxitKR6EUMv+2CmOkQiFU6RHPZ-rOQVyzbGe2LQw@mail.gmail.com>

On Mon, Aug 25, 2025 at 10:01:05PM -0700, Kuniyuki Iwashima wrote:
> On Mon, Aug 25, 2025 at 9:12 PM Hangbin Liu <liuhangbin@gmail.com> wrote:
> >
> > hsr_for_each_port is called in many places without holding the RCU read
> > lock, this may trigger warnings on debug kernels like:
> >
> >   [   40.457015] [  T201] WARNING: suspicious RCU usage
> >   [   40.457020] [  T201] 6.17.0-rc2-virtme #1 Not tainted
> >   [   40.457025] [  T201] -----------------------------
> >   [   40.457029] [  T201] net/hsr/hsr_main.c:137 RCU-list traversed in non-reader section!!
> >   [   40.457036] [  T201]
> >                           other info that might help us debug this:
> >
> >   [   40.457040] [  T201]
> >                           rcu_scheduler_active = 2, debug_locks = 1
> >   [   40.457045] [  T201] 2 locks held by ip/201:
> >   [   40.457050] [  T201]  #0: ffffffff93040a40 (&ops->srcu){.+.+}-{0:0}, at: rtnl_link_ops_get+0xf2/0x280
> >   [   40.457080] [  T201]  #1: ffffffff92e7f968 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x5e1/0xb20
> >   [   40.457102] [  T201]
> >                           stack backtrace:
> >   [   40.457108] [  T201] CPU: 2 UID: 0 PID: 201 Comm: ip Not tainted 6.17.0-rc2-virtme #1 PREEMPT(full)
> >   [   40.457114] [  T201] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> >   [   40.457117] [  T201] Call Trace:
> >   [   40.457120] [  T201]  <TASK>
> >   [   40.457126] [  T201]  dump_stack_lvl+0x6f/0xb0
> >   [   40.457136] [  T201]  lockdep_rcu_suspicious.cold+0x4f/0xb1
> >   [   40.457148] [  T201]  hsr_port_get_hsr+0xfe/0x140
> >   [   40.457158] [  T201]  hsr_add_port+0x192/0x940
> >   [   40.457167] [  T201]  ? __pfx_hsr_add_port+0x10/0x10
> >   [   40.457176] [  T201]  ? lockdep_init_map_type+0x5c/0x270
> >   [   40.457189] [  T201]  hsr_dev_finalize+0x4bc/0xbf0
> >   [   40.457204] [  T201]  hsr_newlink+0x3c3/0x8f0
> >   [   40.457212] [  T201]  ? __pfx_hsr_newlink+0x10/0x10
> >   [   40.457222] [  T201]  ? rtnl_create_link+0x173/0xe40
> >   [   40.457233] [  T201]  rtnl_newlink_create+0x2cf/0x750
> >   [   40.457243] [  T201]  ? __pfx_rtnl_newlink_create+0x10/0x10
> >   [   40.457247] [  T201]  ? __dev_get_by_name+0x12/0x50
> >   [   40.457252] [  T201]  ? rtnl_dev_get+0xac/0x140
> >   [   40.457259] [  T201]  ? __pfx_rtnl_dev_get+0x10/0x10
> >   [   40.457285] [  T201]  __rtnl_newlink+0x22c/0xa50
> >   [   40.457305] [  T201]  rtnl_newlink+0x637/0xb20
> >
> > Fix it by wrapping the call with rcu_read_lock()/rcu_read_unlock().
> >
> > Fixes: c5a759117210 ("net/hsr: Use list_head (and rcu) instead of array for slave devices.")
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > ---
> >  net/hsr/hsr_device.c  | 37 ++++++++++++++++++++++++++++++++-----
> >  net/hsr/hsr_main.c    | 12 ++++++++++--
> >  net/hsr/hsr_netlink.c |  4 ----
> >  3 files changed, 42 insertions(+), 11 deletions(-)
> >
> > diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> > index 88657255fec1..67955b21b4a4 100644
> > --- a/net/hsr/hsr_device.c
> > +++ b/net/hsr/hsr_device.c
> > @@ -49,12 +49,15 @@ static bool hsr_check_carrier(struct hsr_port *master)
> >
> >         ASSERT_RTNL();
> >
> > +       rcu_read_lock();
> >         hsr_for_each_port(master->hsr, port) {
> 
> Why not use the 4th arg of list_for_each_entry_rcu() ?
> 
> Adding random rcu_read_lock() looks confusing.

Yes. Thanks for this notify. I didn't notice the 4th arg of
list_for_each_entry_rcu(). Do you have any suggestion which lock we should
check? rtnl_is_locked() seems can't cover all cases.

Or maybe add a hsr_for_each_port_rntl() for some of net_device_ops?
And others still using rcu read lock? I'm not very sure. Do you have any
suggestions?

...

> > @@ -205,10 +216,13 @@ static netdev_features_t hsr_features_recompute(struct hsr_priv *hsr,
> >          * may become enabled.
> >          */
> >         features &= ~NETIF_F_ONE_FOR_ALL;
> > +
> > +       rcu_read_lock();
> >         hsr_for_each_port(hsr, port)
> >                 features = netdev_increment_features(features,
> >                                                      port->dev->features,
> >                                                      mask);
> > +       rcu_read_unlock();
> >
> >         return features;
> >  }
> > @@ -410,14 +424,11 @@ static void hsr_announce(struct timer_list *t)
> >
> >         hsr = timer_container_of(hsr, t, announce_timer);
> >
> > -       rcu_read_lock();
> >         master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
> >         hsr->proto_ops->send_sv_frame(master, &interval, master->dev->dev_addr);
> 
> hsr_announce() is a timer func, and what protects master after
> rcu_read_unlock() in hsr_port_get_hsr() ?

hsr_port_get_hsr() is called in more places thank hsr_for_each_port().
That's why I set the rcu read lock in side of of hsr_port_get_hsr().

How about using dev_hold() to protect master device?

Thanks
Hangbin


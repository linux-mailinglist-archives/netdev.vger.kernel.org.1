Return-Path: <netdev+bounces-210453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD33B1361F
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 10:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49EAC171B6F
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 08:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8599221F02;
	Mon, 28 Jul 2025 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="yG9Uh0Dj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7771DC9B5
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753690601; cv=none; b=Sv9nOxagIpN6+n4H4Oo7Ua41LsvYcaQZIWJvFt6UH/N1c4YpDxwwZtCBt8TpPQwRBB96yHP30YPcj4m7N1fmf6QBTGrX0FxaIfbk9j+qexxioUBvipUmW59AONpNI3JhPSN7wQwcK4d0rZ4x4+vVus7A5+ypoK4V6sKylDHjm58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753690601; c=relaxed/simple;
	bh=ATpJw7WzoRud+y6bLFzHZO/ZLPtUwMBPibeII5AvRv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZw2vXbn/+g1PJJCjFDMx0ngETqsDCBhT3V020RcJPkymd3E81Z6gvegMbI32A+JlX7c6t3juaaG482Ji/SZ6uCNANICoVDzv046yNiFYVAabr6eMaOCJua4mAuHFIrZ2eCzyAcdva1YcIZnbuQ1NBr57kIjhLgNapX/B05wNLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=yG9Uh0Dj; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae361e8ec32so730271666b.3
        for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 01:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1753690598; x=1754295398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BLJsYkXB9VHBJy4TSItaYqbC4HNxg9MAcc9feRLugIQ=;
        b=yG9Uh0DjdytynVL8wI1c9CtpH7kuDs9BGzxpzb7zoFaWwquic0LXyGvCrOM6cs3jAs
         Tnmtr38qStSMD4IrC5lLrpWRbpudxC4myw5qyIGXdJJfNLawiGwG6snh1eeOIq53ugdu
         SRHyvw9rCpjsjKZKrFOIroOKQV3UfG7Hwctq87B7EsWrwBreNOJqQgpbTXpcvgKNkpu+
         ywgGLo2NmLaIwn/AmlJ8aOff85AHdSkirBJBuMBFKz5a/lD7u3vDCA7ttGv18mJ+DTl8
         3rg23CDNXpUaR3YRGypGNeU2mVrDRvSZbmRvvcHQS9Ez5UQ1OGZ/OS9VpdaNkHs86VES
         F5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753690598; x=1754295398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLJsYkXB9VHBJy4TSItaYqbC4HNxg9MAcc9feRLugIQ=;
        b=Cu9lCauDxD0CJLZnV4wWVoG8jPlFgdmjlOGulhqn+t+qmE1fttiZU1bRrTm7mnmJ7V
         q4Jsu6BhGO0H5ZYvCHO95gxQLSWFpixhZbOTLfCnedl8CMreskVbEFYMR5HtR2MxetMq
         7itv1Xw3q/gNHw/ihRbHOinoF+p3jlVyA0yae+hOPaUWWLwzrxEhRRdBIQ1WZmAXPvTQ
         A+NMwUJ65lDzfwvvrEsBxgDcLjpA7EsEDU/O+1xEmQ3Q6YnC2b5uDA6scQoK9P/gSJ6R
         XxT9NPxoo0GxVPJL58D0gluj2tehBUJiP0Veu1c1hyFIxrkw2gi224x+9fml82TfQkRq
         JyjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJdF3iZsoNpmyW7+s+RuCqQQHlFfmGN9c8+Vwg/2GkwhheR6/UzO/3caHk/9N1v79ZefUcbbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysq4qOhWRF1BjdzsAOwMSJl3zubutl/wDf3HUwaeUoOPJ3lCu7
	J6YXKZyyH28CMYkr+bcZgQobdzzzsxdQPaB2/fH5YhQjEEpRxQIhBskYa2DaA4st8g8=
X-Gm-Gg: ASbGncsmg6QYzdLHvxFGGFNOzXd5G6bz/8pZ1eP5XcR2BxubnKW0YP3VViceHr9Ow9g
	gW3gbwlAucRKk5TP+xY2FlQ075OCfMKa+x4J4yc9/Wc2Ekq5HSLQvkFidK0mFjx5oNERGVoKESe
	sWpraishSuZQjIzSaun8qgOhyDmaXA9vQMam4QSRoZjJX2pstAMywPlCmdxwED/dZ7YxHn3PY8t
	OUOfqvZlRdqSmXREuMoQUxn0LYUnfW2XSdhAvxq7P5FpGGCzHNTKoeTyB5ck/ct0NMMRSwyhkMa
	ke///UumZ0uRhTrJXgBZh7QHnDSr9udDfjHstezSUTi8gJ6rf68mKSu6+rMIu8rYmJGCfm94Pu7
	d76OWHfixNe6ejKPN/2GNMyKK3g3D
X-Google-Smtp-Source: AGHT+IF500Dv6cNp/OyxZXV7NAhtOUjrPP2IhdEwpTckqccDSP/sK78bO43eDzNO9RnW/nn4lGzOqg==
X-Received: by 2002:a17:906:f04a:b0:af6:361e:664d with SMTP id a640c23a62f3a-af6361e6780mr903788066b.7.1753690598206;
        Mon, 28 Jul 2025 01:16:38 -0700 (PDT)
Received: from jiri-mlt ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a66852sm379805466b.71.2025.07.28.01.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 01:16:37 -0700 (PDT)
Date: Mon, 28 Jul 2025 10:16:36 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ujwal Kundur <ujwal.kundur@gmail.com>
Cc: syzbot+8182574047912f805d59@syzkaller.appspotmail.com, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, andrew+netdev@lunn.ch
Subject: Re: [RFC PATCH] net: team: switch to spinlock in team_change_rx_flags
Message-ID: <dc2cjhvanb3rhlwljeuegp4euimfadt5q6u35wp55vueb5b5pb@xf4y6oxkjzjn>
References: <68712acf.a00a0220.26a83e.0051.GAE@google.com>
 <20250727180921.360-1-ujwal.kundur@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250727180921.360-1-ujwal.kundur@gmail.com>

Sun, Jul 27, 2025 at 08:09:21PM +0200, ujwal.kundur@gmail.com wrote:
>Syzkaller reports the following issue:
>BUG: sleeping function called from invalid context in
>team_change_rx_flags
>
>3 locks held by syz.1.1814/12326:
> #0: ffffffff8fa21eb8 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
> #0: ffffffff8fa21eb8 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
> #0: ffffffff8fa21eb8 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x23/0x250 net/core/rtnetlink.c:570
> #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
> #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
> #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8db/0x1c70 net/core/rtnetlink.c:4054
> #2: ffff8880635e8368 (&macsec_netdev_addr_lock_key#2/2){+...}-{3:3}, at: netif_addr_lock_bh include/linux/netdevice.h:4805 [inline]
> #2: ffff8880635e8368 (&macsec_netdev_addr_lock_key#2/2){+...}-{3:3}, at: dev_uc_add+0x67/0x120 net/core/dev_addr_lists.c:689
>Preemption disabled at:
>[<ffffffff895a7d26>] local_bh_disable include/linux/bottom_half.h:20 [inline]
>^^^^
>[<ffffffff895a7d26>] netif_addr_lock_bh include/linux/netdevice.h:4804 [inline]
>[<ffffffff895a7d26>] dev_uc_add+0x56/0x120 net/core/dev_addr_lists.c:689
>Call Trace:
> <TASK>
> dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
> print_lock_invalid_wait_context kernel/locking/lockdep.c:4833 [inline]
> check_wait_context kernel/locking/lockdep.c:4905 [inline]
> __lock_acquire+0xbcb/0xd20 kernel/locking/lockdep.c:5190
> lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
> __mutex_lock_common kernel/locking/mutex.c:602 [inline]
> __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:747
> team_change_rx_flags+0x38/0x220 drivers/net/team/team_core.c:1781
> dev_change_rx_flags net/core/dev.c:9241 [inline]
> __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285
> netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9305
> dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:287
> dev_change_rx_flags net/core/dev.c:9241 [inline]
> __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285
> __dev_set_rx_mode+0x17c/0x260 net/core/dev.c:-1
> dev_uc_add+0xc8/0x120 net/core/dev_addr_lists.c:693
> macsec_dev_open+0xd9/0x530 drivers/net/macsec.c:3634
> __dev_open+0x470/0x880 net/core/dev.c:1683
> __dev_change_flags+0x1ea/0x6d0 net/core/dev.c:9458
> rtnl_configure_link net/core/rtnetlink.c:3577 [inline]
> rtnl_newlink_create+0x555/0xb00 net/core/rtnetlink.c:3833
>
>mutex_lock/mutex_unlock are called from team_change_rx_flags with
>BH disabled (caused by netif_addr_lock_bh). Switch to spinlock instead
>to avoid sleeping with BH disabled.
>
>Reported-by: syzbot+8182574047912f805d59@syzkaller.appspotmail.com
>Signed-off-by: Ujwal Kundur <ujwal.kundur@gmail.com>

This is already fixed by:
bfb4fb77f9a8 ("team: replace team lock with rtnl lock")


>---
> drivers/net/team/team_core.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
>index 8bc56186b2a3..4568075fea6e 100644
>--- a/drivers/net/team/team_core.c
>+++ b/drivers/net/team/team_core.c
>@@ -1778,7 +1778,7 @@ static void team_change_rx_flags(struct net_device *dev, int change)
> 	struct team_port *port;
> 	int inc;
> 
>-	mutex_lock(&team->lock);
>+	spin_lock(&team->lock);
> 	list_for_each_entry(port, &team->port_list, list) {
> 		if (change & IFF_PROMISC) {
> 			inc = dev->flags & IFF_PROMISC ? 1 : -1;
>@@ -1789,7 +1789,7 @@ static void team_change_rx_flags(struct net_device *dev, int change)
> 			dev_set_allmulti(port->dev, inc);
> 		}
> 	}
>-	mutex_unlock(&team->lock);
>+	spin_unlock(&team->lock);
> }
> 
> static void team_set_rx_mode(struct net_device *dev)
>-- 
>2.30.2
>


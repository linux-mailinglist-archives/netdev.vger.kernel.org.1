Return-Path: <netdev+bounces-108952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA11292657E
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D037B20D3A
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7960B17E904;
	Wed,  3 Jul 2024 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcNernnb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E940717C7C;
	Wed,  3 Jul 2024 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720022538; cv=none; b=RwKUC2kE6NYd3SsGAiuR4dilbCH1GykaCUclwm1qCGzvsnebtbfuXmn9BvyY3VCM4P7yBOoTD/i6Iw8YIqcSQzj52VjUgOAhTrmlx1b4qp5dNgBqCeE+QUUcYv4slUZ1Pb9hBrfvtnoYNnJmGiYywQhhykECdzjAuRWIk8RULJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720022538; c=relaxed/simple;
	bh=kLrhaR+1UBp8gvQNoBqnTS0wMECkG7vE5QiNlpFWVGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=majjjm/O7XCpGhporFipXQN+Me12g1CA8GFPZ548vulrbb5uV9kOurwHcBRv1MAeWINDYdnQZ5Au2Wgop3ERkNlwpg77sQB5VvyZo1t7iGPi+MiSxwKnfJafuCbHmx4fyCQcJBvX77fAHzteGUnOXW/2WkGM44B7WqoTl/DA69I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcNernnb; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7178727da84so3284874a12.0;
        Wed, 03 Jul 2024 09:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720022536; x=1720627336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BV1NRVd6+8QOeMy6RKDnNQikMEGyoeyplnHtMAi0lv8=;
        b=CcNernnbDqwJsPAlceHBLf3l/QEGAZ4cqchFY7MxprtcbaqV27MOJmUTwu4hHCF9YY
         SS0F/2d4qQSv4TiJiRqVw0fdAAnHH9RMaM67XvE5L/cZtQonhnZMI73hCla0rp+ZNRsX
         qsI7PC68cLq/pITFtQrTtFH7HTWZVe2DfM9aFnHxhb0YYaxFdQ6ABYtBEfghq252Uc7s
         U1qV9goqsZcq6rqjcKbCIWqyqBrIcwSyaM7uBqYHey/jfG6FGzIpwj36CjvLcqFIN/wX
         AlM+NHCQEphqdB7nNWTL30h8EEg3Q0ms9ZrOMupkU0NbJKyx9Dl7lu8aNUQtyD6Bebkh
         Fjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720022536; x=1720627336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BV1NRVd6+8QOeMy6RKDnNQikMEGyoeyplnHtMAi0lv8=;
        b=YffMVnrcyMeJ24GVFHeOk0Jbw1QJ/cBnSfomaYTjge0MFne5XZgd22Ddp9Vjp1l03n
         qdqZSyN2wgJndgVGoHWRyFn9oOjJDlHAfKnC61HRL48HpEqw3c+SwUzQixAWWvq+QOB6
         hfj1KizKlpWQpcYLOc4zZROn9B8Q8T4P0rQWNJHKhxbY5ZTGpdgy1eazLJmLwbWEwKZ6
         dd7RSj9uIt9xP22LDTa30Uw6L5E0NjNnWnDlP2NxeZ1Ka0VDPDVpCfi1+ovxU93LlkQ3
         iGpJscqYBZ2AJQP0FZ13I3/boB5V55A5JJ9bcTjjgTCtn3/GkvOOxeXEKF4xcZm8y6eS
         1IDA==
X-Forwarded-Encrypted: i=1; AJvYcCXiK8LPPkDkW5j15+OIjrPUdY5V50c4VD6TOo/rydnaxr4G3FVR3Do7TIdoFfhhXnl+qDl+uAowt/1WjsVrNaW1Ph/zTcQKd9Y/RGgb2Nm+7EIdzg3D9Zv3FN6uEfVA3d5Ot4U+
X-Gm-Message-State: AOJu0Yx3YMk6o7m70r8KFyEvHznR4Pi/QfztlksxMg5SANo91RkECcy9
	NB1x49PArsPsxcAcXLF03RqZm/wpdD7igPq1/EeBNXJykxFyawsq
X-Google-Smtp-Source: AGHT+IFi5c4YINJhrwQwETCSze2/5k6xB9B/isHptGfKiFOVbUz2hUcppkvRF78iCs3ILpmX1/dFCg==
X-Received: by 2002:a17:90a:e795:b0:2c9:6f91:fc43 with SMTP id 98e67ed59e1d1-2c96f91fd44mr2536498a91.3.1720022535920;
        Wed, 03 Jul 2024 09:02:15 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce432b9sm11090471a91.15.2024.07.03.09.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 09:02:15 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: michal.kubiak@intel.com
Cc: aha310510@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net] team: Fix ABBA deadlock caused by race in team_del_slave
Date: Thu,  4 Jul 2024 01:02:10 +0900
Message-Id: <20240703160210.83667-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZoVrzGBouwEQU3Bu@localhost.localdomain>
References: <ZoVrzGBouwEQU3Bu@localhost.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=Y
Content-Transfer-Encoding: 8bit

>
> On Wed, Jul 03, 2024 at 11:51:59PM +0900, Jeongjun Park wrote:
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(&rdev->wiphy.mtx);
> >                                lock(team->team_lock_key#4);
> >                                lock(&rdev->wiphy.mtx);
> >   lock(team->team_lock_key#4);
> >
> > Deadlock occurs due to the above scenario. Therefore,
> > modify the code as shown in the patch below to prevent deadlock.
> >
> > Regards,
> > Jeongjun Park.
>
> The commit message should contain the patch description only (without
> salutations, etc.).
>
> >
> > Reported-and-tested-by: syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com
> > Fixes: 61dc3461b954 ("team: convert overall spinlock to mutex")
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > ---
> >  drivers/net/team/team_core.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> > index ab1935a4aa2c..3ac82df876b0 100644
> > --- a/drivers/net/team/team_core.c
> > +++ b/drivers/net/team/team_core.c
> > @@ -1970,11 +1970,12 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
> >                           struct netlink_ext_ack *extack)
> >  {
> >         struct team *team = netdev_priv(dev);
> > -       int err;
> > +       int err, locked;
> > 
> > -       mutex_lock(&team->lock);
> > +       locked = mutex_trylock(&team->lock);
> >         err = team_port_add(team, port_dev, extack);
> > -       mutex_unlock(&team->lock);
> > +       if (locked)
> > +               mutex_unlock(&team->lock);
>
> This is not correct usage of 'mutex_trylock()' API. In such a case you
> could as well remove the lock completely from that part of code.
> If "mutex_trylock()" returns false it means the mutex cannot be taken
> (because it was already taken by other thread), so you should not modify
> the resources that were expected to be protected by the mutex.
> In other words, there is a risk of modifying resources using
> "team_port_add()" by several threads at a time.
>
> > 
> >         if (!err)
> >                 netdev_change_features(dev);
> > @@ -1985,11 +1986,12 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
> >  static int team_del_slave(struct net_device *dev, struct net_device *port_dev)
> >  {
> >         struct team *team = netdev_priv(dev);
> > -       int err;
> > +       int err, locked;
> > 
> > -       mutex_lock(&team->lock);
> > +       locked = mutex_trylock(&team->lock);
> >         err = team_port_del(team, port_dev);
> > -       mutex_unlock(&team->lock);
> > +       if (locked)
> > +               mutex_unlock(&team->lock);
>
> The same story as in case of "team_add_slave()".
>
> > 
> >         if (err)
> >                 return err;
> > --
> >
>
> The patch does not seem to be a correct solution to remove a deadlock.
> Most probably a synchronization design needs an inspection.
> If you really want to use "mutex_trylock()" API, please consider several
> attempts of taking the mutex, but never modify the protected resources when
> the mutex is not taken successfully.
>

Thanks for your comment. I rewrote the patch based on those comments. 
This time, we modified it to return an error so that resources are not 
modified when a race situation occurs. We would appreciate your 
feedback on what this patch would be like.

> Thanks,
> Michal
>
>

Regards,
Jeongjun Park

---
 drivers/net/team/team_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index ab1935a4aa2c..43d7c73b25aa 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1972,7 +1972,8 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
        struct team *team = netdev_priv(dev);
        int err;
 
-       mutex_lock(&team->lock);
+       if (!mutex_trylock(&team->lock))
+               return -EBUSY;
        err = team_port_add(team, port_dev, extack);
        mutex_unlock(&team->lock);
 
@@ -1987,7 +1988,8 @@ static int team_del_slave(struct net_device *dev, struct net_device *port_dev)
        struct team *team = netdev_priv(dev);
        int err;
 
-       mutex_lock(&team->lock);
+       if (!mutex_trylock(&team->lock))
+               return -EBUSY;
        err = team_port_del(team, port_dev);
        mutex_unlock(&team->lock);
 
--


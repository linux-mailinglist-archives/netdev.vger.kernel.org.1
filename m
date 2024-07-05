Return-Path: <netdev+bounces-109545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED19928B80
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 17:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5909E280C4F
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2160814AD30;
	Fri,  5 Jul 2024 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPnn0MJm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5D91487D8;
	Fri,  5 Jul 2024 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720192749; cv=none; b=laA44izNH3uIda8Lnz66w5u5b1RqUb+9w3CsLBA9s8/c46Xcy3avDdluzyeL5UGiwkxs/10Jn5o1bZmd+rbXXZagsD2gQMBPFZ6SOmHvbFllQvlzLOIALu5Zdg14bc8Ie4/PWG5vOl7SZH7sb/LtsRXkEmCqR0Msc8q8sf9FWfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720192749; c=relaxed/simple;
	bh=RFnFLxpFbGDtT10Dk/Tdh98X48tsX08DjcEQXQCwsG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUJd5KYN1XvndxZxdqsS1ej+lenrljRsT3WhhH3w5Qag24Fitj8x+ZVUjBtCzBwXjB7AiN85YB1LjftGkLhTj1v9dVACDFKeVvgN6e+JqsIDy26S2W2dANxXhj35pMOi1VjL7qQigY69aBkkICAWqNKjc2Za2S2xVrVdNqkE0y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPnn0MJm; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-702294d6265so1118505a34.1;
        Fri, 05 Jul 2024 08:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720192747; x=1720797547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfgcjToHDms+e/xA2Hsd4lyRapgO6QBy6Yt2Qi/WJcY=;
        b=iPnn0MJmzNKMM84I8BiQzyiFvBpR76Z1/AtVWz/Ab3wY0fPT+7xHpqpxYWXgG7cBQU
         /f3Y3FvXqL+5ZJpG7dLCJOXcn8XXJUCgPq8DC25bQAEm0q7PzPmsuYBI57nZse20HxgE
         FyWwWeG4AY+32RaiQK10bRp1KYd6GAf0lI1/irJgVe+qUURwd/HLhCddIShpMeaD6+wK
         Th9X+VpHDA/+Tm0joNgXt5wRi6bAh3g1CKLEMui+VD584OrX4WmPBHRuD17mj5wMwLjr
         2CSzHCVoKgSf01bSwDnLzY90n8tOj5WuEJ8zLhD7rLYmK+hbqGmQYdHAl9rRy5OXFijE
         AObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720192747; x=1720797547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfgcjToHDms+e/xA2Hsd4lyRapgO6QBy6Yt2Qi/WJcY=;
        b=Ul5gkvxVdeHFgUvuvRsdcE5+haNdfG0VgjGaL1OcmAkE8Dtzmtgo4lWhAMBlWwemfG
         ywSBoGdPtUD2Dupr4bI4kVjCrCxdpM03zRGHD6yy/yggxpe9wvd4R4mn5kH6i5bnExke
         tvWWIkAy6TCJusGoSOjQG6DDbhPogQFeW7Ari8PNwX8d4IJUuaVMMOfvU5uVJ6SHp2uU
         O1B9Z9KCdCX1ZfS2OEbCpYv6pHU3Ouf0y1y7Uom5nQPB2sai/1hjFZCyuNHtWSX6CgRt
         CfUbgJvfdY1gWBzFbsWEMAIR+080zdPkp8dF54zYyc+WJqPxS7aqkWdoVd19A9k8rCDt
         GpsA==
X-Forwarded-Encrypted: i=1; AJvYcCV1ExtXTkcTBgBkGq3xw1Kr+8+Jq5WQhrctwLIJFl80Ypr1yaT/FUjO0GMmtNRrLHYRXo6f00wtZOZ18/Wfie60f4KQ+0YATWLTf/lia6THFG2yGQU10OD6j27EZC4XhJRJ9HeI
X-Gm-Message-State: AOJu0YzT8q2NBILhGB8VqTWbiHnXBVzQyuhU2h324NKVVb39cy1CNWPa
	zpCvC/fUS+T623G3ExmyCpEu624hXi8K1n/2Wt9kcqLx8hlSm0Vt
X-Google-Smtp-Source: AGHT+IGj09BYI4AoXFXbl4HIMN5eYqJfhUFpuaRzrTu+XlgaJmIgRV2oGaVo/F6rlNg9FL3H+RKRQg==
X-Received: by 2002:a05:6358:6f0f:b0:1a5:2f55:c47b with SMTP id e5c5f4694b2df-1aa98c2430emr514351355d.10.1720192746611;
        Fri, 05 Jul 2024 08:19:06 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6c7f72a7sm11087720a12.63.2024.07.05.08.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 08:19:05 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: edumazet@google.com
Cc: aha310510@gmail.com,
	davem@davemloft.net,
	jiri@resnulli.us,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	michal.kubiak@intel.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net] team: Fix ABBA deadlock caused by race in team_del_slave
Date: Sat,  6 Jul 2024 00:19:00 +0900
Message-Id: <20240705151900.94546-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANn89iKbP4r+uAkHiz8_pdMB9XWoyRWR0NJ7ZuNCOr+LiFr9zg@mail.gmail.com>
References: <CANn89iKbP4r+uAkHiz8_pdMB9XWoyRWR0NJ7ZuNCOr+LiFr9zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> >
> > Thanks for your comment. I rewrote the patch based on those comments.
> > This time, we modified it to return an error so that resources are not
> > modified when a race situation occurs. We would appreciate your
> > feedback on what this patch would be like.
> >
> > > Thanks,
> > > Michal
> > >
> > >
> >
> > Regards,
> > Jeongjun Park
> >
> > ---
> >  drivers/net/team/team_core.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> > index ab1935a4aa2c..43d7c73b25aa 100644
> > --- a/drivers/net/team/team_core.c
> > +++ b/drivers/net/team/team_core.c
> > @@ -1972,7 +1972,8 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
> >         struct team *team = netdev_priv(dev);
> >         int err;
> >
> > -       mutex_lock(&team->lock);
> > +       if (!mutex_trylock(&team->lock))
> > +               return -EBUSY;
> >         err = team_port_add(team, port_dev, extack);
> >         mutex_unlock(&team->lock);
> >
> > @@ -1987,7 +1988,8 @@ static int team_del_slave(struct net_device *dev, struct net_device *port_dev)
> >         struct team *team = netdev_priv(dev);
> >         int err;
> >
> > -       mutex_lock(&team->lock);
> > +       if (!mutex_trylock(&team->lock))
> > +               return -EBUSY;
> >         err = team_port_del(team, port_dev);
> >         mutex_unlock(&team->lock);
> >
> > --
>
> Failing team_del_slave() is not an option. It will add various issues.

Thank you for comment. 

So, how about briefly releasing the lock before calling dev_open()
in team_port_add() and then locking it again? dev_open() does not use
&team, so disabling it briefly will not cause any major problems.

Regards,
Jeongjun Park

---
 drivers/net/team/team_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index ab1935a4aa2c..245566a1875d 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1213,7 +1213,9 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		goto err_port_enter;
 	}
 
+	mutex_unlock(&team->lock);
 	err = dev_open(port_dev, extack);
+	mutex_lock(&team->lock);
 	if (err) {
 		netdev_dbg(dev, "Device %s opening failed\n",
 			   portname);
--


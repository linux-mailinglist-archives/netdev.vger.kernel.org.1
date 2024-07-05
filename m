Return-Path: <netdev+bounces-109544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA14928B7D
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 17:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE98F1F2140F
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBA416C684;
	Fri,  5 Jul 2024 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htes5xZh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A52614AA0;
	Fri,  5 Jul 2024 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720192648; cv=none; b=UF5w5QjsOTSTNQQbTxDgtjRtUFzejx5ObcePOl0i3r2rzOCwe4uLelaVp4BKetjvV2cDshiHwpgqLv1IZOeChZ1dhMCDt1HipAJl/KdBRX+ukaehl0fT6G84VKL54QcbA4AhLJHLue9GOI0CSXRZMB2HNxuTHr1KWtJQoQPa8Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720192648; c=relaxed/simple;
	bh=RFnFLxpFbGDtT10Dk/Tdh98X48tsX08DjcEQXQCwsG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+1VNYPSJMTNvnz/f+TS+mpnMW8qXAIGWNk/JFO62z/nC5qNwhQzqyou2ebOVJMUhy74a5pG7eTIHi875yf2aL1XSMP/p0s0quQA+apX6Ooh2Dk3lv/whOn5sWkznJU+njjiWHEBLlrpM6t+W+BCAcw8PBdPxS3Kb3q3IAi2EjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htes5xZh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fa9f540f45so11080785ad.1;
        Fri, 05 Jul 2024 08:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720192646; x=1720797446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfgcjToHDms+e/xA2Hsd4lyRapgO6QBy6Yt2Qi/WJcY=;
        b=htes5xZh8VNE+xY5+SscRBp32MDzd1w/a/jVWwYxLZm6oz8Ig8sLC9iGYHnbfX83by
         iaxXtkXoxWASR2jkEvWu2FYV4J6cEZosrpKZ11cJ8Hl5m8qewZP8FpFFUVRaBavoqNd9
         EH+48LPZ2E1/BA9YUPHrU9OWBjRWNPXCCEFjyt3FZxMiJA4hZqetpbd9rcxJRXCaRa+w
         Bog2l6aMKzViOb5paDfB93+w1tB0DvxvqbpKYWPtIZL8W+BeTFCNdLEn9tYYsvgEaLU2
         7VoLsTgW//rm4Ov6213XvGRgKTiDvqsp6ko37uUnsWIGnZWxEEQcLoaMC37wafGlTxgR
         qQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720192646; x=1720797446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfgcjToHDms+e/xA2Hsd4lyRapgO6QBy6Yt2Qi/WJcY=;
        b=lDTAvrpa4Eo3eZ+kVF5KGVs3V1jV0NgTmf7kpUUfloqcISSQMLOiByA7YCZd+ry6th
         IKaXYXUI9YZ8qel0TOexlr7Xtd40w13LPRpaEpCdnpuVD/MufWxJjm14rA/dqV+rxMAP
         p6axTkVLG9Db5avbju1+XSulwaNeggCq/oQjzC7tuoOA7DYkAaw9Us1GjOaCAP0pYdgy
         QAzwMozbEUZ0VkLbm2FyXxepvq4DpywJPLZryhSfqVRzQQjpoEpO2F79l5z/28zZU0VH
         Xcj0qsW4IgeSh9fmtJKBV78bO+zEGD1RI7EP8S0IMcaLubgDJJ50XDmocLuCAU8VESly
         hAOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbSN2BvCNZ/y85DCcI47kplgNcKhRXZGsvpR3U7cFE/Sdm2QvnaHBYYl9kdazr+PsLO2ysaJxeFa8vIWfuxFSngIKTWq6XlMVj22XXBRU8IEgy72vdapPX0KvHPoA1f2QVS270
X-Gm-Message-State: AOJu0Yz8m9fp2Y3y0ixv79F2CfeurhgrGbL8iWnW4T/jHDmjRzYJGhEo
	SNzR7WrhbwBsfy0FXjDUZmmV4jYAqeHfOGN/GscGG42EcgMKP9qq
X-Google-Smtp-Source: AGHT+IHmv3SnKy6Cb7LE6Yl54nI+nlP3nioCJboV1xyLRkn6pPGtG7vxfxO0L6WHLCgUBeCqZemDNA==
X-Received: by 2002:a17:902:d48f:b0:1fb:5d6f:8ce8 with SMTP id d9443c01a7336-1fb5d6f91e4mr4478835ad.52.1720192646179;
        Fri, 05 Jul 2024 08:17:26 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb5e284269sm1043535ad.187.2024.07.05.08.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 08:17:25 -0700 (PDT)
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
Subject: Re: [syzbot] [net?] possible deadlock in team_del_slave (3)
Date: Sat,  6 Jul 2024 00:17:19 +0900
Message-Id: <20240705151719.94431-1-aha310510@gmail.com>
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


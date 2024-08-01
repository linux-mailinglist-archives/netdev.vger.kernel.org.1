Return-Path: <netdev+bounces-114791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D82AC944108
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 04:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156231C23DDE
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 02:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30111422CE;
	Thu,  1 Aug 2024 02:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMEDZa5N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B73D13CAB0;
	Thu,  1 Aug 2024 02:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722478578; cv=none; b=BCWBJFtoNV6hjnYNOGR8ggo1KqlX8si4TGBRe1oEZSuBX579Xh5grfsIsCSxFC40bMABCukXKmlzhk1AhmNqDvdOvPk3u0Rx0tthukKJH32KYhZ4U8GsrTSSL3A6fBh02sY9vF6srualLtI98v7C2CqEb6fduALK8ZL6N5z5+60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722478578; c=relaxed/simple;
	bh=2HoOPqm+n1OLGJ/DowF/fcV3eBGIO5mRMI0Gloh8tTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnWFq2KK8Y2n5UufxrSS5a49x6GVGx19tbgs0EToqlwSwx8nYy3jkDacAL/KDySpXWe8+AazyFiOcdeUdotTVTm4BNGCjuXGj2quYbw1SkGhl3rkEmqozISHY2n4MkDPfzkRcF8v3KPTWnBbXs15Pj14loK+tiexOJaajcRqVIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMEDZa5N; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70f5ef740b7so2506006b3a.2;
        Wed, 31 Jul 2024 19:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722478576; x=1723083376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ejq2C3F/dAPbPhSGNK4nAupqeIE7GfO8x1h1qatpwug=;
        b=JMEDZa5NW5+fpV7wzavjGN0zgPE89/K7Cit/SKrHp7A7IXqyWdbgzI8mfoeFGvDPtu
         giAY19trytHsqZW/1Sk54CB0X4VXx+eYOJtfxdLy20vXRNAhxyQoX8v6genaPNlOic+Z
         hlFRTIGUwnG3I5EwMNnRMNh5pBAwm2+cd245UvoxR+z3kGgYjkJlWfsoezEjO5fZEDC3
         3CvYJQVdEoX3aidtswRFyewiyoVfFtYR6+kRpiTIe1fFJUiQ91d4Q/SZW5BUPIHzVuHl
         dIDduLNQQH6BzI3f2fltQ9fwraZxhdM7CbExCrQ+XId5tpKMXtb8HDryGZS4Dc7fTdo5
         aVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722478576; x=1723083376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejq2C3F/dAPbPhSGNK4nAupqeIE7GfO8x1h1qatpwug=;
        b=S3vWTkW5DQO9kCANyoI5w+6hG72m3cltJ0xjYHEMdmzsDzyeif6dTcT22mJf7i0Jfs
         DFlG3aWZT0EykUNuYGXqRucbT9WvpcjkE8hL4iW3AhdLz805Qta8nVsyb4DyzpVhmjmq
         Elzs5KIAplsISaaBZHAPZfUdNpqu2ULbmP6DSNpyPOmCIR31aZnDd9SgM8ZtND5bKr1N
         G9m5lKvqTTR/dMp1LAQr4AXwbLNM6dnsO4OGJ3HhXaiBEk4id9Kcd/M09QPfxV3e1P+r
         jkKfMPmgYLRfPAOQegvr04KBGHs5QMbYQmnuScmWs8zAQjkKynNZmGv5xqYqpsgShbbV
         p/rA==
X-Forwarded-Encrypted: i=1; AJvYcCUELRdWmO1Ol/JrLn3Eu804KVRDvRpiO8/XWD7Z+v/TmKykLd/BAT6rMnz+NnW/iEGOVO5UngewnDvi+Us=@vger.kernel.org, AJvYcCXKKlUMa89JtMFj4ytDd9R0PdCv3ZmjqREJ3IxxnkELAAKKk1y1PL3z2z93CeiZyva3BxB1sqng@vger.kernel.org
X-Gm-Message-State: AOJu0Yy57vX7wtICBxbHf6XkKXYteQNrzbwUFxx334lyQ8yY87J+/oNJ
	tTq3xlrE1Yp4vSGp+jKiofKYBSeyoA4CdTr0oinfOHRoxvcVKiBi
X-Google-Smtp-Source: AGHT+IFWw4mzX8dteIjYqTEzi4a0VvHR94VUKHWAasKvzM/xbT6ANPQqN6jo80HjiYqOH2g+v9A5Vg==
X-Received: by 2002:a05:6a20:914c:b0:1c2:92ad:3331 with SMTP id adf61e73a8af0-1c68cec8eb9mr1940906637.2.1722478576483;
        Wed, 31 Jul 2024 19:16:16 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:782c:bea0:2ba1:46ac:dba6:9de4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8d376sm127671345ad.18.2024.07.31.19.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 19:16:16 -0700 (PDT)
Date: Thu, 1 Aug 2024 10:16:11 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, nicolas.dichtel@6wind.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com,
	syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com
Subject: Re: [PATCH net,v2] rtnetlink: fix possible deadlock in
 team_port_change_check
Message-ID: <Zqrv64570Zp9HaxZ@Laptop-X1>
References: <20240731150940.14106-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731150940.14106-1-aha310510@gmail.com>

On Thu, Aug 01, 2024 at 12:09:40AM +0900, Jeongjun Park wrote:
> In do_setlink() , do_set_master() is called when dev->flags does not have
> the IFF_UP flag set, so 'team->lock' is acquired and dev_open() is called,
> which generates the NETDEV_UP event. This causes a deadlock as it tries to
> acquire 'team->lock' again.
> 
> To solve this, we need to unlock 'team->lock' before calling dev_open()
> in team_port_add() and then reacquire the lock when dev_open() returns.
> Since the implementation acquires the lock in advance when the team
> structure is used inside dev_open(), data races will not occur even if it
> is briefly unlocked.
> 
> 
> Reported-by: syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com
> Fixes: ec4ffd100ffb ("Revert "net: rtnetlink: Enslave device before bringing it up"")

The fixes tag shouldn't be ec4ffd100ffb, as the issue exists before
ec4ffd100ffb. I think it should be

3d249d4ca7d0 ("net: introduce ethernet teaming device")

Jiri, what do you think?

Thanks
Hangbin


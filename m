Return-Path: <netdev+bounces-250908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 551C9D39897
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 18:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EA9730056E8
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 17:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472672F39CF;
	Sun, 18 Jan 2026 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3HWkvEK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84522F261C
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 17:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768757718; cv=none; b=DCma3Qrob4dUC3zMqg8Tc+dnKMoT+wd3iZms9LQkF6a0uFRRys1tUlMv/Jb4ylm25Lxkvgh/AnKnRdT9rGHowe7d3EhC+Ehg9QrYQYMfyZ5va/rjblwiFjKllmxcMvK/UWFp3wSe+kdWPmWGwHTii/IY8kIGQFEPyv/1SycXR4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768757718; c=relaxed/simple;
	bh=1XjJMml5OQHthHhA3ZJ+DGh77+QauGSNKbPL+AXXDOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q74uP3M06vwqdKq4lysN5BIajYMjanypw7NVMBHfLkbMe2bEA3gvggngozJTDoOIYp31fM8USBbNQ9znv33FmUiXJ+YN//MBnsOUqMWPRe3975Zh4U8foA3haup8izSHDrXOo7Qh9VYhj+qeSLm2MYg0a2/lmoQXI6KM1r+jTXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3HWkvEK; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b876c0d5318so489627366b.0
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 09:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768757715; x=1769362515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pGZEHCPvQHmUu6ZZAHCVz+kl9sfR9JLyuBUpjMnyHL8=;
        b=h3HWkvEKKGJzTpxkwG9bvkRXr5RPqRabGvsoGSv304WVI1dyZqMCsqAObaJ1SDhCF/
         WtbWaujJHUaHqoTWFpvthfeHIUJwusghfpSIAUzOE3kCInyrUjhGkACgD7oshWWBDG/A
         XyQfnrB9u2TDPzA+42vVKD453juaeh7QQ3nB335Yh8HO6cLJO8ypUjwO38EtzMXyq4/Y
         YkdKN8mhfpOVy/xKeNfPbAHUMngf9ZYplSjtup5qpi7jVO19BEFErHktTqK2meWtnTVK
         vFGAfew8p0QbiiBAId6QlOPzGVB0Fk64cVc1V4Q2WkGjQ+lTaKy8uDnFCEgV+3HRsoau
         rmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768757715; x=1769362515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGZEHCPvQHmUu6ZZAHCVz+kl9sfR9JLyuBUpjMnyHL8=;
        b=Wvp9W9nS6F80I0qRrenYHXXAsHtOPJx3qmIasdO+/4r5CKWo1WVBTHvoauusjA3y40
         UWxw05e8lRz+QceyFio6tReVZqPe0VPxP0VrUEjuzz/N/bWaJZiyt/4K95ENAls+wRdH
         k/KGabjGl/vJCnw3a/Exm2pzl+AgC9TeWVj33FzpGZSwHoyPt2LneA+biRUirmLWj7vE
         TR9/V+I3njskahz/R6XLmCgyH3DJy3KWkHRxhU9Xph0sJD8e+IYhK9U4yIsyZ72p2FS/
         KRe8EmXMPF2U+MtJcM38aQar1IY2Ubm32Zqir6Fkf5JMfMs4Rg2lFFPrBYj3o1KGl5i2
         Zdgg==
X-Forwarded-Encrypted: i=1; AJvYcCUqNKejY1MQ8O6F6J/90DZvMRZGLKh1j+5zYmhwCWCqpnsf4Ap2fESRpIA2t8HmEA5PGULR6Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8iqZ0pH49Y4Pn33QsGqzn7Eh4/+qtDyqi+XjvpCfzG/Zm21tm
	CWTxXajE0yk5W86mYuLOzD3GZDRNhvBVQEkg8azCBzubPV1waHfZ2iop
X-Gm-Gg: AY/fxX7LBiduYutBrWQGKfK8oEXhPibEteHewS4ACJX48Vuf5fWC11br5QlzOYkeLD1
	fy91Dovo6KfMwW1GRKlu9L8KgzS6AecHogpiZOTWopTmi41IjjtOeixnKsaLCDsPmhIAHXToq7F
	VVxq+t1VFqMUyAbr8riic0b5gI5wNNoKrrbHAVuwpyiuVfWzQM6b5VPARAa3C9vLOdMeaWzcPLb
	3KV6RUk9eD5lhWBtmZuS4jqxA2xd1gDPVYxLyBjS+8fHonJfiVEu2PtMR9Q/RzAsFqV0xFPd2yz
	dDPfOmswtYCNf0NR/7IohvpwsG/YzGON9z09AvNKAkuW0EvjbLqZX5scL/lIkILE8EfYEYnalw3
	QgX90o58hUO4thZ7B5r2oujWjbWiavsiJcpmg1EkDtGvO9fEjMOCijS9L06+RE9x+Y6f8OHYM6i
	LVMm+AlBAd2+0=
X-Received: by 2002:a17:907:1c02:b0:b80:a31:eb08 with SMTP id a640c23a62f3a-b879302426amr752483166b.55.1768757714447;
        Sun, 18 Jan 2026 09:35:14 -0800 (PST)
Received: from osama ([2a02:908:1b4:dac0:5466:5c6:1ae0:13b7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-654533cc4b9sm8173672a12.18.2026.01.18.09.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 09:35:13 -0800 (PST)
Date: Sun, 18 Jan 2026 18:35:11 +0100
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Sjur Braendeland <sjur.brandeland@stericsson.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+f9d847b2b84164fa69f3@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: caif: fix memory leak in ldisc_receive
Message-ID: <aW0Zz9SNbxJRxghp@osama>
References: <20260118144800.18747-1-osama.abdelkader@gmail.com>
 <2026011805-bamboo-disband-926a@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026011805-bamboo-disband-926a@gregkh>

On Sun, Jan 18, 2026 at 04:02:44PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Jan 18, 2026 at 03:47:54PM +0100, Osama Abdelkader wrote:
> > Add NULL pointer checks for ser and ser->dev in ldisc_receive() to
> > prevent memory leaks when the function is called during device close
> > or in race conditions where tty->disc_data or ser->dev may be NULL.
> > 
> > The memory leak occurred because netdev_alloc_skb() would allocate an
> > skb, but if ser or ser->dev was NULL, the function would return early
> > without freeing the allocated skb. Additionally, ser->dev was accessed
> > before checking if it was NULL, which could cause a NULL pointer
> > dereference.
> > 
> > Reported-by: syzbot+f9d847b2b84164fa69f3@syzkaller.appspotmail.com
> > Closes:
> > https://syzkaller.appspot.com/bug?extid=f9d847b2b84164fa69f3
> 
> Please do not wrap this line.

OK.

> 
> > Fixes: 9b27105b4a44 ("net-caif-driver: add CAIF serial driver (ldisc)")
> > CC: stable@vger.kernel.org
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > ---
> >  drivers/net/caif/caif_serial.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
> > index c398ac42eae9..0ec9670bd35c 100644
> > --- a/drivers/net/caif/caif_serial.c
> > +++ b/drivers/net/caif/caif_serial.c
> > @@ -152,12 +152,16 @@ static void ldisc_receive(struct tty_struct *tty, const u8 *data,
> >  	int ret;
> >  
> >  	ser = tty->disc_data;
> > +	if (!ser)
> > +		return;
> 
> Can this ever be true?

Yes, when the line discipline is changed, tty_set_termios_ldisc() sets tty->disc_data = NULL
> 
> >  	/*
> >  	 * NOTE: flags may contain information about break or overrun.
> >  	 * This is not yet handled.
> >  	 */
> >  
> > +	if (!ser->dev)
> > +		return;
> 
> Why is this check here and not just merged together with the one you
> added above?  And how can ->dev be NULL?

I'm going to combine them in v2.
If ser exists, ser->dev should be non-NULL (they're created together), but the check is defensive.

> 
> And where is the locking to prevent this from changing right after you
> check it?
> 

I'm going to address that in v2.

> thanks,
> 
> greg k-h

Thanks,
Osama


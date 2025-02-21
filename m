Return-Path: <netdev+bounces-168623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2091FA3FD33
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 18:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD289188C0BB
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 17:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE22224E4C9;
	Fri, 21 Feb 2025 17:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evyTDHtF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E79024E4A2
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158163; cv=none; b=MAojNSqWoWB4MuJaC6fpWktfYYy/O9Md9ikrviBFs7slT/PZW51SAYi2UnUZdhHN5aUgOHWyDDdhEyEJxwnbRmettorgCRgTlZckxFgvCFW2FnGi7Yea9XGvCOm1v3lkEY0IYS/ZZNjDWfORte1E67NVMgABPSWeQoiOtwxK3oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158163; c=relaxed/simple;
	bh=LuYSFr/mRUT4yzTGhbrQavfUfsRw5mdDa/QJCVAmfhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTqIAo/0lJv94txm6lgwWGRA26Px7AUUqIcTQXuuk9wciLB1+qNcjn4GEG9JdWOzEs7nuIDWeMPIN0T+JIozO2Ic1p4M5O0IVlJA6pOQ89dI/casfANLyqM6Au+tVnCK99c0LELivPufHNlekcwIdgEQJOdJ5pQOOrAvg93VuRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evyTDHtF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220c8eb195aso53113105ad.0
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740158161; x=1740762961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TKHhhdXji6Dk04xw36WFay3nDgbF5w60+ErEsgzhfgo=;
        b=evyTDHtFgt/4PWs8uTI4ncd6uILO/DPPgspgNkMHUx/8Y2egh6fmo2Pa3Zo+Mhepny
         W2vcan9XK2+d2pIqNq71Kk5tveFqbYdBNiNhPD3IUk2ZEqzAV8gLOZ4aqbRv0Gms5Xhg
         PVyJRqlL5asoGiiRneZH2NTBoeWN4ZYFsnu3A53SSqQvNbMmjUQAXD/wbdVTJd8pizn4
         ORXYlSl9Dv/RWgGQHepSGulS3GDIHXoSNj+v25iPEAs++i4UUeTtCRREUbMIaVzj0u6x
         j5DcMHZj4AUyobhiVJ0VK4hY4bDm9u5X0Oq/iA4DO++An1/xIo3+OO0/lfA+eDl7WN6b
         PiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740158161; x=1740762961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKHhhdXji6Dk04xw36WFay3nDgbF5w60+ErEsgzhfgo=;
        b=xRM9O9f2Fbals6fUbjn/OeZZ+umw0kx3p2yXHiEiHn2AEt9CBrCW9WMMQlNTJ2+CjW
         D9zQ/LeBS1Ribof3C5aKQUuYOdEVa89GHo83h1mViH4dVggzcZEp4gF33AdYkpoNTzn/
         2x/CusQ5U5xusZnn698uhtrJoCSgpqqBrAK+TPYisqk6dHY3BSo6OXKvM6UxrTVOgu/f
         Z4Kxkp5UhBBpHh6wc3sB0fBAw1oSPm6+xBOmry0PR0qw+1UfbqxjoNmYu5BpsKDbnDd0
         XLhJMPw19qAvDP8AmbzM4LfyqJSDwyC2RNih1eK65XuEro1+Ri6GvxrVtHyBJzpedMFf
         qySQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcdY12nVS142oaHI/iwgemTNNiF8Dx0EiZ9CbKsXsbc0MWbpUgWCjCgdP9eDijF52UBUnwpCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsFU+zIk0uZXG0Ez9yxHwn9hOIOwfr9HnBjhEJ6az887YHZX43
	gDpXfxLsSdWuqk3VzAq6NFYGv9za282T2M5ved4PzXITqJZAxog=
X-Gm-Gg: ASbGncuJjn8qswvDxzVrKOpO4wDaf0ASZjauSkEeAQ6SnQgBNmMUXTLvnpzGBp9z9Bd
	ZnSCDKdxyAT65Tnfqm1N0LoewfX4A494/DXLzZXGagH8SCrmx6PCwE9iTqAXOjMlHlcrno0CKGv
	RwjFQDQkgKTcueEGYlSnDjTtFzd+aqEVEXs0/1BcunI1V1CA0V7wOm4KaAmM31kt8x2cy+s2Ryy
	skiDywPxTTYdHvUdFOehtOVmAPjKONtyk3jKbDjgyt2wkrAK4OM6t2zhbAd7vrKDM3BNi5b/5PX
	9N3rk+MXCIS1kIKDc0jKjxRfhQ==
X-Google-Smtp-Source: AGHT+IEoMrLniW+2g43e/c/2ugLcYqeUnoGhc55ymwlUuNgcwJHifNeOdL3t+62iP2d5vbEzsfDz2Q==
X-Received: by 2002:a17:902:fc8f:b0:220:cd23:3cd with SMTP id d9443c01a7336-2219fff2ad7mr80081745ad.44.1740158161309;
        Fri, 21 Feb 2025 09:16:01 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d558fe3asm138651425ad.234.2025.02.21.09.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 09:16:00 -0800 (PST)
Date: Fri, 21 Feb 2025 09:16:00 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next v5 03/12] net: hold netdev instance lock during
 queue operations
Message-ID: <Z7i00BqilLK2xAWU@mini-arch>
References: <20250219202719.957100-1-sdf@fomichev.me>
 <20250219202719.957100-4-sdf@fomichev.me>
 <Z7dGFLSom9mnWFdB@hog>
 <Z7dfqFr-knB3Bv0G@mini-arch>
 <Z7inYue3xLFjlu5C@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z7inYue3xLFjlu5C@hog>

On 02/21, Sabrina Dubroca wrote:
> 2025-02-20, 09:00:24 -0800, Stanislav Fomichev wrote:
> > On 02/20, Sabrina Dubroca wrote:
> > > 2025-02-19, 12:27:10 -0800, Stanislav Fomichev wrote:
> > > > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> > > > index 533e659b15b3..cf9bd08d04b2 100644
> > > > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > > > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > > > @@ -1886,7 +1886,7 @@ static void gve_turndown(struct gve_priv *priv)
> > > >  			netif_queue_set_napi(priv->dev, idx,
> > > >  					     NETDEV_QUEUE_TYPE_TX, NULL);
> > > >  
> > > > -		napi_disable(&block->napi);
> > > > +		napi_disable_locked(&block->napi);
> > > 
> > > I don't think all the codepaths that can lead to gve_turndown have the
> > > required netdev_lock():
> > > 
> > > gve_resume -> gve_reset_recovery -> gve_turndown
> > Good catch, looks like suspend is missing the netdev lock as well, will
> > add.
> > 
> > > gve_user_reset -> gve_reset -> gve_reset_recovery
> > I believe this should be covered by patch "net: ethtool: try to protect
> > all callback with netdev instance lock", no?
> > 
> > __dev_ethtool
> >   netdev_lock_ops
> >   ethtool_reset
> >     gve_user_reset
> 
> Ah, right, sorry, I missed that.
> 
> > Or is there some other reset path I'm missing?
> 
> Looking at net/ethtool, maybe cmis_fw_update_reset?
> module_flash_fw_work -> ethtool_cmis_fw_update -> cmis_fw_update_reset -> ->reset()
> 
> (no idea if it can ever be called for those drivers)

Hmm, and this workqueue work doesn't grab rtnl_lock, interesting..
Let me add netdev_lock_ops just in case, won't hurt.

> > > (and nit:) There's also a few places in the series (bnxt, ethtool
> > > calling __netdev_update_features) where the lockdep
> > > annotation/_locked() variant gets introduced before the patch adding
> > > the corresponding lock.
> > 
> > This is mostly about ethtool patch and queue ops patch?
> 
> Patch 04 also adds a lockdep annotation to __netdev_update_features,
> which gets call (unlocked until the ethtool patch) from ethtool.
> 
> > The latter
> > converts most of the napi/netif calls to _locked variant leaving
> > a small window where some of the paths might be not properly locked.
> > Not sure what to do about it, but probably nothing since everything
> > is still rtnl_lock-protected and the issue is mostly about (temporary)
> > wrong lockdep annotations?
> 
> Yes, it's temporary (I didn't check the final bnxt patch to see if it
> covers all paths).
> 
> > Any other suggestions?
> 
> I guess the alternative would be introducing netdev_lock where it
> belongs before adding the lockdep annotations/switching to _locked()
> variants.
> 
> Maybe it's not worth the pain of reworking this patchset if it ends up
> in the correct state anyway, I don't know. Probably more a question
> for the maintainers, depending on what they prefer.

SG! I did try to to do this initially (adding extra locking, then
removing extra locking), but it seemed to only make everything more
difficult to review (imo), so I reverted to a simplified way :-)


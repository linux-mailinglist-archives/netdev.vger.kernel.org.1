Return-Path: <netdev+bounces-190785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B65D8AB8C36
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 18:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5081916B053
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 16:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8740321B910;
	Thu, 15 May 2025 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0SspptK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021FB145323;
	Thu, 15 May 2025 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747326080; cv=none; b=VFIsRUml6OUZfa+xbtIv1jjOoM5uoazN6oosw3afxTU7J+qLWxLczfr+JkULvgf9RHOoPl8OSCTdAT8mK4QT/nFYyOd5FkQygJh6PJRYtioxdnuVMzgfZaakXOvn8QC5in84+FZEZG6Ec7uX04z1YdJ6JIhCyNBU+qPtkTFLTrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747326080; c=relaxed/simple;
	bh=+MQ4YOLxj0ZQFTdWurLoPysuJ35g3DMCvGKbtMQEquc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pT1IcpyacIw+hZDQHxvhvg8AKkQK6dWDmya5wl9iAuKO8JRpI1Ni/JQoIDkyqcyq2syzH0qXh3vsGyIGxahIo489WU55D/3h5abVKOEGmsyWR3BIA1RjeK+fftb6kXCEO6aRVUnmSCKNyeJ+H9fQboB38+IP/e7BWr3Bz8tgHKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0SspptK; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso1314842b3a.2;
        Thu, 15 May 2025 09:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747326078; x=1747930878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bbbwkevk/2CVqwqrrWHJNb4ZAmsIL5ei/3Bx8vGe0is=;
        b=K0SspptKLIEWr8Y6ufM/QXYvPrbnth1tKQSYlJ+92WQNJqck8Sp09hsgoJoNyBIYW/
         tWZn2LdC/14HB9gDS2za9Wzm3x/a5UOZ0+zUGj/rqx1exjZSRmq8rLgfa0PkqP79Ynrr
         csCnQmTRa+dm82L/jkZJ4/96EQCJk8ao1VpmNTf4xNzBeacbkjqe2nGZIXcEilSTne+W
         vmfTy0Wb4ZtbJUAVCBZgbOtv1Q3+uICnoAC3q7YjcS5isPkNDdJbZAfcKhJXyR6VvJ3I
         64sYMlVd7BXgbZtSPMf/5CSROufCF3yej3iDqZyCUZuGOKxAcjPCUDuIPvJeDjxuMnbc
         wNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747326078; x=1747930878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bbbwkevk/2CVqwqrrWHJNb4ZAmsIL5ei/3Bx8vGe0is=;
        b=C5j3MRc/W+2nSD3spmV1+ZTnW/21FTy6EKSQ0SZ39d/DUVJViJSC+ekf+1Ba2uJxnP
         m9Xa1GIcXbutefajTq5mO0zRDU1Qw+XrJL76TBF0aHsCK5Dsw/gy3yVninq6CxXBj940
         SZ/Ybv1baEScUIZaJCmw/qrlXvz3nAdvkXaxYexVmP/m0MvVWYVTVc4LKQiICJp0aB5I
         QIBEszoovMuRfRUqee1NynRlNQvXiv29Jl3Q/crAMapRGRhBdYTTxSKyM+p2y0YY0HsD
         7HWAa4z8LYNiiuCygitJOjZxs+Gm6ekVHIf5oOD6Azrd6cVjvVQMJCYNSqFCjjPM7ddZ
         U+Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVhsN28MRKblzOOCF9dBfbUkHjTTTEAJ4RtQ4EKaDPnPUT0sOWWUWL2PMAjVetfUCrmePBmOzVKGdVvNBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhF10Qix+EVlRxaYirCpsaKsq1CyVoKbld1gVGCRs2srvJTo65
	NwPLBFwlCqnO8kE8kHqgM826LUjNJooH4HbU6DIKCu7uv5LWTB4=
X-Gm-Gg: ASbGnctolxQgQ09dI/kRJQicEKRv/0X/F5nVvW6jekBYemEFzPv73hmswTeZycq2Qoc
	zvJZN5qpLV6YJXvRRc2YvbHyYGcbVVCJt3ADUr5vR2Qe8axqHUXOsc6dHJK6YffQIx3zTvPHnKr
	OT2DBAPHx63GvqgFwjl/+/fkKH5C2+y2hKwWEpo6jlPMUijItPpn5EGiEeXaMpMKQAjKX61OcDT
	MXbfuv/r4onAyM73ZBvbaRmlpXXoCrhiJY60ogdb02H/yrv0kXMH0mBn7Y6hqGCSGTmRTo/jKSD
	vNx5NfdsTm8RJwg7/Wq5teBRxEqFmBFixIG8kkUY5obFCjqOmyoyQKpaEce2GMDh+kKfOzSCqtx
	lCBUnJv15Z/xx
X-Google-Smtp-Source: AGHT+IGFmBQ96esdhSIYzJkLEeWfczLxDMqGdgnGqzPjCaxKP+LdrMT6FzZajavze109Hu1ENkuKag==
X-Received: by 2002:a05:6a00:3c8b:b0:736:34a2:8a23 with SMTP id d2e1a72fcca58-7428934692amr9654889b3a.15.1747326077109;
        Thu, 15 May 2025 09:21:17 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-742a970b7bcsm9762b3a.52.2025.05.15.09.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 09:21:16 -0700 (PDT)
Date: Thu, 15 May 2025 09:21:15 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, jiri@resnulli.us, andrew+netdev@lunn.ch,
	sdf@fomichev.me, linux-kernel@vger.kernel.org,
	syzbot+53485086a41dbb43270a@syzkaller.appspotmail.com
Subject: Re: [PATCH net] team: grab team lock during team_change_rx_flags
Message-ID: <aCYUezCpbcadrQfu@mini-arch>
References: <20250514220319.3505158-1-stfomichev@gmail.com>
 <20250515075626.43fbd0e0@kernel.org>
 <aCYK_rVZ7Tl7uIbc@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aCYK_rVZ7Tl7uIbc@mini-arch>

On 05/15, Stanislav Fomichev wrote:
> On 05/15, Jakub Kicinski wrote:
> > On Wed, 14 May 2025 15:03:19 -0700 Stanislav Fomichev wrote:
> > > --- a/drivers/net/team/team_core.c
> > > +++ b/drivers/net/team/team_core.c
> > > @@ -1778,8 +1778,8 @@ static void team_change_rx_flags(struct net_device *dev, int change)
> > >  	struct team_port *port;
> > >  	int inc;
> > >  
> > > -	rcu_read_lock();
> > > -	list_for_each_entry_rcu(port, &team->port_list, list) {
> > > +	mutex_lock(&team->lock);
> > > +	list_for_each_entry(port, &team->port_list, list) {
> > 
> > I'm not sure if change_rx_flags is allowed to sleep.
> > Could you try to test it on a bond with a child without IFF_UNICAST_FLT,
> > add an extra unicast address to the bond and remove it?
> > That should flip promisc on and off IIUC.
> 
> I see, looks like you're concerned about addr_list_lock spin lock in
> dev_set_rx_mode? (or other callers of __dev_set_rx_mode) Let me try
> to reproduce with your example, but seems like it's an issue, yes
> and we have a lot of ndo_change_rx_flags callbacks that are sleepable :-(

Hmm, both bond and team set IFF_UNICAST_FLT, so it seems adding/removing uc
address on the bonding device should not flip promisc. But still will
verify for real.


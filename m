Return-Path: <netdev+bounces-107178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D95C991A375
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 12:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1251C2105C
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 10:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2905113C3F7;
	Thu, 27 Jun 2024 10:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YReOGJ1W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BA522EF2
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 10:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719482748; cv=none; b=A+57VD1qjt8sfRA5QXkQ+F4KvhQ0tDNYZDhXhGZ7qBqoof9DvkdAKYtrBkNK24r/9f9/gyXeskJuU1oV6rqWMvLw/tFDCTXhmzpa9sM7G7k/ic0NVmj6GlIOz4PHWcxcILssZoBwa3/CLjkbJEJxJKZNpKHOb+nZpXey/8140R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719482748; c=relaxed/simple;
	bh=0X04ROVJxP3fnm5CXtQJQ9C51XQkJ7gJt0X08MAaO6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDzHX++Qd3kqLcONNiiij1xxYb/uF+8lBIPVTXgi6oOoBWeLH19Ad7RWYSZhDH8q2+i+IYWq9/qfhQgn6KMoviGtGG9FfIx7hybdC69OoMeaoimoJ1tnVkeoux7ypfY5jmk1Lvk+bg9E0/EQK+HTMqVSjjP80sZaZjgys2/11DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YReOGJ1W; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70679845d69so3373138b3a.1
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 03:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719482746; x=1720087546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtPbJLCt1RNuNbIuAZMKCCkVn01BF9fkohFlUZwEjAI=;
        b=YReOGJ1WyZONPiqFvzlO0vdx0m08Mpgw0eqnSLDVFbBcdzaUHwNS/w1t0Ibv40sRys
         RS+i+GV5PBJXyUsV53xtdwFGB+mgAlIxHpHFSX31TJRYaNzl5An2NOhphUlrtvXXPhIA
         sQgqBHIgrac7VFOsFbs/F6h3TwsQTpt1fdLLUhmI0vnxh9HMFPgTkL4TI1Bpw+b+H2ZY
         c1dvyJHTP3pNGd+kndmGqCqImd1jDLXwzXvnAweaDbWtaN89TYlOVoZkm5BxLWoHV7bu
         4zHWjLy8ozbGm6EkfdKrD+QG6/51N05CINawpHFtTiBw+92Y4l1mGLQtFqCnmYHCs+RB
         RZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719482746; x=1720087546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtPbJLCt1RNuNbIuAZMKCCkVn01BF9fkohFlUZwEjAI=;
        b=kqX5pUqf/tg1OnfNPpHWed7oRtIe5brylwrIUsBiV09mqOzyYjabnnhrUGP1Cuur/J
         IBeiunEgKkjG1QG8Ix83UTBKA4tGmwF7Klmcvx23KUsZvCpcKAy+sbhtUVbsOcAkDUma
         rmPVh+hrAlzvu7qBNcWOObcTxF2Bb6FcNvb7aUGTbWkjtY1JtZ5ghBR0pISETbSa1uTa
         ZmZO/yToz2ln3sa/ao8TZ2VV6OSjffyEtpTXmUz5b1JkjSXfbHgI/12Zpc+lP+zWaMye
         lZzamYuYF2O/Hr8ZapkOyrRpmvN4JpONlOVq1RP00LdSsV8e8jgIae5jookCNpV1Vtfw
         TiBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1UlYFB1sSF6XLWBkKj5DG4n9LyLHX8DP3ffR1i+bgDYZ5FgBwtdUXyf2x1QTh/+DDCbBLd56nkVBO0qFtt6OYY9Utrr4h
X-Gm-Message-State: AOJu0YzBunMzyP0jo6blAVsnp/yU5NLWoFo+zaFAWwjYoYAfwjo3RPHZ
	0Ix+ry/VcYJgTfWzVJYmX+8iZi6aVBUNoQTHsaA4BHweJ/tWhYu6
X-Google-Smtp-Source: AGHT+IFT1rUdpumtQoVQSMeRSfjgEFIEkUTkS93bsJZN8SKr0JVJDnJEEmCpm0w0q9Sdm56W7JWlkg==
X-Received: by 2002:a05:6a00:cd0:b0:706:348a:528a with SMTP id d2e1a72fcca58-7067459a758mr16342575b3a.10.1719482745978;
        Thu, 27 Jun 2024 03:05:45 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:7825:fd0:4f66:6e77:859a:643d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b4a5bef1sm940576b3a.207.2024.06.27.03.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 03:05:45 -0700 (PDT)
Date: Thu, 27 Jun 2024 18:05:40 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jay Vosburgh <jay.vosburgh@canonical.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	Amit Cohen <amcohen@nvidia.com>
Subject: Re: [PATCHv3 net-next] bonding: 3ad: send ifinfo notify when mux
 state changed
Message-ID: <Zn05dMVVlUmeypas@Laptop-X1>
References: <20240626075156.2565966-1-liuhangbin@gmail.com>
 <20240626145355.5db060ad@kernel.org>
 <1429621.1719446760@famine>
 <Zn0iI3SPdRkmfnS1@Laptop-X1>
 <7e0a0866-8e3c-4abd-8e4f-ac61cc04a69e@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e0a0866-8e3c-4abd-8e4f-ac61cc04a69e@blackwall.org>

On Thu, Jun 27, 2024 at 11:29:21AM +0300, Nikolay Aleksandrov wrote:
> On 27/06/2024 11:26, Hangbin Liu wrote:
> > On Wed, Jun 26, 2024 at 05:06:00PM -0700, Jay Vosburgh wrote:
> >>> Hits:
> >>>
> >>> RTNL: assertion failed at net/core/rtnetlink.c (1823)
> > 
> > Thanks for this hits...
> > 
> >>>
> >>> On two selftests. Please run the selftests on a debug kernel..
> > 
> > OK, I will try run my tests on debug kernel in future.
> > 
> >>
> >> 	Oh, I forgot about needing RTNL.
> >>
> 
> +1 & facepalm, completely forgot it was running without rtnl
> 
> >> 	We cannot simply acquire RTNL in ad_mux_machine(), as the
> >> bond->mode_lock is already held, and the lock ordering must be RTNL
> >> first, then mode_lock, lest we deadlock.
> >>
> >> 	Hangbin, I'd suggest you look at how bond_netdev_notify_work()
> >> complies with the lock ordering (basically, doing the actual work out of
> >> line in a workqueue event), or how the "should_notify" flag is used in
> >> bond_3ad_state_machine_handler().  The first is more complicated, but
> >> won't skip events; the second may miss intermediate state transitions if
> >> it cannot acquire RTNL and has to delay the notification.
> > 
> > I think the administer doesn't want to loose the state change info. So how
> > about something like:
> > 
> 
> You can (and will) miss events with the below code. It is kind of best effort,
> but if the notification is not run before the next state change, you will
> lose the intermediate changes.

Yes, but at least the admin could get the latest state. With the following
code the admin may not get the latest update if lock rtnl failed.

        if (should_notify_rtnl && rtnl_trylock()) {
                bond_slave_lacp_notify(bond);
                rtnl_unlock();
	}

Thanks
Hangbin


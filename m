Return-Path: <netdev+bounces-208191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F76FB0A7D7
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 17:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615553B39EC
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 15:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506982957A7;
	Fri, 18 Jul 2025 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6d2Su4e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C9C1AAC9;
	Fri, 18 Jul 2025 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752853225; cv=none; b=RTfhDJJ/vKxTQoHS9Z2tzqvdxyxV8CxiKB0f2X6V5xcbl4bzGwIisDOgJJ4ZjNKplhK3uOScZ1dZ5x3J5AuzkjP0CuedU7mlxQ+l9sdoU7DYm2RRgwlUVDdQnlJZrDHYeK0dNRFgFZxrB3Qh3EXlkHevqxEovQejsuh8a0NVJIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752853225; c=relaxed/simple;
	bh=pcqUsgE+BLWnHrNEE8dooKUtCoJC8WbeCJpLfZgtNOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4CXLJGzoLNBzIeqvbUDrhXpheudpVygeuYzX3TGhJHDeyEXK4YldMmrfdh4GW5CkvixTZyFbTKCLDlTpEM6EwKWmKYxjtm4IRzErEM53p4GqLYdIOmv4O7UfArtD84Jmao0mgroi01SpAalwXSMmvQRKjcvqz+sHRDiNisCWWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6d2Su4e; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23508d30142so27101955ad.0;
        Fri, 18 Jul 2025 08:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752853223; x=1753458023; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uEqcCCwkmsmzuXx77UzHQMLnLGaJu6MAflPHml11P10=;
        b=e6d2Su4epkk9NgJhFL0hKDyTFCNDMvMfs9krwnmJAFeFkvMrEWS8Cp9s3LmcP5Cqfl
         6vrmVMBJfcvO3x5cv2PVl6qLivatXcPAXK/rkymUIt9+IVCl4GJwcJKX+1bbIcIfk6wY
         fWv62KY3M+QXGto3w3CWOc9jkHkB0+HjQKROEmb3J+FixPF+DxPK7vTuka5L4Gw9uiO/
         bWVf+y0B+OMNOpinY0iRQqPCE3LTVWBsQCsavs1fJBVjccWIM7wYYwFtPQ03AnwYY29V
         CZKHRjSDZQHS61MAxDs2PFy9y0jqYMBO7DSiG/JpPZZSDod1UN+6jeoh/zpamNK/eJSx
         LSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752853223; x=1753458023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uEqcCCwkmsmzuXx77UzHQMLnLGaJu6MAflPHml11P10=;
        b=rqJfCqBxllbESbycAa4+03VKo3Nbtl0EyPSHz8myZzmO/T/D8p/CuXEVaZg1ajbBqd
         V7Oe00pLW0UGXVDQiXkHKeD6ZoBzTrqOL6ZYiwa3DYnB1rnYE2GAaQgf5grr1iNA5EuX
         forLEiQF/dLgX9GRbyjTE1Z8qentmYUgvodhBDEyM7SuHSDV/CHFzIeyI3hxA742ZayB
         A2ZKD8IS4IwHJ9UK4Zxmb5PzZffagFX4Miusmz8JlPnySvSHP+Dd7yNIxn41PjLHNbSC
         23VfW5ZDMqWx4f0UDov88GpuIGUWvjwOno0wHH2bVGDhpt6YIPgZppDVpW4Ni9+ccLSf
         VDUA==
X-Forwarded-Encrypted: i=1; AJvYcCUotdNEt3eLnAqKW47Cpo+MuLpvir2b7DtBh/7iHBUXhezhbsfvH7sbRLsYPjgLbbXd/zjBfUYZNFo3BW0=@vger.kernel.org, AJvYcCWpJVdGgHCIpKVAXkiTGMGdcpucJvDSm1MAYrJAFCu6AxLLIh3ITv19WJ47n3Fp+K/Ut45WPFmD@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx8RTThTtzT+qugSV29iYjNRXJygm3H65z8XUHNzzFZw7TJ2NV
	PcLj8VQBx3cTtToDdHnBqzqysG0G7ngfV7JbGWEHTv8fqeAo/cICLV//HeVN8HF69sh/sMYFnqC
	qabFmlT9VKbqi0UEi3cD29jRI5itI2RM=
X-Gm-Gg: ASbGnctGbklMwUIHS8qW3io53LzwYy+v792Q5n2o95XO5Z+Zl0mwHzc4DRLVrCJ6G6q
	5loZNV6kDkVh7vusj/XcGnV+Hdv93GtKtFQYE/LF6MF8VEjufGEfzuag+LrikBsQCdY6uWn8AP/
	4qem2alBmsSFESC3J6tpIQJdfOfqrKGmerhkwIeIz+a2GDcxHphaGO8WkHMiTnRSPruMppGtupR
	bULkeIZDw==
X-Google-Smtp-Source: AGHT+IFITHlQPUA6LMP3QbkBSAv1GjTijR0k+h23C4Uf96ZYSNEmyTHvaDyBzQlGdYFgM4+f55LcYOvcgSTt5LjpWEY=
X-Received: by 2002:a17:903:3db5:b0:234:f4da:7eef with SMTP id
 d9443c01a7336-23e2579ea2cmr139584875ad.52.1752853222873; Fri, 18 Jul 2025
 08:40:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718114958.1473199-1-aha310510@gmail.com> <20250718132500.wq4ahdbiwk2dwwnw@skbuf>
In-Reply-To: <20250718132500.wq4ahdbiwk2dwwnw@skbuf>
From: Jeongjun Park <aha310510@gmail.com>
Date: Sat, 19 Jul 2025 00:40:10 +0900
X-Gm-Features: Ac12FXzHHA9QEl_INVdfZlKBFH14YJGGi0rvNj31d5OVnMNHSh5Dpmjr7xOk25Q
Message-ID: <CAO9qdTHt7aip3v6T1LkEXzyqeMWst+CYiinVu6KYJLyfoY-F_A@mail.gmail.com>
Subject: Re: [PATCH net v2] ptp: prevent possible ABBA deadlock in ptp_clock_freerun()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, yangbo.lu@nxp.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+7cfb66a237c4a5fb22ad@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
>
> On Fri, Jul 18, 2025 at 08:49:58PM +0900, Jeongjun Park wrote:
> > ABBA deadlock occurs in the following scenario:
> >
> >        CPU0                           CPU1
> >        ----                           ----
> >   n_vclocks_store()
> >     lock(&ptp->n_vclocks_mux) [1]
> >                                      pc_clock_adjtime()
> >                                        lock(&clk->rwsem) [2]
> >                                        ...
> >                                        ptp_clock_freerun()
> >                                          ptp_vclock_in_use()
> >                                            lock(&ptp->n_vclocks_mux) [3]
> >     ptp_clock_unregister()
> >       posix_clock_unregister()
> >         lock(&clk->rwsem) [4]
> >
> > To solve this with minimal patches, we should change ptp_clock_freerun()
> > to briefly release the read lock before calling ptp_vclock_in_use() and
> > then re-lock it when we're done.
>
> The most important part of solving a problem is understanding the problem
> that there is to solve. It appears that you've jumped over that step.
>
> The n_vclocks sysfs is exposed for a physical clock, and acquires the
> physical clock's n_vclocks_mux, as shown in your diagram at step [1].
>
> Another process calls pc_clock_adjtime(), acquires &clk->rwsem at step [2],
> and calls ptp_clock_adjtime(). This further tests ptp_clock_freerun() ->
> ptp_vclock_in_use(), and the fact that ptp_vclock_in_use() gets to acquire
> n_vclocks_mux at step [3] means, as per its implementation modified in
> commit 5ab73b010cad ("ptp: fix breakage after ptp_vclock_in_use() rework"),
> that the PTP clock modified by pc_clock_adjtime() could have only been a
> physical clock (ptp->is_virtual_clock == false). This is because we do
> not acquire n_vclocks_mux on virtual clocks.
>
> Back to the CPU0 code path, where we iterate over the physical PTP
> clock's virtual clocks, and call device_for_each_child_reverse(...,
> unregister_vclock) -> ptp_vclock_unregister() -> ptp_clock_unregister() ->
> posix_clock_unregister() on them. During the unregister procedure,
> posix_clock_unregister() acquires the virtual clock's &clk->rwsem as
> shown in your final step [4].
>
> It is clear that the clock which CPU0 unregisters cannot be the same as
> the clock which CPU1 adjusts, because the unregistering CPU0 clock is
> virtual, and the adjusted CPU1 clock is physical.
>
> The crucial bit of information from lockdep's message "WARNING: possible
> circular locking dependency detected" is the word "possible".
>
> See Documentation/locking/lockdep-design.rst section "Lock-class" to
> understand that lockdep does not operate on individual locks, but
> instead on "classes". Therefore, simply put, it does not see, in lack of
> any extra annotations, that the &clk->rwsem of the physical clock is
> different than the &clk->rwsem of a child virtual clock. They have the
> same class.
>
> Therefore, there is no AB/BA ordering between locks themselves, because
> the first "A" is the &clk->rwsem of a physical clock, and the second "A"
> is the &clk->rwsem of a virtual clock. The "B" lock may be the same: the
> &ptp->n_vclocks_mux of the physical clock.
>
> Of course, having lockdep be able to validate locking using its
> class-based algorithm is still important, and a patch is still needed.
> The solution here is at your choice, but the problem space that needs to
> be explored in order to fulfill that is extremely different from the
> patch that you've proposed, to the point that I don't even think I need
> to mention that a patch that makes an unsafe funtional change (drops a
> lock and reacquires it), when alternatives having to do with annotating
> lock subclasses are available and sufficient, is going to get a well
> justified NACK from maintainers.

Thanks for the detailed explanation!

Thanks to you, I figured out that I need to add a annotating lockdep
subclass to some of the locks in vclock. I'll write a v3 patch and send
it to you right away.

Regards,

Jeongjun Park


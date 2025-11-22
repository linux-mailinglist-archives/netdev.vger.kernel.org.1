Return-Path: <netdev+bounces-241002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 776A5C7D540
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 19:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1919B4E1109
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 18:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C334F26FDB2;
	Sat, 22 Nov 2025 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1KHhyKx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F261917FB
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763835294; cv=none; b=iXCpazAGL9nL0AGfj0EBh7Xgl8n1BCZJjEXs7EFFdZexaRSYfKwQd56JCQEG8ijH/GWoODfNZ+4HAuRUZ0pIVAe+cH8Sj8Kk8gQZGH7pp3fJPXbHa+DYjSzVGvqiLpBMtQSJ+k+svY7SesEzWfADFhw3tazIXPVTOKOCniEymX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763835294; c=relaxed/simple;
	bh=FFdoSJ9u62Km9rBg5OXJAYM1Xn/OsZj0Z5qC/8KIAAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVUImBCt9rgF+MfCJxv6d+bWsWkwCEU1WQCPywT9at13LIXk++Bsr+jMmC4od5Sy4+QIDDIHXwMB/hBKoYv8/hE/5Et+BUs6yiq3KK8jDR0zYJoANOtgYazp4IWNCZz4ZHk6rvTPZMn86+bwiNPgS7fy5Crdbeof+3LSjzIGutw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1KHhyKx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-298144fb9bcso33296905ad.0
        for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 10:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763835292; x=1764440092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+dNWXnZ+CpQauZmGtwlNbimoKH0yvdO1MlblAJyrYMc=;
        b=C1KHhyKxwmLDolCKhDRLlszsQyK/Yq8aGQXadUdQr1C0xA2MWm7E6JjgyuksRoC6kv
         OzG4U4eph8TL9u6GZBTPcUZDgpVkwj+qvFmzIEA7o0oCvy7gqeDxKJhFO95Y0LvcONYS
         d0x2IW0Vo58ryCEQGeIS1LN0CBXcmZ9QoQtxxdlhr+lnWUE3roBLiZveX2xCl4pQE456
         x45SKzmew9fen8KtuZ+aXv611mGs5JGnUGUmPVZn+jTwyGPK2Mphle9zFysj/c+/18fV
         daoWDPgiu8eQ8ChDQap1BdFYwXkshNjiCUy/XlUUjcBdmFd39WI+zLkr+a2ZjlIEAUwh
         xgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763835292; x=1764440092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dNWXnZ+CpQauZmGtwlNbimoKH0yvdO1MlblAJyrYMc=;
        b=l7a8ECUTwIzhpTgKLH4A9+xSY2655BjXPtY4oiQGPk6XVpa1GbXgQJDNsAsgHY1qot
         dFDXnHsRq3aqMq+gbWodCWhcM3gCtTAXP8OpE+D2YNCK9+t52aDr1vePK64Soyswx2Ag
         RLBwDBSyBUhbWgtaob9crfipJjJSTIxWJZz996xsOrdYF5UDpw7udLkDVykgEg2EhUh/
         BLlRGib+jj/cTWcQUWSnaclpcDyNMcaZw3q9ZxsVhAWQwF5/tC5D2TLWvb+BMEL+jpSP
         T8oyZw1udyqjlqwx1vQrSVuAgbq2NQWSFW5l2T5zN8aebck/8xPJ55NUqh0kVRx8lCHk
         0v6g==
X-Forwarded-Encrypted: i=1; AJvYcCWcdtltyf8A8hvEPAZ0rEhpZRTSWVtcH2WbHkQYakPNUTUkwkkyRUWoKxgL+vXsiMuLF9sB9N8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHDR5bRk7NKhkY2r4JdNoHEi2fBbZT2DDV8szNLHBNoALFREzG
	NSlBfrRB5qcNKceYf6sub/B8hErSoiTksSumE+bvL9YIuzzTqsQ2zG9b
X-Gm-Gg: ASbGncuRtBi2SVyRbp6OP6Wp6jd3WrYGCahF8lsfcVywL1arOngJuFlgl5zEV4YEpDz
	EW4oq3MJVP7Zd7ws4V5n9FoLeN5DXVlS8IFftpjb8JrtmpfjpMOYu3NMrfqYrQz3qmLY0DBu1sE
	OCX0Zz1zI5cXXpJAy95XdTS9LJmiXrAW3vP+43S8I4Oiftn7V4WG3w4PMvLZmhZlRDOmtoLUwLX
	KF93Vg6QjENNVZ9r95svmHwVexkBUljiLG/tkcsholkn+OWNtQby+PK5dH4hb+pzu35VTx6aLIA
	k92YZ2jLDnPzC5TFDPE2IJWPacTkUeC82sN8NsgK0K1hsGNojhWppnGvidB6f3jZqMvaKTH+5nt
	AKJYsOrbsALsaBZk66Ad0pIoeFF0x36udSX/D9/Q6uxU55LFiNNcAZEAahRDtVJuDLJmPY4p6wB
	Ljxet/jGHaUU+h4U2i3Q==
X-Google-Smtp-Source: AGHT+IFCZbpEPmsFfm4MlFT+MJ0xNsYrm1nl3+rX45WjcsSBzaZPQyyHb87/SJKxBxkZZoZd/IwyMA==
X-Received: by 2002:a17:902:e945:b0:295:f508:9d32 with SMTP id d9443c01a7336-29b6bf3b83emr83186605ad.37.1763835292363;
        Sat, 22 Nov 2025 10:14:52 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:4cfa:6cea:94d3:bc41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138bcbsm89004265ad.29.2025.11.22.10.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 10:14:51 -0800 (PST)
Date: Sat, 22 Nov 2025 10:14:50 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, will@willsroot.io, jschung2@proton.me,
	savy@syst3mfailure.io
Subject: Re: [Bug 220774] New: netem is broken in 6.18
Message-ID: <aSH9mvol/++40XT0@pop-os.localdomain>
References: <20251110123807.07ff5d89@phoenix>
 <aR/qwlyEWm/pFAfM@pop-os.localdomain>
 <CAM0EoMkPdyqEMa0f4msEveGJxxd9oYaV4f3NatVXR9Fb=iCTcw@mail.gmail.com>
 <aSDdYoK7Vhw9ONzN@pop-os.localdomain>
 <20251121161322.1eb61823@phoenix.local>
 <20251121175556.26843d75@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121175556.26843d75@kernel.org>

On Fri, Nov 21, 2025 at 05:55:56PM -0800, Jakub Kicinski wrote:
> On Fri, 21 Nov 2025 16:13:22 -0800 Stephen Hemminger wrote:
> > On Fri, 21 Nov 2025 13:45:06 -0800
> > Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > 
> > > On Fri, Nov 21, 2025 at 07:52:37AM -0500, Jamal Hadi Salim wrote:
> > >    
> > > > jschung2@proton.me: Can you please provide more details about what you
> > > > are trying to do so we can see if a different approach can be
> > > > prescribed?
> > > >     
> > > 
> > > An alternative approach is to use eBPF qdisc to replace netem, but:
> > > 1) I am not sure if we could duplicate and re-inject a packet in eBPF Qdisc
> > > 2) I doubt everyone wants to write eBPF code when they already have a
> > > working cmdline.
> > > 
> > > BTW, Jamal, if your plan is to solve them one by one, even if it could work,
> > > it wouldn't scale. There are still many users don't get hit by this
> > > regression yet (not until hitting LTS or major distro).
> > 
> > The bug still needs to be fixed.
> > eBPF would still have the same kind of issues.
> 
> I guess we forgot about mq.. IIRC mq doesn't come into play in
> duplication, we should be able to just adjust the check to allow 

This is not true, I warned you and Jamal with precisely the mq+netem
combination before applying the patch, both of you chose to ignore.

> the mq+netem hierarchy?

This would make the code even uglier, it is already ugly enough to
hard-code and single out this case in the code.

Not to mention there could be other combinations we don't know yet.

We need to revert it and fix the original issue with changing the
problematic duplication behavior.

Regards,
Cong


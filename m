Return-Path: <netdev+bounces-243359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9ADC9DCE0
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 06:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 750F04E062A
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 05:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4902472A2;
	Wed,  3 Dec 2025 05:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHm3nP/2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0AD3207
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 05:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764739879; cv=none; b=XZRGny8FA+VNBKbmuRQNLMIBzVszWdtmDpaV/PE3hGjdSFJMuuqYXsXTkYqXvwHmUJI7EWNG2N8t9atThgxcwBrxaDisId6Y0hrbt3Tz0Tase9EGKllkJ/Pi8d5uG4PcKQMnngm1KFCAehQJH1H7ekQXRqY/glY0kV2d1AVaPI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764739879; c=relaxed/simple;
	bh=2cZ6e2HifWZxhoTyENYFOVfsdkJ0J4/WLfBT2n58lNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpgUijO3PVn49Gjbhvv3RmTh9sTfpQdNzN0gDOSsgqmxf7hlbEzYAqm8B04HSA4dW5SRSi+sd+byKcH+2dRYUINzQeACOyd5wsby3396UJzGK6ciTJPoWH/Xkpsz+c6GBxLWXzjcvtR4FJoGPVEZ6wyTYL6OZ63gu47xKWwJe+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHm3nP/2; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-bf1b402fa3cso1411382a12.3
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 21:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764739877; x=1765344677; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Krz802YddshXmZcDWgXdxQ3kx1TO7yAoW+miWDBifF0=;
        b=cHm3nP/2hNL2uX3HrLqrEuDD7z+hOXFU8a0F8yfXmdNYTRAkrsNYntN5jwcCFEJE75
         JOo/aMmlU2G2B+OQ3uRB3ZRsNLVaSr19FzjM/X49TF76fZHoJKkJx6AqQ3qPHY0q5ZX2
         RPSxvVWsGsXhrckFSyh0OluN4esyfvsPMqmGLvSezb2EXWvf65mI5z4uPydIGTyGXKjX
         PRwVHJvBFFTBZPN/QU+giPnV4AmHSu8Fv1fTbwrxLQSrf+/MG6851SLCBMImWtoL1V0g
         VMtUB5ANiZsEi3LHhv/WPgWUyKIIJx0vU3H5IYMDF0be9Ox1DHV0FXX1MgQPpe3Uvwez
         AdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764739877; x=1765344677;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Krz802YddshXmZcDWgXdxQ3kx1TO7yAoW+miWDBifF0=;
        b=VGNC639RI0f8H1cYhGCU0OcJ9v0qr8fjIuo+9e6Lz0MZso98g3VdeNtZfLF1FJfkja
         LGHnXFqsYdZ5czSA0xds+2fo7uGf/SiNaCja5LfTwtgzmOp06u1L+UxMtkw4QBTprs7l
         qekLLs7TXlQOkgKrnUiwp9+Y7EJaXC5bGzK9j0KbPEhZ+QsuAeEbPkhY6nxNUu/LQCam
         C0+k/aRpeMOY4qfyIKn3P4/ZhdEUthnHVwkNuqBfz6nND8BxbOAo6QrMnde964HrH2S6
         jAe3Tx1/mWzJoNcJPl00CBry85INouURJpWhM3N5JUrDF4Z4zqIzQXTHRb7y2oC8oZrN
         Nufg==
X-Forwarded-Encrypted: i=1; AJvYcCW4iXGghZmYC38aihbdGrPuk5d34lfinx1NemrT+idfr8bUM6pCapuqoJqVkJ9sjGLKbH3Z5X8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB2nP8N00b6QOmNBWXUVgn1IxacMMig5WvaGtS6gdJviwmlTFt
	c+pCZfoKPIfW0zKp9Nya9Gcus2MO8ItV+gE8gVRB/6bnO5gmHnjZuJao
X-Gm-Gg: ASbGncuZj4y4zrKRyYI5M/MDu97wnz2sCqtaVO+Xt7cEzZB3dXNXxrP2gR2Egydb87K
	q54mDKoVleO8K6zA9Y2+ZxQt9sQxaCsxVY1Q69C0fLLE7aDb65RW1c9nJwt90DMg9p6j6VNMnIl
	zXcSyufD88/W1Cn/zZxvkh2uorUtKaOgiVLRPfo3ye+jgLAOqQC627LYUW7+CNlPzUeSGJWf+qW
	A8naoiW4Pt2eNfXv0iKFonYDktAdFtJmJdpPMgtFgulfBQojYi1bXqLyBRfcXu7i57KffIwiONY
	dIIBBcMhcXXwFLEeEAIFkIBJPfGSiwfSsLUlX3OKrT2vJ12N5LY7UqYchi99OrI5Dievenv2pw2
	t/pxZ6HThKcPAXbVnTGPZ/JR3ogXjhZoIJSftJE78T7GENfE18iIIq2vv6LeBithYscCHQwYO/F
	mZk6RGUhZm+Es+mPbHeyICNChWaToh
X-Google-Smtp-Source: AGHT+IFr9CcjVghg9hmrfzNjTHcxJgo+bljuesXO+WbZ3zPiDNG3V9QwN/EEccXkdDd9cJbrMdBp5g==
X-Received: by 2002:a05:7022:78f:b0:11b:d211:3a64 with SMTP id a92af1059eb24-11df0ba160emr1177470c88.0.1764739876929;
        Tue, 02 Dec 2025 21:31:16 -0800 (PST)
Received: from localhost ([2601:647:6802:dbc0:57e5:a934:7b10:c032])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb057cb0sm97283794c88.9.2025.12.02.21.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 21:31:16 -0800 (PST)
Date: Tue, 2 Dec 2025 21:31:15 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>
Cc: Jakub Kicinski <kuba@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonas =?iso-8859-1?Q?K=F6ppeler?= <j.koeppeler@tu-berlin.de>,
	cake@lists.bufferbloat.net, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] Multi-queue aware sch_cake
Message-ID: <aS/LIzlRuJWDGL6m@pop-os.localdomain>
References: <20251127-mq-cake-sub-qdisc-v2-0-24d9ead047b9@redhat.com>
 <aSiYGOyPk+KeXAhn@pop-os.localdomain>
 <87o6onb7ii.fsf@toke.dk>
 <20251128095041.29df1d22@kernel.org>
 <87cy51bxe1.fsf@toke.dk>
 <20251128184852.7ceb3e72@kernel.org>
 <877bv9b381.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877bv9b381.fsf@toke.dk>

On Sat, Nov 29, 2025 at 10:25:02AM +0100, Toke Høiland-Jørgensen wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> 
> > On Fri, 28 Nov 2025 23:33:26 +0100 Toke Høiland-Jørgensen wrote:
> >> Jakub Kicinski <kuba@kernel.org> writes:
> >> > On Thu, 27 Nov 2025 20:27:49 +0100 Toke Høiland-Jørgensen wrote:  
> >> >> Yeah; how about I follow up with a selftest after this has been merged
> >> >> into both the kernel and iproute2?  
> >> >
> >> > Why is iproute2 a blocker? Because you're not sure if the "API" won't
> >> > change or because you're worried about NIPA or.. ?  
> >> 
> >> No, just that the patch that adds the new qdisc to iproute2 needs to be
> >> merged before the selftests can use them. Which they won't be until the
> >> kernel patches are merged, so we'll have to follow up with the selftests
> >> once that has happened. IIUC, at least :)
> >
> > You can add a URL to the branch with the pending iproute2 changes
> > when you post the selftests and we'll pull them in NIPA, or post 
> > the patches at the same time (just not in one thread).
> 
> Ah, cool.
> 
> Given the likely impending merge window, how would you feel about
> merging this series as-is and taking the selftests as a follow-up? Would
> be kinda neat to get it in this cycle :)

A followup is definitely okay.

Maybe it is time to think about getting rid of such dependence on
iproute2? I am thinking about replacing those iproute2 commands with
libnl (or other netlink libraries). I know this is a lot of work, but
we have AI today, so perhaps it would just take AI a few days.

Another benefit of this is we would avoid parsing with regex, which has
been a headache even for me.

Anyway, it is a long-term thing.

Regards,
Cong


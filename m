Return-Path: <netdev+bounces-156042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFB0A04BD9
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 22:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DDE188620D
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 21:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016B41F63E8;
	Tue,  7 Jan 2025 21:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rJKqu2bQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725111946B1
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 21:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736286090; cv=none; b=Zp0+CgV/Y7sxK4mIkKAtgiPfb6HBNGXjul+iQEPCHiESkdGd8QmRlzmqOTJx/134NfAkNmB6hOBXfYxV4XgLYapb5MZy+cn7FVJ3po0cQI/k99b4FC2LAzuztHKGV7MRZfKX1pEgOWuKvZSlfLUJPbnj2HDhM4yLJxfUVj540jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736286090; c=relaxed/simple;
	bh=lpWKviEZo4bxM8FXJ8znVcvZY1r1EUP8KwYPFjPwLkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qfv5cuTbfkbWlBTTQ1aEQUPpywI4jwAezc0jXMHYkmI3eUeyY5Ou0UwP5S4e/c6t8mn5hp89RNdsjZhr5BgrZBie8BDKVBGehLyRnPxLolgcgRg/6NlC7UKaGxqGpLKmnBq1gRUSIKYpMgQ90EAAqXYPy12VomdHa6IZCOkLxwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rJKqu2bQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-215740b7fb8so39865ad.0
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 13:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736286089; x=1736890889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=unXEBPo8awHZ2Z1rF9jBBJWiHGlrbX40mqZQQ+A6Pko=;
        b=rJKqu2bQcea7guTbC2FPbTVj9vl7Z3T9HB6kDwRdZKmW+kRcuM6s+EPqNkETQfNZTC
         OICOgzg9L7NWOiMGE0AY5AqWgw02vSjz3YNRZJSagIxo/yKFQ0TGDjyEmUTSlc0Gza9A
         vrcMD4pzlGRLS9tZfp7JxJrx4FZUZwkGFIA4kUJgykw82p0/Y51UrqWLrO9cweULhQOv
         D7xay0ikT0Y8lbTIcubMdjad84oGj8wEo0Ie56+DWxwXP+j9ZeOw0ZCrCpyUEJSK2Wgv
         u17tyOkwZ5XrKw8ouzRHbqGurmd4+ecneGnoEeckw2qbTBTO0q3/3cwi4DaiFma57+eY
         /j2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736286089; x=1736890889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unXEBPo8awHZ2Z1rF9jBBJWiHGlrbX40mqZQQ+A6Pko=;
        b=s5ceDk+aMrN0oiOl+AVdXsz6zRZF9dsyowdF8X1FQhDspBwpOcv1THMTxU+XLsVlYn
         zA0RCY1qvkSCuPaoijbo+SF8vHZSSj0w9O0vqj61RPvkkPc2ImBC9PhbzuvPFLrSS3KZ
         ET8irRtBu5Fq1BQFjLG7CV3ganPMh2A+tsTEsvherkVMVp/qMYGi7jnMR7z/c+sDdZ3L
         05EK3hlwiFn5BkPpUC5itBqcyIhUSLTilEFmQ/+GcInIWcEp17ZLlMpvvVPyGNwNQJeo
         nEjDuQK5PEZXPbZ1lmtI5OCrIa1PDNa8NUX0HVGYErH+Qch3HBLdaI902176cPvn9cDc
         nivw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ7/f8eFBEs/QGMf7oiUlDcWd2ivNnBIzpTAIASeowiKwGbSPXqqv7AIpB0I8z6+vhyd7RJUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLhrRhveAwCWnbKqFaA66exRxXPYB20n7F/8Rcizw6Depx7b4L
	kionTvDd4Fyh2vLIIoz/+uyg2XnaWSFjyW0/Q47C3nQQE/F7asxHAZ2p9Rt/lw==
X-Gm-Gg: ASbGncuFk+i86D3LV0Dp0V455b76LSWmy0d5H6lqbyzeCt6phNZ3Mz0UZH1KXlshYMY
	VmNnfU0wcPAh69QvjSWb7aM9Yu1iSkzpAGs/FkE13gNdYyRRPxRVZ3pXq+N3no8bi8eksomxYOu
	sSTC25pTK7AyblICpHgSXiHQ5zOD4IPLx2K9u72q4BDenYTWXK5e4ka3SkkdYUTXVuNG4UM7JuK
	ozwHkKP3t0Qm5XL66jrSld9EExDi7rW5/PaVaICFoCzfzmq5IwuKcU73lN0PV9T2lKfQtBsH/dP
	4bQ7efqJhcO7Oc045tw=
X-Google-Smtp-Source: AGHT+IG3hEhfXeKWewYxbqr5NVyNbPqv0I027EJ/i4H/5/AUmYmTqt4fR8mqPv9GpwTbRhwaYzCZDw==
X-Received: by 2002:a17:902:fa4f:b0:20c:f40e:6ec3 with SMTP id d9443c01a7336-21a84189e0emr559145ad.22.1736286088554;
        Tue, 07 Jan 2025 13:41:28 -0800 (PST)
Received: from google.com (57.145.233.35.bc.googleusercontent.com. [35.233.145.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc963103sm316291215ad.52.2025.01.07.13.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 13:41:28 -0800 (PST)
Date: Tue, 7 Jan 2025 21:41:24 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	donald.hunter@gmail.com, gregkh@linuxfoundation.org,
	arve@android.com, tkjos@android.com, maco@android.com,
	joel@joelfernandes.org, brauner@kernel.org, surenb@google.com,
	arnd@arndb.de, masahiroy@kernel.org, bagasdotme@gmail.com,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	hridya@google.com, smoreland@google.com, kernel-team@android.com
Subject: Re: [PATCH v11 2/2] binder: report txn errors via generic netlink
Message-ID: <Z32fhN6yq673YwmO@google.com>
References: <20241218203740.4081865-1-dualli@chromium.org>
 <20241218203740.4081865-3-dualli@chromium.org>
 <Z32cpF4tkP5hUbgv@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z32cpF4tkP5hUbgv@google.com>

On Tue, Jan 07, 2025 at 09:29:08PM +0000, Carlos Llamas wrote:
> On Wed, Dec 18, 2024 at 12:37:40PM -0800, Li Li wrote:
> > From: Li Li <dualli@google.com>
> 
> > @@ -6137,6 +6264,11 @@ static int binder_release(struct inode *nodp, struct file *filp)
> >  
> >  	binder_defer_work(proc, BINDER_DEFERRED_RELEASE);
> >  
> > +	if (proc->pid == proc->context->report_portid) {
> > +		proc->context->report_portid = 0;
> > +		proc->context->report_flags = 0;
> 
> Isn't ->portid the pid from the netlink report manager? How is this ever
> going to match a certain proc->pid here? Is this manager supposed to
> _also_ open a regular binder fd?
> 
> It seems we are tying the cleanup of the netlink interface to the exit
> of the regular binder device, correct? This seems unfortunate as using
> the netlink interface should be independent.
> 
> I was playing around with this patch with my own PoC and now I'm stuck:
>   root@debian:~# ./binder-netlink
>   ./binder-netlink: nlmsgerr No permission to set flags from 1301: Unknown error -1
> 
> Is there a different way to reset the protid?
> 

Furthermore, this seems to be a problem when the report manager exits
without a binder instance, we still think the report is enabled:

[  202.821346] binder: Failed to send binder netlink message to 597: -111
[  202.821421] binder: Failed to send binder netlink message to 597: -111
[  202.821304] binder: Failed to send binder netlink message to 597: -111
[  202.821306] binder: Failed to send binder netlink message to 597: -111
[  202.821387] binder: Failed to send binder netlink message to 597: -111
[  202.821464] binder: Failed to send binder netlink message to 597: -111
[  202.821467] binder: Failed to send binder netlink message to 597: -111
[  202.821344] binder: Failed to send binder netlink message to 597: -111
[  202.822513] binder: Failed to send binder netlink message to 597: -111
[  202.822152] binder: Failed to send binder netlink message to 597: -111
[  202.822683] binder: Failed to send binder netlink message to 597: -111
[  202.822629] binder: Failed to send binder netlink message to 597: -111


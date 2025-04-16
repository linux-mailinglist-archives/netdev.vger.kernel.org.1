Return-Path: <netdev+bounces-183094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B01E2A8ADB4
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 03:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06247190058F
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 01:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED4E22759C;
	Wed, 16 Apr 2025 01:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Z0WbJ8qt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC4C1A2658
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 01:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744768608; cv=none; b=CQMtqM4oGi6ddz548b+azSESvLush+wjTc2b/7OG6xF6bceZxuT0FtoP4DatC+ig7Rv/iBxADz11VCdZn13hMhcRQ3LLhpHlcMX/T7rnB+Z0bSPRYu+qJ5iA5TzPr1awCLE78J5D7IKQIhe8f5pspNC4Vuje4UBmwGp5J1DX7Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744768608; c=relaxed/simple;
	bh=OlQksBI9N8C4io9PPEeKnK0eRnXxJawMD1xEMjk5isY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIzzwsfvw1NKKOCg4TgTICpA5nQEDTiiyzKZkKv3eubdHgNcTaSzw8Qfte/zNQ5XYTmCZxAmBYtG2FsL4+d82NCdA/B05rgumqRBzDDr+xU8iAVB0MIO2p6iD1QXF1uU8UHn3CYdI4yjk28wQlWstXoPeazwKfAaLVz/Wom56iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Z0WbJ8qt; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-736a72220edso6380812b3a.3
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 18:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744768606; x=1745373406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zH6Lo7K1OSFKp6QNppXRFBk1j0NkAPFfDo3Y+3OHuq8=;
        b=Z0WbJ8qtEHFtZbdbMWMmwVkhyuCmuG5IWRQVqhHNY8OYbFCQoPgyyD1GutQScXTv6x
         ccwu0ZXxJIF9PrnAMIaQ/3NTji0dE+FKiRJmWHdH8rRRUDj25YkWbRxXAplVgGFRQ7hI
         1u+ERAU1wRZbsBAy4j8qSMlibC44oYw3Jg55s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744768606; x=1745373406;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zH6Lo7K1OSFKp6QNppXRFBk1j0NkAPFfDo3Y+3OHuq8=;
        b=YWAqTtCvwwJKX2F+jg83yBEqyBb89syM9Mi1zBfICkJyKOkg80WNmf0wEEs1cy3xYd
         rpIjWu18qXpMDQXhkOYR9zkCRNpEmma1DTsDh7qubBsnbPtRD/5aiFndZjQz6dxV9et5
         FXkCugksOoIyE5W4z/lkYSSUcom4vOm7BU9mDmlQia/QHSPFYztzdMRIFpRas65A6zqB
         o61XiNtlNqMRdEIT/aCW0gBAzDAphKyQywo35eYgaxqS4OgLQ6lm/kTVDvm4zmEuJ+GZ
         W3y5K0b7PVV0/uuRDVOW5nqr2uxzOU9K4tZ/XT1QD7f8F9IK8zo1VYe0jYrNcjYunUgh
         lnMA==
X-Forwarded-Encrypted: i=1; AJvYcCWxSeV0sExQ29bbwzMDyvCc1C5C7YFjkSvmVmOhpDvDGvBECURrn3QNh6yrl+x+iCAUXE+ZHcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb91brJU2nsQveaAFlsAB2CEnz6dMzJyFW/pkLPbY7yB8Z4HTj
	UeaR1PF7A0VTloHIX3/HopRxWLnydjtYlxj3WgmUfysRljYrAnddSj9X4pQu/7ZKAZFTTKXJJlV
	X
X-Gm-Gg: ASbGncthqHXKFYV5ndYtY0InS9TeU/RGoJcCxA0o8OtkkBbN1pkgRfB0XZIVI8Ie2rC
	mEYTa8Zz/ybCIys9YdOd0+albdTIgwn++W3lACzZfUbNUFCDSdHp5MUQpiPGDBJDCy0ug1+7f2D
	bnXRiR4ZCMS/2d/ub41hBBLWZrOnQHgu925WDjf64WuNj6XAyd7Y3epxBy9YJMyLLdMnJ5doA2/
	KJpZkxXvt+1+Tn711wlGnj/xruuxygPt3EW1fL/b01SAZGBivGLtWu1a1Ym/KUQTYXQWMjYFdMW
	nmj7/6WIzBGmax82kVF4Q+b7vpjwSrhYkk13O5ViRBJcR9p6myzkylWEMk1BA2xwn4imyIanNum
	D0N1yqyy/dxCt
X-Google-Smtp-Source: AGHT+IGBEFiE7rD3c6yv9qx9mnATnRt4uhP8Ce6xBfMK/meKycVXu5GcBUNZvg9of04s8MQAW/IL2w==
X-Received: by 2002:a05:6a00:369b:b0:736:3c2b:c38e with SMTP id d2e1a72fcca58-73c26722c8dmr21114b3a.13.1744768606005;
        Tue, 15 Apr 2025 18:56:46 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2198e9csm9238144b3a.28.2025.04.15.18.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 18:56:45 -0700 (PDT)
Date: Tue, 15 Apr 2025 18:56:43 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, David Wei <dw@davidwei.uk>,
	Eric Dumazet <edumazet@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [RFC net 0/1] Fix netdevim to correctly mark NAPI IDs
Message-ID: <Z_8OW7PoidxBOgpK@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, David Wei <dw@davidwei.uk>,
	Eric Dumazet <edumazet@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
References: <20250329000030.39543-1-jdamato@fastly.com>
 <20250331133615.32bd59b8@kernel.org>
 <Z-sX6cNBb-mFMhBx@LQ3V64L9R2>
 <20250331163917.4204f85d@kernel.org>
 <Z_613wmrKRu4R-IP@LQ3V64L9R2>
 <20250415171154.0382c7f7@kernel.org>
 <Z_8KT7LYUgyZQhI-@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_8KT7LYUgyZQhI-@LQ3V64L9R2>

On Tue, Apr 15, 2025 at 06:39:27PM -0700, Joe Damato wrote:
> On Tue, Apr 15, 2025 at 05:11:54PM -0700, Jakub Kicinski wrote:
> > On Tue, 15 Apr 2025 12:39:11 -0700 Joe Damato wrote:
> > > On Mon, Mar 31, 2025 at 04:39:17PM -0700, Jakub Kicinski wrote:
> > > > Up to you. The patch make me wonder how many other corner cases / bugs
> > > > we may be missing in drivers. And therefore if we shouldn't flesh out
> > > > more device-related tests. But exercising the core code makes sense
> > > > in itself so no strong feelings.  
> > > 
> > > Sorry to revive this old thread, but I have a bit of time to get
> > > this fixed now. I have a patch for netdevsim but am trying to figure
> > > out what the best way to write a test for this is.
> > > 
> > > Locally, I've hacked up a tools/testing/selftests/drivers/net/napi_id.py
> > > 
> > > I'm using NetDrvEpEnv, but am not sure: is there an easy way in
> > > Python to run stuff in a network namespace? Is there an example I
> > > can look at?
> > > 
> > > In my Python code, I was thinking that I'd call fork and have each
> > > python process (client and server) set their network namespace
> > > according to the NetDrvEpEnv cfg... but wasn't sure if there was a
> > > better/easier way ?
> > > 
> > > It looks like tools/testing/selftests/net/rds/test.py uses
> > > LoadLibrary to call setns before creating a socket.
> > > 
> > > Should I go in that direction too?
> > 
> > Why do you need a netns? The NetDrvEpEnv will create one for you
> > automatically and put one side of the netdevsim into it.
> > Do you mean that you need to adjust that other endpoint?
> > It's done the same way as if it was a remote machine:
> > 
> > 	cmd(..., host=cfg.remote)
> 
> Maybe I'm just thinking about it wrong and/or describing it poorly.
> 
> The idea was that napi_id.py test forks. One process does a
> listen()/accept() and the other does a connect(). The accept side
> checks that the napi ID is non-zero. For that to work, both
> processes need their netdevsims to be able to talk to each other.

In retrospect, it's probably easier to just have the connect() side
be socat or something run in the background, like the ncdevmem test.

Sorry for the noise, I'll mess around a bit more.


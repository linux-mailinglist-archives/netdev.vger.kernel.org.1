Return-Path: <netdev+bounces-181998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3166BA87496
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 00:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3775216DFE4
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 22:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CEE18BC1D;
	Sun, 13 Apr 2025 22:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lm1EWl1b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9582BB13
	for <netdev@vger.kernel.org>; Sun, 13 Apr 2025 22:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744584503; cv=none; b=bwnF98XWXB9gT+tMsfy//IaGd9KVFR1dXFv6JP95G70a3+AiuBVjmj3HndPok2hISqFY4uRnG609AmvdLZUGFqQtUDhtmlXxQsBZb0hL2mr/3UYwUY4xDDrTu3ORNSDEGHkvRMemEYx9bFNsmKTCOxAmAekBQhxENaE8QWjW6tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744584503; c=relaxed/simple;
	bh=mbw4rQdxMJK1fvIAHBzI9atq22D93g/HtlstU0+J2JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcpt8pbceW5+BUMYd2cNj0r2/oQUdNs47X+5Mjj4Au2wybph/j8H2NO1/1TcNJhxG/ovkA4cAwFOs+XDb0W6gwthjauuCa/58aI9uc+qqNeNaBGOpHXs8oXEAwlUQmv8+TmiSWzQ4a+p8sxnUvp/Rgt8Ymdzf+O3ErNWtx7umuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lm1EWl1b; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736aa9d0f2aso4217005b3a.0
        for <netdev@vger.kernel.org>; Sun, 13 Apr 2025 15:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744584501; x=1745189301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jafwuHTUPZ4r62LUQ26TwYA1He44JjI9eDjutWHCZoQ=;
        b=lm1EWl1bm2PY/UkWCIeN8XyYjnQ0yOmQhF1Z8dfABXNFVUAw8MEbyiaF38IEAWl5CB
         fuqgrOpI5TwaBGowujb6CIDXSeLQuzK2e/ZWj8eFQvTz/f/uy3UjerHzKj3G0LOlxxWd
         1vFpVq7KLl2fP3FL1TO/F/5GbzzNPnYDbtrvmEcpcAEuuz17YXoGa1UI7qmls/IvMkFB
         GvXLcElA40JsVzwRjfnMZmit3XVx/oLouUsi7pnd43B2CMC4mt5uCgoHPjmclowL37Bk
         GlF5HmH0o7L6coviIX3vio7oc7wtrK6zhHE4x15E3Br3am0+lgPn3r64vOMGEI5qDPDe
         A/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744584501; x=1745189301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jafwuHTUPZ4r62LUQ26TwYA1He44JjI9eDjutWHCZoQ=;
        b=rPO8A16oSaJJUEE5AuAdgKE45+hWf0aPBDelDJMH4Xnm3yKx4q1FDq4hNIHDJrb4ie
         8cO3uGMZfxOM0QzES8ZSghmDLJ+IR8Gwsi51gzCHVJbvvGF3ATZwuNht4J8J7lAGkcmS
         gSeRDAEKaDZnMtivMTEE+E1UfsMeq97pRFQmp40OnXOM/5A3BIga1bA7M6+c6TufyFrP
         wqvj6N8XYRpf98vMUr3hLfriMua+5Vp1SVX2ar3JJhvt98k0oRWn04wf4sjGKxYpC9WU
         EcjhZzkZV3yNY1g82LB9x9BqJpZ2cgyTDeutGBhk7iZioF76QtAt3GSUefWes6SqJjiB
         Wwhg==
X-Forwarded-Encrypted: i=1; AJvYcCUDdf8uRigj+AoYV2awSuhLJkLxCZXwZcHgRIBdY2Hc0TB7bJqbc8UIp3MvRdgTNcAnDHyPqg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqmvsgoniKjrsYQzDWV1pSXaXSeRaUCHYtuIOR7217GPtokJJS
	DG0LZnEPKI40AEwbHV2akm5HCHogS1moYREU1KrAnMM0A7o91SuuNGjds0E=
X-Gm-Gg: ASbGncv96no9IG3/kPav8cTmrjAn7AXxHrZ9IrtyW9wSB8nx6GeTBFZBHbk5r42FRyq
	hzWVG5EyTn7RZEO7PIxksXr+EZL/O/8dVJSsowIrgQWlrddO6D9fBkZ6G1dtwneaZiXnNAwQ1eJ
	g+NUHwNVho+kC8O4x2YoTmkccksczEpp2NRDpwzDUMs86R37y7rT9hRG3is7pXa7dJ9pNbiT65V
	8PEByOWle0yryQAyT4ZlIPapbUTZ/2ja+LSMjpII/n1vYCPBrwvsqKKdn64SfAyvmDmyyVOrjCV
	lnAq7/kLv8rH87FD4NHgnsh5bETREiGS4mrVhOgL
X-Google-Smtp-Source: AGHT+IFXpmASgHsI+j3p3S8AY0Atw7UAh04v+LW+Dcbsxpj1Gd5Szi4VS+1ZqRXCLUFySlRYOvkXmg==
X-Received: by 2002:a05:6a00:4603:b0:736:fff2:99b with SMTP id d2e1a72fcca58-73bd129e576mr13332211b3a.23.1744584500759;
        Sun, 13 Apr 2025 15:48:20 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73bd2334468sm5397643b3a.169.2025.04.13.15.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 15:48:20 -0700 (PDT)
Date: Sun, 13 Apr 2025 15:48:19 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	syzbot+6f588c78bf765b62b450@syzkaller.appspotmail.com,
	sdf@fomichev.me
Subject: Re: [PATCH net] net: don't mix device locking in dev_close_many()
 calls
Message-ID: <Z_w_M95kn0UFXfDm@mini-arch>
References: <20250412233011.309762-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250412233011.309762-1-kuba@kernel.org>

On 04/12, Jakub Kicinski wrote:
> Lockdep found the following dependency:
> 
>   &dev_instance_lock_key#3 -->
>      &rdev->wiphy.mtx -->
>         &net->xdp.lock -->
> 	   &xs->mutex -->
> 	      &dev_instance_lock_key#3
> 
> The first dependency is the problem. wiphy mutex should be outside
> the instance locks. The problem happens in notifiers (as always)
> for CLOSE. We only hold the instance lock for ops locked devices
> during CLOSE, and WiFi netdevs are not ops locked. Unfortunately,
> when we dev_close_many() during netns dismantle we may be holding
> the instance lock of _another_ netdev when issuing a CLOSE for
> a WiFi device.
> 
> Lockdep's "Possible unsafe locking scenario" only prints 3 locks
> and we have 4, plus I think we'd need 3 CPUs, like this:
> 
>        CPU0                 CPU1              CPU2
>        ----                 ----              ----
>   lock(&xs->mutex);
>                        lock(&dev_instance_lock_key#3);
>                                          lock(&rdev->wiphy.mtx);
>                                          lock(&net->xdp.lock);
>                                          lock(&xs->mutex);
>                        lock(&rdev->wiphy.mtx);
>   lock(&dev_instance_lock_key#3);
> 
> Tho, I don't think that's possible as CPU1 and CPU2 would
> be under rtnl_lock. Even if we have per-netns rtnl_lock and
> wiphy can span network namespaces - CPU0 and CPU1 must be
> in the same netns to see dev_instance_lock, so CPU0 can't
> be installing a socket as CPU1 is tearing the netns down.
> 
> Regardless, our expected lock ordering is that wiphy lock
> is taken before instance locks, so let's fix this.
> 
> Go over the ops locked and non-locked devices separately.
> Note that calling dev_close_many() on an empty list is perfectly
> fine. All processing (including RCU syncs) are conditional
> on the list not being empty, already.
> 
> Fixes: 7e4d784f5810 ("net: hold netdev instance lock during rtnetlink operations")
> Reported-by: syzbot+6f588c78bf765b62b450@syzkaller.appspotmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>


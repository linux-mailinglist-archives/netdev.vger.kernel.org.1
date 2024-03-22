Return-Path: <netdev+bounces-81298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5988E886F4B
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 15:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1DB1C20FC7
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 14:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567C44C601;
	Fri, 22 Mar 2024 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="bDKBAvqX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF9F495F0
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119541; cv=none; b=pH+EWvGc0lDLN4Q8kYlgZ9Sz57xNixr1pu+Zgh3fTzHe0FU0udtGMQ/ajzua2JgDh9dP+YdP13QifFzOm151VfWBW3q0OVKX9SUrMVIHBsJ/9kQu6Laam2YZkzxLs08BJgy03k9oIWldHYbOY1r2LPn7yL3jhaGcPEr2Q6S8+p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119541; c=relaxed/simple;
	bh=AiQFctbzaTK1HCkBXEgz3gqDQuvM6F+0ZtsNNz8c2is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/0yyJTyFVPeIU3eoVeWKdaQrhsyAievyWS2ty2ZCDt2Q3uKSHj2DvYuLQ2HVnZn/MYHgIVso4unstScl/47T3nSJNWpymrop5Kk7Mmmw4H1PQfG1SCI3PG4J6nJgCo6FTYoG7a5AEzZCaQacCpoMkm6HZvq7mALNQcpns1o494=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=bDKBAvqX; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-69674639df2so1343876d6.1
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 07:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1711119538; x=1711724338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MTDU5Wg5nn1gg+QWYYBqICfB2mdqSCGNI1maZh4gTUY=;
        b=bDKBAvqXPCOq1SYaeGYjDzAnkGbsVNWCjwiigso0X+C+g0bjSkTfm82v7mxN09MzmO
         Ho8/I/cfcJVZcz2+OHVKuuX6TVmVwoI4aWF2VKZeN1uIswX75CHqhu+yA70njtWXTL9Z
         irxaWwsdMJQMJwrErXHX5HsBiOev5GTR2h3d04CNIpL8utN7TZLR9PC8i0LrXSbBQAXN
         9vU7bhQptXrycGJ7oFa/MNVwbgIPZtgQMqNeNvCSzAM8sIf8uvcg3Jc9+5zuwZh8UrAs
         uPsV2LPmXOFUwzUYFa3H6+wgtcNllZpaxpJokkjLHe7/J9ivHNXRqf+J354preWylc2p
         5UWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711119538; x=1711724338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTDU5Wg5nn1gg+QWYYBqICfB2mdqSCGNI1maZh4gTUY=;
        b=UYkcBb5ISaGsSbo0o8Js03VJJoiTzFcRqzSnwYHYle8QGz4eloQrlKvHUkNcKRQNa6
         9FCwIlgkxdOLiosHKlay6mQmRmBea+n2v3hx1AKmwkIk5ALOOyp9M1tNlFXYnK61E52z
         XIwAIrTGmgs4o0vgIpoyhjOJyXhgJX7WWdro50TV46kciDE7Ie74m+B7RkPFh8pMdMaO
         Ug5VqXiMpQacJPCTxUK9SaVqLTwbUcW6pythlYwcHCoto6Q8kacuRGSxk7eS58C0AUEV
         bCqtshNzhaxCk+7KJqF6mTA5l9pmHT8oPDomEAowlooa11Wn7DvD72MFOfTQN57grR+Q
         2t9A==
X-Forwarded-Encrypted: i=1; AJvYcCUeoNoeYU50vV6+k046pyPhU541TH7W4bQWPunhfw3uvDEy6vzR5bsZKlryHM1OnQ9ei88DTiaLR73G4D+R4DuvH27/yV0a
X-Gm-Message-State: AOJu0Yyuc3nhjLZV8PxscjFSOITaTLnYN3ggn3YiOwaif32iDxxCrtgQ
	lYQEI7TF4PMA84uSrtzdsy5JzVPAJCF4ntvVge5sHOdYp0CdwHJjlQcv5kUJBehomlL3j2enYtB
	D
X-Google-Smtp-Source: AGHT+IH0Kt9HxGG2lANH6AQq1guApf7R8uf0U24WWMCnk3F6Is2VwqhcqRyfaiW/sgH5mdS4Zcn+9w==
X-Received: by 2002:a05:6214:f2e:b0:690:afbf:56d1 with SMTP id iw14-20020a0562140f2e00b00690afbf56d1mr3052823qvb.8.1711119538002;
        Fri, 22 Mar 2024 07:58:58 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t12-20020a0562140c6c00b0068fddcdc381sm1161050qvj.18.2024.03.22.07.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:58:57 -0700 (PDT)
Date: Fri, 22 Mar 2024 10:58:56 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH net] tcp: properly terminate timers for kernel sockets
Message-ID: <20240322145856.GA3202449@perftesting>
References: <20240322135732.1535772-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322135732.1535772-1-edumazet@google.com>

On Fri, Mar 22, 2024 at 01:57:32PM +0000, Eric Dumazet wrote:
> We had various syzbot reports about tcp timers firing after
> the corresponding netns has been dismantled.
> 
> Fortunately Josef Bacik could trigger the issue more often,
> and could test a patch I wrote two years ago.
> 
> When TCP sockets are closed, we call inet_csk_clear_xmit_timers()
> to 'stop' the timers.
> 
> inet_csk_clear_xmit_timers() can be called from any context,
> including when socket lock is held.
> This is the reason it uses sk_stop_timer(), aka del_timer().
> This means that ongoing timers might finish much later.
> 
> For user sockets, this is fine because each running timer
> holds a reference on the socket, and the user socket holds
> a reference on the netns.
> 
> For kernel sockets, we risk that the netns is freed before
> timer can complete, because kernel sockets do not hold
> reference on the netns.
> 
> This patch adds inet_csk_clear_xmit_timers_sync() function
> that using sk_stop_timer_sync() to make sure all timers
> are terminated before the kernel socket is released.
> Modules using kernel sockets close them in their netns exit()
> handler.
> 
> Also add sock_not_owned_by_me() helper to get LOCKDEP
> support : inet_csk_clear_xmit_timers_sync() must not be called
> while socket lock is held.
> 
> It is very possible we can revert in the future commit
> 3a58f13a881e ("net: rds: acquire refcount on TCP sockets")
> which attempted to solve the issue in rds only.
> (net/smc/af_smc.c and net/mptcp/subflow.c have similar code)
> 
> We probably can remove the check_net() tests from
> tcp_out_of_resources() and __tcp_close() in the future.
> 

Thanks so much for your help with this Eric!

Josef


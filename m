Return-Path: <netdev+bounces-142322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 549579BE45E
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 11:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D2B2854CD
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CE81922ED;
	Wed,  6 Nov 2024 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="KrOMYLji"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55591173
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 10:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730889413; cv=none; b=IxMkG3M+D5b2MBQ6A3ra/jB32HR9YEr8B9cPGKNXM6mRLIGOXOEwm7xFzYNyry/y/Rf9OWA+36+aGc4G9Po535JKeKiyBC9PtwAJNDrwkw3HhswmLMeqz+hNKviQKVQOxFGxknPkO7Yu5W5qLIIVsB6m/t1DP98saIctgcJT6GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730889413; c=relaxed/simple;
	bh=qrIQJMXw6kUIOmEGiKwPWu/9PZsZ/J5lB6S1428lvOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rx3N92IlG2X60b+/rtjTHfrTxX+8NeADx7SrqmtFJG8vWYRY5+4Vj/uzjFcMoipBhu/lujvBZ+nOkALNi3DP1QCUYZ+hIPjLO8eNRCMhg5CCio7m8bTqFRSLN/kkxarkugtbmirdGekND5dD58CCL8owBcls55iylVyRMx0E/YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=KrOMYLji; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb470a8b27so6825691fa.1
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 02:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1730889410; x=1731494210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vXPuHSkz5FPuugwKydcA8dhzjkn4X5kPe3fEupMvTUU=;
        b=KrOMYLjiOS1GFC24qTvxPeWzx8wIcEHY4jylkBRU7V8YA1u+UNseEhKQxbcm4KELpd
         ZgD3DbS+38u68oLnasZWMip6fz5o+txBTgDVklWIR6jeSLSJoVmgOuv5WC3SE0/kUA9Y
         SbgVMcxXU9ol3d1t9amdPDhmldy0PXzKA8l+9M65DLsSjxYSOEbFm4+CItDaV+1d9NAf
         PD4gnE25ULjeq3lkNJYOX4OUXymyvhTq01P1T7aD3vJ56botmTRJ0AsksUa2Abh3ODL3
         GmEEamAxaIy47UBcRlt2G1H6u+Z7sqg834RtM70wzfKpM+TSW2eXkX84dDOJqDjU5Sl/
         qGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730889410; x=1731494210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXPuHSkz5FPuugwKydcA8dhzjkn4X5kPe3fEupMvTUU=;
        b=hnLrWOxJwsN39fFF2OZSHolYf1weJCICPghmyy+kl/5VEBr4NHuTRS4xu8KPdj+KZt
         Ksm23Q3ofDk11yaw7EucCpmdhdmgYCpwsajZ1yBFwnI+n+8jSzNlbhWjc7HHl5LDiZ3n
         TdA7mHVfFCNwGxATE5alfrINJG244FFgCf6JjEJ7FzsudFM3owjCmzzIX9TXOwIO3ZFM
         Y7P9NAlOykOZBV8qyG/VcIt9VQVfljsJSb64ZEaD3PwKVbLytfkJuSKwm90rPt3kupOg
         vzUE/hAHDx/a66sgIUeMRItH19dSesu0wzpcip4RUJxjhgi2EJmKXMlNIxKu3ZpqkVh6
         8qew==
X-Forwarded-Encrypted: i=1; AJvYcCVC99PwOUVickdQ/DNmhQxYl+l+hESEhezKyjJI29Y7UwaSV9RNoTjrAlXeDXPiEu4McGdLS/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzScSCQmcc1vEAmrevD1CBFyz8tNsWTBSUOQGRFkEkXLZQ4xwlz
	nDtVb8ASuW/wa+pqQGVQWMK/DAL5JUNcO9TX1hJxPd6/IKlAw20W72H4lzxU4ok=
X-Google-Smtp-Source: AGHT+IFWQr4v9ipLITMecA4QyMwRZXbApwx2xKZfgUBRu5XKhWwIahf7id27Tt8yfDngLE4scQgOeg==
X-Received: by 2002:a2e:a58b:0:b0:2fb:55b0:82b8 with SMTP id 38308e7fff4ca-2ff0cb11f69mr6689611fa.4.1730889410384;
        Wed, 06 Nov 2024 02:36:50 -0800 (PST)
Received: from localhost ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef8a664asm24691931fa.81.2024.11.06.02.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 02:36:49 -0800 (PST)
Date: Wed, 6 Nov 2024 12:36:43 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 1/7] rtnetlink: Introduce struct rtnl_nets
 and helpers.
Message-ID: <ZytGu2iHWtApeJG2@penguin>
References: <20241106022432.13065-1-kuniyu@amazon.com>
 <20241106022432.13065-2-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106022432.13065-2-kuniyu@amazon.com>

On Tue, Nov 05, 2024 at 06:24:26PM -0800, Kuniyuki Iwashima wrote:
> rtnl_newlink() needs to hold 3 per-netns RTNL: 2 for a new device
> and 1 for its peer.
> 
> We will add rtnl_nets_lock() later, which performs the nested locking
> based on struct rtnl_nets, which has an array of struct net pointers.
> 
> rtnl_nets_add() adds a net pointer to the array and sorts it so that
> rtnl_nets_lock() can simply acquire per-netns RTNL from array[0] to [2].
> 
> Before calling rtnl_nets_add(), get_net() must be called for the net,
> and rtnl_nets_destroy() will call put_net() for each.
> 
> Let's apply the helpers to rtnl_newlink().
> 
> When CONFIG_DEBUG_NET_SMALL_RTNL is disabled, we do not call
> rtnl_net_lock() thus do not care about the array order, so
> rtnl_net_cmp_locks() returns -1 so that the loop in rtnl_nets_add()
> can be optimised to NOP.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> ---
> v2:
>   * Move struct rtnl_nets to net/core/rtnetlink.c
>   * Unexport rtnl_nets_add()
> ---
>  net/core/rtnetlink.c | 70 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 67 insertions(+), 3 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
 


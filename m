Return-Path: <netdev+bounces-142329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 399A19BE47A
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 11:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69651F22C50
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FA21DE2CC;
	Wed,  6 Nov 2024 10:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="yMnM7un5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B411DC720
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 10:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730889690; cv=none; b=Gbe5ZGsr2JWVjcg7Gm0lZXvreoi66eOwuFqVs0kOlviOzZmVYFwsBM3lTEZmJljKA0L5a2wTcEo1E+LW6pQPeXDvcXMLwxudFs9dgVzZzU9/qEacMc5z6J5QaNOUM/0D9oX5tzXstlUbSwlUMSjoONMVCEO0D1CiUZ15ghmwKvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730889690; c=relaxed/simple;
	bh=UkRaA3z3srVwi/SSidFvQCqPFPiDhsIvJTNuDDohgDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXyEZiMJQ2eqO2txGqMjJvghqFNiqwwken/EQs71hFb6lWpFcDAca0FZzyqSG/zu085onEYC4+xlGHzDof3o5N2NV5rNOjvpxEGVKLL55Q3vzHsDyZ5IZftrx7koUjb+upXy7jxpJ2BfnKLnjdFhBmDR2ha7AzLEUH3116GWMvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=yMnM7un5; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso98508401fa.2
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 02:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1730889687; x=1731494487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sfxO3AGmzAhYserRSQ4jLtyelh4E+bNb+e7p8QpHRq4=;
        b=yMnM7un5jnVRYx4xqm5rX5c9cUIzJ6HjApdZByiWWhhdn2PPdyo5jhE9dnH+arMkSQ
         3QYeXsVsC/n58WVU7NVdZBHsFx3z25nMCbtjx6PnSqf4zzdFD+z2MzjZ27B1F6UDt5G5
         17XoP5SQ2YCr21kQojBXwDpSLWsVoEizqs2ieZhMYmB/U3PE7x9U9fH/yzdBxgAoGIOp
         ZmOCYqy9HiF+pOaVXoirQas2eGgaboDy9VFhyvUveB3nDRXPSR8koC9rxa8gIsPR60E8
         QGpV4OyhhoCe5ji/Q9+stoXCOQYUgNPI3jzAZBb7kT0XlzOuAKzvFkTcwBe4gm7U3L+u
         F3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730889687; x=1731494487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfxO3AGmzAhYserRSQ4jLtyelh4E+bNb+e7p8QpHRq4=;
        b=iNVKy6360ur+aefkZRbvsZH6ym6OZTMJ3Oj0f2InJYdNQ01h9wGOLCVBxHJyXMAIrx
         h1MSSSLuJzbQAQS00o2sMgrQD170d6z6w3cExumPjhg2vE+mfisSFWrmISq4Ud4fJZgt
         LsFb/WWTvk6/rxiFIYef398YVwYUUH66WFPtrBc7RT+9Of+fagjgPLXIwpQriOg6VBs7
         34gyBmH/HbExCnIdc07XcSGk58PMhxtIscvUMCYXm9XV7j2G5lzRzNJa/Xx8jGJ36WPA
         LfwHP3l8iTcT/0kU436Z30DduqPSfgArWkhk20Ou2eZVbuT0lW9DFEC2Bb8vU0efvI8f
         bnAA==
X-Forwarded-Encrypted: i=1; AJvYcCWGMGXYFWKn5x/ENd9DHOwxVhvS9sZeNKpYGdXjxRSaZfcGXjlZOdaZZQQxGpFm9gVZeXkrY7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBC5j2A4VYxv4cIsNMFbfpwq0VCiefTFJ1cKWCzao7IduSF39T
	HgqqiBvziKLCmj9ER9Ms9v1EYda6kshoDjwWZ3XN456MXwjmd5u3cmvourjy7Ls=
X-Google-Smtp-Source: AGHT+IEIqCY0cso62G+IF/VEf7c0Tx9x0LM59I3F4XIdIOE8902BxqTOHoC9tvNFnN4iu7PjD3/1CA==
X-Received: by 2002:a2e:a98b:0:b0:2f0:27da:6864 with SMTP id 38308e7fff4ca-2fedb7a2d44mr147070281fa.17.1730889687358;
        Wed, 06 Nov 2024 02:41:27 -0800 (PST)
Received: from localhost ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef3aeadesm24498481fa.3.2024.11.06.02.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 02:41:26 -0800 (PST)
Date: Wed, 6 Nov 2024 12:41:24 +0200
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
Subject: Re: [PATCH v2 net-next 7/7] rtnetlink: Register rtnl_dellink() and
 rtnl_setlink() with RTNL_FLAG_DOIT_PERNET_WIP.
Message-ID: <ZytH1CjCShr23AoC@penguin>
References: <20241106022432.13065-1-kuniyu@amazon.com>
 <20241106022432.13065-8-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106022432.13065-8-kuniyu@amazon.com>

On Tue, Nov 05, 2024 at 06:24:32PM -0800, Kuniyuki Iwashima wrote:
> Currently, rtnl_setlink() and rtnl_dellink() cannot be fully converted
> to per-netns RTNL due to a lack of handling peer/lower/upper devices in
> different netns.
> 
> For example, when we change a device in rtnl_setlink() and need to
> propagate that to its upper devices, we want to avoid acquiring all netns
> locks, for which we do not know the upper limit.
> 
> The same situation happens when we remove a device.
> 
> rtnl_dellink() could be transformed to remove a single device in the
> requested netns and delegate other devices to per-netns work, and
> rtnl_setlink() might be ?
> 
> Until we come up with a better idea, let's use a new flag
> RTNL_FLAG_DOIT_PERNET_WIP for rtnl_dellink() and rtnl_setlink().
> 
> This will unblock converting RTNL users where such devices are not related.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  include/net/rtnetlink.h |  1 +
>  net/core/rtnetlink.c    | 19 ++++++++++++++++---
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>



Return-Path: <netdev+bounces-142325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46429BE46B
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 11:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1200A1C2161F
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07701DDC29;
	Wed,  6 Nov 2024 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="kxJz/IyZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C0C1922ED
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 10:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730889538; cv=none; b=ZyIbQKQLqVQfyQ5Ju0ZbMYKeHzYZONGkTDy9v39wZH486Z3jFttmXVbC63do3jj0AD40mzGuYPA35/4KcHopQ3jxvOu/OW3uqxu03JthQKiskWkpvJ/R2PvwvpnxeUoZ0ZhOIcdK8WH2IH/dMizN0mZk4IsJiZr3rWp6yILMABs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730889538; c=relaxed/simple;
	bh=28U12kPmfhZyLguijgoZ3tCcn5LGd6isZgZwUiO8V6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cn4GtL4NyxJrj41lloTiVOiwlH23crsQuNdu8vwcM/MFH0jAXko8JW9wd7sgYWC0v0qBFHPqtEYI+Gv9pkFsly4H3e2bxbd7GE/BWD1OOJBO+t3MDMbxvqcKMlaRKABtUjwYy4ktxl/DfEOUtOcFNVhwD5JKiJZkdu9DGF/1KxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=kxJz/IyZ; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso59916721fa.0
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 02:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1730889535; x=1731494335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wxcHn3dB9uRSvjxKga1w/fN26S2mxKEgkIIG/qNW4ZE=;
        b=kxJz/IyZr2gxvk3ocdgTJrrbULJz0DJ1wQFDc6QQ8xZKA5HQ9Zbp6IToBJCnTVTF5v
         /a4SNPcj7ESgm+WGnh1gWt0Z2CNDaU8CkibIQ6t4rf24z2xfUFW6uR3+scwaUKPrv6Eb
         081y6KlySwmnbRK4TIlLASL4N00btQrepjgdCdvSeWyiyGLtncDIgKq4srDanaT9AALI
         mUkqvO87hCdA7CjciZ1MoHI/DVhWpm4ze5oNJ9RIGAmv7rd4UoMytrDBbBU331XBA3KD
         iljT1tlFnz4mQI9HIvDxsiSFpk4+ZMJ8mlYOf2TeaAjJxUOcSBEFrhiEzBhwF+3siqg3
         S7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730889535; x=1731494335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxcHn3dB9uRSvjxKga1w/fN26S2mxKEgkIIG/qNW4ZE=;
        b=HKoT7sAD5hQRKa+h0bHVwSzzGclWOGpm2FF9AFBDosK2V4WfeqrZ6aG5guJfbbQJdb
         HFmJN7/uyDQsFGxzIsS2ci4wrUfVW4iBn/r5SBKw4Yvqp7JkNAZAdZsVPrxDkK2sBs/T
         F6xRMW9VlrImVrGAyZHn7WMzaeGY4DUTNR0eupmhvSa3Hnsy/TqGzMSEPz6dGgY/QxKy
         yKDaKJyBTtqQxzbMw9p3EanrIAQ7KzuAT3ynFZ5Pakeo7EC1Re7p7Es0yLOgAJjRHdGU
         +hRe8tev89rfXcP9+/YDUzYliwqqSUT55OHersLxfBcZJXPdKGYK1RNhYRURsikXJtbj
         B9kg==
X-Forwarded-Encrypted: i=1; AJvYcCUo2irFTsJG//7K4zwPNlLJAwjHHwfnggsBkUTT3l6XGalSV4X08H9wIvvj36T6ybVks5WfSYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtKu8R6u2onyr0v7ccxFZHPdIJpTuFY1YLUp1FXJxtDQULh9fK
	8tqFSi95m0MgnTnySFPuktlXqvzttWbqjJrLuvzwc3CdACvit8gU7Hr5cPBuXfg=
X-Google-Smtp-Source: AGHT+IFHH/ijvrNCtivzSpx03pcAlz3ivdkv8afwiTRwqrj+ob66Q2BgQtXRv54ZuV7ZRl5raLEhmw==
X-Received: by 2002:a05:651c:1508:b0:2fa:ddb5:77f9 with SMTP id 38308e7fff4ca-2fedb7ec448mr104404001fa.40.1730889535244;
        Wed, 06 Nov 2024 02:38:55 -0800 (PST)
Received: from localhost ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef8c335bsm23391551fa.102.2024.11.06.02.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 02:38:54 -0800 (PST)
Date: Wed, 6 Nov 2024 12:38:52 +0200
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
Subject: Re: [PATCH v2 net-next 4/7] vxcan: Set VXCAN_INFO_PEER to
 vxcan_link_ops.peer_type.
Message-ID: <ZytHPCwap5E4Th5z@penguin>
References: <20241106022432.13065-1-kuniyu@amazon.com>
 <20241106022432.13065-5-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106022432.13065-5-kuniyu@amazon.com>

On Tue, Nov 05, 2024 at 06:24:29PM -0800, Kuniyuki Iwashima wrote:
> For per-netns RTNL, we need to prefetch the peer device's netns.
> 
> Let's set rtnl_link_ops.peer_type and accordingly remove duplicated
> validation in ->newlink().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> ---
> Note for CAN maintainers, this patch needs to go through net-next
> directly as the later patch depends on this.
> ---
>  drivers/net/can/vxcan.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
 
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


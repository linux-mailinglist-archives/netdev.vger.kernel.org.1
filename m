Return-Path: <netdev+bounces-142324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5649BE467
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 11:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD0A91C2189B
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8911DE2BB;
	Wed,  6 Nov 2024 10:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="kZP3MbNv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BBF1DE2BA
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730889510; cv=none; b=Ds0B6WcpSADbuvI/34j/uuYhrIqv4MpVYeX4qazFvrqe8r2lCG7fLxpdZXY/u4ThCdKFaqjFncMnpJKcSqtoH3zHFoFXbzjDxedcwBYgB82cf2A7GsaoWzIuFyXC8Z2IOHh9oa2pjg84/gaPUlxHuQ9xhPoW4QkxuMOsvoRM708=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730889510; c=relaxed/simple;
	bh=/Nu4ID/5XBvqIiQMQehxM9UIuA2RLWD31LywL1nXxiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u65Q/J7e/BIhvEDWI/ltM/6ME24/JH6vpQug0Y6xyohbNAW6iewBzQV7Gepk9uGk1hM/gwpAvnp/fa7dCXfDNNvZVYLIAeJ7jLSKAMg8P+MrmAYByfXcRBS5KmD4Mg3Ntayatr+rgumtbh/3SrIwJ6vVi200XnUjuflIssK/m6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=kZP3MbNv; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e63c8678so7262302e87.0
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 02:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1730889507; x=1731494307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SaYd/kpwnxi1z0A8cT4yq6+p3c5UYHygN+sv6WQqDns=;
        b=kZP3MbNvsHr6g8gz/b+zEKjLmgFlJSBmdfDhc3OEheraQeLweonOD0PczClkEB36dD
         n73SwnMeq0Mg2ekTbHLC0M1tSnGHghcIq+AtBJySyRmNmpQGmPqak36pf609Vc2cUt2S
         WUHj6huUYbkqJAV0VJydAzywuAZLg4NeyLyrz/vMN4d4UTDsXiZQ9Gab9mF8L/u/YuYe
         OVYA21c5SijbxyOftRtklt0Gmr4ptqgnY4K0VnIuDb5VcX7QwqeQD+EZgi3oOXSISXlv
         +opgj5DoozTtb7Vtk61wvav3PyqcYFUMWQHmd7MpAN0g6bQ6xEvNWf7rNoflVDb3wZHg
         6mZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730889507; x=1731494307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaYd/kpwnxi1z0A8cT4yq6+p3c5UYHygN+sv6WQqDns=;
        b=fPwYFpO9ArdKcQXOHxYsWWsxGHeLNt7+rTpe5NjXu3liz3v7pOJ3LPdfMX4dju+0Nj
         C2JyNavxJQte5jr9bzy2G3ym5zJPkYoqc63Ju5DkAEuChMC7FxmYD33Sj2OY/CbHgu5W
         if4OoiMd/WpQoFW+qvvJpe/omwXolC+zzD/fHzm1oaUSK48GDJKYPDjbO+YZSIkWzDJr
         3cR0hC8OZpkem7FxO7mcj94bg0dUyttN53JsqwWhBlBPd2FeSskzlkwqRiES+fynVgxL
         mN3U8z9zr8Fg+q16JE+0Iyws6TqWa8NiGtS7RBj3ln/QHnxvcLjWoQjlON9dX2HrplPf
         aRHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiMw2eFrBz9W97BS/v/7E+Ex2Ie4CHm+CLRnpSpM2VTe4Qg+xS2ZK26mFxXC7jrpUFxHKgzx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0FJDzIEtvfLIkMv8k0Z0ciQveXV7eWHJeabt/iwDfD2CdaRHR
	FeoqoBI/7XHyGFeZDn1wmNpuD1DwGQL9SklUFcmwlexFb45qbufVxxlt2Sx39vQ=
X-Google-Smtp-Source: AGHT+IEvJxaQVJ4sJcS3ySyOo9aS6DW/GZL24t+E59QJv39VtpSB52yYGQj1WQ5714vL24qT99j9Wg==
X-Received: by 2002:a05:6512:1150:b0:539:de0d:1e35 with SMTP id 2adb3069b0e04-53d65dd0926mr9213812e87.1.1730889506769;
        Wed, 06 Nov 2024 02:38:26 -0800 (PST)
Received: from localhost ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc9c133sm2473368e87.100.2024.11.06.02.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 02:38:26 -0800 (PST)
Date: Wed, 6 Nov 2024 12:38:24 +0200
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
Subject: Re: [PATCH v2 net-next 3/7] veth: Set VETH_INFO_PEER to
 veth_link_ops.peer_type.
Message-ID: <ZytHIMh0o9cL9xcZ@penguin>
References: <20241106022432.13065-1-kuniyu@amazon.com>
 <20241106022432.13065-4-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106022432.13065-4-kuniyu@amazon.com>

On Tue, Nov 05, 2024 at 06:24:28PM -0800, Kuniyuki Iwashima wrote:
> For per-netns RTNL, we need to prefetch the peer device's netns.
> 
> Let's set rtnl_link_ops.peer_type and accordingly remove duplicated
> validation in ->newlink().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> ---
>  drivers/net/veth.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org> 


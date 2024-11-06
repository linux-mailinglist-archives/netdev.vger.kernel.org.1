Return-Path: <netdev+bounces-142326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4609BE46E
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 11:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B048B23BB4
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483121DE2BB;
	Wed,  6 Nov 2024 10:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="2Lt/3bYd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E531DE2BA
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730889569; cv=none; b=CLZ5teyxGGGik89ex4Opy9u913ga6ZJhwL2Oi4j4zDjkGjZHgeo2wfHPF31BWLOcYdZfZVQnSxSwcAFOIoP/LtWDIar0RaIvoiB2OVbOnn2fX16QUUYcavNOyRq7xDqii1oMLQvLfXN6X9YO6b2J5Gd2rExkUN3xUXOFKmhtk1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730889569; c=relaxed/simple;
	bh=nUQiZS9psmAs2fUPE+dZ61w6WYC2pYRbUiCzVFaCPZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwkSlWK8HL/LHcZUJt8zI8IkG3x4117X3PoszbnmUf4CWhSqc6K1NFLn2x95V7owuKRobZsiXmZBmMihDi3bTSnsf3OuI2IQz4IdMwUa532VsC8woPLBv57142ZOBNxCF3gs5wpodJ6GBPvYWs5jBxZeKBeqxJbcmg1kADrhw+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=2Lt/3bYd; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f72c913aso10462693e87.1
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 02:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1730889566; x=1731494366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1FypXFzGZvEugbvZcDY2Iclht7lH3x4dJlOodtUNyI=;
        b=2Lt/3bYdIoc05puiL8Nw3GsNIMSFHdSDR2woavrnIz6Zkd+WJAbZCpYeb9gq/vdz4p
         4SnJDdC3NdM+N1+niI6TRROwEJdwTpM1h7zKC+ELQ0/wXmSOV2YJFPip9tu2R7DyKvPX
         IFXi0by8GhYR0tN5O+kf8qMnDe+yFZmCD1jkfwKqWBMCEe1/UZTZnpz++Bu2EzWRXhuj
         91PkVlnFXh16OS861HJn81iyKZ3GFIyBZpPKRUze7RB39Pctflp54o9kdv8HxS8kcS/5
         4NOILTmqgqCb921n37Z6ml0UqP61l5qTkGc+zUSft0HHWza8WWKvrWVqHyOWRmWz+2Iv
         l+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730889566; x=1731494366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1FypXFzGZvEugbvZcDY2Iclht7lH3x4dJlOodtUNyI=;
        b=iuTCl8/HRBPQNOxrS7sBHVqjcCtjnKWcGhk5Ne/BSIZRDrHTCJBwp3CGOIimn2ncy3
         nlZavdF1bUkYstuADUXQMy0g6nWatdBaFcDrF4H1HmMa+s6LGkRn4n1jLe6Xpm4Yg16l
         Uw3oxBXuZzo1IGRdSjypnokcgxt6muKSNt56BFMeuJmL25r6U184jcZ3Vz5+dYoyyfXH
         tnmyd5H+4Ax5+kBhTr6HFqdH0PQbZqgV36Bg7t4BdSOIEFT9+GTEVPfGdQ5LGaqcjlQR
         d9JoKrx91Qwmp4Q+f8w+eW4NKpcgDjDVgKwEHKMsliBYbpegEFrov7MIeRyFsPSouTc2
         1w5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWngcNwvHEG3OyKqtFabx/zsD9vU3BL+1P9xcPIMwa4y0KreuhwM0RD+gNazPE3pj4U56NyRHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWHV+SM37Tzm/P0KH84Iciktq15jSFnculQo4mRUVkUMhakeG9
	41weaWV0Ja/1z6Imic5efcmQyzUwlZnkJiElJ0ZF9q8AH6vwJtEBNRBX6ym7DnE=
X-Google-Smtp-Source: AGHT+IEkQEeEFEb1GW1AOA8ZNwHkZMIdnFQpl7q2qhYf2whifOUYMyZtgbYS1IBHjSRbwinsavA5lA==
X-Received: by 2002:a05:6512:ad6:b0:539:fb6f:cb8d with SMTP id 2adb3069b0e04-53b348e1452mr20738083e87.27.1730889565638;
        Wed, 06 Nov 2024 02:39:25 -0800 (PST)
Received: from localhost ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bde14edsm2453912e87.274.2024.11.06.02.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 02:39:24 -0800 (PST)
Date: Wed, 6 Nov 2024 12:39:22 +0200
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
Subject: Re: [PATCH v2 net-next 5/7] netkit: Set IFLA_NETKIT_PEER_INFO to
 netkit_link_ops.peer_type.
Message-ID: <ZytHWogZhcmr5c8R@penguin>
References: <20241106022432.13065-1-kuniyu@amazon.com>
 <20241106022432.13065-6-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106022432.13065-6-kuniyu@amazon.com>

On Tue, Nov 05, 2024 at 06:24:30PM -0800, Kuniyuki Iwashima wrote:
> For per-netns RTNL, we need to prefetch the peer device's netns.
> 
> Let's set rtnl_link_ops.peer_type and accordingly remove duplicated
> validation in ->newlink().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> ---
>  drivers/net/netkit.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
 
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



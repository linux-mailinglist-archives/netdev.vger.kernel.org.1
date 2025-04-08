Return-Path: <netdev+bounces-180025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A4FA7F299
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 04:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD86177F3D
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 02:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B58E157E6B;
	Tue,  8 Apr 2025 02:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="pVgGvw7p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B011F4A21
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 02:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744078663; cv=none; b=A7jVUzc5RxK1aLUqwjwI9i+ntU194xKO3UuFJxRUg0uJNKz7vSpBy5cpEpV7azrWEz7h7/oZ+H+1AVYm+u9hw+FMJaA+ijdzqX1pQYdpaqrj/7uyWflb51ZcbxBj1nGFZNozRI3zLRX57RL/Mn4Ckw2s2nUkAOMa5CHP6NhL89I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744078663; c=relaxed/simple;
	bh=f8nqsIoSrB2UoWBStxPg4auyhzxwOet/IZUuESTb9iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqQhf+iDBY3cuJrc/8zB4Dtbi4eTZTuv4SsURGCyUYt/+v8VhUDd6UElm1KOGUpS+Xqo/+yJY5LVISEKq6zVEJ9FXB5qUERjbCFKzQLwFrq6Yh2A6Lehfq7GWmnYKFiF+tzYefbUm+QYgS1tVC0xcr4gd4WdPparXF+GqzjFeRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=pVgGvw7p; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224191d92e4so46456485ad.3
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 19:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744078660; x=1744683460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bLq9b6JKP4taz9O+M53IYvCvMkStISKatzDVjrYTh4=;
        b=pVgGvw7pWP3ZVNAd8zMeoC7yZI9l/Na82rMttANOr/9E0G/n1sFgyPzXaHK/8Ey9tg
         1v9mpy+TyfhONTCWp/TLc9uJyR4zyHXffh2StGj6yUffPutvrM2JGhoqDxp1l2+0LKus
         8OPfodvXqv4iq++zkkxFbsI4YDVvblbW6xBqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744078660; x=1744683460;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0bLq9b6JKP4taz9O+M53IYvCvMkStISKatzDVjrYTh4=;
        b=CBEP6clqRoJjQoysbsfIiIKyU8CNeOkTELfxWKkoBGh/GGEf3QVtfGcX/GwdrqLD7O
         HaZ51PL5mhk2iKcMs21rMs0P3O/HKps5wkfeKYuEqsmMHz7krEUk38+Nq+AChg465CT6
         du9xRJ1fd/6ewGjJrwNthyqLg9DjyMyWnK7qhTJgsGRI+K0Ux3bFGcLdX85G56fFiGQH
         /MX5+gwwulRpDEglPZ03IryObdRzUCobh35V6Voixh/lXczQuR1gqu+ysL3HcApAY9Jw
         gHysWvIBktORO0uTc+LMLqYEfCdcZif68j9CRa0xEE0CalLJziGtHLBw7XXNebbDgO0e
         pKeA==
X-Forwarded-Encrypted: i=1; AJvYcCW0ZTPOguUd6eS3fHrpW3wq75whjSajogl5AQP2lhOszr7ruGhFaHmbLQAkhjEiXfviG0DdtUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTp+ojFK8CHkNixip+VI/aFDm7moYW8J0maGYSX383PlEg66yT
	QI0JIzO81pEnKLeI+xuuFdmrWkrsWWqJjRzlnYkk0Z2hihcephH7XpjubYw3WNM=
X-Gm-Gg: ASbGncvqkuXQk28J8vgZXG3FEzfgRZuWytB+2kr5UVpFB0FhYgj6J8ogGuo0ECk3yJg
	1c3gREvtfXiiIXh4DBAtzqWY/qnKk+rQygm+oFIN/l4+F4MZN//c2KsoaPRxxNKwqdL6j9XBBFc
	OiwwBqHfcOYb1+sUh+Qy+wglSn69lneHfOdLCAH/aI9KWpvUQFiyBqd6StzcgnKEmF4/owUX3iZ
	PCi3KaCuWHYYecfne6Ii4ElW3ifg7oPeTHY2N+089G7rWYd00IUShr28JguHQU/zRkH9eNCy3/D
	YLq4NJWCuOSoLJj3RpKpKonF9vObExAi2TkuXorOKVngdF4Qv3zhsdXExcVF4JC1BwAstpyDtmc
	sonCHPGoKLc8=
X-Google-Smtp-Source: AGHT+IH3XAHDID2zF+QyFX7OhdUf3f/RnrL/3hvWvV3+PcTbs3I/Ft1IaxedMCC0YZ0uple9U2X/mQ==
X-Received: by 2002:a17:903:246:b0:223:faf5:c82 with SMTP id d9443c01a7336-22a8a045fe5mr170320385ad.8.1744078659911;
        Mon, 07 Apr 2025 19:17:39 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785adae3sm88909645ad.16.2025.04.07.19.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 19:17:39 -0700 (PDT)
Date: Mon, 7 Apr 2025 19:17:36 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	sdf@fomichev.me, hramamurthy@google.com, kuniyu@amazon.com
Subject: Re: [PATCH net-next 2/8] net: designate XSK pool pointers in queues
 as "ops protected"
Message-ID: <Z_SHQJ_pLOgz9vpM@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me,
	hramamurthy@google.com, kuniyu@amazon.com
References: <20250407190117.16528-1-kuba@kernel.org>
 <20250407190117.16528-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407190117.16528-3-kuba@kernel.org>

On Mon, Apr 07, 2025 at 12:01:11PM -0700, Jakub Kicinski wrote:
> Read accesses go via xsk_get_pool_from_qid(), the call coming
> from the core and gve look safe (other "ops locked" drivers
> don't support XSK).
> 
> Write accesses go via xsk_reg_pool_at_qid() and xsk_clear_pool_at_qid().
> Former is already under the ops lock, latter needs to be locked when
> coming from the workqueue via xp_clear_dev().
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  include/linux/netdevice.h     | 1 +
>  include/net/netdev_rx_queue.h | 6 +++---
>  net/xdp/xsk.c                 | 2 ++
>  net/xdp/xsk_buff_pool.c       | 7 ++++++-
>  4 files changed, 12 insertions(+), 4 deletions(-)

[...]

> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 25a76c5ce0f1..c7e50fd86c6a 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -279,9 +279,14 @@ static void xp_release_deferred(struct work_struct *work)
>  {
>  	struct xsk_buff_pool *pool = container_of(work, struct xsk_buff_pool,
>  						  work);
> +	struct net_device *netdev = pool->netdev;
>  
>  	rtnl_lock();
> -	xp_clear_dev(pool);
> +	if (netdev) {
> +		netdev_lock_ops(netdev);
> +		xp_clear_dev(pool);
> +		netdev_unlock_ops(netdev);
> +	}
>  	rtnl_unlock();

Is it actually possible for netdev to be NULL here?

I feel like it probably isn't, but if it were possible we'd need an
else case here to xp_clear_dev(pool) without the netdev_lock_ops?


Return-Path: <netdev+bounces-210397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A57B1312A
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 20:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534DA170292
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 18:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3A6224892;
	Sun, 27 Jul 2025 18:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4tZMX+BO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA41621E0AF;
	Sun, 27 Jul 2025 18:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753640928; cv=none; b=A51EFM4dpXFeuOLT41cdAakAtaGT0PFJdLav2Vy5dhIHDsM9qZMCAHeZUn7hBhsFD8aHbTPO62aA8PBd2km36BjTVTQqw2O3SNUOqIsMfEjcHnsuS6qaKFE1ZZ3NJGUXzgweNoN6mZOuG9QxshtdawzNUjwn2BepkJuF9GFPWs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753640928; c=relaxed/simple;
	bh=RTDT4qrqNVbwO8XdQUIlL2J6PS2o5OmWVYpqXftiQxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOBlgmkKw+NCat2fQC26zn7tgL+USUMev8bqS4TUDkM3po4xTwFCrWjhriuwRrb4gnrcVFhhrDPs7hbahCk+FdxIl/6hOfMClkrtyHkfR459Xwzu3M6I+TSwJeWsCRh7P8Mg/TbhHmfGoeWYtrmhRuFJL3Dl6vNyaAjbzMjR8OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4tZMX+BO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gfbTvT4o4sNA4mwDn2pT9ma0vg6bB2j8rF5lbj+8V6g=; b=4tZMX+BOPFA+3gVPghYwSmx5fZ
	ypS9hp1mAga8funfTBxeen0aX7Q7v9Q0OSvMtOVKZtfHjJ7k+oFrstiaXjpaj8gnUmeo2UtaR/Lz8
	qj7DRD+tfCx3O2U/g6lOe09ObRvn+D12yBVUEI/wqJ9le8Ujp2CvuF9mD6F/Ij3p88dA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ug66v-0031GQ-GQ; Sun, 27 Jul 2025 20:28:37 +0200
Date: Sun, 27 Jul 2025 20:28:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ujwal Kundur <ujwal.kundur@gmail.com>
Cc: syzbot+8182574047912f805d59@syzkaller.appspotmail.com,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com, jiri@resnulli.us,
	andrew+netdev@lunn.ch
Subject: Re: [RFC PATCH] net: team: switch to spinlock in team_change_rx_flags
Message-ID: <e89ca1c2-abb6-4030-9c52-f64c1ca15bf6@lunn.ch>
References: <68712acf.a00a0220.26a83e.0051.GAE@google.com>
 <20250727180921.360-1-ujwal.kundur@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250727180921.360-1-ujwal.kundur@gmail.com>

>  drivers/net/team/team_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index 8bc56186b2a3..4568075fea6e 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -1778,7 +1778,7 @@ static void team_change_rx_flags(struct net_device *dev, int change)
>  	struct team_port *port;
>  	int inc;
>  
> -	mutex_lock(&team->lock);
> +	spin_lock(&team->lock);
>  	list_for_each_entry(port, &team->port_list, list) {
>  		if (change & IFF_PROMISC) {
>  			inc = dev->flags & IFF_PROMISC ? 1 : -1;
> @@ -1789,7 +1789,7 @@ static void team_change_rx_flags(struct net_device *dev, int change)
>  			dev_set_allmulti(port->dev, inc);
>  		}
>  	}
> -	mutex_unlock(&team->lock);
> +	spin_unlock(&team->lock);
>  }

void __sched mutex_unlock(struct mutex *lock)
static __always_inline void spin_unlock(spinlock_t *lock)

They take different parameters. So you need to also change the struct
team to change lock from mutex to a spinlock. And what about all the
other users of team->lock?

Did not compile this change? I doubt you did, or you would of get
warnings, maybe errors.

	Andrew


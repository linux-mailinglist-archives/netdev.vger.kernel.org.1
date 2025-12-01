Return-Path: <netdev+bounces-242900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55929C95FEB
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 08:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059B43A1F35
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 07:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC631519B4;
	Mon,  1 Dec 2025 07:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgCdTmRv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C723E2BDC10
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 07:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764573815; cv=none; b=exe1wHLxOTJEDej1CnBNsLjt1pL1rY9UjFk2vf11FYEFKL5PlXN3XJlauzW7fElrgGVdc2QmRysnKCOKj2SrHrgZSJa48lDEhb1JFIvDVKIPQmD8z2I3ddAHELcQ4GY1P97hgSAiYD2jEC2AZ6GOK8OFTScLGjiuDw8qtTiX9C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764573815; c=relaxed/simple;
	bh=n/g7/adDP/jTkPJ2lWUnUlVVXM5EKjcI9GVIzDWqhoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1uG74PcLTZYR2Mf3QPkLyelhtnxPRbQmh9ByjZf6VRSOIl4wHLFY/+1jDQB+5w0FHwcNl5QYfuWI9xmvgtRcOehf30Ih6JwHUQOcX/SOa6n8Nkz6XUDx6eDNqxOZj2HwLm4uty5YJuXFsYYU69/QAYvQLTWOBtttiSmQF/ai6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgCdTmRv; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso6208645b3a.2
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 23:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764573813; x=1765178613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+9KrWeNVVA0+MJ793lD590Njy12dOhljboshoQZpiSM=;
        b=UgCdTmRv9oYaJ24lWp1YE6N2vE6xq8BRdGmT1++9ebvIhIE/M9Z83/SPzDkmXsD68z
         niqPpJxNNthkMBIg8b7KhqT7XgNd7yHl0SX+yaZbQNUAVDiumxXmIBPCXZmcm5fR+zzn
         rsJberUBVrojoPtoDDk82P9crqVjAEZwCvQuOMGp8Fmo0Oh1C+Fd72TF+ZaD1X1tOumf
         KAhT0frtKSldmwt9aPc1bPt8veMOOo1em5nmKyazvlmnnnrdyYLZVJioIf3F5FNjGCw7
         jrncofc+mhZmNO2HIXJKbGyzwaME+DGHtU7WvlUGPrkmtDhe/faNhDeoJl16iwjBkWfV
         chjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764573813; x=1765178613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9KrWeNVVA0+MJ793lD590Njy12dOhljboshoQZpiSM=;
        b=NwNjuUkqimAMb8b2flb/5PpPtf3tVc4mMRg7xk3F/EE2VGejvtq/vqFmotSYFQYTxu
         teh1VypPst1L05AYOnhv60D539gCYuH1Csl+t20u/1Q+lOkd/6OZ3jbMNhnEdzjnMBLb
         m410zkpnuzJr3b2qC5v0piD/5yymvwPCYrcnTz8v/cqsqH1d7MO9hGdugsT8CLdTOLwM
         FbqGvcOOQLzJkP8HSHDg00m/J/PayNg5ImJVbGUXiSFioBuUo9pz0RUoWFEDYsE3oGxd
         LfEVLPCjhyfvgZBihFjW5KtxAVcF4v1+RGNjUZhUP2bMr+iTjJC9BJnujqMqm2nBKfZV
         yNjA==
X-Gm-Message-State: AOJu0YwJXkfZQPriKv5HvY+AghlluWeSYeQsi84OiU8bHwPCEDIK8oKw
	yfJuyrIv2ATUUYWZxJwEzPsmnxWudQ1mfCNRIP04imIFCHzypJgpw94K
X-Gm-Gg: ASbGncsj1KSE7dTpIqt9Fl4qyYCjA4TYgmYAkDAOv+ZMOTixIaLmbtpYgfSSgHiGe/y
	xcpZWym6/3JKa4NjMNK4Gt9EquyJuGPywGcC3ct6lSPPZ15YVEZEDlfWoU0N6MOx9RWyhCMazt2
	niK02kcCgQIfA7DzivHo4WhcR6lPMZti/eZRBpdJDDr14gdoew2eT8r6XNPKvsp32y1+wkITLg7
	M16d+GMI1sNhWPX7bNTIXHQPASWGyxPb7QO6F4JE//dJACze358uSQ98R/gJtZRKdb6szJkqWZR
	UwjsTgZLcdLuOheAoLYw3Y8tIiQmTKcT8rYktCUgvnnZmRnOzqvyVELzswpWLjIePuFTL8BMFh6
	U8qBETUEah3PsXJZtaogl9RTzGSy11OPbLzR7QYvUC7vAWI/6OnSQWNhL7gz5VcIv5Qf9/Ly8Px
	c6TtN9WF1vxTXUKeQBs+PX4xzJVw==
X-Google-Smtp-Source: AGHT+IGczPhvm5PmVBeqrM1PhUyon8Kc/dajmm0luyb2Lvo6gO5PaCcs0pmGjsacY+bcmUj9qMf2BQ==
X-Received: by 2002:a05:6a20:748e:b0:35d:6bbc:e9ce with SMTP id adf61e73a8af0-3637db64599mr26924766637.16.1764573812885;
        Sun, 30 Nov 2025 23:23:32 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d1516f6c47sm12441651b3a.18.2025.11.30.23.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 23:23:32 -0800 (PST)
Date: Mon, 1 Dec 2025 07:23:25 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v3 2/4] net: bonding: move
 bond_should_notify_peers, e.g. into rtnl lock block
Message-ID: <aS1CbSunlgsFAaDv@fedora>
References: <20251130074846.36787-1-tonghao@bamaicloud.com>
 <20251130074846.36787-3-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251130074846.36787-3-tonghao@bamaicloud.com>

On Sun, Nov 30, 2025 at 03:48:44PM +0800, Tonghao Zhang wrote:
> This patch trys to fix the possible peer notify event loss.
> 
> In bond_mii_monitor()/bond_activebackup_arp_mon(), when we hold the rtnl lock:
> - check send_peer_notif again to avoid unconditionally reducing this value.
> - send_peer_notif may have been reset. Therefore, it is necessary to check
>   whether to send peer notify via bond_should_notify_peers() to avoid the
>   loss of notification events.
> 
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> Cc: Jason Xing <kerneljasonxing@gmail.com>
> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> ---
> v1:
> - splitted from: https://patchwork.kernel.org/project/netdevbpf/patch/20251118090431.35654-1-tonghao@bamaicloud.com/
> - this patch only move the bond_should_notify_peers to rtnl lock.
> - add this patch to series
> ---
>  drivers/net/bonding/bond_main.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 811ced7680c1..1b16c4cd90e0 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2809,11 +2809,10 @@ static void bond_mii_monitor(struct work_struct *work)
>  {
>  	struct bonding *bond = container_of(work, struct bonding,
>  					    mii_work.work);
> -	bool should_notify_peers;
> -	bool commit;
> -	unsigned long delay;
> -	struct slave *slave;
>  	struct list_head *iter;
> +	struct slave *slave;
> +	unsigned long delay;
> +	bool commit;
>  
>  	delay = msecs_to_jiffies(bond->params.miimon);
>  
> @@ -2822,7 +2821,6 @@ static void bond_mii_monitor(struct work_struct *work)
>  
>  	rcu_read_lock();
>  
> -	should_notify_peers = bond_should_notify_peers(bond);
>  	commit = !!bond_miimon_inspect(bond);
>  
>  	rcu_read_unlock();
> @@ -2843,10 +2841,10 @@ static void bond_mii_monitor(struct work_struct *work)
>  		}
>  
>  		if (bond->send_peer_notif) {
> -			bond->send_peer_notif--;
> -			if (should_notify_peers)
> +			if (bond_should_notify_peers(bond))
>  				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
>  							 bond->dev);
> +			bond->send_peer_notif--;
>  		}
>  
>  		rtnl_unlock();	/* might sleep, hold no other locks */
> @@ -3758,7 +3756,6 @@ static bool bond_ab_arp_probe(struct bonding *bond)
>  
>  static void bond_activebackup_arp_mon(struct bonding *bond)
>  {
> -	bool should_notify_peers = false;
>  	bool should_notify_rtnl = false;
>  	int delta_in_ticks;
>  
> @@ -3769,15 +3766,12 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
>  
>  	rcu_read_lock();
>  
> -	should_notify_peers = bond_should_notify_peers(bond);
> -
>  	if (bond_ab_arp_inspect(bond)) {
>  		rcu_read_unlock();
>  
>  		/* Race avoidance with bond_close flush of workqueue */
>  		if (!rtnl_trylock()) {
>  			delta_in_ticks = 1;
> -			should_notify_peers = false;
>  			goto re_arm;
>  		}
>  
> @@ -3794,14 +3788,15 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
>  	if (bond->params.arp_interval)
>  		queue_delayed_work(bond->wq, &bond->arp_work, delta_in_ticks);
>  
> -	if (should_notify_peers || should_notify_rtnl) {
> +	if (bond->send_peer_notif || should_notify_rtnl) {
>  		if (!rtnl_trylock())
>  			return;
>  
> -		if (should_notify_peers) {
> +		if (bond->send_peer_notif) {
> +			if (bond_should_notify_peers(bond))
> +				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
> +							 bond->dev);
>  			bond->send_peer_notif--;
> -			call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
> -						 bond->dev);
>  		}
>  		if (should_notify_rtnl) {
>  			bond_slave_state_notify(bond);
> -- 
> 2.34.1
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>


Return-Path: <netdev+bounces-240380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 69608C740A2
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 13:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 1A5352A53D
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 12:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA183321B7;
	Thu, 20 Nov 2025 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXj9IF9a";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZhJ2maE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880BD372AB6
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763643190; cv=none; b=elq2b6A/HQJshBkYaesuzXsR63WXGrO2uI/kgmVjOrtQRNUVdcjME3eH5fLPHTJ6q6fGm7fZ2Qcbo2scHdtsinPeZbYuPjsrKT8XPjKIidJRxdEmtwsrcPT/E4DwO7MF7wSvfzIjjZxVud8OVEM/r7nEjIOyQJnE/BE/3lGaoaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763643190; c=relaxed/simple;
	bh=LR8ULDq7xaDD5klVm5YD6xiApfZRxnj7/tNcY9vHvYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CWsEJB+OK64CKisb2PvBDMudWPHy2zVepsRCPfFAspxzhlo2YYRalx7DoWmSBzbdvauJn3Yi8zR/cUTWxz0K3t6YuTmaSGkCD/b9ZAa+c2frfEHT1GaHzvFAt118cmzvnxkSJpn+tU6S8XScM/GhJ/oWnMnbbustlocNIYROfqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXj9IF9a; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SZhJ2maE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763643185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E3UU0E8vPbSvan1H9YT1uOvt6lacoFR29MXg1ip0mwM=;
	b=VXj9IF9a0+feoJhaRzkpokRlYluilaP//x0qbSlCGwX2Xc8aU5RfnMm/Ea4NpBww2aqR/k
	tNLTNOYWqzP2eGNU7KZaSbo0O5z7HZjdo5mj5C1AhXbgPhoS3ET662z5hg2cfseHQ2e6KS
	q4oQQKpUtq6PWE31SKtEsBIM+ersjpQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-MwqoCNzPMyGBGdCAR9M-kw-1; Thu, 20 Nov 2025 07:53:04 -0500
X-MC-Unique: MwqoCNzPMyGBGdCAR9M-kw-1
X-Mimecast-MFC-AGG-ID: MwqoCNzPMyGBGdCAR9M-kw_1763643183
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477964c22e0so5839585e9.0
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 04:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763643183; x=1764247983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E3UU0E8vPbSvan1H9YT1uOvt6lacoFR29MXg1ip0mwM=;
        b=SZhJ2maEkF3EKeWI5vUyczz93m21p1n+0DvAhHY6lHk/3kxwFign+noqz3jjV7vouz
         SAyrpYvfdn48w1JxZJPrVYKTXFj3J10gRI01VjFqYjri0VIVFbpSUbS1R51pKEYrN73/
         7W3IW36i9C51/OmG/gsVksVNvd6l2x3j1ROSZ+tm80Gf3T1Y3yCUqnJpmx7myDJlGFgv
         0R9yt+3AmZmo2tYekfDmJHKzWk4m66YgGVKrBEXNoumHj7rMG5LjZnVE17EAvfPDH14L
         cWJ5whYsiTY3wpr924iE/ztobGWA82WNXJ4TDZ09h2apdrSQdbs/T5S72RdnG2wUvtew
         Kppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763643183; x=1764247983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E3UU0E8vPbSvan1H9YT1uOvt6lacoFR29MXg1ip0mwM=;
        b=lxxXJYhFc3zNLEeooOg0InQcHzU9v6cybPYPXhxGYKS0zasFoQiMxp2mSLTLwrX+M/
         5Uwz3chyVzySC+tErN1FavJ+lID8IkLp7Asrr+Fhl1Ls4YP+KLPKFq/2Z9DPxa0mUtVn
         CsT38BRsdjoeu2dfoiAFxv/GsmZkCleeEsbOs1PlRb4sKhs6Nn0NR7ggjMfWbUwQPNQu
         Gn7aJmK9DrmDgOym4vm1QkGwKBaO5kV5muAOrCN3xFG8+cZbToxtUhh/iJzma8KQeprm
         5DuqM3l9bf/f4lny5AUa4f5DJTPeF1sOkozuprQeVANyjSf03RVzNqybGEqsxtLxy9ye
         /FQg==
X-Forwarded-Encrypted: i=1; AJvYcCWkk6kfAsD4VqYtE1z/J4/KJpC0uk+WzhnJbEOHugo2lL4cP8zUPvUXtejS0B8YLtYSoI9MAiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQdXAIMagP2iyh2dHei7vwtF/e+FxDAXBCYYZDZlZNg65AIYHV
	zNTdtgSoJcF/hWdOaGV2Q/Q8+luUnxKp8ofy13iE2WRy9yzx8TgjSmFNibMh1vtQZKWw4mobXJR
	J4S7t7JSR2te4C9pycn3TZZHS5jYsloJUyjBY6ZvUDIrDGg4YqIzPOKva8Q==
X-Gm-Gg: ASbGnctIJxqGV6Hv1X/LlLBB0Wxyo/nMOYyeQKUuUzu3lbOScLmVv74xrW5hPU04Y44
	cSWU3Gyjal/2bdhGNUETID2nJCLkiJ7sQ8Mpnja35axwcj5gHfbnKTagbchYaIQIEiq5Ih+oncm
	H8gPc3XJjEmceQrZDU3JdqwZU0A2vAe4mee6BYBqJjLqLwGS3gBEttF6vt2O9UI8iMUEc7CZo6j
	hZQQ+GSeJ+qugMnVXNZAmgiiVP0I09OjZjJtG8Fo4ePd+AmsgVytGNQqx/KbAwD8tbpztYWz1SX
	ijcfhL0YUd5vxV8vZv5yHYPH56ghQvXVY5loN3SRcWHwMq3swBAXW5lqHRicGsVcbxH6dy5xUq1
	nvvlr4+iEjT63
X-Received: by 2002:a05:600c:4704:b0:477:a1bb:c58e with SMTP id 5b1f17b1804b1-477b9eb25ebmr29390885e9.7.1763643182665;
        Thu, 20 Nov 2025 04:53:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIuNKtkfJBpkGKvjHCtPWs99RSneT8gAHjsulFGLOqaPV/sy4mVEzOiqlz6HiAmI6D5mqQsA==
X-Received: by 2002:a05:600c:4704:b0:477:a1bb:c58e with SMTP id 5b1f17b1804b1-477b9eb25ebmr29390545e9.7.1763643182271;
        Thu, 20 Nov 2025 04:53:02 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8c47sm5519216f8f.38.2025.11.20.04.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 04:53:01 -0800 (PST)
Message-ID: <4dcae50b-42f8-4adb-b154-5974f5aec19d@redhat.com>
Date: Thu, 20 Nov 2025 13:53:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] net: bonding: move bond_should_notify_peers,
 e.g. into rtnl lock block
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Nikolay Aleksandrov <razor@blackwall.org>, Hangbin Liu <liuhangbin@gmail.com>
References: <20251118090431.35654-1-tonghao@bamaicloud.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251118090431.35654-1-tonghao@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/25 10:04 AM, Tonghao Zhang wrote:
> In bond_mii_monitor()/bond_activebackup_arp_mon(), when we hold the rtnl lock:
> 
> - check send_peer_notif again to avoid unconditionally reducing this value.
> - send_peer_notif may have been reset. Therefore, it is necessary to check
>   whether to send peer notify via bond_should_notify_peers() to avoid the
>   loss of notification events.

This looks strictly related to:

https://patchwork.kernel.org/project/netdevbpf/patch/20251118090305.35558-1-tonghao@bamaicloud.com/

you probably should bundle both in a series.

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index b7370c918978..6f0fa78fa3f3 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2810,11 +2810,10 @@ static void bond_mii_monitor(struct work_struct *work)
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
> @@ -2823,7 +2822,6 @@ static void bond_mii_monitor(struct work_struct *work)
>  
>  	rcu_read_lock();
>  
> -	should_notify_peers = bond_should_notify_peers(bond);
>  	commit = !!bond_miimon_inspect(bond);
>  
>  	rcu_read_unlock();
> @@ -2844,10 +2842,10 @@ static void bond_mii_monitor(struct work_struct *work)
>  		}
>  
>  		if (bond->send_peer_notif) {

The first `bond->send_peer_notif` access is outside the lock. I think
the compiler could do funny things and read the field only outside the
lock: I guess you need additional ONCE annotation, and that could be a
separate patch.

> -			bond->send_peer_notif--;
> -			if (should_notify_peers)
> +			if (bond_should_notify_peers(bond))
>  				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
>  							 bond->dev);
> +			bond->send_peer_notif--;
>  		}
>  
>  		rtnl_unlock();	/* might sleep, hold no other locks */
> @@ -3759,8 +3757,7 @@ static bool bond_ab_arp_probe(struct bonding *bond)
>  
>  static void bond_activebackup_arp_mon(struct bonding *bond)
>  {
> -	bool should_notify_peers = false;
> -	bool should_notify_rtnl = false;
> +	bool should_notify_rtnl;
>  	int delta_in_ticks;
>  
>  	delta_in_ticks = msecs_to_jiffies(bond->params.arp_interval);
> @@ -3770,15 +3767,12 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
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
> @@ -3791,18 +3785,15 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
>  	should_notify_rtnl = bond_ab_arp_probe(bond);
>  	rcu_read_unlock();
>  
> -re_arm:
> -	if (bond->params.arp_interval)
> -		queue_delayed_work(bond->wq, &bond->arp_work, delta_in_ticks);
> -
> -	if (should_notify_peers || should_notify_rtnl) {
> +	if (bond->send_peer_notif || should_notify_rtnl) {
>  		if (!rtnl_trylock())
>  			return;

The above skips the 2nd trylock attempt when the first one fail, which
IMHO makes sense, but its unrelated from the rest of the change here. I
think this specific bits should go in a separate patch.

/P



Return-Path: <netdev+bounces-242903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FAFC9605D
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 08:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 97B7A342FC0
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 07:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF3428C864;
	Mon,  1 Dec 2025 07:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncllglAl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDDC2877CD
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 07:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764574535; cv=none; b=QVhsLkmcbkBdHBonk/XosFe+IO0tSZikdxuc4V/NXmAMp+dNhqDQ0oT+SEsJYcTXG4PNzJ5uqEXGI/4wtAEr9KlDlYjaf7OxIv9hwwWlop/dgNmZErVu10a2992w1/nHauBCWSNpB8bduZPUhYpvQSuyDN2tuqwl0dG7+LNICDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764574535; c=relaxed/simple;
	bh=1+E+a6k0vUeq5G/MjCb4gfuXmcFRCfazSkj1KD1m9V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnU4JBRlEfk/D85+m3hKMI3BCey2l8afX762BzhKKptm8fIKrneywKa6gJW0szdCP0TvgznafENLKcJ8LjkaY+ZSVqvhd0I1RRRtTeuQAyiFexALfVfwRxOfoqkBubTZ7QbAF5dS1wEQfPJdPolOoNnsMXcCut8y4/Cub3Dqrjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncllglAl; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b75e366866so1708483b3a.2
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 23:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764574533; x=1765179333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JuV7//LeLH2fdXr++hMWnE1+dNeAGeM2iGs7bt2loHM=;
        b=ncllglAl/oQ8MnrrIOgTF6PeXe0aG9Ce9IGpUNSq2SU7IYH19h99GcU8H7HcbU516Z
         Lb8f8HhthWv7CGdDHMD59J6ijR/0T6Ash6FMzwWWjUU3ZYbfPwxwmxyZgyyY5MMQ7cqK
         f8mpyQ+qbv+2JkUMV5cgQJWAAejte5MT+MtWiV1uBRvT7HOy8aDtVTmUX7+U67pKxwIT
         aVZhxp0HSb+dlPT/K0PPS27ef80r2bt6gPH6/OGkSL496xy4FpCoNDdgpEB9Z4/KYfvQ
         kguqh8UibmM9N0gHuymZ4DFb6diXWIYqFu7AyOFh7AaEEXDWVNMe4H/lVgQ6OeF71Yz9
         pS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764574533; x=1765179333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JuV7//LeLH2fdXr++hMWnE1+dNeAGeM2iGs7bt2loHM=;
        b=JdhdhGO1WnuQ+1n0zZGb+6f4vvxOeKVy4gMbZHE0L9zg6lD19ba2J+wga6bQwjUksw
         V/+rXVQ/OdEjlde9IXR07O8dyOF1XLnVN+e16odmOCInDSsyFuF7sOBBO+JcjI4f/ycS
         nxYbTMn4vsBJOwlveWV55MTxJ7MiD08akmII87KKWD5IpzFgX/mEVqqE4tDlIsXj6Nve
         /79BvjlDRu8cOo4Yxno1fFqodJBS45MdULddfSkH+46hAotDnUCWljMITMwCs9QemjlX
         Xl+F/D+x8brl/avTmdNAAnDWoiwtd1LqKkRGDSkT4PfDCJeWxZPgJE0Fz9RtVe8Ebd12
         k4Nw==
X-Gm-Message-State: AOJu0Yx99IBrrQkWtq9NHU8Jq6Yi9LFmhA43U0cwWO83+FIPo9QRMSTu
	HEia+ZuKZ04pLsTEeTRQSyoeHXWhlec4ijwT78ASepwzo+y4wqhWn7f8
X-Gm-Gg: ASbGncuetKDYPCE+FAuyx8UiKrEeXc93bnhWhvl4C0316YpPfhypiGuma18XssHupx0
	UNKVjAebEYBkKa5kufnSWIv171fenYhCx5RPbHKGl1eZRKODXN4puyEK5nhT8JLDZhuHNVrmqqH
	q5QIxg5N57XWEd7UjrSdxkIm6Ac/rDrhLvdXsi+lwBdAwx4FyB3vZ91ntin11KoInaOkgPHW7Qo
	iZgjE+FVRGvAgpmlLQpyjR2b9+gu0/STZbsERQL+2lmZLHLzOQMyhLjN7uCwYIZAUA/UgpfRRbO
	5TCVTYxk+8FJc7rjxcr/v2uYBPlrS3DLuqcF1jPHGhXZ4ROATxkyzxoQe4qqoaO+KcqiPPElaBW
	YKJQFBHnMfjQvpClS0xYZ8c9t8nq44XMUF0/qR+BALFjsbhlv8ilRPc4Q36dlYrAu3z0v1G0Olq
	JjNdGRBhmsL1IoS3k=
X-Google-Smtp-Source: AGHT+IHKQn6eYtl0/Im0d8wrcUW1RiKdrZWoxVYfuIgO6SfesrTHejmD0OSSDs1tGQFfmLdJWejU4Q==
X-Received: by 2002:a05:6a20:1594:b0:34f:9bab:5f4a with SMTP id adf61e73a8af0-3637daaf5a2mr30454632637.1.1764574532817;
        Sun, 30 Nov 2025 23:35:32 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d1819277c5sm12262835b3a.4.2025.11.30.23.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 23:35:32 -0800 (PST)
Date: Mon, 1 Dec 2025 07:35:25 +0000
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
Subject: Re: [PATCH net-next v3 3/4] net: bonding: skip the 2nd trylock when
 first one fail
Message-ID: <aS1FPdC98q6wxviG@fedora>
References: <20251130074846.36787-1-tonghao@bamaicloud.com>
 <20251130074846.36787-4-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251130074846.36787-4-tonghao@bamaicloud.com>

On Sun, Nov 30, 2025 at 03:48:45PM +0800, Tonghao Zhang wrote:
> After the first trylock fail, retrying immediately is
> not advised as there is a high probability of failing
> to acquire the lock again. This optimization makes sense.
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
> - this patch only skip the 2nd rtnl lock.
> - add this patch to series
> ---
>  drivers/net/bonding/bond_main.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 1b16c4cd90e0..025ca0a45615 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -3756,7 +3756,7 @@ static bool bond_ab_arp_probe(struct bonding *bond)
>  
>  static void bond_activebackup_arp_mon(struct bonding *bond)
>  {
> -	bool should_notify_rtnl = false;
> +	bool should_notify_rtnl;
>  	int delta_in_ticks;
>  
>  	delta_in_ticks = msecs_to_jiffies(bond->params.arp_interval);
> @@ -3784,13 +3784,11 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
>  	should_notify_rtnl = bond_ab_arp_probe(bond);
>  	rcu_read_unlock();
>  
> -re_arm:
> -	if (bond->params.arp_interval)
> -		queue_delayed_work(bond->wq, &bond->arp_work, delta_in_ticks);
> -
>  	if (bond->send_peer_notif || should_notify_rtnl) {
> -		if (!rtnl_trylock())
> -			return;
> +		if (!rtnl_trylock()) {
> +			delta_in_ticks = 1;
> +			goto re_arm;
> +		}
>  
>  		if (bond->send_peer_notif) {
>  			if (bond_should_notify_peers(bond))
> @@ -3805,6 +3803,10 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
>  
>  		rtnl_unlock();
>  	}
> +
> +re_arm:
> +	if (bond->params.arp_interval)
> +		queue_delayed_work(bond->wq, &bond->arp_work, delta_in_ticks);
>  }
>  
>  static void bond_arp_monitor(struct work_struct *work)
> -- 
> 2.34.1
> 

Maybe this patch should be merged together with patch 02, since the issue
was introduced there. Before patch 02, both should_notify_peers and
should_notify_rtnl would be false when the first rtnl_trylock() failed,
so the second trylock() would never be called.

Thanks
Hangbin


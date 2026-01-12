Return-Path: <netdev+bounces-248916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED60D11535
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 09:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C309300816C
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 08:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED33346768;
	Mon, 12 Jan 2026 08:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMoMxT85"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDF33451CA
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 08:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768207771; cv=none; b=VsMgtY33i4rQkppIxG3NqpFjt08R+fsspP/DWHlC4f3OywEAAApC4ZdGvZXumLera/zXA+m3HVQgGwmUGJ+/wwH9DtGdq+OjZdZV8E+sQ7CSTJUkN134kr06rdnD8gr1r/lLIw6E9GN+EdxAeH1gSL1LmBDY/CJL94hg5udy+uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768207771; c=relaxed/simple;
	bh=KXJCkJibHwTGoYr5Lg2+Uv1ZwUqidOCb1dOy2IAkNvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoiA+bMvd8O/XGXYI1lI/JoCT3CzAUk6bwagXolVisJPeR2UVM6kbDu4H6ndKJlGr9KEnDW1oYhiDujQYcsYqHG4jSOnujCRjsVON4k40EWRhZfXGtav0R9Nq/W5wSzl5Ut4H2ja2ipcGAvAeHh/YZoTyMpzCdTdkAxqcD0qzyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMoMxT85; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-81f4f4d4822so293115b3a.3
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 00:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768207765; x=1768812565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F4IfMbbm6AK8/Hw5YB/wQdRPE3JSJ2bRCDHrhjKzWJg=;
        b=cMoMxT85K7hNxH+k94ZxBqsZ0WkaeSfoumF96vhMHsnsluZSUwinhhBRncmovuOQJP
         5/51g8lg+Z+AJeLvsS4WJDdtLxlCRMPIRQeSxtdqdLqalQ3Wk08KUmV/d3qGKpLwvMGE
         uY+cz4rAoqfwAK+ZlQhtQN20EKWMDqFBnPm2zxjZoRc+mgXBjup9OxRxLAajBPL+JfYV
         xMcRdfx0kkFwItWTm0saIc9cKAZBeT6NQQFPaFgX3uysOKumw8K/aa96AH3+Ip95HLny
         k98MCpbwJhDT8+I4zLfUXi5/zlVALhXbuJ3PMguJFCHtNcJz1ue/xdYhqXgJo7HCogaI
         XqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768207765; x=1768812565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4IfMbbm6AK8/Hw5YB/wQdRPE3JSJ2bRCDHrhjKzWJg=;
        b=ngb9NKXbtZJMXQ5dp0wnCB88wS/cHya2Ky+JRvE0YzT5KnyCury8f8Fk8S3VZY0hYe
         /9EiR8GBmnsyAkI5SCubacWF3fXbeb6eKEIJrjwC1HiI5p24vUC/XfP/dMEKCHmUHab0
         5DtJI+TECxzsK9xjm7mFuCiZUfYUzb/1/wij0X0WXWKlE0LDaxflMypXQ4844f+uMPvU
         ABFtmgsKNK0r0Jorwm4aX25uMjY4OVpseufDGkS+e1OU/L71grx+oteVKOmECqIvPCvn
         SE3Fpyht01Iu/UZqpAPOpYBK5THrM4n2YMJQ+VBlKHI7ED2PnXpYKGKdFE+MZEnHDWXt
         EvSQ==
X-Gm-Message-State: AOJu0YzMUGs2lzxSy4VQNaq7soGz03thfz+AaNl2vp98THplSIIk/VFp
	fccdov6VT9CmEMporJYEDkYhsq9tuesMNt9mZzZyNM0OQBuddQ3lR+UV
X-Gm-Gg: AY/fxX6ycq5CdWvcKSqYJfe0KabSuKP9f2LQOPbx6JX0FN72jgERitqMphbPahMpcCk
	qYBMrdvVCXmCxIcs2pCZ/sSOBy7rU9qGVUZE8IITpLyQpFd32OuopRtDhzwbHMyEEpjQkhRdTwh
	uItnuYR23scZGeaXUE3KoLLgtYShglx6vqTJr1UAU/UD3Un/FImrrMQEKfXe69knFQO1v6ezBDo
	ERPYX/2n7k0VDPe/eIhFJPGUCQR6lA5TE6HdUW5hFJ69J5qvwxpoTqIXdFC396DvFRSeYNMvePA
	40pzpz8LPHFMb1tKhX2JY2Upf61ZzXdPgaOveES/cXKHoFFn8ai3nbyIaKuw5lG4W1/PvmUYe8F
	LwlFzx97Lxp7oHe2okOz2oWRFlJabVtnKCAMyykvgVsWSCcJWx4x1gKq2thUBqVKUcnugWQ6eAj
	2vt0vo8hv1feZ6f8o=
X-Google-Smtp-Source: AGHT+IEIRNmchKMf6M/fWpXsHDPS9Tyuz8cNXAfpYvi+SAJDgrrSvB8hvLlQuEUkkXncriGP8bbIxg==
X-Received: by 2002:a05:6a21:9990:b0:366:2696:1455 with SMTP id adf61e73a8af0-3898f8f5526mr14664745637.16.1768207764795;
        Mon, 12 Jan 2026 00:49:24 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbfc2f481sm16678179a12.10.2026.01.12.00.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 00:49:24 -0800 (PST)
Date: Mon, 12 Jan 2026 08:49:17 +0000
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
Subject: Re: [PATCH RESEND net-next v4 3/4] net: bonding: skip the 2nd
 trylock when first one fail
Message-ID: <aWS1jST2907AGCLi@fedora>
References: <cover.1768184929.git.tonghao@bamaicloud.com>
 <e90a599a58a3738d69a2b879f31871afa223d7ab.1768184929.git.tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e90a599a58a3738d69a2b879f31871afa223d7ab.1768184929.git.tonghao@bamaicloud.com>

On Mon, Jan 12, 2026 at 10:40:50AM +0800, Tonghao Zhang wrote:
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
> v2-4:
> - no change
> v1:
> - splitted from: https://patchwork.kernel.org/project/netdevbpf/patch/20251118090431.35654-1-tonghao@bamaicloud.com/
> - this patch only skip the 2nd rtnl lock.
> - add this patch to series
> ---
>  drivers/net/bonding/bond_main.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 8be7f52e847c..b835f63d2871 100644
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

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>


Return-Path: <netdev+bounces-248919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E174AD1157F
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 09:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 46869301D104
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 08:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBB2346ADA;
	Mon, 12 Jan 2026 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SehTPn8V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5736334677A
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768207973; cv=none; b=VMHMELUksKWwXm4W0IVfd8EVeLR+ZYC1w853exBf82r1qY0s/nolBgu6/WW0xFtCHVttHzOYSLcBCUhiDvEDC1jkXthA2x7uPHNRBqxOd3aXld2MCXaVnKutrRHNeAeCGens4LMxK+puaiNr5NIO/sMQ7RTYyLAuWbBdvsTOpEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768207973; c=relaxed/simple;
	bh=hCAIODDBXUR1lJzCXHd+vWzfYVnk0E3TcXj6L2K+O6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gazH7iykw9nyxZxfKMZszko2NDBt+yY2d9Atx/Cl57w/23BaNZHipKbjyD1xO5iS/gj/CaxveamRaKSdaFPyIiOkBuF8vrlPbi1sg64JQN2LNH2spZw9qOp3GbJYveDQNZ2VYxfJzvGkfKvB4cNHOuJ6v4j68atrGfgkrJ1gqc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SehTPn8V; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c1d84781bso3450011a91.2
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 00:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768207971; x=1768812771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rAvO+4sr8eby8Ki32sy15zXdfAa+GIY6AvTzuh51kLg=;
        b=SehTPn8Vc1o/m5VvBhUbVjQHyM9IXJihCKAR9j9V5MdzI44wrk9HuY5pmjNqMSJhG4
         v1mMZ2iIQt1pOmfa4c+BrImTzwiiBdivsgoOTLK5QdFvZFJhDmJe7xUGXVZgTqH6LXPx
         0nK20GKV8SHh6rZfYeNwobxLAPZZnAwNX8i2WtCn1ahrGMQT+9R1fMUUT/hbEful2wgz
         C9shZudqb1i+NtTd2n5k+pknbaqSS6YXN5K9CWLy3LNIrgBN2zZQTTNT6N9FXJ/N332X
         CJ/js82Tx4/TaFcbo1BEj4B7S6pHNizq6KJ7SLG9EBzKs6RiXeDzAl6ohX4eftel/bEF
         Zg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768207971; x=1768812771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAvO+4sr8eby8Ki32sy15zXdfAa+GIY6AvTzuh51kLg=;
        b=KP7k59DlsoY9HFIr4h2gtsXQaLz6BzV3lS5mjIV3SEGGwSE8VxMrbEP/S/UMS6OzMg
         Ci1HmcXoWR41OdUl5vVI5CzUY5g58JUsisX6ha9mUAUcjRNDpdIJh7xgkvarTToH2gYF
         BDp1Qac9WQAGvZTcjb4M4xC6X6auDaLFPU5/EeFuO4S/LDPtbb9OUcy4pwrUrNCafper
         smiQjLUsAELJ3CXo0azJU1UcPIXEKQ3tlj6XUx7UZ95XWlkynMr1CUf0AE+UjOCQRqYy
         f20ZP7xPlkO5tThWLwC6DkD0MBuNZp04zrC+o0o98gwGy2xhwgu9mwH0gXPtHqg0FnZW
         3aVA==
X-Gm-Message-State: AOJu0YyRrir6IgV84MMmjP0qWfHVozDKZbKbTP825LVDN7EyLIsFZW90
	/eRgHje+qUDZL/+jR+e7w4FQ+ppm+Jt0pCBqq9edkS+NxT5LiOdrhtzL
X-Gm-Gg: AY/fxX77v3S/gIR7mIq8jB6EMpj/xHc5jbasCe4JnDH7JFROpJOoyf6r28s6bkAfS8q
	Q44l4qv2wxQiOUeNJpJ+amgPY3vjsGKYcc3Y+qpb1jINO5Y350H+kPvAEvILz5ucWMGJpQDDaJ3
	SPycGJURoVKst/liy3uZVuk3SRpmzOTO3C3IBbYEk48Vd7cn0GYrE1RN34mo6FweSzk2mMgB0/D
	tEUjsLzFKKFh9hRRyWg+LAtNpSDecppHibNVQBVN97rygMchIzxVxlYue31oAUUkbvhZquMFM/j
	IrJSmliYRTRf5m5rtmhmFRLB/NhI3+FSVTBi/Y3Z1naoiRxrh38NaOxGgGaiz+EmI7le3RMvxIW
	3pgKMPygEy0nQ/1gN2e61m6fJEA3OAqneyWihfQYk5vbeyTutE11b11oZigAcDSEdLlqtU9bakC
	/TRVoxSv+tzMnEMlk=
X-Google-Smtp-Source: AGHT+IHhrlxnEkgpReHyY/ln7FfgcqmD96vph7wFRQzv/wIxQr0+Go96YJcfFR08UIl7j9LbvOvoHg==
X-Received: by 2002:a17:90b:57c4:b0:343:eb40:8dca with SMTP id 98e67ed59e1d1-34f68ca4463mr15285309a91.19.1768207971469;
        Mon, 12 Jan 2026 00:52:51 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f6db356sm16884474a91.0.2026.01.12.00.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 00:52:50 -0800 (PST)
Date: Mon, 12 Jan 2026 08:52:43 +0000
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
Subject: Re: [PATCH RESEND net-next v4 4/4] net: bonding: add the
 READ_ONCE/WRITE_ONCE for outside lock accessing
Message-ID: <aWS2W27L3MbZMK1T@fedora>
References: <cover.1768184929.git.tonghao@bamaicloud.com>
 <5bf134412fd558dc80fbf97a149964f536a59cb7.1768184929.git.tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bf134412fd558dc80fbf97a149964f536a59cb7.1768184929.git.tonghao@bamaicloud.com>

On Mon, Jan 12, 2026 at 10:40:51AM +0800, Tonghao Zhang wrote:
> Although operations on the variable send_peer_notif are already within
> a lock-protected critical section, there are cases where it is accessed
> outside the lock. Therefore, READ_ONCE() and WRITE_ONCE() should be
> added to it.
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
> Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> v3/4:
> - no change
> v2: fix compilation errors
> ---
>  drivers/net/bonding/bond_main.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index b835f63d2871..909c01f55744 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1204,8 +1204,9 @@ void bond_peer_notify_work_rearm(struct bonding *bond, unsigned long delay)
>  /* Peer notify update handler. Holds only RTNL */
>  static void bond_peer_notify_reset(struct bonding *bond)
>  {
> -	bond->send_peer_notif = bond->params.num_peer_notif *
> -		max(1, bond->params.peer_notif_delay);
> +	WRITE_ONCE(bond->send_peer_notif,
> +		   bond->params.num_peer_notif *
> +		   max(1, bond->params.peer_notif_delay));
>  }
>  
>  static void bond_peer_notify_handler(struct work_struct *work)
> @@ -2825,7 +2826,7 @@ static void bond_mii_monitor(struct work_struct *work)
>  
>  	rcu_read_unlock();
>  
> -	if (commit || bond->send_peer_notif) {
> +	if (commit || READ_ONCE(bond->send_peer_notif)) {
>  		/* Race avoidance with bond_close cancel of workqueue */
>  		if (!rtnl_trylock()) {
>  			delay = 1;
> @@ -3784,7 +3785,7 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
>  	should_notify_rtnl = bond_ab_arp_probe(bond);
>  	rcu_read_unlock();
>  
> -	if (bond->send_peer_notif || should_notify_rtnl) {
> +	if (READ_ONCE(bond->send_peer_notif) || should_notify_rtnl) {
>  		if (!rtnl_trylock()) {
>  			delta_in_ticks = 1;
>  			goto re_arm;
> -- 
> 2.34.1
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>


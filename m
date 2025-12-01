Return-Path: <netdev+bounces-242906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9CDC960A2
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 08:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 04245343458
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 07:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6912BDC29;
	Mon,  1 Dec 2025 07:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9zGbIVA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C8E2882B7
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 07:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764575000; cv=none; b=l2vTOb2w+SARcFY/tOFSHMrICLULO9sVytFgrMpEchjFy5TJNMSAd7lQd9ulMDZVZRexLs8iyuShUXIrN6hrSZ/6VgmOcwfhCU0lSNvrj7YGS0CFlMh7tHEovA8J6q9HYmhUhebsf0p2u45vR/RZP5VYhnAJ47qXh37cDfKn1hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764575000; c=relaxed/simple;
	bh=nB4KU6Fqp2bXgE/0Yo/+PobWzkr4bvHULqgFGB8+xR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kc/3w6HctYQAzvT5U8SLVUuIncUvVCKXaYBWlkYuu5jMTb7cjX5IqO9Jto8n5yXmVguyaF5+WCPoKt1f6cdd2oX3Fa6aKcNBkmB6elD1rjwOmIpiL6OPqTiPtnnJY+L8nDDvlNfaDeyOTeFwQ/6rsb1oSEK7PVlIHjY4Mqoo30I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9zGbIVA; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-343f35d0f99so2899761a91.0
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 23:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764574998; x=1765179798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fZj+RuFEFi0w12bkYaEUrPOeFpTx+IAsLhnJ0WkDL4k=;
        b=E9zGbIVAbcrpe6uZSaIxffP3qcwlwWNZLRhQHQAvUw34GijBNJ8oeVWWcpqDjuvJxe
         zuH2MhKgyJuPgk7pVU90VOvz87XS7PkG2nlnPhtC+1sfHV0/+dJo8inXN/Oxfts86Zwc
         JrqDtT930zKNpJa1q7VYeOqhheL2Dhn2ycO/MulVtjbBaM/wm7qs8IoHquBny7uFP2H9
         pZLyCc1PDXLYfVX1Umd/+oscsLFsenigYWL+K1qPzYNk7kR1z5r2TjyD+GucXPPrpPLR
         kgggQ5voi4v0IFs5huu0GrTT6XPiOyQUGOmuh5zO7P2eUgGxNTeZ9sjS6+TiVaLgjmup
         2HhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764574998; x=1765179798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZj+RuFEFi0w12bkYaEUrPOeFpTx+IAsLhnJ0WkDL4k=;
        b=ft2Q02/QjA/1Pdovebd81J/kH3rMW+HhB3AkQrlda4t9qHB3k5BxtkkW/kHsgOW4sO
         NqctwkRLiWHcSecOU7HXoFfKMBJVquuQvnTW2T2w/K1pLk4yh61/VT4cKZQUxQ6KaFEu
         cvIJg//5OiuW/PYdT8d8QrRY0lDrG0KO7/QWNF/dcih8+rVKOs+UMz27ylbrUnqpDzsm
         elvr2VLsPNkD39b+yQaVfZQYiZx2liSKVGNh7fLXdm5Q4nhreYQM1UYpO/xUyjFodpT4
         ttzrarNENrLYZV0Kc75wFqCYZpgox4MqqQo1/j9WFYoQZ6kJvWLAX3KlTRqBiGOHdYbY
         v98A==
X-Gm-Message-State: AOJu0Yxf6TKHXjL+kNGXJshqNCgthm4Zp/J4UgkyvZEPVym9IKReVaxP
	h28VcKc5qThdS4rhz4pzZllaLTyOhM6cfwWeLD69MkFoxsUmtoRajcY/
X-Gm-Gg: ASbGnctl5K2KS6cvCZoA4u4y1AtI0JSWGsAERZwvhWELRuF/KQ5ULHsKyHpqA0K+qcI
	RrFLrFIIdK1eTNj9cv/mWXfcHgOa1HyFJk/OZ9WN4b7sETo/VW2Eqk5vWNA+cxt4uDYxxmAU7Tt
	L46xYzfbCpQnu6Dlu3EE2NrCKZ1+yCujf/AqjP/PUeeJNzzcxLEIishJKcYm0V8fNvkDzbrvUnU
	y0E0K1MpJnRxz4XxFxNlxHcdEKS281ixLVZ0Sxilo1jPgkYgmbaljOCTD+V4o5OKxVK5T6pqAZI
	xVY8ZYePOFrUOa2O8lWxZm7Ma85fKUtYOpfUdqskTtqjDKDEY1ybH6IlAS6oz70LB2W6c2u9I44
	EGHnvHXNw0xu3Dfub7F5zRES/FhJifqQs2bWI+HL2rjAzoGWwglAO0UjlZ8EWVRLZCGSo+igI1s
	NqxOp8nipFUoX3X9FTfH6NbS7Zhw==
X-Google-Smtp-Source: AGHT+IH2AIz19o+eqZzvWi0ffDboSqKhDx7JR4ZLoPxVT6DujnUcLu9xScixjJ4Ld7AlQuDmavaL6A==
X-Received: by 2002:a17:90b:54cd:b0:33b:a5d8:f198 with SMTP id 98e67ed59e1d1-3475ed6ada7mr21401913a91.25.1764574998526;
        Sun, 30 Nov 2025 23:43:18 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e9c3e41sm12660370b3a.33.2025.11.30.23.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 23:43:17 -0800 (PST)
Date: Mon, 1 Dec 2025 07:43:10 +0000
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
Subject: Re: [PATCH net-next v3 4/4] net: bonding: add the
 READ_ONCE/WRITE_ONCE for outside lock accessing
Message-ID: <aS1HDqDJr9pwzp2X@fedora>
References: <20251130074846.36787-1-tonghao@bamaicloud.com>
 <20251130074846.36787-5-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251130074846.36787-5-tonghao@bamaicloud.com>

On Sun, Nov 30, 2025 at 03:48:46PM +0800, Tonghao Zhang wrote:
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
> ---
> v2: fix compilation errors
> ---
>  drivers/net/bonding/bond_main.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 025ca0a45615..14396e39b1f0 100644
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


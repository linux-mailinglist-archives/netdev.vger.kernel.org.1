Return-Path: <netdev+bounces-127186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7587E974823
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 04:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3578B2062F
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 02:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E8F26AE4;
	Wed, 11 Sep 2024 02:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkJKL1j0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC4C224EF;
	Wed, 11 Sep 2024 02:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726020919; cv=none; b=aEAxzHGUDopWncGImPZ/Dt+6wsh/M5fA/X2rXKAqxxqCNoKiszQC6PNXqS5VnOjGL4zU6gBMeE8elx6q0+kjARDbacIK9iAmA9w2SBMgXI76ypyHvwtvPJmVNd6gYQKBZliONAkkgj3owUS/MU39XshrkAQCchUmaCaiUKDRN4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726020919; c=relaxed/simple;
	bh=1jmOATByfaXddyTYRmlHhmGBcKP5U5almt6VYcSsF6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klwHGC+Gz+pZUdUEKdT2jn4V5Q+utA8yIz3HKLlUQpYKOFxKnPQ+NZ1mpLxV+QGLoPI5f6cytFvcS2P7KiD81NNmeEWicWki7kBkYEAG/oaY30pJYTxMf9lBpw2tGF1q41BS9KQxAaPZ+upAkck1D7iTZGmrmfYAkkaMWZEBy/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkJKL1j0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A023CC4CEC3;
	Wed, 11 Sep 2024 02:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726020919;
	bh=1jmOATByfaXddyTYRmlHhmGBcKP5U5almt6VYcSsF6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pkJKL1j0yYv6TbwYZHadCvTHjbOEZWZ9E6a3nKEve3Zp0HJYzk6Xg2oRUumrS51mY
	 cjNCOXsHs/bWSXSmj/5jHqQbZVKEQLpxh+R/1+UtJBQ04o5cFLI7AYuiMW4By+6e9i
	 qkRTp2GyzDTYaQKjPMjrpq0B6CkiVmoSA2qbsClQgrUZbrLtYjBxCHEPlziGcEFZa0
	 o6oU3hBUqmDJxycBIJ64JHpUbYHeRadh9ytuvrrbbQ4pjkihOwcKhEVwX/TmEUtL8b
	 nfRJI/x6WXwH4JQynrHM0B4RyUGhhhJfEzDXOKTBsZWYUMFmmNtcHPkkH/eDb4XXgv
	 MZc1oGGgltlHg==
Date: Tue, 10 Sep 2024 19:15:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Jeongjun Park <aha310510@gmail.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 ricardo@marliere.net, m-karicheri2@ti.com, n.zhandarovich@fintech.ru,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+02a42d9b1bd395cbcab4@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: hsr: prevent NULL pointer dereference in
 hsr_proxy_announce()
Message-ID: <20240910191517.0eeaa132@kernel.org>
In-Reply-To: <20240909105822.16362339@wsk>
References: <20240907190341.162289-1-aha310510@gmail.com>
	<20240909105822.16362339@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Sep 2024 10:58:22 +0200 Lukasz Majewski wrote:
> > In the function hsr_proxy_annouance() added in the previous commit 
> > 5f703ce5c981 ("net: hsr: Send supervisory frames to HSR network 
> > with ProxyNodeTable data"), the return value of the
> > hsr_port_get_hsr() function is not checked to be a NULL pointer,
> > which causes a NULL pointer dereference.  
> 
> Thank you for your patch.
> 
> The code in hsr_proxy_announcement() is _only_ executed (the timer is
> configured to trigger this function) when hsr->redbox is set, which
> means that somebody has called earlier iproute2 command:
> 
> ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 interlink lan3
> supervision 45 version 1

Are you trying to say the patch is correct or incorrect?
The structs have no refcounting - should the timers be deleted with
_sync() inside hsr_check_announce()?


Return-Path: <netdev+bounces-226144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E38B9CF65
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 02:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD523286FA
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 00:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCA42D73A6;
	Thu, 25 Sep 2025 00:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQVLlR/J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA70266B56
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 00:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758761729; cv=none; b=Kjpz+tl+P+tM1UGul1PpqhZ0kgocs3o6fxZ62HVHZYyqeWL9ld029KF78Z+B+cj3o5PanHH5tl32knWneLXXdcyz87oJGK//iOccB3g1aT1N2uKrWIM5N6ktkd2oQPv26VHfGSVXCd/jlTkEh7o1IGAL7lFI4beFfpCmMOcI16M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758761729; c=relaxed/simple;
	bh=peciTZcA8YJateklgAvvkEc7Bd4uujtH1h23C90E060=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oFayiKpeqNsKB33nXNR/5HwcH7cVA/hECg/wfDjkax70xR9BIoMkHF4Wq0l/QskDSQEKhKPHb3rMVCE21WseLHaoIGmeUAqMz/V8AS3BPwiz6TrOe0wRFKSqQURuv5gqxXzHlaSG+SAae5f+DxSXbaW/FWiSzbJtQGaZka6ZhZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQVLlR/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8210EC4CEE7;
	Thu, 25 Sep 2025 00:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758761728;
	bh=peciTZcA8YJateklgAvvkEc7Bd4uujtH1h23C90E060=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JQVLlR/JgbTO/OGZLYbDRh4lSute7EKC+mbC8qK/vYzV3YAfrhT2mTrK9OottzW9t
	 CxQhFAPaIIFA8df4ol7wAQGprbpaOxNVWMNxEpnIO6tuC/ym4wRf7jG/njV1XtPQsh
	 JouRKqPoZ13MvhXWw3Nzm2UZ0cG/fmiC/nzOZs/3ssMN/Vl1T5Qt0/0QCGZA1FdZ5j
	 YyABtbmxtPKgLIG0Xz2odeiwAMxMI3F5+te8jGYIrk+CS41sV/orM0qwlda+hsWLlR
	 vgXzJVOLMcSE8vgoba7n688yAUsZ+VYnr8eVKK52k5uo+Gp4C+3o7Fvy6Fugt3Fstp
	 vE5rbkgGXYDIg==
Date: Wed, 24 Sep 2025 17:55:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: xuanqiang.luo@linux.dev
Cc: edumazet@google.com, kuniyu@google.com, kerneljasonxing@gmail.com,
 davem@davemloft.net, netdev@vger.kernel.org, Xuanqiang Luo
 <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net-next v5 3/3] inet: Avoid ehash lookup race in
 inet_twsk_hashdance_schedule()
Message-ID: <20250924175527.4642e32a@kernel.org>
In-Reply-To: <20250924015034.587056-4-xuanqiang.luo@linux.dev>
References: <20250924015034.587056-1-xuanqiang.luo@linux.dev>
	<20250924015034.587056-4-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 09:50:34 +0800 xuanqiang.luo@linux.dev wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> Since ehash lookups are lockless, if another CPU is converting sk to tw
> concurrently, fetching the newly inserted tw with tw->tw_refcnt == 0 cause
> lookup failure.
> 
> The call trace map is drawn as follows:
>    CPU 0                                CPU 1
>    -----                                -----
> 				     inet_twsk_hashdance_schedule()
> 				     spin_lock()
> 				     inet_twsk_add_node_rcu(tw, ...)
> __inet_lookup_established()
> (find tw, failure due to tw_refcnt = 0)
> 				     __sk_nulls_del_node_init_rcu(sk)
> 				     refcount_set(&tw->tw_refcnt, 3)
> 				     spin_unlock()
> 
> By replacing sk with tw atomically via hlist_nulls_replace_init_rcu() after
> setting tw_refcnt, we ensure that tw is either fully initialized or not
> visible to other CPUs, eliminating the race.

This one doesn't build cleanly

net/ipv4/inet_timewait_sock.c:116:28: warning: unused variable 'ehead' [-Wunused-variable]
  116 |         struct inet_ehash_bucket *ehead = inet_ehash_bucket(hashinfo, sk->sk_hash);
      |                                   ^~~~~
net/ipv4/inet_timewait_sock.c:91:13: warning: unused function 'inet_twsk_add_node_rcu' [-Wunused-function]
   91 | static void inet_twsk_add_node_rcu(struct inet_timewait_sock *tw,
      |             ^~~~~~~~~~~~~~~~~~~~~~
-- 
pw-bot: cr


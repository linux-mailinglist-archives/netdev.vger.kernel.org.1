Return-Path: <netdev+bounces-69399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B0484B0DB
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 10:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41045283924
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 09:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8A712C81F;
	Tue,  6 Feb 2024 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9LYDnjz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2783174E2A
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211163; cv=none; b=Dcdr4VujyzkSVMSulf9PAdMR+9r6NS214/AGPqxFNF3iwz8aurVfyQw8vtaF8DoA3W/el19vBGXpv9llsCzB/sj+2kWwW9BYycgGjLI7wKUC9K+e3LdDb/0LF2Xc822kX5g/20tXpX1cBirAzxhuLfc7zvUg9gnhFk4bAupzr0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211163; c=relaxed/simple;
	bh=gklHqoeGrz9iSOsg1aejOyZbfm7UsXbsj7tqTGEBrQE=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=sdJcEJ9KA6y3hL802NNQBuGEOD5/ZQQb9oAyCs13TLEgQbKGYk/7fp3JKLUEVIeAShwBVMigso6B9KZWv+4SGBumBoUyegClWfofBPscqkdMUlqq9PDmm9nrS+0SIP9nwVfV6Ub2J0gxAvglmtLm7RazFy07xChivp80QwFAKuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9LYDnjz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E470C433C7;
	Tue,  6 Feb 2024 09:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707211162;
	bh=gklHqoeGrz9iSOsg1aejOyZbfm7UsXbsj7tqTGEBrQE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=l9LYDnjze8W9IBwEbrys/p6KgcMvDeBseXKcT+PBQWjSfocukiswqBqK+qqT/74YM
	 moClz81IuvpnXb5FWQiMOl/XBDF/n8mM/NawUOo6pYPa5ZrDSIMLe08sZXXetTv3JG
	 xF4Wwzo4K6uI2fKTmA1CzY/W0Q1fne6wrwFUpYdE6MIdE9d38gw+FnIeKJuF9j9EW4
	 eBqMa1NFljt9BlfRI2xXGoVGHugc6iOYs7s902xBvTtUvwQLippjOKUvhpxv5nvl2L
	 ghw379bZJmWYSunLQeJu1g7YmIBozTNgpuVigqYE9rBEFu9Vj1klrteA16JSwmbHE4
	 ioVcebajXoKCQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240205124752.811108-6-edumazet@google.com>
References: <20240205124752.811108-1-edumazet@google.com> <20240205124752.811108-6-edumazet@google.com>
Subject: Re: [PATCH v3 net-next 05/15] geneve: use exit_batch_rtnl() method
From: Antoine Tenart <atenart@kernel.org>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
To: David S . Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Date: Tue, 06 Feb 2024 10:19:19 +0100
Message-ID: <170721115936.5464.3838090704873147346@kwain>

Quoting Eric Dumazet (2024-02-05 13:47:42)
> -static void __net_exit geneve_exit_batch_net(struct list_head *net_list)
> +static void __net_exit geneve_exit_batch_rtnl(struct list_head *net_list,
> +                                             struct list_head *dev_to_ki=
ll)
>  {
>         struct net *net;
> -       LIST_HEAD(list);
> =20
> -       rtnl_lock();
>         list_for_each_entry(net, net_list, exit_list)
> -               geneve_destroy_tunnels(net, &list);
> -
> -       /* unregister the devices gathered above */
> -       unregister_netdevice_many(&list);
> -       rtnl_unlock();
> +               geneve_destroy_tunnels(net, dev_to_kill);
> =20
>         list_for_each_entry(net, net_list, exit_list) {
>                 const struct geneve_net *gn =3D net_generic(net, geneve_n=
et_id);

Not shown in the diff here is:

  WARN_ON_ONCE(!list_empty(&gn->sock_list));

I think this will be triggered as the above logic inverted two calls,
which are now,

1. WARN_ON_ONCE(...)
2. unregister_netdevice_many

But ->sock_list entries are removed in ndo_exit, called from
unregister_netdevice_many.

I guess the warning could be moved to exit_batch (or removed).

Thanks,
Antoine


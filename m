Return-Path: <netdev+bounces-244822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D04CBF18F
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 18:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D0C9300216E
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 17:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8993385B6;
	Mon, 15 Dec 2025 17:00:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65860338592;
	Mon, 15 Dec 2025 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765818058; cv=none; b=Wn4MLF1L2Tr3gIqpaSqhuDMeNA7WHROxh1sw8EiSUe7wO7IxLzURpC/edA95Yyj0zQeIjgUQTDq6XOLIKCUzKWtNDZhnZfnHi8z2FoBHEHxXkJBWgoXvW4/mnuA+T36sxHWtHF6KFH0hH1SzZAMk1nvpaU59cbgd6/0oG9gKTI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765818058; c=relaxed/simple;
	bh=MeAZ1GStC6m6uPIP0sg9vcwJjUoIqzUK8vvFUNls+A8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MMqEuLJrEGTmgvaaMW1zXaACTiRSC5DpyMj+yOUDGYQqayhna1LapJsV9RbcrLkIq4Nn1MXuTKt20MmqM+zF6Elfqk1OCwtFb4Q7iKM2cZ6sEKsOOi7R2jgqyw3MAwwWTPC5LDY9oHNq1rzM++VvMnxhSK7EqfMZAUTT6JfesCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dVRBz3B71zJ46BK;
	Tue, 16 Dec 2025 01:00:27 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id C9C8D40539;
	Tue, 16 Dec 2025 01:00:53 +0800 (CST)
Received: from [10.123.122.223] (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Dec 2025 20:00:53 +0300
Message-ID: <4a0b0695-f13e-4611-a6a5-524b4967ff6e@huawei.com>
Date: Mon, 15 Dec 2025 20:00:52 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipvlan: Make the addrs_lock be per port
To: <netdev@vger.kernel.org>, Xiao Liang <shaw.leon@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Guillaume Nault
	<gnault@redhat.com>, Julian Vetter <julian@outer-limits.org>, Eric Dumazet
	<edumazet@google.com>, Stanislav Fomichev <sdf@fomichev.me>, Etienne
 Champetier <champetier.etienne@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>
References: <20251215165457.752634-1-skorodumov.dmitry@huawei.com>
Content-Language: en-US
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
In-Reply-To: <20251215165457.752634-1-skorodumov.dmitry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500004.china.huawei.com (7.188.26.250)

I'm working currently on some selftests/net for ipvtap for some kind of test (test calls "ip a a/ip a d" in several threads), but I'm unsure how to proceed:

This patch is supposed to be a "fix". But selftest - obviously not a fix.

So, I'm unsure how to send a selftest for this.

Dmitry


On 15.12.2025 19:54, Dmitry Skorodumov wrote:
> Make the addrs_lock be per port, not per ipvlan dev.
>
> Initial code seems to be written in the assumption,
> that any address change must occur under RTNL.
> But it is not so for the case of IPv6. So
>
> 1) Introduce per-port addrs_lock.
>
> 2) It was needed to fix places where it was forgotten
> to take lock (ipvlan_open/ipvlan_close)
>
> 3) Fix places, where list_for_each_entry_rcu()
> was used to iterate the list while holding a lock
>
> This appears to be a very minor problem though.
> Since it's highly unlikely that ipvlan_add_addr() will
> be called on 2 CPU simultaneously. But nevertheless,
> this could cause:
>
> 1) False-negative of ipvlan_addr_busy(): one interface
> iterated through all port->ipvlans + ipvlan->addrs
> under some ipvlan spinlock, and another added IP
> under its own lock. Though this is only possible
> for IPv6, since looks like only ipvlan_addr6_event() can be
> called without rtnl_lock.
>
> 2) Race since ipvlan_ht_addr_add(port) is called under
> different ipvlan->addrs_lock locks
>
> This should not affect performance, since add/remove IP
> is a rare situation and spinlock is not taken on fast
> paths.
>
> Fixes: 8230819494b3 ("ipvlan: use per device spinlock to protect addrs list updates")
> Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
> CC: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>


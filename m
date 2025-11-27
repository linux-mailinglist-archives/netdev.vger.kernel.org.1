Return-Path: <netdev+bounces-242245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E3DC8E12B
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 679ED3A8293
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 11:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBD932B9A5;
	Thu, 27 Nov 2025 11:42:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152E432AADA;
	Thu, 27 Nov 2025 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764243726; cv=none; b=p+3+9h3zALJJzARK6y6LR5DG+9kl3OQn676mGc9x+uxMeldQUFO+b3SPUTd3fPOQ0MZTzJQiszWyVXLlZMjDs6bAsGFNNL7JFm7hCBWwPHZDRHljeEvW/T4z4e50g+KYtk3e/QQDNZZvBGllcZoxkenStbMVk9GjKBu2QDJRFeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764243726; c=relaxed/simple;
	bh=ix0pW9f0iMFgYnYlk3CZAe+tQ8zn1uG9c6QLdGIS2mI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VAcqpfVTtZISUTdw5aHOaH/K7oPV3mt1d7CG1PBkRTS0Oj5QPA4ouxShUSXYaQ+5DwZeA9Okwlk9rQNpvetUc31pvHiF25A/dTx3rQVSNRqmaj7MaecNwd7AO2Dsaw4oy5scv7ut5Z4Qo7Gz9TadIq9i6Ak27CgOlo1R9frPUd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dHDym53CtzJ46sQ;
	Thu, 27 Nov 2025 19:41:04 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 8135114020C;
	Thu, 27 Nov 2025 19:42:01 +0800 (CST)
Received: from [10.123.122.223] (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Nov 2025 14:42:00 +0300
Message-ID: <d67662fc-cdd1-4f48-87b6-40da838fea32@huawei.com>
Date: Thu, 27 Nov 2025 14:42:00 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/12] ipvlan: Don't allow children to use IPs of
 main
To: Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>, Kuniyuki
 Iwashima <kuniyu@google.com>, Xiao Liang <shaw.leon@gmail.com>, Jakub
 Kicinski <kuba@kernel.org>, Julian Vetter <julian@outer-limits.org>, Ido
 Schimmel <idosch@nvidia.com>, Guillaume Nault <gnault@redhat.com>, Eric
 Dumazet <edumazet@google.com>, Stanislav Fomichev <sdf@fomichev.me>, Etienne
 Champetier <champetier.etienne@gmail.com>, <linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
References: <20251120174949.3827500-1-skorodumov.dmitry@huawei.com>
 <20251120174949.3827500-8-skorodumov.dmitry@huawei.com>
 <12d4a794-24f4-4201-8671-38851edb7942@redhat.com>
Content-Language: en-US
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
In-Reply-To: <12d4a794-24f4-4201-8671-38851edb7942@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500004.china.huawei.com (7.188.26.250)


On 25.11.2025 17:26, Paolo Abeni wrote:
> On 11/20/25 6:49 PM, Dmitry Skorodumov wrote:
>> Remember all ip-addresses on main iface and check
>> in ipvlan_addr_busy() that addr is not used on main.
> Why?
>
> Why using in_dev_for_each_ifa_rcu()/in6_dev->addr_list is not good enough?
>
> Note that IP addtion on the main interface can race with
> ipvlan_addr_busy() even with the code you are proposing.
>
Hm.. I don't see lt:


the ipvlan_port_add_addr_event(addr) does { ipvlan_port_add_addr(addr); ipvlan_port_del_addr_ipvlans(addr); }

ipvlan_port_add_addr(addr) { lock(addrs_lock); list_add(addr); unlock(addrs_lock);}

ipvlan_port_del_addr_ipvlans(addr) { lock(addrs_lock); for_each_ipvlan ipvlan_del_addr(ipvlan, addr); unlock(addrs_lock);}


ipvlan_macnat_addr_learn(addr); { lock(addrs_lock); if !ipvlan_addr_busy(): ipvlan_remember(addr); unlock(addrs_lock); }


There is a small window when addr can be remembered on ipvlan. But with the next step in ipvlan_port_add_addr_event(), it will be cleaned up with ipvlan_port_del_addr_ipvlans()

The idea is "it is ok to allow few packets to pass the protection, but don't allow this address be white-listed for forever"

===

I tried first in_dev_for_each_ifa_rcu(), instead of remembering on main iface, but it's not easy to invent synchronization mechanic for this..

if in ipvlan_macnat_addr_learn() we Start -> (1) iterated through in_dev_for_each_ifa_rcu(); found that address is not used and (2) remembered it on ipvlan -> (3) End

there is no way how ipvlan_port_add_addr() can ensure without locks: we can be in the [1-2] stage in addr_learn. And if we try to call ipvlan_del_addr() - again,  we can be in the [1-2] stage in addr_learn


may be we could

in ipvlan_macnat_addr_learn() 

Start -> (1) iterated through in_dev_for_each_ifa_rcu(); found that address is not used and (2) remembered it on ipvlan -> (3) reiterate again through in_dev_for_each_ifa_rcu() -> End

but I think the code becomes overcomplicated with this

Dmitry



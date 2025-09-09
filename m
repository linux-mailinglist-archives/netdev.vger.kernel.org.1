Return-Path: <netdev+bounces-221038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FA4B49ED7
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 03:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5167816328E
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 01:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3FB209F5A;
	Tue,  9 Sep 2025 01:47:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E59B1A9F87
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 01:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757382424; cv=none; b=CQtUL8HrlcIxvvux7nMf5sxFeERfWINKYCD7OugdUkB9/7HTKHXczDFq2QE8JqiXAbxQ7EU7U3B36/t7TmFMbeilc6J2ZPbf+BNKbG6HckLTN/eo+WsyubJLPGY6xt5ETJbskezfKjA+ZmT6ktA8luuUwaCMLAVTBbqW8qoJHj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757382424; c=relaxed/simple;
	bh=kcnNEa04aDqlYIaE+UqNOuE22W/D8JqOvrf8nfL7M9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l1ugQuzPfu2cJcANHIwIxwQX2DqCZELZqTg9HtXGbMEDYm6isLqTNI5l/tiSGBFcMeLEOjGVQRN1mR0pKMAhsuyMHBZwdIQ0MLInRfMn8DbAsfujLSOa6mXjmhvC7EtFzCxrPcG2RZYTj3NTWe5V9VulLdFCRt3TlLI+qse4LCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cLRS06790z24j7J;
	Tue,  9 Sep 2025 09:43:44 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C7661A0188;
	Tue,  9 Sep 2025 09:46:58 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Sep 2025 09:46:57 +0800
Message-ID: <fe8e9969-76dd-4fc0-9da8-13656a870fb2@huawei.com>
Date: Tue, 9 Sep 2025 09:46:56 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] vxlan: Make vxlan_fdb_find_uc() more robust
 against NPDs
To: Ido Schimmel <idosch@nvidia.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <razor@blackwall.org>,
	<petrm@nvidia.com>
References: <20250908075141.125087-1-idosch@nvidia.com>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <20250908075141.125087-1-idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500016.china.huawei.com (7.185.36.197)


在 2025/9/8 15:51, Ido Schimmel 写道:
> first_remote_rcu() can return NULL if the FDB entry points to an FDB
> nexthop group instead of a remote destination. However, unlike other
> users of first_remote_rcu(), NPD cannot currently happen in
> vxlan_fdb_find_uc() as it is only invoked by one driver which vetoes the
> creation of FDB nexthops.
>
> Make the function more robust by making sure the remote destination is
> only dereferenced if it is not NULL.
>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   drivers/net/vxlan/vxlan_core.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index dab864bc733c..a5c55e7e4d79 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -446,7 +446,7 @@ int vxlan_fdb_find_uc(struct net_device *dev, const u8 *mac, __be32 vni,
>   {
>   	struct vxlan_dev *vxlan = netdev_priv(dev);
>   	u8 eth_addr[ETH_ALEN + 2] = { 0 };
> -	struct vxlan_rdst *rdst;
> +	struct vxlan_rdst *rdst = NULL;
>   	struct vxlan_fdb *f;
>   	int rc = 0;
>   
> @@ -459,12 +459,13 @@ int vxlan_fdb_find_uc(struct net_device *dev, const u8 *mac, __be32 vni,
>   	rcu_read_lock();
>   
>   	f = vxlan_find_mac_rcu(vxlan, eth_addr, vni);
> -	if (!f) {
> +	if (f)
> +		rdst = first_remote_rcu(f);
> +	if (!rdst) {
>   		rc = -ENOENT;
>   		goto out;
>   	}
>   
> -	rdst = first_remote_rcu(f);
>   	vxlan_fdb_switchdev_notifier_info(vxlan, f, rdst, NULL, fdb_info);
>   
>   out:


Reviewed-by: Wang Liang <wangliang74@huawei.com>



Return-Path: <netdev+bounces-201400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1846AE949C
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 05:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886F33B31D7
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 03:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946C91F12E9;
	Thu, 26 Jun 2025 03:42:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1BA1E98E6;
	Thu, 26 Jun 2025 03:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750909337; cv=none; b=iXfo1lSRMQi8ArgbCqxU0cDbsWKfByahDW3vRLxCP/rbe8i3/Wow9PthwkLo423oO4i3w12cq6XTx5qIbq1qTjIRN4FzvcFggVWRJNOVvSPWqalfSVUmwbvUMcGGdWa6eqlAqe7PGzu4O/tQ9wAd/pFYdsvdplTv4LCu/Af0aFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750909337; c=relaxed/simple;
	bh=Dw17iLxi7vHOpWmFShysTFc4ChOtppgJvzbcyKjSp4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EHWGabAvu1XCf0p+nwLfb/59Z9/S0/Ckks4YI27b274+uCS/LQAigS7yfTIrtojoZRtq8OjRWtZr4iJZ2yiAiIk4s4DaCpBM+HYoBUVM4Qfy0525CgJ1qnJkXgi7VjvRvqUPlWi2hnhIM2HDEoF5xtVD1gJqJ5vzhNfqdroaCK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bSPXR0d7jzdbln;
	Thu, 26 Jun 2025 11:37:59 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 3752618049E;
	Thu, 26 Jun 2025 11:41:57 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Jun 2025 11:41:47 +0800
Received: from [10.174.177.223] (10.174.177.223) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Jun 2025 11:41:46 +0800
Message-ID: <900f28da-83db-4b17-b56b-21acde70e47f@huawei.com>
Date: Thu, 26 Jun 2025 11:41:45 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: vlan: fix VLAN 0 refcount imbalance of toggling
 filtering during runtime
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <jiri@resnulli.us>, <oscmaes92@gmail.com>,
	<linux@treblig.org>, <pedro.netdev@dondevamos.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>
References: <20250623113008.695446-1-dongchenchen2@huawei.com>
 <20250624174252.7fbd3dbe@kernel.org>
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
In-Reply-To: <20250624174252.7fbd3dbe@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq200002.china.huawei.com (7.202.195.90)


> On Mon, 23 Jun 2025 19:30:08 +0800 Dong Chenchen wrote:
>> $ ip link add bond0 type bond mode 0
>> $ ip link add link bond0 name vlan0 type vlan id 0 protocol 802.1q
>> $ ethtool -K bond0 rx-vlan-filter off
>> $ ifconfig bond0 up
>> $ ethtool -K bond0 rx-vlan-filter on
>> $ ifconfig bond0 down
>> $ ifconfig bond0 up
>> $ ip link del vlan0

Hi, Jakub
Thanks for your review!

> Please try to figure out the reasonable combinations in which we can
> change the flags and bring the device up and down. Create a selftest
> in bash and add it under tools/testing/selftests/net

selftest patch will be added in v2.

>> diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
>> index 06908e37c3d9..6e01ece0a95c 100644
>> --- a/net/8021q/vlan.c
>> +++ b/net/8021q/vlan.c
>> @@ -504,12 +504,21 @@ static int vlan_device_event(struct notifier_block *unused, unsigned long event,
>>   		break;
>>   
>>   	case NETDEV_CVLAN_FILTER_PUSH_INFO:
>> +		flgs = dev_get_flags(dev);
> Why call dev_get_flags()? You can test dev->flags & IFF_UP directly

Yes, there is no need to use this function, I will modify it in v2

>> +		if (flgs & IFF_UP) {
>> +			pr_info("adding VLAN 0 to HW filter on device %s\n",
>> +				dev->name);
>> +			vlan_vid_add(dev, htons(ETH_P_8021Q), 0);
> Not sure if this works always, because if we have no vlan at all when
> the device comes up vlan_info will be NULL and we won't even get here.
>
> IIUC adding vlan 0 has to be handled early, where UP is handled.

Yes, that's right.

the sequence as below can still trigger the issue:

$ ip link add bond0 type bond mode 0
$ ethtool -K bond0 rx-vlan-filter off
$ ifconfig bond0 up
$ ethtool -K bond0 rx-vlan-filter on
$ ip link add link bond0 name vlan0 type vlan id 0 protocol 802.1q
$ ifconfig bond0 down
$ ifconfig bond0 up
$ ip link del vlan0

maybe we can fix it by:

diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index 6e01ece0a95c..262f8d3f06ef 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -378,14 +378,18 @@ static int vlan_device_event(struct notifier_block *unused, unsigned long event,
              return notifier_from_errno(err);
      }
  
-    if ((event == NETDEV_UP) &&
-        (dev->features & NETIF_F_HW_VLAN_CTAG_FILTER)) {
+    if (((event == NETDEV_UP) &&
+        (dev->features & NETIF_F_HW_VLAN_CTAG_FILTER)) ||
+        (event == NETDEV_CVLAN_FILTER_PUSH_INFO &&
+        (dev->flags & IFF_UP))) {
          pr_info("adding VLAN 0 to HW filter on device %s\n",
              dev->name);
          vlan_vid_add(dev, htons(ETH_P_8021Q), 0);
      }
-    if (event == NETDEV_DOWN &&
-        (dev->features & NETIF_F_HW_VLAN_CTAG_FILTER))
+    if ((event == NETDEV_DOWN &&
+        (dev->features & NETIF_F_HW_VLAN_CTAG_FILTER)) ||
+        (event == NETDEV_CVLAN_FILTER_DROP_INFO &&
+        (dev->flags & IFF_UP)))
          vlan_vid_del(dev, htons(ETH_P_8021Q), 0);
  
     vlan_info = rtnl_dereference(dev->vlan_info);

------
Best regards
Dong Chenchen

>> +		}
>>   		err = vlan_filter_push_vids(vlan_info, htons(ETH_P_8021Q));
>>   		if (err)
>>   			return notifier_from_errno(err);
>>   		break;
>>   
>>   	case NETDEV_CVLAN_FILTER_DROP_INFO:
>> +		flgs = dev_get_flags(dev);
>> +		if (flgs & IFF_UP)
>> +			vlan_vid_del(dev, htons(ETH_P_8021Q), 0);
>>   		vlan_filter_drop_vids(vlan_info, htons(ETH_P_8021Q));


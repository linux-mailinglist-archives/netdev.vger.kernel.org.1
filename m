Return-Path: <netdev+bounces-33752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 294BD79FE9C
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 10:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA425B20BA1
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 08:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4193BCA4E;
	Thu, 14 Sep 2023 08:41:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DD31CFA9
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 08:41:36 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6130591
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 01:41:35 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RmW183sMpzMlLM;
	Thu, 14 Sep 2023 16:38:04 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 14 Sep 2023 16:41:32 +0800
Subject: Re: [PATCH net v4] team: fix null-ptr-deref when team device type is
 changed
To: Paolo Abeni <pabeni@redhat.com>, <jiri@resnulli.us>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <leon@kernel.org>, <ye.xingchen@zte.com.cn>,
	<liuhangbin@gmail.com>
References: <20230911094636.3256542-1-william.xuanziyang@huawei.com>
 <2910908aeafc8ff133168045ee19f290a7bb35e0.camel@redhat.com>
 <2cad19f1-552b-792f-f074-daadd8753a59@huawei.com>
 <06082c443dbaf83495dde16c33884adc30872ec8.camel@redhat.com>
From: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <4401cd29-0502-67b2-29b1-2db0a23b2042@huawei.com>
Date: Thu, 14 Sep 2023 16:41:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <06082c443dbaf83495dde16c33884adc30872ec8.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected

> On Wed, 2023-09-13 at 14:15 +0800, Ziyang Xuan (William) wrote:
> 
> To me both cases look the same in the end: the team driver sets and use
> header_ops of a different device that will assume dev_priv() being a
> different struct.
> 
> I'm guessing a generic solution could be implementing 'trampoline'
> header_ops that just call into the lower port corresponding op, and
> assigning such ops to the team device every time the lower has non
> ethernet header_ops.
> 
> team_dev_type_check_change() should then probably check both dev->type
> and dev->header_ops.
> 
>>> Exporting 'eth_header_ops' for team's sake only looks a bit too
>>> much to
>>> me. I think could instead cache the header_ops ptr after the
>>> initial
>>> ether_setup().
>>
>> Is it possible to use ether_setup() like bonding driver andmodify MTU
>> individually later?
> 
> That could be another option to get the eth_header_ops.
> 
> Note that in the end both are quite similar, you will have to cache
> some info (the mtu with the latter); ether_setup() possibly will have
> more side effects, as it touches many fields. I personally would use
> the thing I suggested above.
> 
Hi Pallo,

Is it possible to modify like this?

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index d3dc22509ea5..8e6a87ba85aa 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2127,7 +2127,12 @@ static const struct ethtool_ops team_ethtool_ops = {
 static void team_setup_by_port(struct net_device *dev,
                               struct net_device *port_dev)
 {
-       dev->header_ops = port_dev->header_ops;
+       struct team *team = netdev_priv(dev);
+
+       if (port_dev->type == ARPHRD_ETHER)
+               dev->header_ops = team->header_ops_cache;
+       else
+               dev->header_ops = port_dev->header_ops;
        dev->type = port_dev->type;
        dev->hard_header_len = port_dev->hard_header_len;
        dev->needed_headroom = port_dev->needed_headroom;
@@ -2174,8 +2179,11 @@ static int team_dev_type_check_change(struct net_device *dev,

 static void team_setup(struct net_device *dev)
 {
+       struct team *team = netdev_priv(dev);
+
        ether_setup(dev);
        dev->max_mtu = ETH_MAX_MTU;
+       team->header_ops_cache = dev->header_ops;

        dev->netdev_ops = &team_netdev_ops;
        dev->ethtool_ops = &team_ethtool_ops;
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index 8de6b6e67829..34bcba5a7067 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -189,6 +189,8 @@ struct team {
        struct net_device *dev; /* associated netdevice */
        struct team_pcpu_stats __percpu *pcpu_stats;

+       const struct header_ops *header_ops_cache;
+
        struct mutex lock; /* used for overall locking, e.g. port lists write */


Thank you.

> Cheers,
> 
> Paolo
> 
> .
> 


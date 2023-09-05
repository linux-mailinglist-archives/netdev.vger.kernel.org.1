Return-Path: <netdev+bounces-31990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA4E79202D
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 05:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8AF1C204FC
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 03:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD09648;
	Tue,  5 Sep 2023 03:36:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32DC7E
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 03:36:41 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB20CCC7
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 20:36:39 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RfrhV4FX5zVjtl;
	Tue,  5 Sep 2023 11:34:02 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 5 Sep 2023 11:36:37 +0800
Subject: Re: [PATCH net] team: fix null-ptr-deref when team device type is
 changed
To: Hangbin Liu <liuhangbin@gmail.com>
CC: <jiri@resnulli.us>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <20230902092007.3038132-1-william.xuanziyang@huawei.com>
 <ZPWwE9IYArI08Zsc@Laptop-X1>
From: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <dc1f51d9-ac48-6155-46d4-760781ea202c@huawei.com>
Date: Tue, 5 Sep 2023 11:36:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZPWwE9IYArI08Zsc@Laptop-X1>
Content-Type: text/plain; charset="gbk"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Hi Ziyang,
> 
> On Sat, Sep 02, 2023 at 05:20:07PM +0800, Ziyang Xuan wrote:
>> $ teamd -t team0 -d -c '{"runner": {"name": "loadbalance"}}'
>> $ ip link add name t-dummy type dummy
>> $ ip link add link t-dummy name t-dummy.100 type vlan id 100
>> $ ip link add name t-nlmon type nlmon
>> $ ip link set t-nlmon master team0
>> $ ip link set t-nlmon nomaster
>> $ ip link set t-dummy up
>> $ ip link set team0 up
>> $ ip link set t-dummy.100 down
>> $ ip link set t-dummy.100 master team0
>>
>> When enslave a vlan device to team device and team device type is changed
>> from non-ether to ether, header_ops of team device is changed to
>> vlan_header_ops. That is incorrect and will trigger null-ptr-deref
>> for vlan->real_dev in vlan_dev_hard_header() because team device is not
>> a vlan device.
>>
>> Use ether_setup() for team device when its type is changed from non-ether
>> to ether to fix the bug.
>>
>> Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
>> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
>> ---
>>  drivers/net/team/team.c | 21 +++++++++++++--------
>>  1 file changed, 13 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
>> index d3dc22509ea5..560e04860aa7 100644
>> --- a/drivers/net/team/team.c
>> +++ b/drivers/net/team/team.c
>> @@ -2127,14 +2127,19 @@ static const struct ethtool_ops team_ethtool_ops = {
>>  static void team_setup_by_port(struct net_device *dev,
>>  			       struct net_device *port_dev)
>>  {
>> -	dev->header_ops	= port_dev->header_ops;
>> -	dev->type = port_dev->type;
>> -	dev->hard_header_len = port_dev->hard_header_len;
>> -	dev->needed_headroom = port_dev->needed_headroom;
>> -	dev->addr_len = port_dev->addr_len;
>> -	dev->mtu = port_dev->mtu;
>> -	memcpy(dev->broadcast, port_dev->broadcast, port_dev->addr_len);
>> -	eth_hw_addr_inherit(dev, port_dev);
>> +	if (port_dev->type == ARPHRD_ETHER) {
>> +		ether_setup(dev);
>> +		eth_hw_addr_random(dev);
>> +	} else {
>> +		dev->header_ops	= port_dev->header_ops;
>> +		dev->type = port_dev->type;
>> +		dev->hard_header_len = port_dev->hard_header_len;
>> +		dev->needed_headroom = port_dev->needed_headroom;
>> +		dev->addr_len = port_dev->addr_len;
>> +		dev->mtu = port_dev->mtu;
>> +		memcpy(dev->broadcast, port_dev->broadcast, port_dev->addr_len);
>> +		eth_hw_addr_inherit(dev, port_dev);
>> +	}
>>  
>>  	if (port_dev->flags & IFF_POINTOPOINT) {
>>  		dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
> 
> Thanks for the report. This fix is similar with what I do in my PATCHv3 [1].
> And this will go back to the discussion of MTU update. How about just update
> the header_ops for ARPHRD_ETHER? e.g.
> 
> 	if (port_dev->type == ARPHRD_ETHER)
> 		dev->header_ops	= &eth_header_ops;
> 	else
> 		dev->header_ops	= port_dev->header_ops;
> 
That looks good to me too. I will send patch v2 later.

Thank you!
William Xuan

> [1] https://lore.kernel.org/netdev/20230718101741.2751799-3-liuhangbin@gmail.com/
> 
> Thanks
> Hangbin
> 
> .
> 


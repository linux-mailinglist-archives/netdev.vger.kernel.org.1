Return-Path: <netdev+bounces-221414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5723FB50783
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 22:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531301C638D3
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675A82FF147;
	Tue,  9 Sep 2025 20:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="HUJd2sdZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G/y6dxIJ"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA5D1FF5F9
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 20:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757451247; cv=none; b=IxCV+wB5ECO2k48yMb+xK+J/tiKNJ5oml4tMIywI/jkQWqUMtC/eVtIVxM4r7jRviit/sGzAhgnu8GEs/yG30eLpas9bgvng1WN3bXt66yft7JWqrhPaKi783ozcIuKKFrRKy1NU7ruTBd1g9ChypQV8aoofLNNLDArV9hRSEFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757451247; c=relaxed/simple;
	bh=INH63zfUFEswtQLTU3zqWfwQq/O30z8B1DER2xpYZII=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=gI+/OHWoC/TjqO7COu/cnvbTRpaNt2+UHdIjVXW7v8dr60sK+xW81vpsx11CjUQd0X8VEjmOExTJXfHN3V5H4P1aTVfzPj6W3rP0dIsinO44SrkpaVQUT/KL4Sg3HsSWrKS4tvm5sFmHF1YD29MFegDwGrjJddMp+vnT2ISljug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=HUJd2sdZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G/y6dxIJ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A743E14000B5;
	Tue,  9 Sep 2025 16:54:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 09 Sep 2025 16:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1757451244; x=1757537644; bh=tzK2ssom96X4oV3km6+R4
	O28lO5vF6izmA7MP8BMFqQ=; b=HUJd2sdZB8yLmbbyPGw0iuxPUI+kZhM65+oof
	M6/ZnzYq3TWXl3yBP7cenR0OwEWRUWObDJiHGx6Z4shcjyEvkubnXwfjo+4b0Cxb
	WvVI8BXydaX+WMBSsB8cvseAH7FKoorXoo9KiVDWNiVvSGVDExpODTaWgkRRPqBF
	Ihs3Z4xSjzkuzKulXw0HE3fKfGIA6B6GlMGhikPx8RgYQGyc0YLbONGSVLO4Qdch
	Z39fiqnGc/wG7fNN/hxIZVHT7uYSyL9OK4MmOac+2pghGbM3WgCN0eP2Mx4Cv4sS
	aa1p04U6cYnmnMRR5+IdVWIeLDz1Vzo7xvGIs+1WVg2hFqEoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757451244; x=1757537644; bh=tzK2ssom96X4oV3km6+R4O28lO5vF6izmA7
	MP8BMFqQ=; b=G/y6dxIJG7jn0TO+RhA6eNDeIqXksvrSic6ZwmlxIyT1AglMeQC
	V2nv2Zuqa1CZZd81+c4wp2ZlDJn6zJi+pZNLqjvUeDH/Fd9LRo/alZ6i05HA32Cc
	1lesh+4uSVAkj0Q3YyWmSBXd79MahgfZG1UbuTh4tM0jRdnoO70L+gmKYy80Uf+k
	7QKCQzUFYFEoFdgM5MQqsa4UOUswNbgT5C79YaViiajy9VxFpAI4mIncC26U1xVU
	dVkZqoG4z1h2DiKblw6ReLgKVuCls2+Rk+QasDQ/BrXb7qcah9unQdXQB12WXzFk
	6pt2XcV8unwLQ9iZ2g8JjuiGkJmBPR2DiBw==
X-ME-Sender: <xms:7JPAaAfMGJt940UrKwE0r9gkOmRIcTu2vYlPN42YcrWGUBUHpYof6w>
    <xme:7JPAaOH7NXAISWC3cOqnc9v_S1-7xcddMevkX0EFyYYBYuz28ZvCQH0h8KWbsifS3
    -c6WPPIZ3raVvb-QY4>
X-ME-Received: <xmr:7JPAaOh_f2itewNNSj_z8W9ml8xQWL_wfn2_hrpNwGJlsfP4ZHVFy1EH_TUylptFnN9DkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhfogggtgfffkfesthhqredtredtvdenucfhrhhomheplfgrhicuggho
    shgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeifedvleefleejveethfefieduueeivdefieevleffuddvveeftdehffffteefffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjh
    hvohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhgpdhrtghpth
    htohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhrrgguvggvphhs
    sehlihhnuhigrdhvnhgvthdrihgsmhdrtghomhdprhgtphhtthhopehsthgvphhhvghnse
    hnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopehirdhmrgigihhmvght
    shesohhvnhdrohhrghdprhgtphhtthhopegrmhhorhgvnhhoiiesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtohephhgrlhhiuhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphhr
    rgguvggvphesuhhsrdhisghmrdgtohhmpdhrtghpthhtohepfihilhguvghrsehushdrih
    gsmhdrtghomh
X-ME-Proxy: <xmx:7JPAaK1QReJ3KlEy6otU0lVPsbZs_azGfD-LZbDSYwyVXak1fYHRfQ>
    <xmx:7JPAaBcBzMuLj3CJeLV8WcsK1_d4Elhy44BgjUGld-n1c0wzyl8kmA>
    <xmx:7JPAaAxeuTTG5tZyf3PVvYbvcii3Muj7fa-eQT84NMqpPAdFmn9w7Q>
    <xmx:7JPAaJxpBl9kI_EsW7WqMmcYhkg9LIr3mV27T1G5ldby53x7XxrxDw>
    <xmx:7JPAaKev9tOCKsLPONtqr4kL6D6EtH4u2sSNnSdHWsGhbeM1t4qYiwPh>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 16:54:03 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 78B119FCB4; Tue,  9 Sep 2025 13:54:02 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 755C29FC62;
	Tue,  9 Sep 2025 13:54:02 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Nikolay Aleksandrov <razor@blackwall.org>
cc: David Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org,
    pradeeps@linux.vnet.ibm.com, pradeep@us.ibm.com, i.maximets@ovn.org,
    amorenoz@redhat.com, haliu@redhat.com, stephen@networkplumber.org,
    horms@kernel.org
Subject: Re: [PATCH net-next v10 5/7] bonding: Update to bond_arp_send_all()
 to use supplied vlan tags
In-reply-to: <2c0f972a-2393-4554-a76b-3ac425fed42b@blackwall.org>
References: <20250904221956.779098-1-wilder@us.ibm.com>
 <20250904221956.779098-6-wilder@us.ibm.com>
 <2c0f972a-2393-4554-a76b-3ac425fed42b@blackwall.org>
Comments: In-reply-to Nikolay Aleksandrov <razor@blackwall.org>
   message dated "Tue, 09 Sep 2025 21:55:35 +0300."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2921169.1757451242.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Sep 2025 13:54:02 -0700
Message-ID: <2921170.1757451242@famine>

Nikolay Aleksandrov <razor@blackwall.org> wrote:

>On 9/5/25 01:18, David Wilder wrote:
>> bond_arp_send_all() will pass the vlan tags supplied by
>> the user to bond_arp_send(). If vlan tags have not been
>> supplied the vlans in the path to the target will be
>> discovered by bond_verify_device_path(). The discovered
>> vlan tags are then saved to be used on future calls to
>> bond_arp_send().
>> bond_uninit() is also updated to free vlan tags when a
>> bond is destroyed.
>> Signed-off-by: David Wilder <wilder@us.ibm.com>
>> ---
>>   drivers/net/bonding/bond_main.c | 22 +++++++++++++---------
>>   1 file changed, 13 insertions(+), 9 deletions(-)
>> diff --git a/drivers/net/bonding/bond_main.c
>> b/drivers/net/bonding/bond_main.c
>> index 7548119ca0f3..7288f8a5f1a5 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -3063,18 +3063,19 @@ struct bond_vlan_tag *bond_verify_device_path(s=
truct net_device *start_dev,
>>     static void bond_arp_send_all(struct bonding *bond, struct slave
>> *slave)
>>   {
>> -	struct rtable *rt;
>> -	struct bond_vlan_tag *tags;
>>   	struct bond_arp_target *targets =3D bond->params.arp_targets;
>> +	char pbuf[BOND_OPTION_STRING_MAX_SIZE];
>> +	struct bond_vlan_tag *tags;
>>   	__be32 target_ip, addr;
>> +	struct rtable *rt;
>>   	int i;
>>     	for (i =3D 0; i < BOND_MAX_ARP_TARGETS && targets[i].target_ip; i+=
+)
>> {
>>   		target_ip =3D targets[i].target_ip;
>>   		tags =3D targets[i].tags;
>>   -		slave_dbg(bond->dev, slave->dev, "%s: target %pI4\n",
>> -			  __func__, &target_ip);
>> +		slave_dbg(bond->dev, slave->dev, "%s: target %s\n", __func__,
>> +			  bond_arp_target_to_string(&targets[i], pbuf, sizeof(pbuf)));
>>     		/* Find out through which dev should the packet go */
>>   		rt =3D ip_route_output(dev_net(bond->dev), target_ip, 0, 0, 0,
>> @@ -3096,9 +3097,13 @@ static void bond_arp_send_all(struct bonding *bo=
nd, struct slave *slave)
>>   		if (rt->dst.dev =3D=3D bond->dev)
>>   			goto found;
>>   -		rcu_read_lock();
>> -		tags =3D bond_verify_device_path(bond->dev, rt->dst.dev, 0);
>> -		rcu_read_unlock();
>> +		if (!tags) {
>> +			rcu_read_lock();
>> +			tags =3D bond_verify_device_path(bond->dev, rt->dst.dev, 0);
>> +			/* cache the tags */
>> +			targets[i].tags =3D tags;
>> +			rcu_read_unlock();
>
>Surely you must be joking. You cannot overwrite the tags pointer without =
any synchronization.

	Agreed, I think this will race with at least bond_fill_info,
_bond_options_arp_ip_target_set, and bond_option_arp_ip_target_rem.

	Also, pretending for the moment that the above isn't an issue,
does this cache handle changes in real time?  I.e., if the VLAN above
the bond is replumbed without dismantling the bond, will the above
notice and do the right thing?

	The current code checks the device path on every call, and I
don't see how it's feasible to skip that.

	Separately, a random thought while looking at the code, I feel
like there ought to be a way to replace the GFP_ATOMIC memory allocation
in bond_verify_device_path with storage local to its caller (since it's
always immediately freed), but that's probably not something to get into
for this patch set.

	-J

>> +		}
>>     		if (!IS_ERR_OR_NULL(tags))
>>   			goto found;
>> @@ -3114,7 +3119,6 @@ static void bond_arp_send_all(struct bonding *bon=
d, struct slave *slave)
>>   		addr =3D bond_confirm_addr(rt->dst.dev, target_ip, 0);
>>   		ip_rt_put(rt);
>>   		bond_arp_send(slave, ARPOP_REQUEST, target_ip, addr, tags);
>> -		kfree(tags);
>>   	}
>>   }
>>   @@ -6047,6 +6051,7 @@ static void bond_uninit(struct net_device
>> *bond_dev)
>>   	bond_for_each_slave(bond, slave, iter)
>>   		__bond_release_one(bond_dev, slave->dev, true, true);
>>   	netdev_info(bond_dev, "Released all slaves\n");
>> +	bond_free_vlan_tags(bond->params.arp_targets);
>>     #ifdef CONFIG_XFRM_OFFLOAD
>>   	mutex_destroy(&bond->ipsec_lock);
>> @@ -6633,7 +6638,6 @@ static void __exit bonding_exit(void)
>>     	bond_netlink_fini();
>>   	unregister_pernet_subsys(&bond_net_ops);
>> -
>>   	bond_destroy_debugfs();
>>     #ifdef CONFIG_NET_POLL_CONTROLLER
>

---
	-Jay Vosburgh, jv@jvosburgh.net


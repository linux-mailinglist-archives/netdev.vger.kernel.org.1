Return-Path: <netdev+bounces-279593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFD+BAjp5Gl0bwEAu9opvQ
	(envelope-from <netdev+bounces-279593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 16:39:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CCC424642
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 16:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB0CB300491B
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 14:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C49E21D3E4;
	Sun, 19 Apr 2026 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/EpLyPT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A859E1C3C1F
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776609539; cv=none; b=A5zfbz9iw7kw32j8FlRLhCmi54sg7rZT06ORRYcI93w67SddjzS6TpNPAJZNWFaia0vCqP0ag3Zy2i1tEyGROB9xv8Bhfa2qhv9avIWoc9j8uY7TqqUJm9ww64iMUm9fRiLyCF0pYa3/t7tUWHQEmUQWH1oXC9jjVSV67ptAYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776609539; c=relaxed/simple;
	bh=tlcXlm1EGYPdgH/RDjYPwhioWoT2JMM98ERnPGLKYAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZw8HGtY/0BLfaf3QgndZemoWRZDAfPkZEGNFZnbneP4QyMODsp88OBQ1AZtjSv4JsDvJVO3uSIg3yF407Q1CYWABkG6LVNN4kX8M68r06yAiS0Ngy2DBq8lsPS/6ZO21rYnJCpEHqnT3mkwNNMF8A3ZEKPivpD9czriALUG9uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q/EpLyPT; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so2175532a91.2
        for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 07:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776609538; x=1777214338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXbYtnWhywSmr0JMKJvb407oewKcBkKpjTSErT+Dy40=;
        b=q/EpLyPT9Wbe0IfoVtGNb7tFa+//HVgmb5LFmnvlzrNRqtFFhtMKTkiIVlO3LI5MZJ
         1MGNO6zvkHJ0xFjwCbLCUgtsxmKdjcppWSABQ2Nibf7m0DhI1mBDyv0bC1qXgmvK1Fqj
         iuiPq/qJTlPlMtGDLa4T/2S04C32MVR8Pdxcd+CQaRee6KEG65HStZkxg/1alAHTbJk7
         rJjkSz9T9NZtoi3RWyKW4BbMLiiSPW1fcn33gTmaWfO9UQVej4Mr5AUmt3RHM8jDXVbL
         wo+H9X7le9xMu3URsWXKnsRF/ld9c9QongPqzVH8AqUbo+3aZVbxJ0QC53P7Wuru+dNY
         Hcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776609538; x=1777214338;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FXbYtnWhywSmr0JMKJvb407oewKcBkKpjTSErT+Dy40=;
        b=K0s4j2ou0wRpfpKKxO3/ujM0v4vXbyqYfokn8Bn4NZNuJwCu7NpCqbCFbZSp7F1Q86
         VS6dvD8jd8VZZp60Gn9KjXdpB9yrwh+beSnpTXh5dvkTbnn1KsufRg46OSk7dB0vHR2T
         PZSLfGjcyufIiektPeE8U/IsNB+eUe9Wr2v722cOk4pMo5PhgplbAfnPpnisHgBQdEWs
         9SYDtbwi0EjkVu3yeB7Gm/ikRbLGgAwoOGhqzMlc/AGqio/YvVbULz/caI0XZJE+dpMj
         AxcV6inNIcLDc0F6ajqZEiAc+QgsAIfQQ27v20YRdV2CMqYOzJhNtAaffloSXiOzb988
         +IZA==
X-Gm-Message-State: AOJu0YygQePmDYZyBPmny3p3N/uOdcOSk03G8/He6cyer1E7wfqVjxhC
	OZugHYqH/+/Bd24BbgwtPkzLFB4In5/O1CdnwhnNEjsld256G/M5Ghbp
X-Gm-Gg: AeBDieuDAZDgfJ80LsyimfvddALGaQ+SGXd0KEieQd81KMLQ7Flnhs5v8bLO2nHMFXK
	2mLy6tnwf95ahiKTc+iGAgwxDsK6qQFVHLMSYXjFkgqsrj2uC8zXx6VAS9Q6GSiZNNF7DFHCwKT
	jOrbPHBLsIS1aPCZOq69qpZWmLq/CgyzdLXFRom8TFZQQ5sh3k2p9VAJAVRh3ItLndMAlERWo2D
	ga/VK0wIdF4pqULfFQDgt3OkfZrLjx8bTcUXBNoU6NZXDDzhdtLdj5iFEj35hn+WjzxIQ8jYRr+
	KOqlekweXP0LOaQHEaGJUPRMa7ylwaiXyPq1BDYfuiVelSgHhEroxCoXyXRk79dSXZ2uXPX2UhT
	2F60HkL4gEQJ0YxrgkWowk95CBdRug3HIBzGrVIC9xha8u21ZsqFjB3ks2eXECbJLeL1m7W0e3I
	f1QNLaUdWAaABceFSHJzOYbjziVSHhXPbnIWmXbBIaOeWZN9dRHMf9QLlXl3k=
X-Received: by 2002:a17:903:2283:b0:2b0:54dc:63e with SMTP id d9443c01a7336-2b5f9fadcd4mr114205915ad.33.1776609538020;
        Sun, 19 Apr 2026 07:38:58 -0700 (PDT)
Received: from [0.0.0.0] (42-3-10-232.ptr.netvigator.com. [42.3.10.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab55062sm75684205ad.84.2026.04.19.07.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 07:38:57 -0700 (PDT)
Message-ID: <289e65da-a7db-4b6f-b099-7bb9b95c5b59@gmail.com>
Date: Sun, 19 Apr 2026 22:38:49 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/1] net: l3mdev: Ignore non-L3 uppers in
 l3mdev_fib_table_rcu
To: Ido Schimmel <idosch@nvidia.com>, Ao Zhou <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@resnulli.us>,
 Yifan Wu <yifanwucs@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>,
 Yuan Tan <yuantan098@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
 royenheart@gmail.com
References: <cover.1775062214.git.royenheart@gmail.com>
 <429dd4a81d4ca5624ab9f6d7b53c5fe08552c734.1775443332.git.royenheart@gmail.com>
 <20260406154808.GA714138@shredder>
 <6eb15ec6-6994-4b24-9a53-48a653b96860@gmail.com>
From: Haoze Xie <royenheart@gmail.com>
In-Reply-To: <6eb15ec6-6994-4b24-9a53-48a653b96860@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,google.com,redhat.com,mellanox.com,resnulli.us,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-279593-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royenheart@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Queue-Id: 85CCC424642
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/19/2026 11:49 AM, Haoze Xie wrote:
> 
> On 4/6/2026 11:48 PM, Ido Schimmel wrote:
>> On Mon, Apr 06, 2026 at 09:28:16PM +0800, Ao Zhou wrote:
>>> From: Haoze Xie <royenheart@gmail.com>
>>>
>>> l3mdev_fib_table_rcu() assumes that any upper device observed for
>>> an IFF_L3MDEV_SLAVE device is an L3 master and dereferences
>>> master->l3mdev_ops unconditionally.
>>>
>>> VRF slave setup sets IFF_L3MDEV_SLAVE before the upper link is fully
>>> switched, so readers can transiently observe a non-L3 upper such as a
>>> bridge and follow a NULL l3mdev_ops pointer. Require the current upper
>>> to still be an L3 master before consulting its FIB table.
>>>
>>> Fixes: fdeea7be88b1 ("net: vrf: Set slave's private flag before linking")
>>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
>>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>>> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
>>> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
>>> Suggested-by: Xin Liu <bird@lzu.edu.cn>
>>> Reviewed-by: David Ahern <dsahern@kernel.org>
>>> Signed-off-by: Haoze Xie <royenheart@gmail.com>
>>> Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>
>>> ---
>>> changes in v2:
>>> - point Fixes to the VRF slave ordering change identified by David Ahern
>>> - add David Ahern's Reviewed-by trailer
>>>
>>>  net/l3mdev/l3mdev.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/l3mdev/l3mdev.c b/net/l3mdev/l3mdev.c
>>> index 5432a5f2dfc8..b8a3030cb2c4 100644
>>> --- a/net/l3mdev/l3mdev.c
>>> +++ b/net/l3mdev/l3mdev.c
>>> @@ -177,7 +177,7 @@ u32 l3mdev_fib_table_rcu(const struct net_device *dev)
>>>  		const struct net_device *master;
>>>  
>>>  		master = netdev_master_upper_dev_get_rcu(_dev);
>>> -		if (master &&
>>> +		if (master && netif_is_l3_master(master) &&
>>>  		    master->l3mdev_ops->l3mdev_fib_table)
>>
>> Don't we have the same problem in l3mdev_l3_rcv() and l3mdev_l3_out()?
>> If so, please check if I missed more places and include them in v3.
>>
> 
> I checked the same pattern in the other slave-side helpers, and v3 now
> extends the fix to both `l3mdev_l3_rcv()` and `l3mdev_l3_out()` in
> addition to `l3mdev_fib_table_rcu()`.
> 
> All three helpers resolve the current upper with
> `netdev_master_upper_dev_get_rcu()` and then use `master->l3mdev_ops`.
> So v3 consistently requires the resolved upper to still satisfy
> `netif_is_l3_master(master)` before dereferencing `l3mdev_ops`.
> 

While updating the patch, I found that `l3mdev_l3_rcv()` must keep
working for existing `IFF_L3MDEV_RX_HANDLER` users such as
`ipvlan_l3s`. The v3 patch keeps that direct RX-handler path
intact and applies the extra master check only to the slave-resolved
upper case.

the smoke test, it should ping succeffully:

===> BEGIN smoke test cmd <===
ip netns add ipvl_ns
ip link add ipvl_host type veth peer name ipvl_peer
ip link set ipvl_peer netns ipvl_ns

ip link set ipvl_host up
ip link add link ipvl_host name ipvl0 type ipvlan mode l3s
ip addr add 198.51.100.1/24 dev ipvl0
ip link set ipvl0 up

ip netns exec ipvl_ns ip link set lo up
ip netns exec ipvl_ns ip link set ipvl_peer up
ip netns exec ipvl_ns ip addr add 198.51.100.2/24 dev ipvl_peer
ip netns exec ipvl_ns ping -c 3 198.51.100.1
===> END smoke test cmd <===

>> And I think that the part that I was missing earlier is that we don't
>> have RCU synchronization in the unslaving path, so an RCU reader can
>> either see the original master, NULL or a new master (e.g., bridge
>> instead of the original VRF master).
>>
>>>  			tb_id = master->l3mdev_ops->l3mdev_fib_table(master);
>>>  	}
>>> -- 
>>> 2.53.0
>>>
> 



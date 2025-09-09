Return-Path: <netdev+bounces-221369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5C5B50580
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C23E01C67E5D
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 18:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165942FC88C;
	Tue,  9 Sep 2025 18:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="dxNntv1g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF619219A7D
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 18:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757443360; cv=none; b=A3KOCnHhp8GLxPKdfOW9xhkvi4PJFh/s6HJR7+cFlFsWvdPCgzln1dHadOAtFPFRX2z7SNbIM6lHwcC4MBECSeYOCaxev0i1gnE2+KZ2BKzOXf56rcL1JqX+GdYBJZ8+OqdnZ81OD6NS1gzvxLeOkBpbLb1XhxuXUn9BqFqn8bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757443360; c=relaxed/simple;
	bh=IvXwJzqrYTv90UFjymuXZYGhH0dMgJgVZ+waSkbz11M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qR0+s4u+8yxBZ5AaLYhdRdDFntob5pImjVa1rvdfbxTYJJ7xYkZjZqe3LaWvgYnggln97TmtWMyjIPDsayxJUORBLs5bCUEX+YwiMs+TdHdYvoMkoQEpnpnqYgdJ6ylUeur9Jb3HZK9uG6/8RA1TFGbVk9xOkVrXGqs/EILX0j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=dxNntv1g; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-560880bb751so5965363e87.3
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 11:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1757443356; x=1758048156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J8rZP0b1NLEP9nh5B5JtGQ50QbKwlhESdjc7Eyq5vAc=;
        b=dxNntv1gEXI+sgnRtRLMrNz9/uV4Kvjad6YjbMzFF1eaj5i6UChVDo40pZo732XESM
         8h0Gp4E300bnXXYJFLuyay4hwICVK6Epfige1NM6O4OZJwanNG4zoixt5v5dd/ZqIJ6u
         osPorso7e/uJOthn3c8jqGrBlfXTmkNfIEAPlE6FHWew38EPUMDw6XbGoPRZMGarKWQi
         +yVrY2+iOcWVAogCXgux1uaVLTn0ca0URytEehhgWSSP2nL42gqYxrOE+KXaCA9rJaCs
         3p3erxdcC6+u6Lf0LwF2ghfEG0LQjFPO0LD/otl1igu8G/uN52Y3O3gtROsUTR4llOrF
         jKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757443356; x=1758048156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J8rZP0b1NLEP9nh5B5JtGQ50QbKwlhESdjc7Eyq5vAc=;
        b=UKP723VlxePgFZOOUh7Ax2ihmab9rho3aK7fccf/CMJ8U9gW/u9/w2Y6P2HMF53wBZ
         hY5NSSiL/z/0U51T01hW/nRiaktqy0Gft6m/E+Bwm92o/8bzVuPsXPkHXGZVIRIYJ23Y
         ftKYkoxu+py9cibIxjWRzfnHIeJ1L0y9u1eIkM3ebJTlhDq0i/iFbwN8Hfg9heQkDQjB
         CxMFeNx9PnF4EERfGEOGbomOrwfzRS8iJoHHArwATbiW4/q+99p9r+EI2nEmwG0mEKIJ
         qiV7t2w91NIjvd71cqG5KFBBlsPiCVFE16CT8UQ5iezVdVq45K3MHfduyFEWzez6pTEm
         CA5w==
X-Forwarded-Encrypted: i=1; AJvYcCVrvohpJ0YHln3h4Xjx+S8iYoYm/MRw9dX+2V2QiI+WelgLLICokGau+BP1GI0EDrMlDEcxjig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNoD6ThpnmaYH+Cs35TTw3rSBvsDNaKaWXuol48LhurdR0Mft6
	Q+htarMbQkiAFSt8DIcUac7/r7uFlDaFu9wbU7hkKjWYzeaNturTPZN158b5xzSZmpo=
X-Gm-Gg: ASbGncv0Tmuz/iDj/6sx3BvBHxMcbzHLNl1uFJp54rMGWvyVO7cjbIww4+fF/WvyT/7
	BGYSlQrico3onsEriqURIVCUOInrAz+Za6Z+GRwvgqWKbV4E1xW8/Af7LPu/6A7sWne6n2xYCpT
	X0M5z3CQHnci5inbkt33XOJ8Q3/+T5dsHo9pAjd1Ee27FMPbJoZpyJH4AXiXgofhURVmF8V1JLi
	Ivxc6iR70g7VeVIPl9WCIsflpFPzG6jkGtyEGlW7OvR6w0oxjAbmFiHuJeQKSxaojibbA9tZKHT
	zvBgqeR88W0VbhvckKq48Flya91hskAC1tWj284W5TA3WfSvT7S/OiFCDiaNq584gtdOYiAlDm/
	mb1CoCHslcQcXdV1YrF2QefxdUlxGRDW7eVuU97Iw7daN+pgiBGFawwqxmW/h6yQDhdd6BMnvWN
	zcoA==
X-Google-Smtp-Source: AGHT+IE1NBtZZVAmyV4gb5ug/BB1Xq/fLAHRZYvCfNObEPUq8f7tFjVVJrgGTzKIQs0UOvu2VhCVcg==
X-Received: by 2002:a05:6512:6404:b0:55f:44b8:1ed5 with SMTP id 2adb3069b0e04-56262e1b19emr3665532e87.39.1757443355759;
        Tue, 09 Sep 2025 11:42:35 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680cbf2612sm699152e87.45.2025.09.09.11.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 11:42:35 -0700 (PDT)
Message-ID: <aa19f9b7-7eb4-4cf2-b400-1370ef95c66e@blackwall.org>
Date: Tue, 9 Sep 2025 21:42:32 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 4/7] bonding: Processing extended
 arp_ip_target from user space.
To: David Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org
Cc: jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com, pradeep@us.ibm.com,
 i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com,
 stephen@networkplumber.org, horms@kernel.org
References: <20250904221956.779098-1-wilder@us.ibm.com>
 <20250904221956.779098-5-wilder@us.ibm.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250904221956.779098-5-wilder@us.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/25 01:18, David Wilder wrote:
> Changes to bond_netlink and bond_options to process extended
> format arp_ip_target option sent from user space via the ip
> command.
> 
> The extended format adds a list of vlan tags to the ip target address.
> 
> Signed-off-by: David Wilder <wilder@us.ibm.com>
> ---
>   drivers/net/bonding/bond_netlink.c |   5 +-
>   drivers/net/bonding/bond_options.c | 121 +++++++++++++++++++++++------
>   2 files changed, 99 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
> index a5887254ff23..28ee50ddf4e2 100644
> --- a/drivers/net/bonding/bond_netlink.c
> +++ b/drivers/net/bonding/bond_netlink.c
> @@ -291,9 +291,10 @@ static int bond_changelink(struct net_device *bond_dev, struct nlattr *tb[],
>   			if (nla_len(attr) < sizeof(target))
>   				return -EINVAL;
>   
> -			target = nla_get_be32(attr);
> +			bond_opt_initextra(&newval,
> +					   (__force void *)nla_data(attr),
> +					   nla_len(attr));
>   
> -			bond_opt_initval(&newval, (__force u64)target);
>   			err = __bond_opt_set(bond, BOND_OPT_ARP_TARGETS,
>   					     &newval,
>   					     data[IFLA_BOND_ARP_IP_TARGET],
> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
> index cf4cb301a738..61334633403d 100644
> --- a/drivers/net/bonding/bond_options.c
> +++ b/drivers/net/bonding/bond_options.c
> @@ -31,8 +31,8 @@ static int bond_option_use_carrier_set(struct bonding *bond,
>   				       const struct bond_opt_value *newval);
>   static int bond_option_arp_interval_set(struct bonding *bond,
>   					const struct bond_opt_value *newval);
> -static int bond_option_arp_ip_target_add(struct bonding *bond, __be32 target);
> -static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target);
> +static int bond_option_arp_ip_target_add(struct bonding *bond, struct bond_arp_target target);
> +static int bond_option_arp_ip_target_rem(struct bonding *bond, struct bond_arp_target target);
>   static int bond_option_arp_ip_targets_set(struct bonding *bond,
>   					  const struct bond_opt_value *newval);
>   static int bond_option_ns_ip6_targets_set(struct bonding *bond,
> @@ -1133,7 +1133,7 @@ static int bond_option_arp_interval_set(struct bonding *bond,
>   }
>   
>   static void _bond_options_arp_ip_target_set(struct bonding *bond, int slot,
> -					    __be32 target,
> +					    struct bond_arp_target target,
>   					    unsigned long last_rx)
>   {
>   	struct bond_arp_target *targets = bond->params.arp_targets;
> @@ -1143,24 +1143,25 @@ static void _bond_options_arp_ip_target_set(struct bonding *bond, int slot,
>   	if (slot >= 0 && slot < BOND_MAX_ARP_TARGETS) {
>   		bond_for_each_slave(bond, slave, iter)
>   			slave->target_last_arp_rx[slot] = last_rx;
> -		targets[slot].target_ip = target;
> +		memcpy(&targets[slot], &target, sizeof(target));
>   	}
>   }
>   
> -static int _bond_option_arp_ip_target_add(struct bonding *bond, __be32 target)
> +static int _bond_option_arp_ip_target_add(struct bonding *bond, struct bond_arp_target target)
>   {
>   	struct bond_arp_target *targets = bond->params.arp_targets;
> +	char pbuf[BOND_OPTION_STRING_MAX_SIZE];
>   	int ind;
>   
> -	if (!bond_is_ip_target_ok(target)) {
> +	if (!bond_is_ip_target_ok(target.target_ip)) {
>   		netdev_err(bond->dev, "invalid ARP target %pI4 specified for addition\n",
> -			   &target);
> +			   &target.target_ip);
>   		return -EINVAL;
>   	}
>   
> -	if (bond_get_targets_ip(targets, target) != -1) { /* dup */
> +	if (bond_get_targets_ip(targets, target.target_ip) != -1) { /* dup */
>   		netdev_err(bond->dev, "ARP target %pI4 is already present\n",
> -			   &target);
> +			   &target.target_ip);
>   		return -EINVAL;
>   	}
>   
> @@ -1170,43 +1171,44 @@ static int _bond_option_arp_ip_target_add(struct bonding *bond, __be32 target)
>   		return -EINVAL;
>   	}
>   
> -	netdev_dbg(bond->dev, "Adding ARP target %pI4\n", &target);
> +	netdev_dbg(bond->dev, "Adding ARP target %s\n",
> +		   bond_arp_target_to_string(&target, pbuf, sizeof(pbuf)));
>   
>   	_bond_options_arp_ip_target_set(bond, ind, target, jiffies);
>   
>   	return 0;
>   }
>   
> -static int bond_option_arp_ip_target_add(struct bonding *bond, __be32 target)
> +static int bond_option_arp_ip_target_add(struct bonding *bond, struct bond_arp_target target)
>   {
>   	return _bond_option_arp_ip_target_add(bond, target);
>   }
>   
> -static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target)
> +static int bond_option_arp_ip_target_rem(struct bonding *bond, struct bond_arp_target target)
>   {
>   	struct bond_arp_target *targets = bond->params.arp_targets;
> +	unsigned long *targets_rx;
>   	struct list_head *iter;
>   	struct slave *slave;
> -	unsigned long *targets_rx;
>   	int ind, i;
>   
> -	if (!bond_is_ip_target_ok(target)) {
> +	if (!bond_is_ip_target_ok(target.target_ip)) {
>   		netdev_err(bond->dev, "invalid ARP target %pI4 specified for removal\n",
> -			   &target);
> +			   &target.target_ip);
>   		return -EINVAL;
>   	}
>   
> -	ind = bond_get_targets_ip(targets, target);
> +	ind = bond_get_targets_ip(targets, target.target_ip);
>   	if (ind == -1) {
>   		netdev_err(bond->dev, "unable to remove nonexistent ARP target %pI4\n",
> -			   &target);
> +			   &target.target_ip);
>   		return -EINVAL;
>   	}
>   
>   	if (ind == 0 && !targets[1].target_ip && bond->params.arp_interval)
>   		netdev_warn(bond->dev, "Removing last arp target with arp_interval on\n");
>   
> -	netdev_dbg(bond->dev, "Removing ARP target %pI4\n", &target);
> +	netdev_dbg(bond->dev, "Removing ARP target %pI4\n", &target.target_ip);
>   
>   	bond_for_each_slave(bond, slave, iter) {
>   		targets_rx = slave->target_last_arp_rx;
> @@ -1214,30 +1216,77 @@ static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target)
>   			targets_rx[i] = targets_rx[i+1];
>   		targets_rx[i] = 0;
>   	}
> -	for (i = ind; (i < BOND_MAX_ARP_TARGETS - 1) && targets[i + 1].target_ip; i++)
> -		targets[i] = targets[i+1];
> +
> +	bond_free_vlan_tag(&targets[ind]);
> +
> +	for (i = ind; (i < BOND_MAX_ARP_TARGETS - 1) && targets[i + 1].target_ip; i++) {
> +		targets[i].target_ip = targets[i + 1].target_ip;
> +		targets[i].tags = targets[i + 1].tags;
> +		targets[i].flags = targets[i + 1].flags;
> +	}
>   	targets[i].target_ip = 0;
> +	targets[i].flags = 0;
> +	targets[i].tags = NULL;

This looks wrong, bond_free_vlan_tag() is kfree(tags) and then it is set to NULL but
these tags can be used with only RCU held (change is in patch 05) in a few places, there is
no synchronization and nothing to keep that code from either a use-after-free or a null
ptr dereference.

Check bond_loadbalance_arp_mon -> bond_send_validate.

>   
>   	return 0;
>   }
>   
>   void bond_option_arp_ip_targets_clear(struct bonding *bond)
>   {
> +	struct bond_arp_target empty_target;

empty_target = {} ...

>   	int i;
>   
> +	empty_target.target_ip = 0;
> +	empty_target.flags = 0;
> +	empty_target.tags = NULL;

... and you can drop these lines

> +
>   	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++)
> -		_bond_options_arp_ip_target_set(bond, i, 0, 0);
> +		_bond_options_arp_ip_target_set(bond, i, empty_target, 0);
> +}
> +
> +/**
> + * bond_validate_tags - validate an array of bond_vlan_tag.
> + * @tags: the array to validate
> + * @len: the length in bytes of @tags
> + *
> + * Validate that @tags points to a valid array of struct bond_vlan_tag.
> + * Returns: the length of the validated bytes in the array or -1 if no
> + * valid list is found.
> + */
> +static int bond_validate_tags(struct bond_vlan_tag *tags, size_t len)
> +{
> +	size_t i, ntags = 0;
> +
> +	if (len == 0 || !tags)
> +		return 0;
> +
> +	for (i = 0; i <= len; i = i + sizeof(struct bond_vlan_tag)) {
> +		if (ntags > BOND_MAX_VLAN_TAGS)
> +			break;
> +
> +		if (tags->vlan_proto == BOND_VLAN_PROTO_NONE)
> +			return i + sizeof(struct bond_vlan_tag);

You suppose that there is at least sizeof(struct bond_vlan_tag) in tags
but there shouldn't be, it could be target_ip + 1 byte and here you will
be out of bounds.

> +> +		if (tags->vlan_id > 4094)

vlan tag 0 is invalid as well, and this should be using the vlan definitions
e.g. !tags->vlan_id || tags->vlan_id >= VLAN_VID_MASK

> +			break;
> +		tags++;
> +		ntags++;
> +	}
> +	return -1;
>   }
>   
>   static int bond_option_arp_ip_targets_set(struct bonding *bond,
>   					  const struct bond_opt_value *newval)
>   {
> -	int ret = -EPERM;
> -	__be32 target;
> +	size_t len = (size_t)newval->extra_len;
> +	char *extra = (char *)newval->extra;
> +	struct bond_arp_target target;
> +	int size, ret = -EPERM;
>   
>   	if (newval->string) {
> +		/* Adding or removing arp_ip_target from sysfs */
>   		if (strlen(newval->string) < 1 ||
> -		    !in4_pton(newval->string + 1, -1, (u8 *)&target, -1, NULL)) {
> +		    !in4_pton(newval->string + 1, -1, (u8 *)&target.target_ip, -1, NULL)) {
>   			netdev_err(bond->dev, "invalid ARP target specified\n");
>   			return ret;
>   		}
> @@ -1248,7 +1297,29 @@ static int bond_option_arp_ip_targets_set(struct bonding *bond,
>   		else
>   			netdev_err(bond->dev, "no command found in arp_ip_targets file - use +<addr> or -<addr>\n");
>   	} else {
> -		target = newval->value;
> +		/* Adding arp_ip_target from netlink. aka: ip command */
> +		if (len < sizeof(target.target_ip)) {

this check is redundant, we already validate it has at least sizeof(__be32) in bond_changelink()

> +			netdev_err(bond->dev, "invalid ARP target specified\n");
> +			return ret;
> +		}
> +		memcpy(&target.target_ip, newval->extra, sizeof(__be32));
> +		len = len - sizeof(target.target_ip);
> +		extra = extra + sizeof(target.target_ip);

len could be < sizeof(struct bond_vlan_tag), e.g. it could be 1
(see above my comment about tags len)

> +
> +		size = bond_validate_tags((struct bond_vlan_tag *)extra, len);
> +
> +		if (size > 0) {
> +			target.tags = kmalloc((size_t)size, GFP_ATOMIC);
> +			if (!target.tags)
> +				return -ENOMEM;
> +			memcpy(target.tags, extra, size);
> +			target.flags |= BOND_TARGET_USERTAGS;
> +		}

else if (size == -1)

> +
> +		if (size == -1)
> +			netdev_warn(bond->dev, "Invalid list of vlans provided with %pI4\n",
> +				    &target.target_ip);
> +
>   		ret = bond_option_arp_ip_target_add(bond, target);


I don't see target.tags freed if bond_option_arp_ip_target_add() results in an error.




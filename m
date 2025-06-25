Return-Path: <netdev+bounces-200890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17627AE73EA
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 02:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26FF1922501
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 00:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0B47261E;
	Wed, 25 Jun 2025 00:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sl8Vksed"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF72978F32;
	Wed, 25 Jun 2025 00:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750812174; cv=none; b=iYzZBV4AoBp4qsn0w64NfnLeOowZ9tKlgcN/3FKxgldxpMz9SnKc05H4c8Ko6icd7maiOzQic1YXyxOuBoLsYlQ/MsBSP9J4/upz6Y6eBd9xk8lOiLEC2VL+HL8+51KfbKZYHNWdX953Bk4Ah6kMWPrgWb8Aufz7ubIIly+kBjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750812174; c=relaxed/simple;
	bh=sQkxeHTipZS4vmVmOQzJQQdgbKms1hiJGF6GNURpkKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N470v/0uO49yPTEnCt8jp9wDeIxwXh0CHjMxbjmit6yBqs2eSigdszwE/1GLWrJnb8qszI3+gDXWMPcTC3AWFoDD2VgJDOMvOq+FpheR8Yrfp5nITqAPz+d8lWxZcIe/hnUpilre3kBVeHHwM6yCYAFs5f84SF0y+bwNvf8Ma3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sl8Vksed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FE3C4CEE3;
	Wed, 25 Jun 2025 00:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750812174;
	bh=sQkxeHTipZS4vmVmOQzJQQdgbKms1hiJGF6GNURpkKA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sl8Vksed3lrAB6mMEzjEIQJDhjqf+SnWdQZdno7Tj+Df7vIqvfBxlN6bBaq3kt30r
	 ViBko3rtYeQb53LCf9HdaDXmuacVMITb8YBfGwpiX91A6XswgXxEO1IepjxZUdkUxG
	 XMUvNWbedHsLLugAOARQQv4OrDfjMO5SscyYYwdzTXnS50fMKAqwWEzoFahDiccugi
	 myqVYon+SfxAzdzA+kBXbdt03znMeewPw//7SDAZ2tQiWSFULByf504rIXvlmX72Z0
	 ricK7FMzbcrooF+Ph3TKVAcRKzneck5+ueNC36kPvxiwGeDXZGXh0F4j+4cTaBojRA
	 Hd2d4JePlpRhA==
Date: Tue, 24 Jun 2025 17:42:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dong Chenchen <dongchenchen2@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <jiri@resnulli.us>, <oscmaes92@gmail.com>,
 <linux@treblig.org>, <pedro.netdev@dondevamos.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>
Subject: Re: [PATCH net] net: vlan: fix VLAN 0 refcount imbalance of
 toggling filtering during runtime
Message-ID: <20250624174252.7fbd3dbe@kernel.org>
In-Reply-To: <20250623113008.695446-1-dongchenchen2@huawei.com>
References: <20250623113008.695446-1-dongchenchen2@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Jun 2025 19:30:08 +0800 Dong Chenchen wrote:
> $ ip link add bond0 type bond mode 0
> $ ip link add link bond0 name vlan0 type vlan id 0 protocol 802.1q
> $ ethtool -K bond0 rx-vlan-filter off
> $ ifconfig bond0 up
> $ ethtool -K bond0 rx-vlan-filter on
> $ ifconfig bond0 down
> $ ifconfig bond0 up
> $ ip link del vlan0

Please try to figure out the reasonable combinations in which we can
change the flags and bring the device up and down. Create a selftest
in bash and add it under tools/testing/selftests/net

> diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
> index 06908e37c3d9..6e01ece0a95c 100644
> --- a/net/8021q/vlan.c
> +++ b/net/8021q/vlan.c
> @@ -504,12 +504,21 @@ static int vlan_device_event(struct notifier_block *unused, unsigned long event,
>  		break;
>  
>  	case NETDEV_CVLAN_FILTER_PUSH_INFO:
> +		flgs = dev_get_flags(dev);

Why call dev_get_flags()? You can test dev->flags & IFF_UP directly

> +		if (flgs & IFF_UP) {
> +			pr_info("adding VLAN 0 to HW filter on device %s\n",
> +				dev->name);
> +			vlan_vid_add(dev, htons(ETH_P_8021Q), 0);

Not sure if this works always, because if we have no vlan at all when
the device comes up vlan_info will be NULL and we won't even get here.

IIUC adding vlan 0 has to be handled early, where UP is handled.

> +		}
>  		err = vlan_filter_push_vids(vlan_info, htons(ETH_P_8021Q));
>  		if (err)
>  			return notifier_from_errno(err);
>  		break;
>  
>  	case NETDEV_CVLAN_FILTER_DROP_INFO:
> +		flgs = dev_get_flags(dev);
> +		if (flgs & IFF_UP)
> +			vlan_vid_del(dev, htons(ETH_P_8021Q), 0);
>  		vlan_filter_drop_vids(vlan_info, htons(ETH_P_8021Q));
-- 
pw-bot: cr


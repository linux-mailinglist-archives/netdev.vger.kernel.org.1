Return-Path: <netdev+bounces-76264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C5586D095
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 18:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02B81F24AA3
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 17:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81906CC0E;
	Thu, 29 Feb 2024 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="DE1lsnvO"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE936CBF0
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 17:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227629; cv=pass; b=tAr4vxIsNH4kUTC257RUC4tSfqolaJ6ggi6fa8/tDl1KNGHzgMmkK/axzSWJmKWAiSk/S3pRYVEXfLBjGvpjqaUOcn14xW3RJ+EvCY6SaDVu/FdfhV30hC8XTtWlwOscVIuA0PmKK7+YFI/B83SyQzv+RWVmF8pkU5wZjX/fqeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227629; c=relaxed/simple;
	bh=Xg+MJ8L5Wyk9mdNUeKLSknJ7KJytxvMqUzEycS6TtSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nP76NTcei8KmDxr1QmvJvAMmf2fioSfgMlD94+0Qjqto0BKX8Yh6CHB9HYjqDn+fbjum9fVa2dLUx6aLedoH+sTq4/0mRmkHSa3zCsAKUKpyzQfIinef1OkDlgzp8o8IV/ZzaGALkNspSrQ2sSu+WYr9PHf48YanK3LlFvjd8d0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=DE1lsnvO; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1709227618; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EE0WvGElZX+qbl81w3N6DUVTY0EiRZ+fJn3VgvOS9USR2XUPWZpxWkYeMJ02Qf0eEo0SFopIBghMXtkwYmTkIyH5E4V8tFSWmk+dMUJqfC+QJ+nsTC6RMaSetrdKU+R9BxnD1S9T5WZAZlJEnJ+5pAtJpe9b9VHHbQkUp320SC8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1709227618; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GNjVmWHd4p1FnV/Y3Nr5HOQNpCQcatCjqUhq3AfwOYE=; 
	b=kjfgHQvfRut/pgjQEydOxlS5KUVi7KApE5PAvlhtBD/XpNxRU3mXhVIqmzpGubjg0oy3GAp7AotQQiL4Ve4OlQshGDyCF9E5PSGfbQG7dPkqUtLV/Wd4Ufyn2QCJneoTuS5c8OhJMgkXoMArCDUyLtElHt8Tc57UFJl8lzwLLuQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1709227618;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=GNjVmWHd4p1FnV/Y3Nr5HOQNpCQcatCjqUhq3AfwOYE=;
	b=DE1lsnvOVXVirr1364k4Ppkt0U4ckdQkSzxrekZ4Rl67mgojs/QlQ23qpGrJI/s+
	njgsv1s2TBph9RnWa6FFpGJ+kux/yk049XkGBznwj/zF7tbfJqoaR/M8qv/1eJtX+HY
	5URRekLIM0xhF5FqlOJldUWMjzsEnmuYxewin2gRaijokTyWhOuh1rEKYzsTKb2RK3K
	jYKzkq8pNbx7hqliFBgMYI0dGJ4aSNjS26Yms291svY+vx0CfX7KvOquFv9h5DNGlWX
	J/+HCaUII1ZGhi0wV3kXP1yjDyiAdLa9MrFoz0y2v8m+EYNc93kJYnqQqI8kZIg9xzi
	sRIn6W/Xrw==
Received: from [192.168.5.82] (public-gprs530213.centertel.pl [31.61.190.102]) by mx.zohomail.com
	with SMTPS id 1709227615487357.20380883369444; Thu, 29 Feb 2024 09:26:55 -0800 (PST)
Message-ID: <466f225c-bedc-421c-86d6-60efac7acfef@machnikowski.net>
Date: Thu, 29 Feb 2024 18:26:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 4/5] netdevsim: add selftest for forwarding skb
 between connected ports
Content-Language: en-US
To: David Wei <dw@davidwei.uk>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 horms@kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240228232253.2875900-1-dw@davidwei.uk>
 <20240228232253.2875900-5-dw@davidwei.uk>
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <20240228232253.2875900-5-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 29/02/2024 00:22, David Wei wrote:
> Connect two netdevsim ports in different namespaces together, then send
> packets between them using socat.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  .../selftests/drivers/net/netdevsim/Makefile  |   1 +
>  .../selftests/drivers/net/netdevsim/peer.sh   | 143 ++++++++++++++++++
>  2 files changed, 144 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer.sh
> 
> diff --git a/tools/testing/selftests/drivers/net/netdevsim/Makefile b/tools/testing/selftests/drivers/net/netdevsim/Makefile
> index 7a29a05bea8b..5bace0b7fb57 100644
> --- a/tools/testing/selftests/drivers/net/netdevsim/Makefile
> +++ b/tools/testing/selftests/drivers/net/netdevsim/Makefile
> @@ -10,6 +10,7 @@ TEST_PROGS = devlink.sh \
>  	fib.sh \
>  	hw_stats_l3.sh \
>  	nexthop.sh \
> +	peer.sh \
>  	psample.sh \
>  	tc-mq-visibility.sh \
>  	udp_tunnel_nic.sh \
> diff --git a/tools/testing/selftests/drivers/net/netdevsim/peer.sh b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
> new file mode 100755
> index 000000000000..aed62d9e6c0a
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
> @@ -0,0 +1,143 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +source ../../../net/net_helper.sh
> +
> +NSIM_DEV_1_ID=$((256 + RANDOM % 256))
> +NSIM_DEV_1_SYS=/sys/bus/netdevsim/devices/netdevsim$NSIM_DEV_1_ID
> +NSIM_DEV_2_ID=$((512 + RANDOM % 256))
> +NSIM_DEV_2_SYS=/sys/bus/netdevsim/devices/netdevsim$NSIM_DEV_2_ID
> +
> +NSIM_DEV_SYS_NEW=/sys/bus/netdevsim/new_device
> +NSIM_DEV_SYS_DEL=/sys/bus/netdevsim/del_device
> +NSIM_DEV_SYS_LINK=/sys/bus/netdevsim/link_device
> +NSIM_DEV_SYS_UNLINK=/sys/bus/netdevsim/unlink_device
> +
> +socat_check()
> +{
> +	if [ ! -x "$(command -v socat)" ]; then
> +		echo "socat command not found. Skipping test"
> +		return 1
> +	fi
> +
> +	return 0
> +}
> +
> +setup_ns()
> +{
> +	set -e
> +	ip netns add nssv
> +	ip netns add nscl
> +
> +	NSIM_DEV_1_NAME=$(find $NSIM_DEV_1_SYS/net -maxdepth 1 -type d ! \
> +		-path $NSIM_DEV_1_SYS/net -exec basename {} \;)
> +	NSIM_DEV_2_NAME=$(find $NSIM_DEV_2_SYS/net -maxdepth 1 -type d ! \
> +		-path $NSIM_DEV_2_SYS/net -exec basename {} \;)
> +
> +	ip link set $NSIM_DEV_1_NAME netns nssv
> +	ip link set $NSIM_DEV_2_NAME netns nscl
> +
> +	ip netns exec nssv ip addr add '192.168.1.1/24' dev $NSIM_DEV_1_NAME
> +	ip netns exec nscl ip addr add '192.168.1.2/24' dev $NSIM_DEV_2_NAME
> +
> +	ip netns exec nssv ip link set dev $NSIM_DEV_1_NAME up
> +	ip netns exec nscl ip link set dev $NSIM_DEV_2_NAME up
> +	set +e
> +}
> +
> +cleanup_ns()
> +{
> +	ip netns del nscl
> +	ip netns del nssv
> +}
> +
> +###
> +### Code start
> +###
> +
> +socat_check || exit 4
> +
> +modprobe netdevsim
> +
> +# linking
> +
> +echo $NSIM_DEV_1_ID > $NSIM_DEV_SYS_NEW
> +echo $NSIM_DEV_2_ID > $NSIM_DEV_SYS_NEW
> +udevadm settle
> +
> +setup_ns
> +
> +NSIM_DEV_1_FD=$((256 + RANDOM % 256))
> +exec {NSIM_DEV_1_FD}</var/run/netns/nssv
> +NSIM_DEV_1_IFIDX=$(ip netns exec nssv cat /sys/class/net/$NSIM_DEV_1_NAME/ifindex)
> +
> +NSIM_DEV_2_FD=$((256 + RANDOM % 256))
> +exec {NSIM_DEV_2_FD}</var/run/netns/nscl
> +NSIM_DEV_2_IFIDX=$(ip netns exec nscl cat /sys/class/net/$NSIM_DEV_2_NAME/ifindex)
> +
> +echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:2000" > $NSIM_DEV_SYS_LINK 2>/dev/null
> +if [ $? -eq 0 ]; then
> +	echo "linking with non-existent netdevsim should fail"
> +	cleanup_ns
> +	exit 1
> +fi
> +
> +echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX 2000:$NSIM_DEV_2_IFIDX" > $NSIM_DEV_SYS_LINK 2>/dev/null
> +if [ $? -eq 0 ]; then
> +	echo "linking with non-existent netnsid should fail"
> +	cleanup_ns
> +	exit 1
> +fi
> +
> +echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX" > $NSIM_DEV_SYS_LINK 2>/dev/null
> +if [ $? -eq 0 ]; then
> +	echo "linking with self should fail"
> +	cleanup_ns
> +	exit 1
> +fi
> +
> +echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:$NSIM_DEV_2_IFIDX" > $NSIM_DEV_SYS_LINK
> +if [ $? -ne 0 ]; then
> +	echo "linking netdevsim1 with netdevsim2 should succeed"
> +	cleanup_ns
> +	exit 1
> +fi
> +
> +# argument error checking
> +
> +echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:a" > $NSIM_DEV_SYS_LINK 2>/dev/null
> +if [ $? -eq 0 ]; then
> +	echo "invalid arg should fail"
> +	cleanup_ns
> +	exit 1
> +fi
> +
> +# send/recv packets
> +
> +tmp_file=$(mktemp)
> +ip netns exec nssv socat TCP-LISTEN:1234,fork $tmp_file &
> +pid=$!
> +res=0
> +
> +wait_local_port_listen nssv 1234 tcp
> +
> +echo "HI" | ip netns exec nscl socat STDIN TCP:192.168.1.1:1234
> +
> +count=$(cat $tmp_file | wc -c)
> +if [[ $count -ne 3 ]]; then
> +	echo "expected 3 bytes, got $count"
> +	res=1
> +fi
> +
> +echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX" > $NSIM_DEV_SYS_UNLINK
> +
> +echo $NSIM_DEV_2_ID > $NSIM_DEV_SYS_DEL
> +
> +kill $pid
> +echo $NSIM_DEV_1_ID > $NSIM_DEV_SYS_DEL
> +
> +cleanup_ns
> +
> +modprobe -r netdevsim
> +
> +exit $res

Reviewed-by: Maciek Machnikowski <maciek@machnikowski.net>


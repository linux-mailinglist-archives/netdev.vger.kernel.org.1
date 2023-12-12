Return-Path: <netdev+bounces-56583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E6380F7EC
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 21:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405C0282055
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 20:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6189963C1B;
	Tue, 12 Dec 2023 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9gobhbf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4565763C11
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 20:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C61C433C7;
	Tue, 12 Dec 2023 20:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702412977;
	bh=msSCeA8YNuYhmkjZ3lbzSEV9WWadnTg5nSpnxpoeWeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D9gobhbfM+nIOKEBsi5aE3xriCB0eGKLE1GvoWGLWCb/mDBRYJ13gvTWpfdO2plk3
	 d9n1x+Y044aqk9/89xQl+xK2HKDTlBWVTgseEIiNOO0y+HvyHPFS7Qb8NAtAZMFCeC
	 TqGu424nSDGWIDjpY3GVQzA2KK3nfe1Aa6EXLgUN8odBVIxKHUwWA7u9y51yrgHUVl
	 9vAUDzvERqV9tXpLKZ+Qm6uhQ6c6VUyjeetmjCaVhFeeplGxCy5TiUjkHtOUGV133A
	 S4sVIepodBYEp7M6P8Lzrxl8N1NXQHH9szT5VDq9DvhehdwDy0tv7EN2IgJN0nRY0g
	 hqn1JVz7QWrZg==
Date: Tue, 12 Dec 2023 12:29:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 3/3] netdevsim: add selftest for forwarding
 skb between connected ports
Message-ID: <20231212122935.4e23dd08@kernel.org>
In-Reply-To: <20231210010448.816126-4-dw@davidwei.uk>
References: <20231210010448.816126-1-dw@davidwei.uk>
	<20231210010448.816126-4-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  9 Dec 2023 17:04:48 -0800 David Wei wrote:
> From: David Wei <davidhwei@meta.com>
> 
> Connect two netdevsim ports in different namespaces together, then send
> packets between them using socat.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  .../selftests/drivers/net/netdevsim/peer.sh   | 111 ++++++++++++++++++
>  1 file changed, 111 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer.sh

You need to include this script in the Makefile so it gets run

> diff --git a/tools/testing/selftests/drivers/net/netdevsim/peer.sh b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
> new file mode 100755
> index 000000000000..d1d59a932174
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
> @@ -0,0 +1,111 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +NSIM_DEV_SYS=/sys/bus/netdevsim
> +NSIM_DEV_DFS=/sys/kernel/debug/netdevsim/netdevsim
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
> +	ip link set eni1np1 netns nssv
> +	ip link set eni2np1 netns nscl

This assumes you have systemd renaming interfaces.
I can find out what the netdev is called from sysfs.
After you create the nsim device in its sysfs dir
there will be a dir "net" and in it you'll have
a subdir with the same name as the netdev.

> +	ip netns exec nssv ip addr add '192.168.1.1/24' dev eni1np1
> +	ip netns exec nscl ip addr add '192.168.1.2/24' dev eni2np1
> +
> +	ip netns exec nssv ip link set dev eni1np1 up
> +	ip netns exec nscl ip link set dev eni2np1 up
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
> +modprobe netdevsim
> +
> +# linking
> +
> +echo 1 > ${NSIM_DEV_SYS}/new_device

Use $RANDOM to generate a random device ID.

> +echo "2 0" > ${NSIM_DEV_DFS}1/ports/0/peer 2>/dev/null
> +if [ $? -eq 0 ]; then
> +	echo "linking with non-existent netdevsim should fail"
> +	exit 1
> +fi
> +
> +echo 2 > /sys/bus/netdevsim/new_device
> +
> +echo "2 0" > ${NSIM_DEV_DFS}1/ports/0/peer
> +if [ $? -ne 0 ]; then
> +	echo "linking netdevsim1 port0 with netdevsim2 port0 should succeed"
> +	exit 1
> +fi
> +
> +# argument error checking
> +
> +echo "2 1" > ${NSIM_DEV_DFS}1/ports/0/peer 2>/dev/null
> +if [ $? -eq 0 ]; then
> +	echo "linking with non-existent port in a netdevsim should fail"
> +	exit 1
> +fi
> +
> +echo "1 0" > ${NSIM_DEV_DFS}1/ports/0/peer 2>/dev/null
> +if [ $? -eq 0 ]; then
> +	echo "linking with self should fail"
> +	exit 1
> +fi
> +
> +echo "2 a" > ${NSIM_DEV_DFS}1/ports/0/peer 2>/dev/null
> +if [ $? -eq 0 ]; then
> +	echo "invalid arg should fail"
> +	exit 1
> +fi
> +
> +# send/recv packets
> +
> +socat_check || exit 1

There's a magic return value for skipping kselftests, 1 means fail.
-- 
pw-bot: cr


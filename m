Return-Path: <netdev+bounces-188400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A2FAACA72
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 18:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999F7525B9D
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 16:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A609284673;
	Tue,  6 May 2025 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NggBylv4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64877284663
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746547678; cv=none; b=iZcGWBYxWCxOwO4jNMJcUCAcYqZHySATelVkVrx4vPK1QVABQukauKf75BeNfVm3UYNTibeLy6eaTqPhk6E4GBaAq+hErK7kV7EiXSZ0jkBcirUnGGGY+VwL7XY5W4b209JnKSLCNnWqzXfwnB+PWXTukjg+gecoaJfURcNP878=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746547678; c=relaxed/simple;
	bh=fwhyVDiVmOPviMujIj3jD6wk57AXXjZMsLH5fjNqIb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHzAnp4WwgLh65IJgSOveBnJVXRkekUBk+mbANu2CWa7pU1Ajxxr7z1UsODmfkpgIRtU2V4ljXHlmE5HOSPx5ClTMbUU3gp3aCX3jtqJkJg3jUmCNnuKnWarMlsrthpEQEOUeOpLJbGlxAFxRlGZS4FFFJLeEHU7Qr92Wekt904=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NggBylv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16CBC4CEE4;
	Tue,  6 May 2025 16:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746547677;
	bh=fwhyVDiVmOPviMujIj3jD6wk57AXXjZMsLH5fjNqIb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NggBylv4YQFtK9jIb/RLDZNDMWCf4v3QHL9Ht8S6lGta2h82b7WnOwmoRWRzivVt+
	 1zUf5EywJIDFjAgPq9hPLet9CkUIjaycihq6Mr0QaVPtXfj9hl1+V/pM2DElci44yu
	 rI9LBSw9CUut7is+bn0D9m9sk5Y0U/M/WbenWu0tG2Wyu0Cil0MejXKWQ9N9qcyqSS
	 rDVUymTh/+7xCwm6LHuuEFUzoAdxUCCGWBTJzt+8o2gSPBSvWjaENWtsqqziSc1yso
	 hEA2QvtnCs9COXy4wWnVcpe+A/IQU6OJzU9uli4jJHxfvjErNLSWbgCZk4/gFuue0h
	 lEZaKYuY/ktkg==
Date: Tue, 6 May 2025 17:07:53 +0100
From: Simon Horman <horms@kernel.org>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	syzbot+e76d52dadc089b9d197f@syzkaller.appspotmail.com,
	syzbot+1065a199625a388fce60@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: mctp: Don't access ifa_index when missing
Message-ID: <20250506160753.GU3339421@horms.kernel.org>
References: <20250505-mctp-addr-dump-v1-1-a997013f99b8@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505-mctp-addr-dump-v1-1-a997013f99b8@codeconstruct.com.au>

On Mon, May 05, 2025 at 05:05:12PM +0800, Matt Johnston wrote:
> In mctp_dump_addrinfo, ifa_index can be used to filter interfaces, but
> only when the struct ifaddrmsg is provided. Otherwise it will be
> comparing to uninitialised memory - reproducible in the syzkaller case from
> dhcpd, or busybox "ip addr show".
> 
> The kernel MCTP implementation has always filtered by ifa_index, so
> existing userspace programs expecting to dump MCTP addresses must
> already be passing a valid ifa_index value (either 0 or a real index).
> 
> BUG: KMSAN: uninit-value in mctp_dump_addrinfo+0x208/0xac0 net/mctp/device.c:128
>  mctp_dump_addrinfo+0x208/0xac0 net/mctp/device.c:128
>  rtnl_dump_all+0x3ec/0x5b0 net/core/rtnetlink.c:4380
>  rtnl_dumpit+0xd5/0x2f0 net/core/rtnetlink.c:6824
>  netlink_dump+0x97b/0x1690 net/netlink/af_netlink.c:2309
> 
> Fixes: 583be982d934 ("mctp: Add device handling and netlink interface")
> Reported-by: syzbot+e76d52dadc089b9d197f@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68135815.050a0220.3a872c.000e.GAE@google.com/
> Reported-by: syzbot+1065a199625a388fce60@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/681357d6.050a0220.14dd7d.000d.GAE@google.com/
> Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>

Thanks Matt,

FWIIW, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  net/mctp/device.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mctp/device.c b/net/mctp/device.c
> index 8e0724c56723de328592bfe5c6fc8085cd3102fe..7780acdb99dedca1cd6a17e4d6bf917c7f7f370f 100644
> --- a/net/mctp/device.c
> +++ b/net/mctp/device.c
> @@ -117,11 +117,17 @@ static int mctp_dump_addrinfo(struct sk_buff *skb, struct netlink_callback *cb)
>  	struct net_device *dev;
>  	struct ifaddrmsg *hdr;
>  	struct mctp_dev *mdev;
> -	int ifindex, rc;
> +	int ifindex = 0, rc;
>  
> -	hdr = nlmsg_data(cb->nlh);
> -	// filter by ifindex if requested
> -	ifindex = hdr->ifa_index;
> +	/* Filter by ifindex if a header is provided */
> +	if (cb->nlh->nlmsg_len >= nlmsg_msg_size(sizeof(*hdr))) {
> +		hdr = nlmsg_data(cb->nlh);

FWIIW, I think the scope of the declaration of hdr can be reduced to this block.
(Less positive ease, so to speak.)

> +		/* Userspace programs providing AF_MCTP must be expecting ifa_index filter
> +		 * behaviour, as will those setting strict_check.
> +		 */
> +		if (hdr->ifa_family == AF_MCTP || cb->strict_check)
> +			ifindex = hdr->ifa_index;
> +	}
>  
>  	rcu_read_lock();
>  	for_each_netdev_dump(net, dev, mcb->ifindex) {
> 
> ---
> base-commit: ebd297a2affadb6f6f4d2e5d975c1eda18ac762d
> change-id: 20250505-mctp-addr-dump-673e0fdc7894
> 
> Best regards,
> -- 
> Matt Johnston <matt@codeconstruct.com.au>
> 


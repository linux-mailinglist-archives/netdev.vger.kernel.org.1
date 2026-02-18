Return-Path: <netdev+bounces-259197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI6DKxoxlWmeMwIAu9opvQ
	(envelope-from <netdev+bounces-259197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 04:25:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B32E152D96
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 04:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AC313033ABF
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 03:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8BC2E9730;
	Wed, 18 Feb 2026 03:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIw044kx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881462D738E
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 03:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771385049; cv=none; b=N8KOAQ3kZ6odEqEMQ8SzyC2UAl9rB3TlUskEZi+dDIwLg9RPLgi7wOYwv7XQgahWoXtO+KYYByu9iFemOJvRVLKUK3TxY5ggnptkdunFeG3D76ceUfsKoutem66T/ZQXjwy0ySF87AseKwH+uRQP9KhBM9ZwNaJDzAJBZEJeJAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771385049; c=relaxed/simple;
	bh=fG54kZ+6MPq1Ul9AOByxq5qVkMX1F72oNHQvOsP6cVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BhUfzTby0xiRWZYWlYxyYPlJWlfQAUh6G9Bm3b0wFN8cqc8tr/rXiVpXokZfhsXJqRW4EgsBgUJehisFf6MsdS/+AD9QaZG5oQKttglQwcyAADPvk1w6SWQaZ/hRmkADvMIrHEEqBFcyhlUInRKX8wYztQkx68GPORbYJgqhobU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIw044kx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB03C4CEF7;
	Wed, 18 Feb 2026 03:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771385049;
	bh=fG54kZ+6MPq1Ul9AOByxq5qVkMX1F72oNHQvOsP6cVo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZIw044kxc//XR/ZTvm6F30x0bHrJDsouZyBvKzxuoWZ0ji7pjj9Jb9aFOivEnY4up
	 2QIX3MbsIk56Bw2pcOQHtDQGW03VsoiLjMlIxfoDAO8cUzlJK5b8ASpbZGCs9t9jUH
	 Eysdo3EGku9dtfust4QH4fC7tohool3RRHfSvXCpUSW01xWBCdwZWEopxqE+lfJUlL
	 ndLnNNziIELXrGQfsNmsrKkrmSTD9ogWRpQBPPCpbybdr4WHTiBY6w6+uWCPqRrbkW
	 ujtH1vILLHikjgfZ8IXThsS1FS17n/QZmCc2XXAHpjIUMhletUwkSLxcsELv/RXKEp
	 Kz6vQWtDpRzMg==
Message-ID: <a9197cec-d406-4201-98d4-a06820b220f3@kernel.org>
Date: Tue, 17 Feb 2026 20:24:08 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2] ip/netns: avoid redundant mounts
Content-Language: en-US
To: me@black-desk.cn, Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>
References: <20260210-netns-redundant-mount-v1-1-0b1ebfc1c79f@black-desk.cn>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260210-netns-redundant-mount-v1-1-0b1ebfc1c79f@black-desk.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259197-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,black-desk.cn:email]
X-Rspamd-Queue-Id: 0B32E152D96
X-Rspamd-Action: no action

On 2/9/26 9:11 PM, Chen Linxuan via B4 Relay wrote:
> From: Chen Linxuan <me@black-desk.cn>
> 
> On Ubuntu 24.04, I observed redundant mounts after adding a netns with
> the commands below:
> 
> 	sudo ip netns add xxx
> 	cat /proc/self/mountinfo | grep /run
> 
> Output:
> 
> 	29 31 0:26 / /run rw,nosuid,nodev,noexec,relatime shared:5 - tmpfs tmpfs ...
> 	...
> 	203 29 0:26 /netns /run/netns rw,nosuid,nodev,noexec,relatime shared:5 - tmpfs tmpfs ...
> 	6443 203 0:4 net:[4026533578] /run/netns/xxx rw shared:917 - nsfs nsfs rw
> 	6444 29 0:4 net:[4026533578] /run/netns/xxx rw shared:917 - nsfs nsfs rw

with this patch I am still seeing 2 entries:

$ sudo ./ip netns add blah
$ cat /proc/self/mountinfo  | grep blah
337 92 0:4 net:[4026532418] /run/netns/blah rw shared:344 - nsfs nsfs rw
338 28 0:4 net:[4026532418] /run/netns/blah rw shared:344 - nsfs nsfs rw

...

> diff --git a/ip/ipnetns.c b/ip/ipnetns.c
> index a20cd8bc7cb8..3a33a3adacee 100644
> --- a/ip/ipnetns.c
> +++ b/ip/ipnetns.c
> @@ -846,6 +846,20 @@ static int netns_add(int argc, char **argv, bool create)
>  			}
>  			return -1;
>  		}
> +
> +		/* Reconfigure NETNS_RUN_DIR to MS_PRIVATE recursively and later
> +		 * MS_SAHRED again to make sure it is placed in a new peer group
> +		 */
> +		if (mount(NETNS_RUN_DIR, NETNS_RUN_DIR, "none", MS_PRIVATE | MS_REC, NULL)) {

line is rather long. please limit line length to about 80 columns except
for print strings like the next line.

> +			fprintf(stderr, "mount --make-private %s failed: %s\n",
> +				NETNS_RUN_DIR, strerror(errno));
> +			if (lock != -1) {
> +				flock(lock, LOCK_UN);
> +				close(lock);
> +			}
> +			return -1;
> +		}
> +
>  		made_netns_run_dir_mount = 1;
>  	}
>  	if (lock != -1) {
> 
> ---
> base-commit: 72f679c0d07629fe9e462c2c52bbe48aaeaa7f83
> change-id: 20260210-netns-redundant-mount-aa2db50eac7d
> 
> Best regards,



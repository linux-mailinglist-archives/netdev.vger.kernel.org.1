Return-Path: <netdev+bounces-67340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D87842DB4
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 21:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0E51C226FC
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 20:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D024F71B4B;
	Tue, 30 Jan 2024 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtIC7mMf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE7069E14
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 20:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706646414; cv=none; b=C1VIScvvmptn0xdgaykEsoOLuVfmazXrasGSr8GGv9CzKvEqu5eVlpKmCbpUVYtrUg8/SJbtz74EDYD6HPOGtNhUd001EWEmbQ75aoGY0VY1SdWRMNT1PfP87R+S9KfDD4y1Wl5LjjZlufMvxSy4/OMNbZQTCpr72sxGw7YtVao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706646414; c=relaxed/simple;
	bh=KuTmKyvCKc/JzV7yLDBEVAywdYQYYiHwg6FUaoKHR9I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=aEQwtrWUm1ppq7gcGRBW41kftPtlOZj8yiOiHBHEQe7ELVPE7XOUvpImWIK9oju0f/WFzi4t5YBIu9UdpPBDGM0r0+kPmjuF5wnnbHzJwPAGw4TOzLZr9xaHndlLpG9H5VkaEa8K8TKeuemSUA7sbegrl9hvmAbphUDXK0fMJok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtIC7mMf; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3beb1d4d872so122082b6e.2
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 12:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706646412; x=1707251212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbTJjKCrOfDgTy9smq7m24U8CMjAHxM02Wx3bo7/ZAA=;
        b=GtIC7mMfKfwxazY0g26q//xdqZzes9RAkCYdT3CBMyPHrCSN3O6OOKuTr0XXKNfsof
         jCkMedKxKDACs6dqU61PHvXNKJFScdjxQceczYGDWK6BrmrRypFhY9LL2t/yyVQGazup
         NZhs2NeW8z8XJ07HIPTuFIjdU5ISdSnu/U37uYzKE2wfYaXsIXdsYxjsAYwmYxZ6yrqM
         crjNMj/EYXk3MPQY/Y8bvdwwI2g4pDVWO8Jw6yghphDBsFJkJJYUtSMmvfQoNJq6ffTQ
         yvIx8R/2DnInfh7MxL+Z2tgZAl2yVIH+4EWn8b8LvRt+9QWo2Ny+MRv9a95GmzrfqS4n
         C+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706646412; x=1707251212;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kbTJjKCrOfDgTy9smq7m24U8CMjAHxM02Wx3bo7/ZAA=;
        b=Vyi74t/93vW+TIZhIwgjUKues1NvYAHYBDBJ/7g8jXKtC26nNzusdHlDkojMPg94P3
         vv6hRfTgL2xY1s38+IQIcixQ6BN/Wg5Vd/Y4JGAIXSGwy7QD5IAF7W21oFjUmrPIRaST
         emBGSXixVdn4JCSA/XzbBPTr5zlGmK9TN/x/GA3SvUfeXnvx+8rttr1cYBULMoLvARKY
         886Sp+WYearqgHDUAAOOCC13iF38UHkWO2hKtZBrFrpsCDUnXnVkHK2YXKMVcuOXFDlc
         atwSemPtMgDfeqKQUH1aRvwu6J6+oFT875l2avCMlNMG8DfzgcCdmcNBgemJznLGFDBg
         StDA==
X-Gm-Message-State: AOJu0YxNtrZL7I7MX1QH1vY5zYcqKDn54QgNhBFWqbTHdiaBOb4jW+dX
	PyM19rZR7mU5eRCQ1FfX06cSsqaBwCo36p9JK6Hn58F4qhvUYMoa
X-Google-Smtp-Source: AGHT+IGErMPVqryARc+ypYYa6CsfppsSKWQVv3v+CIQOp/QRyBr1CrmzM7TpHUs/xSGdi6woOB763Q==
X-Received: by 2002:a05:6870:d0c2:b0:218:4755:559b with SMTP id k2-20020a056870d0c200b002184755559bmr8099044oaa.7.1706646411905;
        Tue, 30 Jan 2024 12:26:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVa114iTK3tFQmxPj+H1jrSOUV+WNAI2ihbK9JBtYldvfV1t2yr12OhJijOgAUABSvf9paxdo0NNo0TJkP4dj1T6fOUKJLlUyIGbhl2J4YgFXSsHeJpJ09NSDht0w2uDAHDyR6z+d2UiaXRacSu34rVLvu1tm+RnWXHVBCyMHXdaZ09cw3hh8A5rLQCd74USNWoMX3FT8gatbegNTMI5rNbSeBngj0FQTLexNmvWV+H
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id m18-20020a05622a119200b0042a882de47fsm4284216qtk.41.2024.01.30.12.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 12:26:51 -0800 (PST)
Date: Tue, 30 Jan 2024 15:26:51 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 kernel-team@cloudflare.com
Message-ID: <65b95b8b3e4d0_ce3aa29444@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240130131422.135965-1-jakub@cloudflare.com>
References: <20240130131422.135965-1-jakub@cloudflare.com>
Subject: Re: [PATCH net-next] selftests: udpgso: Pull up network setup into
 shell script
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Sitnicki wrote:
> udpgso regression test configures routing and device MTU directly through
> uAPI (Netlink, ioctl) to do its job. While there is nothing wrong with it,
> it takes more effort than doing it from shell.
> 
> Looking forward, we would like to extend the udpgso regression tests to
> cover the EIO corner case [1], once it gets addressed. That will require a
> dummy device and device feature manipulation to set it up. Which means more
> Netlink code.
> 
> So, in preparation, pull out network configuration into the shell script
> part of the test, so it is easily extendable in the future.
> 
> Also, because it now easy to setup routing, add a second local IPv6
> address. Because the second address is not managed by the kernel, we can
> "replace" the corresponding local route with a reduced-MTU one. This
> unblocks the disabled "ipv6 connected" test case. Add a similar setup for
> IPv4 for symmetry.

Nice!

Just a few small nits.

> 
> [1] https://lore.kernel.org/netdev/87jzqsld6q.fsf@cloudflare.com/
> 
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>  tools/testing/selftests/net/udpgso.c  | 134 ++------------------------
>  tools/testing/selftests/net/udpgso.sh |  50 ++++++++--
>  2 files changed, 48 insertions(+), 136 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
> index 7badaf215de2..79fd3287ff60 100644
> --- a/tools/testing/selftests/net/udpgso.c
> +++ b/tools/testing/selftests/net/udpgso.c
> @@ -56,7 +56,6 @@ static bool		cfg_do_msgmore;
>  static bool		cfg_do_setsockopt;
>  static int		cfg_specific_test_id = -1;
>  
> -static const char	cfg_ifname[] = "lo";
>  static unsigned short	cfg_port = 9000;
>  
>  static char buf[ETH_MAX_MTU];
> @@ -69,8 +68,13 @@ struct testcase {
>  	int r_len_last;		/* recv(): size of last non-mss dgram, if any */
>  };
>  
> -const struct in6_addr addr6 = IN6ADDR_LOOPBACK_INIT;
> -const struct in_addr addr4 = { .s_addr = __constant_htonl(INADDR_LOOPBACK + 2) };
> +const struct in6_addr addr6 = {
> +	{ { 0x20, 0x01, 0x0d, 0xb8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x00, 0x01 } },
> +};
> +
> +const struct in_addr addr4 = {
> +	__constant_htonl(0xc0000201), /* 192.0.2.1 */
> +};

Prefer an address from a private range?

>  struct testcase testcases_v4[] = {
>  	{
> @@ -274,48 +278,6 @@ struct testcase testcases_v6[] = {
>  	}
>  };
>  
> -static unsigned int get_device_mtu(int fd, const char *ifname)
> -{
> -	struct ifreq ifr;
> -
> -	memset(&ifr, 0, sizeof(ifr));
> -
> -	strcpy(ifr.ifr_name, ifname);
> -
> -	if (ioctl(fd, SIOCGIFMTU, &ifr))
> -		error(1, errno, "ioctl get mtu");
> -
> -	return ifr.ifr_mtu;
> -}
> -
> -static void __set_device_mtu(int fd, const char *ifname, unsigned int mtu)
> -{
> -	struct ifreq ifr;
> -
> -	memset(&ifr, 0, sizeof(ifr));
> -
> -	ifr.ifr_mtu = mtu;
> -	strcpy(ifr.ifr_name, ifname);
> -
> -	if (ioctl(fd, SIOCSIFMTU, &ifr))
> -		error(1, errno, "ioctl set mtu");
> -}
> -
> -static void set_device_mtu(int fd, int mtu)
> -{
> -	int val;
> -
> -	val = get_device_mtu(fd, cfg_ifname);
> -	fprintf(stderr, "device mtu (orig): %u\n", val);
> -
> -	__set_device_mtu(fd, cfg_ifname, mtu);
> -	val = get_device_mtu(fd, cfg_ifname);
> -	if (val != mtu)
> -		error(1, 0, "unable to set device mtu to %u\n", val);
> -
> -	fprintf(stderr, "device mtu (test): %u\n", val);
> -}
> -
>  static void set_pmtu_discover(int fd, bool is_ipv4)
>  {
>  	int level, name, val;
> @@ -354,81 +316,6 @@ static unsigned int get_path_mtu(int fd, bool is_ipv4)
>  	return mtu;
>  }
>  
> -/* very wordy version of system("ip route add dev lo mtu 1500 127.0.0.3/32") */
> -static void set_route_mtu(int mtu, bool is_ipv4)
> -{
> -	struct sockaddr_nl nladdr = { .nl_family = AF_NETLINK };
> -	struct nlmsghdr *nh;
> -	struct rtattr *rta;
> -	struct rtmsg *rt;
> -	char data[NLMSG_ALIGN(sizeof(*nh)) +
> -		  NLMSG_ALIGN(sizeof(*rt)) +
> -		  NLMSG_ALIGN(RTA_LENGTH(sizeof(addr6))) +
> -		  NLMSG_ALIGN(RTA_LENGTH(sizeof(int))) +
> -		  NLMSG_ALIGN(RTA_LENGTH(0) + RTA_LENGTH(sizeof(int)))];
> -	int fd, ret, alen, off = 0;
> -
> -	alen = is_ipv4 ? sizeof(addr4) : sizeof(addr6);
> -
> -	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
> -	if (fd == -1)
> -		error(1, errno, "socket netlink");
> -
> -	memset(data, 0, sizeof(data));
> -
> -	nh = (void *)data;
> -	nh->nlmsg_type = RTM_NEWROUTE;
> -	nh->nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE;
> -	off += NLMSG_ALIGN(sizeof(*nh));
> -
> -	rt = (void *)(data + off);
> -	rt->rtm_family = is_ipv4 ? AF_INET : AF_INET6;
> -	rt->rtm_table = RT_TABLE_MAIN;
> -	rt->rtm_dst_len = alen << 3;
> -	rt->rtm_protocol = RTPROT_BOOT;
> -	rt->rtm_scope = RT_SCOPE_UNIVERSE;
> -	rt->rtm_type = RTN_UNICAST;
> -	off += NLMSG_ALIGN(sizeof(*rt));
> -
> -	rta = (void *)(data + off);
> -	rta->rta_type = RTA_DST;
> -	rta->rta_len = RTA_LENGTH(alen);
> -	if (is_ipv4)
> -		memcpy(RTA_DATA(rta), &addr4, alen);
> -	else
> -		memcpy(RTA_DATA(rta), &addr6, alen);
> -	off += NLMSG_ALIGN(rta->rta_len);
> -
> -	rta = (void *)(data + off);
> -	rta->rta_type = RTA_OIF;
> -	rta->rta_len = RTA_LENGTH(sizeof(int));
> -	*((int *)(RTA_DATA(rta))) = 1; //if_nametoindex("lo");
> -	off += NLMSG_ALIGN(rta->rta_len);
> -
> -	/* MTU is a subtype in a metrics type */
> -	rta = (void *)(data + off);
> -	rta->rta_type = RTA_METRICS;
> -	rta->rta_len = RTA_LENGTH(0) + RTA_LENGTH(sizeof(int));
> -	off += NLMSG_ALIGN(rta->rta_len);
> -
> -	/* now fill MTU subtype. Note that it fits within above rta_len */
> -	rta = (void *)(((char *) rta) + RTA_LENGTH(0));
> -	rta->rta_type = RTAX_MTU;
> -	rta->rta_len = RTA_LENGTH(sizeof(int));
> -	*((int *)(RTA_DATA(rta))) = mtu;
> -
> -	nh->nlmsg_len = off;
> -
> -	ret = sendto(fd, data, off, 0, (void *)&nladdr, sizeof(nladdr));
> -	if (ret != off)
> -		error(1, errno, "send netlink: %uB != %uB\n", ret, off);
> -
> -	if (close(fd))
> -		error(1, errno, "close netlink");
> -
> -	fprintf(stderr, "route mtu (test): %u\n", mtu);
> -}
> -

Oh no, my handcrafted artisanal netlink code!

Yeah, concise shell commands are a better model.

>  static bool __send_one(int fd, struct msghdr *msg, int flags)
>  {
>  	int ret;
> @@ -591,15 +478,10 @@ static void run_test(struct sockaddr *addr, socklen_t alen)
>  	/* Do not fragment these datagrams: only succeed if GSO works */
>  	set_pmtu_discover(fdt, addr->sa_family == AF_INET);
>  
> -	if (cfg_do_connectionless) {
> -		set_device_mtu(fdt, CONST_MTU_TEST);
> +	if (cfg_do_connectionless)
>  		run_all(fdt, fdr, addr, alen);
> -	}
>  
>  	if (cfg_do_connected) {
> -		set_device_mtu(fdt, CONST_MTU_TEST + 100);
> -		set_route_mtu(CONST_MTU_TEST, addr->sa_family == AF_INET);
> -
>  		if (connect(fdt, addr, alen))
>  			error(1, errno, "connect");
>  
> diff --git a/tools/testing/selftests/net/udpgso.sh b/tools/testing/selftests/net/udpgso.sh
> index fec24f584fe9..d7fb71e132bb 100755
> --- a/tools/testing/selftests/net/udpgso.sh
> +++ b/tools/testing/selftests/net/udpgso.sh
> @@ -3,27 +3,57 @@
>  #
>  # Run a series of udpgso regression tests
>  
> +set -o errexit
> +set -o nounset
> +# set -o xtrace

Leftover debug comment?

> +
> +setup_loopback() {
> +  ip addr add dev lo 192.0.2.1/32
> +  ip addr add dev lo 2001:db8::1/128 nodad noprefixroute
> +}
> +
> +test_dev_mtu() {
> +  setup_loopback
> +  # Reduce loopback MTU
> +  ip link set dev lo mtu 1500
> +}
> +
> +test_route_mtu() {
> +  setup_loopback
> +  # Remove default local routes
> +  ip route del local 192.0.2.1/32 table local dev lo
> +  ip route del local 2001:db8::1/128 table local dev lo
> +  # Install local routes with reduced MTU
> +  ip route add local 192.0.2.1/32 table local dev lo mtu 1500
> +  ip route add local 2001:db8::1/128 table local dev lo mtu 1500

ip route change?

> +}
> +
> +if [ "$#" -gt 0 ]; then
> +  "$1"
> +  shift 2 # pop "test_*" function arg and "--" delimiter
> +  exec "$@"
> +fi
> +
>  echo "ipv4 cmsg"
> -./in_netns.sh ./udpgso -4 -C
> +./in_netns.sh "$0" test_dev_mtu -- ./udpgso -4 -C
>  
>  echo "ipv4 setsockopt"
> -./in_netns.sh ./udpgso -4 -C -s
> +./in_netns.sh "$0" test_dev_mtu -- ./udpgso -4 -C -s
>  
>  echo "ipv6 cmsg"
> -./in_netns.sh ./udpgso -6 -C
> +./in_netns.sh "$0" test_dev_mtu -- ./udpgso -6 -C
>  
>  echo "ipv6 setsockopt"
> -./in_netns.sh ./udpgso -6 -C -s
> +./in_netns.sh "$0" test_dev_mtu -- ./udpgso -6 -C -s
>  
>  echo "ipv4 connected"
> -./in_netns.sh ./udpgso -4 -c
> +./in_netns.sh "$0" test_route_mtu -- ./udpgso -4 -c
>  
> -# blocked on 2nd loopback address
> -# echo "ipv6 connected"
> -# ./in_netns.sh ./udpgso -6 -c
> +echo "ipv6 connected"
> +./in_netns.sh "$0" test_route_mtu -- ./udpgso -6 -c
>  
>  echo "ipv4 msg_more"
> -./in_netns.sh ./udpgso -4 -C -m
> +./in_netns.sh "$0" test_dev_mtu -- ./udpgso -4 -C -m
>  
>  echo "ipv6 msg_more"
> -./in_netns.sh ./udpgso -6 -C -m
> +./in_netns.sh "$0" test_dev_mtu -- ./udpgso -6 -C -m
> -- 
> 2.43.0
> 




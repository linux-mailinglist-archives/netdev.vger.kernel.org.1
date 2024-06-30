Return-Path: <netdev+bounces-107951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF4591D2A5
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 18:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3DA1C20833
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 16:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5219E14532C;
	Sun, 30 Jun 2024 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="hbpqLbhf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25E35B1E0
	for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719764599; cv=none; b=LgwYTzqOyxnXWLnxwrwSSUqizztYMAtjmfqrja4BVq3lHgduob9oEII7US6d9tRSsC0DG2i+CbNV7602mwyAvmIJS/CD4/fItvPQe6Soib+FjLfmr0T8HBk4zkAo1ATE04MHoVvtQVqLAt+kg89DgAlsHBPNLAEAIMMkaEanD1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719764599; c=relaxed/simple;
	bh=6Mst8rKuQjLyMrdljnyQxlYvwuLh6UAFNlWO+zJvNLw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWbRhIopk1VdP2BugTG1/cI+rvKV5iXjADwNq77Na06d1V6MwnNAAGZ0pVjf/e0RxE0t32DzN/GOD4lQhBgzplwR9Vilrv7bo5uI+dxHioCxKGH3tBxNbyayUGBAEDaP+/ZKgjj7RG6D4X8GB/JAj8//Mz4mMpQ8HFGCYVbQEzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=hbpqLbhf; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-725a7b0fc55so1188444a12.3
        for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 09:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1719764596; x=1720369396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUvHQaHB8KQazWjFNTbpd2HsHhF2Zs2Xvp8bhfQPGIU=;
        b=hbpqLbhf3RT2V9wrTDbCVyJaNl4VXA8NWwWLEdc8LzliVjaHFhulmsBr5CErK3wS2n
         f6OJj+COfU1+c3DU2HHkIIoSn3KVEiA9PR+PgzLFhlEtj5xMSD0Tl9CKtc2eCJRAKppw
         /+wmFc83wa0OyzKmaYAJDAhb4e53XiB1iybXKGl6rmutj9lVPr5xDOO+sSum37Rm4D95
         Hpi23Mt5OZQOKsoxEWvdgR7mxodApPsqp316Pittr7HjWqs0cAJHs5sAqb47PchKi8RX
         y29lzCiLNbD1g8qTXUlQ57wL/i3C3/A4c4dz9KrZn1G/sIR9EpCOfLFWxs3y1ijQimrg
         e+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719764596; x=1720369396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUvHQaHB8KQazWjFNTbpd2HsHhF2Zs2Xvp8bhfQPGIU=;
        b=FRi0qkbVXD/jPXvDJ3d+o5ZsyHDjLO6XOsLTRA2JUyIPan26Zlmqict+SGzo0HSjSf
         PpxfX1VkA3pCh3+DEYi62E6lfApmuccg++4A1dBVNW2AyamK+q4xJDb3IEZYYh1GlRrj
         Cj31e6qwF25OcLYCRqOspM1qoxiXDU1vShvckZ+1j/LjomExr2fLVBq0MU+0yHzja8LV
         CETUPuOvZkcqDr8P7NN4tykA9ezCqLiP0ARH0nFvVNXpfRbMjQVYvqCceloZi9rJC28X
         DYNVeIP3yXKbLphELAuGuhmY4VoJk+CeTV+zaMGJs33FtGJE4r4iF3VHEnwgo2Wk9UgW
         JA+A==
X-Forwarded-Encrypted: i=1; AJvYcCXz7PdS5fH1vIdLqYqcRciNRVmGUa4vnY53Jl9MA+XxpaAKyr1Zy/ZllF14HL7PzJiGobC3/s+LjjJf7cRjDYV4K+HgKUw7
X-Gm-Message-State: AOJu0YzmGX6ylqar7vlE/HTK6kuL+Ih72a6+Xjd20wRWA89tfVtazly5
	Uk+w+rt31ceVsP3dQcJOZRTcL4ytitDWjoS2wrgc1TrAmxxPuBIgaimeBvYMe14=
X-Google-Smtp-Source: AGHT+IHZ3FyZQHD6iSQwq2m8Zca7uZaP5ZWlPyV2m4MBC/PY6qoz6LPt9aFnmyLboIPZHzfieqI93A==
X-Received: by 2002:a05:6a20:3948:b0:1be:cdce:9fb7 with SMTP id adf61e73a8af0-1bef613f429mr3013811637.19.1719764596032;
        Sun, 30 Jun 2024 09:23:16 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1538dc2sm48133985ad.170.2024.06.30.09.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 09:23:15 -0700 (PDT)
Date: Sun, 30 Jun 2024 09:23:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ido Schimmel <idosch@idosch.org>
Cc: "Muggeridge, Matt" <matt.muggeridge2@hpe.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: "ip route show dev enp0s9" does not show all routes for enp0s9
Message-ID: <20240630092308.0288083a@hermes.local>
In-Reply-To: <ZoE15-y0wMhzQEYg@shredder.mtl.com>
References: <SJ0PR84MB2088DCBDCCCD49FFB9DFFBAAD8D02@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
	<20240627193632.5ea88216@hermes.local>
	<SJ0PR84MB20889120746B75792B83693CD8D02@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
	<ZoE15-y0wMhzQEYg@shredder.mtl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Jun 2024 13:39:35 +0300
Ido Schimmel <idosch@idosch.org> wrote:

> On Fri, Jun 28, 2024 at 02:54:58AM +0000, Muggeridge, Matt wrote:
> > > From: Stephen Hemminger <stephen@networkplumber.org>
> > > Sent: Friday, June 28, 2024 12:37 PM
> > > 
> > > On Fri, 28 Jun 2024 00:01:47 +0000
> > > "Muggeridge, Matt" <matt.muggeridge2@hpe.com> wrote:
> > >   
> > > > Hi,
> > > >
> > > > This looks like a problem in "iproute2".  This was observed on a fresh install  
> > > of Ubuntu 24.04, with Linux 6.8.0-36-generic.  
> > > >
> > > > NOTE: I first raised this in  
> > > https://bugs.launchpad.net/ubuntu/+source/iproute2/+bug/2070412, then
> > > later found https://github.com/iproute2/iproute2/blob/main/README.devel.  
> > > >
> > > > * PROBLEM
> > > > Compare the outputs:
> > > >
> > > > $ ip -6 route show dev enp0s9
> > > > 2001:2:0:1000::/64 proto ra metric 1024 expires 65518sec pref medium
> > > > fe80::/64 proto kernel metric 256 pref medium
> > > >
> > > > $ ip -6 route
> > > > 2001:2:0:1000::/64 dev enp0s9 proto ra metric 1024 expires 65525sec
> > > > pref medium
> > > > fe80::/64 dev enp0s3 proto kernel metric 256 pref medium
> > > > fe80::/64 dev enp0s9 proto kernel metric 256 pref medium default proto
> > > > ra metric 1024 expires 589sec pref medium  nexthop via
> > > > fe80::200:10ff:fe10:1060 dev enp0s9 weight 1  nexthop via
> > > > fe80::200:10ff:fe10:1061 dev enp0s9 weight 1
> > > >
> > > > The default route is associated with enp0s9, yet the first command above  
> > > does not show it.  
> > > >
> > > > FWIW, the two default route entries were created by two separate routers  
> > > on the network, each sending their RA.  
> > > >
> > > > * REPRODUCER
> > > > Statically Configure systemd-networkd with two route entries, similar to the  
> > > following:  
> > > >
> > > > $ networkctl cat 10-enp0s9.network
> > > > # /etc/systemd/network/10-enp0s9.network
> > > > [Match]
> > > > Name=enp0s9
> > > >
> > > > [Link]
> > > > RequiredForOnline=no
> > > >
> > > > [Network]
> > > > Description="Internal Network: Private VM-to-VM IPv6 interface"
> > > > DHCP=no
> > > > LLDP=no
> > > > EmitLLDP=no
> > > >
> > > >
> > > > # /etc/systemd/network/10-enp0s9.network.d/address.conf
> > > > [Network]
> > > > Address=2001:2:0:1000:a00:27ff:fe5f:f72d/64
> > > >
> > > >
> > > > # /etc/systemd/network/10-enp0s9.network.d/route-1060.conf
> > > > [Route]
> > > > Gateway=fe80::200:10ff:fe10:1060
> > > > GatewayOnLink=true
> > > >
> > > >
> > > > # /etc/systemd/network/10-enp0s9.network.d/route-1061.conf
> > > > [Route]
> > > > Gateway=fe80::200:10ff:fe10:1061
> > > > GatewayOnLink=true
> > > >
> > > >
> > > >
> > > > Now reload and reconfigure the interface and you will see two routes.
> > > >
> > > > $ networkctl reload
> > > > $ networkctl reconfigure enp0s9
> > > > $ ip -6 r
> > > > $ ip -6 r show dev enp0s9 # the routes are not shown
> > > >  
> > > 
> > > "Don't blame the messenger", the ip command only reports what the kernel
> > > sends. So it is likely a route semantics issue in the kernel.  
> > 
> > Thanks Stephen.
> > 
> > Ok, I have reported it on my distro in https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2071406.
> > 
> > I guess the kernel netdev folks will see this thread and can comment too?  
> 
> The problem seems to be in iproute2 and not in the kernel. Both IPv4 and
> IPv6 will dump the route if at least one of the nexthop devices is the
> one specified by user space. You can see the routes in the strace output
> below.
> 
> ip link add name dummy1 up type dummy
> ip link add name dummy2 up type dummy
> ip address add 192.0.2.1/28 dev dummy1
> ip address add 192.0.2.17/28 dev dummy2
> ip addres add 2001:db8:1::1/64 dev dummy1
> ip addres add 2001:db8:2::1/64 dev dummy2
> ip route add 198.51.100.0/24 nexthop via 192.0.2.2 dev dummy1 nexthop via 192.0.2.18 dev dummy2
> ip route add 2001:db8:10::/64 nexthop via 2001:db8:1::2 dev dummy1 nexthop via 2001:db8:2::2 dev dummy2
> 
> # strace -e network ip -4 route show dev dummy1
> [...]
> recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=[[{nlmsg_len=60, nlmsg_type=RTM_NEWROUTE, nlmsg_flags=NLM_F_MULTI|NLM_F_DUMP_FILTERED, nlmsg_seq=1719737009, nlmsg_pid=704}, {rtm_family=AF_INET, rtm_dst_len=28, rtm_src_len=0, rtm_tos=0, rtm_table=RT_TABLE_MAIN, rtm_protocol=RTPROT_KERNEL, rtm_scope=RT_SCOPE_LINK, rtm_type=RTN_UNICAST, rtm_flags=0}, [[{nla_len=8, nla_type=RTA_TABLE}, RT_TABLE_MAIN], [{nla_len=8, nla_type=RTA_DST}, inet_addr("192.0.2.0")], [{nla_len=8, nla_type=RTA_PREFSRC}, inet_addr("192.0.2.1")], [{nla_len=8, nla_type=RTA_OIF}, if_nametoindex("dummy1")]]], [{nlmsg_len=80, nlmsg_type=RTM_NEWROUTE, nlmsg_flags=NLM_F_MULTI|NLM_F_DUMP_FILTERED, nlmsg_seq=1719737009, nlmsg_pid=704}, {rtm_family=AF_INET, rtm_dst_len=24, rtm_src_len=0, rtm_tos=0, rtm_table=RT_TABLE_MAIN, rtm_protocol=RTPROT_BOOT, rtm_scope=RT_SCOPE_UNIVERSE, rtm_type=RTN_UNICAST, rtm_flags=0}, [[{nla_len=8, nla_type=RTA_TABLE}, RT_TABLE_MAIN], 
 [{nla_len=8, nla_type=RTA_DST}, inet_addr("198.51.100.0")], [{nla_len=36, nla_type=RTA_MULTIPATH}, [[{rtnh_len=16, rtnh_flags=0, rtnh_hops=0, rtnh_ifindex=if_nametoindex("dummy1")}, [{nla_len=8, nla_type=RTA_GATEWAY}, inet_addr("192.0.2.2")]], [{rtnh_len=16, rtnh_flags=0, rtnh_hops=0, rtnh_ifindex=if_nametoindex("dummy2")}, [{nla_len=8, nla_type=RTA_GATEWAY}, inet_addr("192.0.2.18")]]]]]]], iov_len=32768}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 140
> 
> # strace -e network ip -6 route show dev dummy1
> [...]
> recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=[[{nlmsg_len=116, nlmsg_type=RTM_NEWROUTE, nlmsg_flags=NLM_F_MULTI|NLM_F_DUMP_FILTERED, nlmsg_seq=1719737009, nlmsg_pid=708}, {rtm_family=AF_INET6, rtm_dst_len=64, rtm_src_len=0, rtm_tos=0, rtm_table=RT_TABLE_MAIN, rtm_protocol=RTPROT_KERNEL, rtm_scope=RT_SCOPE_UNIVERSE, rtm_type=RTN_UNICAST, rtm_flags=0}, [[{nla_len=8, nla_type=RTA_TABLE}, RT_TABLE_MAIN], [{nla_len=20, nla_type=RTA_DST}, inet_pton(AF_INET6, "2001:db8:1::")], [{nla_len=8, nla_type=RTA_PRIORITY}, 256], [{nla_len=8, nla_type=RTA_OIF}, if_nametoindex("dummy1")], [{nla_len=36, nla_type=RTA_CACHEINFO}, {rta_clntref=0, rta_lastuse=0, rta_expires=0, rta_error=0, rta_used=0, rta_id=0, rta_ts=0, rta_tsage=0}], [{nla_len=5, nla_type=RTA_PREF}, 0]]], [{nlmsg_len=168, nlmsg_type=RTM_NEWROUTE, nlmsg_flags=NLM_F_MULTI|NLM_F_DUMP_FILTERED, nlmsg_seq=1719737009, nlmsg_pid=708}, {rtm_family=AF_INET6, rtm_dst_len=64, rtm_src
 _len=0, rtm_tos=0, rtm_table=RT_TABLE_MAIN, rtm_protocol=RTPROT_BOOT, rtm_scope=RT_SCOPE_UNIVERSE, rtm_type=RTN_UNICAST, rtm_flags=0}, [[{nla_len=8, nla_type=RTA_TABLE}, RT_TABLE_MAIN], [{nla_len=20, nla_type=RTA_DST}, inet_pton(AF_INET6, "2001:db8:10::")], [{nla_len=8, nla_type=RTA_PRIORITY}, 1024], [{nla_len=60, nla_type=RTA_MULTIPATH}, [[{rtnh_len=28, rtnh_flags=0, rtnh_hops=0, rtnh_ifindex=if_nametoindex("dummy1")}, [{nla_len=20, nla_type=RTA_GATEWAY}, inet_pton(AF_INET6, "2001:db8:1::2")]], [{rtnh_len=28, rtnh_flags=0, rtnh_hops=0, rtnh_ifindex=if_nametoindex("dummy2")}, [{nla_len=20, nla_type=RTA_GATEWAY}, inet_pton(AF_INET6, "2001:db8:2::2")]]]], [{nla_len=36, nla_type=RTA_CACHEINFO}, {rta_clntref=0, rta_lastuse=0, rta_expires=0, rta_error=0, rta_used=0, rta_id=0, rta_ts=0, rta_tsage=0}], [{nla_len=5, nla_type=RTA_PREF}, 0]]], [{nlmsg_len=116, nlmsg_type=RTM_NEWROUTE, nlmsg_flags=NLM_F_MULTI|NLM_F_DUMP_FILTERED, nlmsg_seq=1719737009, nlmsg_pid=708}, {rtm_family=AF_INET6, rtm_
 dst_len=64, rtm_src_len=0, rtm_tos=0, rtm_table=RT_TABLE_MAIN, rtm_protocol=RTPROT_KERNEL, rtm_scope=RT_SCOPE_UNIVERSE, rtm_type=RTN_UNICAST, rtm_flags=0}, [[{nla_len=8, nla_type=RTA_TABLE}, RT_TABLE_MAIN], [{nla_len=20, nla_type=RTA_DST}, inet_pton(AF_INET6, "fe80::")], [{nla_len=8, nla_type=RTA_PRIORITY}, 256], [{nla_len=8, nla_type=RTA_OIF}, if_nametoindex("dummy1")], [{nla_len=36, nla_type=RTA_CACHEINFO}, {rta_clntref=0, rta_lastuse=0, rta_expires=0, rta_error=0, rta_used=0, rta_id=0, rta_ts=0, rta_tsage=0}], [{nla_len=5, nla_type=RTA_PREF}, 0]]]], iov_len=32768}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 400
> 
> Following patch works for me [1], but it is missing support for
> RTA_GATEWAY which is also present in the RTA_MULTIPATH nest.
> 
> [1]
> diff --git a/ip/iproute.c b/ip/iproute.c
> index b53046116826..3999853a1455 100644
> --- a/ip/iproute.c
> +++ b/ip/iproute.c
> @@ -310,12 +310,28 @@ static int filter_nlmsg(struct nlmsghdr *n, struct rtattr **tb, int host_len)
>  			return 0;
>  	}
>  	if (filter.oifmask) {
> -		int oif = 0;
> +		if (tb[RTA_OIF]) {
> +			int oif = rta_getattr_u32(tb[RTA_OIF]);
>  
> -		if (tb[RTA_OIF])
> -			oif = rta_getattr_u32(tb[RTA_OIF]);
> -		if ((oif^filter.oif)&filter.oifmask)
> -			return 0;
> +			if ((oif ^ filter.oif) & filter.oifmask)
> +				return 0;
> +		} else if (tb[RTA_MULTIPATH]) {
> +			const struct rtnexthop *nh = RTA_DATA(tb[RTA_MULTIPATH]);
> +			int len = RTA_PAYLOAD(tb[RTA_MULTIPATH]);
> +			bool dev_match = false;
> +
> +			while (len >= sizeof(*nh)) {
> +				if (nh->rtnh_ifindex == filter.oif) {
> +					dev_match = true;
> +					break;
> +				}
> +
> +				len -= NLMSG_ALIGN(nh->rtnh_len);
> +				nh = RTNH_NEXT(nh);
> +			}
> +			if (!dev_match)
> +				return 0;
> +		}
>  	}
>  	if (filter.markmask) {
>  		int mark = 0;


Good catch, original code did not handle multipath in filtering.

Suggest moving the loop into helper function for clarity

diff --git a/ip/iproute.c b/ip/iproute.c
index b5304611..44666240 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -154,6 +154,24 @@ static int flush_update(void)
 	return 0;
 }
 
+static bool filter_multipath(const struct rtattr *rta)
+{
+	const struct rtnexthop *nh = RTA_DATA(rta);
+	int len = RTA_PAYLOAD(rta);
+
+	while (len >= sizeof(*nh)) {
+		if (nh->rtnh_len > len)
+			break;
+
+		if (!((nh->rtnh_ifindex ^ filter.oif) & filter.oifmask))
+			return true;
+
+		len -= NLMSG_ALIGN(nh->rtnh_len);
+		nh = RTNH_NEXT(nh);
+	}
+	return false;
+}
+
 static int filter_nlmsg(struct nlmsghdr *n, struct rtattr **tb, int host_len)
 {
 	struct rtmsg *r = NLMSG_DATA(n);
@@ -310,12 +328,15 @@ static int filter_nlmsg(struct nlmsghdr *n, struct rtattr **tb, int host_len)
 			return 0;
 	}
 	if (filter.oifmask) {
-		int oif = 0;
+		if (tb[RTA_OIF]) {
+			int oif = rta_getattr_u32(tb[RTA_OIF]);
 
-		if (tb[RTA_OIF])
-			oif = rta_getattr_u32(tb[RTA_OIF]);
-		if ((oif^filter.oif)&filter.oifmask)
-			return 0;
+			if ((oif ^ filter.oif) & filter.oifmask)
+				return 0;
+		} else if (tb[RTA_MULTIPATH]) {
+			if (!filter_multipath(tb[RTA_MULTIPATH]))
+				return 0;
+		}
 	}
 	if (filter.markmask) {
 		int mark = 0;



Return-Path: <netdev+bounces-214321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A525B29006
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 20:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8521C81138
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 18:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A221EDA2C;
	Sat, 16 Aug 2025 18:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="emSOrkNn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055C41922FA
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 18:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755367517; cv=none; b=CtpXpV6byPlG2DCYRKxxRjQLtxPnHBEcHTua8cw/FYddKlLXrFi9ixQ9F3r2cExOLpr4O/leG2a7w5YTwYBGe0VJYW2snishamqLsNuJDxxNer1eYW4tcCAXe90zx3hatBkZZ2+Y1qJOEJsk6r+CWuU9/qVICwCo5paIf5RkLu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755367517; c=relaxed/simple;
	bh=xonrr5aMED7WeWCfVzoGnUTIrs5LMjhFczYIojMxUUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQ1tIfHO56XOsf2Bo1HYp7VKXkwBPoZQsfL5WbizKxSgQfvKg0Hd0RONsLOZUvWWCrt1qr9KY/tWr+n2fBi+s7QuDpPYzFDRWWdE5A1B/fFA1uzD2MYSEK5tdrshdrrzCaRC274CxeVJqlO2sflYa3QtI49QsTkGlTo8YNLtnfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=emSOrkNn; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9d41cd38dso2159196f8f.0
        for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 11:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755367513; x=1755972313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOfq1GZ7HMOucDBtwcJWTto8XPjVixy8Jtp/gDXlOBY=;
        b=emSOrkNnKFEwdpvzGucU9gZmrkgoMjLKUGQ0j6AKzuk94Dd58Va45ZouSRMcZbUxPY
         WvT+WfGyZXprk3A8s2AH24cWWuci5r0qAxYfGPxd3Itc2RxeSTDvXWwngo9uLLQ4zUgO
         Ozq3g9S2ng4s1goxwpEbNkd5mLEIMhfVi2446b42p+UQ5ay9bCUeo/lwzrQg0BRBsxos
         vzxKQ4Xmbh705JzLa8Wwv5Bx1u3BDER04HhGIIRpUKkohzYWR0Go3n8iayyx4oNV6dJi
         /1X6vbOy8eU1fNrLrxse5twAJokP/KUsG5PZDtKOeQXMqvzit8+ib1L7HPAbpQHb5thb
         NcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755367513; x=1755972313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOfq1GZ7HMOucDBtwcJWTto8XPjVixy8Jtp/gDXlOBY=;
        b=eUrqdrPpnsLFnCmz6ZSPRzKxzcJi83HG9x/bsDAonLYf7bXc6gFWCAkR1FHqcjlgYH
         FxWc/F/R1xr1lMeR7K2VODEjXcP62Smb9BOMJb2zVU2+SnIhp4BkN1adO0ZI++QPBX0W
         leg+cN86I9uS2ojaSOregnj+SJ4xDHX5iIRHBv8gcCOkDKZ5Ad1iq8VtPZfygGuSVn7c
         1jatlNZGjBmMS5JaVFGF/FbMyQoGMHH2F6YJakJBSNZzR6pzZavtkqDKo1/I1Cso/ckq
         myV8eXXmXPD+ybakVyFfrGAjf9N3HmIZoH9AqXmC3rt6lQmezZaE+MOTh9R5OXGCkRCr
         M3mw==
X-Forwarded-Encrypted: i=1; AJvYcCU03l9+P/kcu6QQZJSkTxCRY6Ued2Owllc8gNGjIfTCVDnZEf36BQcaIsb1yWgs9HxB08doLuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx7eYYbiNvP1RoeC3TUz1XkDHjwJrZf0Z7V2oWDiced0u1irNB
	9N2AM93H437PrUzGC1WXfnbfo9f/CzFWswISPHZebSJAC4mpp3dUKKfEw8R2jYepnnY=
X-Gm-Gg: ASbGncuZ6IfExH/X9HxtppgxWhhmoziiMnSMct9wT6dA4/TyfMip2hQpymObWFHkFY3
	aEkJ997Em7q6oq5C0F0zQL0fIuKFWjjZbo7g0asmW8IV+mWDaQP5A7LG+KiCZLc6Fiyq1e3fuer
	izaKZt5R8IqLzIUQ//nzRiEWsq9NvdH/OIGmJObtSOKOodYcH4ZIlDVIfBjn3MgiKwCZhxIWUjs
	AZIgaCBcKMWSKuP4xjJllSu3jXV9zUMu6S7RfRTPf8koCi9xBydP8+S2gPVHtQc2CUOvlkwdyvx
	wQiw8Lt2KzCmS4aQazchL9Fg5vv5ELk5v//TfbIfwW474LI1zjilF8VBBtnMH0vSiOT4gv51/ng
	tBCwrttNk+jPabnPEd0CZsnWI1enJURjIQEItcGohi0G1Do7ClXAbgrLoGs76ZOR/OcyXeILfSY
	sPFuzMbPSLiQ==
X-Google-Smtp-Source: AGHT+IECPEX34BYbtgNSbwFr6DLwIUlzKuoeLLXCRbvPT3Kxrs1aagFyWsq6CJ6WRWzfXzCqQefN7A==
X-Received: by 2002:a05:6000:250e:b0:3b7:9b4d:70e9 with SMTP id ffacd0b85a97d-3bb68c037a2mr4598965f8f.43.1755367513190;
        Sat, 16 Aug 2025 11:05:13 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb93862fe7sm6458422f8f.64.2025.08.16.11.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 11:05:12 -0700 (PDT)
Date: Sat, 16 Aug 2025 11:05:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: dsahern@gmail.com, netdev@vger.kernel.org, haiyangz@microsoft.com,
 shradhagupta@linux.microsoft.com, ssengar@microsoft.com,
 dipayanroy@microsoft.com, ernis@microsoft.com
Subject: Re: [PATCH iproute2-next v3] iproute2: Add 'netshaper' command to
 'ip link' for netdev shaping
Message-ID: <20250816110507.3063a733@hermes.local>
In-Reply-To: <1754895902-8790-1-git-send-email-ernis@linux.microsoft.com>
References: <1754895902-8790-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 00:05:02 -0700
Erni Sri Satya Vennela <ernis@linux.microsoft.com> wrote:

> Add support for the netshaper Generic Netlink
> family to iproute2. Introduce a new subcommand to `ip link` for
> configuring netshaper parameters directly from userspace.
> 
> This interface allows users to set shaping attributes (such as speed)
> which are passed to the kernel to perform the corresponding netshaper
> operation.
> 
> Example usage:
> $ip link netshaper { set | get | delete } dev DEVNAME \
>                    handle scope SCOPE id ID \
>                    [ speed SPEED ]
> 
> Internally, this triggers a kernel call to apply the shaping
> configuration to the specified network device.
> 
> Currently, the tool supports the following functionalities:
> - Setting speed in Mbps, enabling bandwidth clamping for
>   a network device that support netshaper operations.
> - Deleting the current configuration.
> - Querying the existing configuration.
> 
> Additional netshaper operations will be integrated into the tool
> as per requirement.
> 
> This change enables easy and scriptable configuration of bandwidth
> shaping for  devices that use the netshaper Netlink family.
> 
> Corresponding net-next patches:
> 1) https://lore.kernel.org/all/cover.1728460186.git.pabeni@redhat.com/
> 2) https://lore.kernel.org/lkml/1750144656-2021-1-git-send-email-ernis@linux.microsoft.com/
> 
> Install pkg-config and libmnl* packages to print kernel extack
> errors to stdout.
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
> Please add include/uapi/linux/net_shaper.h from kernel source tree
> for this patch.
> ---
> Changes in v3:
> * Use strcmp instead of matches.
> * Use get_rate64 instead get_unsigned for speed parameter.
> * Remove speed_mbps in do_cmd() to reduce redundancy.
> * Update the usage of speed parameter in the command.
> Changes in v2:
> * Use color coding for printing device name in stdout.
> * Use clang-format to format the code inline.
> * Use __u64 for speed_bps.
> * Remove include/uapi/linux/netshaper.h file. 
> ---
>  ip/Makefile           |   2 +-
>  ip/iplink.c           |  12 +++
>  ip/iplink_netshaper.c | 189 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 202 insertions(+), 1 deletion(-)
>  create mode 100644 ip/iplink_netshaper.c

No documentation.
No tests?

> 
> diff --git a/ip/Makefile b/ip/Makefile
> index 3535ba78..18218c3b 100644
> --- a/ip/Makefile
> +++ b/ip/Makefile
> @@ -4,7 +4,7 @@ IPOBJ=ip.o ipaddress.o ipaddrlabel.o iproute.o iprule.o ipnetns.o \
>      ipmaddr.o ipmonitor.o ipmroute.o ipprefix.o iptuntap.o iptoken.o \
>      ipxfrm.o xfrm_state.o xfrm_policy.o xfrm_monitor.o iplink_dummy.o \
>      iplink_ifb.o iplink_nlmon.o iplink_team.o iplink_vcan.o iplink_vxcan.o \
> -    iplink_vlan.o link_veth.o link_gre.o iplink_can.o iplink_xdp.o \
> +    iplink_vlan.o iplink_netshaper.o link_veth.o link_gre.o iplink_can.o iplink_xdp.o \
>      iplink_macvlan.o ipl2tp.o link_vti.o link_vti6.o link_xfrm.o \
>      iplink_vxlan.o tcp_metrics.o iplink_ipoib.o ipnetconf.o link_ip6tnl.o \
>      link_iptnl.o link_gre6.o iplink_bond.o iplink_bond_slave.o iplink_hsr.o \
> diff --git a/ip/iplink.c b/ip/iplink.c
> index 59e8caf4..daa4603d 100644
> --- a/ip/iplink.c
> +++ b/ip/iplink.c
> @@ -1509,6 +1509,15 @@ static void do_help(int argc, char **argv)
>  		usage();
>  }
>  
> +static int iplink_netshaper(int argc, char **argv)
> +{
> +	struct link_util *lu;
> +
> +	lu = get_link_kind("netshaper");
> +
> +	return lu->parse_opt(lu, argc, argv, NULL);
> +}
> +
>  int do_iplink(int argc, char **argv)
>  {
>  	if (argc < 1)
> @@ -1545,6 +1554,9 @@ int do_iplink(int argc, char **argv)
>  	if (matches(*argv, "property") == 0)
>  		return iplink_prop(argc-1, argv+1);
>  
> +	if (strcmp(*argv, "netshaper") == 0)
> +		return iplink_netshaper(argc-1, argv+1);
> +
>  	if (matches(*argv, "help") == 0) {
>  		do_help(argc-1, argv+1);
>  		return 0;
> diff --git a/ip/iplink_netshaper.c b/ip/iplink_netshaper.c
> new file mode 100644
> index 00000000..30ee6c3e
> --- /dev/null
> +++ b/ip/iplink_netshaper.c
> @@ -0,0 +1,189 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * iplink_netshaper.c netshaper H/W shaping support
> + *
> + * Authors:        Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> + */
> +#include <stdio.h>
> +#include <string.h>
> +#include <linux/genetlink.h>
> +#include <linux/netlink.h>
> +#include <linux/rtnetlink.h>
> +#include <uapi/linux/netshaper.h>
> +#include "utils.h"
> +#include "ip_common.h"
> +#include "libgenl.h"
> +
> +/* netlink socket */
> +static struct rtnl_handle gen_rth = { .fd = -1 };
> +static int genl_family = -1;
> +
> +static void usage(void)
> +{
> +	fprintf(stderr,
> +		"Usage:	ip link netshaper set dev DEVNAME handle scope HANDLE_SCOPE id HANDLE_ID speed SPEED\n"
> +		"	ip link netshaper delete dev DEVNAME handle scope HANDLE_SCOPE id HANDLE_ID\n"
> +		"	ip link netshaper get dev DEVNAME handle scope HANDLE_SCOPE id HANDLE_ID\n"

Seems like netshaper is property of the device not a top level object, the syntax
here is awkward. Open to better suggestions. Looks to me that netshaper should be property of
device not top level object.

Or netshaper is like neighbour and route and really wants to be not part of link command.

Also no other ip commands use show not get.
The verb "get" is only used for things like getting a route or neighbor with a particular address.


> +		"Where:	DEVNAME		:= STRING\n"
> +		"	HANDLE_SCOPE	:= { netdev | queue | node }\n"
> +		"	HANDLE_ID	:= UINT\n"
> +		"	SPEED		:= UINT{ kbit | mbit | gbit }\n");
> +
> +	exit(-1);
> +}
> +
> +static void print_netshaper_attrs(struct nlmsghdr *answer)
> +{
> +	struct genlmsghdr *ghdr = NLMSG_DATA(answer);
> +	int len = answer->nlmsg_len - NLMSG_LENGTH(GENL_HDRLEN);
> +	struct rtattr *tb[NET_SHAPER_A_MAX + 1] = {};
> +	__u32 speed_mbps;
> +	__u64 speed_bps;
> +	int ifindex;
> +
> +	parse_rtattr(tb, NET_SHAPER_A_MAX,
> +		     (struct rtattr *)((char *)ghdr + GENL_HDRLEN), len);
> +
> +	for (int i = 1; i <= NET_SHAPER_A_MAX; ++i) {
> +		if (!tb[i])
> +			continue;
> +		switch (i) {
> +		case NET_SHAPER_A_BW_MAX:
> +			speed_bps = rta_getattr_u64(tb[i]);
> +			speed_mbps = (speed_bps / 1000000);
> +			print_uint(PRINT_ANY, "speed", "speed: %u mbps\n",
> +				   speed_mbps);
> +			break;
> +		case NET_SHAPER_A_IFINDEX:
> +			ifindex = rta_getattr_u32(tb[i]);
> +			print_color_string(PRINT_ANY, COLOR_IFNAME, "dev",
> +					   "dev: %s\n",
> +					   ll_index_to_name(ifindex));
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +}
> +
> +static int do_cmd(int argc, char **argv, struct nlmsghdr *n, int cmd)
> +{
> +	GENL_REQUEST(req, 1024, genl_family, 0, NET_SHAPER_FAMILY_VERSION, cmd,
> +		     NLM_F_REQUEST | NLM_F_ACK);
> +
> +	struct nlmsghdr *answer;
> +	__u64 speed_bps = 0;
> +	int ifindex = -1;
> +	int handle_scope = NET_SHAPER_SCOPE_UNSPEC;
> +	__u32 handle_id = 0;
> +	bool handle_present = false;
> +	int err;
> +
> +	while (argc > 0) {
> +		if (strcmp(*argv, "dev") == 0) {
> +			NEXT_ARG();
> +			ifindex = ll_name_to_index(*argv);
> +		} else if (strcmp(*argv, "speed") == 0) {
> +			NEXT_ARG();
> +			if(get_rate64(&speed_bps, *argv)) {
> +				fprintf(stderr, "Invalid speed value\n");
> +				return -1;
> +			}
> +			/*Convert Bps to bps*/
> +			speed_bps *= 8;
> +		} else if (strcmp(*argv, "handle") == 0) {
> +			handle_present = true;
> +			NEXT_ARG();
> +			if (strcmp(*argv, "scope") == 0) {
> +				NEXT_ARG();
> +				if (strcmp(*argv, "netdev") == 0) {
> +					handle_scope = NET_SHAPER_SCOPE_NETDEV;
> +				} else if (strcmp(*argv, "queue") == 0) {
> +					handle_scope = NET_SHAPER_SCOPE_QUEUE;
> +				} else if (strcmp(*argv, "node") == 0) {
> +					handle_scope = NET_SHAPER_SCOPE_NODE;
> +				} else {
> +					fprintf(stderr, "Invalid scope\n");
> +					return -1;
> +				}
> +
> +				NEXT_ARG();
> +				if (strcmp(*argv, "id") == 0) {
> +					NEXT_ARG();
> +					if (get_unsigned(&handle_id, *argv, 10)) {
> +						fprintf(stderr,
> +							"Invalid handle id\n");
> +						return -1;
> +					}
> +				}
> +			}
> +		} else {
> +			fprintf(stderr, "What is \"%s\"\n", *argv);
> +			usage();
> +		}
> +		argc--;
> +		argv++;
> +	}
> +
> +	if (ifindex == -1)
> +		missarg("dev");
> +
> +	if (!handle_present)
> +		missarg("handle");
> +
> +	if (cmd == NET_SHAPER_CMD_SET && speed_bps == 0)
> +		missarg("speed");
> +
> +	addattr32(&req.n, sizeof(req), NET_SHAPER_A_IFINDEX, ifindex);
> +
> +	struct rtattr *handle = addattr_nest(&req.n, sizeof(req),
> +					     NET_SHAPER_A_HANDLE | NLA_F_NESTED);
> +	addattr32(&req.n, sizeof(req), NET_SHAPER_A_HANDLE_SCOPE, handle_scope);
> +	addattr32(&req.n, sizeof(req), NET_SHAPER_A_HANDLE_ID, handle_id);
> +	addattr_nest_end(&req.n, handle);
> +
> +	if (cmd == NET_SHAPER_CMD_SET)
> +		addattr64(&req.n, sizeof(req), NET_SHAPER_A_BW_MAX, speed_bps);
> +
> +	err = rtnl_talk(&gen_rth, &req.n, &answer);
> +	if (err < 0) {
> +		printf("Kernel command failed: %d\n", err);
> +		return err;
> +	}
> +
> +	if (cmd == NET_SHAPER_CMD_GET)
> +		print_netshaper_attrs(answer);
> +
> +	return err;
> +}
> +
> +static int netshaper_parse_opt(struct link_util *lu, int argc, char **argv,
> +			       struct nlmsghdr *n)
> +{
> +	if (argc < 1)
> +		usage();
> +	if (strcmp(*argv, "help") == 0)
> +		usage();
> +
> +	if (genl_init_handle(&gen_rth, NET_SHAPER_FAMILY_NAME, &genl_family))
> +		exit(1);
> +
> +	if (strcmp(*argv, "set") == 0)
> +		return do_cmd(argc - 1, argv + 1, n, NET_SHAPER_CMD_SET);
> +
> +	if (strcmp(*argv, "delete") == 0)
> +		return do_cmd(argc - 1, argv + 1, n, NET_SHAPER_CMD_DELETE);
> +
> +	if (strcmp(*argv, "get") == 0)
> +		return do_cmd(argc - 1, argv + 1, n, NET_SHAPER_CMD_GET);
> +
> +	fprintf(stderr,
> +		"Command \"%s\" is unknown, try \"ip link netshaper help\".\n",
> +		*argv);
> +	exit(-1);
> +}
> +
> +struct link_util netshaper_link_util = {
> +	.id = "netshaper",
> +	.parse_opt = netshaper_parse_opt,
> +};


Please add a print_opt functionality.
Very useful to see what kernel thinks state is. 


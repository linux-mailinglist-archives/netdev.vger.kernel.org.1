Return-Path: <netdev+bounces-211769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C54B1B9C8
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 20:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F413618A62E1
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 18:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9FA218AB0;
	Tue,  5 Aug 2025 18:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="m8jqC9+2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0190511712
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754417022; cv=none; b=Hw0StBGpcZuKmbQc41OrpiUIRI4/qR04Sk/DLkVJCChytIkpynTIKA0uOf7ffSvwuiBBDs0E6+agT24kI6jKHZIt1pccN4F2iO7wtRekZ2OKKWDGCz/2j03R6fd2hX95v1GXYgfsgS4Ta+1l9GbOgjWHICcFBE1HBMkghqhKK3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754417022; c=relaxed/simple;
	bh=noPwSXWrr8TCEznqeGBBbTQxhLrtydpi+mZ0xSbkrIY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oeQ4nhmnbELpVb4G/7Z79LN/uTfUXSMyD8ewZg+uTmS3/nNWE10VvAmohB3VOBT29EFC8r8TsCeDw9AOeTKHArr1BD45buanocQBC5WdgOTY7YQdmG7kxFldb3UBmflZ8yVtWrNVQ15bTPzQoNF71yY41mCm3RV+AcTESDq+bWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=m8jqC9+2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-458bc3ce3beso21630105e9.1
        for <netdev@vger.kernel.org>; Tue, 05 Aug 2025 11:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754417018; x=1755021818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHD1XjzCuuFvIeHZ0B0vum9rCysQVh8DhukoHkmwls8=;
        b=m8jqC9+2Ha4PKuRauu1LSBbrvGZM97+lVBeB0iOv8s71C6fmZWXkkEmj35o5N2CMsn
         xOyzY5C2dU45euP8M6rJ7yEAuZVi+kX+NmDRSgRSJOvOFJ4QgmL0EvGgNVY5Y8g0E8Yw
         a5fybBc7bQMFjrSIcfHXtMJEIAm9OHB9b10WkCrQ+vXDEYtOs05jJYvoXRLXuGPj1MT+
         EUvE2a6HWZPnk/oHmzzJmRdkTMeyWSjidumce9+6vi5IPfyukaEgsWpYuQ22u1OjeC/3
         1h+qpMZyWUVnX0gvU9cY2qRBfmLOUYq1Q7d9erDYN7KZmViq5JFDaTR6EJ2WXGOedqlm
         e05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754417018; x=1755021818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHD1XjzCuuFvIeHZ0B0vum9rCysQVh8DhukoHkmwls8=;
        b=hWFjGF9Pk78jfFbJz21YqOQE+pvpVUXFSRhe+7klP8OjIIPj2PelDGqlLMBDwGVJgK
         CKv1Lma8sQC4r2H5Jag5Hw6BiCbFhj6Rci7z0hoQWZs/Vxd2RvHeZVBNsJEwBykbDuiv
         sdtaBk+ZUWnPwOWN/DJLLOxrAKhFxZyB9I9G4kbCF/E+reffzgwEhvVCzsaVoExlTuii
         UI4nUdZtQnvK7lH1rReD+OIomWke4yyHas5xUd9+vlj83oVb6wvKPbNwtMHwA6HcY7PE
         rezzTkgpX9fwnPgPItofoQBZtLujQCXHwRa5oIFVvmozNsnxwQfG+iaBtUYaQfkWScZU
         g2iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlM3rDt2bradXhjOorAUv7slIwnfQH9WnQ4RXT8VxfGkSkn5lLmnXYLqsaUxJNLSEnnSPX0bA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDfAkUvjX4zoanMktzHVmglSMXCLcw5P5fZKXUnipAhqeFuNEB
	R4hA8SuBfYa6o4vE/3o4fSxMEoIqLabHTrcnZoK5RLjeb+tWdgYfPsWYZV6JT5WEafM=
X-Gm-Gg: ASbGnctrjgfsa8+KFVac5JKhS4yV/884UHtVyb3QvfUB6v6q4YTBmMxsJvuEMlb7vdg
	2MFCJH0EbiH3ddIE0BEriBeRQLH8/OGKCC30k1Wlj1DC4yUJypkOlSNCQcZRFZVBUZZC4JKVn54
	LC9CjEljQIq1qOuNznKUmd1A3O3W1J8VcDbUDd3rAJq2DrYhwc7ncIBQgx3OR4HvDSeCRRwFCHS
	QoibmtmME8HMO1+hmyRTNlOgLFMg5tcDymvQwwtoAbcWrvkmPeD+RBEnRverEmkq32o4RzJVnvs
	VucQr5G/S3+hs8PnCKQIOMnrUDcg3y+ODO0f5MV4inHo6Q/7W4+FLT2STcMGBwugtO2Oc2oA5oq
	P32f5rpzVfjn6E6e3/v6yzH4tyAg8aGwptyLIfpdkoshbB+8KMCZeMK59I5NV7fWjK1wf7ZkgWV
	8=
X-Google-Smtp-Source: AGHT+IF/4wc8jCs+lINrWv2ws8lK1z6JfwBZ93sdmwT4LkhZmYoyLG3i5+vYHmOeNfis1ojCl6aYqA==
X-Received: by 2002:a05:600c:4f10:b0:458:be44:357b with SMTP id 5b1f17b1804b1-458be443856mr115748585e9.15.1754417017936;
        Tue, 05 Aug 2025 11:03:37 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453328sm21077245f8f.46.2025.08.05.11.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 11:03:37 -0700 (PDT)
Date: Tue, 5 Aug 2025 11:03:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: dsahern@gmail.com, netdev@vger.kernel.org, haiyangz@microsoft.com,
 shradhagupta@linux.microsoft.com, ssengar@microsoft.com,
 dipayanroy@microsoft.com, ernis@microsoft.com
Subject: Re: [PATCH iproute2-next v2] iproute2: Add 'netshaper' command to
 'ip link' for netdev shaping
Message-ID: <20250805110331.348499c9@hermes.local>
In-Reply-To: <1753867316-7828-1-git-send-email-ernis@linux.microsoft.com>
References: <1753867316-7828-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Jul 2025 02:21:56 -0700
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
> Install pkg-config and libmnl* packages to print any kernel extack
> errors to stdout.
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
> Please add include/uapi/linux/net_shaper.h from kernel source tree
> for this patch.
> ---
> Changes in v2:
> * Use color coding for printing device name in stdout.
> * Use clang-format to format the code inline.
> * Use __u64 for speed_bps.
> * Remove include/uapi/linux/netshaper.h file.
> ---
>  ip/Makefile           |   2 +-
>  ip/iplink.c           |  12 +++
>  ip/iplink_netshaper.c | 190 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 203 insertions(+), 1 deletion(-)
>  create mode 100644 ip/iplink_netshaper.c

Good start but changes needed.

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
> index 59e8caf4..9da6e304 100644
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
> +	if (matches(*argv, "netshaper") == 0)
> +		return iplink_netshaper(argc-1, argv+1);
> +

Matches() can cause issues, prefer strcmp() for new code.

>  	if (matches(*argv, "help") == 0) {
>  		do_help(argc-1, argv+1);
>  		return 0;
> diff --git a/ip/iplink_netshaper.c b/ip/iplink_netshaper.c
> new file mode 100644
> index 00000000..af7d5e09
> --- /dev/null
> +++ b/ip/iplink_netshaper.c
> @@ -0,0 +1,190 @@
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
> +		"Where:	DEVNAME		:= STRING\n"
> +		"	HANDLE_SCOPE	:= { netdev | queue | node }\n"
> +		"	HANDLE_ID	:= UINT\n"
> +		"	SPEED		:= UINT (Mega bits per second)\n");
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
> +	__u32 speed_mbps = 0;
> +	__u64 speed_bps = 0;
> +	int ifindex = -1;
> +	int handle_scope = NET_SHAPER_SCOPE_UNSPEC;
> +	__u32 handle_id = 0;
> +	bool handle_present = false;
> +	int err;
> +
> +	while (argc > 0) {
> +		if (matches(*argv, "dev") == 0) {
> +			NEXT_ARG();
> +			ifindex = ll_name_to_index(*argv);
> +		} else if (matches(*argv, "speed") == 0) {

Iproute2 no longer allows shortcut matches on new commands.
Shortcuts have lead to lots of confusion where there are multiple matches possible.

> +			NEXT_ARG();
> +			if (get_unsigned(&speed_mbps, *argv, 10)) {
> +				fprintf(stderr, "Invalid speed value\n");
> +				return -1;
> +			}

Could you change this code to use the get_rate() in lib/utils_math.c
That routine handles wide variety of suffixes.

> +			/*Convert Mbps to Bps*/

Won't need this if you use get_rate() or get_rate64

> +			speed_bps = (((__u64)speed_mbps) * 1000000);
> +		} else if (matches(*argv, "handle") == 0) {
> +			handle_present = true;
> +			NEXT_ARG();
> +			if (matches(*argv, "scope") == 0) {
> +				NEXT_ARG();
> +				if (matches(*argv, "netdev") == 0) {
> +					handle_scope = NET_SHAPER_SCOPE_NETDEV;
> +				} else if (matches(*argv, "queue") == 0) {
> +					handle_scope = NET_SHAPER_SCOPE_QUEUE;
> +				} else if (matches(*argv, "node") == 0) {
> +					handle_scope = NET_SHAPER_SCOPE_NODE;
> +				} else {
> +					fprintf(stderr, "Invalid scope\n");
> +					return -1;
> +				}
> +
> +				NEXT_ARG();
> +				if (matches(*argv, "id") == 0) {
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
> +	if (cmd == NET_SHAPER_CMD_SET && speed_mbps == 0)
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
> +	if (matches(*argv, "help") == 0)
> +		usage();
> +
> +	if (genl_init_handle(&gen_rth, NET_SHAPER_FAMILY_NAME, &genl_family))
> +		exit(1);
> +
> +	if (matches(*argv, "set") == 0)
> +		return do_cmd(argc - 1, argv + 1, n, NET_SHAPER_CMD_SET);
> +
> +	if (matches(*argv, "delete") == 0)
> +		return do_cmd(argc - 1, argv + 1, n, NET_SHAPER_CMD_DELETE);
> +
> +	if (matches(*argv, "get") == 0)
> +		return do_cmd(argc - 1, argv + 1, n, NET_SHAPER_CMD_GET);

No matches shortcuts

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

Where is the print function. You should be able to print current shaper
state?


Return-Path: <netdev+bounces-106759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E829178D2
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 08:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9B21F23AE7
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 06:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68214148FF7;
	Wed, 26 Jun 2024 06:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Ln0dAYqj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623F033C5
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 06:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719382880; cv=none; b=eCVyn/Ft+XP4UEvboxmIrmrwsxyVS84EA27j54VscdbFHoltV/iVj3m3dyYRN7C1Ou3TToZ3oRAiwzSxN0nmW2Vq6on4UFtYDlaOMRniZ7ekz9Saa/Hkwf+Ex4hxAgul0R7Ul+kfh+e5ySN/s5cCpp8ZOtP75c4bYtEZRAcifNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719382880; c=relaxed/simple;
	bh=pc969qtArpisEvMbAheRvf80yiX+sMx3X4qb+iuOqsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=db0emRUTd6PJKFj1PU1bgASvEVpniy9fNeC+lno7tUA3i+wCDTEaiBC5aoLM8VVoxgybTF/bOXKYSpdNpJMwO8MhDtlXuxbS+uwhwia8s8it22QMljJlP5uKBk4AA1lPx6WcKJcq7CWzd4mwckGbNijNu3RoR+BKk4T1LP3oYE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Ln0dAYqj; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a72585032f1so364262066b.3
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 23:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1719382876; x=1719987676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dOsv815OH/DbrBVoBzQtWtxW5QtPbNqZnE4TuVPm71c=;
        b=Ln0dAYqjArqduucffI2fQWuEGdTAwXlTdPYTZgcs/Xvp6nDIOjv1FAPEU4xD4m51iJ
         1MiXTLJoCllM76Ts87Tq49tup3LAhvasld8dvfpkYuWTAssUeixDiOzkUqy24Q+CZ/AD
         CIZl1coaHcQHwli3DHm7bzeOB3D1bvIzdzhcZdMjste7kbGs/sm2OtovWRiIuW26vt+R
         WC35hk5ZDQA44qtNSs1iK7xti7P44NF8BhB2fJCSpARI2fpdOSi4mP4wbBhY+vJM9j53
         YXkbc2jERIZVobqo+3tjsApSJCH7gHYDapD8imUvGFrwHwHUS+nq9gHmI/xA8nb4QPod
         KJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719382876; x=1719987676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOsv815OH/DbrBVoBzQtWtxW5QtPbNqZnE4TuVPm71c=;
        b=RFHjAebzuz9PUiwwLgCU7HVQdD4ESAHwMsxkCHdWRdi4Er4Wx+rydCbVJLbn1z30kD
         lWzCoOUFpeF7apyZOvbSAlliSlxe0aapn528vr2ES71/ExtZJQT4U0T1UwAp20aOxnZK
         g+s8jBR5NcPb9/uhUxRlyurzzMo5MCQLbVr4Ys18Q7nxjjydCNIi7VApjNCLv+/qFO1r
         uDE0sXRPLZQpLwlZqiQfTGG0f3v4MeqPFvcrSQQ/hAY4i8FHSPLTZa0gFlXUDbJxROaZ
         Gj983rzUSZsyf2B219baylulTBTpkRjDM5nR5m/BRr2+IWneiCqpcMeD1RFI7kLIZtl3
         6Wuw==
X-Forwarded-Encrypted: i=1; AJvYcCXwvyJNIaEGbVVu0OSOzUNnfjaJHQL9owReLmZzhKxWj/Uptu36ih66wp0X3q33sr2WiUYoPrVkopWhDN4xZz7OhP0wgamD
X-Gm-Message-State: AOJu0YzcLKj6QjOM4ZeKkVIhrPXle8mR4buwQPPF7rt21YSe5lpd62yy
	z/9QQKL+B5eiu3jqiTsnHJgh1eZin15n48R3WhxV3+sqqJgm3ZiFFoI9Alda4lY=
X-Google-Smtp-Source: AGHT+IHuY3K1k+PVEFjDoBZE72XUI9ylKeeTRnnIAUyEGDex6INJ29+6UMSyuPI9vw7Ktq5JxxGtrw==
X-Received: by 2002:a17:906:230d:b0:a6f:50ae:e0a with SMTP id a640c23a62f3a-a715f978a7amr588463966b.37.1719382876335;
        Tue, 25 Jun 2024 23:21:16 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7169b12999sm432061866b.95.2024.06.25.23.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 23:21:15 -0700 (PDT)
Message-ID: <386fc09b-d0ec-4757-b910-d3d5c7947f9c@blackwall.org>
Date: Wed, 26 Jun 2024 09:21:15 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iproute2 3/3] bridge: mst: Add get/set support for MST
 states
To: Tobias Waldekranz <tobias@waldekranz.com>, stephen@networkplumber.org,
 dsahern@kernel.org
Cc: liuhangbin@gmail.com, netdev@vger.kernel.org
References: <20240624130035.3689606-1-tobias@waldekranz.com>
 <20240624130035.3689606-4-tobias@waldekranz.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240624130035.3689606-4-tobias@waldekranz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/06/2024 16:00, Tobias Waldekranz wrote:
> Allow a port's spanning tree state to be modified on a per-MSTI basis,
> and support dumping the current MST states for every port and MSTI.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  bridge/Makefile    |   2 +-
>  bridge/br_common.h |   1 +
>  bridge/bridge.c    |   3 +-
>  bridge/mst.c       | 262 +++++++++++++++++++++++++++++++++++++++++++++
>  man/man8/bridge.8  |  57 ++++++++++
>  5 files changed, 323 insertions(+), 2 deletions(-)
>  create mode 100644 bridge/mst.c
> 
> diff --git a/bridge/Makefile b/bridge/Makefile
> index 01f8a455..4c57df43 100644
> --- a/bridge/Makefile
> +++ b/bridge/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -BROBJ = bridge.o fdb.o monitor.o link.o mdb.o vlan.o vni.o
> +BROBJ = bridge.o fdb.o monitor.o link.o mdb.o mst.o vlan.o vni.o
>  
>  include ../config.mk
>  
> diff --git a/bridge/br_common.h b/bridge/br_common.h
> index 704e76b0..3a0cf882 100644
> --- a/bridge/br_common.h
> +++ b/bridge/br_common.h
> @@ -20,6 +20,7 @@ void print_headers(FILE *fp, const char *label);
>  int do_fdb(int argc, char **argv);
>  int do_mdb(int argc, char **argv);
>  int do_monitor(int argc, char **argv);
> +int do_mst(int argc, char **argv);
>  int do_vlan(int argc, char **argv);
>  int do_link(int argc, char **argv);
>  int do_vni(int argc, char **argv);
> diff --git a/bridge/bridge.c b/bridge/bridge.c
> index ef592815..f8b5646a 100644
> --- a/bridge/bridge.c
> +++ b/bridge/bridge.c
> @@ -36,7 +36,7 @@ static void usage(void)
>  	fprintf(stderr,
>  "Usage: bridge [ OPTIONS ] OBJECT { COMMAND | help }\n"
>  "       bridge [ -force ] -batch filename\n"
> -"where  OBJECT := { link | fdb | mdb | vlan | vni | monitor }\n"
> +"where  OBJECT := { link | fdb | mdb | mst | vlan | vni | monitor }\n"
>  "       OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] |\n"
>  "                    -o[neline] | -t[imestamp] | -n[etns] name |\n"
>  "                    -com[pressvlans] -c[olor] -p[retty] -j[son] }\n");
> @@ -56,6 +56,7 @@ static const struct cmd {
>  	{ "link",	do_link },
>  	{ "fdb",	do_fdb },
>  	{ "mdb",	do_mdb },
> +	{ "mst",	do_mst },
>  	{ "vlan",	do_vlan },
>  	{ "vni",	do_vni },
>  	{ "monitor",	do_monitor },
> diff --git a/bridge/mst.c b/bridge/mst.c
> new file mode 100644
> index 00000000..873ca536
> --- /dev/null
> +++ b/bridge/mst.c
> @@ -0,0 +1,262 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Get/set Multiple Spanning Tree (MST) states
> + */
> +
> +#include <stdio.h>
> +#include <linux/if_bridge.h>
> +#include <net/if.h>
> +
> +#include "libnetlink.h"
> +#include "json_print.h"
> +#include "utils.h"
> +
> +#include "br_common.h"
> +
> +#define MST_ID_LEN 9
> +
> +#define __stringify_1(x...) #x
> +#define __stringify(x...) __stringify_1(x)

This part seems to be defined in multiple places for the bridge tool,
perhaps pull it in br_common.h?

> +
> +static unsigned int filter_index;
> +
> +static void usage(void)
> +{
> +	fprintf(stderr,
> +		"Usage: bridge mst set dev DEV msti MSTI state STATE\n"
> +		"       bridge mst {show} [ dev DEV ]\n");
> +	exit(-1);
> +}
> +
> +static void print_mst_entry(struct rtattr *a, FILE *fp)
> +{
> +	struct rtattr *tb[IFLA_BRIDGE_MST_ENTRY_MAX + 1];
> +	__u16 msti = 0;
> +	__u8 state = 0;
> +
> +	parse_rtattr_flags(tb, IFLA_BRIDGE_MST_ENTRY_MAX, RTA_DATA(a),
> +			   RTA_PAYLOAD(a), NLA_F_NESTED);
> +
> +
> +	if (!(tb[IFLA_BRIDGE_MST_ENTRY_MSTI] &&
> +	      tb[IFLA_BRIDGE_MST_ENTRY_STATE])) {
> +		fprintf(stderr, "BUG: broken MST entry");
> +		return;
> +	}
> +
> +	msti = rta_getattr_u16(tb[IFLA_BRIDGE_MST_ENTRY_MSTI]);
> +	state = rta_getattr_u8(tb[IFLA_BRIDGE_MST_ENTRY_STATE]);
> +
> +	open_json_object(NULL);
> +	print_uint(PRINT_ANY, "msti", "%u", msti);
> +	print_nl();
> +	print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s    ", "");
> +	print_stp_state(state);
> +	print_nl();
> +	close_json_object();
> +}
> +
> +static int print_msts(struct nlmsghdr *n, void *arg)
> +{
> +	struct ifinfomsg *ifi = NLMSG_DATA(n);
> +	struct rtattr *af_spec, *mst, *a;
> +	int rem = n->nlmsg_len;
> +	bool opened = false;
> +
> +	rem -= NLMSG_LENGTH(sizeof(*ifi));
> +	if (rem < 0) {
> +		fprintf(stderr, "BUG: wrong nlmsg len %d\n", rem);
> +		return -1;
> +	}
> +
> +	af_spec = parse_rtattr_one(IFLA_AF_SPEC, IFLA_RTA(ifi), rem);
> +	if (!af_spec)
> +		return -1;
> +
> +	if (filter_index && filter_index != ifi->ifi_index)
> +		return 0;
> +
> +	mst = parse_rtattr_one_nested(NLA_F_NESTED | IFLA_BRIDGE_MST, af_spec);
> +	if (!mst)
> +		return 0;
> +
> +	rem = RTA_PAYLOAD(mst);
> +	for (a = RTA_DATA(mst); RTA_OK(a, rem); a = RTA_NEXT(a, rem)) {
> +		unsigned short rta_type = a->rta_type & NLA_TYPE_MASK;
> +
> +		if (rta_type > IFLA_BRIDGE_MST_MAX)
> +			continue;
> +

You can just use the switch below to continue in the default case.

> +		switch (rta_type) {
> +		case IFLA_BRIDGE_MST_ENTRY:
> +			if (!opened) {
> +				open_json_object(NULL);
> +				print_color_string(PRINT_ANY, COLOR_IFNAME,
> +						   "ifname",
> +						   "%-" __stringify(IFNAMSIZ) "s  ",
> +						   ll_index_to_name(ifi->ifi_index));
> +				open_json_array(PRINT_JSON, "mst");
> +				opened = true;
> +			} else {
> +				print_string(PRINT_FP, NULL, "%-"
> +					     __stringify(IFNAMSIZ) "s  ", "");
> +			}
> +
> +			print_mst_entry(a, arg);
> +			break;
> +		}
> +	}
> +
> +	if (opened) {
> +		close_json_array(PRINT_JSON, NULL);
> +		close_json_object();
> +	}
> +
> +	return 0;
> +}
> +
> +static int mst_show(int argc, char **argv)
> +{
> +	char *filter_dev = NULL;
> +
> +	while (argc > 0) {
> +		if (strcmp(*argv, "dev") == 0) {
> +			NEXT_ARG();
> +			if (filter_dev)
> +				duparg("dev", *argv);
> +			filter_dev = *argv;
> +		}
> +		argc--; argv++;
> +	}
> +
> +	if (filter_dev) {
> +		filter_index = ll_name_to_index(filter_dev);
> +		if (!filter_index)
> +			return nodev(filter_dev);
> +	}
> +
> +	if (rtnl_linkdump_req_filter(&rth, PF_BRIDGE, RTEXT_FILTER_MST) < 0) {
> +		perror("Cannon send dump request");
> +		exit(1);
> +	}
> +
> +	new_json_obj(json);
> +
> +	if (!is_json_context()) {
> +		printf("%-" __stringify(IFNAMSIZ) "s  "
> +		       "%-" __stringify(MST_ID_LEN) "s",
> +		       "port", "msti");
> +		printf("\n");
> +	}
> +
> +	if (rtnl_dump_filter(&rth, print_msts, stdout) < 0) {
> +		fprintf(stderr, "Dump terminated\n");
> +		return -1;
> +	}
> +
> +	delete_json_obj();
> +	fflush(stdout);
> +	return 0;
> +}
> +
> +static int mst_set(int argc, char **argv)
> +{
> +	struct {
> +		struct nlmsghdr		n;
> +		struct ifinfomsg	ifi;
> +		char			buf[512];
> +	} req = {
> +		.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
> +		.n.nlmsg_flags = NLM_F_REQUEST,
> +		.n.nlmsg_type = RTM_SETLINK,
> +		.ifi.ifi_family = PF_BRIDGE,
> +	};
> +	char *d = NULL, *m = NULL, *s = NULL, *endptr;
> +	struct rtattr *af_spec, *mst, *entry;
> +	__u16 msti;
> +	__u8 state;
> +
> +	while (argc > 0) {
> +		if (strcmp(*argv, "dev") == 0) {
> +			NEXT_ARG();
> +			d = *argv;
> +		} else if (strcmp(*argv, "msti") == 0) {
> +			NEXT_ARG();
> +			m = *argv;
> +		} else if (strcmp(*argv, "state") == 0) {
> +			NEXT_ARG();
> +			s = *argv;
> +		} else {
> +			if (matches(*argv, "help") == 0)
> +				usage();
> +		}
> +		argc--; argv++;
> +	}
> +
> +	if (d == NULL || m == NULL || s == NULL) {
> +		fprintf(stderr, "Device, MSTI and state are required arguments.\n");
> +		return -1;
> +	}
> +
> +	req.ifi.ifi_index = ll_name_to_index(d);
> +	if (!req.ifi.ifi_index)
> +		return nodev(d);
> +
> +	msti = strtol(m, &endptr, 10);
> +	if (!(*s != '\0' && *endptr == '\0')) {
> +		fprintf(stderr,
> +			"Error: invalid MSTI\n");
> +		return -1;
> +	}
> +
> +	state = strtol(s, &endptr, 10);
> +	if (!(*s != '\0' && *endptr == '\0')) {
> +		state = parse_stp_state(s);
> +		if (state == -1) {
> +			fprintf(stderr,
> +				"Error: invalid STP port state\n");
> +			return -1;
> +		}
> +	}
> +
> +	af_spec = addattr_nest(&req.n, sizeof(req), IFLA_AF_SPEC);
> +	mst = addattr_nest(&req.n, sizeof(req), IFLA_BRIDGE_MST);
> +
> +	entry = addattr_nest(&req.n, sizeof(req), IFLA_BRIDGE_MST_ENTRY);
> +	entry->rta_type |= NLA_F_NESTED;
> +
> +	addattr16(&req.n, sizeof(req), IFLA_BRIDGE_MST_ENTRY_MSTI, msti);
> +	addattr8(&req.n, sizeof(req), IFLA_BRIDGE_MST_ENTRY_STATE, state);
> +
> +	addattr_nest_end(&req.n, entry);
> +
> +	addattr_nest_end(&req.n, mst);
> +	addattr_nest_end(&req.n, af_spec);
> +
> +
> +	if (rtnl_talk(&rth, &req.n, NULL) < 0)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +int do_mst(int argc, char **argv)
> +{
> +	ll_init_map(&rth);
> +
> +	if (argc > 0) {
> +		if (matches(*argv, "set") == 0)
> +			return mst_set(argc-1, argv+1);
> +
> +		if (matches(*argv, "show") == 0 ||
> +		    matches(*argv, "lst") == 0 ||
> +		    matches(*argv, "list") == 0)
> +			return mst_show(argc-1, argv+1);
> +		if (matches(*argv, "help") == 0)
> +			usage();
> +	} else
> +		return mst_show(0, NULL);
> +
> +	fprintf(stderr, "Command \"%s\" is unknown, try \"bridge mst help\".\n", *argv);
> +	exit(-1);
> +}
> diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
> index b4699801..08f329c6 100644
> --- a/man/man8/bridge.8
> +++ b/man/man8/bridge.8
> @@ -207,6 +207,15 @@ bridge \- show / manipulate bridge addresses and devices
>  .RB "[ " vni
>  .IR VNI " ]"
>  
> +.ti -8
> +.B "bridge mst set"
> +.IR dev " DEV " msti " MSTI " state " STP_STATE "
> +
> +.ti -8
> +.BR "bridge mst" " [ [ " show " ] [ "
> +.B dev
> +.IR DEV " ] ]"
> +
>  .ti -8
>  .BR "bridge vlan" " { " add " | " del " } "
>  .B dev
> @@ -1247,6 +1256,54 @@ endpoint. Match entries only with the specified destination port number.
>  the VXLAN VNI Network Identifier to use to connect to the remote VXLAN tunnel
>  endpoint. Match entries only with the specified destination VNI.
>  
> +.SH bridge mst - multiple spanning tree port states
> +
> +In the multiple spanning tree (MST) model, the active paths through a
> +network can be different for different VLANs.  In other words, a
> +bridge port can simultaneously forward one subset of VLANs, while
> +blocking another.
> +
> +Provided that the
> +.B mst_enable
> +bridge option is enabled, a group of VLANs can be forwarded along the
> +same spanning tree by associating them with the same instance (MSTI)
> +using
> +.BR "bridge vlan global set" .

Give a complete command example?

> +
> +.SS bridge mst set - set multiple spanning tree state
> +
> +Set the spanning tree state for
> +.IR DEV ,
> +in the multiple spanning tree instance
> +.IR MSTI ,
> +to
> +.IR STP_STATE .
> +
> +.TP
> +.BI dev " DEV"
> +Interface name of the bridge port.
> +
> +.TP
> +.BI msti " MSTI"
> +The multiple spanning tree instance.
> +
> +.TP
> +.BI state " STP_STATE"
> +The spanning tree state, see the
> +.B state
> +option of
> +.B "bridge link set"
> +for supported states.
> +
> +.SS bridge mst show - list MST states
> +
> +List current MST port states in every MSTI.
> +
> +.TP
> +.BI dev " DEV"
> +If specified, only display states of the bridge port with this
> +interface name.
> +
>  .SH bridge vlan - VLAN filter list
>  
>  .B vlan



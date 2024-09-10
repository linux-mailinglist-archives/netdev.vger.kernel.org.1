Return-Path: <netdev+bounces-127142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B64349744F8
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 23:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D8F288DFB
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 21:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142F11AAE07;
	Tue, 10 Sep 2024 21:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9kZzkZ0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D09B18CBE6
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 21:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726004515; cv=none; b=NMLbsZ6tiY0r7WD/1qPxEApF9caDqZDkKuh6I0EOncAaOoocVdlJr8CpMS96Msk0i+57ckbGN73cU+Dgq5fQHE4pGVRpiKgj86d0T4PMcxWNUbmYL5rB+nx1WjBDkrIIBsd7iho1A6DPw17KXsfBLSToE/8GDUri565FwiEHEwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726004515; c=relaxed/simple;
	bh=3db2goRONDrXz0EluDtm1usvRK6K/4HT1Y7waApa9o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDHwvcMiC0w98imSRSZ5MwhPUJiwsc+CVYQbrICfzJnHejfBCk8343ai20SVR3IuA8z3gWPB74v2KqbZQasEbE841PoNUkucP2vszHAirl16dWgg6shNkpQlNImDlBXeEdTHbJEo4nun5lV8NS2CeWt+WSJk96a2UXXPnk6GcE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9kZzkZ0; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d8a744aa9bso3879174a91.3
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 14:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726004512; x=1726609312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aw+6lFFj6ydEjI4u0rC5LELrB7W3bbCNrFSSnF9eFsE=;
        b=a9kZzkZ0u7e0vPZurX150CDXurTKQ6OKK9UXfEAhtitUcUcTpb0krkG/czWG28r+UT
         fbjtrv9v3mPD93G4GHlTSyZ/8IaJN7nDpU9gVUjR6gRlJKG64CXYwMR/n4B0Yz3WSqyW
         T8ToFiFccYiDJRbBYXiIHGvq+xFccIRAD9HYZWLmT7vRa6OhfA79r4QO74kVbH6rfNXw
         9BZdmDVhP4Jnh6vnkBmqqfwLag6yOjXf5yN7mkUHUSKGqIQ5FmX2DVsZD6MfhBCSBj7f
         Vr9qnxFkh8qAm6l1peOEB+8tONB4tpCJs8C8EK1pr6MdGAD/5BZOexLzFRLqAC6zk7sx
         SZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726004512; x=1726609312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aw+6lFFj6ydEjI4u0rC5LELrB7W3bbCNrFSSnF9eFsE=;
        b=ooQrdbkh6eE0IWVugpgOEoNdCdtANnUANWLyES2Fy1kLbFn/lSYmhdUnCbCk8vsgov
         cwy7LS7L8dx0NoCWSXzYYu2BIAOWItqly7y0TeLlXElmLtJbn08nQMfZQsirZjfs9cid
         t8EKJru7CoOf27YBQkAt0vS1fvlvH7ag/q+6pkZCa4HoI8+59fQwQoDmuXXy9dWSSTEs
         qZTOICdXpJOokFH4RqYwQYh9BVNo88+xO0zNQNl2bp2wHxGjzaKcukqPJPoSrEzhskSg
         f1x/sRGXO8YSB0IglLanukobK+Kz/VZ/9nk+lXz4V+hlEmV/n0N0IufF9OijSNlCgX29
         A17w==
X-Gm-Message-State: AOJu0YxtxRuwlbOjCiyjzp4UGi1Jvjxnn8SXqnO/eS11Who6zlh8607X
	+rpE175+ytK8qP1jXPvkCBkWzhcT9D0rPlvf7IR3329mMOmQoqQ=
X-Google-Smtp-Source: AGHT+IEvOgVrw/812SeiaWST2kBcmXnMbFJk+4080I5B6q/Gwjl34UD296M23Ho2l2tkjto19ArQ+Q==
X-Received: by 2002:a17:90b:4d08:b0:2d3:caeb:a9ad with SMTP id 98e67ed59e1d1-2dad50ed05fmr14690679a91.31.1726004512294;
        Tue, 10 Sep 2024 14:41:52 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db0419ae89sm6989195a91.13.2024.09.10.14.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 14:41:51 -0700 (PDT)
Date: Tue, 10 Sep 2024 14:41:51 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Donald Hunter <donald.hunter@gmail.com>, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
	edumazet@google.com
Subject: Re: [PATCH v7 net-next 11/15] testing: net-drv: add basic shaper test
Message-ID: <ZuC9H5uABXA0-SYo@mini-arch>
References: <cover.1725919039.git.pabeni@redhat.com>
 <5f17d61004db141808b15d50485d0ccb69cbfa12.1725919039.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f17d61004db141808b15d50485d0ccb69cbfa12.1725919039.git.pabeni@redhat.com>

On 09/10, Paolo Abeni wrote:
> Leverage a basic/dummy netdevsim implementation to do functional
> coverage for NL interface.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v5 -> v6:
>   - additional test-cases for delegation and queue reconf
> 
> v4 -> v5:
>   - updated to new driver API
>   - more consistent indentation
> 
> rfc v1 -> v2:
>   - added more test-cases WRT nesting and grouping
> ---
>  drivers/net/Kconfig                           |   1 +
>  drivers/net/netdevsim/ethtool.c               |   2 +
>  drivers/net/netdevsim/netdev.c                |  39 ++
>  tools/testing/selftests/drivers/net/Makefile  |   1 +
>  tools/testing/selftests/drivers/net/shaper.py | 457 ++++++++++++++++++
>  .../testing/selftests/net/lib/py/__init__.py  |   1 +
>  tools/testing/selftests/net/lib/py/ynl.py     |   5 +
>  7 files changed, 506 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/shaper.py
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 9920b3a68ed1..1fd5acdc73c6 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -641,6 +641,7 @@ config NETDEVSIM
>  	depends on PTP_1588_CLOCK_MOCK || PTP_1588_CLOCK_MOCK=n
>  	select NET_DEVLINK
>  	select PAGE_POOL
> +	select NET_SHAPER
>  	help
>  	  This driver is a developer testing tool and software model that can
>  	  be used to test various control path networking APIs, especially
> diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
> index 1436905bc106..5fe1eaef99b5 100644
> --- a/drivers/net/netdevsim/ethtool.c
> +++ b/drivers/net/netdevsim/ethtool.c
> @@ -103,8 +103,10 @@ nsim_set_channels(struct net_device *dev, struct ethtool_channels *ch)
>  	struct netdevsim *ns = netdev_priv(dev);
>  	int err;
>  
> +	mutex_lock(&dev->lock);
>  	err = netif_set_real_num_queues(dev, ch->combined_count,
>  					ch->combined_count);
> +	mutex_unlock(&dev->lock);
>  	if (err)
>  		return err;
>  
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index 017a6102be0a..cad85bb0cf54 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -22,6 +22,7 @@
>  #include <net/netdev_queues.h>
>  #include <net/page_pool/helpers.h>
>  #include <net/netlink.h>
> +#include <net/net_shaper.h>
>  #include <net/pkt_cls.h>
>  #include <net/rtnetlink.h>
>  #include <net/udp_tunnel.h>
> @@ -475,6 +476,43 @@ static int nsim_stop(struct net_device *dev)
>  	return 0;
>  }
>  
> +static int nsim_shaper_set(struct net_shaper_binding *binding,
> +			   const struct net_shaper *shaper,
> +			   struct netlink_ext_ack *extack)
> +{
> +	return 0;
> +}
> +
> +static int nsim_shaper_del(struct net_shaper_binding *binding,
> +			   const struct net_shaper_handle *handle,
> +			   struct netlink_ext_ack *extack)
> +{
> +	return 0;
> +}
> +
> +static int nsim_shaper_group(struct net_shaper_binding *binding,
> +			     int leaves_count,
> +			     const struct net_shaper *leaves,
> +			     const struct net_shaper *root,
> +			     struct netlink_ext_ack *extack)
> +{
> +	return 0;
> +}
> +
> +static void nsim_shaper_cap(struct net_shaper_binding *binding,
> +			    enum net_shaper_scope scope,
> +			    unsigned long *flags)
> +{
> +	*flags = ULONG_MAX;
> +}
> +
> +static const struct net_shaper_ops nsim_shaper_ops = {
> +	.set			= nsim_shaper_set,
> +	.delete			= nsim_shaper_del,
> +	.group			= nsim_shaper_group,
> +	.capabilities		= nsim_shaper_cap,
> +};
> +
>  static const struct net_device_ops nsim_netdev_ops = {
>  	.ndo_start_xmit		= nsim_start_xmit,
>  	.ndo_set_rx_mode	= nsim_set_rx_mode,
> @@ -496,6 +534,7 @@ static const struct net_device_ops nsim_netdev_ops = {
>  	.ndo_bpf		= nsim_bpf,
>  	.ndo_open		= nsim_open,
>  	.ndo_stop		= nsim_stop,
> +	.net_shaper_ops		= &nsim_shaper_ops,
>  };
>  
>  static const struct net_device_ops nsim_vf_netdev_ops = {
> diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
> index 39fb97a8c1df..25aec5c081df 100644
> --- a/tools/testing/selftests/drivers/net/Makefile
> +++ b/tools/testing/selftests/drivers/net/Makefile
> @@ -9,6 +9,7 @@ TEST_PROGS := \
>  	ping.py \
>  	queues.py \
>  	stats.py \
> +	shaper.py
>  # end of TEST_PROGS
>  
>  include ../../lib.mk
> diff --git a/tools/testing/selftests/drivers/net/shaper.py b/tools/testing/selftests/drivers/net/shaper.py
> new file mode 100755
> index 000000000000..3504d51985bc
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/shaper.py
> @@ -0,0 +1,457 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_true, KsftSkipEx
> +from lib.py import EthtoolFamily, NetshaperFamily
> +from lib.py import NetDrvEnv
> +from lib.py import NlError
> +from lib.py import cmd
> +
> +def get_shapers(cfg, nl_shaper) -> None:
> +    try:
> +        shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
> +    except NlError as e:
> +        if e.error == 95:
> +            raise KsftSkipEx("shapers not supported by the device")
> +        raise
> +
> +    # Default configuration: no shapers configured.
> +    ksft_eq(len(shapers), 0)
> +
> +def get_caps(cfg, nl_shaper) -> None:
> +    try:
> +        caps = nl_shaper.cap_get({'ifindex': cfg.ifindex}, dump=True)
> +    except NlError as e:
> +        if e.error == 95:
> +            raise KsftSkipEx("shapers not supported by the device")
> +        raise
> +
> +    # Each device implementing shaper support must support some
> +    # features in at least a scope.
> +    ksft_true(len(caps)> 0)
> +
> +def set_qshapers(cfg, nl_shaper) -> None:
> +    try:
> +        caps = nl_shaper.cap_get({'ifindex': cfg.ifindex,
> +                                 'scope':'queue'})
> +    except NlError as e:
> +        if e.error == 95:
> +            raise KsftSkipEx("shapers not supported by the device")
> +        raise
> +    if not 'support-bw-max' in caps or not 'support-metric-bps' in caps:
> +        raise KsftSkipEx("device does not support queue scope shapers with bw_max and metric bps")
> +
> +    cfg.queues = True;
> +    netnl = EthtoolFamily()
> +    channels = netnl.channels_get({'header': {'dev-index': cfg.ifindex}})
> +    if channels['combined-count'] == 0:
> +        cfg.rx_type = 'rx'
> +        cfg.nr_queues = channels['rx-count']
> +    else:
> +        cfg.rx_type = 'combined'
> +        cfg.nr_queues = channels['combined-count']
> +    if cfg.nr_queues < 3:
> +        raise KsftSkipEx("device does not support enough queues min 3 found {cfg.nr_queues}")
> +
> +    nl_shaper.set({'ifindex': cfg.ifindex,
> +                   'handle': {'scope': 'queue', 'id': 1},
> +                   'metric': 'bps',
> +                   'bw-max': 10000})
> +    nl_shaper.set({'ifindex': cfg.ifindex,
> +                   'handle': {'scope': 'queue', 'id': 2},
> +                   'metric': 'bps',
> +                   'bw-max': 20000})
> +
> +    # Querying a specific shaper not yet configured must fail.
> +    raised = False
> +    try:
> +        shaper_q0 = nl_shaper.get({'ifindex': cfg.ifindex,
> +                                   'handle': {'scope': 'queue', 'id': 0}})
> +    except (NlError):
> +        raised = True
> +    ksft_eq(raised, True)
> +
> +    shaper_q1 = nl_shaper.get({'ifindex': cfg.ifindex,
> +                              'handle': {'scope': 'queue', 'id': 1}})

[..]

> +    ksft_eq(shaper_q1, {'ifindex': cfg.ifindex,
> +                        'parent': {'scope': 'netdev'},
> +                        'handle': {'scope': 'queue', 'id': 1},
> +                        'metric': 'bps',
> +                        'bw-max': 10000})
> +

Before comparison, you probably need to drop some fields that are not
expected? 

# # Check failed {'ifindex': 8, 'parent': {'scope': 'netdev'}, 'handle': {'scope': 'queue', 'id': 1}, 'metric': 'bps', 'bw-min': 517778718638633216, 'bw-max': 10000, 'burst': 18446683600580769792, 'priority': 60858368, 'weight': 4294936704} != {'ifindex': 8, 'parent': {'scope': 'netdev'}, 'handle': {'scope': 'queue', 'id': 1}, 'metric': 'bps', 'bw-max': 10000} 
# # Check| At /home/virtme/testing-18/tools/testing/selftests/drivers/net/./shaper.py, line 83, in set_qshapers:
# # Check|     ksft_eq(shapers, [{'ifindex': cfg.ifindex,
# # Check failed [{'ifindex': 8, 'parent': {'scope': 'netdev'}, 'handle': {'scope': 'queue', 'id': 1}, 'metric': 'bps', 'bw-min': 517778718638633216, 'bw-max': 10000, 'burst': 18446683600580769792, 'priority': 60858368, 'weight': 4294936704}, {'ifindex': 8, 'parent': {'scope': 'netdev'}, 'handle': {'scope': 'queue', 'id': 2}, 'metric': 'bps', 'bw-min': 517778718638633216, 'bw-max': 20000, 'burst': 18446683600580769792, 'priority': 60858368, 'weight': 4294936704}] != [{'ifindex': 8, 'parent': {'scope': 'netdev'}, 'handle': {'scope': 'queue', 'id': 1}, 'metric': 'bps', 'bw-max': 10000}, {'ifindex': 8, 'parent': {'scope': 'netdev'}, 'handle': {'scope': 'queue', 'id': 2}, 'metric': 'bps', 'bw-max': 20000}]

https://netdev-3.bots.linux.dev/vmksft-net-drv-dbg/results/766702/4-shaper-py/stdout

Debug builds are also reporting a UBSAN error:

https://netdev-3.bots.linux.dev/vmksft-net-drv-dbg/results/766702/4-shaper-py/stderr

---
pw-bot: cr


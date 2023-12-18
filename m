Return-Path: <netdev+bounces-58459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AED8C8167F6
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 09:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6559B283120
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 08:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B71101C2;
	Mon, 18 Dec 2023 08:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1BONRs+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AC213FE3
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 08:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5c65ca2e1eeso735263a12.2
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 00:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702887760; x=1703492560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zau/JatSH7MN7K5B/zm+elLYDg0JQrNA93ntWIyNs+M=;
        b=A1BONRs+EMepVmaI0ytI20BjjwXKm3vSWQraWQ+vk/gvr7C9ChwHCGmkffQrSZ+Nom
         tKz8CCuU8/aLWL028Dr7+wZX8r/QH8LXuEo8c+XPvK2rIwTeJK2lKvurafLaA4USDWJM
         u697GAPkvOnA7yM2bBunFJPmSSXInAdoqLXJ2j3YTQkrlNcw7B3SgYthDY7NCPYSgysS
         qXXldlHHhDXwnII/IH/453b6vKxbwf7OTlAZfFP27jSKeUwUO032urXrcflXNcvwnklG
         tX7SQDnfAbk2czSD+zEpXfR/h/QP1JAoDVTlAX0xUj92w5RZ/HxwBksMxhDKNJwCGf9C
         SgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702887760; x=1703492560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zau/JatSH7MN7K5B/zm+elLYDg0JQrNA93ntWIyNs+M=;
        b=K0JdMDaA/ztePMn2UFa/RRfgC4Ydhgv85IoixtjBhUuSwPyt4nl3xiq1Am/YH5qpnA
         cOBR1b0T9eWQAwl3wKbndM6yxNUAuwCJXgMluP49QWNQEJhwUtGFtGQlaQ0s/hfhrsrk
         kovem3STrDnk+1mukYynp805wgpu4ZLFp2kMWBqeue7rNM7BTIiN4p7Y/vuqkAupd1aI
         yZd9eb/4kQ2ThNeKQDSV3ylvZ6pQkOzJsRqlST6a6rLYH81BmcEyonPAzaYR9hU9YV+e
         2GmyHwC9TaBJLBjN7JWaN0TGAf66h/1p25+scO/YvnN+jJanYaasoX97ME5ybg1/b7d+
         tHrg==
X-Gm-Message-State: AOJu0YzjkXkcB79qnTkLRcDY/jpHd3lWGe4SqU09wbFlNSUaczvtPMRJ
	sgTEApnFBfhxhKZBg1OD28zyC0pkRcQsm+RSfJ0=
X-Google-Smtp-Source: AGHT+IFtxMYhQV216xRWzeecnxjuJ1IXbRBR9KiR/zpjaVw9kuZsaIhxJNXGSx6ZWolu7j/0EWv3dA==
X-Received: by 2002:a05:6a20:7fa6:b0:18f:fbe4:ca80 with SMTP id d38-20020a056a207fa600b0018ffbe4ca80mr6955083pzj.63.1702887759720;
        Mon, 18 Dec 2023 00:22:39 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902c40900b001bc676df6a9sm18416562plk.132.2023.12.18.00.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 00:22:39 -0800 (PST)
Date: Mon, 18 Dec 2023 16:22:29 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, roopa@nvidia.com, razor@blackwall.org,
	petrm@nvidia.com
Subject: Re: [PATCH net-next 8/9] selftests: bridge_mdb: Add MDB bulk
 deletion test
Message-ID: <ZYABRWdw798FbaTf@Laptop-X1>
References: <20231217083244.4076193-1-idosch@nvidia.com>
 <20231217083244.4076193-9-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231217083244.4076193-9-idosch@nvidia.com>

On Sun, Dec 17, 2023 at 10:32:43AM +0200, Ido Schimmel wrote:
> Add test cases to verify the behavior of the MDB bulk deletion
> functionality in the bridge driver.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Acked-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

> ---
>  .../selftests/net/forwarding/bridge_mdb.sh    | 191 +++++++++++++++++-
>  1 file changed, 189 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
> index e4e3e9405056..61348f71728c 100755
> --- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
> +++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
> @@ -803,11 +803,198 @@ cfg_test_dump()
>  	cfg_test_dump_common "L2" l2_grps_get
>  }
>  
> +# Check flush functionality with different parameters.
> +cfg_test_flush()
> +{
> +	local num_entries
> +
> +	# Add entries with different attributes and check that they are all
> +	# flushed when the flush command is given with no parameters.
> +
> +	# Different port.
> +	bridge mdb add dev br0 port $swp1 grp 239.1.1.1 vid 10
> +	bridge mdb add dev br0 port $swp2 grp 239.1.1.2 vid 10
> +
> +	# Different VLAN ID.
> +	bridge mdb add dev br0 port $swp1 grp 239.1.1.3 vid 10
> +	bridge mdb add dev br0 port $swp1 grp 239.1.1.4 vid 20
> +
> +	# Different routing protocol.
> +	bridge mdb add dev br0 port $swp1 grp 239.1.1.5 vid 10 proto bgp
> +	bridge mdb add dev br0 port $swp1 grp 239.1.1.6 vid 10 proto zebra
> +
> +	# Different state.
> +	bridge mdb add dev br0 port $swp1 grp 239.1.1.7 vid 10 permanent
> +	bridge mdb add dev br0 port $swp1 grp 239.1.1.8 vid 10 temp
> +
> +	bridge mdb flush dev br0
> +	num_entries=$(bridge mdb show dev br0 | wc -l)
> +	[[ $num_entries -eq 0 ]]
> +	check_err $? 0 "Not all entries flushed after flush all"
> +
> +	# Check that when flushing by port only entries programmed with the
> +	# specified port are flushed and the rest are not.
> +
> +	bridge mdb add dev br0 port $swp1 grp 239.1.1.1 vid 10
> +	bridge mdb add dev br0 port $swp2 grp 239.1.1.1 vid 10
> +	bridge mdb add dev br0 port br0 grp 239.1.1.1 vid 10
> +
> +	bridge mdb flush dev br0 port $swp1
> +
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port $swp1"
> +	check_fail $? "Entry not flushed by specified port"
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port $swp2"
> +	check_err $? "Entry flushed by wrong port"
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port br0"
> +	check_err $? "Host entry flushed by wrong port"
> +
> +	bridge mdb flush dev br0 port br0
> +
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port br0"
> +	check_fail $? "Host entry not flushed by specified port"
> +
> +	bridge mdb flush dev br0
> +
> +	# Check that when flushing by VLAN ID only entries programmed with the
> +	# specified VLAN ID are flushed and the rest are not.
> +
> +	bridge mdb add dev br0 port $swp1 grp 239.1.1.1 vid 10
> +	bridge mdb add dev br0 port $swp2 grp 239.1.1.1 vid 10
> +	bridge mdb add dev br0 port $swp1 grp 239.1.1.1 vid 20
> +	bridge mdb add dev br0 port $swp2 grp 239.1.1.1 vid 20
> +
> +	bridge mdb flush dev br0 vid 10
> +
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 10 &> /dev/null
> +	check_fail $? "Entry not flushed by specified VLAN ID"
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 20 &> /dev/null
> +	check_err $? "Entry flushed by wrong VLAN ID"
> +
> +	bridge mdb flush dev br0
> +
> +	# Check that all permanent entries are flushed when "permanent" is
> +	# specified and that temporary entries are not.
> +
> +	bridge mdb add dev br0 port $swp1 grp 239.1.1.1 permanent vid 10
> +	bridge mdb add dev br0 port $swp2 grp 239.1.1.1 temp vid 10
> +
> +	bridge mdb flush dev br0 permanent
> +
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port $swp1"
> +	check_fail $? "Entry not flushed by \"permanent\" state"
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port $swp2"
> +	check_err $? "Entry flushed by wrong state (\"permanent\")"
> +
> +	bridge mdb flush dev br0
> +
> +	# Check that all temporary entries are flushed when "nopermanent" is
> +	# specified and that permanent entries are not.
> +
> +	bridge mdb add dev br0 port $swp1 grp 239.1.1.1 permanent vid 10
> +	bridge mdb add dev br0 port $swp2 grp 239.1.1.1 temp vid 10
> +
> +	bridge mdb flush dev br0 nopermanent
> +
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port $swp1"
> +	check_err $? "Entry flushed by wrong state (\"nopermanent\")"
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port $swp2"
> +	check_fail $? "Entry not flushed by \"nopermanent\" state"
> +
> +	bridge mdb flush dev br0
> +
> +	# Check that L2 host entries are not flushed when "nopermanent" is
> +	# specified, but flushed when "permanent" is specified.
> +
> +	bridge mdb add dev br0 port br0 grp 01:02:03:04:05:06 permanent vid 10
> +
> +	bridge mdb flush dev br0 nopermanent
> +
> +	bridge mdb get dev br0 grp 01:02:03:04:05:06 vid 10 &> /dev/null
> +	check_err $? "L2 host entry flushed by wrong state (\"nopermanent\")"
> +
> +	bridge mdb flush dev br0 permanent
> +
> +	bridge mdb get dev br0 grp 01:02:03:04:05:06 vid 10 &> /dev/null
> +	check_fail $? "L2 host entry not flushed by \"permanent\" state"
> +
> +	bridge mdb flush dev br0
> +
> +	# Check that IPv4 host entries are not flushed when "permanent" is
> +	# specified, but flushed when "nopermanent" is specified.
> +
> +	bridge mdb add dev br0 port br0 grp 239.1.1.1 temp vid 10
> +
> +	bridge mdb flush dev br0 permanent
> +
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 10 &> /dev/null
> +	check_err $? "IPv4 host entry flushed by wrong state (\"permanent\")"
> +
> +	bridge mdb flush dev br0 nopermanent
> +
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 10 &> /dev/null
> +	check_fail $? "IPv4 host entry not flushed by \"nopermanent\" state"
> +
> +	bridge mdb flush dev br0
> +
> +	# Check that IPv6 host entries are not flushed when "permanent" is
> +	# specified, but flushed when "nopermanent" is specified.
> +
> +	bridge mdb add dev br0 port br0 grp ff0e::1 temp vid 10
> +
> +	bridge mdb flush dev br0 permanent
> +
> +	bridge mdb get dev br0 grp ff0e::1 vid 10 &> /dev/null
> +	check_err $? "IPv6 host entry flushed by wrong state (\"permanent\")"
> +
> +	bridge mdb flush dev br0 nopermanent
> +
> +	bridge mdb get dev br0 grp ff0e::1 vid 10 &> /dev/null
> +	check_fail $? "IPv6 host entry not flushed by \"nopermanent\" state"
> +
> +	bridge mdb flush dev br0
> +
> +	# Check that when flushing by routing protocol only entries programmed
> +	# with the specified routing protocol are flushed and the rest are not.
> +
> +	bridge mdb add dev br0 port $swp1 grp 239.1.1.1 vid 10 proto bgp
> +	bridge mdb add dev br0 port $swp2 grp 239.1.1.1 vid 10 proto zebra
> +	bridge mdb add dev br0 port br0 grp 239.1.1.1 vid 10
> +
> +	bridge mdb flush dev br0 proto bgp
> +
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port $swp1"
> +	check_fail $? "Entry not flushed by specified routing protocol"
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port $swp2"
> +	check_err $? "Entry flushed by wrong routing protocol"
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port br0"
> +	check_err $? "Host entry flushed by wrong routing protocol"
> +
> +	bridge mdb flush dev br0
> +
> +	# Test that an error is returned when trying to flush using unsupported
> +	# parameters.
> +
> +	bridge mdb flush dev br0 src_vni 10 &> /dev/null
> +	check_fail $? "Managed to flush by source VNI"
> +
> +	bridge mdb flush dev br0 dst 198.51.100.1 &> /dev/null
> +	check_fail $? "Managed to flush by destination IP"
> +
> +	bridge mdb flush dev br0 dst_port 4789 &> /dev/null
> +	check_fail $? "Managed to flush by UDP destination port"
> +
> +	bridge mdb flush dev br0 vni 10 &> /dev/null
> +	check_fail $? "Managed to flush by destination VNI"
> +
> +	log_test "Flush tests"
> +}
> +
>  cfg_test()
>  {
>  	cfg_test_host
>  	cfg_test_port
>  	cfg_test_dump
> +	cfg_test_flush
>  }
>  
>  __fwd_test_host_ip()
> @@ -1166,8 +1353,8 @@ ctrl_test()
>  	ctrl_mldv2_is_in_test
>  }
>  
> -if ! bridge mdb help 2>&1 | grep -q "get"; then
> -	echo "SKIP: iproute2 too old, missing bridge mdb get support"
> +if ! bridge mdb help 2>&1 | grep -q "flush"; then
> +	echo "SKIP: iproute2 too old, missing bridge mdb flush support"
>  	exit $ksft_skip
>  fi
>  
> -- 
> 2.40.1
> 


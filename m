Return-Path: <netdev+bounces-278075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EitDORfq3GkZYQkAu9opvQ
	(envelope-from <netdev+bounces-278075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 15:05:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 984D43EC56D
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 15:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 186A9300CC83
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16993CAE93;
	Mon, 13 Apr 2026 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BV0pQeUP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+S7GKpT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4423C9EDD
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776085521; cv=none; b=qVrAQ2VNEnSuwjzHuJ7OaSN8ujI6yxfs1RhB6z1Ok1yERJBlnPE/ytMPOz66U7kSn7i8yafBtQ1wG/FXMDfR3+Mxp43Eeje7XYbdxYWOhGGTbjMtieQXcfRCARmJzD9M0uMA3Gs1/6wnY729qv4S0C6roP3gXNvXyQlMpv5V7ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776085521; c=relaxed/simple;
	bh=8G0n+5N46kyHlC6zW0UIk+1mROJfOmueHkVVdUErsrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XxwdnXfL2vRAsfexCIHLCLE4GGiSEJoFU9LQ3bWQgIFaUW33gw0XRYg2DPnD59wzHZqSG62UBu8kg56PMQ79EeXI1+SZ+rtUP9MbOlxMWAmbAgtKAMbIqqSn0lLc2qsMxhAAhRx+V+RFTqRrJn8CoAhdZT25Tk0cIEjlIvcmlOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BV0pQeUP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=T+S7GKpT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776085519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zd81MzorX7tMHzshw5o/gcRBDu2OrmNaB6rEAdDyIBo=;
	b=BV0pQeUPkhcxiDaJ08gZZhs47m50Qryr6mKNyQH2INym0vKJMExvF2WVe0rYsF6TNjYSTc
	5EW79UUOKA+rM6Xa7sBdIcxn8tqFikvdkUlA2CjQnUScbjBDc6ncW5PrPHT3DLsBKX1x5P
	mzTgNkAndSYpXxD7o7LUnBXGvJtBXLA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-RmVZk3wgMlCycySbXgp7yA-1; Mon, 13 Apr 2026 09:05:16 -0400
X-MC-Unique: RmVZk3wgMlCycySbXgp7yA-1
X-Mimecast-MFC-AGG-ID: RmVZk3wgMlCycySbXgp7yA_1776085514
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d1dea12aaso3208729f8f.1
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 06:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776085514; x=1776690314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zd81MzorX7tMHzshw5o/gcRBDu2OrmNaB6rEAdDyIBo=;
        b=T+S7GKpTBSaPLqw3NI2UL77h0V9ySQMduOJ7cvh1wgdDesLkBAA2LrwtMK9DaWSkJX
         2kgdfZn2ZuHqzRpZ/yIdx60bRhvfwbPPAgOhtK8yseErIVvn+VSEyLnA+N+pIBOXmFwN
         rdnuHZV2Diuj/znPfGKXuNIP9fsjDkv8M7uO/afXVbN3SQbO4sM8LgbbRb5uup/vOYIs
         Od/Mi4kd6HwQMFrglPs8WuIRqRy7dEi6uacIdvYoV/Pk5S2a0FIaJAYhNEmcQflwyJCQ
         AeZNlM+eAA0EvRxnY5d74VoaFDBYBPdoaQzdddPz0eVUeDaqChh4yXxFUbqM+SN2Y/k2
         aXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776085514; x=1776690314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zd81MzorX7tMHzshw5o/gcRBDu2OrmNaB6rEAdDyIBo=;
        b=kH0A4Cm3s6SCn5fFzKfxVlbxzjQkAkycWwkoDM3fVWvuQPTu2i17iClzpBidOVrGWT
         c06BLf4nyybKHaZzbQYSAw+EDQhnGCidn0iytC/LZJRQcttomAjJUbUcEZgY+ViaT1zP
         V4nSA+6Dc6QGuzbxt+3vb4bxoxtI+wS0p5gwn56YOyteuq9VeESEfzFtGXwwTCaz7rym
         jsNmGOsZQIUEAxzirdX1gzg2HqLfjVpyhWgIjBlGWVMnT6iVqW6bO/VJ7w+MsuIHWhEX
         BThmUdDfcPTksaYpZn25SYBi+/wFlt8SvGLHv+MJQuV+jBbIadrGaUj8aXruq7RkIPxS
         7HHw==
X-Gm-Message-State: AOJu0Yx55v7IJb1dja5j4dQVHXj4arSxJWelHjwLUhgV2Ltoad+73w2U
	yJnOLrJbFqI9kywQBNUz8DlZvv15p54FJ+baCHq+VfgCpSihT4FrTEYezbJy/JwwbKd7+wM6z7Z
	W3xP5/urtFxq1RPyrFXOUKxeTjyhJn0w1mqNvfDkNn83qKQ/o90Hmijiv+A==
X-Gm-Gg: AeBDietxUXp4R0B/NBxx4CkXyN3djWqkCAc9QKCKRZIZT6pU5/LtuSN+VhD55pgy4hb
	PdffxUW923DZx52lqd3eCw2vdQKKoPn8XKC8eNbg0WgJQVhX/8MBrdwsVZWokuPYSoL3OlQvsgv
	BH/3ELwbfqK+0UE10w3LHeVkp7fr+8OywtyVIqUAnvyplTFLTQTFg0knp/lB/hBpcx+EQIDPDxf
	TgfNIWwYjqujFDJevxcKSl97rm2X6uBTquNEUPlrLQvTb6wvSOFJB9ueNpVcUYmrZk43qmYF/n0
	6+amPGfw0S4Q3F+QNHsmmSGS2bScyiZBAiKK5ORUiAZHqXp1HyrZ8ckyqZFUuZvW+y0tFMu55q8
	6t0c+ljRPNYdqUi+QaSFwp7P40UOpJ3PqFbWsVpWqYaSjD8qKTErQLKFl
X-Received: by 2002:a05:600c:681:b0:488:e192:6fbd with SMTP id 5b1f17b1804b1-488e192710cmr60961355e9.30.1776085512954;
        Mon, 13 Apr 2026 06:05:12 -0700 (PDT)
X-Received: by 2002:a05:600c:681:b0:488:e192:6fbd with SMTP id 5b1f17b1804b1-488e192710cmr60960105e9.30.1776085512328;
        Mon, 13 Apr 2026 06:05:12 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67ce3e4sm209725325e9.5.2026.04.13.06.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 06:05:11 -0700 (PDT)
Message-ID: <ce718e68-22bb-40bc-a046-8fc9b636590b@redhat.com>
Date: Mon, 13 Apr 2026 15:05:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 04/10] selftests: net: Add tests for failover
 of team-aggregated ports
To: Marc Harvey <marcharvey@google.com>, Jiri Pirko <jiri@resnulli.us>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>
References: <20260409-teaming-driver-internal-v7-0-f47e7589685d@google.com>
 <20260409-teaming-driver-internal-v7-4-f47e7589685d@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260409-teaming-driver-internal-v7-4-f47e7589685d@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278075-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,team_lib.sh:url,refleak.sh:url,options.sh:url]
X-Rspamd-Queue-Id: 984D43EC56D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/9/26 4:59 AM, Marc Harvey wrote:
> There are currently no kernel tests that verify the effect of setting
> the enabled team driver option. In a followup patch, there will be
> changes to this option, so it will be important to make sure it still
> behaves as it does now.
> 
> The test verifies that tcp continues to work across two different team
> devices in separate network namespaces, even when member links are
> manually disabled.
> 
> Signed-off-by: Marc Harvey <marcharvey@google.com>
> ---
> Changes in v6:
> - Use a tcp port with no associated service.
> - Make tcpdump helper function not string-replace port numbers with
>   associated service names, even on Fedora, which has a tcpdump patch
>   that changes the required flag.
> - Link to v5: https://lore.kernel.org/netdev/20260406-teaming-driver-internal-v5-4-e8a3f348a1c5@google.com/
> 
> Changes in v5:
> - Use tcpdump for collecting traffic, rather than reading rx counters.
> - Link to v4: https://lore.kernel.org/netdev/20260403-teaming-driver-internal-v4-4-d3032f33ca25@google.com/
> 
> Changes in v2:
> - Fix shellcheck failures.
> - Remove dependency on net forwarding lib and pipe viewer tools.
> - Use iperf3 for tcp instead of netcat.
> - Link to v1: https://lore.kernel.org/all/20260331053353.2504254-5-marcharvey@google.com/
> ---
>  tools/testing/selftests/drivers/net/team/Makefile  |   2 +
>  tools/testing/selftests/drivers/net/team/config    |   4 +
>  .../testing/selftests/drivers/net/team/team_lib.sh | 148 +++++++++++++++++++
>  .../drivers/net/team/transmit_failover.sh          | 158 +++++++++++++++++++++
>  tools/testing/selftests/net/forwarding/lib.sh      |   9 +-
>  5 files changed, 319 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/team/Makefile b/tools/testing/selftests/drivers/net/team/Makefile
> index 02d6f51d5a06..777da2e0429e 100644
> --- a/tools/testing/selftests/drivers/net/team/Makefile
> +++ b/tools/testing/selftests/drivers/net/team/Makefile
> @@ -7,9 +7,11 @@ TEST_PROGS := \
>  	options.sh \
>  	propagation.sh \
>  	refleak.sh \
> +	transmit_failover.sh \
>  # end of TEST_PROGS
>  
>  TEST_INCLUDES := \
> +	team_lib.sh \
>  	../bonding/lag_lib.sh \
>  	../../../net/forwarding/lib.sh \
>  	../../../net/in_netns.sh \
> diff --git a/tools/testing/selftests/drivers/net/team/config b/tools/testing/selftests/drivers/net/team/config
> index 5d36a22ef080..8f04ae419c53 100644
> --- a/tools/testing/selftests/drivers/net/team/config
> +++ b/tools/testing/selftests/drivers/net/team/config
> @@ -6,4 +6,8 @@ CONFIG_NETDEVSIM=m
>  CONFIG_NET_IPGRE=y
>  CONFIG_NET_TEAM=y
>  CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=y
> +CONFIG_NET_TEAM_MODE_BROADCAST=y
>  CONFIG_NET_TEAM_MODE_LOADBALANCE=y
> +CONFIG_NET_TEAM_MODE_RANDOM=y
> +CONFIG_NET_TEAM_MODE_ROUNDROBIN=y
> +CONFIG_VETH=y
> diff --git a/tools/testing/selftests/drivers/net/team/team_lib.sh b/tools/testing/selftests/drivers/net/team/team_lib.sh
> new file mode 100644
> index 000000000000..2057f5edee79
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/team/team_lib.sh
> @@ -0,0 +1,148 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +test_dir="$(dirname "$0")"
> +export REQUIRE_MZ=no
> +export NUM_NETIFS=0
> +# shellcheck disable=SC1091
> +source "${test_dir}/../../../net/forwarding/lib.sh"
> +
> +TCP_PORT="43434"
> +
> +# Create a team interface inside of a given network namespace with a given
> +# mode, members, and IP address.
> +# Arguments:
> +#  namespace - Network namespace to put the team interface into.
> +#  team - The name of the team interface to setup.
> +#  mode - The team mode of the interface.
> +#  ip_address - The IP address to assign to the team interface.
> +#  prefix_length - The prefix length for the IP address subnet.
> +#  $@ - members - The member interfaces of the aggregation.
> +setup_team()
> +{
> +	local namespace=$1
> +	local team=$2
> +	local mode=$3
> +	local ip_address=$4
> +	local prefix_length=$5
> +	shift 5
> +	local members=("$@")
> +
> +	# Prerequisite: team must have no members
> +	for member in "${members[@]}"; do
> +		ip -n "${namespace}" link set "${member}" nomaster
> +	done
> +
> +	# Prerequisite: team must have no address in order to set it
> +	# shellcheck disable=SC2086
> +	ip -n "${namespace}" addr del "${ip_address}/${prefix_length}" \
> +			${NODAD} dev "${team}"
> +
> +	echo "Setting team in ${namespace} to mode ${mode}"
> +
> +	if ! ip -n "${namespace}" link set "${team}" down; then
> +		echo "Failed to bring team device down"
> +		return 1
> +	fi
> +	if ! ip netns exec "${namespace}" teamnl "${team}" setoption mode \
> +			"${mode}"; then
> +		echo "Failed to set ${team} mode to '${mode}'"
> +		return 1
> +	fi
> +
> +	# Aggregate the members into teams.
> +	for member in "${members[@]}"; do
> +		ip -n "${namespace}" link set "${member}" master "${team}"
> +	done
> +
> +	# Bring team devices up and give them addresses.
> +	if ! ip -n "${namespace}" link set "${team}" up; then
> +		echo "Failed to set ${team} up"
> +		return 1
> +	fi
> +
> +	# shellcheck disable=SC2086
> +	if ! ip -n "${namespace}" addr add "${ip_address}/${prefix_length}" \
> +			${NODAD} dev "${team}"; then
> +		echo "Failed to give ${team} IP address in ${namespace}"
> +		return 1
> +	fi
> +}
> +
> +# This is global used to keep track of the sender's iperf3 process, so that it
> +# can be terminated.
> +declare sender_pid
> +
> +# Start sending and receiving TCP traffic with iperf3.
> +# Globals:
> +#  sender_pid - The process ID of the iperf3 sender process. Used to kill it
> +#  later.
> +start_listening_and_sending()
> +{
> +	ip netns exec "${NS2}" iperf3 -s -p "${TCP_PORT}" --logfile /dev/null &
> +	# Wait for server to become reachable before starting client.
> +	slowwait 5 ip netns exec "${NS1}" iperf3 -c "${NS2_IP}" -p \
> +			"${TCP_PORT}" -t 1 --logfile /dev/null

Note for a possible follow-up: the iperf3 server is apparently never
stopped. You could used the wait_local_port_listen helper and
the`--one-off` iperf3 command line argument to avoid that (or explicitly
killing the server pid at cleanup time)

/P



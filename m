Return-Path: <netdev+bounces-246178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69177CE4B84
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 13:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F09383009F96
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 12:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A0225F7B9;
	Sun, 28 Dec 2025 12:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cDDPu/Ae";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ojd+fYAW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6192673B7
	for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766924061; cv=none; b=JoNoMqi3+MozNeR+Np1sNqcM82C4v6+s70KpfrPVHiq8yWnR3D/zDcp87j///d9SDYk18PBVe5Jo9I+j4ZIQ61WKCXPgSeGW2tKUU8BhtA0EVQQRpSDjZkcWGyeg/0FjETDANX3ANjZ3Z/Xf2oQSM0miNpN1V94mPn9JzfZSz3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766924061; c=relaxed/simple;
	bh=FtVcvjSqO79VVhAexiQ8Tk6eQRe2bnLHlHrLLXC2qLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYyulS2UIWqjCjdWkrpHMNfHtQozetN5ctTgqfllNegvnsAQ4NXur0eB12pybxPFNFPHo/RaQZ2SqaPdPsUEt8yDcwwk1GthVN9v93P2IVld3mVVT7xgr7iOazeTpPLg0fhJNYJ23H5/IQnq+adgJEiyHzXdDAHmHKJuV4Vm8g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cDDPu/Ae; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ojd+fYAW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766924054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hb94p/3fW6d+zrjNPqtXlJMQflYVyrGPy+23bPGAbt4=;
	b=cDDPu/Ae6Ft9os0G6pLSfXUZ2tRiVED+rBwssSwUByojZ4/ddILuKV/pvb7kQtcQ7AZ+Fc
	Vy/vbKWavW3nxpEWHWED0iRZ0rt7t8URQFa8BDOYqsIUE2nASA1jkdAYOtBrVeY2M7QUO6
	fuK6tpZV0P9vqmq6vly4TskWNIzNuu4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-BTCEE3vSNcyfNk6LfNQVaA-1; Sun, 28 Dec 2025 07:14:13 -0500
X-MC-Unique: BTCEE3vSNcyfNk6LfNQVaA-1
X-Mimecast-MFC-AGG-ID: BTCEE3vSNcyfNk6LfNQVaA_1766924052
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430fcf10280so6164740f8f.0
        for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 04:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766924052; x=1767528852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hb94p/3fW6d+zrjNPqtXlJMQflYVyrGPy+23bPGAbt4=;
        b=ojd+fYAWW18I3d/0CJqUhGSxyzzvsReXbb7acrRNDj24AO18YJ1dIa/8akDyNkwc+9
         neaRI2S1oYkvDXygWJ2Kpjp2NfPlea8UczGg/ZDhhGN26w4x0HQQpVHO7Ip71NqfrBLF
         fCaSG6lVak9PGwnb6wfGV1MwismkuhjpIp3Kv5OY7y/GybW0X0ZupAku02tJwdLeJGMQ
         Efqb0aumCgoXOrtLRNMH07R/WAj4Wobl/IDyL3l2dikGKSr5cNfQKzXwlO+/I6PXkxkT
         C04y/7svEuimzDg+ODpyym5bHMx2pqK06dXoHjQjCFYXCLBIMkS3N3xdERbgx7HTnJoi
         KRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766924052; x=1767528852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hb94p/3fW6d+zrjNPqtXlJMQflYVyrGPy+23bPGAbt4=;
        b=qzgkDPqR8glXzFhIXVrviVHdG/2wG7qHqFV7hHm9r2x65raUR7kRhb7CdS8Mlgv2JH
         IVRKkFwdN1qS/RAG6SlpXin2ju0lh+/ti9OiakkYpmeeOJuFmROzEQeIM//TKjjsizLu
         XsaADJni5zLL2rxI7O11UI4zUvObiq28U6m23uH5vfVJbU6ScZuHu9yFmqkf+pVdyqPl
         j+9pqk9eCeGfQcFGjcLoj4X0oyR+B3b7wEoCzEwsn9IEH4/DagL3eK8mkmO5V2OkMoNj
         rzMWJPGUCXv6rvnv1YiSPwOWH6pR7bVp79y9c47M4PEDJVjJI2LPnAGP02UFubC1aUs6
         Y5SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUjduqNh6hU0eLwxlAupkAVdiEw+N3fCXeJ2JvbH5uUYuEBGpVD9LGlUqiAbKwDqTiN2ug0So=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiX03WadpHyyi99ruvOXjPoHdIrF5uPtg2Njn8vWD0cBQyYymF
	TJFMdR9okNPrMW3Wkn5MFFJFwVTO1uNQntlsBI6fgMuVRVgTlAfK/dlCwckhRpNpHnXQgJ8FFgY
	fmu1hApZeMGVG5hzjkNc+hxYC3+d4HJxoMWtEtBaOZTmx6bLnULVfX+Dz0Q==
X-Gm-Gg: AY/fxX7ZkaRYKr7qNM4Eqisev9IZcsrhoUHvAFP24MYSfQ9Jgzg7RWbna+cAnSsUATz
	0cCVqIGJvBajqffW0ORCQNHJL1H30IWIJ/Lj/eelbpiuXFwukjOJi9Wt+FVmsp3ooCZzplo8Fqm
	bXB7axKmkPZsNHNQCB2vyNva3Smie6hv5KPZmhMSvCVt44zVFb+usxcoplD9miYEI5xramkeiWr
	BwtfY7Qm+bcRTqUJr9sOcivv6r0oHol3VPhAv6NVMHMSsyOQVq0oIepKU8DKMn0hFONihMljqSV
	1TY2KChwBmJb3v4EBhZkyJswtVAiPyj+9hRkLk+PK8/tj3D3W5XU9gOu1XHzZVRv1eKPwAT2We6
	ND9OVmuGcDFRyHg==
X-Received: by 2002:a05:6000:40ce:b0:42f:bad7:af76 with SMTP id ffacd0b85a97d-4324e4cc00amr39273445f8f.15.1766924051777;
        Sun, 28 Dec 2025 04:14:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9s6P8gOpSpbWlos80FLDLxQgg0IlYWd5InaHc47tKRrvQ/Asn43slk7o17Wv+jnvFEa+z9Q==
X-Received: by 2002:a05:6000:40ce:b0:42f:bad7:af76 with SMTP id ffacd0b85a97d-4324e4cc00amr39273422f8f.15.1766924051343;
        Sun, 28 Dec 2025 04:14:11 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa4749sm57106837f8f.37.2025.12.28.04.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Dec 2025 04:14:10 -0800 (PST)
Message-ID: <16fa929d-db04-48f5-a350-a31d23f8327c@redhat.com>
Date: Sun, 28 Dec 2025 13:14:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] selftests: net: simple selftest for ipvtap
To: Dmitry Skorodumov <dskr99@gmail.com>, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20251225185543.1459044-1-skorodumov.dmitry@huawei.com>
 <20251225185543.1459044-3-skorodumov.dmitry@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251225185543.1459044-3-skorodumov.dmitry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/25/25 7:55 PM, Dmitry Skorodumov wrote:
> diff --git a/tools/testing/selftests/net/ipvtap_test.sh b/tools/testing/selftests/net/ipvtap_test.sh
> new file mode 100755
> index 000000000000..751793f26fed
> --- /dev/null
> +++ b/tools/testing/selftests/net/ipvtap_test.sh
> @@ -0,0 +1,168 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Simple tests for ipvtap
> +
> +
> +#
> +# The testing environment looks this way:
> +#
> +# |------HOST------|     |------PHY-------|
> +# |      veth<----------------->veth      |
> +# |------|--|------|     |----------------|
> +#        |  |
> +#        |  |            |-----TST0-------|
> +#        |  |------------|----ipvlan      |
> +#        |               |----------------|
> +#        |
> +#        |               |-----TST1-------|
> +#        |---------------|----ipvlan      |
> +#                        |----------------|
> +#
> +
> +ALL_TESTS="
> +	test_ip_set
> +"
> +
> +source lib.sh
> +
> +DEBUG=0
> +
> +VETH_HOST=vethtst.h
> +VETH_PHY=vethtst.p
> +
> +NS_COUNT=32
> +IP_ITERATIONS=1024
> +
> +ns_run() {
> +	ns=$1
> +	shift
> +	if [[ "$ns" == "global" ]]; then
> +		"$@" >/dev/null
> +	else
> +		ip netns exec "$ns" "$@" >/dev/null
> +	fi
> +}
> +
> +test_ip_setup_env() {
> +	modprobe -q tap
> +	modprobe -q ipvlan
> +	modprobe -q ipvtap
> +
> +	setup_ns NS_PHY
> +
> +	# setup simulated other-host (phy) and host itself
> +	ip link add $VETH_HOST type veth peer name $VETH_PHY \
> +		netns "$NS_PHY" >/dev/null

It would be better to avoid creating devices in the main netns.

> +	ip link set $VETH_HOST up
> +	ns_run "$NS_PHY" ip link set $VETH_PHY up
> +
> +	for ((i=0; i<NS_COUNT; i++)); do
> +		setup_ns ipvlan_ns_$i
> +		ns="ipvlan_ns_$i"
> +		if [ "$DEBUG" = "1" ]; then
> +			echo "created NS ${!ns}"
> +		fi
> +		if ! ip link add netns ${!ns} ipvlan0 link $VETH_HOST \
> +		    type ipvtap mode l2 bridge; then
> +			exit_error "FAIL: Failed to configure ipvlan link."
> +		fi
> +	done
> +}
> +
> +test_ip_cleanup_env() {
> +	ip link del $VETH_HOST
> +	cleanup_all_ns
> +}
> +
> +exit_error() {
> +	echo "$1"
> +	exit $ksft_fail
> +}
> +
> +rnd() {
> +	echo $(( RANDOM % 32 + 16 ))
> +}
> +
> +test_ip_set_thread() {
> +	ip link set ipvlan0 up
> +	for ((i=0; i<IP_ITERATIONS; i++)); do
> +		v=$(rnd)
> +		ip a a "172.25.0.$v/24" dev ipvlan0 2>/dev/null
> +		ip a a "fc00::$v/64" dev ipvlan0 2>/dev/null
> +		v=$(rnd)
> +		ip a d "172.25.0.$v/24" dev ipvlan0 2>/dev/null
> +		ip a d "fc00::$v/64" dev ipvlan0 2>/dev/null

It's unclear to me why the above tries to remove random addresses
different from the ones just added (possibly not existing)

> +	done
> +}
> +
> +test_ip_set() {
> +	RET=0
> +
> +	modprobe -q tap
> +	modprobe -q ipvlan
> +	modprobe -q ipvtap
> +
> +	trap test_ip_cleanup_env EXIT
> +
> +	test_ip_setup_env
> +
> +	declare -A ns_pids
> +	for ((i=0; i<NS_COUNT; i++)); do
> +		ns="ipvlan_ns_$i"
> +		ns_run ${!ns} bash -c "$0 test_ip_set_thread"&
> +		ns_pids[$i]=$!
> +	done
> +
> +	for ((i=0; i<NS_COUNT; i++)); do
> +		wait "${ns_pids[$i]}"
> +	done

This tests fails quite often in debug build due to timeout, see:

https://netdev.bots.linux.dev/flakes.html?tn-needle=ipvtap

and i.e.

https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-dbg/results/447821/5-ipvtap-test-sh/

You should likely decrease the thread and/or iterations count, at least
for debug builds

/P



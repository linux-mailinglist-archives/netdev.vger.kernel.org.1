Return-Path: <netdev+bounces-212826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C3EB222F8
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 11:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9883C4E278C
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 09:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F472E92A6;
	Tue, 12 Aug 2025 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EnCkzcIr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EFE2E8E0A
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990605; cv=none; b=WSZf+HMo3IpFqdAtYyq5ML7A7Zd9YKi/fodQgL1MRDx0I6+uinurrbZ92NSqDJwQIyrgVN+zXeM2MhSApA4+76N1HR6iJNosyt4FzLuH+4aJxFeJTD9oIRdE41u4A/ASj8C99WYrygYKhFg9rI5gD+szprq/tfoMj3qrjbOPQNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990605; c=relaxed/simple;
	bh=9UjwDurw1nUTJra9i5P6+81yOgQ9oABvAHUxnXc8Kx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZsIDFC7juJfndEDxktWdRgVL7wIW/9yWKG7fEjm0OJu/pq85l+HqkXu3a9XLD9czJycURLCn00hhzyIxu+QxmNelEHfCmV7tt1A8+ZeyDI/4AGrT9DiTIKEwJ4Ym3xnnbjae1sW8FgS4zQEbM1hcBFR0K1eZlVovqXsQJMCgtbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EnCkzcIr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754990603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pz1ojHO8eyf7HqxNiN54zlh4fLIlVQ4LDosH11WtvzQ=;
	b=EnCkzcIrOxrEyaxoBhwlXhf+2mq5p8aa7H/jEeFOvqgv7bG6MuvMOZNmyS3AZovtYPi2Sj
	RnrTYBaVo/YMufBdz8k9Mzox8xh5jA7UEj5hslfbqxvbkxoZW++T+yDCIg/8zdVFbOjkbz
	e1U7ZlprIrYLbghsIla+66L1hjXueCU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-Z1oA3ScyOUa7IxmXcbAqig-1; Tue, 12 Aug 2025 05:23:21 -0400
X-MC-Unique: Z1oA3ScyOUa7IxmXcbAqig-1
X-Mimecast-MFC-AGG-ID: Z1oA3ScyOUa7IxmXcbAqig_1754990600
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b7812e887aso2542040f8f.2
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 02:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990600; x=1755595400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pz1ojHO8eyf7HqxNiN54zlh4fLIlVQ4LDosH11WtvzQ=;
        b=BnSJmOGvG2DHx7zJQ29s1xoBlUw3W3zQSsRnMJmcJZ2pGx5t/goXUytCnivaMGOK03
         lvS3mjSVTy17SuN0olMx8mBSVud0a/xtFgT3+bEOpFhw2IuBjoElgYlXw2RoUkOno2TR
         CDQv/WcrXQtBkC24w+G4U055KMJhjXGccenVCHQ9V1wq0gEqt4jloYgc1J5tRxLpYjb5
         E382gd3hETUFLVhbQ+wu1mdXN/5MXgtlUVCc3lowZs8aHOJkSHi/oAFCEuHUOsn6kLym
         o9yraV6jei4Ipb5s2R9rysf5dM1L9cmHdlqLyOShFgWPH16265pwUpcqugt1Xu5coLRv
         +3Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWplJhCF4TCMv5nbROX3LJKjalN4W0RLMyWvw1nVxEiI6pjPx8aXtuVCvQgAzvHQQ5k0h1SYpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzpJje2ReKhgGYFY+AWOI0JOf9fwsFn7eds6Qv+BORzHavzgEX
	ak9pygBxbbBfIRpxrH89GDH/rHmpscYYDzM5xq6bjz3zRmCuZ0y04v+CyWrc2BYiOImyf+mr8i1
	Vc4nOtoFyOybXhJGf/W1H3bM7QNGQ5lGdBEeOwiSwJg/wRxUPbpJQs2wOfA==
X-Gm-Gg: ASbGnct+46lvRdw6gjWt2YqOSPKnZDGeOO2yufvqTGMCPQPD97+B43aYCshyA/2Q9ma
	GX+j/NCnZtQl9h34MLNBVNN5nmgKckE9tIGbbD7vCVlDHxfDQ6k4JdeDNCVgZ1lW5BQ/XbpuhOM
	8rNemDwJfVrCqbyewsDs0eqlf6Zz7SDzEjsoCBU0ObauE2aahD5tdDJwc+yAc976mjZp+Rolb0Y
	WFQPXJ5ZsxcjVBubG0CVGF8Ja0147Nz1wIrVbRXsFx8RXIWQ1kzPjdFmo0dbRFaE4yyIVwrAWam
	2DLG7yQh3hlequMobYjZ6El/6LnKSyPOIMFAfbXqWlU=
X-Received: by 2002:a5d:64c3:0:b0:3b7:974d:5359 with SMTP id ffacd0b85a97d-3b900b50441mr13785213f8f.32.1754990600317;
        Tue, 12 Aug 2025 02:23:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE75vvLuAwqhrfvMgiTAl2Xg6NM58jFLAd6KwXmS+pVefqn91SHuQHbjFMHg1LHMpKDBWwnbA==
X-Received: by 2002:a5d:64c3:0:b0:3b7:974d:5359 with SMTP id ffacd0b85a97d-3b900b50441mr13785179f8f.32.1754990599877;
        Tue, 12 Aug 2025 02:23:19 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.149.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5e99e04sm288071615e9.11.2025.08.12.02.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 02:23:19 -0700 (PDT)
Message-ID: <4a8266bf-5e33-4a38-a569-2a1e13633696@redhat.com>
Date: Tue, 12 Aug 2025 11:23:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net 3/3] selftests: bonding: add test for passive LACP
 mode
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250805094634.40173-1-liuhangbin@gmail.com>
 <20250805094634.40173-4-liuhangbin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250805094634.40173-4-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/25 11:46 AM, Hangbin Liu wrote:
@@ -0,0 +1,95 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Test if a bond interface works with lacp_active=off.
> +
> +# shellcheck disable=SC2034
> +REQUIRE_MZ=no
> +NUM_NETIFS=0
> +lib_dir=$(dirname "$0")
> +# shellcheck disable=SC1091
> +source "$lib_dir"/../../../net/forwarding/lib.sh
> +
> +check_port_state()
> +{
> +	local netns=$1
> +	local port=$2
> +	local state=$3
> +
> +	ip -n "${netns}" -d -j link show "$port" | \
> +		jq -e ".[].linkinfo.info_slave_data.ad_actor_oper_port_state_str | index(\"${state}\") != null" > /dev/null
> +}
> +
> +trap cleanup EXIT
> +setup_ns c_ns s_ns
> +defer cleanup_all_ns
> +
> +# shellcheck disable=SC2154
> +ip -n "${c_ns}" link add eth0 type veth peer name eth0 netns "${s_ns}"
> +ip -n "${c_ns}" link add eth1 type veth peer name eth1 netns "${s_ns}"
> +ip -n "${s_ns}" link set eth0 up
> +ip -n "${s_ns}" link set eth1 up
> +ip -n "${c_ns}" link add bond0 type bond mode 802.3ad lacp_active off lacp_rate fast
> +ip -n "${c_ns}" link set eth0 master bond0
> +ip -n "${c_ns}" link set eth1 master bond0
> +ip -n "${c_ns}" link set bond0 up
> +
> +# 1. The passive side shouldn't send LACPDU.
> +RET=0
> +client_mac=$(cmd_jq "ip -j -n ${c_ns} link show bond0" ".[].address")
> +# Wait for the first LACPDU due to state change.
> +sleep 5
> +timeout 62 ip netns exec "${c_ns}" tcpdump --immediate-mode -c 1 -i eth0 \
> +	-nn -l -vvv ether proto 0x8809 2> /dev/null > /tmp/client_init.out
> +grep -q "System $client_mac" /tmp/client_init.out && RET=1
> +log_test "802.3ad" "init port pkt lacp_active off"
> +
> +# 2. The passive side should not have the 'active' flag.
> +RET=0
> +check_port_state "${c_ns}" "eth0" "active" && RET=1
> +log_test "802.3ad" "port state lacp_active off"
> +
> +# Set up the switch side with active mode.
> +ip -n "${s_ns}" link set eth0 down
> +ip -n "${s_ns}" link set eth1 down
> +ip -n "${s_ns}" link add bond0 type bond mode 802.3ad lacp_active on lacp_rate fast
> +ip -n "${s_ns}" link set eth0 master bond0
> +ip -n "${s_ns}" link set eth1 master bond0
> +ip -n "${s_ns}" link set bond0 up
> +# Make sure the negotiation finished
> +sleep 5

Minor nit: I guess the above sleep time depends on some kernel constant,
but it's not obvious to me if the minimum time is mandated by the RFC,
nor how long is such interval.

A comment explaining the rationale behind such sleep will help, and
possibly a loop with smaller minimal wait and periodic checks for the
expected condition up to a significantly higher timeout could make the
test both faster on average and more robust.

> +
> +# 3. The active side should have the 'active' flag.
> +RET=0
> +check_port_state "${s_ns}" "eth0" "active" || RET=1
> +log_test "802.3ad" "port state lacp_active on"
> +
> +# 4. Make sure the connection has not expired.
> +RET=0
> +slowwait 15 check_port_state "${s_ns}" "eth0" "expired" && RET=1
> +slowwait 15 check_port_state "${s_ns}" "eth1" "expired" && RET=1
> +log_test "bond 802.3ad" "port connect lacp_active off"
> +
> +# After testing, disconnect one port on each side to check the state.
> +ip -n "${s_ns}" link set eth0 nomaster
> +ip -n "${s_ns}" link set eth0 up
> +ip -n "${c_ns}" link set eth1 nomaster
> +ip -n "${c_ns}" link set eth1 up
> +# 5. The passive side shouldn't send LACPDU anymore.
> +RET=0
> +# Wait for LACPDU due to state change.
> +sleep 5

Same here.

Thanks,

Paolo



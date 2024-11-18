Return-Path: <netdev+bounces-145994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E38E9D19B4
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 21:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13CEEB219EF
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 20:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F0D1E5015;
	Mon, 18 Nov 2024 20:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noEUFqcD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486B514BF8F
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 20:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731962158; cv=none; b=SQFscNRgoPZ3EjEMhwjXGndVR8orRTHsK2JTtn0CdUiRASBYo9JehMG8ko08K4Ph9JWODLo09zgmftsDGyfSWb703aCrT/MxvLMmfCDpon87v5WxPx0FTtk7XXZP0V2rQwgg+UNWVr2WL2r+7GPquyBOzNMQUWWfiKTjPtvN4wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731962158; c=relaxed/simple;
	bh=qP2Gn0FvyzE2X1n9fxM7Kdewy8cFydDfpI8dRuQlwqU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=JROxo6QUz0SOt5BvBlGWzpahjMNb3hePbj1akuIYyDESb7pBJVHFM0SdQ8ZTF3ZwUVFGLqTFIvC3aFavqs7oiOEV40uVUyBbJceL1NQULNsunKIkp875lcI+sTwQaewUNymaq4GlO3A5cxcs4T1Sdw1Ad8c+kniPKADdL8YKoRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noEUFqcD; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6d402ce7aa3so23768146d6.1
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 12:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731962155; x=1732566955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bf6KRH15a4iQ1V/X//Zf/VuIkJmHJ5qMcshZM0TdNHQ=;
        b=noEUFqcDbcm+8uvpffm0zhzX4ov/BO2pT1qqsUt5IR09qnDF5JA35d5eSLjZXfmm6k
         R2DAen6rVa1EudFMznRALtOoVkhN2Y3RBShL9KV72wVfRJKhpVFvHvw5R1Jq/AxfskWU
         6t0uI2AtSLhJexH28HtKDjsAa6dgR/gVliM+kC9A1X2sSzUc9yigOcKmLUsBLADbN0N6
         yPuS+06ZkVmY/JXq41oYiV0g1NpLw9fCwrm8CU1LmjRn6vEIFCH1kvYu28YHE9dq25nE
         e7bOz5FHcrCLQkAygPNfoSAQ+eck7Qh3gH2uPdiMiY1mwwg2JJdZgebMulrJyb1q7k7F
         FqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731962155; x=1732566955;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bf6KRH15a4iQ1V/X//Zf/VuIkJmHJ5qMcshZM0TdNHQ=;
        b=vtZB1e0vPnavPZUcYf5eqawyDdvGVMS9R1aP8++c4VOKcDL67UU6jZaQ197lu6taZb
         vxMb6wwIVaLiWp4G8te1ULwRN6NJODbEKBIPfxBbV2vvQy4JtwnY1h6vO4tIOcbOk7de
         JGdWMvokLwEPPtL4+XQOL2an9O7Gq/tHZjfZ/yyUWhbfncrNctdcrgBlvoiRa0jpIQoy
         3l6s9e4HrZo8fVfpDi4IuidJXhGhW6L94SkJdXHLSw8n/Gb/3PW8FO/3eFy6lHqwNtBj
         evX3qu6S9XtdL9rr62xa0slZbj0XFNP6v99E93QZ7yY0edhhdu3B+tF0pFzJjgll8whm
         GhgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU3hol91qPCpFjElNA0aAGv5DwY8MPunFkcCfxfxjOtlz0CUvI5qlVQiqAtzjBrE6IQcKLli8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRtEUlZsHNLocChgPz071t1q0mA+iCkvpjjHuBr9gMjMmrS2X/
	BOMKYuI9tnkjr3ZE9WHdApyK0i44CgzTu3h9l5H2izOi8LjJtotM
X-Google-Smtp-Source: AGHT+IF1p3iUXICx7931OXtB04PZBLDz30jWWGmaPoLplsKbG4OL1SAqMg8JtuK3qLDYuHM2FqK+rg==
X-Received: by 2002:a05:6214:2689:b0:6d4:1425:6d30 with SMTP id 6a1803df08f44-6d414257096mr141508896d6.45.1731962155132;
        Mon, 18 Nov 2024 12:35:55 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d40dc1f49asm39671836d6.50.2024.11.18.12.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 12:35:54 -0800 (PST)
Date: Mon, 18 Nov 2024 15:35:54 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>, 
 netdev@vger.kernel.org
Cc: fejes@inf.elte.hu, 
 annaemesenyiri@gmail.com, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemb@google.com, 
 idosch@idosch.org
Message-ID: <673ba52a4374f_1d652429476@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241118145147.56236-4-annaemesenyiri@gmail.com>
References: <20241118145147.56236-1-annaemesenyiri@gmail.com>
 <20241118145147.56236-4-annaemesenyiri@gmail.com>
Subject: Re: [PATCH net-next v4 3/3] selftests: net: test SO_PRIORITY
 ancillary data with cmsg_sender
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Anna Emese Nyiri wrote:
> Extend cmsg_sender.c with a new option '-Q' to send SO_PRIORITY
> ancillary data.
> 
> cmsg_so_priority.sh script added to validate SO_PRIORITY behavior 
> by creating VLAN device with egress QoS mapping and testing packet
> priorities using flower filters. Verify that packets with different
> priorities are correctly matched and counted by filters for multiple
> protocols and IP versions.
> 
> Suggested-by: Ido Schimmel <idosch@idosch.org>
> Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> ---
>  tools/testing/selftests/net/cmsg_sender.c     |  11 +-
>  .../testing/selftests/net/cmsg_so_priority.sh | 147 ++++++++++++++++++
>  2 files changed, 157 insertions(+), 1 deletion(-)
>  create mode 100755 tools/testing/selftests/net/cmsg_so_priority.sh
> 

> +++ b/tools/testing/selftests/net/cmsg_so_priority.sh
> @@ -0,0 +1,147 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +IP4=192.0.2.1/24
> +TGT4=192.0.2.2/24
> +TGT4_NO_MASK=192.0.2.2

nit, avoid duplication:

TGT4_NO_MASK=192.0.2.2
TGT4="${TGT4_NO_MASK}/24"

etc.

Or even drop the versions with the suffix and add that
explicitly where used.

> +TGT4_RAW=192.0.2.3/24
> +TGT4_RAW_NO_MASK=192.0.2.3
> +IP6=2001:db8::1/64
> +TGT6=2001:db8::2/64
> +TGT6_NO_MASK=2001:db8::2
> +TGT6_RAW=2001:db8::3/64
> +TGT6_RAW_NO_MASK=2001:db8::3
> +PORT=1234
> +DELAY=4000
> +
> +
> +create_filter() {
> +
> +    local ns=$1
> +    local dev=$2
> +    local handle=$3
> +    local vlan_prio=$4
> +    local ip_type=$5
> +    local proto=$6
> +    local dst_ip=$7
> +
> +    local cmd="tc -n $ns filter add dev $dev egress pref 1 handle $handle \
> +    proto 802.1q flower vlan_prio $vlan_prio vlan_ethtype $ip_type"

nit: indentation on line break. Break inside string is ideally avoided too.

perhaps just avoid the string and below call

    tc -n "$ns" filter add dev "$dev" \
            egress pref 1 handle "$handle" proto 802.1q \
            dst_ip "$dst_ip" "$ip_proto_opt"
            flower vlan_prio "$vlan_prio" vlan_ethtype "$ip_type" \
	    action pass
> +
> +    if [[ "$proto" == "u" ]]; then
> +        ip_proto="udp"
> +    elif [[ "$ip_type" == "ipv4" && "$proto" == "i" ]]; then
> +        ip_proto="icmp"
> +    elif [[ "$ip_type" == "ipv6" && "$proto" == "i" ]]; then
> +        ip_proto="icmpv6"
> +    fi
> +
> +    if [[ "$proto" != "r" ]]; then
> +        cmd="$cmd ip_proto $ip_proto"
> +    fi
> +
> +    cmd="$cmd dst_ip $dst_ip action pass"
> +
> +    eval $cmd
> +}
> +
> +TOTAL_TESTS=0
> +FAILED_TESTS=0
> +
> +check_result() {
> +    ((TOTAL_TESTS++))
> +    if [ "$1" -ne 0 ]; then
> +        ((FAILED_TESTS++))
> +    fi
> +}
> +
> +cleanup() {
> +    ip link del dummy1 2>/dev/null

Both devices are in ns1.

No need to clean up the devices explicitly. Just deleting the netns
will remove them.

> +    ip -n ns1 link del dummy1.10 2>/dev/null
> +    ip netns del ns1 2>/dev/null

> +}
> +
> +trap cleanup EXIT
> +
> +
> +
> +ip netns add ns1
> +
> +ip -n ns1 link set dev lo up
> +ip -n ns1 link add name dummy1 up type dummy
> +
> +ip -n ns1 link add link dummy1 name dummy1.10 up type vlan id 10 \
> +        egress-qos-map 0:0 1:1 2:2 3:3 4:4 5:5 6:6 7:7
> +
> +ip -n ns1 address add $IP4 dev dummy1.10
> +ip -n ns1 address add $IP6 dev dummy1.10
> +
> +ip netns exec ns1 bash -c "
> +sysctl -w net.ipv4.ping_group_range='0 2147483647'
> +exit"

Same point on indentation on line continuation.

No need for explicit exit.

> +
> +
> +ip -n ns1 neigh add $TGT4_NO_MASK lladdr 00:11:22:33:44:55 nud permanent dev \
> +        dummy1.10
> +ip -n ns1 neigh add $TGT6_NO_MASK lladdr 00:11:22:33:44:55 nud permanent dev dummy1.10
> +ip -n ns1 neigh add $TGT4_RAW_NO_MASK lladdr 00:11:22:33:44:66 nud permanent dev dummy1.10
> +ip -n ns1 neigh add $TGT6_RAW_NO_MASK lladdr 00:11:22:33:44:66 nud permanent dev dummy1.10
> +
> +tc -n ns1 qdisc add dev dummy1 clsact
> +
> +FILTER_COUNTER=10
> +
> +for i in 4 6; do
> +    for proto in u i r; do
> +        echo "Test IPV$i, prot: $proto"
> +        for priority in {0..7}; do
> +            if [[ $i == 4 && $proto == "r" ]]; then
> +                TGT=$TGT4_RAW_NO_MASK
> +            elif [[ $i == 6 && $proto == "r" ]]; then
> +                TGT=$TGT6_RAW_NO_MASK
> +            elif [ $i == 4 ]; then
> +                TGT=$TGT4_NO_MASK
> +            else
> +                TGT=$TGT6_NO_MASK
> +            fi
> +
> +            handle="${FILTER_COUNTER}${priority}"
> +
> +            create_filter ns1 dummy1 $handle $priority ipv$i $proto $TGT
> +
> +            pkts=$(tc -n ns1 -j -s filter show dev dummy1 egress \
> +                | jq ".[] | select(.options.handle == ${handle}) | \

Can jq be assumed installed on all machines?

> +                .options.actions[0].stats.packets")
> +
> +            if [[ $pkts == 0 ]]; then
> +                check_result 0
> +            else
> +                echo "prio $priority: expected 0, got $pkts"
> +                check_result 1
> +            fi
> +
> +            ip netns exec ns1 ./cmsg_sender -$i -Q $priority -d "${DELAY}" -p $proto $TGT $PORT
> +            ip netns exec ns1 ./cmsg_sender -$i -P $priority -d "${DELAY}" -p $proto $TGT $PORT
> +
> +
> +            pkts=$(tc -n ns1 -j -s filter show dev dummy1 egress \
> +                | jq ".[] | select(.options.handle == ${handle}) | \
> +                .options.actions[0].stats.packets")
> +            if [[ $pkts == 2 ]]; then
> +                check_result 0
> +            else
> +                echo "prio $priority: expected 2, got $pkts"
> +                check_result 1

I'd test -Q and -p separately. A bit of extra code to repeat the pkts
read. But worth it.

> +            fi
> +        done
> +        FILTER_COUNTER=$((FILTER_COUNTER + 10))
> +    done
> +done
> +
> +if [ $FAILED_TESTS -ne 0 ]; then
> +    echo "FAIL - $FAILED_TESTS/$TOTAL_TESTS tests failed"
> +    exit 1
> +else
> +    echo "OK - All $TOTAL_TESTS tests passed"
> +    exit 0
> +fi
> -- 
> 2.43.0
> 




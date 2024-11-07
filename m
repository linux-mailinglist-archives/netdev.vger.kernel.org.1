Return-Path: <netdev+bounces-142962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A509C0CCC
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563301F210C8
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9E0215C4C;
	Thu,  7 Nov 2024 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dleHHqkj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A44DDBE
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731000150; cv=none; b=PNG//3pjfnPdshCKfDdmW7VgTYFdPqOWNjKS+L5G1orWrSab9ID9RKgA+L5OQdGKC/9Pe9EpCFBoHjBGKxB6c6Q9uskgGTajhWO3yPmfQgK/MRg8o3oK5pwREQhOWvkWokob3n2UM1VtG8ApC8NTdMhxPY+wSinnx+RGxruOzUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731000150; c=relaxed/simple;
	bh=Zy9gWtaJwTpyi96qYYiKdWEectUfmQrsSxCk4gazfIc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=JW0pGYXj/WwqGFaRb4hSo3Sj8Xnck099DNwPW3H8TPrhqz/nW9DILYpvItxaL6pwD4bMsH6GK+jjJsKp+7nhXugetrPqhdzQZcXVvgyAbf2/v9gWZLMB2TLzdVQr9kRGFJDLmBM9zMbwAg2GMNfLIKy2RnYb/U3Nbs42nD0MIMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dleHHqkj; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b1b224f6c6so74610785a.3
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 09:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731000148; x=1731604948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CB1GjEUHwJBGGITqddYTl/52yIRfCWDkCg1boKplgfU=;
        b=dleHHqkjbF+TJ/KSq5b633sVISJ4TPoI5wawB0TEbNiMLis0C/lXxoQSscBhQ2lu5o
         homnp0B4hVfvNGpoYanKDZ8uxOmtpMx2iQs1jR1bPKc648k1Fwe6ApFmlDdTC7eb5WOc
         1uZYXqGWSZnmzzeFl6FFT6Zb6zGB7JTKPRKOwGAGOR7T8g8umYjEi9MrdLE8Bm/f7G9m
         LmVw2mNeAmFnscWn63ssyWLAzSjBo/luuuLs6rfq4coZWWfX14r32VBeSchjZ2eBYiZT
         hWjCTb7QXeM6xFVPDtlZXy2QEDfY9QCJwk9avDSnM1V6eEmSSEknyus9fybwK9awCFkP
         yMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731000148; x=1731604948;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CB1GjEUHwJBGGITqddYTl/52yIRfCWDkCg1boKplgfU=;
        b=VxaXcOS48D7jaGUhzT/BaPIOl1oQMuLRihsnGOsKZC/ngqVywFoVTNVE4pm6G6vkhk
         rb9bE60t/SuGUjySYBbJ/GyqLLs0XNsSd+ifer5OZ26yIywkfuh5XEOTN0KoMxx9QaFX
         M25aUYwMgBDvJ3U4zWdlsCJovQCST0pJH8x6xnqbH28jGTWmXEHyo/B0CMuTej9rjGWi
         lrEqTfMQld1MXpOxVXYSIFsZ5Sxe9H1LNJl14ovsxisdNmySsXtMq4GO8LJX1+lyiXCi
         RX+SdI+bhFgveD3wU/LREcv463Rqc4PPgTyM4o4lHo7vHLeYDyE4QmI/2A7jl6C9veTe
         1oqg==
X-Forwarded-Encrypted: i=1; AJvYcCXfrrzZpu8pZiJ6AWbjGAAmUX6b6b7LHImO5CTmMvgM25MvNwyJtMnBP0KInQHWneW4WQhEICs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxcafaNYENil1LKzzQWTg5JKhdXBEKKLsAZmPyFGXdU+qk5eBY
	RyiuhD5bhdUh1WlPTjr78gy5FndQ5prT27LSuLwOCS1UyOxQyiIc
X-Google-Smtp-Source: AGHT+IGVgY8e8E29rrd7gubY4aT1gUeMxjKnsbqfYKdsOpu3FvxH5nO6nxtXmGt8zmwCNDmAGi2coQ==
X-Received: by 2002:a05:620a:4108:b0:7b1:5089:4867 with SMTP id af79cd13be357-7b2fb9bfe02mr3129090185a.62.1731000147732;
        Thu, 07 Nov 2024 09:22:27 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32acae4casm82097685a.75.2024.11.07.09.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 09:22:27 -0800 (PST)
Date: Thu, 07 Nov 2024 12:22:26 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>, 
 netdev@vger.kernel.org
Cc: fejes@inf.elte.hu, 
 annaemesenyiri@gmail.com, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 Ido Schimmel <idosch@idosch.org>
Message-ID: <672cf752e2014_1f26762945a@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241107132231.9271-4-annaemesenyiri@gmail.com>
References: <20241107132231.9271-1-annaemesenyiri@gmail.com>
 <20241107132231.9271-4-annaemesenyiri@gmail.com>
Subject: Re: [PATCH net-next v3 3/3] selftest: net: test SO_PRIORITY ancillary
 data with cmsg_sender
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
> Add the `cmsg_so_priority.sh` script, which sets up two network  
> namespaces (red and green) and uses the `cmsg_sender.c` program to  
> send messages between them. The script sets packet priorities both  
> via `setsockopt` and control messages (cmsg) and verifies whether  
> packets are routed to the same queue based on priority settings.

qdisc. queue is a more generic term, generally referring to hw queues.
 
> Suggested-by: Ido Schimmel <idosch@idosch.org>
> Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> ---
>  tools/testing/selftests/net/cmsg_sender.c     |  11 +-
>  .../testing/selftests/net/cmsg_so_priority.sh | 115 ++++++++++++++++++
>  2 files changed, 125 insertions(+), 1 deletion(-)
>  create mode 100755 tools/testing/selftests/net/cmsg_so_priority.sh
 
> diff --git a/tools/testing/selftests/net/cmsg_so_priority.sh b/tools/testing/selftests/net/cmsg_so_priority.sh
> new file mode 100755
> index 000000000000..706d29b251e9
> --- /dev/null
> +++ b/tools/testing/selftests/net/cmsg_so_priority.sh
> @@ -0,0 +1,115 @@
> +#!/bin/bash

SPDX header

> +
> +source lib.sh
> +
> +IP4=192.168.0.2/16
> +TGT4=192.168.0.3/16
> +TGT4_NO_MASK=192.168.0.3
> +IP6=2001:db8::2/64
> +TGT6=2001:db8::3/64
> +TGT6_NO_MASK=2001:db8::3
> +IP4BR=192.168.0.1/16
> +IP6BR=2001:db8::1/64
> +PORT=8080
> +DELAY=400000
> +QUEUE_NUM=4
> +
> +
> +cleanup() {
> +    ip netns del red 2>/dev/null
> +    ip netns del green 2>/dev/null
> +    ip link del br0 2>/dev/null
> +    ip link del vethcab0 2>/dev/null
> +    ip link del vethcab1 2>/dev/null
> +}
> +
> +trap cleanup EXIT
> +
> +priority_values=($(seq 0 $((QUEUE_NUM - 1))))
> +
> +queue_config=""
> +for ((i=0; i<$QUEUE_NUM; i++)); do
> +    queue_config+=" 1@$i"
> +done
> +
> +map_config=$(seq 0 $((QUEUE_NUM - 1)) | tr '\n' ' ')
> +
> +ip netns add red
> +ip netns add green
> +ip link add br0 type bridge
> +ip link set br0 up

Is this bridge needed? Can this just use a veth pair as is.

More importantly, it would be great if we can deduplicate this kind of
setup boilerplate across similar tests as much as possible.

> +ip addr add $IP4BR dev br0
> +ip addr add $IP6BR dev br0
> +
> +ip link add vethcab0 type veth peer name red0
> +ip link set vethcab0 master br0
> +ip link set red0 netns red
> +ip netns exec red bash -c "
> +ip link set lo up
> +ip link set red0 up
> +ip addr add $IP4 dev red0
> +ip addr add $IP6 dev red0
> +sysctl -w net.ipv4.ping_group_range='0 2147483647'
> +exit"
> +ip link set vethcab0 up
> +
> +ip link add vethcab1 type veth peer name green0
> +ip link set vethcab1 master br0
> +ip link set green0 netns green
> +ip netns exec green bash -c "
> +ip link set lo up
> +ip link set green0 up
> +ip addr add $TGT4 dev green0
> +ip addr add $TGT6 dev green0
> +exit"
> +ip link set vethcab1 up
> +
> +ip netns exec red bash -c "
> +sudo ethtool -L red0 tx $QUEUE_NUM rx $QUEUE_NUM
> +sudo tc qdisc add dev red0 root mqprio num_tc $QUEUE_NUM queues $queue_config map $map_config hw 0
> +exit"
> +
> +get_queue_bytes() {
> +    ip netns exec red sudo tc -s qdisc show dev red0 | grep 'Sent' | awk '{print $2}'
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
> +
> +for i in 4 6; do
> +    [ $i == 4 ] && TGT=$TGT4_NO_MASK || TGT=$TGT6_NO_MASK
> +
> +    for p in u i r; do
> +        echo "Test IPV$i, prot: $p"
> +        for value in "${priority_values[@]}"; do
> +            ip netns exec red ./cmsg_sender -$i -Q $value -d "${DELAY}" -p $p $TGT $PORT
> +            setsockopt_priority_bytes_num=($(get_queue_bytes))
> +
> +            ip netns exec red ./cmsg_sender -$i -P $value -d "${DELAY}" -p $p $TGT $PORT
> +            cmsg_priority_bytes_num=($(get_queue_bytes))
> +
> +            if [[ "${cmsg_priority_bytes_num[$actual_queue]}" != \
> +            "${setsockopt_priority_bytes_num[$actual_queue]}" ]]; then
> +                check_result 0
> +            else
> +                check_result 1
> +            fi
> +        done
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




Return-Path: <netdev+bounces-176737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6885DA6BC92
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 15:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3658E465D56
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 14:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CEF13FD86;
	Fri, 21 Mar 2025 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSI2+I6I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9EF80C02
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 14:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566040; cv=none; b=VkGZhKq7rzPqZgt9oGu829RpEPmd2H1psZuXcNfRGWaOKWslT+TwjJRQQppit7vF4ig6AEu6AVaBbAlxKqL3UKj+lAcDobRFM2OSTWDcPdhyCYysOor5w743na3KVUaaVDbZ7gAgiUkMHNBj/SY3Qva3w/bGd/HBkhiNgYN6XXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566040; c=relaxed/simple;
	bh=l5ESA26GelRvhWO6G47s8ua3/q1jtOz/xphduj4QCtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upFyIHPUfLGLWnBgANodlgBlbtNO+FPoe7h4Wq8YXyIBxSTu47NG88vxhQ80EcJmn2QK2KDsG6Azr/13Tf0ybnGNa2yvML6UDBfXQGcXaGP5uMBdSoA8Dmfc4HxY4z35OO8D3lDjDeh28qBVddN4E8VnZjnTXMznmy2M/tqq57s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSI2+I6I; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223594b3c6dso45883505ad.2
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 07:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742566037; x=1743170837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HNNXIW8gMu0VEMnhx6zhE5dagRgi71mEjEQZX+11Te4=;
        b=GSI2+I6IRuuFBnlCxz4ElPW1dQOdhKfc4GxR047cnt0IdxSVgs1B6TTJkiLFik7zDg
         jMHdxtdU13eeqqlc/Vq0VBYItPaTwBw0uLzdTOLjFuGCVCxKVMvpBYKLV5H+UCFMLo5Z
         IrA1iK7HTfVr8JoCJSj7Lxo1TfPDJz9atgEwICmaHjUwFo7Kk9yAx9hs8GECYEC2XAVj
         Lk5fUxWCkuBnocWtx4mWj2zmgb4nHMK+jDQq/EUFd1dI2/dST0TrIshLNEJov/K5IxwP
         rjxVWBMUyORj7KE1pwv0Sedb3oymv8wRIno1NhtBIxYqeVQS/yKGtXPm+Cj7zM6pktf+
         RUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742566037; x=1743170837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNNXIW8gMu0VEMnhx6zhE5dagRgi71mEjEQZX+11Te4=;
        b=EaYwGN8XCM9tWayOyqL39ThAZnepFKMvQMybxwxAe2BL9rNDphYbzWKhvQPrchfwk1
         U4oEPkGzPdIf/AVIXCLKXRXUOSHpbAImGRipGfrjfdQjHbUw2E211dCwkQh8HnpS5atT
         YBMzBEdUgJ6UU3w3DKGBR0icFpUr7ehMWjJeRbV1FuMA1HbvdWSQhf6VXz7jltXkpga9
         JfGRalzPQlT6FXsrbJrf8T/dO7TOf41QnKzcHyw2nY7hjQRAJrdubD5RB4bl38gi6wES
         Rs2nmsn2TQiomo0EFxvrN8c0nS4jBm1JONNToR75ZCUYJgoSAxaFm2GwXJLQ3NGFJ3Q8
         hVhw==
X-Forwarded-Encrypted: i=1; AJvYcCWPoE6x+R/jyEXy+h8gqLqWQrGRUjP+p5LZb0/qWrLUAR4AleM3vZp5SRWdeRGxCzuSuvHMe1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr7Y1CxsiTewMn2B06s7aK/BN+l4sEu7Pr04CLvgv8PVEj2XHA
	TsHwhSvu6YkcxNccAsD+VC7K2spnv10MANvaXJCAdjKcEut08x+9i25c
X-Gm-Gg: ASbGncs9ICfZgq2GofhPmmS0Nt+4vdIcTqqCnOaSiSzUZtXrU8Z1m9b6R0Qea7ITqAN
	9FSBTNpLf48LZYHCy/TYnJ125LJut040qQDrfYB8BY64RA4qGlLBbP7W6/DSX2BEj11fdxgrtGA
	FeTnKE2TSYyxAkJY7k+rQaAWkTc1hK8JBPdmNgvK8nZOaX6YFFqgScQ6D+ro7rTSU5W02lYETVG
	/DXSVnV6gtYDE0D2IJ0g7xszsIR8EI9JGykFX0+uxuUVPmD/uuPYnUVzlNdTC9GSnVGPnU4KJKa
	pwhPZhd4/hkbTWhUvOYlxF9K+DSXpFaea/n/PXbotWbk
X-Google-Smtp-Source: AGHT+IF0ySEVJZP4cTFIo5F4VDYA6Ro+TxOj+9WTCfnl4nkl8iwOsJuBXdFTs+hZ61tHx3cE+N+SUw==
X-Received: by 2002:a05:6a21:108c:b0:1f5:a3e8:64d9 with SMTP id adf61e73a8af0-1fe42f55b0amr6710939637.19.1742566036813;
        Fri, 21 Mar 2025 07:07:16 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af8a2a4da80sm1715222a12.74.2025.03.21.07.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:07:16 -0700 (PDT)
Date: Fri, 21 Mar 2025 07:07:15 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 00/13] ipv6: No RTNL for IPv6 routing table.
Message-ID: <Z91yk90LZy9yJexG@mini-arch>
References: <20250321040131.21057-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250321040131.21057-1-kuniyu@amazon.com>

On 03/20, Kuniyuki Iwashima wrote:
> IPv6 routing tables are protected by each table's lock and work in
> the interrupt context, which means we basically don't need RTNL to
> modify an IPv6 routing table itself.
> 
> Currently, the control paths require RTNL because we may need to
> perform device and nexthop lookups; we must prevent dev/nexthop from
> going away from the netns.
> 
> This, however, can be achieved by RCU as well.
> 
> If we are in the RCU critical section while adding an IPv6 route,
> synchronize_net() in netif_change_net_namespace() and
> unregister_netdevice_many_notify() guarantee that the dev will not be
> moved to another netns or removed.
> 
> Also, nexthop is guaranteed not to be freed during the RCU grace period.
> 
> If we care about a race between nexthop removal and IPv6 route addition,
> we can get rid of RTNL from the control paths.
> 
> Patch 1 moves a validation for RTA_MULTIPATH earlier.
> Patch 2 removes RTNL for SIOCDELRT and RTM_DELROUTE.
> Patch 3 ~ 10 move validation and memory allocation earlier.
> Patch 11 prevents a race between two requests for the same table.
> Patch 12 prevents the race mentioned above.
> Patch 13 removes RTNL for SIOCADDRT and RTM_NEWROUTE.
> 
> 
> Test:
> 
> The script [0] lets each CPU-X create 100000 routes on table-X in a
> batch.
> 
> On c7a.metal-48xl EC2 instance with 192 CPUs,
> 
> With this series:
> 
>   $ sudo ./route_test.sh
>   start adding routes
>   added 19200000 routes (100000 routes * 192 tables).
>   Time elapsed: 189154 milliseconds.
> 
> Without series:
> 
>   $ sudo ./route_test.sh
>   start adding routes
>   added 19200000 routes (100000 routes * 192 tables).
>   Time elapsed: 62531 milliseconds.
> 
> I changed the number of routes (1000 ~ 100000 per CPU/table) and
> constantly saw it complete 3x faster with this series.
> 
> 
> [0]
> #!/bin/bash
> 
> mkdir tmp
> 
> NS="test"
> ip netns add $NS
> ip -n $NS link add veth0 type veth peer veth1
> ip -n $NS link set veth0 up
> ip -n $NS link set veth1 up
> 
> TABLES=()
> for i in $(seq $(nproc)); do
>     TABLES+=("$i")
> done
> 
> ROUTES=()
> for i in {1..100}; do
>     for j in {1..1000}; do
> 	ROUTES+=("2001:$i:$j::/64")
>     done
> done
> 
> for TABLE in "${TABLES[@]}"; do
>     FILE="./tmp/batch-table-$TABLE.txt"
>     > $FILE
>     for ROUTE in "${ROUTES[@]}"; do
>         echo "route add $ROUTE dev veth0 table $TABLE" >> $FILE
>     done
> done
> 
> echo "start adding routes"
> 
> START_TIME=$(date +%s%3N)
> for TABLE in "${TABLES[@]}"; do
>     ip -n $NS -6 -batch "./tmp/batch-table-$TABLE.txt" &
> done
> 
> wait
> END_TIME=$(date +%s%3N)
> ELAPSED_TIME=$((END_TIME - START_TIME))
> 
> echo "added $((${#ROUTES[@]} * ${#TABLES[@]})) routes (${#ROUTES[@]} routes * ${#TABLES[@]} tables)."
> echo "Time elapsed: ${ELAPSED_TIME} milliseconds."
> echo $(ip -n $NS -6 route show table all | wc -l)  # Just for debug
> 
> ip netns del $NS
> rm -fr ./tmp/

Lockdep is not supper happy about some patch:
https://netdev-3.bots.linux.dev/vmksft-forwarding-dbg/results/42463/38-gre-multipath-nh-res-sh/stderr

---
pw-bot: cr


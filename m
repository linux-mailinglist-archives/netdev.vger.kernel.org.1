Return-Path: <netdev+bounces-216464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD8CB33DF8
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 13:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043CB3B7B5E
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 11:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F6B2E7BC0;
	Mon, 25 Aug 2025 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bCJlf6Hv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DF323D7D0
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756121375; cv=none; b=UJAaSi+GI16sfgcF0CysEkgF7rMX/w8UBrnF15Q8ck6IDKZppjGfKrPpWj1b/N8lMPkIRhpXdwGlpAcTf3uo9cv5GEJZp4JdwTRITDQsueylNSSY4DKabd/7jaZwTAtk2SLiNTvuM80s4WLwfxix37vMOpMvJt3GSKmPtyOXoFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756121375; c=relaxed/simple;
	bh=cnYfDu7LAy6Y841XuECcBvXAa9lS9mdmMtRI4gs9j/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6oDtRvGZnuNkoBTdSMjB/U1n/DbBXZPP1d7Wqg6QPQZl7C4yXEnOGTZl1l6g+SuT+5Jdz6UKmlHTDq9Nw4TR9SUzuEWogDX1xUHpyKDv3/SLQ4bkE5LzD7BNJqmpi5vUBIz6hFvGerLit6bZzc3WbwbENGSDApQqV1O3SS9pYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bCJlf6Hv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756121372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5b/mUUUytT0GI7j66aiVNJW72wGpdKIu5jNTrVh+KKI=;
	b=bCJlf6HvgYdzSN/hP4+PM2uMXLbLe5flM3J21TzfSGLwCvTcLh1agRkhRfs0/Rv1i3eOnR
	tKvEnC1KaM+6eyUvF1xuRHECO8M6W6cTFMxB6XLMnBjVZyuAinKcOPzvczHxjySCJ01WOa
	oOFEgL7lIQGfn4ysDhM309vw/dQY4Gs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-veH7Lmq-NBGn4G_41aL60A-1; Mon, 25 Aug 2025 07:29:30 -0400
X-MC-Unique: veH7Lmq-NBGn4G_41aL60A-1
X-Mimecast-MFC-AGG-ID: veH7Lmq-NBGn4G_41aL60A_1756121370
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b109c7ad98so162618871cf.3
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 04:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756121370; x=1756726170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5b/mUUUytT0GI7j66aiVNJW72wGpdKIu5jNTrVh+KKI=;
        b=hO77Ot5NV1iFQtv9z97OFKwtdz21iFWxJd2/o3xSSHC0eJ5Gd1m5k+9WJLJko9L+US
         9HXgOKwxlq7lp9+POFxnxOKwNm5UcS9xIUAHypVuan/A6dVM81GClu0HjqCPMcPaoS8I
         YZWnz8VPNyxNh5cZbXt/WfVeK0ij9di9KbP2WBWmHQqGilFCcrrUDQzHahjwJoyoVsVG
         6MOTF+iXsHzZt1J3tzw9HmDhudNXrjpmR8wB7vAoJGZTM/6NsSeluxUzTCMnIFhQ0DJj
         Z/BXDpD4rzsuyUBph5sPgURGHXcvCkLIxhIDrcfrcm0sv4rIaClBNpe0S2k0Y3X58j3d
         XwPA==
X-Forwarded-Encrypted: i=1; AJvYcCUNgJSkzL6BnPiwI0nIMbhWEMXo7+Q0nX/uIf582VqtBOX7btb8k3xPLH2vkppDl0K+g3HJlMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMO2Wr4R1142+09LLQgqQoTQb4RGCRKNJCfoicFqb78W9BRvvk
	wmY4NncV2lFgJRwj9Yiyo3nW5c8wdxl6vj9GBKlVD2crhFL0nrlwxl13vLOfq9LUQMa5992BZo5
	9hAhpbvCkNikmbATr8/jhQZ849lukrsWORevMBWsGBMMLK6XqMOEHAWPe5g==
X-Gm-Gg: ASbGncvDFBCPGJgzab5dSRufHHH3yAAm+4ho3wfUWnHfun++PduGz84G02Vc8t6W7Ib
	qW8IiSFdoKrGOcjLudrE6CA1f4LBOKBx5axy+b9hbGGK0t15P0p6cbeHUQJ7IHtRvouqSfHnZfG
	t2ZIboJsewl/vVA+KEFMpJWOTptxXjYhl7L3b0CahjlJlcCsJ7mxi2+IFNRElAeKS8ZIh013Q0D
	EdoUG3j1y45K1QmDzzmEbsh8Wq9UAGaIA3ufUNacBD4n2ZwcWNXXF0ZZQowB0244rHkwm0NVNa8
	JHNsh/O6Qcp4qJBzPzcx9Lv6OXK9grqoWuvzS21EfUqgOFu1DwqZKSJYuDi7OlY5mkrNoSvpFti
	rFFtfiP/WdZYXKBrjew==
X-Received: by 2002:a05:622a:2618:b0:4b2:8ac5:27c1 with SMTP id d75a77b69052e-4b2aab51b5cmr160967881cf.76.1756121369816;
        Mon, 25 Aug 2025 04:29:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4jDx+nkCanpozXJlq46gYLeZrEClJPdxH6Sy/f4dOU0M85qzelwlk1XIGDBZEEZssS70mqA==
X-Received: by 2002:a05:622a:2618:b0:4b2:8ac5:27c1 with SMTP id d75a77b69052e-4b2aab51b5cmr160967511cf.76.1756121369429;
        Mon, 25 Aug 2025 04:29:29 -0700 (PDT)
Received: from debian (2a01cb058918ce0048dd797e0334a429.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:48dd:797e:334:a429])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e1eb30sm50747301cf.40.2025.08.25.04.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 04:29:28 -0700 (PDT)
Date: Mon, 25 Aug 2025 13:29:21 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	David Ahern <dsahern@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Subject: Re: [PATCH net-next] ipv4: Convert ->flowi4_tos to dscp_t.
Message-ID: <aKxJEaSZ40d416sK@debian>
References: <5af3062dabed0fb45506a38114082b5090e61a52.1755715298.git.gnault@redhat.com>
 <aKbDCJWjMpUEOtXe@shredder>
 <aKcoAbPXff_IT7MN@debian>
 <aKrmOtDqr_46icM1@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKrmOtDqr_46icM1@shredder>

On Sun, Aug 24, 2025 at 01:15:22PM +0300, Ido Schimmel wrote:
> On Thu, Aug 21, 2025 at 04:06:57PM +0200, Guillaume Nault wrote:
> > By the way, do you have an opinion about converting struct
> > ip_tunnel_key::tos? Do you think it'd be worth it, or just code churn?
> 
> I'm not sure if it's even possible. For example, on Tx, some drivers
> interpret ip_tunnel_key::tos being 1 as a sign that TOS should be
> inherited from the encapsulated packet. See the script in [1] and its
> output in [2] for example.

For this case, I was thinking of storing the "inherit" option in a
tunnel flag.

> On Rx, drivers in collect metadata ("external") mode set this field to
> the TOS from the outer header (which can have ECN bits set). The field
> can later be used to match on the outer TOS using flower's "enc_tos" key
> (for example). See the script in [3] and its output in [4].

This one would be a problem indeed.
I'll leave struct ip_tunnel_key alone.

> [1]
> #!/bin/bash
> 
> ip netns add ns1
> ip -n ns1 link set dev lo up
> ip -n ns1 address add 192.0.2.1/32 dev lo
> 
> ip -n ns1 link add name dummy1 up type dummy
> ip -n ns1 route add default dev dummy1
> 
> ip -n ns1 link add name ipip1 up type ipip external
> ip -n ns1 route add 192.0.2.0/24 dev ipip1 \
> 	encap ip id 1234 dst 198.51.100.1 src 192.0.2.1 tos 1
> 
> ip netns exec ns1 tcpdump -i dummy1 -Q out -n -vvv -c 1 dst host 198.51.100.1 &
> sleep 1
> ip netns exec ns1 ping -q -Q 4 -w 1 -c 1 192.0.2.2
> 
> ip netns del ns1
> 
> [2]
> # ./ipip_repo_tunkey.sh 
> dropped privs to tcpdump
> tcpdump: listening on dummy1, link-type EN10MB (Ethernet), snapshot length 262144 bytes
> PING 192.0.2.2 (192.0.2.2) 56(84) bytes of data.
> 13:11:02.742405 IP (tos 0x4, ttl 64, id 64774, offset 0, flags [none], proto IPIP (4), length 104)
>     192.0.2.1 > 198.51.100.1: IP (tos 0x4, ttl 64, id 21845, offset 0, flags [DF], proto ICMP (1), length 84)
>     192.0.2.1 > 192.0.2.2: ICMP echo request, id 360, seq 1, length 64
> 1 packet captured
> 1 packet received by filter
> 0 packets dropped by kernel
> 
> --- 192.0.2.2 ping statistics ---
> 1 packets transmitted, 0 received, 100% packet loss, time 0ms
> 
> [3]
> #!/bin/bash
> 
> for ns in ns1 ns2; do
> 	ip netns add $ns
> 	ip -n $ns link set dev lo up
> done
> 
> ip -n ns1 link add name eth0 type veth peer name eth0 netns ns2
> ip -n ns1 link set dev eth0 up
> ip -n ns2 link set dev eth0 up
> 
> ip -n ns1 address add 192.0.2.1/32 dev lo
> ip -n ns1 link add name vx0 up type \
> 	vxlan id 10010 local 192.0.2.1 remote 192.0.2.2 dstport 4789 tos 0xff
> ip -n ns1 address add 192.0.2.17/28 dev eth0
> ip -n ns1 route add default via 192.0.2.18
> 
> ip -n ns2 address add 192.0.2.2/32 dev lo
> ip -n ns2 link add name vx0 up type vxlan dstport 4789 external
> ip -n ns2 address add 192.0.2.18/28 dev eth0
> ip -n ns2 route add default via 192.0.2.17
> tc -n ns2 qdisc add dev vx0 clsact
> tc -n ns2 filter add dev vx0 ingress pref 1 proto all \
> 	flower enc_src_ip 192.0.2.1 enc_dst_ip 192.0.2.2 enc_tos 0xfe \
> 	action drop
> 
> ip netns exec ns1 mausezahn vx0 -a own -b 00:11:22:33:44:55 \
> 	-A 198.51.100.1 -B 198.51.100.2 -t ip tos=0xff -c 1 -q
> sleep 1
> tc -n ns2 -s filter show dev vx0 ingress
> 
> for ns in ns1 ns2; do
> 	ip netns del $ns
> done
> 
> [4]
> # ./vxlan_repo_tunkey.sh 
> filter protocol all pref 1 flower chain 0 
> filter protocol all pref 1 flower chain 0 handle 0x1 
>   enc_dst_ip 192.0.2.2
>   enc_src_ip 192.0.2.1
>   enc_tos 254
>   not_in_hw
>         action order 1: gact action drop
>          random type none pass val 0
>          index 1 ref 1 bind 1 installed 1 sec used 1 sec firstused 1 sec
>         Action statistics:
>         Sent 20 bytes 1 pkt (dropped 1, overlimits 0 requeues 0) 
>         backlog 0b 0p requeues 0
> 



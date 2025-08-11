Return-Path: <netdev+bounces-212498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D933B2109B
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D1B62269D
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 15:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD30C2D6E58;
	Mon, 11 Aug 2025 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZV7HFRmc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079B52D6E48
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926459; cv=none; b=dgLqXWHIf7EqcEeIo5w/iRAykkqIisg3qQWk8mDZlZ1U/jYqefBlvSQeWGpzGeuyJvYC3mXvA3U1M+/NHVqbQ6mVtwafu26fz0nATBAwnfwjkSm30LE+xPDch17SltfLzsLG+xHil+dRhbr2wzo3NEftZ8xM6jcgEH2CTRkT5jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926459; c=relaxed/simple;
	bh=OYE7mwVCwkFJnlaulyMQDYzo83QEeZ7EjwunJn1k0IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opgsCwlnUG1LlNey/DKWtOdPwR47xPtq9t11XJowNau46OCUv3GEr8RoGT3P0HRpbSamKrE8BhEDBNsXUFdWuIcJvHqPedWtcZIVPw5Cd1Tll/JlUsg6P/Q1EMab0ImA7RRx4MdUP52d06szncN90pkuQgNK33kXxphMCiO8B/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZV7HFRmc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754926457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oBG7qRqnmc+FohmmDMtXr+FTQ7gWXBFW/8JjqABYXio=;
	b=ZV7HFRmcz7Mw6WLUK/2qd5m76yNs3QgP3nVKmzZ02Bi62Sm2i+gwTNL8r7kvldFkh/ndg1
	gHBdLXj13sBwZkWXkk7JAx0e34T4dQ/lCjfpNhU7H4A7+Ok/MNrBqw9iXI/qOz8hX5e/ZE
	VhrPlLrg7TEpI7bVl3Kcl4aWhkj7lKE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-pJY7HpJeNkyotAdNt1TaCA-1; Mon,
 11 Aug 2025 11:34:13 -0400
X-MC-Unique: pJY7HpJeNkyotAdNt1TaCA-1
X-Mimecast-MFC-AGG-ID: pJY7HpJeNkyotAdNt1TaCA_1754926452
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6D7118529A0;
	Mon, 11 Aug 2025 15:33:49 +0000 (UTC)
Received: from jramaseu-thinkpadt14gen5.tpbc.csb (unknown [10.43.3.226])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 07B0F19560AB;
	Mon, 11 Aug 2025 15:33:46 +0000 (UTC)
From: Jakub Ramaseuski <jramaseu@redhat.com>
To: willemdebruijn.kernel@gmail.com
Cc: horms@kernel.org,
	jramaseu@redhat.com,
	kuba@kernel.org,
	mschmidt@redhat.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tizhao@redhat.com
Subject: Re: Re: [PATCH net v2] net: mask NETIF_F_IPV6_CSUM flag on irregular packet header size
Date: Mon, 11 Aug 2025 17:33:15 +0200
Message-ID: <20250811153315.856048-1-jramaseu@redhat.com>
In-Reply-To: <689512a45dabb_217ac1294e6@willemb.c.googlers.com.notmuch>
References: <689512a45dabb_217ac1294e6@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Thanks for the feedback, Willem de Bruijn asked:
> If you go to 04c20a9356f283da~1, does this traffic work?
That is a good question, prior to this conversation I checked the results
on 6.11.0-27 (which is prior to that commit), with reverting 04c20a9356f283da
and 68e068cabd2c6c53 on v6.16, but not on 04c20a9356f283da~1. Here are the
iperf3 results for:
- git checkout 04c20a9356f283da~1
 Connecting to host 2023::11, port 5201
 [  5] local 2023::12 port 47768 connected to 2023::11 port 5201
 [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
 [  5]   0.00-1.00   sec  1.88 GBytes  16.2 Gbits/sec   79   2.14 MBytes       
 [  5]   1.00-2.00   sec  1.96 GBytes  16.8 Gbits/sec   11   1.89 MBytes       
 [  5]   2.00-3.00   sec  1.96 GBytes  16.8 Gbits/sec    0   2.53 MBytes       
 [  5]   3.00-4.00   sec  1.96 GBytes  16.9 Gbits/sec    1   2.35 MBytes       
 [  5]   4.00-5.00   sec  1.95 GBytes  16.7 Gbits/sec    5   2.13 MBytes       
 [  5]   5.00-6.00   sec  1.97 GBytes  16.9 Gbits/sec    0   2.72 MBytes       
 [  5]   6.00-7.00   sec  1.96 GBytes  16.8 Gbits/sec    6   2.49 MBytes       
 [  5]   7.00-8.00   sec  1.99 GBytes  17.1 Gbits/sec    2   2.26 MBytes       
 [  5]   8.00-9.00   sec  1.97 GBytes  16.9 Gbits/sec    3   2.06 MBytes       
 [  5]   9.00-10.00  sec  1.98 GBytes  17.0 Gbits/sec    0   2.66 MBytes       
 - - - - - - - - - - - - - - - - - - - - - - - - -
 [ ID] Interval           Transfer     Bitrate         Retr
 [  5]   0.00-10.00  sec  19.6 GBytes  16.8 Gbits/sec  107             sender
 [  5]   0.00-10.00  sec  19.6 GBytes  16.8 Gbits/sec                  receiver

- git checkout 04c20a9356f283da
 Connecting to host 2023::11, port 5201
 [  5] local 2023::12 port 44762 connected to 2023::11 port 5201
 [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
 [  5]   0.00-1.00   sec  0.00 Bytes  0.00 bits/sec    0   13.4 KBytes       
 [  5]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec    3   2.69 KBytes       
 [  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec    8   5.38 KBytes       
 [  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec    5   2.69 KBytes       
 [  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec    0   2.69 KBytes       
 [  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec    2   5.38 KBytes       
 [  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    0   6.72 KBytes       
 [  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec    6   5.38 KBytes       
 [  5]   8.00-9.00   sec   128 KBytes  1.05 Mbits/sec    2   5.38 KBytes       
 [  5]   9.00-11.29  sec  0.00 Bytes  0.00 bits/sec    2   5.38 KBytes       
 - - - - - - - - - - - - - - - - - - - - - - - - -
 [ ID] Interval           Transfer     Bitrate         Retr
 [  5]   0.00-11.29  sec   128 KBytes  92.9 Kbits/sec   28             sender
 [  5]   0.00-11.46  sec  92.7 KBytes  66.3 Kbits/sec                  receiver

- git checkout v6.16 + this patch
 Connecting to host 2023::11, port 5201
 [  5] local 2023::12 port 60108 connected to 2023::11 port 5201
 [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
 [  5]   0.00-1.00   sec   807 MBytes  6.77 Gbits/sec    0   1.74 MBytes       
 [  5]   1.00-2.00   sec   852 MBytes  7.14 Gbits/sec    0   1.74 MBytes       
 [  5]   2.00-3.00   sec   851 MBytes  7.14 Gbits/sec    0   1.83 MBytes       
 [  5]   3.00-4.00   sec   837 MBytes  7.02 Gbits/sec    0   1.92 MBytes       
 [  5]   4.00-5.00   sec   846 MBytes  7.10 Gbits/sec    0   1.92 MBytes       
 [  5]   5.00-6.00   sec   852 MBytes  7.14 Gbits/sec    0   1.92 MBytes       
 [  5]   6.00-7.00   sec   849 MBytes  7.12 Gbits/sec    0   1.92 MBytes       
 [  5]   7.00-8.00   sec   849 MBytes  7.12 Gbits/sec    0   1.92 MBytes       
 [  5]   8.00-9.00   sec   798 MBytes  6.69 Gbits/sec    0   1.92 MBytes       
 [  5]   9.00-10.00  sec   805 MBytes  6.75 Gbits/sec    0   1.92 MBytes       
 - - - - - - - - - - - - - - - - - - - - - - - - -
 [ ID] Interval           Transfer     Bitrate         Retr
 [  5]   0.00-10.00  sec  8.15 GBytes  7.00 Gbits/sec    0             sender
 [  5]   0.00-10.00  sec  8.15 GBytes  7.00 Gbits/sec                  receiver

Where ip addr shows:

1: lo: <LOOPBACK,UP,LOWER_UP> ...
    ...
...
8: enp65s0f0np0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    ...
    inet6 2011::12/64 scope global 
       valid_lft forever preferred_lft forever
...
12: ip6tnl0@NONE: <NOARP,UP,LOWER_UP> mtu 1452 qdisc noqueue state UNKNOWN group default qlen 1000
    link/tunnel6 :: brd :: permaddr 1257:d9c1:e829::
    inet6 fe80::1057:d9ff:fec1:e829/64 scope link proto kernel_ll 
       valid_lft forever preferred_lft forever
13: ip6gre0@NONE: <NOARP,UP,LOWER_UP> mtu 1448 qdisc noqueue state UNKNOWN group default qlen 1000
    link/gre6 :: brd :: permaddr cab1:6316:aa70::
    inet6 fe80::c8b1:63ff:fe16:aa70/64 scope link proto kernel_ll 
       valid_lft forever preferred_lft forever
14: gre1@enp65s0f0np0: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1448 qdisc noqueue state UNKNOWN group default qlen 1000
    link/gre6 2011::12 peer 2011::11 permaddr ded7:5b97:9098::
    ...
    inet6 2023::12/64 scope global 
       valid_lft forever preferred_lft forever
    ...

with 2023::11 being the other side of that GRE tunnel
and ethtool -i enp65s0f0np0 shows that NIC uses ice driver.

Even though this commit fixes 04c20a9356f283da, the throughput is still
50 % of its original rate. This leads me to the following question: since
the original commit affects throughput on NICs with the bnxt_en or ice
drivers, is it possible that in

net/core/dev.c: skb_csum_hwoffload_help()

the check
...
if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
    skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
    !ipv6_has_hopopt_jumbo(skb))
        goto sw_checksum;
...
should have another condition or flag before jumping to sw_checksum?
Any insights would be greatly appreciated.



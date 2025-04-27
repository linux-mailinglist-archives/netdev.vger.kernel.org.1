Return-Path: <netdev+bounces-186289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6A6A9E075
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 09:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317B43BCA6B
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 07:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588042459D1;
	Sun, 27 Apr 2025 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rz8/HI0q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1B722172E;
	Sun, 27 Apr 2025 07:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745739289; cv=none; b=fu3wXUo7wSHct5Q0Q5eHaxQCOgaBF8/lqVgBluYrZ5a9n/c1eiGEguOODufve4fMzaArVQoocxdZwbJhNlTNT0EZAp9sBw5Y1XzbVj7gkAuQwRurKJoeUK9IyGZ7aIbZOWeo/RXCpfIrUYcdPYn3kVV9h+i7CcIdn+ex/bXtPJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745739289; c=relaxed/simple;
	bh=oyve19ueN96/Ebh5Km24Q9h/X7zpZCSCr04LTX9kF8o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ftx4HfVx1i2PH4xTXkqm72XYobG0jgvdqnCV1Hs2yaKZZq7eDtVrC3sN+uQXCJbfUAOSQesaFfbVcaqIm3gcWT/afU+O6wSTmxipYVdYOjIDhITokMrzp5OsRQ5jOeuLm5yPL2ohoyZ6zAH+orkYg09wmNcUBWFYyND43eQiH24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rz8/HI0q; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39bf44be22fso2414662f8f.0;
        Sun, 27 Apr 2025 00:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745739286; x=1746344086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6UpTuTX+eZ8EYTzEMiVidNK8ap2WyoAJZ6DfeDCGGdo=;
        b=Rz8/HI0qSksEKV0KZdFQmqtKfJXyb46RFdX6N4Lm4AoI1uHBnit5rhGR/n6PME/ede
         Dz9hLeLEzzQFveBfd5dErHgyvCFGGsUJ26VJpriCTEXTMf6VY+JFbcOxENQdxctT6Qqm
         umPVZ6dfnSx1+CwQz7XmTjjJUJuEZh2vnrfalmcEcMQjTZUBePJf/N/O2hyCmOObrESE
         XPdTonY3rzUlVLP4F/2yOJJtepo0kEM7CD9/ShUThMsgZwL96hmHgztkeGoRIp2/jhVQ
         xKN06XFBV5QGMXeERul8f9b1QJIEK1aEaBSeYNwEhTawh3YtMilPkIBLdkfORoHNAl7x
         VOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745739286; x=1746344086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6UpTuTX+eZ8EYTzEMiVidNK8ap2WyoAJZ6DfeDCGGdo=;
        b=cIgeKgp5s7+uH95d8Xq6hdgwXTgQzGcAo4JyN0iDI/uqt+bCv86/yMLPi4OVkA1Sq1
         zD0wD+hxPK9ngGPYGQ1MK1Sloj2yk5qFQVlMLjLrfy8F9em6y+Qq+13uZQ+3UOoDV79S
         phjdU/x+RnU/zB6C2CMuLlA2D7y1+2lkPn6oc3TMw30tflTzR10J0nNFCZBXpjZ5po5U
         zc0U42ngsnGvSP3mcG6AlV7FVBWvcXYj0ReTA8A2fiM895lPXsK5TTpeuB/KPhvBYPLa
         CNCUE+QPr2x1/TlA6xN8HhXKRgqVIZ5NTiDa1o40F3Si8cMKXgBRudOCVmtxpSx1mNL/
         ndqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqT1P0D8HCuqIxAmombmjKGvSiwjo7qkO8FRjZ+JFgVUFQEyvZZQ7MUsPaqihYLy3seTeS0U8r@vger.kernel.org, AJvYcCX49uIJmCLqtrpDlzWV/xt2lZqHqnFt+x3lFvihq3f7GI+WtHLuL8++6LTEizd+OB2GBwbecgNz+kG3Cow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ecqpxuVds4VRxzHHPS02oWN1CpHQMSmE4lp9hXbU2uF7z84t
	7O/ie1BGRgu8he6rAOYmGjAq75cx2ow51Q9M+84uJ0IHhnm5U3HNF8B5UmHlkoychBfed3z9jYC
	Xrs0I6idR2qa8UNVbSIjwa4jcuBg=
X-Gm-Gg: ASbGnculApg2sB/2VVN30IC8Lg4w3bfC2ueHPavwZ5jGVPNFG7WSNJUEUvif2Rc+TSG
	BQhw+WCmP6NOgNjG1mLHRigkcWHHSn1NI6jvCVJxxE9AUHdnaO9r5+gpBbC3/2Hns5R7k47HDYM
	1E/VGqbjK9zuzzKntdLuh3d8cWuRVXywvk/Jg=
X-Google-Smtp-Source: AGHT+IEr1ICI4Sa6Cc3bM3qmIYa7BjTkiB9IxJiUdBntrpJcUBhQruUXxGfs4tiq8D4RUwn5CRFWLRfonKq/SzWoHt0=
X-Received: by 2002:a05:6000:1864:b0:3a0:7017:61f6 with SMTP id
 ffacd0b85a97d-3a074e1d763mr6721576f8f.14.1745739285562; Sun, 27 Apr 2025
 00:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Qiang Zhang <dtzq01@gmail.com>
Date: Sun, 27 Apr 2025 15:34:32 +0800
X-Gm-Features: ATxdqUHE4SnAhnPG-R5Lf_lcBdJHpgd7uUJGjudIOzr2TiLa2B2euenvR6HH8bo
Message-ID: <CAPx+-5u1k_JfTGpRz7hSbGug1CgU5EZzOpbOEM9phH6kaaxKgQ@mail.gmail.com>
Subject: tc-vlan push 1ad vlan on 1Q packet at ingress abnormal
To: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, all.
I met an problem when I tried to use bridge forward QinQ packet.
Use tc vlan instead of pvid due to I wanna push different vlans on rules.
It seemed that 1ad vlan pushed abnormal on 1q packet at ingress for the bri=
dge.
The steps to reproduce the issue:
/*
        PC0                              PC1
        br  1ad
ens37            ens38   ------- ens36--vlan2
                                             32.24
 */
1. Config on PC0:
  ip link add dev br up type bridge vlan_protocol 802.1ad vlan_filtering 1
  ip link set ens37 master br
  ip link set ens38 master br
  bridge vlan add vid 2 dev ens37
  bridge vlan add vid 2 dev ens38
  //Del the default vlan
  bridge vlan del vid 1 dev ens37
  bridge vlan del vid 1 dev ens38
  bridge vlan del vid 1 dev br self
  tc qdisc add dev ens38 clsact
  //Use tc vlan to add 1ad vlan 2.
  tc filter add dev ens38 ingress matchall action vlan push id 2
protocol 802.1ad

2. Config on PC1:
  ip link add vlan2 up link ens37 type vlan id 2
  ip addr add dev vlan2 192.168.32.24/24

3. Ping on PC1, then capture packet on ens37 and ens38 on PC0.
Find that dst mac and src mac changed, and 1q vlan 2 missed.
Expect that 1ad vlan 2 inserted between src mac and 1q vlan.
Details are below:
  PC1:
  # ping 192.168.32.1 -W1 -c1
  PING 192.168.32.1 (192.168.32.1) 56(84) bytes of data.

  --- 192.168.32.1 ping statistics ---
  1 packets transmitted, 0 received, 100% packet loss, time 0ms

  PC0:
  #tcpdump -iens38 -nnvvepXX
  tcpdump: listening on ens38, link-type EN10MB (Ethernet), snapshot
length 262144 bytes
  06:56:11.491285 00:0c:29:1a:32:8c > ff:ff:ff:ff:ff:ff, ethertype
802.1Q (0x8100),
  length 64: vlan 2, p 0, ethertype ARP (0x0806), Ethernet (len 6),
IPv4 (len 4),
  Request who-has 192.168.32.1 tell 192.168.32.24, length 46
  0x0000:  ffff ffff ffff 000c 291a 328c 8100 0002  ........).2.....
  0x0010:  0806 0001 0800 0604 0001 000c 291a 328c  ............).2.
  0x0020:  c0a8 2018 0000 0000 0000 c0a8 2001 0000  ................
  0x0030:  0000 0000 0000 0000 0000 0000 0000 0000  ................

  #tcpdump -iens37 -nnvvepXX
  tcpdump: listening on ens37, link-type EN10MB (Ethernet), snapshot
length 262144 bytes
  06:56:11.491548 32:8c:81:00:00:02 > ff:ff:00:0c:29:1a, ethertype
802.1Q-QinQ (0x88a8),
  length 64: vlan 2, p 0, ethertype ARP (0x0806), Ethernet (len 6),
IPv4 (len 4),
  Request who-has 192.168.32.1 tell 192.168.32.24, length 46
  0x0000:  ffff 000c 291a 328c 8100 0002 88a8 0002  ....).2.........
  0x0010:  0806 0001 0800 0604 0001 000c 291a 328c  ............).2.
  0x0020:  c0a8 2018 0000 0000 0000 c0a8 2001 0000  ................
  0x0030:  0000 0000 0000 0000 0000 0000 0000 0000  ................

  Display config on PC0=EF=BC=9A
  # bridge vlan
  port              vlan-id
  ens37             2
  ens38             2

  # tc -s filter ls dev ens38 ingress
  filter protocol all pref 49152 matchall chain 0
  filter protocol all pref 49152 matchall chain 0 handle 0x1
    not_in_hw (rule hit 3)
  action order 1: vlan  push id 2 protocol 802.1ad priority 0 pipe
  index 1 ref 1 bind 1 installed 506 sec used 365 sec firstused 367 sec
  Action statistics:
  Sent 138 bytes 3 pkt (dropped 0, overlimits 0 requeues 0)
  backlog 0b 0p requeues 0

  # ip -d link ls dev br
  17: br: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue
state UP mode DEFAULT group default qlen 1000
    link/ether ca:dc:7a:b2:df:f0 brd ff:ff:ff:ff:ff:ff promiscuity 0
minmtu 68 maxmtu 65535
    bridge forward_delay 1500 hello_time 200 max_age 2000 ageing_time
30000 stp_state 0 priority 32768 vlan_filtering 1 vlan_protocol
802.1ad bridge_id 8000.ca:dc:7a:b2:df:f0 designated_root
8000.ca:dc:7a:b2:df:f0 root_port 0 root_path_cost 0 topology_change 0
topology_change_detected 0 hello_timer    0.00 tcn_timer    0.00
topology_change_timer    0.00 gc_timer  158.49 vlan_default_pvid 1
vlan_stats_enabled 0 vlan_stats_per_port 0 group_fwd_mask 0
group_address 01:80:c2:00:00:08 mcast_snooping 1 mcast_router 1
mcast_query_use_ifaddr 0 mcast_querier 0 mcast_hash_elasticity 16
mcast_hash_max 4096 mcast_last_member_count 2
mcast_startup_query_count 2 mcast_last_member_interval 100
mcast_membership_interval 26000 mcast_querier_interval 25500
mcast_query_interval 12500 mcast_query_response_interval 1000
mcast_startup_query_interval 3125 mcast_stats_enabled 0
mcast_igmp_version 2 mcast_mld_version 1 nf_call_iptables 0
nf_call_ip6tables 0 nf_call_arptables 0 addrgenmode eui64 numtxqueues
1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
  # uname -a
  Linux code 5.15.0-131-lowlatency #141-Ubuntu SMP PREEMPT Thu Jan 16
18:36:23 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux


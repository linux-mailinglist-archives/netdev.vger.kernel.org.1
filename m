Return-Path: <netdev+bounces-129208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93D497E334
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 22:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17CE81C20BAC
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 20:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884C54D8A7;
	Sun, 22 Sep 2024 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2r8hZqA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0661547A4C;
	Sun, 22 Sep 2024 20:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727036601; cv=none; b=XCiVyJowoXPdnltFF1kPUwBosDUp+zX3c/TX5o806o5qGzRRO50lRMFBBgwiObwPQaQp3+kCwMw1gHKqImTr9JxMXkybfmalyY3/13z5B9seWTdHN5S3lkQhaG4wYKOVoMyg3IxNsllpI9fGxzGtvvXfItKmL796yT7Y/+UTNn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727036601; c=relaxed/simple;
	bh=53S+jZVdDbCMOPq/ZyTVGtu40p5t9c69I2JmwrU7SHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7IChMPD3UzqxcbDUSdn85nelVE0j4vQnG/LqiK0gm5QZ6IIjagyiDD8eVj3DDs4wTBFkl7KK/NYqhbs7BlyNe4Y0gJx/rqSOV7DIaIzDSMgpMLHPRcYyr6CMGadR45MFSDWz0x/LCCKeuoFRp22Icwqc0jgEZu34Ds/jD/uiIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2r8hZqA; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53567b4c3f4so3845697e87.2;
        Sun, 22 Sep 2024 13:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727036597; x=1727641397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V8QECbxXnIBiJ73xVEhQWZc5zqOlbo0njkDAeJrr+No=;
        b=J2r8hZqAPuXSCWNANt9hbrufBTTp3KF1fFi3Mlt5UqxcLAgNVWP2ZIk33odzP9Nuwf
         mx+OMJIvdiX7JMgX6uA/C9syAA+Gfqh+pAGsHLE6AoJ751SbHQ8b7tMoWZrPzHSFTUYo
         DNo+mEYhQ3Q+0CgCRFcoAbf3upwpceOcFHXtG0IPzJSr8CEgJuE65ZsvQ6EbVl/YnqsT
         vS8TtxW9XzZDUzV7kNe3PpPDh1x3T5Z2yrwllTEIVVZw3QI6orvtjp5t69Nomf8slbbE
         Y6HhLwbQbsnU/EnZvLyh8c1/Zs0aCrr8tE7nx/L5C80oBrAr85nsCzz8zkQ9C21OjbC0
         RLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727036597; x=1727641397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8QECbxXnIBiJ73xVEhQWZc5zqOlbo0njkDAeJrr+No=;
        b=A/swnD5wgrbCckq38o29E81Rfi/OLjCXOZFYKHOT803JjHm62bk7tt5LWfD9gv543t
         hgjxQXU4GdqwvwUrvP3W1BazqDeStrdS68dfbLnVyaXgdMfEHYte1CtlmCuGZfu4xB56
         V4BE3JRtY4gHyoeFieSsPo8cXsCLywGYjWS12d28bkQnq6Z2koPgSplVVo+g9eUlYoCX
         I+5JvGP169uTsfGKfNcWhDjbwd2CPXyLQJ/qF+v8pdx5YxRPUQwE5Sd/IlJTlkYLNFmB
         Bmmctn1cFCWZVvh3fzq54+9Y4aitSDmeXnVn/O1DPlsXERZu1/nUqSd4d1R/4mI7dpCx
         JY+A==
X-Forwarded-Encrypted: i=1; AJvYcCX50uNhUwxBDyoZ5oiXbQDoiZxsiHfeFYS8SZGwCcKcgZgQS29CsaSZhgFVX6hfSaP/GdXcNmkcL6FLMR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynf5TAtRnAfSCvl6XGwDlW3cwL3FHGI6FsBaXC24dXpcUhcNZh
	elgfqMbIZ557Q0E2Kh+J6li9BVN9ls/+7leAcDqfyadW7vYD9w7sZLvUQ3iQ4RY=
X-Google-Smtp-Source: AGHT+IEHPOsCYjHveDMOJ4rpauvBZV6X8VFG+eS/L2NxCkEa0IpGCqPLMdkEKWW3hV2byeSdCk2Juw==
X-Received: by 2002:a05:6512:1106:b0:52c:dfa7:9f43 with SMTP id 2adb3069b0e04-536ac2f5b66mr5008867e87.34.1727036596604;
        Sun, 22 Sep 2024 13:23:16 -0700 (PDT)
Received: from dau-work-pc.sunlink.ru ([185.149.163.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870470afsm3038363e87.38.2024.09.22.13.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 13:23:16 -0700 (PDT)
Date: Sun, 22 Sep 2024 23:23:14 +0300
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Suman Ghosh <sumang@marvell.com>,
	Shigeru Yoshida <syoshida@redhat.com>, linux-kernel@vger.kernel.org,
	Anton Danilov <littlesmilingcloud@gmail.com>
Subject: Re: [RFC PATCH net] ipv4: ip_gre: Fix drops of small packets in
 ipgre_xmit
Message-ID: <ZvB8stjbrXoez86t@dau-work-pc.sunlink.ru>
References: <20240921215410.638664-1-littlesmilingcloud@gmail.com>
 <CANn89iKP3VPExdyZt+eLFk3rE5=6yRckTPySfh5MvcEqPNm6aA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iKP3VPExdyZt+eLFk3rE5=6yRckTPySfh5MvcEqPNm6aA@mail.gmail.com>

On Sun, Sep 22, 2024 at 12:20:03PM +0200, Eric Dumazet wrote:

Hi Eric,

> Please provide a real selftest, because in this particular example,
> the path taken by the packets should not reach the
> pskb_network_may_pull(skb, pull_len)),
> because dev->header_ops should be NULL ?

I sincerely apologize for providing an inaccurate example of the commands 
needed to reproduce the issue. I understand that this may have caused
confusion, and I'm truly sorry for any inconvenience.

Here are the correct commands and their results.


  ip l add name mgre0 type gre local 192.168.71.177 remote 0.0.0.0 ikey 1.9.8.4 okey 1.9.8.4
  ip l s mtu 1400 dev mgre0
  ip a add 192.168.13.1/24 dev mgre0
  ip l s up dev mgre0
  ip n add 192.168.13.2 lladdr 192.168.69.50 dev mgre0
  
  
  ip -s -s -d l ls dev mgre0
    19: mgre0@NONE: <NOARP,UP,LOWER_UP> mtu 1400 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
        link/gre 192.168.71.177 brd 0.0.0.0 promiscuity 0  allmulti 0 minmtu 0 maxmtu 0 
        gre remote any local 192.168.71.177 ttl inherit ikey 1.9.8.4 okey 1.9.8.4 \
          addrgenmode eui64 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 \
          tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 

        RX:  bytes packets errors dropped  missed   mcast           
                 0       0      0       0       0       0 
        RX errors:  length    crc   frame    fifo overrun
                         0      0       0       0       0 
        TX:  bytes packets errors dropped carrier collsns           
                 0       0      0       0       0       0 
        TX errors: aborted   fifo  window heartbt transns
                         0      0       0       0       0 


  ping -n -c 10 -s 1374 192.168.13.2
    PING 192.168.13.2 (192.168.13.2) 1374(1402) bytes of data.
    
    --- 192.168.13.2 ping statistics ---
    10 packets transmitted, 0 received, 100% packet loss, time 9237ms


  ip -s -s -d l ls dev mgre0
    19: mgre0@NONE: <NOARP,UP,LOWER_UP> mtu 1400 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
        link/gre 192.168.71.177 brd 0.0.0.0 promiscuity 1  allmulti 0 minmtu 0 maxmtu 0 
        gre remote any local 192.168.71.177 ttl inherit ikey 1.9.8.4 okey 1.9.8.4 \
          addrgenmode eui64 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 \
          tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536

        RX:  bytes packets errors dropped  missed   mcast           
                 0       0      0       0       0       0 
        RX errors:  length    crc   frame    fifo overrun
                         0      0       0       0       0 
        TX:  bytes packets errors dropped carrier collsns           
             13960      10      0      10       0       0 
        TX errors: aborted   fifo  window heartbt transns
                     0      0       0       0       0 


  tcpdump -vni mgre0
    tcpdump: listening on mgre0, link-type LINUX_SLL (Linux cooked v1), snapshot length 262144 bytes
    21:51:19.481523 IP (tos 0x0, ttl 64, id 52595, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 1, length 1376
    21:51:19.481547 IP (tos 0x0, ttl 64, id 52595, offset 1376, flags [none], proto ICMP (1), length 26)
        192.168.13.1 > 192.168.13.2: ip-proto-1
    21:51:20.526751 IP (tos 0x0, ttl 64, id 53374, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 2, length 1376
    21:51:20.526773 IP (tos 0x0, ttl 64, id 53374, offset 1376, flags [none], proto ICMP (1), length 26)
        192.168.13.1 > 192.168.13.2: ip-proto-1
    21:51:21.550751 IP (tos 0x0, ttl 64, id 54124, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 3, length 1376
    21:51:21.550775 IP (tos 0x0, ttl 64, id 54124, offset 1376, flags [none], proto ICMP (1), length 26)
        192.168.13.1 > 192.168.13.2: ip-proto-1
    21:51:22.574748 IP (tos 0x0, ttl 64, id 55109, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 4, length 1376
    21:51:22.574766 IP (tos 0x0, ttl 64, id 55109, offset 1376, flags [none], proto ICMP (1), length 26)
        192.168.13.1 > 192.168.13.2: ip-proto-1
    21:51:23.598748 IP (tos 0x0, ttl 64, id 56011, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 5, length 1376
    21:51:23.598771 IP (tos 0x0, ttl 64, id 56011, offset 1376, flags [none], proto ICMP (1), length 26)
        192.168.13.1 > 192.168.13.2: ip-proto-1
    21:51:24.622758 IP (tos 0x0, ttl 64, id 57009, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 6, length 1376
    21:51:24.622783 IP (tos 0x0, ttl 64, id 57009, offset 1376, flags [none], proto ICMP (1), length 26)
        192.168.13.1 > 192.168.13.2: ip-proto-1
    21:51:25.646748 IP (tos 0x0, ttl 64, id 57277, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 7, length 1376
    21:51:25.646775 IP (tos 0x0, ttl 64, id 57277, offset 1376, flags [none], proto ICMP (1), length 26)
        192.168.13.1 > 192.168.13.2: ip-proto-1
    21:51:26.670750 IP (tos 0x0, ttl 64, id 57869, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 8, length 1376
    21:51:26.670773 IP (tos 0x0, ttl 64, id 57869, offset 1376, flags [none], proto ICMP (1), length 26)
        192.168.13.1 > 192.168.13.2: ip-proto-1
    21:51:27.694751 IP (tos 0x0, ttl 64, id 58317, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 9, length 1376
    21:51:27.694774 IP (tos 0x0, ttl 64, id 58317, offset 1376, flags [none], proto ICMP (1), length 26)
        192.168.13.1 > 192.168.13.2: ip-proto-1
    21:51:28.718751 IP (tos 0x0, ttl 64, id 58558, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 10, length 1376
    21:51:28.718775 IP (tos 0x0, ttl 64, id 58558, offset 1376, flags [none], proto ICMP (1), length 26)
        192.168.13.1 > 192.168.13.2: ip-proto-1


  tcpdump -vni enp11s0.100 'ip proto 47'
    tcpdump: listening on enp11s0.100, link-type EN10MB (Ethernet), snapshot length 262144 bytes
    21:51:19.481696 IP (tos 0x0, ttl 64, id 32563, offset 0, flags [DF], proto GRE (47), length 1424)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 1404
        IP (tos 0x0, ttl 64, id 52595, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 1, length 1376
    21:51:20.526767 IP (tos 0x0, ttl 64, id 33363, offset 0, flags [DF], proto GRE (47), length 1424)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 1404
        IP (tos 0x0, ttl 64, id 53374, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 2, length 1376
    21:51:21.550768 IP (tos 0x0, ttl 64, id 34260, offset 0, flags [DF], proto GRE (47), length 1424)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 1404
        IP (tos 0x0, ttl 64, id 54124, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 3, length 1376
    21:51:22.574761 IP (tos 0x0, ttl 64, id 34922, offset 0, flags [DF], proto GRE (47), length 1424)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 1404
        IP (tos 0x0, ttl 64, id 55109, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 4, length 1376
    21:51:23.598764 IP (tos 0x0, ttl 64, id 35042, offset 0, flags [DF], proto GRE (47), length 1424)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 1404
        IP (tos 0x0, ttl 64, id 56011, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 5, length 1376
    21:51:24.622775 IP (tos 0x0, ttl 64, id 36024, offset 0, flags [DF], proto GRE (47), length 1424)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 1404
        IP (tos 0x0, ttl 64, id 57009, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 6, length 1376
    21:51:25.646766 IP (tos 0x0, ttl 64, id 36133, offset 0, flags [DF], proto GRE (47), length 1424)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 1404
        IP (tos 0x0, ttl 64, id 57277, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 7, length 1376
    21:51:26.670766 IP (tos 0x0, ttl 64, id 36417, offset 0, flags [DF], proto GRE (47), length 1424)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 1404
        IP (tos 0x0, ttl 64, id 57869, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 8, length 1376
    21:51:27.694767 IP (tos 0x0, ttl 64, id 37006, offset 0, flags [DF], proto GRE (47), length 1424)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 1404
        IP (tos 0x0, ttl 64, id 58317, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 9, length 1376
    21:51:28.718767 IP (tos 0x0, ttl 64, id 37825, offset 0, flags [DF], proto GRE (47), length 1424)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 1404
        IP (tos 0x0, ttl 64, id 58558, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 63847, seq 10, length 1376


  ping -n -c 10 -s 1376 192.168.13.2
    PING 192.168.13.2 (192.168.13.2) 1376(1404) bytes of data.
    
    --- 192.168.13.2 ping statistics ---
    10 packets transmitted, 0 received, 100% packet loss, time 9198ms


  ip -s -s -d l ls dev mgre0
    19: mgre0@NONE: <NOARP,UP,LOWER_UP> mtu 1400 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
        link/gre 192.168.71.177 brd 0.0.0.0 promiscuity 0  allmulti 0 minmtu 0 maxmtu 0 
        gre remote any local 192.168.71.177 ttl inherit ikey 1.9.8.4 okey 1.9.8.4 addrgenmode eui64 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 
        RX:  bytes packets errors dropped  missed   mcast           
                 0       0      0       0       0       0 
        RX errors:  length    crc   frame    fifo overrun
                         0      0       0       0       0 
        TX:  bytes packets errors dropped carrier collsns           
             28200      30      0      10       0       0 
        TX errors: aborted   fifo  window heartbt transns
                         0      0       0       0       0 


  tcpdump -vni mgre0
    tcpdump: listening on mgre0, link-type LINUX_SLL (Linux cooked v1), snapshot length 262144 bytes
    22:01:34.176810 IP (tos 0x0, ttl 64, id 40388, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 1, length 1376
    22:01:34.176830 IP (tos 0x0, ttl 64, id 40388, offset 1376, flags [none], proto ICMP (1), length 28)
        192.168.13.1 > 192.168.13.2: ip-proto-1
    22:01:35.183742 IP (tos 0x0, ttl 64, id 40516, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 2, length 1376
    22:01:35.183765 IP (tos 0x0, ttl 64, id 40516, offset 1376, flags [none], proto ICMP (1), length 28)
        192.168.13.1 > 192.168.13.2: ip-proto-1
    22:01:36.207750 IP (tos 0x0, ttl 64, id 40684, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 3, length 1376
    22:01:36.207774 IP (tos 0x0, ttl 64, id 40684, offset 1376, flags [none], proto ICMP (1), length 28)
        192.168.13.1 > 192.168.13.2: ip-proto-1
    22:01:37.230738 IP (tos 0x0, ttl 64, id 41578, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 4, length 1376
    22:01:37.230756 IP (tos 0x0, ttl 64, id 41578, offset 1376, flags [none], proto ICMP (1), length 28)
        192.168.13.1 > 192.168.13.2: ip-proto-1
    22:01:38.254761 IP (tos 0x0, ttl 64, id 42099, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 5, length 1376
    22:01:38.254789 IP (tos 0x0, ttl 64, id 42099, offset 1376, flags [none], proto ICMP (1), length 28)
        192.168.13.1 > 192.168.13.2: ip-proto-1
    22:01:39.278748 IP (tos 0x0, ttl 64, id 42506, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 6, length 1376
    22:01:39.278771 IP (tos 0x0, ttl 64, id 42506, offset 1376, flags [none], proto ICMP (1), length 28)
        192.168.13.1 > 192.168.13.2: ip-proto-1
    22:01:40.302738 IP (tos 0x0, ttl 64, id 42527, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 7, length 1376
    22:01:40.302754 IP (tos 0x0, ttl 64, id 42527, offset 1376, flags [none], proto ICMP (1), length 28)
        192.168.13.1 > 192.168.13.2: ip-proto-1
    22:01:41.326733 IP (tos 0x0, ttl 64, id 42989, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 8, length 1376
    22:01:41.326749 IP (tos 0x0, ttl 64, id 42989, offset 1376, flags [none], proto ICMP (1), length 28)
        192.168.13.1 > 192.168.13.2: ip-proto-1
    22:01:42.350750 IP (tos 0x0, ttl 64, id 43576, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 9, length 1376
    22:01:42.350773 IP (tos 0x0, ttl 64, id 43576, offset 1376, flags [none], proto ICMP (1), length 28)
        192.168.13.1 > 192.168.13.2: ip-proto-1
    22:01:43.374743 IP (tos 0x0, ttl 64, id 44118, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 10, length 1376
    22:01:43.374762 IP (tos 0x0, ttl 64, id 44118, offset 1376, flags [none], proto ICMP (1), length 28)
        192.168.13.1 > 192.168.13.2: ip-proto-1

    
  tcpdump -vni enp11s0.100 'ip proto 47'
    tcpdump: listening on enp11s0.100, link-type EN10MB (Ethernet), snapshot length 262144 bytes
    22:01:34.176825 IP (tos 0x0, ttl 64, id 5066, offset 0, flags [DF], proto GRE (47), length 1424)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 1404
        IP (tos 0x0, ttl 64, id 40388, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 1, length 1376
    22:01:34.176832 IP (tos 0x0, ttl 64, id 5067, offset 0, flags [DF], proto GRE (47), length 56)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 36
        IP (tos 0x0, ttl 64, id 40388, offset 1376, flags [none], proto ICMP (1), length 28)
        192.168.13.1 > 192.168.13.2: ip-proto-1
    22:01:35.183758 IP (tos 0x0, ttl 64, id 5567, offset 0, flags [DF], proto GRE (47), length 1424)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 1404
        IP (tos 0x0, ttl 64, id 40516, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 2, length 1376
    22:01:35.183768 IP (tos 0x0, ttl 64, id 5568, offset 0, flags [DF], proto GRE (47), length 56)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 36
        IP (tos 0x0, ttl 64, id 40516, offset 1376, flags [none], proto ICMP (1), length 28)
        192.168.13.1 > 192.168.13.2: ip-proto-1
    22:01:36.207767 IP (tos 0x0, ttl 64, id 5741, offset 0, flags [DF], proto GRE (47), length 1424)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 1404
        IP (tos 0x0, ttl 64, id 40684, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 3, length 1376
    22:01:36.207778 IP (tos 0x0, ttl 64, id 5742, offset 0, flags [DF], proto GRE (47), length 56)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 36
        IP (tos 0x0, ttl 64, id 40684, offset 1376, flags [none], proto ICMP (1), length 28)
        192.168.13.1 > 192.168.13.2: ip-proto-1
    22:01:37.230751 IP (tos 0x0, ttl 64, id 5785, offset 0, flags [DF], proto GRE (47), length 1424)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 1404
        IP (tos 0x0, ttl 64, id 41578, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 4, length 1376
    22:01:37.230758 IP (tos 0x0, ttl 64, id 5786, offset 0, flags [DF], proto GRE (47), length 56)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 36
        IP (tos 0x0, ttl 64, id 41578, offset 1376, flags [none], proto ICMP (1), length 28)
        192.168.13.1 > 192.168.13.2: ip-proto-1
    22:01:38.254780 IP (tos 0x0, ttl 64, id 5937, offset 0, flags [DF], proto GRE (47), length 1424)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 1404
        IP (tos 0x0, ttl 64, id 42099, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 5, length 1376
    22:01:38.254795 IP (tos 0x0, ttl 64, id 5938, offset 0, flags [DF], proto GRE (47), length 56)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 36
        IP (tos 0x0, ttl 64, id 42099, offset 1376, flags [none], proto ICMP (1), length 28)
        192.168.13.1 > 192.168.13.2: ip-proto-1
    22:01:39.278764 IP (tos 0x0, ttl 64, id 6876, offset 0, flags [DF], proto GRE (47), length 1424)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 1404
        IP (tos 0x0, ttl 64, id 42506, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 6, length 1376
    22:01:39.278775 IP (tos 0x0, ttl 64, id 6877, offset 0, flags [DF], proto GRE (47), length 56)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 36
        IP (tos 0x0, ttl 64, id 42506, offset 1376, flags [none], proto ICMP (1), length 28)
        192.168.13.1 > 192.168.13.2: ip-proto-1
    22:01:40.302749 IP (tos 0x0, ttl 64, id 7410, offset 0, flags [DF], proto GRE (47), length 1424)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 1404
        IP (tos 0x0, ttl 64, id 42527, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 7, length 1376
    22:01:40.302757 IP (tos 0x0, ttl 64, id 7411, offset 0, flags [DF], proto GRE (47), length 56)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 36
        IP (tos 0x0, ttl 64, id 42527, offset 1376, flags [none], proto ICMP (1), length 28)
        192.168.13.1 > 192.168.13.2: ip-proto-1
    22:01:41.326744 IP (tos 0x0, ttl 64, id 7913, offset 0, flags [DF], proto GRE (47), length 1424)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 1404
        IP (tos 0x0, ttl 64, id 42989, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 8, length 1376
    22:01:41.326753 IP (tos 0x0, ttl 64, id 7914, offset 0, flags [DF], proto GRE (47), length 56)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 36
        IP (tos 0x0, ttl 64, id 42989, offset 1376, flags [none], proto ICMP (1), length 28)
        192.168.13.1 > 192.168.13.2: ip-proto-1
    22:01:42.350766 IP (tos 0x0, ttl 64, id 8422, offset 0, flags [DF], proto GRE (47), length 1424)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 1404
        IP (tos 0x0, ttl 64, id 43576, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 9, length 1376
    22:01:42.350776 IP (tos 0x0, ttl 64, id 8423, offset 0, flags [DF], proto GRE (47), length 56)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 36
        IP (tos 0x0, ttl 64, id 43576, offset 1376, flags [none], proto ICMP (1), length 28)
        192.168.13.1 > 192.168.13.2: ip-proto-1
    22:01:43.374756 IP (tos 0x0, ttl 64, id 9410, offset 0, flags [DF], proto GRE (47), length 1424)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 1404
        IP (tos 0x0, ttl 64, id 44118, offset 0, flags [+], proto ICMP (1), length 1396)
        192.168.13.1 > 192.168.13.2: ICMP echo request, id 54476, seq 10, length 1376
    22:01:43.374766 IP (tos 0x0, ttl 64, id 9411, offset 0, flags [DF], proto GRE (47), length 56)
        192.168.71.177 > 192.168.69.50: GREv0, Flags [key present], key=0x1090804, length 36
        IP (tos 0x0, ttl 64, id 44118, offset 1376, flags [none], proto ICMP (1), length 28)
        192.168.13.1 > 192.168.13.2: ip-proto-1



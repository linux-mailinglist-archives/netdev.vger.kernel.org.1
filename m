Return-Path: <netdev+bounces-76836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17C286F1A6
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 18:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408D428111D
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 17:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BA524A0E;
	Sat,  2 Mar 2024 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="qQ3BbEwX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942522375F
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709399474; cv=none; b=JnkTy8++/lDnFcoxSf79uQ7DGOQsA4gqYTfEZtkKLxn+4BOqhE4qjPirdPrytZmpOkQmD5+aEqpwK/tMS6YYoZ22YuKDPQPU+fXC4PDpOHgR6SpFv+GgVs+EV4f1XwOmORxpT7vfImCsP3mmWYAwQMD8YMhpoUgXJFU/D1+X340=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709399474; c=relaxed/simple;
	bh=JPc2L9QGb9deqProchZroQWUXGayOoQ7o8rUsVOoPjQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=s2WdW+85alHlztfHlEG5nbFitoQvDZ4I64uUejfBoJIsMeTObysdtC5Hw5bMdOjIuitW00kcxa2souYc/kSBFtHLy6LWa4wyVaRLeelARKixZhSaqviQNflvMWA7sfO4Ey5Ypb9wQVcXnZzdDOVz7/ypW+8ru96fvke2zITkFtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=qQ3BbEwX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dd01ea35b5so1300035ad.0
        for <netdev@vger.kernel.org>; Sat, 02 Mar 2024 09:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1709399472; x=1710004272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2p8mvDfAiLV+qM7UaCxcnBf2mbQmwxAEgvV4RAPDaE4=;
        b=qQ3BbEwXobguZJ2X0m3HcAnZSAqX7xpXNq5HuHEtd6dflAvoLWZR6V9P5Mu3V+kIvS
         70mJsMl6RXRKzS4V/LU7ROm433MIidHPx2pdIXo8sZeomHmJ8bJ3w90Nr77NLz72flxd
         R6cdpm9yAnPCRubHwizWJl/CIuULQ527xQiSP3wzcJ+r+keWVjHGz+0eYTQ8z4d+7Sx+
         vK1Wj/4IIBAaal8SvN4l/Qu/7KJP+y2hAM6qwsnaxWXuN9jWS0pGU68XC7eHNAATExve
         Mpa9VHbTTGENMuLgfZSDzoqiwU7HBIGy+XGROKYdtBicxmMEj5zS6rzavK82b7W+oaJk
         XqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709399472; x=1710004272;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2p8mvDfAiLV+qM7UaCxcnBf2mbQmwxAEgvV4RAPDaE4=;
        b=Mr9dBWX5nlMMLSSUhrbyD2sMe6Ac/cjbVJBuWnenTgpNLdtjGaTWlbP8k/IqO6OcFA
         3Ea14sGm+QfEgZaV8zv6hmne+6G6ZbaTmKnImHiCEPhr8zhEGc3QjBy6vs4NfC7yP79S
         3NUBYensAMdcVH64Fh4s/pnAEuITu6/sqBq90xxUGU9VWFnlpDnQTl3J/FPiiyZNs/hh
         I8A1wWVFkNK5nM1CT6yUmjP5o2TzsUWNwmQucUhgHcgeIuTY/VjeHS3xX45ZbbxRrxLw
         T2W7SV+cbOQPgQGod3miS1xm17nJ2cvO8O4ZAG/T+PIik4zzvp793PgiVRWzTKZBrEj5
         PEmQ==
X-Gm-Message-State: AOJu0YyEdJ3gKweht7vG06lgO45q4gcLPO93VI1cTGUEattV0lGH2QlI
	HkIFfzrpVI9gvhvr0iWUHbSbnPdqPjBrtNgKA/UXT2/03rpMr33h4ymemkeC//irnrot/q3TFps
	OLNI=
X-Google-Smtp-Source: AGHT+IE4oP6BRZV8u2n1efC7ifKy2ELC0WGlDGheE8eLBCgGiEi1KdXABhXrp0Eab43h97XeV2tO1Q==
X-Received: by 2002:a17:902:ec83:b0:1db:f952:eebf with SMTP id x3-20020a170902ec8300b001dbf952eebfmr5362685plg.44.1709399471857;
        Sat, 02 Mar 2024 09:11:11 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id w10-20020a170902e88a00b001dc89fe5743sm5492601plg.0.2024.03.02.09.11.11
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 09:11:11 -0800 (PST)
Date: Sat, 2 Mar 2024 09:11:10 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Fw: [Bug 218552] New: GRE passing Linux MPLS network has poor
 performance for TCP
Message-ID: <20240302091110.3e18088c@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Begin forwarded message:

Date: Sat, 02 Mar 2024 15:33:49 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 218552] New: GRE passing Linux MPLS network has poor performance for TCP


https://bugzilla.kernel.org/show_bug.cgi?id=218552

            Bug ID: 218552
           Summary: GRE passing Linux MPLS network has poor performance
                    for TCP
           Product: Networking
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: devel@easynet.dev
        Regression: No

Created attachment 305949
  --> https://bugzilla.kernel.org/attachment.cgi?id=305949&action=edit  
GRE over MPLS poor performance

I'm facing a strange behavior of the MPLS network between 2 routers build on
linux. Then I'm creating a GRE tunnel on a router or a GRE tunnel which is
passing the Linux MPLS network I have a very-very poor performance of the TCP
traffic, even I'm shrinking the MTU or the MSS.

The setup is like this:

Inbound traffic:
ISP -> (eth3-0) R02 (eth4-0) -> (MPLS) -> (eth4-0) R01 (eth3-1 & eth4-1) -> VPN
server

Outbound traffic
VPN server -> (eth3-1 & eth4-1) R01 (eth4-0) -> (MPLS) -> (eth4-0) R02 (eth3-0)
-> ISP  


Routing table on R02:

R02# show ip route vrf internet 89.A.B.1
Routing entry for 89.A.B.1/32
  Known via "bgp", distance 200, metric 0, vrf internet, best
  Last update 12:43:11 ago
    10.100.1.1(vrf default) (recursive), label 81, weight 1
  *   10.100.0.1, via mpls0(vrf default), label IPv4 Explicit Null/81, weight 1

R02# show ip route vrf servers 89.A.B.161
Routing entry for 89.A.B.128/26
  Known via "bgp", distance 200, metric 0, vrf servers, best
  Last update 12:40:35 ago
    10.100.1.1(vrf default) (recursive), label 85, weight 1
  *   10.100.0.1, via mpls0(vrf default), label IPv4 Explicit Null/85, weight 1

R02# show ip route vrf internet 89.A.B.161
Routing entry for 89.A.B.128/26
  Known via "bgp", distance 200, metric 0, vrf internet, best
  Last update 12:42:56 ago
    10.100.1.1(vrf default) (recursive), label 85, weight 1
  *   10.100.0.1, via mpls0(vrf default), label IPv4 Explicit Null/85, weight 1

R02# show ip route vrf internet 178.C.D.0/15
Routing entry for 178.C.D.0/15
  Known via "bgp", distance 20, metric 0, vrf internet, best
  Last update 14:28:23 ago
    193.230.200.47 (recursive), weight 1
  *   89.238.245.113, via wan0.650, weight 1

R02# show ip route vrf servers
Codes: K - kernel route, C - connected, L - local, S - static,
       R - RIP, O - OSPF, I - IS-IS, B - BGP, E - EIGRP, N - NHRP,
       T - Table, v - VNC, V - VNC-Direct, A - Babel, F - PBR,
       f - OpenFabric, t - Table-Direct,
       > - selected route, * - FIB route, q - queued, r - rejected, b - backup  
       t - trapped, o - offload failure

VRF servers:
S>* 0.0.0.0/0 [1/0] is directly connected, internet (vrf internet), weight 1,  
14:29:46

Routing table on R01:

R01# show ip route vrf internet 89.A.B.1
Routing entry for 89.A.B.1/32
  Known via "local", distance 0, metric 0, vrf internet
  Last update 15:07:48 ago
  * directly connected, internet

Routing entry for 89.A.B.1/32
  Known via "connected", distance 0, metric 0, vrf internet, best
  Last update 15:07:48 ago
  * directly connected, internet

R01# show ip route vrf servers 89.A.B.161
Routing entry for 89.A.B.128/26
  Known via "connected", distance 0, metric 0, vrf servers, best
  Last update 14:53:40 ago
  * directly connected, lan0.11

R01# show ip route vrf internet 89.A.B.161
Routing entry for 89.A.B.128/26
  Known via "bgp", distance 20, metric 0, vrf internet, best
  Last update 14:53:50 ago
  * directly connected, servers(vrf servers), weight 1

R01# show ip route vrf internet 178.C.D.0/15
Routing entry for 178.C.D.0/15
  Known via "bgp", distance 200, metric 0, vrf internet, best
  Last update 12:44:27 ago
    10.100.2.1(vrf default) (recursive), label 81, weight 1
  *   10.100.0.2, via eth4-0(vrf default), label IPv4 Explicit Null/81, weight
1

Create a GRE tunnel:

R01# /sbin/ip link add name gre1001 numtxqueues $(nproc) numrxqueues $(nproc)
type gre remote 178.C.D.X local 89.A.B.1 ttl 225 key 1001
R01# ip link set gre1001 up

R10# /sbin/ip link add name gre1001 numtxqueues $(nproc) numrxqueues $(nproc)
type gre remote 89.A.B.1 local 178.C.D.X ttl 225 key 1001
R10# ip link set gre1001 up

R01# show interface gre1001
Interface gre1001 is up, line protocol is up
  Link ups:       6    last: 2024/03/02 16:50:46.82
  Link downs:     6    last: 2024/03/02 16:50:46.82
  vrf: default
  Description: R01-R10 GRE
  index 206 metric 0 mtu 65507 speed 0 txqlen 1000
  flags: <UP,POINTOPOINT,RUNNING,NOARP>
  Ignore all v4 routes with linkdown
  Ignore all v6 routes with linkdown
  Type: GRE over IP
  HWaddr: 59:26:3a:01
  inet 10.100.100.129/30
  inet6 fe80::5926:3a01/64
  Interface Type GRE
  Interface Slave Type None
  VTEP IP: 89.A.B.1 , remote 178.C.D.X
  protodown: off

R10# show interface gre1001
Interface gre1001 is up, line protocol is up
  Link ups:      38    last: 2024/03/02 16:51:35.67
  Link downs:    30    last: 2024/03/02 16:51:35.66
  vrf: default
  Description: R01-R10 GRE
  index 357 metric 0 mtu 1472 speed 0 txqlen 1000
  flags: <UP,POINTOPOINT,RUNNING,NOARP>
  Type: GRE over IP
  HWaddr: b2:26:6c:bc
  inet 10.100.100.130/30
  inet6 fe80::b226:6cbc/64
  Interface Type GRE
  Interface Slave Type None
  VTEP IP: 178.C.D.X , remote 89.A.B.1
  protodown: off

Testing:

R10# iperf3 -c 10.100.100.129
Connecting to host 10.100.100.129, port 5201
[  5] local 10.100.100.130 port 51610 connected to 10.100.100.129 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  2.38 MBytes  19.9 Mbits/sec   20   2.77 KBytes
[  5]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec    8   2.77 KBytes
[  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec    8   2.77 KBytes
[  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec    8   2.77 KBytes
[  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec    8   4.16 KBytes
[  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec    8   5.55 KBytes
[  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec   12   2.77 KBytes
[  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec    8   2.77 KBytes
[  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec   12   2.77 KBytes
[  5]   9.00-10.00  sec  0.00 Bytes  0.00 bits/sec   10   2.77 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  2.38 MBytes  2.00 Mbits/sec  102             sender
[  5]   0.00-10.04  sec   128 KBytes   104 Kbits/sec                  receiver

R10# iperf3 -c 10.100.100.129 -R
Connecting to host 10.100.100.129, port 5201
Reverse mode, remote host 10.100.100.129 is sending
[  5] local 10.100.100.130 port 50280 connected to 10.100.100.129 port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.03   sec  47.4 MBytes   386 Mbits/sec
[  5]   1.03-2.02   sec  30.9 MBytes   261 Mbits/sec
[  5]   2.02-3.00   sec  25.8 MBytes   220 Mbits/sec
[  5]   3.00-4.01   sec  27.0 MBytes   224 Mbits/sec
[  5]   4.01-5.01   sec  28.4 MBytes   238 Mbits/sec
[  5]   5.01-6.00   sec  28.0 MBytes   238 Mbits/sec
[  5]   6.00-7.01   sec  28.1 MBytes   235 Mbits/sec
[  5]   7.01-8.00   sec  28.8 MBytes   242 Mbits/sec
[  5]   8.00-9.03   sec  29.0 MBytes   237 Mbits/sec
[  5]   9.03-10.01  sec  28.2 MBytes   242 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.05  sec   305 MBytes   255 Mbits/sec    8             sender
[  5]   0.00-10.01  sec   302 MBytes   253 Mbits/sec                  receiver

Even in TCPDUMP over the MPLS network I'm capturing very low number of
packates:

I test it from VPN server to some Cisco routers and each time when the GRE
tunnel is passing Linux MPLS network I have such huge TCP degradation. If I'm
moving the tunnels to GUE, FOU or IPIP the performances are over 250Mbits/s.

R10# ip a l gre1001
358: gre1001@NONE: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1480 qdisc noqueue state
UNKNOWN group default qlen 1000
    link/ipip 178.C.D.X peer 89.A.B.1
    inet 10.100.100.130/30 brd 10.100.100.131 scope global gre1001
       valid_lft forever preferred_lft forever
    inet6 fe80::200:5efe:b226:6cbc/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever

R01# ip a l gre1001
207: gre1001@NONE: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1480 qdisc noqueue state
UNKNOWN group default qlen 1000
    link/ipip 89.A.B.1 peer 178.C.D.X
    inet 10.100.100.129/30 brd 10.100.100.131 scope global gre1001
       valid_lft forever preferred_lft forever
    inet6 fe80::200:5efe:5926:3a01/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever

root@R10:~# iperf3 -c 10.100.100.129 -R
Connecting to host 10.100.100.129, port 5201
Reverse mode, remote host 10.100.100.129 is sending
[  5] local 10.100.100.130 port 42162 connected to 10.100.100.129 port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.02   sec  48.0 MBytes   395 Mbits/sec
[  5]   1.02-2.01   sec  33.4 MBytes   283 Mbits/sec
[  5]   2.01-3.01   sec  35.0 MBytes   292 Mbits/sec
[  5]   3.01-4.01   sec  36.6 MBytes   307 Mbits/sec
[  5]   4.01-5.01   sec  37.6 MBytes   317 Mbits/sec
[  5]   5.01-6.00   sec  38.4 MBytes   322 Mbits/sec
[  5]   6.00-7.00   sec  38.2 MBytes   321 Mbits/sec
[  5]   7.00-8.00   sec  38.5 MBytes   323 Mbits/sec
[  5]   8.00-9.01   sec  39.1 MBytes   327 Mbits/sec
[  5]   9.01-10.01  sec  38.9 MBytes   327 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.05  sec   388 MBytes   324 Mbits/sec   12             sender
[  5]   0.00-10.01  sec   384 MBytes   322 Mbits/sec                  receiver

iperf Done.
root@R10:~# iperf3 -c 10.100.100.129
Connecting to host 10.100.100.129, port 5201
[  5] local 10.100.100.130 port 43416 connected to 10.100.100.129 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  41.1 MBytes   345 Mbits/sec    0   3.75 MBytes
[  5]   1.00-2.00   sec  46.2 MBytes   388 Mbits/sec    5   1.34 MBytes
[  5]   2.00-3.00   sec  36.2 MBytes   304 Mbits/sec    0   1.42 MBytes
[  5]   3.00-4.00   sec  36.2 MBytes   304 Mbits/sec    0   1.48 MBytes
[  5]   4.00-5.00   sec  38.8 MBytes   325 Mbits/sec    0   1.52 MBytes
[  5]   5.00-6.00   sec  40.0 MBytes   335 Mbits/sec    0   1.55 MBytes
[  5]   6.00-7.00   sec  38.8 MBytes   325 Mbits/sec    0   1.57 MBytes
[  5]   7.00-8.00   sec  40.0 MBytes   336 Mbits/sec    0   1.57 MBytes
[  5]   8.00-9.00   sec  40.0 MBytes   336 Mbits/sec    0   1.57 MBytes
[  5]   9.00-10.00  sec  40.0 MBytes   335 Mbits/sec    0   1.57 MBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   397 MBytes   333 Mbits/sec    5             sender
[  5]   0.00-10.04  sec   396 MBytes   330 Mbits/sec                  receiver

iperf Done.

Routers NICs are 40GbE Mellanox MCX354A-FCBT. MPLS interfaces has MTU 9216.

The solution was to move all tunnels between VPN server and Cisco routers to
IPIP.

Does anybody faced such issue? I have no clue what to optimize or is a Kernel
bug.
Tested on 6.5.x an 6.6.x Kernels.

I've attached a small capture of traffic from the test with poor performance.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.


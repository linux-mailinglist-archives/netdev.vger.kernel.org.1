Return-Path: <netdev+bounces-161903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEDBA24886
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 12:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0873A59B3
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 11:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B71E145A07;
	Sat,  1 Feb 2025 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQ3QW82D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715F920318
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738409605; cv=none; b=NpQymYPmIBzEMeXULZofVoUBhVXHTRS6PlDOP5nD+YwszD9DnSMXBPecKSSc/jBN4VECJTk2fVZBlxrctN+yKhPTlzHAWvrEaXK6vgzrIA7U1bRO4sjZX+FaKVw0ho2fKNJEsXeECZc1gFitgolDeyQS7fQxh48HpLSoDdx0Zno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738409605; c=relaxed/simple;
	bh=Fn1qEF9Np+3/oqXI1VfmsIWwgkdylQJ1CTI8Wjl+3Rg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qJIQjCuzwlouIlUKxTi5QXRNcA4gkDJ1NzurC3iz0U5XD/o+5GlfDB3bq2d7uYuz+/yO5gEx4C720ot9ue9Lzm+M92AMA42IR6P9WZIjhnG1zJ6no9+p66Kw8EJWFztTCv2YYDEnrF1Hy2xZ9Hf6wIvkS9FNV2qLqAl/Y6JK7zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQ3QW82D; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3eb9ba53f90so840665b6e.1
        for <netdev@vger.kernel.org>; Sat, 01 Feb 2025 03:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738409602; x=1739014402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t6gSpQYypHPNdNeV2qyXDiVU4Cc2oqo/4LeqN3CA5SI=;
        b=AQ3QW82D1NpnmN+P5uPNuA5PQF+sBKo2vJsHMTV6vEQKygSHohIr+r8uItmPALpSJa
         qZRtE658bVQK7nNtkOzcU1ksaOO495J8GGjodxpVU4BBAPXqzeIpAtP8l2SaWAuMWGf1
         OXRJnUJq1DvBoiaFCQZ7sBJaqhgd/ymjsc9ajAIXxOYDr7Pmdki7VdF+mvqOu1xNdDGx
         d/bITWvCuyHlLE/iZf/bwn3OB8TzMfvEanPbNz3QIXT3HfY3Z0RGv9RYh1Cwac8742rl
         QOiPLrWN0rESuyPvCVMaHVyNVeQ4HDMQi2b7QH0xu0+qH3lJ483g/YW7qNxME35dL10d
         qd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738409602; x=1739014402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6gSpQYypHPNdNeV2qyXDiVU4Cc2oqo/4LeqN3CA5SI=;
        b=wlM5o8EA9/07rNRGq9BGfR4n7V8pOLp+XWOO3sSehIGH10gTakbZTU+WX4lU5xLVqn
         UYbDWf25ICErzDMdhK1KDMmbj9nwYd5afB6B7miDVwUxAseh9m5Tvh6KOjRVhcVjlmZV
         f8Y4SWJkGq8zeNb4+THD9qh9mx41TuRBrJuyl+difq1MzxfDHyO3Pmfzg0c4EHJEdK7c
         nPr7vsmtFrDsRvWzK/+kEmmEiRWqOSMnjXWqzSG23a0hd8Jdkf2qRed4eSjy6EXkaBwW
         o0jyPGdMfcUWM5zLmnubFqIcDoUSdYb8xYKKIJwbus4LIKvHOYQOnv+kWtOWQZiRiCaG
         FKUg==
X-Gm-Message-State: AOJu0YzEIcDVAx5sus+Ki+vBJ6jUFiYpHnnSd0Tuab2KIPhbmWHotMQM
	bHEWwoOFjrGBibRPcU6iQ7WkuOOIWOgBliyXXLYgNqPjXs0IKIs=
X-Gm-Gg: ASbGncvs6ETUwrKff6w3wpi+fDk1uvWx6/SGbAXScStCTEdO6BqVrWGCZkMDSbOUF6Q
	BVBCE/h7d6AufRFuZXcTNsqzVBK5sjGzIDnPfJqLf9qhfJk2Xa+LMdD/UwuvIXlI3t1dWcrQyti
	NoWR9PFJZlExDs00LLx/LCjUtR2gToEpKmwxQT8uyN27zioP/ptm7n91/jWnPMo9xVRYWtubtC5
	riYVgUN57tm6C9WJEhyqn9LgBZOp2ceQc+r17iGw26newC5PRzPMZ13Ft60NZEwUF75SR5659iF
	FFXH/Is7KDBauUCViQ==
X-Google-Smtp-Source: AGHT+IFEWsPh+45GgmFCFIfOIj/Ihg3K98S5QvXOs4DETKkkHXYa8AHfWc0Ts+0YkJOPxMpYk5XDuQ==
X-Received: by 2002:a05:6808:3a0e:b0:3ea:57cf:7c26 with SMTP id 5614622812f47-3f323a73eb7mr10339386b6e.19.1738409602295;
        Sat, 01 Feb 2025 03:33:22 -0800 (PST)
Received: from ted-dallas.. ([2001:19f0:6401:18f2:5400:4ff:fe20:62f])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc105d8a2dsm1359442eaf.35.2025.02.01.03.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 03:33:21 -0800 (PST)
From: Ted Chen <znscnchen@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	Ted Chen <znscnchen@gmail.com>
Subject: [PATCH RFC net-next 0/3] vxlan: Support of Hub Spoke Network to use the same VNI
Date: Sat,  1 Feb 2025 19:32:07 +0800
Message-Id: <20250201113207.107798-1-znscnchen@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

This RFC series proposes an implementation to enable the configuration of vxlan
devices in a Hub-Spoke Network, allowing multiple vxlan devices to share the
same VNI while being associated with different remote IPs under the same UDP
port.

== Use case ==
In a Hub-Spoke Network, there is a central VTEP acting as the gateway, along
with multiple outer VTEPs. Each outer VTEP communicates exclusively with the
central VTEP and has no direct connection to other outer VTEPs. As a result,
data exchanged between outer VTEPs must traverse the central VTEP. This design
enhances security and enables centralized auditing and monitoring at the
central VTEP.

== Existing methods ==
Currently, there are three methods to implement the use case.

Method 1:
         The central VTEP establishes a separate vxlan tunnel with each outer
         VTEP, creating a vxlan device with a different VNI for each tunnel.
         All vxlan devices are then added to the same Linux bridge to enable
         forwarding.

         Drawbacks: Complex configuration.
         Each tenant requires multiple VNIs.

Method 2:
        The central VTEP creates a single vxlan device using the same VNI,
        without configuring a remote IP. The IP addresses of all outer VTEPs
        are stored in the fdb. To enable forwarding, the vxlan device is added
        to a Linux bridge with hairpin mode enabled.

        Drawbacks: unnecessary overhead or network anomalies
        The hairpin mode may broadcast packets to all outer VTEPs, causing the
        source outer VTEP receiving packets it originally sent to the central
        VTEP. If the packet from the source outer VTEP is a broadcast packet,
        the broadcasting back of the packet can cause network anomalies.

Method 3:
        The central VTEP uses the same VNI but different UDP ports to create a
        vxlan device for each outer VTEP, each tunneling to its corresponding
        outer VTEP. All the vxlan devices in the central VTEP are then added to
        the same Linux bridge to enable forwarding.

        Drawbacks: complex configuration and potential security issues.
        Multiple UDP ports are required.

== Proposed implementation ==
In the central VTEP, each tenant only requires a single VNI, and all tenants
share the same UDP port. This can avoid the drawbacks of the above three
methods.

As in below example,
- a tunnel is established between vxlan42.1 in the central VTEP and vxlan42 in
  the outer VTEP1:
  ip link add vxlan42.1 type vxlan id 42 \
          local 10.0.0.3 remote 10.0.0.1 dstport 4789

- a tunnel is established between vxlan42.2 in the central VTEP and vxlan42 in
  the outer VTEP2:
  ip link add vxlan42.2 type vxlan id 42 \
  		  local 10.0.0.3 remote 10.0.0.2 dstport 4789


    ┌────────────────────────────────────────────┐
    │       ┌─────────────────────────┐  central │
    │       │          br0            │    VTEP  │
    │       └─┬────────────────────┬──┘          │
    │   ┌─────┴───────┐      ┌─────┴───────┐     │          
    │   │ vxlan42.1   │      │  vxlan42.2  │     │
    │   └─────────────┘      └─────────────┘     │  
    └───────────────────┬─┬──────────────────────┘
                        │ │ eth0 10.0.0.3:4789
                        │ │            
                        │ │            
       ┌────────────────┘ └───────────────┐
       │eth0 10.0.0.1:4789                │eth0 10.0.0.2:4789
 ┌─────┴───────┐                    ┌─────┴───────┐
 │outer VTEP1  │                    │outer VTEP2  │
 │     vxlan42 │                    │     vxlan42 │
 └─────────────┘                    └─────────────┘


== Test scenario ==
ip netns add ns_1
ip link add veth1 type veth peer name veth1-peer
ip link set veth1 netns ns_1
ip netns exec ns_1 ip addr add 10.0.1.1/24 dev veth1
ip netns exec ns_1 ip link set veth1 up
ip netns exec ns_1 ip link add vxlan42 type vxlan id 42 \
                   remote 10.0.1.3 dstport 4789
ip netns exec ns_1 ip addr add 192.168.0.1/24 dev vxlan42
ip netns exec ns_1 ip link set up dev vxlan42

ip netns add ns_2
ip link add veth2 type veth peer name veth2-peer
ip link set veth2 netns ns_2
ip netns exec ns_2 ip addr add 10.0.1.2/24 dev veth2
ip netns exec ns_2 ip link set veth2 up
ip netns exec ns_2 ip link add vxlan42 type vxlan id 42 \
                   remote 10.0.1.3 dstport 4789
ip netns exec ns_2 ip addr add 192.168.0.2/24 dev vxlan42
ip netns exec ns_2 ip link set up dev vxlan42

ip netns add ns_c
ip link add veth3 type veth peer name veth3-peer
ip link set veth3 netns ns_c
ip netns exec ns_c ip addr add 10.0.1.3/24 dev veth3
ip netns exec ns_c ip link set veth3 up
ip netns exec ns_c ip link add vxlan42.1 type vxlan id 42 \
                   local 10.0.1.3 remote 10.0.1.1 dstport 4789
ip netns exec ns_c ip link add vxlan42.2 type vxlan id 42 \
                   local 10.0.1.3 remote 10.0.1.2 dstport 4789
ip netns exec ns_c ip link set up dev vxlan42.1
ip netns exec ns_c ip link set up dev vxlan42.2
ip netns exec ns_c ip link add name br0 type bridge
ip netns exec ns_c ip link set br0 up
ip netns exec ns_c ip link set vxlan42.1 master br0
ip netns exec ns_c ip link set vxlan42.2 master br0

ip link add name br1 type bridge
ip link set br1 up
ip link set veth1-peer up
ip link set veth2-peer up
ip link set veth3-peer up
ip link set veth1-peer master br1
ip link set veth2-peer master br1
ip link set veth3-peer master br1

ip netns exec ns_1 ping 192.168.0.2 -I 192.168.0.1

Ted Chen (3):
  vxlan: vxlan_vs_find_vni(): Find vxlan_dev according to vni and
    remote_ip
  vxlan: Do not treat vxlan dev as used when unicast remote_ip
    mismatches
  vxlan: vxlan_rcv(): Update comment to inlucde ipv6

 drivers/net/vxlan/vxlan_core.c | 38 +++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

-- 
2.39.2



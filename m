Return-Path: <netdev+bounces-48936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA797F0145
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 18:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF741F229E8
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 17:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2964112E48;
	Sat, 18 Nov 2023 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="EYzCKKRK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21315127
	for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 09:11:45 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-35742cbb670so10686335ab.2
        for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 09:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1700327504; x=1700932304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wp3fHl51XjSsVNmn4N3Fz45TWYQXUqYhFVtzXYVOEGM=;
        b=EYzCKKRKF9BmwLJfEbKZrYiT+0OaFl/50WD15HSFlA0WGU5KNrIu1Cvy1Ugo15ABme
         bVGinOeukjgqrja8gZKrdOntRBmR2QpyHi+3p5VHST5BxW+xI7I4qkBRwAuzqPo6cPu3
         3bKBvolIrlZNsPWwO9xFbfaJOhnatna8BO8Hagx3aqCha1JkMx8LAOeKrFHS3k5lLE0M
         VXIn24/4KkaAe90zXFIaGf+6RqBXkdG3mDQDmBDOegNvvhg2yJ7JrAlfYOAo1DD+pM1o
         H92XjsW0BOQVSRAQPA6V0eVoKCfh8CgnfueGHBaweNgk5YEqQX7AT1JMgAOgR3WJVqOw
         6k4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700327504; x=1700932304;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wp3fHl51XjSsVNmn4N3Fz45TWYQXUqYhFVtzXYVOEGM=;
        b=eAvqTB/aeLP3qhjyN+hAzgzO+Em5sPuNAbPQ28nwGw0DY9eWboe7dynRch3StYxtjj
         GAZMtAFELvuWq9XIfKz7hC/999Jw6xc+gEVU5Lpk4ihHe28HfTIgDN1BVE0Qz5ctI1ql
         lg9UdkDL1Zu/3s9EobA/Ufg7ewNlgjMfsOf5wkkA14X2kP/gstZGH6rs/7NC56WpkzpF
         eBh0leRpYbXbLgsu3r/ENTeDRwYYG0dKeoWcmrvZY9LbZmj6KXhlA3FZswFILHTaFdaP
         39vV61xaf2KUpXNKZH3hzwxI7aVy8pEg0rtxrH4w+EX3TWChZM/V9FHlWdi86Zk3G7p+
         mbbw==
X-Gm-Message-State: AOJu0YwOuFX8aAucijVlmZkVdNRvHIbKV1tbAvftK1kp5ZUL+4UELPxy
	ifLXnKAIkof5K7inBEIdTiNxb9qvPltKqjssL0w=
X-Google-Smtp-Source: AGHT+IE5Kl+xARmday3obgwDp0gtWS0Zha6jlVdcrwZygXPhiz1EN30foIKXRbx9aHQaChg5qIajzw==
X-Received: by 2002:a05:6e02:58f:b0:357:4a63:2ad2 with SMTP id c15-20020a056e02058f00b003574a632ad2mr3038787ils.21.1700327504248;
        Sat, 18 Nov 2023 09:11:44 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id p11-20020a056a000a0b00b0068fb8e18971sm3210660pfh.130.2023.11.18.09.11.43
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 09:11:43 -0800 (PST)
Date: Sat, 18 Nov 2023 09:11:41 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Fw: [Bug 218157] New: Linux bridge corruption ethernet heaser if
 transfer vlan packet if configure tc-vlan rule
Message-ID: <20231118091141.1e650296@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Begin forwarded message:

Date: Sat, 18 Nov 2023 16:38:49 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 218157] New: Linux bridge corruption ethernet heaser if transfer vlan packet if configure tc-vlan rule


https://bugzilla.kernel.org/show_bug.cgi?id=218157

            Bug ID: 218157
           Summary: Linux bridge corruption ethernet heaser if transfer
                    vlan packet if configure tc-vlan rule
           Product: Networking
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: ne-vlezay80@yandex.ru
        Regression: No

TC ingress configuration from network interface:

root@nevlpc:/home/ne-vlezay80#[127] tc filter show dev vm-test10.0 parent ffff:
filter protocol all pref 49152 matchall chain 0 
filter protocol all pref 49152 matchall chain 0 handle 0x1 
  not_in_hw
        action order 1: vlan  push id 10 protocol 802.1Q priority 0 pipe
         index 1 ref 1 bind 1

        action order 2: mirred (Egress Redirect to device vm-test10.0-ifb)
stolen
        index 5 ref 1 bind 1
tcpdump from vm interfaces:
root@nevlpc:/home/ne-vlezay80#[0] tcpdump -i vm-test10.0 -ne not port 22
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on vm-test10.0, link-type EN10MB (Ethernet), snapshot length 262144
bytes
19:34:42.581388 52:54:00:01:55:01 > 33:33:00:00:00:01, ethertype 802.1Q
(0x8100), length 122: vlan 110, p 0, ethertype IPv6 (0x86dd),
fe80::5054:ff:fe01:5501 > ff02::1: ICMP6, echo request, id 3572, seq 0, length
64
19:34:42.713886 08:00:27:66:44:02 > 01:00:5e:00:00:05, ethertype IPv4 (0x0800),
length 82: 192.168.10.1 > 224.0.0.5: OSPFv2, Hello, length 48
19:34:43.581572 52:54:00:01:55:01 > 33:33:00:00:00:01, ethertype 802.1Q
(0x8100), length 122: vlan 110, p 0, ethertype IPv6 (0x86dd),
fe80::5054:ff:fe01:5501 > ff02::1: ICMP6, echo request, id 3572, seq 1, length
64
19:34:44.581718 52:54:00:01:55:01 > 33:33:00:00:00:01, ethertype 802.1Q
(0x8100), length 122: vlan 110, p 0, ethertype IPv6 (0x86dd),
fe80::5054:ff:fe01:5501 > ff02::1: ICMP6, echo request, id 3572, seq 2, length
64
19:34:45.581964 52:54:00:01:55:01 > 33:33:00:00:00:01, ethertype 802.1Q
(0x8100), length 122: vlan 110, p 0, ethertype IPv6 (0x86dd),
fe80::5054:ff:fe01:5501 > ff02::1: ICMP6, echo request, id 3572, seq 3, length
64
19:34:46.129360 08:00:27:66:44:02 > 33:33:00:00:00:05, ethertype IPv6 (0x86dd),
length 94: fe80::a00:27ff:fe66:4402 > ff02::5: OSPFv3, Hello, length 40
19:34:47.314145 52:54:00:01:55:01 > 08:00:27:66:44:02, ethertype IPv4 (0x0800),
length 85: 172.18.3.1.33850 > 172.18.3.0.179: Flags [P.], seq
3664159432:3664159451, ack 4138575432, win 504, options [nop,nop,TS val
288779010 ecr 3989811588], length 19: BGP
19:34:47.314555 08:00:27:66:44:02 > 52:54:00:01:55:01, ethertype IPv4 (0x0800),
length 85: 172.18.3.0.179 > 172.18.3.1.33850: Flags [P.], seq 1:20, ack 19, win
502, options [nop,nop,TS val 3989871588 ecr 288779010], length 19: BGP
19:34:47.314703 52:54:00:01:55:01 > 08:00:27:66:44:02, ethertype IPv4 (0x0800),
length 66: 172.18.3.1.33850 > 172.18.3.0.179: Flags [.], ack 20, win 504,
options [nop,nop,TS val 288779011 ecr 3989871588], length 0
19:34:47.482985 52:54:00:01:55:01 > 01:00:5e:00:00:05, ethertype IPv4 (0x0800),
length 82: 192.168.10.2 > 224.0.0.5: OSPFv2, Hello, length 48
^C
10 packets captured
10 packets received by filter
0 packets dropped by kernel
root@nevlpc:/home/ne-vlezay80#[0] 
tcpdump width switch:
root@nevlpc:/home/ne-vlezay80#[1] tcpdump -i vm-test1 -ne not port 22
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on vm-test1, link-type EN10MB (Ethernet), snapshot length 262144
bytes
19:35:57.483216 52:54:00:01:55:01 > 01:00:5e:00:00:05, ethertype 802.1Q
(0x8100), length 86: vlan 10, p 0, ethertype IPv4 (0x0800), 192.168.10.2 >
224.0.0.5: OSPFv2, Hello, length 48
19:36:00.138697 55:01:81:00:00:6e > 00:01:52:54:00:01, ethertype 802.1Q
(0x8100), length 122: vlan 10, p 0, ethertype IPv6 (0x86dd),
fe80::5054:ff:fe01:5501 > ff02::1: ICMP6, echo request, id 3573, seq 0, length
64
19:36:00.351335 52:54:00:01:55:01 > 33:33:00:00:00:05, ethertype 802.1Q
(0x8100), length 98: vlan 10, p 0, ethertype IPv6 (0x86dd),
fe80::5054:ff:fe01:5501 > ff02::5: OSPFv3, Hello, length 40
19:36:01.138953 55:01:81:00:00:6e > 00:01:52:54:00:01, ethertype 802.1Q
(0x8100), length 122: vlan 10, p 0, ethertype IPv6 (0x86dd),
fe80::5054:ff:fe01:5501 > ff02::1: ICMP6, echo request, id 3573, seq 1, length
64
19:36:02.722027 08:00:27:66:44:02 > 01:00:5e:00:00:05, ethertype 802.1Q
(0x8100), length 86: vlan 10, p 0, ethertype IPv4 (0x0800), 192.168.10.1 >
224.0.0.5: OSPFv2, Hello, length 48
^C
5 packets captured
5 packets received by filter
0 packets dropped by kernel
root@nevlpc:/home/ne-vlezay80#[0] 

VLAN map:
110 - test vlan
10 - vm vlan

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.


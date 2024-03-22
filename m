Return-Path: <netdev+bounces-81349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96492887598
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 00:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0528BB2259F
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 23:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5AB8288B;
	Fri, 22 Mar 2024 23:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="HtxQWjCn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CF982877
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 23:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711148575; cv=none; b=B3iLk87sCGtROn5pVLQKcIc4T7p9dygI1ZRdjh728UE/n0asLGMZDWsXbEMv7fm9PgjgTF1DJTFKyxVjk6cjG/9qmSB25F37cd301TaFo+k58cFpFNSuqfj0lFQN2aNqR9gVTb2gMtAhjD20QhjPKpEOcS37FBAQtBPCUxm/z9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711148575; c=relaxed/simple;
	bh=0eqZC8b76TIj9YpyZJlPZsK9BecoExWtHqoHCBR0lvk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=p8ao21LmWNq1cPcg4176M844+9zuyehDMSySk3lxfRhIYsFHpzUfW3+IRSHMi6G8dQgzVfaQoY2Ef7trfusll+cOf3IQ0Y3DjwJ5bFWCWmBWkwtY773mCu7s/MaS1+ehtSFY70WpmqNcwIrYPD4AeUHEjDHDxcAeTww/OfiClfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=HtxQWjCn; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e6b5432439so1982510b3a.1
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 16:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1711148572; x=1711753372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nOF45oPewrbgAFGs9PehVv+IH5EFhX4gC1bDNYF7XSE=;
        b=HtxQWjCnbT29JMa7LJVDOP3aNNGs7UTJOBDXZUBvnVgqK/W24peZFqleBaNXw+Xjgd
         B6j8t++zD1hMk4j3CwT4pb4mSkXz68FTMA+8mS1Gn2h+JabllgEhZmLlZepLcaVkxcPc
         Py1Jks7cUh0GRmdKh/KsQnRyGJ69inJ+xg3HuuSwiuHZFTOMRY7gIix6dpFECh52OsZr
         4V3eSgyGJI+SvEYQ9r57gAWL+pnb16IGC/8l3nEbhatft76HYZ1CV6sLECNKWs1PltHC
         hmir/oidhAmaOdvj3rpj1f/cg3ltyiJr8km1MyUN1xZ53RasJkbMv/afKXWSvDrcEbXc
         94Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711148572; x=1711753372;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOF45oPewrbgAFGs9PehVv+IH5EFhX4gC1bDNYF7XSE=;
        b=du6wa//JSm3RQI64bZyg3n1baw7yV//BL0PQFuzo+g8bnlq8K2vfOL2fugzSjTDfHk
         S5VM9TjHCSWwyZ1qQHJScGJL8c4As+LPj94wf3w3hXJn/EY5ZW4/wZR5Tg6Lly/jIH/S
         S/O11VasdZ5QtqLqPCVdFI5ZF+7kzKOo9t9kpNrX6GjNkcAjGUx2IY7918A/ax/A+dVm
         zVGNnQiZKnctue39rN0mZI4fVledyCWQTsk14aNXnFCCX9nuhHuUIa1nJu9Vt030LVyC
         M6qMOaHaFTinOxVUSibEzITOWHpWuOMN2FJEe/jfOhydhiKF6DDpltXwVgYJTJkwqFNX
         V4MA==
X-Gm-Message-State: AOJu0YxOBA/y6rEn+O6X4nJEVeidqFnWlDpdneJfFgSJ5I1lxmowpjGh
	i/Ck/c5f6W1KUct5J//fNvpSpBkCzTyN6EOHfack385bkyM/lk+RsmAbbNP3mjL1tGWzojh2sJf
	F
X-Google-Smtp-Source: AGHT+IEY21ut++8umLPne3jyB1A0cTOXqs4zRgMBupRBcYJ9muuDysrxmAdZOo/R0b04st+MC3lxuQ==
X-Received: by 2002:a05:6a00:1ad0:b0:6ea:8604:cb12 with SMTP id f16-20020a056a001ad000b006ea8604cb12mr1376493pfv.31.1711148570976;
        Fri, 22 Mar 2024 16:02:50 -0700 (PDT)
Received: from hermes.local (204-195-123-203.wavecable.com. [204.195.123.203])
        by smtp.gmail.com with ESMTPSA id y4-20020aa79e04000000b006e55a21ac02sm283047pfq.152.2024.03.22.16.02.50
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 16:02:50 -0700 (PDT)
Date: Fri, 22 Mar 2024 16:02:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Fw: [Bug 218629] New: tc-vlan push vlan is regression from the lab
Message-ID: <20240322160249.5190c144@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Begin forwarded message:

Date: Fri, 22 Mar 2024 19:00:46 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 218629] New: tc-vlan push vlan is regression from the lab


https://bugzilla.kernel.org/show_bug.cgi?id=218629

            Bug ID: 218629
           Summary: tc-vlan push vlan is regression from the lab
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

Created attachment 306027
  --> https://bugzilla.kernel.org/attachment.cgi?id=306027&action=edit  
lab for reproducte the bug

Exec: netns.sh - create test namespaces
Exec: switch.sh - load tc-vlan rule per the namespace
Problem:
tc-vlan regression

Example:
[root@arch user]# ip netns exec host1 iperf3 -c 192.168.1.16
Connecting to host 192.168.1.16, port 5201
[  5] local 192.168.1.2 port 47824 connected to 192.168.1.16 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   717 MBytes  6.01 Gbits/sec   30   9.97 MBytes       
[  5]   1.00-2.00   sec   736 MBytes  6.17 Gbits/sec    2   9.97 MBytes       
[  5]   2.00-3.00   sec   574 MBytes  4.81 Gbits/sec    0   9.97 MBytes       
[  5]   3.00-4.00   sec   582 MBytes  4.88 Gbits/sec    0   9.97 MBytes       
[  5]   4.00-5.00   sec   687 MBytes  5.76 Gbits/sec    0   9.97 MBytes       
[  5]   5.00-6.00   sec   737 MBytes  6.16 Gbits/sec    3   6.98 MBytes       
[  5]   6.00-7.00   sec   716 MBytes  6.03 Gbits/sec    0   6.98 MBytes       
[  5]   7.00-8.00   sec   705 MBytes  5.92 Gbits/sec    3   4.88 MBytes       
[  5]   8.00-9.00   sec   645 MBytes  5.39 Gbits/sec    0   4.88 MBytes       
[  5]   9.00-10.00  sec   705 MBytes  5.92 Gbits/sec    1   4.88 MBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  7.01 GBytes  6.02 Gbits/sec   39             sender
[  5]   0.00-10.00  sec  7.01 GBytes  6.02 Gbits/sec                  receiver

iperf Done.
[root@arch user]# ip netns exec host1 iperf3 -c 192.168.1.16 -R
Connecting to host 192.168.1.16, port 5201
Reverse mode, remote host 192.168.1.16 is sending
[  5] local 192.168.1.2 port 60818 connected to 192.168.1.16 port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  1.35 GBytes  11.6 Gbits/sec                  
[  5]   1.00-2.00   sec  1.42 GBytes  12.2 Gbits/sec                  
[  5]   2.00-3.00   sec  1.44 GBytes  12.3 Gbits/sec                  
[  5]   3.00-4.00   sec  1.41 GBytes  12.1 Gbits/sec                  
[  5]   4.00-5.00   sec  1.40 GBytes  12.0 Gbits/sec                  
[  5]   5.00-6.00   sec  1.38 GBytes  11.8 Gbits/sec                  
[  5]   6.00-7.00   sec  1.41 GBytes  12.1 Gbits/sec                  
[  5]   7.00-8.00   sec  1.41 GBytes  12.1 Gbits/sec                  
[  5]   8.00-9.00   sec  1.39 GBytes  12.0 Gbits/sec                  
[  5]   9.00-10.00  sec  1.42 GBytes  12.2 Gbits/sec                  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  14.0 GBytes  12.0 Gbits/sec  306             sender
[  5]   0.00-10.00  sec  14.0 GBytes  12.0 Gbits/sec                  receiver

iperf Done.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.


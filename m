Return-Path: <netdev+bounces-95744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA9F8C33CB
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 23:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F48281A6F
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 21:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706F6208D7;
	Sat, 11 May 2024 21:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rjmcmahon.com header.i=@rjmcmahon.com header.b="l4Y2aN11"
X-Original-To: netdev@vger.kernel.org
Received: from bobcat.rjmcmahon.com (bobcat.rjmcmahon.com [45.33.58.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958F71CD3B
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 21:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.58.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715461318; cv=none; b=N4nr7GwpNEkILDkTIkV0hiehbSb6GTuRtTn6y8bU6zqCDe1VyRI25Z1edKPrIUWheiRC84Z7LEPziZQihB5FjLwL8XKjzq8Tq152WNXv5n/O3hbiJ6U959KmvHXt6KgqTVkxv0+GuiyHst7/B7DncHJbb57HUEBgYh6uTVB+b28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715461318; c=relaxed/simple;
	bh=D1BUHWgSXd6+/ewuX2WsHeRgbc4hgL4d4s0JnSWNLoI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=f1IDEi4YjAQSKz0CrZjB8Ybw06i6Xh8GkXc5TRYlGl3TAdvugkHt081K/QKxv0BkjbpNTuFREHig1pe8+vsRZLWUaXpAEPnd1fPzz4qiFn8dKYjP642PCQQQcSC9lsFrsfz3rqanX7hvc6+D0z4VFEMXbE7zGobKAg85mAeFad8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rjmcmahon.com; spf=pass smtp.mailfrom=rjmcmahon.com; dkim=pass (1024-bit key) header.d=rjmcmahon.com header.i=@rjmcmahon.com header.b=l4Y2aN11; arc=none smtp.client-ip=45.33.58.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rjmcmahon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjmcmahon.com
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bobcat.rjmcmahon.com (Postfix) with ESMTPSA id 020951B4EC
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 13:52:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 bobcat.rjmcmahon.com 020951B4EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjmcmahon.com;
	s=bobcat; t=1715460741;
	bh=sJ6jX2SZeZ27xbPP+zOqZQvylZuwfGUR2IzubPNoaQM=;
	h=From:Date:Subject:To:From;
	b=l4Y2aN11M5JwdfQ6j1PTvTe4XdCxssgi8dAxbuiDgrTjMMYek2ECvIowgSp1+t2s8
	 o1H/l/anhCXI6PNuRnUQP0Sfq3/DKqJjEROSwELk0IuV6bXepyJ+v7wR01PqQLG4bO
	 Q1ctMZEm6Sa9Wxs9YKisTBTSoxHlSARpSAfbaxQY=
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-de60d05adafso3055966276.2
        for <netdev@vger.kernel.org>; Sat, 11 May 2024 13:52:20 -0700 (PDT)
X-Gm-Message-State: AOJu0YwKRXUAf+Vn/BqIUB6wYa9F+Unn8TR4tKUsultY90SPG0RiKHju
	Kwdjk+Bway6R7EfPkn4dxxo4FH65h+GuZ9e4hjxmrwS/Wm731G9ovmGZDFmETrWxlNzen425Z98
	/0EJBv1knPrP6H1zl9BN4FD6nntU=
X-Google-Smtp-Source: AGHT+IFM+yLXPADzobY9zupY7Fmq4dAh+wGcEbpi5S+aH3XrqvGc2naqWrdHnDSskM3EuyTLqcL4SttzROmp7LxN6qY=
X-Received: by 2002:a05:6902:110:b0:de6:b58:fe72 with SMTP id
 3f1490d57ef6-dee4f4ed89emr5658566276.58.1715460740095; Sat, 11 May 2024
 13:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Robert McMahon <rjmcmahon@rjmcmahon.com>
Date: Sat, 11 May 2024 13:52:09 -0700
X-Gmail-Original-Message-ID: <CAEBrVk6at+OG7Tw3yU1U95=zSUoGR0m0G6Tx1oj29fK=EbowQQ@mail.gmail.com>
Message-ID: <CAEBrVk6at+OG7Tw3yU1U95=zSUoGR0m0G6Tx1oj29fK=EbowQQ@mail.gmail.com>
Subject: Feedback request: iperf 2 asymmetric bounceback outputs
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi All,

One feature of iperf 2's bouncecback is the asymmetric write size
between the request and reply. I'm considering the output as shown
below. The transfer values include both directions. The per direction
is bytes only. Comments are welcome.

rjmcmahon@fedora:~/Code/bb/iperf2-code$ src/iperf -c 127.0.0.1 -e -i 1
-t 3 --bounceback=1 --bounceback-period 0 --bounceback-request 1000
--bounceback-reply 500
------------------------------------------------------------
Client connecting to 127.0.0.1, TCP port 5001 with pid 63480 (1/0 flows/load)
Bounceback test (req/reply size =1000 Byte/ 500 Byte) (server hold
req=0 usecs & tcp_quickack)
TCP congestion control using cubic
TOS defaults to 0x0 (dscp=0,ecn=0) and nodelay (Nagle off)
TCP window size: 2.50 MByte (default)
------------------------------------------------------------
[  1] local 127.0.0.1%lo port 47210 connected with 127.0.0.1 port 5001
(bb w/quickack req/reply/hold=1000/500/0)
(icwnd/mss/irtt=162/16640/32) (ct=0.08 ms) on 2024-05-11
13:27:11.441673 (PDT)
[ ID] Interval        Transfer    Bandwidth         BB
cnt=avg/min/max/stdev         Rtry  Cwnd(pkts)/RTT(var)   Tx/Rx bytes
RPS(avg)
[  1] 0.00-1.00 sec  63.2 MBytes   530 Mbits/sec
44171=0.022/0.016/0.389/0.003 ms    0 639K/(10)/13(0) us  Tx=42.1
MByte Rx=21.1 MByte  RPS=46006
[  1] 1.00-2.00 sec  45.3 MBytes   380 Mbits/sec
31671=0.030/0.022/0.086/0.007 ms    0 639K/(10)/19(0) us  Tx=30.2
MByte Rx=15.1 MByte  RPS=32967
[  1] 2.00-3.00 sec  38.0 MBytes   319 Mbits/sec
26581=0.036/0.031/0.077/0.003 ms    0 639K/(10)/19(1) us  Tx=25.3
MByte Rx=12.7 MByte  RPS=27715
[  1] 0.00-3.01 sec   147 MBytes   408 Mbits/sec
102424=0.028/0.016/0.389/0.008 ms    0   -(-)/-(-)    Tx=97.7 MByte
Rx=48.8 MByte  RPS=35565
[  1] 0.00-3.01 sec  BB8(f)-PDF:
bin(w=100us):cnt(102424)=1:102421,2:1,4:2
(5.00/95.00/99.7%=1/1/1,Outliers=0,obl/obu=0/0)

Thanks in advance for any comments,
Bob


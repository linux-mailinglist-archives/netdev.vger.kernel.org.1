Return-Path: <netdev+bounces-107781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBD191C513
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 19:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A041F21343
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 17:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F451CCCBA;
	Fri, 28 Jun 2024 17:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rjmcmahon.com header.i=@rjmcmahon.com header.b="GnC7iw4Q"
X-Original-To: netdev@vger.kernel.org
Received: from bobcat.rjmcmahon.com (bobcat.rjmcmahon.com [45.33.58.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BE61CCCBF
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.58.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719596496; cv=none; b=R+q28E3Tgov9ynAJM7wSMwD/89q+/hlmK9vNt6eIqGUOkoqFyvyx3ERvRm4lvjbxClx2V8t/R2e1yIuxIPVaH5haT1ytGyJqFFpdXcnbF4sX0WvcYQJ4+IBMQpAnvKU+aV7D7EliydA8Py+yxIcJ6MbigUwuzGAvE8zBlYcdyV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719596496; c=relaxed/simple;
	bh=d0MHfk0+NaEQn2UUeD3s+ZELj5ZUrUygcFgdptk2p/c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=hRxb8M+l7YnK2dEBR9u71oM8gp4kLzxQ00wRJ4O7LmaDicnpZXA0NYmxLSavhC/W4x4zPAIbeG3nVmqVic04E1XxeYFhOzbc5GwFSVZjaGNbDKM0tKvWEs9+quIpSNKV0fcyxJRJsIWP1LMZLWiN6b1gr1/cbIwMLoe0VyXwY0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rjmcmahon.com; spf=pass smtp.mailfrom=rjmcmahon.com; dkim=pass (1024-bit key) header.d=rjmcmahon.com header.i=@rjmcmahon.com header.b=GnC7iw4Q; arc=none smtp.client-ip=45.33.58.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rjmcmahon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjmcmahon.com
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bobcat.rjmcmahon.com (Postfix) with ESMTPSA id 847CA1B312
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 10:34:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 bobcat.rjmcmahon.com 847CA1B312
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjmcmahon.com;
	s=bobcat; t=1719596050;
	bh=DFUfDAyyI0/i+Krmj/BBJl9foMxUucoIg6e0Mlss5Wc=;
	h=From:Date:Subject:To:From;
	b=GnC7iw4QM6OUjxEFFZcIMkmfvcRkOPAPfXiNyiS1H3mEYQwGMUp4vrNrBKWlGzPfi
	 Gk9bMMCAckBcILFlUIFvboTfE2V+InZq/wac5fzAdyaNZyVBhsMnPXVwmo+fMqO/Em
	 i8adYXUH6euFybUy5f5xvqS38d4iTZ2EDdMQsK1Q=
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dff02b8a956so608640276.1
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 10:34:10 -0700 (PDT)
X-Gm-Message-State: AOJu0YxCDFe6n6Pn8odhh6R7VICoqDZpaAC+boFu+21/bATNCfeP3Mcc
	v/CuAcL0pwdyxUUeQrEIY2zQJ65C2xBCggpOKb8ygzUA9S30AzNHFgPhQsXBVnC+n2XzlP2c9Zn
	FA+ooOpTAi3vCF2hzai91sav+DOs=
X-Google-Smtp-Source: AGHT+IF/xGH16zdA9UdO6HAefjSN94ACVEil3Q9KYQR2I9ooo7qjKDsvY2Gc3wqxYbQ1ypgluJe2kYKVXt4+u1fxjHQ=
X-Received: by 2002:a25:838d:0:b0:e03:3d0a:bb14 with SMTP id
 3f1490d57ef6-e033d0acef5mr6662792276.11.1719596049805; Fri, 28 Jun 2024
 10:34:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Robert McMahon <rjmcmahon@rjmcmahon.com>
Date: Fri, 28 Jun 2024 10:33:59 -0700
X-Gmail-Original-Message-ID: <CAEBrVk5BNZmJWAK0q+eX0zxEq+VJtf0C7pK-xvCMGTo6Ct6jMQ@mail.gmail.com>
Message-ID: <CAEBrVk5BNZmJWAK0q+eX0zxEq+VJtf0C7pK-xvCMGTo6Ct6jMQ@mail.gmail.com>
Subject: Little's law byte wait time and iperf 2
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi All,

I have two questions with respect to adding support for TCP byte wait
times based on Little's law into iperf 2.

1) Is this avg byte wait time field useful
2) Should the queue depth be based on the sampled CWND or the bytes inflight

Thanks in advance for comments on this (including a better column header name)

Example output:

rjmcmahon@fedora:~/Code/pyflows/iperf2-code$ src/iperf -c 192.168.1.77
-i 1 -e --fq-rate 100m -w 4M --tcp-write-prefetch 256K
------------------------------------------------------------
Client connecting to 192.168.1.77, TCP port 5001 with pid 60030 (1/0 flows/load)
Write buffer size: 131072 Byte
fair-queue socket pacing set to  100 Mbit/s
TCP congestion control using cubic
TOS defaults to 0x0 (dscp=0,ecn=0) (Nagle on)
TCP window size: 8.00 MByte (WARNING: requested 4.00 MByte)
Event based writes (pending queue watermark at 262144 bytes)
------------------------------------------------------------
[  1] local 192.168.1.103%enp4s0 port 55468 connected with
192.168.1.77 port 5001 (prefetch=262144) (icwnd/mss/irtt=14/1448/627)
(ct=0.69 ms) on 2024-06-28 10:21:14.724 (PDT)
[ ID] Interval        Transfer    Bandwidth      Wait        Write/Err
 Rtry     InF(pkts)/Cwnd(pkts)/RTT(var)  fq-rate  NetPwr
[  1] 0.00-1.00 sec  12.3 MBytes   103 Mbits/sec  15.147 ms    99/0
   0      190K(135)/207K(147)/403(25) us  100 Mbit/sec 31874
[  1] 1.00-2.00 sec  11.9 MBytes  99.6 Mbits/sec  10.444 ms    95/0
   0      127K(90)/207K(147)/384(21) us  100 Mbit/sec 32427
[  1] 2.00-3.00 sec  12.0 MBytes   101 Mbits/sec  15.462 ms    96/0
   0      190K(135)/207K(147)/366(17) us  100 Mbit/sec 34380
[  1] 3.00-4.00 sec  11.9 MBytes  99.6 Mbits/sec  10.444 ms    95/0
   0      127K(90)/207K(147)/385(13) us  100 Mbit/sec 32342
[  1] 4.00-5.00 sec  12.0 MBytes   101 Mbits/sec  15.462 ms    96/0
   0      190K(135)/207K(147)/378(26) us  100 Mbit/sec 33288
[  1] 5.00-6.00 sec  11.9 MBytes  99.6 Mbits/sec  10.444 ms    95/0
   0      127K(90)/207K(147)/394(30) us  100 Mbit/sec 31604
[  1] 6.00-7.00 sec  11.9 MBytes  99.6 Mbits/sec  10.444 ms    95/0
   0      127K(90)/207K(147)/385(19) us  100 Mbit/sec 32342
[  1] 7.00-8.00 sec  12.0 MBytes   101 Mbits/sec  15.462 ms    96/0
   0      190K(135)/207K(147)/384(19) us  100 Mbit/sec 32768
[  1] 8.00-9.00 sec  11.9 MBytes  99.6 Mbits/sec  10.444 ms    95/0
   0      127K(90)/207K(147)/349(17) us  100 Mbit/sec 35679
[  1] 9.00-10.00 sec  12.0 MBytes   101 Mbits/sec  15.462 ms    96/0
    0      190K(135)/207K(20) us 32113

Bob

https://en.wikipedia.org/wiki/Little%27s_law


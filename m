Return-Path: <netdev+bounces-42434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5397CEB02
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 00:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A4A281CE6
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 22:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EF743A88;
	Wed, 18 Oct 2023 22:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rjmcmahon.com header.i=@rjmcmahon.com header.b="L3v6l5WC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB873FB0D
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 22:10:12 +0000 (UTC)
Received: from bobcat.rjmcmahon.com (bobcat.rjmcmahon.com [45.33.58.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B5A113
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 15:10:09 -0700 (PDT)
Received: from mail.rjmcmahon.com (bobcat.rjmcmahon.com [45.33.58.123])
	by bobcat.rjmcmahon.com (Postfix) with ESMTPA id 6988A1B26F
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 15:10:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 bobcat.rjmcmahon.com 6988A1B26F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjmcmahon.com;
	s=bobcat; t=1697667009;
	bh=ga81rokYqtwAcvC9+E0HgR9iqsXmt1dkUI1iOJEZ0BI=;
	h=Date:From:To:Subject:From;
	b=L3v6l5WCBXPcJber1IEOh7R+ytTgem6Y8R2SoLUcEf0l/g+IxpPCBQ8v39Lcmk7Av
	 hLLuIMfcLpO0pgLD1kolXIEtJH6DKkcjzHkyB2dQBd+THdsedRdsbvMk909o7MpvLF
	 CAXBSFEda46NBPgmxXRqEHRTkhoyVMdnQGbniNhQ=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 18 Oct 2023 15:10:09 -0700
From: rjmcmahon <rjmcmahon@rjmcmahon.com>
To: Netdev <netdev@vger.kernel.org>
Subject: iperf 2 & clock unsync detection
Message-ID: <67af57222b0fb1c97b190e66678f44e2@rjmcmahon.com>
X-Sender: rjmcmahon@rjmcmahon.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

One can use the bounceback test to check if the clock's are not 
synchronized relative to the bb time.  (you'll need to compile the 
latest iperf from master to get this 
https://sourceforge.net/projects/iperf2/

Below is an example:

root@raspberrypi:/usr/local/src/iperf2-code# iperf -c 192.168.1.33 -e -i 
1 --trip-times --bounceback --bounceback-period 0
------------------------------------------------------------
Client connecting to 192.168.1.33, TCP port 5001 with pid 38489 (1/0 
flows/load)
Bounceback test (req/reply size = 100 Byte/ 100 Byte) (server hold req=0 
usecs & tcp_quickack)
TCP congestion control using cubic
TOS set to 0x0 and nodelay (Nagle off)
TCP window size: 85.0 KByte (default)
Event based writes (pending queue watermark at 16384 bytes)
------------------------------------------------------------
[  1] local 192.168.1.32%eth0 port 42258 connected with 192.168.1.33 
port 5001 (prefetch=16384) (bb w/quickack req/reply/hold=100/100/0) 
(trip-times) (sock=3) (icwnd/mss/irtt=14/1448/265) (ct=0.43 ms) on 
2023-10-18 14:49:24.047 (PDT)
[ ID] Interval        Transfer    Bandwidth         BB 
cnt=avg/min/max/stdev         Rtry  Cwnd/RTT    RPS(avg)
[  1] 0.00-1.00 sec   998 KBytes  8.18 Mbits/sec    
10223=0.093/0.078/1.057/0.027 ms    0   14K/62 us    10729 rps
[  1] 1.00-2.00 sec  1.06 MBytes  8.93 Mbits/sec    
11166=0.086/0.077/0.225/0.003 ms    0   14K/61 us    11631 rps
[  1] 2.00-3.00 sec  1.07 MBytes  8.94 Mbits/sec    
11172=0.086/0.077/0.434/0.004 ms    0   14K/60 us    11633 rps
[  1] 3.00-4.00 sec  1.06 MBytes  8.87 Mbits/sec    
11092=0.087/0.079/0.376/0.005 ms    0   14K/62 us    11547 rps
[  1] 4.00-5.00 sec   979 KBytes  8.02 Mbits/sec    
10025=0.096/0.090/0.442/0.004 ms    0   14K/61 us    10402 rps
[  1] 5.00-6.00 sec   960 KBytes  7.86 Mbits/sec    
9831=0.098/0.090/0.413/0.008 ms    0   14K/61 us    10213 rps
[  1] 6.00-7.00 sec   984 KBytes  8.06 Mbits/sec    
10080=0.096/0.090/0.150/0.002 ms    0   14K/61 us    10461 rps
[  1] 7.00-8.00 sec   983 KBytes  8.06 Mbits/sec    
10070=0.096/0.090/0.168/0.002 ms    0   14K/61 us    10452 rps
[  1] 8.00-9.00 sec   984 KBytes  8.06 Mbits/sec    
10074=0.096/0.092/0.149/0.002 ms    0   14K/61 us    10455 rps
[  1] 9.00-10.00 sec   982 KBytes  8.04 Mbits/sec    
10056=0.096/0.087/0.446/0.004 ms    0   14K/64 us    10434 rps
[  1] 0.00-10.01 sec  9.90 MBytes  8.29 Mbits/sec    
103791=0.093/0.077/1.057/0.011 ms    0   14K/1729 us    10795 rps
[  1] 0.00-10.01 sec  OWD (ms) Cnt=103791 TX=0.770/-0.357/4.012/1.683 
RX=-0.678/-3.709/0.789/1.686 Asymmetry=2.299/0.001/7.702/2.857
[  1] 0.00-10.01 sec  OWD-TX-PDF: 
bin(w=100us):cnt(103791)=1:14920,2:263,3:275,4:271,5:273,6:272,7:272,8:272,9:271,10:272,11:270,12:275,13:273,14:272,15:269,16:272,17:272,18:272,19:272,20:273,21:271,22:269,23:273,24:271,25:272,26:273,27:273,28:270,29:272,30:271,31:272,32:271,33:273,34:270,35:271,36:272,37:269,38:20475,39:625,40:2,41:1 
(5.00/95.00/99.7%=1/100000/100000,Outliers=0,obl/obu=57994/0)
[  1] 0.00-10.01 sec  OWD-RX-PDF: 
bin(w=100us):cnt(103791)=1:12175,2:3139,3:3132,4:3136,5:51552,6:5,8:2 
(5.00/95.00/99.7%=1/100000/100000,Outliers=0,obl/obu=30650/0)
[  1] 0.00-10.01 sec  BB8-PDF: 
bin(w=100us):cnt(103791)=1:100388,2:3136,3:258,4:4,5:4,11:1 
(5.00/95.00/99.7%=1/1/2,Outliers=0,obl/obu=0/0)
[  1] 0.00-10.01 sec  Clock sync error count = 92028

Below is an example where the clock are sync'd - there is no Clock sync 
error count message

root@raspberrypi:/usr/local/src/iperf2-code# iperf -c 192.168.1.33 -e -i 
1 --trip-times --bounceback --bounceback-period 0
------------------------------------------------------------
Client connecting to 192.168.1.33, TCP port 5001 with pid 38492 (1/0 
flows/load)
Bounceback test (req/reply size = 100 Byte/ 100 Byte) (server hold req=0 
usecs & tcp_quickack)
TCP congestion control using cubic
TOS set to 0x0 and nodelay (Nagle off)
TCP window size: 85.0 KByte (default)
Event based writes (pending queue watermark at 16384 bytes)
------------------------------------------------------------
[  1] local 192.168.1.32%eth0 port 46112 connected with 192.168.1.33 
port 5001 (prefetch=16384) (bb w/quickack req/reply/hold=100/100/0) 
(trip-times) (sock=3) (icwnd/mss/irtt=14/1448/291) (ct=0.46 ms) on 
2023-10-18 14:51:27.555 (PDT)
[ ID] Interval        Transfer    Bandwidth         BB 
cnt=avg/min/max/stdev         Rtry  Cwnd/RTT    RPS(avg)
[  1] 0.00-1.00 sec  1003 KBytes  8.22 Mbits/sec    
10270=0.093/0.079/1.218/0.025 ms    0   14K/61 us    10775 rps
[  1] 1.00-2.00 sec  1.06 MBytes  8.93 Mbits/sec    
11166=0.086/0.078/0.322/0.005 ms    0   14K/60 us    11628 rps
[  1] 2.00-3.00 sec  1.07 MBytes  8.94 Mbits/sec    
11175=0.086/0.078/0.263/0.003 ms    0   14K/61 us    11635 rps
[  1] 3.00-4.00 sec  1.06 MBytes  8.93 Mbits/sec    
11167=0.086/0.078/0.313/0.004 ms    0   14K/60 us    11630 rps
[  1] 4.00-5.00 sec   998 KBytes  8.18 Mbits/sec    
10224=0.094/0.080/0.410/0.006 ms    0   14K/62 us    10614 rps
[  1] 5.00-6.00 sec   958 KBytes  7.85 Mbits/sec    
9811=0.098/0.088/0.432/0.009 ms    0   14K/61 us    10187 rps
[  1] 6.00-7.00 sec   982 KBytes  8.05 Mbits/sec    
10060=0.096/0.090/0.306/0.003 ms    0   14K/61 us    10437 rps
[  1] 7.00-8.00 sec   980 KBytes  8.03 Mbits/sec    
10035=0.096/0.090/0.927/0.015 ms    0   14K/61 us    10409 rps
[  1] 8.00-9.00 sec   981 KBytes  8.04 Mbits/sec    
10048=0.096/0.090/0.763/0.010 ms    0   14K/61 us    10424 rps
[  1] 9.00-10.00 sec   982 KBytes  8.04 Mbits/sec    
10054=0.096/0.092/0.287/0.003 ms    0   14K/61 us    10432 rps
[  1] 0.00-10.01 sec  9.92 MBytes  8.31 Mbits/sec    
104011=0.092/0.078/1.218/0.012 ms    0   14K/1009 us    10816 rps
[  1] 0.00-10.01 sec  OWD (ms) Cnt=104011 TX=0.040/0.030/0.680/0.005 
RX=0.053/0.045/0.887/0.008 Asymmetry=0.013/0.000/0.847/0.006
[  1] 0.00-10.01 sec  OWD-TX-PDF: 
bin(w=100us):cnt(104011)=1:103967,2:31,3:9,4:2,6:1,7:1 
(5.00/95.00/99.7%=1/1/1,Outliers=0,obl/obu=0/0)
[  1] 0.00-10.01 sec  OWD-RX-PDF: 
bin(w=100us):cnt(104011)=1:103769,2:226,3:13,4:1,8:1,9:1 
(5.00/95.00/99.7%=1/1/1,Outliers=0,obl/obu=0/0)
[  1] 0.00-10.01 sec  BB8-PDF: 
bin(w=100us):cnt(104011)=1:100646,2:3146,3:198,4:10,5:4,6:1,7:1,8:2,10:2,13:1 
(5.00/95.00/99.7%=1/1/2,Outliers=0,obl/obu=0/0)

Bob


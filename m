Return-Path: <netdev+bounces-57262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C4D812AD5
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 09:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79D661C21123
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 08:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A6C2575A;
	Thu, 14 Dec 2023 08:55:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from borne-mail2.ac-clermont.fr (borne-mail2.ac-clermont.fr [194.254.204.99])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06F7109
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 00:55:44 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by borne-mail2.ac-clermont.fr (Postfix) with ESMTP id 094B0685D1
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 08:55:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at ac-clermont.fr
Received: from borne-mail2.ac-clermont.fr ([127.0.0.1])
	by localhost (borne-mail2.ac-clermont.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bV2aMetWPLQA for <netdev@vger.kernel.org>;
	Thu, 14 Dec 2023 09:55:42 +0100 (CET)
Received: by borne-mail2.ac-clermont.fr (Postfix, from userid 1000)
	id BB7DC685D7; Thu, 14 Dec 2023 08:55:42 +0000 (UTC)
Received: from roundcube-webmail2 (roundcube-webmail2.ac-clermont.fr [172.30.83.84])
	(Authenticated sender: nvanhaute)
	by borne-mail2.ac-clermont.fr (Postfix) with ESMTPA id AFD7F685D1
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 08:55:42 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 14 Dec 2023 09:55:42 +0100
From: Vanhaute Nicolas <nicolas.vanhaute@ac-clermont.fr>
To: netdev@vger.kernel.org
Subject: ss command - false mss/mtu values
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <1d28e37a988a4da62f6df71ec6c3b67a@ac-clermont.fr>
X-Sender: nicolas.vanhaute@ac-clermont.fr
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I use socket stats in python scripts to catch some information. That 
works well but I'm facing issues about MSS/MTU values... they are not 
correct in most cases.

I managed few VPN (ipsec peer to peer but also ssl vpn...) so I can make 
tests and check if it's ok. I use also windows apps to check (mtupath 
and mturoute) or just ping with some arguments on linux.
FYI : I tried to change some values in sysctl.conf but no real changes. 
OS used are RHEL8 and Ubuntu22.
ss utility, iproute2-5.18.0
ss utility, iproute2-ss200127

I use iperf to get these values so it's not a small trafic.

See below some tests :
By example a test inside a VPN tunnel (IPSEC peer to peer) where I 
forced mss to 1360 and mtu to 1400 gives me :
ESTAB                      0                           1474240           
                                 172.30.92.192:47836                      
                      172.29.68.205:5201                       
timer:(on,028ms,0)
          sack cubic wscale:10,7 rto:212 rtt:9.447/0.052 mss:1360 
pmtu:1500 rcvmss:536 advmss:1460 cwnd:74 ssthresh:58 bytes_sent:88061397 
bytes_retrans:25840 bytes_acked:87943078 segs_out:64754 segs_in:18658 
data_segs_out:64752 send 85224939bps lastrcv:4944 pacing_rate 
102265864bps delivery_rate 80641024bps delivered:64666 busy:4936ms 
rwnd_limited:12ms(0.2%) unacked:68 retrans:0/19 rcv_space:14600 
rcv_ssthresh:64076 notsent:1381760 minrtt:9.234

as you can see mss (1360) is the good one, but pmtu still 1500

an other test inside a VPN SSL (with a forticlient) :
ESTAB                      0                           2327424           
                                 172.31.119.187:39966                     
                       172.29.68.205:5201
  timer:(on,140ms,0)
          sack cubic wscale:10,7 rto:260 rtt:57.42/0.558 mss:1352 
pmtu:1392 rcvmss:536 advmss:1352 cwnd:370 ssthresh:370 
bytes_sent:55417165 bytes_retrans:4056 bytes_acked:54918278 
segs_out:41014 segs_in:21803 data_segs_out:41012 send 69695576bps 
lastrcv:4990 pacing_rate 83633960bps delivery_rate 79511952bps 
delivered:40644 busy:4970ms rwnd_limited:1550ms(31.2%) unacked:366 
retrans:0/3 reordering:4 reord_seen:6 rcv_space:13520 rcv_ssthresh:64184 
notsent:1832592 minrtt:10.577

this time mss/mtu changed and pmtu seems true, but mss should be 1364 
from my test with icmp, maybe just because tcp has option so 12 B more ?

and other ipsec tunnel on an other place I have :
ESTAB                      0                           3903886           
                                 192.168.23.75:51706                      
                       172.25.101.2:5201                       
timer:(on,019ms,0)
          sack cubic wscale:10,7 rto:209 rtt:8.915/0.158 mss:1326 
pmtu:1500 rcvmss:536 advmss:1460 cwnd:609 ssthresh:485 
bytes_sent:472799861 bytes_retrans:185640 bytes_acked:471834534 
segs_out:356564 segs_in:10900 data_segs_out:356562 send 724651935bps 
lastsnd:1 lastrcv:5118 lastack:1 pacing_rate 869557936bps delivery_rate 
689913056bps delivered:355835 busy:5096ms rwnd_limited:9ms(0.2%) 
sndbuf_limited:4ms(0.1%) unacked:588 retrans:0/140 rcv_space:29200 
rcv_ssthresh:29200 notsent:3124198 minrtt:8.348

mss 1326... and mtu still 1500 (false)

Well as you can see, it's difficult to get right values :-(
If you have an idea.

Thanks for your help
Nicolas


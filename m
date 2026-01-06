Return-Path: <netdev+bounces-247492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54071CFB42B
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 23:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91DC03003FD4
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 22:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE402DFA46;
	Tue,  6 Jan 2026 22:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMUL96oY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84BA2236E3
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 22:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767738519; cv=none; b=Wn+zyEgzqC1/ia13xr4TfndGzzmviFZ/mMG/ie9JFOFX+Id8rAL7kYKAEKh8aoyL7LkMeJeaO+S8yAdyqpka6uOwUQf97B17LPK1j9UrZgFLZ1zqxtYme9BZKAUhGL/qFh28RnOdeU9/sho/4B38/4QZQBLJK/m4czCtLPISdCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767738519; c=relaxed/simple;
	bh=BBlZ1JnoXvo2zcRv8VOJvxHyzdWAsF4gU0wAgQRTtqA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nLuN9v6bVflgLaFtXUmtOFUWo4A4LFStHdMRBVc8XcPiMRuzl6FG7wQClCiAIxfv2fkazyPnY/Nxr4bybk79dB7KliFYZI8ZO5HvdDWlYVaSiuHjRvtZMyfIX2eW878aXJ9B1suWqrAbhdrtFwiUn9/wQnHSCmFK42vd2cVcuxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMUL96oY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB5FC116C6;
	Tue,  6 Jan 2026 22:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767738519;
	bh=BBlZ1JnoXvo2zcRv8VOJvxHyzdWAsF4gU0wAgQRTtqA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uMUL96oYAKuFPpun7wgatt/edvbicNq2/WDHyeN1MHWu9WnUau+kw476qybPbA+0C
	 uzVVwuKRLYMRaPX+E9BZyyZRJ9d+bnym/Cyg8Wq1prXQcQZSrNTBWmHZtcp940gHf6
	 4hMJZisGCuHSLbfkrTfEPQjpMWOOwdpd2NRPodTlA/WZYq/cWlAy4MCPv+OekGbobw
	 i6s+0a6l8nyhHslJX2dDDSOBBwL/ZWMCQLK16O6Q0F0X0gO+KiWQVylWciPgxCPjPR
	 ILFJaRPBLYgsRP1qVagV+TCN5ko99yTxJH1xKwWPgDwkRRryvk0zoaCOMvmM4C6VjO
	 HYMB4nbs6rn4w==
Date: Tue, 6 Jan 2026 14:28:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Florian Westphal
 <fw@strlen.de>, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com, Mazin Al Haddad
 <mazin@getstate.dev>
Subject: Re: [PATCH v2 net] ip6_gre: use skb_vlan_inet_prepare() instead of
 pskb_inet_may_pull()
Message-ID: <20260106142838.69ecc00c@kernel.org>
In-Reply-To: <CANn89iKVaigLaffUqXE+UX+Tr88apSa1Ciavi1rLr+G3sMzkLw@mail.gmail.com>
References: <20260106144529.1424886-1-edumazet@google.com>
	<20260106095648.07a870f1@kernel.org>
	<CANn89iJnXg892OU13PeJMGvBKw90fJdqDaAmJ867Rptsm0zgNA@mail.gmail.com>
	<20260106123151.03a984bb@kernel.org>
	<CANn89iL_Sa_ez340w2eyM_rfCnOH-UV9-zo1sYv65_hdQ-_W6g@mail.gmail.com>
	<CANn89iKVaigLaffUqXE+UX+Tr88apSa1Ciavi1rLr+G3sMzkLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Jan 2026 22:33:05 +0100 Eric Dumazet wrote:
> > [hi on] edumazet@edumazet1:~/git/net-next$ vng  -r --user root --cpus
> > 4 --memory 4G
> > /usr/lib/tmpfiles.d/legacy.conf:14: Duplicate line for path
> > "/run/lock", ignoring.
> >           _      _
> >    __   _(_)_ __| |_ _ __ ___   ___       _ __   __ _
> >    \ \ / / |  __| __|  _   _ \ / _ \_____|  _ \ / _  |
> >     \ V /| | |  | |_| | | | | |  __/_____| | | | (_| |
> >      \_/ |_|_|   \__|_| |_| |_|\___|     |_| |_|\__  |
> >                                                 |___/
> >    kernel version: 6.16.12-1rodete2-amd64 x86_64
> >    (CTRL+d to exit)
> >
> > Illegal instruction        shell-history-configtool configure-interactively
> > root@virtme-ng:/usr/local/google/home/edumazet/git/net-next# cd
> > tools/testing/selftests/net/
> > root@virtme-ng:/usr/local/google/home/edumazet/git/net-next/tools/testing/selftests/net#
> > ./gre_gso.sh
> >     TEST: GREv6/v4 - copy file w/ TSO                                   [ OK ]
> >     TEST: GREv6/v4 - copy file w/ GSO                                   [ OK ]
> > 2026/01/06 21:25:27 socat[1214] W exiting on signal 15
> >     TEST: GREv6/v6 - copy file w/ TSO                                   [ OK ]
> >     TEST: GREv6/v6 - copy file w/ GSO                                   [ OK ]
> > 2026/01/06 21:25:27 socat[1229] W exiting on signal 15
> >
> > Tests passed:   4
> > Tests failed:   0
> > root@virtme-ng:/usr/local/google/home/edumazet/git/net-next/tools/testing/selftests/net#  
> 
> Ah of course my script had '-r arch/x86/boot/bzImage'

Maybe your machine / TCP tunings are super fast. I think we have some
packet loss here which slows things down, maybe we run into the timeout
of 1 sec with GSO and you don't.

I did this to the (GSO side of the) test:

diff --git a/tools/testing/selftests/net/gre_gso.sh b/tools/testing/selftests/net/gre_gso.sh
index 5100d90f92d2..b9a223b584f6 100755
--- a/tools/testing/selftests/net/gre_gso.sh
+++ b/tools/testing/selftests/net/gre_gso.sh
@@ -125,9 +125,16 @@ gre_gst_test_checks()
 
        ethtool -K veth0 tso off
 
-       cat $TMPFILE | timeout 1 socat -u STDIN TCP:$addr:$port
-       log_test $? 0 "$name - copy file w/ GSO"
-
+       $NS_EXEC nstat >>/dev/null
+       nstat >>/dev/null
+       cat $TMPFILE | \time timeout 1 socat -u STDIN TCP:$addr:$port
+       R=$?
+       echo "== Sender"
+       nstat
+       echo "== Receiver"
+       $NS_EXEC nstat
+       log_test $R 0 "$name - copy file w/ GSO"
+       
        ethtool -K veth0 tso on
 
        kill $PID

Without the fix under discussion I get:

# ./gre_gso.sh 
    TEST: GREv6/v4 - copy file w/ TSO                                   [ OK ]
0.00user 0.12system 0:00.13elapsed 92%CPU (0avgtext+0avgdata 3744maxresident)k
0inputs+0outputs (0major+406minor)pagefaults 0swaps
== Sender
#kernel
IpInReceives                    255                0.0
IpInDelivers                    255                0.0
IpOutRequests                   259                0.0
IpOutTransmits                  259                0.0
TcpActiveOpens                  1                  0.0
TcpInSegs                       255                0.0
TcpOutSegs                      1539               0.0
Ip6InReceives                   255                0.0
Ip6InDelivers                   255                0.0
Ip6InOctets                     26528              0.0
Ip6OutOctets                    2124096            0.0
Ip6InNoECTPkts                  255                0.0
Ip6OutTransmits                 259                0.0
TcpExtTCPPureAcks               252                0.0
TcpExtTCPBacklogCoalesce        1                  0.0
TcpExtTCPOrigDataSent           1536               0.0
TcpExtTCPDelivered              1537               0.0
IpExtInOctets                   13268              0.0
IpExtOutOctets                  2110628            0.0
IpExtInNoECTPkts                255                0.0
== Receiver
#kernel
IpInReceives                    7                  0.0
IpInDelivers                    7                  0.0
TcpPassiveOpens                 2                  0.0
TcpInSegs                       7                  0.0
Ip6InReceives                   1287               0.0
Ip6InDelivers                   1287               0.0
Ip6InMcastPkts                  1                  0.0
Ip6InOctets                     4328152            0.0
Ip6InMcastOctets                72                 0.0
Ip6InNoECTPkts                  2564               0.0
Icmp6InNeighborSolicits         1                  0.0
Icmp6OutNeighborAdvertisements  1                  0.0
Icmp6InType135                  1                  0.0
Icmp6OutType136                 1                  0.0
TcpExtTW                        2                  0.0
TcpExtTCPRcvCoalesce            22                 0.0
IpExtInOctets                   4194668            0.0
IpExtInNoECTPkts                2564               0.0
    TEST: GREv6/v4 - copy file w/ GSO                                   [ OK ]
2026/01/06 17:23:10 socat[787] W exiting on signal 15
    TEST: GREv6/v6 - copy file w/ TSO                                   [ OK ]
0.00user 0.12system 0:00.14elapsed 85%CPU (0avgtext+0avgdata 3668maxresident)k
0inputs+0outputs (0major+405minor)pagefaults 0swaps
== Sender
#kernel
TcpActiveOpens                  1                  0.0
TcpInSegs                       261                0.0
TcpOutSegs                      1539               0.0
Ip6InReceives                   522                0.0
Ip6InDelivers                   522                0.0
Ip6OutRequests                  263                0.0
Ip6InOctets                     51172              0.0
Ip6OutOctets                    4245868            0.0
Ip6InNoECTPkts                  522                0.0
Ip6OutTransmits                 526                0.0
TcpExtTCPPureAcks               257                0.0
TcpExtTCPLossProbes             1                  0.0
TcpExtTCPBacklogCoalesce        2                  0.0
TcpExtTCPOrigDataSent           1537               0.0
TcpExtTCPDelivered              1538               0.0
== Receiver
#kernel
IpInReceives                    7                  0.0
IpInDelivers                    7                  0.0
TcpPassiveOpens                 4                  0.0
TcpInSegs                       11                 0.0
Ip6InReceives                   2571               0.0
Ip6InDelivers                   2571               0.0
Ip6InMcastPkts                  1                  0.0
Ip6InOctets                     12875768           0.0
Ip6InMcastOctets                72                 0.0
Ip6InNoECTPkts                  7670               0.0
Icmp6InNeighborSolicits         1                  0.0
Icmp6OutNeighborAdvertisements  1                  0.0
Icmp6InType135                  1                  0.0
Icmp6OutType136                 1                  0.0
TcpExtTW                        4                  0.0
TcpExtTCPRcvCoalesce            42                 0.0
IpExtInOctets                   4194668            0.0
IpExtInNoECTPkts                2564               0.0
    TEST: GREv6/v6 - copy file w/ GSO                                   [ OK ]
2026/01/06 17:23:10 socat[808] W exiting on signal 15

Tests passed:   4
Tests failed:   0



With the change I see retransmits:

# ./gre_gso.sh 
    TEST: GREv6/v4 - copy file w/ TSO                                   [ OK ]
2026/01/06 17:25:21 socat[805] W exiting on signal 15
Command exited with non-zero status 124
0.00user 0.03system 0:01.02elapsed 3%CPU (0avgtext+0avgdata 3792maxresident)k
0inputs+0outputs (2major+408minor)pagefaults 0swaps
== Sender
#kernel
IpInReceives                    103                0.0
IpInDelivers                    103                0.0
IpOutRequests                   145                0.0
IpOutTransmits                  145                0.0
TcpActiveOpens                  1                  0.0
TcpInSegs                       103                0.0
TcpOutSegs                      123                0.0
TcpRetransSegs                  52                 0.0
Ip6InReceives                   103                0.0
Ip6InDelivers                   103                0.0
Ip6InOctets                     11176              0.0
Ip6OutOctets                    254280             0.0
Ip6InNoECTPkts                  103                0.0
Ip6OutTransmits                 145                0.0
TcpExtDelayedACKs               1                  0.0
TcpExtTCPPureAcks               88                 0.0
TcpExtTCPSackRecovery           9                  0.0
TcpExtTCPLostRetransmit         10                 0.0
TcpExtTCPLossFailures           1                  0.0
TcpExtTCPFastRetrans            33                 0.0
TcpExtTCPSlowStartRetrans       15                 0.0
TcpExtTCPTimeouts               4                  0.0
TcpExtTCPLossProbes             2                  0.0
TcpExtTCPSackRecoveryFail       3                  0.0
TcpExtTCPBacklogCoalesce        12                 0.0
TcpExtTCPSackMerged             4                  0.0
TcpExtTCPSackShiftFallback      9                  0.0
TcpExtTCPOrigDataSent           120                0.0
TcpExtTCPDelivered              119                0.0
TcpExtTcpTimeoutRehash          4                  0.0
IpExtInOctets                   5820               0.0
IpExtOutOctets                  246740             0.0
IpExtInNoECTPkts                103                0.0
== Receiver
#kernel
IpInReceives                    23                 0.0
IpInDelivers                    22                 0.0
TcpPassiveOpens                 2                  0.0
TcpInSegs                       23                 0.0
Ip6InReceives                   21                 0.0
Ip6InDelivers                   21                 0.0
Ip6InMcastPkts                  1                  0.0
Ip6InOctets                     2262688            0.0
Ip6InMcastOctets                72                 0.0
Ip6InNoECTPkts                  1295               0.0
Icmp6InNeighborSolicits         1                  0.0
Icmp6OutNeighborAdvertisements  1                  0.0
Icmp6InType135                  1                  0.0
Icmp6OutType136                 1                  0.0
TcpExtTW                        1                  0.0
TcpExtTCPRcvCoalesce            72                 0.0
TcpExtTCPOFOQueue               13                 0.0
IpExtInOctets                   2261596            0.0
IpExtInNoECTPkts                1295               0.0
    TEST: GREv6/v4 - copy file w/ GSO                                   [FAIL]
2026/01/06 17:25:21 socat[789] W exiting on signal 15
    TEST: GREv6/v6 - copy file w/ TSO                                   [ OK ]
2026/01/06 17:25:22 socat[825] W exiting on signal 15
Command exited with non-zero status 124
0.00user 0.10system 0:01.05elapsed 9%CPU (0avgtext+0avgdata 3720maxresident)k
0inputs+0outputs (0major+406minor)pagefaults 0swaps
== Sender
#kernel
TcpActiveOpens                  1                  0.0
TcpInSegs                       408                0.0
TcpOutSegs                      430                0.0
TcpRetransSegs                  73                 0.0
Ip6InReceives                   818                0.0
Ip6InDelivers                   817                0.0
Ip6OutRequests                  464                0.0
Ip6InMcastPkts                  1                  0.0
Ip6OutMcastPkts                 1                  0.0
Ip6InOctets                     81620              0.0
Ip6OutOctets                    1460624            0.0
Ip6InMcastOctets                72                 0.0
Ip6OutMcastOctets               72                 0.0
Ip6InNoECTPkts                  818                0.0
Ip6OutTransmits                 928                0.0
Icmp6OutMsgs                    1                  0.0
Icmp6OutRouterSolicits          1                  0.0
Icmp6OutType133                 1                  0.0
TcpExtDelayedACKs               1                  0.0
TcpExtTCPPureAcks               238                0.0
TcpExtTCPSackRecovery           15                 0.0
TcpExtTCPDSACKUndo              1                  0.0
TcpExtTCPLostRetransmit         10                 0.0
TcpExtTCPLossFailures           1                  0.0
TcpExtTCPFastRetrans            57                 0.0
TcpExtTCPSlowStartRetrans       12                 0.0
TcpExtTCPTimeouts               4                  0.0
TcpExtTCPLossProbes             8                  0.0
TcpExtTCPSackRecoveryFail       3                  0.0
TcpExtTCPBacklogCoalesce        161                0.0
TcpExtTCPDSACKRecv              1                  0.0
TcpExtTCPSackShiftFallback      15                 0.0
TcpExtTCPOrigDataSent           427                0.0
TcpExtTCPDelivered              427                0.0
TcpExtTcpTimeoutRehash          4                  0.0
TcpExtTCPDSACKRecvSegs          1                  0.0
== Receiver
#kernel
IpInReceives                    21                 0.0
IpInDelivers                    21                 0.0
TcpPassiveOpens                 4                  0.0
TcpInSegs                       43                 0.0
Ip6InReceives                   65                 0.0
Ip6InDelivers                   65                 0.0
Ip6InMcastPkts                  1                  0.0
Ip6InOctets                     7658680            0.0
Ip6InMcastOctets                72                 0.0
Ip6InNoECTPkts                  3889               0.0
Icmp6InNeighborSolicits         1                  0.0
Icmp6OutNeighborAdvertisements  1                  0.0
Icmp6InType135                  1                  0.0
Icmp6OutType136                 1                  0.0
TcpExtTW                        3                  0.0
TcpExtDelayedACKLost            1                  0.0
TcpExtTCPDSACKOldSent           1                  0.0
TcpExtTCPRcvCoalesce            197                0.0
TcpExtTCPOFOQueue               30                 0.0
IpExtInOctets                   2294396            0.0
IpExtInNoECTPkts                1295               0.0
    TEST: GREv6/v6 - copy file w/ GSO                                   [FAIL]
2026/01/06 17:25:22 socat[812] W exiting on signal 15

Tests passed:   2
Tests failed:   2


If I increase the timeout to 3 or 4 sec it's enough time to finish the
file transfer regardless of the loss.


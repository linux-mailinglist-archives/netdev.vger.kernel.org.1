Return-Path: <netdev+bounces-41054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A09EC7C9744
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 01:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1155B20BE7
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 23:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DA81BDE3;
	Sat, 14 Oct 2023 23:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="YvOaP4JJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213F01845
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 23:26:26 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87F2A9
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 16:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
 t=1697325972; x=1697930772; i=wahrenst@gmx.net;
 bh=Kf+dXHqaDX/YlfHhdVdZ6CRomIrIo6XkifbeOhJ8H38=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=YvOaP4JJ6/0tCI+H7Cl0O6aZ+Bd8gfaKF10iCx9XywlGwcpJeX+UmRfCoRcRgjtiLDbexAlheMh
 VQzDZadFdctw6KsWDULzEOCybJA4xntK9wDOrLmw6mSCndyQZ3A8E5W3Ll/ir1HoFZvw4dd/aWCbY
 ZLOnPwzm3Q+NBAHs7XoYntaIR5kh6NvURCv2m+0Xk14Ssfbx5jGFd6SGpRcQtkXPPcSeIeflLsJ75
 D71knyX5zdow5Hz8J1gLZxiz0ZUnhqgckImSeVOCeYmXwQmK+8BeLha5DdIlm7z/QeTpOmrFx1UQS
 W6Z1LIMCOyldjD8/+MAFhTGl32nQ/x8EBFxA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNswE-1rBhPw0VzM-00OKTc; Sun, 15
 Oct 2023 01:26:12 +0200
Message-ID: <1ac3ea60-81d8-4501-b983-cb22b046f2ea@gmx.net>
Date: Sun, 15 Oct 2023 01:26:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iperf performance regression since Linux 5.18
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 linux-imx@nxp.com, Stefan Wahren <stefan.wahren@chargebyte.com>,
 Michael Heimpold <mhei@heimpold.de>, netdev@vger.kernel.org,
 Yuchung Cheng <ycheng@google.com>
References: <7f31ddc8-9971-495e-a1f6-819df542e0af@gmx.net>
 <CANn89iKY58YSknzOzkEHxFu=C=1_p=pXGAHGo9ZkAfAGon9ayw@mail.gmail.com>
 <CADVnQymV=nv53YaC8kLC1qT1ufhJL9+w_wcZ+8AHwPRG+JRdnw@mail.gmail.com>
 <a35b1a27-575f-4d19-ad2d-95bf4ded40e9@gmx.net>
 <CADVnQymM2HrGrMGyJX2QQ9PpgQT8JqsRz_0U8_WvdvzteqsfEQ@mail.gmail.com>
 <CANn89iL97hLAyHx9ee1VKTnLEgJeEVPrf_8-wf0BEBKAPQitPA@mail.gmail.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <CANn89iL97hLAyHx9ee1VKTnLEgJeEVPrf_8-wf0BEBKAPQitPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8v/DmKMgaEe7RGBUH7ZcIMtbgw+pTTnHinKUhcZL/vZx4a8A16Z
 Cc/qL4ejuejJyyoqK8TeWByJ7bJF6QDTvRadW6m52KYcyilAum5X05Y7RxuSoYBak1/ksRk
 8cNGdAvKQd5rTw9d0cp3qR2bcxNg/HEbTX0+uzzJlNTVrDWdngMqYcQjOO+fqco/uMDWytJ
 D50w9fg4BKZWOsa3ri+Qg==
UI-OutboundReport: notjunk:1;M01:P0:X7ZldE3rzgg=;Lbu8E+lgOmaNgNoT9YN4PIb9iiq
 UoDY/FZHCGRqS546ZQCSXOzNj/IfGWdMqa432xl8PKBV+XVj3GU/o/YiUDsuiu10uFRzIjDv2
 Se2mAGOqmQ4N4ko1UxrysUu3vOzPH+LFSpfprebUG5eJGqfooOMq2cvscdgK2FR/NSCuhVanA
 iLMzllWPH+tI5E5EHLyxEkkNptLGLCprDJfxhwtEsEESjMt0SMD5proQkH5Uz9pKXrZvsOcLl
 TvECXRmU+tivTAMiWTrZ+bVYUnUeCM/yBbkbW30u/ROjxv/WDTm8gcO1n7FyNN4lZXWcOcz7Q
 YbngxCszLY8e4OKSJWFD4PowehDI6OrY3RbuM3dNTOv6BmVeF6XNA2uaB36LREVTfSP2t6nEL
 Um7ZvYL/a3JDGHL7TSyBML+tXzz/9Rrl6vVbRoDIy34cT3tyLK2knF+Iv8GC1G50ZiSbi8e/m
 oOrl/rQctjkaXHg3P9qfWQKxaYuqo89Cmj93MlM5OOROEZzwCfGHLSysp3kbxLbo6SseSrtUf
 q2NiZXAu2l36ek0gCK+5r92jJVYoKvzaO9RsKRyoq1afyYh2DhlqVQk5suuXsY78/MxxM/f3B
 FVVHSiVmIConcnNLyzxwiS9Mjdjjt9gorzwe79bpXgrVQrg/7RsJB2CuwU+6j/R0MS3atGyVH
 1vhCZsdRDCRV22FSKveSCcMnR99CA+ytvpDGeF/8WYW1YuweRXm5t5t7RMNExcoYUWdyL3dNA
 8nqXflju/+k84xo0NqutpfP7h0cS+QbL0GYlx5oQgK+1xN/xtLfKNFTY4d9e6zeg7GeO2xo7Q
 nJNFRdUjPi2r8caWsoKESeWXkWomAQNpB1utY0LoaQz3uihgZukRuE2rjHxJHwy0qsAS5WJK4
 bVbvEPa/1fysvI7/WAFzKqzxu+kL4KuD4Ub4eObG2vj54YjWKxpvKsYpUXtKJmkYfQz9EY66/
 xbIqOUERJZBFjJjZ2dcxZ/AD8iY=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Eric,

Am 15.10.23 um 00:51 schrieb Eric Dumazet:
> On Sat, Oct 14, 2023 at 9:40=E2=80=AFPM Neal Cardwell <ncardwell@google.=
com> wrote:
>> On Fri, Oct 13, 2023 at 9:37=E2=80=AFAM Stefan Wahren <wahrenst@gmx.net=
> wrote:
>>> Hi,
>>>
>>> Am 09.10.23 um 21:19 schrieb Neal Cardwell:
>>>> On Mon, Oct 9, 2023 at 3:11=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
>>>>> On Mon, Oct 9, 2023 at 8:58=E2=80=AFPM Stefan Wahren <wahrenst@gmx.n=
et> wrote:
>>>>>> Hi,
>>>>>> we recently switched on our ARM NXP i.MX6ULL based embedded device
>>>>>> (Tarragon Master [1]) from an older kernel version to Linux 6.1. Af=
ter
>>>>>> that we noticed a measurable performance regression on the Ethernet
>>>>>> interface (driver: fec, 100 Mbit link) while running iperf client o=
n the
>>>>>> device:
>>>>>>
>>>>>> BAD
>>>>>>
>>>>>> # iperf -t 10 -i 1 -c 192.168.1.129
>>>>>> ------------------------------------------------------------
>>>>>> Client connecting to 192.168.1.129, TCP port 5001
>>>>>> TCP window size: 96.2 KByte (default)
>>>>>> ------------------------------------------------------------
>>>>>> [  3] local 192.168.1.12 port 56022 connected with 192.168.1.129 po=
rt 5001
>>>>>> [ ID] Interval       Transfer     Bandwidth
>>>>>> [  3]  0.0- 1.0 sec  9.88 MBytes  82.8 Mbits/sec
>>>>>> [  3]  1.0- 2.0 sec  9.62 MBytes  80.7 Mbits/sec
>>>>>> [  3]  2.0- 3.0 sec  9.75 MBytes  81.8 Mbits/sec
>>>>>> [  3]  3.0- 4.0 sec  9.62 MBytes  80.7 Mbits/sec
>>>>>> [  3]  4.0- 5.0 sec  9.62 MBytes  80.7 Mbits/sec
>>>>>> [  3]  5.0- 6.0 sec  9.62 MBytes  80.7 Mbits/sec
>>>>>> [  3]  6.0- 7.0 sec  9.50 MBytes  79.7 Mbits/sec
>>>>>> [  3]  7.0- 8.0 sec  9.75 MBytes  81.8 Mbits/sec
>>>>>> [  3]  8.0- 9.0 sec  9.62 MBytes  80.7 Mbits/sec
>>>>>> [  3]  9.0-10.0 sec  9.50 MBytes  79.7 Mbits/sec
>>>>>> [  3]  0.0-10.0 sec  96.5 MBytes  80.9 Mbits/sec
>>>>>>
>>>>>> GOOD
>>>>>>
>>>>>> # iperf -t 10 -i 1 -c 192.168.1.129
>>>>>> ------------------------------------------------------------
>>>>>> Client connecting to 192.168.1.129, TCP port 5001
>>>>>> TCP window size: 96.2 KByte (default)
>>>>>> ------------------------------------------------------------
>>>>>> [  3] local 192.168.1.12 port 54898 connected with 192.168.1.129 po=
rt 5001
>>>>>> [ ID] Interval       Transfer     Bandwidth
>>>>>> [  3]  0.0- 1.0 sec  11.2 MBytes  94.4 Mbits/sec
>>>>>> [  3]  1.0- 2.0 sec  11.0 MBytes  92.3 Mbits/sec
>>>>>> [  3]  2.0- 3.0 sec  10.8 MBytes  90.2 Mbits/sec
>>>>>> [  3]  3.0- 4.0 sec  11.0 MBytes  92.3 Mbits/sec
>>>>>> [  3]  4.0- 5.0 sec  10.9 MBytes  91.2 Mbits/sec
>>>>>> [  3]  5.0- 6.0 sec  10.9 MBytes  91.2 Mbits/sec
>>>>>> [  3]  6.0- 7.0 sec  10.8 MBytes  90.2 Mbits/sec
>>>>>> [  3]  7.0- 8.0 sec  10.9 MBytes  91.2 Mbits/sec
>>>>>> [  3]  8.0- 9.0 sec  10.9 MBytes  91.2 Mbits/sec
>>>>>> [  3]  9.0-10.0 sec  10.9 MBytes  91.2 Mbits/sec
>>>>>> [  3]  0.0-10.0 sec   109 MBytes  91.4 Mbits/sec
>>>>>>
>>>>>> We were able to bisect this down to this commit:
>>>>>>
>>>>>> first bad commit: [65466904b015f6eeb9225b51aeb29b01a1d4b59c] tcp: a=
djust
>>>>>> TSO packet sizes based on min_rtt
>>>>>>
>>>>>> Disabling this new setting via:
>>>>>>
>>>>>> echo 0 > /proc/sys/net/ipv4/tcp_tso_rtt_log
>>>>>>
>>>>>> confirm that this was the cause of the performance regression.
>>>>>>
>>>>>> Is it expected that the new default setting has such a performance =
impact?
>>>> Indeed, thanks for the report.
>>>>
>>>> In addition to the "ss" output Eric mentioned, could you please grab
>>>> "nstat" output, which should allow us to calculate the average TSO/GS=
O
>>>> and LRO/GRO burst sizes, which is the key thing tuned with the
>>>> tcp_tso_rtt_log knob.
>>>>
>>>> So it would be great to have the following from both data sender and
>>>> data receiver, for both the good case and bad case, if you could star=
t
>>>> these before your test and kill them after the test stops:
>>>>
>>>> (while true; do date; ss -tenmoi; sleep 1; done) > /root/ss.txt &
>>>> nstat -n; (while true; do date; nstat; sleep 1; done)  > /root/nstat.=
txt
>>> i upload everything here:
>>> https://github.com/lategoodbye/tcp_tso_rtt_log_regress
>>>
>>> The server part is a Ubuntu installation connected to the internet. At
>>> first i logged the good case, then i continued with the bad case.
>>> Accidentally i delete a log file of bad case, so i repeated the whole
>>> bad case again. So the uploaded bad case files are from the third run.
>> Thanks for the detailed data!
>>
>> Here are some notes from looking at this data:
>>
>> + bad client: avg TSO burst size is roughly:
>> https://github.com/lategoodbye/tcp_tso_rtt_log_regress/blob/main/nstat_=
client_bad.log
>> IpOutRequests                   308               44.7
>> IpExtOutOctets                  10050656        1403181.0
>> est bytes   per TSO burst: 10050656 / 308 =3D 32632
>> est packets per TSO burst: 32632 / 1448 ~=3D 22.5
>>
>> + good client: avg TSO burst size is roughly:
>> https://github.com/lategoodbye/tcp_tso_rtt_log_regress/blob/main/nstat_=
client_good.log
>> IpOutRequests                   529               62.0
>> IpExtOutOctets                  11502992        1288711.5
>> est bytes   per TSO burst: 11502992 / 529 ~=3D 21745
>> est packets per TSO burst: 21745 / 1448 ~=3D 15.0
>>
>> + bad client ss data:
>> https://github.com/lategoodbye/tcp_tso_rtt_log_regress/blob/main/ss_cli=
ent_bad.log
>> State Recv-Q Send-Q Local Address:Port   Peer Address:PortProcess
>> ESTAB 0      236024  192.168.1.12:39228 192.168.1.129:5001
>> timer:(on,030ms,0) ino:25876 sk:414f52af rto:0.21 cwnd:68 ssthresh:20
>> reordering:0
>> Mbits/sec allowed by cwnd: 68 * 1448 * 8 / .0018 / 1000000.0 ~=3D 437.6
>>
>> + good client ss data:
>> https://github.com/lategoodbye/tcp_tso_rtt_log_regress/blob/main/ss_cli=
ent_good.log
>> Fri Oct 13 15:04:36 CEST 2023
>> State Recv-Q Send-Q Local Address:Port   Peer Address:PortProcess
>> ESTAB 0      425712  192.168.1.12:33284 192.168.1.129:5001
>> timer:(on,020ms,0) ino:20654 sk:414f52af rto:0.21 cwnd:106 ssthresh:20
>> reordering:0
>> Mbits/sec allowed by cwnd: 106 * 1448 * 8 / .0028 / 1000000.0 =3D 438.5
>>
>> So it seems indeed like cwnd is not the limiting factor, and instead
>> there is something about the larger TSO/GSO bursts (roughly 22.5
>> packets per burst on average) in the "bad" case that is causing
>> problems, and preventing the sender from keeping the pipe fully
>> utilized.
>>
>> So perhaps the details of the tcp_tso_should_defer() logic are hurting
>> performance?
>>
>> The default value of tcp_tso_win_divisor is 3, and in the bad case the
>> cwnd / tcp_tso_win_divisor =3D 68 / 3 =3D 22.7 packets, which is
>> suspiciously close to the average TSO burst size of 22.5. So my guess
>> is that the tcp_tso_win_divisor of 3 is the dominant factor here, and
>> perhaps if we raise it to 5, then 68/5 ~=3D 13.60 will approximate the
>> TSO burst size in the "good" case, and fully utilize the pipe. So it
>> seems worth an experiment, to see what we can learn.
>>
>> To test that theory, could you please try running the following as
>> root on the data sender machine, and then re-running the "bad" test
>> with tcp_tso_rtt_log at the default value of 9?
>>
>>     sysctl net.ipv4.tcp_tso_win_divisor=3D5
>>
>> Thanks!
>> neal
> Hmm, we receive ~3200 acks per second, I am not sure the
> tcp_tso_should_defer() logic
> would hurt ?
>
> Also the ss binary on the client seems very old, or its output has
> been mangled perhaps ?
this binary is from Yocto kirkstone:

# ss --version
ss utility, iproute2-5.17.0

This shouldn't be too old. Maybe some missing kernel settings?

Maybe relevant extract from the config:

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
CONFIG_PROC_SYSCTL=3Dy
CONFIG_PROC_PAGE_MONITOR=3Dy
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=3Dy
CONFIG_SYSFS=3Dy
CONFIG_TMPFS=3Dy
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
CONFIG_MEMFD_CREATE=3Dy
CONFIG_CONFIGFS_FS=3Dy
# end of Pseudo filesystems

CONFIG_NET=3Dy
CONFIG_NET_EGRESS=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dy
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=3Dy
CONFIG_UNIX_SCM=3Dy
CONFIG_AF_UNIX_OOB=3Dy
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=3Dy
CONFIG_IP_PNP_DHCP=3Dy
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TABLE_PERTURB_ORDER=3D16
# CONFIG_INET_DIAG is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=3Dy
CONFIG_DEFAULT_TCP_CONG=3D"cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=3Dy
# CONFIG_IPV6_ROUTER_PREF is not set
CONFIG_IPV6_OPTIMISTIC_DAD=3Dy
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_ILA is not set
# CONFIG_IPV6_VTI is not set
# CONFIG_IPV6_SIT is not set
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=3Dy
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=3Dy
CONFIG_NETFILTER_ADVANCED=3Dy
# CONFIG_BRIDGE_NETFILTER is not set

#
# Core Netfilter Configuration
#
# CONFIG_NETFILTER_INGRESS is not set
CONFIG_NETFILTER_EGRESS=3Dy
# CONFIG_NETFILTER_NETLINK_ACCT is not set
# CONFIG_NETFILTER_NETLINK_QUEUE is not set
# CONFIG_NETFILTER_NETLINK_LOG is not set
# CONFIG_NETFILTER_NETLINK_OSF is not set
CONFIG_NF_CONNTRACK=3Dy
# CONFIG_NF_LOG_SYSLOG is not set
# CONFIG_NF_CONNTRACK_MARK is not set
# CONFIG_NF_CONNTRACK_ZONES is not set
# CONFIG_NF_CONNTRACK_PROCFS is not set
# CONFIG_NF_CONNTRACK_EVENTS is not set
# CONFIG_NF_CONNTRACK_TIMEOUT is not set
# CONFIG_NF_CONNTRACK_TIMESTAMP is not set
# CONFIG_NF_CONNTRACK_LABELS is not set
CONFIG_NF_CT_PROTO_DCCP=3Dy
CONFIG_NF_CT_PROTO_SCTP=3Dy
CONFIG_NF_CT_PROTO_UDPLITE=3Dy
# CONFIG_NF_CONNTRACK_AMANDA is not set
CONFIG_NF_CONNTRACK_FTP=3Dy
# CONFIG_NF_CONNTRACK_H323 is not set
# CONFIG_NF_CONNTRACK_IRC is not set
# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
# CONFIG_NF_CONNTRACK_SNMP is not set
# CONFIG_NF_CONNTRACK_PPTP is not set
# CONFIG_NF_CONNTRACK_SANE is not set
# CONFIG_NF_CONNTRACK_SIP is not set
# CONFIG_NF_CONNTRACK_TFTP is not set
# CONFIG_NF_CT_NETLINK is not set
CONFIG_NF_NAT=3Dy
CONFIG_NF_NAT_FTP=3Dy
CONFIG_NF_NAT_MASQUERADE=3Dy
# CONFIG_NF_TABLES is not set
CONFIG_NETFILTER_XTABLES=3Dy

#
# Xtables combined modules
#
# CONFIG_NETFILTER_XT_MARK is not set
# CONFIG_NETFILTER_XT_CONNMARK is not set

#
# Xtables targets
#
# CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
# CONFIG_NETFILTER_XT_TARGET_CONNMARK is not set
# CONFIG_NETFILTER_XT_TARGET_HMARK is not set
# CONFIG_NETFILTER_XT_TARGET_IDLETIMER is not set
# CONFIG_NETFILTER_XT_TARGET_LED is not set
# CONFIG_NETFILTER_XT_TARGET_LOG is not set
# CONFIG_NETFILTER_XT_TARGET_MARK is not set
CONFIG_NETFILTER_XT_NAT=3Dy
# CONFIG_NETFILTER_XT_TARGET_NETMAP is not set
# CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
# CONFIG_NETFILTER_XT_TARGET_NFQUEUE is not set
# CONFIG_NETFILTER_XT_TARGET_RATEEST is not set
# CONFIG_NETFILTER_XT_TARGET_REDIRECT is not set
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=3Dy
# CONFIG_NETFILTER_XT_TARGET_TEE is not set
CONFIG_NETFILTER_XT_TARGET_TCPMSS=3Dy

#
# Xtables matches
#
# CONFIG_NETFILTER_XT_MATCH_ADDRTYPE is not set
# CONFIG_NETFILTER_XT_MATCH_BPF is not set
# CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
# CONFIG_NETFILTER_XT_MATCH_CLUSTER is not set
# CONFIG_NETFILTER_XT_MATCH_COMMENT is not set
# CONFIG_NETFILTER_XT_MATCH_CONNBYTES is not set
# CONFIG_NETFILTER_XT_MATCH_CONNLABEL is not set
# CONFIG_NETFILTER_XT_MATCH_CONNLIMIT is not set
# CONFIG_NETFILTER_XT_MATCH_CONNMARK is not set
# CONFIG_NETFILTER_XT_MATCH_CONNTRACK is not set
# CONFIG_NETFILTER_XT_MATCH_CPU is not set
# CONFIG_NETFILTER_XT_MATCH_DCCP is not set
# CONFIG_NETFILTER_XT_MATCH_DEVGROUP is not set
# CONFIG_NETFILTER_XT_MATCH_DSCP is not set
# CONFIG_NETFILTER_XT_MATCH_ECN is not set
# CONFIG_NETFILTER_XT_MATCH_ESP is not set
# CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
# CONFIG_NETFILTER_XT_MATCH_HELPER is not set
# CONFIG_NETFILTER_XT_MATCH_HL is not set
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
# CONFIG_NETFILTER_XT_MATCH_IPRANGE is not set
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
# CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
# CONFIG_NETFILTER_XT_MATCH_LIMIT is not set
# CONFIG_NETFILTER_XT_MATCH_MAC is not set
# CONFIG_NETFILTER_XT_MATCH_MARK is not set
# CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
# CONFIG_NETFILTER_XT_MATCH_OSF is not set
# CONFIG_NETFILTER_XT_MATCH_OWNER is not set
# CONFIG_NETFILTER_XT_MATCH_PKTTYPE is not set
# CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
# CONFIG_NETFILTER_XT_MATCH_RATEEST is not set
# CONFIG_NETFILTER_XT_MATCH_REALM is not set
# CONFIG_NETFILTER_XT_MATCH_RECENT is not set
# CONFIG_NETFILTER_XT_MATCH_SCTP is not set
# CONFIG_NETFILTER_XT_MATCH_SOCKET is not set
# CONFIG_NETFILTER_XT_MATCH_STATE is not set
# CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
# CONFIG_NETFILTER_XT_MATCH_STRING is not set
# CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

# CONFIG_IP_SET is not set
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=3Dy
# CONFIG_NF_SOCKET_IPV4 is not set
# CONFIG_NF_TPROXY_IPV4 is not set
# CONFIG_NF_DUP_IPV4 is not set
# CONFIG_NF_LOG_ARP is not set
# CONFIG_NF_LOG_IPV4 is not set
# CONFIG_NF_REJECT_IPV4 is not set
CONFIG_IP_NF_IPTABLES=3Dy
# CONFIG_IP_NF_MATCH_AH is not set
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_TTL is not set
# CONFIG_IP_NF_FILTER is not set
# CONFIG_IP_NF_TARGET_SYNPROXY is not set
CONFIG_IP_NF_NAT=3Dy
CONFIG_IP_NF_TARGET_MASQUERADE=3Dy
# CONFIG_IP_NF_TARGET_NETMAP is not set
# CONFIG_IP_NF_TARGET_REDIRECT is not set
# CONFIG_IP_NF_MANGLE is not set
# CONFIG_IP_NF_RAW is not set
# CONFIG_IP_NF_ARPTABLES is not set
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
# CONFIG_NF_SOCKET_IPV6 is not set
# CONFIG_NF_TPROXY_IPV6 is not set
# CONFIG_NF_DUP_IPV6 is not set
# CONFIG_NF_REJECT_IPV6 is not set
# CONFIG_NF_LOG_IPV6 is not set
# CONFIG_IP6_NF_IPTABLES is not set
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=3Dy
# CONFIG_NF_CONNTRACK_BRIDGE is not set
# CONFIG_BRIDGE_NF_EBTABLES is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=3Dy
CONFIG_BRIDGE=3Dy
CONFIG_BRIDGE_IGMP_SNOOPING=3Dy
CONFIG_BRIDGE_VLAN_FILTERING=3Dy
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=3Dy
# CONFIG_VLAN_8021Q_GVRP is not set
# CONFIG_VLAN_8021Q_MVRP is not set
CONFIG_LLC=3Dy
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=3Dy
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=3Dy
CONFIG_BQL=3Dy

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=3Dy
CONFIG_CAN_RAW=3Dy
CONFIG_CAN_BCM=3Dy
# CONFIG_CAN_GW is not set
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_MCTP is not set
CONFIG_WIRELESS=3Dy
CONFIG_CFG80211=3Dy
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=3Dy
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=3Dy
CONFIG_CFG80211_DEFAULT_PS=3Dy
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=3Dy
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=3Dy
CONFIG_MAC80211_HAS_RC=3Dy
CONFIG_MAC80211_RC_MINSTREL=3Dy
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=3Dy
CONFIG_MAC80211_RC_DEFAULT=3D"minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=3Dy
# CONFIG_MAC80211_DEBUGFS is not set
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=3D0
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_NET_SELFTESTS=3Dy
CONFIG_PAGE_POOL=3Dy
# CONFIG_PAGE_POOL_STATS is not set
# CONFIG_FAILOVER is not set
CONFIG_ETHTOOL_NETLINK=3Dy


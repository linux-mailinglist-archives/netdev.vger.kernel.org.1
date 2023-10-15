Return-Path: <netdev+bounces-41055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9477C9755
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 02:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4E401C20949
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 00:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346A0195;
	Sun, 15 Oct 2023 00:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="IvDK23e8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E638161
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 00:06:30 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F69CD6
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 17:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
 t=1697328379; x=1697933179; i=wahrenst@gmx.net;
 bh=KlV33a8F2B4w2Kf6SAsP1DSJ4DJyoLivvIY2+XasDio=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=IvDK23e8AiV3z90wfA2FaMur7H0DnslMOt3o5RA+hEepqlhltOYyB5EJ30OdLS7qvGCvQVkQqmb
 kRBY/Pk/07iCe+OOPS7cZYP7a8JN357ldFq1zuB8kW4yxZItnr+26ZNnU9zIn1MbxQOYn+HIeaXH5
 7ZYdpegKjy81c+XWWFMMmEZ8tabPC70xQFGxZbl9ExpyaoENU2WwaUSeX0RFwBbufTbxmrJfA8NN3
 67DtHJ7TRx5INBUsWmNKBStU6qjxrtHiaM66+P0M3IwutlYiuGodsVb52ezt87ABEQPjRf1e8VuW3
 wxt4/BblTkRe1f4To8VwS4drOIW2GyW+7GIQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqb1W-1rMjXO3n4C-00mb1H; Sun, 15
 Oct 2023 02:06:18 +0200
Message-ID: <c7f4b618-696c-48bc-b95c-ddecf9024f84@gmx.net>
Date: Sun, 15 Oct 2023 02:06:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iperf performance regression since Linux 5.18
Content-Language: en-US
To: Neal Cardwell <ncardwell@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
 Stefan Wahren <stefan.wahren@chargebyte.com>,
 Michael Heimpold <mhei@heimpold.de>, netdev@vger.kernel.org,
 Yuchung Cheng <ycheng@google.com>
References: <7f31ddc8-9971-495e-a1f6-819df542e0af@gmx.net>
 <CANn89iKY58YSknzOzkEHxFu=C=1_p=pXGAHGo9ZkAfAGon9ayw@mail.gmail.com>
 <CADVnQymV=nv53YaC8kLC1qT1ufhJL9+w_wcZ+8AHwPRG+JRdnw@mail.gmail.com>
 <a35b1a27-575f-4d19-ad2d-95bf4ded40e9@gmx.net>
 <CADVnQymM2HrGrMGyJX2QQ9PpgQT8JqsRz_0U8_WvdvzteqsfEQ@mail.gmail.com>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <CADVnQymM2HrGrMGyJX2QQ9PpgQT8JqsRz_0U8_WvdvzteqsfEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N9s5wOizQWZpkW1y6EZB0OIHmQS7kQp1lhH7hMg5BAs68PDOArV
 Z0CBqo1mj/Dje00POk3K+EVZc6n9p36GzeNMz0vQ9oWdUsQZ14/mLWgzOFM4yHCSyYZdisB
 qI22kt3BX9O0nRYFwtcdf8OcDpMalIqQwpMl1RHglHD//M/Wd5mDLWbEZkgnwnpXEdwMNhq
 RTgluWJhM9+5zCgIkb8SA==
UI-OutboundReport: notjunk:1;M01:P0:G+Br7+opBPM=;TtLKady4pZrjldT6XstrsF2iBof
 yPGzhjR7gxX4g1Jc0y/d8U6ANRvYFdtTdmH+AEvs6PLvu0Y+DNErfpCu5wWp+laDZnu/dNT8F
 TJluUdoZi1YY9Jdf2wjv8tsGvvqIIk+orYl/FdHWGB/Af0v3yK1Ydy2ha+IlBlCrWKSrE7Dqm
 w45T2Ipcw6CJJ9t2lrYrMUSjiPoGAys1x/14xNbKQQMKmOcgcII+A3ABF/iDBzkNkUb2XX8nk
 OKyWRl/sdC5sIWvwZ96loyyHWIt/EA/k0Ry5wQt2xrh4wT9jxb73H/Ay6fPPWqymwbtWdY8ZI
 0aIG+LW3gJXR6j14hGoU0IaIV48BgVseOTdl/cjFGdCkedQYhUpNppI++fLtHw6aRAYbEYK0i
 A0iYlupp6nFm4xo+DwTNv8b56TW7wfrJ1zDYnIdpaF4Bm1FYFupM9TXydYNDA0w53tD9P9LJZ
 sl8QvRpCGpYwB5NxNmXw6P8Ku4MY/IUO9TqyFo83ABl9COSkdk9VS3JMhdw+BDXzgyIUu3u32
 ODlRJYZQDCSKbMwvhpx41HD7/T/di41+tut1L2+vHMiYL3A1prOy/jqH40XazmQADdoDQXf9r
 lVA5//3q3LStWcOP5Vi+CWwDSZBMNHWGElgAARoA0Tifzo7kHrtVceNCvn2nk9635lL/jEq5H
 BnbIb2xaofqAAjSbfiq6I7rQUMlwD2K5FtZxFYLcAdkmYjzMR99X5OFcaGCNC7hQLTsoiijaT
 Ovp9d3idb3Cy8qefVscv7M5Grs8xkL4nK32S90cdVykE6dAizWKWB0uwceza62LVcJOHy9fTx
 sq9oM6KtxZh9GPVQuBEKPlmoKDxC+1orhYPxhkUg8WslDKd4VcfTdCEWSYFtmKWZJnGGWX/j0
 4il0xohRpU+6npFYcdHEkfEWBo3cTT4Bgt+W1LzJBRBoeHi2fATsyFG68+YCXgCWKhhEZYcW5
 gDiSgQqxhz2r+Euo0ODX5Kim1jg=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Am 14.10.23 um 21:40 schrieb Neal Cardwell:
> On Fri, Oct 13, 2023 at 9:37=E2=80=AFAM Stefan Wahren <wahrenst@gmx.net>=
 wrote:
>> Hi,
>>
>> Am 09.10.23 um 21:19 schrieb Neal Cardwell:
>>> On Mon, Oct 9, 2023 at 3:11=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
>>>> On Mon, Oct 9, 2023 at 8:58=E2=80=AFPM Stefan Wahren <wahrenst@gmx.ne=
t> wrote:
>>>>> Hi,
>>>>> we recently switched on our ARM NXP i.MX6ULL based embedded device
>>>>> (Tarragon Master [1]) from an older kernel version to Linux 6.1. Aft=
er
>>>>> that we noticed a measurable performance regression on the Ethernet
>>>>> interface (driver: fec, 100 Mbit link) while running iperf client on=
 the
>>>>> device:
>>>>>
>>>>> BAD
>>>>>
>>>>> # iperf -t 10 -i 1 -c 192.168.1.129
>>>>> ------------------------------------------------------------
>>>>> Client connecting to 192.168.1.129, TCP port 5001
>>>>> TCP window size: 96.2 KByte (default)
>>>>> ------------------------------------------------------------
>>>>> [  3] local 192.168.1.12 port 56022 connected with 192.168.1.129 por=
t 5001
>>>>> [ ID] Interval       Transfer     Bandwidth
>>>>> [  3]  0.0- 1.0 sec  9.88 MBytes  82.8 Mbits/sec
>>>>> [  3]  1.0- 2.0 sec  9.62 MBytes  80.7 Mbits/sec
>>>>> [  3]  2.0- 3.0 sec  9.75 MBytes  81.8 Mbits/sec
>>>>> [  3]  3.0- 4.0 sec  9.62 MBytes  80.7 Mbits/sec
>>>>> [  3]  4.0- 5.0 sec  9.62 MBytes  80.7 Mbits/sec
>>>>> [  3]  5.0- 6.0 sec  9.62 MBytes  80.7 Mbits/sec
>>>>> [  3]  6.0- 7.0 sec  9.50 MBytes  79.7 Mbits/sec
>>>>> [  3]  7.0- 8.0 sec  9.75 MBytes  81.8 Mbits/sec
>>>>> [  3]  8.0- 9.0 sec  9.62 MBytes  80.7 Mbits/sec
>>>>> [  3]  9.0-10.0 sec  9.50 MBytes  79.7 Mbits/sec
>>>>> [  3]  0.0-10.0 sec  96.5 MBytes  80.9 Mbits/sec
>>>>>
>>>>> GOOD
>>>>>
>>>>> # iperf -t 10 -i 1 -c 192.168.1.129
>>>>> ------------------------------------------------------------
>>>>> Client connecting to 192.168.1.129, TCP port 5001
>>>>> TCP window size: 96.2 KByte (default)
>>>>> ------------------------------------------------------------
>>>>> [  3] local 192.168.1.12 port 54898 connected with 192.168.1.129 por=
t 5001
>>>>> [ ID] Interval       Transfer     Bandwidth
>>>>> [  3]  0.0- 1.0 sec  11.2 MBytes  94.4 Mbits/sec
>>>>> [  3]  1.0- 2.0 sec  11.0 MBytes  92.3 Mbits/sec
>>>>> [  3]  2.0- 3.0 sec  10.8 MBytes  90.2 Mbits/sec
>>>>> [  3]  3.0- 4.0 sec  11.0 MBytes  92.3 Mbits/sec
>>>>> [  3]  4.0- 5.0 sec  10.9 MBytes  91.2 Mbits/sec
>>>>> [  3]  5.0- 6.0 sec  10.9 MBytes  91.2 Mbits/sec
>>>>> [  3]  6.0- 7.0 sec  10.8 MBytes  90.2 Mbits/sec
>>>>> [  3]  7.0- 8.0 sec  10.9 MBytes  91.2 Mbits/sec
>>>>> [  3]  8.0- 9.0 sec  10.9 MBytes  91.2 Mbits/sec
>>>>> [  3]  9.0-10.0 sec  10.9 MBytes  91.2 Mbits/sec
>>>>> [  3]  0.0-10.0 sec   109 MBytes  91.4 Mbits/sec
>>>>>
>>>>> We were able to bisect this down to this commit:
>>>>>
>>>>> first bad commit: [65466904b015f6eeb9225b51aeb29b01a1d4b59c] tcp: ad=
just
>>>>> TSO packet sizes based on min_rtt
>>>>>
>>>>> Disabling this new setting via:
>>>>>
>>>>> echo 0 > /proc/sys/net/ipv4/tcp_tso_rtt_log
>>>>>
>>>>> confirm that this was the cause of the performance regression.
>>>>>
>>>>> Is it expected that the new default setting has such a performance i=
mpact?
>>> Indeed, thanks for the report.
>>>
>>> In addition to the "ss" output Eric mentioned, could you please grab
>>> "nstat" output, which should allow us to calculate the average TSO/GSO
>>> and LRO/GRO burst sizes, which is the key thing tuned with the
>>> tcp_tso_rtt_log knob.
>>>
>>> So it would be great to have the following from both data sender and
>>> data receiver, for both the good case and bad case, if you could start
>>> these before your test and kill them after the test stops:
>>>
>>> (while true; do date; ss -tenmoi; sleep 1; done) > /root/ss.txt &
>>> nstat -n; (while true; do date; nstat; sleep 1; done)  > /root/nstat.t=
xt
>> i upload everything here:
>> https://github.com/lategoodbye/tcp_tso_rtt_log_regress
>>
>> The server part is a Ubuntu installation connected to the internet. At
>> first i logged the good case, then i continued with the bad case.
>> Accidentally i delete a log file of bad case, so i repeated the whole
>> bad case again. So the uploaded bad case files are from the third run.
> Thanks for the detailed data!
>
> Here are some notes from looking at this data:
>
> + bad client: avg TSO burst size is roughly:
> https://github.com/lategoodbye/tcp_tso_rtt_log_regress/blob/main/nstat_c=
lient_bad.log
> IpOutRequests                   308               44.7
> IpExtOutOctets                  10050656        1403181.0
> est bytes   per TSO burst: 10050656 / 308 =3D 32632
> est packets per TSO burst: 32632 / 1448 ~=3D 22.5
>
> + good client: avg TSO burst size is roughly:
> https://github.com/lategoodbye/tcp_tso_rtt_log_regress/blob/main/nstat_c=
lient_good.log
> IpOutRequests                   529               62.0
> IpExtOutOctets                  11502992        1288711.5
> est bytes   per TSO burst: 11502992 / 529 ~=3D 21745
> est packets per TSO burst: 21745 / 1448 ~=3D 15.0
>
> + bad client ss data:
> https://github.com/lategoodbye/tcp_tso_rtt_log_regress/blob/main/ss_clie=
nt_bad.log
> State Recv-Q Send-Q Local Address:Port   Peer Address:PortProcess
> ESTAB 0      236024  192.168.1.12:39228 192.168.1.129:5001
> timer:(on,030ms,0) ino:25876 sk:414f52af rto:0.21 cwnd:68 ssthresh:20
> reordering:0
> Mbits/sec allowed by cwnd: 68 * 1448 * 8 / .0018 / 1000000.0 ~=3D 437.6
>
> + good client ss data:
> https://github.com/lategoodbye/tcp_tso_rtt_log_regress/blob/main/ss_clie=
nt_good.log
> Fri Oct 13 15:04:36 CEST 2023
> State Recv-Q Send-Q Local Address:Port   Peer Address:PortProcess
> ESTAB 0      425712  192.168.1.12:33284 192.168.1.129:5001
> timer:(on,020ms,0) ino:20654 sk:414f52af rto:0.21 cwnd:106 ssthresh:20
> reordering:0
> Mbits/sec allowed by cwnd: 106 * 1448 * 8 / .0028 / 1000000.0 =3D 438.5
>
> So it seems indeed like cwnd is not the limiting factor, and instead
> there is something about the larger TSO/GSO bursts (roughly 22.5
> packets per burst on average) in the "bad" case that is causing
> problems, and preventing the sender from keeping the pipe fully
> utilized.
>
> So perhaps the details of the tcp_tso_should_defer() logic are hurting
> performance?
>
> The default value of tcp_tso_win_divisor is 3, and in the bad case the
> cwnd / tcp_tso_win_divisor =3D 68 / 3 =3D 22.7 packets, which is
> suspiciously close to the average TSO burst size of 22.5. So my guess
> is that the tcp_tso_win_divisor of 3 is the dominant factor here, and
> perhaps if we raise it to 5, then 68/5 ~=3D 13.60 will approximate the
> TSO burst size in the "good" case, and fully utilize the pipe. So it
> seems worth an experiment, to see what we can learn.
>
> To test that theory, could you please try running the following as
> root on the data sender machine, and then re-running the "bad" test
> with tcp_tso_rtt_log at the default value of 9?
>
>     sysctl net.ipv4.tcp_tso_win_divisor=3D5
Unfortunately this doesn't fix it.

Please look at the trace and sysctl settings [1]. I will try to figure
out what's wrong mit iproute2-ss later. CET says it's time to sleep.

[1] -
https://github.com/lategoodbye/tcp_tso_rtt_log_regress/commit/e1ceb689d779=
7eb10127613861d56cb3303f7b72
>
> Thanks!
> neal



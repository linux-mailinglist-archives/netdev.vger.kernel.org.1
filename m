Return-Path: <netdev+bounces-40716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A55737C86F4
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 15:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4188BB20983
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 13:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC33715E9E;
	Fri, 13 Oct 2023 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Oe55oofo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EEC1096B
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 13:37:18 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE2895
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 06:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
 t=1697204225; x=1697809025; i=wahrenst@gmx.net;
 bh=M3CryACWh8gOvZZGn8MpbMigRUWDXhC/fi0OvVCJA/U=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Oe55oofo+aD1Ulow7k4bm/iEMnvD12iGrgumEKTIPufwlfrYSEQjmHVZd8ywQYJ4rzhNqeTZCOJ
 tWX1oi4skxwpSAAhfjuGUHnDaBq2cGTx3Xcugclc9AvpLBVNTbxxhUeuDhA0tjBd0pxsggv/QBxAn
 r9XgXmjdmxYAzY/9XCzjHjp4TJaB9k5Hbj5bD6qxyS0lDgr0OKl6f1rLep2vstAE9Mx+wKKSz76Cb
 dksM7dU8dH6d+sfnigwv3wpu/r1tMIielDCRcm1DX0+7wqlr1vFfDRWTHhPZj1KzoDwbr+G4Ou64K
 8wZog42tLJAX9ABvaea3ymtCB0DAlTZPflQQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mzhj9-1rmIvA1C6r-00vhfP; Fri, 13
 Oct 2023 15:37:05 +0200
Message-ID: <a35b1a27-575f-4d19-ad2d-95bf4ded40e9@gmx.net>
Date: Fri, 13 Oct 2023 15:37:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iperf performance regression since Linux 5.18
To: Neal Cardwell <ncardwell@google.com>, Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 linux-imx@nxp.com, Stefan Wahren <stefan.wahren@chargebyte.com>,
 Michael Heimpold <mhei@heimpold.de>, netdev@vger.kernel.org
References: <7f31ddc8-9971-495e-a1f6-819df542e0af@gmx.net>
 <CANn89iKY58YSknzOzkEHxFu=C=1_p=pXGAHGo9ZkAfAGon9ayw@mail.gmail.com>
 <CADVnQymV=nv53YaC8kLC1qT1ufhJL9+w_wcZ+8AHwPRG+JRdnw@mail.gmail.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <CADVnQymV=nv53YaC8kLC1qT1ufhJL9+w_wcZ+8AHwPRG+JRdnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F2qvbdjrd6gT8vKwIaB+4j0qFd5FCYuSKj1do0y7YAldLX3Ioan
 PkZBV6kBTp1tNthJvkodIAu98nMCmSb3WSmukAeXJJcoWgsGlWIQg6Nui6GfzOXgqjjkn0s
 9nD+Fwl8odei9e/gKlnZH/Z0HjywdFJYI0ShgTWFbYoc7XEDk2I+ZDiutLn24gV+G9y79xh
 OWrVO4dIQN3c466wgQ4eg==
UI-OutboundReport: notjunk:1;M01:P0:8fBYIhNfcjE=;gHiz6BOS9ga0m79Ezc1gVGdCKsH
 Z4oHbU1h04Jo5Uq8el7O9vCHQL3ivt1BBRaXN5uT+xNMSxyfiIos6l6v0wunB0jtg7Q/P7Cf4
 qKzCPyuMMgt9ji9n/Dy1AN0iOblNFTcr3MthGWvQI6c35OCoAra1qhPHalOODYG4boVk7YRoM
 XqOtWgGurml5qrJvSy0BZUZ6WfzajmkTDaO62uktML9Oh1Zg2yTCDKzt4qXycLVpyML7P22k4
 5UmI1dxuiX4x+1HLRNPUfIXWb+E97xrB37hNet9c5kK0vWzBBwNTRX66c33ccRVuvlKHF+DtT
 FRHCBjY2XAsuAMjLcJ2iVXKHiwwmR1yWIV/Zispd7y4RxJpFZjYK9uaML29/5uElSTklvdeT/
 lcvtLU5DHnTbKBQ8NE4ufQjwfj5UZXwyr0uHi300keuyWLajOz+xtt8SaBeWt7Wg+2dsnLhPu
 k7G4Um863u0H/oDoQ2uTNiYFUkDenKOjJxI+GTQrvbDT4iAKA/YkWsNXdn2ztfiSSPpb5mUZE
 COJZ3u4zNKCcHKEQWLP8KRD/Ov7UX8nSRjQMk4nk9AhjtvDJceux0mpVd4Xp3l/tuCx5UQo+l
 0kI6VH9Xlv3jPYc+GqcEX/ZZlWXG0JsC0vGxlfwjAN29HHHGMwzq18KOILEp0AIgEBsusQ4DC
 4GpodvQIqwMjNfVX2R7rL7Pt8QTX1LanEjBl1BhN/PX1iOPCUnmBIbxU9fuzTa7mOGiH8Wjln
 1j5XV8o7t5xAoSMsnitm2hxhPlakHH46fm4hfUnvBON0vv5qlF/kfPmIaYYwVeBr7ZyldUuIy
 tuW69EXnqqOf8UFSb6FSRLrVIWzqzXOQgXmvafGOB8UWZVZZTdoZ7RfaQNPganITODkFrjHNr
 B7Bo8vG0no5fNx1xEuuL3HSFWOq00aNUNZ8NTy03ktAYG1PpOJSE4axFPs216n6ULEpfhLkNw
 2a+HDwCgJuuaaNTw2+9pgwfnkGA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

Am 09.10.23 um 21:19 schrieb Neal Cardwell:
> On Mon, Oct 9, 2023 at 3:11=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
>> On Mon, Oct 9, 2023 at 8:58=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net>=
 wrote:
>>> Hi,
>>> we recently switched on our ARM NXP i.MX6ULL based embedded device
>>> (Tarragon Master [1]) from an older kernel version to Linux 6.1. After
>>> that we noticed a measurable performance regression on the Ethernet
>>> interface (driver: fec, 100 Mbit link) while running iperf client on t=
he
>>> device:
>>>
>>> BAD
>>>
>>> # iperf -t 10 -i 1 -c 192.168.1.129
>>> ------------------------------------------------------------
>>> Client connecting to 192.168.1.129, TCP port 5001
>>> TCP window size: 96.2 KByte (default)
>>> ------------------------------------------------------------
>>> [  3] local 192.168.1.12 port 56022 connected with 192.168.1.129 port =
5001
>>> [ ID] Interval       Transfer     Bandwidth
>>> [  3]  0.0- 1.0 sec  9.88 MBytes  82.8 Mbits/sec
>>> [  3]  1.0- 2.0 sec  9.62 MBytes  80.7 Mbits/sec
>>> [  3]  2.0- 3.0 sec  9.75 MBytes  81.8 Mbits/sec
>>> [  3]  3.0- 4.0 sec  9.62 MBytes  80.7 Mbits/sec
>>> [  3]  4.0- 5.0 sec  9.62 MBytes  80.7 Mbits/sec
>>> [  3]  5.0- 6.0 sec  9.62 MBytes  80.7 Mbits/sec
>>> [  3]  6.0- 7.0 sec  9.50 MBytes  79.7 Mbits/sec
>>> [  3]  7.0- 8.0 sec  9.75 MBytes  81.8 Mbits/sec
>>> [  3]  8.0- 9.0 sec  9.62 MBytes  80.7 Mbits/sec
>>> [  3]  9.0-10.0 sec  9.50 MBytes  79.7 Mbits/sec
>>> [  3]  0.0-10.0 sec  96.5 MBytes  80.9 Mbits/sec
>>>
>>> GOOD
>>>
>>> # iperf -t 10 -i 1 -c 192.168.1.129
>>> ------------------------------------------------------------
>>> Client connecting to 192.168.1.129, TCP port 5001
>>> TCP window size: 96.2 KByte (default)
>>> ------------------------------------------------------------
>>> [  3] local 192.168.1.12 port 54898 connected with 192.168.1.129 port =
5001
>>> [ ID] Interval       Transfer     Bandwidth
>>> [  3]  0.0- 1.0 sec  11.2 MBytes  94.4 Mbits/sec
>>> [  3]  1.0- 2.0 sec  11.0 MBytes  92.3 Mbits/sec
>>> [  3]  2.0- 3.0 sec  10.8 MBytes  90.2 Mbits/sec
>>> [  3]  3.0- 4.0 sec  11.0 MBytes  92.3 Mbits/sec
>>> [  3]  4.0- 5.0 sec  10.9 MBytes  91.2 Mbits/sec
>>> [  3]  5.0- 6.0 sec  10.9 MBytes  91.2 Mbits/sec
>>> [  3]  6.0- 7.0 sec  10.8 MBytes  90.2 Mbits/sec
>>> [  3]  7.0- 8.0 sec  10.9 MBytes  91.2 Mbits/sec
>>> [  3]  8.0- 9.0 sec  10.9 MBytes  91.2 Mbits/sec
>>> [  3]  9.0-10.0 sec  10.9 MBytes  91.2 Mbits/sec
>>> [  3]  0.0-10.0 sec   109 MBytes  91.4 Mbits/sec
>>>
>>> We were able to bisect this down to this commit:
>>>
>>> first bad commit: [65466904b015f6eeb9225b51aeb29b01a1d4b59c] tcp: adju=
st
>>> TSO packet sizes based on min_rtt
>>>
>>> Disabling this new setting via:
>>>
>>> echo 0 > /proc/sys/net/ipv4/tcp_tso_rtt_log
>>>
>>> confirm that this was the cause of the performance regression.
>>>
>>> Is it expected that the new default setting has such a performance imp=
act?
> Indeed, thanks for the report.
>
> In addition to the "ss" output Eric mentioned, could you please grab
> "nstat" output, which should allow us to calculate the average TSO/GSO
> and LRO/GRO burst sizes, which is the key thing tuned with the
> tcp_tso_rtt_log knob.
>
> So it would be great to have the following from both data sender and
> data receiver, for both the good case and bad case, if you could start
> these before your test and kill them after the test stops:
>
> (while true; do date; ss -tenmoi; sleep 1; done) > /root/ss.txt &
> nstat -n; (while true; do date; nstat; sleep 1; done)  > /root/nstat.txt
i upload everything here:
https://github.com/lategoodbye/tcp_tso_rtt_log_regress

The server part is a Ubuntu installation connected to the internet. At
first i logged the good case, then i continued with the bad case.
Accidentally i delete a log file of bad case, so i repeated the whole
bad case again. So the uploaded bad case files are from the third run.

>
> Thanks!
> neal



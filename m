Return-Path: <netdev+bounces-41504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDD17CB236
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 20:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A59F1B20D3A
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 18:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E855033988;
	Mon, 16 Oct 2023 18:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="fFrRj3Ef"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD721F61D
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 18:21:16 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1A6AC
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 11:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
 t=1697480465; x=1698085265; i=wahrenst@gmx.net;
 bh=8G9sgkid8V1gahRKGDqoqTwq08lGsgfUBvNKixYV5mY=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=fFrRj3EfrphV9uW9uB3x/h5kAWFS9n6Vy+ZU5rnTb20qWsCL0H1sjJ7rqU2QvJAhDpPWp9qKo3G
 hcvHGh4B4WI2I9Dm7WBjDlxsA2qhiFvMgM4/Viiu0f+TqUsHbEhBNBP8452AVALsxfh6aQLap+9rP
 uthohFAeUbd+Iv45+3Sp6KYekcNwQkcR1pKNWUnpspYYlOxIcRgErj5sse+YTEE+DaVOABV2j/qjt
 ZDN0ih+jnlGVdq8ud5QSHJ6G/BLoXbJ/hpu6jUdC1xeXDqob5Xg9qSxtEROBNtzlKJ3HzZYDMj0T8
 dr4TR+/0ySbk6uI9xOESmzSPUspiTgvPv7BQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnaoZ-1rHZlV3j09-00jW1u; Mon, 16
 Oct 2023 20:21:04 +0200
Message-ID: <b0bbc989-d6c7-4a3e-aa31-a63116542348@gmx.net>
Date: Mon, 16 Oct 2023 20:21:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iperf performance regression since Linux 5.18
To: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
 Stefan Wahren <stefan.wahren@chargebyte.com>,
 Michael Heimpold <mhei@heimpold.de>, netdev@vger.kernel.org,
 Yuchung Cheng <ycheng@google.com>
References: <7f31ddc8-9971-495e-a1f6-819df542e0af@gmx.net>
 <CANn89iKY58YSknzOzkEHxFu=C=1_p=pXGAHGo9ZkAfAGon9ayw@mail.gmail.com>
 <CADVnQymV=nv53YaC8kLC1qT1ufhJL9+w_wcZ+8AHwPRG+JRdnw@mail.gmail.com>
 <a35b1a27-575f-4d19-ad2d-95bf4ded40e9@gmx.net>
 <CADVnQymM2HrGrMGyJX2QQ9PpgQT8JqsRz_0U8_WvdvzteqsfEQ@mail.gmail.com>
 <CANn89iL97hLAyHx9ee1VKTnLEgJeEVPrf_8-wf0BEBKAPQitPA@mail.gmail.com>
 <1ac3ea60-81d8-4501-b983-cb22b046f2ea@gmx.net>
 <a94b00d9-8bbc-4c54-b5c9-4a7902220312@gmx.net>
 <CANn89i+53WWxaZA5+cc9Yck8h+HTV6BvbybAnvTckriFfKpQMQ@mail.gmail.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <CANn89i+53WWxaZA5+cc9Yck8h+HTV6BvbybAnvTckriFfKpQMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KR03gsMgmmoT731RbBDmN1mWML9pFiP0PvBef7uZwbP4FNMYHOO
 5AV4lAhAN0FAA9O3feLbUG4ZE5df528m0frPhCYQJkB7gmPgHgk0NEb3kRkfatG3AWH8xHn
 CX6Q8f9bpAZV4XSZx9vlMajhN/xXStyId+IjPaknzS+25RCpyzCfQXFesgc4BTqN2Jlk6dc
 IJfqRSSAkcsiWCbiX6WQw==
UI-OutboundReport: notjunk:1;M01:P0:iP4rGHCLh3E=;oCvXYVZnCweQVC6lql2Zd81uBoI
 Kwng+mRs8fPGr84crvfJ4U0vpzUcyH0PYXju/hckqdiETULqtN1yBJowBzFVSkSJApDkz5wwR
 VmYMSueQfUF/v6vNQU1gDPlGeVsoyvaW3dNWc22bSj4m6pINFQ3bXYD1267Ifi9oFAETt50Ah
 v5bEurQkRtLktj7Rx7LuUucHJVyW35rZlbcHD9jGYQWvRzTmA1kPkE/hp+Ff2vD/fh7armS0Q
 Q4ArqUNsLsqLR+1LjwC9dmUT1Wv55m0exVMFz+xghcf+KULPOg6gD9O1ZyDgsKVhhWUWhlwPb
 3TB0ca9nkfXZulYrqDqib7BpbAGBFDwI/4K7ER+Qwk7DOUjJ7YoMszkCrmnmQg7w2ljjU3/G7
 XMd8+9mBzVjQHdpNXCRKUYkfmgj7i59g4A5Lh5FJQvoPM4ZnTRp7YZ5wg1Ql/xRCptMDOXZlT
 DccB17tjnMPWORWVfmfeIoLSysTnDaTrkqaFVbLDybfmbCqX4tui+YBazHvMkpc+AxZxvYFkO
 OYv1Vv/1Bbz9Ygmk+bmZSMCHVTGurrPi/z5JdkxdZJk2V02C8G8Xdwmd8dUdrrqActE3fJQz6
 VmAW5PmKwIQupMsUx0pXyMQ4KV2Meeog8SM/tbCztMwHPxPXyLpqYPFzpaCcSsTQZB1tEn7MM
 vflNKNIA0ZCDuRL08wpG3Y3oFQ4m14Dc39rg9pM5/i0DfeLfrA8u3aCH7EGa8ZEeUWu7Xwudk
 caqGBE8hT5OYgW9eHK/jYmyyMSfQZYlSbfETJTz3Ik147XDYOZf+5yUU53Nc5+TZT5FY36vi+
 k6xX7LkVzT3gfAiLm7x6wxC8thnROIaWg9waknIL7fNoKQVQjCNX6K7TtQIawIWI+LX1MWELj
 CQlE0W32qilb0KaF5c4+Zz/QJu7wMJyVEA5CJ0azvTCn2QS/yC7RS4JmrnnL/6ndJG5WvXx6V
 Xhh4cg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Eric,

Am 16.10.23 um 11:49 schrieb Eric Dumazet:
> On Sun, Oct 15, 2023 at 12:23=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net=
> wrote:
>> Hi,
>>
>> Am 15.10.23 um 01:26 schrieb Stefan Wahren:
>>> Hi Eric,
>>>
>>> Am 15.10.23 um 00:51 schrieb Eric Dumazet:
>>>> On Sat, Oct 14, 2023 at 9:40=E2=80=AFPM Neal Cardwell <ncardwell@goog=
le.com>
>>>> wrote:
>> ...
>>>> Hmm, we receive ~3200 acks per second, I am not sure the
>>>> tcp_tso_should_defer() logic
>>>> would hurt ?
>>>>
>>>> Also the ss binary on the client seems very old, or its output has
>>>> been mangled perhaps ?
>>> this binary is from Yocto kirkstone:
>>>
>>> # ss --version
>>> ss utility, iproute2-5.17.0
>>>
>>> This shouldn't be too old. Maybe some missing kernel settings?
>>>
>> i think i was able to fix the issue by enable the proper kernel
>> settings. I rerun initial bad and good case again and overwrote the log
>> files:
>>
>> https://github.com/lategoodbye/tcp_tso_rtt_log_regress/commit/93615c94b=
a1bf36bd47cc2b91dd44a3f58c601bc
> Excellent, thanks.
>
> I see your kernel uses HZ=3D100, have you tried HZ=3D1000 by any chance =
?
>
> CONFIG_HZ_1000=3Dy
> CONFIG_HZ=3D1000
i tried, but it doesn't have any influence.
> I see that the bad run seems to be stuck for a while with cwnd=3D66, but
> a smaller amount of packets in flight (26 in following ss extract)
>
> ESTAB 0 315664 192.168.1.12:60542 192.168.1.129:5001
> timer:(on,030ms,0) ino:13011 sk:2 <->
> skmem:(r0,rb131072,t48488,tb295680,f3696,w319888,o0,bl0,d0) ts sack
> cubic wscale:7,6 rto:210 rtt:3.418/1.117 mss:1448 pmtu:1500 rcvmss:536
> advmss:1448 cwnd:66 ssthresh:20 bytes_sent:43874400
> bytes_acked:43836753 segs_out:30302 segs_in:14110 data_segs_out:30300
> send 223681685bps lastsnd:10 lastrcv:4310 pacing_rate 268408200bps
> delivery_rate 46336000bps delivered:30275 busy:4310ms unacked:26
> rcv_space:14480 rcv_ssthresh:64088 notsent:278016 minrtt:0.744
>
> I wonder if fec pseudo-tso code is adding some kind of artifacts,
> maybe with TCP small queue logic.
> (TX completion might be delayed too much on fec driver side)
>
> Can you try
>
> ethtool -K eth0 tso off ?
TSO off, CONFIG_HZ_100=3Dy

root@tarragon:~# iperf -t 10 -i 1 -c 192.168.1.129
=2D-----------------------------------------------------------
Client connecting to 192.168.1.129, TCP port 5001
TCP window size:=C2=A0 122 KByte (default)
=2D-----------------------------------------------------------
[=C2=A0 3] local 192.168.1.12 port 52326 connected with 192.168.1.129 port=
 5001
[ ID] Interval=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Transfer=C2=A0=C2=A0=C2=
=A0=C2=A0 Bandwidth
[=C2=A0 3]=C2=A0 0.0- 1.0 sec=C2=A0 11.6 MBytes=C2=A0 97.5 Mbits/sec
[=C2=A0 3]=C2=A0 1.0- 2.0 sec=C2=A0 11.2 MBytes=C2=A0 94.4 Mbits/sec
[=C2=A0 3]=C2=A0 2.0- 3.0 sec=C2=A0 11.2 MBytes=C2=A0 94.4 Mbits/sec
[=C2=A0 3]=C2=A0 3.0- 4.0 sec=C2=A0 11.1 MBytes=C2=A0 93.3 Mbits/sec
[=C2=A0 3]=C2=A0 4.0- 5.0 sec=C2=A0 11.2 MBytes=C2=A0 94.4 Mbits/sec
[=C2=A0 3]=C2=A0 5.0- 6.0 sec=C2=A0 11.1 MBytes=C2=A0 93.3 Mbits/sec
[=C2=A0 3]=C2=A0 6.0- 7.0 sec=C2=A0 11.4 MBytes=C2=A0 95.4 Mbits/sec
[=C2=A0 3]=C2=A0 7.0- 8.0 sec=C2=A0 11.1 MBytes=C2=A0 93.3 Mbits/sec
[=C2=A0 3]=C2=A0 8.0- 9.0 sec=C2=A0 11.5 MBytes=C2=A0 96.5 Mbits/sec
[=C2=A0 3]=C2=A0 9.0-10.0 sec=C2=A0 11.1 MBytes=C2=A0 93.3 Mbits/sec
[=C2=A0 3]=C2=A0 0.0-10.0 sec=C2=A0=C2=A0 113 MBytes=C2=A0 94.5 Mbits/sec

The figures seems slightly better than tcp_tso_rtt_log =3D 0 -> Good
> Alternatively I think I mentioned earlier that you could try to reduce
> gso_max_size on a 100Mbit link
>
> ip link set dev eth0 gso_max_size 16384
TSO on, gso_max_size 16384, CONFIG_HZ_100=3Dy

root@tarragon:~# iperf -t 10 -i 1 -c 192.168.1.129
=2D-----------------------------------------------------------
Client connecting to 192.168.1.129, TCP port 5001
TCP window size:=C2=A0 101 KByte (default)
=2D-----------------------------------------------------------
[=C2=A0 3] local 192.168.1.12 port 54548 connected with 192.168.1.129 port=
 5001
[ ID] Interval=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Transfer=C2=A0=C2=A0=C2=
=A0=C2=A0 Bandwidth
[=C2=A0 3]=C2=A0 0.0- 1.0 sec=C2=A0 11.4 MBytes=C2=A0 95.4 Mbits/sec
[=C2=A0 3]=C2=A0 1.0- 2.0 sec=C2=A0 11.0 MBytes=C2=A0 92.3 Mbits/sec
[=C2=A0 3]=C2=A0 2.0- 3.0 sec=C2=A0 10.9 MBytes=C2=A0 91.2 Mbits/sec
[=C2=A0 3]=C2=A0 3.0- 4.0 sec=C2=A0 11.0 MBytes=C2=A0 92.3 Mbits/sec
[=C2=A0 3]=C2=A0 4.0- 5.0 sec=C2=A0 10.6 MBytes=C2=A0 89.1 Mbits/sec
[=C2=A0 3]=C2=A0 5.0- 6.0 sec=C2=A0 11.0 MBytes=C2=A0 92.3 Mbits/sec
[=C2=A0 3]=C2=A0 6.0- 7.0 sec=C2=A0 10.9 MBytes=C2=A0 91.2 Mbits/sec
[=C2=A0 3]=C2=A0 7.0- 8.0 sec=C2=A0 11.0 MBytes=C2=A0 92.3 Mbits/sec
[=C2=A0 3]=C2=A0 8.0- 9.0 sec=C2=A0 10.8 MBytes=C2=A0 90.2 Mbits/sec
[=C2=A0 3]=C2=A0 9.0-10.0 sec=C2=A0 10.9 MBytes=C2=A0 91.2 Mbits/sec
[=C2=A0 3]=C2=A0 0.0-10.0 sec=C2=A0=C2=A0 109 MBytes=C2=A0 91.7 Mbits/sec

The figures are similiar to tcp_tso_rtt_log =3D 0 -> Good


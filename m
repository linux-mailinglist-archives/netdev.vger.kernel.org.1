Return-Path: <netdev+bounces-41950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A51907CC607
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 16:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2C56B210D8
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 14:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAE341E23;
	Tue, 17 Oct 2023 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ISlPm5yd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEBB1F5FA
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 14:39:09 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D037B0
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 07:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
 t=1697553531; x=1698158331; i=wahrenst@gmx.net;
 bh=vjiBJBdXURqAr5mlqf8TRfrJKfDIvVbJDwTpW8QJCgA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=ISlPm5ydTaky+Y3PPrxodqDqdDzhoXnkMIKBFttfl2/Yvjie2qufxyJWFEHrpFQsd9lEtE7awbG
 m4zNI4wZmSbANAINyurOXp05cu2EYlj2juqb3BlTKO0rsZnvgirp0u6Dx3ALfa6yAYm5lq8hBYMPE
 HXHeSOHEbzku8vnbs+1XneAFseIMm1syQp1l9z3/eds9GPHOdQnUE8VOnXbrUO9RmnTTxV7SxBl4e
 df0XEyNIAzc23lufxAZcu9xYKLacxpO20+JiQLXzzTIDunn4gF/7vfgpuUr0R96/tt/OcDkfzKV14
 TSE/Uc2hv49ARsocNdl9mJo3YGAOLX+BX4zg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKbg4-1r77Cw47cS-00Ku33; Tue, 17
 Oct 2023 16:38:51 +0200
Message-ID: <b0f3d278-5da3-4ef8-8b9b-2cb439e2e88f@gmx.net>
Date: Tue, 17 Oct 2023 16:38:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tcp: tsq: relax tcp_small_queue_check() when rtx
 queue contains a single skb
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Neal Cardwell <ncardwell@google.com>
References: <20231017124526.4060202-1-edumazet@google.com>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20231017124526.4060202-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1I1Tun17Og24bz7b9JiZCmxoRDaFT5VYxOg+G4M76d5LCUr1W3j
 CGVq2osPr6nzU8UdTkbOLku8yBgaTulBlQzsnmusp+tSbfL9CpZaT9FVeokBK6oR5rnVhpS
 ZCD4rBohwhyvSc8SS7JneocJ9nypNT2wC7WsoqadEtxFg2sPGW3rKq6LvnS5OZX3rZzC0h5
 gMCtyMUpNQst9jBr1o41w==
UI-OutboundReport: notjunk:1;M01:P0:+zD6e7QpANY=;pxprGekyMNsXRlO5yvjPoihMDII
 biw1rCa56YTZpNSGsi12KW2JmMRUVKU3Z6Tmr/oeu4Hls94NmIXf9IQetM+GzXrAu+2KmBOYc
 8x6cU6wPM3TW+of2vreI8EG83YWivcOfrFHhURi9pyBJ3pZrVlMbzn/B0Djvqyqewi/j4m7Fu
 PZSmd9PLYltivilFWl7Nkhu/HDmoE5BSf5qbjAPNAbGEBrd+5CYqcicoXTwpRp4dQJllJNT47
 +p4XigwPHcfj4L3MBKl92e3dh/lH4XpKvKF0DNvWTmi+6GwZKMxdnoT/OPziQPs3c+zG21FkH
 DwJpm+yzbOXtq5Duk1/h2ce2tf7zYCzuGh+B7/0dnSuV2ym6NVVINKgxcrNFemS92r3A4u9J2
 8UGs5Ks5HCbXRuL04rKfKtEhGlw/M+PF5ztaR439Lj/rTtmpfiSw+69WVMiMDDUXYp8ezkLz5
 +dle12V4eTGbrupLm4hu3DXLxacSBko1gEklq9hEbP480hgFAEyVJDkuP5QnX75+EqTESEqsT
 I9G8cx0IPDFXm0S2rapdq088CHEWnvfl7fQXhuzOc2OuIf32k6uJR4PT0cwbgUwHZou3XIzh1
 rpchNPOGJMKQ+PA4j+BqzRcIKfBHzpt/WTwSsv+2JmAlhqlzrHrNqDZCNGAnwRzacqr7givIn
 stklrZaxkaVLc/sv6C/h9UxUVWr8W8VLFWVAhzVU7BQovpEwLXprvzrYaJUvEwwVFBjcnTWkF
 Iu3IQ6nn9iMhJOUMW3CYrqqodN7rxnKM6q0wy9oPFYQC5PSVMavjTDBhCnRXsqMDHcy4+UtHV
 nNrxslTIADgfhTnA/UKOhAxYXl64OThdZIopElbMPSMh+odJV3CxZwe8ggTQMJ1iEjagkMccu
 0yg+hoFwWqtJVHff190pJjjib0O2k73yokFwF+tcIvh3MYoaeGWajBoIGqbQKFG9raJihs07X
 jxW+IQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

Am 17.10.23 um 14:45 schrieb Eric Dumazet:
> In commit 75eefc6c59fd ("tcp: tsq: add a shortcut in tcp_small_queue_che=
ck()")
> we allowed to send an skb regardless of TSQ limits being hit if rtx queu=
e
> was empty or had a single skb, in order to better fill the pipe
> when/if TX completions were slow.
>
> Then later, commit 75c119afe14f ("tcp: implement rb-tree based
> retransmit queue") accidentally removed the special case for
> one skb in rtx queue.
>
> Stefan Wahren reported a regression in single TCP flow throughput
> using a 100Mbit fec link, starting from commit 65466904b015 ("tcp: adjus=
t
> TSO packet sizes based on min_rtt"). This last commit only made the
> regression more visible, because it locked the TCP flow on a particular
> behavior where TSQ prevented two skbs being pushed downstream,
> adding silences on the wire between each TSO packet.
>
> Many thanks to Stefan for his invaluable help !
>
just some figures using my ARM platform (Tarragon) as iperf client and a
PC (Ubuntu 22.04) as iperf server.

Using current net ( 95535e37e895 ) without the patch

# iperf -t 10 -i 1 -c 192.168.1.129
=2D-----------------------------------------------------------
Client connecting to 192.168.1.129, TCP port 5001
TCP window size: 96.2 KByte (default)
=2D-----------------------------------------------------------
[=C2=A0 3] local 192.168.1.12 port 33152 connected with 192.168.1.129 port=
 5001
[ ID] Interval=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Transfer=C2=A0=C2=A0=C2=
=A0=C2=A0 Bandwidth
[=C2=A0 3]=C2=A0 0.0- 1.0 sec=C2=A0 10.1 MBytes=C2=A0 84.9 Mbits/sec
[=C2=A0 3]=C2=A0 1.0- 2.0 sec=C2=A0 9.62 MBytes=C2=A0 80.7 Mbits/sec
[=C2=A0 3]=C2=A0 2.0- 3.0 sec=C2=A0 9.62 MBytes=C2=A0 80.7 Mbits/sec
[=C2=A0 3]=C2=A0 3.0- 4.0 sec=C2=A0 9.62 MBytes=C2=A0 80.7 Mbits/sec
[=C2=A0 3]=C2=A0 4.0- 5.0 sec=C2=A0 9.62 MBytes=C2=A0 80.7 Mbits/sec
[=C2=A0 3]=C2=A0 5.0- 6.0 sec=C2=A0 9.62 MBytes=C2=A0 80.7 Mbits/sec
[=C2=A0 3]=C2=A0 6.0- 7.0 sec=C2=A0 9.62 MBytes=C2=A0 80.7 Mbits/sec
[=C2=A0 3]=C2=A0 7.0- 8.0 sec=C2=A0 9.75 MBytes=C2=A0 81.8 Mbits/sec
[=C2=A0 3]=C2=A0 8.0- 9.0 sec=C2=A0 9.62 MBytes=C2=A0 80.7 Mbits/sec
[=C2=A0 3]=C2=A0 9.0-10.0 sec=C2=A0 10.0 MBytes=C2=A0 83.9 Mbits/sec
[=C2=A0 3]=C2=A0 0.0-10.0 sec=C2=A0 97.2 MBytes=C2=A0 81.5 Mbits/sec

Using current net with applied patch

# iperf -t 10 -i 1 -c 192.168.1.129
=2D-----------------------------------------------------------
Client connecting to 192.168.1.129, TCP port 5001
TCP window size: 96.2 KByte (default)
=2D-----------------------------------------------------------
[=C2=A0 3] local 192.168.1.12 port 32854 connected with 192.168.1.129 port=
 5001
[ ID] Interval=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Transfer=C2=A0=C2=A0=C2=
=A0=C2=A0 Bandwidth
[=C2=A0 3]=C2=A0 0.0- 1.0 sec=C2=A0 11.5 MBytes=C2=A0 96.5 Mbits/sec
[=C2=A0 3]=C2=A0 1.0- 2.0 sec=C2=A0 11.4 MBytes=C2=A0 95.4 Mbits/sec
[=C2=A0 3]=C2=A0 2.0- 3.0 sec=C2=A0 11.2 MBytes=C2=A0 94.4 Mbits/sec
[=C2=A0 3]=C2=A0 3.0- 4.0 sec=C2=A0 11.1 MBytes=C2=A0 93.3 Mbits/sec
[=C2=A0 3]=C2=A0 4.0- 5.0 sec=C2=A0 11.2 MBytes=C2=A0 94.4 Mbits/sec
[=C2=A0 3]=C2=A0 5.0- 6.0 sec=C2=A0 11.2 MBytes=C2=A0 94.4 Mbits/sec
[=C2=A0 3]=C2=A0 6.0- 7.0 sec=C2=A0 11.1 MBytes=C2=A0 93.3 Mbits/sec
[=C2=A0 3]=C2=A0 7.0- 8.0 sec=C2=A0 11.2 MBytes=C2=A0 94.4 Mbits/sec
[=C2=A0 3]=C2=A0 8.0- 9.0 sec=C2=A0 11.2 MBytes=C2=A0 94.4 Mbits/sec
[=C2=A0 3]=C2=A0 9.0-10.0 sec=C2=A0 11.2 MBytes=C2=A0 94.4 Mbits/sec
[=C2=A0 3]=C2=A0 0.0-10.0 sec=C2=A0=C2=A0 113 MBytes=C2=A0 94.4 Mbits/sec

Thanks


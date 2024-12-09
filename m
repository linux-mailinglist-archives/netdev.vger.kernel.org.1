Return-Path: <netdev+bounces-150017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 630F89E890A
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 02:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE9418832E0
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 01:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD04128691;
	Mon,  9 Dec 2024 01:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QqTQFnjJ"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E5C5695
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 01:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733708935; cv=none; b=MtOeP7RD/fW7IGE5eKuisJD7jGe95XzfStPyZ5sdnX7Ir+V62F7+weF7hGU//w14Awsh+OM8O105mI9gtHIZ5eJvya0/5M5b2whlICZIV9m+spOBadXLeJxoYhaBm+lVbOkGdsdWTk26sxfWIZSK7NQ6kzWSL0pj7m0+mpdkoOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733708935; c=relaxed/simple;
	bh=7I+7ewPdPrhkBFcv5aWbXYivYYXOZEl+zQyNL4b3VXc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=VJKvv9QLQiTPTcqB7J6koldQT0c2utuQM+vvgRUDXuTwTowhAZvTkmtnTtwme0VPS2g9g5Y1ooDXGV9zLjz4XdmqlDIbFcUZbc7ozgRXGNqPMP3mWx8m3SZh+ZOi156xpyPyrKtSsx9uNNjJejRw7bBy+e/Z3JSy+asp4Mm3bi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QqTQFnjJ; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241209014849epoutp02b153a3d33a767021ce6ee690f6ef0b27~PXxXvUA9w1320313203epoutp02a
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 01:48:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241209014849epoutp02b153a3d33a767021ce6ee690f6ef0b27~PXxXvUA9w1320313203epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733708929;
	bh=5q2Gy50CjWY8XzahAef4ozcI3q+afsiLyGYUVA8DltM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QqTQFnjJ3H7I68O5YW1arYzF0I7aoeAw5ib66MlFrbrxpY+dnsKYJ9Bhhcrl7MECC
	 i1H3kt3rEkDmgnApL12T+QseBvIE7yu9FhwYPS3bR3JCG65ZSX7rTVtKGk7Cup52sX
	 VRP885yux1dUU5dW8+nAFrg43TSct154mlCd6RTE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20241209014848epcas2p160ab82c51f6cd8a6278ce3e41807009d~PXxXU1pfA3068630686epcas2p1d;
	Mon,  9 Dec 2024 01:48:48 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.90]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Y64XJ25sMz4x9Q7; Mon,  9 Dec
	2024 01:48:48 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	D6.B8.22938.08C46576; Mon,  9 Dec 2024 10:48:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20241209014847epcas2p219955d6e71c91d1f9b2b5dbca5d705d6~PXxWWbxng0909609096epcas2p2c;
	Mon,  9 Dec 2024 01:48:47 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241209014847epsmtrp20eb60868368dbdddaa1a0d845ee7f2d0~PXxWUq6xC1489914899epsmtrp2U;
	Mon,  9 Dec 2024 01:48:47 +0000 (GMT)
X-AuditID: b6c32a43-0b1e27000000599a-f3-67564c80f037
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	69.B4.18949.F7C46576; Mon,  9 Dec 2024 10:48:47 +0900 (KST)
Received: from perf (unknown [10.229.95.91]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241209014847epsmtip2e82778ea439b13f5c32e90b8ff9acd58~PXxWC6tQw0099100991epsmtip23;
	Mon,  9 Dec 2024 01:48:47 +0000 (GMT)
Date: Mon, 9 Dec 2024 10:52:12 +0900
From: Youngmin Nam <youngmin.nam@samsung.com>
To: Neal Cardwell <ncardwell@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Youngmin Nam
	<youngmin.nam@samsung.com>, Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net, dsahern@kernel.org, pabeni@redhat.com,
	horms@kernel.org, dujeong.lee@samsung.com, guo88.liu@samsung.com,
	yiwang.cai@samsung.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, joonki.min@samsung.com,
	hajun.sung@samsung.com, d7271.choe@samsung.com, sw.ju@samsung.com
Subject: Re: [PATCH] tcp: check socket state before calling WARN_ON
Message-ID: <Z1ZNTKHmCV9Jg2o8@perf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CADVnQykZhXO_k5vKpaQBi+9JnuFt1C5E=20mt=mb-bzXrzfXLw@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFJsWRmVeSWpSXmKPExsWy7bCmmW6DT1i6wZ8XvBbX9k5kt5hzvoXF
	Yt2uViaLZwtmsFg8PfaI3WLyFEaLpv2XmC0e9Z9gs7i6+x2zxYVtfawWl3fNYbPouLOXxeLY
	AjGLb6ffMFq0Pv7MbvHxeBO7xeIDn9gdBD22rLzJ5LFgU6nHplWdbB7v911l8+jbsorR4/Mm
	uQC2qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKDT
	lRTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV56Xp5qSVWhgYGRqZA
	hQnZGf9PNzAWfFKqWPB4PmMD4yupLkYODgkBE4m90yW6GLk4hAR2MEq0n1/ODuF8YpR4dWkh
	E4TzjVHi6ZG9LF2MnGAdO1/vZ4VI7GWUeHvuHxuE85BR4uL6fUwgc1kEVCRab8mANLAJ6Eps
	O/GPEcQWEdCQuLvoASNIPbPAEmaJ6yensYLUCws4S/y9YwtSwyugLLHh4Uc2CFtQ4uTMJ2CL
	OQUCJX7M/QR2kYTAGQ6JXZPXsUJc5CLR/eMHO4QtLPHq+BYoW0ri87u9bBB2sUTD/VvMEM0t
	jBKnrr9ghkgYS8x61g52HbNAhsTOc93skIBRljhyiwUizCfRcfgvVJhXoqNNCKJTTeLXlA2M
	ELaMxO7FK6AmekhMXNDEAgmTXywST9e9YZ/AKDcLyT+zkGybBTSWWUBTYv0ufYiwvETz1tnM
	EGFpieX/OJBULGBkW8UollpQnJuemmxUYAiP6+T83E2M4ESt5byD8cr8f3qHGJk4GA8xSnAw
	K4nwcniHpgvxpiRWVqUW5ccXleakFh9iNAVG00RmKdHkfGCuyCuJNzSxNDAxMzM0NzI1MFcS
	573XOjdFSCA9sSQ1OzW1ILUIpo+Jg1OqgWnJ1fSfPu7SAXy/hd9Y5i6PnJu24V1RdfBzvzw1
	Tr2MusMCpzQlm+RkWfs+lmncCg6xfZit0vFBTIe/NeKKtuLuye8mbQp5Xfjmts+rk1s3WSo6
	zYxgTK8IWsGSMX3lPIfMk86vFkxV1WdwDb0yyzSvoZtZfJ2Z8XxndiabzonszjIem04dNRT6
	Y9GUoeNhm8csGrmHnd2h/LXJkzy1/lQX5bPntvctejGne5Oq7r/nM+037vjn+GC+nHX664bs
	LbPrJovGnn3DlSOqyHj72ItPG1sjtyUvf+UlVnL3X9s1AYfiSXfl3U+cb70ilvvzzN2MlPBD
	66ptp/QtXHrFOfLVWaegZa3Mko+7WTm6lViKMxINtZiLihMB5vzSd10EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCSvG69T1i6wbFzWhbX9k5kt5hzvoXF
	Yt2uViaLZwtmsFg8PfaI3WLyFEaLpv2XmC0e9Z9gs7i6+x2zxYVtfawWl3fNYbPouLOXxeLY
	AjGLb6ffMFq0Pv7MbvHxeBO7xeIDn9gdBD22rLzJ5LFgU6nHplWdbB7v911l8+jbsorR4/Mm
	uQC2KC6blNSczLLUIn27BK6MfecvshRMUajYdWsPYwPjCokuRk4OCQETiZ2v97N2MXJxCAns
	ZpToezmBFSIhI3F75WUoW1jifssRqKL7jBLb5h9n7mLk4GARUJFovSUDUsMmoCux7cQ/RhBb
	REBD4u6iB4wg9cwCy5glFrz4D1YvLOAs8feOLUgNr4CyxIaHH9kgZq5gkZh65TEbREJQ4uTM
	JywgNrOAusSfeZfAepkFpCWW/+OACMtLNG+dzQxicwoESvyY+4lpAqPgLCTds5B0z0LonoWk
	ewEjyypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k/NxNjOAY1NLawbhn1Qe9Q4xMHIyHGCU4
	mJVEeDm8Q9OFeFMSK6tSi/Lji0pzUosPMUpzsCiJ83573ZsiJJCeWJKanZpakFoEk2Xi4JRq
	YHJ6ousrUuChvY411Uij9c271+rzlbq9Fq5TWbJRfmPGM61JbU+/RP3+pr1v3n4GnaT8S4xm
	vxkmvDk6b5Ha/+f6tytjN7yUjG764ras0OHqdzXXZxHTdh2Sa42TO1thKKafxfCssmZZRHvb
	B+Ya06qZ5k0SN0xln2fMvxB02df3obmt6a7P+tNdv8/jPzxd30/W+NKDVPepvhsSJ0mGCKtp
	J7d+YG94XW7i8GzPbub8rvPtN+QZlteey1CyiagxV5e+kW5+w8c730r+lETSnCUP+qJyD99U
	TYu2umP9vfaj/Ou8XbwyYTO7/z2JTZ51QkWkwTs6uvXfhmmKF0+cN7xwzy5J9BbnL7vfIpO+
	KbEUZyQaajEXFScCACHXCUgwAwAA
X-CMS-MailID: 20241209014847epcas2p219955d6e71c91d1f9b2b5dbca5d705d6
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----Cwu3ZXVVeZAiO6hmdsuERc26j9mSSa5rGzwFtoxKk617clws=_fa1aa_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241209014847epcas2p219955d6e71c91d1f9b2b5dbca5d705d6
References: <CANn89iK+7CKO31=3EvNo6-raUzyibwRRN8HkNXeqzuP9q8k_tA@mail.gmail.com>
	<CADVnQynUspJL4e3UnZTKps9WmgnE-0ngQnQmn=8gjSmyg4fQ5A@mail.gmail.com>
	<20241203181839.7d0ed41c@kernel.org> <Z0/O1ivIwiVVNRf0@perf>
	<CANn89iKms_9EX+wArf1FK7Cy3-Cr_ryX+MJ2YC8yt1xmvpY=Uw@mail.gmail.com>
	<Z1KRaD78T3FMffuX@perf>
	<CANn89iKOC9busc9G_akT=H45FvfVjWm97gmCyj=s7_zYJ43T3w@mail.gmail.com>
	<Z1K9WVykZbo6u7uG@perf>
	<CANn89i+BuU+1__zSWgjshFzfxFUttDEpn90V+p8+mVGCHidYAA@mail.gmail.com>
	<CADVnQykZhXO_k5vKpaQBi+9JnuFt1C5E=20mt=mb-bzXrzfXLw@mail.gmail.com>
	<CGME20241209014847epcas2p219955d6e71c91d1f9b2b5dbca5d705d6@epcas2p2.samsung.com>

------Cwu3ZXVVeZAiO6hmdsuERc26j9mSSa5rGzwFtoxKk617clws=_fa1aa_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Fri, Dec 06, 2024 at 10:34:16AM -0500, Neal Cardwell wrote:
> On Fri, Dec 6, 2024 at 4:08 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Fri, Dec 6, 2024 at 9:58 AM Youngmin Nam <youngmin.nam@samsung.com> wrote:
> > >
> > > On Fri, Dec 06, 2024 at 09:35:32AM +0100, Eric Dumazet wrote:
> > > > On Fri, Dec 6, 2024 at 6:50 AM Youngmin Nam <youngmin.nam@samsung.com> wrote:
> > > > >
> > > > > On Wed, Dec 04, 2024 at 08:13:33AM +0100, Eric Dumazet wrote:
> > > > > > On Wed, Dec 4, 2024 at 4:35 AM Youngmin Nam <youngmin.nam@samsung.com> wrote:
> > > > > > >
> > > > > > > On Tue, Dec 03, 2024 at 06:18:39PM -0800, Jakub Kicinski wrote:
> > > > > > > > On Tue, 3 Dec 2024 10:34:46 -0500 Neal Cardwell wrote:
> > > > > > > > > > I have not seen these warnings firing. Neal, have you seen this in the past ?
> > > > > > > > >
> > > > > > > > > I can't recall seeing these warnings over the past 5 years or so, and
> > > > > > > > > (from checking our monitoring) they don't seem to be firing in our
> > > > > > > > > fleet recently.
> > > > > > > >
> > > > > > > > FWIW I see this at Meta on 5.12 kernels, but nothing since.
> > > > > > > > Could be that one of our workloads is pinned to 5.12.
> > > > > > > > Youngmin, what's the newest kernel you can repro this on?
> > > > > > > >
> > > > > > > Hi Jakub.
> > > > > > > Thank you for taking an interest in this issue.
> > > > > > >
> > > > > > > We've seen this issue since 5.15 kernel.
> > > > > > > Now, we can see this on 6.6 kernel which is the newest kernel we are running.
> > > > > >
> > > > > > The fact that we are processing ACK packets after the write queue has
> > > > > > been purged would be a serious bug.
> > > > > >
> > > > > > Thus the WARN() makes sense to us.
> > > > > >
> > > > > > It would be easy to build a packetdrill test. Please do so, then we
> > > > > > can fix the root cause.
> > > > > >
> > > > > > Thank you !
> > > > > >
> > > > >
> > > > > Hi Eric.
> > > > >
> > > > > Unfortunately, we are not familiar with the Packetdrill test.
> > > > > Refering to the official website on Github, I tried to install it on my device.
> > > > >
> > > > > Here is what I did on my local machine.
> > > > >
> > > > > $ mkdir packetdrill
> > > > > $ cd packetdrill
> > > > > $ git clone https://protect2.fireeye.com/v1/url?k=746d28f3-15e63dd6-746ca3bc-74fe485cbff6-e405b48a4881ecfc&q=1&e=ca164227-d8ec-4d3c-bd27-af2d38964105&u=https%3A%2F%2Fgithub.com%2Fgoogle%2Fpacketdrill.git .
> > > > > $ cd gtests/net/packetdrill/
> > > > > $./configure
> > > > > $ make CC=/home/youngmin/Downloads/arm-gnu-toolchain-13.3.rel1-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-gcc
> > > > >
> > > > > $ adb root
> > > > > $ adb push packetdrill /data/
> > > > > $ adb shell
> > > > >
> > > > > And here is what I did on my device
> > > > >
> > > > > erd9955:/data/packetdrill/gtests/net # ./packetdrill/run_all.py -S -v -L -l tcp/
> > > > > /system/bin/sh: ./packetdrill/run_all.py: No such file or directory
> > > > >
> > > > > I'm not sure if this procedure is correct.
> > > > > Could you help us run the Packetdrill on an Android device ?
> 
> BTW, Youngmin, do you have a packet trace (e.g., tcpdump .pcap file)
> of the workload that causes this warning?
> 
> If not, in order to construct a packetdrill test to reproduce this
> issue, you may need to:
> 
> (1) add code to the warning to print the local and remote IP address
> and port number when the warning fires (see DBGUNDO() for an example)
> 
> (2) take a tcpdump .pcap trace of the workload
> 
> Then you can use the {local_ip:local_port, remote_ip:remote_port} info
> from (1) to find the packet trace in (2) that can be used to construct
> a packetdrill test to reproduce this issue.
> 
> thanks,
> neal
> 

(Neal, please ignore my previous email as I missed adding the CC list.)

Thank you for your detailed and considerate information.

We are currently trying to reproduce this issue using our stability stress test and
aiming to capture the tcpdump output.

Thanks.

------Cwu3ZXVVeZAiO6hmdsuERc26j9mSSa5rGzwFtoxKk617clws=_fa1aa_
Content-Type: text/plain; charset="utf-8"


------Cwu3ZXVVeZAiO6hmdsuERc26j9mSSa5rGzwFtoxKk617clws=_fa1aa_--


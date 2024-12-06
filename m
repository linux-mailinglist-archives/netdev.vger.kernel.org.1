Return-Path: <netdev+bounces-149606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E66F9E6700
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 06:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1170E1885500
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 05:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0D7194A63;
	Fri,  6 Dec 2024 05:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OWQbzcQH"
X-Original-To: netdev@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163638F66
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 05:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733464230; cv=none; b=rGu8wvIdibkxmFJPBhmgw9bx7o5m9CE9kTxkVF1DD7CqFGk7FFqJ9L6QOXSkivti0xBjdgeQTZaulJTbGVcpml5b2Vpnvp9QcROgYY52FQNOrIoTWO00TxNf9i4qcVdIaTXbGMBFwkMnGqv7oXtkhK+nzkBZ15qOlRdoE5JvdRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733464230; c=relaxed/simple;
	bh=vQEiOL8dHlNiztyDs00fKiaSRkT5GyiKbaFLD07qYzc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=qSh46is00rTdCRAoeL/p76Mc9Sm+lvekpQqzrHxK66lhtXDrCyNxWK1ahJ10PLj/1dC35YcDJtew/QhSTfxEMJLaRpBtpHMPhoLqdNDQhStm4hTrfO1OotWuyD+nuM7Jlwe7d3LcRqQxncyRiN70Pl/VDc/6p0qtyHmEG7dajkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OWQbzcQH; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241206055023epoutp032bc435c47e8ca6db366eca935ade5520~OgIcAAmR91773817738epoutp03j
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 05:50:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241206055023epoutp032bc435c47e8ca6db366eca935ade5520~OgIcAAmR91773817738epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733464223;
	bh=gAD4nrKxltYUkYrM4gD+AsFCBgJS7oVMWjvtQ+RHCCM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OWQbzcQHJy6yubLsXxhEkGMIYuRQNitmErGGp9QKldrpZhYO28Z8tiMuv2215Wc2z
	 aGLIwyeo06EF8KIvLzCwthoxkxV/+mNVKAkyZjkO2NRaf3VJTITa2TozvZwEuUjNgw
	 saydzxyTO7F9GnMI5spANsPtVimBPlyGx8DlK8Vk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20241206055023epcas2p30e0a06460d7f87ddf34c37b62670ec68~OgIbcTNmt1632516325epcas2p3J;
	Fri,  6 Dec 2024 05:50:23 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.70]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Y4L2Q4Y4rz4x9Q4; Fri,  6 Dec
	2024 05:50:22 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	5D.9E.23368.E9092576; Fri,  6 Dec 2024 14:50:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20241206055022epcas2p2318bee5e417e7148018eb39e58835df0~OgIaUcuhL1410614106epcas2p2J;
	Fri,  6 Dec 2024 05:50:22 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241206055022epsmtrp2bf62b09cdfcd574efb59e16ce93551fa~OgIaSt7fv0756107561epsmtrp2t;
	Fri,  6 Dec 2024 05:50:22 +0000 (GMT)
X-AuditID: b6c32a45-dc9f070000005b48-dc-6752909e45f0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9A.2B.18949.D9092576; Fri,  6 Dec 2024 14:50:21 +0900 (KST)
Received: from perf (unknown [10.229.95.91]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241206055021epsmtip2239e5359c2ced719952f3bd59ce5c95f~OgIaDXQmc3013630136epsmtip2B;
	Fri,  6 Dec 2024 05:50:21 +0000 (GMT)
Date: Fri, 6 Dec 2024 14:53:44 +0900
From: Youngmin Nam <youngmin.nam@samsung.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Youngmin Nam <youngmin.nam@samsung.com>, Jakub Kicinski
	<kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>,
	davem@davemloft.net, dsahern@kernel.org, pabeni@redhat.com,
	horms@kernel.org, dujeong.lee@samsung.com, guo88.liu@samsung.com,
	yiwang.cai@samsung.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, joonki.min@samsung.com,
	hajun.sung@samsung.com, d7271.choe@samsung.com, sw.ju@samsung.com
Subject: Re: [PATCH] tcp: check socket state before calling WARN_ON
Message-ID: <Z1KRaD78T3FMffuX@perf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANn89iKms_9EX+wArf1FK7Cy3-Cr_ryX+MJ2YC8yt1xmvpY=Uw@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUwTZxzHeXrl7jDrOKrSR9wYKcYNYmkLtBwMjNEym20xMBLNTDZ2oZeW
	QF/otUbmP8igg0IQIq68aSoQkOrUEV4MpGPSaYHOqIAIxGB0yAwwq9QxBkrWcrj53+f3fX7f
	+32fl8MRvhuNwHN1Jtqoo/KF6BZujytGLjpX/YVa0l//PjnhrMHIptslXPJyXymHnLPXcckn
	Nx9j5OlaQBYPjCLk41NDKHmv/xlC3umpCibH+ppQsuyBk0vetIeTy55FQJb+7sPIF+5ijGz5
	ZQnbF6bs6pjiKO2dZmWnoxxVen++hyqruhxA6euMzECP5qVqaEpFG6NoXY5elatTpwk/y8o+
	kC2TS6QiaTKZJIzSUVo6Taj4PEP0SW6+P7ow6hiVb/ZLGRTDCMV7U416s4mO0ugZU5qQNqjy
	DUmGOIbSMmadOk5Hm1KkEkm8zN/4TZ5mcs3KMbziH3dPZBSB5lArCMEhkQhXih1cK9iC84lr
	AF6s8KFssQTgarMLsMUygFO3e8Eby/qNyU2LE8A/XpxD2OIRgNdtlcGBLi6xC5YPTGABRgkR
	7Bla97txfBuxG/5VdCggI0QbAm95kwPyVuIAfP0gLSDziGjYVvFDMMthcLh+lhvgECITrp45
	jwVGQeI3HM6ctwSzgRTQNW7jsLwVzru7MJYjoO+ZE2WZgUUPpxHWXALgyP2nCLuQABvmvt/I
	hhAaONC7gdAf4tdpLhvzXVjmeo2xMg+WWfiscTdcrb26eSTvwf6WC5sfVMJp9xDGnkg7Ai1P
	TnKrQWTDW9tp+H8YizHwSp+4YWPYB/C77kaElXfC9nX8rQ47QB0gnDYwWjXNxBuk/110jl7b
	CTZedGz6NXD6z+dxg4CDg0EAcUS4jVd4OFPN56mowm9poz7baM6nmUEg899RDRKxPUfv/yV0
	pmxpYrIkUS6XJsXLJElCAW+m9KyKT6gpE51H0wba+MbHwUMiijiV3oJohlxef9nG2yM4+5IK
	ShirsERrFeFK90q4dEVT9yNnpLvGt7en9fJBd3l9aG3Mp38PV0Suee4fVz7sDWrH+r5ydVuq
	yj2F1Qk69xGRYaGx7gpvf7JtolVzZ7i2sMe1h/7QZ526pHg1PzN+sPKYKnO0sSkIF4yFFM8c
	PbPk9Uxk/lT7NFW19miHWJF6yWYVy5OH51T6unSPZfJknLJ1vaPgn1PbR0bverMUd50z/fNm
	W3beIvpx7GzBuHx1vyXFkdVh/fp6yexHJ5pH47QlsxffEcdelQXL+weO2E8MKwS3dtqe39i1
	oyU9NDwP89QcThnc9+XCYlJEmECwkCLkMhpKGosYGepfODLVTloEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSvO7cCUHpBrfOWllc2zuR3WLO+RYW
	i3W7Wpksni2YwWLx9NgjdovJUxgtmvZfYrZ41H+CzeLq7nfMFhe29bFaXN41h82i485eFotj
	C8Qsvp1+w2jR+vgzu8XH403sFosPfGJ3EPTYsvImk8eCTaUem1Z1snm833eVzaNvyypGj8+b
	5ALYorhsUlJzMstSi/TtErgyns5XK5gnUPHkv2ID4wOeLkZODgkBE4l/R2+wdDFycQgJ7GaU
	uPmqnxkiISNxe+VlVghbWOJ+yxFWiKL7jBJb93xlAUmwCKhIdO6/xg5iswnoSmw78Y+xi5GD
	Q0RATeJrgx9IPbPACmaJ+XOfg8WFBZwl/t6xBSnnFVCWWNY9DWrmSmaJo2uOs0EkBCVOznwC
	Np9ZQF3iz7xLzCC9zALSEsv/cUCE5SWat84Gu5NTIFDi19SF7BMYBWch6Z6FpHsWQvcsJN0L
	GFlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIEx5+W1g7GPas+6B1iZOJgPMQowcGs
	JMJbGRaYLsSbklhZlVqUH19UmpNafIhRmoNFSZz32+veFCGB9MSS1OzU1ILUIpgsEwenVAPT
	Enfe7KvHVmq171+4QqiPbceNV84br65ReNo3dQl3Q2ZuUryoZCrX5+dLl3V2vTD5deKigKD0
	gpSpP4y1tZc8FE8pkbRed/n3X7fVBvo33/h2GPJzV53gtNVdGGdh2x3WWMPQ6ujKUuGaFzXv
	qMrbimPyyd66tvIilxefXRjqs+FP7+KtD/lXnXhpwS/3TbXtrNesJ9NvTNXYZ/Bv0Trl/HzR
	dwns505/euviuG2ZQaxTxL1dgSoCsRWxsYzBvSYdOQrP3Jte/V0nUeT7ue2gbu/RvQ+K1q3t
	+rXxOsdi36ht2V/Sbq54wTDnQubXSyahqQ09mouObl5p8bKs1mBZSXWM0alHU5OUZ3bOdHqj
	xFKckWioxVxUnAgAy92lBS4DAAA=
X-CMS-MailID: 20241206055022epcas2p2318bee5e417e7148018eb39e58835df0
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----Cwu3ZXVVeZAiO6hmdsuERc26j9mSSa5rGzwFtoxKk617clws=_e6d32_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295
References: <CGME20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295@epcas2p2.samsung.com>
	<20241203081247.1533534-1-youngmin.nam@samsung.com>
	<CANn89iK+7CKO31=3EvNo6-raUzyibwRRN8HkNXeqzuP9q8k_tA@mail.gmail.com>
	<CADVnQynUspJL4e3UnZTKps9WmgnE-0ngQnQmn=8gjSmyg4fQ5A@mail.gmail.com>
	<20241203181839.7d0ed41c@kernel.org> <Z0/O1ivIwiVVNRf0@perf>
	<CANn89iKms_9EX+wArf1FK7Cy3-Cr_ryX+MJ2YC8yt1xmvpY=Uw@mail.gmail.com>

------Cwu3ZXVVeZAiO6hmdsuERc26j9mSSa5rGzwFtoxKk617clws=_e6d32_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Wed, Dec 04, 2024 at 08:13:33AM +0100, Eric Dumazet wrote:
> On Wed, Dec 4, 2024 at 4:35 AM Youngmin Nam <youngmin.nam@samsung.com> wrote:
> >
> > On Tue, Dec 03, 2024 at 06:18:39PM -0800, Jakub Kicinski wrote:
> > > On Tue, 3 Dec 2024 10:34:46 -0500 Neal Cardwell wrote:
> > > > > I have not seen these warnings firing. Neal, have you seen this in the past ?
> > > >
> > > > I can't recall seeing these warnings over the past 5 years or so, and
> > > > (from checking our monitoring) they don't seem to be firing in our
> > > > fleet recently.
> > >
> > > FWIW I see this at Meta on 5.12 kernels, but nothing since.
> > > Could be that one of our workloads is pinned to 5.12.
> > > Youngmin, what's the newest kernel you can repro this on?
> > >
> > Hi Jakub.
> > Thank you for taking an interest in this issue.
> >
> > We've seen this issue since 5.15 kernel.
> > Now, we can see this on 6.6 kernel which is the newest kernel we are running.
> 
> The fact that we are processing ACK packets after the write queue has
> been purged would be a serious bug.
> 
> Thus the WARN() makes sense to us.
> 
> It would be easy to build a packetdrill test. Please do so, then we
> can fix the root cause.
> 
> Thank you !
> 

Hi Eric.

Unfortunately, we are not familiar with the Packetdrill test.
Refering to the official website on Github, I tried to install it on my device.

Here is what I did on my local machine.

$ mkdir packetdrill
$ cd packetdrill
$ git clone https://github.com/google/packetdrill.git .
$ cd gtests/net/packetdrill/
$./configure
$ make CC=/home/youngmin/Downloads/arm-gnu-toolchain-13.3.rel1-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-gcc

$ adb root
$ adb push packetdrill /data/
$ adb shell

And here is what I did on my device

erd9955:/data/packetdrill/gtests/net # ./packetdrill/run_all.py -S -v -L -l tcp/
/system/bin/sh: ./packetdrill/run_all.py: No such file or directory

I'm not sure if this procedure is correct.
Could you help us run the Packetdrill on an Android device ?

------Cwu3ZXVVeZAiO6hmdsuERc26j9mSSa5rGzwFtoxKk617clws=_e6d32_
Content-Type: text/plain; charset="utf-8"


------Cwu3ZXVVeZAiO6hmdsuERc26j9mSSa5rGzwFtoxKk617clws=_e6d32_--


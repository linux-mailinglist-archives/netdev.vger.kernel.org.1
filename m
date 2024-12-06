Return-Path: <netdev+bounces-149644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 667879E6972
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 09:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 406E616483A
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 08:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B781DF978;
	Fri,  6 Dec 2024 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="coLIY0XM"
X-Original-To: netdev@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B551D63D7
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475486; cv=none; b=VyUVwC2ILJVR5JkKViNNdeuL4y2nlGGuiGDgJu8ZSNMhzWeCLYwmStKUFDrQhLQP3zyrFHgmytHfIDoJ36Vet2x4ThmfaJxg/Pw5RH6STe8oIBkQnLMSUuwFp1BWGqFQRpHAvCP6a0InkYI3ya+jj08mbxSxFoz+u4KJ9R70ckE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475486; c=relaxed/simple;
	bh=ipWHOOSpzzEhcOMd3ga6qACpNCgtJAu8hIWa3RvxlqI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=MTi+8CXYEe3Me2NT+d9a/UxdGx2qysaznuTiKrIwG2dOoL5XgnsamPhfIta3KaUfg7bfQNNVUsa4btsY6DMtvJxua04nN5rlWFpdhdEgq1YZxz4PiFSMenlPGcgBUcnUHGtVGg6ZDeWIxDOWOBy9SZaLg31IIFRuHSJg7DZscHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=coLIY0XM; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241206085801epoutp030ced5205b354cec049c9bb7d02d37849~OisQEMAFJ1138511385epoutp03e
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 08:58:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241206085801epoutp030ced5205b354cec049c9bb7d02d37849~OisQEMAFJ1138511385epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733475481;
	bh=SHFnUVyOXUbXOdDF1O6AcUDNl2Xmnx2b57PgiCCVVsU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=coLIY0XMSn2Zs00ARuHJbuKTnMzMLoq2rAOIegfNmgieBx/hl4tOCswk33skpHhpe
	 XBtT2BALb/tUqPC9I6J69KYdGbDyFp1aYSLkd9/QL1fSHjdLbCrZsw6RVkfYSHE6vQ
	 bSeC6Y9Jxh8++5Z70DhQaCxyrRA9PPFE8Lmj3two=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20241206085800epcas2p4298c780705c73237ac1fc0242a8453b0~OisPT1kk53214632146epcas2p4X;
	Fri,  6 Dec 2024 08:58:00 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.92]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Y4QBv53lhz4x9Pt; Fri,  6 Dec
	2024 08:57:59 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	89.C0.22105.79CB2576; Fri,  6 Dec 2024 17:57:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20241206085759epcas2p1a285a9cda99738a432ceebb0e19f65be~OisOTeFj22986829868epcas2p1B;
	Fri,  6 Dec 2024 08:57:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241206085759epsmtrp1a6632e7aa5dcf2527ae690816f58b71f~OisORMxZC2591025910epsmtrp1Z;
	Fri,  6 Dec 2024 08:57:59 +0000 (GMT)
X-AuditID: b6c32a47-fd1c970000005659-63-6752bc97190b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	11.68.18729.69CB2576; Fri,  6 Dec 2024 17:57:58 +0900 (KST)
Received: from perf (unknown [10.229.95.91]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20241206085758epsmtip1ec66baef78e9af11b08d8c486f1963bd~OisOA9dk_3119231192epsmtip1q;
	Fri,  6 Dec 2024 08:57:58 +0000 (GMT)
Date: Fri, 6 Dec 2024 18:01:22 +0900
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
Message-ID: <Z1K9WVykZbo6u7uG@perf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANn89iKOC9busc9G_akT=H45FvfVjWm97gmCyj=s7_zYJ43T3w@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOJsWRmVeSWpSXmKPExsWy7bCmue70PUHpBj3H1Cyu7Z3IbjHnfAuL
	xbpdrUwWzxbMYLF4euwRu8XkKYwWTfsvMVs86j/BZnF19ztmiwvb+lgtLu+aw2bRcWcvi8Wx
	BWIW306/YbRoffyZ3eLj8SZ2i8UHPrE7CHpsWXmTyWPBplKPTas62Tze77vK5tG3ZRWjx+dN
	cgFsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUCn
	KymUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKzAv0ihNzi0vz0vXyUkusDA0MjEyB
	ChOyMybOvsJUcF+64tSnuawNjH1iXYycHBICJhLPv/1n7GLk4hAS2MEosb9nJROE84lRovfX
	MajMN0aJmw9nssG0XLo6jx0isZdRoqFxJTNIQkjgIaPEixM2IDaLgIrE51XPGUFsNgFdiW0n
	/gHZHBwiAmoSXxv8QMLMAsuYJc6+twQJCws4S/y9YwsS5hVQlli78hsThC0ocXLmExYQm1Mg
	UGLp7Vlg90gInOCQ6HzRBnWPi8Tck7/ZIWxhiVfHt0DZUhIv+9ug7GKJhvu3mCGaWxglTl1/
	wQyRMJaY9awd7DZmgQyJVe1BIKYE0BFHbrFAnMkn0XH4LztEmFeio00IolFN4teUDYwQtozE
	7sUroAZ6SNw6fgIaOh0sEjOX7mOdwCg3C8k7sxCWQZiaEut36c8CWyYv0bx1NjNEWFpi+T8O
	JBULGNlWMYqlFhTnpqcWGxUYwyM6OT93EyM4RWu572Cc8faD3iFGJg7GQ4wSHMxKIryVYYHp
	QrwpiZVVqUX58UWlOanFhxhNgXE0kVlKNDkfmCXySuINTSwNTMzMDM2NTA3MlcR577XOTRES
	SE8sSc1OTS1ILYLpY+LglGpg6q59xfZvzbr4hScf6/ZU+z4vKLw5JTbmxPdcmceLpnMs3tsv
	PPnrTV2X3z/TP0aeM9+U+GHLHDcW+RaBHzGpM+4/uhvoUmZfolc3y+gPi+/vRENTw37XTdsV
	9twN83nDZBPINXWy5De+lP2b39qFPIj5oMikyz7laMjUOTunWKyJ7p+8a9Ek1kX6/ToSjI03
	Li/W8vdSUJOxTxLTOHmK9XHsokNljkaH5zrtOxBtu5xxydp4y83LZK1Un6id1be7mTT9ZUsz
	483+fTJp92ZwiFwKLl9nybCleOa9Y9NeaQhMjSha051wUPmqxf+SALvUjLtC12/deveO8+xn
	N2fjty1OL/mi1VMCf7dWKDCEKbEUZyQaajEXFScCAFNUdrlaBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSnO70PUHpBi1iFtf2TmS3mHO+hcVi
	3a5WJotnC2awWDw99ojdYvIURoum/ZeYLR71n2CzuLr7HbPFhW19rBaXd81hs+i4s5fF4tgC
	MYtvp98wWrQ+/sxu8fF4E7vF4gOf2B0EPbasvMnksWBTqcemVZ1sHu/3XWXz6NuyitHj8ya5
	ALYoLpuU1JzMstQifbsErozPC3rYCxolKx4+jW1gPCPcxcjJISFgInHp6jz2LkYuDiGB3YwS
	a64dYIZIyEjcXnmZFcIWlrjfcoQVoug+o8STn58ZQRIsAioSn1c9B7PZBHQltp34B2RzcIgI
	qEl8bfADqWcWWMEsMX/uc7C4sICzxN87tiDlvALKEmtXfmOCmNnFInGroYsFIiEocXLmEzCb
	WUBd4s+8S8wgvcwC0hLL/3FAhOUlmrfOBruTUyBQYuntWYwTGAVnIemehaR7FkL3LCTdCxhZ
	VjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBMefluYOxu2rPugdYmTiYDzEKMHBrCTC
	WxkWmC7Em5JYWZValB9fVJqTWnyIUZqDRUmcV/xFb4qQQHpiSWp2ampBahFMlomDU6qB6XA4
	y7mUudrHdWvfbf7Ef6okX/n5VVveg6bdD3zqih681ozcwzhZRNCnQKSz83JdDFN3Su/W2o/n
	lvSzmXrnb333fu/BeNZo7uelD34u6a2Itj0dNnHn7TP8qbLLxBd851xSu0VY7nF4ufb10E+l
	V/bcZ9GQW6/T31TY87vMZPWCp5b2P1jv1qkpnBU/o60dkOZ56m9tdKb5xXNTBB/vfz1fXF1T
	a+nBbJd7vDN5l+1mX93FkX+t77O1wvTPLKphbAWJN0z+xteECUSFrj/KbSOyKHS5XfyOSjH1
	71MfHLqlfEP64intSwtkDKZVbj64+m4ts0dMQuaGad4B/F86w8w+tpickV7vZlUV3PhIiaU4
	I9FQi7moOBEA/CRvkC4DAAA=
X-CMS-MailID: 20241206085759epcas2p1a285a9cda99738a432ceebb0e19f65be
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----6TxoHKXr_qkwT5q0XKHb2K6SEyMzWlX0etqXdnnbNHHFM6GI=_e8b90_"
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
	<Z1KRaD78T3FMffuX@perf>
	<CANn89iKOC9busc9G_akT=H45FvfVjWm97gmCyj=s7_zYJ43T3w@mail.gmail.com>

------6TxoHKXr_qkwT5q0XKHb2K6SEyMzWlX0etqXdnnbNHHFM6GI=_e8b90_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Fri, Dec 06, 2024 at 09:35:32AM +0100, Eric Dumazet wrote:
> On Fri, Dec 6, 2024 at 6:50 AM Youngmin Nam <youngmin.nam@samsung.com> wrote:
> >
> > On Wed, Dec 04, 2024 at 08:13:33AM +0100, Eric Dumazet wrote:
> > > On Wed, Dec 4, 2024 at 4:35 AM Youngmin Nam <youngmin.nam@samsung.com> wrote:
> > > >
> > > > On Tue, Dec 03, 2024 at 06:18:39PM -0800, Jakub Kicinski wrote:
> > > > > On Tue, 3 Dec 2024 10:34:46 -0500 Neal Cardwell wrote:
> > > > > > > I have not seen these warnings firing. Neal, have you seen this in the past ?
> > > > > >
> > > > > > I can't recall seeing these warnings over the past 5 years or so, and
> > > > > > (from checking our monitoring) they don't seem to be firing in our
> > > > > > fleet recently.
> > > > >
> > > > > FWIW I see this at Meta on 5.12 kernels, but nothing since.
> > > > > Could be that one of our workloads is pinned to 5.12.
> > > > > Youngmin, what's the newest kernel you can repro this on?
> > > > >
> > > > Hi Jakub.
> > > > Thank you for taking an interest in this issue.
> > > >
> > > > We've seen this issue since 5.15 kernel.
> > > > Now, we can see this on 6.6 kernel which is the newest kernel we are running.
> > >
> > > The fact that we are processing ACK packets after the write queue has
> > > been purged would be a serious bug.
> > >
> > > Thus the WARN() makes sense to us.
> > >
> > > It would be easy to build a packetdrill test. Please do so, then we
> > > can fix the root cause.
> > >
> > > Thank you !
> > >
> >
> > Hi Eric.
> >
> > Unfortunately, we are not familiar with the Packetdrill test.
> > Refering to the official website on Github, I tried to install it on my device.
> >
> > Here is what I did on my local machine.
> >
> > $ mkdir packetdrill
> > $ cd packetdrill
> > $ git clone https://protect2.fireeye.com/v1/url?k=746d28f3-15e63dd6-746ca3bc-74fe485cbff6-e405b48a4881ecfc&q=1&e=ca164227-d8ec-4d3c-bd27-af2d38964105&u=https%3A%2F%2Fgithub.com%2Fgoogle%2Fpacketdrill.git .
> > $ cd gtests/net/packetdrill/
> > $./configure
> > $ make CC=/home/youngmin/Downloads/arm-gnu-toolchain-13.3.rel1-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-gcc
> >
> > $ adb root
> > $ adb push packetdrill /data/
> > $ adb shell
> >
> > And here is what I did on my device
> >
> > erd9955:/data/packetdrill/gtests/net # ./packetdrill/run_all.py -S -v -L -l tcp/
> > /system/bin/sh: ./packetdrill/run_all.py: No such file or directory
> >
> > I'm not sure if this procedure is correct.
> > Could you help us run the Packetdrill on an Android device ?
> 
> packetdrill can run anywhere, for instance on your laptop, no need to
> compile / install it on Android
> 
> Then you can run single test like
> 
> # packetdrill gtests/net/tcp/sack/sack-route-refresh-ip-tos.pkt
> 

You mean.. To test an Android device, we need to run packetdrill on laptop, right ?

Laptop(run packetdrill script) <--------------------------> Android device

By the way, how can we test the Android device (DUT) from packetdrill which is running on Laptop?
I hope you understand that I am aksing this question because we are not familiar with the packetdrill.
Thanks.

------6TxoHKXr_qkwT5q0XKHb2K6SEyMzWlX0etqXdnnbNHHFM6GI=_e8b90_
Content-Type: text/plain; charset="utf-8"


------6TxoHKXr_qkwT5q0XKHb2K6SEyMzWlX0etqXdnnbNHHFM6GI=_e8b90_--


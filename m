Return-Path: <netdev+bounces-150016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B669E88FD
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 02:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04259281DD0
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 01:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACEB224F6;
	Mon,  9 Dec 2024 01:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dc3oMo8I"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8DF320B
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 01:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733707739; cv=none; b=qGArIoYSYiNgf10HZYKLI0jUjPPajV7Cl5yU/IHApM5yiMc4PFFtilOY1hlvThvSm61kGPaUJehWtWKNb0IFNmduM8Sdn+4iXvlWQKf1w0OWAvQqL1i1KHDGgA0hsnIC2csyaxgtAWOt/ynml/clqmSCNj1pIDXnWvAGMV9yHd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733707739; c=relaxed/simple;
	bh=MMjJpS1E3+GtNmd4qR8mN73ya7XW0SCnsIzkRb2o3IA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=jiJ/yQfZlWt4wO8zkYGQreCxzrILRI7QCeOR4/co+u8eZQGRLj7kCD2Qa76CuIJ1XI+PEUiS/bvDbCdWPSr0JvN9+qen05zmQnjw4D9XwGE0D0scuzSldzvVO5uC77GeQvaUbRE39C/sJ6H4ERnzDfC0zwU0MW6hwRuXFhlhpBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dc3oMo8I; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241209012853epoutp02738d76f3ab86ec13d66b7f32ceec92dc~PXf92_-e12505625056epoutp02F
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 01:28:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241209012853epoutp02738d76f3ab86ec13d66b7f32ceec92dc~PXf92_-e12505625056epoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733707733;
	bh=tXpUKRPlXzDCStBidEkIGOaELN3vLfguT2EhBZwlKFA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dc3oMo8IfR/+66EDgVUFY8PTJYgMQgNqHStPmcTQjtD+BvrN9VYCyQf1x5CHTGaF5
	 aC4gCoAmDC4ukmYhTRGv6mr7XSVQKj1rUhVui8+eW+vZRKXLoZ5s28N1mrEZuuq0Sv
	 K3TdHg1tgXb8kAg/EMoHxvmeesOmJI1KYaXh8oks=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20241209012852epcas2p15048a66580ba154bc97ed0583f26f856~PXf9OJVJo3100131001epcas2p17;
	Mon,  9 Dec 2024 01:28:52 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.70]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Y645H72hYz4x9Pt; Mon,  9 Dec
	2024 01:28:51 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	15.4B.32010.3D746576; Mon,  9 Dec 2024 10:28:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20241209012851epcas2p19a32fe38ec43dd2a91eda9540c11bf97~PXf75us-j3099830998epcas2p17;
	Mon,  9 Dec 2024 01:28:51 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241209012851epsmtrp10244d96992e20d503c36995ab6bc8538~PXf74adx60793307933epsmtrp1k;
	Mon,  9 Dec 2024 01:28:51 +0000 (GMT)
X-AuditID: b6c32a4d-acffa70000007d0a-db-675647d3d767
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	51.B2.33707.3D746576; Mon,  9 Dec 2024 10:28:51 +0900 (KST)
Received: from perf (unknown [10.229.95.91]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20241209012850epsmtip15a75039c39acccc11471c729286601f6~PXf7qUsab0371203712epsmtip1E;
	Mon,  9 Dec 2024 01:28:50 +0000 (GMT)
Date: Mon, 9 Dec 2024 10:32:15 +0900
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
Message-ID: <Z1ZIn7+mBZdM5VNt@perf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANn89i+BuU+1__zSWgjshFzfxFUttDEpn90V+p8+mVGCHidYAA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmme5l97B0g5OvzSyu7Z3IbjHnfAuL
	xbpdrUwWzxbMYLF4euwRu8XkKYwWTfsvMVs86j/BZnF19ztmiwvb+lgtLu+aw2bRcWcvi8Wx
	BWIW306/YbRoffyZ3eLj8SZ2i8UHPrE7CHpsWXmTyWPBplKPTas62Tze77vK5tG3ZRWjx+dN
	cgFsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUCn
	KymUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKzAv0ihNzi0vz0vXyUkusDA0MjEyB
	ChOyMybsPcFasMq8Yua1r+wNjHv1uhg5OSQETCQune9i7mLk4hAS2MMo8fLFdRYI5xOjxJu3
	rxjhnFNPV7LBtMy8/QSqZSejxMENu6CqHjJKTD39D6yKRUBF4t7PHiYQm01AV2LbiX9ARRwc
	IgJqEl8b/EDCzALLmCXOvrcECQsLOEv8vWMLEuYVUJZYfW0yO4QtKHFy5hMWEJtTIFDi8rIt
	rCCrJAROcEis+LiOHeIgF4mu6x1QxwlLvDq+BSouJfGyvw3KLpZouH+LGaK5Beib6y+YIRLG
	ErOetTNCHJQhcb15CRvIQRJAVxy5xQIR5pPoOPyXHSLMK9HRJgTRqSbxa8oGRghbRmL34hVQ
	Ez0kXiyazgQJkpcsEt1LHrNNYJSbheSfWUi2zQIayyygKbF+lz5EWF6ieetsZoiwtMTyfxxI
	KhYwsq1ilEotKM5NT002KjDUzUsth8d3cn7uJkZwwtby3cH4ev1fvUOMTByMhxglOJiVRHg5
	vEPThXhTEiurUovy44tKc1KLDzGaAmNqIrOUaHI+MGfklcQbmlgamJiZGZobmRqYK4nz3mud
	myIkkJ5YkpqdmlqQWgTTx8TBKdXAxCZ5xDUqg4vzT1/vV0t1pblfqjvLl/8KfuAW3WZ8PNYh
	4/k7R2P1eyyvxE5xXDH3X9hq+3ilx3TxhzMnLtNwiazYtUpIim2z3vEL8kf5m/ncF6xN/v5a
	sblRIb1smn7k5s++UVvPn8yRWRwfemjRzgNX/v3o/FaiHtF201S3LCZT5QK72pyLxcvM3JQ6
	9u3XnDGpWcsp8I+ov8M59aei7394intOKgnfr33I9vKSV7PTmbK+v2IKVq2wet6954/bhaet
	p06Z/Vm9xaB7b/leCe/KCz4m363N2HJ23p079fevHbINtldmOf3Smau5uP7r9ZRzYe2GzzZP
	DG3bP9v7ucOBNh8W9/bGFgbLXntHJZbijERDLeai4kQAZCuAjGEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnO5l97B0gzsfOSyu7Z3IbjHnfAuL
	xbpdrUwWzxbMYLF4euwRu8XkKYwWTfsvMVs86j/BZnF19ztmiwvb+lgtLu+aw2bRcWcvi8Wx
	BWIW306/YbRoffyZ3eLj8SZ2i8UHPrE7CHpsWXmTyWPBplKPTas62Tze77vK5tG3ZRWjx+dN
	cgFsUVw2Kak5mWWpRfp2CVwZHV/aWQrOmFTcXDONrYHxt3YXIyeHhICJxMzbT5i7GLk4hAS2
	M0q0zZrPApGQkbi98jIrhC0scb/lCCtE0X1GiTcvQTo4OVgEVCTu/exhArHZBHQltp34x9jF
	yMEhIqAm8bXBD6SeWWAFs8T8uc/B4sICzhJ/79iClPMKKEusvjaZHWLmdBaJ3StbGSESghIn
	Zz4BO4JZQF3iz7xLzCC9zALSEsv/cUCE5SWat84GO4FTIFDi8rItrBMYBWch6Z6FpHsWQvcs
	JN0LGFlWMYqmFhTnpucmFxjqFSfmFpfmpesl5+duYgTHnlbQDsZl6//qHWJk4mA8xCjBwawk
	wsvhHZouxJuSWFmVWpQfX1Sak1p8iFGag0VJnFc5pzNFSCA9sSQ1OzW1ILUIJsvEwSnVwGSx
	z6XX+3jt3/w2/ur9sTJnNzomc7b/WT5D/0K9LMuG/Wfl/la9vhLBvcki/9zL7eZLBDkEzsmz
	Pr704f5Bi6TT7kkmSdYS7UZhC2rvmy2tPGYYo6Gp6Pn7y94fD3jKWd3n9C9qWre2v5Br6rJX
	Jzlz5rax7UpUmhzJUxEff8O2wHgbu+6LnDMfv9+aqnZ4htcl3aqdU6a2prmmn7G9NjmnfCaP
	/c/NvCyPpvjOOGp8+6nAokv7XhsLPq4+uJhLq2a2oxhv9LbaD962WW926jUv66y9eMKD/U8g
	o+4znfk6CSvnneEVX8jbmntJpiRuAq/CvsTzDF7u0YnbFApPK63KETIo2sJQ81f+uznnaSWW
	4oxEQy3mouJEAEW97PcsAwAA
X-CMS-MailID: 20241209012851epcas2p19a32fe38ec43dd2a91eda9540c11bf97
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----s1rSNMrXnBzddN1l0VjCdR-rsUXqO_rd2V3PEwJ04hej3fE3=_f98bb_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241209012851epcas2p19a32fe38ec43dd2a91eda9540c11bf97
References: <20241203081247.1533534-1-youngmin.nam@samsung.com>
	<CANn89iK+7CKO31=3EvNo6-raUzyibwRRN8HkNXeqzuP9q8k_tA@mail.gmail.com>
	<CADVnQynUspJL4e3UnZTKps9WmgnE-0ngQnQmn=8gjSmyg4fQ5A@mail.gmail.com>
	<20241203181839.7d0ed41c@kernel.org> <Z0/O1ivIwiVVNRf0@perf>
	<CANn89iKms_9EX+wArf1FK7Cy3-Cr_ryX+MJ2YC8yt1xmvpY=Uw@mail.gmail.com>
	<Z1KRaD78T3FMffuX@perf>
	<CANn89iKOC9busc9G_akT=H45FvfVjWm97gmCyj=s7_zYJ43T3w@mail.gmail.com>
	<Z1K9WVykZbo6u7uG@perf>
	<CANn89i+BuU+1__zSWgjshFzfxFUttDEpn90V+p8+mVGCHidYAA@mail.gmail.com>
	<CGME20241209012851epcas2p19a32fe38ec43dd2a91eda9540c11bf97@epcas2p1.samsung.com>

------s1rSNMrXnBzddN1l0VjCdR-rsUXqO_rd2V3PEwJ04hej3fE3=_f98bb_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Fri, Dec 06, 2024 at 10:08:17AM +0100, Eric Dumazet wrote:
> On Fri, Dec 6, 2024 at 9:58 AM Youngmin Nam <youngmin.nam@samsung.com> wrote:
> >
> > On Fri, Dec 06, 2024 at 09:35:32AM +0100, Eric Dumazet wrote:
> > > On Fri, Dec 6, 2024 at 6:50 AM Youngmin Nam <youngmin.nam@samsung.com> wrote:
> > > >
> > > > On Wed, Dec 04, 2024 at 08:13:33AM +0100, Eric Dumazet wrote:
> > > > > On Wed, Dec 4, 2024 at 4:35 AM Youngmin Nam <youngmin.nam@samsung.com> wrote:
> > > > > >
> > > > > > On Tue, Dec 03, 2024 at 06:18:39PM -0800, Jakub Kicinski wrote:
> > > > > > > On Tue, 3 Dec 2024 10:34:46 -0500 Neal Cardwell wrote:
> > > > > > > > > I have not seen these warnings firing. Neal, have you seen this in the past ?
> > > > > > > >
> > > > > > > > I can't recall seeing these warnings over the past 5 years or so, and
> > > > > > > > (from checking our monitoring) they don't seem to be firing in our
> > > > > > > > fleet recently.
> > > > > > >
> > > > > > > FWIW I see this at Meta on 5.12 kernels, but nothing since.
> > > > > > > Could be that one of our workloads is pinned to 5.12.
> > > > > > > Youngmin, what's the newest kernel you can repro this on?
> > > > > > >
> > > > > > Hi Jakub.
> > > > > > Thank you for taking an interest in this issue.
> > > > > >
> > > > > > We've seen this issue since 5.15 kernel.
> > > > > > Now, we can see this on 6.6 kernel which is the newest kernel we are running.
> > > > >
> > > > > The fact that we are processing ACK packets after the write queue has
> > > > > been purged would be a serious bug.
> > > > >
> > > > > Thus the WARN() makes sense to us.
> > > > >
> > > > > It would be easy to build a packetdrill test. Please do so, then we
> > > > > can fix the root cause.
> > > > >
> > > > > Thank you !
> > > > >
> > > >
> > > > Hi Eric.
> > > >
> > > > Unfortunately, we are not familiar with the Packetdrill test.
> > > > Refering to the official website on Github, I tried to install it on my device.
> > > >
> > > > Here is what I did on my local machine.
> > > >
> > > > $ mkdir packetdrill
> > > > $ cd packetdrill
> > > > $ git clone https://protect2.fireeye.com/v1/url?k=746d28f3-15e63dd6-746ca3bc-74fe485cbff6-e405b48a4881ecfc&q=1&e=ca164227-d8ec-4d3c-bd27-af2d38964105&u=https%3A%2F%2Fgithub.com%2Fgoogle%2Fpacketdrill.git .
> > > > $ cd gtests/net/packetdrill/
> > > > $./configure
> > > > $ make CC=/home/youngmin/Downloads/arm-gnu-toolchain-13.3.rel1-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-gcc
> > > >
> > > > $ adb root
> > > > $ adb push packetdrill /data/
> > > > $ adb shell
> > > >
> > > > And here is what I did on my device
> > > >
> > > > erd9955:/data/packetdrill/gtests/net # ./packetdrill/run_all.py -S -v -L -l tcp/
> > > > /system/bin/sh: ./packetdrill/run_all.py: No such file or directory
> > > >
> > > > I'm not sure if this procedure is correct.
> > > > Could you help us run the Packetdrill on an Android device ?
> > >
> > > packetdrill can run anywhere, for instance on your laptop, no need to
> > > compile / install it on Android
> > >
> > > Then you can run single test like
> > >
> > > # packetdrill gtests/net/tcp/sack/sack-route-refresh-ip-tos.pkt
> > >
> >
> > You mean.. To test an Android device, we need to run packetdrill on laptop, right ?
> >
> > Laptop(run packetdrill script) <--------------------------> Android device
> >
> > By the way, how can we test the Android device (DUT) from packetdrill which is running on Laptop?
> > I hope you understand that I am aksing this question because we are not familiar with the packetdrill.
> > Thanks.
> 
> packetdrill does not need to run on a physical DUT, it uses a software
> stack : TCP and tun device.
> 
> You have a kernel tree, compile it and run a VM, like virtme-ng
> 
> vng -bv
> 
> We use this to run kernel selftests in which we started adding
> packetdrill tests (in recent kernel tree)
> 
> ./tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-4pkt.pkt
> ./tools/testing/selftests/net/packetdrill/tcp_zerocopy_client.pkt
> ./tools/testing/selftests/net/packetdrill/tcp_zerocopy_batch.pkt
> ./tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-after-win-update.pkt
> ./tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-fq-ack-per-2pkt.pkt
> ./tools/testing/selftests/net/packetdrill/tcp_zerocopy_maxfrags.pkt
> ./tools/testing/selftests/net/packetdrill/tcp_inq_server.pkt
> ./tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_exclusive.pkt
> ./tools/testing/selftests/net/packetdrill/tcp_zerocopy_basic.pkt
> ./tools/testing/selftests/net/packetdrill/tcp_zerocopy_small.pkt
> ./tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-app-limited-9-packets-out.pkt
> ./tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-2pkt.pkt
> ./tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_oneshot.pkt
> ./tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-server.pkt
> ./tools/testing/selftests/net/packetdrill/tcp_inq_client.pkt
> ./tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_edge.pkt
> ./tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-app-limited.pkt
> ./tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-client.pkt
> ./tools/testing/selftests/net/packetdrill/tcp_zerocopy_closed.pkt
> ./tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-1pkt.pkt
> ./tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-after-idle.pkt
> ./tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-2pkt-send-5pkt.pkt
> ./tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-2pkt-send-6pkt.pkt
> ./tools/testing/selftests/net/packetdrill/tcp_md5_md5-only-on-client-ack.pkt
> ./tools/testing/selftests/net/netfilter/packetdrill/conntrack_synack_old.pkt
> ./tools/testing/selftests/net/netfilter/packetdrill/conntrack_syn_challenge_ack.pkt
> ./tools/testing/selftests/net/netfilter/packetdrill/conntrack_inexact_rst.pkt
> ./tools/testing/selftests/net/netfilter/packetdrill/conntrack_synack_reuse.pkt
> ./tools/testing/selftests/net/netfilter/packetdrill/conntrack_rst_invalid.pkt
> ./tools/testing/selftests/net/netfilter/packetdrill/conntrack_ack_loss_stall.pkt
> 

You mean we should run our kernel in a virtual machine environment instead of on a real device.
Actually, we don't have a virtual environment for the Android kernel.
Additionally, I'm not sure if a virtual environment for an Android device is available.
Anyway, we are going to reproduce this issue using our stability stress test.

Thanks.

------s1rSNMrXnBzddN1l0VjCdR-rsUXqO_rd2V3PEwJ04hej3fE3=_f98bb_
Content-Type: text/plain; charset="utf-8"


------s1rSNMrXnBzddN1l0VjCdR-rsUXqO_rd2V3PEwJ04hej3fE3=_f98bb_--


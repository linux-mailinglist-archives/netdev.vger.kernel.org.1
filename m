Return-Path: <netdev+bounces-159162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 968DDA1490F
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 06:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F273F3A98F4
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 05:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACCE1F7575;
	Fri, 17 Jan 2025 05:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HrmQyD27"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DC01F76DF
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 05:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737090304; cv=none; b=Y7kd/7eMZUsh+SilDoDF0qtPkqnXvT+cHng24YJV0SoxvLC4zDqwAw9U+xYGMFuIb75QNsexxaZ5A4O2roB10f2g8ozmbwRfMNdjxq6WF/64Fg7MumsAwxeK4bmj5i1FFVKRjPGIvP2Vw4O+5/Z8aJ26cSVFaj3lAH0H7rrYFYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737090304; c=relaxed/simple;
	bh=nA735ijctfPvXKw2MPMn/SYX2exiUysdHgw1pzxx+XM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=dQAeSKSs5ImFRanj49WFdDtPSLJ5H1zvsMRBXQTA18uVHwrG5oChEcJZNyCvMREvuXAcAKyv8lE002XBmt6lEzJDn/1l3kTooNi3t4WwAORT556WD8oGCWKWPYAMvsHli9Uoc+I7Bo0h3uprNA1tQOTgFLHRqf3sOZu1+o3hndA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HrmQyD27; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250117050454epoutp021e27c4ce21320e9acf3a54e8d5486fab~bYmtSVdt42472724727epoutp029
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 05:04:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250117050454epoutp021e27c4ce21320e9acf3a54e8d5486fab~bYmtSVdt42472724727epoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1737090294;
	bh=HIR8q2mF4sWDFC/z0m7EBIG9TEG9U8v6XXqg5Vmz6lg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HrmQyD27rjSNOaOLgKkbMXxMgY9E4+tpWsPbHbpgRzzmhg4SeN6M1ZU5suAoDY6x2
	 I7WptpYwzMnBW9U9xoXml3izhHajmBQGvuwIJUvTEXc1VRc16kuVfiyocyrDU1W3wU
	 yUuOLGgGHjmvcMsn6uxgzgdNejCuy2TivcSjE8JI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20250117050453epcas2p19e0105c16b75682998e44b6ad601120d~bYmswJlEj1001910019epcas2p1K;
	Fri, 17 Jan 2025 05:04:53 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.92]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4YZ72Y34JCz4x9Py; Fri, 17 Jan
	2025 05:04:53 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1A.C6.32010.5F4E9876; Fri, 17 Jan 2025 14:04:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20250117050452epcas2p3eec45f40766213150d849de55e6114ae~bYmr8_LIa0554805548epcas2p3K;
	Fri, 17 Jan 2025 05:04:52 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250117050452epsmtrp1a2ae4ba790b9c5def6285c50c89e2a31~bYmr8HJAu0799307993epsmtrp1Y;
	Fri, 17 Jan 2025 05:04:52 +0000 (GMT)
X-AuditID: b6c32a4d-abdff70000007d0a-5e-6789e4f58055
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	4D.E4.33707.4F4E9876; Fri, 17 Jan 2025 14:04:52 +0900 (KST)
Received: from perf (unknown [10.229.95.91]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250117050452epsmtip14a1c60a3330af1eccdb5ebd4a86aaec3~bYmrsfZzb2367423674epsmtip1J;
	Fri, 17 Jan 2025 05:04:52 +0000 (GMT)
Date: Fri, 17 Jan 2025 14:08:34 +0900
From: Youngmin Nam <youngmin.nam@samsung.com>
To: Neal Cardwell <ncardwell@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Youngmin Nam
	<youngmin.nam@samsung.com>, Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net, dsahern@kernel.org, pabeni@redhat.com,
	horms@kernel.org, guo88.liu@samsung.com, yiwang.cai@samsung.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	joonki.min@samsung.com, hajun.sung@samsung.com, d7271.choe@samsung.com,
	sw.ju@samsung.com, "Dujeong.lee" <dujeong.lee@samsung.com>
Subject: Re: [PATCH] tcp: check socket state before calling WARN_ON
Message-ID: <Z4nl0h1IZ5R/KDEc@perf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CADVnQykPo35mQ1y16WD3zppENCeOi+2Ea_2m-AjUQVPc9SXm4g@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmue7XJ53pBlNPi1pc2zuR3WLO+RYW
	i3W7Wpksni2YwWLx9NgjdovJUxgtmvZfYrZ41H+CzeLq7nfMFhe29bFaXN41h82i485eFotj
	C8Qsvp1+w2jR+vgzu8XH403sFosPfGJ3EPTYsvImk8eCTaUem1Z1snm833eVzaNvyypGj8+b
	5ALYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4BO
	V1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBfoFSfmFpfmpevlpZZYGRoYGJkC
	FSZkZxzbsZi9oImz4vWxXSwNjIfZuxg5OSQETCR6Pn9l62Lk4hAS2MMo0bPyDROE84lR4szk
	0yxwzqJnK+FaNp5ZCpXYySjx4sJLRgjnIaPEqiPzgDIcHCwCqhJ//geANLAJ6EpsO/GPEcQW
	EdCQuLvoAVg9s8AWZokHb74wgtQLCzhL/L1jC1LDK6As8Xf2dxYIW1Di5MwnYCM5BQIlZnak
	gbRKCOzhkLjcfokZ4iAXiR9tv1ghbGGJV8e3QB0qJfGyvw3KLpZouH+LGaK5hVHi1PUXUM3G
	ErOetYMdxyyQKTHx1yuwZRJARxy5xQIR5pPoOPyXHSLMK9HRJgTRqSbxa8oGRghbRmL34hVQ
	Ez0kbh0/wQ4JknksEicn/2CawCg3C8k7s5Bsg7B1JBbs/sQ2C2gFs4C0xPJ/HBCmpsT6XfoL
	GFlXMUqlFhTnpqcmGxUY6uallsMjOTk/dxMjODVr+e5gfL3+r94hRiYOxkOMEhzMSiK8ab87
	0oV4UxIrq1KL8uOLSnNSiw8xmgKjZyKzlGhyPjA75JXEG5pYGpiYmRmaG5kamCuJ81bvaEkX
	EkhPLEnNTk0tSC2C6WPi4JRqYGLMnyjGXc0rF7Fjz9lyf/t50m3f1QSyV/85O/3AJZF5B7n+
	qCxQyu5fplSQ/bH/w5Lop/2b+sQcZzGlJLY/nGV9R6VXkq28Le4ck/PyZ5+XOO85fiDzt89t
	7otb0o+u7NkyN/lqgTWLssDL+kqVhDUTYxaVzEiIetimc2BOhENE5bW/+7U2MrSekW5cKTLf
	W2bm9H1c+/fNbFtg76T98eHFxPIWPt/jSx04t5nwJ045sDr782JOx82FM+7vP2235d2c5hsq
	puedivNFv4faCISsW8b23PbhQe/NjxoMLl3wcFzoNumZbp3xP8+Qum0a5y5xPdn6xCf+5Hy5
	mzO4w+4/3HBmzyu+zwuzzp1/9bJTiaU4I9FQi7moOBEAWgYyIlYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWy7bCSnO6XJ53pBo8mGllc2zuR3WLO+RYW
	i3W7Wpksni2YwWLx9NgjdovJUxgtmvZfYrZ41H+CzeLq7nfMFhe29bFaXN41h82i485eFotj
	C8Qsvp1+w2jR+vgzu8XH403sFosPfGJ3EPTYsvImk8eCTaUem1Z1snm833eVzaNvyypGj8+b
	5ALYorhsUlJzMstSi/TtErgyfuz9zlqwn61i8ZY57A2MM1m7GDk5JARMJDaeWcoCYgsJbGeU
	+DLVEiIuI3F75WWoGmGJ+y1HgGwuoJr7jBKfX51k7mLk4GARUJX48z8ApIZNQFdi24l/jCC2
	iICGxN1FDxhB6pkFdjBLLG3dxwZSLyzgLPH3ji1IDa+AssTf2d9ZIGYuYJH4d3o6I0RCUOLk
	zCdgBzELaEnc+PeSCaSXWUBaYvk/DhCTUyBQYmZH2gRGgVlIGmYhaZiF0LCAkXkVo2hqQXFu
	em5ygaFecWJucWleul5yfu4mRnAcaQXtYFy2/q/eIUYmDsZDjBIczEoivGm/O9KFeFMSK6tS
	i/Lji0pzUosPMUpzsCiJ8yrndKYICaQnlqRmp6YWpBbBZJk4OKUamLb1Okh9uM903+G52Lnj
	J9PWlCyeVuKmGpkmH65d4yixuS7npNldGa3aDR7Xdm5ak1y0nvHKupZFK37OD30Ucu3t9z/b
	Tp80Xdl78mKwuQ23QAOzSvvPbafnHiy24D7w/Ma7sGMPLq/Lvjz1A6f5s2k7FG5v63lirD3/
	9IEVBzkNnvrVRqr9LQhZe/lwd/5ORp4S5cefPOoNztwWL1Bf+TbtQEjt/tRdm06bPCjXk4xu
	8jp+fetTf9FPr6IjK5QmTkibyWG4NK/G4ixjttWJ3RPu/lTZ8V540cvf1WtO1FVoKe+J63z1
	yUTC3M335bF5RrLKzCWJ28IaL77W2uLavuVx+pMVywR0ubPXS27dWXpCiaU4I9FQi7moOBEA
	TavUNxIDAAA=
X-CMS-MailID: 20250117050452epcas2p3eec45f40766213150d849de55e6114ae
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----6TxoHKXr_qkwT5q0XKHb2K6SEyMzWlX0etqXdnnbNHHFM6GI=_284afd_"
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
	<009e01db4620$f08f42e0$d1adc8a0$@samsung.com>
	<CADVnQykPo35mQ1y16WD3zppENCeOi+2Ea_2m-AjUQVPc9SXm4g@mail.gmail.com>

------6TxoHKXr_qkwT5q0XKHb2K6SEyMzWlX0etqXdnnbNHHFM6GI=_284afd_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

> Thanks for all the details! If the ramdump becomes available again at
> some point, would it be possible to pull out the following values as
> well:
> 
> tp->mss_cache
> inet_csk(sk)->icsk_pmtu_cookie
> inet_csk(sk)->icsk_ca_state
> 
> Thanks,
> neal
> 

Hi Neal. Happy new year.

We are currently trying to capture a tcpdump during the problem situation
to construct the Packetdrill script. However, this issue does not occur very often.

By the way, we have a full ramdump, so we can provide the information you requested.

tp->packets_out = 0
tp->sacked_out = 0
tp->lost_out = 4
tp->retrans_out = 1
tcp_is_sack(tp) = 1
tp->mss_cache = 1428
inet_csk(sk)->icsk_ca_state = 4
inet_csk(sk)->icsk_pmtu_cookie = 1500

If you need any specific information from the ramdump, please let me know.

Thanks.

------6TxoHKXr_qkwT5q0XKHb2K6SEyMzWlX0etqXdnnbNHHFM6GI=_284afd_
Content-Type: text/plain; charset="utf-8"


------6TxoHKXr_qkwT5q0XKHb2K6SEyMzWlX0etqXdnnbNHHFM6GI=_284afd_--


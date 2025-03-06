Return-Path: <netdev+bounces-172340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45758A54464
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 09:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 647027A21C1
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 08:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6500E1DF964;
	Thu,  6 Mar 2025 08:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TRRYU3YQ"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0DB1F3FF8
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 08:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741248843; cv=none; b=mIku3fj0XcXgmFyM6MoHruwmI422NKMjXCByjfrPC/MSrv7335Ypn2hNNmIaZnIW3PjUhJkmzoBlCn3UUrz6j5qGPHEdDWT45/2as4KtFb4l1X7rtl0cXzOh7WE4K5LqyM84q+C/+rVy3bzOi4JeZVL/7dCRWiWOc1tamZtpAJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741248843; c=relaxed/simple;
	bh=TkDcozBHBnKIV2auGGkHeHlQgJZ4HaUOFBQ63/NI+P8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=WT8lmouAOhYHgc6dEJaz+ZsGNlfsRy1V3ionQoFThXdknw1KweSM6XbzDXeIw7aKSiAF1+0Vu6lbQLRIXY/6V6EMulAOFfuEy6h1klFJh/mvsYTa/ZenO3WkQB+kWpZ4qxjexnkwg6xKansXm1zGl9HW0whpVXMciaDHVRHOLR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TRRYU3YQ; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250306081359epoutp042ffc271f9fd20520fe10ef2328f28c17~qKJgTilcs0792607926epoutp04O
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 08:13:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250306081359epoutp042ffc271f9fd20520fe10ef2328f28c17~qKJgTilcs0792607926epoutp04O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741248839;
	bh=GFNB3GQfHuZhgoLh28ySpFkcndevRW3IQZO7WqPJuLc=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=TRRYU3YQJPsGxLk2/M/mc9QNMWkBFVrclJD3t50D40EOYKrvT8TDLWlMOay0wXKA+
	 Cvn5BD+p9d/jW2OA35+xZx/jx9gzRV3uTqqcOy9l8Z9sarGrw6cZc2wn/Hp/BoKEdE
	 5v69T4r3M1hrNZNFg4nGR8JhCcKWe4n3pA6twuPg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250306081358epcas5p45839d254f72b81c22b1854bf49ddf2bd~qKJfudMFH3180531805epcas5p4j;
	Thu,  6 Mar 2025 08:13:58 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Z7hyY07Xjz4x9Q7; Thu,  6 Mar
	2025 08:13:57 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0A.75.19710.44959C76; Thu,  6 Mar 2025 17:13:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250306074425epcas5p20a08ef2dbd5705a1044fafb8c4a9ec15~qJvr5Zkdd1625216252epcas5p22;
	Thu,  6 Mar 2025 07:44:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250306074425epsmtrp13d2eb93faea97f50364276552d52caec~qJvr4VzDQ3019030190epsmtrp1-;
	Thu,  6 Mar 2025 07:44:25 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-fa-67c959443956
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	41.8E.18729.95259C76; Thu,  6 Mar 2025 16:44:25 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250306074422epsmtip18b4df393bbcbb9f3899d26f119ba0546~qJvpHt7NI2008120081epsmtip1a;
	Thu,  6 Mar 2025 07:44:22 +0000 (GMT)
From: "Swathi K S" <swathi.ks@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>, <krzk+dt@kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<conor+dt@kernel.org>, <richardcochran@gmail.com>,
	<mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>
Cc: <rmk+kernel@armlinux.org.uk>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<pankaj.dubey@samsung.com>, <ravi.patel@samsung.com>, <gost.dev@samsung.com>
In-Reply-To: <789ecb2f-dddc-491b-b9f8-5fb89058fd1b@kernel.org>
Subject: RE: [PATCH v8 1/2] dt-bindings: net: Add FSD EQoS device tree
 bindings
Date: Thu, 6 Mar 2025 13:14:13 +0530
Message-ID: <012701db8e6b$950550c0$bf0ff240$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQHcwqSBZNYxUrKMqce/4F1P5N/GfgGyT6S5AetEnA8CiHKSMrMyHirw
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1CTdRzH/T7bs2eQs0cE+cIdtKZk4oFbbOuBE5AkeiJJUq+7uro54Gns
	gG23jQg9L6ydCelwpl48oBArLYSIMWAT+REhNuRARBZw4oGAB04Owp1FKbXxQPHf6/v+vj/f
	z+f9/d6Xy/IrwIK5SpWe0qrk2QKOL7vxl+0vRyS+51AIz3ZKiMWZ84C4PGZDieqWXoQo6zOw
	ifLOXpSY6rqPEcPtdoSYoe9xiL6+nzDiVqMRJSwTTpQYuFrGIYqckyhx8VkNSnRVbCae3HwE
	iMoGN0aMz1/DiM6eaRZxu9iEEP9cs2G7A8gBZz+LtP4wjJBTxQ0YaadHMbLCkktaqgo5ZP23
	n5J222OEnGsd5JBGaxUgf24VkY8toanr38/alUnJMygtn1KlqzOUKkWs4K0Dsj0yiVQoihBF
	E68K+Cp5DhUrSNybGpGkzPZkFfA/lmfneqRUuU4n2Bm3S6vO1VP8TLVOHyugNBnZGrEmUifP
	0eWqFJEqSh8jEgpfkXiMh7IyF2+eA5pZ/JOm3yvRAnBqQxHw4UJcDB+Y/8CKgC/XD28G0Oly
	c5jFAoDdfzahzOIJgE/dNGe1pMjQvOJqAbD2af2KaxrAOkf7souDh8NKYyvmZX+8BYEPjqV6
	TSy8AoF1N8yId8MHj4MlxvPLvAl/B5Z13QVeZuNbofWrJraXeXg0vNM1jDK8ETpKJpd1Fr4D
	XvrGxWJG4sPFqUsoowfC64snPTrX0zgJTvSkeftC/LIPPOamUa8O8UT45UAUU7oJPrxhxRgO
	hjPFx1dYBq8YB9kMZ8LRv0wr6eNh+50ytvcYFr4d1l7dycgh8Fz3jwgzwQZ46u9JhNF50HZx
	lbfAZy7nypFBsPG7Oew0ENBrgtFrgtFrwtD/d6sA7CoQRGl0OQoqXaIRqai8/x48XZ1jActf
	ITzRBobKlyI7AMIFHQByWQJ/Xv/bDoUfL0Oef5jSqmXa3GxK1wEknts2sYID0tWev6TSy0Ti
	aKFYKpWKo6OkIkEg73O7QeGHK+R6KouiNJR2tQ7h+gQXICnJUXD8tnR+JN+fL90ygiydeS2O
	jhweS3jRlsi6sOCwTtVmWGOyjrr6267Ub3gj4GCb9jNh7Im8NoO9KbU5eDCiq/T5+UZrWK95
	Nr/v3f3K5+C8pRtoHoXVG6uFmPU6ht27NTA7ZXSOhP42ML3kyz9dfkb5kXTY5l6Ijy81xplF
	+WGLyTGmaWRo/cbAWV153lKoa3/Cm3OlLsmOD8a3YuLol3qG8l6XrQsK4R13m/d9P56C7TGf
	TJLtXafcd//h16FHqg0hh2t3d/psq+ksjD9R8mGaoeHIoRo/+tcDKWkJphatZcw0ykk+GzJx
	oXQz/2Be+hdL2+oK7Udldx359AsCti5TLgpnaXXyfwEUJ5spkwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec9l52w2PM3KVyOREZZGq3V9lZIssfOlC33ToFp6WNNNbWul
	flG8dJm5kspwaU3RldNIp+nmvKSZZVrTMm2rJDNLK1A0RAW7uCH47ff8/+/z4/nw0rhonPCn
	FYnnOHWiTCnmCYj6p+KAzdHHuuRbdU4vNDdeAND9z1YSVTW/xlCRI5tA9zpek2i08wuFnE9s
	GBo3DPGQw1FNod56PYksIwMkettYxEO6ga8kurvwkESdxjVopvsXQKWPf1NoeLKJQh09Yzh6
	cy0fQ3+brNS+1ezbgT6cratwYuzotccUazN8olijRctazFd4bG1ZOmuzTmPsRMs7HquvMwO2
	rUXKTlsCjq6IEeyJ45SK85x6S/gpwZm2NzYyuYZJGZx/SWSAPqEO8GnI7IC6bDtPBwS0iLED
	+HliEPMUfnAq6xbpYR9Y8ec75Xn0DcDnd2qJxYLHhMBSfYu7WMV0Y3D20h/3gDNmDNaXv3Sr
	RMwEgOYH8YvMZ8Jhob7AnfswR2DmUCG+yASzHtbdaHBbhUwo7O90kh5eCbsKv7pznNkE84Zz
	wBKbSn7invMC4dyoifTkvvDZ3NX/Of3/oig40nP6OvAxLDMZlpkMy0yGZdtGQJiBH5esUclV
	GmmyNJG7INHIVBptolwSm6SyAPdvCAm2ggbzpKQdYDRoB5DGxauEfYe75CJhnCw1jVMnnVRr
	lZymHaylCbGv0HcsL07EyGXnuASOS+bUSy1G8/0zsPQ1uxUHXxl6dilwVWp2eHTQiQfB0t1Y
	calr0tWtzGlsYsiRv67cgwHM2j4q9pA65fLT1hmN4sLs7Rc2emVQUGhW2PC2/qqZR/vvVy5Q
	Bfn2VJN8qCLzkry5Oubk1up3rbXes86Ujcpcr+OyAUfWhvxwW781bPhma+RURGRwrPG9qyej
	/XuT7KLJGJ1QY0zJL7fP4/HrJOSGwZ3jHzNnS8szH/7+4M2vcOiLVuT6pN0UyBsnjof1cr3p
	tPeTtobisqmo7cUuQUOgVhkNCyQfCVNSmLbqgJNfkxBin6Gn2iJS/Tuq05uJY5VlMA+NqUN1
	XiV7j0z/4J39NRrvEBOaMzJpCK7WyP4BMmZmenwDAAA=
X-CMS-MailID: 20250306074425epcas5p20a08ef2dbd5705a1044fafb8c4a9ec15
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250305091852epcas5p18a0853e85a5ed3d36d5d42ef89735ca6
References: <20250305091246.106626-1-swathi.ks@samsung.com>
	<CGME20250305091852epcas5p18a0853e85a5ed3d36d5d42ef89735ca6@epcas5p1.samsung.com>
	<20250305091246.106626-2-swathi.ks@samsung.com>
	<789ecb2f-dddc-491b-b9f8-5fb89058fd1b@kernel.org>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk=40kernel.org>
> Sent: 06 March 2025 12:45
> To: Swathi K S <swathi.ks=40samsung.com>; krzk+dt=40kernel.org;
> andrew+netdev=40lunn.ch; davem=40davemloft.net; edumazet=40google.com;
> kuba=40kernel.org; pabeni=40redhat.com; robh=40kernel.org;
> conor+dt=40kernel.org; richardcochran=40gmail.com;
> mcoquelin.stm32=40gmail.com; alexandre.torgue=40foss.st.com
> Cc: rmk+kernel=40armlinux.org.uk; netdev=40vger.kernel.org;
> devicetree=40vger.kernel.org; linux-stm32=40st-md-mailman.stormreply.com;
> linux-arm-kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org;
> pankaj.dubey=40samsung.com; ravi.patel=40samsung.com;
> gost.dev=40samsung.com
> Subject: Re: =5BPATCH v8 1/2=5D dt-bindings: net: Add FSD EQoS device tre=
e
> bindings
>=20
> On 05/03/2025 10:12, Swathi K S wrote:
> > Add FSD Ethernet compatible in Synopsys dt-bindings document. Add FSD
> > Ethernet YAML schema to enable the DT validation.
> >
> > Signed-off-by: Pankaj Dubey <pankaj.dubey=40samsung.com>
> > Signed-off-by: Ravi Patel <ravi.patel=40samsung.com>
> > Signed-off-by: Swathi K S <swathi.ks=40samsung.com>
> > ---
> >  .../devicetree/bindings/net/snps,dwmac.yaml   =7C   5 +-
> >  .../bindings/net/tesla,fsd-ethqos.yaml        =7C 118 ++++++++++++++++=
++
> >  2 files changed, 121 insertions(+), 2 deletions(-)  create mode
> > 100644 Documentation/devicetree/bindings/net/tesla,fsd-ethqos.yaml
> >
>=20
> I tried and did not see any differences, so point me exactly to any diffe=
rence
> in the binding (binding=21) which would justify dropping review?

Added the following in the example given in DT binding doc:

assigned-clocks =3D <&clock_peric PERIC_EQOS_PHYRXCLK_MUX>,
                                <&clock_peric PERIC_EQOS_PHYRXCLK>;
assigned-clock-parents =3D <&clock_peric PERIC_EQOS_PHYRXCLK>;

Given the significance of these changes, I assumed the changes need to be r=
eviewed again.
That was why the tag was removed. Please correct me if I am wrong and provi=
de your feedback on this patch.

- Swathi

>=20
> Best regards,
> Krzysztof



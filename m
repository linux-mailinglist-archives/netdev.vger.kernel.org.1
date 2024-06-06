Return-Path: <netdev+bounces-101342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA3C8FE307
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1531C25B33
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 09:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91650146A85;
	Thu,  6 Jun 2024 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NKwlZgvB"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609B513E41F
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666626; cv=none; b=pXudMPwPzE6dJolKINpcQ0lvqKZ7V4omMaqu9+7BZmieCo78049BDu4XhXSmcHSRfsu8w3z77GQ4Zlge441H/dA14JSzXIa2a2FNW1uOhc296BCW/X90uQY2I88b6sQqWlYzWEZenlVOvs+q44vERQ6edsB6zsHPAlzhzXpVEG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666626; c=relaxed/simple;
	bh=K8z9T8UHY/F4zlu5ZLtMTw1w5AVtuggANTviT2JXhO4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=cjeCPAf7h93uPhz039PtLM+H/VAYS4Ga+25A21xFq1ujJPcSEFk9s0OoXGmpNVxD7l1kpIpfznBALHmps5tAWzTa9Wucpkvp1kInqL16AF3D+ACcHeOnBZcWAx1nEPGGksfxRKVGibgNLVKSnpRFOwW9CNwZDbbFyM2Ljscxgzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NKwlZgvB; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240606093702epoutp01ef04ae21caf0f4a896cbb507ac1a9ed3~WYLFTPEHE3213432134epoutp01p
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 09:37:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240606093702epoutp01ef04ae21caf0f4a896cbb507ac1a9ed3~WYLFTPEHE3213432134epoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717666622;
	bh=0/gX1X+YcseBTe4RfPyzf6pKMLbCRhNqrkgBeWnCr4Y=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=NKwlZgvBfHG8M9nSqzVcu0D7js1EqhNSLElegYVE8VuoYv7rmgOhChh1i83t6S4YW
	 jW7Iv1mB2MDCBzN1+u19sDEdRlZxCR3M/JohwqsjpgGjEEHBBGrhIJSiheidRJkpMu
	 jAor+XovlQ9v+WoFuXFJC/NQj8lAPgzOsr+3i0qU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240606093702epcas5p10f5a47e829e7ffc60cd625433ea15158~WYLE1gc3Z2905129051epcas5p1G;
	Thu,  6 Jun 2024 09:37:02 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VvzkN1T9tz4x9Pr; Thu,  6 Jun
	2024 09:37:00 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3C.2B.08853.B3381666; Thu,  6 Jun 2024 18:37:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240606091539epcas5p1b1796b062efeba3e3d67e92767c6d3e1~WX4Z4s2dA1218912189epcas5p1f;
	Thu,  6 Jun 2024 09:15:39 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240606091539epsmtrp221863d369e3fbd4966d69ba2ad62a810~WX4Z3sZPb2889428894epsmtrp2T;
	Thu,  6 Jun 2024 09:15:39 +0000 (GMT)
X-AuditID: b6c32a44-d67ff70000002295-77-6661833b3ba6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6E.14.07412.A3E71666; Thu,  6 Jun 2024 18:15:38 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240606091535epsmtip2c9e019a86a21f706b0afae8a9973d38a~WX4W0iXFq2119021190epsmtip28;
	Thu,  6 Jun 2024 09:15:35 +0000 (GMT)
From: "Swathi K S" <swathi.ks@samsung.com>
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<richardcochran@gmail.com>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>,
	<alim.akhtar@samsung.com>, <linux-fsd@tesla.com>,
	<pankaj.dubey@samsung.com>, <ravi.patel@samsung.com>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, "'Jayati Sahu'"
	<jayati.sahu@samsung.com>
In-Reply-To: <323e6d03-f205-4078-a722-dd67c66e7805@lunn.ch>
Subject: RE: [PATCH v3 3/4] arm64: dts: fsd: Add Ethernet support for FSYS0
 Block of FSD SoC
Date: Thu, 6 Jun 2024 14:44:40 +0530
Message-ID: <000001dab7f2$18a499a0$49edcce0$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG0kE2cByMDcfrFjxkR49X5VWx9JAKuNFnTAVxbNBUCeh7WU7HHZ7Qw
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1BUVRzH59y7j7vMbG28POBo60VnAoeVhd3lYlCOMnYrVBqyZnRqucNe
	dwnY3dlHSvbQgBIUFBIiWhbiYUpK0wor8pI2oCBjoQRpAgSFAF0e4wpKCNPCXYr/Pr/v+f7O
	Od9z5oehnplcfyxRbaB1aioZ53iwrD8FvhAcmUYdCSn/ASEWJgsAMWy2cgj7oA0lLjd1IYTJ
	ns4iSlq72MRY+10u0dpZgRBDZdNsImdiBCW6rTlswnKvj02M3H+b+KPexCEK7c0IYV66wiba
	S32J+V8dgCirfcQlRmYbXe03J1Aio6mVu8uXrLn0J0KOna3lkteLBrlkqcVIWqoyOeRAXyOH
	vFrxCXm9zomQM829HDKnpgqQNTecgFz+tJhLOi2bY/mHkiJVNKWgdUJanaBRJKqVUfjrcfI9
	cqksRBwsjiDCcaGaSqGj8OiY2OC9icmu1LjwfSrZ6JJiKb0e3/FSpE5jNNBClUZviMJprSJZ
	K9GK9FSK3qhWitS0Yac4JCRU6jLGJ6myf7yBaB/yjk1+04ucACVYFuBhUCCB/W15aBbwwDwF
	DQD+Zv6byxQPAezvnucwxTyAZ39/xF1rsU1dZDMLTQC2X3K6WyYATHPWrLo4giBYltO8yt6C
	rdBcfB5ZYVQwzoJV1fgK8wQvwoI76SALYJiX4F14wRyzIrNc9s4eC7rCfEEEtPd0IAw/Bzu+
	GmUx2zwPr02ZUOZCQrgwdoHNHLUXmtoGOIxnA2xbOOP2NPCgpXMrw9EwzTLDYdgL3v+5xh3M
	Hzqnm9y6HH6X08tiWAUH/8l16y/Dllsm1sqVUUEg/L5+ByNvgvmd1e6Ez8DsxVGE0fmwzrzG
	AXDpQZ97Sz9orZzhngN40bpkReuSFa1LUPT/aaWAVQX8aK0+RUknSLViNX30v/9O0KRYwOpM
	BEXXgf6SZZENIBiwAYihuDd/v15+xJOvoFI/oHUauc6YTOttQOp67lzU3ydB4xoqtUEulkSE
	SGQymSQiTCbGN/AfZBQrPAVKykAn0bSW1q31IRjP/wQS0KMWxadeO+3InProal/jU4dUiKkK
	wp949VS+kRk3G/2sxEN0atk4MJff7XwrbEtt6JX+APZUV2zhxuKPW07xQqXp0Uunt3+5vCDx
	jcie1Oyr7yh1DKWmh9/OSLBsvnfmYK2I1YBZO/wydo/AMHo37y5nFtZ++1fFbOG2hr6J8ycP
	7Mvrv6zjH1aWlysPVPbG2HKDA+2jzv13hiq6FS1P4w2Yfrt31rHe6fFwu+mxx8lX436Z80Pf
	GX9T5jlc5fXh8eO3tm3Z9fnwaNZ85qzji9vmr30Wbz4JLytHqw9tOmpdzD4Y1LMzg/Ju+Oy9
	x684fMbzXjs8N34xlkT5+Rv3IHvDFDhLr6LEQahOT/0LLQd5jJwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsWy7bCSvK5VXWKawdbbJhY/X05jtHgwbxub
	xfm7h5gt1uw9x2Qx53wLi8X8I+dYLZ4ee8RuceTUEiaLe4vesVr0vXjIbHFhWx+rxabH11gt
	Hr4Kt7i8aw6bxYzz+5gs5v1dy2pxbIGYxbfTbxgtFm39wm7x8MMeoPYzL5gtWvceYXcQ89iy
	8iaTx9P+reweO2fdZfdYsKnUY9OqTjaPO9f2sHlsXlLvsXPHZyaP9/uusnn0bVnF6LFl/2dG
	j39Nc9k9Pm+SC+CN4rJJSc3JLEst0rdL4MroPbifqeATZ8XLhVeZGhjnc3QxcnJICJhIHHq7
	grWLkYtDSGA3o8SSBYdZIBKSEp+ap7JC2MISK/89ZwexhQSeMUosmpMJYrMJaEks6tsHFhcR
	UJGYN3cKE8ggZoHfLBL/v89jh5j6gVHi3a02ZpAqTgFriWn3WxhBbGGBGIme/01gNgtQ96mL
	m8BqeAUsJc5fPMkEYQtKnJz5BOgiDqCpehJtG8HKmQXkJba/ncMMcZyCxM+ny1ghjnCTmHP0
	DhtEjbjE0Z89zBMYhWchmTQLYdIsJJNmIelYwMiyilEytaA4Nz032bDAMC+1XK84Mbe4NC9d
	Lzk/dxMjOFVoaexgvDf/n94hRiYOxkOMEhzMSiK8fsXxaUK8KYmVValF+fFFpTmpxYcYpTlY
	lMR5DWfMThESSE8sSc1OTS1ILYLJMnFwSjUwNU7p2WFkvzxj3pW5D/JNRAScbi58Mle6bMLG
	OdrLWXSczm8wOHNZ37z1+Vfxj/vuy4pV/oyYEXX67uEVN5hZJLeZNWbtnSaW/TF4w4PFjNa5
	krfZvkxf/Ldx2sl7YW5bRZSXcsixPfL/szO1Um9hbfyG8mfKdn+nF3+RjptnPTFYsUSpI9nd
	6tnUeJW9YdI+BtueW4odfJFmbdH45lP37Oi9J7MWh3JGSVokiCdyHKg8H7x3uZ272RcH7wdf
	3R4va1/VZ53R2ilY51TzYeLM2EfHOn48Uvi7x4lpcpzQrE9yi17PrlNTsb+SvGTVwqT7pfM5
	jvBvD09t3PLygdqhs1nuUb9Lg1xunbZo8zlTqsRSnJFoqMVcVJwIAIzDl72EAwAA
X-CMS-MailID: 20240606091539epcas5p1b1796b062efeba3e3d67e92767c6d3e1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230814112617epcas5p1bc094e9cf29da5dd7d1706e3f509ac28
References: <20230814112539.70453-1-sriranjani.p@samsung.com>
	<CGME20230814112617epcas5p1bc094e9cf29da5dd7d1706e3f509ac28@epcas5p1.samsung.com>
	<20230814112539.70453-4-sriranjani.p@samsung.com>
	<323e6d03-f205-4078-a722-dd67c66e7805@lunn.ch>



> -----Original Message-----
> From: Andrew Lunn [mailto:andrew@lunn.ch]
> Sent: 15 August 2023 02:20
> To: Sriranjani P <sriranjani.p@samsung.com>
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> richardcochran@gmail.com; alexandre.torgue@foss.st.com;
> joabreu@synopsys.com; mcoquelin.stm32@gmail.com;
> alim.akhtar@samsung.com; linux-fsd@tesla.com;
> pankaj.dubey@samsung.com; swathi.ks@samsung.com;
> ravi.patel@samsung.com; netdev@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-samsung-
> soc@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Jayati Sahu
> <jayati.sahu@samsung.com>
> Subject: Re: [PATCH v3 3/4] arm64: dts: fsd: Add Ethernet support for
FSYS0
> Block of FSD SoC
> 
> > +&ethernet_0 {
> > +	status = "okay";
> > +
> > +	fixed-link {
> > +		speed = <1000>;
> > +		full-duplex;
> > +	};
> > +};
> 
> A fixed link on its own is pretty unusual. Normally it is combined with an
> Ethernet switch. What is the link peer here?

It is a direct connection to the Ethernet switch managed by an external
management unit.

> 
>      Andrew

Regards,
Swathi



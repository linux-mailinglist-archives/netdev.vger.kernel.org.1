Return-Path: <netdev+bounces-161468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A7DA21BE8
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 12:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD283A3892
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 11:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084191B87CC;
	Wed, 29 Jan 2025 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cbwRLcva"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F92D19DF60
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738149326; cv=none; b=kXqwtwh0SsIpAOzc9gqby2iiT8lpRsShpSsyCMHWASVfqZYUtAGZvUP7fMBo3IqaI13DGs0nSfKarSIBSswHNrqZDqv3ru0FzXZdnCgHKH9xEFnttfHyzmOscYwhENvaGdw4nmX2hBqaFLKyPxsU27W8XzknN2Qm/SjLc4tweK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738149326; c=relaxed/simple;
	bh=yV7QEmCBi6cLzgr71zomg3RgQJOJnAcFx9LRGTWFOT8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=s4XKbtFxMeLmzNPNmsez4sou/xcp7t7aZ/rSw+Oe0tJXLtQKIafgAhLRINIWLmQ7jL/YLyZgobBApL3Y3IKxSksvj514LkR99R65JWiS2ZgyvL0gIfUul55LyqCnaujJF+mrP2bs4TiYY/HCtwbZNkJY3mWGHD3ucg929V7jnxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cbwRLcva; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250129111521epoutp0465f350bd401d449416a5148518fccab1~fJZlCcQ4t1343413434epoutp04T
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 11:15:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250129111521epoutp0465f350bd401d449416a5148518fccab1~fJZlCcQ4t1343413434epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738149321;
	bh=Z9fllAJYUN6AmYP7n2l4q34f+Blz1Lv5y24Ho/5gbdU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=cbwRLcva/yLp7wSN1TZAoM5dwPTBTHkNdbHX0DQnUS1WKThHTsiR8NOrp2+XTHIjQ
	 PVv+suDDJNS+F1FX4WT27zaM/0tmk8JHm28eU93eqNaZS26HyvFqgAuT+2GNiPd8qY
	 cb8B9SuTo/nsG52Bwj8r74baGeOf5MQlz85uRZf4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250129111520epcas5p443f7775626d65b9f83bca31bc0e87b55~fJZkSPuBa0428904289epcas5p4x;
	Wed, 29 Jan 2025 11:15:20 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YjfhQ49S2z4x9Pr; Wed, 29 Jan
	2025 11:15:18 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B2.A6.19710.6CD0A976; Wed, 29 Jan 2025 20:15:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250129092103epcas5p138d9dfb58098b7acfe8e77f0d6bffe59~fH1yAHLuU1266012660epcas5p1H;
	Wed, 29 Jan 2025 09:21:03 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250129092103epsmtrp2ac876043b0b127adcc9eea9eac8d50f7~fH1x_7w3h0501805018epsmtrp2r;
	Wed, 29 Jan 2025 09:21:03 +0000 (GMT)
X-AuditID: b6c32a44-363dc70000004cfe-79-679a0dc68091
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	42.43.23488.FF2F9976; Wed, 29 Jan 2025 18:21:03 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250129092059epsmtip2d1fe8ddc7c96e182e3bec5dc88374132~fH1ufWQlF0959509595epsmtip2O;
	Wed, 29 Jan 2025 09:20:59 +0000 (GMT)
From: "Swathi K S" <swathi.ks@samsung.com>
To: "'Rob Herring'" <robh@kernel.org>
Cc: <krzk@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <conor+dt@kernel.org>,
	<richardcochran@gmail.com>, <mcoquelin.stm32@gmail.com>, <andrew@lunn.ch>,
	<alim.akhtar@samsung.com>, <linux-fsd@tesla.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>,
	<alexandre.torgue@foss.st.com>, <peppe.cavallaro@st.com>,
	<joabreu@synopsys.com>, <rcsekar@samsung.com>, <ssiddha@tesla.com>,
	<jayati.sahu@samsung.com>, <pankaj.dubey@samsung.com>,
	<ravi.patel@samsung.com>, <gost.dev@samsung.com>
In-Reply-To: <20250128154538.GA3539469-robh@kernel.org>
Subject: RE: [PATCH v5 1/4] dt-bindings: net: Add FSD EQoS device tree
 bindings
Date: Wed, 29 Jan 2025 14:50:57 +0530
Message-ID: <003001db722f$1d7e56d0$587b0470$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDx5RsunPn3lkU9PtjwM0wRa6rGBAHz93duAhzDMjcBqxsRNrTStT1Q
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1BUVRzHO/fuvXfRWeaGqEdA27ZyAgF3dYFDAQWR3QynpXKa0QhvcGch
	YHfbBxTlY4Cc4qWMSbjyDkgXAl1hY3lFiJDoAE3AgIU8AkHwwUiZgEi7LBT/feb3+37P9/x+
	Zw4fdyijnPjRCi2nVrCxInIdz3TZ1c2jTaCXi/OLXNDc7WyAhvNNJOoabMFRRWMnhnK7Unio
	oLWTQONtoxQaaDZjqLWjBEM3i+8RqKvrAoW6TZkEMv7ZR6CRqffRb3W5JMrpasJQat8YgfIX
	fyBQW+Em9PDaHYCKa/6i0NJ0DUAjMw0U0nfXEqj1+iSOlhpqKVQ8XEi86sxUnx/AmPETNRRj
	1g9STKFRxxgNX5PMpZKjjLl2FmPuN/WSTGa1ATA/N0mY8UeNOFP90yxgniTlUcyscZvM/kCM
	XxTHRnJqIaeIUEZGK+T+orfeDX8t3MtbLPGQ+CIfkVDBxnH+ouAQmcee6FjLSkTCeDZWZynJ
	WI1GtDPAT63UaTlhlFKj9RdxqshYlVTlqWHjNDqF3FPBaV+SiMW7vCzCQzFRQ6O/81SXtn06
	Y3I/BmZhKrDjQ1oKLx83k6lgHd+Brgcwf9AArA0H+gGAt0bcbY2HAM7lTOCrjjt16SuiRgDL
	0ymbaBLAU6e7SWuDpN1gcWYTZWVH+gWYpB/mWUU4fY2Aj3JOLbvtaB9Y1FxPWHkDHQoL+jOX
	zTyLoST7l2UW0L6wt3+GZ+On4dUzY8uM08/AH+/mrtxICOfGywhb2B7YkTtL2jSb4ZW5dNwa
	DOlRO1iWXsqzGYJhSVsJZuMNcKq9mrKxE5y910jaOByWZ/au6KPg4HzWSv0V2NyTa6nzLQGu
	sKpup628FZ7uqMRsufYwY2Fs5XgBrM1f5efg4nTfypFboKn0PnUSiPRrRtOvGU2/ZgT9/2mF
	gGcAWziVJk7ORXipJAou4b/3jlDGGcHyh3ELrgX9BU88WwDGBy0A8nGRoyCsM0fuIIhkP0vk
	1MpwtS6W07QAL8u+s3CnjRFKy49TaMMlUl+x1NvbW+q721si2ixINqfIHWg5q+ViOE7FqVd9
	GN/O6Rg2MjzPowfQmxcDhe9pbxw9BxLWy4qqbzrvqxxfr87+suNg8vHDJaPcvo1nE9OWEkYT
	Nx1YmGj1o64HsBWV0n++KPv18TdfZcXHJ5Xu4h2WiBt63Kuqfd5+Z6H9CBvXvj2w70Z66LnH
	BnrolhDslpmO2BtCcZfJDJcMj0DWuZ50DPjow5czzPtD8Db7oO8CMUL37Cem8jBCNSGVoFzZ
	H2datEVv3K5y/XZRJuV9kILt2G48KyDvus987j8liyVDY3rmq4LS8ob2Vlx1C3sxcfrj5zv3
	H7pwcGtQR9p5zV2jGfdIXhzlnzB8734yJG/mqeC/8+QiT/fX8z0v+kQ/uJKx120HJuJpoliJ
	G67WsP8C+lQY67kEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZdlhJXvf/p5npBj+38Vr8fDmN0eLBvG1s
	FufvHmK2WLP3HJPFnPMtLBbzj5xjtXh67BG7xc0DO5ksjpxawmRxb9E7Vovz5zewW1zY1sdq
	senxNVaLh6/CLS7vmsNmMeP8PiaLrmtPWC3m/V3LanFsgZjFt9NvGC0Wbf3CbvH/9VZGi4cf
	9rBbzLqwg9XiyJkXzBb/9+xgt1j0YAGrg7THlpU3mTye9m9l99g56y67x4JNpR6bVnWyeWxe
	Uu+xc8dnJo/3+66yefRtWcXocXCfocfTH3uZPbbs/8zo8a9pLrvH501yAXxRXDYpqTmZZalF
	+nYJXBn3H91mKdgsV/Fhm04D42eJLkZODgkBE4k3u3oYuxi5OIQEdjNKNK69xgaRkJT41DyV
	FcIWllj57zk7RNEzRomtF1pZQBJsAloSi/r2sYPYIgKqEk2zHrCAFDELvGSV6Lj5DKFj35n1
	YB2cAuYSCw/sBhsrLOAvMe3SQTCbBah7ybQTYKt5BSwlrt74wAJhC0qcnPkEyOYAmqon0baR
	ESTMLCAvsf3tHGaI6xQkfj5dxgpxhJvEqTmf2SBqxCWO/uxhnsAoPAvJpFkIk2YhmTQLSccC
	RpZVjJKpBcW56bnJhgWGeanlesWJucWleel6yfm5mxjBSUZLYwfju29N+ocYmTgYDzFKcDAr
	ifDGnpuRLsSbklhZlVqUH19UmpNafIhRmoNFSZx3pWFEupBAemJJanZqakFqEUyWiYNTqoHJ
	L39y0I6oPxcSNjm+tlvpW2f/5PO0JzeWiildWFkYGN4vff/wh+A3Ow3m5pzcsP7zdBbZlzyN
	hvm77Dt48hbN7E9XWGLP3y8oVvn20e+T05MV3Krsf+g87Sgu+/H79uyebyIaPErnj76dMOOu
	v5B6O0NVbOTFCYrrLJu5u3JKz7oI35z/nKVo0qTg0t371qn83Gi60jo+ofXDr8NC+mY2V0Wn
	63BPn26UYsRx7NJufsGGvwU8TkzKrsHfLhpPtb7tuVPr+r1nh0+u2i+YZNdS6nvjpIdS8d1V
	xxdJTOU53Gs1SSuT9aHzsypvUSku51sWVU9ef7Db024kscxAcap0/WXmXm2T7q9Hu1vrc+SV
	WIozEg21mIuKEwElC802oQMAAA==
X-CMS-MailID: 20250129092103epcas5p138d9dfb58098b7acfe8e77f0d6bffe59
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250128102725epcas5p44b02ac2980a3aeb0016ce9fdef011ecf
References: <20250128102558.22459-1-swathi.ks@samsung.com>
	<CGME20250128102725epcas5p44b02ac2980a3aeb0016ce9fdef011ecf@epcas5p4.samsung.com>
	<20250128102558.22459-2-swathi.ks@samsung.com>
	<20250128154538.GA3539469-robh@kernel.org>



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: 28 January 2025 21:16
> To: Swathi K S <swathi.ks@samsung.com>
> Cc: krzk@kernel.org; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; conor+dt@kernel.org;
> richardcochran@gmail.com; mcoquelin.stm32@gmail.com; andrew@lunn.ch;
> alim.akhtar@samsung.com; linux-fsd@tesla.com; netdev@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-stm32@st-
> md-mailman.stormreply.com; linux-arm-kernel@lists.infradead.org; linux-
> samsung-soc@vger.kernel.org; alexandre.torgue@foss.st.com;
> peppe.cavallaro@st.com; joabreu@synopsys.com; rcsekar@samsung.com;
> ssiddha@tesla.com; jayati.sahu@samsung.com;
> pankaj.dubey@samsung.com; ravi.patel@samsung.com;
> gost.dev@samsung.com
> Subject: Re: [PATCH v5 1/4] dt-bindings: net: Add FSD EQoS device tree
> bindings
> 
> On Tue, Jan 28, 2025 at 03:55:55PM +0530, Swathi K S wrote:
> > Add FSD Ethernet compatible in Synopsys dt-bindings document. Add FSD
> > Ethernet YAML schema to enable the DT validation.
> >
> > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
> > Signed-off-by: Swathi K S <swathi.ks@samsung.com>
> > ---
> >  .../devicetree/bindings/net/snps,dwmac.yaml   |  5 +-
> >  .../bindings/net/tesla,fsd-ethqos.yaml        | 91 +++++++++++++++++++
> >  2 files changed, 94 insertions(+), 2 deletions(-)  create mode 100644
> > Documentation/devicetree/bindings/net/tesla,fsd-ethqos.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > index 91e75eb3f329..2243bf48a0b7 100644
> > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > @@ -103,6 +103,7 @@ properties:
> >          - starfive,jh7100-dwmac
> >          - starfive,jh7110-dwmac
> >          - thead,th1520-gmac
> > +        - tesla,fsd-ethqos
> >
> >    reg:
> >      minItems: 1
> > @@ -126,7 +127,7 @@ properties:
> >
> >    clocks:
> >      minItems: 1
> > -    maxItems: 8
> > +    maxItems: 10
> >      additionalItems: true
> >      items:
> >        - description: GMAC main clock
> > @@ -138,7 +139,7 @@ properties:
> >
> >    clock-names:
> >      minItems: 1
> > -    maxItems: 8
> > +    maxItems: 10
> >      additionalItems: true
> >      contains:
> >        enum:
> > diff --git
> > a/Documentation/devicetree/bindings/net/tesla,fsd-ethqos.yaml
> > b/Documentation/devicetree/bindings/net/tesla,fsd-ethqos.yaml
> > new file mode 100644
> > index 000000000000..579a7bd1701d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/tesla,fsd-ethqos.yaml
> > @@ -0,0 +1,91 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause %YAML 1.2
> > +---
> > +$id:
> > +https://protect2.fireeye.com/v1/url?k=6d811f84-0c0a0abe-6d8094cb-
> 74fe
> > +4860008a-af9296512b2d412c&q=1&e=ccfde7ee-b20c-400e-ab77-
> 48df91b2df3c&
> > +u=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fnet%2Ftesla%2Cfsd-
> ethqos.ya
> > +ml%23
> > +$schema:
> > +https://protect2.fireeye.com/v1/url?k=82ab8361-e320965b-82aa082e-
> 74fe
> > +4860008a-8834d7e9197f59d4&q=1&e=ccfde7ee-b20c-400e-ab77-
> 48df91b2df3c&
> > +u=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
> > +
> > +title: FSD Ethernet Quality of Service
> > +
> > +maintainers:
> > +  - Swathi K S <swathi.ks@samsung.com>
> > +
> > +description:
> > +  Tesla ethernet devices based on dwmmac support Gigabit ethernet.
> > +
> > +allOf:
> > +  - $ref: snps,dwmac.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: tesla,fsd-ethqos.yaml
> 
> Humm...

Hi Rob, 
Could you help me understand if there is anything wrong here?

-Swathi



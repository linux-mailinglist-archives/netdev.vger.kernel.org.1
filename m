Return-Path: <netdev+bounces-161316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C07BAA20B08
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 14:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D143A5313
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 13:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BB81A38E4;
	Tue, 28 Jan 2025 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hcfWlujY"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4D04C92
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738070039; cv=none; b=Opt9LPKw7TphOi8ZOqUf3TmqzDZkZ27A2bpHKdBhGgwPYqTIINlyfnrGk+GnCwdGzjY8gJb4yu/bRuZYO/lTUmCSeVJKitBdxhWXT6Biy4e659ZStQFaNa5fqY+KOqN+VHk+YjqAR4it4PwFHckWVmC/FQRxzGJr3rVNo6E8odg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738070039; c=relaxed/simple;
	bh=FUf+1hdWQ8/Hw5FQA0NqZxjW9EABKlV9Yp3XBkjY99M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=d5td4GCYztziTFPD5FtJsbNmKsxeArXnv5gsh6bfQbbfoMNSx1s3JpxNTNqZ93H1xDRit/sTs9/cRUbJbZxx8hnxvBcessX5pr29+FH0XQN4MskuTKJIfLzsiM5AsQNfvU4U6f3Abkh4YkRJAgRSvFik9gEjBl43FfA2nGX8OpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hcfWlujY; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250128131349epoutp01c25bc11261afce73e9641206de0530f9~e3XvCdV9i2334423344epoutp01J
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 13:13:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250128131349epoutp01c25bc11261afce73e9641206de0530f9~e3XvCdV9i2334423344epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738070029;
	bh=rVoxDSn/mnfeIHuzjRNlI7IvBiNM2DlmF8PSTKMt7ss=;
	h=From:To:Cc:Subject:Date:References:From;
	b=hcfWlujYzJPha+yhGO/k3WdAvQ7q4vZpUZtLFoItl4Z0zoimhNMNJLh1aD1jZUkkQ
	 X/eTULmflMZJ+rmGRnAOKJRTgIrGz5b6mcTNEB1bmGY4YfF/iBcVpeOEkjmcQsrGop
	 fskfY7LyGat3QlRI9AHUTwjY3F15SGDNpmKBq1Y4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250128131348epcas5p3f646be962cec0bf0cb12bbe975aed698~e3XuAAw7p1168111681epcas5p3f;
	Tue, 28 Jan 2025 13:13:48 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Yj5Mb31t2z4x9Pt; Tue, 28 Jan
	2025 13:13:47 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F4.06.20052.B08D8976; Tue, 28 Jan 2025 22:13:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250128102707epcas5p154db286b06da942e18ffe315e4767707~e1GLMeRUr0919409194epcas5p1B;
	Tue, 28 Jan 2025 10:27:07 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250128102706epsmtrp1b0558ff1f199840ffe6e5733277efa27~e1GLLg74X0859008590epsmtrp1i;
	Tue, 28 Jan 2025 10:27:06 +0000 (GMT)
X-AuditID: b6c32a49-3d20270000004e54-8f-6798d80b9fad
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	7A.DC.33707.AF0B8976; Tue, 28 Jan 2025 19:27:06 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250128102703epsmtip1160dfc5bf2fe8cfa244a9aa043cf0775~e1GHjlYEJ1806518065epsmtip1n;
	Tue, 28 Jan 2025 10:27:02 +0000 (GMT)
From: Swathi K S <swathi.ks@samsung.com>
To: krzk@kernel.org, robh@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	conor+dt@kernel.org, richardcochran@gmail.com, mcoquelin.stm32@gmail.com,
	andrew@lunn.ch, alim.akhtar@samsung.com, linux-fsd@tesla.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	alexandre.torgue@foss.st.com, peppe.cavallaro@st.com, joabreu@synopsys.com,
	swathi.ks@samsung.com, rcsekar@samsung.com, ssiddha@tesla.com,
	jayati.sahu@samsung.com, pankaj.dubey@samsung.com, ravi.patel@samsung.com,
	gost.dev@samsung.com
Subject: [PATCH v5 0/4] net: stmmac: dwc-qos: Add FSD EQoS support
Date: Tue, 28 Jan 2025 15:55:54 +0530
Message-Id: <20250128102558.22459-1-swathi.ks@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0zbVRTHvb9fX5R0/sZwu2PySM0cI8KoK/VCQOck7DeRBV9oUNI18KMl
	QFv7AIUgyB4Cy8pQMQ0DBIYGGAgU6ErHozy2ZSivCAhqCbDieEwYg5gNxmrXlvnf55zzPfd7
	cu69LNztLsODlSRVUQqpKIXLYNP0fYcP+btOasWBW1p39Gjxe4BmyvUMNGzuxVF95xCGSofP
	0tAP/UN0NH9zjommTO0Y6h+oxtB01QodDQ83MdGIXkNHujsTdDS79BH6zVjKQNrhLgwVTFjo
	qHy7gY5uVuxF//5yD6Cqtg0msi63ATR7v4OJSkYMdNT/6wKOrB0GJqqaqaCjjeYp5rEXydba
	KYycL2xjku0lZiZZoVOTurp8BtlSnU22G9YxcrVrnEFqWusA2dPFI+cfduJka/c6IJ/kljHJ
	dZ1X9K7Y5FAJJUqgFD6UNF6WkCQVh3Ej3xe+JQwSBPL8ecHoNa6PVJRKhXHD34n2j0hKse2F
	65MmSlHbUtEipZJ75PVQhUytonwkMqUqjEvJE1LkfHmAUpSqVEvFAVJKFcILDHw1yCY8nSxZ
	vLxKlxvYnxf1DWI5wMQqAC4sSPBhieUnvACwWW7EdQC/3e5nOIIHAFqHntCfBZsTlfSdlnOF
	Vqaj0A7g6EqTs38DwIf5s+CpikH4wt9rrtlV7kQOBr/5Z9SuwoluHE5p5mlPVXuI43DwltHO
	NOIg3L78yM4cIgTeqB/AHH7e8GqTyd4MiTMu8KuFetxRCIdFjyeZDt4Dl261OtkDLhaed7IQ
	XtWM0xwsgebNIoaD34CmsVJbnmWb6DBsNB5xpD1h8cDPdl+c2AUvblmcM3CgoXyHX4LbyxPO
	I/dD/Y+rTisSll6x2tmNiIOP/1yjXQKeJf87VABQB/ZTcmWqmFIGyXlSKv3ZXcXLUnXA/uL9
	ThqAeeZ+QC/AWKAXQBbOdefEDWnFbpwE0RcZlEImVKhTKGUvCLLtrAj3eCFeZvsyUpWQxw8O
	5AsEAn7wUQGPu49zpv2s2I0Qi1RUMkXJKcVOH8Zy8cjBorzZEv7dFVoY2PfHWPMJk67lUlFn
	+LFT4TUF2/7ji3u7/efCXDMMsYMfpoekatk6o94lD0Zhh2bN+jVfTVxmQZbo6Me91lGeb3Eo
	bdXb6OW6QH1ZE/N35LlwXkRWmoHTknO94cDgtCy3s7Hs+RsLvuYV3Lf+dl4bwy+2+A7G/zS7
	40Dl7uzaB7vfvqLraTybm/lJsfH45thJyweNt6snO01+lhjhm+zqgYG/Wr9OvJY1kl+YIeg5
	32C92K9Z6omonH3X6+XTnsvqvL617MGtLmkFjHklsk5ruZAZl9hMq5tLC43PCY1pSi+rfS76
	s6hTQQdZ+femv/PxyL2QbtBlJr7HpSklIp4frlCK/gNcVkjpegQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJTvfXhhnpBn9fmVr8fDmN0eLBvG1s
	FufvHmK2WLP3HJPFnPMtLBbzj5xjtXh67BG7xc0DO5ksjpxawmRxb9E7Vovz5zewW1zY1sdq
	senxNVaLh6/CLS7vmsNmMeP8PiaLrmtPWC3m/V3LanFsgZjFt9NvGC0Wbf3CbvH/9VZGi4cf
	9rBbzLqwg9XiyJkXzBb/9+xgt1j0YAGrxZeNN9kdZDy2rLzJ5PG0fyu7x85Zd9k9Fmwq9di0
	qpPNY/OSeo+dOz4zebzfd5XNo2/LKkaPg/sMPZ7+2MvssWX/Z0aPf01z2T0+b5IL4IvisklJ
	zcksSy3St0vgyng5+z1rwQ6uiomHzzI1MB7g6GLk5JAQMJFo7f/P3sXIxSEksJ1R4lJ7ByNE
	QlLiU/NUVghbWGLlv+dQRZ8YJfaua2IDSbAJaEhcX7EdLCEiMIFJYv2n/UwgDrPARWaJ5lMf
	2UGqhAWcJM4e38UCYrMIqEr8nf0TzOYVsJI4uuYUE8QKeYnVGw4wT2DkWcDIsIpRNLWgODc9
	N7nAUK84Mbe4NC9dLzk/dxMjOMq0gnYwLlv/V+8QIxMH4yFGCQ5mJRHezptT0oV4UxIrq1KL
	8uOLSnNSiw8xSnOwKInzKud0pggJpCeWpGanphakFsFkmTg4pRqYhJTWNFiud7oeEcVX2W8a
	t3fFaefKVq07C9y3Hz2y/N7lEI9XsnIri57WWrpreMt+1BOyTnp8cOfxOwc3enj1Oj8ONU1Z
	Yvr2b+DOU53NVfPOhLxTeGWfNMvww8PZt/dWmkxgdi64ru2s/v1i9j2e6X+u3Uh4s1DmkZHW
	2uSzMRtv1ZpdeLn9hKe2kWzCpeRkvdPrv1nqqvc9k2b8WTyVZ4mz+OoZ3qElh7mNgx0Eo/3/
	GgqpH7nW9HCm4mK1Mz+3HNnqpbulPF3crt101uO9n/il9BvUXu2wtK+Yaf4sMvFmCnNa+P05
	DtL7luevzl7BFvNr2+kpK3sU0xd/mb3TJaeK6/RZrd/L1rI3CFVsVGIpzkg01GIuKk4EAHNY
	hBMhAwAA
X-CMS-MailID: 20250128102707epcas5p154db286b06da942e18ffe315e4767707
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250128102707epcas5p154db286b06da942e18ffe315e4767707
References: <CGME20250128102707epcas5p154db286b06da942e18ffe315e4767707@epcas5p1.samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

FSD platform has two instances of EQoS IP, one is in FSYS0 block and
another one is in PERIC block. This patch series add required DT binding,
DT file modifications and platform driver specific changes for the same.

Changes since v4:
1. Avoided switching between internal and external clocks for every open/
close.
2. Addressed the review comments on DT bindings

Here is the link to v4 patches for reference:
https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=&submitter=211782&state=&q=&archive=true&delegate=

Swathi K S (4):
  dt-bindings: net: Add FSD EQoS device tree bindings
  net: stmmac: dwc-qos: Add FSD EQoS support
  arm64: dts: fsd: Add Ethernet support for FSYS0 Block of FSD SoC
  arm64: dts: fsd: Add Ethernet support for PERIC Block of FSD SoC

 .../devicetree/bindings/net/snps,dwmac.yaml   |   5 +-
 .../bindings/net/tesla,fsd-ethqos.yaml        |  91 ++++++++++++++
 arch/arm64/boot/dts/tesla/fsd-evb.dts         |  18 +++
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi    | 112 ++++++++++++++++++
 arch/arm64/boot/dts/tesla/fsd.dtsi            |  47 ++++++++
 .../stmicro/stmmac/dwmac-dwc-qos-eth.c        |  74 ++++++++++++
 6 files changed, 345 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/tesla,fsd-ethqos.yaml

-- 
2.17.1



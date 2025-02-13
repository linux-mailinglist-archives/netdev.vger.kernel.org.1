Return-Path: <netdev+bounces-165820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C78CA33711
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 05:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B853A8685
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 04:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62722063F0;
	Thu, 13 Feb 2025 04:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="f4AGjI24"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD12F1FBE80
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 04:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739422564; cv=none; b=XCe0W2jzRF0adkFxHWi/aOThczh1YupM+0EbDQ8JGp8CvCETdHYm8Hm/cMWCbSz1bA9XL6U3AMgyBzSYrOnSS6SnspFHE/S+PiQgvhNtAlyt7lVcQ4UBpb2Gy01hIX3yMwd1woLv9MlI6SWHbaIOiag4nwNKiPgGX0vGt/VeP2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739422564; c=relaxed/simple;
	bh=8pkX9hqEXrpMa6BDEq/0XQ1iua4+qZyBfJvEDK0EGnA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=ZH7Mj5tesrAKY236TTSGn9hCG993E2O4VfWLCX3Rm0nTB2J5Yj7yD3wPYsZ6r8qlngCEZZ1kKkMTaI1XDQDL7SFPbryfPdRpy71Zh+56Lqqalxfl82fp5SPnceprt0ZSv+uzbjSWqUOoT3nuGkUjaBNf3MugrLBfS1fA9RVaDm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=f4AGjI24; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250213045600epoutp015d3430c36f5cf2f4ac010ce563747e8a~jq5pywl7D2001020010epoutp01o
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 04:56:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250213045600epoutp015d3430c36f5cf2f4ac010ce563747e8a~jq5pywl7D2001020010epoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739422560;
	bh=IvA31ZbD3Zexo4H7INEaKo7X7KJqCF/0qKrLl6D23Yg=;
	h=From:To:Cc:Subject:Date:References:From;
	b=f4AGjI24g6vfdhDWi9jNytRlvg8AfYxeoS5kPlyK/jYkQW1o20j858HDje/wkvqVf
	 risrbvZWPphe2BCx+lUaIYMf774w6sVp/PV/JqKsG77HMZmFKTJ2x35VJFGbTqVE6G
	 zoGgarrJIpJr8zdMbYntG3h7Fvh2vE8QU+ig5nwQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250213045600epcas5p4339919d365306e80caebf8739ab4304d~jq5pPueOt1374413744epcas5p4E;
	Thu, 13 Feb 2025 04:56:00 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4YtjYp75BXz4x9Px; Thu, 13 Feb
	2025 04:55:58 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1D.1B.19956.E5B7DA76; Thu, 13 Feb 2025 13:55:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250213044950epcas5p1a7badb480a7e8d843fe0ff51bcf5cbf4~jq0Q09LC_2465824658epcas5p11;
	Thu, 13 Feb 2025 04:49:50 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250213044950epsmtrp25ca5594c3b92929b4c65f819f26d33a5~jq0Qzfr1Y1364113641epsmtrp25;
	Thu, 13 Feb 2025 04:49:50 +0000 (GMT)
X-AuditID: b6c32a4b-fd1f170000004df4-1a-67ad7b5eff71
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	58.A0.33707.EE97DA76; Thu, 13 Feb 2025 13:49:50 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250213044947epsmtip24a8e5a1d81bad9d99d12448f2eda324e~jq0ODQcEX2154321543epsmtip2h;
	Thu, 13 Feb 2025 04:49:47 +0000 (GMT)
From: Swathi K S <swathi.ks@samsung.com>
To: krzk+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	conor+dt@kernel.org, richardcochran@gmail.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: rmk+kernel@armlinux.org.uk, swathi.ks@samsung.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] net: stmmac: dwc-qos: Add FSD EQoS support
Date: Thu, 13 Feb 2025 10:16:22 +0530
Message-Id: <20250213044624.37334-1-swathi.ks@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmpm5c9dp0gyvd5hY/X05jtFj+YAer
	xZq955gs5pxvYbGYf+Qcq8XTY4/YLW4e2Mlk8XLWPTaLC9v6WC02Pb7GanF51xw2i65rT1gt
	5v1dy2pxbIGYxbfTbxgtFm39wm7x8MMedosjZ14wW1zqn8hk8X/PDnaLLxtvsjuIely+dpHZ
	Y8vKm0weT/u3snvsnHWX3WPBplKPTas62Tw2L6n32LnjM5PH+31X2Tz6tqxi9Di4z9Dj8ya5
	AJ6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoF+V
	FMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnFpXnpenmpJVaGBgZGpkCF
	CdkZz56cZi74wFPRPH8hSwPjGa4uRk4OCQETic9/fzN3MXJxCAnsZpS43PyZDcL5xChxf+sb
	BGf+qQPMMC0Lb/5kgUjsBKqa+ZAVwvnCKLHm8gJWkCo2AQ2J6yu2s4MkRAR+MUp8mHQabAuz
	wF1GiU29d9lAqoQFnCRWLvwCNpdFQFXi+KkDLCA2r4CVxPmpH9kg9slLrN4As/sEh8SlidUQ
	tovE+Xkt7BC2sMSr41ugbCmJz+/2QvXGS6zuu8oCYWdI3P01ESpuL3HgyhygOAfQQZoS63fp
	Q4RlJaaeWscEYjML8En0/n7CBBHnldgxD8ZWlvj7+hrUSEmJbUvfQ631kPjadhzseSGBWImO
	iyeZJzDKzkLYsICRcRWjZGpBcW56arFpgXFeajk8qpLzczcxghOxlvcOxkcPPugdYmTiYDzE
	KMHBrCTCKzFtTboQb0piZVVqUX58UWlOavEhRlNgkE1klhJNzgfmgrySeEMTSwMTMzMzE0tj
	M0Mlcd7mnS3pQgLpiSWp2ampBalFMH1MHJxSDUzyYv4L5J4ssv6SrLjSvuOA991GhwnZF09r
	XrxdYfv2sqpLWSefcdH59JOibpVv9O4Ll6btWd+4ap9OzJ0bqXuyas5vUU3ji3b18Mttvly5
	R0r93Iwb77jbOsK/dXdFhn36//2bWGlUkEtg/eNl26wlDuTz8xS3J5/zlWKKOrc+5d5T9v0F
	O/vW7X9WmCb5/tbMTXpfhWPitx6dIeF36t9ZXqdjCSs+9vKXGiue6PRYUuOlrGamUFvyad7F
	I9Xz3Robvm7x6k/JmKe3sqXXM1NcuSX3QKtBeNMW0WWN99OSm07pfJirM9nv05+TsmfrVnW7
	H+wJa5c5fe3AIseA41z89x1U83la/63V/tDspcRSnJFoqMVcVJwIAMa1SHxNBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsWy7bCSvO67yrXpBv8WiVn8fDmN0WL5gx2s
	Fmv2nmOymHO+hcVi/pFzrBZPjz1it7h5YCeTxctZ99gsLmzrY7XY9Pgaq8XlXXPYLLquPWG1
	mPd3LavFsQViFt9Ov2G0WLT1C7vFww972C2OnHnBbHGpfyKTxf89O9gtvmy8ye4g6nH52kVm
	jy0rbzJ5PO3fyu6xc9Zddo8Fm0o9Nq3qZPPYvKTeY+eOz0we7/ddZfPo27KK0ePgPkOPz5vk
	AniiuGxSUnMyy1KL9O0SuDKePTnNXPCBp6J5/kKWBsYzXF2MnBwSAiYSC2/+ZOli5OIQEtjO
	KHH5/SImiISkxKfmqawQtrDEyn/P2UFsIYFPjBJ7n4aA2GwCGhLXV2xnB2kWEehgktgz9SQz
	iMMs8JhR4sGr/2wgVcICThIrF35hBrFZBFQljp86wAJi8wpYSZyf+pENYoO8xOoNB5gnMPIs
	YGRYxSiaWlCcm56bXGCoV5yYW1yal66XnJ+7iREcC1pBOxiXrf+rd4iRiYPxEKMEB7OSCK/E
	tDXpQrwpiZVVqUX58UWlOanFhxilOViUxHmVczpThATSE0tSs1NTC1KLYLJMHJxSDUxJxZUG
	U1/wB+42V2J7sW3/05VGen+Oe631P3H808I3KtaT1Vzq94otitG5t855y/3njOIHflw75z7j
	h5nIv0eL3l5e8M6Qr/bcueApiVorj+tIXJPW28XUOj9anGnn88OrunND7k/euWheW/huryuT
	xENL9sr62Bw64TRj+7ULW4p2M+SoVjZ8V1dy0d6pqW2/pMCsdU3JwWczTP6Hls6XZpzux1pc
	v3+Ke/u3SUrREhNX/b71uUJwktaK2ItJExp9xIyey0aw+tz+cuK5/gbRPSXWz5nnBnZs377b
	TbWU6VVZyQGD02nfriyI+ezm9UFda9bHFesuHssKffDY2e5o9s5tLYwFQsa6caecVC+nK7EU
	ZyQaajEXFScCAKiT7UT0AgAA
X-CMS-MailID: 20250213044950epcas5p1a7badb480a7e8d843fe0ff51bcf5cbf4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250213044950epcas5p1a7badb480a7e8d843fe0ff51bcf5cbf4
References: <CGME20250213044950epcas5p1a7badb480a7e8d843fe0ff51bcf5cbf4@epcas5p1.samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

FSD platform has two instances of EQoS IP, one is in FSYS0 block and
another one is in PERIC block. This patch series add required DT binding
and platform driver specific changes for the same.

Changes since v1:
1. Updated dwc_eqos_setup_rxclock() function as per the review comments
given by Andrew.

Changes since v2:
1. Addressed all the review comments suggested by Krzysztof with respect to
DT binding file.
2. Added SOB Swathi.

Changes since v3:
1. Avoided using alias-id to configure the HW.
2. Modified the clock implementation.

Changes since v4:
1. Avoided switching between internal and external clocks for every open/
close.
2. Addressed the review comments on DT bindings

Changes since v5:
1. Addressed the review comment on correcting the intendation.
2. Corrected the compatible name in dt-binding file.
3. Listed and described the clocks in dt-binding.
4. Modified FSD probe as per the changes in the refactoring patch given
below: https://lore.kernel.org/netdev/20250207121849.55815-1-swathi.ks@samsung.com/

Here is the link to v5 patches for reference:
https://lore.kernel.org/netdev/1cb63ff4-8926-4bbc-8a78-59103d167140@kernel.org/

Swathi K S (2):
  dt-bindings: net: Add FSD EQoS device tree bindings
  net: stmmac: dwc-qos: Add FSD EQoS support

 .../devicetree/bindings/net/snps,dwmac.yaml   |   5 +-
 .../bindings/net/tesla,fsd-ethqos.yaml        | 114 ++++++++++++++++++
 .../stmicro/stmmac/dwmac-dwc-qos-eth.c        |  28 +++++
 3 files changed, 145 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/tesla,fsd-ethqos.yaml

-- 
2.17.1



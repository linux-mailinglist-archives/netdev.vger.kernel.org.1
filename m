Return-Path: <netdev+bounces-168075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C921A3D44B
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 10:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A933A2CAB
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 09:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9221EC013;
	Thu, 20 Feb 2025 09:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LrBaGoGJ"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8F41C6FF0
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740042810; cv=none; b=fZyWbsDF10fKk6Psw5cP7XEnI49FyN2abJfhh+wKxXvM4h/t+HfwP7bcmk4tBRCZ8yS9MB5TcO8FpQnvAIttDg0UZnOHJlR+D6HE3gWTTOeFHVRZDAwCjQSsN1h5DFI1FnjRHVD6J5SIiiaMPnt+WmrG80vQhB2CraAUNOh1+Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740042810; c=relaxed/simple;
	bh=ThtpQUIG9uWpPcVRfm/ZAycUqWanNuaXn9Bh7BL5WPg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=ddfPax5bDLFjqZIzrDuU+AQB7dkyvPrI9PE8c8WCecgz3aHlRpM27gMSPaBSmd46p14UJOORjwoNJ98J11FMUSe4bshq0FyYuSQJ8XQhev+qZhSaZQ+JsCzxaCei/9sYsj6iA0MEzqKigfAiZszvxMMa+2gyNJo5z2fucLZxuWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LrBaGoGJ; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250220091325epoutp0444ca394155d0123e991a97dda9486c39~l37ZbGFwQ2042320423epoutp04L
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 09:13:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250220091325epoutp0444ca394155d0123e991a97dda9486c39~l37ZbGFwQ2042320423epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740042805;
	bh=4misLsGizIp8iJMKt8X2Vm5Ecs/n9mjZr4L2QsqFWXM=;
	h=From:To:Cc:Subject:Date:References:From;
	b=LrBaGoGJ7evwoCMSk8hi7DaVOCciwIbblIEXmfgZMt64lJjrAvB/P5HFtN0aL1YN+
	 +b3MJSE0VxUuYNjhxkm57BGNc/xXXbhk1a+M0NcJMkZf06CIoKmonS2602P1gXsNZV
	 AdODV6RAxDYieuKsqSLlSJGMHdGqmU+JUDUqyuXk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250220091324epcas5p42d6766705a53da738706cb26af96c3a0~l37YrWvpt1887418874epcas5p49;
	Thu, 20 Feb 2025 09:13:24 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Yz6xZ3VfQz4x9QH; Thu, 20 Feb
	2025 09:13:22 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	59.7F.19933.232F6B76; Thu, 20 Feb 2025 18:13:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250220073939epcas5p24b926b2dd3bcfda426b03309d8c29590~l2piTYbsi3085630856epcas5p2a;
	Thu, 20 Feb 2025 07:39:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250220073939epsmtrp1850a517d022c0d7bb0aff188bbf88784~l2piSa9JX2536525365epsmtrp1o;
	Thu, 20 Feb 2025 07:39:39 +0000 (GMT)
X-AuditID: b6c32a4a-b87c770000004ddd-f2-67b6f23262df
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D7.3E.18729.B3CD6B76; Thu, 20 Feb 2025 16:39:39 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250220073937epsmtip2cb6b4cac36a7a6ea08a4d6f3ab053e3d~l2pgGOnLT3266832668epsmtip2s;
	Thu, 20 Feb 2025 07:39:37 +0000 (GMT)
From: Swathi K S <swathi.ks@samsung.com>
To: krzk+dt@kernel.org, linux-fsd@tesla.com, robh@kernel.org,
	conor+dt@kernel.org, richardcochran@gmail.com, alim.akhtar@samsung.com
Cc: jayati.sahu@samsung.com, swathi.ks@samsung.com,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pankaj.dubey@samsung.com, ravi.patel@samsung.com,
	gost.dev@samsung.com
Subject: [PATCH v7 0/2] arm64: dts: fsd: Add Ethernet support for FSD SoC
Date: Thu, 20 Feb 2025 13:05:25 +0530
Message-Id: <20250220073527.22233-1-swathi.ks@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdlhTU9fo07Z0g2dnJSwezNvGZrFm7zkm
	i/lHzrFa3Dywk8niyKklTBYvZ91js9j0+BqrxcNX4RaXd81hs5hxfh+TxbEFYhaLtn5ht3j4
	YQ+7xZEzL5gt/u/ZwW7xZeNNdgcBj52z7rJ7bFrVyeaxeUm9R9+WVYwe/5rmsnt83iQXwBaV
	bZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdLWSQlli
	TilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITtj
	ybLz7AW9PBUnTn9kbWD8wNnFyMkhIWAi8al1J1sXIxeHkMBuRokbbY+hnE+MEkeP/oRyvjFK
	/L5/khWmZd6UBcwgtpDAXkaJVW8VIYq+MErM/tXPApJgE9CQuL5iOztIQkSgjVHi2NNGMIdZ
	YC6TxKqD24DmcnAIC3hK3FrLDdLAIqAqcWdqL9hUXgEriTWnfrJDbJOXWL3hADNIr4TAT3aJ
	3sV7WCASLhL3jn9ghrCFJV4d3wLVICXxsr8Nyo6XWN13Fao+Q+Lur4lsELa9xIErc1hAbmAW
	0JRYv0sfIiwrMfXUOiYQm1mAT6L39xMmiDivxI55MLayxN/X16BGSkpsW/qeHWSMhICHxMaL
	KpBAiZW4fOwv2wRG2VkICxYwMq5ilEwtKM5NTy02LTDKSy2HR1Ryfu4mRnBi1PLawfjwwQe9
	Q4xMHIyHGCU4mJVEeNvqt6QL8aYkVlalFuXHF5XmpBYfYjQFBtlEZinR5Hxgas4riTc0sTQw
	MTMzM7E0NjNUEudt3tmSLiSQnliSmp2aWpBaBNPHxMEp1cAUd8FWniUvb96WJYscSx7bs/Vv
	6DrINr3cW2hH6hrW42Uiz/J/3L0vyix+gvMCl0wLh1LgbqtpUnZm0403XbTlMwoWa5yzPpb3
	vMeDPZfevupYmjr5/gTvHXyrXpqXas80zN/CcLfn2f4WMaUze4r3MvtsljjPf63lnoJf3yKR
	mf8OhBYlneB+e3LyDG2erjQunoprFwW6rzls+deUvVhOZeWL4vkup0PXXX2dxvjC4Mq6C5pd
	7IqWUzkWP4/z1l55LbzgzY9kV4/Fh9/fm97AcM5xddSGr5I2obFv08zVznyctfrtASOZfXtP
	W025MjU/2aQ0aeemu5suObCnG0823eg9te2CaHi7Yp2kkeojJZbijERDLeai4kQARMCm1RUE
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPLMWRmVeSWpSXmKPExsWy7bCSvK71nW3pBq8P6Fk8mLeNzWLN3nNM
	FvOPnGO1uHlgJ5PFkVNLmCxezrrHZrHp8TVWi4evwi0u75rDZjHj/D4mi2MLxCwWbf3CbvHw
	wx52iyNnXjBb/N+zg93iy8ab7A4CHjtn3WX32LSqk81j85J6j74tqxg9/jXNZff4vEkugC2K
	yyYlNSezLLVI3y6BK2PJsvPsBb08FSdOf2RtYPzA2cXIySEhYCIxb8oC5i5GLg4hgd2MElcn
	rmKCSEhKfGqeygphC0us/PecHaLoE6PE4StXwYrYBDQkrq/YDpYQEehjlNiwvZUFxGEWWM4k
	seBAA2MXIweHsICnxK213CANLAKqEnem9jKD2LwCVhJrTv1kh9ggL7F6wwHmCYw8CxgZVjFK
	phYU56bnFhsWGOallusVJ+YWl+al6yXn525iBIepluYOxu2rPugdYmTiYDzEKMHBrCTC21a/
	JV2INyWxsiq1KD++qDQntfgQozQHi5I4r/iL3hQhgfTEktTs1NSC1CKYLBMHp1QDk8aMZ8Jy
	hvNFJpUmTY4Ls00pYXkplFK2c1VIZan1uqB7p6+e6tnLKRuQbDrruenOM9/lf0U4tSx9knr8
	otvLUpPjpxIDLulzvWvcG8x5Mnxr1N6a0DXn/3sW24me273mY+sxnzZbV3WTR6kBBgU3/7Ae
	U3Sb+FtJRVZzvl5jgkO59XsXtZLilCwnIyeJNm35G2f2yjnkGBx4WmN5qja/UveIYM71ra7T
	wmseR3h6Ze4/tzfxfu7XrOPq6VnPll5M3Re8w/2Vl4fhjQTeBf8ZQyOO6Txy5Cn2szRs/nvt
	Z4C38WTOs+azspRWaQus1X6/UaYjlJdxH6dE9rGdilV2N05KVux82x7WzvX+zHclluKMREMt
	5qLiRACs3C//wgIAAA==
X-CMS-MailID: 20250220073939epcas5p24b926b2dd3bcfda426b03309d8c29590
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250220073939epcas5p24b926b2dd3bcfda426b03309d8c29590
References: <CGME20250220073939epcas5p24b926b2dd3bcfda426b03309d8c29590@epcas5p2.samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

FSD platform has two instances of EQoS IP, one is in FSYS0 block and
another one is in PERIC block. This patch series add required DT file
modifications for the same.

Changes since v1:
1. Addressed the format related corrections.
2. Addressed the MAC address correction.

Changes since v2:
1. Corrected intendation issues.

Changes since v3:
1. Removed alias names of ethernet nodes

Changes since v4:
1. Added more details to the commit message as per review comment.

Changes since v5:
1. Avoided inserting node in the end and inserted it in between as per
address.
2. Changed the node label.
3. Separating DT patches from net patches and posting in different
branches.

Changes since v6:
1. Addressed Andrew's review comment and removed phy-mode from .dtsi to
.dts

Here is the link to v6 patches for reference:
https://lore.kernel.org/netdev/20250213132328.4405-1-swathi.ks@samsung.com/

This patch depends on the DT binding patch
https://lore.kernel.org/netdev/20250220043712.31966-2-swathi.ks@samsung.com/

And the driver patch
https://lore.kernel.org/netdev/20250220043712.31966-3-swathi.ks@samsung.com/

Swathi K S (2):
  arm64: dts: fsd: Add Ethernet support for FSYS0 Block of FSD SoC
  arm64: dts: fsd: Add Ethernet support for PERIC Block of FSD SoC

 arch/arm64/boot/dts/tesla/fsd-evb.dts      |  20 ++++
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 112 +++++++++++++++++++++
 arch/arm64/boot/dts/tesla/fsd.dtsi         |  47 +++++++++
 3 files changed, 179 insertions(+)

-- 
2.17.1



Return-Path: <netdev+bounces-166037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D05EBA34091
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 14:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6932B16A8D6
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 13:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BEA23A9A4;
	Thu, 13 Feb 2025 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Fu99oUMS"
X-Original-To: netdev@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5620723A980
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454200; cv=none; b=ewAtD7Kxp8jr3lGseopSSFkdpIyn6SaTdRYgwnwjmUspZOWs0tb0MhJCOwq5t/uHSD0fg8rJiCW5m0DHDk91dQdPj1hoTCF/etHcrJkoDyIuaS0Gn2SZhLtMXC9OgBl49NxpaPgJhwnazcZE99IAnbDC0P+wPg/ObxtF2OqF3jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454200; c=relaxed/simple;
	bh=fNjNmI5Rl5Y5oA9MbVoyWFB1Ivbf4aZs4eKe5ZtHeJI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=M39e1XpFZtvHXsPS/On48HeYMQQ3AvUmxAcSDqPGKiVN3d8o8agUhqJC3GEk/07itjY3htSW5SluA1Gw5rNER+ESiuceN0S2xEuUpY13NEEA7c5GQJQZglu6p9cilZGT75fJ7DXz/4Blw+5n7bFBl0v3m8XRA72TrYnjWgBMxPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Fu99oUMS; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250213134310epoutp03a7db18f64d75997d85517267db869b5a~jyF6-yNSF3185031850epoutp03g
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 13:43:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250213134310epoutp03a7db18f64d75997d85517267db869b5a~jyF6-yNSF3185031850epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739454190;
	bh=Cr1W+A1j9eKhEIpkh0PbU+eTR3PGjKL2Pnrw2rmrfgw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Fu99oUMSsPLDHN9WJPdT5aF+eIchVr0EHm8C4qVuhm3/UGEy3jE708CTGOU/ClYrk
	 64tgJ+gCsuZUz8KvfZCSQ2yM+pWxTvv9MVkIxI7eLX63NDq1+Gl0JSDHjXZ4RnnHhY
	 fs5TvWN30ceW2L44F7fruvf8q7f1vPx8SC/BsxW0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250213134309epcas5p3649909ccba39f7b333257285fc35e5d4~jyF6Ldf5d0812908129epcas5p30;
	Thu, 13 Feb 2025 13:43:09 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YtxG41MXTz4x9Ps; Thu, 13 Feb
	2025 13:43:08 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	81.08.19710.CE6FDA76; Thu, 13 Feb 2025 22:43:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250213132731epcas5p44671005103247c9c8d82de4dfc81097d~jx4Qvh9sJ0970909709epcas5p41;
	Thu, 13 Feb 2025 13:27:31 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250213132731epsmtrp2545a452aa4992565cdb85a3dd701ce37~jx4QtxdUW2782827828epsmtrp2d;
	Thu, 13 Feb 2025 13:27:31 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-de-67adf6ecae95
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	08.58.18949.343FDA76; Thu, 13 Feb 2025 22:27:31 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250213132729epsmtip1d130c10a8bb2ff3f0395988d728c1ff7~jx4OjkTTW0863808638epsmtip1-;
	Thu, 13 Feb 2025 13:27:29 +0000 (GMT)
From: Swathi K S <swathi.ks@samsung.com>
To: krzk+dt@kernel.org, linux-fsd@tesla.com, robh@kernel.org,
	conor+dt@kernel.org, richardcochran@gmail.com, alim.akhtar@samsung.com
Cc: jayati.sahu@samsung.com, swathi.ks@samsung.com,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 0/2] arm64: dts: fsd: Add Ethernet support for FSD SoC
Date: Thu, 13 Feb 2025 18:53:26 +0530
Message-Id: <20250213132328.4405-1-swathi.ks@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdlhTQ/fNt7XpBg+Ps1o8mLeNzWLN3nNM
	FvOPnGO1uHlgJ5PFkVNLmCxezrrHZrHp8TVWi4evwi0u75rDZjHj/D4mi2MLxCwWbf3CbvHw
	wx52iyNnXjBb/N+zg93iy8ab7A4CHjtn3WX32LSqk81j85J6j74tqxg9/jXNZff4vEkugC0q
	2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6GolhbLE
	nFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbG
	lu2TmQvWcldcP9jH1sC4hLOLkZNDQsBEYu+qryxdjFwcQgK7GSW+LvzJDOF8YpRonLeREcL5
	xihx99RNRpiWo3/eQlXtZZR4/34xO4TzhVHixsr5rCBVbAIaEtdXbAdLiAi0MUoce9oI5jAL
	XGaUWLrtFTNIlbCAp8Szvp1MIDaLgKrEiiVNYDavgKXEtN6XUPvkJVZvOAC2T0LgJ7tE05vl
	rBAJF4n7V3ayQNjCEq+Ob2GHsKUkPr/bywZhx0us7rsKVZMhcffXRKi4vcSBK3OA4hxAF2lK
	rN+lDxGWlZh6ah3YDcwCfBK9v58wQcR5JXbMg7GVJf6+vgY1UlJi29L3UGs9JHpXtjKCjBQS
	iJU4dEB4AqPsLIQFCxgZVzFKphYU56anJpsWGOallsOjKjk/dxMjODlquexgvDH/n94hRiYO
	xkOMEhzMSiK8EtPWpAvxpiRWVqUW5ccXleakFh9iNAUG2URmKdHkfGB6ziuJNzSxNDAxMzMz
	sTQ2M1QS523e2ZIuJJCeWJKanZpakFoE08fEwSnVwHSWLz7oyYOg8utLD/26LMzG1Sdl9eCC
	6OeOguN91rOnd71tnyZ2McTzflKa7ybnhf1t3t4Ppp04u+tji2hhvH9krsQJyR2Lwq1W7Gey
	1u2x+vxBpz7onuNmp2PLjhaZt3O/2vOiWDvtZH+Z6PzfArX9J6Rs5u4/PfP1n+MbZjxjUbp8
	t1+sbeqvxzp5HK/LAo+u4DZzPnh7KvtlnSNM2sXf+O93uuxznKZzZPWjzUKllyxSn/022t2b
	Fy+1r3h27ocPN5SXtfu+vrfg38xukaW+i+X9UqVP8p14NL2/f1lFpslx+cAAjVOHV5/8HVO+
	JF0w886GdxVz1Duz5xh/rOCwlvJfMomj0N4o8BWDxjslluKMREMt5qLiRAD6skt5FwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSnK7z57XpBu+mylk8mLeNzWLN3nNM
	FvOPnGO1uHlgJ5PFkVNLmCxezrrHZrHp8TVWi4evwi0u75rDZjHj/D4mi2MLxCwWbf3CbvHw
	wx52iyNnXjBb/N+zg93iy8ab7A4CHjtn3WX32LSqk81j85J6j74tqxg9/jXNZff4vEkugC2K
	yyYlNSezLLVI3y6BK2PL9snMBWu5K64f7GNrYFzC2cXIySEhYCJx9M9b5i5GLg4hgd2MEt1r
	XrNCJCQlPjVPhbKFJVb+e84OUfSJUeLrhsPsIAk2AQ2J6yu2gyVEBPoYJTZsb2UBcZgFbjJK
	fFv/mBmkSljAU+JZ304mEJtFQFVixZImMJtXwFJiWu9LRogV8hKrNxxgnsDIs4CRYRWjZGpB
	cW56brFhgVFearlecWJucWleul5yfu4mRnCgamntYNyz6oPeIUYmDsZDjBIczEoivBLT1qQL
	8aYkVlalFuXHF5XmpBYfYpTmYFES5/32ujdFSCA9sSQ1OzW1ILUIJsvEwSnVwLSZJ9aQg8U/
	oyxXe7qAe7f3fRUn35CMwIlfd016khJ5/vzEE5XbVT4q5b17eknXOOFaq7JAE//8TVIF+m93
	Pb67LO7/OvvEDXPWORu+OBq1Rfnr3HlNkuIdDpWSq0Qi8xIuB3rK5bnt1llTkFBjnpo78c6r
	PbvuTmFyWMbDOjd/0batbr1XorduKgyXfcG2K38G/z4lNWe5i9Pq4ldf/1Bqqc0dPbdks3VH
	wcsJu/o/BW2xfj1rsUyd7ry/6+19Z0qfPpxdLLQgqbgrfMl8yc0rY3ZIvHuSuX/Gj1pPEaGT
	93Jbj4vfUzv5/Vasxo1/K/l0Iu1PGm5g+KOQsuby9psdih79sTPXTT/LEcOX66rEUpyRaKjF
	XFScCAA/jEe1wwIAAA==
X-CMS-MailID: 20250213132731epcas5p44671005103247c9c8d82de4dfc81097d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250213132731epcas5p44671005103247c9c8d82de4dfc81097d
References: <CGME20250213132731epcas5p44671005103247c9c8d82de4dfc81097d@epcas5p4.samsung.com>
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

Here is the link to v5 patches for reference:
https://lore.kernel.org/netdev/1cb63ff4-8926-4bbc-8a78-59103d167140@kernel.org/

This patch depends on the DT binding patch
https://lore.kernel.org/netdev/20250213044624.37334-2-swathi.ks@samsung.com/

And the driver patch
https://lore.kernel.org/netdev/20250213044624.37334-3-swathi.ks@samsung.com/

Swathi K S (2):
  arm64: dts: fsd: Add Ethernet support for FSYS0 Block of FSD SoC
  arm64: dts: fsd: Add Ethernet support for PERIC Block of FSD SoC

 arch/arm64/boot/dts/tesla/fsd-evb.dts      |  18 ++++
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 112 +++++++++++++++++++++
 arch/arm64/boot/dts/tesla/fsd.dtsi         |  49 +++++++++
 3 files changed, 179 insertions(+)

-- 
2.17.1



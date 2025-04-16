Return-Path: <netdev+bounces-183256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8394FA8B7B1
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 13:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081303BEF8B
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B4423D2BA;
	Wed, 16 Apr 2025 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QxFpLY36"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50C31E5B7D
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 11:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744803004; cv=none; b=TT5nLBwYCWb0wuTTgg5DE5X93vHPj3gXqXgpadfEpWa6lr6r0z+9O5qTziWWpqkvWJHzvIUdwb4V06SpCEcWqBhQqDFyHqFD00KO/Wa3SsqIYEFPcr6rzH91+SX33h+Qi08Eyuo6zcxBw0KL4kptVUqYWAy+m4bzDRZbuyyADNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744803004; c=relaxed/simple;
	bh=OjGOcMClYqNlLex2fBnE6FzvSS+RJVTgH2eVGsrOqjo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=jMmBqeDo229eNGCGI1dPCqfVoeUZVI02lmB/+6/Q8eh38r/NU7iqnVFQqZmpgyeCMUo7dJu6PBChvSGfvl/Rz9LLlIXmOm798VKGUFWjKt5F7Xpdd9Hf234GTwCQq0sUekFPVNd38LWrJu4SVrPT8LUu20bJfxqI9P2xbDOsgaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=partner.samsung.com; spf=pass smtp.mailfrom=partner.samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QxFpLY36; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=partner.samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250416112958euoutp013ce620ed5497db35229f7b09d44524f8~2yRVKkIzP1212512125euoutp01e
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 11:29:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250416112958euoutp013ce620ed5497db35229f7b09d44524f8~2yRVKkIzP1212512125euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744802998;
	bh=+rfveBj9GE4cfZwlls5aVeex988AmgxoRWVksvLkYnY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=QxFpLY36CVkUv8XaBxwCZbsU2WwmCg4glbeVDTLsxxqu0g/nBSL8pw3kuMvcBP0FE
	 gjKt87kp/8oLjNeP7tzFZDfKw2EBW+XgK7Kh4EOQT4hp3z3wYOsVnqnu4gg/HvklKP
	 vjK52A0H3OOHHxPh0ZPZkCH1Ocghgc2HAWctkUs4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250416112957eucas1p2ce83ea39dd70f7e1c02c7c8472f821b6~2yRTxydEW0440004400eucas1p2v;
	Wed, 16 Apr 2025 11:29:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id E7.18.20821.5B49FF76; Wed, 16
	Apr 2025 12:29:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250416112956eucas1p1977ffda6af7fa81c3e46cadc93c30de3~2yRTOGMi61410114101eucas1p1s;
	Wed, 16 Apr 2025 11:29:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250416112956eusmtrp2cbd3c9539b11e9d2f8ab61ba62d284f5~2yRTNjBYb0434704347eusmtrp2S;
	Wed, 16 Apr 2025 11:29:56 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-44-67ff94b50700
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id F4.74.19654.4B49FF76; Wed, 16
	Apr 2025 12:29:56 +0100 (BST)
Received: from panorka.. (unknown [106.210.135.126]) by eusmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250416112955eusmtip230ef002cc48935b9994d9fe67c9d3190~2yRSSCajO0284402844eusmtip27;
	Wed, 16 Apr 2025 11:29:55 +0000 (GMT)
From: "e.kubanski" <e.kubanski@partner.samsung.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, "e.kubanski"
	<e.kubanski@partner.samsung.com>
Subject: [PATCH v2 bpf] xsk: Fix offset calculation in unaligned mode
Date: Wed, 16 Apr 2025 13:29:25 +0200
Message-Id: <20250416112925.7501-1-e.kubanski@partner.samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZduznOd2tU/6nGxxdLWax9f0qFosHs5cy
	W+xaN5PZ4vKuOWwWN48/Z7FYcegEu8WxBWIO7B47Z91l91i85yWTx6ZVnWweB9/tYfL4vEku
	gDWKyyYlNSezLLVI3y6BK2PJ8atMBZ/YK84/XcPYwHierYuRk0NCwETix45Z7F2MXBxCAisY
	JX7c6WGFcL4wSqzeeA/K+cwocW9nGzNMy+/LIO0gieWMEn1zpkE5Lxkl7hzdwQRSxSZgLNH0
	fT8LiC0iYCGxadE3sFHMArMYJZbs2QWU4OAQFnCVuPAxGaSGRUBVYt+/mUAb2Dl4BZwkdsVC
	7JKX2H/wLNheXgFBiZMzn4BNZAaKN2+dzQwyUUJgIYfE4m1zWCEaXCTuzbsD9ZuwxKvjW9gh
	bBmJ/zvnM0E0NDNKzJrZyQ7h9DBKrLl6hRHkHgkBa4m1J21BTGYBTYn1u/Qhoo4SW68VQ5h8
	EjfeCkKcwCcxadt0Zogwr0RHmxDEIh2JGxefQy2Vkvg+czMLhO0h8eXcZrBPhARiJaYcnMg6
	gVFhFpLHZiF5bBbCCQsYmVcxiqeWFuempxYb5qWW6xUn5haX5qXrJefnbmIEJpnT/45/2sE4
	99VHvUOMTByMhxglOJiVRHjPmf9LF+JNSaysSi3Kjy8qzUktPsQozcGiJM67aH9rupBAemJJ
	anZqakFqEUyWiYNTqoHJ0+PgnyV75Y24TgfnHPotxZVcL3NJ/n9rpYrUx8NfVBViK06lzdOO
	Uj/DrnWEp45n08VzByYmr/692GBJfPSvD84Fllqrn79+d3HbRX6tzU5ewbu2skyd26XWbvjt
	Wvxabe+Qap+1n7cFm343fs1UsdJW7lfiCtv5TAJPt9pLW2f7V2qmcBiss7TJMPxwdO+j5kj7
	GfHrlqzl2Ko2UUxv8bf2nRX7Cg/IRN/YfaaurSxfs6Vpi5yIvML+vNVaGtPvzvp4emtU+olf
	dgEsqi/szjz7k/nSbvvjHc23d6xI4nj/s3bJNvatR98rL5tR+Wmdg8+uLw4SnqHsfz9ONqt7
	6vI3/t+Gz64pD8KPPrH/p8RSnJFoqMVcVJwIACUrs+6hAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsVy+t/xe7pbpvxPN1gwQ9ti6/tVLBYPZi9l
	tti1biazxeVdc9gsbh5/zmKx4tAJdotjC8Qc2D12zrrL7rF4z0smj02rOtk8Dr7bw+TxeZNc
	AGuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsaS
	41eZCj6xV5x/uoaxgfE8WxcjJ4eEgInE78sgNheHkMBSRonLk14yQiSkJP6s+8MMYQtL/LnW
	BVX0nFHi7ssJTCAJNgFjiabv+1lAbBEBK4kHt/8xgxQxC8xjlJizaz1rFyMHh7CAq8SFj8kg
	NSwCqhL7/s0EqmHn4BVwktgVCzFeXmL/wbNgq3gFBCVOznwCNpEZKN68dTbzBEa+WUhSs5Ck
	FjAyrWIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAgM723Hfm7Zwbjy1Ue9Q4xMHIyHGCU4mJVE
	eM+Z/0sX4k1JrKxKLcqPLyrNSS0+xGgKdN1EZinR5HxghOWVxBuaGZgamphZGphamhkrifOy
	XTmfJiSQnliSmp2aWpBaBNPHxMEp1cDUI7nl08WZp2ZaZj1RTCmeOen993Kf7DcMCnHb1fPq
	0mVKQxfv3NEn8lmUr/jDViXhG/v/xE/4zdxyfNFjmy1Wcy54LJn6V1Gk/ovGFbaZq6IWrvj3
	dn9X4OzUXXHGnn8Fem/frBGxXqPbGHcyJaZ+3hKdRQ0BrcFsYouS/7wxUrD8p/Vy3zqhzTXy
	t36/YLJJ+apYExJi6DXLULaxbeOlxmsfdv2cLnSppP9R57Zlsv7POufcKjOzW9Pm/vHRWrn0
	S2GrdGbeSlP4IMJzZ46G9QvJG+KRXnt4F8cxsXMc3t4cKsxj0VHMUaZrN0HmvnuVT9tRJT0+
	lk9SkpaS19SqHxsf2lIc8u+1wbHL1wuVWIozEg21mIuKEwE9HsxB+AIAAA==
X-CMS-MailID: 20250416112956eucas1p1977ffda6af7fa81c3e46cadc93c30de3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250416112956eucas1p1977ffda6af7fa81c3e46cadc93c30de3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250416112956eucas1p1977ffda6af7fa81c3e46cadc93c30de3
References: <CGME20250416112956eucas1p1977ffda6af7fa81c3e46cadc93c30de3@eucas1p1.samsung.com>

Bring back previous offset calculation behaviour
in AF_XDP unaligned umem mode.

In unaligned mode, upper 16 bits should contain
data offset, lower 48 bits should contain
only specific chunk location without offset.

Remove pool->headroom duplication into 48bit address.

Signed-off-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
Fixes: bea14124bacb ("xsk: Get rid of xdp_buff_xsk::orig_addr")
---
 include/net/xsk_buff_pool.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index 7f0a75d6563d..b3699a848844 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -232,8 +232,8 @@ static inline u64 xp_get_handle(struct xdp_buff_xsk *xskb,
 		return orig_addr;
 
 	offset = xskb->xdp.data - xskb->xdp.data_hard_start;
-	orig_addr -= offset;
 	offset += pool->headroom;
+	orig_addr -= offset;
 	return orig_addr + (offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT);
 }
 
-- 
2.34.1



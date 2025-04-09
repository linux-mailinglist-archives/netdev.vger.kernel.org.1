Return-Path: <netdev+bounces-180764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B06A82629
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 15:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6210D7B1054
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 13:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38EF25F7AE;
	Wed,  9 Apr 2025 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WDoJkqId"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9B2262D27
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744204775; cv=none; b=AhAxSCGfwCW7OENMIMuYJh0RXZjmj87RULykvr416G3h6P7qtJfPXDINcjZFzNam87nIqaJdrclr6Ocu89E9TTkwKoUnFu6njKnS9n7h4X+EpLJj9MpxLRGCNmSLK8y+LGnLwSow4NZJ80wr6ifEfiu6VELOL8amG9lC+caIVv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744204775; c=relaxed/simple;
	bh=QnEbq81WG/G4uWQ0H7Xdkr/N+XKj9P55Wll6BVS07fE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=IbfdcMUPPF4PYeOdSm5Ljv9lny8J/sfGhGAsFvXNZLlp+Ksw3C5Tr59s7zGIKe9IjvworA27nQH638yQJ45HLF9imbJ1HebeAPxItpb2T0v2aVQjliuE/7EIn/t5WMO11VmQeuO1/9SBby/a0+tTId52oITKFuzkHaIgC8+H+Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=partner.samsung.com; spf=pass smtp.mailfrom=partner.samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WDoJkqId; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=partner.samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250409131930euoutp027b796b9eff2053db3e55906484b16add~0qP90pUvK2542825428euoutp02s
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 13:19:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250409131930euoutp027b796b9eff2053db3e55906484b16add~0qP90pUvK2542825428euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744204770;
	bh=ajQR5ZKkUJJOfFz3DoIefpGG3D1hZOJkRQa0pPm8NGo=;
	h=From:To:Cc:Subject:Date:References:From;
	b=WDoJkqIdeW2rHSX7wPM5CfkOwQoriEzGKLW3Uw7g0IZizpvKOo+bbyNtKaWa0AGaa
	 A1S08+tcUthHK5L26fGCz3wijy2TQE7A2I/7ovpsO8/gPL/pYsCrEyXw18vMqbnqHQ
	 seVrUVG6mqFiQafE8lxpR5WTjNpkvW3T3nWSg738=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250409131930eucas1p132940cb320ad36d80b90584e8937ac09~0qP9Y_IKW2055320553eucas1p1-;
	Wed,  9 Apr 2025 13:19:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 11.D1.20821.2E376F76; Wed,  9
	Apr 2025 14:19:30 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250409131930eucas1p22b304bf5924a9b3bc43a442d738ebef3~0qP9FOWp70469704697eucas1p2C;
	Wed,  9 Apr 2025 13:19:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250409131930eusmtrp2e2199d72fa0da5ec446bf2fe886b0e1a~0qP9ET3_l3273432734eusmtrp23;
	Wed,  9 Apr 2025 13:19:30 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-4f-67f673e27c40
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id B2.42.19654.1E376F76; Wed,  9
	Apr 2025 14:19:29 +0100 (BST)
Received: from localhost.localdomain (unknown [106.210.135.126]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250409131929eusmtip20dcfc89f65c7cecb613cd2851acda8f5~0qP8qCftP1305413054eusmtip2K;
	Wed,  9 Apr 2025 13:19:29 +0000 (GMT)
From: "e.kubanski" <e.kubanski@partner.samsung.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, "e.kubanski"
	<e.kubanski@partner.samsung.com>
Subject: [PATCH] xsk: Fix offset calculation in unaligned mode
Date: Wed,  9 Apr 2025 15:19:13 +0200
Message-Id: <20250409131913.65179-1-e.kubanski@partner.samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se1BMcRSe3727d68dy20znEJYj5k8Nq/hei2GYVuNjEFEo5Vr7Wi35l4V
	6zENabQTmm2mtNpph4yUFZu22iIteshbek4TjaLIK/JKabsM/33nfN93XnNIXHpC6E1q9XsZ
	Vq8OlxFigaP8+4MZrVyPZma/ZTid/z5bQD8/cx6nnZfTcPqpM52gGypeCegsV6WILreOXCZS
	FpmbRcpzJR2Y0p6dQCjL3pVgym67zzphsHjxTiZcG82wfopQ8e4b6Z+wSJto3wvTvFh0kjAi
	kgRqLnS/DzaiIaSUykJga1hqROIB/BlB/JN0IR90I0h5XUu4VW5DU4mF4IkLCK73Nor44AuC
	hDdtyK0iqDlw5GupwI1HUDTYz/YMlsIpM4LMEucg4Ukp4N3Pb7gbC6jJYD3VgrlnklAroO82
	y3cbB6Vl9wclEsoDqtJeDlrxgfzR/DO4uyZQFhLKTXUYb1gJTb15OI89obPimojHY6C/KAPj
	DUcRmNMSRHyQiODSsxrEX2MR2KqWuCFO+UKu04/3LgdXwXUhrxgG9V0e/AzDwORIxfm0BI7H
	S3n1dKh//OpPV2/4mpYn4CVKuBL359IhYEqNJZLQePN/i5n/W8z8bwQrwrPRKCaK02kYbpae
	iZFzah0XpdfIwyJ0djTwMdV9FZ8KkaXzo9yFMBK5EJC4bIQkSd+jkUp2qvcbGDZiOxsVznAu
	NJoUyEZJzpYe00gpjXovs4dhIhn2L4uRQ7xjsS2JffJJARZrkNeyLqyxJa/QIJMFeK0oSGnX
	ud545PYGbZjfmdQQE9psUcRUiVM3hIw9OGHa5tMK46GKk5OTw0z5K33uLdTObrT8KI7uCAFI
	McqL1+6gH5Wt8u5/S1yc7Zi4acrqZ9G0sMn3xoHHhhOVB2riZa8dkV3t/rK8y4GEKieYsj+M
	62gLPfIy43BH99CNlXMKFhg3X9jO5oTNZ7b6Vy+5WXvLOTFFV3x1bOSa44Wqu9rCO9uCVs3I
	rPt4WhuXjGfoE23irG1+vqJf9RdzamdGBPg71t/StLFUK3c/MMGmUsUWbVRM37VnU5A1hOLa
	q1WK3reGBR8MSk1/zVKZgNutnjUVZzn1b7JcnwmgAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsVy+t/xe7oPi7+lG8ybbG6x9f0qFosHs5cy
	W+xaN5PZ4vKuOWwWN48/Z7FYcegEu8WxBWIO7B47Z91l91i85yWTx6ZVnWweB9/tYfL4vEku
	gDVKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2Pf
	nE9MBWvZKx5OMmtg7GPrYuTkkBAwkbi9Zy6QzcUhJLCUUeL2oYVMEAkpiT/r/jBD2MISf651
	QRV9ZpTYefk8WIJNwFii6ft+FhBbRMBK4sHtf8wgRcwC8xgl5uxazwqSEBawk3j3+wdYA4uA
	qsSC/vtAGzg4eAWcJf4dKYJYIC+x/+BZsBJeAUGJkzOfgM1kBoo3b53NPIGRbxaS1CwkqQWM
	TKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECA3zbsZ9bdjCufPVR7xAjEwfjIUYJDmYlEd4J
	ed/ShXhTEiurUovy44tKc1KLDzGaAp03kVlKNDkfGGN5JfGGZgamhiZmlgamlmbGSuK8bFfO
	pwkJpCeWpGanphakFsH0MXFwSjUwFd9a6LXdVOzIgp+uTKpx0W+3SfBN36Ax/2Sz4TwJFUeu
	Z5ke2zdueZCpenJ61Rtn+c/1hcvdamw0zwk0PmC9rKSweMPf9K0c528387r8cv8iPadzRg2n
	yOtHx+PKTi079+n3A/vTuaIng7baZKY75b1uXtrF/Uj6paJCtOG3rCumMlMOaVy+sXBhxGrO
	GlGeUi/JBRvZn7sV2KyVvSg069KFiNuPJe9XSMkZ5rx0ZVPTPOek/+25mkHJmvfVdu0mnU+4
	7098serFuhfzGY4U3vO05Hhs0qB91lyEu/5K7AEWhcRLd9ie9N3vNLy+a196y8oOtd3+mpe2
	771yuHtO4PdYTV+umLCr/ec/b+F2VmIpzkg01GIuKk4EALRlnqn5AgAA
X-CMS-MailID: 20250409131930eucas1p22b304bf5924a9b3bc43a442d738ebef3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250409131930eucas1p22b304bf5924a9b3bc43a442d738ebef3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250409131930eucas1p22b304bf5924a9b3bc43a442d738ebef3
References: <CGME20250409131930eucas1p22b304bf5924a9b3bc43a442d738ebef3@eucas1p2.samsung.com>

Offset calculation in unaligned mode didn't
match previous behaviour.

Unaligned mode should pass offset only in
upper 16 bits, lower 48 bits should pass
only specific chunk location in umem.

pool->headroom was duplicated into offset
and address of the umem chunk.

Signed-off-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
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



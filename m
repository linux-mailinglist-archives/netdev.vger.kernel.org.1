Return-Path: <netdev+bounces-195650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95571AD19A2
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 10:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8C3188A942
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 08:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D06E2820C8;
	Mon,  9 Jun 2025 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="V+hMvXor"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BBE28134A
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749456703; cv=none; b=M6LqH8xE/dywjPDAs+Od+EiutxgEo0cZmr2DckVePUlQAylKF3fS5YxVlxRCkHDbjAQgsbtXlMgowjxQobMcGPAYcKnA77X9D0L8pFZr8Y3pt0Ff5rbUTpwF8vSW7E67VkJhL551b/qbHYa2Lz07+fyXRngXOz137kMZ02xbHOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749456703; c=relaxed/simple;
	bh=Ky/TxtCfTe0l1Pac0CgEqfbI0HTvBXlStE1ol0qmIEs=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=RBfQHJ4ad+iVvkYU4/WbCucGe2pCj5YoOw5kd7vpttNyuVc61SjIBJDP/9EOvp0T/IqjauMP2+SboXSqBMmD8GDyvk9o/4Sesr3QspNP56K7Hzyy6IocmgMVBMwo9s/8aW1jBsq4DB3V2CiYwotZ6kFmphtsCPpmj353wzdduXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=V+hMvXor; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250609081138epoutp011a97eb9b9a3d4354607bd02a86267bb4~HUZkfLpop2094220942epoutp01w
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 08:11:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250609081138epoutp011a97eb9b9a3d4354607bd02a86267bb4~HUZkfLpop2094220942epoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749456698;
	bh=cCKDTqb+uAHktuv4ggRzrPoN/1B3zoVL46D/W98jRPs=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=V+hMvXortCjz7/ycaM+ANIn3tvVjKG5syDeDrRzVdJpMospVaW3o2WZueE8JXJ7sq
	 f6mPhixwNFzfwKMmu85rw/xAHYp8OUVPOFFk5Hvb40QdRTLjdwC7BGsMBqHEf1Ptwm
	 KiPvilaSl+xr1PqF90uyQj7F/oBj++PulZ4u3iLU=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250609081137epcas5p158d45542b2752659b3c1c338c9cf0ed7~HUZj61i0M2901329013epcas5p1g;
	Mon,  9 Jun 2025 08:11:37 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.183]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bG4Pz5pMSz2SSKj; Mon,  9 Jun
	2025 08:11:35 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250609081134epcas5p1c89e67af7350711fac95686a82981f74~HUZhNrfn72723027230epcas5p1g;
	Mon,  9 Jun 2025 08:11:34 +0000 (GMT)
Received: from INBRO002756 (unknown [107.122.3.168]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250609081132epsmtip18db79fbd3b3f0d3e4080c9fdb9642fec~HUZezQJp_1346413464epsmtip1L;
	Mon,  9 Jun 2025 08:11:32 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Raghav Sharma'" <raghav.s@samsung.com>, <krzk@kernel.org>,
	<s.nawrocki@samsung.com>, <cw00.choi@samsung.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
	<conor+dt@kernel.org>, <richardcochran@gmail.com>,
	<sunyeal.hong@samsung.com>, <shin.son@samsung.com>
Cc: <linux-samsung-soc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<chandan.vn@samsung.com>, <karthik.sun@samsung.com>,
	<dev.tailor@samsung.com>
In-Reply-To: <20250529112640.1646740-4-raghav.s@samsung.com>
Subject: RE: [PATCH v3 3/4] clk: samsung: exynosautov920: add block hsi2
 clock support
Date: Mon, 9 Jun 2025 13:41:30 +0530
Message-ID: <043f01dbd916$1d8decf0$58a9c6d0$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIRyuXPQglR2pg1tLiplohNF2WAzQKeHRX1Aq1ypKGzZDlhYA==
Content-Language: en-us
X-CMS-MailID: 20250609081134epcas5p1c89e67af7350711fac95686a82981f74
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250529111715epcas5p19a63894e2556d2c8005845e01f67c783
References: <20250529112640.1646740-1-raghav.s@samsung.com>
	<CGME20250529111715epcas5p19a63894e2556d2c8005845e01f67c783@epcas5p1.samsung.com>
	<20250529112640.1646740-4-raghav.s@samsung.com>

HI Raghav

> -----Original Message-----
> From: Raghav Sharma <raghav.s@samsung.com>
> Sent: Thursday, May 29, 2025 4:57 PM
> To: krzk@kernel.org; s.nawrocki@samsung.com; cw00.choi@samsung.com;
> alim.akhtar@samsung.com; mturquette@baylibre.com; sboyd@kernel.org;
> robh@kernel.org; conor+dt@kernel.org; richardcochran@gmail.com;
> sunyeal.hong@samsung.com; shin.son@samsung.com
> Cc: linux-samsung-soc@vger.kernel.org; linux-clk@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; netdev@vger.kernel.org;
> chandan.vn@samsung.com; karthik.sun@samsung.com;
> dev.tailor@samsung.com; Raghav Sharma <raghav.s@samsung.com>
> Subject: [PATCH v3 3/4] clk: samsung: exynosautov920: add block hsi2 clock
> support
> 
> Register compatible and cmu_info data to support clocks.
> CMU_HSI2, this provides clocks for HSI2 block
> 
> Signed-off-by: Raghav Sharma <raghav.s@samsung.com>
> ---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>



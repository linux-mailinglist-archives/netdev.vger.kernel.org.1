Return-Path: <netdev+bounces-213555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CA7B25989
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 04:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADC467B81FC
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 02:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF9419F11E;
	Thu, 14 Aug 2025 02:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bnSyl4Qa"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780EC7260B
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 02:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755139012; cv=none; b=q5QlqtUgny+IhJF5TOGM1TFXLwrdG52wC5nfQeTVq/E80paVKFdEJj8O8VSEiQ310sYPeAqCeugB3nW0ck520U7iAWNgO3M2mcgnP6qcmWApnPgNXr48L97ubU/rhy9n9NvQyENzha5V5gpRhluTlNuRF3HLf1MPfFbuBu0WzPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755139012; c=relaxed/simple;
	bh=ZUKjgyy0btOB0JEvG/0aTzv8AXdnUlUTp8QHtmFnrh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=HWIgSTV01yyX+cBRAWdpxfdOtqc0VfD8R2BmcOdUG1cDwLgFY24YezELLKFmXCO10EwdPSkeqB5gzU/HN0qM6zJz5Gq+XevNdMqIfTBCP5atma07OffqDLmtMnv9+2P/dfPpsSvqtK8Gk78zGvH9xJAURkg1BBDvodeDp4C/9jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bnSyl4Qa; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250814023648epoutp0225efa2c288dcd5aa545d6f970d46cced~bgaD4FBnh1966819668epoutp02o
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 02:36:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250814023648epoutp0225efa2c288dcd5aa545d6f970d46cced~bgaD4FBnh1966819668epoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755139008;
	bh=44C6bRh5qYy8AvG4h59yKMY2QM+osiZPYVbTKoGgO1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bnSyl4Qa/Y76HjejSdeSYBIe4L4fSvARz1y8n8E7hPXWemNczkWITFanmz8fSGxgu
	 2H8VE5Ydyf6v/SLGvhA3eSwkID9KKZQXgoyiOXl2cmp9m5PtYqL5+3zXeW0weIHrhi
	 BJ7LtgnvTcZgDf5BuorAk34+3WNtAIlO6VTF9uhU=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250814023647epcas5p4df13272ea95eaa15c0573df6d09bb9fd~bgaC_jSqy0260502605epcas5p4m;
	Thu, 14 Aug 2025 02:36:47 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.92]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4c2TsB1D4Rz2SSKf; Thu, 14 Aug
	2025 02:36:46 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250814023554epcas5p4b3dcab50835e2da4749be1be135def20~bgZR_ftYe2756427564epcas5p4K;
	Thu, 14 Aug 2025 02:35:54 +0000 (GMT)
Received: from asg29.. (unknown [109.105.129.29]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250814023552epsmtip1d326f6f872887b30b03960a9a0fb04b2~bgZQVvLG62143121431epsmtip1n;
	Thu, 14 Aug 2025 02:35:52 +0000 (GMT)
From: Junnan Wu <junnan01.wu@samsung.com>
To: kuba@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	eperezma@redhat.com, jasowang@redhat.com, junnan01.wu@samsung.com,
	lei19.wang@samsung.com, linux-kernel@vger.kernel.org, mst@redhat.com,
	netdev@vger.kernel.org, pabeni@redhat.com, q1.huang@samsung.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	ying123.xu@samsung.com
Subject: Re: [PATCH net] virtio_net: adjust the execution order of function
 `virtnet_close` during freeze
Date: Thu, 14 Aug 2025 10:36:07 +0800
Message-Id: <20250814023607.3888932-1-junnan01.wu@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813172307.7d5603e0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250814023554epcas5p4b3dcab50835e2da4749be1be135def20
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250814023554epcas5p4b3dcab50835e2da4749be1be135def20
References: <20250813172307.7d5603e0@kernel.org>
	<CGME20250814023554epcas5p4b3dcab50835e2da4749be1be135def20@epcas5p4.samsung.com>

On Wed, 13 Aug 2025 17:23:07 -0700 Jakub Kicinski wrote:
> Sounds like a fix people may want to backport. Could you repost with 
> an appropriate Fixes tag added, pointing to the earliest commit where
> the problem can be observed?

This issue is caused by commit "7b0411ef4aa69c9256d6a2c289d0a2b320414633"
After this patch, during `virtnet_poll`, function `virtnet_poll_cleantx`
will be invoked, which will wakeup tx queue and clear queue state.
If you agree with it, I will repost with this Fixes tag later.

Fixes: 7b0411ef4aa6 ("virtio-net: clean tx descriptors from rx napi")


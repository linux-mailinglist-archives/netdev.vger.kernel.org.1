Return-Path: <netdev+bounces-74308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DA7860D65
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 09:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1802E1F27460
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 08:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E83199D9;
	Fri, 23 Feb 2024 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bhnERPkH"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355C11B59B
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 08:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708678781; cv=none; b=PvuQQRjVs4HZLC6yYi6jhvioYZxjj65c+m948nEfbRPq28F9oxVIPODSGgpJYYINPEqUwXGKxQnz9jzmHKE4y4bheALKEQ70r+lxFX2ccKAg+ldL5InptJsjdltIN2lE0diKC336p0DPNUi8lMok4iixel3xjdRlYTTgegjY9Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708678781; c=relaxed/simple;
	bh=CzQMf8Gq0ii1lU59Iu2BizEPKglHNnOKkLlG+2JJaso=;
	h=Date:Message-Id:From:Subject:To:Cc; b=ZMeLp0rPR69W+UMau7a8KmmZ+ND1qd2mEX66Mnah/etlzeB1SGSyqPpaQyYg2CS1nwR4DV+qJUThgqVh4WmGOdgMLdGAXr8+ZF4dTD4QzOWw38MZFbP0Wz7FCLbFAIuoWIy8LiKXptycwVOhy9DxVY+PWCvtQ1pQtv4ger7hYAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bhnERPkH; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708678775; h=Date:Message-Id:From:Subject:To;
	bh=tlqFKYpC2xXGenKd9+fUy+UwCV30gOPxtbk4zQpwblI=;
	b=bhnERPkHYVN/Ye+X7sBvlazxRJu13BESttBQVuYqwMRLdhDx/FHG/808e2A8qQ75Mydb00y0mXZ33av3W4DnGXHPjW5tASx2ZsRyE72V4Yo4E9KsuLGMu/3+bRSVtuXfiJaTchZpu7gUWX81XtCu8HF40cpo9D6HhN0kNqSW16o=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W13nqMq_1708678774;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W13nqMq_1708678774)
          by smtp.aliyun-inc.com;
          Fri, 23 Feb 2024 16:59:35 +0800
Date: Fri, 23 Feb 2024 16:49:35 +0800
Message-Id: <1708678175.1740165-3-xuanzhuo@linux.alibaba.com>
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: virtio-net + BQL
To: Dave Taht <dave.taht@gmail.com>
Cc: "Jason Wang" <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
    hengqi@linux.alibaba.com, netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Hi Dave,

We study the BQL recently.

For virtio-net, the skb orphan mode is the problem for the BQL. But now, we have
netdim, maybe it is time for a change. @Heng is working for the netdim.

But the performance number from https://lwn.net/Articles/469652/ has not appeal
to me.

The below number is good, but that just work when the nic is busy.

	No BQL, tso on: 3000-3200K bytes in queue: 36 tps
	BQL, tso on: 156-194K bytes in queue, 535 tps

Or I miss something.

Thanks.



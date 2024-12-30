Return-Path: <netdev+bounces-154540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0739FE6C1
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 15:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5742A162342
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 14:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F571A706F;
	Mon, 30 Dec 2024 14:01:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9B325949D;
	Mon, 30 Dec 2024 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735567306; cv=none; b=jlQ0UzCoQVo4o7DCBLsZbuiKivbXsUx5NRXv5BTn2prxiq6BOKEHOdAAfBhxyesxQrQmCG2hCREgOtwaRFr/Uyy2uGhy4cx9Z8p5XiIvmhv+oSDEdZ1zH+8Q+MICpSJqwrhFN0oH0RJ+Vjt/Alk23J9umAT+LjKaFlJ6XenNuFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735567306; c=relaxed/simple;
	bh=2wjbcROzUkVGBKDreBSvfrBSwNiFQBswFijQbp4DKb8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQHqeQoBcZUT9MKmtccjtmX0SkrZ1rpBx9zZnwuDEyp2jDIycH4DPG7M6INJl7gRcRGagaScse49Cn7KkDsnwfBnhoep5CVfZpGqULTQJIVs4b8WF6vTY7a1rK0uTkK7aN9TrYwL4skgG78T3Z3o42wyBCTfsQRYDpFkNrSJImU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YMHnM17h1z6K6Xt;
	Mon, 30 Dec 2024 22:00:55 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 71105140155;
	Mon, 30 Dec 2024 22:01:34 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 30 Dec
 2024 15:01:23 +0100
From: Gur Stavi <gur.stavi@huawei.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <cai.huoqing@linux.dev>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <gongfan1@huawei.com>,
	<guoxin09@huawei.com>, <gur.stavi@huawei.com>, <helgaas@kernel.org>,
	<horms@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <meny.yossefi@huawei.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <shenchenyang1@hisilicon.com>,
	<shijing34@huawei.com>, <wulike1@huawei.com>, <zhoushuai28@huawei.com>
Subject: Re: [PATCH net-next v01 1/1] hinic3: module initialization and tx/rx logic
Date: Mon, 30 Dec 2024 16:14:35 +0200
Message-ID: <20241230141435.2817079-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241227103134.21168df3@kernel.org>
References: <20241227103134.21168df3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 frapeml500005.china.huawei.com (7.182.85.13)

> > > I understand. But I'm concerned about the self-assured tone of the
> > > "it's not supported" message, that's very corporate verbiage. Annotating
> > > endian is standard practice of writing upstream drivers. It makes me
> > > doubt if you have any developers with upstream experience on your team
> > > if you don't know that. That and the fact that Huawei usually tops
> > > the list of net-negative review contributors in netdev.
> >
> > The most popular combination in the last 3 decades was little endian
> > CPUs with big endian device interfaces. Endianity conversion was a
> > necessity and therefore endian annotation became standard practice.
> > But it was never symmetric, conversion to/from BE was more common than
> > conversion to/from LE.
> >
> > As the pendulum moved from horizontal market to vertical market and major
> > companies started to develop both hw and sw, the hw engineers transformed
> > proprietary parts of the interface to little endian to save extra work in
> > the sw. AWS did it. Azure did it. Huawei did it. These vertical companies
> > do not care about endianity of CPUs they do not use.
> > This is not "corporate verbiage" this is a real market shift.
>
> Don't misquote me. You did it in your previous reply, now you're doing
> it again.
>
> If you don't understand what I'm saying you can ask for clarifications.
>

We studied previous submissions and followed their example.
Were the maintainers wrong to approve Amazon and Microsoft drivers?

I don't understand what the problem is. Please clarify.

> > The necessity for endian conversion is gone (or just halved). Will the
> > standard practice remain? There is not a single __le annotation in Amazon
> > and Microsoft code. Not in Mellanox code either. Maybe their hw is fully
> > BE (have to wonder about their DPUs). Amazingly, Intel that only creates
> > little endian CPUs has lots of __le annotations. But they are the flag
> > barer of horizontal market.
> >
> > Interesting how both Amazon and Microsoft started with:
> > depends on X86
> > Thus evaded demand for adding __le annotations to the code.
> > Later, both sneaked in quiet small patches with replacement to:
> > depends on !CPU_BIG_ENDIAN
> > Maybe that is the true meaning of "upstream experience".



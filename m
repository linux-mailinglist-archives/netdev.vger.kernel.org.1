Return-Path: <netdev+bounces-169745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49290A45806
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 09:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3132C161BCC
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 08:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1364C1A2C0B;
	Wed, 26 Feb 2025 08:24:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A6E46426;
	Wed, 26 Feb 2025 08:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558262; cv=none; b=Nzvlhm80mhRtdZcLgz9Dasfcl+Boiy5jfjIREcHZJYKEn9sDNt4wytPGTyyhKyMIZjU4NFKNjvoCUKvJjLj/ZUNyFQZ6wiPhH/Kb8tdQP9hEhJDwo1l+NBp0k1Q9GmORAm53F0kru69pA1eIcwDMjdjQD6hjzbPW5Sc1mbvUL9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558262; c=relaxed/simple;
	bh=c8H8rdd6EqpekwRsXzHBZUQjED7TQMef11mcwfcOceY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1hlEQmY934uIrH3U+al8B+8CidU75aPczeMK+QGKfOoGsLiK3yPKZJwZGEODBuG74AKksl/ppHV3L0LMvSsml7GNXYexVP1nstLVtbN2gyShrZ98RrS33PmDY3NkjQZV7SHZN1epoBw162PPEISmCo8cXXaA2fWzQGYiuwg7JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z2nWw6kHNz6K94s;
	Wed, 26 Feb 2025 16:22:20 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 0BDBB14097D;
	Wed, 26 Feb 2025 16:24:16 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 26 Feb
 2025 09:24:04 +0100
From: Gur Stavi <gur.stavi@huawei.com>
To: <jdamato@fastly.com>
CC: <andrew+netdev@lunn.ch>, <cai.huoqing@linux.dev>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <gongfan1@huawei.com>,
	<guoxin09@huawei.com>, <gur.stavi@huawei.com>, <helgaas@kernel.org>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luosifu@huawei.com>,
	<meny.yossefi@huawei.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>, <shenchenyang1@hisilicon.com>,
	<shijing34@huawei.com>, <sumang@marvell.com>, <wulike1@huawei.com>,
	<zhoushuai28@huawei.com>
Subject: Re: [PATCH net-next v06 1/1] hinic3: module initialization and tx/rx logic
Date: Wed, 26 Feb 2025 10:41:24 +0200
Message-ID: <20250226084124.650275-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <Z73pMXNsYprCcbmk@LQ3V64L9R2>
References: <Z73pMXNsYprCcbmk@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 frapeml500005.china.huawei.com (7.182.85.13)

> On Tue, Feb 25, 2025 at 04:53:30PM +0200, Gur Stavi wrote:
> > From: Fan Gong <gongfan1@huawei.com>
> >
> > This is [1/3] part of hinic3 Ethernet driver initial submission.
> > With this patch hinic3 is a valid kernel module but non-functional
> > driver.
>
> IMHO, there's a huge amount of code so it makes reviewing pretty
> difficult.
>
> Is there no way to split this into multiple smaller patches? I am
> sure his was asked and answered in a previous thread that I missed.
>
> I took a quick pass over the code, but probably missed many things
> due to the large amount of code in a single patch.


>
> Doesn't this function need to re-enable hw IRQs? Maybe it does
> somewhere in one of the helpers and I missed it?
>
> Even so, it should probably be checking napi_complete_done before
> re-enabling IRQs and I don't see a call to that anywhere, but maybe
> I missed it?
>
> I also don't see any calls to netif_napi_add, so I'm not sure if
> this code needs to be included in this patch ?
>

Hi Joe, thanks for the review.

There was a discussion during our initial submission where we were required to
limit submission size to 4k LoC.
https://lore.kernel.org/netdev/cover.1730290527.git.gur.stavi@huawei.com

After removing almost anything optional from the driver we reached ~12K LoC
and broke it into 3 submissions of 4K LoC that compile. This is the 1st
submission.

The rational for patch ordering was to start with the code that have lots of
interaction with Linux interfaces and therefore is of more interest to the
community and keep the code that deals with proprietary HW interfaces for later.
We also try to make the patches incremental and avoid introducing ad-hoc code
that is being deleted or modified in later submission.

The actual calls to rx/tx poll and napi require IRQs that require hw management
interfaces.
I can try to pull these functions from later submission (without breaking the 4K
limit) into this patch. They are currently static functions so I will have to
un-static them to avoid compilation errors and then re-static them at a later
submission.

As for breaking the 4K submission into smaller patches, I will try to find
some finer granularity that makes sense. When I studied the mailing list,
there were conflicting opinions about the right way for initial driver
submission. For example:
https://lore.kernel.org/netdev/20170817.220343.905568389038615738.davem@davemloft.net


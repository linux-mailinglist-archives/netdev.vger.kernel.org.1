Return-Path: <netdev+bounces-154254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D3D9FC536
	for <lists+netdev@lfdr.de>; Wed, 25 Dec 2024 13:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E10188382C
	for <lists+netdev@lfdr.de>; Wed, 25 Dec 2024 12:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D700218E373;
	Wed, 25 Dec 2024 12:43:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30802257D;
	Wed, 25 Dec 2024 12:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735130621; cv=none; b=RR4/yOaIGyLpGjpmsKSAvVPwLkCV/ee2hZS251G/V88Wo4lLcuyIBw/vtOlbu6St43ngkahKVePLi7feLHocwMb/26f4S15IVjqkPKp37hVi6BtZyt1grUGUCr4rf8ULqweItisNvHUZDVyn6pzN2sH5CvDQ6cxhwi2T0XkTxRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735130621; c=relaxed/simple;
	bh=6aHKffAeNMdgEx5yJwsThmx1+qZzNlpIGlLP2u8KM4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/SD1hri8NljaDdL68aVAiD/gZauFIbJEygNrUL4NCMeyXXvmJdrCOlMcQFmuhoYPe1CVvBlsq30XNBnOG6md5PfR2uyk7hW16Z6s0lhkHuC8gSts98txMjPpbKzdNQSd3ZjTK6RfCZArcOa/r+LEarZUFodwq4CHQFFqJBZb8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YJBCw5DhLz6K8bK;
	Wed, 25 Dec 2024 20:39:40 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 6F62A140AE5;
	Wed, 25 Dec 2024 20:43:36 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 25 Dec
 2024 13:43:26 +0100
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
Date: Wed, 25 Dec 2024 14:56:49 +0200
Message-ID: <20241225125649.2595970-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241223073955.52da7539@kernel.org>
References: <20241223073955.52da7539@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 frapeml500005.china.huawei.com (7.182.85.13)

> > > On Thu, 19 Dec 2024 11:21:55 +0200 Gur Stavi wrote:
> > > > +config HINIC3
> > > > +	tristate "Huawei Intelligent Network Interface Card 3rd"
> > > > +	# Fields of HW and management structures are little endian and will not
> > > > +	# be explicitly converted
> > >
> > > This is a PCIe device, users may plug it into any platform.
> > > Please annotate the endian of the data structures and use appropriate
> > > conversion helpers.
> >
> > This is basically saying that all drivers MUST support all architectures
> > which is not a currently documented requirement.
> > As I said before, both Amazon and Microsoft have this dependency.
> > They currently do not sell their HW so users cannot choose where to plug
> > it, but they could start selling it whenever they want and the driver will
> > remain the same.
> > The primary goal of this driver is for VMs in Huawei cloud, just like
> > Amazon and Microsoft. Whether users can actually buy it in the future is
> > unknown.
> >
> > for the record, we did start at some point to change all integer members
> > in management structures to __leXX and use cpu_to_le and le_to_cpu.
> > There are hundreds of these and it made the code completely unreadable.
> >
> > And since we do not plan to test the driver on POWER or ARM big endian I
> > really don't see the point.
>
> I understand. But I'm concerned about the self-assured tone of the
> "it's not supported" message, that's very corporate verbiage. Annotating
> endian is standard practice of writing upstream drivers. It makes me
> doubt if you have any developers with upstream experience on your team
> if you don't know that. That and the fact that Huawei usually tops
> the list of net-negative review contributors in netdev.

The most popular combination in the last 3 decades was little endian
CPUs with big endian device interfaces. Endianity conversion was a
necessity and therefore endian annotation became standard practice.
But it was never symmetric, conversion to/from BE was more common than
conversion to/from LE.

As the pendulum moved from horizontal market to vertical market and major
companies started to develop both hw and sw, the hw engineers transformed
proprietary parts of the interface to little endian to save extra work in
the sw. AWS did it. Azure did it. Huawei did it. These vertical companies
do not care about endianity of CPUs they do not use.
This is not "corporate verbiage" this is a real market shift.

The necessity for endian conversion is gone (or just halved). Will the
standard practice remain? There is not a single __le annotation in Amazon
and Microsoft code. Not in Mellanox code either. Maybe their hw is fully
BE (have to wonder about their DPUs). Amazingly, Intel that only creates
little endian CPUs has lots of __le annotations. But they are the flag
barer of horizontal market.

Interesting how both Amazon and Microsoft started with:
depends on X86
Thus evaded demand for adding __le annotations to the code.
Later, both sneaked in quiet small patches with replacement to:
depends on !CPU_BIG_ENDIAN
Maybe that is the true meaning of "upstream experience".


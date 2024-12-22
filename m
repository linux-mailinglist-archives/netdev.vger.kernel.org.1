Return-Path: <netdev+bounces-153956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A38A9FA49B
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 08:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B811B1887260
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 07:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D685152E12;
	Sun, 22 Dec 2024 07:59:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A1C1547F5;
	Sun, 22 Dec 2024 07:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734854359; cv=none; b=kZxrkv+Uddduh8MrFbZxlZd+0xCmrrg7UOGWRYWUp7eTD15eSFBrZBKD35QbXu+EMiE+aFb2i1m+Z/qIvZyL62rpQftCsVmLQ8YIhsvyYuGerpYZA+fVdQl+R0auP71IknwLEkPROerpymKe5SEmVlCg+nTycJEvmkwenRmA+c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734854359; c=relaxed/simple;
	bh=nIugVE0iIgf5KhveeYjItYdRJQcrgAHfd7Njy7fHiGE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hd0/5ge0jEdL+qbu7LG0P/rjJVgIzHu5ZqPyIccMIIDHICJtOzUzDIVyEvtHfIquyvCB33Rt+a1L6FR0qslw4ueihDp6+80DaGrDmvaz3IjcVizQwgPCd3+P/VRxkF2x49Zhh1LIMg/JrSMrKG7jmlaKARNrxM78WqCrVAF84a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YGD6F2q10z6L75S;
	Sun, 22 Dec 2024 15:57:57 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 731BE1400D4;
	Sun, 22 Dec 2024 15:59:07 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sun, 22 Dec
 2024 08:58:57 +0100
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
Date: Sun, 22 Dec 2024 10:12:25 +0200
Message-ID: <20241222081225.2543508-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220132413.0962ad79@kernel.org>
References: <20241220132413.0962ad79@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 frapeml500005.china.huawei.com (7.182.85.13)

> On Thu, 19 Dec 2024 11:21:55 +0200 Gur Stavi wrote:
> > +config HINIC3
> > +	tristate "Huawei Intelligent Network Interface Card 3rd"
> > +	# Fields of HW and management structures are little endian and will not
> > +	# be explicitly converted
>
> This is a PCIe device, users may plug it into any platform.
> Please annotate the endian of the data structures and use appropriate
> conversion helpers.
>

This is basically saying that all drivers MUST support all architectures
which is not a currently documented requirement.
As I said before, both Amazon and Microsoft have this dependency.
They currently do not sell their HW so users cannot choose where to plug
it, but they could start selling it whenever they want and the driver will
remain the same.
The primary goal of this driver is for VMs in Huawei cloud, just like
Amazon and Microsoft. Whether users can actually buy it in the future is
unknown.

for the record, we did start at some point to change all integer members
in management structures to __leXX and use cpu_to_le and le_to_cpu.
There are hundreds of these and it made the code completely unreadable.

And since we do not plan to test the driver on POWER or ARM big endian I
really don't see the point.

> > +	depends on 64BIT && !CPU_BIG_ENDIAN
> > +	depends on PCI_MSI && (X86 || ARM64)
>
> Also allow COMPILE_TEST
>

Ack

> > +	help
> > +	  This driver supports HiNIC PCIE Ethernet cards.
> > +	  To compile this driver as part of the kernel, choose Y here.
> > +	  If unsure, choose N.
> > +	  The default is N.


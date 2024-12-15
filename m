Return-Path: <netdev+bounces-151979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1059F22C8
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 10:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CBC216607D
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 09:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEB0146A66;
	Sun, 15 Dec 2024 09:00:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C75145B24;
	Sun, 15 Dec 2024 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734253207; cv=none; b=tH+W+A9IYcM63guTxf+Md+qXjp1yqP6YQ3B5mUAIL0QTEsX71UMrFWlvb0Fnt79C+QcLdLWSEzJO/rsCDBiyn619n9E/zOgZ/nN6hqFr5olNWUbkZyi6n820a1NNz6nLi3DIO53hW6ofbDhBd5zavJdKrkKL12rJsq0nL/yGbgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734253207; c=relaxed/simple;
	bh=K/9cI6V0lSp9Yq8zI5ErDWD25ukQakppLVK2TH9/Ydo=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=otu31poSz/XbfQY9hFVARGYuc5jbn29Bz3jSbrc2Lo1STgFkoBNp0mtvQ+Oi1bJqZ1ipj4uG/HBHTsc5inNa5ZckzP5DPTIMuLtYCKJ7diBO9VuFZxM4q92scb7Xp2wVV0LboxGMPIzWUw40f0VfbXRGmoSqoYKUnLSQlCksCe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y9xnr2cNJz6LCjw;
	Sun, 15 Dec 2024 16:58:56 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A537140157;
	Sun, 15 Dec 2024 16:59:56 +0800 (CST)
Received: from GurSIX1 (10.204.107.85) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sun, 15 Dec
 2024 09:59:44 +0100
From: Gur Stavi <gur.stavi@huawei.com>
To: 'Bjorn Helgaas' <helgaas@kernel.org>
CC: "Gongfan (Eric, Chip)" <gongfan1@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, <linux-doc@vger.kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Cai Huoqing <cai.huoqing@linux.dev>, "Guoxin (D)"
	<guoxin09@huawei.com>, shenchenyang <shenchenyang1@hisilicon.com>, "zhoushuai
 (A)" <zhoushuai28@huawei.com>, "Wulike (Collin)" <wulike1@huawei.com>,
	"shijing (A)" <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>
References: <7d62ca11c809ac646c2fd8613fd48729061c22b3.1733990727.git.gur.stavi@huawei.com> <20241212170256.GA3347301@bhelgaas>
In-Reply-To: <20241212170256.GA3347301@bhelgaas>
Subject: RE: [RFC net-next v02 1/3] net: hinic3: module initialization and tx/rx logic
Date: Sun, 15 Dec 2024 10:59:36 +0200
Message-ID: <008b01db4ecf$b529e4a0$1f7dade0$@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHbTIwlLUyEGMPD106kXiEG8AMaKrLixYUAgAQ87hA=
Content-Language: en-us
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 frapeml500005.china.huawei.com (7.182.85.13)

> Is the PPF selected dynamically by the driver?  By firmware on the
> NIC?

Selected dynamically by PF driver but initial submission only contains
VF logic.

> > +	# Fields of HW and management structures are little endian and will
> not
> > +	# be explicitly converted
> 
> I guess this comment is here to explain the !CPU_BIG_ENDIAN below?
> That's quite an unusual dependency.
> 

Yes. Otherwise the code will be swamped with cpu_to_le and le_to_cpu.
Microsoft and Amazon drivers have it as well. I wonder if all other
drivers were tested on big endian host.
Dependency on CPU_LITTLE_ENDIAN would be nicer but unfortunately x86
arch does not define it.

> > +	depends on 64BIT && !CPU_BIG_ENDIAN
> 

Other comments were addressed in files for next submission.



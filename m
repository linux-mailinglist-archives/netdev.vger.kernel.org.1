Return-Path: <netdev+bounces-229939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EFCBE23D9
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 91A12352A78
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 08:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A19530C60C;
	Thu, 16 Oct 2025 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="YpRvjChg"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D042E426A;
	Thu, 16 Oct 2025 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760604959; cv=none; b=lAUfMBBriIouT+DeB7jjgwMSCJT/CFa8lIVvdNx9RNbnSoqYPBt18B86+n57b3jvqcL9PQ6/S89zoH9EFPkrpXuNA84AT4ybYUBOgyFBDCKz9BPMOMfID40lYgFzlJY06+brrMyUXt+gCZwQ1y18o2Qd7rau2fcrKQXfTczqXOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760604959; c=relaxed/simple;
	bh=8l+Mg45r7QyS31S5oLsAZ715odXzb2V6gB3AxfkzWuM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rASIDsCoRGYmIsG8hfIiY1rn2/j6X77iYwqdIK8yIZUhWw3MGLLpeqfzLNjLCXLsIcvEd0f7H/ew84hdkKnZTkQHZtWASDOR6DepguG962TbiPR/RUSV2TujmDQ3RskEIMB6A0+AL4zStNjLIWe2z7n+Qn6Qgt511ucDDSOZaIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=YpRvjChg; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8l+Mg45r7QyS31S5oLsAZ715odXzb2V6gB3AxfkzWuM=;
	b=YpRvjChgc1mCWPLVJHnSLXC0ET1CCsGV7HXWXaWJ1DTs56HSdlQc+dFhGka92Tx6pWr1CeNGb
	BNRbpUmqXv/VHyPs6IabOI7/3MkG3xrF7FjySwoU5YNdwGLUP1+gOZccMomDp8B7wK3Pz+MF8mH
	g592v2YuNYAxtOSjXwudTBA=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4cnMH33djCz1cyVs;
	Thu, 16 Oct 2025 16:55:27 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 5CC2C140148;
	Thu, 16 Oct 2025 16:55:48 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Oct 2025 16:55:46 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <markus.elfring@web.de>
CC: <andrew+netdev@lunn.ch>, <christophe.jaillet@wanadoo.fr>,
	<corbet@lwn.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<gongfan1@huawei.com>, <guoxin09@huawei.com>, <gur.stavi@huawei.com>,
	<helgaas@kernel.org>, <horms@kernel.org>, <jdamato@fastly.com>,
	<kuba@kernel.org>, <lee@trager.us>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luosifu@huawei.com>,
	<luoyang82@h-partners.com>, <meny.yossefi@huawei.com>, <mpe@ellerman.id.au>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>, <shenchenyang1@hisilicon.com>,
	<shijing34@huawei.com>, <sumang@marvell.com>, <vadim.fedorenko@linux.dev>,
	<wulike1@huawei.com>, <zhoushuai28@huawei.com>, <zhuyikai1@h-partners.com>
Subject: Re: [PATCH net-next 2/9] hinic3: Add PF management interfaces
Date: Thu, 16 Oct 2025 16:55:41 +0800
Message-ID: <20251016085543.1903-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <b59d625d-18c8-49c9-9e96-bb4e2f509cd7@web.de>
References: <b59d625d-18c8-49c9-9e96-bb4e2f509cd7@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100013.china.huawei.com (7.202.181.12)

On 10/15/2025 6:00 PM, Markus Elfring wrote:
>> To: Fan Gong …
>
> Please reconsider the distribution of recipient information between message fields
> once more.

Hi Markus. Thanks for your comment.

I can't quite understand "the distribution of recipient information between message
fields". Can you explain this further?


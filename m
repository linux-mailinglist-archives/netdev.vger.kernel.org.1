Return-Path: <netdev+bounces-220697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E91AB482E1
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 05:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0743BDF0B
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 03:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2EB1FDA92;
	Mon,  8 Sep 2025 03:27:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492B97263E;
	Mon,  8 Sep 2025 03:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757302072; cv=none; b=fHs/svrDVlDP77Rxeqk8v0IxuIV8JQ4Dr0e3YfmehA/kKVugvEJFzuTK/vdbWWrFOAVYl3xSMf8V139cPlC4zbD4fnDx8PbOwCXNXlpC0gNp/WktN97GNwl8MQuq6Kd/SAZiL0+AOvTf6Wbqk/KeH5A0BVllryauM0zwL9xoumI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757302072; c=relaxed/simple;
	bh=/xm0CoQperM2d+lJa/HVWwNf046vpRb170SWKROPvz4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UDFGCzFPBjvKtRoLb5LOHKGeE3iOg2hRW+cPP9CzhHnj9TRgfACr4qlAKoKlEBRy+FDh1xdtd/NG9YIUn+mDBntJxumLJ8ztrcUsu7U397sO7FMxbYGuzMVo6i53kYoRyDZYuOpgXAlW9YTqgyC6nXp9m/G7QdaIRdk+TtZor2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cKsj95s2czRk4v;
	Mon,  8 Sep 2025 11:23:09 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id A65BE140258;
	Mon,  8 Sep 2025 11:27:46 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.55) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Sep 2025 11:27:45 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <vadim.fedorenko@linux.dev>
CC: <andrew+netdev@lunn.ch>, <christophe.jaillet@wanadoo.fr>,
	<corbet@lwn.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<gongfan1@huawei.com>, <guoxin09@huawei.com>, <gur.stavi@huawei.com>,
	<helgaas@kernel.org>, <horms@kernel.org>, <kuba@kernel.org>, <lee@trager.us>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<luosifu@huawei.com>, <luoyang82@h-partners.com>, <meny.yossefi@huawei.com>,
	<mpe@ellerman.id.au>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>, <shenchenyang1@hisilicon.com>,
	<shijing34@huawei.com>, <sumang@marvell.com>, <wulike1@huawei.com>,
	<zhoushuai28@huawei.com>, <zhuyikai1@h-partners.com>
Subject: Re: [PATCH net-next v04 06/14] hinic3: Nic_io initialization
Date: Mon, 8 Sep 2025 11:27:40 +0800
Message-ID: <20250908032741.1849-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <98c93693-0647-4c7e-ac1c-729502beab76@linux.dev>
References: <98c93693-0647-4c7e-ac1c-729502beab76@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100013.china.huawei.com (7.202.181.12)

On 9/8/2025 1:02 AM, Vadim Fedorenko wrote:

> >   int hinic3_init_hwdev(struct pci_dev *pdev)
> >   {
> >       struct hinic3_pcidev *pci_adapter = pci_get_drvdata(pdev);
> > @@ -451,6 +463,7 @@ int hinic3_init_hwdev(struct pci_dev *pdev)
> >       hwdev->pdev = pci_adapter->pdev;
> >       hwdev->dev = &pci_adapter->pdev->dev;
> >       hwdev->func_state = 0;
> > +    hwdev->dev_id = hinic3_adev_idx_alloc(); 
> 
> Why do you need dev_id? It's not used anywhere in the patchset. The
> commit doesn't explain it neither... 

Thanks for your commit.
This is the code to refine the first patchset of hinic3 driver. In
hinic3_lld.c, we use "hadev->adev.id = hwdev->dev_id;" and dev_id
is temporarily set to default value 0. In this patchset we complete
hwdev's initialization.
I will update this commit message to explain this modification.


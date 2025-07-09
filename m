Return-Path: <netdev+bounces-205298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C524AFE1F8
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1165F1AA2931
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39132222D0;
	Wed,  9 Jul 2025 08:08:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D18627453;
	Wed,  9 Jul 2025 08:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048492; cv=none; b=eqYLAgxWF9ebQeMHVWtxCSt7uuESW8ngTGTLUa01QVPxAiozUCyBVeN5bnSks6kkBu0G419iUYafiXykA3v0F2l7CLn8UTeqTV7R2ValHJAHDCW5kZWP52LTViYLqxGZIpCrdD29oddt5q6H7KHHdT9WDknXXDQs+okCL5MziuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048492; c=relaxed/simple;
	bh=8e5DJ6eb/9lk9z4u6yIhTJJ+olqISSeokcWp/4UTNAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GumNQODnbSJOLGC4eOmSaLr6FIIlJry1/0nV3XKMFPl4sEGuV4q5kBOrrKx9FhFbmWWgsKnM15u3ezT2oBIjTH2hZR2qrDRR7C7cvBMkraLCSjO8yagHHbcjC8sHfCnHakvKhVXuuN41geZkglAKsv6bRifUXQoRlaEYPMey2y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bcVtt1fWRz6GCbc;
	Wed,  9 Jul 2025 16:07:02 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 63FA6140257;
	Wed,  9 Jul 2025 16:08:07 +0800 (CST)
Received: from china (10.220.118.114) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 9 Jul
 2025 10:07:53 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: <vadim.fedorenko@linux.dev>
CC: <andrew+netdev@lunn.ch>, <christophe.jaillet@wanadoo.fr>,
	<corbet@lwn.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<gongfan1@huawei.com>, <guoxin09@huawei.com>, <gur.stavi@huawei.com>,
	<helgaas@kernel.org>, <horms@kernel.org>, <jdamato@fastly.com>,
	<kuba@kernel.org>, <lee@trager.us>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luosifu@huawei.com>,
	<meny.yossefi@huawei.com>, <mpe@ellerman.id.au>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>,
	<shenchenyang1@hisilicon.com>, <shijing34@huawei.com>, <sumang@marvell.com>,
	<wulike1@huawei.com>, <zhoushuai28@huawei.com>, <zhuyikai1@h-partners.com>
Subject: Re: [PATCH net-next v06 5/8] hinic3: TX & RX Queue coalesce interfaces
Date: Wed, 9 Jul 2025 11:26:20 +0300
Message-ID: <20250709082620.1015213-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <ef88247b-e726-4f8b-9aec-b3601e44390f@linux.dev>
References: <ef88247b-e726-4f8b-9aec-b3601e44390f@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 frapeml500005.china.huawei.com (7.182.85.13)

> On 27/06/2025 07:12, Fan Gong wrote:
> > Add TX RX queue coalesce interfaces initialization.
> > It configures the parameters of tx & tx msix coalesce.
> >
> > Co-developed-by: Xin Guo <guoxin09@huawei.com>
> > Signed-off-by: Xin Guo <guoxin09@huawei.com>
> > Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> > Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> > Signed-off-by: Fan Gong <gongfan1@huawei.com>
> > ---
> >   .../net/ethernet/huawei/hinic3/hinic3_main.c  | 61 +++++++++++++++++--
> >   .../ethernet/huawei/hinic3/hinic3_nic_dev.h   | 10 +++
> >   2 files changed, 66 insertions(+), 5 deletions(-)
> >
>
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Procedural question about submissions:
Are we allowed (or expected) to copy the "Reviewed-by" above to future
submissions as long as we do not modify this specific patch?


Return-Path: <netdev+bounces-236684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628F3C3EF09
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 09:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F8D3AE364
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 08:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E7230F537;
	Fri,  7 Nov 2025 08:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="G7MIPNMi"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFD0308F14;
	Fri,  7 Nov 2025 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762503995; cv=none; b=EBCGlVyUMBL739vSFdFP8TdF5s/iYoMKCTmaOejGIdJLkOlq2vsx4K8OPrHmPSou9TbG2/X+15Bx7UXwABrj4tf2eV/Wgu9XG+3IHcUYa1Twqf0NPawLXjy/0wbtbqnWyttFhPB1Ptra/v1J7ClyVq/t9JOvc1g7hLmgur0CQs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762503995; c=relaxed/simple;
	bh=Hw7WviiLw+ywvBJebQ5O6RgAsIukfMAuZawgmFiWwas=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+EMeUIMR/jhAKXutmArNHdSDmxmYXQVVYW7TQMX0YBURD0fGkCXSby8BuvB6u5F/N8F3ypLCXfFYFpehi4zd/Sqy73zb2LUAIh842qsBDvzLBVYbZFlYXq3Jh9Jn6m0A7b3Sbq5BdGku9PIbDbCB1Tro6CGK6HiH35+TFFf8bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=G7MIPNMi; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=yJghrzhXUW4i7ez9BxpbYoOfx1uePTskE0iGZn9IjOY=;
	b=G7MIPNMiXqXrpJtWkJbvxy966zKiXFBSiIpDtIHh4ubf3GwNV7wjC11b9YGHoigE1jiyY95jw
	tl/T+XxzIG+OaJxN6KzueIvmArmjK5RBrhZuy+OvNcgEVxEc2QcLAcUImCa/+VdhINKXM+svCBr
	nV5XbIP8iJ6NthiYtQmsydc=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4d2sYg1wzxzpStP;
	Fri,  7 Nov 2025 16:24:55 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 56975180B66;
	Fri,  7 Nov 2025 16:26:29 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Nov 2025 16:26:28 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <alok.a.tiwari@oracle.com>
CC: <Markus.Elfring@web.de>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <gongfan1@huawei.com>, <guoxin09@huawei.com>,
	<gur.stavi@huawei.com>, <horms@kernel.org>, <kuba@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<luosifu@huawei.com>, <luoyang82@h-partners.com>, <meny.yossefi@huawei.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <pavan.chebbi@broadcom.com>,
	<shenchenyang1@hisilicon.com>, <shijing34@huawei.com>, <wulike1@huawei.com>,
	<zhoushuai28@huawei.com>, <zhuyikai1@h-partners.com>
Subject: Re: [External] : [PATCH net-next v05 1/5] hinic3: Add PF framework
Date: Fri, 7 Nov 2025 16:26:24 +0800
Message-ID: <20251107082624.931-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <2321cbe4-e704-4c19-9d0d-92011f768178@oracle.com>
References: <2321cbe4-e704-4c19-9d0d-92011f768178@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100013.china.huawei.com (7.202.181.12)

On 11/6/2025 10:19 PM, ALOK TIWARI wrote:

> > +    if (src_func_id == MBOX_MGMT_FUNC_ID) {
> > +        msg_ch = &mbox->mgmt_msg;
> > +    } else if (HINIC3_IS_VF(hwdev)) {
> > +        /* message from pf */
> > +        msg_ch = mbox->func_msg;
> > +        if (src_func_id != hinic3_pf_id_of_vf(hwdev) || !msg_ch)
> > +            return NULL;
> > +    } else if (src_func_id > hinic3_glb_pf_vf_offset(hwdev)) {
> > +        /* message from vf */
> > +        id = (src_func_id - 1) - hinic3_glb_pf_vf_offset(hwdev);
> > +        if (id >= 1)
> > +            return NULL; 
> 
> hard coding id >= 1, is only one VF supported?

Hi, Alok. Thanks for your reviews.
This is an oversight on "get_mbox_msg_desc". The part of "message from vf"
should be removed in this patch because currently hinic3 driver does not support
communication between VF and PF.
Besides, as it is incorrectly placed here, it appears to support only one vf
and pf communication. But actually pf can communicate with all vf that belongs
to it. This part of code will be contained in future SRIOV subject.

> >   +    if (HINIC3_IS_VF(hwdev)) {
> > +        /* VF to PF mbox message channel */
> > +        err = hinic3_init_func_mbox_msg_channel(hwdev);
> > +        if (err)
> > +            goto err_uninit_mgmt_msg_ch;
> > +    }
> > +
> >       err = hinic3_init_func_mbox_msg_channel(hwdev);
> 
> is hinic3_init_func* second init for PF and
> VF executes both calls, is that correct? 

hinic3_init_func* only inits for VF and PF initialization is in future SRIOV
subject. So this is oversight and we should remove the redundant initialization
for PF.

The rest comments will be solved in the next version sooner.

Thanks,
Fan Gong


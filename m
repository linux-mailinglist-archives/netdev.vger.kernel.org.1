Return-Path: <netdev+bounces-240749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4406CC78F00
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 13:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AD47E35F507
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49C834A3D6;
	Fri, 21 Nov 2025 12:07:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7D6349B14;
	Fri, 21 Nov 2025 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763726825; cv=none; b=WuNVFMhSX/39xPuq5JIdg8YdUZ59vH4nH7enbwN0rx8Mfei/a0B76+j08rB9zpLkCJ9mYwrdbWTqaclOhT0RhOY5kQP9JYYCQnlVb3r6cWJGs+dgyC6YlmwBhDlwksc9jAwcjuQV4CJR3eANXrGqpAf02w5UE35gT4mSxedaVkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763726825; c=relaxed/simple;
	bh=Dhqg+B9NHpP/rXRbMr51Beg/Sru804ovTJh44+KVcng=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RhmpQ3ZAqgyKezAz7+P1Z7CojnVnNLXgsN6xERuGwtjpl/jVgiJt1kphZXKeZnEDW14IiH31G3PVn3aWeDeOj6QnIFngIb6gjsXwD2r1bEsnbGA3yD7+mfkww5K86AC/rRwj/TOtFqfK58T4sEfpkIUTW64syFvfmGJh0DkPRYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dCYpk2CFCzHnHDT;
	Fri, 21 Nov 2025 20:06:22 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id EEFAE1404C5;
	Fri, 21 Nov 2025 20:06:58 +0800 (CST)
Received: from localhost (10.122.19.247) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 21 Nov
 2025 12:06:57 +0000
Date: Fri, 21 Nov 2025 12:06:56 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
Subject: Re: [PATCH v21 01/23] cxl/mem: refactor memdev allocation
Message-ID: <20251121120656.0000546c@huawei.com>
In-Reply-To: <c40d91b5-d251-47a3-8672-b9ea5c54eb2a@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
	<20251119192236.2527305-2-alejandro.lucero-palau@amd.com>
	<20251120180805.00001699@huawei.com>
	<c40d91b5-d251-47a3-8672-b9ea5c54eb2a@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 20 Nov 2025 18:27:50 +0000
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> On 11/20/25 18:08, Jonathan Cameron wrote:
> > On Wed, 19 Nov 2025 19:22:14 +0000
> > alejandro.lucero-palau@amd.com wrote:
> >  
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> In preparation for always-synchronous memdev attach, refactor memdev
> >> allocation and fix release bug in devm_cxl_add_memdev() when error after
> >> a successful allocation.
> >>
> >> The diff is busy as this moves cxl_memdev_alloc() down below the definition
> >> of cxl_memdev_fops and introduces devm_cxl_memdev_add_or_reset() to
> >> preclude needing to export more symbols from the cxl_core.
> >>
> >> Fixes: 1c3333a28d45 ("cxl/mem: Do not rely on device_add() side effects for dev_set_name() failures")
> >>  
> > No line break here. Fixes is part of the tag block and some tools
> > get grumpy if that isn't contiguous.  That includes a bot that runs
> > on linux-next.
> >  
> 
> OK
> 
> 
> >> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>  
> > This SOB chain is wrong.  What was Dan's role in this?  As first SOB with no
> > Co-developed tag he would normally also be the author (From above)  
> 
> 
> The original patch is Dan's work. I did change it.
> 
> 
>  From the previous revision I asked what I should do and if adding my 
> Signed-off to Dan's one would be enough. Dave's answer was a yes.
> 
> Someone, likely I, misunderstood something in that exchange.
> 
> 
> I did add my Signed-off to the patches 1 to 4 along with Dan's ones, 
> what I think it was suggested by Dave as well in another review.
> 
> 
> Please, tell me what should I do here.

Change the author to Dan.  IIRC

git commit --amend --author="Dan Williams <dan.j.williams@intel.com>"

should do that for you

Then author and first SoB will be Dan and you will be noting you 'handled'
the patch. Feel free to add a comment # Changed XYZ
to your SoB - or if appropriate a co-developed-by for yourself.


> 
> 
> Thank you
> 
> 
> >
> > I'm out of time for today so will leave review for another time. Just flagging
> > that without these tag chains being correct Dave can't pick this up even
> > if everything else is good.
> >  
> 
> 



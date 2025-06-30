Return-Path: <netdev+bounces-202559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9D5AEE454
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23AE57AF2DA
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504B6290DB2;
	Mon, 30 Jun 2025 16:20:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90BD1DFF7;
	Mon, 30 Jun 2025 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300458; cv=none; b=tK85JvfdIbOBWC2mkV+ERmbezxj+IhBBEVLaVt0G4Wgx/OpVQmxd0jqb6+rXal9b5uty1w/1iq5/ARIcVzmt8xTutjIJbEe6ubBWAvmdfhEgQ8CGUkedAnR+6f0c695s/lt1fNqkqRFWqkqs0VrjzaaGFlwpVb+D9ElS8YT0OBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300458; c=relaxed/simple;
	bh=b9hSZivE0RssUGKNhDBro17kA+3QCCzAgzAs2nSn63c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S/VJqekaYE6gIGoC/ZqPjwQYUGDwuGTVZes4KRXyvOOoeQgyO+ZrEk2eXf7JXDkN42zU0JYJ5pZHKJip9WJX9fqMN2c6HXFrcWRSC07w/fKx1+dfybr1MzUuIY2PJL2ZozJaBSTl4WuSQKaUq9JXCMOLhtipW40MsXNgmWA7q5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bWBCf559Dz6L5RD;
	Tue,  1 Jul 2025 00:18:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A4DD21402F0;
	Tue,  1 Jul 2025 00:20:54 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 30 Jun
 2025 18:20:54 +0200
Date: Mon, 30 Jun 2025 17:20:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, Alejandro Lucero <alucerop@amd.com>, Zhi Wang
	<zhiw@nvidia.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v17 16/22] cxl/region: Factor out interleave ways setup
Message-ID: <20250630172052.000011bd@huawei.com>
In-Reply-To: <0a73070b-b7b0-4697-9fb6-b43a4e6834b6@intel.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
	<20250624141355.269056-17-alejandro.lucero-palau@amd.com>
	<20250627101345.00002524@huawei.com>
	<0a73070b-b7b0-4697-9fb6-b43a4e6834b6@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 27 Jun 2025 16:05:20 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 6/27/25 2:13 AM, Jonathan Cameron wrote:
> > On Tue, 24 Jun 2025 15:13:49 +0100
> > <alejandro.lucero-palau@amd.com> wrote:
> >   
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> Region creation based on Type3 devices is triggered from user space
> >> allowing memory combination through interleaving.
> >>
> >> In preparation for kernel driven region creation, that is Type2 drivers
> >> triggering region creation backed with its advertised CXL memory, factor
> >> out a common helper from the user-sysfs region setup for interleave ways.
> >>
> >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> >> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>  
> > As a heads up, this code changes a fair bit in Dan's ACQUIRE() series
> > that may well land before this.  Dave can ask for whatever resolution he
> > wants when we get to that stage!
> > 
> >   
> We probably want to rebase on top of that. Dan has an immutable branch in cxl.git for the ACQUIRE() patch. Or are you talking about the outstanding CXL changes?
> 
The CXL specific ones from that series.

J
> 



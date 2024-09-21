Return-Path: <netdev+bounces-129132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A4A97DB75
	for <lists+netdev@lfdr.de>; Sat, 21 Sep 2024 04:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96FC71C21411
	for <lists+netdev@lfdr.de>; Sat, 21 Sep 2024 02:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC566FBF;
	Sat, 21 Sep 2024 02:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pFjd9xMe"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF74179A3
	for <netdev@vger.kernel.org>; Sat, 21 Sep 2024 02:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726885749; cv=none; b=Tw6FpYChIKxYuF8CAqZUygAOdhs+JZv5FoZqz3BS9yj0UytiooG4F0QVjGzGdbYS7du+9lvm93sUyzJtYAlMG+nDKG2FnuEx30h6qzdeiJ9mAe4MGTrl0ULAhdTuBysA2SGXtMN2qBf2bdhuRogmd6OPn874h0BhdO/C6g/zMLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726885749; c=relaxed/simple;
	bh=Q+9ubO9p6FjOwXPy94zOE+C1TH3tXKwjSOieBL6q5d0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ip1T5ZFzCQkIC2o3pC76EPlnSDj9MEYHd8m9TI8E93uS6gN2rOtAcfz+MVq2VdOxUzaMl1ToWA/okIB9OmYxG5pLI7a91huWLZeK+y4NqMghP5Utt2Lf7ubd62DW+d+qTGUrk0/5IWjcPIuns+E/oTI/gPmpMLffYG0IfynUCMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pFjd9xMe; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <525e9a31-31ee-4acf-a25c-8bf3a617283f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726885745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JCscfEp+Ym80CC3dMZxCPMQuoLupJ/Y+JmyiHw8Mmfc=;
	b=pFjd9xMejfPGUiSPhej4ygvK6DHI8WPs35hiuMloySd7XfpzfajQ/DuYhuCSPhCqICam4K
	jy7xzDksghJnNR4DgyUNZY3/9K99LBzpP57mDq9u8EkD+dhUsrwNzR/pfYpp6o/NAn/4wO
	6nPWjXq9X60wQzoyVHPgUKC4zX2mFwY=
Date: Sat, 21 Sep 2024 10:28:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [MAINLINE 0/2] Enable DIM for legacy ULPs and use it in RDS
To: Christoph Hellwig <hch@infradead.org>,
 Haakon Bugge <haakon.bugge@oracle.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Allison Henderson <allison.henderson@oracle.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 OFED mailing list <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>
References: <20240918083552.77531-1-haakon.bugge@oracle.com>
 <Zuwyf0N_6E6Alx-H@infradead.org>
 <C00EA178-ED20-4D56-B6F2-200AC72F3A39@oracle.com>
 <Zu191hsvJmvBlJ4J@infradead.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <Zu191hsvJmvBlJ4J@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/9/20 21:51, Christoph Hellwig 写道:
> On Fri, Sep 20, 2024 at 09:46:06AM +0000, Haakon Bugge wrote:
>>> I would much prefer if you could move RDS off that horrible API finally
>>> instead of investing more effort into it and making it more complicated.
>>
>> ib_alloc_cq() and family does not support arming the CQ with the IB_CQ_SOLICITED flag, which RDS uses.
> 
> Then work on supporting it.  RDS and SMC are the only users, so one

Some other open source projects are also the users.

Zhu Yanjun

> of the maintainers needs to drive it.
> 



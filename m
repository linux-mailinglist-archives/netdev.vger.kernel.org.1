Return-Path: <netdev+bounces-240528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C1FC75DDC
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 19:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 72D60343B36
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 18:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554662E03F3;
	Thu, 20 Nov 2025 18:08:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF1234DB40;
	Thu, 20 Nov 2025 18:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763662100; cv=none; b=A5aM/oIDg9XSO7tlVboVReiDsRz9fA5IP4LSrkDRRnfxYu4qX6LEGoFMY8bAoWiA9Sf5d0iCK6kU5Gdoam/zsRkLT5Pgw6haUjQfLA8GNC5/Hi6Giab//6RmIhyVsyuEV0i5bpU9dOkz5lip/uksJetqUbybT6AmtLpdd+9yBsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763662100; c=relaxed/simple;
	bh=UnnFl3rY9FqVL9vjmZgHXUaZ5u4R4nXBPU2E7u6esTk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLX0ZKNk/1pW3kh/X8wOhJMZKpC/bC0pVX5XrApRyJrX/asj1j5Jbafk1ZCitY2sGaOGJ68y5DRfqWYU+5it7ECbEyEQSimoVb5R03nrMKjy63RLjzZ+sIASDfSYvtiodV7dE9tvygEPI+rA3J4u5VEpjs+SRheZCARZpFa/T5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dC5sm4mL0zJ469G;
	Fri, 21 Nov 2025 02:07:24 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F2B714038F;
	Fri, 21 Nov 2025 02:08:10 +0800 (CST)
Received: from localhost (10.48.159.58) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 20 Nov
 2025 18:08:09 +0000
Date: Thu, 20 Nov 2025 18:08:05 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v21 01/23] cxl/mem: refactor memdev allocation
Message-ID: <20251120180805.00001699@huawei.com>
In-Reply-To: <20251119192236.2527305-2-alejandro.lucero-palau@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
	<20251119192236.2527305-2-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 19 Nov 2025 19:22:14 +0000
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> In preparation for always-synchronous memdev attach, refactor memdev
> allocation and fix release bug in devm_cxl_add_memdev() when error after
> a successful allocation.
> 
> The diff is busy as this moves cxl_memdev_alloc() down below the definition
> of cxl_memdev_fops and introduces devm_cxl_memdev_add_or_reset() to
> preclude needing to export more symbols from the cxl_core.
> 
> Fixes: 1c3333a28d45 ("cxl/mem: Do not rely on device_add() side effects for dev_set_name() failures")
> 

No line break here. Fixes is part of the tag block and some tools
get grumpy if that isn't contiguous.  That includes a bot that runs
on linux-next.

> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

This SOB chain is wrong.  What was Dan's role in this?  As first SOB with no
Co-developed tag he would normally also be the author (From above)

I'm out of time for today so will leave review for another time. Just flagging
that without these tag chains being correct Dave can't pick this up even
if everything else is good.



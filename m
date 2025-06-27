Return-Path: <netdev+bounces-201855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CA1AEB339
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D037E7A65F8
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 09:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754A921CA0D;
	Fri, 27 Jun 2025 09:46:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378E921C9E5;
	Fri, 27 Jun 2025 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751017602; cv=none; b=UnADpSNcY8YnPvJCwZpfTCqMAkA+NU+5XDOXfSoKa+6dVHNOc7H/essJIGunjU+fPjpE0LV8qVonY+Os3wj6YFguCduj87J4CBbg7KZCz8dQWFqOt3pl4GSGDrZcOtYfFg42Cz7rmyq5NM4zfNOiUiMZO0i4uPSPeuDl+phUJ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751017602; c=relaxed/simple;
	bh=LYZEpuIa3Szo6eNJ1L1rGTcakSHuj7SMvnBiVFOTYTw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mg0T9IHqq3erTprwPqwC9e67/H1xkytyMZB31vYJZL7zq1W3sz9Q5fm4hL4tB7dV970PqKe2tS5RY8iMhuFGpVTDzxDgPo4IRCvbD73Ufy8/Bz0O8FtfvEpe62fEZNcdyc7p0HgILhv6P8VVzErGM7tlSQ8KaNTndx8a5lxvKfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bT9fP2tXtz6M4sW;
	Fri, 27 Jun 2025 17:45:49 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D8F34140277;
	Fri, 27 Jun 2025 17:46:37 +0800 (CST)
Received: from localhost (10.48.153.213) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 27 Jun
 2025 11:46:37 +0200
Date: Fri, 27 Jun 2025 10:46:35 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v17 22/22] sfc: support pio mapping based on cxl
Message-ID: <20250627104635.000003c4@huawei.com>
In-Reply-To: <20250624141355.269056-23-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
	<20250624141355.269056-23-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 24 Jun 2025 15:13:55 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> A PIO buffer is a region of device memory to which the driver can write a
> packet for TX, with the device handling the transmit doorbell without
> requiring a DMA for getting the packet data, which helps reducing latency
> in certain exchanges. With CXL mem protocol this latency can be lowered
> further.
> 
> With a device supporting CXL and successfully initialised, use the cxl
> region to map the memory range and use this mapping for PIO buffers.
> 
> Add the disabling of those CXL-based PIO buffers if the callback for
> potential cxl endpoint removal by the CXL code happens.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
There is quite a bit of ifdef magic in here.  If there is any way
to push that to stubs in headers, it would probably improved code
readability.


I was expecting to at somepoint see handling of the CXL code being
called returning EPROBE_DEFER but that's not here so I don't
understand exactly how that is supposed to work if the CXL infrastructure
hasn't arrived at time of first probe.

Otherwise, main overall concern is that lifetimes are (I think) more
complex than they need to be.  I suggest a solution in an earlier patch (and
in reply to previous version)  Devres groups are really handy for wrapping
up a bunch of devm calls with the option to unwind them all on error or at
a specific point in the remove() path for a driver.  That should resolve
most of my concerns as you'll have something closely approximating a non devm flow.

Jonathan


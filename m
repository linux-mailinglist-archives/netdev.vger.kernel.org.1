Return-Path: <netdev+bounces-115553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEB2946FDF
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 18:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB6F28157A
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 16:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241E1A953;
	Sun,  4 Aug 2024 16:44:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C92382486;
	Sun,  4 Aug 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722789873; cv=none; b=d+UKMKlBJE7lefu4OHKu64Zd67UyR7MiKleO5effsUD2U68hXiIgjUl6DncN8rgGwW45YiwE0SsQ15DnFtjko7naa+do2ekLn7T0a3LuZureJRuJ4jsjyHuM+6FWgj1nKMbA+Fb1wn65DDzWkUSwwoeJIgZ88lG+PbJv7tdCYbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722789873; c=relaxed/simple;
	bh=1kciJ2/x/qzd9muqvODhkrXTdVxR8web0yC0JeiRvzU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pgeCJbRWAHDS1bWIWbIx7N0Xdgy6wQJqki8w3w1+mLdu/2JGF9vruzNTp+lZqdtphnDXEvKXz2pmyXq8ZJ8/3NGs/Jg3qFNcsAJFMh5LbIHlMHByqBevX1NhEIMKqg4xRySvFdQR43YSE/qd8qR3pNiu6U34P1Lp7YRaiUjlY0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WcQMs061Hz6K5nl;
	Mon,  5 Aug 2024 00:42:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EF8291406AC;
	Mon,  5 Aug 2024 00:44:27 +0800 (CST)
Received: from localhost (10.195.244.131) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sun, 4 Aug
 2024 17:44:27 +0100
Date: Sun, 4 Aug 2024 17:44:24 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: Dave Jiang <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>
Subject: Re: [PATCH v2 01/15] cxl: add type2 device basic support
Message-ID: <20240804174424.00007011@Huawei.com>
In-Reply-To: <e5a4836d-a405-5b12-62a7-e45b39fb12ad@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-2-alejandro.lucero-palau@amd.com>
	<936eecad-2e98-4336-b775-d28fa1d87d76@intel.com>
	<e5a4836d-a405-5b12-62a7-e45b39fb12ad@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

> >> diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_m=
em.h
> >> new file mode 100644
> >> index 000000000000..daf46d41f59c
> >> --- /dev/null
> >> +++ b/include/linux/cxl_accel_mem.h
> >> @@ -0,0 +1,22 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
> >> +
> >> +#include <linux/cdev.h> =20
> > Don't think this header is needed?
> > =20
> >> +
> >> +#ifndef __CXL_ACCEL_MEM_H
> >> +#define __CXL_ACCEL_MEM_H
> >> +
> >> +enum accel_resource{
> >> +	CXL_ACCEL_RES_DPA,
> >> +	CXL_ACCEL_RES_RAM,
> >> +	CXL_ACCEL_RES_PMEM,
> >> +};
> >> +
> >> +typedef struct cxl_dev_state cxl_accel_state; =20
> > Please use 'struct cxl_dev_state' directly. There's no good reason to h=
ide the type. =20
>=20
>=20
> That is what I think I was told to do although not explicitly. There=20
> were concerns in the RFC about accel drivers too loose for doing things=20
> regarding CXL and somehow CXL core should keep control as much as=20
> possible.=A0 I was even thought I was being asked to implement auxbus wit=
h=20
> the CXL part of an accel as an auxiliar device which should be bound to=20
> a CXL core driver. Then Jonathan Cameron the only one explicitly giving=20
> the possibility of the opaque approach and disadvising the auxbus idea.

I wasn't thinking a typedef to hide it.
More making all state accesses that are needed through accessor functions so
that from the 'internals' become opaque to the accelerator code and
we can radically change how things are structured internally with
no impact to the (hopefully large number of) CXL accelerator drivers.

So here, I'd just expect a
struct cxl_device_state; forwards declaration.

Or potentially one to a a different structure after refactors etc.

>=20
>=20
> Maybe I need an explicit action here.

J


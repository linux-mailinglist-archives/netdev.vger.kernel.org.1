Return-Path: <netdev+bounces-227372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D45BAD3AA
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 16:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 853BC7A0F81
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 14:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D492253FC;
	Tue, 30 Sep 2025 14:43:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9EE201017;
	Tue, 30 Sep 2025 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243432; cv=none; b=R1Ykf9omYCsUu+xSGbG34NC9Q5BkwClN/gocLkBhYQq3LV80kf8iS+A7wm/6P8HnIdbVlovhU9ogeqcaWW580juawBq+9TQjOvX0pjasFOZtG/Eo8FvGfU7EWXmKd/TjNA9RQs2eFCT6Ud/6Z32Vf/pEqaMEpQqlpMI013o/3AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243432; c=relaxed/simple;
	bh=RvJXQw/yH73lc7t/zKcG3rvawnBc6JRBzvYD2iOM0cI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFg5T6bnWoxmm9tau4Wk/qcLBm+rCCcjTgT5d+2sy2fOOnDCV6Pqe9Vhl/6TmXWGss2pgVFmsQdeThg9p8qzAyRm44EmIb9SiyQkkHdI1EZY+EHn3OjkZRHj1Kmbbdns9Z7hhBU4iTYLB8QTRi3sNDfvG9AXdFAnxh/ItkVRD+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cbghh2XtCz6M4Xb;
	Tue, 30 Sep 2025 22:40:36 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 54DA41402ED;
	Tue, 30 Sep 2025 22:43:43 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 30 Sep
 2025 15:43:42 +0100
Date: Tue, 30 Sep 2025 15:43:40 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>, "Alison Schofield"
	<alison.schofield@intel.com>
Subject: Re: [PATCH v18 01/20] cxl: Add type2 device basic support
Message-ID: <20250930154340.000005f7@huawei.com>
In-Reply-To: <ee5d4ff7-da7b-4caa-b723-b4b5a09bfc39@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
	<20250918091746.2034285-2-alejandro.lucero-palau@amd.com>
	<20250918115512.00007a02@huawei.com>
	<7d80a32f-149c-4812-8827-71befdaae924@amd.com>
	<ee5d4ff7-da7b-4caa-b723-b4b5a09bfc39@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 29 Sep 2025 11:21:33 +0100
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> On 9/23/25 12:21, Alejandro Lucero Palau wrote:
> >
> > On 9/18/25 11:55, Jonathan Cameron wrote: =20
> >> On Thu, 18 Sep 2025 10:17:27 +0100
> >> alejandro.lucero-palau@amd.com wrote:
> >> =20
> >>> From: Alejandro Lucero <alucerop@amd.com>
> >>>
> >>> Differentiate CXL memory expanders (type 3) from CXL device=20
> >>> accelerators
> >>> (type 2) with a new function for initializing cxl_dev_state and a mac=
ro
> >>> for helping accel drivers to embed cxl_dev_state inside a private
> >>> struct.
> >>>
> >>> Move structs to include/cxl as the size of the accel driver private
> >>> struct embedding cxl_dev_state needs to know the size of this struct.
> >>>
> >>> Use same new initialization with the type3 pci driver.
> >>>
> >>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> >>> Reviewed-by: Alison Schofield <alison.schofield@intel.com> =20
> >> =20
> >>> diff --git a/Documentation/driver-api/cxl/theory-of-operation.rst=20
> >>> b/Documentation/driver-api/cxl/theory-of-operation.rst
> >>> index 257f513e320c..ab8ebe7722a9 100644
> >>> --- a/Documentation/driver-api/cxl/theory-of-operation.rst
> >>> +++ b/Documentation/driver-api/cxl/theory-of-operation.rst
> >>> @@ -347,6 +347,9 @@ CXL Core
> >>> =A0 .. kernel-doc:: drivers/cxl/cxl.h
> >>> =A0=A0=A0=A0 :internal:
> >>> =A0 +.. kernel-doc:: include/cxl/cxl.h
> >>> +=A0=A0 :internal:
> >>> + =20
> >> Smells like a merge conflict issue given same entry is already there.
> >> =20
> >
> > Yes, I'll fix it.
> >
> >
> > Thanks
> > =20
>=20
> Hi Jonathan,
>=20
>=20
> When double-checking for v19, I am not sure what you meant here. It=20
> seems my answer was in "automatic mode" since there is no duplicate=20
> entry at all.
>=20
>=20
> Note there is one line for another file with same name but different=20
> path. We discussed the file name for public cxl API for type2 drivers=20
> time ago, so I think this should not be a problem.
>=20

Indeed. Misread on my part.

>=20
>=20
> > =20
> >>> =A0 .. kernel-doc:: drivers/cxl/acpi.c
> >>> =A0=A0=A0=A0 :identifiers: add_cxl_resources =20
> >> =20
>=20



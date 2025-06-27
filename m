Return-Path: <netdev+bounces-201797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1272AEB185
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 10:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF95F189EFAC
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 08:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EA121E08A;
	Fri, 27 Jun 2025 08:43:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01231DEFD9;
	Fri, 27 Jun 2025 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751013819; cv=none; b=tW7yCgoOe9h5OL+TAgLK9Ufi+KsCm3RMgO3CLGA/qyQGkSrtyhIXGe/jyBGzGlb5y3jpkCb+8kSJMgU6fk8IBIXDiPSHPUqptuUCmZ4DyyP9EsvgMabNI0i1iWsOQmueZXG3J+HldEJ3jNcSjCcHNjXCEiBYHjw1eVfxs4aG5EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751013819; c=relaxed/simple;
	bh=pYqfkTURafLryInbR2tTfRtApge2Fnga/mPhmWTyaA8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VEaluserbhOUwT6riWTWRIUOOkXncS9i2CSg8VQis3bJxpS3qlygWnBje1EQ6YkRR4wYcDaLuwBEW35C67O9ah1ygXDKzTK7JSzJ8hO22MfKII79e0qZ1WcbBZmLj0bt5lnjovox+nlwaefxYm1aPUbEnAZLgYi4TecrEtH29vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bT8CY3pwlz6L5Dr;
	Fri, 27 Jun 2025 16:40:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7652C1402ED;
	Fri, 27 Jun 2025 16:43:35 +0800 (CST)
Received: from localhost (10.48.153.213) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 27 Jun
 2025 10:43:34 +0200
Date: Fri, 27 Jun 2025 09:43:32 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v17 06/22] cxl: Support dpa initialization without a
 mailbox
Message-ID: <20250627094332.0000223d@huawei.com>
In-Reply-To: <20250624141355.269056-7-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
	<20250624141355.269056-7-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 24 Jun 2025 15:13:39 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
>=20
> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
> memdev state params which end up being used for DPA initialization.
>=20
> Allow a Type2 driver to initialize DPA simply by giving the size of its
> volatile hardware partition.
>=20
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> =BA
> ---
>  drivers/cxl/core/mbox.c | 17 +++++++++++++++++
>  include/cxl/cxl.h       |  1 +
>  2 files changed, 18 insertions(+)
>=20
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index d78f6039f997..d3b4ba5214d5 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1284,6 +1284,23 @@ static void add_part(struct cxl_dpa_info *info, u6=
4 start, u64 size, enum cxl_pa
>  	info->nr_partitions++;
>  }
> =20
> +/**
> + * cxl_set_capacity: initialize dpa by a driver without a mailbox.
> + *
> + * @cxlds: pointer to cxl_dev_state
> + * @capacity: device volatile memory size
> + */
> +void cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity)
> +{
> +	struct cxl_dpa_info range_info =3D {
> +		.size =3D capacity,
> +	};
> +
> +	add_part(&range_info, 0, capacity, CXL_PARTMODE_RAM);
> +	cxl_dpa_setup(cxlds, &range_info);
I missed that this function can in general fail.  If that either can't occur
here for some reason or we don't care if does, add a comment. Otherwise han=
dle
the error.

> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_set_capacity, "CXL");
> +
>  int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info =
*info)
>  {
>  	struct cxl_dev_state *cxlds =3D &mds->cxlds;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 0810c18d7aef..4975ead488b4 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -231,4 +231,5 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(stru=
ct device *dev,
>  int cxl_map_component_regs(const struct cxl_register_map *map,
>  			   struct cxl_component_regs *regs,
>  			   unsigned long map_mask);
> +void cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>  #endif /* __CXL_CXL_H__ */



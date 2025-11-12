Return-Path: <netdev+bounces-238031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D46F8C52EEA
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 16:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A6571356E2A
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 15:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412B5347FCA;
	Wed, 12 Nov 2025 14:57:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DE4347BC9;
	Wed, 12 Nov 2025 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959471; cv=none; b=Egpi3kPnKli2UUGrqVQRmK1F/3KeIThpXfSJTcTRSOzrQ2ANG45Q4eLx9FyFBH5hR2JoAkHHPn//HDsSWbYbKQtUHTVUZHl3HU3y8c04Y8kFHTSiGXP7l23PKcwL7hOPkixMdjKske4iKTy/yQ4ESW78rBLBO1KztCUnLZShwRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959471; c=relaxed/simple;
	bh=aTwqvPfWOeYJQqqzPM5NDZoXgiN4DjHpYrR/AV+lr5M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V971PUpCuHxUJyhRoHPMaTZLnaEpe66kvx+Ewh6NZOYalMnM+b937rnOMuMjciR6N6t+iP0GaT899h+OIwPoo9iQasnKoGK/gUOEDJTszXZ9vhITtIXfhlZghyFNJwyIZq5pwdG6Q+bmT7zHzeYZ88K1ZcTbiOekCeCr+YdAD6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d662H4kKXzHnH8m;
	Wed, 12 Nov 2025 22:57:27 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id E0042140371;
	Wed, 12 Nov 2025 22:57:46 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 12 Nov
 2025 14:57:46 +0000
Date: Wed, 12 Nov 2025 14:57:44 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
Subject: Re: [PATCH v20 02/22] cxl/port: Arrange for always synchronous
 endpoint attach
Message-ID: <20251112145744.0000595f@huawei.com>
In-Reply-To: <20251110153657.2706192-3-alejandro.lucero-palau@amd.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
	<20251110153657.2706192-3-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 10 Nov 2025 15:36:37 +0000
alejandro.lucero-palau@amd.com wrote:

> From: Dan Williams <dan.j.williams@intel.com>
> 
> Make it so that upon return from devm_cxl_add_endpoint() that
> cxl_mem_probe() can assume that the endpoint has had a chance to complete
> cxl_port_probe().
> 
> I.e. cxl_port module loading has completed prior to device registration.
> 
> MODULE_SOFTDEP() is not sufficient for this purpose, but a hard link-time
> dependency is reliable.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>



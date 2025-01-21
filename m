Return-Path: <netdev+bounces-159988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71561A17A40
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 10:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B039716A216
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 09:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7128E1B87F0;
	Tue, 21 Jan 2025 09:34:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93BE1BCA0E;
	Tue, 21 Jan 2025 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737452091; cv=none; b=XmulzRO+GE2V+O4cuCxP9B0+RBP5DAN5Y3M3RTZAxJOhAQYEGY3qOCCAUV5ME7VY6nlTYYWx+Sx4DvUZ+Cmx1ayFuOe63hgGL8RhaKxDHeAPWtQuZdaOtQaU6F7erlTj06ljp5nrV8GloiNGDMxp5pdST9X05JzmHsfdHoorPhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737452091; c=relaxed/simple;
	bh=R97qkQ4CJAxdQj0eC/dbAFLCcXtY/of9Qvyl2eGoNn4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OZXxkxUL9bdR3slrBnYWHO/+002cozHlE4YkAbNv3Pi6IlMFTVWmC1cvig+C/ZM3QN4zNIRg351BCczroTS/acK3wYZMmvujNz7j3krYVGC7bcezu9pqLZaB4xoPTAyy8kYOTGFA2uO953K0Smb0Air4H5VHPnwFsNwkFx7hkDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ychnw4xr9z6M4Jq;
	Tue, 21 Jan 2025 17:32:52 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 82EF1140390;
	Tue, 21 Jan 2025 17:34:46 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 21 Jan
 2025 10:34:34 +0100
From: Gur Stavi <gur.stavi@huawei.com>
To: <horms@kernel.org>
CC: <andrew+netdev@lunn.ch>, <cai.huoqing@linux.dev>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <gongfan1@huawei.com>,
	<guoxin09@huawei.com>, <gur.stavi@huawei.com>, <helgaas@kernel.org>,
	<kuba@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luosifu@huawei.com>,
	<meny.yossefi@huawei.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<shenchenyang1@hisilicon.com>, <shijing34@huawei.com>, <sumang@marvell.com>,
	<wulike1@huawei.com>, <zhoushuai28@huawei.com>
Subject: Re: [PATCH net-next v04 1/1] hinic3: module initialization and tx/rx logic
Date: Tue, 21 Jan 2025 11:47:06 +0200
Message-ID: <20250121094706.3950522-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250116181037.GE6206@kernel.org>
References: <20250116181037.GE6206@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 frapeml500005.china.huawei.com (7.182.85.13)


> > diff --git a/Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst b/Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst
>
> ...
>
> > +Completion Event Queue (CEQ)
> > +--------------------------
>
> nit: the length of the "---" line doesn't match that of the line above it.

Ack

>
> ...



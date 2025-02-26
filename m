Return-Path: <netdev+bounces-169703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CDBA45522
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 06:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA28189B614
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 05:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B595267B0B;
	Wed, 26 Feb 2025 05:57:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A6726772E;
	Wed, 26 Feb 2025 05:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740549423; cv=none; b=uTduEkEZw8/VUsvcVr2PXauJOx4UroaG+VgQNgxa1zYYNQOvcpCxnJBxVVVcy3PUKBwd88FrcEylqJ3wTJXRCIDOTx6VQbEJePUKzkhLZtG7t6O4kxuQHGglCLUfQCu+rTpIaaRD2r8LnMMiR2M/z6EDZ81Y3c95T6gflR2ESoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740549423; c=relaxed/simple;
	bh=f3AGTiEZqNUqow84PeoV+tMi66XaEGYtHQp5fpuqWbM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CULDRArrYavKKAa1lOzplu27pohQxHY0HuuthoE2/DXQ9NOvK2Rqb3L10uPYfMcujxM1LR0wuLg0CnwEW3Zec0I4xckLlh/wO0CnkFd7z2Pl1+988lXQvi6w6PJ2RKWpgW3iP4OcR0XVnBZjxXyOHaBJaA7CnMtGYJ0RNkxbm4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z2kF02pLHz6GDnJ;
	Wed, 26 Feb 2025 13:54:12 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 9BC2D1400DD;
	Wed, 26 Feb 2025 13:56:58 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 26 Feb
 2025 06:56:47 +0100
From: Gur Stavi <gur.stavi@huawei.com>
To: <gur.stavi@huawei.com>
CC: <andrew+netdev@lunn.ch>, <cai.huoqing@linux.dev>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <gongfan1@huawei.com>,
	<guoxin09@huawei.com>, <helgaas@kernel.org>, <horms@kernel.org>,
	<kuba@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luosifu@huawei.com>,
	<meny.yossefi@huawei.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>, <shenchenyang1@hisilicon.com>,
	<shijing34@huawei.com>, <sumang@marvell.com>, <wulike1@huawei.com>,
	<zhoushuai28@huawei.com>
Subject: Re: [PATCH net-next v06 1/1] hinic3: module initialization and tx/rx logic
Date: Wed, 26 Feb 2025 08:14:06 +0200
Message-ID: <20250226061406.648948-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250226060847.648823-1-gur.stavi@huawei.com>
References: <20250226060847.648823-1-gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 frapeml500005.china.huawei.com (7.182.85.13)

> > On Tue, 25 Feb 2025 16:53:30 +0200 Gur Stavi wrote:
> > >  .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    |  25 +
> >
> > drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c:14:36-41: WARNING: conversion to bool not needed here
>
> Don't know what this comment refers to.
> There is nothing related to 'bool' in line 14 or 36-41.
> The only place 'bool' appears in the file is line 243.

My mistake. I looked at the full file instead of only the 1st patch we
actually submitted.


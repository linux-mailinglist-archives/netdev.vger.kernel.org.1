Return-Path: <netdev+bounces-148600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC86B9E2A3A
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 19:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 871A1B35297
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 17:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175051FA152;
	Tue,  3 Dec 2024 17:14:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA00918BC1D;
	Tue,  3 Dec 2024 17:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246079; cv=none; b=nWYWpvbu7HHcZiSY3garnOyChiPPxzme2Wu8AIOpYMYZhLZyfJ/BSJ0OxWHISmsByuu3S2yEW79T3MOS5eoytZhgCdILBdhIZrSsViwCjwsmyy675v/YUYP7f11SZBBQvFMJWrGe3qIq7me0NEHShr9P/ozOVRK+PVRZauZhi8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246079; c=relaxed/simple;
	bh=r08B2JBddPOuESU+/w8o4lsEqsB39x+7zALxq7cEeO8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JufvkOX6uiJ7DFreXbbIvGOmpelUnzQfKG/8uT4hUMAth02KSLMomJKL4UIWmpgNc0smJzMV20ep/hsoCuGC6I12NjTTHPXL0OuHJvrP1SR11l0exAYS1sz22crdhR2iWdkmAndyvJL0fDUjmY3FXAcydcnwlzFKUkBzt5b0M20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y2nLQ4cnkz6L7DB;
	Wed,  4 Dec 2024 01:13:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 50AF9140A34;
	Wed,  4 Dec 2024 01:14:33 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 3 Dec
 2024 18:14:32 +0100
Date: Tue, 3 Dec 2024 17:14:30 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alucerop@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <nifan.cxl@gmail.com>
Subject: Re: [PATCHv4] cxl: avoid driver data for obtaining cxl_dev_state
 reference
Message-ID: <20241203171430.00000d0e@huawei.com>
In-Reply-To: <20241203162112.5088-1-alucerop@amd.com>
References: <20241203162112.5088-1-alucerop@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 3 Dec 2024 16:21:12 +0000
<alucerop@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> CXL Type3 pci driver uses struct device driver_data for keeping
> cxl_dev_state reference. Type1/2 drivers are not only about CXL so this
> field should not be used when code requires cxl_dev_state to work with
> and such a code used for Type2 support.
> 
> Change cxl_dvsec_rr_decode for passing cxl_dev_state as a parameter.
> 
> Seize the change for removing the unused cxl_port param.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
I wondered if the other places this assumption is made about drvdata
would cause you trouble, but they seem ok for now at least as
error handling code you probably won't use.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


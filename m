Return-Path: <netdev+bounces-201022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8022AAE7E00
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 529CA7A56AD
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DC827FB27;
	Wed, 25 Jun 2025 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h12oAJ9X"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3A0202987
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845111; cv=none; b=b0shsJmOU5IAUSUXP+eTnkI4Un3Llj3+8YhJNEMXmIwnX0JBdDjl6XObh04X08H6qrcCCyhfMwWc59AwjUk7ZRevZcnUfePcetMbV1StWVgKAIReuiNghZCYRmffSaARgNLH/Qck9G2hTzjGkBIF2FNLCyNEXsok5By7kyGCcrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845111; c=relaxed/simple;
	bh=orA5hl8mOrlRqgtAYdazEQT9m/BuTnqj5P9Ji7geJkY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6dBCdr6AJ7dbWY184w72iUod6a0xqcj3LXkTR/aN4TI7nsAd4nBW5AnJUzL4iuHtKONj9j3Jf4NUSLHiFpquVqhQTlDsH5WcqNOnv3G9Up69FcINU2w9ZFw7qkg/MpP+zW9GR28M1ZyyXSoRupUYmZtoImkq6hcSLLyGVns+gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=h12oAJ9X; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55P9pdUR1429718;
	Wed, 25 Jun 2025 04:51:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1750845099;
	bh=yM9DZCjv2WCedL+KVH1DBViVqTEkaHpNXVwA6Vk3TY8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=h12oAJ9XwhDSkd/YIAcupnT5BtWQN4k3f/RVYq7PImBUltvrbbPOpaLI9MKXnizRN
	 Hpmk6q7c+NjXKNL8mBSxHnwceBotEP1lKIrAdRvcuhEIKGOjXp+FUi2IFQH90miSnN
	 eemSjP5RmJmH0zECAFD7kM0Fzq36isHJsT3iUO08=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55P9pdq22450676
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 25 Jun 2025 04:51:39 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 25
 Jun 2025 04:51:39 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 25 Jun 2025 04:51:39 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.169])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55P9pctn3424026;
	Wed, 25 Jun 2025 04:51:38 -0500
Date: Wed, 25 Jun 2025 15:21:37 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
CC: <mkubecek@suse.cz>, <s-vadapalli@ti.com>, <danishanwar@ti.com>,
        <netdev@vger.kernel.org>
Subject: Re: [PATCH ethtool-next v2] pretty: Add support for TI K3 CPSW
 registers and ALE table dump
Message-ID: <182fd7c0-52ad-4ff6-b08d-43480ee660f7@ti.com>
References: <20250619171920.826125-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250619171920.826125-1-c-vankar@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Thu, Jun 19, 2025 at 10:49:20PM +0530, Chintan Vankar wrote:
> Add support to dump CPSW registers and ALE table for the CPSW instances on
> K3 SoCs that are configured using the am65-cpsw-nuss.c device-driver in
> Linux.
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.


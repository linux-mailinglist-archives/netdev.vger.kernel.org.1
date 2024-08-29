Return-Path: <netdev+bounces-123029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B599637DA
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 03:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0163D2846CF
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 01:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DDC4C9A;
	Thu, 29 Aug 2024 01:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLyGuQGP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D41915AC4;
	Thu, 29 Aug 2024 01:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724895338; cv=none; b=O+PFa9zU2FKZ6QuK0A6P8VjvNjahQEryp/FU88oAHCMf5JAXjWHUtpX62jt1oe+bgCiUGtW+Uac1Aa2RZT1PHkbmVXspkbW0oJCbCJsPejtw09jPJ0VCv87c8YTzsw37U0JjpdT8FlQO5VYJhHeZPL1QUUvyfacGqlgsKYhjgLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724895338; c=relaxed/simple;
	bh=OZy6MchE/gg+ChcU3IXmYsoShKIt3TJI+gN9/sk3Ru8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYE++XEsjA3ihC8ObAktTBj8UaOTHDadrNZA6/gdY3uX2aO9FJppweRSuPEx9R8m0nrWHY1UkfywDtREYVdvErGil01rtfaKJDDnu2p9ji3b6aJEuLop3oiIfNi6eJHpCuMwi7yxtAA7DIQAfBMlQItdCu/qpdm66lS6C4B1SOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLyGuQGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3003BC4CEC0;
	Thu, 29 Aug 2024 01:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724895337;
	bh=OZy6MchE/gg+ChcU3IXmYsoShKIt3TJI+gN9/sk3Ru8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eLyGuQGPGKKfv7yG+DsHJSztvajpvy7fYjQUjRrFnN68bm9yIuZRq22F4bX2xgbsS
	 Ez1gtQEDfoJ2EYCeNSGI85lFH7EmaFRAwM03Tn/2fVUWKYNign47CUDuMhiCj3b/42
	 uwEIkrIDbNiVqi5BdVa4L7Jh5FKSP242R4AlMoayQ93AVg3T+Ywik4q4ujZZtBLzra
	 391AsSNDsUcIiHpIiEYZG9jSax19kL+P90U5N+n6cS1kFZQ2A73tLxL720Pl7U88N3
	 0X44cIFZwQYVBg8aZJcRqpdTVuNfXbAMYeNEI4jW6oQeef0gKkVje3U0lRB6f7WG3F
	 8Em/pNI6FKQdg==
Date: Wed, 28 Aug 2024 18:35:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>, <andrew@lunn.ch>,
 <jdamato@fastly.com>, <horms@kernel.org>, <jonathan.cameron@huawei.com>,
 <shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 net-next 04/11] net: hibmcge: Add interrupt supported
 in this module
Message-ID: <20240828183536.130df0fa@kernel.org>
In-Reply-To: <20240827131455.2919051-5-shaojijie@huawei.com>
References: <20240827131455.2919051-1-shaojijie@huawei.com>
	<20240827131455.2919051-5-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2024 21:14:48 +0800 Jijie Shao wrote:
> +	ret = pci_alloc_irq_vectors(priv->pdev, HBG_VECTOR_NUM, HBG_VECTOR_NUM,
> +				    PCI_IRQ_MSI | PCI_IRQ_MSIX);

These are not devm_ -managed, don't you have to free them?
On remove and errors during probe?


Return-Path: <netdev+bounces-134010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF36D997A9C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 04:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D020C1C212B7
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 02:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0936148300;
	Thu, 10 Oct 2024 02:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mj7rX9Nc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E1EBE57;
	Thu, 10 Oct 2024 02:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728527839; cv=none; b=HU2hX/+jk1Nk7uTHyIFHGoqdas4gKEYSmG1BpIRwqXpkjyMAdFF+5kP0bQt6u1Jp2o99QU1s0Jo1gadHzpPPQUyZc6XCn2/yJE1fcPJJ+6zKQ+yGrW8nm3L2mmu4XmTyqQYviU4zI6mLIUV0tqHV+zhpHCfyR62ftTxCk218JlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728527839; c=relaxed/simple;
	bh=O9jlulRNTzLKY2OseZsYYFbTy7xtTcakr/E6SYynmuc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oY4CItD7+rnO0s1R3Ltzzbccwg/jetWqW6EcFQBQxMQXwj6XLEKbbttTBeQXJ0dZT+51enBgSweSFKLwlz7BC4Dv2j7GqCRrZiRYWVl4XFgbQAH6MOtOZSHBdRN546HAYOq0z85J8eC3RgFqTH9iYA/iYq9ju7ol7kkSYX5jHF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mj7rX9Nc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B6BC4CED0;
	Thu, 10 Oct 2024 02:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728527839;
	bh=O9jlulRNTzLKY2OseZsYYFbTy7xtTcakr/E6SYynmuc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mj7rX9NcYK06lw6gjrol16PfLFDkkWxCe5VWnnTnT9v3cOJV3H4PwnY55hiAJpV6J
	 d40Aqw4YSADTYgzCrNa2yYORXc0z6KsdHs5Wyd/Y6hyElaCBEi7k99cKnDU/X7rLL+
	 ZXKQjwq21YllN9oA/bfAix4mrjCgzlemQYwlN1DDzjj6ZvClC/I8JYZk+TkheKcfmp
	 5ne5j7IJM0BnKjB5c4StPT1/wEEkc9GDUDgYOtZE7A2Q7hXY8/WIj01tYIHyQDRu/c
	 +InCrwgJ8jrM6DOdX0NETeDibZLK2fHBcBxCVdkKsqAdYaEFbEdcmREBs9iFHFo2GX
	 vBEIfzewu0Mbg==
Date: Wed, 9 Oct 2024 19:37:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>, <andrew@lunn.ch>,
 <jdamato@fastly.com>, <horms@kernel.org>,
 <kalesh-anakkur.purayil@broadcom.com>, <christophe.jaillet@wanadoo.fr>,
 <jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
 <salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V11 net-next 10/10] net: hibmcge: Add maintainer for
 hibmcge
Message-ID: <20241009193717.7b02e215@kernel.org>
In-Reply-To: <20241008022358.863393-11-shaojijie@huawei.com>
References: <20241008022358.863393-1-shaojijie@huawei.com>
	<20241008022358.863393-11-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Oct 2024 10:23:58 +0800 Jijie Shao wrote:
> +W:	http://www.hisilicon.com

The W is for driver information, please put something more relevant
here or remove the W entry.


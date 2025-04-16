Return-Path: <netdev+bounces-183117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87969A8AE7C
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 05:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81CB67A61FE
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 03:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3712046B1;
	Wed, 16 Apr 2025 03:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBVvEAlY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501CE13AD05;
	Wed, 16 Apr 2025 03:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744774960; cv=none; b=O5Wa0ACwLR0BdAdVt0Apxrg15cHopCQv7yoyrv3lfQZ09V7ck2ac+feRsqj2cTl7lGUhFNb7fD7JVoDHaR9QGMzjiWqxQd+66SuI9M6hH5xHewCrmAXTUyaBiHZEo197hbrLEDtrKcdAuGRE6tlgPK6zuh1AfIm0paUrvODveL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744774960; c=relaxed/simple;
	bh=nBws4V36RnH91dCzptgVsPeT41zfd8Mcsqg5oOphTmM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjEatwWbu3a3YcQBnyeiSBV7tSn4mFaRi/gJRo4GVTqQW4jyFv1bRoYys7i3Nmin5Nogy3IUggzncwsUc9diEyC1XU8TkNbKKF8/0pu0BDizxhb4lkv90xszypqXwTLVCnSBmcPIxBGyLpLE8r20OhOl5JiFL/Yiv3Mt8rgGuyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBVvEAlY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B85DC4CEEA;
	Wed, 16 Apr 2025 03:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744774959;
	bh=nBws4V36RnH91dCzptgVsPeT41zfd8Mcsqg5oOphTmM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MBVvEAlYhsk3J9rwRldL2+ieUj/bNTseHBxu1+7L3Me3kDQ17RGcYprgU9YHSvXGL
	 5lToJG+oaBS6Nht1qX4i9QUIQUfCi1CWMF1S4cOol8GrXNBwycIR3hguSmXPgIY8/z
	 CsEVLaRu/In1lPNQzpki0+FvVwthusn3MmW5QB4F78Tl/c6kNVAn2Te+bmjyXt841Q
	 nhEnNYjeHkXgNeucnss2P43xdj7lRULMSPMH//6GX8eEFLDqBFsqieOBOK4kPZ3TYU
	 /JjHBJZlVd25Cu67lR2jdKefmJ1e2yvoXqeXp+Uw1ogZRrF0I6/ra3XMgZO4r1GdR6
	 /UvBsgYY/9nBQ==
Date: Tue, 15 Apr 2025 20:42:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, christophe.leroy@csgroup.eu, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 net-next 04/14] net: enetc: add MAC filtering for
 i.MX95 ENETC PF
Message-ID: <20250415204238.4e0634f8@kernel.org>
In-Reply-To: <20250411095752.3072696-5-wei.fang@nxp.com>
References: <20250411095752.3072696-1-wei.fang@nxp.com>
	<20250411095752.3072696-5-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 17:57:42 +0800 Wei Fang wrote:
>  	enetc4_pf_netdev_destroy(si);
>  	enetc4_pf_free(pf);
> +	destroy_workqueue(si->workqueue);

I think that you need to flush or cancel the work after unregistering
the netdev but before freeing it? The work may access netdev after its
freed.


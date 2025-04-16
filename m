Return-Path: <netdev+bounces-183369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFA6A90837
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D14A16528F
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768FD1EE032;
	Wed, 16 Apr 2025 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsS60ONa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528E71A2643
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 16:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744819422; cv=none; b=D3mjOMOgM5vVchzh37tfBoxstuTmep5OLj5L2oueCjIsdmgRswRVl0IL60Txw3M8ryf94shrTuOAH76VogasW7vlwo0XJNYKPo4gY/Gw8BDM4Mx8p9nAD3ixKkrA+0Pe9R5IxkBE4V+xAbKdFnFvxLV9Cxpi9Ifcr2zmBwcO3KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744819422; c=relaxed/simple;
	bh=usewujL41h/hBfaWMuKtroQRdbGAjFgftnV1hpjCjGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeDM5RZKk4tMxZVwjAR0cn/unpKRH6IrzNPLd5Gqbe4YBsH6sh0EnASWTi/1ZOL9cwD2SSs32aXGQYXXejpmpcrALS1R67pxs1ad/Uq6aSzytdQPaXKrNyzP/MfGD9xM6NyNUGY0rneaU2q5+2IpKaEV4YIBLTgMfuFhg2O2SgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsS60ONa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC12FC4CEE2;
	Wed, 16 Apr 2025 16:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744819420;
	bh=usewujL41h/hBfaWMuKtroQRdbGAjFgftnV1hpjCjGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QsS60ONa8vIHyB7MhGlyZ7OCL0MdIPUr9CO7p95YXMRHixTBSQebgbNcoEZvx9QTv
	 9Rg9qWnkd7hv4OyCHq3frA4VePkJUUDHsYykvCLlESJzlS8PKfcT/ekwLhpmgTtk/o
	 XQUBe1v6p+lwEWsx335degn90tkfg6QcuBRzLdV+Fm65XknweZeBISv7rTZoHdeMxv
	 3/ydxS4PlCywSg0NGRA14W633lM2Bu+fkCrbMmCk0IUZb+q4pjJ6MvkUdc4HaoCZIV
	 9l3QAzjH9LXIFN0ZlFuhkwAlZLTO9VZV7GhEwXCjrnY/i73hl2MM0w7c99BZA7MeFk
	 jdIikLceOnkWA==
Date: Wed, 16 Apr 2025 18:03:36 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH] r8169: do not call rtl8169_down() twice on shutdown
Message-ID: <Z__U2O2xetryAK_E@ryzen>
References: <20250415095335.506266-2-cassel@kernel.org>
 <4f8d3018-d7e5-47e5-b99d-550f8a4011ee@gmail.com>
 <Z_-7I26WVApG98Ej@ryzen>
 <276986c2-7dbe-33e5-3c11-ba8b2b2083a2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <276986c2-7dbe-33e5-3c11-ba8b2b2083a2@oss.qualcomm.com>

Hello Krishna Chaitanya,

On Wed, Apr 16, 2025 at 09:15:19PM +0530, Krishna Chaitanya Chundru wrote:
> On 4/16/2025 7:43 PM, Niklas Cassel wrote:
> > 
> > So perhaps we should hold off with this patch.
> > 
> I disagree on this, it might be causing issue with net driver, but we
> might face some other issues as explained above if we don't call
> pci_stop_root_bus().

When I wrote hold off with this patch, I meant the patch in $subject,
not your patch.


When it comes to your patch, I think that the commit log needs to explain
why it is so special.

Because AFAICT, all other PCIe controller drivers call pci_stop_root_bus()
in the .remove() callback, not in the .shutdown() callback.

Doing things differently from all other PCIe controller drivers is usually
a red flag.


Kind regards,
Niklas


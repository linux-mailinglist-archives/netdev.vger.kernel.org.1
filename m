Return-Path: <netdev+bounces-224184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCC0B81E6D
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 23:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943062A81C3
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 21:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE95304972;
	Wed, 17 Sep 2025 21:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jv4Erpib"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB38B302CB9
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 21:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758143594; cv=none; b=bSlyvc/ltGxGV+XfkyYC6nAzmO7f3UwvHtpuY1uEpgK+AQ4x1P/LNVL/53vPulMnUwdIWsaTW9Sl02jZAxQX96bcPxV8yqIIvyutmNya4Udp9gUkPOf2i3MjG/xjIiz8yuFhVOEVPus6FEf0DVW1m1Vjg3g09DK0i7tpYoJr5s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758143594; c=relaxed/simple;
	bh=aTiqCbYKsL4zedmsTSIWfS2vs6OPaddBz1v7A6w3xdg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aUW+WvHAEKLOcZFjr9su45jZc4ZFxvvhuXuulcOSJoCLrckk+ZJuG4fAyZUt/v6oFq5lq1nAmegrd+KBrfiaNPCJ5Nkhh+TnBpfxA1UFw0Jb6x+30EZXdtX8X3Lc/QPkwH2QvbndGWFaiVThZRfCaiwEtOFf4iKHR1UIm9Z6EE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jv4Erpib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8075C4CEE7;
	Wed, 17 Sep 2025 21:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758143594;
	bh=aTiqCbYKsL4zedmsTSIWfS2vs6OPaddBz1v7A6w3xdg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jv4ErpibXD8uuQPxkNxm+RAFQgT4wMsaKInd2TWOxydYds3vqtKYxnCtVaP552XHk
	 8CAyjtqhRPjCNhIivyU4v6njVKigmlBfHfY4nYiPwBbQU1o5t6PR6++hyrVkRIxulN
	 zd0hqumhmsaQQD+4TXtGBUE1/svvxV/rzEnhJGtOCiriSKnegWU5JUmgL3P4W3JcMN
	 1pguJx+QbmU6+7pUzwe4xtUQsqBIUkAYZjSssKKwa9MQbuTDhSEmOx23w6JfoCUt0o
	 Fg/1FpcHEt0fWKmDYZhUf5WtfR1wV7N2V2rTvpUALzaWDjQTs0e6QtWIlpTkkWDapA
	 TzQnqxJuahfBw==
Date: Wed, 17 Sep 2025 14:13:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: <netdev@vger.kernel.org>, "'Andrew Lunn'" <andrew+netdev@lunn.ch>,
 "'David S. Miller'" <davem@davemloft.net>, "'Eric Dumazet'"
 <edumazet@google.com>, "'Paolo Abeni'" <pabeni@redhat.com>, "'Simon
 Horman'" <horms@kernel.org>, "'Alexander Lobakin'"
 <aleksander.lobakin@intel.com>, "'Mengyuan Lou'"
 <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v4 1/2] net: libwx: support multiple RSS for
 every pool
Message-ID: <20250917141313.43b71217@kernel.org>
In-Reply-To: <039301dc27a6$194e79a0$4beb6ce0$@trustnetic.com>
References: <20250912062357.30748-1-jiawenwu@trustnetic.com>
	<20250912062357.30748-2-jiawenwu@trustnetic.com>
	<20250915180133.2af67344@kernel.org>
	<038c01dc2775$9f4c58f0$dde50ad0$@trustnetic.com>
	<20250916192544.36c20fc1@kernel.org>
	<039301dc27a6$194e79a0$4beb6ce0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 15:38:45 +0800 Jiawen Wu wrote:
> > > Deleting VFs will reset these configurations.  
> > 
> > You shouldn't reset user-set configuration of the PF when SR-IOV
> > is disabled.  
> 
> But the maximum queue number of PF is different when SRIOV is
> enabled or disabled?
> 
> And for the global RSS table (non SR-IOV mode) or multiple RSS table
> (SR-IOV mode), the table size is different on hardware design.
> 
> How could I keep the RSS redirection table during the mode switching?

Only if the user requested a particular config.

If netif_is_rxfh_configured() returns true and the RSS table contains
the ring you're trying to disable you should reject the attempt to
enable SRIOV.

For the change in table size you can just reject if
netif_is_rxfh_configured() for simplicity (user can reset the table using 
ethtool -X $ifc default
You could support "shrinking" the table if both sub-tables are
identical. But IDK if its worth the effort. Setting custom indir tables
is fairly rare.


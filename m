Return-Path: <netdev+bounces-241382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C75C83459
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 04:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0733ABF51
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 03:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9CA284689;
	Tue, 25 Nov 2025 03:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrp7hWA+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91586283FF5;
	Tue, 25 Nov 2025 03:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764042505; cv=none; b=e1f1/XLUDvAc3bUTtOX27m1apXBPgq7P8Wx+TMwEjyE+apgwuQSczJW5qKnuIYvP2jY7F5LlUT5rm9w4be8mouNHEfAxZwy7KaIL/SWDkwROGb0asY9aNb8FDP8+nC0nUBGJXcZJjvTz+srXc6MBffmpnfkSE/LQM/WzrjNHADs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764042505; c=relaxed/simple;
	bh=Lzma0UMaI7nmo9PE8B+nQQvyo+UTYzUfPbCUcc53mG8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDjxu6W7Mby4WMCbEvM8wfaSYRkXqkuNIwcwvy4Ar5U+2ajWxw//zt+AYER+tnHIwyXN6r+kNu41Je05HX8T5rOoAEuRejZ9PVdOVk16DBX2rYvfGGMOz9qFa+o2sGYgexUOXWzUfiXuuoLQpjnlV3E3OXhkQRhb7rOkM+l5FTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrp7hWA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A58C4CEF1;
	Tue, 25 Nov 2025 03:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764042505;
	bh=Lzma0UMaI7nmo9PE8B+nQQvyo+UTYzUfPbCUcc53mG8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jrp7hWA+xYQJAnp3/csPpKJPwLpnK4gpEb20S2zAUQalxd87nTVIXFeJqhwWuGRn3
	 z2j0XmnFb+FOstOnDvINuM6G4xNG5m6i48MBWDLG0KEqJ0WEIfaqeAlU6q17LGW/33
	 25RNWI/DhWrfzBxSUwyXNi4dJsfnWbVFFWWJt7CuWuGJrHWgeGuMXMol3hNaT//nI5
	 v4pGWwyGxhR2uv7Po9G7ZAwwhxammG9XJp17WePCwq+rDe8fIeaJrQ6xyzxNsdYHFK
	 c0rdL/6CGZlmiQzmwTNeClxolTZ8DTk5oPqEH3ACj5T5OtGX6ak3bpQUs8Im32Bfd+
	 9NGPv2NSJ75og==
Date: Mon, 24 Nov 2025 19:48:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: aleksander.lobakin@intel.com, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 michal.swiatkowski@linux.intel.com, michal.kubiak@intel.com,
 maciej.fijalkowski@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next 1/8] i40e: extract GRXRINGS from .get_rxnfc
Message-ID: <20251124194823.79d393ab@kernel.org>
In-Reply-To: <20251124-gxring_intel-v1-1-89be18d2a744@debian.org>
References: <20251124-gxring_intel-v1-0-89be18d2a744@debian.org>
	<20251124-gxring_intel-v1-1-89be18d2a744@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Nov 2025 10:19:05 -0800 Breno Leitao wrote:
> + * Returns the number of RX rings.

I suspect you used this format because the rest of the driver does,
but let's avoid adding new kdoc warnings. I think Andy is trying
to clean up the "Returns" vs "Return:" in Intel drivers..

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c:3530 No description found for return value of 'i40e_get_rx_ring_count'

(similar warnings to first 4 patches of the series)
-- 
pw-bot: cr


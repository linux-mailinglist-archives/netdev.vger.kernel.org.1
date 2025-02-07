Return-Path: <netdev+bounces-164152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 248F5A2CBEE
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 19:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11811685E2
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 18:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D338188580;
	Fri,  7 Feb 2025 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZ59KkDy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685891AE01C
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 18:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738954070; cv=none; b=FsU03edAd2wG1unl4yaDCt7AbT63xdM6w0n/GptQ5bkq/VKEHn71kTf5OaYAbWXSZ4mg8/BEilI0YX+W1X2LenC3lANIT7iBYxzx3Shwl3L4UQbfLcvKwWf6dRCA0NV9s6Cu6i/Mg6KXz+nH6S68Kmo/qSW7Pva3wjH4RaT77gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738954070; c=relaxed/simple;
	bh=SNHeOCTyWvD96DD7OFG4ME5iDM/iA2UYMrI1ko53A1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WKCxg/J0h9C1boeLKOt1ohAhTH3mZquX7bSwjuuxpYIRoFF8O6Bu/UtO9a5kRKLB46CttlMUCyvBvq3gQYk9MqOJYaP6xRopBlWZpWLydrtAzc3uh03hiULhxlDMI2fnVLItYI8dkU3m5kxq+Z8RiJ2AQ2TXXO/UJS8IXxULANY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZ59KkDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537C5C4CED1;
	Fri,  7 Feb 2025 18:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738954069;
	bh=SNHeOCTyWvD96DD7OFG4ME5iDM/iA2UYMrI1ko53A1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sZ59KkDygg+JhdakwAIIaXTh/jB2sEZVMgaNTU8mU7umEwJCkPDTpxaPlqNXuPl5c
	 eb6Qg0U8P+nK8dwlZNcaJ4bpfTxmKnLYbYT9HoKQqXwXXIj8cLDio6iBBhXFJrP0c6
	 JQyY1ns+l319hN7KOkCKaoZStq8OgRS4mlq9CIdJ93r8gZewDAqW1YDhtNCdkXLahS
	 CmMJP038DbUFc1RsOu1oJ7gYWnH5ApUI3jXeb6yDvckVO53salmtMsPAuZfFTcXHPr
	 HuIWiOTBNMzUwTG0BPaVjl13F5dO29u3hwCK9q9unDvyNYAyAULVz6iPvUuvhIHmEw
	 6rp8hX9rFWBdw==
Date: Fri, 7 Feb 2025 10:47:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 andrew+netdev@lunn.ch, edumazet@google.com, horms@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, michael.chan@broadcom.com,
 tariqt@nvidia.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jdamato@fastly.com, shayd@nvidia.com,
 akpm@linux-foundation.org, shayagr@amazon.com,
 kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v7 0/5] net: napi: add CPU affinity to
 napi->config
Message-ID: <20250207104748.27c7f96b@kernel.org>
In-Reply-To: <20250204220622.156061-1-ahmed.zaki@intel.com>
References: <20250204220622.156061-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Feb 2025 15:06:17 -0700 Ahmed Zaki wrote:
> Drivers usually need to re-apply the user-set IRQ affinity to their IRQs
> after reset. However, since there can be only one IRQ affinity notifier
> for each IRQ, registering IRQ notifiers conflicts with the ARFS rmap
> management in the core (which also registers separate IRQ affinity
> notifiers).   
> 
> Move the IRQ affinity management to the napi struct. This way we can have
> a unified IRQ notifier to re-apply the user-set affinity and also manage
> the ARFS rmaps. The first patch  moves the ARFS rmap management to CORE.
> The second patch adds the IRQ affinity mask to napi_config and re-applies
> the mask after reset. Patches 3-5 use the new API for bnxt, ice and idpf
> drivers.

Hi Ahmed!

I put together a selftest for maintaining the affinity:
https://github.com/kuba-moo/linux/commit/de7d2475750ac05b6e414d7e5201e354b05cf146

It depends on a couple of selftest infra patches (in that branch) 
which I just posted to the list. But if you'd like you can use
it against your drivers.


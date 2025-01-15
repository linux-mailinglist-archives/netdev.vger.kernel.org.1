Return-Path: <netdev+bounces-158333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 147E7A116B4
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 02:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B586F3A816A
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 01:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67AC6F2F2;
	Wed, 15 Jan 2025 01:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJy1jSyl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24331805E
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 01:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736905087; cv=none; b=sFVJdwWSmCAnQZVD+PR2JXokN3MG6gvXWMeFYvbZkkdIepDTHNBoD20862H0z00PyYt/PReMm2b5byzlvutRmC1HIvlfN9fPkR9X5eFCQqsvLF5gMD69pA6W17r5bsQQzYRUpZCHG3YtUWj/i60S7iARa5WRs+qPoCLEAwhC0IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736905087; c=relaxed/simple;
	bh=rXDyVzqRYD1yqsER5V/bGDwGrtFOZ+HbyXu3jgH1F+I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DepLd/DgQIA39zKVeNilTa9lbAjpzDr84FPyfyXsrXG04CDfWLiaALI83B/Rq045dYnYLIEMiDzOOXFHJcrJ68EhbytMLxEMGqGVsAeIj2jMj2Bb8rt5+NCrS7dAnXAroMH+VcrrafOf84M/leYmwooboMF45NYUvatk4XMp2vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJy1jSyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D4BC4CEDD;
	Wed, 15 Jan 2025 01:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736905087;
	bh=rXDyVzqRYD1yqsER5V/bGDwGrtFOZ+HbyXu3jgH1F+I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nJy1jSylS3VUDL7OObgc1tMwFpn/1zDSr3o/+/c/vTMupvPMKsS6grWaPsB2+UxzV
	 w57b0ZhkF6q8/byuHtsIXxUFnlckdL/yKo7lEk3svNYaD+HnBSwZVjOTHZZ6S5u/ai
	 DYpEZ8LdC4Xw/Dw92AYyJPbwEOg6GfhgSiZHa7S//9rx5FzcApyOj3mE/cptcQEJCb
	 bKy0EwwGKRx+Vj2IF2D74gl41jeZnH2najGqxG0qI46G6PqOTMyNGqYtgzIHT68chN
	 HydPC2jJ3cQJ3DMewiXT5ZVhdDxsu3Yc2LHzANlD911WSWuRMnaGp36lN12GOV6b90
	 M/zjefGiW5YDg==
Date: Tue, 14 Jan 2025 17:38:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <andrew+netdev@lunn.ch>, <edumazet@google.com>, <horms@kernel.org>,
 <pabeni@redhat.com>, <davem@davemloft.net>, <michael.chan@broadcom.com>,
 <tariqt@nvidia.com>, <anthony.l.nguyen@intel.com>,
 <przemyslaw.kitszel@intel.com>, <jdamato@fastly.com>, <shayd@nvidia.com>,
 <akpm@linux-foundation.org>, <shayagr@amazon.com>,
 <kalesh-anakkur.purayil@broadcom.com>, <pavan.chebbi@broadcom.com>,
 <yury.norov@gmail.com>, <darinzon@amazon.com>
Subject: Re: [PATCH net-next v5 1/6] net: move ARFS rmap management to core
Message-ID: <20250114173805.23d254a9@kernel.org>
In-Reply-To: <5e9659aa-d21f-4ee9-8c0a-1d9191bbeb8c@intel.com>
References: <20250113171042.158123-1-ahmed.zaki@intel.com>
	<20250113171042.158123-2-ahmed.zaki@intel.com>
	<20250114140813.5a7d527f@kernel.org>
	<5e9659aa-d21f-4ee9-8c0a-1d9191bbeb8c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jan 2025 18:00:30 -0700 Ahmed Zaki wrote:
> > Similarly netif_napi_set_irq() may get called with -1 to clear
> > the IRQ number, which you currently treat at a real IRQ id, AFAICT.  
> 
> correct there is no handling for irq = -1. So netif_napi_set_irq() needs 
> to add the irq to the rmap only if it is > 0.
> 
> I need to clarify expectation of netif_napi_set_irq() because I only see 
> it called with irq = -1 in napi_add_weight. But you say it can be called 
> with irq = -1 to "clear" the IRQ.

I _think_ that's what Amritha had in mind. For queue <> NAPI linking
similarly we are expected to call the same helper with a NULL param.

> Does this mean that, if irq = -1, we need to "delete" the irq from rmap 
> if a valid irq already existed (which means this can happen as an 
> alternative to napi_del()/napi_diable())? or just skip adding irq to 
> rmap is enough?

I'm afraid we need both. Most drivers today simply never clear the IRQ,
they will just delete the NAPI and kfree() its memory. So we need to
"catch" NAPIs with IRQs assigned getting deleted and clean up the IRQ.

In the future some drivers may explicitly call the set with -1,
especially now that the IRQ has more implications than just getting
reported via netlink. We need to support that, too.

And for a good measure we should also throw in a warning if a driver
tries to set the IRQ but the IRQ is already set in the NAPI (not -1).


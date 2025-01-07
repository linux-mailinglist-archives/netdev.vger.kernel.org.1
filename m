Return-Path: <netdev+bounces-155651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAD3A0343D
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 01:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8C21885F18
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 00:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152395661;
	Tue,  7 Jan 2025 00:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgMd4lo6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10CB7082D;
	Tue,  7 Jan 2025 00:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736211454; cv=none; b=X026p6q4nvfS+vQEvcgOq2u91QTQMzTiF+glecP/Ys4SaUpUczuOH34sQiKm/vflpzUcDU9dZm2FlngUpyV9KcGqfBYkgvS5DaxwwnUvbPvnfXqwxQ3HWqYqorq1X4XlfNAmFuerZvyHWmCQgCmqSWX0DbCGkM5MDD9bTIGesMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736211454; c=relaxed/simple;
	bh=JjICmiEBV/LkVT4wjNu1pPF2m3SfyqftbRgfyCOMUu8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CtU1oEZ754vpD3MxNggmtXvcNseSNKI5I5eyCQ+j8oC0XlgjoLzNuXCyRPCkCIBQYZ/PqsMf1xf8n2iDwqA64XUSSqsWMEscPm9ITS1gpGGrsSlaPRHlxfgKX62bCdvMw2TEpd91NHws1P/GCkVYMoKY+Q3yQnwEEpK5LW9VFTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgMd4lo6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3CAC4CED2;
	Tue,  7 Jan 2025 00:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736211453;
	bh=JjICmiEBV/LkVT4wjNu1pPF2m3SfyqftbRgfyCOMUu8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lgMd4lo607ATJx3Z6UtvKsRu0tVb0KAM+L1YC+IGmAkApi/VrWHXPUpNWafeh6Eh6
	 pIR4ZZmCs7bYtrVSovmA7WsBFF8bdrig2pxbkisPVA6j4mooRMMgNS8pfhRjOnIJ+0
	 B0hJsaVNH1voXFTsBCxaHmk2xbBaysmrqZKK3h6pqDl9vteIvcfW+MRVIF4c7Uc/lA
	 En5nSKnM4CfmOosqOWGb/9jCQx+Gj2SQXOMIx1AWxeLcyteetPVmVuj9YoXZOTe1U+
	 Q6rkjVFh3VH74BuzdWtJxq4e4CF8Rvj5YKe+rCW12I4D6IKop281Jya8qmnJ6OpgVc
	 r1OGsx7jtPOJw==
Date: Mon, 6 Jan 2025 16:57:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>, ronak.doshi@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] vmxnet3: Adjust maximum Rx ring buffer size
Message-ID: <20250106165732.3310033e@kernel.org>
In-Reply-To: <031eafb1-4fa6-4008-92c3-0f6ecec7ce63@broadcom.com>
References: <20250105213036.288356-1-atomlin@atomlin.com>
	<20250106154741.23902c1a@kernel.org>
	<031eafb1-4fa6-4008-92c3-0f6ecec7ce63@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Jan 2025 15:51:10 -0800 Florian Fainelli wrote:
> On 1/6/25 15:47, 'Jakub Kicinski' via BCM-KERNEL-FEEDBACK-LIST,PDL wrote:
> > On Sun,  5 Jan 2025 21:30:35 +0000 Aaron Tomlin wrote:  
> >> I managed to trigger the MAX_PAGE_ORDER warning in the context of function
> >> __alloc_pages_noprof() with /usr/sbin/ethtool --set-ring rx 4096 rx-mini
> >> 2048 [devname]' using the maximum supported Ring 0 and Rx ring buffer size.
> >> Admittedly this was under the stock Linux kernel-4.18.0-477.27.1.el8_8
> >> whereby CONFIG_CMA is not enabled. I think it does not make sense to
> >> attempt a large memory allocation request for physically contiguous memory,
> >> to hold the Rx Data ring that could exceed the maximum page-order supported
> >> by the system.  
> > 
> > I think CMA should be a bit orthogonal to the warning.
> > 
> > Off the top of my head the usual way to solve the warning is to add
> > __GFP_NOWARN to the allocations which trigger it. And then handle
> > the error gracefully.  
> 
> That IMHO should really be the default for any driver that calls 
> __netdev_alloc_skb() under the hood, we should not really have to 
> specify __GFP_NOWARN, rather if people want it, they should specify it.

True, although TBH I don't fully understand why this flag exists
in the first place. Is it just supposed to be catching programming
errors, or is it due to potential DoS implications of users triggering
large allocations?


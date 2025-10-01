Return-Path: <netdev+bounces-227422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9485DBAEE84
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 02:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5447E3A506A
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 00:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470151E1DFC;
	Wed,  1 Oct 2025 00:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMCyHeCm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22663191484
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 00:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759279422; cv=none; b=rp8oppy0EEEHBKkvaHS5UN0dUykicEPjEnBnkk72G8DUQdaW7ma21Yc4u290kj2/dEZZSWQIe5FKdskmlpeWIIAz4NIS2+/ZI78MLOpLqcMTQcTJqeBmIXTIJkvEq4i1GXI1/SWNA3nyMuDKjf7eTRaSDmMsBl5E/Laocglc/qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759279422; c=relaxed/simple;
	bh=9RhAEwBjocD/mhOTiWfIKm34k6UDGRaAkP9FFbk41OA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIJ/0UcyCORNJ2cqZM14uLXyA0occ/CUmzuLJPU2s74k4vbCiqiBItMRcr0h3yY93qVQ7svrDHuxB3POqi9EzJtrCu2hDtr2/hhoDmcHFWXbAkxUxa81JK9s/CzBR8yF53A2LFhztN6vgWkxJeCqNgTT28ZZiKCZfb2ID5R5HRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMCyHeCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71034C113D0;
	Wed,  1 Oct 2025 00:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759279421;
	bh=9RhAEwBjocD/mhOTiWfIKm34k6UDGRaAkP9FFbk41OA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eMCyHeCmTbiwE06QuQUJ4me8SqwnxeSiDrC5UWiVCTdvfvk+3PPK2Q/cqIdNeJ3CV
	 OIu3k9P4L/Ps+rWUjheR5tJUHZSYuyXNZPRzAuOybgbGu9jqb4LSoNGXukQy22veLo
	 PRoDai7ptfusvqdbQaY1aOrMYwwd8su2uRmF+ThVtP8wAeyH2TV3n6PMzgXLar0dnD
	 nrG/H4yqJgn2M/EnD+Vg/+9S+e5BnHPJYQusSkFssgts0Aa5eKqDqGisLgQlP714EG
	 p4sc7oN4+Kz9AVDRr08CDuAn2UURa88+cJzPdZZhKJrstKqr7xFSFK+EezB78zllQR
	 dVbjp7SS8JppQ==
Date: Tue, 30 Sep 2025 17:43:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Zqiang" <qiang.zhang@linux.dev>
Cc: horms@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH] usbnet: Fix using smp_processor_id() in preemptible
 code warnings
Message-ID: <20250930174340.5e554e10@kernel.org>
In-Reply-To: <98852ec27b03a4b7a16243e32b616a0189e32165@linux.dev>
References: <20250930084636.5835-1-qiang.zhang@linux.dev>
	<20250930103018.74d5f85b@kernel.org>
	<98852ec27b03a4b7a16243e32b616a0189e32165@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 01 Oct 2025 00:39:18 +0000 Zqiang wrote:
> > We also call netif_rx() which historically wanted to be in bh context.
> > I think that disabling bh in usbnet_resume_rx() may be a better idea.  
> 
> Actually, the netif_rx() will disable bh internally when call from
> process context.

Sigh. I said "historically". Commit under Fixes is very old
so the fix needs to be backported. Look thru the git history 
you'll see that netif_rx() did not disable BH when the bad commit 
was written.

> but the skb_defer_rx_timestamp() is usually called in the bh or
> interrupt context.
> 
> Anyway, I will disable bh in usbnet_resume_rx() and resend.

If you think you have better solution, please do not hesitate 
to propose.

Also make sure you read
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
if you haven't already.


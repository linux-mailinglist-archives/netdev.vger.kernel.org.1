Return-Path: <netdev+bounces-197003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215D9AD745E
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B66F3B23E7
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF2E24A06A;
	Thu, 12 Jun 2025 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWN28862"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E78248F6F;
	Thu, 12 Jun 2025 14:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739505; cv=none; b=AJM7arRuCYla5K0ttK/STZREKOd0g9saAF+CAPlpf66wMwqGf2gQQhVI5u1gVBMs2H1YsMUhihkul/ZznZgOty4thpLDON2/edTXqTdRzSAwSDzTbxEVyv6xAkds1iVNBtdFZ/b+yIffTqBtBeeTkhFc47EiQV6WoYsCQUGSZew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739505; c=relaxed/simple;
	bh=rhW2uPY7C6h/BLG/laMfzjLwgKmKRwYa3f9EKStw7xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ej7uoodgqhWYnKKmz1qsmPDZfsRrEEdWdEBsIy24+lQS+FOo16tehFlPZYHeTwgRRDVzvWlwBkUfCC0oNzEsF7msvHCWmFQ+zPMFz7YvxEAXevPnneUu+XRbP+BN6UiMG1AcsqkaG9EQrB8a/OU99z12JxbT0Uoqa/7RE7UlxFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWN28862; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4174EC4CEEA;
	Thu, 12 Jun 2025 14:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749739504;
	bh=rhW2uPY7C6h/BLG/laMfzjLwgKmKRwYa3f9EKStw7xQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YWN28862BHnhGYH2SwLF8nXQOPAWhB6kiidXReIXS9Uv5OTfa9tgiGl75gYni45mD
	 WhUq5RfqPQM8TIdoQwMteBUb0ip5b367AzSEJrqdJF7EwSFoV5y4JS57D/zXfqL+aZ
	 Iqmv+SRjQ3iPttjydeguMOO2wnzYWmqhSngUgXq7SVCsy37I8jI4zhnHq3uj+N1KOR
	 1p8Y4YWbTD/ICVkGI+fCROQNCGk29SBAmdlt3gR+HoLfro253MrwqpMAjtG4FumiL2
	 s7rEoNaTagV5Rwy1nPT3NTixgHYQQhX9baHhdDcsVWaVb5+YZB4ClipnwlFHuFFnmr
	 fooRbFXOvIE+g==
Date: Thu, 12 Jun 2025 07:45:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next 2/2] netdevsim: collect statistics at RX side
Message-ID: <20250612074503.1f80b816@kernel.org>
In-Reply-To: <aErjcH3NPbdP7Usx@MacBook-Air.local>
References: <20250611-netdevsim_stat-v1-0-c11b657d96bf@debian.org>
	<20250611-netdevsim_stat-v1-2-c11b657d96bf@debian.org>
	<aErjcH3NPbdP7Usx@MacBook-Air.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 17:25:52 +0300 Joe Damato wrote:
> It "feels" like other drivers would be bumping RX stats in their NAPI poll
> function (which is nsim_poll, the naming of the functions is a bit confusing
> here), so it seems like netdevsim maybe should too?

Good point, and then we should probably add the queue length to
rx_dropped in nsim_queue_free() before we call purge?
-- 
pw-bot: cr


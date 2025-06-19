Return-Path: <netdev+bounces-199495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 425E6AE0857
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 16:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF8A18982F3
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8368825F98B;
	Thu, 19 Jun 2025 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bX/uLUnY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7CF21ABBB
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750342206; cv=none; b=SE/MxR4oCXvRoIb9qos8B9Nyb6/xkyOCL2DKFIt5MRD2RkUx7/JGo35Q/zloRflf9aWBjyRfa1DiQ6BOZtcVwLh5RXhq7RCu1jfPfLznftr33zSyaG67yIaxmtkyGaf/KlgUftB0z24xB+1bg/2qk4hmnS09oyfK9YuDOFD0rjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750342206; c=relaxed/simple;
	bh=7rlfA9VKmjAzDXlnPJtEUgOT3E3a5mweRdXGp3fXBUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4GoDivDVWwF55Smu9zzf6KAmtCO9LbWKIcOmRV6uQ7zMY2pp/ColDzZdWjSZUzRDfB185G0ae82f3/g9hQfS9WPmCYtoDV94b5CGAgul0cbFLBEcXaCCe5G7uAnsBRaLi5yWfq6XctY77Oz6kyZolhwZ0U9uLmnMKBoPPHR5HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bX/uLUnY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDFCC4CEEA;
	Thu, 19 Jun 2025 14:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750342205;
	bh=7rlfA9VKmjAzDXlnPJtEUgOT3E3a5mweRdXGp3fXBUg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bX/uLUnYcfs9V0aLZ6VgIbn+V92uE0XFWTZNW3v3fyMFHl5bqaOVCmrpcVIOyweDG
	 xrBBXldD57fcLYsl62ENd+meqJt6orlKIrrNJGP/99LaYY39TmD5YmbIXuUgKIY68b
	 60pdnlqst0A7nnosFmPK82ptTDLXzwfvE4oTTRFXy1tOjlrZZ1DYb7C4hel6IGiREi
	 IUIkr1iF6xDf1TJ/jwyHVxS5gzaNXbS44gkD7mbcpQ/fDfFBm+1y81OzyJnqxE0VoT
	 GF0ym5kZBqfRKQDziRxBwFSfwwbcFt5V++9kRPVoy0PvioCSggRqZvn0TD+oChsMuG
	 WraUmtSNshFCw==
Date: Thu, 19 Jun 2025 07:10:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, lee@trager.us,
 jacob.e.keller@intel.com, Alexander Duyck <alexanderduyck@fb.com>
Subject: Re: [PATCH net] eth: fbnic: avoid double free when failing to
 DMA-map FW msg
Message-ID: <20250619071004.5e841f1a@kernel.org>
In-Reply-To: <9ed6bff1-9210-4b2d-a897-2321316ac3b9@redhat.com>
References: <20250616195510.225819-1-kuba@kernel.org>
	<9ed6bff1-9210-4b2d-a897-2321316ac3b9@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Jun 2025 12:18:58 +0200 Paolo Abeni wrote:
> On 6/16/25 9:55 PM, Jakub Kicinski wrote:
> > The semantics are that caller of fbnic_mbx_map_msg() retains
> > the ownership of the message on error.   
> 
> FWIW, I think the opposite semantic would lead to simpler/smaller code
> overall, but no objections to retain the current one.

Interesting, I'd have thought the semantics of "on error caller retains
the ownership of the object they are trying to hand over" are generally
considered more intuitive. 


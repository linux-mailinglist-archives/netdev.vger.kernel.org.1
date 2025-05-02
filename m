Return-Path: <netdev+bounces-187413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1858AA7020
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 12:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4963417B938
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 10:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12460231821;
	Fri,  2 May 2025 10:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3Cyi9mv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E218E1F4199
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746183265; cv=none; b=ku8rCBpR/+NnmRBcSq/67mOb1+zanKL6Z8G8NuZEhTfcEfurXMmkUxmp78MiM9ZlsVGPHA5Yxk+o9Gwmw2X2QsLL2oJvvvNac8ObX9Lxj9se9ahnchzRzq5warwBbQQ+yIayAdsJEXoWM0TZ98ULv4BF0e2j2I2ls+R61whMjAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746183265; c=relaxed/simple;
	bh=K9BZzw4QKcVE0BwdWTK8nU4i1uzIm5UvQ/GuiCN52bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBrSx2EOEV+zBPwvENz81goVW6+ELkLZm8ezPkB5FJeQaC46g0ucqtEMleQJgbh1JyaJAyJyiINehrZ6DaNmNxmpwdxcrfZKEAaBkTRQV9/4ZnLr8RUMTZWvpZ8x2OiaYwoBoUqvFE+J9mOiZezfcbLuBkf247t9vywMII8MB5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3Cyi9mv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C32C4CEE4;
	Fri,  2 May 2025 10:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746183264;
	bh=K9BZzw4QKcVE0BwdWTK8nU4i1uzIm5UvQ/GuiCN52bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t3Cyi9mvJt4ieMnsCVGZB4bkoJq/25XTDMf3l5tkmQm577I2TyfglvNd9l9AKzIwc
	 6oydMJ1+32WuZ/D1CvfUjGvWkuPKUMypHa3BdQP52UxTxpWlne3mr4VeZDqBjp54Rk
	 akHbebRgEJ47sLVOc8dUrlesmuk0mAoBHna4JGpqKDuZ7YVrfIiR29tWUjPaQ/I3Nl
	 15Iqs4uYX5S513GvzXbSYGfGuJJinmcsFlZMMRhPNL7JDngHob1k24TEXTqkufyw/H
	 bRq5JGMdgt+cSQbmes/04BtBp1znNNhGs/PFP9BI2vCRMGPMjlnYBrGGhJjul3bt8p
	 6LT8C4JjTf2sw==
Date: Fri, 2 May 2025 11:54:20 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [net PATCH 4/6] fbnic: Actually flush_tx instead of stalling out
Message-ID: <20250502105420.GK3339421@horms.kernel.org>
References: <174614212557.126317.3577874780629807228.stgit@ahduyck-xeon-server.home.arpa>
 <174614221649.126317.7015369906157925744.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174614221649.126317.7015369906157925744.stgit@ahduyck-xeon-server.home.arpa>

On Thu, May 01, 2025 at 04:30:16PM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> The fbnic_mbx_flush_tx function had a number of issues.
> 
> First, we were waiting 200ms for the firmware to process the packets. We
> can drop this to 20ms and in almost all cases this should be more than
> enough time. So by changing this we can significantly reduce shutdown time.
> 
> Second, we were not making sure that the Tx path was actually shut off. As
> such we could still have packets added while we were flushing the mailbox.
> To prevent that we can now clear the ready flag for the Tx side and it
> should stay down since the interrupt is disabled.
> 
> Third, we kept re-reading the tail due to the second issue. The tail should
> not move after we have started the flush so we can just read it once while
> we are holding the mailbox Tx lock. By doing that we are guaranteed that
> the value should be consistent.
> 
> Fourth, we were keeping a count of descriptors cleaned due to the second
> and third issues called out. That count is not a valid reason to be exiting
> the cleanup, and with the tail only being read once we shouldn't see any
> cases where the tail moves after the disable so the tracking of count can
> be dropped.
> 
> Fifth, we were using attempts * sleep time to determine how long we would
> wait in our polling loop to flush out the Tx. This can be very imprecise.
> In order to tighten up the timing we are shifting over to using a jiffies
> value of jiffies + 10 * HZ + 1 to determine the jiffies value we should
> stop polling at as this should be accurate within once sleep cycle for the
> total amount of time spent polling.
> 
> Fixes: da3cde08209e ("eth: fbnic: Add FW communication mechanism")

nit: No blank line here
> 
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

The nit above aside, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


Return-Path: <netdev+bounces-82011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3817688C15D
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 12:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0288B2492C
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552C66F51F;
	Tue, 26 Mar 2024 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cO6XuoQA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6EF6F09C
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711454356; cv=none; b=PKOFtkesrfpa7RZ4pmWxvBSCiA/zT+5tTonqhVQvc/QxZrjUw2xC+gGXq7M9+BAgxAAiT+iKXYyTuUwr95/5/meLye4a0UsKrpN3X0/CXt+NIBGr9CxnLmtCD030OUOl8vJDwST9I5DEUGPnmu301mcb0+ziHEhOp8GPaK0bToU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711454356; c=relaxed/simple;
	bh=xkBMYAJCE2xKS51B6d/zC6t/J3DRJcaLw8XNJ5X+6M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2NzExZojq55VPCjXqnUfGYzBP6XBRjoBtPbYVJnBaM1xCQH32VD01e/9sW4Lv/++8+PBR+/JLcbmIcz4qH+M2QFNyKQcwNA+Tdtd4F14yA1v/VQe6Vl3l6OmJP07SHzNTwcNRwaeD7uAM8cb4ARQDjc98YzYK2kGJ0o/b0KHXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cO6XuoQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6B5C433C7;
	Tue, 26 Mar 2024 11:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711454355;
	bh=xkBMYAJCE2xKS51B6d/zC6t/J3DRJcaLw8XNJ5X+6M8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cO6XuoQAfAoDQ6DPmBxEZSI16HUGVisB9n4NPsP1tc9uk6pmwCJ7K6VzGpP6+48+x
	 9PRMiq+qtVtr0AaeXHSc868y6EmG0+qMXZ3rOxASuRuR6cEzfYCvdd7dDgKFBT8ilD
	 Jwkz5duN4C2q3u5GZEu3CUjdzx3eDff9lrFpsgwe3eWWSVw4I0dfd5Unova2947vWn
	 /nc2PNPhrBGgxdioalcmEgSV5RyhHaRTHP8BnEYSWwP6s27VmBvdcoVpetVd3iIJU0
	 BQP844q2duhaBDsgXwJ9G4BvD2N4N+DvQ+/jvxyCc0i3k89pHoAZA+NONod27CdaJn
	 HirgZEDadkKsA==
Date: Tue, 26 Mar 2024 11:59:11 +0000
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Gaurav Jain <gaurav.jain@nxp.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net 2/4] tls: adjust recv return with async crypto and
 failed copy to userspace
Message-ID: <20240326115911.GQ403975@kernel.org>
References: <cover.1711120964.git.sd@queasysnail.net>
 <1b5a1eaab3c088a9dd5d9f1059ceecd7afe888d1.1711120964.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b5a1eaab3c088a9dd5d9f1059ceecd7afe888d1.1711120964.git.sd@queasysnail.net>

On Mon, Mar 25, 2024 at 04:56:46PM +0100, Sabrina Dubroca wrote:
> process_rx_list may not copy as many bytes as we want to the userspace
> buffer, for example in case we hit an EFAULT during the copy. If this
> happens, we should only count the bytes that were actually copied,
> which may be 0.
> 
> Subtracting async_copy_bytes is correct in both peek and !peek cases,
> because decrypted == async_copy_bytes + peeked for the peek case: peek
> is always !ZC, and we can go through either the sync or async path. In
> the async case, we add chunk to both decrypted and
> async_copy_bytes. In the sync case, we add chunk to both decrypted and
> peeked. I missed that in commit 6caaf104423d ("tls: fix peeking with
> sync+async decryption").
> 
> Fixes: 4d42cd6bc2ac ("tls: rx: fix return value for async crypto")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>



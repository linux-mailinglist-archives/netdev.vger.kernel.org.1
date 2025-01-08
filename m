Return-Path: <netdev+bounces-156195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CD4A0573C
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 10:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB57D1885BB5
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 09:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002531A00FE;
	Wed,  8 Jan 2025 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9d9F8Ae"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09CC79FE
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736329437; cv=none; b=DLNqJKhqFOJu3ja8jmyaxos2x8Ct4wAVmDTw3IDxG0AA/OmXg24nPlfqW6ZWecasvXtvGaaZvsiSXaxVh7S/ZNBflbnH6Ctd/b1FgGQMYC3nx/GEXiaDRTBRP/QDZ1IJZlWavZ38mIBcnlcM3DxpLV4mkG4uPcOQKRNupGzuQ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736329437; c=relaxed/simple;
	bh=GTIwoHS+9H/buXndyZk8JX7O6T5StsynrLs9Q8JE1yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHTF5n+y033niHrKUw17a38uH3hgOz76BJ1FYM+5OY32o6NZ5fo55K9PGzM49ueVAub6G8BJB+6pDpAG1JzKoqpheIb5vshOZEFEu3GMKRD9ZXvBUNa4DVefPEX+OJxWP+lom72RcGBwzO9ven60IG4twBKEL/Ed28PNarlooIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9d9F8Ae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F99C4CEE0;
	Wed,  8 Jan 2025 09:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736329437;
	bh=GTIwoHS+9H/buXndyZk8JX7O6T5StsynrLs9Q8JE1yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B9d9F8AegXftWtHi7AzFjhMVlGOzFNoXsqNA4Osl95dzroDBp5ualDSrwXtSwuSEZ
	 nsaeEUtjL5LXVBe3oUfnMXo+zGphJppuW0MtBqOKCO5rnMOdpL2IzBnxTaW29dasFQ
	 FbdZ6DjNM5HFpQ+qGpg9utms3lmTKK7sKTYgjsO3sjJ5uoQVD5J3BOgW/bOBtcNIbg
	 kvx2RSnRu3HNVMrcfNXZa/fL7O7UY460QofkJoEtNV7jS7XBHRPLCLjZXNrt6qaEy8
	 1bcvnP578h6yd+TY0C+0vsLP6IF71f4FKXQRsRrNvWZyCgL24ZZfVRAsVPkA7xuyVw
	 Z+IOnCi1iCOXg==
Date: Wed, 8 Jan 2025 09:43:54 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: no longer reset transport_header in
 __netif_receive_skb_core()
Message-ID: <20250108094354.GE2772@kernel.org>
References: <20250107144342.499759-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107144342.499759-1-edumazet@google.com>

On Tue, Jan 07, 2025 at 02:43:42PM +0000, Eric Dumazet wrote:
> In commit 66e4c8d95008 ("net: warn if transport header was not set")
> I added a debug check in skb_transport_header() to detect
> if a caller expects the transport_header to be set to a meaningful
> value by a prior code path.
> 
> Unfortunately, __netif_receive_skb_core() resets the transport header
> to the same value than the network header, defeating this check
> in receive paths.
> 
> Pretending the transport and network headers are the same
> is usually wrong.
> 
> This patch removes this reset for CONFIG_DEBUG_NET=y builds
> to let fuzzers and CI find bugs.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>



Return-Path: <netdev+bounces-220194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDF8B44B76
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 04:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA90BA421DE
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 02:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDEF2080C8;
	Fri,  5 Sep 2025 02:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vG3e/Kpc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783C61F560B
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 02:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757038005; cv=none; b=UNd2y3+UTuLiISWpZo8DzjsKiWLmHIW1EDfiFPoD5ZO2Iw6mSyq099n294S6C/3KefjRkwheKFni7+izq2SN4GB00ylDfn9hYhHyQ5/kx/kqH3Srs4zsKjUPxj9tup0luZknetdEOVaGffYLbpcbr+emDWsQcOBOLxI6sk3sIeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757038005; c=relaxed/simple;
	bh=+wqhQZVLGCW1IsyIFdhvdAs/iuaSMvczithUVZq82j8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S9CNP3L+T1WH/qm8ED48pUBmmiPs8sw3tJimX1vv/v6SU/2Y3eaxbqKzvs4pK6vn8pb1G2UmF4swPLsYKtQwkRCJrXgA4dUaohB5PUgJlvGsSBdru+HLGEwKQWALfH7Nvp8c/Sr1KxcLKSdSombc7vnCNGcyolWKlw9LRnc5V78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vG3e/Kpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5EBC4CEF0;
	Fri,  5 Sep 2025 02:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757038004;
	bh=+wqhQZVLGCW1IsyIFdhvdAs/iuaSMvczithUVZq82j8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vG3e/KpczL5mezkOCUfo9x+sHiFd+LN6RMzrQRLISC0Xt3Choqbxl8bhliYK7iL71
	 7TxGwkC+9st5YdRrpOby9El9/EH+DPUs1RkJG9bAyKRZHrroWfUgn1/WS6fXIql4M2
	 QdtxzvoNscEc15bnweipMCf2ULeXglZq7vjI2qubben8TDRRia11kwiRT9w+jnHelK
	 dZtnzFG+8RReyUvlNrfRRHGNlcJwoUPOFEPKaFifD8oVnJaTpKthEwSao2FaCpNJPN
	 XkaljZjU1WVJJfHNvmk/XTTsB8M1pXdTJjCkhM07c+c8t+xM0TaDNG3nhBXJrqJRcQ
	 sb/lpp3Qt07Ww==
Date: Thu, 4 Sep 2025 19:06:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: <netdev@vger.kernel.org>, "'Andrew Lunn'" <andrew+netdev@lunn.ch>,
 "'David S. Miller'" <davem@davemloft.net>, "'Eric Dumazet'"
 <edumazet@google.com>, "'Paolo Abeni'" <pabeni@redhat.com>, "'Simon
 Horman'" <horms@kernel.org>, "'Alexander Lobakin'"
 <aleksander.lobakin@intel.com>, "'Mengyuan Lou'"
 <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v3 1/2] net: libwx: support multiple RSS for
 every pool
Message-ID: <20250904190643.580c20c3@kernel.org>
In-Reply-To: <010001dc1e08$c8758970$59609c50$@trustnetic.com>
References: <20250902032359.9768-1-jiawenwu@trustnetic.com>
	<20250902032359.9768-2-jiawenwu@trustnetic.com>
	<20250902174116.080782a5@kernel.org>
	<010001dc1e08$c8758970$59609c50$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Sep 2025 09:59:58 +0800 Jiawen Wu wrote:
> On Wed, Sep 3, 2025 8:41 AM, Jakub Kicinski wrote:
> > On Tue,  2 Sep 2025 11:23:58 +0800 Jiawen Wu wrote:  
> > > Depends-on: commit 46ba3e154d60 ("net: libwx: fix to enable RSS")  
> > 
> > What made you think this sort of citation is a thing?  
> 
> So should I wait for the fix patch of net branch to be merged
> into net-next branch, then repost this patch series?


You have to wait.


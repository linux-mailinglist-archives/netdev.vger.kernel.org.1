Return-Path: <netdev+bounces-204681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AF8AFBB43
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 21:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D75442076D
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 19:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CCE25394A;
	Mon,  7 Jul 2025 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSH4YW/F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303254D8CE
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751915029; cv=none; b=geTpEolP4f3F6H4zx4tt0jhN6vQvJmTAUnLv9enXioJdYpCzEqhnMK6MjKBVB30k/yApmzTIGNHF/iwko7w/nRLDwjWg3+k/fVqbJK8VS4kbc3t1ojkS4+jTwY2hRbohSoT0kIuOea1hoG0RDzFLXbQSa1mfI/shOVqiS0DCpWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751915029; c=relaxed/simple;
	bh=gGTwbud1VSf4u70ET8wqbNoFKZkqgvZKm0qjAjmobBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNOfQ6/uqnM0mUXf1wqTFnLAxcTM4Bct9pMrMRgAwTJFuoWWCD5AEBg4DbCFCy5eHCHdx14hKsLK3Z64mHvrwXXhgOmoOuQL9Yz1YUg8V/Txrxu1M047tPH/NEvhm+va8fhuiVS9RCeUt/PhPmncUW3/j58fZNPeYtjuJnUajcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSH4YW/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85836C4CEE3;
	Mon,  7 Jul 2025 19:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751915029;
	bh=gGTwbud1VSf4u70ET8wqbNoFKZkqgvZKm0qjAjmobBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sSH4YW/FG4/oHDwWJxftAwxtytvCEhnCpEeeT1nKpFlQUX7X+8FSiU5eHxJuTIGqa
	 x8VcCCLSWAAC9XO5iUc2sy4fDVH/3eH8fn5eBhigOojPdaYGTEbk8IyOhwrZevmJaG
	 VdekcHmwu9C6rvufApw7FseM48DVGvg9rVgeizLuPtic3yjrEw7ujZ8Ww5T+oy6WCJ
	 VVhFr3DmMe1t3lYcou/1mKC3elNJlJdYu6N+3O7D2TP/VnU95nTDUDdKNcHhTO0VFy
	 OOUsMQucGzXuQ7/e61oCjm6X7fLWV0O3ipGiSeSGMIToTGWQIn3ZgJmiDw8iNfCx78
	 oEoQpTAhCSIoQ==
Date: Mon, 7 Jul 2025 20:03:45 +0100
From: Simon Horman <horms@kernel.org>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] net: netdevsim: Support setting
 dev->perm_addr on port creation
Message-ID: <20250707190345.GB452973@horms.kernel.org>
References: <20250706-netdevsim-perm_addr-v3-0-88123e2b2027@redhat.com>
 <20250706-netdevsim-perm_addr-v3-1-88123e2b2027@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250706-netdevsim-perm_addr-v3-1-88123e2b2027@redhat.com>

On Sun, Jul 06, 2025 at 04:45:31PM +0200, Toke Høiland-Jørgensen wrote:
> Network management daemons that match on the device permanent address
> currently have no virtual interface types to test against.
> NetworkManager, in particular, has carried an out of tree patch to set
> the permanent address on netdevsim devices to use in its CI for this
> purpose.
> 
> To support this use case, support setting netdev->perm_addr when
> creating a netdevsim port.
> 
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>



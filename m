Return-Path: <netdev+bounces-110400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A44492C2F4
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83681F23D66
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B122D180047;
	Tue,  9 Jul 2024 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1j4B+I4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C50318002D
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720547919; cv=none; b=dwaOPJom7TL0RXqoYIG3QG8x32IlTVjJj5iWnAmZw0+wIg2/XPc4IeaIlNy4cDczeGH9D6D+76UtwTFyvd+AQKVRTtyteNufSQ5sAkaUBXdomuiLl+4aEX2ic+ICZG1W1IOZCs0j9HE4Qyu+INXCUoSl4rDT8u2Csg/vL2U9dVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720547919; c=relaxed/simple;
	bh=oxP/OVI152Z02wAJjJUnLdmTewhBFJmUlT/vlYIfvac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/90E5VfY+Pj+rObazc0O790kh+FhbkPH/xRLQlZbbOfFl6soyAX54ZXOQUrmamuGaPBp9QSk18JtjRrOfyqwLmr2UxR2jMFrkGBkNP1TfKTRN2lOltltQqQ0ZmFq1QnYY3nPbNb8kF7i9rcWDpVET32TReYdPLmReqKCRE/lAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1j4B+I4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375B9C32786;
	Tue,  9 Jul 2024 17:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720547919;
	bh=oxP/OVI152Z02wAJjJUnLdmTewhBFJmUlT/vlYIfvac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b1j4B+I4pQHbuV8vJ94r6T0lZCWwtT5N/OHrwPwvhf0nArSXDcULemlvIcsABK4jk
	 1bDmLFVrBkt8oSyVg4hq2CTdrZovOk6XdDDhR68UVwX7pOSCZ1x1E4Nohb1fEc1Hpx
	 IkEsz9+ga1cDn+S5Yftvi8NpZWaE+hrgrte5QtBaCiN+FzFN+VyXtY538cotm8zIL/
	 5vjL+stUOLw4GgFZnmSzGjIPe6umTJWwTlJoJ7Wk8kpRH0oulYwWs+PLrm57KVQcVj
	 htzb92Inhs+oWB5rRli/Rqy0ysxAGS6vgGhIROE3LvsYlOKK2brBKlo1eOnpP9Dzfo
	 AUzANfKBtPT6A==
Date: Tue, 9 Jul 2024 18:58:34 +0100
From: Simon Horman <horms@kernel.org>
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-afs@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH -next] rxrpc: Fix the error handling path in
 rxkad_init_connection_security
Message-ID: <20240709175834.GN346094@kernel.org>
References: <20240709104910.3397496-1-cuigaosheng1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709104910.3397496-1-cuigaosheng1@huawei.com>

On Tue, Jul 09, 2024 at 06:49:10PM +0800, Gaosheng Cui wrote:
> If security_level of rxrpc_connection is invalid, ci should be freed
> by crypto_free_sync_skcipher, replace error with error_ci to fix the
> memory leak.
> 
> Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

As an aside, the BUG() in the middle of rxkad_init_connection_security()
is a bit of a surprise.


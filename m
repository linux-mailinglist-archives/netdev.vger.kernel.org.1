Return-Path: <netdev+bounces-72866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 798A785A01E
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 10:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC3DE1C210AF
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 09:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6164324A09;
	Mon, 19 Feb 2024 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUk3O+JO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6FC22098
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336076; cv=none; b=P6zEOoV7DGxo7LJdg1fluDxA3s+bnqOWFUJA2FuFUsVXfzuv1YxxUTZXkWqW7difJ4fgSY08IHo4QPNXBnR2Maq3LzAqqnDUywkjitro95Ja1Ul48xkaU83AxnxJt6oSdfUQsas8QxVGSUtddMse1/6QfzsnYSObKyU8wLekMu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336076; c=relaxed/simple;
	bh=AwVAwxNxN6glbYCODeigT0nwxRmDS3d1W1Tyy37Oabk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fegRWkVrS5ERC/Bcq1/LT9vK8tYflwsO9zQUQ4n9wHTCaVp9/OhPcPYClnFGA2eZ925EXakQOCNLbPUaSG0+npbKvxWURaw6x75mJf+p+bHFOGM2Sl5JUXkuRYEpqzOktNa03QmOXVfUGqr0b8JzKMkqEEczlqyXTLyCYwyD/gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUk3O+JO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40279C433F1;
	Mon, 19 Feb 2024 09:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708336075;
	bh=AwVAwxNxN6glbYCODeigT0nwxRmDS3d1W1Tyy37Oabk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mUk3O+JONHu2LCPpmRSAMe2e/Lh4tlk9VjzpLwjMNNxPTO0vvw0+UCIUC96lIYqwG
	 57syxpvbaJr5kPae3esjJBe3la4FsZ/ENB0atfENzuxhh5/0hVQd0d/zkGHXT232KR
	 yWC6zASWVfY21n4cgI9YIU0Uf5MvQqt9/yEPQUSo8N83JfyqXYuqZoclJnfhGKJAMz
	 2lvp0DSQk0rnVzyPYNv5xfibQ2rL6ec1F3gCy8+CV1U/IM77q6FjCQ9kaTF14eSQVg
	 j/jnZsvcioU7m6tCe0O+apc4c4XkfDGOp41tzg9goCdH/sDmWAt84HjXvzyO11mbO5
	 mQgijAMjpUPgQ==
Date: Mon, 19 Feb 2024 09:46:22 +0000
From: Simon Horman <horms@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: mctp: put sock on tag allocation failure
Message-ID: <20240219094622.GU40273@kernel.org>
References: <ce9b61e44d1cdae7797be0c5e3141baf582d23a0.1707983487.git.jk@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce9b61e44d1cdae7797be0c5e3141baf582d23a0.1707983487.git.jk@codeconstruct.com.au>

On Thu, Feb 15, 2024 at 03:53:08PM +0800, Jeremy Kerr wrote:
> We may hold an extra reference on a socket if a tag allocation fails: we
> optimistically allocate the sk_key, and take a ref there, but do not
> drop if we end up not using the allocated key.
> 
> Ensure we're dropping the sock on this failure by doing a proper unref
> rather than directly kfree()ing.
> 
> Fixes: de8a6b15d965 ("net: mctp: add an explicit reference from a mctp_sk_key to sock")
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

Reviewed-by: Simon Horman <horms@kernel.org>



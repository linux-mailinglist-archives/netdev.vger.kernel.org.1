Return-Path: <netdev+bounces-90236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F7C8AD3E6
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 20:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37F3CB232DF
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 18:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12F815444B;
	Mon, 22 Apr 2024 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gp+3Dx2N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB8915443B;
	Mon, 22 Apr 2024 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713810481; cv=none; b=m4vxKD/Kc/FBc/p2soD70T6G5DcNGRWm83M6EFEi1jYkOjeUXQTHzGCok0TRIL0LDPAWhweMXnZhA19oEFCvCSkbujztsK+LKX+rKRwLEAg15LjUX9ODatRvwzDPtGjFG1NNjSBUP/9ypGPoHmmhvNz96Xa7P82jOfc7LN6qRaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713810481; c=relaxed/simple;
	bh=TebqyUasjtfC4W0N5+ZbzWhVoia1pG5BkHfAupOsIMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtqFaTqHUG6sF2RUgBVQsakPqocn1na2cBH3wOHru6BIAmtCkz8XE+iBoNAWquGseEV1aqu24jcZkH/8ThTot6RKQpVarW6+XbSIMAROm/ZVEL7RPp7iHYYz44J+Nz4tdSUrb4QgcJhTEHZUvzNLJp7uFFLoe+25QU38A+/E2iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gp+3Dx2N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A183AC113CC;
	Mon, 22 Apr 2024 18:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713810481;
	bh=TebqyUasjtfC4W0N5+ZbzWhVoia1pG5BkHfAupOsIMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gp+3Dx2NQ/u2cLRwU3jsX4GbyGO2CI1l9t1pqP4tI2gfFdzq36b1Fdu9aCag/Tqxd
	 D1cYSLLCngdN0FwzDl55AKwIXyc3qcG2NdvSJjulpdnkZwYnUZwhkqwxZqPGS+QK82
	 mlT7VhOkd5W6fJqC+h4Azxb3Jn11Gayq8ymScsf2Vg8L6dP/Yj+1gzHwm41KcCl5Hm
	 Wjfrg27YF0PTu3OlYIWnFvD5aB7YqCK108NX1D0eNu/Ku10gmXoRawokW2rGnbEB1Z
	 q5UicrQAMaqk838nIrt1hsEfMv7jLMTx09C3MEHioC5A2xboKD8tJr0jBombWuklga
	 x/IWnw8rHRcPw==
Date: Mon, 22 Apr 2024 19:27:55 +0100
From: Simon Horman <horms@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, dsahern@kernel.org, matttbe@kernel.org,
	martineau@kernel.org, geliang@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, davem@davemloft.net, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	atenart@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v7 1/7] net: introduce rstreason to detect why
 the RST is sent
Message-ID: <20240422182755.GD42092@kernel.org>
References: <20240422030109.12891-1-kerneljasonxing@gmail.com>
 <20240422030109.12891-2-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422030109.12891-2-kerneljasonxing@gmail.com>

On Mon, Apr 22, 2024 at 11:01:03AM +0800, Jason Xing wrote:

...

> diff --git a/include/net/rstreason.h b/include/net/rstreason.h

...

> +/**
> + * There are three parts in order:
> + * 1) reset reason in MPTCP: only for MPTCP use
> + * 2) skb drop reason: relying on drop reasons for such as passive reset
> + * 3) independent reset reason: such as active reset reasons
> + */

Hi Jason,

A minor nit from my side.

'/**' denotes the beginning of a Kernel doc,
but other than that, this comment is not a Kernel doc.

FWIIW, I would suggest providing a proper Kernel doc for enum sk_rst_reason.
But another option would be to simply make this a normal comment,
starting with "/* There are"

> +enum sk_rst_reason {

...


Return-Path: <netdev+bounces-99922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30B28D7037
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 15:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97DC82822F8
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 13:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A8D1514D0;
	Sat,  1 Jun 2024 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mF8zfR4c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E7A1FA1
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717248630; cv=none; b=cX80UqCT8LXEIY2qRc5btueqa5aSTiUB10S+1fruLFAS4vX9yyKclzaMvX6E3qIqOJ3VwDGM+e0PX119rbg7hSk3eu+UYTNXxcR/b9f1AD7dJsr5MvUypKzOyjitjWF0ZV07gI4HZT5y9vq3JAoLNYj+SFQ4701rNrFHHncNvew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717248630; c=relaxed/simple;
	bh=NE2zh6nIZZVp7tENSf/sGl4moHwYoR+yioOzLzMXE6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piFGrV48YkugrZY7IQpbERX5A9zt4YHZk3RqDBkwMappE3qU2NrnZw4TF0AgdBlZLSvKoy7v72sZYYAB10BR0x5PeJw23GHEr9bEfQYusv6yLdf0xHcURTpmaSAgw6lBAbdseNrSFNOv2uJOWxx5B1q/SaKkB8Bci8OnV/uZNJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mF8zfR4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A40C116B1;
	Sat,  1 Jun 2024 13:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717248629;
	bh=NE2zh6nIZZVp7tENSf/sGl4moHwYoR+yioOzLzMXE6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mF8zfR4cTtf3GV7P05RWECmn/iEbw7XE6vJ+HpIm6SkPO1kbba5ILpfCVyHn7koMQ
	 4Id6S0VJGkkih02v4pKr3V+ZdxHNnf3PABaPsY7NsUnKg0rdotyS2EyZKS/pTRJmBb
	 Bb9qcp9nKJzlJGVQfrAtvR9L81TVmo1t3tu8p8IcckIwy0UrA99kdVDxKtnds+fG50
	 OE+0iFv8hv0pKb7ufoqgflH3WGMXqGqc/6wiYtuIkvWb4JrvvhZVdHB8jXmRnn74zR
	 X3fEcpj+6xwRO9PTiPXf/Np7t8l7sFiuPLUWishTp9stWvKGQRiGkv6YBCwpaiPVYb
	 mH+NTNN/Yjkog==
Date: Sat, 1 Jun 2024 14:30:25 +0100
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next] af_unix: Don't check last_len in
 unix_stream_data_wait().
Message-ID: <20240601133025.GO491852@kernel.org>
References: <20240530164256.40223-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530164256.40223-1-kuniyu@amazon.com>

On Thu, May 30, 2024 at 09:42:56AM -0700, Kuniyuki Iwashima wrote:
> When commit 869e7c62486e ("net: af_unix: implement stream sendpage
> support") added sendpage() support, data could be appended to the last
> skb in the receiver's queue.
> 
> That's why we needed to check if the length of the last skb was changed
> while waiting for new data in unix_stream_data_wait().
> 
> However, commit a0dbf5f818f9 ("af_unix: Support MSG_SPLICE_PAGES") and
> commit 57d44a354a43 ("unix: Convert unix_stream_sendpage() to use
> MSG_SPLICE_PAGES") refactored sendmsg(), and now data is always added
> to a new skb.
> 
> Now we no longer need to check the length of the last skb, so let's
> remove the dead logic in unix_stream_data_wait().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

...

> @@ -2744,8 +2738,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>  
>  			mutex_unlock(&u->iolock);
>  
> -			timeo = unix_stream_data_wait(sk, timeo, last,
> -						      last_len, freezable);
> +			timeo = unix_stream_data_wait(sk, timeo, last, freezable);

Hi Iwashima-san,

A minor nit from my side. In the case that you have to reason perhaps
keep the line above to <= 80 columns wide.

...


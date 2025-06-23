Return-Path: <netdev+bounces-200259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2262AE3F97
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 14:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF9F189B408
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10BD24DCFB;
	Mon, 23 Jun 2025 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CH4E1c6E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1F21F4604
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680739; cv=none; b=uLnSTiNMD6STuS7xvncdrANnGKnlLAodrUsJ33AOxyfgOh8yNqEyaz4i96+1v4TSR2M0CzbTo0k/up3gw4wOoOhqPZujEtQzARm+desJA3sVlFph4y7PxUrCxW1XLfS82N9JC+vHcfOuWhly7hhvhNQwrTxpKp2hbtDbtOx+XMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680739; c=relaxed/simple;
	bh=3Lk07Nllisu7GDEZfzZ/CW8Nuhl6ydFNFzi+aQM+7A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7OpIUVq2HyrGQRcdt4O+XE5wYuK/yw05RFFlbbPa564Y/vv9/D4PE541WjXuznxbpE7DLpi703euxySo2RKCwJl5k4+o1dk/v2MRBt4SVBfCy2JxJY8tDb3AENWPpeEb+NUvYGB8NymbY3o/0jesyz1lIdWUcACVXUlpck8Vv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CH4E1c6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC3CC4CEF0;
	Mon, 23 Jun 2025 12:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750680739;
	bh=3Lk07Nllisu7GDEZfzZ/CW8Nuhl6ydFNFzi+aQM+7A4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CH4E1c6EmzAMJmR2a/EaasUMeJdLPbqverFuehhnoXUGXC2F3tHTkVnK8nE46mng6
	 Ae70xD3HPHP4ER4lxMQdy+m5ZXKKaFtvgPfZxudJGsH/+QAZ7PTJ61Ua9Wu/enwLuL
	 hObwSHlwMrgYLwDtAXk2IjKuvw6zaAjViPyZFiVglZlESy8m1/q6sQjx5aQhLB4E9d
	 rHZ/hecsbMn+b9wLCS1CfNw6VfFEQwuUTcrtpFm+hPDe1O5Mb5V7Fdrgh2qdLy3fpu
	 kryG2y9//hn0JmJRhO5Owz511SxOB7rNWKmZvDP9oAvWKfy60ZrWpZJi7D+Pp3VFkw
	 U2oPFgu0zyi2w==
Date: Mon, 23 Jun 2025 14:12:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Rao Shoaib <rao.shoaib@oracle.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net 3/4] af_unix: Don't set -ECONNRESET for consumed
 OOB skb.
Message-ID: <20250623-couch-pragmatisch-c0155fd10a11@brauner>
References: <20250619041457.1132791-1-kuni1840@gmail.com>
 <20250619041457.1132791-4-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250619041457.1132791-4-kuni1840@gmail.com>

On Wed, Jun 18, 2025 at 09:13:57PM -0700, Kuniyuki Iwashima wrote:
> From: Kuniyuki Iwashima <kuniyu@google.com>
> 
> Christian Brauner reported that even after MSG_OOB data is consumed,
> calling close() on the receiver socket causes the peer's recv() to
> return -ECONNRESET:
> 
>   1. send() and recv() an OOB data.
> 
>     >>> from socket import *
>     >>> s1, s2 = socketpair(AF_UNIX, SOCK_STREAM)
>     >>> s1.send(b'x', MSG_OOB)
>     1
>     >>> s2.recv(1, MSG_OOB)
>     b'x'
> 
>   2. close() for s2 sets ECONNRESET to s1->sk_err even though
>      s2 consumed the OOB data
> 
>     >>> s2.close()
>     >>> s1.recv(10, MSG_DONTWAIT)
>     ...
>     ConnectionResetError: [Errno 104] Connection reset by peer
> 
> Even after being consumed, the skb holding the OOB 1-byte data stays in
> the recv queue to mark the OOB boundary and break recv() at that point.
> 
> This must be considered while close()ing a socket.
> 
> Let's skip the leading consumed OOB skb while checking the -ECONNRESET
> condition in unix_release_sock().
> 
> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> Reported-by: Christian Brauner <brauner@kernel.org>
> Closes: https://lore.kernel.org/netdev/20250529-sinkt-abfeuern-e7b08200c6b0@brauner/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

Thanks for fixing this!
Acked-by: Christian Brauner <brauner@kernel.org>


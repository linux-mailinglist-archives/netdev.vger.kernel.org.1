Return-Path: <netdev+bounces-76217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C84486CD3D
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 16:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C37A9B21405
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 15:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D15C143C48;
	Thu, 29 Feb 2024 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j69R3bwr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196C83E489
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221072; cv=none; b=OsnLGdXVFZuUfSxDzvGdhaLAG5Kcar0kIWmNRigEavhw9uc0R2XJ1Vu8TqLyZ0E/7a33rH2KSFT4s8xt4sGakHFRuKfKBY/q3lviw3sDdUNP+c6LGnHuzUONMuSgIQ7e6ZffaakVUAHmGktWLFyNwu9xO7v5rA69xZ3EZdsQ2+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221072; c=relaxed/simple;
	bh=Ji4kKlDI4pBGAq1ShpKbrNK4v4fNybTX4hJ2EtLKumY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9I2F2y9Y6g9JHTHQTpPZTKu3uL9pW7I0dE2Q1mk9mnpNkgxa2ja22zvV0vcLbsegq2cYuS8fQXIVaYJfb4we736ELKKg++ZDWLgvKitplWHAngZtMYOPmjoTLmUcjBcEHUvlKdYKolQqwWwU624+usOfiJshhdlwgv6a6lFazM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j69R3bwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E3EC433F1;
	Thu, 29 Feb 2024 15:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221071;
	bh=Ji4kKlDI4pBGAq1ShpKbrNK4v4fNybTX4hJ2EtLKumY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j69R3bwrZBbvH9rFtegQ8Q8hYMW2Y6mwjqed0qUo0HkmEmAI/sCZzyrYiUeA4Xdlz
	 kqIOP3KuK1CzzUx64IjErL6wJj0QqEs0wKCpur6aoTIuFvGxZEgT1scUBfxnRmJscM
	 /l3FNNaJS6gzRoZz+ju+fFhF3zNtJ6d60C6GBJMo6Rrwxv6wnxwmFGegGTlbXIyYfM
	 EyBLwgPsWbNz4dGSZDyD0M9b6GlCizQxDJnW0Rme5GmjqShkA5UOOCi5r1EWKfFFSq
	 V1u3Wb+P+tCZfZ0TkJ+djJpEPVKP/aNppKABi6V2ubiNvDItUQ6E46+kZlERQo1A2b
	 hpZm4C78CSDPw==
Date: Thu, 29 Feb 2024 07:37:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Jiri Pirko <jiri@nvidia.com>, David Ahern
 <dsahern@kernel.org>, netdev@vger.kernel.org, Florian Westphal
 <fw@strlen.de>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 6/6] inet: use xa_array iterator to implement
 inet_dump_ifaddr()
Message-ID: <20240229073750.6e59155e@kernel.org>
In-Reply-To: <20240229114016.2995906-7-edumazet@google.com>
References: <20240229114016.2995906-1-edumazet@google.com>
	<20240229114016.2995906-7-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Feb 2024 11:40:16 +0000 Eric Dumazet wrote:
> +	if (err < 0 && likely(skb->len))
> +		err = skb->len;

I think Ido may have commented on one of your early series, but if we
set err to skb->len we'll have to do an extra empty message to terminate
the dump.

You basically only want to return skb->len when message has
overflown, so the somewhat idiomatic way to do this is:

	err = (err == -EMSGSIZE) ? skb->len : err;

Assuming err can't be set to some weird positive value.

IDK if you want to do this in future patches or it's risky, but I have
the itch to tell you every time I see a conversion which doesn't follow
this pattern :)


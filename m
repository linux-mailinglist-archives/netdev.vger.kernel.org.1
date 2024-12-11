Return-Path: <netdev+bounces-150915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 032349EC125
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 01:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC18168217
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 00:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAEC4D8A3;
	Wed, 11 Dec 2024 00:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5ccgsJV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ABD1F949
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 00:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733878770; cv=none; b=ruS7yebuoLV3ar/tqmmrE1ON67aa8iabkx++Iq6P3dCwFrx4KoF2khpfQsi6EwnzWq0ykrZihCucUSagu7j+5GQq2dB71n6MRdNf20knLHDFB/C3HS7NhEkaJAChmXDJzNkhil1XjOuXnRZbZkZt6lUb4MF2uv9BweO/fdltrpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733878770; c=relaxed/simple;
	bh=2eEwHT72/u4XxyGBevbiQqT4zc0BhDMAqZv6w9GeNxc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GuEMqwSRORKnDkjk9KiRj/nnMgRDWrmASRD07ZveS4pEuxtVZuYtJA2kY/TdRVViwowyuCkUFDHtY5R1gSwX8WYYW46EmYnaIup9pmAY69wDJP+dXPvGjLFOtSiORbViWeteSiKkAaakqh/eMVbXNHxIj+2iNTI0oJz6rKfiPwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5ccgsJV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83829C4CED6;
	Wed, 11 Dec 2024 00:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733878770;
	bh=2eEwHT72/u4XxyGBevbiQqT4zc0BhDMAqZv6w9GeNxc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q5ccgsJVP4uzUtdP/wi7mstKvjRSlpZwCIgc7/1+oxxGMep8lcyn1ULURso0+jIYH
	 9gQCQ9kDNhqg/mIJxNqVgQGWMoSG+f+zRrmSl7LZO51JNvED2c5eM3l7DZle3t7pai
	 67+BbWKNgMafdjsir+NESfQSBG7d/PCw8FVb09y7k5Ghn/ihxDFlVMYmkdKfTLxbzd
	 1PUFpTf1YsGD9FLEBXA3yT92B57ZRSn0Qr8HY7TkH+ccs89dgXRkd6Xt47dsHQSc4h
	 qUPjZXaj+hJOMTl4WwsNmNJkOMcbFUjpbB79mQAZeXa+hT6pD50V17QtqxQFcsClgV
	 DFyATQBbfPp4Q==
Date: Tue, 10 Dec 2024 16:59:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, David
 Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, Fred Chen <fred.cc@alibaba-inc.com>, Cambda Zhu
 <cambda@linux.alibaba.com>, Willem de Bruijn <willemb@google.com>, Philo Lu
 <lulie@linux.alibaba.com>, Stefano Brivio <sbrivio@redhat.com>
Subject: Re: [PATCH net] udp: fix l4 hash after reconnect
Message-ID: <20241210165928.6934188e@kernel.org>
In-Reply-To: <4761e466ab9f7542c68cdc95f248987d127044d2.1733499715.git.pabeni@redhat.com>
References: <4761e466ab9f7542c68cdc95f248987d127044d2.1733499715.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Dec 2024 16:49:14 +0100 Paolo Abeni wrote:
> After the blamed commit below, udp_rehash() is supposed to be called
> with both local and remote addresses set.
> 
> Currently that is already the case for IPv6 sockets, but for IPv4 the
> destination address is updated after rehashing.
> 
> Address the issue moving the destination address and port initialization
> before rehashing.
> 
> Fixes: 1b29a730ef8b ("ipv6/udp: Add 4-tuple hash for connected socket")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

I feel obliged to point out a lack of selftest both here and the series
under Fixes :(


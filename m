Return-Path: <netdev+bounces-123567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7322B96552A
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 04:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D998B21949
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 02:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C2D4D112;
	Fri, 30 Aug 2024 02:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNVd3SOo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5582D4690
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 02:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724984077; cv=none; b=PDonWpatxljfAFVeKq0YuBpio4AH5x/eeGPOPgnHl0BAeaYRJc86sw4cWcEJsRnEMip+p0OnKkLX27DE0pm0ausGjIDrlh6hEqNBCOBwkAilCOC/ZoiyV9Tsgn8Ijx50/t/8S24IksqFmdW6Ss/7WfBrKYHZyAVnku69ySrr3is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724984077; c=relaxed/simple;
	bh=lH93ZsdR3rZ23Ssy4/SATUhZZ+rE0Kt6JW4EVURmXds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qEGVMDfD8u7rSy/zYhJi0hfKUenFG+t5C6Yvjka4tA7+ljxRbBSKxcD5UoIkRYByWuJ/fSRt6pD2VvDKBEcq0n399jrwAKeNkRj6n5/SZkt7BM3ffnFl2MRUJZU1r1KCLZ/TX4i2SNncaxFZ5L+/JVMj5S7TPSW4zTZCqQ529WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNVd3SOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C92C4CEC1;
	Fri, 30 Aug 2024 02:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724984077;
	bh=lH93ZsdR3rZ23Ssy4/SATUhZZ+rE0Kt6JW4EVURmXds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lNVd3SOoS5xf1HM+Ag4OdFm/mH6eFvSiqlQZUCZcGQ7bMkMoaI2r31MdcY1g+F1S1
	 qWt2SRaU9HNvn7aUWtNq+ztqLQh5gy9sQ/emSswJu+bVSkNsQwLv/xjUUgHiv+OBUY
	 /X55MCE+AQjn3rEJ98tYpwieb2YZpyGUbRMY+IwEketsXjojTntrKOmIJBmyhAoucl
	 2aUc1uCrY+ZYliq8iTbzTpOYub9oVkWvVInZLgfdOOrLFgU2AGS0H1mLf1m6x0KUql
	 8WkJrKqp0g8UtUla56QJzuinYuVkT7QMgjHJ4IcaThLzdkPcoFVy4OhsWoziLB3b3i
	 9VPel93S6JkKw==
Date: Thu, 29 Aug 2024 19:14:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 dsahern@kernel.org, willemb@google.com, netdev@vger.kernel.org, Jason Xing
 <kernelxing@tencent.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: make SOF_TIMESTAMPING_RX_SOFTWARE
 feature per socket
Message-ID: <20240829191435.739154ef@kernel.org>
In-Reply-To: <CAL+tcoCXTwarrWpaZ8adVz9cV0FsROTBRHJS5v3YOtE0jJD+ZQ@mail.gmail.com>
References: <20240828160145.68805-1-kerneljasonxing@gmail.com>
	<20240828160145.68805-3-kerneljasonxing@gmail.com>
	<20240829122923.33b93bad@kernel.org>
	<CAL+tcoCXTwarrWpaZ8adVz9cV0FsROTBRHJS5v3YOtE0jJD+ZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Aug 2024 08:40:47 +0800 Jason Xing wrote:
> In this case, we expect to control whether we can report the rx
> timestamp in this function. But we also need to handle the egress
> path, or else reporting the tx timestamp will fail. Egress path and
> ingress path will finally call sock_recv_timestamp(). We have to
> distinguish them. Errqueue is a good indicator to reflect the flow
> direction.

That is better, FWIW, thanks


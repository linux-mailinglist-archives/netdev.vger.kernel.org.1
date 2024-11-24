Return-Path: <netdev+bounces-146930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386BB9D6C80
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 03:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD41161740
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 02:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889371BF37;
	Sun, 24 Nov 2024 02:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZf8ax+y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F05F1FC8;
	Sun, 24 Nov 2024 02:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732415633; cv=none; b=TpaWIk05CqfCI9dVA2bx6zpnk4uc44syVURarMOAXHStSnnCnmVQ05izNXvg7kZkoHbctUj7If7tJxgxiCw9tWKwTUvZrDCyxSpVBpaFDXzGFwi/cvRr1YAaWdPI3hMAcc6VbNH3QtDNKhwt+Da3B/wu+8KoLoM68i9NkCi0ZxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732415633; c=relaxed/simple;
	bh=MHgkf4950Dv/pXJOwCEapYXWpGGemZnM6ozWk9gJHL8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFLu2s7tJvpGtyKLr3Y55BNpOs7kLK9sVIUTQSjD5ZHo0dITyrJoRnP8t+nyXo1TCCRdknxjkpRwKFZDJm4Zuu0mYxnejFZKhOKSydwWyfMxyZHpQnoNFhuj8VUpNIkZ7JVIvUthxC+6uV1/IkBY+Lg/2esREmlUu1oKvvdPHZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZf8ax+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E48C4CECD;
	Sun, 24 Nov 2024 02:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732415633;
	bh=MHgkf4950Dv/pXJOwCEapYXWpGGemZnM6ozWk9gJHL8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NZf8ax+yKFnT5V6LPnNTtCVX5TJTuDlsIM52OkE2T5C/OFcyA1dR20z41kREc+n0p
	 Q8XRZjyuEazlHNiVleRDwbfhiMBULQ3b3rRqbQAF36u0tc/NLapyOqteUjWXmuFGMk
	 wyJQ/eQC7L2UYMZePrfu5lJyPSNr0CrYB098+TQmDfUciV02Wo2momHpn9OSDeD+vb
	 JSTWH7RzyawDkT6ZUtyK/+XvzHy6wNvHpWE3PquzAQubI+kUlsEFVtEoLkJ82E3280
	 TmmfZLj6ltV6dYaGpqnQdLZ6+1bmQNmkCBgn0OgfC3a+GT2q+TL50vVOvVRPu0Djdn
	 XnIx5Vokkf8WQ==
Date: Sat, 23 Nov 2024 18:33:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>, Mina Almasry
 <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>, Willem
 de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net-next v2 4/5] page_pool: disable sync for cpu for
 dmabuf memory provider
Message-ID: <20241123183351.582aa8ac@kernel.org>
In-Reply-To: <CAAywjhRb0Lb9fJocWBU1r01521sy71hLOaH=92gqceXqUOGHJg@mail.gmail.com>
References: <20241107212309.3097362-1-almasrymina@google.com>
	<20241107212309.3097362-5-almasrymina@google.com>
	<20241108141812.GL35848@ziepe.ca>
	<CAHS8izOVs+Tz2nFHMfiQ7=+hk6jKg46epO2f6Whfn07fNFOSRw@mail.gmail.com>
	<20241115015912.GA559636@ziepe.ca>
	<CAAywjhRb0Lb9fJocWBU1r01521sy71hLOaH=92gqceXqUOGHJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Nov 2024 14:10:28 -0800 Samiullah Khawaja wrote:
> > > > If you do this you may want to block accepting dmabufs that have CPU
> > > > pages inside them.  
> 
> I believe we should be following the dmabuf API for this purpose, if
> we really want to sync for CPU in. page_pool, and should not assume
> the behaviour of the backing memory.
> 
> The dmabuf exporters are supposed to implement the begin_cpu_access
> (optional) and the sync for cpu is done based on the exporter
> implementation.

DMABUF is a bit of a distraction here.

What's key is that we need to fill in the gap in the driver facing
page_pool API, because DMABUF will not be the only provider we can
plug in.


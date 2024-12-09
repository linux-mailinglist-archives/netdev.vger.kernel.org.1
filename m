Return-Path: <netdev+bounces-150393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF6A9EA15A
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 22:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5E82829D9
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 21:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ECB19D08A;
	Mon,  9 Dec 2024 21:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKl21bNS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9D619D06A;
	Mon,  9 Dec 2024 21:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733780672; cv=none; b=q04Hg3CJpWEctXFZvvh+0CgN2NjvtAYHVMh0CC9RvfluDC/ilUuytIFXRJRWHv9Z9Q65gV6h9Egr/1697nhWI26/MXVeL1O2qgBLaJK6k+k6UnWGDEXpWSOpgMBej0S9fAxynHhl2Why93DdC/ieFIAWniL4zGz+T/F1GtPmjBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733780672; c=relaxed/simple;
	bh=8Zwmc8+keEBf913N09eZ9odCEXLxK7GQu41YDQemRyY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ClLaAOd1mQcX/YC63+jKHtqX6KLs5rxHCIUZGy1r0kRqaBdZCHjLhaKSiHEgkQu1hM6yybw0lWUZYTHFPRtwVOB8042k/WlWeN1D3+qyPzOlxR1wgitvhsTtHDEQBd9KlfK7EOQcmLg6Bt/bzkK4g1z0ehc8Qi8NvKe0gRZRBQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKl21bNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97857C4CED1;
	Mon,  9 Dec 2024 21:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733780671;
	bh=8Zwmc8+keEBf913N09eZ9odCEXLxK7GQu41YDQemRyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uKl21bNSMP1/eVEyKuFtjN6dBStUdAl6LKqTZpVcDvRRUA7fSwUOobW3XLc9JTnCw
	 qfq5HX5tqimJWInXhKTjuHEC6eF8DEs32kG+zbu8Zc159mF/yr+EGP8sYQXmrwQQvK
	 gjnqc4sm7FgCyY/HON/ZLK2ytIo9DNu5gMeLL/otKs/lUb3UMlQmYK80qhV1b4iNbj
	 PjvxRfc1FGCqq+QiQGnGKCbNgN/Gw98FuxtKBLyyXFdMAohCDP65BkHsL4dlne9Zlc
	 /OdVMcOVMVar4qVANlSUytC6PDZ4Xc4mIpvS2ezZPVQlwGszjYcemRVnOGFSO0tIQ2
	 9ygZTZSjEmyzQ==
Date: Mon, 9 Dec 2024 13:44:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: stsp <stsp2@yandex.ru>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tun: fix group permission check
Message-ID: <20241209134430.5cdefa09@kernel.org>
In-Reply-To: <062ab380-ee73-45ad-9519-e71bb3059c13@yandex.ru>
References: <20241205073614.294773-1-stsp2@yandex.ru>
	<20241207174400.6acdd88f@kernel.org>
	<062ab380-ee73-45ad-9519-e71bb3059c13@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 8 Dec 2024 09:53:40 +0300 stsp wrote:
> > I personally put a --- line between SOB and the CCs.
> > That way git am discards the CCs when patch is applied.
> >  
> I simply used the output of
> get_maintainer.pl and copy/pasted
> it directly to commit msg.
> After doing so, git format-patch
> would put --- after CCs.
> How to do that properly?

You can have multiple --- markers, you can insert your marker and let
git format-patch add another.


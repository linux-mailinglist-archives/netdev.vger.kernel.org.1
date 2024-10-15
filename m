Return-Path: <netdev+bounces-135757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC6799F1A2
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7421C21E87
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 15:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FEF1DD0FC;
	Tue, 15 Oct 2024 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koC/qCX8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58531DD0FB
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006919; cv=none; b=B6ziom+QLxwWrd3xmn7645qHTo/rIxRPx20jk3Y5s8jh9JUfRwk7q2zlmtZw0fEHX1W+ey9AearLPtvD8doWE1cnOFvWvlHjtF+NHxUMa+VkLdV+Of3U959ySSFYd9tqpMICLa8gnXUPfBXpSnHdYG6615PHiLSfEcbU50MdF2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006919; c=relaxed/simple;
	bh=r4OFyxn42iOn7JrYChr3YbK40WJfvlY8RB0BfWV3aFs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B0JsQJLrQZm8PsYFSAgzhY8XfXtwSoEYyEK/GalP7JFM9ItRfVnSbTJiy6NQPHDKZKcJVzNVvOpJP1JK7en6cauTmmUnrBYW/gopg0DIxjrLicPxs/zF2cPQfGcuaiZDNVxTMZjad5Mcu5XdQyqqmcmeviEPTFYm5ukMm9d191U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koC/qCX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3629FC4CEC6;
	Tue, 15 Oct 2024 15:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729006918;
	bh=r4OFyxn42iOn7JrYChr3YbK40WJfvlY8RB0BfWV3aFs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=koC/qCX8um7/DESHtuJtVNtG+z1sOrnbjnSdxnW9382o8a9dcA0NbqYvMaX7UePAK
	 bNFH4zl6e9jxhwvWLYBgp6YXWyn0EuuEWvjrQDOzMylw+jgbac9JVZ/4tEsw50YTsE
	 BQ8PQSHiOnQHZLjT7pTrmbryLqbXUcCvssuZTRhU3wCo51Ovmx0m1i1Wa2IyxiXN9n
	 64BUAsvuXRPieBsBImfoZAf3ve+JE2L9MRGGnyNddrlrAURkc4+KJy5Jlh540+RSTF
	 zwhDspVDx2vlm8GhD8hInH2okJ8MpyAx/iFj6mfyID5LAIbi1+j7b2kiM+Rmr5W6pW
	 f5zpsOSYcQvXw==
Date: Tue, 15 Oct 2024 08:41:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Michael Chan <michael.chan@broadcom.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] bnxt_en: replace PTP spinlock with seqlock
Message-ID: <20241015084157.2f0a2178@kernel.org>
In-Reply-To: <2f6119ae-128d-48ba-b7ef-d5a610df8a7f@linux.dev>
References: <20241014232947.4059941-1-vadfed@meta.com>
	<20241014163538.1ac0d88d@kernel.org>
	<2f6119ae-128d-48ba-b7ef-d5a610df8a7f@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 11:25:00 +0100 Vadim Fedorenko wrote:
> > I think when you adjtime / adjfine (IOW on all the write path) you still
> > need the spin lock. But in addition also the seq lock. And then the
> > read path can take just the seq lock.  
> 
> I think there is a spinlock in seqlock_t which is used to prevent
> multiple writers.

My bad.

> > This will also remove any uncertainty about the bit ops.  
> 
> Should I use read_seqlock_excl_bh()/write_seqlock_bh() for the bit ops
> then?

Yup, modulo what Micheal said in the other leg of the thread, but SGTM.


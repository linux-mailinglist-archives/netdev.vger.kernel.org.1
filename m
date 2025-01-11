Return-Path: <netdev+bounces-157326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C47A09F8B
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 01:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5DD3A115C
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 00:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8276610D;
	Sat, 11 Jan 2025 00:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0KzO+Kb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930C75C96
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 00:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736555925; cv=none; b=FARGLOG20nEW6TBA+0VZV7TIjBaGOODgXfejS45YQeP3Asoxq+Y/KDgoyg1+KrG3RUodTfcisNfVYME0eyWgWvoYleCDpXLftd7sAxIGXucBL3tczqa6t4IJTMHDhSouZ6YnqWVeLxEPl8pTCusIeTPW82Wnhp3CN5u+oelKxX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736555925; c=relaxed/simple;
	bh=zdtk+xGNFlTChs8ahDQC95t5a5Qz9+9rQKBzuVs9GEw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGpwn33TXaiQ/7sDWlJ/UHCKz4zXSPZpM8RKGvIIY9RQllwqWUj6E1gWrpy8OcDyoOH7srPuV752L78nf/0AKFpHqOSQJJZ2QSpuCIBCKyTe1S3jW8vXP/bBiyg6XRRVm1Obd/wfllTybz5DIYxHtPDnTkjK0ruhpr3F8DI8Jxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0KzO+Kb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95CAC4CED6;
	Sat, 11 Jan 2025 00:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736555925;
	bh=zdtk+xGNFlTChs8ahDQC95t5a5Qz9+9rQKBzuVs9GEw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O0KzO+KbELsDZvY7ldXernqQhcX+8b6gslHKhVXIRplwIo7hhgunnmyETFI/PqMoc
	 6jjwBYhGgn8IIH3BSvQnzRKwvMIaZb9A+Rlft6v80uvPzxXaT8okPrY9dUq6u1OJL9
	 ifSO8lObSX5Tuc3viJILdidShCIK2Et72V3TYURu98bYMFJn5E2ZORvZETfCkhtPQk
	 uebtpSkdIwg2WYksGVf9uOszjUalpX+DoNHVjtTNTZ7NV211XSPRT1HAepSggcUr30
	 zKuMQbPiH/j6U8GaJDbBYd578f5eHs9uQPgRvi36WaJBK26BD/s4KeZhK/IK5dfSV9
	 hlmM0/hb6Rpsg==
Date: Fri, 10 Jan 2025 16:38:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: John Daley <johndale@cisco.com>
Cc: andrew+netdev@lunn.ch, benve@cisco.com, davem@davemloft.net,
 edumazet@google.com, neescoba@cisco.com, netdev@vger.kernel.org,
 pabeni@redhat.com, satishkh@cisco.com
Subject: Re: [PATCH net-next v4 4/6] enic: Use the Page Pool API for RX when
 MTU is less than page size
Message-ID: <20250110163844.39f8efb3@kernel.org>
In-Reply-To: <20250110040302.14891-1-johndale@cisco.com>
References: <20250107030016.24407-1-johndale@cisco.com>
	<20250110040302.14891-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 Jan 2025 20:03:02 -0800 John Daley wrote:
> >>Good point, once fragmentation is no longer possible you can
> >>set .max_len to the size of the fragment HW may clobber,
> >>and .offset to the reserved headroom.  
> >
> >Ok, testing going good so far, but need another day.  
> 
> Testing is OK, but we are concerned about extra memory usage when order
> is greater than 0. Especially for 9000 MTU where order 2 would mean
> allocating an extra unused page per buffer. This could impact scaled up
> installations with memory constraints. For this reason we would like to
> limit the use of page pool to MTU <= PAGE_SIZE for now so that order is
> 0.

And if you don't use the page pool what would be the allocation size
for 9k MTU if you don't have scatter? I think you're allocating linear
skbs, which IIRC will round up to the next power of 2...

> Our newer hardware supports using multiple 0 order pages for large MTUs
> and we will submit a patch for that in the future.
> 
> I will make a v5 patchset with the napi_free_frags and pp_alloc_error
> changes already discussed. Thanks, John



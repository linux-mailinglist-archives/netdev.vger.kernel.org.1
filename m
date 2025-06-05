Return-Path: <netdev+bounces-195276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDC8ACF274
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 17:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 192DD172845
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 15:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7D816D9C2;
	Thu,  5 Jun 2025 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwPfkDyY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4856D282EE
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749135623; cv=none; b=p6CzweZkMpqhwXl4VKlxwDwcoHON8U9NKQNSn1kIU/WyWi6r9eZTNRzEi042PRyDEf2gwPmljthpwHofbKbWSwczlx/NYSN6o+SecQkSnd1xek7FroaeZFqq2OHd3sv2t0VBVWXDt4x0i6pwQagJLefFxAuOtS1AaS3ILQfzluA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749135623; c=relaxed/simple;
	bh=dbJgHa8ejyVeGlts4x95hGEmyfn5reUY/VnkAy8bFiA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ku1Vh63LK4ZEwP7yazyYkqvCUOcFQAkWBHXSSbOiWT9cFi+knfTLdoy9O0mi9TxHMFlQe37J4xJNoI56NfchQXo0AyfV9xcVskQ1v8huFr7yD4L9C7i+X0rVLYiCgUY348j6jPK7fr0p0YiqnFJ3jH92uZlywQroAo2zpWNzi2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwPfkDyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECF5C4CEE7;
	Thu,  5 Jun 2025 15:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749135622;
	bh=dbJgHa8ejyVeGlts4x95hGEmyfn5reUY/VnkAy8bFiA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RwPfkDyYRgGs2ZbbFc2U9iRKFnwhGcz592l6b2XSmPf5oTZIs1UKTJAcy5X3jQU5K
	 y+ynPCzdsC/S5GXam6qvCdayrkl4BK0Lw359LRErgTH6YRbfz441J6Ze44uspMpRY3
	 MuSMafHwrezYsl1thnevg9iCQCwJ+AorAejd3/f8YZaIDsIiIOhlYhgcMsVAYbJgPt
	 MCTN1YHgNq3EW/IDAHOqXYD6lM8OoUtlaGmJwsbpIo0TKSPivX5KWp7GSCBk9DMNNq
	 1WuPfo7MQ0wPXcC50TC3WissvlbxRLo9VtvMg759uNkL0SlD9MQVHqt4f0uSFVCwCp
	 h+KAXVQRQv+RA==
Date: Thu, 5 Jun 2025 08:00:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, przemyslaw.kitszel@intel.com
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, sdf@fomichev.me
Subject: Re: [PATCH net 0/6][pull request] iavf: get rid of the crit lock
Message-ID: <20250605080021.3a22f581@kernel.org>
In-Reply-To: <20250603171710.2336151-1-anthony.l.nguyen@intel.com>
References: <20250603171710.2336151-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Jun 2025 10:17:01 -0700 Tony Nguyen wrote:
> Fix some deadlocks in iavf, and make it less error prone for the future.
> 
> Patch 1 is simple and independent from the rest.
> Patches 2, 3, 4 are strictly a refactor, but it enables the last patch
> 	to be much smaller.
> 	(Technically Jake given his RB tags not knowing I will send it to -net).
> Patch 5 just adds annotations, this also helps prove last patch to be correct.
> Patch 6 removes the crit lock, with its unusual try_lock()s.
> 
> I have more refactoring for scheduling done for -next, to be sent soon.
> 
> There is a simple test:
>  add VF; decrease number of queueus; remove VF
> that was way too hard to pass without this series :)

Nice work, thank you!


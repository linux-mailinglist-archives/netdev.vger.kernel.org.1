Return-Path: <netdev+bounces-226814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 290F6BA5557
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 00:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC18F383BD2
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 22:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42299279355;
	Fri, 26 Sep 2025 22:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLkMUP4u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166E34C9D;
	Fri, 26 Sep 2025 22:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758925823; cv=none; b=pKY+3i1PgCwYNv3p3GYmHjbRxOKLpaERjvW8XNRIoiC/9h0RAqsbbU5g6/1yseF6xZVqXB7OCWOqTuV1d42C1nNQlgQ5Af1AOM1Oj565KlQ7j+IRgRJDPN/l9YKrtmy1Whbf39ow7HQvGzXD0zsPJWNbakPsNsyRIT4Nd1RL5HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758925823; c=relaxed/simple;
	bh=DnYZKDgZJRGoOij2mgfIyq+rTFLbRNq/MJ2uvRBYCrU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tO3bIivvtwvEBPrr71jQHPHwQJbmei3MfLR+qf75keBSwasZgWgV4xXErJ/a08eizSt3BJVEIcuxU8WeZTHXAV6yhdEhhNv0GNxW8BvXpw5qzEIMwhyuABMxYxO9KZ7xRgV51E8AqW+8K4ccSOIXjmWTzCZTOnVW4aiFA5/2ShI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLkMUP4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25176C4CEF4;
	Fri, 26 Sep 2025 22:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758925822;
	bh=DnYZKDgZJRGoOij2mgfIyq+rTFLbRNq/MJ2uvRBYCrU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RLkMUP4u74sWpQfAjnfBIIhPBV3Qm7HShlBF3j9wDr8tuIKVipm517fcNmj56pV2Y
	 TnquDeWDvXGaqvFKpMkKQcx7HaWYcrByJses/O4sUCaNFvuBx4snDADfcd5LlZXTxn
	 Z6l5XzMP7tdrR5Je0/KfYkIatNJuojZ1wk6Z5RKZbC3C0F1hWpYp9792Nl4tXJEBVP
	 p3p73GuFS0w2sGPYyWsAWfWKsSLwmk/Pryxr8g1z2qwZVOYPy2I2D9WYfk8SBXZn2Q
	 L4rZLo2LouPTVqb+FxqTgh0HOw4L8FyPFOPfbX8tyqgK8rKOF/EH/eXRmbYSkRNGIj
	 RhPee1JSJhUVA==
Date: Fri, 26 Sep 2025 15:30:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
 syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com
Subject: Re: [PATCH net v3] ptp: Add a upper bound on max_vclocks
Message-ID: <20250926153021.46848cca@kernel.org>
In-Reply-To: <20250925155908.5034-1-viswanathiyyappan@gmail.com>
References: <20250925155908.5034-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Sep 2025 21:29:08 +0530 I Viswanath wrote:
> This can be reproduced by executing: 
> 
> echo x > /sys/devices/virtual/ptp/ptp0/max_vclocks
> 
> where x > KMALLOC_MAX_SIZE/(sizeof(int)) which computes to 1048576 on
> my system
> 
> What would be a reasonable value for PTP_MAX_VCLOCKS_LIMIT?

I wonder about that, too. Perhaps tying uAPI behavior to
KMALLOC_MAX_SIZE is going to come back to bite us. But I don't
have a great idea for what the max should be.

> KMALLOC_MAX_SIZE/(sizeof(int)) is the absolute max value for which the 
> memory allocation won't fail


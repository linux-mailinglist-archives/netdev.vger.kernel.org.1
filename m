Return-Path: <netdev+bounces-215668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39390B2FCE4
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 16:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06FD14E162D
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D9C2A1B2;
	Thu, 21 Aug 2025 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPdkO1ne"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19812EC549;
	Thu, 21 Aug 2025 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787065; cv=none; b=dH4qR4Uip10pYcWO7AY92o6Je4LvVw2J/838Qf5xko0zhjMXUwXf4PLaCCkKR6HiQf9iGlkRw1rxB8QHOtf0nyy6VHmEqt9YtlYmfrXbpC7wrk1aGF1ACgq7d307oVopUq4VunXdsFaQ2Dkg2BUKW8Hs/V1Xozv6LNU37pd9Au8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787065; c=relaxed/simple;
	bh=1vrbY0X9co0KzB/I/9Y6/Ln/h3hmwgwFOPu33wQyVDE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p9G0Y+qSd+vRR1iw35VyRdYy9UfY8x91Y7gsd002J0uVSdG8aqDX1F/7cW1hu0ewucI8wi3nsQdAr0CoLxUVYXa8MrI2mAmynrPTVieRkAOl/Hblybg5SOTWUmN5RX7oi8nXrzInEwmASN+W9F46PBrJ3B6Jxia7gkcIqggkFvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPdkO1ne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB0DC4CEEB;
	Thu, 21 Aug 2025 14:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755787065;
	bh=1vrbY0X9co0KzB/I/9Y6/Ln/h3hmwgwFOPu33wQyVDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bPdkO1ne/HIdwP7RUp83SJ0wvTyncFfKz+pUd7CPkBkCsLujOE8HOWK2tepJK1p/G
	 DwD5UpIZ8+RmxrgoBq8ztQQHjOcLvs/6WxqStnis3lbItMZphBQxY72CYs0iMNx2Dw
	 UTg/gce2MsOH+ArU5bP8FzfZnmvxvwbqcGtBZfn3/RjzLFb5E4OhWwfv2/HoTHSaj1
	 NMnElRg3pGkXxhYk8SdV7v/ZDypmjTN72liPoJSmRYGzhidVfzz3uuGDf5rtjhCJrZ
	 tEHVES18gA3/Zy+hSig3vIgQeSsJ1HPUEbixuWfne3+Ep4liju9KBVqozUVgcR5eNP
	 V3ImZFEQI8szA==
Date: Thu, 21 Aug 2025 07:37:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?="
 <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen
 <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>, Christian
 Brauner <brauner@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Li Li
 <dualli@google.com>, Tiffany Yang <ynaffit@google.com>, John Stultz
 <jstultz@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, Thorsten Leemhuis <linux@leemhuis.info>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH] netlink: specs: binder: replace underscores with dashes
 in names
Message-ID: <20250821073743.7bf0e0db@kernel.org>
In-Reply-To: <20250821135522.2878772-1-cmllamas@google.com>
References: <20250821135522.2878772-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 13:55:21 +0000 Carlos Llamas wrote:
> The usage of underscores is no longer allowed for the 'name' format in
> the yaml spec. Instead, dashes should be used. This fixes the build
> issue reported by Thorsten that showed up on linux-next.
> 
> Note this change has no impact on C code.

I guess the tree where the patches landed doesn't have last merge window
material? I thought the extra consistency checks went in for 6.17
already.. In any case, change makes sense:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>


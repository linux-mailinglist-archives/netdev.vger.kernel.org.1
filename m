Return-Path: <netdev+bounces-124263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F8E968BAF
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 18:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3AB1C22866
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F411A3040;
	Mon,  2 Sep 2024 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMhHnx7x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9C41A2659;
	Mon,  2 Sep 2024 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725293462; cv=none; b=kvN0ZAt/GTuXZDxuNmd5aprVJF4ExflK/C2aXE1AkfezSuCaPr08bLadB/ILEkLb5USpr2WieaGO+S3Zd/goXwuOhWsuMqOxqCQ4wila3RwzgJQLj5BYcDVTDBh72f5TFUNbadijREP/aDjfHEcSeopLVfkQ1ATORK4zl/AE7cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725293462; c=relaxed/simple;
	bh=YF7BiudXlR2XGJ2GK/rIdAsgWsAxRRE5v7AiFUk78a4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UMJ8oLU+504bNBnsqZ+xlSIG1FefNS2wC9ng1SZd0kn1i8a1gEVCdEeLyJS/F0iHHUsvmLUneakjm2fK8Vg1eJVG/K5GcExcWXiheyI6Btb3H8BTDWO2Sp9jiVVGjn9ASG/AGT1LzJ0rAf5SgylM5WIXS6FIDfohnoBqayWY33M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMhHnx7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC042C4CEC7;
	Mon,  2 Sep 2024 16:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725293462;
	bh=YF7BiudXlR2XGJ2GK/rIdAsgWsAxRRE5v7AiFUk78a4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BMhHnx7x8b8kq0VOMRBNCVJjDrnqSNZSJ9GR+NXIwyjxvYtqNyEKBdYw6at50Jxeh
	 yWlu4mW2x/lQS/UV1PPQDnXdzGw9i9fJB9pXKlOMunIu5ZrZSILfOIw4eh6xH0Atpz
	 qRINOxktkivRZAn4rEdUJkf7USoMhaPocuwjTEbMnrF9hbwydPN/jKuzrC51bovn7J
	 bK38o52sLSVNZa/SfIGWOB/6yPhLCwWBgF/PiK3d2X1ee5dCrQ2qAZoUQGSJPJVRB2
	 rSYOrgM6eTpNPP4NijB1oM/FJ6C4imoszscZargiEfZmmVl9eAuaMIJCKK6jW6tG/X
	 zcOMgywRmQg9A==
Date: Mon, 2 Sep 2024 09:11:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Hongbo Li <lihongbo22@huawei.com>, kees@kernel.org, andy@kernel.org,
 willemdebruijn.kernel@gmail.com, jasowang@redhat.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, akpm@linux-foundation.org,
 linux-hardening@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH -next 2/4] tun: Make use of str_disabled_enabled helper
Message-ID: <20240902091100.1fa07b84@kernel.org>
In-Reply-To: <3360d021-6290-4d6a-9d83-cd4c2d47fd0d@nvidia.com>
References: <20240831095840.4173362-1-lihongbo22@huawei.com>
	<20240831095840.4173362-3-lihongbo22@huawei.com>
	<20240831130741.768da6da@kernel.org>
	<3360d021-6290-4d6a-9d83-cd4c2d47fd0d@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Sep 2024 09:10:33 +0300 Gal Pressman wrote:
> > You don't explain the 'why'. How is this an improvement?
> > nack on this and 2 similar networking changes you sent
> 
> Are you against the concept of string_choices in general, or this
> specific change?

Willem verbalized my opinion better than I can.

If a (driver|subsystem) maintainer likes string_choices that's
perfectly fine, but IMHO they are not worth converting to, and
not something we should suggest during review.


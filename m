Return-Path: <netdev+bounces-26492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4E6777F35
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 19:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4A228221C
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2E8214E7;
	Thu, 10 Aug 2023 17:33:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1951E1C0
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 17:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E73CC433C8;
	Thu, 10 Aug 2023 17:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691688781;
	bh=w486nyzRHpAmngFJBzsm9JYDfkyohxWqFlzZ7SdQvoo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q3HhqwYvxrtiMVGJ6Qz2XBKY7M0GRY9i5LxNPqRqmzX/Y6Rm4iJZjjuEgs3JvGrsh
	 THau7ihA1GlXKRDD7JTzzk6aNrdndmEha+LGL7RBQ5KNgNs78a4SYrtQywqwkMxd5i
	 X0yKxaGzp+Rq5DKvXBf7dLX1PILOgXeC+G1Rh3DZmdlKgjkk/wM6Dq3/+sqNn6TXvd
	 hFxVt+q8CJktcJ/Y9QDcv9FWRtrdUpZJ7PZ3nStkovVXA/5Lm4Vth5EWGE/p2zFE41
	 kZ4YAaaQzefBHsIqoZawk7QL9szGC1lzFfDTssCTGCugBSQbKqc/BfFw0GVwfE8B9W
	 yXrxQxjbEmWHQ==
Date: Thu, 10 Aug 2023 10:33:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shay Drory <shayd@nvidia.com>
Cc: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
 <edumazet@google.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net v2] devlink: Delay health recover notification until
 devlink registered
Message-ID: <20230810103300.186b42c8@kernel.org>
In-Reply-To: <20230809203521.1414444-1-shayd@nvidia.com>
References: <20230809203521.1414444-1-shayd@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Aug 2023 23:35:21 +0300 Shay Drory wrote:
> From one side, devl_register() is done last in device initialization
> phase, in order to expose devlink to the user only when device is
> ready. From second side, it is valid to create health reporters
> during device initialization, in order to recover and/or notify the
> user.
> As a result, a health recover can be invoked before devl_register().
> However, invoking health recover before devl_register() triggers a
> WARN_ON.

My comment on v1 wasn't clear enough, I guess.

What I was trying to get across is that because drivers can take
devl_lock(), devl_register() does not have to be last.

AFAIU your driver does:

  devlink_port_health_reporter_create()
  ...
  devlink_register()

why not change it to do:

  devl_lock()
  devl_register()
  devl_port_health_reporter_create()
  ...
  devl_unlock() # until unlock user space can't access the instance

?


Return-Path: <netdev+bounces-26956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D74779A80
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 00:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDF6D281AF5
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 22:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5EA34CC1;
	Fri, 11 Aug 2023 22:14:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A876D8833
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 22:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4A8C433C8;
	Fri, 11 Aug 2023 22:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691792044;
	bh=ij7a71/93P/g8NWn3Yd2f9267DUpu7Im83IKmaelYjk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B/yHjJrdYgQ4RPQS0xfdOYpCvSVK4ViiJhjxsWcWOJ3inOge8CcbzAJ/zvDC6TRlw
	 gV2nkA5T1UuDYvnPLbkHx3OLudpnnNmmX3ib0JtlsWZwvs8nWHVnsNISiKNBqhtSL4
	 tJ3UNy1C1DSc+PFSgucj6WGcqLzRkbOe58nQqYlS2yVeiAHjESIarAX557NpzpKtAh
	 bQkKe7BocFK37GYctu4GPM4dxjmFa1nIDI3ayWoNlGkOrUs2OZ5D8XMs/reNMjSsAE
	 IaUOONRp6Wrg2/42mWttZEw+mE7YCL1uP3oF0DTdai8A+KGcR8xUUxCOEx5imUP/yv
	 3/7TUul2wQzfA==
Date: Fri, 11 Aug 2023 15:14:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Shay Drory <shayd@nvidia.com>, netdev@vger.kernel.org,
 pabeni@redhat.com, davem@davemloft.net, edumazet@google.com, Jiri Pirko
 <jiri@nvidia.com>
Subject: Re: [PATCH net v2] devlink: Delay health recover notification until
 devlink registered
Message-ID: <20230811151403.127c8755@kernel.org>
In-Reply-To: <20230811144231.0cea3205@kernel.org>
References: <20230809203521.1414444-1-shayd@nvidia.com>
	<20230810103300.186b42c8@kernel.org>
	<ZNXrr7MspgDp8QfA@nanopsycho>
	<20230811144231.0cea3205@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Aug 2023 14:42:31 -0700 Jakub Kicinski wrote:
> > Limiting the creation of health reporter only when instance is
> > registered does not seem like a good solution to me.
> > 
> > As with any other object, we postpone the notifications only after
> > register is done, that sounds fine, doesn't it?  
> 
> No, it doesn't. Registering health reporters on a semi-initialized
> device is a major foot gun, we should not allow this unless really
> necessary.

FWIW I mean that the recovery may race with the init and try to access
things which aren't set up yet. Could lead to deadlocks or crashes at
worst and sprinkling of "if (!initialized) return;" at best.
All the same problems we had before reload was put under the instance
lock basically.


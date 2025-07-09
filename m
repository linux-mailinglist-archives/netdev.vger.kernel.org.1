Return-Path: <netdev+bounces-205519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F640AFF0AD
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 20:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AAB05828C4
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 18:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC74238D22;
	Wed,  9 Jul 2025 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdzi+dm5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654B9238C2D;
	Wed,  9 Jul 2025 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084906; cv=none; b=GdvY4g4gZ3bdHMHF0WlNQJDuKPnWleI70GIwJ+gLHnRkdIgoP5jR2VgWh/RPzSOclfWhgcsWcOP2JbR1R0AY96Leb9L8mbpEY+MHnvbUGTanFsLVhkzJxj2qwk3LVOWefQu0m355rAkz80C1VhJaJ4j8ukUlzE+9rAd1GohncT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084906; c=relaxed/simple;
	bh=ftDWFaZGRI3jKpLhEWU7GiVvBKEdc90tSIWQ6m1cfcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mamVB3yZbY91mqxrrWnpHjW7Z7RdcycSOTPUfR9IQdj2FDd0/i6bkCOdq2QFWFBKJYgFfu9Ne5kzvoAVdsev6lcrKYHzyuYu2zqixx6DdwSbvNMEjKIqxm5dmSw6bsEYhg8Yqcd5Ch9SCcLwGDW8CJHpPbXFmSjR47SgA0UXABk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdzi+dm5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354E9C4CEEF;
	Wed,  9 Jul 2025 18:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752084905;
	bh=ftDWFaZGRI3jKpLhEWU7GiVvBKEdc90tSIWQ6m1cfcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qdzi+dm5MbtX/jujblrieXw4roY7qc/vMd42v5VU0Lfa7oWNDkQQrbOTUfO3t7bA9
	 ZEp3zh8F5XTIynhPblhEXan5ViDW4hztLCwpQOP8FU0Si8EhySgssYLECXK2STGByP
	 L90EV+UvFi9XgkUwn3tJWlX8Mn7PQV9QWESKmKFrAs0joFdLgXzMNqpYaDMrqig8AH
	 MtilpXjmzNITH6embH8eamyEJJUf/BJ3AfTKmSvH8aBQQflU1eOaDa7Y25XfLNYLkY
	 Dpp4cuLDEnN92j8JWZshqhjt93GR/XAlpQJrkavNHFE0wkzpcNRqqiF3UP288yqTMX
	 K77/YbKyYFkSQ==
Date: Wed, 9 Jul 2025 19:15:02 +0100
From: Simon Horman <horms@kernel.org>
To: Yun Lu <luyun_611@163.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] af_packet: fix the SO_SNDTIMEO constraint not
 effective on tpacked_snd()
Message-ID: <20250709181502.GI721198@horms.kernel.org>
References: <20250709095653.62469-1-luyun_611@163.com>
 <20250709095653.62469-2-luyun_611@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709095653.62469-2-luyun_611@163.com>

On Wed, Jul 09, 2025 at 05:56:52PM +0800, Yun Lu wrote:
> From: Yun Lu <luyun@kylinos.cn>
> 
> Due to the changes in commit 581073f626e3 ("af_packet: do not call
> packet_read_pending() from tpacket_destruct_skb()"), every time
> tpacket_destruct_skb() is executed, the skb_completion is marked as
> completed. When wait_for_completion_interruptible_timeout() returns
> completed, the pending_refcnt has not yet been reduced to zero.
> Therefore, when ph is NULL, the wait function may need to be called
> multiple times untill packet_read_pending() finally returns zero.

nit: until

> 
> We should call sock_sndtimeo() only once, otherwise the SO_SNDTIMEO
> constraint could be way off.
> 
> Fixes: 581073f626e3 ("af_packet: do not call packet_read_pending() from tpacket_destruct_skb()")
> Cc: stable@kernel.org
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Yun Lu <luyun@kylinos.cn>

...


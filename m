Return-Path: <netdev+bounces-122976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DEB96351A
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B52FB2142C
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BA21AC8AE;
	Wed, 28 Aug 2024 22:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwgBCv1z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F23B14BF8D;
	Wed, 28 Aug 2024 22:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724885879; cv=none; b=qsTOBO5ZuZ2KSqOS4Y1wcvco5/TShwtmlvemLAphsqLqzdMKQ43R4FZW93Chni5hWTvC2OZp2zN+XAnPnvbJLKMc3jiN7Cq7oL5WUM7MVrMJTuIX61a6DEN9zx93jVf+U0XNGwg+UB3ZWQztVj1g96vnesv75l3idYc451X5DgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724885879; c=relaxed/simple;
	bh=FxOA8Mq6k/1/DAfynJX6BwJJ5BtzYA6h+dM8g0lFq0c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gu6/QHTgHfA9ogikYJtqc68BwkU8s0y0yYh6ha4X1GbLR1A2mPDWlTscEesEPOfGLoQVPS3teUr5yhbAyBQUBkbdHjM1YbW+aR8WwJxshlysTPG6Wu79q6PTz3y7hmFYw8mXkH1Oz0JcU+aQaQpYreS/pu4iL4gEO+u8So7e/O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwgBCv1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11FEC4CEC0;
	Wed, 28 Aug 2024 22:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724885879;
	bh=FxOA8Mq6k/1/DAfynJX6BwJJ5BtzYA6h+dM8g0lFq0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KwgBCv1zvzA6ZQH195WpTLW/JpK3sadzUiOY7B2Bbv12On9HqmCCsaxyusX+9ySHZ
	 LSPwTiOeWfVWRd8vy4aGSQ99cSzdwDfGi+bMyjNVzWz5npOlatYuPbZDEqe1QbHHfs
	 7SS33xxoNAsEGKvtWEiscCBe6A+nnAOQ5J3c2zUj/7x8yQMMOF0JmHLx1LaR3B4c5I
	 5ShV8HkUKr9mgnuhPXDIywp3MPygP/2a0rqB5U+8F3PIo4yYE5oTwOJ4UTZdpgWwpg
	 n2GDmhrK+VYrbDJTOcsEhMvWnzvKZyjaVngRK0DPHmrolpEOuC10XvInjp4egjR8Dv
	 ft9Pka0lDZL4w==
Date: Wed, 28 Aug 2024 15:57:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maksym Kutsevol <max@kutsevol.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Breno Leitao
 <leitao@debian.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] netpoll: Make netpoll_send_udp return status
 instead of void
Message-ID: <20240828155758.61e3a214@kernel.org>
In-Reply-To: <20240828214524.1867954-1-max@kutsevol.com>
References: <20240824215130.2134153-1-max@kutsevol.com>
	<20240828214524.1867954-1-max@kutsevol.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 14:33:48 -0700 Maksym Kutsevol wrote:
> netpoll_send_udp can return if send was successful.
> It will allow client code to be aware of the send status.
> 
> Possible return values are the result of __netpoll_send_skb (cast to int)
> and -ENOMEM. This doesn't cover the case when TX was not successful
> instantaneously and was scheduled for later, __netpoll__send_skb returns
> success in that case.

no need to repost but, quoting documentation:

  Resending after review
  ~~~~~~~~~~~~~~~~~~~~~~
  
  Allow at least 24 hours to pass between postings. This will ensure reviewers
  from all geographical locations have a chance to chime in. Do not wait
  too long (weeks) between postings either as it will make it harder for reviewers
  to recall all the context.
  
  Make sure you address all the feedback in your new posting. Do not post a new
  version of the code if the discussion about the previous version is still
  ongoing, unless directly instructed by a reviewer.
  
  The new version of patches should be posted as a separate thread,
  not as a reply to the previous posting. Change log should include a link
  to the previous posting (see :ref:`Changes requested`).
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#resending-after-review


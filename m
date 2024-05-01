Return-Path: <netdev+bounces-92781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E638B8D2F
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 17:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16FA51C21AD3
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 15:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DEF13341A;
	Wed,  1 May 2024 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYpWI67m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF473133413
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714577494; cv=none; b=BwkKuZ4uQXR7KoBv1DS1cl75R+hVorK+J9Lq86pfzsk7U+ViFg/hC0R+PNdBNPyWP44U6l/sun1k6FNigHkUSjQgE8hXdNFwzTCH8YYGw1ZlRujqqtUbNw6obHcKtq1AnM3hKB1obQpx/9OZmjGiTBX2GB15zr88RpjQwedLIzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714577494; c=relaxed/simple;
	bh=rY57Xa1URtJFCJmhRtQBCpe5UdZ4B8HR8LqnZ8ShNnw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+ClRzNqFfEsUk7EsGy6duZgubhgpmSLEF6ryv8rN57W2mGcYG6lw00Z+oD7WK4Lfu/RVBJXQInwdpWkjX8axGHQ4pN/5hlID4VHeI3R+15jjk1AnXqxXF5NM4OTeRbtiNx5rvOjNFVZXjl2WHKehAAPgFEGdDP54IE8R/FkyQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYpWI67m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CCFC4AF14;
	Wed,  1 May 2024 15:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714577494;
	bh=rY57Xa1URtJFCJmhRtQBCpe5UdZ4B8HR8LqnZ8ShNnw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gYpWI67muQ+PSdz6em0wdGGcqUkmgmhiVSavAojtfhK/xs1+r5akSz73eG4JNXdSl
	 2GbPRZJNp939vEgEpvjsslx15g2CO9hFoWuc+5vPC8nDuu8mAtiLlH1Bf/4iaXTK4Z
	 hUIw5Qd6naAQ/TYeuBNcrJ9/VrS740NrM9vSOQjQDktZ00a0skvLO/XnFcPrgaQOPY
	 4yxgAaOlTK37uFNgH8GfC3EBEda8stryfVdIhKwydTPvd9jHWOt0qhr93WCtz6pCak
	 TUdPlcTBOM39G1y+e/CFECdQANQogvg4wDsPM5iinEfeg0qVW8oUGdZZ4Gs653aiyl
	 e/JXC+LeuRfdQ==
Date: Wed, 1 May 2024 08:31:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shailend Chand <shailend@google.com>
Cc: netdev@vger.kernel.org, almasrymina@google.com, davem@davemloft.net,
 edumazet@google.com, hramamurthy@google.com, jeroendb@google.com,
 pabeni@redhat.com, pkaligineedi@google.com, willemb@google.com
Subject: Re: [PATCH net-next 09/10] gve: Alloc and free QPLs with the rings
Message-ID: <20240501083132.1ba34a02@kernel.org>
In-Reply-To: <20240430231420.699177-10-shailend@google.com>
References: <20240430231420.699177-1-shailend@google.com>
	<20240430231420.699177-10-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 23:14:18 +0000 Shailend Chand wrote:
> Every tx and rx ring has its own queue-page-list (QPL) that serves as
> the bounce buffer. Previously we were allocating QPLs for all queues
> before the queues themselves were allocated and later associating a QPL
> with a queue. This is avoidable complexity: it is much more natural for
> each queue to allocate and free its own QPL.
> 
> Moreover, the advent of new queue-manipulating ndo hooks make it hard to
> keep things as is: we would need to transfer a QPL from an old queue to
> a new queue, and that is unpleasant.

Some compiler unhappiness here:

drivers/net/ethernet/google/gve/gve_rx.c:315:7: warning: variable 'err' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
  315 |                 if (!rx->data.qpl)
      |                     ^~~~~~~~~~~~~
drivers/net/ethernet/google/gve/gve_rx.c:376:9: note: uninitialized use occurs here
  376 |         return err;
      |                ^~~
drivers/net/ethernet/google/gve/gve_rx.c:315:3: note: remove the 'if' if its condition is always false
  315 |                 if (!rx->data.qpl)
      |                 ^~~~~~~~~~~~~~~~~~
  316 |                         goto abort_with_copy_pool;
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/google/gve/gve_rx.c:278:9: note: initialize the variable 'err' to silence this warning
  278 |         int err;
      |                ^
      |                 = 0
1 warning generated.
drivers/net/ethernet/google/gve/gve_main.c:1432:6: warning: variable 'qpl_start_id' set but not used [-Wunused-but-set-variable]
 1432 |         int qpl_start_id;
      |             ^
drivers/net/ethernet/google/gve/gve_main.c:1454:6: warning: variable 'start_id' set but not used [-Wunused-but-set-variable]
 1454 |         int start_id;
      |             ^
-- 
pw-bot: cr


Return-Path: <netdev+bounces-208636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9582FB0C76F
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 17:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D803B7BB2
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 15:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1012DE213;
	Mon, 21 Jul 2025 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+uei1wk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077802D836F
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111273; cv=none; b=sRKVtHyy4DrCFJJZDq0YZT04++r+HVeE4TLQyfplFrXvP7QfQcv+fnFeuqn+BRulPiL83mWbMPYDWFoordepHT8CWfm2QdhPLOrTymPBhDyUc2QnWEdHu1zg1cWOw9exhsgk5YGvXLettsZGpOsoGnrqYy5A9X/p3aaJz//rVaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111273; c=relaxed/simple;
	bh=xuOWFEDdjKxSYTq7yMaw6enKdvklo/uf1BNGXSAebmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3iI51/QSG4jJpR92TxazWFnhoFwQHHjXhfFTe2O0rT6S0ycCf4IFt8KIPFlJnTte7dLMFRQEBRRSbjLorwHp5DcE12y9K8/bGscX8av4qw6lwU21kLPeu002biQ5296ZX/J+Sxt9toTb9O2YvmTLuMLRsnPk0Dj4HwmC56dU6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+uei1wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479B3C4CEED;
	Mon, 21 Jul 2025 15:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753111272;
	bh=xuOWFEDdjKxSYTq7yMaw6enKdvklo/uf1BNGXSAebmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A+uei1wkpRX+0zlPFbq7hIQymgtV2W8+jC/GhR9gedJcXqc1VXenOnp5CWhGQl21X
	 2fRsfaTd2/EkkKrs+rR9DKgozMm7tMnLfE+65sXa7AWcb8fV2Vt/0bct1X8LprJWFI
	 nz0c5yfkvRphG9LKRvL7cklA3gGl8FklgefJ+9sOZbcrx3sWO9PUlbfqDWcGYCMcjO
	 vOsRfpUkoxOVHqjtM+Zu+SLhMV+QIAXsOs0bd/GKrvTeibFPQy7BIGQOKKc1oTemI+
	 f1Lk/FFMCFrztUhOeXM86E8PzkP6SRfK+1YyE2BhlztE66hMzes+3lmRpxqd3JW2Mu
	 papcC1/yYc4Zw==
Date: Mon, 21 Jul 2025 08:21:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 donald.hunter@gmail.com, shuah@kernel.org, kory.maincent@bootlin.com,
 ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next 6/8] ethtool: rss: support creating contexts
 via Netlink
Message-ID: <20250721082111.6826d138@kernel.org>
In-Reply-To: <70db339e-a60b-430c-bc8e-f226decb44f7@nvidia.com>
References: <20250717234343.2328602-1-kuba@kernel.org>
	<20250717234343.2328602-7-kuba@kernel.org>
	<70db339e-a60b-430c-bc8e-f226decb44f7@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Jul 2025 14:42:36 +0300 Gal Pressman wrote:
> On 18/07/2025 2:43, Jakub Kicinski wrote:
> > +Kernel response contents:
> > +
> > +=====================================  ======  ==============================
> > +  ``ETHTOOL_A_RSS_HEADER``             nested  request header
> > +  ``ETHTOOL_A_RSS_CONTEXT``            u32     context number
> > +=====================================  ======  ==============================
> > +
> > +Create an additional RSS context, if ``ETHTOOL_A_RSS_CONTEXT`` is not
> > +specified kernel will allocate one automatically.  
> 
> We don't support choosing the context id from userspace in ioctl flow, I
> think it should be stated somewhere (at the least, in the commit message?).

Sure, how about:

  Support letting user choose the ID for the new context. This was not
  possible in IOCTL since the context ID field for the create action had
  to be set to the ETH_RXFH_CONTEXT_ALLOC magic value.


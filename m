Return-Path: <netdev+bounces-227474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 170E4BB04DC
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 14:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63B417C514
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 12:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDD6254AE7;
	Wed,  1 Oct 2025 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxDRzhn6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76B01BDCF
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 12:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759321157; cv=none; b=RshnAMjkd7GatCZhO4O8ZtH561N0et7g9hdVrbJKlvuZs4rPjZNznORJk0wMoItlFvUosfEHDes6tf4L5Ztke1lsTzZfAoSNBUeBbjcTtOU0Fh7A+AWNcVwKHuf5yZWok7jC24qQvcZDCXVpKzDmy/Y9k2414lIzab9rhWW+X7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759321157; c=relaxed/simple;
	bh=HiMMV6WA41eY6HEfiLbuPnmABBXxaH25z4O6bvOCp0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5X9LHckehANFsrBzjEfwHYLZQj8Fsy/x1dyr4oh3c3TwXfcVSPkCcoC8E6qqlqlSHDqR5chYAiDAXUt+7+iLwcOmlVP0acdr5lMCDFvMoBFBSwkWCCEBe2QtDNbVWUcC00LE+aTzmmLB2iE+T7y0J1byf56XgHSbApGBEZfMOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxDRzhn6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF776C4CEF4;
	Wed,  1 Oct 2025 12:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759321156;
	bh=HiMMV6WA41eY6HEfiLbuPnmABBXxaH25z4O6bvOCp0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UxDRzhn641RF1FYnz2mF1VRc5g5CBRGNbb3/ab19q/hkGAOlikm3+DRbeQB9HiEFy
	 jaREsEpFvBTAuToUpq1YrcyERilnl57pRT8Te+40g93zQSfQ7L94oTozuXdSDxWNkF
	 W2rxPft5BRNcBwOjHzO/ilKRzTWOkGrLXxN1BNbJAqYpPIZ5uljsyiDPrdtm8tX+qG
	 xIW72dE5+4TSZ86qVMKFn+dR5bM5Wyn38VGz1S3tgC2dmb0fUJAswX/udsb4sEJ5Hb
	 EzGENXGLcky5Rwp3pY+lxCOA2q1t/+Eiw9VmvQ/DncbjOmS2WWP1RLmXXF9OTsXWtP
	 +r1TQR/kyN50w==
Date: Wed, 1 Oct 2025 14:19:13 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: xuanqiang.luo@linux.dev
Cc: edumazet@google.com, kuniyu@google.com,
	"Paul E. McKenney" <paulmck@kernel.org>, kerneljasonxing@gmail.com,
	davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Subject: Re: [PATCH net-next v7 1/3] rculist: Add hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
Message-ID: <aN0cQd2Pz3cOjS13@localhost.localdomain>
References: <20250926074033.1548675-1-xuanqiang.luo@linux.dev>
 <20250926074033.1548675-2-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250926074033.1548675-2-xuanqiang.luo@linux.dev>

Le Fri, Sep 26, 2025 at 03:40:31PM +0800, xuanqiang.luo@linux.dev a écrit :
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> Add two functions to atomically replace RCU-protected hlist_nulls entries.
> 
> Keep using WRITE_ONCE() to assign values to ->next and ->pprev, as
> mentioned in the patch below:
> commit efd04f8a8b45 ("rcu: Use WRITE_ONCE() for assignments to ->next for
> rculist_nulls")
> commit 860c8802ace1 ("rcu: Use WRITE_ONCE() for assignments to ->pprev for
> hlist_nulls")
> 
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs


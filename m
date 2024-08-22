Return-Path: <netdev+bounces-120754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F1F95A894
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 02:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3B91F223FD
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 00:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14E1A38;
	Thu, 22 Aug 2024 00:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDPDwDmZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2D1368
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 00:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724285468; cv=none; b=TIiQn0sZnqvjAfmNczuMEJi8fdiUY5Z2p5+Rp42HoOBS/piUREBXTVl8JrTXPSKLReQhTUPTPm4Dq1tA46IR9/KCwHgfrIJ3FnFp+lP/NAEqS4cdXPhYkw0z1waEE7tbPVsBzUjXw9xz6skO0zFxk1sSxvM+wbOMz9OxAz2O5uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724285468; c=relaxed/simple;
	bh=Q4+G8lr5xY7firP1wiSD0wbj5P1Vew5VqmWCQmotR6I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xhx6dVLZOY8/yqOrQ4qDrh4rlzYtP2EOTdyV7+dKwCwSIoc/yuJzCk0vD5WqzPBXkB8hy7ibM2X4ncQVtfaPRFjTzZJ5cm8oUyoaD0T1h2GWzpqhdQJiQ47hRDv3jfZMgsfoKiDD1tNyqqRYokgZRs3owmbfVJGRm+PgrmBPpi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDPDwDmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD57C32781;
	Thu, 22 Aug 2024 00:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724285467;
	bh=Q4+G8lr5xY7firP1wiSD0wbj5P1Vew5VqmWCQmotR6I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JDPDwDmZQyM8Zh94ooG0WEhRYGvz6b4Ty/aLk2Xc0PRyF2msGZXEcClpEK+WjNJVb
	 klGcpD3Gu+ZD+MnMfKC2bElc8HLziHXhZUjT54CGSC3gVB2Xxn49NQwZ0TEN1gzDgL
	 Pg2x5tP3qufdFHO34Dmdvy4vQrqGUvGzs2VES6SYflHMYF7Ur1pDTaQ7Iy5S+qm2DZ
	 ypCRUq9duYFHNqgH2C9hvv5JSPVliGYTEePsc6y3mBOxCJqTCKKRDegDb5xtWJ/GXP
	 HihdiWFAoAy43VokqCZcfLckreEN0H3SWVu2iK9ifcyCE3pHfo6UEu30pl7AstQyG4
	 PLnPBRWsoDhBQ==
Date: Wed, 21 Aug 2024 17:11:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: Jianbo Liu <jianbol@nvidia.com>, netdev@vger.kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andy@greyhouse.net, saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com,
 liuhangbin@gmail.com, tariqt@nvidia.com
Subject: Re: [PATCH net V5 3/3] bonding: change ipsec_lock from spin lock to
 mutex
Message-ID: <20240821171106.69e8e887@kernel.org>
In-Reply-To: <120654.1724256030@famine>
References: <20240821090458.10813-1-jianbol@nvidia.com>
	<20240821090458.10813-4-jianbol@nvidia.com>
	<120654.1724256030@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Aug 2024 09:00:30 -0700 Jay Vosburgh wrote:
> 	Is it really safe to access real_dev once we've left the rcu
> critical section?  What prevents the device referenced by real_dev from
> being deleted as soon as rcu_read_unlock() completes?

Hah, I asked them this question at least 2 times.
Let's see if your superior communication skills help :)


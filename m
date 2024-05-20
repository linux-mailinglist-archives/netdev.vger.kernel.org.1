Return-Path: <netdev+bounces-97232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3028CA31D
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 22:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490F0281ABA
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 20:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF79137C26;
	Mon, 20 May 2024 20:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XU8tlNpY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8492826AC1;
	Mon, 20 May 2024 20:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716235575; cv=none; b=sxgNn2OTy4tV5ERWf9hPWg84XgLcphXc+1yRs2tBHfzFIzTnTP8vGmPPH1Bwos3H7TnslEboTXiEwyDOEaL0igirNUW9tczqMoeOXCQ9ri1gNgkrZWgJJ9uinf/GdoDxmMyG6tORDw6YMNbUspnsLVSQgaj5SAfiFZk0hPzC2uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716235575; c=relaxed/simple;
	bh=KXcQBuEjJkcM2zPf7EMgL19fpMvPGUqTBm5eaSkFGa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlALS7HY/zS8GAT6yf50DoLSuJiIouSXoD1vv3/pdGZJirWoZeEnKFeXlqaVcNgTOA1M1t14g9ppBkWl7EcTQEuOc/nyawBcJf4Vb3h7cS5xiMXWiUHslK3iBVMv+ZpU7i1SQ+ghM3b5CKZfOwaJegoA3PYXs7sZ+pxOoAJoUBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XU8tlNpY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F02C2BD10;
	Mon, 20 May 2024 20:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716235575;
	bh=KXcQBuEjJkcM2zPf7EMgL19fpMvPGUqTBm5eaSkFGa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XU8tlNpY45f9KM6cK/uvLQNvB2eZjfVJBpAv3moZx+0ZbLwkCEhq5mTMQbvp2s2Xj
	 hK3lrRYr/PWCkN+tLGwoo5z6lw9Ew8Rg2Lxh6vU/i1iVHYqRRI9bvb0def88afPPZc
	 YG+cOYCu7pZtAXXDIXR3R88MtK0gk6dP6Ezd0XLt799rFQnC86SH7TETvJyqPefDLC
	 qkq5wPp0JK/Rgpv55ZAbU8ZhpcRj+jQmkBVv/3f6vi82PZ1QwgRDgz1KvPEN6qh6mH
	 XBajGiYZLf3X7W358WwQmpiEWxZV3FsH0Zk7tur01U7yA217XAzHjo3/UTqiM4VSMJ
	 nOF7ZcyuiDPig==
Date: Mon, 20 May 2024 21:06:10 +0100
From: Simon Horman <horms@kernel.org>
To: Ronak Doshi <ronak.doshi@broadcom.com>
Cc: netdev@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/4] vmxnet3: add latency measurement support in
 vmxnet3
Message-ID: <20240520200610.GD764145@kernel.org>
References: <20240514182050.20931-1-ronak.doshi@broadcom.com>
 <20240514182050.20931-3-ronak.doshi@broadcom.com>
 <20240515104626.GE154012@kernel.org>
 <CAP1Q3XRYGySJQaWe8dvasUGmpZGcYy_g_Xgft2u=hg9R_eqEsQ@mail.gmail.com>
 <CAP1Q3XQKStM5Tn9HZjTdgki4_7RiF8EOf0ksZE9gzZYHNkAFbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP1Q3XQKStM5Tn9HZjTdgki4_7RiF8EOf0ksZE9gzZYHNkAFbQ@mail.gmail.com>

On Mon, May 20, 2024 at 12:19:43PM -0700, Ronak Doshi wrote:
> > On Wed, May 15, 2024 at 3:46 AM Simon Horman <horms@kernel.org> wrote:
> > If not, I would suggest making this feature optional and only compiled
> > for x86. That might mean factoring it out into a different file. I'm
> > unsure.
> I can move the rdpmc code under #if defined(__i386__) ||
> defined(__x86_64__) so that it will be no-op for other architectures.
> Will that be fine?

Hi Ronak,

I think that it would be an good improvement, as long as the result is a
working driver for other architectures.

Perhaps #ifdef CONFIG_X86 can be used as the guard.
I also would suggest using rdpmc helpers if possible.


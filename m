Return-Path: <netdev+bounces-167370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68903A39FEF
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 15:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082593B0B69
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F77426AA8A;
	Tue, 18 Feb 2025 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfSI+f1U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6809F2698BC;
	Tue, 18 Feb 2025 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888962; cv=none; b=dAS3buyc9/ckjAZSb+GbgPsekVl9xugafhMqb+zO2Umnmi2mY9IWsyiKwMISNP/E7/qEAkyhjdgCnhBZb95j6WEkqp0XIdV3h0erdfqX6OWSlhi31DhNKfMEIMfsLrKN4KKoFe6I0AM6b95Xu4ZdHHur9Torl/m5gTrlqQ0poAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888962; c=relaxed/simple;
	bh=PJhMxrQ6IRClgl4QOJlG0/le0GBoaW6SDI24GDJEeQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STKKehGSFHZiSFQ+5reBj472DolJ8Cfo86Q/9B4v9MkOl3fd5CbPpKukfSx57ediQE62HEHiodp3PxeO9r0fPwffpXArj9rgA6Dxy62lcD52v3tvu4cxhKwSr8GLnKRgDOf9Y2Imngx0mITy7GWYuU7IVPN5A4ALCoHfhkH8WkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfSI+f1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC70C4CEE2;
	Tue, 18 Feb 2025 14:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739888961;
	bh=PJhMxrQ6IRClgl4QOJlG0/le0GBoaW6SDI24GDJEeQ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lfSI+f1Uuymjh2OzEk8sO4SxYPf/fXPTIPttvRo9COZs9ID/PlxjuejyrARgTLyy9
	 4n/ByLBdcXtvExyif4Ps1NuohgE/fy0s9Nd9ewWmGgo0O3b+iKhNiZhqtx1wi6uPPj
	 rzuouN4GZrOpf7icgcX3eqHYI62vhUmfBwtNd00WTP11JSyxq/0wHuaeosrW+skqJ+
	 lxQTbjbMFiBtRed/SSNZFrz+qhc2ob25jvnJpIyraGDk1PiAZWT25cWOizBaQrfOoY
	 X2aEAaUJkHuv6aAI9NJVTlWIftZB3U+CVWSetzm08Ou2o7as8VEWgZBLr6vGD4PW/y
	 8e4RHg5hEQ4tw==
Date: Tue, 18 Feb 2025 06:29:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern
 <dsahern@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>, kuniyu@amazon.co.jp,
 ushankar@purestorage.com, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH net v4 2/2] arp: switch to dev_getbyhwaddr() in
 arp_req_set_public()
Message-ID: <20250218062920.40aaaa6a@kernel.org>
In-Reply-To: <20250218-debonair-smoky-sparrow-97e07f@leitao>
References: <20250213-arm_fix_selftest-v4-0-26714529a6cf@debian.org>
	<20250213-arm_fix_selftest-v4-2-26714529a6cf@debian.org>
	<20250217163344.0b9c4a8f@kernel.org>
	<20250218-debonair-smoky-sparrow-97e07f@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 01:36:30 -0800 Breno Leitao wrote:
> On Mon, Feb 17, 2025 at 04:33:44PM -0800, Jakub Kicinski wrote:
> > On Thu, 13 Feb 2025 04:42:38 -0800 Breno Leitao wrote:  
> > > The arp_req_set_public() function is called with the rtnl lock held,
> > > which provides enough synchronization protection. This makes the RCU
> > > variant of dev_getbyhwaddr() unnecessary. Switch to using the simpler
> > > dev_getbyhwaddr() function since we already have the required rtnl
> > > locking.
> > > 
> > > This change helps maintain consistency in the networking code by using
> > > the appropriate helper function for the existing locking context.  
> > 
> > I think you should make it clearer whether this fixes a splat with
> > PROVE_RCU_LIST=y  
> 
> This one doesn't fix the splat in fact, since rtnl lock was held, and it
> is moving from dev_getbyhwaddr_rcu() to dev_getbyhwaddr(), since rtnl
> lock was held.

Are you sure? I don't see the RCU lock being taken on the path that
ends up here. arp_ioctl() -> arp_req_set() -> arp_req_set_public()


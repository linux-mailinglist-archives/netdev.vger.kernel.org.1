Return-Path: <netdev+bounces-222356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DBCB53F5E
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 02:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F7F560489
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 00:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2B7111A8;
	Fri, 12 Sep 2025 00:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kd44Djh7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C444D2DC76D;
	Fri, 12 Sep 2025 00:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757635321; cv=none; b=f2f8L6tUl7FhiRDn7QF57sLl6JB8tL8Y7QDdmv7vnKKSA4Z3Ac9USzAbT9nqazXsxwlmPgrIaRk3gHR3VYHAyJZrEek/G7+vSKCScFxIXnnmZBAxTh1n9XvPlAi1ZFJSlB+VnEb72Diq6VnTRynFesF4COnjeKCd0eI8w7pwH+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757635321; c=relaxed/simple;
	bh=0wrrUK4oFK61WEcwJoC3CXhY9QFy4rgtgWwUYrq0Opk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7YUx9SGzTaMmlKejf+0Kj2DE1sIyub51Q+UNeqfxomyAD3Ygt37vxJQGLcEwrpIQZ0GhdnMhRz9eIIyHL35BJ0m/bFK7BmgBG21d7+I1JoBU6JjXFPgFyfnDOQn5yF7PBiml088waXZFgDMv1ig0EdqYy6Kzy3TCFA7yx7mnxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kd44Djh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03CCC4CEF0;
	Fri, 12 Sep 2025 00:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757635321;
	bh=0wrrUK4oFK61WEcwJoC3CXhY9QFy4rgtgWwUYrq0Opk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kd44Djh7pYO5hpTr2eXfUuw2U3SIZXAP03Bx/lMr6U5OjMqZoVFGwuKp9niagx3mW
	 J7wtpMixRjTORzLjl3S57ubl0+IUzLk2Jwu1UVqVexsGvGbvJnRYY+mfuDQ3hUEkt4
	 y0za4yPT4yyi/dVgIcHUQEK6ourw0nMI3CYlkmVqykCbpokVXyaeIChewqrrWBSgif
	 vZh8FxXMumht53cMKwt5uakXzo17LP/lsOSN5N6iZN7VpaPIeXChx0YXuUVaX+Tf8J
	 wFrn2ZgrkBGKTmDjZs0myx2YZDxAwO2DWG630RBOHmXYddJusBJhctH/sQIZCqypnJ
	 t87HiHPMP/kLg==
Date: Thu, 11 Sep 2025 17:01:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <Jose.Abreu@synopsys.com>, Rohan
 G Thomas <rohan.g.thomas@intel.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew
 Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net 1/2] net: stmmac: est: Fix GCL bounds checks
Message-ID: <20250911170159.383edcc6@kernel.org>
In-Reply-To: <2d00df77-870d-426c-a823-3a9f53d9eb30@altera.com>
References: <20250911-qbv-fixes-v1-0-e81e9597cf1f@altera.com>
	<20250911-qbv-fixes-v1-1-e81e9597cf1f@altera.com>
	<aMKxc6AuEiWplhcV@shell.armlinux.org.uk>
	<2d00df77-870d-426c-a823-3a9f53d9eb30@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Sep 2025 18:12:16 +0530 G Thomas, Rohan wrote:
> On 9/11/2025 4:54 PM, Russell King (Oracle) wrote:
> > On Thu, Sep 11, 2025 at 04:22:59PM +0800, Rohan G Thomas via B4 Relay wrote:  
> >> @@ -1012,7 +1012,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
> >>   		s64 delta_ns = qopt->entries[i].interval;
> >>   		u32 gates = qopt->entries[i].gate_mask;
> >>   
> >> -		if (delta_ns > GENMASK(wid, 0))
> >> +		if (delta_ns >= BIT(wid))  
> > 
> > While I agree this makes it look better, you don't change the version
> > below, which makes the code inconsistent. I also don't see anything
> > wrong with the original comparison.  
> 
> Just to clarify the intent behind this change:
> For example, if wid = 3, then GENMASK(3, 0) = 0b1111 = 15. But the
> maximum supported gate interval in this case is actually 7, since only 3
> bits are available to represent the value. So in the patch, the
> condition delta_ns >= BIT(wid) effectively checks if delta_ns is 8 or
> more, which correctly returns an error for values that exceed the 3-bit
> limit.

Comparison to BIT() looks rather odd, I think it's better to correct
the GENMASK() bound?


Return-Path: <netdev+bounces-119233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D75954E14
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 17:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62B81C2107B
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 15:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415E21BE85C;
	Fri, 16 Aug 2024 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1EeGSyV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB851BE854
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723823094; cv=none; b=X5wy3Zuznhw4rWvcivbqjOxMuBlI3piTG7VtjtNDr+0T2buiAQQvIIoziMWg/8HmqQlxfUVFBFu0jsrEN5Gghioxk8M8Lt+PZIk2enAMbhMtUTd93ltUYoa2C7noqyNaO20ogS1i5yPvX8Xb6p/JlQ+MG1FztjtxUgy25i1KFdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723823094; c=relaxed/simple;
	bh=DiCNzBlHKx9xWGChY/LgSz8kICtnK/qKJunkG8X4uMw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BxHxcL8pLAYxT0JWghEgPRFUk0sIxyJD03CwBGBZHrQML2kShX3TgStK1PpgAUo0gZdz6T37R7laA/DrZ1CXSoer5Fp4tkkryGJebStXbAmoklr7Fu8dIb+XEAbLl8/wEqcihUDqIhdOjMz0KEQKalaH+14n9jxUtJBn7UtT2O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1EeGSyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A537C4AF12;
	Fri, 16 Aug 2024 15:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723823093;
	bh=DiCNzBlHKx9xWGChY/LgSz8kICtnK/qKJunkG8X4uMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r1EeGSyVNpl8Eix/F602DM9ZNhwE3g6ONpN33x5VXfk16fx8FD2UzyZktaM+MHMyO
	 n9G70JlVFoE88Uor3/zM9Qpr16FULFgAsc9T1tpMZq7OXUV6JGv3g9AnOyHJNbuSza
	 fweT9CmDJVISpy2u56XOv7GHV6VVy5E6v2YoVi/14/VQFyl3wqEUehkWBzgKZlI8sh
	 VAq1WHRsUMdQcch5MTS3w/Y3dosJbWoxyHtycztcMLpxy1kllO0FDRLh7agPHkgtWu
	 Jtm+mzwLF0y5nZPwqK8aJA3qElIqe/kFX6pW7pYEu5Vjrnq3yfDD/BT0PXo0YzRl90
	 inSo1eF4PVkhw==
Date: Fri, 16 Aug 2024 08:44:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>, Network Development
 <netdev@vger.kernel.org>
Subject: Re: Per-queue stats question
Message-ID: <20240816084452.0af5ba00@kernel.org>
In-Reply-To: <Zr8ZtKXUgUo5OgSK@LQ3V64L9R2.home>
References: <56a36d45-f779-0c67-2853-6ead9e8f9dc9@gmail.com>
	<20240815124247.65183cbf@kernel.org>
	<Zr8ZtKXUgUo5OgSK@LQ3V64L9R2.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 10:19:48 +0100 Joe Damato wrote:
> On Thu, Aug 15, 2024 at 12:42:47PM -0700, Jakub Kicinski wrote:
> > > On a related note, I notice that the stat_cmp() function within that
> > >  selftest returns the first nonzero delta it finds in the stats, so
> > >  that if (say) tx-packets goes forwards but rx-packets goes backwards,
> > >  it will return >0 causing the rx-packets delta to be ignored.  Is
> > >  this intended behaviour, or should I submit a patch?  
> > 
> > Looks like a bug.  
> 
> FWIW, while debugging the stats stuff on mlx5, I tweaked the
> stat_cmp function to output a lot more information about each of the
> values to help me debug.
> 
> It seemed too verbose for an upstream patch at the time, but since
> you are going through the same process a patch might make a lot of
> sense.

We are in a desperate need of a better debugging flow :(
I hope Mohsin's patch to add verbose printing is ready soon,
it should be _a_ start.


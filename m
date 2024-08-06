Return-Path: <netdev+bounces-116123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DB49492CA
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 16:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187F6282475
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 14:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA3218D63F;
	Tue,  6 Aug 2024 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLRup0q9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D0E17ADE1
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722953877; cv=none; b=kiqSiiTBCycBlSSJ5F3mXtcApRIWdZrTLl1hGXf3huNoUQJas8OA3MzGEJbSxf3or+YSsbnZZhWpyZ8/V/oO9NHQjJq0Mp2O+vWD2eL3p99cagvOgbuxhtnsyC10tUQ9cCWVxh+ABcscm7GH4Sn5fj7TeMaVr+kyRlbtrUWqEgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722953877; c=relaxed/simple;
	bh=tYTcGEOmzO0CnvfGmbdY11RHZLvhUSSieW/yGJqjvD8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YV8aMIaBNGn/V4Zegwynnm3O3DHNU4KCu0LS2SlWW0/eNmJEqY14fEdpY4VFIGzAoeHRlovVnYsmB80c62+AIklnSDubCozPvRQGhGQ10AMZIuBfwVkVEjm6pjiy91YU6iqJEmLd6sZgRXGxJ2+qAGkFhi7BCFHl46susegiZtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLRup0q9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774D6C32786;
	Tue,  6 Aug 2024 14:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722953877;
	bh=tYTcGEOmzO0CnvfGmbdY11RHZLvhUSSieW/yGJqjvD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LLRup0q9cvXympOoYfccmqjsHbLi/6QeZ1k6tH6loBeeDIdF6ikiKmwe1x7XFwabQ
	 nj9ij5vnz23Y5Pre0rfhYQkkLCXWrPtJXXyElQar3bEVe8c9nprtdw3CsRnspPcYGm
	 TzeMwNig9WRTTCwRqQ5I+0XZfeG/tOA5ytjvCSmyp7Uqi7glnfd8ZDRyF8zLaRb9rB
	 rzK5uGvkrgohUFdmkkEFVKJdmjp+7w7XF5WpFwvemiEYipLHJhW05lDfKAhbl8s96M
	 7o7ZuT/VUG9clnHDUSzdUG4PL5pxO6tfdOW2zk8l29418s9tjVPfujgMAy2jN5i3hZ
	 keSJVVHhICsxQ==
Date: Tue, 6 Aug 2024 07:17:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Joe Damato <jdamato@fastly.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 dxu@dxuuu.xyz, przemyslaw.kitszel@intel.com, donald.hunter@gmail.com,
 gal.pressman@linux.dev, tariqt@nvidia.com, willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next v2 09/12] ethtool: rss: support dumping RSS
 contexts
Message-ID: <20240806071755.2b3c5f46@kernel.org>
In-Reply-To: <13606f9d-ff3e-f000-ba87-db890c8cfdcd@gmail.com>
References: <20240803042624.970352-1-kuba@kernel.org>
	<20240803042624.970352-10-kuba@kernel.org>
	<Zq5y0DvXQpBdOEeA@LQ3V64L9R2>
	<20240805145933.3ac6ae7a@kernel.org>
	<13606f9d-ff3e-f000-ba87-db890c8cfdcd@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Aug 2024 14:58:59 +0100 Edward Cree wrote:
> > Better name would probably help, but can't think of any.  
> 
> 'only_ifindex'?  'match_ifindex'?

'match' sounds good, I'll use that, thanks!


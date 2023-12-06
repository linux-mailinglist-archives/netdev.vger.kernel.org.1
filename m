Return-Path: <netdev+bounces-54183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4116180633B
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 01:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0E9D2821A1
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 00:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D73E19F;
	Wed,  6 Dec 2023 00:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhRb34vh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9B419E
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 00:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15155C433C8;
	Wed,  6 Dec 2023 00:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701821464;
	bh=Noje1nVjETDXyxffRE702mcXM1H93e1s6wI8ZABu2oY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nhRb34vhRLGrdqMDwI5CYxuzJs1xmLWMQEdI+RBkf3awuw75AWGf15VpK+dbRtujO
	 W09ODTaDjPQAzPiIBnapUud2CU9LyEr0nz4RqaAGgbOufQ+5o2+uP0b5VyX1/qzLba
	 igBCLXgwq9Efqb4skaEzxxga848wt1u0DzyD+JNpxsnQcHAizHet08BXokt4B0Jvl/
	 a9cu2wvHo/UrYIiNiZwilOz90AZn6GDfDyGrdWqbWHwh4u4Cvchci3AszTr8c2ywD1
	 XUt3TikX9tXRq2hbjBGXCRC5xB+k3/N3+CS5DN5ayexbGMHwIo4hDH/P3qfgHYBecj
	 TjYNzJrYwR9cw==
Date: Tue, 5 Dec 2023 16:11:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH net] net: core: synchronize link-watch when carrier is
 queried
Message-ID: <20231205161103.3bec2036@kernel.org>
In-Reply-To: <20231204214706.303c62768415.I1caedccae72ee5a45c9085c5eb49c145ce1c0dd5@changeid>
References: <20231204214706.303c62768415.I1caedccae72ee5a45c9085c5eb49c145ce1c0dd5@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Dec 2023 21:47:07 +0100 Johannes Berg wrote:
> There are multiple ways to query for the carrier state: through
> rtnetlink, sysfs, and (possibly) ethtool. Synchronize linkwatch
> work before these operations so that we don't have a situation
> where userspace queries the carrier state between the driver's
> carrier off->on transition and linkwatch running and expects it
> to work, when really (at least) TX cannot work until linkwatch
> has run.
> 
> I previously posted a longer explanation of how this applies to
> wireless [1] but with this wireless can simply query the state
> before sending data, to ensure the kernel is ready for it.

Are you okay with net-next?
The previous behavior is, herm... well established.


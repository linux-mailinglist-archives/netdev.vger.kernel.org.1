Return-Path: <netdev+bounces-114993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D9F944DB9
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A0DAB20E03
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DB11A4862;
	Thu,  1 Aug 2024 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFgG1SCi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E2228F3
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722521613; cv=none; b=hHF0cwg9FgmE587NqXctBn4rX4wKsDqlBziUaX7dS8KyTETTsPa9Yx+fP9/ze2OLeQLh/N0hi2OKXUfl8PAMT8HU73eLfMPuAkrHVtGK+6WA0uQmjafIzjtK9AYP1MDlUL88Coxb18HqduvvitlfkbIivhNfI612T71IAkmslW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722521613; c=relaxed/simple;
	bh=Eq/aNHDxaOY+V8tE16TNUHJ1VjAhDc5Cbsz9tdj07LI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ONzjWxCBZBTmGhLDgAuqiAh7b658rph/a41ckBWYNSTe4aEylpwm0jLeOeK5EOIx2CNqGypoVyJ5f9CUdTYEq04ZWls5fJFeM0BvWPzjgyqM7jmzcqps2UfnAn4ogDabZQw+QMx8qBq3YPwubDjlTvBZMa7raSrDj3xVZvJ9n6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFgG1SCi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2E6C32786;
	Thu,  1 Aug 2024 14:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722521612;
	bh=Eq/aNHDxaOY+V8tE16TNUHJ1VjAhDc5Cbsz9tdj07LI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EFgG1SCivUy5ObYkMX4OJCtMA+1JmXglJyJodcsoZq2KDbr+TZfWPqOD0rCDu5gbu
	 KjrZkrUJtIdpPIyBpbnzi/HYbT2gFy14S28F2E/JMJpH34ZZLtIqB5+DyvBvxoHVC4
	 m90a9fk7qNH8gOJV0zU2ynsLuHELTJVd9dCtrxg5ZEIkxiVjMyKhSfxLRXPQViQfxT
	 tFk03E8lpWN3EckbB2KBeoxhYvr2ztpDwTXlVI+cleUFbEXohNjnaV9DTgxWaUH+w4
	 VfmM7bx6gwWeYa4E2D228l7PR3/GaIe7d6ufEU0/uEHUSR/y4P7P/NbxhRHzlwdQBX
	 2IWD2MJtKsaqQ==
Date: Thu, 1 Aug 2024 07:13:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: "Keller, Jacob E" <jacob.e.keller@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "simon.horman@corigine.com" <simon.horman@corigine.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: Implement ethtool reset
 support
Message-ID: <20240801071331.086a0864@kernel.org>
In-Reply-To: <616bd069-51a0-4b05-96af-2d419961e0e5@intel.com>
References: <20240730105121.78985-1-wojciech.drewek@intel.com>
	<20240730065835.191bd1de@kernel.org>
	<c0213cae-5e63-4fd7-81e7-37803806bde4@intel.com>
	<20240731164716.63f3b5b7@kernel.org>
	<616bd069-51a0-4b05-96af-2d419961e0e5@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Aug 2024 13:01:52 +0200 Wojciech Drewek wrote:
> We've came up with below mapping:
> 
> PF reset:
> ethtool --reset eth0 irq dma filter offload
> (we reset all those components but only for the given PF)
> 
> CORE reset:
> ethtool --reset eth0 irq-shared dma-shared filter-shared offload-shared ram-shared
> (whole adapter is affected so we use shared versions + ram)
> 
> GLOBAL reset:
> ethtool --reset eth0 irq-shared dma-shared filter-shared offload-shared mac-shared phy-shared ram-shared
> (GLOBALR is CORER plus mac and phy components are also reinitialized)

SG!


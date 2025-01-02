Return-Path: <netdev+bounces-154852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF81A0013A
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 23:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676FE1883C92
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 22:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F672AF1D;
	Thu,  2 Jan 2025 22:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwSwLAJ1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E58ADDC1
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 22:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735857409; cv=none; b=KBMex0GLJnX8PxsmwqYlP0bP4D9k91wAtiNYT+iWD3HwhdB4EkHq4WfTu3XW+f9W0xBmixFrz8w+Pc/KNFxbPlS8lJqBCSfM5fuZr258HZUND5lRmswAF+arh8gJIzBd2ZRwuHODzeGlgEQIsKpanffxNmh/pph2AT40aYDsq5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735857409; c=relaxed/simple;
	bh=ocaRHi59zpGnTRXE9GIhf/VGujjxdQjnIcymJYvU5LI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmzifuSQMTlittogud75D34G42mQjcIFtmzsFCuvPR/JAMgbzkUdMadbYZJeiFimQ8R/V2BD8n6hJZYyyNBgaGiU03Vw9wU1n1YP01LDB+JUTnmMyNaAiVdaLRemJmJGXS/Wux+G+TRShPtDUnyDFVzAWNwpqPawMVGovqcqPCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwSwLAJ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77123C4CED0;
	Thu,  2 Jan 2025 22:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735857408;
	bh=ocaRHi59zpGnTRXE9GIhf/VGujjxdQjnIcymJYvU5LI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JwSwLAJ1xPIRdbyoIwlj+HPFrfy2yEEcbz6w5Do4mLo2v3DVdwO0PEU36LE2VshoN
	 EyIgZoEqL6AhVCGRijVxbi3Prx8c0Fjfsb89/jhygm7JhT9zGCt+tqATV/org71vLM
	 6Ed2bWCLzECSu4JKiCb2Du8kUxFBW4VPLqD8Z058hKUPNLGmc6PZEWXUXZF3HAAdg4
	 Fres/tcWC+6kXssiXH5nPuwwD9mfghfoIGXDfpMyYhhKHkEih4FV5S8uzHNRNhFgTn
	 3U71I4ypcZOK0+itvSa5Xz2IRWnXk21gaQQH9OXaMH5vmXx1brmsFnSV/3KYTWPoXz
	 Sq2GEQ4KQ38Ow==
Date: Thu, 2 Jan 2025 14:36:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, gregkh@linuxfoundation.org, mhocko@suse.com,
 stephen@networkplumber.org
Subject: Re: [RFC PATCH net-next 1/4] net-sysfs: remove rtnl_trylock from
 device attributes
Message-ID: <20250102143647.7963cbfd@kernel.org>
In-Reply-To: <20231018154804.420823-2-atenart@kernel.org>
References: <20231018154804.420823-1-atenart@kernel.org>
	<20231018154804.420823-2-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Oct 2023 17:47:43 +0200 Antoine Tenart wrote:
> We have an ABBA deadlock between net device unregistration and sysfs
> files being accessed[1][2]. To prevent this from happening all paths
> taking the rtnl lock after the sysfs one (actually kn->active refcount)
> use rtnl_trylock and return early (using restart_syscall)[3] which can
> make syscalls to spin for a long time when there is contention on the
> rtnl lock[4].

Hi Antoine!

I was looking at the sysfs locking, and ended up going down a very
similar path. Luckily lore search for sysfs_break_active_protection()
surfaced this thread so I can save myself some duplicated work :)

Is there any particular reason why you haven't pursued this solution
further? I think it should work.

My version, FWIW:
https://github.com/kuba-moo/linux/commit/2724bb7275496a254b001fe06fe20ccc5addc9d2


Return-Path: <netdev+bounces-72149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B00AF856B93
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 18:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E298E1C2436B
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 17:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A163613848A;
	Thu, 15 Feb 2024 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgg/EgrV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAB3132C04
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019407; cv=none; b=MbfA7nRFfuxi5NRo2Z9iJRKAc6Ij77KDp6RJBbEbpq4udVls6u6cmeKDhi9dnl4tqrbHqz2CQ0nr0+zkRmXx2pHkDicTT4nGm3NPpkVjTQomLjgan9DpMTFQ3Obxwc2lKJe29IYSFF7LArnC504nNJKFyQQ4+q3axS30Oevuk3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019407; c=relaxed/simple;
	bh=ipKHUvdxfU/Fw6F47ktyigKFnQbW75lrbU9Zj9grFe4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=aa+S/xwgGUBQ7lTUO5YAxvmMJIUHVnH9YjyhXmW7fxGlxa2X+mh92kHKglSKTSdtRvjg7JU9UleEOIXSV9MxkEmfiwjuHGCx9d2P8iJRNi8hV/FLlX0TYLPqXT3iWVLLuPDSxN8mw6ADhQFAyr7F76yt2lXZCG3X3tTuWQB5viE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgg/EgrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7260C433C7;
	Thu, 15 Feb 2024 17:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708019407;
	bh=ipKHUvdxfU/Fw6F47ktyigKFnQbW75lrbU9Zj9grFe4=;
	h=Date:From:To:Cc:Subject:From;
	b=qgg/EgrVqbvxRSbIY6lGkamjnleQV2udR+ZCsi2skQ7P85YtH6JChO6K7OKNsDAjD
	 xw0k+BYsRj4DvRndhTl030ouCIMovoKUakxsSwR6Xzvm54CjZovbDihWCS/aWaBNSF
	 pwXsc4vJwmNJ0rSidWDiYw+PcD08JZfU8YHkALGyrtNiCKTXOiE0oqvnNQA9g3mOHz
	 /TkLA4mWDy5ZR8wBW/J1dqwq+ekAuDppZ+vCWmn/r98kB/x8eBSch8q+TsjY/A6UXn
	 RF/dv8vSub7BMSTFd9dp83Y6yLSmZRpS2AWgGyh3wxipwydcG5gxikpp6r23yXmPPa
	 aChlCMOb2UVRQ==
Date: Thu, 15 Feb 2024 09:50:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [TEST] gre_multipath_nh_res takes forever
Message-ID: <20240215095005.7d680faa@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

I bumped the timeouts for forwarding tests with kernel debug enabled
yesterday, and gre_multipath_nh_res still doesn't finish even tho it
runs for close to 3 hours. On a non-debug kernel it takes around 30min.

You probably have a better idea how to address this than me, but it
seems to time out on the IPv6 tests - I wonder if using mausezahn 
instead of ping for IPv6 would help a bit?


Return-Path: <netdev+bounces-166146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD16EA34C0F
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 18:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6222318828ED
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 17:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFD320110B;
	Thu, 13 Feb 2025 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oL0MsfBF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1976D1547F5
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739468231; cv=none; b=nv1iryJF0M4K3c/Ke9/OfO9BgbWtqnvAaDP9jMcPakqDDNEaxeSLEPnTDwXj2FXrtql2O2eSFSkPcHDB/uSFm1o1eY4SlkdpqEJSClu0l3rg5BM+dAKAXUCudTe2Rmzgh8TlWMctT6Pl3EtXf0LDbxFoljTXl6aq3dGLT0tyN+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739468231; c=relaxed/simple;
	bh=OkIvkTnr460rlyPf6xtD91vM5FDBXnTE+zHvdyuu9UE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kUxE75OoZyWQYkDmYb/W9C5jU/HcfPC8sUxBuDQQ+qpiPfj0T/GSPSbsB3ODKjAJF8dx5ztFr57DkGEI1qiTpwHib13sjmJJvnQ+cjqHFgMJO/YS9PyhuF0d/Mw9Ce89ClLxs+y6AFfmQChHgFKdkjsx6bufjPWE8tze3t1NlN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oL0MsfBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52406C4CEE4;
	Thu, 13 Feb 2025 17:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739468230;
	bh=OkIvkTnr460rlyPf6xtD91vM5FDBXnTE+zHvdyuu9UE=;
	h=Date:From:To:Cc:Subject:From;
	b=oL0MsfBF2aJTAejFFyu5NnqoDmtxdq+uxToXwG8hjo6WPZzfP/OdUbeG+R6mUYfeI
	 VqubcG4gb7ICV66PP34mFpVqVuLRmgbgD5o73a1qp0Zj/u0Y4Kd3krGISqEu1nljqN
	 XXbXsNPYYdnj/YdgJQ/HmmCmrpdRUKQ7uDA0C6Dl8eDPYPEeOZwV+FMiue1eypu9rm
	 +V81adXf8kb5anDTz6oVs6jxKR7HZHV701kIKPV3GfxwChXpj8p112uOjbWMHQJhWN
	 RtvmzGdoWK2B/8DN8O5D39iS+aBgYqfQfSC78zmBXQ8efZd4aiqMUHp5wUlPclg1CI
	 8Bk0c90g3OQfg==
Date: Thu, 13 Feb 2025 09:37:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: benjamin.berg@intel.com, johannes.berg@intel.com
Cc: netdev@vger.kernel.org
Subject: [TEST] kunit/cfg80211-ie-generation flaking ?
Message-ID: <20250213093709.79de1a25@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Do you see any problems with the cfg80211-ie-generation kUnit test?

We hit 3 failures in the last 3 days.

https://netdev.bots.linux.dev/flakes.html?min-flip=0&tn-needle=cfg80211-ie-generation

But the kunit stuff likes to break because of cross-tests corruptions :(

We run:

  ./tools/testing/kunit/kunit.py run --alltests --json --arch=x86_64


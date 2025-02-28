Return-Path: <netdev+bounces-170824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F46A4A117
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 19:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7233A567E
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 18:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD4426E140;
	Fri, 28 Feb 2025 18:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1lSUyrC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F54C26B0A1;
	Fri, 28 Feb 2025 18:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765902; cv=none; b=i5CfGDRrRztHCkIhFQzqUxTeXeygWbqvWXIGoJy/cvZrrL8tQULELhQXbpPSnQRFZceXSvba0o6isxmbLgKhu6gTTRTEsgOwlQGoFtS5aHNH7vv9oBBfTfFaiLCVmHhMewRUVxeT3jcsbvlu0uwzgR8FVLdVlKNEjZNRR6v+TXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765902; c=relaxed/simple;
	bh=ucBMCvlh2p5U+bYBr7YBt6icBbitc8jZM304oKBG//k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lyrwQ60xFJrT56Olc7LaJiN+w6fLjxP2y8w0Q5PDzk6CMw2a2NW6PJkL0DE1OOgT44+tq2ASQvGwm6WBbpUWzvN8fj6SpwQUyp4P79nWqmvY7XqVO5k6uVHUaHYroN8ew7q/fp9f0j2VmOJm4nnu9eJxKKmB3wYNSTrzlXA8Kg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1lSUyrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723BEC4CED6;
	Fri, 28 Feb 2025 18:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740765901;
	bh=ucBMCvlh2p5U+bYBr7YBt6icBbitc8jZM304oKBG//k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z1lSUyrCtRsDQBmpUweu9a8AyirOHuvXb+GJvN3kaWdPO+D/8idHtDHP/k/aF2sjn
	 2LRc9zm/fPFpM7MCiPsbft5ez4L9lt5P12hHvy0RWS14mPJSsNMYEAc/xpBiGi3Okk
	 2TQmETG2j7URruxb3XyiI20xSaG/+9GmUW2TKOt8FssYTa5L/9rV60Ourfjta46GIT
	 etOWKs4QrplvzBXyoN52mmi0VZYmZZ8aK1ebGqHBXGalPseirPjtxuMFW2xrACRnJ3
	 2kXQlyex178NWHCjSXtihdZj9R4ez4FQJcAIV2NBPI/fIPLtCG4OaLegg5wKVYclK+
	 XVLoEKb/LpAGA==
Date: Fri, 28 Feb 2025 10:05:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Danny Lin <danny@orbstack.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: fully namespace net.core.{r,w}mem_{default,max}
 sysctls
Message-ID: <20250228100500.4ed52499@kernel.org>
In-Reply-To: <20250228083025.10322-1-danny@orbstack.dev>
References: <20250228083025.10322-1-danny@orbstack.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Feb 2025 00:19:41 -0800 Danny Lin wrote:
> This builds on commit 19249c0724f2 ("net: make net.core.{r,w}mem_{default,max} namespaced")
> by adding support for writing the sysctls from within net namespaces,
> rather than only reading the values that were set in init_net. These are
> relatively commonly-used sysctls, so programs may try to set them without
> knowing that they're in a container. It can be surprising for such attempts
> to fail with EACCES.
> 
> Unlike other net sysctls that were converted to namespaced ones, many
> systems have a sysctl.conf (or other configs) that globally write to
> net.core.rmem_default on boot and expect the value to propagate to
> containers, and programs running in containers may depend on the increased
> buffer sizes in order to work properly. This means that namespacing the
> sysctls and using the kernel default values in each new netns would break
> existing workloads.
> 
> As a compromise, inherit the initial net.core.*mem_* values from the
> current process' netns when creating a new netns. This is not standard
> behavior for most netns sysctls, but it avoids breaking existing workloads.

You need to update:

 tools/testing/selftests/net/netns-sysctl.sh

and please CC Matteo on the next revision.
-- 
pw-bot: cr


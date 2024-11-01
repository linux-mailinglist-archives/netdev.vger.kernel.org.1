Return-Path: <netdev+bounces-140870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7491D9B8869
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63771C21193
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8E583CC7;
	Fri,  1 Nov 2024 01:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmKhQqvy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117C582C7E;
	Fri,  1 Nov 2024 01:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730424410; cv=none; b=V3HHsA2/wee4OHT++T+R5BWwx/xLsR28mByhVQpQUL3w1FgfOsde1retot4/tduFPb84wXaO4FTbT8b+MXOw4uHL6fojQrAeOBBqkVrtM6yluoMDEMnkmjafofNpboTBFGGRp8p8p523Jl0CwbdZjl4UgW08HgQxVUuO4oWKpnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730424410; c=relaxed/simple;
	bh=SOidcFY93eVmt85VoTjputoO3SXQ+jLjj72zPsRKZCk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oIhlHCNORiDdFFEke4gCMtucL+U29pMxquFmuapX+WqgO0rL7vKyw6dqn3JjARzeYq/NhR4wiid7UrsaJEmlG0xa68AZ716OgSZZkiUUmd5Yn//LedVvV51FPKNQpzoY97R2nHvud0xXS7uOPOQVILJ7Gwn6cB6LcBmOxeRFUrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmKhQqvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC2AC4CED6;
	Fri,  1 Nov 2024 01:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730424409;
	bh=SOidcFY93eVmt85VoTjputoO3SXQ+jLjj72zPsRKZCk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OmKhQqvyKE1k5nwa/A4lY0gfIapimepS9wRgGaQjR2roEpzIqSzYvmuQ8hK8RbOq8
	 N/pEBswJY8fHwvD5O9XtN1e7filQbj0VVBC71xFy+CiioHa2IARh5U5tDseNadT8J/
	 6lNjs2J5fNfzQIbZsSmJn5UgHOvesHnWyzkO+bLJyXZ7TjGSGj9qljOIQUl/VAWuvX
	 i7jtdTEcDqZ+SVLh4qGLRGr1KBkIEUSaJaPQKy5hXJrmWbYDVeFhoR5phIrxNygA3t
	 qdL1cPJkeX/v7w+RH6/ms6yZFG/tZ0+F4x1yqxiIwqka15sRtO60ofoDd7jyWo2j4o
	 +B8WAL1bgn8pg==
Date: Thu, 31 Oct 2024 18:26:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, davej@codemonkey.org.uk, vlad.wing@gmail.com,
 max@kutsevol.com, kernel-team@meta.com, jiri@resnulli.us, jv@jvosburgh.net,
 andy@greyhouse.net, aehkn@xenhub.one, Rik van Riel <riel@surriel.com>, Al
 Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH net-next 1/3] net: netpoll: Defer skb_pool population
 until setup success
Message-ID: <20241031182647.3fbb2ac4@kernel.org>
In-Reply-To: <20241025142025.3558051-2-leitao@debian.org>
References: <20241025142025.3558051-1-leitao@debian.org>
	<20241025142025.3558051-2-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 07:20:18 -0700 Breno Leitao wrote:
> The current implementation has a flaw where it populates the skb_pool
> with 32 SKBs before calling __netpoll_setup(). If the setup fails, the
> skb_pool buffer will persist indefinitely and never be cleaned up.
> 
> This change moves the skb_pool population to after the successful
> completion of __netpoll_setup(), ensuring that the buffers are not
> unnecessarily retained. Additionally, this modification alleviates rtnl
> lock pressure by allowing the buffer filling to occur outside of the
> lock.

arguably if the setup succeeds there would now be a window of time
where np is active but pool is empty.


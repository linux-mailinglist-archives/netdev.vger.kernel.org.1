Return-Path: <netdev+bounces-99962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4A28D72D3
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 01:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FA72B211D8
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 23:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA55344366;
	Sat,  1 Jun 2024 23:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLKp5Z51"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9539F47A48
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 23:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717285696; cv=none; b=cVsRVvJjpYlBwqw4ndMtvRxhzOtdxehYHg9+HCq3qupQsfPjowU3TuJhXD/qI1vgbJcETg/xGvaKButrWn6c/FHPrfFoXMs3d19OS4Av/pPhOo1LdA/j71/NouzT2WGn2JSK8LkUjFNpT50p+LTcL3PIuOdsNbJWZY+4B8y6KV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717285696; c=relaxed/simple;
	bh=XiBW7GKqJSQGCNWjnrWKwhkS5Pq7XANlIVYUKrSecgg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJlUURQGopNzd6j0i7RBCKtnm9uvND7ObjtQkOqi1e618zSvyF2y87JjD5h6nMoBjcfCqsonuRd6iU9V229OXSUSUdXJIJUgcLcYuzNPW8adyXEUp1+Yli2IPQ4vEZ2KtxpdTOQEGtTsbNAaNKhGLM7FeE0yN3Qrb375CB51VlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLKp5Z51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5010C116B1;
	Sat,  1 Jun 2024 23:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717285696;
	bh=XiBW7GKqJSQGCNWjnrWKwhkS5Pq7XANlIVYUKrSecgg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oLKp5Z51qmWQ30srqs/TGZ+83tjyLt9S2r6ckNoE8SjaPBHqFzxL2TFzNZvOQi0su
	 8LrK4RV1gL/Z70JzV6a24EIp00sEZ5rj8bzAo87zCk5LCgi+hTbAbdlLiP5tVTePIP
	 p4IXUCPHPy15nIazM0wD0Yq6LKhvadqg1Pd+N2nOqPx5Qbx9tpj7nmPmyPZFOml7pK
	 FhQH+P5JDEcOCaNfDU2qLIZwNe6gZyrA65du7jd+9eLpw3DIydrYV5myZpcZPKwv/L
	 cmnG4f1Zxa78zOPDVc0lcmWmBP0kQEAdAdsOwupMxn/kuiO8TNuSA7C5VjVMAeQk87
	 k6Vtsjp2mvysA==
Date: Sat, 1 Jun 2024 16:48:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
 dsahern@kernel.org
Subject: Re: [PATCH net] inet: bring NLM_DONE out to a separate recv() in
 inet_dump_ifaddr()
Message-ID: <20240601164814.3c34c807@kernel.org>
In-Reply-To: <20240601161013.10d5e52c@hermes.local>
References: <20240601212517.644844-1-kuba@kernel.org>
	<20240601161013.10d5e52c@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 1 Jun 2024 16:10:13 -0700 Stephen Hemminger wrote:
> Sorry, I disagree.
> 
> You can't just fix the problem areas. The split was an ABI change, and there could
> be a problem in any dump. This the ABI version of the old argument 
>   If a tree falls in a forest and no one is around to hear it, does it make a sound?
> 
> All dumps must behave the same. You are stuck with the legacy behavior.

The dump partitioning is up to the family. Multiple families
coalesce NLM_DONE from day 1. "All dumps must behave the same"
is saying we should convert all families to be poorly behaved.

Admittedly changing the most heavily used parts of rtnetlink is very
risky. And there's couple more corner cases which I'm afraid someone
will hit. I'm adding this helper to clearly annotate "legacy"
callbacks, so we don't regress again. At the same time nobody should
use this in new code or "just to be safe" (read: because they don't
understand netlink).


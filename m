Return-Path: <netdev+bounces-177088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDC1A6DD1C
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 15:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD6E3A42DD
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 14:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A219425E83E;
	Mon, 24 Mar 2025 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sw/YZkLo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC0325E836
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826917; cv=none; b=TDnb0rgtP6Pandlp1XAoKFG1XsuMSyi5ZlgWE3koOyb2sMOt7z75zILO/WhmQM9UDHWt+wFxKUX8eH5bFNQjPNWcGlqI3WUoDwzxySKA70SBU11A/OCpUJA408H5m2+2jja7Ec3TC4b/ZuIGLv2uDRe7XOcFF2WJ35pf0bEOt7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826917; c=relaxed/simple;
	bh=blapyNur1DMRooUFHg+K+WyQyiTZXlIJeMRKIQET7UU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIXue6m13qj1Bj8d+9EylVC5c8aGXmAHXZXO6JmG110IeyaJcMU9ahLiCg5YHsRpmXgP04KVbLc/ajhAWLQBjk8DfjX3znaHBPTBN0PJfXiBFI8KcvQwY4o1gf4fEIAX5GuQK8FEbOmEBlsp5nRrg2cBZiMxNv3pzVTwDPn4G08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sw/YZkLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E37DC4CEDD;
	Mon, 24 Mar 2025 14:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742826917;
	bh=blapyNur1DMRooUFHg+K+WyQyiTZXlIJeMRKIQET7UU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sw/YZkLoHvWkHgKdnj8XP/eukUnZv16EomIOyUFrveXy3sbrqOHHko7jD+xBxmKbH
	 A55dRw2NLdG14oXAdaIj3EeHsU0th9+Sqjj80cEXSNxWDd5kRmE4rD2vsWbh+qvQu0
	 V8HV91nWDAeS3/fwbtrNWe124g8pQc4W7dA+RgVTvXKBdSqiYLtE/QemePygRaTTlY
	 x5+m9JbBCtiIqIAOuf5u5jyNU7zpdutapVzBcgQ38tX384TM8HE19x2lYUeEZz8yfJ
	 tl0NUMhvxV//7pMfQsaEpKKigMoqIYNI7Ia2OOV1kmclkX/fLTdtAcY/Dz9Hy8OjwS
	 B9GpJ/fP76PRg==
Date: Mon, 24 Mar 2025 07:35:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Tariq Toukan
 <tariqt@nvidia.com>
Subject: Re: [PATCH net-next] ethtool: Block setting of symmetric RSS when
 non-symmetric rx-flow-hash is requested
Message-ID: <20250324073509.6571ade3@kernel.org>
In-Reply-To: <eb3badef-2603-4bab-8d7a-c3a90c28dc64@nvidia.com>
References: <20250310072329.222123-1-gal@nvidia.com>
	<f7a63428-5b2e-47fe-a108-cdf93f732ea2@redhat.com>
	<9461675d-3385-4948-83a5-de34e0605b10@nvidia.com>
	<9af06d0b-8b3b-4353-8cc7-65ec50bf4edb@redhat.com>
	<eb3badef-2603-4bab-8d7a-c3a90c28dc64@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 11:00:10 +0200 Gal Pressman wrote:
> > I guess something alike the following could be quite common or at least
> > possible:
> > 
> > #ifdef AH_V4_FLOW
> > 
> > // kernel support AH flow, implement user-space side
> > 
> > #else
> > 
> > // fail on any AH-flow related code path
> > 
> > #endif  
> 
> Right, thanks Paolo!

I don't see a v2, so commenting here.

I believe that we have had this conversation in BPF context in the past.
BPF likes to have things in enums because enums are preserved in debug
info / BTF and defines (obviously) aren't. So we converted a bunch of
things in uAPI to enums in the past for BPF's benefit. While Paolo's
concern is correct (and I believe I voiced similar concerns myself),
in practice we have never encountered any issues.

No strong preference from my side, but FWIW I think there's significant
precedent for such conversions.

One nit if you decide to keep the enum, Gal, please keep the comments
aligned.


Return-Path: <netdev+bounces-226124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E517CB9C945
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 01:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D691BC417B
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 23:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57E0274668;
	Wed, 24 Sep 2025 23:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aY4fjG81"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDE3202960
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 23:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756676; cv=none; b=DzPoDI+iCcMOXevIMuCyHbXEO0znnimr4poy72kHIv/sHjhHvQ05fap61MY0LzWoqsHSRDW2lxmPRxs51orulbdY62XUJi7Rz/PkftE8cgR1ee4NtZpxNP62FgkKGeNsDLqdwBgd3rSwI6IYv6EfjVcwtx4FC4bQn8XP/MaRPDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756676; c=relaxed/simple;
	bh=OSHr7+nHz+hF+isrcqplKblSjslyVerqC5yQhioXbf8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6hhbqkQxRwvhIuvyKmhF4WJ9nZgTr8gfgxHrQCpcQ2ZCe81R+q6bw6k6irEF19bAVnaUE6KzEojRTDeDGRrTIytmAPmtkR4+wBzH4+jw1AYv79SsxjEpIJBQ1LP+Ulc2LRR0agyMvPXpuly5tMLT/kvOT/RyMOxTyktjYn3Sfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aY4fjG81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898FDC4CEE7;
	Wed, 24 Sep 2025 23:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758756676;
	bh=OSHr7+nHz+hF+isrcqplKblSjslyVerqC5yQhioXbf8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aY4fjG81Bq1t2JBiRdqghGIBSnYEPSz75HRxc3j4ptcM3IopTqw/cjQ29pwah3rKh
	 SsxIJdRjofmimtQ2lgmFnsa5Gl7yKEbCnSjIxwlmivpegkfS3Qd7IKMTNWOg2elhVS
	 p9UwjOj7sVP9hSMm8xUXUfdDLRMh6+X8VBblaFk5SwI5YPb4TNuMZOTAcMqQX5EBTj
	 AcU1trs6Ra1WiQDHyz42r5SXp5++DQOMeZN5/x/nnJJUSdFqw75Hef8/gDUupGGM2Z
	 UwAGiJrcXBV4oXwOin0l/XnmXNBO3bz94NplMb50XvaSrkaou3LdIe8nOKAGcFECJ6
	 +utQdsj5RZFwQ==
Date: Wed, 24 Sep 2025 16:31:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marek Mietus <mmietus97@yahoo.com>
Cc: netdev@vger.kernel.org, sd@queasysnail.net, antonio@openvpn.net,
 openvpn-devel@lists.sourceforge.net
Subject: Re: [PATCH net-next v3 0/3] net: tunnel: introduce noref xmit flows
 for tunnels
Message-ID: <20250924163114.2adc671b@kernel.org>
In-Reply-To: <3f9e0aa5-1628-4ad7-8078-86a55b09b216@yahoo.com>
References: <20250922110622.10368-1-mmietus97.ref@yahoo.com>
	<20250922110622.10368-1-mmietus97@yahoo.com>
	<20250923184856.6cce6530@kernel.org>
	<3f9e0aa5-1628-4ad7-8078-86a55b09b216@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 18:27:46 +0200 Marek Mietus wrote:
> > On Mon, 22 Sep 2025 13:06:19 +0200 Marek Mietus wrote:  
> >> This patchset introduces new noref xmit helpers and incorporates
> >> them in the OpenVPN driver. A similar improvement can also be
> >> applied to other tunnel code in the future. The implementation
> >> for OpenVPN is a good starting point as it doesn't use the
> >> udp_tunnel_dst_lookup helper which adds some complexity.  
> > 
> > You're basically refactoring an API, it's fairly unusual to leave both
> > APIs in place upstream. Unless the number of callers is really huge,
> > say >100, or complexity very high. Not sure how others feel but IMHO
> > you should try to convert all the tunnels.
> >   
> 
> I'm introducing an opt-in API, which is useful in some cases, but not
> always as it optimizes flows that follow a specific pattern.
> 
> Since this API is opt-in, there is no need to over-complicate code
> to integrate the new API. The current API is still retained and is not 
> made redundant by the new API. Some tunnels may benefit from the new
> API with only minor complications, and should be modified in separate
> patchsets after this one.

My objection stands. Unless you have a reason why some tunnels need 
to ref the dst you should just convert all. Otherwise this is just
technical debt you're pushing on posterity.

> >> There are already noref optimizations in both ipv4 and ip6 
> >> (See __ip_queue_xmit, inet6_csk_xmit). This patchset allows for
> >> similar optimizations in udp tunnels. Referencing the dst_entry
> >> is now redundant, as the entire flow is protected under RCU, so
> >> it is removed.
> >>
> >> With this patchset, I was able to observe a 4% decrease in the total
> >> time for ovpn_udp_send_skb using perf.  
> > 
> > Please provide more meaningful perf wins. Relative change of perf in
> > one function doesn't tell use.. well.. anything.
> 
> Okay. Currently, I'm getting a consistent 2% increase in throughput on a VM,
> using iperf. Is this what I should mention in the next cover-letter?

Yes, that's much better! Some kind of average over multiple runs and/or
stddev would be ideal.


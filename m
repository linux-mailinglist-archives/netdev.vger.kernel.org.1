Return-Path: <netdev+bounces-178828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EA7A7912A
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 16:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6678A166BF6
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 14:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCC823958B;
	Wed,  2 Apr 2025 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amTsf5ga"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FFC23771C
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743603941; cv=none; b=FvfL0BZUBpp7n9U2S8MaMlqDcGIxW0NQbnj3yozaz0DYJ/9kcB931Zk/RGbT6Id0vK1CvRrwJGD1vlBEVrpz3NG8wtXaKO6dg6vbfvZRxZqzaM535Nv5FnIETPC9bnowiWhcrGoTGBAdxgrkyWJDgOrfezAVyMkJz7Y8cTWjaQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743603941; c=relaxed/simple;
	bh=2lsNp4DVGzP0UOpu4LhO8ww6Uh+B27bt62fxUNCHxh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAV4h2TQRHRtMZ1km1qH3+eFiW2tnsEK7RplmuhLAnKDc7OmNBHcQNlss7FkcSbhv1L2FWZQNQ/HVC3a3PLY8ZnLAW6oRJZXRU98I/4FKeTJMPkSzl4Thn9M1Oe1R/CrAM6FPTZEV4QDUQB1UDuzovp6y222gUPCFNVIUtz3JOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amTsf5ga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DB3C4CEE9;
	Wed,  2 Apr 2025 14:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743603940;
	bh=2lsNp4DVGzP0UOpu4LhO8ww6Uh+B27bt62fxUNCHxh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=amTsf5ga7GpiWJd2FV3I1m8Jz4xP01Cl2pPxAJJQIT4L4/dmV/6sID+u6BNlIEcPH
	 Q0IE6feAjCrGvxaCOiLABgQ0LlU9/Boj4mWB6anUK9nZ6BQ69f9BX4QwCyxjy5MItq
	 MsO432PU1JhaXwTs+dPpws0pobJBVICx8wzyaKXv7MB0hZ4o6R13qzERFdZT5Za4Lm
	 3UG6xcPYksaIuA8bHO8xRTw1tCsfwjtqUdP1wavbrHdCsJM4/otNmCVvphWS6Kf7VB
	 p5AuIovO1hNGl6bTlAdLJFGV+m3hn0qzPdmLU3YAs9ar7/0vnNyE11F1QFMkGKh069
	 J/PjBQ64zNlMQ==
Date: Wed, 2 Apr 2025 15:25:37 +0100
From: Simon Horman <horms@kernel.org>
To: Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net v2] ipv6: fix omitted netlink attributes when using
 RTEXT_FILTER_SKIP_STATS
Message-ID: <20250402142537.GT214849@horms.kernel.org>
References: <20250402121751.3108-1-ffmancera@riseup.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402121751.3108-1-ffmancera@riseup.net>

On Wed, Apr 02, 2025 at 02:17:51PM +0200, Fernando Fernandez Mancera wrote:
> Using RTEXT_FILTER_SKIP_STATS is incorrectly skipping non-stats IPv6
> netlink attributes on link dump. This causes issues on userspace tools,
> e.g iproute2 is not rendering address generation mode as it should due
> to missing netlink attribute.
> 
> Move the filling of IFLA_INET6_STATS and IFLA_INET6_ICMP6STATS to a
> helper function guarded by a flag check to avoid hitting the same
> situation in the future.
> 
> Fixes: d5566fd72ec1 ("rtnetlink: RTEXT_FILTER_SKIP_STATS support to avoid dumping inet/inet6 stats")
> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>

Reviewed-by: Simon Horman <horms@kernel.org>



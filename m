Return-Path: <netdev+bounces-183678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDE9A9183A
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 11:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F8467AA050
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 09:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCEA22758F;
	Thu, 17 Apr 2025 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RK2DipEG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DBB226D14
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883093; cv=none; b=LhlazkEyEzRLf52Hqs8lnxDWo3lUbvnk+0LWm9dOgWUHm4T7ZZyQztgPcIMY1AvBNF9/h7CqFmiulT6//hzBQaXjFIlTw/91zIxtT4I9JwGEcPKFmk7XP6Sl/77Svt9GEOwv2ExzQmE8KKp7MzYkj3prZpt+ieYJ94T91t9w1f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883093; c=relaxed/simple;
	bh=YheLnVHKHrjonvnYiEi71GpWs1A41Yx90K15oM82il0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2vDpw+WadDN+OKUsFNDsP6I+GTBqZ6ZUayfkbhdFNPQaqfr40LKPzakuZlVyj4aG/HBGEcP4xegVZZc3Qnz1zIeJNwdhLMxS7LV/Y2pkoSYg/3KU0zzq0BYbWzvTe+H6hs1Cfo9QumfzVJ/P9xj++fsII05nX3Lji+nG6nrmG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RK2DipEG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6130AC4CEE4;
	Thu, 17 Apr 2025 09:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744883093;
	bh=YheLnVHKHrjonvnYiEi71GpWs1A41Yx90K15oM82il0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RK2DipEGslJN5dNrBcfnp17GMhzQWZ9PqikCFiid2s+oXeSrcJ0klyarprLmSd6is
	 msowIKeEllpbXifNtLpMmDTTaQ0koF1Pkn6y0wHBtoqH+tUHcdJnW3vYvgMWIf+bCV
	 i+hbZDvmm3+TdE4tBqXAPrVuTwtg+NlAtqYp+/xGwmlj5PPMXYuBPJKFSDMCfytSQt
	 wuQWegLjg1PKKsJAxKQIvnaCWIQxDi4SGUzZTjhp9/xozX2AF2emAActdsIO7I3zTl
	 iUZuyY33BlZhGo+2GrQ8Eig38DHYBN+26GHqDsft3LTvDCl36OhwwtzR2Xj8O9AkCL
	 tQdAuOXmI3NCg==
Date: Thu, 17 Apr 2025 10:44:50 +0100
From: Simon Horman <horms@kernel.org>
To: allison.henderson@oracle.com
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/8] net/rds: Add per cp work queue
Message-ID: <20250417094450.GC2430521@horms.kernel.org>
References: <20250411180207.450312-1-allison.henderson@oracle.com>
 <20250411180207.450312-2-allison.henderson@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411180207.450312-2-allison.henderson@oracle.com>

On Fri, Apr 11, 2025 at 11:02:00AM -0700, allison.henderson@oracle.com wrote:
> From: Allison Henderson <allison.henderson@oracle.com>
> 
> This patch adds a per connection path queue which can be initialized
> and used independently of the globally shared rds_wq.
> 
> This patch is the first in a series that aims to address multiple bugs
> including following the appropriate shutdown sequnce described in

nit: sequence

> rfc793 (pg 23) https://www.ietf.org/rfc/rfc793.txt
> 
> This initial refactoring lays the ground work needed to alleviate
> queue congestion during heavy reads and writes.  The independently
> managed queues will allow shutdowns and reconnects respond more quickly
> before the peer times out waiting for the proper acks.
> 
> Signed-off-by: Allison Henderson <allison.henderson@oracle.com>

...


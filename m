Return-Path: <netdev+bounces-207217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 324D4B064B5
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 18:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 516063AD4E2
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E0A277008;
	Tue, 15 Jul 2025 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIPsdCF4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D86819F464;
	Tue, 15 Jul 2025 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598531; cv=none; b=sutfoxEyXOsMgGcH0qp0lFfE8RAGGpvOvIK/rE7R1zqCodX+F/kZh8fKTL8ZJDmFCNyGn9weNyqTMyA1s+C1K3FUMkd8pRXd2Ge013KeI1wfkh0WjaPEqCSG6UVcImfMoSqy+nSyWs78eWdbCDW4MtGR54dZYhb9wdNqxErOVXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598531; c=relaxed/simple;
	bh=Q4k7QSsXGvGRbwoe4qh+ClOw428CuLsphz2IMYzzboc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YS5om0VZ53gn5qLi4K1PrD/7iaVdKuhkjKvcB+Kop2uthxyjQDIjJglfXqVB3+cVlWNYymGNKQPAZ/J2QYABhpBDoHcqTjj/uqTD1aWZufsRyLAsY+c4LChwyVCMMfLtFPyXuSxx3q++lGSep/H0JaOqn1pnfkK16c3x7rhaw7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIPsdCF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C43C4CEE3;
	Tue, 15 Jul 2025 16:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752598531;
	bh=Q4k7QSsXGvGRbwoe4qh+ClOw428CuLsphz2IMYzzboc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sIPsdCF4HOh0j833xWRmmBBUbbzeg8Mx6Cb/w7voRD/+/lci7P6sxEp3RbbNqtZQf
	 0OQebrgbpJNyXRc2IfLJ0J0RBXchRml+bw83irzj92YWDLL7lMxq/B1eDKGx9gkqeb
	 2JcSMs3m/nfddB4IUgj1vLDnFOXUqB9KqIu328k+a3suJB6Ua8t8+FWv8A0AelvxcZ
	 iP6lsMNYDSWch1X9Ir/l1bqk5F1crtmm2gyyTncg2K+cwT2f8G+WFcJp+o/7tBfSEG
	 N9sqifoUx2KUTAstkoSthMR2hvcD4vn4NlfofRR5ZKXwB8FORcaqbp5p5cow2DfVDn
	 hFTX83rFPd8oA==
Date: Tue, 15 Jul 2025 17:55:27 +0100
From: Simon Horman <horms@kernel.org>
To: Wang Haoran <haoranwangsec@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: We found a bug in i40e_debugfs.c for the latest linux
Message-ID: <20250715165527.GG721198@horms.kernel.org>
References: <CANZ3JQRRiOdtfQJoP9QM=6LS1Jto8PGBGw6y7-TL=BcnzHQn1Q@mail.gmail.com>
 <20250714181032.GS721198@horms.kernel.org>
 <CANZ3JQQtC1ytmaqGR3xx6eDVyV-ZJp=hCZDcAJV-ktA2RHvTYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANZ3JQQtC1ytmaqGR3xx6eDVyV-ZJp=hCZDcAJV-ktA2RHvTYA@mail.gmail.com>

On Tue, Jul 15, 2025 at 09:38:11PM +0800, Wang Haoran wrote:
> Hi Simon,
> 
> Thanks for the clarification.
> 
> We’ve observed that i40e_dbg_command_buf is
> initialized with a fixed size of 256 bytes, but we
> didn’t find any assignment statements updating
> its contents elsewhere in the kernel source code.
> 
> We’re unsure whether this buffer could potentially
> be used or modified in other contexts that we
> might have missed.
> 
> If the buffer is indeed isolated and only used
> as currently observed, then the current use of
> snprintf() should be safe.
> 
> We’d appreciate your confirmation on whether
> this buffer could potentially be used beyond its
> current scope.

Thanks,

My reading is that i40e_dbg_command_buf is declared
as static in i40e_debugfs.c. And thus should only
be updated within the scope of code in that file.

I would be happy to stand corrected on this.


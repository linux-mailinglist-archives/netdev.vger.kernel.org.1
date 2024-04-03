Return-Path: <netdev+bounces-84444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21F8896F06
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8851C2416F
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED2558112;
	Wed,  3 Apr 2024 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1f4acID"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B678B66E
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 12:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148063; cv=none; b=Xci1PPcjWMZ2CMMDy6NLeVZpe4+X7K0wLFiw9RomaYraJzEpG0zajsST6t0X0YEI+XTAKM3XVSPuYDGldqwVAgzwsfx0tZvdnaZP33yoSgDe59X8YrO1+lBCys4DeTOMUNGKjKBwoiMsmaY1Ith5x1ajd6JFYD+SOAqyq4AjRP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148063; c=relaxed/simple;
	bh=zhmcuOV8K/EJe64YqdiZSXutj7VKins5XSAV6SJdRZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLnuDkMO/cULfff+XizwIk6BifIHeRiyvZnIAxE3BCEz+mPBjMZTCEpcKINYvoJ41ZOhaiHTicVl7eVA+x23Wz/gNuwa2zf0WmPoFTil8HlbA6XjY1KE5h2h4YwZETSamCGE/2Yh629W9yFnJwjQ063n5jTV3NiXcjE8dbE2BLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1f4acID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD8FC433C7;
	Wed,  3 Apr 2024 12:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712148062;
	bh=zhmcuOV8K/EJe64YqdiZSXutj7VKins5XSAV6SJdRZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F1f4acIDr4Qt2AZU+5HxE854dwMebLJUUsfvC254/UczpSs2dxW61vhcv4mmykeZQ
	 LC45wSkXS6jrFwNnJ3QZrBDnFcLA9F3t24JX6U6mrZxED3FwLJddSKO35k8RLw3apr
	 NOA2zeglbAC/puBqvK1DWZcSHRZRyqQ9UGdsofFQnxnJHBPdd1hmilnEVL0WNT8O3h
	 tgQE6Vr2oQUX8wtv7kaGz7jhUp5Byb+o78lpuTY7pa3nGRm1Gou3iD5OHEcxqCZINx
	 h4JOEJydjL4Mx3BlNuggpYyBYxkud/Juc3ZuHkexVUUuD4ottw3wkHAHiUpip2Jawp
	 f8Lv9RMG0Bu/Q==
Date: Wed, 3 Apr 2024 13:40:58 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 15/15] mlxsw: pci: Store DQ pointer as part of
 CQ structure
Message-ID: <20240403124058.GK26556@kernel.org>
References: <cover.1712062203.git.petrm@nvidia.com>
 <a5b2559cd6d532c120f3194f89a1e257110318f1.1712062203.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5b2559cd6d532c120f3194f89a1e257110318f1.1712062203.git.petrm@nvidia.com>

On Tue, Apr 02, 2024 at 03:54:28PM +0200, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> Currently, for each completion, we check the number of descriptor queue
> and take it via mlxsw_pci_{sdq,rdq}_get(). This is inefficient, the
> DQ should be the same for all the completions in CQ, as each CQ handles
> only one DQ - SDQ or RDQ. This mapping is handled as part of DQ
> initialization via mlxsw_cmd_mbox_sw2hw_dq_cq_set().
> 
> Instead, as part of DQ initialization, set DQ pointer in the appropriate
> CQ structure. When we handle completions, warn in case that the DQ number
> that we expect is different from the number we get in the CQE. Call
> WARN_ON_ONCE() only after checking the value, to avoid calling this method
> for each completion.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>



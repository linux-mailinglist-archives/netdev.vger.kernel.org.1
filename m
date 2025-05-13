Return-Path: <netdev+bounces-190161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD638AB55FE
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB203B2AE6
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 13:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7E328ECCE;
	Tue, 13 May 2025 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDPSgC2C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6559528DB7B
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747142747; cv=none; b=s19uHSxF9PBCSQZBx8/54boWm0wZf+jlWPyxh2VuGlYbZZP7JLBF9H5IinlPPGb1A8OHyMWsj2AAREnKIbcYpAexlzHJOkWC5ghU87VAp9U33lyfkk9t1aYjJk1TRWvUfMK45ZjJhbb6VbIhNes02MLznlmzZ/z+IeSTm8qE7Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747142747; c=relaxed/simple;
	bh=FJ/NGVFLnflPkv404uFS+BErBlSpAuN15zZS/UtKf0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0e4xrd4l3OGt7nmFOFG93e2h9CLs4x+C+Qq5pu4HT3PNXYhzYLC/b/ki3dC7ahlrE+Qf3jKeTTFOzmYmrsv+rplX4nHXgQDlazreu2UG3aGwqWjbgcUn2h97dlFtnTozpMiNmaDUMHZMOVtI+8nZjsecUWJk1zYFHJPCiyOYJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDPSgC2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65093C4CEE4;
	Tue, 13 May 2025 13:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747142746;
	bh=FJ/NGVFLnflPkv404uFS+BErBlSpAuN15zZS/UtKf0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qDPSgC2CR81Qx6+jJR/yTRELeiD3k32MfgwPndCD4bYE6FgCEaCOmdv7NJM2MvRRh
	 aucU3SfuNyIFWDGQpuwnNa3p89KQgJdvkvHyA1dfV1I+w+hmgMgdIgaGRBsbYdALNC
	 jb4tcrHszVIZaCjQgHQpkrpGV3pyc8JlMyLEHadTVNP4+GdhO1euOB1JxMWIc7Nye2
	 VeLwQJAjXJDSWlEQnUXzqm7DSIhCDktXJyoghctUzTScqE1koiypULM7F54QzYAiaF
	 uR2Im9QnGRMvvnOZsoOj9BDbmd0MtSi3MW4mFa2uIiu1osPtnZcbDcURVija/ucqau
	 hhF2a2gqpaYJA==
Date: Tue, 13 May 2025 14:25:42 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gakula@marvell.com,
	hkelam@marvell.com, sgoutham@marvell.com, lcherian@marvell.com,
	bbhushan2@marvell.com, jerinj@marvell.com, netdev@vger.kernel.org
Subject: Re: [net v2] octeontx2-pf: Do not reallocate all ntuple filters
Message-ID: <20250513132542.GA3339421@horms.kernel.org>
References: <1747054357-5850-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1747054357-5850-1-git-send-email-sbhatta@marvell.com>

On Mon, May 12, 2025 at 06:22:37PM +0530, Subbaraya Sundeep wrote:
> If ntuple filters count is modified followed by
> unicast filters count using devlink then the ntuple count
> set by user is ignored and all the ntuple filters are
> being reallocated. Fix this by storing the ntuple count
> set by user. Without this patch, say if user tries
> to modify ntuple count as 8 followed by ucast filter count as 4
> using devlink commands then ntuple count is being reverted to
> default value 16 i.e, not retaining user set value 8.
> 
> Fixes: 39c469188b6d ("octeontx2-pf: Add ucast filter count configurability via devlink.")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>

I don't think there is any need to repost because of this, but for future
reference it is normal to include the PATCH keyword along with the net
keyword in the Subject.

e.g. Subject: [PATCH net v2] ...

Likewise for net-next.


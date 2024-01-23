Return-Path: <netdev+bounces-65137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A48E48395A9
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 18:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D269BB2DC00
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F4285C72;
	Tue, 23 Jan 2024 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZnYjD3w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0015485C6F
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 16:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028484; cv=none; b=D12nrH21D0Qlhu3mo0j6uU5/PTn48C4CrW7h2Q9mNhzjHtT8AxkcSRqyRMO96dVE7NB11/tA3YnYh+sLDfGRxXlteyuYHb5MpRX1dQzEgNKS+K0C4BZaV01zHOomk6e41Gsd/vy+7hj9qHuMk8T7bEa1BqsJuTalSh9P6WBZNlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028484; c=relaxed/simple;
	bh=s2MvNDMwQDf6Fks/boYZD731v1ByeIuexIheT6lCcUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jf6DDykzwBhukAsl9A9mlp+LLHBcjaBrUwlanlBNaIYqsDyh86BR1QUs6rtjHTh/r6dJWlSK0YuTu1Y0EPzD/NVCUxFZ4PbFOZ9ZEf+2VU99WnYEeATMCMi5PUDMutvqrEmlRW3naa/u/k4fZDNY/py9fIq7b/nTQ9fQ+KKWqsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZnYjD3w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203C0C433C7;
	Tue, 23 Jan 2024 16:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706028483;
	bh=s2MvNDMwQDf6Fks/boYZD731v1ByeIuexIheT6lCcUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tZnYjD3wm28FB0uRiRR/EZsHVoYUvKbtuKWwbSV5dU9NHnf4oz+ZVuQceGvl6a4Bs
	 mu1M6LhEsXNXzJkItEiMAej44VkLiAVMr198cWcrWo8MzXQjnFO2PGL21kxjqzy2sn
	 jIXmd3wkTEF62iBbjIDjZUoO5b6Za50/xfyCzYufIEyHixWULyNLxVCznwxFFYFVG1
	 WAZF9dc1+ET59kqurJVXUqMQc55lkBsc/ugUwu/3HmmtyrZAPT4OnF5MTlYszo2dCL
	 PowXyq33GEWDVEkfI5OaQpI07R6PlEEzO9JuSzvqpmw+iDbvQDOix70FOFEQcTm96N
	 9Xr5vp88oxUCg==
Date: Tue, 23 Jan 2024 16:47:59 +0000
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v7 iwl-next 1/7] ice: introduce PTP state machine
Message-ID: <20240123164759.GG254773@kernel.org>
References: <20240123105131.2842935-1-karol.kolacinski@intel.com>
 <20240123105131.2842935-2-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123105131.2842935-2-karol.kolacinski@intel.com>

On Tue, Jan 23, 2024 at 11:51:25AM +0100, Karol Kolacinski wrote:
> Add PTP state machine so that the driver can correctly identify PTP
> state around resets.
> When the driver got information about ungraceful reset, PTP was not
> prepared for reset and it returned error. When this situation occurs,
> prepare PTP before rebuilding its structures.
> 
> Co-authored-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Sorry, I sent this just now for v6, not realising that v7 had been posted.

Reviewed-by: Simon Horman <horms@kernel.org>


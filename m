Return-Path: <netdev+bounces-95400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896358C22A9
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D8D1C20D3A
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6778A16C6A9;
	Fri, 10 May 2024 11:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjPn21al"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4248F16ABC3
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 11:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715338978; cv=none; b=j8kb6Yu0fz762A0g7MSVwsdFC0rDvVnctbwshMeJS+9EMArzukFvHywZux1xqD88BsIp1kFc8PISiQ9G1Pyw+Vq+tl4zkajuBv8ZKnX5qmZLfs/XbY0sKig/meMRyn9Q3iC9FHWfbvfLu6j8Lz6CTlBQTs2/A++O6mnWb/uyh90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715338978; c=relaxed/simple;
	bh=7ci1fi03lER3M3a1LyWlHm8KKCSQMYM3V05XcAPPy1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVyrFRghEyN+z5zNCYjWSxGIKRzsSFu/zOwJBRIme7DmUBw4UtHMytGHzmnsgqBBmo1ouUepWwXjxsCFFjGP22MYD+rNxtIb5dtYVirbtGqgv9iO25ijKmAkWY9WEjJI+FHLZaBecRWw/Qk8OKMSfPGZZg7D1/2CYZxUp3Sbqa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjPn21al; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E49C2BD11;
	Fri, 10 May 2024 11:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715338977;
	bh=7ci1fi03lER3M3a1LyWlHm8KKCSQMYM3V05XcAPPy1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pjPn21aloWccCKcZ/MWF7bTwo0cjFhTBSQAy3TjoKNpuB2a5UhmyWSGj+zKgc4ldd
	 zCgdRikeXXCDgJ6Ww4oj+G132XJ1StDsbebiHCBA1+ThiK5Q7V5I9SYnzb7ahnYktl
	 yIOSdyMZqZGQaF4r9ZEd9aNdrSDPJ1QScmR1w5Ky3x/ccIduN2s8lqJXLcuSrTzt2N
	 HFFCPi0OJwHIgsPXAiWjehvHtme03XAtr4rkp3E++72jzi13XpMfsOLospcQL9keHX
	 FDMnkE7VWzCUA+EjLMqT0MdkToincCpfBLaHjrcipKFV31I8usAdEFRFgaKCk4WxYR
	 0yNn0pRhgRs4w==
Date: Fri, 10 May 2024 12:02:51 +0100
From: Simon Horman <horms@kernel.org>
To: Hui Wang <hui.wang@canonical.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	kuba@kernel.org, anthony.l.nguyen@intel.com,
	vitaly.lifshits@intel.com, dima.ruinskiy@intel.com,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sasha.neftin@intel.com, naamax.meir@linux.intel.com
Subject: Re: [PATCH v2] e1000e: move force SMBUS near the end of enable_ulp
 function
Message-ID: <20240510110251.GB2347895@kernel.org>
References: <20240508120604.233166-1-hui.wang@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508120604.233166-1-hui.wang@canonical.com>

On Wed, May 08, 2024 at 08:06:04PM +0800, Hui Wang wrote:
> The commit 861e8086029e ("e1000e: move force SMBUS from enable ulp
> function to avoid PHY loss issue") introduces a regression on
> CH_MTP_I219_LM18 (PCIID: 0x8086550A). Without the referred commit, the
> ethernet works well after suspend and resume, but after applying the
> commit, the ethernet couldn't work anymore after the resume and the
> dmesg shows that the NIC Link changes to 10Mbps (1000Mbps originally):
> [   43.305084] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Up 10 Mbps Full Duplex, Flow Control: Rx/Tx
> 
> Without the commit, the force SMBUS code will not be executed if
> "return 0" or "goto out" is executed in the enable_ulp(), and in my
> case, the "goto out" is executed since FWSM_FW_VALID is set. But after
> applying the commit, the force SMBUS code will be ran unconditionally.
> 
> Here move the force SMBUS code back to enable_ulp() and put it
> immediate ahead of hw->phy.ops.release(hw), this could allow the
> longest settling time as possible for interface in this function and
> doesn't change the original code logic.
> 
> Fixes: 861e8086029e ("e1000e: move force SMBUS from enable ulp function to avoid PHY loss issue")
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> Acked-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> In the v2:
>  Change "this commit" to "the referred commit" in the commit header
>  Fix a potential infinite loop if ret_val is not zero

Reviewed-by: Simon Horman <horms@kernel.org>



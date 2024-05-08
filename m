Return-Path: <netdev+bounces-94362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B17788BF467
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 04:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B451F24628
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB788F6C;
	Wed,  8 May 2024 02:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMnbodEz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B438BE7
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 02:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715134874; cv=none; b=tV/n7QWs+/LmV3Za/UCTMhcPqye73otQrFgrc5kfUX606gPeSUQZWIip+HJuYDR7qIaepiPGRuXwH9h5aLlAdPN39T2v2veHuxz1A8O57M3ZJX808T0VRUv9M03cbBCMFhrXtCvUiZualWbQcQegSCiCEvUSIrTeiH/z4Z5b7hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715134874; c=relaxed/simple;
	bh=MWyLD08F7rzUStzPBBAygPeFUz7EXZqfMmeek/XzZs8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/v0cRsYSCppBMrFXBZ5BYORdeZuMjR6Qd4w/hc/+KyTs3TwyeVRVW9a9bJlcun3ptyT3v49a9RjglpoWduKVj+aEWbZqx+qdCGjuukB1WrSUPNZiQjQjMDYL70NnX1AVRs4CcrhIbHcCx5RkrFvvVQvbaIPGR5JZkMAPrGv+N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMnbodEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84040C2BBFC;
	Wed,  8 May 2024 02:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715134874;
	bh=MWyLD08F7rzUStzPBBAygPeFUz7EXZqfMmeek/XzZs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lMnbodEzwHkV4ODdHcXQUnmYNaafEfrmcvng/+pPHb+n/TdEGjK0q4YBbgpMp6r4e
	 EyEGyk+BaIsuKDwQiR+GQnhn8fHxJWc/rR2NelU3sXSP9L3YM0sXQW2jT4P4Xn4aZq
	 +stBKyhbBwI1JiTfpuoisKW7FfqimyDTBAO2x5CQm2V/YJnqiawbNVGwWit/si35nZ
	 RJqumm39GYrflC5cHFW1PaqGrKx89hRq1gmvoGnqI3UCIHIhxnf60+N6QLJy8PPnva
	 jSBazkOmujACjkm5dG2bX6zN//K0QodQlunUpkUku1tyA8dMGwRCG5G833VEO5rkIC
	 MYkh8NepyITeg==
Date: Tue, 7 May 2024 19:21:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Hui Wang <hui.wang@canonical.com>,
 sasha.neftin@intel.com, dima.ruinskiy@intel.com, Vitaly Lifshits
 <vitaly.lifshits@intel.com>, Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net] e1000e: move force SMBUS near the end of enable_ulp
 function
Message-ID: <20240507192112.3c3ee4f2@kernel.org>
In-Reply-To: <20240506172217.948756-1-anthony.l.nguyen@intel.com>
References: <20240506172217.948756-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 May 2024 10:22:16 -0700 Tony Nguyen wrote:
> The commit 861e8086029e ("e1000e: move force SMBUS from enable ulp
> function to avoid PHY loss issue") introduces a regression on
> CH_MTP_I219_LM18 (PCIID: 0x8086550A). Without this commit, the

Referring to the quoted commit as "this commit" is pretty confusing.

> ethernet works well after suspend and resume, but after applying the
> commit, the ethernet couldn't work anymore after the resume and the
> dmesg shows that the NIC Link changes to 10Mbps (1000Mbps originally):
> [   43.305084] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Up 10 Mbps Full Duplex, Flow Control: Rx/Tx

>  release:
> +	/* Switching PHY interface always returns MDI error
> +	 * so disable retry mechanism to avoid wasting time
> +	 */
> +	e1000e_disable_phy_retry(hw);
> +
> +	/* Force SMBus mode in PHY */
> +	ret_val = e1000_read_phy_reg_hv_locked(hw, CV_SMB_CTRL, &phy_reg);
> +	if (ret_val)
> +		goto release;

Looks like an infinite loop waiting to happen.


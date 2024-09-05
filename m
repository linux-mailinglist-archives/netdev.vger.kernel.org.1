Return-Path: <netdev+bounces-125328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D145496CBE2
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 02:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F631F25CA0
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 00:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E084D440C;
	Thu,  5 Sep 2024 00:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfa/idAN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC46F38C
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 00:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725496856; cv=none; b=KCAnvP84rx+kmhXSsI84TGy8lf71JcF4HstEKRX5dyi/oFHueiktRBdd0aTjKRE00+csLoRzoAb+j3ev7eWnpQ+pYrbfBRfJolxiJthtrZk1VX2R/kKVmk0/xLONC1/0MYRDiH6JI0f6+F+zpFD9DCbH9TvDe0poVpLGB7WJTSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725496856; c=relaxed/simple;
	bh=LMvpfzvbJHjRNldRE72Zzb1I187lsNQdVHfTCGCfaT0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WcmJq6OLQrayV1832y1Wq1wwPBvLQZmkYI7oXWft7hxCa0Mxf1S067+qH/bJtZa0N+lTq/PWEWhNw9BZCwyf0TiFIba/KnpuXTigyeMkZiGYoYnNPp7im3+1CEaRf6E2I3nM0UPcHkh0rKT/eCrysRsldzQ6+1Mb5OlxZ5rHbxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfa/idAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0D8C4CEC2;
	Thu,  5 Sep 2024 00:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725496856;
	bh=LMvpfzvbJHjRNldRE72Zzb1I187lsNQdVHfTCGCfaT0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gfa/idANISWni59Nc1GXCYL7wTpIPyeUmgeLFt3gc51kYLkJ8XKwCvlg7ihBPuFdl
	 caQRQwKpG5hhbZ0Lu+E5uKmR3VzwCeLYSE/ugerhrRDriqqrukCLa7V0KgoAcAbuC/
	 7L8/ofpb3ZiEJmMX+A1Cke2pEQXyE2DK1Vmb55uWEmiSV/HMcBPDsNiAdnsanFYRLc
	 wLzoqW3Nk8AXTclkq00JmhWZo5Cd1EaJUMcRnYfCHo8OUf+OObgucRmBNinwywIIN6
	 y/kea+NUKgKXQRU+x+BPopQ+wqvZmM7AzODC4WDUiHgKjKx8bDoNKRoHtJU52Z+VG2
	 NfUJ9VHEqivjg==
Date: Wed, 4 Sep 2024 17:40:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com
Subject: Re: [PATCH v6 net-next 01/15] genetlink: extend info user-storage
 to match NL cb ctx
Message-ID: <20240904174055.6e2a95d7@kernel.org>
In-Reply-To: <b67adf159b412f7618df7b40fcdb1d8f94b3766f.1725457317.git.pabeni@redhat.com>
References: <cover.1725457317.git.pabeni@redhat.com>
	<b67adf159b412f7618df7b40fcdb1d8f94b3766f.1725457317.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Sep 2024 15:53:33 +0200 Paolo Abeni wrote:
> This allows a more uniform implementation of non-dump and dump
> operations, and will be used later in the series to avoid some
> per-operation allocation.
> 
> Additionally rename the NL_ASSERT_DUMP_CTX_FITS macro, to
> fit a more extended usage.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Thank you!


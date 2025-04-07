Return-Path: <netdev+bounces-179950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCA3A7EFCC
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 23:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2F21886107
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220FA21ABD5;
	Mon,  7 Apr 2025 21:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUdWfIbR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3042185B4C;
	Mon,  7 Apr 2025 21:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744062174; cv=none; b=KBAuqy/QAm1IYYMfE210WyPhztxeUr+Qu4AcJU5DcniVV3x91i4DUL60wQ7feR53LTYyEasK0AWeZEc02INCHSHLNpMLg5345jlyZNWB9pQIpLW3ufUzYG1JYs2V++xyky3ZJ7XrNAj8VJC3mxjnlenePI4S9LWNGmnQgJttYwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744062174; c=relaxed/simple;
	bh=1aplgnizhUX2KCMPSohtzujJdpI6mRSUV6g2qAsz/1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taJtSpMQSrK4q2YSH/YBugoeq1q8FAEi/6vkxkS9wuOvPFgFOWF+PNg0ylQf26NZeNjWrXE7IPA1hA1fp8Z0Vh+JgWg5Ceo4tJaChKSHgY5aATbPe+H2U71W9rOtunHFmzlQ8lpvCc48H+Up8r8YjxmKK+/CHUJAse2hC/c/sf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUdWfIbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6BCC4CEDD;
	Mon,  7 Apr 2025 21:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744062173;
	bh=1aplgnizhUX2KCMPSohtzujJdpI6mRSUV6g2qAsz/1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VUdWfIbRKyPlXHdyZ6qauIe1bmxf+Ot0q8NfnVj5M89zJOMXU1e5B/lnV+etkbT53
	 iDsN4R2PXv8zPU9b2zfQiwarbxdbtycBRiXsh/W5iW6rknfZkssTebvFVWp14ShPTz
	 xDpUACU7CjOcZTmt8aYlluTM8vrmWD0EfRqey59y2k5OQUI6K00mdbHlksPsXoIRiC
	 BO/dqZ7RTI9bW14ttwOkOg2476r/L/w1nB7HOuoVvmAIB7oLURd/WiquOff7ce9FUJ
	 BWbGkEph5/DieKip8VsgfmHtY3u01lpq50PFFg6irQ/x6rj1WDRGwReDP0+zIljM9k
	 FuSgVLaFopj8Q==
Date: Mon, 7 Apr 2025 14:42:51 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: linux-kernel@vger.kernel.org, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: objtool warning in ice_free_prof_mask
Message-ID: <ficwjo5aa6enekhu6nsmsi5vfp6ms7dgyc326yqknda22pthdn@puk4cdrmem23>
References: <4970551.GXAFRqVoOG@natalenko.name>
 <fdb5d23c-8c39-4f73-a89d-32257dac389b@intel.com>
 <5874052.DvuYhMxLoT@natalenko.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5874052.DvuYhMxLoT@natalenko.name>

On Mon, Apr 07, 2025 at 11:21:27AM +0200, Oleksandr Natalenko wrote:
> It's not a new warning, I've observe it for several recent major kernel releases already.
> 
> I do not build with CONFIG_COMPILE_TEST.
> 
> I've also realised I see this warning with -O3 only. I know this is
> unsupported, so feel free to ignore me, but I do -O3 builds for
> finding out possible loose ends in the code, and this is the only
> place where it breaks.
> 
> > > ```
> > > drivers/net/ethernet/intel/ice/ice.o: error: objtool: ice_free_prof_mask.isra.0() falls through to next function ice_free_flow_profs.cold()
> > > drivers/net/ethernet/intel/ice/ice.o: error: objtool: ice_free_prof_mask.isra.0.cold() is missing an ELF size annotation
> > > ```
> > > 
> > > If I mark ice_write_prof_mask_reg() as noinline, this warning disappears.
> > > 
> > > Any idea what's going wrong?

This type of error usually means some type of undefined behavior.  Can
you share your config?  No guarantees since it is -O3 after all, but I
can still take a look to see if it's pointing to a bug of some kind.

-- 
Josh


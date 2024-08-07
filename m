Return-Path: <netdev+bounces-116561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 767AA94AEA2
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 19:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1578A1F22581
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 17:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0951139CE9;
	Wed,  7 Aug 2024 17:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCwa3mb/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23FD12F398;
	Wed,  7 Aug 2024 17:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723050347; cv=none; b=lNZCdVA7TWVupWj7wE6c9aRcXrIJl2TXMI8T1vTQHsCiE+BZ/2xLQ3c8uXCEI0NvqjirRCtuvvEWR8/2GaBMFDNwhxQELEPyM4aauqnqjp4oysNdXK/RW34Ro7wsts1yf5ma+xGZeWjMuKLL1xDPzdaJ8KH1YhSeIoii3pkeAcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723050347; c=relaxed/simple;
	bh=aTViCyKmbUpyeYhUXvYqN+xUH5sZrDigFA7fo5bgqGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilwbn7rwrVLz5pHARvpo1Z/igCQZGGLMk8Nb6hVbAM2e07cwiV79fVH5ebN454Q1IQdftswHXAkGDkPD0fEkO6bwghi8EsMxzjAS5waEHYVX/nJFZn3ojsFwz7GDFJ7GxwUtzktj0Mx0G1oXwD+KUdIr2PGKjTCHdkoTiH/rOH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCwa3mb/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094D4C4AF0D;
	Wed,  7 Aug 2024 17:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723050347;
	bh=aTViCyKmbUpyeYhUXvYqN+xUH5sZrDigFA7fo5bgqGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jCwa3mb/XrIlgV09o0SIJuC3Bxlnx0rEHSw1m4Oy2YR0d4feUg2BaRAuaKBYHEJ0b
	 tsfJ6Ddn65nw0Myc9Hh0SPb1WuaovIr+Ei2w2gS2iTn4YvqnO2OufUS3QmZq6HLMFs
	 qgRABE3wvB6kwfYsGFxxzwzIbY26OBNKKhgKH2qU8L+TcsQj2H7TD82ok/SmKQvTsF
	 TimrbSSy3m3R+tGUEyj6jUbykPwYQs/uHHS3Q4QPwKrVQWomIBLr1vGREz6DWNvAMr
	 Zl3BRtTEYe69XJnNW8/xCsThl2CiEhTwtUKMs18d6ams4mumPCy8veLi28vQoRclYR
	 w3MtwR4EnMWPg==
Date: Wed, 7 Aug 2024 18:05:42 +0100
From: Simon Horman <horms@kernel.org>
To: Manoj Vishwanathan <manojvishy@google.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	netdev@vger.kernel.org, David Decotigny <decot@google.com>,
	linux-kernel@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [Intel-wired-lan] [PATCH] [PATCH iwl-net] idpf: Acquire the lock
 before accessing the xn->salt
Message-ID: <20240807170542.GE3006561@kernel.org>
References: <20240803182548.2932270-1-manojvishy@google.com>
 <20240805182159.3547482-1-manojvishy@google.com>
 <04affbd5-828a-4327-8b84-8767c1c139f1@intel.com>
 <CA+M8utN7FbwMF5QN8O0a0Qnd3ykQwq7O4QkHMVEaBj2jE9BEYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+M8utN7FbwMF5QN8O0a0Qnd3ykQwq7O4QkHMVEaBj2jE9BEYw@mail.gmail.com>

On Wed, Aug 07, 2024 at 06:58:59AM -0700, Manoj Vishwanathan wrote:
> Thanks Przemek & Olek for your quick feedback and responses.
> Hi Olek,
> I can add more details about the issue we faced in the commit message.
> The bug we had here was a virtchnl delay leading to the xn->salt
> mismatch. This could be due to several factors including default CPU
> bounded kworker workqueue for virtchnl message processing being
> starved by aggressive userspace load causing the virtchnl to be
> delayed. While debugging this issue, this locking order  appeared like
> a potential issue, hence the change was made.
> But, this change is more a clean up we felt based on concurrent access
> to the virtchnl transaction struct and does not fix the issue. This is
> more of the patch to do the right thing before we access the "xn".
> I wanted to start with a first patch to the community for acceptance
> followed by a series of other patches that are general clean up or
> improvements to IDPF in general. Will follow with with [PATCH v3]

Still, I am a little confused about the protection offered to xn->salt.

My analysis is as follows, where guarded is used loosely to mean
the lock is held.

* In idpf_vc_xn_pop_free() it is guarded by vcxn_mngr->xn_bm_lock.

* In idpf_vc_xn_exec() it is guarded by:
  1. vcxn_mngr->xn_bm_lock when idpf_vc_xn_pop_free is called
  2. idpf_vc_xn_lock, otherwise

* And with this patch, in idpf_vc_xn_forward_reply it is guarded
  by idpf_vc_xn_lock().

This doesn't seem entirely consistent.

Also, please don't top-post on Kernel mailing lists.

...


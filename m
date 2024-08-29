Return-Path: <netdev+bounces-123326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 503589648BB
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 16:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06EBC1F2686D
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5215A1B143B;
	Thu, 29 Aug 2024 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrCpkQM1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4FA1B0126
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942396; cv=none; b=fu0e13gYL77NXhH1rLCxeOF4T4qQKy0dRkORHFKCH0824kl4vmQNuYYpmwOT1wxRiG5Q6+ejQZzNahQyV6xoDOTByIfYFzjH3b9j/Az9/1273pFC/RICn8PvL4DdaEkwI0iXuFk9tTvYT9qYYaBkkQPf0Q6japnPlDxWsS41XOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942396; c=relaxed/simple;
	bh=i3HRSgsyI1d7DnJimD7jqY3NF8xTUq7AaV0jnfiz+3E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hqxlkSa9iahSs/rRfJwDFgpnVa9/Ogsb/NrbpZXxJzysFu3K8mKUexkvZkq6Dv7ZP7nyD8PUQf5cE1KwWi77dFPhiiA1EMe1oc/AkSXd+quwcx4pQBClUXECOvCGlC3YlHM0wB3DXEgJgutbxxaphPsa5izILpuTeSFIEqj98rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrCpkQM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52211C4CEC5;
	Thu, 29 Aug 2024 14:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724942395;
	bh=i3HRSgsyI1d7DnJimD7jqY3NF8xTUq7AaV0jnfiz+3E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OrCpkQM1rqUtjh6M8gQKAQrOrzokEJEcaJrZXsibAYYuS8VP6BW+rvVBUEtfysrih
	 yXA/GBTtMocO3vEO8TCr3Ral5Cl+7GrTVbmmuYU2vgRQ0yxu469nqEpDSlR1+LVkit
	 z8LZ1KaTOi+axBhoUIT2caI7foLXyr2/JWM2nGvPWw7CvUwTt6OzBUHQ9VzaML1bid
	 NuP++ovuBbS+JkmBIDl4idbJMLtT4Zj+UCRN+ELGQYFTuNCaaKqxftP7DKCY0xeWTa
	 EdS7D+aMsMOSEGp3scTZR9syWtfv95YkcU/Gm8vzUmIYQRjjpqnwau1VguydV4WLar
	 hcz3wOVaNjYvw==
Date: Thu, 29 Aug 2024 07:39:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
 <przemyslaw.kitszel@intel.com>, <joshua.a.hay@intel.com>,
 <michal.kubiak@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>
Subject: Re: [PATCH net-next v2 2/9] libeth: add common queue stats
Message-ID: <20240829073954.73ef0765@kernel.org>
In-Reply-To: <bf736d48-813e-4bdd-b33f-23bb1c7d4c0a@intel.com>
References: <20240819223442.48013-1-anthony.l.nguyen@intel.com>
	<20240819223442.48013-3-anthony.l.nguyen@intel.com>
	<20240820181757.02d83f15@kernel.org>
	<613fb55f-b754-433a-9f27-7c66391116d9@intel.com>
	<20240822161718.22a1840e@kernel.org>
	<b5271512-f4bd-434c-858e-9f16fe707a5a@intel.com>
	<20240826180921.560e112d@kernel.org>
	<ee5eca5f-d545-4836-8775-c5f425adf1ed@intel.com>
	<20240827112933.44d783f9@kernel.org>
	<ea4b0892-a087-4931-bc3a-319255d85038@intel.com>
	<20240828132235.0e701e53@kernel.org>
	<bf736d48-813e-4bdd-b33f-23bb1c7d4c0a@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 14:01:06 +0200 Alexander Lobakin wrote:
> > Either way is fine by me. You may want to float the XDP stats first as
> > a smaller series, just extending the spec and exposing from some driver
> > already implementing qstat. In case someone else does object.  
> 
> I think I'll do that the following way. To not delay this series and XDP
> for idpf in general, I'll drop these stats for now, leaving only onstack
> containers (they will be used in libeth_xdp etc.), without the macro
> magic. But at the same time I'll work on extending the NL queue stats,
> incl. XDP ones, and send them separately when they're done. Would that
> be fine?

Modulo implementation details -- SGTM!


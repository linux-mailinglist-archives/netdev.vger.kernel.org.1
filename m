Return-Path: <netdev+bounces-170331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F703A482EE
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 359E83B313A
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D1925EF9C;
	Thu, 27 Feb 2025 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7brH9Yn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FEA22FAD3
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670176; cv=none; b=WOL1LER0t8IkF34qD4B2CcavZHIE7WSWpqDS3kCsab9zyIsjxAozQ/h/nCwtiZIolCphsR3nEs6XLH0fpTjfirkk3Aa6hYb6wb1mPgmOI8LKxJC8pyrz0HKncXQQSTbYbAwv1VJYqOgkIh+6Ste+cNjVIFOfhCpTEJVoWnaYPMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670176; c=relaxed/simple;
	bh=QUpTJK9tlDJVqdDLV9qis63xou0rViMbX5C60ys6IJA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1SAome4JKFBPIwOxmCUcecuY52tCzr2v5hpqUdavX71daLF/v11Sy8idzvQO6gWjQbnplMaMwfcZ7tBCnB0zWT28/JheCYIf2HhSueiT+pc1jsIUA9qq/rJ41corHtGuz1iewJGA1rSK52gXDPi8QNuJ0HBrbwd5TXXLCak1kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7brH9Yn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7B8C4CEDD;
	Thu, 27 Feb 2025 15:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740670174;
	bh=QUpTJK9tlDJVqdDLV9qis63xou0rViMbX5C60ys6IJA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e7brH9YnsPQFi2xqwCGOTuWdTkLhVSiCtc8cdwtfsbDjLltDpbLR4oMNXw9ex5194
	 niolhm+cCvJg/7acFRYQClInHldMdEfLvtinH2VbwaaiQFiUcySENg7u7Gh40TPkmc
	 bSzO96ekk/75xkLp4/kpcBK/pxY/vToZFP7tl1sl4KkqljoqisOSOajuOiKCITrliV
	 mY3kud9Qxgh31d6rIfbX0U7C7IIkLCvyPyCFDr93JZE5B11Tph0Z6fEmqs4DjyybAA
	 kNSvpt+NaDNrb6f/7qNplxmf50SanLVoDPRXbbAcR0NaMetUPGLaOMJG141iQrFQRp
	 889571eyMTwTQ==
Date: Thu, 27 Feb 2025 07:29:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Joe Damato
 <jdamato@fastly.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next] net: ethtool: Don't check if RSS context
 exists in case of context 0
Message-ID: <20250227072933.5bbb4e2c@kernel.org>
In-Reply-To: <275696e3-b2dd-3000-1d7b-633fff4748f0@gmail.com>
References: <20250225071348.509432-1-gal@nvidia.com>
	<20250225170128.590baea1@kernel.org>
	<8a53adaa-7870-46a9-9e67-b534a87a70ed@nvidia.com>
	<20250226182717.0bead94b@kernel.org>
	<20250226204503.77010912@kernel.org>
	<275696e3-b2dd-3000-1d7b-633fff4748f0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 15:18:47 +0000 Edward Cree wrote:
> On 27/02/2025 04:45, Jakub Kicinski wrote:
> > The ordering guarantees of ntuple filters are a bit unclear.
> > My understanding was that first match terminates the search,
> > actually, so your example wouldn't work :S  
> 
> My understanding is that in most ntuple implementations more-
>  specific filters override less-specific ones, in which case
>  Gal's setup would work.

The behavior of partially overlapping rules being undefined?

> On other implementations which use the rule number as a
>  position (like the API/naming implies) you could insert the
>  5-tuple rule first and that would work too.
> 
> > Oh, I think Ed may tell us that using context 0 + queue offset is legit.  
> 
> I hadn't actually thought of that, but yes that's true too.
> 
> Anyway, 'mechanism, not policy' says we should allow ctx 0
>  unless there's some mechanism reason why it can't be
>  supported, and I don't see one.

I never uttered the thought that lead me to opposing. 
ctx 0 is a poor man's pass / accept. If someone needs a pass we should
add an explicit "action pass". Or am I missing something magical that
ctx 0 would do that's not 100% the same as pass (modulo the queue
offset)? Using ctx 0 as implicit pass is a very easy thing to miss
for driver developers.

But yeah, the queue offset is legit.


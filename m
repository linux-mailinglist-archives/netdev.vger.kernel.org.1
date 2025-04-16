Return-Path: <netdev+bounces-183527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49615A90EC4
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 00:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4993BB3F5
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC5C241676;
	Wed, 16 Apr 2025 22:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOGZUeCg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F361E1E09
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 22:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744843478; cv=none; b=bYu8Lq/FGYFi/wVMxpILE08K36Sj/gG54hOfDrpyZJTYD0yDRTtFT/Ow1s83dtLNGV095R2JW74qVLhJ6WJE+XVflN9ueSZiDWw/iANWrCnjivVFqoMBjfCWLl9dgGKRpuLFXucoIJeEGVHbBKUG3n8GuXKEC6LFBdTqgTBjKrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744843478; c=relaxed/simple;
	bh=lcZgJn+CvHo3YOwlCWFiXBOitE/C42Pup5tjkuVMIlE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLwC3HuxBQ5VSzfzsqSpGCBiImSp8EvIKV0IT5rUC4N08Vtc0sC0Ml/rdfBN56CGyRxq8IzcmelKbMG3tQ7StAk6fHwsWFrpM7c3+uZgW4hRcMGfEOzDXYyYag8z9wwwZPDBOj0Un+vaqA37wU616ltGbj+bzmIZdyLCMNPIQqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOGZUeCg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5C4C4CEE2;
	Wed, 16 Apr 2025 22:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744843477;
	bh=lcZgJn+CvHo3YOwlCWFiXBOitE/C42Pup5tjkuVMIlE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eOGZUeCgsqkIQJN3WKGWc29qCuIX7rfm4g9qqXSXauJezCXZ3Dlp9sWL2tTg3JWfD
	 1bhTySYoAaMiIBmaWt3yTDFyfUR/3pFNnNkUph7SMWizmsmNRwiA0xSkMIX4+u2PjD
	 auheV/4odqN0Ufgv6DnfGYK0UdfyNnGSrw+ls5exWkWwmuAX18sVyEYrLpgxmmWCOn
	 KQOVryisXtvOjf1WQ1jAaYJGmHLJQ6x3Y7CDDuXxj066Ks6cAfW1HsoFzpM978NSNA
	 P0QBwKI4xOJz5vrD2240ElQ0qfPcEKXphiIp9vy0wuBqJg3LEIRWMviuLnDQDXaRIm
	 HrgT4LI2S50dA==
Date: Wed, 16 Apr 2025 15:44:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, jdamato@fastly.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Igor Raits <igor@gooddata.com>, Daniel Secik
 <daniel.secik@gooddata.com>, Zdenek Pesek <zdenek.pesek@gooddata.com>, Eric
 Dumazet <edumazet@google.com>, Martin Karsten <mkarsten@uwaterloo.ca>,
 Ahmed Zaki <ahmed.zaki@intel.com>, "Czapnik, Lukasz"
 <lukasz.czapnik@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>
Subject: Re: Increased memory usage on NUMA nodes with ICE driver after
 upgrade to 6.13.y (regression in commit 492a044508ad)
Message-ID: <20250416154436.179ba4e9@kernel.org>
In-Reply-To: <CAK8fFZ4bKHa8L6iF7dZNBRxujdmsoFN05p73Ab6mkPf6FGhmMQ@mail.gmail.com>
References: <CAK8fFZ4hY6GUJNENz3wY9jaYLZXGfpr7dnZxzGMYoE44caRbgw@mail.gmail.com>
	<4a061a51-8a6c-42b8-9957-66073b4bc65f@intel.com>
	<20250415175359.3c6117c9@kernel.org>
	<CAK8fFZ6ML1v8VCjN3F-r+SFT8oF0xNpi3hjA77aRNwr=HcWqNA@mail.gmail.com>
	<20250416064852.39fd4b8f@kernel.org>
	<CAK8fFZ4bKHa8L6iF7dZNBRxujdmsoFN05p73Ab6mkPf6FGhmMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 18:03:52 +0200 Jaroslav Pulchart wrote:
> > FWIW you can also try the tools/net/ynl/samples/page-pool
> > application, not sure if Intel NICs init page pools appropriately
> > but this will show you exactly how much memory is sitting on Rx rings
> > of the driver (and in net socket buffers).  
> 
> I'm not familiar with the page-pool tool, I try to build it, run it
> and nothing is shown. Any hint/menual how to use it?

It's pretty dumb, you run it and it tells you how much memory is
allocated by Rx page pools. Commit message has an example:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=637567e4a3ef6f6a5ffa48781207d270265f7e68


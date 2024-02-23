Return-Path: <netdev+bounces-74230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCC58608EE
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 03:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6882B232E4
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 02:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B32BA30;
	Fri, 23 Feb 2024 02:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgmykX5Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F57FB664
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 02:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708656047; cv=none; b=K+kT53X7uPRRCUyAChgD82Nl7i15cTAgMuLvE/ks2gxm1nturAO58ZKtmUZ846tRIartEVLUWRFmNt+rKbqMfefHnvuY34JmPBx+qSrplMk2cfvW2Iz+ATYWZpoyfL1kdgQHphiu8DO+wqpUN7oVdN3vXu7HCvUQ3sfNcMn2vKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708656047; c=relaxed/simple;
	bh=IobIRdT3Ig21oarXgExWNcl+H+c2QnoSca+gsu4tx1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q+NZCvmRW0suCVVI2ISJ7KcLa5JoXUyQevGj1zeQk4e1EawbcUfhgceLiMLNVTXuZM01F3tScSpYjzduoBJa0fHyH6UgTRl7ps+neagLi62ZJJgWFxXM9j8ZVfSJ6B1Nl6eTvBXg7RFgoZ32BO/oBWXljWq3wzCxFbHYMzz6fSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgmykX5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0481CC433F1;
	Fri, 23 Feb 2024 02:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708656046;
	bh=IobIRdT3Ig21oarXgExWNcl+H+c2QnoSca+gsu4tx1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IgmykX5YbI8mGqrMJHiz8JKsplCeoEqjKdSFaqky4e52SMQdKFbGVjs/6I/t3KTJi
	 ZPrsRGT0Z/fwMIVY5llCVNMTwRzBh9Pawv4v1EaqBXbB73H12qRHUUQrs/FQzgOeLv
	 XrSKatgepCiBSBRzvq82xlvLIHrO/bpNOJ6Mka6tym7hZTJ+6DXJsZe+JpP//LM1Iu
	 v0/MSkXhBugTVy9uVHuyvZnU65TkF9nk1v9ebtYyxS3adJciC1zNxMeO4szSdOX6vL
	 TuvvYVX925IY0KEZLneSOfyJaoou9s92wr+oGg6pUoWOJJjlt9XsUpyO2dlrY0r0D/
	 /kuXYzgPdizwg==
Date: Thu, 22 Feb 2024 18:40:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: <stephen@networkplumber.org>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <corbet@lwn.net>,
 <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
 <netdev@vger.kernel.org>, "Chittim, Madhu" <madhu.chittim@intel.com>,
 "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
 <amritha.nambiar@intel.com>, Jan Sokolowski <jan.sokolowski@intel.com>
Subject: Re: [RFC]: raw packet filtering via tc-flower
Message-ID: <20240222184045.478a8986@kernel.org>
In-Reply-To: <5be479fb-8fc6-4fa1-8a18-25be4c7b06f6@intel.com>
References: <5be479fb-8fc6-4fa1-8a18-25be4c7b06f6@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 12:43:47 -0700 Ahmed Zaki wrote:
> Following on the discussion in [1] regarding raw packet filtering via 
> ethtool and ntuple. To recap, we wanted to enable the user to offload 
> filtering and flow direction using binary patterns of extended lengths 
> and masks (e.g. 512 bytes). The conclusion was that ethtool and ntuple 
> are deemed legacy and are not the best approach.
> 
> After some internal discussions, tc-flower seems to be another 
> possibility. In [2], the skbedit and queue-mapping is now supported on 
> the rx and the user can offload flow direction to a specific rx queue.
> 
> Can we extend tc-flower to support raw packet filtering, for example:
> 
> # tc filter add dev $IFACE ingress protocol 802_3 flower \
>     offset $OFF pattern $BYTES mask $MASK \
>     action skbedit queue_mapping $RXQ_ID skip_sw
> 
> where offset, pattern and mask are new the flower args, $BYTES and $MASK 
> could be up to 512 bytes.

Have you looked at cls_u32 offload?


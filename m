Return-Path: <netdev+bounces-109243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D77927865
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15EC21F2515F
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 14:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94C01A0B1D;
	Thu,  4 Jul 2024 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjCh0YUN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910141DA58;
	Thu,  4 Jul 2024 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103461; cv=none; b=VwirzLK9VSK7UM8j7lqQIMY+C3eiL5fuVC/JGqUGy5SjBDvrbXC9i7BDXk0Tmtno68h954WZLMyMRq0H85sTmQ1UAyB2P5znVT/RvCguC1b7lOiF3tvm3NQfIAIYkmWXOWrPplutqRh21VtYezaGk9z6tlzf0QQxkSbAHVpMvBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103461; c=relaxed/simple;
	bh=oQAmUrRfhx4B6Tl3H9BetcyAPDwKs4yCMdkTWEMTkvM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OIcNwg92pGX3D+gA5F9DjpD7qckpNgnGisrnotKw7tazGz5JdrAB5LHEgsKeKLsPGzSnazTDO/204Tj1myHBs8mibs5K1oyZ+ck2Zail+nFY2z6L9NC4dGME5+rOWos10q6K1A/+CgsvKGu0B/iCff1hN5U0JhjaoDVLUHCrTRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjCh0YUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B3FC3277B;
	Thu,  4 Jul 2024 14:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720103461;
	bh=oQAmUrRfhx4B6Tl3H9BetcyAPDwKs4yCMdkTWEMTkvM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FjCh0YUNvR5uY24+D7Rzui72wZ2fWYxVxGCxS+qkSJifbaKwFZMavgKlnN6PiXuVB
	 ozG22XFcQJtb2w1djehUOOaG1CU2TqzuaxSA692Nw8vzwyZhtoR4iAV2veOwVOJkcj
	 nAWaq6F1//EBITGTHuwTP/VHuz0kYuLOxpnSMFgVuZnERdCruaDlm70kt/Oc/ffpvs
	 CVT0kQRFHW73S+9jxDeN3y91xBbiCn0Kj3vXSX7RPd3gskVAmEDLdwIW05CqopMGOF
	 Reesbm7Cu9y9eqHh1SmlftqYtSEV6wwJq5mOvjawQWKLs1Zer23e1J6DG0VRSkD5Za
	 aKGD3yuS7oamg==
Date: Thu, 4 Jul 2024 07:30:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: Chengen Du <chengen.du@canonical.com>, <jhs@mojatatu.com>,
 <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <ozsh@nvidia.com>,
 <paulb@nvidia.com>, <marcelo.leitner@gmail.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Gerald Yang <gerald.yang@canonical.com>
Subject: Re: [PATCH] net/sched: Fix UAF when resolving a clash
Message-ID: <20240704073059.2e797f2d@kernel.org>
In-Reply-To: <ZoaAH/R8NM1rtYFt@localhost.localdomain>
References: <20240704093458.39198-1-chengen.du@canonical.com>
	<ZoaAH/R8NM1rtYFt@localhost.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jul 2024 12:57:35 +0200 Michal Kubiak wrote:
> Please check the patchwork warning for details.

Please don't direct people to patchwork checks, it's not a public CI.


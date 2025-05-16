Return-Path: <netdev+bounces-190902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A99CAB9367
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 03:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D1E1BC46D8
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 01:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799E4214813;
	Fri, 16 May 2025 01:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fM5Hpisd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5576D2147EA
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 01:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747357490; cv=none; b=SVtt6QgZwiri5ZP0H3zgjXqZe67sK2Gxi5LqrmpFJpWqdFdehe33QFjwmW77IP7Y4u4DHenB8E86YyHBNqnJSOURPR+d25YnXsrmbsJT7T3JCGBfZd0gc+SNa/sfr5Lsk8bzIwHMtCURY+Be/5Dr0HC2yFAtkqqfRqtb43YdVSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747357490; c=relaxed/simple;
	bh=3ggWfmad+Ahr7bFez/BW9d/QPrzgbhpVN0Lt6HYLdYw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mmSKPU97GSwhjBfJiT0QqB8i15vZsVAkID+AsnAn7VIhwdCPvee+PUHgeVAvFmvjWV4YZkPPgvrqGU32uhwHKoacSkfOdNCm/36cim78Px/bkqd8omsJnLyBlXpCjw48dTs0mW9GEBUPG7xV/QEa/kpxva/72lbQQt7zQLhEVaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fM5Hpisd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC0EC4CEE7;
	Fri, 16 May 2025 01:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747357489;
	bh=3ggWfmad+Ahr7bFez/BW9d/QPrzgbhpVN0Lt6HYLdYw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fM5HpisdK9I89uPQxKjo44flBMfJQYJLWGvodP3rAmh4O/ZYNp19nXuMIEXEt9vl9
	 M6lcd8BIxyIyhg27f8WudzMRH+ojoT4sr8/f5BJK8YsVeIrKy4DQ6YTDCUMBqQ2fVQ
	 IimnR8/BHVSAg/ibZJLPhMGgE9mqyu6AEQ35FoQP46OCjtBMixlNrsXyCwh3DLULeW
	 EvTbvV34sUfjtRidMBti0A97mHFewVxi3760FPT0iiTU7aUq9lXjsJ7FKS2YrySQcV
	 VRajxmnCd8ublHWq0l2oeTPk/9NFvlTFJmMc2nRAIac5cSMRzcm1cUL7hg662V7Rl1
	 TCUdwm5vxv7Tg==
Date: Thu, 15 May 2025 18:04:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Richard Cochran <richardcochran@gmail.com>,
 Furong Xu <0x1207@gmail.com>
Subject: Re: [PATCH v2 net-next] net: stmmac: convert to ndo_hwtstamp_get()
 and ndo_hwtstamp_set()
Message-ID: <20250515180448.2d00909a@kernel.org>
In-Reply-To: <20250514143249.1808377-1-vladimir.oltean@nxp.com>
References: <20250514143249.1808377-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 May 2025 17:32:49 +0300 Vladimir Oltean wrote:
> +	if (!netif_running(dev)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Cannot change timestamping configuration while up");

changed up -> down when applying


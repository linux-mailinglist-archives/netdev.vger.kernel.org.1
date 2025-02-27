Return-Path: <netdev+bounces-170108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA46FA474DA
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 05:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3751701C3
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 04:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B481E521D;
	Thu, 27 Feb 2025 04:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJBzniOZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF7B1D6DA8
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631506; cv=none; b=cPvftXp3wEQZfTC7iBxBA8aRnu71Y3+aGPBm81mtPS5CYqyP/8GmXH1kjENrKx4NeKGI3Kz62duFGursJ7neq2fQxqlXXfNuChyErKhpKdNYZUM2crZdpTsQxgoy3xypmvHoQHghH+uaNkngNTu5iRouu/qL6yYx86JHAxzaep4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631506; c=relaxed/simple;
	bh=Zxt9c2e+Nu+AmaPjZQDnG+G22k2Fvo4v6nXQpSNfRKY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=StL/DpnGG3nvT3OHGdlSmZcRtpup8e3ygT1Cikotu9DhtfikHB38KwSfjAiAU3udnvBDvWShtCQPY85X24PwamaVGTdwVl8G8+TP8LGN2kDlxE4Ws6uJuz4ZSHeynpVr27BMcEszjFvE41OHRxv4QUvSb+h/k7hAEX6miG695+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJBzniOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDE4C4CEDD;
	Thu, 27 Feb 2025 04:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740631504;
	bh=Zxt9c2e+Nu+AmaPjZQDnG+G22k2Fvo4v6nXQpSNfRKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SJBzniOZ/dks4vwix/aHQbCnm7H2no87+YmLJPIOExDVDa7wVNznVpbqIbx9N8zA/
	 Y5hPfs1Ez448zv4r2hj7cFgFEpRQer7fmhpXuDe0ukBD0fExJgK9OrLJWm7daPf+80
	 dcwkV6+fexnoE6KYIoMHXXPtOU42Eo7HgQ8gVcfv1qIosDCpj95/Wo0N2VYXinffFF
	 1Es6QU5ndSn857nQUWeHrilATQknbVWGoL+qbDYEOesP2wg4xWBHPndPKJCNbkeVYU
	 h5qOcPtskNbhpYhW02LBosnv+HQ3flldK7c9/TJKrag5TIOLeG5qinvhHKUP37xsib
	 f0ky7L2Zcbm1w==
Date: Wed, 26 Feb 2025 20:45:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Joe Damato
 <jdamato@fastly.com>, Tariq Toukan <tariqt@nvidia.com>,
 ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next] net: ethtool: Don't check if RSS context
 exists in case of context 0
Message-ID: <20250226204503.77010912@kernel.org>
In-Reply-To: <20250226182717.0bead94b@kernel.org>
References: <20250225071348.509432-1-gal@nvidia.com>
	<20250225170128.590baea1@kernel.org>
	<8a53adaa-7870-46a9-9e67-b534a87a70ed@nvidia.com>
	<20250226182717.0bead94b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 18:27:17 -0800 Jakub Kicinski wrote:
> > Anyway, it used to work.  
> 
> To be clear unit tests don't count as "breaking real users",
> and I assume the complaint comes from your QA team?
> 
> Given the weak definition of the ntuple API I'd prefer to
> close this corner case. Unless someone feels strongly that
> this should be allowed. If a real user complains we can both
> fix and try to encode their flow into a selftest.
> 
> Let me CC Ed, too.

Oh, I think Ed may tell us that using context 0 + queue offset is legit.
If he does, please respin with that as the justification and the test
case as suggested by Joe.
-- 
pw-bot: cr


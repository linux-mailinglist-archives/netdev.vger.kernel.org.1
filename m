Return-Path: <netdev+bounces-169671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 065E3A4532C
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 03:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F29C1889FBE
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 02:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2541A2C11;
	Wed, 26 Feb 2025 02:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKQs5SIw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF32E42070
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 02:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740537526; cv=none; b=n43JANWecEGdIT7bO8m5oBh+wIBCIyYs7LxujtEWmBlJly+ueulTkPD3qcxPexWogtIP7r3k3b5FHS+irLnyrdvXikOBsHWilYqxEalO1OESHqJWpBNft6SyntRoy8VO9BI6niJ7y8X5ZcabzNQAZE4ata+Xl3tE6jNonsrYG1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740537526; c=relaxed/simple;
	bh=aLXuF7yTDQ4ITxWf75Rpp767Tr9bWsf/z4SK7Mmoi9c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=duJ94mDC01Pv6e6otRhhQgikRGg1/PTVY+UoJ9TlYrU0Bfkzi5HzRUfaKxAjYAGsA1DCjKWgu5MTRHrTZ0fY1c4LBRMTWQ/hXNMH/GZoOZf1/thPqNuOiOUZ8y4ZLmBFglZbhnJLNIiWEFCsqIFjJ0iS4RQ/vofPtkWK3mnkiSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKQs5SIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D392BC4CEDD;
	Wed, 26 Feb 2025 02:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740537525;
	bh=aLXuF7yTDQ4ITxWf75Rpp767Tr9bWsf/z4SK7Mmoi9c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LKQs5SIws+FD3mgeNF4CFHMP30BolVa0hf3nUoqqiPD1ItWyuYfGRyfL9YDXy4KTT
	 PfrexS+1B+ldvxTfZ4hgLHZgCX6aXg67JtWcR2SFGNE+T4GdM7qkW+5hFtGAn0pCUG
	 17ijKNzJcDDOJxwgkr13BOOHzdAZxCNjxkbMtSb6rdlutJn1fTSVBpfErfau5PJAUs
	 svb7qCR7T/qDHzVGmsjkt+kxdTwi9Na1Pv6k0fH5KOthkfAoN8ndZg0LIAc2vJF9oa
	 ysnFDqbRaQF3b+GI/5AnLIqkbr6xflcmLf4UGE9TUb7KBo4Ka34z8b0oX+ztkNA0mB
	 nCzTvrStZE2WQ==
Date: Tue, 25 Feb 2025 18:38:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Ahmed Zaki
 <ahmed.zaki@intel.com>, willemb@google.com, Madhu Chittim
 <madhu.chittim@intel.com>, Simon Horman <horms@kernel.org>, Samuel Salin
 <Samuel.salin@intel.com>
Subject: Re: [PATCH net 3/5] idpf: synchronize pending IRQs after disable
Message-ID: <20250225183844.44f9eb66@kernel.org>
In-Reply-To: <20250224190647.3601930-4-anthony.l.nguyen@intel.com>
References: <20250224190647.3601930-1-anthony.l.nguyen@intel.com>
	<20250224190647.3601930-4-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 11:06:43 -0800 Tony Nguyen wrote:
> From: Ahmed Zaki <ahmed.zaki@intel.com>
> 
> Wait for pending IRQ handler after it is disabled. This will ensure the IRQ
> is cleanly freed afterwards.

No real explanation of the race in the commit message, no comment 
in the code. More info needed here.


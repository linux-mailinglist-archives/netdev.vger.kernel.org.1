Return-Path: <netdev+bounces-103764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A99ED9095AC
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 04:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A531C2147D
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 02:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C378C79F5;
	Sat, 15 Jun 2024 02:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2uKrgsZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9952219D8AF;
	Sat, 15 Jun 2024 02:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718418443; cv=none; b=HAwG5IROobcD6ZvIh+aRaZw7qgxVSiIBA6k9yjqAVCImyZsm43/eTOQfV/aMQD4f9zEhnUvbNpT9e+/J2FEipYexR2qgm8/8bVI3o+9bBoTQhyJKkYrk9FGwDkWOXHbnNkThvvU+G7pvc3bT4uDL07TC3DyfVhvXNbw13lFvyRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718418443; c=relaxed/simple;
	bh=t8KWBraf+ArgRE1IzbmljHRa8Tm+WCzZh+Q4NDrt4tc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ecGrp5PuVBRa/6XF3EOFRy4+Sz4f3SdHby2l5JdtfkCbUBOcnmMOPNUQqTPac1KyL5h0hf1Ctknh4dRuuuAw5rhwV4xwsOqHr0n+XQfbC4ITWjho8WNytKt9ig7ACE3dmmbyVJ/ISAkfgjseLveyudd4K8VfXcL2IFRy2xx4Myw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2uKrgsZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F10C2BD10;
	Sat, 15 Jun 2024 02:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718418443;
	bh=t8KWBraf+ArgRE1IzbmljHRa8Tm+WCzZh+Q4NDrt4tc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R2uKrgsZyfkrLppuSWRCNSWlnaR0nryyf+lWWxIToS/Ud/FSrlLNEDC+aj9WWybku
	 jlPIoybPYqcck1AzgN1vNrwvzXYk8+cYU6jF8pWd7/TnHWj4i0jXW48U9PqraQE6fQ
	 jCdvgvZPc3nDol7ha/xZADifkafKfy7PASfA843xJp5Jb7kAua1PyPLIPPmUFJJHUJ
	 KXH7YW3a8hTlBSvK6kEiMnI+6eoRh/EXAfmxN0/lLwN4sCUcCj7fBJ900rgZNRuiXI
	 iJ5zjrFVG3u46ufk1JM4ihbAVf0VLFz82fuAsKxphbGXlGGnTOAN8pc7Bq4H6mvihN
	 WGVJEVBU1f+Qw==
Date: Fri, 14 Jun 2024 19:27:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ziwei Xiao <ziweixiao@google.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, pkaligineedi@google.com,
 shailend@google.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, willemb@google.com, hramamurthy@google.com,
 rushilg@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/5] gve: Add flow steering ethtool support
Message-ID: <20240614192721.02700256@kernel.org>
In-Reply-To: <20240613014744.1370943-6-ziweixiao@google.com>
References: <20240613014744.1370943-1-ziweixiao@google.com>
	<20240613014744.1370943-6-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 01:47:44 +0000 Ziwei Xiao wrote:
> +	dev_hold(netdev);
> +	rtnl_unlock();

If you care about the op being unlocked make the core not take
the lock in the first place. The core itself doesn't need it
either. Add a flag in the ops to tell the core driver doesn't
need the lock.

Disappointing :|


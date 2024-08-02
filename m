Return-Path: <netdev+bounces-115277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7DB945B4A
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 11:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3B81F24405
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 09:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFAA1DAC51;
	Fri,  2 Aug 2024 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqM7FEQk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F56256D
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722591744; cv=none; b=hsPYrMe4AiK92X7FQMjHiSnq21yA483YNw5CoToQzFkwAs/uwjKyO6GHbz9GPg7PLezon4QAI3TQ0Yn4t1uImrM1L9OH5aarhyqJ6HZfhPTBXZxYBBF4UZvHWG9kz3+mZVzeaDyfD0boWymmJy23Rq/TQDaKg7qcQlke3CM3vGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722591744; c=relaxed/simple;
	bh=rzqvTPucUOHePsBnwTFO4YPTZGqWKB3T985AtQaSS0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQZnVQTZxrHhyrUjsMdkOusNUjXIhgnj3eAX76SUO0nZ1SWaV/PX+Iipk87/EoStMjugpCK2HfusLpiGgnw9SXf2EqqHXB5tLlbS4+JyH3eyavnsYFruRmd6JEo8N3Pz11J2Qpyo37cbJf+gCxrFUUpw7XL+mmsSjR9zjoXNQNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqM7FEQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2700DC32782;
	Fri,  2 Aug 2024 09:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722591744;
	bh=rzqvTPucUOHePsBnwTFO4YPTZGqWKB3T985AtQaSS0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IqM7FEQk0cByC1OLzEEf/hZXQDCtHLc0EYkB9scinDXdmnxQ10N3fQ7IZ/iScuDv5
	 dQBrkDNptabp1ORELwMP/SZxU7UWzO8q7VU0vniVIcb5IwSLYR0+F9pw0eFeB8885j
	 k9ZyTmunmKtegZyH06xLJMArpsCWINPylKgxx6erGg+r3/eroMzubBdHo2F03g4kfJ
	 iOu1FDV/wKSC8pa3tAoUOxt06DlkiZ/h1cd/y3oYapC4qEop4pHFMqEJYGFaoXsZ8A
	 So/pjrSbj0p3wc6hgkBUSpHmPerVoEAqHtlix4oVuQ2gbD6lyBjTN70sEjvkCdn42g
	 x2x0oCPo/GTMQ==
Date: Fri, 2 Aug 2024 10:42:19 +0100
From: Simon Horman <horms@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
	Per Liden <per.liden@nospam.ericsson.com>, netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH net-next v2] tipc: guard against string buffer overrun
Message-ID: <20240802094219.GB2503418@kernel.org>
References: <20240801-tipic-overrun-v2-1-c5b869d1f074@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-tipic-overrun-v2-1-c5b869d1f074@kernel.org>

On Thu, Aug 01, 2024 at 07:35:37PM +0100, Simon Horman wrote:
> Smatch reports that copying media_name and if_name to name_parts may
> overwrite the destination.
> 
>  .../bearer.c:166 bearer_name_validate() error: strcpy() 'media_name' too large for 'name_parts->media_name' (32 vs 16)
>  .../bearer.c:167 bearer_name_validate() error: strcpy() 'if_name' too large for 'name_parts->if_name' (1010102 vs 16)
> 
> This does seem to be the case so guard against this possibility by using
> strscpy() and failing if truncation occurs.
> 
> Introduced by commit b97bf3fd8f6a ("[TIPC] Initial merge")
> 
> Compile tested only.
> 
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
> I am not marking this as a fix for net as I am not aware of this
> actually breaking anything in practice. Thus, at this point I consider
> it more of a clean-up than a bug fix.
> ---
> Changes in v2:
> - Correct formatting and typo in subject (Thanks Jakub)
>   + The formatting problem was caused by tooling (b4)
>     so I reworded the subject as a work-around

Just to clarify. The formatting issue I was referring, is a double space
in the subject [1], which seems to of occurred due to the subject being
linewrapped and then unlinewrapped. However, in the light of a new day,
it is not at all clear to me that b4 is the cause of the problem.
So sorry for pointing my finger at it.

[1] https://lore.kernel.org/netdev/20240731182356.01a4c2b8@kernel.org/

> - Added Acked-by tag from Jakub
> - Link to v1: https://lore.kernel.org/r/20240731-tipic-overrun-v1-1-32ce5098c3e9@kernel.org

...


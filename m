Return-Path: <netdev+bounces-107438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E07DA91AFC4
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 21:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8BF283345
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 19:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE329446D1;
	Thu, 27 Jun 2024 19:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9yMcj55"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BBA33C9
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 19:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719517174; cv=none; b=S7ak0/MhmaJ+9jtNi666537mLnjGKDHkwnQQ24Yo2KAqCF8OYfacug13QsPyjKe8HElJuS+5mwqjvD5EbMj8NoVxS3ARFioJQ4+V0PPIir1w7Nj1NzQY6QFwBvJvHI3uuiAKYJ2SxzBa8D7olgb20bz27RB+73ZoS821PQunZ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719517174; c=relaxed/simple;
	bh=hSBJk/HwR4pHg3H3e3bsWeKioFIfedfcF79GSgbv80A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lcP5DQ7cDJwYBWNiTGcGHHDggEnbbO7XlEBoYrRQ1k+upwzHt0yeFM3vcW/CJ2iXcTypOTmN70c451itZTt4YbkbeIzdhMeHFS+MjUw8DVHJ+Owguwpv+1hY5DXULm+1ypXgjpYTj6L+Fi22Q/dZ5aEBCY1gf4RtSKrOwfL5jZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9yMcj55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DA0C2BBFC;
	Thu, 27 Jun 2024 19:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719517174;
	bh=hSBJk/HwR4pHg3H3e3bsWeKioFIfedfcF79GSgbv80A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d9yMcj55IM3xE4K1/8Wbo9XXTLNms+ZD03zmSq0zH1pVo88JWzfPDnaL2vu4D++bR
	 +WgZPsWaKdilMKf3vP9Cmeu55LbbY5L7QtRHDhqzsughNfqsAqhRrscZCdRIjrivAy
	 rsZkE9nMjq8X3upZpMhftal/zwgiV4dalcoB9h9vl91CVO6qAoFNhz3WKIE4AD3yQ6
	 0hroDj/lgK1STr850fUhZcKKkQe4Cs8JJ1DiptBkRaCCqzWHg/Bcb192SkkS3z9cK9
	 eSCLy9ySC2hi9u+y8tJCgsytWQc2lHfHUe4g6uTXG+m3/X6lOxW9jdBoaE0ZsEWoqI
	 6/yiYGnrGUG1Q==
Date: Thu, 27 Jun 2024 12:39:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Jiri Pirko <jiri@resnulli.us>, Simon
 Horman <horms@kernel.org>,
 syzbot+e77327e34cdc8c36b7d3@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: ethtool: Fix the panic caused by dev being
 null when dumping coalesce
Message-ID: <20240627123932.4c7e964a@kernel.org>
In-Reply-To: <20240626153421.102107-1-hengqi@linux.alibaba.com>
References: <20240626153421.102107-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 23:34:21 +0800 Heng Qi wrote:
> The problematic commit targeted by this fix may still be in the next branch.

Could you resend with [PATCH net-next] in the subject instead, in this
case? Our build bot trusts the designation in the subject so since this
was submitted as "PATCH net" and patch doesn't apply to net - it
rejected the patch.
-- 
pw-bot: cr


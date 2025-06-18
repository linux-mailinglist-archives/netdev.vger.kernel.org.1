Return-Path: <netdev+bounces-199250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA60ADF8F0
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 23:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8224D189DBA0
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 21:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA1C21CA0D;
	Wed, 18 Jun 2025 21:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhJO2H3G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2354628682;
	Wed, 18 Jun 2025 21:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750283612; cv=none; b=YCIj3idweE4fIv+ss3pMYN3OYgUQ1oa9CACzTg+2GBSqlrTlqUGdNJTg2PUKv+uWZLL0jXLaP1KyNctVSEZIR18CmgTD/YQY8iG2qv8ODZlEuqqr0GBplgSRH34cV+Pcdb4+WVyvQE5wqJM9vpahIykMIyHVA63R+J9PTN0P+k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750283612; c=relaxed/simple;
	bh=wXtVusAp3+QiMEIYqRg9Vl6bCRKV2LLfzhRzLsjob9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AeDxsfA8rn3f11fWYlzszYl2ftda2FF6d7lmnMJaMLD850lB82WFJd/Nt6vPdG9sLfIf7mBP+0H0LJYsadpZ8ewrA3i91lsMeqLLHaI11c618HJ/WdFReKvC3CJCFW+SnuD2EoKdaBmYe0BvPnKbP96Dk9zhSLlX1WuOZaN+lKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhJO2H3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6193EC4CEE7;
	Wed, 18 Jun 2025 21:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750283611;
	bh=wXtVusAp3+QiMEIYqRg9Vl6bCRKV2LLfzhRzLsjob9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DhJO2H3GZYNsUHx0LMLE5Fls0eTyfMNnoQLmwYviESb1WWJPdRitbjF36PFQeByn2
	 BnRngd3AQhxuqE+ApR0C96PpCF0e+BaSnAIK/KVyyzbjwEnMzXMpfiAt+27sRMEXS/
	 x8+ByI0b6GGuUqpt6Modf6UOJhryCcPwcUXqcdflsnTEGqV60IRlUmu+mGT9YcTyjk
	 ueSHH1vs65tGjZVCbZ2cI4c0aUcg6dEoeyHaLxeGI6tmCovJL9PTTie3NQjyzkwjAl
	 bJGvrZS8lkNSvLrmzBx2HSO0Z01Z9BzYW8ZinnO4avwQ9MGCi9zZSeSowc19OL3S1N
	 +d/1qQHQ8y+9Q==
Date: Wed, 18 Jun 2025 14:53:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, ap420073@gmail.com
Subject: Re: [PATCH net v1] netmem: fix skb_frag_address_safe with
 unreadable skbs
Message-ID: <20250618145330.2584636e@kernel.org>
In-Reply-To: <20250617210950.1338107-1-almasrymina@google.com>
References: <20250617210950.1338107-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Jun 2025 21:09:50 +0000 Mina Almasry wrote:
> +	void *ptr;
> +
> +	if (!skb_frag_page(frag))
> +		return NULL;
> +
> +	ptr = page_address(skb_frag_page(frag));

Sorry, noticed mid-push that we're calling skb_frag_page() twice.
Let's save the return value and pass it to page_address?
-- 
pw-bot: cr


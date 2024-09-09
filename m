Return-Path: <netdev+bounces-126492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAADA971619
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 13:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650A71F270F5
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 11:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17A61B5EC0;
	Mon,  9 Sep 2024 11:01:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154CC1B5EB1
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 11:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725879678; cv=none; b=J8VPFyEvS6Tg5FXvPQUN/K5ZjcRLqlIy+Nedzt3Q9LFfaqx0EE6Lolucs5HiJt13Ad9vnKO/izpe8S/HFJo29aOBB9QYGlWejV0EdWk251FyIOgAarsrPTAAVxelR/nj/YakrHnY+dqnr5zI+5rSKGXAqCc6AfBbIIeVQY88agU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725879678; c=relaxed/simple;
	bh=8zfTxnNihtDUO3V9f4OtBR4610dCCe5Yona4CKJg/g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rldi8Ic8TtShlhs01zyrFoHwU7C7CZHSpDg1JG8BhksnogSxdYwK7zXKZ7z88/4KHdli3ZXJxeUuEKHRTF9anhCbNLQPcKFzMhfzc9IESFc20O9WK6jtATskUYMMj0JVlIqKRJzzQUuAMGp7Cu6Xa1jh7HyQu0xpOlB+5UdAcUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1snc8t-00053n-Qd; Mon, 09 Sep 2024 13:01:11 +0200
Date: Mon, 9 Sep 2024 13:01:11 +0200
From: Florian Westphal <fw@strlen.de>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org
Subject: Re: [PATCH 06/11] xfrm: switch migrate to xfrm_policy_lookup_bytype
Message-ID: <20240909110111.GB19195@breakpoint.cc>
References: <20240909100328.1838963-1-steffen.klassert@secunet.com>
 <20240909100328.1838963-7-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909100328.1838963-7-steffen.klassert@secunet.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Steffen Klassert <steffen.klassert@secunet.com> wrote:
> From: Florian Westphal <fw@strlen.de>
> 
> XFRM_MIGRATE still uses the old lookup method:
> first check the bydst hash table, then search the list of all the other
> policies.
> 
> Switch MIGRATE to use the same lookup function as the packetpath.
> 
> This is done to remove the last remaining users of the pernet
> xfrm.policy_inexact lists with the intent of removing this list.
> 
> After this patch, policies are still added to the list on insertion
> and they are rehashed as-needed but no single API makes use of these
> anymore.
> 
> This change is compile tested only.

This needs following fixup:

https://patchwork.kernel.org/project/netdevbpf/patch/20240830143920.9478-1-fw@strlen.de/



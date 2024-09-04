Return-Path: <netdev+bounces-125227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67F696C58F
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 19:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88AD1C21D56
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2D81E1303;
	Wed,  4 Sep 2024 17:39:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213156E619
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 17:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725471545; cv=none; b=WW7hkodP4nTyFWKMbD6aPTnRvV/UGU9+7L2X47nzTs9hWNlJrtgVdeewhRjjc1XLNMGIAIYj20lb7RE0kbWi9qTuJFRe10xJeO1e9KMUJQG2pJAgOk5Yla7FOe3iRkcG15VNI2kBFUXl7OcAm/pSbJeeGaJEtllPJWsi6B+nHTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725471545; c=relaxed/simple;
	bh=X8ZcwREnazxQNyYjRDexNtG2U6hQps4i4Bqq7v+lm+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qa1tmva2nzEZp7bLJFa1RDXKFaVn/Dcnh3vMqBNl9xEeYfk/JZu78FAgYNxzH7B32U/JCzTmjeHZ2zcDnY+Xngjcu7/aT7vs4h6fCnEBSReUn6WQdjINeH4IVOhL7/iaBQsTA9UQ8HHUtXLhpS8RySR5G3PKj5n6KDf7fRPVeJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sltxz-0006UP-Ld; Wed, 04 Sep 2024 19:38:51 +0200
Date: Wed, 4 Sep 2024 19:38:51 +0200
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>,
	Tom Herbert <tom@herbertland.com>, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH net] ila: call nf_unregister_net_hooks() sooner
Message-ID: <20240904173851.GA24759@breakpoint.cc>
References: <20240904144418.1162839-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904144418.1162839-1-edumazet@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Eric Dumazet <edumazet@google.com> wrote:
> syzbot found an use-after-free Read in ila_nf_input [1]
> 
> Issue here is that ila_xlat_exit_net() frees the rhashtable,
> then call nf_unregister_net_hooks().
> 
> It should be done in the reverse way, with a synchronize_rcu().
> 
> This is a good match for a pre_exit() method.

Indeed, thanks Eric.

Reviewed-by: Florian Westphal <fw@strlen.de>


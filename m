Return-Path: <netdev+bounces-95541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7467C8C28DC
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 18:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15EE31F26646
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 16:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889A010957;
	Fri, 10 May 2024 16:41:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B6D14006
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715359316; cv=none; b=Lrap1Bc+EtHUZ4o9mEccBCa/XVN7ZnYjAX3m+PSjEcXUvjq3R5V0Gr9xyqm4yKfNyhjD1zGd3XP2Wrn9FJXp0ojUHKayWrUVUK4ZT9tONNzthX5QKScyBGB9to/HKwYQWUqrhOa3YXoqN8qvLGPjmYf/w+EZrSy1piu45JIfJ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715359316; c=relaxed/simple;
	bh=TL1mo9OGIjXEk00GsdCfLWlM1bmLoLRO3D6dT2Nxt4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdMLUrxCsZPS9cFvL8qiUrOLBO8Syeg9ovHSAL+T59rI3zJE2+d/l0vzVjdCZP7EMFk5NT8cEYASoVrBuK+4ntWlwNetnrr70fAossKyMD6fmFT4r5nY+DOMHeNFMeKBZC/mRRtt/e/TkahjCz69pvIZodV7AKSJoYycL+CsTNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1s5TJb-0000Jc-I1; Fri, 10 May 2024 18:41:47 +0200
Date: Fri, 10 May 2024 18:41:47 +0200
From: Florian Westphal <fw@strlen.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Westphal <fw@strlen.de>, Simon Horman <horms@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jaehee Park <jhpark1013@gmail.com>, Petr Machata <petrm@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>, netdev@vger.kernel.org
Subject: Re: [TEST] Flake report
Message-ID: <20240510164147.GE16079@breakpoint.cc>
References: <20240509160958.2987ef50@kernel.org>
 <20240510083551.GB16079@breakpoint.cc>
 <20240510074716.1bbb8de8@kernel.org>
 <20240510090336.54180074@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510090336.54180074@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Jakub Kicinski <kuba@kernel.org> wrote:
> M. Looks like that didn't do anything.
> 
> I tried to investigate nft_audit.sh
> 
> https://netdev-3.bots.linux.dev/vmksft-nf/results/589221/22-nft-audit-sh/stdout
> 
>   # selftests: net/netfilter: nft_audit.sh
>   # SKIP: nft reset feature test failed: nftables v1.0.9 (Old Doc Yak #3)
>   ok 1 selftests: net/netfilter: nft_audit.sh # SKIP
>
> This is what it hits:
> 
>   bash-5.2# nft -v
>   nftables v1.0.9 (Old Doc Yak #3)
>   bash-5.2# nft --check -f /dev/stdin <<EOF
>   add table t
>   add chain t c
>   reset rules t c
>   EOF
>   /dev/stdin:3:7-11: Error: syntax error, unexpected string, expecting counter or counters or quotas or quota
>   reset rules t c
>         ^^^^^
> 
> What does that mean in lay terms? 

This nft version chokes on syntax, but I cannot reproduce this:
src/nft --check -f /dev/stdin <<EOF
add table t
add chain t c
reset rules t c
EOF
echo $?
table ip t {
	chain c { }
}
0
src/nft --version
nftables v1.0.9 (Old Doc Yak #3)

No idea :-(

I tried building both recent nftables.git and v1.0.9 tag and both
parse the test file for me :-(

Also. nft-flowtable.sh is still not working on nf infra even
with the updated version while that script works fine locally for me
as well, even with running via vng.

Maybe there is an old libnftables on the system that is used
instead for parsing?  Its bundled/installed with nftables, can
you check that ldd nft doesnt show some other distro-installed
version?  Other than that I have no idea what could be happening here.

> Question #2, for the ebtables test - do I need to build iptables?
> I built nft with
> 	./configure --with-json --with-xtables 

You need to add --enable-nftables for ebtables-nft, or you need to
use the old ebtables tree, i.e.:
https://git.netfilter.org/ebtables/

both should work.


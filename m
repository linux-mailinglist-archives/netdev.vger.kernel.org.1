Return-Path: <netdev+bounces-127046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1526973D19
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 18:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78BAA1F26686
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 16:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90532192D99;
	Tue, 10 Sep 2024 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ielbQacs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656D5192B78;
	Tue, 10 Sep 2024 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985309; cv=none; b=Idl3GZ8VZwNzX5E+dSwzVT+RTGwMh/0VpVJyQiSddCJUEcMU3qjQzJgzfIVaJJh2WxI8h80XPBTraKRPndqTZijgK3X25X9JgmfZDPD9BHUeayDYE9Ber0kVkvVXETw3byhNzYwQnsITooNp0b8dsWxmZ56oyCTnDxz4lH1Tb+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985309; c=relaxed/simple;
	bh=U34K8OBr4BeabMcAREXxo1SJ31qpjS+PHZwzWtMf8Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSfASCy9VdkpIR/75XWLB6+J6XyyxcWwx46JrSblce/ovJviP8r9AykDqkW0KNe0gPPMdMxIyg4YFN1PTs05dszp2H5CIGlUIuAwmp284CA9HIGuWO00VNML9kN/MbVgLhtG7vqbz/qkU8R179ibMR0I7MpELrZeV7I7mjm+nHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ielbQacs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A099BC4CEC3;
	Tue, 10 Sep 2024 16:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725985309;
	bh=U34K8OBr4BeabMcAREXxo1SJ31qpjS+PHZwzWtMf8Zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ielbQacs0Rl1+ElCAhz0jFrlm5ZeEAqsaNDlxzMmKOYsHnBu/BYrZFsbO/1wgaCKO
	 shz67vxeg/NiioWGaAIaWR8eA00eqYONmbGDPSxqFvkfMVPjWsJwgGjLV4zYOYxAaj
	 5Oses1tGscUsSuh8CyVGOYecpMDkfn2fyDWjDN44ieAwsUH0uwRcq29JDBu3iwsuS/
	 F9DXCj4eWh3br15tLYCfcrOsJcsWwL65hMOjekaARAY6R1mwDDOXcpjCSsDyDSUKC1
	 K690E5sbo9u8wGXnCY2kLFvaGd6UTWlPVWlFVv7fc8kjNZvjsv7laJYPGK/dCy6Pl+
	 IG7l5NO9m+t3A==
Date: Tue, 10 Sep 2024 09:21:47 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH ipsec-next v2] xfrm: policy: Restore dir assignments in
 xfrm_hash_rebuild()
Message-ID: <20240910162147.GA117481@thelio-3990X>
References: <20240829-xfrm-restore-dir-assign-xfrm_hash_rebuild-v2-1-1cf8958f6e8e@kernel.org>
 <20240909150934.GA1111756@thelio-3990X>
 <Zt/qX2RoOWSkTwOF@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt/qX2RoOWSkTwOF@gauss3.secunet.de>

On Tue, Sep 10, 2024 at 08:42:39AM +0200, Steffen Klassert wrote:
> On Mon, Sep 09, 2024 at 08:09:34AM -0700, Nathan Chancellor wrote:
> > Ping? This is still seen on next-20240909.
> 
> Sorry, there was some delay due to travelling on my side.

No worries, just wanted to make sure it did not get lost in the rush up
to the merge window :)

> This is now applied to ipsec-next, thanks Nathan!

Thanks a lot!

Cheers,
Nathan


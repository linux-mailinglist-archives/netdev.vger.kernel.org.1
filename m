Return-Path: <netdev+bounces-162633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E294A27708
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E69188368D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE1A214A60;
	Tue,  4 Feb 2025 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8MGLWjb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38357188583
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738686070; cv=none; b=YN8scPbZjhSWIOflLaTuviOyPBmvSDJ+dgZ/O7ej21EcedtTp/HI+rnxezFKq1EFqwmbj/cba0VNsQrrwZ6Yjrqo3wUxE9sL9F/j5Oeq6xT87nMOh2G3FjEwkRYeb4yKXjTd1aQqxvr1SoriSb5H3kN7JmfxnfPRF0BTBlDk2hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738686070; c=relaxed/simple;
	bh=Dfl2j0lToxKOn7p9JvN1Z6+sjFYI6tccUPO599i6wbE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GaIyvIoWAvCk8J6qvkPb9hMcmghhXtgCeFa4XrakPKkpyqJ28Xw0H7HyFGivgsUo8wLybH8aO/TYvNE4hil2WeFFmCAJ0Fs5gbywWlOurOGPMgDWsCFEzGFdZvXaZR8CnVoEKemNoGAbtQglDAyy/1newB1kvyDtKEfdoz11gsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8MGLWjb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA4BC4CEDF;
	Tue,  4 Feb 2025 16:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738686069;
	bh=Dfl2j0lToxKOn7p9JvN1Z6+sjFYI6tccUPO599i6wbE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e8MGLWjb4qVShIPiBmfzZcTX6VHb/64jvywiSWf/1n2Ic5eY0Ruv3FJD0lpEbi2p9
	 jRmMdA67ZWujopudGOkY+mpRhUYm4vGNceTv39g92VVPh4+4HZHSHp1Sx0WkOGnljm
	 WW5Zcy+pSkFNCoqRpcOfHvwASMhoE2En6oB0qZ3nRM/VVEYDdo1K80cJTjEE5XOXqF
	 Pj2kKDLMayoRakEJrK/3jEOCoqTsJQ+Oa9jYWxa6FsU8I+uOu2QnUECwlR3t1kvVRJ
	 GISHPitHsQ1nw1h5/ovrzVzhYQysCzwdL9nvKk8s9WcdrBbymatAUdeL+k39YMKH6W
	 vCBD4v+qUfZng==
Date: Tue, 4 Feb 2025 08:21:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Kuniyuki Iwashima
 <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>,
 eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net 09/16] ipv4: icmp: convert to dev_net_rcu()
Message-ID: <20250204082108.678fb8fe@kernel.org>
In-Reply-To: <CANn89iJKeRYZh42MKvqLgLFwCSoti0dbSkreaOMSgmfWXzm-GA@mail.gmail.com>
References: <20250203143046.3029343-1-edumazet@google.com>
	<20250203143046.3029343-10-edumazet@google.com>
	<20250203153633.46ce0337@kernel.org>
	<CANn89i+-Jifwyjhif1jPXcoXU7n2n4Hyk13k7XoTRCeeAJV1uA@mail.gmail.com>
	<CANn89iKfq8LhriwPzzkCACfrPtVz=XXdnsqQFz6ZOFgqJX7ZJA@mail.gmail.com>
	<CANn89iJKeRYZh42MKvqLgLFwCSoti0dbSkreaOMSgmfWXzm-GA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Feb 2025 11:35:46 +0100 Eric Dumazet wrote:
> > > Oops, I thought I ran the tests on the whole series. I missed this one.  
> >
> > BTW, ICMPv6 has the same potential problem, I will amend both cases.  
> 
> I ran again the tests for v3, got an unrelated crash, FYI.

Yes, FWIW that's
https://lore.kernel.org/all/20250129191937.GR1977892@ZenIV/
we have the fix queued up locally in NIPA. Merge windows are fun!


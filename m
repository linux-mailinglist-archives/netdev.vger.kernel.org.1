Return-Path: <netdev+bounces-41955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5A57CC6DD
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 16:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2645E2819BF
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 14:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C258744460;
	Tue, 17 Oct 2023 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0c3nY35"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7513405C8
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 14:58:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555A2C433C8;
	Tue, 17 Oct 2023 14:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697554739;
	bh=26KEUeoSCG0JL5tigZ23JXNLNGRK4NC2boE3JmU/14Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C0c3nY35mX6r0bDtrw7S9/LW2034oEMx8ZEBf1KvE3sm6OehsZArdjNPI3GfmKoZh
	 7kGoTTQ3Y5QiM0TEzKfUNcljQH4ojis7AqVIwSICopXqq9hC/EuHknl2bg8O6c5RuQ
	 4XWpNUMoPuu1KAkRx8a6iJJFqcSnZuMGVWgXaGCsrVD4o9Mh/7uL42kXxH0Q/dXBiD
	 eErSslC6TCefpcKrEvuG+QkxLRRxzgZY5dkr5ahyiXsEq0nkCqWdLdfCB15eoVE9mU
	 FTst0uqZfqEY4aD1YVjsF/1urKzuKqkADfYW3JLYucxzaHjtbSchE+mBjMbdTD4Fz0
	 BY7NeoSxFHKEQ==
Date: Tue, 17 Oct 2023 07:58:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
 <davem@davemloft.net>
Subject: Re: [PATCH net 5/5] selftests: net: add very basic test for netdev
 names and namespaces
Message-ID: <20231017075858.66863311@kernel.org>
In-Reply-To: <73c1dc5b-4add-0db9-0073-7ae8fed0c747@intel.com>
References: <20231016201657.1754763-1-kuba@kernel.org>
	<20231016201657.1754763-6-kuba@kernel.org>
	<73c1dc5b-4add-0db9-0073-7ae8fed0c747@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Oct 2023 13:25:10 +0200 Przemek Kitszel wrote:
> On 10/16/23 22:16, Jakub Kicinski wrote:
> > +fail() {
> > +    if [ ! -z "$1" ]; then  
> 
> s/! -z/-n/

I find ! -z easier to read.
! -z == "not zero", -n == "not??"

> > +	echo "ERROR: $1"
> > +    else
> > +	echo "ERROR: unexpected return code"  
> 
> I see that in some cases unexpected rc is 0, but it's worth printing.
> 
> At the expense of requiring reader to know about default values syntax,
> whole if could become:
>    echo "ERROR: ${1-unexpected return code} (rc=$_)"

SG!

> I didn't do my homework (of checking expectations of selftests
> "framework"), but perhaps errors/diag messages should go to stderr? >&2

Hm, I've never done that but won't hurt!

> > +    fi
> > +    RET_CODE=1
> > +}
> > +
> > +ip netns add $NS
> > +
> > +#
> > +# Test basic move without a rename
> > +#
> > +ip -netns $NS link add name $DEV type dummy || fail
> > +ip -netns $NS link set dev $DEV netns 1 || \  
> 
> \ after ||, |, && is redundant, not sure if it improves readability or not

Roger.

> I like this patch (and the rest of the series), especially for the fact
> how easy it is to test (compared to internals of HW drivers ;) )

Or notification fixes without something more flexible like YNL :(


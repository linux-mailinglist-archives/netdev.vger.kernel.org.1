Return-Path: <netdev+bounces-28658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 655F97802FB
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 03:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780B81C21561
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 01:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2729F395;
	Fri, 18 Aug 2023 01:18:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDAA375
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 01:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB48BC433C7;
	Fri, 18 Aug 2023 01:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692321510;
	bh=saAULgCa4svmukEdxg5rGyB7EbkKtlujQFyUvp+i7Vc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hE1yGyj4I+6f6vKz+CZ5h89FLu76V7zSC7yhRof7OwLqRwXhOn8aS1eBu3nWThRp4
	 BusfNyTPDSmsU+goK4N1xjJAhhGgdMyyXL2iH59ZchVtK1UxgzMy0d/+h9DRVwzQU2
	 HQSPXD9S53phggMCxQRrl0vpZnw4juwtWNmcsDDJkRys5uQx1iyJDvDcjMa3M1rF5N
	 +8cODK2nCP6UH2hl1eakWUQ7MhNxZnJnCOpgZHM3D9bFuQ8TTbuzr+mY1Y8NadUHZB
	 aHNgI8MpHVFoTcoQkhWNJE6GJ4YJ81frQ3ccERlnL/pqY+Fu3dMAyLCqBZ5YDkkvUS
	 +ipsTAyj6tQdw==
Date: Thu, 17 Aug 2023 18:18:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Stanislav Fomichev
 <sdf@google.com>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 06/10] tools/net/ynl: Add support for
 netlink-raw families
Message-ID: <20230817181828.76ac2c11@kernel.org>
In-Reply-To: <m2cyzmhw50.fsf@gmail.com>
References: <20230815194254.89570-1-donald.hunter@gmail.com>
	<20230815194254.89570-7-donald.hunter@gmail.com>
	<20230816082908.1365f287@kernel.org>
	<m2cyzmhw50.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Aug 2023 10:10:35 +0100 Donald Hunter wrote:
> > Looks good, but do we also need some extra plumbing to decode extack
> > for classic netlink correctly?  Basically shouldn't _decode_extack()
> > also move to proto? Or we can parameterize it? All we really need there
> > is to teach it how much of fixed headers parser needs to skip to get to
> > attributes, really (which, BTW is already kinda buggy for genl families
> > with fixed headers).  
> 
> I have been working on the assumption that extack responses don't
> include any fixed headers. I have seen extack messages decoded correctly
> for classic netlink, here with RTM_NEWROUTE:
> 
> lib.ynl.NlError: Netlink error: Invalid argument
> nl_len = 80 (64) nl_flags = 0x300 nl_type = 2
>   error: -22  extack: {'msg': 'Invalid prefix for given prefix length'}
> 
> Is there something I am missing?

I'm thinking of extack messages carrying offsets in addition to the 
textual error message. NLMSGERR_ATTR_OFFS or NLMSGERR_ATTR_MISS_NEST.

In that case ynl will try to re-parse its own message via
_decode_extack_path() to resolve from the offset to what attribute
was there. See the commit message on a552bfa16:

    lib.ynl.NlError: Netlink error: Numerical result out of range
    nl_len = 108 (92) nl_flags = 0x300 nl_type = 2
            error: -34      extack: {'msg': 'integer out of range',...
                                     'bad-attr': '.ifindex'}

I mean the "bad-attr" thing.

I think it works out of sheer luck here, we happen to skip over 
the fixed header because it looks like a 0-length attribute?


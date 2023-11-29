Return-Path: <netdev+bounces-52223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47447FDED6
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 18:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D881C20986
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 17:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F2859149;
	Wed, 29 Nov 2023 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIyfzKp/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F451B296;
	Wed, 29 Nov 2023 17:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15191C433C7;
	Wed, 29 Nov 2023 17:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701280184;
	bh=Vv2kg7tUugR+HRvGHfArl3hiwfBQKgqlPjyZTkGiqMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vIyfzKp/JUZx7ipcA63+BeDgfzWutCphqYFFS4V5ds5KbiDdmM6s/LvIAVXc14eIS
	 5+q/A4IGl8R+xzaEuA3r5I6mzTgAboszbNeACRdFL2F8+OUIF/Ib/yCmxpGZ8PsVTL
	 hQB0f1HptdILOjdbcEmfrqs61iFCL6QhS5bOlvAdDBOdXDazGUPLIeaz8JkBPP6XNq
	 8VSSx8GSN4YqyIuhk+OZB170LdlcfvM6Y43NUPD8dM2KaPKTB0iCbGxvnPqgjNKKkf
	 zBoE7FeM4EeFKkNosnPs+wC7XSOtFZHRpbgpF2fDqKVHeEgs8VPGWRgZemieJupDf1
	 mCSz1Y6958E3A==
Date: Wed, 29 Nov 2023 09:49:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 donald.hunter@redhat.com
Subject: Re: [RFC PATCH net-next v1 0/6] tools/net/ynl: Add dynamic selector
 for options attrs
Message-ID: <20231129094943.13f1ae0c@kernel.org>
In-Reply-To: <m2bkbc8pim.fsf@gmail.com>
References: <20231129101159.99197-1-donald.hunter@gmail.com>
	<20231129080943.01d81902@kernel.org>
	<m2bkbc8pim.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Nov 2023 16:58:57 +0000 Donald Hunter wrote:
> rt_link shares attribute-sets between different kinds of link so I think
> that rules out putting the key on the attribute-set. I think we may also
> see reuse across stats attribute sets in tc.
> 
> FWIW I initially considered avoiding a selector list by using a template
> to generate the attribute set name, but that broke pretty quickly.

Ah :(

> It seems reasonable to pull the selector list out of line because
> they do get big, e.g. over 100 lines for tc "options".
> 
> My preference is 1, probably including a fallback to "binary" if there
> is no selector match.

Are there any "nests" that need a real binary type? An actual byte
array? Or are these all structs? If the latter then fixed-header
covers it.

> I think that once you have broken out to a sub-message, they're no
> longer "nested-attributes" and we should maybe reuse "attribute-set".

Good point.

> I don't think we can reuse "sub-type" because the schema for it is the
> set of netlink type names, not a free string. Maybe we add "sub-message"
> instead?

Sounds good.

> So how about this:
> 
> attribute-sets:
>   -
>     name: outside-attrs
>     attributes:
>       ...
>       -
>          name: kind
>          type: string
>       -
>          name: options
>          type: sub-message
>          sub-message: inside-msg
>          selector: kind
>     ...
>   -
>     name: inside-attrs:
>     attributes:
>       ...
> 
> sub-messages:
>   -
>     name: inside-msg
>     formats:
>       -
>         value: some-value
>         fixed-header: struct-name
>       -
>         value: other-value
>         fixed-header: struct-name-two
>         attribute-set: inside-attrs
>       -
>         value: another-one
>         attribute-set: inside-attrs
>   -
>     name: different-inside-msg
>     ...
> 
> operations:
>   ...

LG!

> I cannot think of a better name than "formats" so happy to go with that.

Or maybe "variants" ?

> Did you want an explicit "list:" in the yaml schema?

You mean instead of the "formats" or in addition somewhere?
Under sub-messages?

The "formats" is basically a "list", just feels less artificial
to call it something else than "list". No strong preference, tho.

If you mean under "sub-messages" - I can't think of any extra property
we may want to put there. So going directly to entries seems fine.


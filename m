Return-Path: <netdev+bounces-52181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7964C7FDC3D
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 17:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88C81C20945
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 16:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AE23987D;
	Wed, 29 Nov 2023 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mj/2r65Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608DC14AB9;
	Wed, 29 Nov 2023 16:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8285BC433C7;
	Wed, 29 Nov 2023 16:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701274184;
	bh=2UymZxPUMN0L+YuIw9qnZl0SEIiS8hfvznXni7z7f2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mj/2r65ZWZ86suTXp5alc4ujW2PfMg1qh0aSqSrYgwmmJ/Zb68ExiejnkinqTEkRT
	 6h/O5gl8TbJZLZex5e1o8dLtsLawVKVdIaCrAY8k/DepcXxPP58jJgPputun5mzFbe
	 VO/OD4BaWEv5SyAqgmbVLrdNJE9Nsj9P+ETnJW0rtAxRQ1KI1zi8WhIhWFSbbdNyFT
	 iUcnaBv9wRxUJCK+TuYj990UQAUf2s1xv+7xeAoX5X8J+HG6rlzGYnM6p9+52wW/YG
	 ezaw9ZXy2rItxy2w/FRIJ6MBEb0lVNHOMKn21Yk1kmidYzAD2BPYFp8oXZKkgxWimW
	 LswiyUCYgGIcg==
Date: Wed, 29 Nov 2023 08:09:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 donald.hunter@redhat.com
Subject: Re: [RFC PATCH net-next v1 0/6] tools/net/ynl: Add dynamic selector
 for options attrs
Message-ID: <20231129080943.01d81902@kernel.org>
In-Reply-To: <20231129101159.99197-1-donald.hunter@gmail.com>
References: <20231129101159.99197-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Nov 2023 10:11:53 +0000 Donald Hunter wrote:
> This patchset adds a dynamic selector mechanism to YNL for kind-specific
> options attributes. I am sending this as an RFC solicit feedback on a
> couple of issues before I complete the patchset.

Exciting stuff!
 
> I started adding this feature for the rt_link spec which is monomorphic,
> i.e. the kind-specific 'data' attribute is always a nest. The selector
> looked like this:
> 
>   -
>     name: data
>     type: dynamic
>     selector:
>       attribute: kind
>       list:
>         -
>           value: bridge
>           nested-attributes: linkinfo-bridge-attrs
>         -
>           value: erspan
>           nested-attributes: linkinfo-gre-attrs

It's kinda moot given your discovery below :(, but FWIW this is very
close to what I've been thinking.

After some pondering I thought it'd be better to structure it just
a bit differently:

 -
   name: data
   type: poly-nest
   selector: kind    # which attr carries the key

that's it for the attr, and then in attr-set I'd add a "key":

 -
   name: linkinfo-bridge-attrs
   poly-key: bridge

putting the key on the attr set is worse if we ever need to "key"
the same attr set with different selectors, but it makes the attr
definition a lot smaller. And in practice I didn't expect us
to ever need keying into one attr set with different selectors. 
If we did - we could complicate it later, but start simple.

> Then I started working on tc and found that the 'options' attribute is
> poymorphic. It is typically either a C struct or a nest. So I extended the
> dynamic selector to include a 'type' field and type-specific sub-fields:
> 
>   -
>     name: options
>     type: dynamic
>     selector:
>       attribute: kind
>       list:
>         -
>           value: bfifo
>           type: binary
>           struct: tc-fifo-qopt
>         -
>           value: cake
>           type: nest
>           nested-attributes: tc-cake-attrs
>         -
>           value: cbs
>           type: nest
>           nested-attributes: tc-cbs-attrs
> 
> Then I encountered 'netem' which has a nest with a C struct header. I
> realised that maybe my mental model had been wrong and that all cases
> could be supported by a nest type with an optional fixed-header followed
> by zero or more nlattrs.
> 
>   -
>     value: netem
>     type: nest
>     fixed-header: tc-netem-qopt
>     nested-attributes: tc-netem-attrs
> 
> Perhaps it is attribute-sets in general that should have an optional
> fixed-header, which would also work for fixed-headers at the start of
> genetlink messages. I originally added fixed-header support to
> operations for genetlink, but fixed headers on attribute sets would work
> for all these cases.
> 
> I now see a few possible ways forward and would like feedback on the
> preferred approach:
> 
> 1. Simplify the current patchset to implement fixed-header & nest
>    support in the dynamic selector. This would leave existing
>    fixed-header support for messages unchanged. We could drop the 'type'
>    field.
> 
>    -
>      value: netem
>      fixed-header: tc-netem-qopt
>      nested-attributes: tc-netem-attrs
> 
> 2. Keep the 'type' field and support for the 'binary' type which is
>    useful for specifying nests with unknown attribute spaces. An
>    alternative would be to default to 'binary' behaviour if there is no
>    selector entry.
> 
> 3. Refactor the existing fixed-header support to be an optional part of
>    all attribute sets instead of just messages (in legacy and raw specs)
>    and dynamic attribute nests (in raw specs).
> 
>    attribute-sets:
>      -
>        name: tc-netem-attrs
>        fixed-header: tc-netem-qopt
>        attributes:

Reading this makes me feel like netem wants to be a "sub-message"?
It has a fixed header followed by attrs, that's quite message-like.

Something along the lines of 1 makes most sense to me, but can we
put the "selector ladder" out-of-line? I'm worried that the attr
definition will get crazy long.

attribute-sets:
  -
    name: outside-attrs
    attributes:
      ...
      -
         name: kind
         type: string
      -
         name: options
         type: sub-message
         sub-type: inside-msg  # reuse sub-type or new property?
         selector: kind
    ...
  -
    name: inside-attrs:
    attributes: 
      ...

sub-messages:
  list:
    -
      name: inside-msg
      formats: # not a great name?..
        -
          value: some-value
          fixed-header: struct-name
        -
          value: other-value
          fixed-header: struct-name-two
          nested-attributes: inside-attrs
        -
          value: another-one
          nested-attributes: inside-attrs
    -
      name: different-inside-msg
      ...

operations:
  ...

At least that's what comes to my mind after reading the problem
description. Does it make sense?


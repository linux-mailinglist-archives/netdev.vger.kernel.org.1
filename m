Return-Path: <netdev+bounces-53183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6D48019AB
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 02:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6468F281E45
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 01:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9135B17C4;
	Sat,  2 Dec 2023 01:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLUkjPow"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7050C15A3;
	Sat,  2 Dec 2023 01:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A1DC433C8;
	Sat,  2 Dec 2023 01:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701481995;
	bh=71K0AG7807yL3dO88k+XTdBRlpK2YY5iaZVWFGNpFt0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QLUkjPowUY621Y5727Iv3FK8+XwuK9p9yvcD/hnh6NsnGpjPz1GPL2zTwQHrqKQnl
	 kDURJFengjmqfw5QlgcB9Mvb7DcIooZJeXX6H+uyc2r0ePHNR8RwBc64j70kmvSGwO
	 ldkq+ybL2wFfHzEJFhkquCZXklvqCmngDN5y5cC926+w7aL8C2GIWY9BdYSHkjhu8V
	 59KyqzDl9zGruEk1A3aklxrxHiVmaBsrnEXa0DE64HAvda1jZ8oJZekQz3m+fojQu1
	 fn+noDSbadrgvcP+g3DXl5oqFfHjQ9RcJ23IDi98nn7zNv++1mKfVzZXI46LxU8iTx
	 LA9kVu8YfWQ9Q==
Date: Fri, 1 Dec 2023 17:53:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 2/6] doc/netlink: Add sub-message support to
 netlink-raw
Message-ID: <20231201175314.26cfcefa@kernel.org>
In-Reply-To: <20231130214959.27377-3-donald.hunter@gmail.com>
References: <20231130214959.27377-1-donald.hunter@gmail.com>
	<20231130214959.27377-3-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 21:49:54 +0000 Donald Hunter wrote:
> Add a 'sub-message' attribute type with a selector that supports
> polymorphic attribute formats for raw netlink families like tc.
> 
> A sub-message attribute uses the value of another attribute as a
> selector key to choose the right sub-message format. For example if the
> following attribute has already been decoded:
> 
>   { "kind": "gre" }
> 
> and we encounter the following attribute spec:
> 
>   -
>     name: data
>     type: sub-message
>     sub-message: linkinfo-data-msg
>     selector: kind
> 
> Then we look for a sub-message definition called 'linkinfo-data-msg' and
> use the value of the 'kind' attribute i.e. 'gre' as the key to choose
> the correct format for the sub-message:
> 
>   sub-messages:
>     name: linkinfo-data-msg
>     formats:
>       -
>         value: bridge
>         attribute-set: linkinfo-bridge-attrs
>       -
>         value: gre
>         attribute-set: linkinfo-gre-attrs
>       -
>         value: geneve
>         attribute-set: linkinfo-geneve-attrs
> 
> This would decode the attribute value as a sub-message with the
> attribute-set called 'linkinfo-gre-attrs' as the attribute space.
> 
> A sub-message can have an optional 'fixed-header' followed by zero or
> more attributes from an attribute-set. For example the following
> 'tc-options-msg' sub-message defines message formats that use a mixture
> of fixed-header, attribute-set or both together:
> 
>   sub-messages:
>     -
>       name: tc-options-msg
>       formats:
>         -
>           value: bfifo
>           fixed-header: tc-fifo-qopt
>         -
>           value: cake
>           attribute-set: tc-cake-attrs
>         -
>           value: netem
>           fixed-header: tc-netem-qopt
>           attribute-set: tc-netem-attrs

SGTM, could you add all the info from the commit message somewhere 
in the documentation? Perhaps a new section at the end of
Documentation/userspace-api/netlink/specs.rst

> @@ -261,6 +262,17 @@ properties:
>                  description: Name of the struct type used for the attribute.
>                  type: string
>                # End genetlink-legacy
> +              # Start netlink-raw
> +              sub-message:
> +                description:
> +                  Name of the sub-message definition to use for the attribute.
> +                type: string
> +              selector:
> +                description:
> +                  Name of the attribute to use for dynamic selection of sub-message
> +                  format specifier.
> +                type: string

We can leave it for later either way, but have you seen any selectors
which would key on an integer, rather than a string?


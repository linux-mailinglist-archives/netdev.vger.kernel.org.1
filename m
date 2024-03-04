Return-Path: <netdev+bounces-77166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F05870558
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13839B220E7
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBCE47A6A;
	Mon,  4 Mar 2024 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tz9X1JQ3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5826E47A62
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709565753; cv=none; b=m2xKq0BIWWKn7aIdt1SRuUVH6iUUb6hap1J0vw88t7G9eppxY9h5FDh1auG/EhR5kw1XuOljgj8TPLS11cLoPAyctmdWMV+DqOMQDSEQ07RuY606WQdIpSVWp4xzEwbWROCojPCB+vR54R1hDt4GhtQV+FrF9A9lo9ehfmfpI/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709565753; c=relaxed/simple;
	bh=gLmLq9sNx9n01ZeImLh1aWQi0KnY0rkk/qUTDy1Ph+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/zJGDJ/pr8cM+Tsz3PQDMq/5zO7sax/TrejwdgJ5iqI6jxPz5ExXdvGnMaLDQufIkJ/IhNhggdlAKerz/xjvRVkKnchQdk5zTVoCfnz3B48R6viOpF0XlBvOPgaIaO4YGerRlsFQIvkiKlP0kR5JWW1IHaFglMPNJAw1cKLKkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tz9X1JQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5316C433F1;
	Mon,  4 Mar 2024 15:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709565753;
	bh=gLmLq9sNx9n01ZeImLh1aWQi0KnY0rkk/qUTDy1Ph+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tz9X1JQ3NKqZB3dTgARz/mc5cFmRskOHjPi34jJAn8O/V7cXrd2Wq6ekM9/bZerHc
	 RNkv2Wmt/vBFx1yTMBFIHmS5rb9MrePyNEH8k8uf7DoF8URmle6mh0hK2KX0BxEU4C
	 uPgA+9bP5b6XBOakkjXi/EFBD4NKNBS+VPu2hMK6+GOtFwTplm+QdweT2y1U2Xl2Rw
	 e7sdFEzPGv0P90mC7Z1wIFFO5II7R68o5QKtw+XbLIb9/V43qgAiieTwiEE7aObvo+
	 mHDv0UrzfOHQRq7uQ292rRyJw0jXvMKjzc4i+db9pdTqcoG1aVsw0VMPrynzO+g8ww
	 iZPA9WVp0EObw==
Date: Mon, 4 Mar 2024 07:22:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jacob
 Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, Stanislav
 Fomichev <sdf@google.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 3/4] tools/net/ynl: Extend array-nest for
 multi level nesting
Message-ID: <20240304072231.6f21159e@kernel.org>
In-Reply-To: <CAD4GDZwHXNM++G3xDgD_xFk1mHgxr+Bw35uJuDFG+iOchynPqw@mail.gmail.com>
References: <20240301171431.65892-1-donald.hunter@gmail.com>
	<20240301171431.65892-4-donald.hunter@gmail.com>
	<20240302200536.511a5078@kernel.org>
	<CAD4GDZwHXNM++G3xDgD_xFk1mHgxr+Bw35uJuDFG+iOchynPqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 3 Mar 2024 10:50:09 +0000 Donald Hunter wrote:
> On Sun, 3 Mar 2024 at 04:05, Jakub Kicinski <kuba@kernel.org> wrote:
> > On Fri,  1 Mar 2024 17:14:30 +0000 Donald Hunter wrote:  
> > > The nlctrl family uses 2 levels of array nesting for policy attributes.
> > > Add a 'nest-depth' property to genetlink-legacy and extend ynl to use
> > > it.  
> >
> > Hm, I'm 90% sure we don't need this... because nlctrl is basically what
> > the legacy level was written for, initially. The spec itself wasn't
> > sent, because the C codegen for it was quite painful. And the Python
> > CLI was an afterthought.
> >
> > Could you describe what nesting you're trying to cover here?
> > Isn't it a type-value?  
> 
> I added it for getpolicy which is indexed by policy_idx and attr_idx.
> 
> ./tools/net/ynl/cli.py \
>     --spec Documentation/netlink/specs/nlctrl.yaml \
>     --dump getpolicy --json '{"family-name": "nlctrl"}'
> [{'family-id': 16, 'op-policy': [{3: {'do': 0, 'dump': 0}}]},
>  {'family-id': 16, 'op-policy': [{0: {'dump': 1}}]},
>  {'family-id': 16,
>   'policy': [{0: [{1: {'max-value-u': 65535,
>                        'min-value-u': 0,
>                        'type': 'u16'}}]}]},
>  {'family-id': 16,
>   'policy': [{0: [{2: {'max-length': 15, 'type': 'nul-string'}}]}]},
>  {'family-id': 16,
>   'policy': [{1: [{1: {'max-value-u': 65535,
>                        'min-value-u': 0,
>                        'type': 'u16'}}]}]},
>  {'family-id': 16,
>   'policy': [{1: [{2: {'max-length': 15, 'type': 'nul-string'}}]}]},
>  {'family-id': 16,
>   'policy': [{1: [{10: {'max-value-u': 4294967295,
>                         'min-value-u': 0,
>                         'type': 'u32'}}]}]}]

Yeah.. look at the example I used for type-value :)

https://docs.kernel.org/next/userspace-api/netlink/genetlink-legacy.html#type-value

> > BTW we'll also need to deal with the C codegen situation somehow.
> > Try making it work, if it's not a simple matter of fixing up the
> > names to match the header - we can grep nlctrl out in the Makefile.  
> 
> Yeah, I forgot to check codegen but saw the failures on patchwork. I
> have fixed the names but still have a couple more things to fix.
> 
> BTW, this patchset was a step towards experimenting with removing the
> hard-coded msg decoding in the Python library. Not so much for
> genetlink families, more for the extack decoding so that I could add
> policy attr decoding. Thinking about it some more, that might be
> better done with a "core" spec that contains just extack-attrs and
> policy-attrs because they don't belong to any single family - they're
> kinda infrastructure for all families.

YAML specs describe information on how to parse data YNL doesn't have
to understand, just format correctly. The base level of netlink
processing, applicable to all families, is a different story.
I think hand-coding that is more than okay. The goal is not to express
everything in YAML but to avoid duplicated work per family, if that
makes sense.


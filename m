Return-Path: <netdev+bounces-41977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5913C7CC800
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 17:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9116D1C20AB0
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 15:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1905450F1;
	Tue, 17 Oct 2023 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieCl5oaD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11F4450EC
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 15:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1372DC433CA;
	Tue, 17 Oct 2023 15:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697557854;
	bh=tpaDDi5AOX5s2f2Vf6+2CZRZFhSqTVVlwCWOfzHW5xo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ieCl5oaDAxZkxOYtHjwg/niu8JeeJEiIRgxDpG6oSFZG8E8/JhCDzqPpslpyNt+cL
	 2W5ZdJHtl7mDcg6WzQWGyd2vyDCEaa2Xu7vqs5nh+oKZyiB61LEJLDc6WxaOlQ8pVs
	 L3joF9M+eS/bmroCblOlYZsUEfX+f3sasypbImnrvGuTeLLyZrYKOnOS3aapryxYQV
	 mQsyCxke2Nu+J2tstXiJlo4fLdV3xMHwWrNUGb9TLg7tWEmml8zUe2/Iwh2ANPSbTq
	 5Eg2SueR6V5AAR5kqlLKzgCW0YCsVde28cRYiRacNQJFVMxo15FDX6pw5YpZquNpS7
	 ekTzYIA5fEbNw==
Date: Tue, 17 Oct 2023 08:50:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com
Subject: Re: [patch net-next v2] tools: ynl: introduce option to process
 unknown attributes or types
Message-ID: <20231017085053.63d4af40@kernel.org>
In-Reply-To: <ZS4nJeM+Svk+WUq+@nanopsycho>
References: <20231016110222.465453-1-jiri@resnulli.us>
	<20231016175903.605f61aa@kernel.org>
	<ZS4nJeM+Svk+WUq+@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Oct 2023 08:18:13 +0200 Jiri Pirko wrote:
> Tue, Oct 17, 2023 at 02:59:03AM CEST, kuba@kernel.org wrote:
> >On Mon, 16 Oct 2023 13:02:22 +0200 Jiri Pirko wrote:  
> >> +class FakeSpecAttr:
> >> +    def __init__(self, name):
> >> +        self.dict = {"name": name, "type": None}
> >> +        self.is_multi = False
> >> +
> >> +    def __getitem__(self, key):
> >> +        return self.dict[key]
> >> +
> >> +    def __contains__(self, key):
> >> +        return key in self.dict  
> >
> >Why the new class? Why not attach the NlAttr object directly?  
> 
> It's not NlAttr, it's SpecAttr. And that has a constructor with things I
> cannot provide for fake object, that's why I did this dummy object.

Just to be able to do spec["type"] on it?

There is an if "ladder", just replace the first

	if attr_spec["type"] == ...

with
	if attr_spec is None:
		# your code
	elif attr_spec["type"] == ...

hm?

> >I have an idea knocking about in my head to support "polymorphic"
> >nests (nests where decoding depends on value of another attr,
> >link rtnl link attrs or tc object attrs). The way I'm thinking 
> >about doing it is to return NlAttr / struct nla_attr back to the user.
> >And let the users call a sub-parser of choice by hand.  
> 
> Sounds parallel to this patch, isn't it?

I'm just giving you extra info to explain my thinking.
Given how we struggle to understand each other lately :S

> >So returning a raw NlAttr appeals to me more.  
> 
> Wait, you suggest not to print out attr.as_bin(), but something else?

Yea, it should not be needed. NlAttr has a __repr__ which *I think*
should basically do the same thing? Or you may need to call that
__repr__ from __str__, I don't know what PrettyPrinter uses internally

> >> +                if not self.process_unknown:
> >> +                    raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
> >> +                if attr._type & Netlink.NLA_F_NESTED:
> >> +                    subdict = self._decode(NlAttrs(attr.raw), None)
> >> +                    decoded = subdict
> >> +                else:
> >> +                    decoded = attr.as_bin()  
> >
> >Again, I wouldn't descend at all.  
> 
> I don't care that much. I just thought it might be handy for the user to
> understand the topology. Actually, I found it quite convenient already.
> It's basically a direct dump. What is the reason not to do this exactly?

No strong reason but you need to rewrite it to at least not access
attr._type directly.

I have a weak preference for putting this code in NlAttr's __repr__,
could be more broadly useful?


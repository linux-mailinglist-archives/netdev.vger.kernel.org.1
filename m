Return-Path: <netdev+bounces-66244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA9383E1F0
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 19:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0211F294FC
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 18:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E59200D2;
	Fri, 26 Jan 2024 18:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ql0q4xCS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BA11DFF9;
	Fri, 26 Jan 2024 18:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706295057; cv=none; b=Oa/ppsVVlTgeR5CVn/yHyUpA3M68qjQPjtkxy0CFqepxNsdgrZFBD8o68tSAJ/qKUO7B8ElMZa6enmCboJ+LOfwQ4NwedzubxhqKYKdz4bEU1f140V9Fm7gH5L12WZPEJrpyy6QV/rXD8PPG49RM1TG3wvVc8Z6PLtqW6GFQ6Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706295057; c=relaxed/simple;
	bh=1fIdBK9itM3esz+45anwZiUUi0Nm9BupJFdH2OcnKHU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UtkPXcfwhEKR3HntOebqcEtjPjfNY3fBzCgQeNCjaMJB1gQq8Up97aGz62aZW/xrlPwGIPOVYJGPOY2mI154Q+h3RlXqDTXydp0GKv3HZB82RJa3cQ18xYt0ynhrjMG/TXP0R5KecQc/yY79zU9an/q3ur+rsgiS5HlHczxhDaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ql0q4xCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F693C433C7;
	Fri, 26 Jan 2024 18:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706295056;
	bh=1fIdBK9itM3esz+45anwZiUUi0Nm9BupJFdH2OcnKHU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ql0q4xCSd1ECPT731kwD6UN7mZUKOpqjZ7zO3iAjguXCltnjpZWbQBOA0J79QTExM
	 r9QBbNNd8mmv1dv+g05gn7DdsbpQgHhP+ceUtPxzSV2f6vR3cjOtx2iJz/kBOjHs6+
	 cD41f/oFoaaZKlwZnT3gDAUy+ErAzIFthD4wIa1i9ptLivBbhaovq6HB8KP7JvLffS
	 9AHnsjStXi3qIoiVG4OWvx3K8fLcpWsqldBqyfYzrF8GkY5PqCQQLa/Air4W8nNEo1
	 IbEEJMw7JmmcHwLt4cv833YDcRy3a3WxHNPl/g5NXBRAP570pgWRYnbXPui+1kxOfS
	 d70P3pJKCLrWw==
Date: Fri, 26 Jan 2024 10:50:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, Breno Leitao <leitao@debian.org>, Jiri Pirko
 <jiri@resnulli.us>, Alessandro Marcolini <alessandromarcolini99@gmail.com>,
 donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 02/12] tools/net/ynl: Support sub-messages
 in nested attribute spaces
Message-ID: <20240126105055.2200dc36@kernel.org>
In-Reply-To: <m2ttn0w9fa.fsf@gmail.com>
References: <20240123160538.172-1-donald.hunter@gmail.com>
	<20240123160538.172-3-donald.hunter@gmail.com>
	<20240123161804.3573953d@kernel.org>
	<m2ede7xeas.fsf@gmail.com>
	<20240124073228.0e939e5c@kernel.org>
	<m2ttn0w9fa.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 12:44:57 +0000 Donald Hunter wrote:
> I was quite pleased with how simple the patch turned out to be when I
> used ChainMap, but it does have this weakness.

It is very neat, no question about it :(

> In practice, the only place this could be a problem is with
> tc-act-attrs which has the same attribute name 'kind' in the nest and
> in tc-attrs at the top level. If you send a create message with ynl,
> you could omit the 'kind' attr in the 'act' nest and ynl would
> incorrectly resolve to the top level 'kind'. The kernel would reject
> the action with a missing 'kind' but the rest of payload would be
> encoded wrongly and/or could break ynl.

We can detect the problem post-fact and throw an exception. I primarily
care about removing the ambiguity.

Is it possible to check at which "level" of the chainmap the key was
found? If so we can also construct a 'chainmap of attr sets' and make
sure that the key level == attr set level. I.e. that we got a hit at
the first level which declares a key of that name.

More crude option - we could construct a list of dicts (the levels
within the chainmap) and keys they can't contain. Once we got a hit 
for a sub-message key at level A, all dicts currently on top of A
are not allowed to add that key. Once we're done with the message we
scan thru the list and make sure the keys haven't appeared?

Another random thought, should we mark the keys which can "descend"
somehow? IDK, put a ~ in front?

	selector: ~kind

or some other char?

> My initial thought is that this might be better handled as input
> validation, e.g. adding 'required: true' to the spec for 'act/kind'.
> After using ynl for a while, I think it would help to specify required
> attributes for messages, nests and sub-messsages. It's very hard to
> discover the required attributes for families that don't provide
> extack responses for errors.

Hah, required attrs. I have been sitting on patches for the kernel for
over a year - https://github.com/kuba-moo/linux/tree/req-args
Not sure if they actually work but for the kernel I was curious if it's
possible to do the validation in constant time (in relation to the
policy size, i.e. without scanning the entire policy at the end to
confirm that all required attrs are present). And that's what I came up
with.

I haven't posted it because I was a tiny bit worried that required args
will cause bugs (people forgetting to null check attrs) and may cause
uAPI breakage down the line (we should clearly state that "required"
status is just advisory, and can go away in future kernel release).
But that was more of a on-the-fence situation. If you find them useful
feel free to move forward!

I do think that's a separate story, tho. For sub-message selector
- isn't the key _implicitly_ required, in the first attr set where 
it is defined? Conversely if the sub-message isn't present the key
isn't required any more either?


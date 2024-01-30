Return-Path: <netdev+bounces-66939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6807F84188A
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 02:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07E37B20BF5
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 01:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D57374FD;
	Tue, 30 Jan 2024 01:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPZvMqNn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF520374EF;
	Tue, 30 Jan 2024 01:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578943; cv=none; b=VGHvFxXlNtGO9kuhNGYACLL4HCeFzVU1Hp1lOda5mo5J3U/ZoVUwE6q/FDI/DvtQOtACaGRhOcD9PLpjEB+qMI1qPuJJILOTAPwUxrbU8Xw730QeFs7Hm5Q5wFWYpS6qle/i3/uZs6D+NLUw+QUNxvwKdz6rOSwyOjWMkbeRmiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578943; c=relaxed/simple;
	bh=/JzcwD8NzWMj0SpZAO4WH/f9dgEUodb/EmnczVGCy24=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rd0SvILyiKpDZHLUh2StIawHW6S+JmrLfdO6enUk+Dj/HOs7jQv6fb1Yw0ls/DpeT6h1f/JhECZuCsh2LrEq+GNsE3JxUlkEvME7sS5KK16Q0KFiukENyyRPjw30JfpY+U5NT9OqAMBMz5uSte/UrLlJSda6r3VN/NZEtHUHs94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPZvMqNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4476C43394;
	Tue, 30 Jan 2024 01:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706578942;
	bh=/JzcwD8NzWMj0SpZAO4WH/f9dgEUodb/EmnczVGCy24=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JPZvMqNnsXWET+l7E5ijxQxPfLTh5YyE3Le3yplmTJwBmFJY21GDClgoZecpbqqY/
	 J+ANxNnd8cSwedsh4xxbqUeM8q6SP68h9z/tTfAvrIguFNeD2nIFXn/zkzJhL6epmO
	 BB4kEhVn3FMmimApvUuBcCyMZoqv5a/8xFRDXLvF4DP5xBvcH74SRH0SCbVzrpxcwm
	 NSB+QJHWvzXYtmHU001bod/QcbCD3+a5Ay3WBZWByC04HrjldaQGNw2FnFt9THAaAH
	 U2auUQXx13gwxeuPpz/aLkCw9Mic428v3D+ImPxMYAY2P9NjRcRTcJstWRP9PkTZTb
	 dQQCte+nypHAw==
Date: Mon, 29 Jan 2024 17:42:20 -0800
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
Message-ID: <20240129174220.65ac1755@kernel.org>
In-Reply-To: <m2jznuwv7g.fsf@gmail.com>
References: <20240123160538.172-1-donald.hunter@gmail.com>
	<20240123160538.172-3-donald.hunter@gmail.com>
	<20240123161804.3573953d@kernel.org>
	<m2ede7xeas.fsf@gmail.com>
	<20240124073228.0e939e5c@kernel.org>
	<m2ttn0w9fa.fsf@gmail.com>
	<20240126105055.2200dc36@kernel.org>
	<m2jznuwv7g.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jan 2024 17:18:59 +0000 Donald Hunter wrote:
> > Hah, required attrs. I have been sitting on patches for the kernel for
> > over a year - https://github.com/kuba-moo/linux/tree/req-args
> > Not sure if they actually work but for the kernel I was curious if it's
> > possible to do the validation in constant time (in relation to the
> > policy size, i.e. without scanning the entire policy at the end to
> > confirm that all required attrs are present). And that's what I came up
> > with.  
> 
> Interesting. It's definitely a thorny problem with varying sets of
> 'required' attributes. It could be useful to report the absolutely
> required attributes in policy responses, without any actual enforcement.
> Would it be possible to report policy for legacy netlink-raw families?

It's a simple matter of plumbing. We care reuse the genetlink policy
dumping, just need to add a new attr to make "classic" family IDs
distinct from genetlink ones.

The policy vs spec is another interesting question. When I started
thinking about YNL my intuition was to extend policies to carry all
relevant info. But the more I thought about it the less sense it made.

Whether YNL specs should replace policy dumps completely (by building
the YAML into the kernel, and exposing via sysfs like kheaders or btf)
 - I'm not sure. I think I used policy dumps twice in my life. They
are not all that useful, IMVHO...

> Thinking about it, usability would probably be most improved by adding
> extack messages to more of the tc error paths.

TC was one of the first netlink families, so we shouldn't judge it too
harshly. With that preface - it should only be used as "lessons learned"
not to inform modern designs.


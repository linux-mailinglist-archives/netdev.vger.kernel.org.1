Return-Path: <netdev+bounces-83467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D07C889264F
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 22:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8739C1F228A7
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 21:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A40D13BC09;
	Fri, 29 Mar 2024 21:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI+U+9iL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA80785926
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 21:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748801; cv=none; b=hLKYXnQEay5o+2wB5f0ryqS+rZ4ZW/pWleHMXwjhbqTEO9laLXYaP0C6ZTYGVrNw+Tt5OVQ/RQaNUat82Rt+EhBBWWqzcvErd7KDsFj0u4E1bDi1tepghJvI1eyyM+7gjw9B2Jl5hWUWRNj3KHwymj9hNAeWQKdXyYcIelmzd6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748801; c=relaxed/simple;
	bh=WYrLnd5VJ+w8tGoOoxXgy3WX373NxHkTc+nBr5+yjG4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Da0PmiKj4OjIEt8CupTNYdDoBOgmm/fmvFKxeKWlbCItOgbA0gtxxxkd4hPTd3TIzWfN6pUedIOpwdyyZE0XgLyjFKerPpbHIyQsmI5+UNZ2pzKJU7SOGYeO/z+jep+WWfr4R1gtnmwquWEj0SLan7cV63m1nEY70J0ZSUYgjHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bI+U+9iL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BAFCC433C7;
	Fri, 29 Mar 2024 21:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711748800;
	bh=WYrLnd5VJ+w8tGoOoxXgy3WX373NxHkTc+nBr5+yjG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bI+U+9iL3hiAq1i9X3EfgmszunTmib3XIbrxUXRflu3eiFNobwQTe80Nf79MnqiG8
	 t3e98Rgu7Jq4Mk3ZE4Fdq4v43fw9On7zw5k3qEWPs63RVIGvHxkkIqzruRT0wC46jl
	 9q2y63dRk0GsdQxnFxFqQ44B8lisQgn22oS7gpVRPtSnINNdrbZMtXLzpz7n7rYzER
	 WwmL/vzkFrdHEj9I9WpPRcCiHv3J4pPbcwn/oyA4gO058KPdy3NpRp992LZOHjmd3M
	 ax2/pQcD7XZi71fGhCFm+oewMT3YFpCaojmdBqcEOVTku7zALR43tPlo8iANKnkNbS
	 495lKCzcWHj0w==
Date: Fri, 29 Mar 2024 14:46:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>, Pablo Neira Ayuso
 <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Jacob Keller <jacob.e.keller@intel.com>, Stanislav
 Fomichev <sdf@google.com>, donald.hunter@redhat.com, fw@strlen.de
Subject: Re: [PATCH net-next v1 2/2] tools/net/ynl: Add multi message
 support to ynl
Message-ID: <20240329144639.0b42dc19@kernel.org>
In-Reply-To: <CAD4GDZw0RW3B2n5vC-q-XLpQ_bCg0iP13qvOa=cjK37CPLJsKg@mail.gmail.com>
References: <20240327181700.77940-1-donald.hunter@gmail.com>
	<20240327181700.77940-3-donald.hunter@gmail.com>
	<20240328175729.15208f4a@kernel.org>
	<m234s9jh0k.fsf@gmail.com>
	<20240329084346.7a744d1e@kernel.org>
	<m2plvcj27b.fsf@gmail.com>
	<CAD4GDZw0RW3B2n5vC-q-XLpQ_bCg0iP13qvOa=cjK37CPLJsKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Mar 2024 21:01:09 +0000 Donald Hunter wrote:
> There's no response for 'batch-begin' or 'batch-end'. We may need a
> per op spec property to tell us if a request will be acknowledged.

:(

Pablo, could we possibly start processing the ACK flags on those
messages? Maybe the existing user space doesn't set ACK so nobody
would notice?

I don't think the messages are otherwise marked as special from 
the "netlink layer" perspective.

> > I think this was a blind spot on my part because nftables doesn't
> > support batch for get operations:
> >
> > https://elixir.bootlin.com/linux/latest/source/net/netfilter/nf_tables_api.c#L9092
> >
> > I'll need to try using multi for gets without any batch messages and see how
> > everything behaves.  
> 
> Okay, so it can be made to work. Will incorporate into the next revision:

Great!


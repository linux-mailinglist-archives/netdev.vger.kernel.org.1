Return-Path: <netdev+bounces-40062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 255A47C5990
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 18:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521C11C20C26
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9746020334;
	Wed, 11 Oct 2023 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Equw31i+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA261A59F
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58F5C433C7;
	Wed, 11 Oct 2023 16:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697043158;
	bh=jWrmZ532YR+dPuppXLRmIYFDahPgdwjU16ldDoVMVzI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Equw31i+sBZKdNiotXEdHTrJmodBC1ikvLUQrE1Z9WViSrrFUPQo7TOTJbsHYx55/
	 FT9d9tSjg+YQQGHaODSiRhiCS2Vh9JPHsj8I+xJ3XHeUyrt5wygiBZ/j8rw70YcOYT
	 rfgrLh6nBVTW8Fouyr/uhFU3AQbMg2CzWwA083TW7VOtACOTbajFXKZZQmMNQPPYbc
	 1UItrmHY7sNL0WGSKOzVPU27qjiz4qZ5wbcVRiqMLZcwjzIDn8bNMFM9+RW4HpyDdP
	 L0Wwm7/ulyYVXed+Z9dgaFUUbnsxcsN6ukgbOYmcIgtNsGLkpIKZobnaYN9IWpnIV8
	 /7e9EizE4rchg==
Date: Wed, 11 Oct 2023 09:52:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com, johannes@sipsolutions.net
Subject: Re: [patch net-next 02/10] tools: ynl-gen: introduce support for
 bitfield32 attribute type
Message-ID: <20231011095236.5fdca6e2@kernel.org>
In-Reply-To: <ZSY7kHSLKMgXk9Ao@nanopsycho>
References: <20231010110828.200709-1-jiri@resnulli.us>
	<20231010110828.200709-3-jiri@resnulli.us>
	<20231010115804.761486f1@kernel.org>
	<ZSY7kHSLKMgXk9Ao@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Oct 2023 08:07:12 +0200 Jiri Pirko wrote:
> >> Note that since the generated code works with struct nla_bitfiel32,
> >> the generator adds netlink.h to the list of includes for userspace
> >> headers. Regenerate the headers.  
> >
> >If all we need it for is bitfield32 it should be added dynamically.
> >bitfiled32 is an odd concept.  
> 
> What do you mean by "added dynamically"?

Scan the family, see if it has any bitfields and only then add 
the include? It's not that common, no point slowing down compilation
for all families if the header is not otherwise needed.

> >> diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
> >> index f9366aaddd21..8192b87b3046 100644
> >> --- a/Documentation/netlink/genetlink-c.yaml
> >> +++ b/Documentation/netlink/genetlink-c.yaml
> >> @@ -144,7 +144,7 @@ properties:
> >>                name:
> >>                  type: string
> >>                type: &attr-type
> >> -                enum: [ unused, pad, flag, binary, u8, u16, u32, u64, s32, s64,
> >> +                enum: [ unused, pad, flag, binary, bitfield32, u8, u16, u32, u64, s32, s64,
> >>                          string, nest, array-nest, nest-type-value ]  
> >
> >Just for genetlink-legacy, please.  
> 
> Why? Should be usable for all, same as other types, no?

array-nest already isn't. I don't see much value in bitfiled32
and listing it means every future codegen for genetlink will
have to support it to be compatible. It's easier to add stuff
than to remove it, so let's not.


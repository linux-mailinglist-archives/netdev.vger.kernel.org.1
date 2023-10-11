Return-Path: <netdev+bounces-40094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCF17C5B3E
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 20:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0831C20A9F
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 18:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C0622322;
	Wed, 11 Oct 2023 18:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmUNzX20"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3421B29C
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 18:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07935C433C8;
	Wed, 11 Oct 2023 18:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697048738;
	bh=lbV/zFq8sp9n/MttKlSzsBUZqyAQ+bGmiDaIqvofFNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dmUNzX20KXwoJioRU9LD8DSXrP6kQbreGlfOH05XDB2rmHLnsT8QtWd8uvb+J7OJs
	 CbpwoVsJI4dQGgZP0OUWD5XZ1Sq04KGTuj7IjHSjdDMYC/64P/0ECn8cCL26Yh+QgD
	 Vzsf8tCP4pdH6dFoqtL35V7jvYMWjTvLd5rmOKKiEXGfaMhIDluXIvR1eCN66qslAW
	 s0Sq0eOwk3krsnZ6a+R3bMPxAvcXQ62Gnb/kScAyEtVqneLz6Uy69mnO4jSd3sIOdM
	 15eBa22Ryg+JOk8y1uOCx48SRSBs4M8iJiM+FbJFNDR+lCfOo1ZkHF0UQZcu1WQOt3
	 hesa9vJ1Wb8rg==
Date: Wed, 11 Oct 2023 11:25:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com, johannes@sipsolutions.net
Subject: Re: [patch net-next 02/10] tools: ynl-gen: introduce support for
 bitfield32 attribute type
Message-ID: <20231011112537.2962c8be@kernel.org>
In-Reply-To: <ZSbVqhM2AXNtG5xV@nanopsycho>
References: <20231010110828.200709-1-jiri@resnulli.us>
	<20231010110828.200709-3-jiri@resnulli.us>
	<20231010115804.761486f1@kernel.org>
	<ZSY7kHSLKMgXk9Ao@nanopsycho>
	<20231011095236.5fdca6e2@kernel.org>
	<ZSbVqhM2AXNtG5xV@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Oct 2023 19:04:42 +0200 Jiri Pirko wrote:
> >> Why? Should be usable for all, same as other types, no?  
> >
> >array-nest already isn't. I don't see much value in bitfiled32
> >and listing it means every future codegen for genetlink will
> >have to support it to be compatible. It's easier to add stuff
> >than to remove it, so let's not.  
> 
> Interesting. You want to somehow mark bitfield32 obsolete? But why is
> it? I mean, what is the reason to discourage use of bitfield32?

It's a tradeoff between simplicity of base types and usefulness.
bitfield32 is not bad in any way, but:

 - it's 32b, new features/caps like to start with 64b
 - it doesn't support "by name" operations so ethtool didn't use it
 - it can be trivially re-implemented with 2 attrs

all in all there aren't very many new uses. So I think we should
put it in legacy for now. Maybe somehow mark it as being there due
to limited applicability rather than being "bad"?


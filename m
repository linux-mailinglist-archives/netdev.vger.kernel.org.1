Return-Path: <netdev+bounces-87095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5792B8A1D34
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 20:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63149B310BE
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 17:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835C8135A4D;
	Thu, 11 Apr 2024 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpVDD8o3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF3C13541F
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851407; cv=none; b=nGaon9WIE1g1yGns9io8V2tcbjPGjMkGgz8PQdMdxqDe1xIyDdIohc8oJq0zay1iWN1QTrQYCWxGT0i1t4MQxmjfNRD3v5qv+WxBD71MZD3j+ZIPXJKDRE2LAGbp4QH6UPkz7sO3yeSdUu8XIogiSANbcd0Ky/U7lsy1kzpTQIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851407; c=relaxed/simple;
	bh=8qkXMxGNyZUH4i84qFj5jzo+T8txtZswwudFhYwuan8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVopkfCpYht0RYW3v2UkWnP6Lz3N6La1tqAXx/r0SoHrLTpzUfLiZtalFe618mIZFPA+xxT0ipw8HmUbDEYv/q50BzW0fZhR47gEbgXt1RbTpot2MD3WuyRlOBbRGzJoQ88CRK1tTrSFJEO9fQAg46Hja830s9d8vKKEscia41k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpVDD8o3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970A8C2BD10;
	Thu, 11 Apr 2024 16:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712851406;
	bh=8qkXMxGNyZUH4i84qFj5jzo+T8txtZswwudFhYwuan8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jpVDD8o3h+f8r9Gr5+n4ODmeYF6Vz09bUzvzXRAqQwWUed6rYI7T/uOrBN33wpHK3
	 tlerCf4xLt29wkrQjTzHHfK58jOvVUjSVRQRo9VEryHi5Klmwv30W/1o9X6deCIOSV
	 Qr2SO+2iZGkZkQcqyeAF5cKTwIdO2NNBbo+kcjsk5JOVZO3pDWTPpxZ+gEieJRlUrF
	 zMBHjG4xFgBPNLo4zMuQN5l0GyKdm9S5AuTj2xNFM+zS7cQKPWanFL0ASaNOm5j+1S
	 wAPGdmzZmaN0d5tjLbkDkJlRQDaSOLwSptQQnZJ7BfzZkt9SjZ5mxnnXbvQG2hwikv
	 t2+5dSur6qM0g==
Date: Thu, 11 Apr 2024 09:03:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, Jiri Pirko
 <jiri@resnulli.us>, Madhu Chittim <madhu.chittim@intel.com>, Sridhar
 Samudrala <sridhar.samudrala@intel.com>
Subject: Re: [RFC] HW TX Rate Limiting Driver API
Message-ID: <20240411090325.185c8127@kernel.org>
In-Reply-To: <de5bc3a7180fdc42a58df56fd5527c4955fd0978.camel@redhat.com>
References: <20240405102313.GA310894@kernel.org>
	<20240409153250.574369e4@kernel.org>
	<91451f2da3dcd70de3138975ad7d21f0548e19c9.camel@redhat.com>
	<20240410075745.4637c537@kernel.org>
	<de5bc3a7180fdc42a58df56fd5527c4955fd0978.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Apr 2024 17:58:59 +0200 Paolo Abeni wrote:
> > In this contrived example we have VF1 which limited itself to 35G.
> > VF2 limited each queue to 100G and 200G (ignored, eswitch limit is lower)
> > and set strict priority between queues.
> > PF limits each of its queues, and VFs to 50G, no rate limit on the port.
> > 
> > "x" means we cross domains, "=" purely splices one hierarchy with another.
> > 
> > The hierarchy for netdevs always starts with a queue and ends in a netdev.
> > The hierarchy for eswitch has just netdevs at each end (hierarchy is
> > shared by all netdevs with the same switchdev id).
> > 
> > If the eswitch implementation is not capable of having a proper repr for PFs
> > the PF queues feed directly into the port.
> > 
> > The final RR node may be implicit (if hierarchy has loose ends, the are
> > assumed to RR at the last possible point before egress).  
> 
> Let me try to wrap-up all the changes suggested above:
> 
> - we need to clearly define the initial/default status (possibly no b/w
> limits and all the objects on the same level doing RR)
> 
> - The hierarchy controlled by the API should shown only non
> default/user-configured nodes
> 
> - We need to drop the references to privileged VFs.
> 
> - The core should maintain the full status of the user-provided
> configuration changes (say, the 'delta' hierarchy )
> 
> Am I missing something?

LG

> Also it's not 110% clear to me the implication of:
> 
> > consider netdev/queue node as "exit points" of the tree, 
> > to which a layer of actual scheduling nodes can be attached  
> 
> could you please rephrase a bit?
> 
> I have the feeling the the points above should not require significant
> changes to the API defined here, mainly more clear documentation, but
> I'll have a better look.

They don't have to be nodes. They can appear as parent or child of 
a real node, but they don't themselves carry any configuration.

IOW you can represent them as a special encoding of the ID field,
rather than a real node.


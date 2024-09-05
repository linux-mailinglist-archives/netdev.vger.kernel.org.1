Return-Path: <netdev+bounces-125598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D5396DD44
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 17:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B13DB1F234F4
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 15:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E3F1990BA;
	Thu,  5 Sep 2024 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxbGl6Yi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222D6197A9B
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548704; cv=none; b=RFfe7CUPXoIPnQ2/QfuskOHe651oQ6SYdzvY/cVSSe+FzTG4YW4P+F8GVUV+heal9b36rFtM9CMKMb+2MWOZuioQ6Wn2sqfJjWzykt/j4rB0VGRwF/zm5RHkJ9MHwwM9z1/6hkpQowzYUo/67koq94QdWXlzyNhuzLeHeFqOTcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548704; c=relaxed/simple;
	bh=Ld8KTi3QDI3VDWXO6dPONOX6HZLHeHYM7DMRcCRDWfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i9e/Yxu0b2dOv4WwRQr9PTqCyBpaVLJIUnNEXlESTVYKPJ6Oedt9oF9i8448UAuLIo+y4CMWFb6HCUs3jAHKpP6HGI4qmBWAN4y2dQqZM7A+m8YlGQIn9apmumVmaEGq8z35RaBRbLmBeYg3w+IkvKZGUbtO1l276WgLeyQ3hak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxbGl6Yi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B540C4CEC3;
	Thu,  5 Sep 2024 15:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725548703;
	bh=Ld8KTi3QDI3VDWXO6dPONOX6HZLHeHYM7DMRcCRDWfQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bxbGl6YiK5528f0iedkMc3CPab1WUFRuvkqkHVX96+Zgh5LxTYJAeda1dHTja1IYX
	 Gm/euAa4fXmj0fJLGdu/e4Qt/L+MuVqG8q5yXMs5ohEpu+P039EeXwrrluWiIuZPqW
	 Fn9SmZdx3Q0NJMkAPlsLr0PfgmN11LYsJK4RdptjDIVssru1zNI8lXDM+YliuVmcYt
	 lM4tLHEWDzKbK+N7YX+WO/pMLPUCZhDKOjGYr64YyiCTM7gj6M86e6AnSPHDS4vks+
	 DAw6Hu8sO9SQW5XhlmiYqK4RrtEXgdl7PD9md7Zu1yVhODbJcD6UDzIdxaYUQI6Bh/
	 DHXIehKSrOgVQ==
Date: Thu, 5 Sep 2024 08:05:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com
Subject: Re: [PATCH v6 net-next 02/15] netlink: spec: add shaper YAML spec
Message-ID: <20240905080502.3246e040@kernel.org>
In-Reply-To: <d4a8d497-7ec8-4e8b-835e-65cc8b8066b6@redhat.com>
References: <cover.1725457317.git.pabeni@redhat.com>
	<a0585e78f2da45b79e2220c98e4e478a5640798b.1725457317.git.pabeni@redhat.com>
	<20240904180330.522b07c5@kernel.org>
	<d4a8d497-7ec8-4e8b-835e-65cc8b8066b6@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Sep 2024 16:51:00 +0200 Paolo Abeni wrote:
> On 9/5/24 03:03, Jakub Kicinski wrote:
> > On Wed,  4 Sep 2024 15:53:34 +0200 Paolo Abeni wrote:  
> >> +      -
> >> +        name: node
> >> +        type: nest
> >> +        nested-attributes: node-info
> >> +        doc: |
> >> +           Describes the node shaper for a @group operation.
> >> +           Differently from @leaves and @shaper allow specifying
> >> +           the shaper parent handle, too.  
> > 
> > Parent handle is inside node scope? Why are leaves outside and parent
> > inside? Both should be at the same scope, preferably main scope.  
> 
> The group() op receives as arguments, in the main scope:
> 
> ifindex
> node
> leaves
> 
> 'parent' is a nested attribute for 'node', exactly as 'handle'. We need 
> to specify both to identify the 'node' itself (via the 'handle') and to 
> specify where in the hierarchy the 'node' will be located (via the 
> 'parent'). Do I read correctly that you would prefer:
> 
> ifindex
> node_handle
> node_parent
> leaves

I don't see example uses in the cover letter or the test so there's 
a good chance I'm missing something, but... why node_parent?
The only thing you need to know about the parent is its handle,
so just "parent", right?

Also why node_handle? Just "handle", and other attrs of the node can
live in the main scope.

Unless you have a strong reason to do this to simplify the code -
"from netlink perspective" it looks like unnecessary nesting.
The operation arguments describe the node, there's no need to nest
things in another layer.


Return-Path: <netdev+bounces-218855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF6FB3EDE6
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152DA175004
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 18:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CCD1C3F0C;
	Mon,  1 Sep 2025 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQri/5I+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C9910FD
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756751566; cv=none; b=saZ3YI6QtDMQ63uOqGBUuu4dWTutbG3S2N4ulq5rXT3kyel6F3X3H3thZ960cuK36zZbLKb8nPxJkjhddnf645tVmoC7LMcd7xRdNwRjPsH59kXXvWOHcLs+CD5RSIFD5GjLdNt90XjLF9y837vGTV5jXA1aJreQysZMvh4rcys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756751566; c=relaxed/simple;
	bh=K9ti3insN0jdyiodJE+rkG/8zXItiJW1bvvTjCRtNHI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVFWMOVSeGIoTHdndXjXZ4FBHrQx1xwV8pPULd8LslH+v4lRLjOSMgpR2KnNGsK9lkO7sL+Wo1qvSpvoOskq7+BCYRhZRP428UAENVVaQtuK5Bi0E20HhB4ldmPv8YcYXQ3OvCGMhA2xOJld8UKuBty81DkvP2JXMoU6GI9H8hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQri/5I+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C8FC4CEF0;
	Mon,  1 Sep 2025 18:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756751566;
	bh=K9ti3insN0jdyiodJE+rkG/8zXItiJW1bvvTjCRtNHI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nQri/5I+EIweKjcMIZCHlgH4thXTPGJmfSEB7TvVn1lqIBWO1mpuIB3xZkbLkjX+W
	 PUfJhN+2Tl67Q+crFbek+2nSkNV8wFJ2DIigzJUQdwbcnBUM4nOOiwIyzM2hzQ+Ppu
	 vE96EdCtdDYM99T2vMJJDGmw0qXHtrqdEQRehBzM98kTMtYgrKgP+vif/43ncz65QP
	 9ZLaG7yzAGgSPoX+q1zfaZFxUpdHK/bXcZLbjqUkueSEDVrKKNBsBqd3/IFqkv5F/T
	 UvzPynrMK8X/i5VrqlIqlDxNGVFP2M9dclyV2VqnC/rISwVgWno5uHsQmEE/dNYzcz
	 5r3fiZXn/kX0Q==
Date: Mon, 1 Sep 2025 11:32:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alok Tiwari <alok.a.tiwari@oracle.com>, jiri@nvidia.com,
 stanislaw.gruszka@linux.intel.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] genetlink: fix genl_bind() invoking bind() after
 -EPERM
Message-ID: <20250901113244.58c19ca1@kernel.org>
In-Reply-To: <7bb4e094-fa20-42d6-89d5-c25cc0584309@lunn.ch>
References: <20250831190315.1280502-1-alok.a.tiwari@oracle.com>
	<7bb4e094-fa20-42d6-89d5-c25cc0584309@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Sep 2025 03:23:36 +0200 Andrew Lunn wrote:
> > @@ -1836,7 +1836,7 @@ static int genl_bind(struct net *net, int group)
> >  		    !ns_capable(net->user_ns, CAP_SYS_ADMIN))
> >  			ret = -EPERM;
> >  
> > -		if (family->bind)
> > +		if (!ret && family->bind)
> >  			family->bind(i);  
> 
> I agree, this fixes the issue you point out. But i think it would be
> more robust if after each EPERM there was a continue.
> 
> Also, i don't understand how this ret value is used. It looks like the
> bind() op could be called a number of times, and yet genl_bind()
> returns -EPERM?

The loop has a break at the end, there can be only one family that owns
a given mcast group ID. So the structure of the code is fine as is
(with the exception of the bug discussed).

As for the fix, to avoid future problems, I'd add a separate:

		if (ret)
			break;

rather than inserting a check into the bind condition.

> Also, struct genl_family defines bind() as returning an int. It does
> not say so, but i assume the return value is 0 on success, negative
> error code on failure. Should we be throwing this return value away?
> Should genl_bind() return an error code if the bind failed?

Good question, I think core checks if the group exists within
genetlink, here we should be more or less guaranteed to find
the family. Would be good to test that tho.

> And if genl_bind() does return an error, should it first cleanup and
> unbind any which were successful bound?
> 
> As i said, i don't know this code, so all i can do is ask questions in
> the hope somebody does know what is supposed to happen here.


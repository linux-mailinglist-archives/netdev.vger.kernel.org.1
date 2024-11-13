Return-Path: <netdev+bounces-144508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D789C7A81
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8711F237E7
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF46206E77;
	Wed, 13 Nov 2024 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfR47I9n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D349C20514D;
	Wed, 13 Nov 2024 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520754; cv=none; b=LHvHmYYBHqCGJHFiTKR/vrnahtHsvB2otDDCs+hhyiQb8mQ4y49E12GJMl5CexCAvAf7yxEms8F4qlzgbUE8WlxjDduGp4YspsWTQK3AiOsGkasLZZan05L8hOhj5/xwujFA6f3StRC9IHqJh3bO2cYVKjfziOJKLJQop1ttPlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520754; c=relaxed/simple;
	bh=kvruL1GdSBx8iandcR56wwKSMO8JMiEGXVsrb7k0A/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zjc8sbl1Bk+E8Z5KXyTfivJUzKs6mfVnosJ3P9226myyw22YLRmEHFAOdL5vf8xACeuFK4Dttft3PFXd8z6Y/IA0mvPQeAhZ0U32OyPmf6+opQzhqkEvGiaHfuka4/4bJVbaHJ+3oya5gnrrA+ViRm1mqenMmljhpKam8Iz834c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfR47I9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462DDC4CEC3;
	Wed, 13 Nov 2024 17:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731520753;
	bh=kvruL1GdSBx8iandcR56wwKSMO8JMiEGXVsrb7k0A/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JfR47I9ni6SRUhA2VcKNUa5Zv8rMdbJKqQZKpEUklGnFSHV1zpUdFP04UKVVYMSrN
	 HAn68Cp+Txg8bxLkRDJ5We6Iv8sJmUarkZxB0S3QXIjeS26xx4+15G7UwuMIOIhTvc
	 6sMIJha7+nJckfN9I8P5C0ecmtlnSLP5yoLHstQ9Pt0TELguTk8PB5dKOfiDTZqXJG
	 yhE0EoKXNfyr3n7zHkxUtJRIuPWn1MtOZKKUeVw1E+V4Yj1NSrgs9TT8E3dYp2VW5v
	 ICCciIufsu6mPdGr70zrhBAkdDtkNr58hKK+JEhM9aDbDt1kqedQHXCe4PbTUlSrNc
	 zygohYDtkZqAw==
Date: Wed, 13 Nov 2024 17:59:09 +0000
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] xfrm: Add error handling when nla_put_u32()
 returns an error
Message-ID: <20241113175909.GB4507@kernel.org>
References: <20241112233613.6444-1-everestkc@everestkc.com.np>
 <20241113105939.GY4507@kernel.org>
 <81088611-41d9-4472-94e6-3170418156c9@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81088611-41d9-4472-94e6-3170418156c9@stanley.mountain>

On Wed, Nov 13, 2024 at 04:10:15PM +0300, Dan Carpenter wrote:
> On Wed, Nov 13, 2024 at 10:59:39AM +0000, Simon Horman wrote:
> > On Tue, Nov 12, 2024 at 04:36:06PM -0700, Everest K.C. wrote:
> > > Error handling is missing when call to nla_put_u32() fails.
> > > Handle the error when the call to nla_put_u32() returns an error.
> > > 
> > > The error was reported by Coverity Scan.
> > > Report:
> > > CID 1601525: (#1 of 1): Unused value (UNUSED_VALUE)
> > > returned_value: Assigning value from nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num)
> > > to err here, but that stored value is overwritten before it can be used
> > > 
> > > Fixes: 1ddf9916ac09 ("xfrm: Add support for per cpu xfrm state handling.")
> > > Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > 
> > For future reference, I think the appropriate target for this tree
> > is ipsec-next rather than next.
> > 
> > 	Subject: [PATCH ipsec-next] xfrm: ...
> 
> All these trees are a pain in the butt to track.  It's fine for people who only
> work in one tree but for people doing static checker stuff, then we have to
> deal with all 388 trees in linux-next.
> 
> I've changed my scripts to add [next] to my patches if Linus hasn't merged the
> commit from the Fixes tag.  I still add net and net-next by hand but I'm going
> to just automate that as well because doing it by hand has been failure prone.
> 
> But then if we try to add all the ipsec or whatever trees, it just becomes
> unworkable.  I started to write a script which would look do the --is-ancestor
> check based on the Fixes tag, but it take forever to update the git trees.  I
> wasn't able to figure out a way to make this work.
> 
> Also once Linus merges the commit, there is no way to tell which tree the commit
> goes to so it only applies to linux-next.  For networking, I already have the
> script that greps the patch for -w net and grep -vw wireless.  But I don't want
> to maintain a list greps for everyone's tree.
> 
> A lot of this scripting could be built into the CI system.  The CI system is
> already doing some scripting based on the subject but we could do it based on
> the Fixes tag instead.  If there isn't a Fixes tag, then it should go to
> net-next.

Hi Dan,

I take your point that this is not very friendly to people sending
the occasional patch (towards Networking). And certainly there
is room to improve the CI.

FWIIW, my goto when preparing patches is something like the following.
Because at least for Networking, we do try to make MAINTAINERS reflect
reality:

./scripts/get_maintainer.pl --scm net/xfrm/xfrm_user.c


Return-Path: <netdev+bounces-50253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBB57F50EB
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 20:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D992813A2
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 19:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A18C4EB57;
	Wed, 22 Nov 2023 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="um+CthHV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E25E5E0DD
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 19:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12ECAC433C7;
	Wed, 22 Nov 2023 19:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700682656;
	bh=8+dHgOtK1lyLrH7Qjs4jKErBKHnN+vPS8axyfLs9RqE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=um+CthHVzBwi6ZBU7MHHsXRQWqaXiTE9SVm4RVvajqDNOOA7wAgVR69rAw+2QMEYu
	 kaMHcKWCKm91Ktzj1ILZsp/J1vsf7u0Vt74Of5Bf24AfsnqAbZ1eSrYl0COgNfForR
	 PZJvFqhsY9GhQzXDUkIRPrGcAoo3hYzDXL0742DHnBglTRq3Ufj/nz8qajhUlXn55U
	 sk+BrN68fXt4fLIPCv0mM8Z4vexD8ieWNfNxG7vOK9KrATNDBxlmkfS0mDEg9NqLgK
	 fGrwVt6UpAdg1txUm9DFtjkN9yd7Y2V0sxzmQWQtAHldE2TCHPQc2Ri532cWYRrbnp
	 4jWzt604dU70g==
Date: Wed, 22 Nov 2023 11:50:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
 johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
 amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org
Subject: Re: [patch net-next v3 5/9] genetlink: implement release callback
 and free sk_user_data there
Message-ID: <20231122115055.0731c225@kernel.org>
In-Reply-To: <ZV5GikewsOpDqHwK@nanopsycho>
References: <20231120084657.458076-1-jiri@resnulli.us>
	<20231120084657.458076-6-jiri@resnulli.us>
	<20231120185022.78f10188@kernel.org>
	<ZVys11ToRj+oo75s@nanopsycho>
	<20231121095512.089139f9@kernel.org>
	<ZV3KCF7Q2fwZyzg4@nanopsycho>
	<20231122090820.3b139890@kernel.org>
	<ZV5GikewsOpDqHwK@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Nov 2023 19:20:58 +0100 Jiri Pirko wrote:
> >I'm pretty sure I complained when it was being added. Long story.
> >AFAIU user as in if the socket is opened by a kernel module, the kernel
> >module is the user. There's no need to use this field for the
> >implementation since the implementation can simply extend its 
> >own structure to add a properly typed field.  
> 
> Okay, excuse me, as always I'm slow here. What structure are
> you refering to?

struct netlink_sock. Technically it may be a little cleaner to wrap 
that in another struct that will be genetlink specific. But that's
a larger surgery for relatively little benefit at this stage.


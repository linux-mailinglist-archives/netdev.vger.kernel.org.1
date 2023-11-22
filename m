Return-Path: <netdev+bounces-50191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5D07F4DD3
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 18:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B351C20947
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 17:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5958B4CE19;
	Wed, 22 Nov 2023 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhnVGW3o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C12259B4E
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 17:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE79C433C8;
	Wed, 22 Nov 2023 17:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700672902;
	bh=sn1w8LZ5Enx6g9lYakHDB/6CeUfmHhPXwe9Ef287GLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QhnVGW3oSHvy8zIjTTx8lj24/qKpN2TMKhX3o9dEHxzzIauevJqbizbCC0ILBVLFB
	 ADJaATcnxHQz7ndfBz2LoCfx7Ot7gaNDJz/+TJMOFN6G9umVyAy2RkwxbIMxbV9xlC
	 4BDapfT3cfuh1UB9VVTI6PQZ2FRirkq8mXVPLjfpNKEZMzFLUgUexEWyH75t/HYByP
	 M0fZPF0MINw9aNRAc1DosremaIfAQMi7TInrE7QxL2noaPBBGQvLA6I8SqlArDVDC9
	 gl4SEpfHp/gHjoM9nCkb7iKKbtiS4r//dVBmxtmLqRw+uX7qxI7pJEgTd6wUMghIrg
	 HKy3+ShgEKcLA==
Date: Wed, 22 Nov 2023 09:08:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
 johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
 amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org
Subject: Re: [patch net-next v3 5/9] genetlink: implement release callback
 and free sk_user_data there
Message-ID: <20231122090820.3b139890@kernel.org>
In-Reply-To: <ZV3KCF7Q2fwZyzg4@nanopsycho>
References: <20231120084657.458076-1-jiri@resnulli.us>
	<20231120084657.458076-6-jiri@resnulli.us>
	<20231120185022.78f10188@kernel.org>
	<ZVys11ToRj+oo75s@nanopsycho>
	<20231121095512.089139f9@kernel.org>
	<ZV3KCF7Q2fwZyzg4@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Nov 2023 10:29:44 +0100 Jiri Pirko wrote:
> >If you're doing it centrally, please put the state as a new field in
> >the netlink socket. sk_user_data is for the user.  
> 
> I planned to use sk_user_data. What do you mean it is for the user?
> I see it is already used for similar usecase by connector for example:

I'm pretty sure I complained when it was being added. Long story.
AFAIU user as in if the socket is opened by a kernel module, the kernel
module is the user. There's no need to use this field for the
implementation since the implementation can simply extend its 
own structure to add a properly typed field.


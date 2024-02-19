Return-Path: <netdev+bounces-72928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDAD85A2FE
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 13:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91F31F235C7
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 12:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5622D79D;
	Mon, 19 Feb 2024 12:16:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26A72D608
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 12:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344965; cv=none; b=HLLvXdAWp6/UPw2pjoQ9k/sL1wuYK8ONrWDe3YG53y4JS9gJzLSpCwvlKON27x6564FkVYXv6cBoQLZlopHCmRyBnfjq6Spu3vCRkGVFqrfDQx7b9fVaQOp7QqoH4qxlYR+8+b+p1ekHEdN0eYGCub5U0e7s3CYapurrdAPdLAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344965; c=relaxed/simple;
	bh=YgcSrbwN4DXhEAb4hvzhEyKjxrXY64SnchQcmsPAYxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewRT2iFN1p+zii0E1RdqnkN5wjFG/sN91f8q1ln/OQMa+yuGbbgAFhUHHSYdkJAnkGjaRx5VJsT3E69HdJ4ccqsZMrQdHYL3sIh5qLvFiivjsU+ZkwxmNOb1WopT7ES9bNS2VJty2BwDKqmlLifpHdkosDN4wGzhuY4/PlOQoKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 3563F2F20253; Mon, 19 Feb 2024 12:15:59 +0000 (UTC)
X-Spam-Level: 
Received: from [10.88.144.178] (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 7B5EA2F2024C;
	Mon, 19 Feb 2024 12:15:56 +0000 (UTC)
Message-ID: <4462f60e-63eb-c566-818a-98523ca4d4ff@basealt.ru>
Date: Mon, 19 Feb 2024 15:15:52 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] genetlink: fix potencial use-after-free and
 null-ptr-deref in genl_dumpit()
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
 jacob.e.keller@intel.com, johannes@sipsolutions.net, idosch@nvidia.com,
 David Lebrun <david.lebrun@uclouvain.be>,
 Pablo Neira Ayuso <pablo@netfilter.org>
References: <20240215202309.29723-1-kovalev@altlinux.org>
 <20240219113240.GZ40273@kernel.org>
From: kovalev@altlinux.org
In-Reply-To: <20240219113240.GZ40273@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+ Pablo Neira Ayuso <pablo@netfilter.org>

19.02.2024 14:32, Simon Horman wrote:
> + Jiri Pirko <jiri@resnulli.us>
>    David Lebrun <david.lebrun@uclouvain.be>
>
> On Thu, Feb 15, 2024 at 11:23:09PM +0300, kovalev@altlinux.org wrote:
>> From: Vasiliy Kovalev <kovalev@altlinux.org>
>>
>> The pernet operations structure for the subsystem must be registered
>> before registering the generic netlink family.
>>
>> Fixes: 134e63756d5f ("genetlink: make netns aware")
> Hi Vasiliy,
>
> A Fixes tag implies that this is a bug fix.
> So I think some explanation is warranted of what, user-visible,
> problem this resolves.
>
> In that case the patch should be targeted at net.
> Which means it should be based on that tree and have a net annotation
> in the subject
>
> 	Subject: [PATCH net] ...
>
> Alternatively, the Fixes tag should be dropped and some explanation
> should be provided of why the structure needs to be registered before
> the family.
>
> In this case, if you wish to refer to the patch where the problem (but not
> bug) was introduced you can use something like the following.
> It is just the Fixes tag that has a special meaning.
>
> 	Introduced in 134e63756d5f ("genetlink: make netns aware")
>
> I think the above comments also apply to:
>
> - [PATCH] ipv6: sr: fix possible use-after-free and null-ptr-deref
>    https://lore.kernel.org/all/20240215202717.29815-1-kovalev@altlinux.org/
>
> - [PATCH] devlink: fix possible use-after-free and memory leaks in devlink_init()
>    https://lore.kernel.org/all/20240215203400.29976-1-kovalev@altlinux.org/
>
> And as these patches seem to try to fix the same problem in different
> places, all under Networking, I would suggest that if you do repost,
> they are combined into a patch series (3 patches in the same series).
>
> But I do wonder, how such an apparently fundamental problem has been
> present for so long in what I assume to be well exercised code.

Hi Simon,

The history of these changes began with the crash fix in the gtp module [1]

A solution to the problem was found [2] and Pablo Neruda Ayuso suggested 
fixing similar

sections of code if they might have the same problem.

I have sent patches, but do not have reproducers, relying on drawing 
attention to the problem.


[1] 
https://lore.kernel.org/lkml/20240124101404.161655-1-kovalev@altlinux.org/T/

[2] 
https://lore.kernel.org/netdev/20240214162733.34214-1-kovalev@altlinux.org/T/#u

-- 
Thanks,
Vasiliy Kovalev



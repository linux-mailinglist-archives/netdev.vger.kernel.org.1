Return-Path: <netdev+bounces-100038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECABD8D7A1D
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 04:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8CC1F20F2B
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 02:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7335250;
	Mon,  3 Jun 2024 02:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIEIUJ/a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8644C46AF
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 02:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717382536; cv=none; b=uTPe+rUrNOnp23RSl/fm0SymB+bW521JkFLqhu742G7WfENjgEcD/SmpC0/Wmd/CSuE7MMBuzuwfHlM6+8/76uvoA6xbobMaUtY2B4mUxVeSeZIGxE9peXq3JybptB44RfH9J4iLIu/x9KdYa1/QT/bsxXmCj1b7yKQNybLYIow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717382536; c=relaxed/simple;
	bh=szRr1ZrFVhoqIW05er6VvT95RtIFU5F1q5/KULroP9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hr4L+w3AepmCJwrL6/cs6wZJmtfELfqe/zeenUYEADZSlGto493hH1/C0PRyth6a2oqIijz40ivzAZ2RFfbhx4Fx4gHkmpxS0y0kQDASkgmR3Vgm1zQEQ1UG6T4GB4YWk1Bu5KC5QJeG1um0jB2ryx2itYIz3rXRv1su7n5zbCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIEIUJ/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89A6C2BBFC;
	Mon,  3 Jun 2024 02:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717382536;
	bh=szRr1ZrFVhoqIW05er6VvT95RtIFU5F1q5/KULroP9I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LIEIUJ/awsgFN0V+0fP06hMdOwlgWTho6NquGN3biTN2lSdEew1guaOYCmBIjquOA
	 FLu7dfBSvQMAi3IYrEq+Etje7BHJJkxomDyfNb1ro2BRC77z3vq2KvMjBpe2anTdea
	 nU5fdobKW0/X1Jh2keSnGgxWCWFwmP0V0BIiMum3E+FDf+3xS1NAO5//9KqNTVFLQx
	 r2i4RQMMItXNyZwvVBAO3UBH/luoVENQdLKv6dPeTsuEF1W0ymANxfgtkhg0nN2YEg
	 lj8SsvaLxehWO2vJK/ABGFBZYiB907n1jNZ4SZAKk8Y5r0HzAfKb6qOhv2vKbdtPcM
	 aTKL7mni+mQjQ==
Message-ID: <dafecb99-d4e4-4c0c-a339-a5a5bebcc41c@kernel.org>
Date: Sun, 2 Jun 2024 20:42:14 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] inet: bring NLM_DONE out to a separate recv() in
 inet_dump_ifaddr()
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
References: <20240601212517.644844-1-kuba@kernel.org>
 <20240601161013.10d5e52c@hermes.local> <20240601164814.3c34c807@kernel.org>
 <ad393197-fd1a-4cd8-a371-f6529419193b@kernel.org>
 <20240602145916.0629c8e2@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240602145916.0629c8e2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/24 3:59 PM, Jakub Kicinski wrote:
> On Sat, 1 Jun 2024 20:23:17 -0600 David Ahern wrote:
>>> The dump partitioning is up to the family. Multiple families
>>> coalesce NLM_DONE from day 1. "All dumps must behave the same"
>>> is saying we should convert all families to be poorly behaved.
>>>
>>> Admittedly changing the most heavily used parts of rtnetlink is very
>>> risky. And there's couple more corner cases which I'm afraid someone
>>> will hit. I'm adding this helper to clearly annotate "legacy"
>>> callbacks, so we don't regress again. At the same time nobody should
>>> use this in new code or "just to be safe" (read: because they don't
>>> understand netlink).  
>>
>> What about a socket option that says "I am a modern app and can handle
>> the new way" - similar to the strict mode option that was added? Then
>> the decision of requiring a separate message for NLM_DONE can be based
>> on the app.
> 
> That seems like a good solution, with the helper marking the "legacy"
> handlers - I hope it should be trivial to add such option and change
> the helper's behavior based on the socket state.
> 
>> Could even throw a `pr_warn_once("modernize app %s/%d\n")`
>> to help old apps understand they need to move forward.
> 
> Hm, do you think people would actually modernize all the legacy apps?

I have worked for a few companies that do monitor dmesg and when given
the right push will update apps. Best an OS can do.

> 
> Coincidentally, looking at Jaroslav's traces it appears that the app
> sets ifindex for the link dump, so it must not be opting into strict
> checking, either.

:-(

I should have added a warning back when the option was introduced - that
and a warning when options to a dump are ignored.


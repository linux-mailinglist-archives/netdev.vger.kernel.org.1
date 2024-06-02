Return-Path: <netdev+bounces-99965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1363A8D730D
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 04:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DFD0B21176
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 02:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A5FA34;
	Sun,  2 Jun 2024 02:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpWdns4p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521681FA3
	for <netdev@vger.kernel.org>; Sun,  2 Jun 2024 02:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717294999; cv=none; b=RqOsLiuuBrUp9DpGrZWRMaT0Np8V8oGFbtvpY/oDSK8QLSt9EW6QdUJrp/0fNPKtxZIMdNSVa5rgTDUg6keCJ51l9+JrIoRwM/QnRxC3Hg6Ol9O+jmvv/9uFuFy9REqqNcNZuCpCmhIWsgyiosdfFDm6tO2Fe4DPjRVB5zgmEdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717294999; c=relaxed/simple;
	bh=HHXHfs0NBWk4ptYtWWKjElQh/Nja/C3yVwq7/Ckw9BE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gLafieUquA7DcOHrUXuWeOPUfkI0chRZ8jJBRadtlCoA+taLHwfTOSiBPK+hXnt/84NDL+rxVwYEi6M8btMhAPFvYzifLGEMcUOAYDHuV/uWUivMBI1OTdzKOvZ4rY7iQI/40XI7JURVD4YRsNrbd1KnLjNZexFS+F++LPxTQO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpWdns4p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9107FC116B1;
	Sun,  2 Jun 2024 02:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717294998;
	bh=HHXHfs0NBWk4ptYtWWKjElQh/Nja/C3yVwq7/Ckw9BE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EpWdns4pHenGyQlTWBwDl+0rzvTrncli/X5bl6PRsH4TMctgxCSj+qwi9a1+79/FX
	 qZnGbziyyncWdGows3/MFNCGz1/NFXUm1hhTirFHQRo0b99YFkOQvA+WhZcjKkc/bd
	 hf+UOdfJvX2xsipc9JDro73vwvRcxtClZyHyfEaKEfpY2h0zZdAi/SG6b6KQNEBY8H
	 BjmJtjGBVWFxnEzbzCLJ21nXCIIdxW+Xsdg1Tlxc1kUN7wi1RHP2u8Eef3X/5dG35f
	 2LoapJ3fJemvFqTUoOQX7Z/ilCFwdHAFMZsf/4katrWgik0rIWPR2VEfrzSe+T/lTg
	 GHf1S8XV1GwRg==
Message-ID: <ad393197-fd1a-4cd8-a371-f6529419193b@kernel.org>
Date: Sat, 1 Jun 2024 20:23:17 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] inet: bring NLM_DONE out to a separate recv() in
 inet_dump_ifaddr()
To: Jakub Kicinski <kuba@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
References: <20240601212517.644844-1-kuba@kernel.org>
 <20240601161013.10d5e52c@hermes.local> <20240601164814.3c34c807@kernel.org>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240601164814.3c34c807@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/1/24 5:48 PM, Jakub Kicinski wrote:
> On Sat, 1 Jun 2024 16:10:13 -0700 Stephen Hemminger wrote:
>> Sorry, I disagree.
>>
>> You can't just fix the problem areas. The split was an ABI change, and there could
>> be a problem in any dump. This the ABI version of the old argument 
>>   If a tree falls in a forest and no one is around to hear it, does it make a sound?
>>
>> All dumps must behave the same. You are stuck with the legacy behavior.

I don't agree with such a hard line stance. Mistakes made 20 years ago
cannot hold Linux back from moving forward. We have to continue
searching for ways to allow better or more performant behavior.

> 
> The dump partitioning is up to the family. Multiple families
> coalesce NLM_DONE from day 1. "All dumps must behave the same"
> is saying we should convert all families to be poorly behaved.
> 
> Admittedly changing the most heavily used parts of rtnetlink is very
> risky. And there's couple more corner cases which I'm afraid someone
> will hit. I'm adding this helper to clearly annotate "legacy"
> callbacks, so we don't regress again. At the same time nobody should
> use this in new code or "just to be safe" (read: because they don't
> understand netlink).

What about a socket option that says "I am a modern app and can handle
the new way" - similar to the strict mode option that was added? Then
the decision of requiring a separate message for NLM_DONE can be based
on the app. Could even throw a `pr_warn_once("modernize app %s/%d\n")`
to help old apps understand they need to move forward.


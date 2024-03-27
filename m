Return-Path: <netdev+bounces-82439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AADD88DC7E
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 12:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F901F29389
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 11:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3853074C05;
	Wed, 27 Mar 2024 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4E0GlH9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1503B12B9A
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538866; cv=none; b=L35f2/jv0MOYyHpPhxtmJG6+ER+xyiC2g1YrjORwP6gYdy3goACE4qhu6oQA42ePd6sSEUiEnB25VzAix1nwK7JQjsVu5StVjFen3Vi/crwAiOtUGRJw96WAHzge+JJzcjMvvEWntRJOmi3OiPcO8oCgO4f/fqjplUmwGPZ4Tc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538866; c=relaxed/simple;
	bh=oaApo/srU9FnnVLasNCPU6Vc3zmFm7lgY/ipcvsqNPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BfQeyfW/9zEjkVocOaWZ3ZYlQhyVqj7jm/1U7XMN78QrQQxtNGrJ0MIc8ZhKrDj2XYPZFQhZCzgC64scOgG/NyP3hs5+9oRubbXNDcnUpwZlhpEB4jzg2E+tPehaivPKgoqaYOEEeww+nqL/8e+vtJCUA+zQiVf4nRz05/X8huc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4E0GlH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350A4C433C7;
	Wed, 27 Mar 2024 11:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711538866;
	bh=oaApo/srU9FnnVLasNCPU6Vc3zmFm7lgY/ipcvsqNPY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H4E0GlH9HUEweYrzsTAO2HPHRXXGBEpZs6yN6KVA3hT8kwEw+Ubf+Ljq5UQJPX37Y
	 FlPwaJVTKU2NW1xFHlwVRbskKd5mGgy2icPiOAZ+1U1kUuUAh8ZSFYC9y4+pIC+dU1
	 Ym9Xukbk8XELkNE78cJicLOiYBCc5oZEBrhtmx8Iaswogyd2wMEnssPxjMEPzm5c/h
	 2dKu5vngwLbAW+CqR6W1XdjJjyZgqkGdVfIO4ASqGzzPWgivqliMmaBOg3yx9dNvR6
	 AhQY2/Sq3ce2spg/yt0GB8rlJPMlw3X6bkgHhhKYMkvr5hjZ1J+UMNYdwjbxbNhkdB
	 L7itUDvOgcGWw==
Message-ID: <ba4ac0f4-7a95-4fb2-b128-d7b248e4137a@kernel.org>
Date: Wed, 27 Mar 2024 12:27:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Xen NIC driver have page_pool memory leaks
To: paul@xen.org, Arthur Borsboom <arthurborsboom@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Netdev <netdev@vger.kernel.org>, Wei Liu <wei.liu@kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 kda@linux-powerpc.org
References: <CALUcmUncphE8v8j1Xme0BcX4JRhqd+gB0UUzS-U=3XXw_3iUiw@mail.gmail.com>
 <1cde0059-d319-4a4f-a68d-3b3ffeb3da20@kernel.org>
 <857282f5-5df6-4ed7-b17e-92aae0cf484a@xen.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <857282f5-5df6-4ed7-b17e-92aae0cf484a@xen.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 25/03/2024 13.33, Paul Durrant wrote:
> On 25/03/2024 12:21, Jesper Dangaard Brouer wrote:
>> Hi Arthur,
>>
>> (Answer inlined below, which is custom on this mailing list)
>>
>> On 23/03/2024 14.23, Arthur Borsboom wrote:
>>> Hi Jesper,
>>>
>>> After a recent kernel upgrade 6.7.6 > 6.8.1 all my Xen guests on Arch
>>> Linux are dumping kernel traces.
>>> It seems to be indirectly caused by the page pool memory leak
>>> mechanism, which is probably a good thing.
>>>
>>> I have created a bug report, but there is no response.
>>>
>>> https://bugzilla.kernel.org/show_bug.cgi?id=218618
>>>
>>> I am uncertain where and to whom I need to report this page leak.
>>> Can you help me get this issue fixed?
>>
>> I'm the page_pool maintainer, but as you say yourself in comment 2 then
>> since dba1b8a7ab68 ("mm/page_pool: catch page_pool memory leaks") this
>> indicated there is a problem in the xen_netfront driver, which was
>> previously not visible.
>>
>> Cc'ing the "XEN NETWORK BACKEND DRIVER" maintainers, as this is a driver
>> bug.  What confuses me it that I cannot find any modules named
>> "xen_netfront" in the upstream tree.
>>
> 
> You should have tried '-' rather than '_' :-)
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/xen-netfront.c
> 

Looking at this driver, I think it is missing a call to 
skb_mark_for_recycle().

I'll will submit at patch for this, with details for stable maintainers.

As I think it dates back to v5.9 via commit 6c5aa6fc4def ("xen
networking: add basic XDP support for xen-netfront"). I think this
commit is missing a call to page_pool_release_page()
between v5.9 to v5.14, after which is should have used
skb_mark_for_recycle().

Since v6.6 the call page_pool_release_page() were removed (in
535b9c61bdef ("net: page_pool: hide page_pool_release_page()") and
remaining callers converted (in commit 6bfef2ec0172 ("Merge branch
'net-page_pool-remove-page_pool_release_page'")).

This leak became visible in v6.8 via commit dba1b8a7ab68 ("mm/page_pool:
catch page_pool memory leaks").

--Jesper


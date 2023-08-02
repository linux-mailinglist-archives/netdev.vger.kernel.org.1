Return-Path: <netdev+bounces-23502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB0076C371
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 05:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93201C21189
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 03:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875B6A56;
	Wed,  2 Aug 2023 03:18:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E05A40
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 03:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C2BC433C9;
	Wed,  2 Aug 2023 03:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690946328;
	bh=pPUw7iVxQvIYg97/YCPzTavNzCKbFieabBAhT15a2Uo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bkcncHKz/50NbkYBuFySUwMr+ehRZ3ht7OWpcR8GWtU9m5OJRSsRdhOZP45x0rMiD
	 lyx9oHODYj1kNIMtZbddO5jGYdkgXmN1COwQMNkWLN4keMu4QdMN0RHqdPT7Sw3h2S
	 8sw2tGvk5fH6inIRlp4Za54mZBfkfUTJizanswHdHaemnbxhroj9TkO1PS4gkVr3Jx
	 knPz4E1dqyrHQVD38G0/LL6vyuxJIXJxePRJO5wvLBqeKNrFqEK83J7nxMFRCfFc/x
	 1Fj9/5wRTGf13jfSNeHUBBWzT4cvZiFyuMndA0R43CY0RKi5Zfk1cQwBQpbL/1Njwk
	 8ORqcl2mqQHyA==
Message-ID: <cbefa473-2d48-5df9-f773-8bb6bdcd6be1@kernel.org>
Date: Tue, 1 Aug 2023 21:18:47 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3] ip6mr: Fix skb_under_panic in ip6mr_cache_report()
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, YueHaibing <yuehaibing@huawei.com>
Cc: Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
 pabeni@redhat.com, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, simon.horman@corigine.com
References: <20230801064318.34408-1-yuehaibing@huawei.com>
 <CANn89iJO44CiUjftDZHEjOCy5Q3-PDB12uWTkrbA5JJNXMoeDA@mail.gmail.com>
 <20230801131146.51a9aaf3@kernel.org>
 <0e3e2d6f-0e8d-ccb4-0750-928a568ccaaf@kernel.org>
 <cad2b715-14fc-8424-f85d-b5391e0110dc@huawei.com>
 <20230801191058.0664b1b8@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230801191058.0664b1b8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/1/23 8:10 PM, Jakub Kicinski wrote:
> On Wed, 2 Aug 2023 09:28:31 +0800 YueHaibing wrote:
>>> that pattern shows up a few times:  
>>
>> Ok, I will test and fix these if any.
> 
> Thanks, we may also want to add a 
>   DEBUG_NET_WARN_ON_ONCE(len > INT_MAX)
> in skb_push() but perhaps that's an overkill.
> Most of those cases are probably legit (skb_.*_offset()
> can well be negative if headers were already pulled).

Yea, a lot of those could be legit, so it would be best to have a test
case that shows it can be triggered and then any patch fixes it.


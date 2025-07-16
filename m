Return-Path: <netdev+bounces-207410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB75B070DD
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 10:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DCBC189958F
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 08:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C24E2EF664;
	Wed, 16 Jul 2025 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="KEeRUPXz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8932A2EF646
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752655677; cv=none; b=nlLxP5J1JKYX0NB7mAcisI+pWkvXe28L8YKzpfzfNviTOnAJ+5uu36xcmLyiXAqOy4PZ8IF8iXgxWVPkRhIcLG4LYwVHofDrnkxl6mM6Ch5muzw4Bm/kSTVITWBorvqxWZDK0o+BT1EbowLczeo3hicpwr7kYZxooSyyY1vk1UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752655677; c=relaxed/simple;
	bh=4QffYuVKhgZ4GbHjAsmwCfeGfPI7b22Kcnp44jAaudY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SIUms9YK/V/PMtvVBvWw4LTiQlVEOfNzyLKSrdCJiXyoBHTCAb1SEDsO4A4Wl/4xq5HomJ4M5si5Uytd5ewDOR2kQwNMN3CO8FpEQMcresuGNGV6xoPculnP0b1RguuZrYzdlp0x0nOGzNCVRvG2GDN5rENkP2Of+1T6ThXjnxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=KEeRUPXz; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1752655664; x=1753260464; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=77T80VOI+9iqCkLyGbExF8UYDUL9XmI3icM12b1nLCk=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
   b=KEeRUPXzkhqrQKRPB5Vlp7aMTQpDBOTzciUN3pibiT3VNlrN11LnIjnOs5U2n78zAogxPc7gg3yZXs6x/1Np9RPxUVw3FrcaKu+IsvPADopaEaeetwOoiUvrKgaKzSvvTEe2Sz0ugVYmWaEFQnJ+YK4EMqkNzA4dsEtT+ks3alY=
Received: from [10.0.5.28] ([95.168.203.222])
        by mail.sh.cz (14.1.0 build 16 ) with ASMTP (SSL) id 202507161047430369;
        Wed, 16 Jul 2025 10:47:43 +0200
Message-ID: <ad52a9ca-bbbb-469f-8b8d-6a0f24ac3175@cdn77.com>
Date: Wed, 16 Jul 2025 10:47:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 2/2] mm/vmpressure: add tracepoint for socket
 pressure detection
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>,
 David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>,
 linux-mm@kvack.org, netdev@vger.kernel.org,
 Matyas Hurtik <matyas.hurtik@cdn77.com>,
 Daniel Sedlak <danie.sedlak@cdn77.com>
References: <20250714143613.42184-1-daniel.sedlak@cdn77.com>
 <20250714143613.42184-3-daniel.sedlak@cdn77.com>
 <CAAVpQUAsZsEKQ65Kuh7wmcf6Yqq8m4im7dYFvVd1RL4QHxMN8g@mail.gmail.com>
 <8a7cea99-0ab5-4dba-bc89-62d4819531eb@cdn77.com>
 <CAAVpQUDj23KHKpMFA4J7gV=H_BnvG4z0aVxf6-B04KsYtBL=1w@mail.gmail.com>
 <CAAVpQUD=diV7aWqJqyQjL7MOZuC5xQ0AwJssPJ6vu4nYZPer+g@mail.gmail.com>
Content-Language: en-US
From: Daniel Sedlak <daniel.sedlak@cdn77.com>
In-Reply-To: <CAAVpQUD=diV7aWqJqyQjL7MOZuC5xQ0AwJssPJ6vu4nYZPer+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CTCH: RefID="str=0001.0A006397.68776744.001B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

Hi Kuniyuki,

On 7/15/25 7:46 PM, Kuniyuki Iwashima wrote:
>>>> Maybe a noob question: How can we translate the memcg ID
>>>> to the /sys/fs/cgroup/... path ?
>>>
>>> IMO this should be really named `cgroup_id` instead of `memcg_id`, but
>>> we kept the latter to keep consistency with the rest of the file.
>>>
>>> To find cgroup path you can use:
>>> - find /sys/fs/cgroup/ -inum `memcg_id`, and it will print "path" to the
>>> affected cgroup.
>>> - or you can use bpftrace tracepoint hooks and there is a helper
>>> function [1].
>>
>> Thanks, this is good to know and worth in the commit message.

Sure, I will add it to the v3.

>>>> It would be nice to place this patch first and the description of
>>>> patch 2 has how to use the new stat with this tracepoint.
>>>
>>> Sure, can do that. However, I am unsure how a good idea is to
>>> cross-reference commits, since each may go through a different tree
>>> because each commit is for a different subsystem. They would have to go
>>> through one tree, right?
>>
>> Right.
> 
> Sorry, I meant to say the two patches don't need to go along to a
> single tree and you can post them separately as each change is
> independent.

Just to make sure we are on the same page. Are you suggesting first 
posting this second patch to mm, and once (if) it gets merged, reference 
it from the first patch and send the first patch to netdev?

Thanks!
Daniel


Return-Path: <netdev+bounces-204824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E8DAFC30A
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 08:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA563AB4A4
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 06:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FAA2222AB;
	Tue,  8 Jul 2025 06:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="KXe/PGI8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECAA19D880;
	Tue,  8 Jul 2025 06:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751957144; cv=none; b=KwiAIqldfJ1baFsVljPhe/+wUP6VHjBhPAk0xDyslyE5VqZftRXLXsDsYzY25rwWl2RmkIBNFBf2sMAU3CPZL3ywSGWjQ0uoGtdklo4Lq3O4kNON/pON3izIelsDPcIiE7IyLYHlqH8iQ4v/F0HWv4yJSoAnCkDDAePIwroFplI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751957144; c=relaxed/simple;
	bh=wmP5cFWTBbzBH2NOFudolKvGxK3QvOGa7t3szEMAsHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pKfEqtuUxt9oVKSgTDzo1nN54hWDdf/vF5GrBtHmMmlOzoUr1vpqDjQiNhlajp7NNRGpYUdfIU0R1XDR3nS7XejRFy6ip7jAxjK3IRZ6Gu/+LGniDRV8HGlLu+QZbpmpKOuDmD+xYLqalpSRpbg1xRMUB330PGPz3TBCz2aWacQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=KXe/PGI8; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1751957139; x=1752561939; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=6hT6TsXcDuS9h0QK5bmrpipfbH0JFyaWHOQXJDS8eA8=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
   b=KXe/PGI8TP0lW37PtJL/BZIFE20jkbSnhhsU+GEB9mTjncDK/OzlVUF0yelLUGYSMY3OMe9qZGhJ9WkOKigc/hYWNlqc+w2JV8/Hp+IMiC8ZArj27q1TPaPrT2rdjF4lDC3duSxf74c0S2HYlJM4GWguuJtt5ry2fh/bL4PzMH4=
Received: from [10.0.5.28] ([95.168.203.222])
        by mail.sh.cz (14.1.0 build 16 ) with ASMTP (SSL) id 202507080845386842;
        Tue, 08 Jul 2025 08:45:38 +0200
Message-ID: <825c60bd-33cf-443f-a737-daa2b34e6bea@cdn77.com>
Date: Tue, 8 Jul 2025 08:45:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tcp: account for memory pressure signaled by
 cgroup
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 David Ahern <dsahern@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 Christian Hopps <chopps@labn.net>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 Matyas Hurtik <matyas.hurtik@cdn77.com>
References: <20250707105205.222558-1-daniel.sedlak@cdn77.com>
 <CANn89i+=haaDGHcG=5etnNcftKM4+YKwdiP6aJfMqrWpDgyhvg@mail.gmail.com>
Content-Language: en-US
From: Daniel Sedlak <daniel.sedlak@cdn77.com>
In-Reply-To: <CANn89i+=haaDGHcG=5etnNcftKM4+YKwdiP6aJfMqrWpDgyhvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A006372.686CBEC9.0067,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

Hi Eric,
Thank you for your feedback.

On 7/7/25 2:48 PM, Eric Dumazet wrote:
> On Mon, Jul 7, 2025 at 3:55 AM Daniel Sedlak <daniel.sedlak@cdn77.com> wrote:
>>
>> Currently, we have two memory pressure counters for TCP sockets [1],
>> which we manipulate only when the memory pressure is signalled through
>> the proto struct [2].
>>
>> However, the memory pressure can also be signaled through the cgroup
>> memory subsystem, which we do not reflect in the netstat counters.
>>
>> This patch adds a new counter to account for memory pressure signaled by
>> the memory cgroup.
> 
> OK, but please amend the changelog to describe how to look at the
> per-cgroup information.

Sure, I will explain it more in v2. I was not sure how much of a 
"storytelling" is appropriate in the commit message.


> I am sure that having some details on how to find the faulty cgroup
> would also help.

Right now, we have a rather fragile bpftrace script for that, but we 
have a WIP patch for memory management, which will expose which cgroup 
is having "difficulties", but that is still ongoing work.

Or do you have any suggestions on how we can incorporate this 
information about "this particular cgroup is under pressure" into the 
net subsystem? Maybe a log line?

Thanks!
Daniel



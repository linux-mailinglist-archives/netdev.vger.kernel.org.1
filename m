Return-Path: <netdev+bounces-128138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E80797834E
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2287328B575
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CF52B9C5;
	Fri, 13 Sep 2024 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="khX1Z+NY"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3223B4D8A7;
	Fri, 13 Sep 2024 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240019; cv=none; b=mAsHN47ak5ebvdVmatVguuVj4kXjCSSGrEqa8yxgbsBfWhAbELmVFTIzwdxbprrb/NvdN1W0hvarbCPj62SRMDqCba2yAl6EZ5id20FbldejSwej2Wk08Vvip3dvucfHTddRITpHgZY6YGX5UoT25yuf3ymSnuPeZwKgEz2QIhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240019; c=relaxed/simple;
	bh=cuAElOUq90nweBea2SqsM7p+rOnPpDpB7SfBb+vrRiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOMarMh9Af5YIP2/4Dx9aRLiRNguZOtQye1WbrMnnF1g5Y15blIOePZQxaMzretHrJGh07SlOEfjIXVeLH1Us/gXG6m2d81RrcIUeVQ7e43SnjAwPWcNAQiF/T+j3HUxiKSsgG7rM6GwuLD5onk08fubxkS28P5cACmmcvCt0zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=khX1Z+NY; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726240010; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=cuAElOUq90nweBea2SqsM7p+rOnPpDpB7SfBb+vrRiY=;
	b=khX1Z+NYcSX7I9xkUq4vy8NTl9TvkMCNgdCRX0uaw96Eah67EXYHFq9uL7Uy3uRg0UCoM9BWaOpsBBHwhJAiGFgqG8JDV1rmDloWWn4EMOl4Tm+aejoOAxrxthQQB7+WTdhtX9RCIaCUihPDyQiSQ6YMG2j1GmQQCqB+sZq1HIU=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WEv8PBG_1726240009)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 23:06:50 +0800
Date: Fri, 13 Sep 2024 23:06:49 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org,
	willemdebruijn.kernel@gmail.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
	antony.antony@secunet.com, steffen.klassert@secunet.com,
	linux-kernel@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [RFC PATCH net-next] net/udp: Add 4-tuple hash for connected
 socket
Message-ID: <20240913150649.GB14069@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20240913100941.8565-1-lulie@linux.alibaba.com>
 <CANn89iJuUFaM5whtsqA37vh6vUKUQJhgjV9Uqv6_ARpVGFjB2w@mail.gmail.com>
 <20240913142155.GA14069@linux.alibaba.com>
 <CANn89iL9EYX1EYLcrsXxz6dZX6eYyAi+u4uCZuYjg=y3tbgh6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iL9EYX1EYLcrsXxz6dZX6eYyAi+u4uCZuYjg=y3tbgh6A@mail.gmail.com>

On 2024-09-13 16:39:33, Eric Dumazet wrote:
>On Fri, Sep 13, 2024 at 4:22 PM Dust Li <dust.li@linux.alibaba.com> wrote:
>>
>> On 2024-09-13 13:49:03, Eric Dumazet wrote:
>> >On Fri, Sep 13, 2024 at 12:09 PM Philo Lu <lulie@linux.alibaba.com> wrote:
>> >>
>> >> This RFC patch introduces 4-tuple hash for connected udp sockets, to
>> >> make udp lookup faster. It is a tentative proposal and any comment is
>> >> welcome.
>> >>
>> >> Currently, the udp_table has two hash table, the port hash and portaddr
>> >> hash. But for UDP server, all sockets have the same local port and addr,
>> >> so they are all on the same hash slot within a reuseport group. And the
>> >> target sock is selected by scoring.
>> >>
>> >> In some applications, the UDP server uses connect() for each incoming
>> >> client, and then the socket (fd) is used exclusively by the client. In
>> >> such scenarios, current scoring method can be ineffcient with a large
>> >> number of connections, resulting in high softirq overhead.
>> >>
>> >> To solve the problem, a 4-tuple hash list is added to udp_table, and is
>> >> updated when calling connect(). Then __udp4_lib_lookup() firstly
>> >> searches the 4-tuple hash list, and return directly if success. A new
>> >> sockopt UDP_HASH4 is added to enable it. So the usage is:
>> >> 1. socket()
>> >> 2. bind()
>> >> 3. setsockopt(UDP_HASH4)
>> >> 4. connect()
>> >>
>> >> AFAICT the patch (if useful) can be further improved by:
>> >> (a) Support disable with sockopt UDP_HASH4. Now it cannot be disabled
>> >> once turned on until the socket closed.
>> >> (b) Better interact with hash2/reuseport. Now hash4 hardly affects other
>> >> mechanisms, but maintaining sockets in both hash4 and hash2 lists seems
>> >> unnecessary.
>> >> (c) Support early demux and ipv6.
>> >>
>> >> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
>> >
>> >Adding a 4-tuple hash for UDP has been discussed in the past.
>>
>> Thanks for the information! we don't know the history.
>>
>> >
>> >Main issue is that this is adding one cache line miss per incoming packet.
>>
>> What about adding something like refcnt in 'struct udp_hslot' ?
>> if someone enabled uhash4 on the port, we increase the refcnt.
>> Then we can check if that port have uhash4 enabled. If it's zero,
>> we can just bypass the uhash4 lookup process and goto the current
>> udp4_lib_lookup2().
>>
>
>Reading anything (thus a refcnt) in 'struct udp_hslot' will need the
>same cache line miss.

hslot2->head in 'struct udp_hslot' will be read right away in
udp4_lib_lookup2() in any case, it's just a few instructions
later(about 20). So I think cache miss should not be a problem
in this case.

>
>Note that udp_hslot already has a 'count' field

Yes, but that's for uhash/uhash2. I'm thinking of adding something
to indicate that uhash4 was enabled on this port. So we can avoid
the extra memory footprint on some cold memory. Maybe 'struct udp_hslot'
is not a good place.

Best regards,
Dust



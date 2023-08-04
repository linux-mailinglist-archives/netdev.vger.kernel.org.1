Return-Path: <netdev+bounces-24338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3716776FD49
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 11:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688621C20D23
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 09:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376F0A939;
	Fri,  4 Aug 2023 09:30:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E25A92D
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 09:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5BDC433C7;
	Fri,  4 Aug 2023 09:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691141408;
	bh=LEzM9G3hCkmW57EJI+SwefMcALPoyoAqXr/zZx0/GPw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sIGAu88hByPr2pePZ9Q6D3Op+OdIxyXOdviLitcorwMWrv8SrX0NOW/EDrU5LDMRu
	 hbC7eG8xmtLQf+t62qRsaSoAEwpDcb1klZN6MFIfPJiCvpF/2GOTg7fidd0TiMIe3s
	 TgLaTMxQvbTEMyrZ3dp3/jqeJxlPeyTi+F4GJHh+mU5+pz+mKvRL0dY/knGbTdvr26
	 Jetk/KBw7uzKMLQa8BIUZ3MuzFJ1hR98N0GM7SLCFrCndR0/I6S3MJV5J/kYCbPPHZ
	 XmxwbxAs2V855E3W7I+pwkz8Jaq4Z8N7SK70s1QU2+HqqZRpM39LnD0og0yM2QRggL
	 NxhvBslhPcR7Q==
Message-ID: <224e100b-6874-2993-a743-0a93ca0201fd@kernel.org>
Date: Fri, 4 Aug 2023 11:30:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/2] drivers: net: prevent tun_build_skb() to exceed
 the packet size limit
Content-Language: en-US
To: Andrew Kanner <andrew.kanner@gmail.com>, Jason Wang <jasowang@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, dsahern@gmail.com,
 jbrouer@redhat.com, john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com,
 Alexander Duyck <alexander.duyck@gmail.com>
References: <20230801220710.464-1-andrew.kanner@gmail.com>
 <2cb34364-0d7c-cf0a-487f-c15ba6568ac8@kernel.org>
 <CACGkMEvukuV5UZqb=MOaPqWfuJKOokZW1986GE4cRwt=Vx9Unw@mail.gmail.com>
 <64cbe991.190a0220.b646b.04c1@mx.google.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <64cbe991.190a0220.b646b.04c1@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/08/2023 19.53, Andrew Kanner wrote:
>>> Question to Jason Wang:
>>> Why fall back (to e.g. tun_alloc_skb()) when size is above PAGE_SIZE?
>>>
>>> AFAIK tun_build_skb()*can*  create get larger packets than PAGE_SIZE
>>> from it's page_frag.  Is there a reason for this limitation?
>> >> I couldn't recall but I think we can relax.
> > Jesper already sent enough info for this idea in v2, I will use it for
> the next patch/series.
> 

I have some more input and considerations when selecting the new
constant that replace PAGE_SIZE.

Lets see if Eric Dumazet or Alex Duyck disagree?
("inventors" of page_frag scheme)

The function tun_alloc_skb() uses a page_frag scheme for allocation.
The maximim size is 32768 bytes (Order-3), but using something that is
close to this max alloc size can cause memory waste and fragmentation.

My suggestion would be to use the constant SKB_MAX_ALLOC (16KiB).

Maybe Eric or Alex would recommend using something smaller? (e.g. 8192)

page_frag limit comes from:
  #define SKB_FRAG_PAGE_ORDER get_order(32768)


> Jesper, I will add this tag for this next patch/series if you don't
> mind:
> Suggested-by: Jesper Dangaard Brouer <hawk@kernel.org>

ACK



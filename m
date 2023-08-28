Return-Path: <netdev+bounces-31048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 517F578B14E
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 15:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13901280DBD
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 13:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E894A125C8;
	Mon, 28 Aug 2023 13:06:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8D546BA
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 13:06:07 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE2FC9
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 06:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=xU3UrktoxuPlKfn1FWUirA0UpmqxYaLwMPWmeTz084k=; b=EMi3agsj8gb7g9MYQww5Ql2a6b
	BNaiRCn5BC0S0OYAgSy/B1A+dFdRxoPLzyAvuOOQkZhlB7VjOeMr0xZzXx6/lPgY3+8n7BxRTSA++
	H4IaCZAlKXD5DbGwzuZDcfS8mS8RGBBBk31tKxQzS4KvsJ4mfB5lTHllBptJaQS6AIh9xYoCJSjRt
	JZ/GA/PKM7+dIKqf49xM76jwcwHLcb5XaU1p0/SR8wTQawZIAmXO8Illr4zUrpvb8XOFmS6pcXP+m
	8m7c+m0nL0QihDoC7Au+DLAE6YeBQPbczOQc8SOQ03HkxziRBza/1EKxfRA65wN7BXKyW8ngl4aQY
	x40/HqVg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qabwM-0004Ir-W4; Mon, 28 Aug 2023 15:05:59 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qabwN-000Fe1-0z; Mon, 28 Aug 2023 15:05:59 +0200
Subject: Re: [PATCH net-next 1/2] net: Fix skb consume leak in
 sch_handle_egress
To: Gal Pressman <gal@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org,
 martin.lau@linux.dev
References: <20230825134946.31083-1-daniel@iogearbox.net>
 <14c3f6ad-b264-b6f8-19a0-5bc8ad83f13f@nvidia.com>
 <6b6a21e4-8ade-9da3-2219-1ca2faa24b51@nvidia.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b16d0899-d812-6a51-047a-b5eee7badb0d@iogearbox.net>
Date: Mon, 28 Aug 2023 15:05:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6b6a21e4-8ade-9da3-2219-1ca2faa24b51@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27014/Mon Aug 28 09:38:26 2023)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/28/23 2:55 PM, Gal Pressman wrote:
> On 27/08/2023 16:55, Gal Pressman wrote:
>> On 25/08/2023 16:49, Daniel Borkmann wrote:
[...]
>>> After the fix, there are no kmemleak reports with the reproducer. This is
>>> in line with what is also done on the ingress side, and from debugging the
>>> skb_unref(skb) on dummy xmit and sch_handle_egress() side, it is visible
>>> that these are two different skbs with both skb_unref(skb) as true. The two
>>> seen skbs are due to mirred doing a skb_clone() internally as use_reinsert
>>> is false in tcf_mirred_act() for egress. This was initially reported by Gal.
>>>
>>> Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
>>> Reported-by: Gal Pressman <gal@nvidia.com>
>>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>>> Link: https://lore.kernel.org/bpf/bdfc2640-8f65-5b56-4472-db8e2b161aab@nvidia.com
>>
>> I suspect that this series causes our regression to timeout due to some
>> stuck tests :\.
>> I'm not 100% sure yet though, verifying..
> 
> Seems like everything is passing now, hope it was a false alarm, will
> report back if anything breaks.

Sounds good, thanks for your help Gal!


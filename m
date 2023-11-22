Return-Path: <netdev+bounces-50241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A60207F4FED
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 19:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6AA2814CE
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 18:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C319254BE0;
	Wed, 22 Nov 2023 18:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pj3rfBdF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76E14F5F6
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 18:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B139CC433C7;
	Wed, 22 Nov 2023 18:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700679086;
	bh=76BHoCxrsrTi+cmBAEZpQM1SFPdFzrrN19PgkN1SjQM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pj3rfBdFR3HV/NrtPuedqTQGUoja5aeucEC9LDpP8+afGo5bkR0B/O6mIOOUV96QQ
	 iEU4tscaNHpaG4QLjwvscrmbI2YTnMX5m4Ty6T0Fs2GlZy6Gg0AdhL7KRs/EUFV1JC
	 Z9/tVxYMqV2SaHAfN8R/JRUXgG1AA++C8U5TWtymUVZrMex+rbxPvAzQ0z1X4qMyHh
	 8vXx9ZuD5F+8X+xJt0TEkaaDLW5rKKmh+JlatGGrLEfzcNYw5BdppA6kpV90bruPaD
	 kMK/N87PHHmVjqJpqwUcJFk6/DNIYOUYCEtQSqxuVyhCmbu0FzAvXgJrRyf02Sfcsh
	 jcXf2bJE3HjpQ==
Message-ID: <40a08bfe-6470-4fe0-8540-81db17c2bbc4@kernel.org>
Date: Wed, 22 Nov 2023 10:51:24 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ipv6: Correct/silence an endian warning in
 ip6_multipath_l3_keys
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>, Kunwu Chan <chentao@kylinos.cn>,
 Tom Herbert <tom@herbertland.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jkbs@redhat.com, kunwu.chan@hotmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231122071924.8302-1-chentao@kylinos.cn>
 <ZV2sWSRzZhy4klrq@infradead.org>
 <37452b03-9c24-42a7-bb4f-ed19f622f0ef@kylinos.cn>
 <ZV3EmcsEqfFuvW4P@infradead.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ZV3EmcsEqfFuvW4P@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/22/23 1:06 AM, Christoph Hellwig wrote:
> On Wed, Nov 22, 2023 at 05:04:49PM +0800, Kunwu Chan wrote:
>> Hi Christoph,
>> Thanks for your reply.
>> I also can't guarantee that it's the right thing to do. Just wanted to
>> dispel this warning. If you have any better way, please let me know.
> 
> The most likely reason is that it needs an endianess conversion.  I
> don't know the answer either, but actually spending a few minutes
> trying to understand the code should allow you to find it out quickly.
> 
> Removing a warning for it's own sake when you don't understand it is
> never a good idea.
> 

We should be able to set flow_label to __be32 in flow_dissector_key_tags
(and remove a couple ntohl).

Tom: any reason not to do that?


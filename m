Return-Path: <netdev+bounces-24204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A165376F3AA
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 21:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B06E28215E
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 19:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8186025932;
	Thu,  3 Aug 2023 19:49:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F0425178
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 19:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B643C433C7;
	Thu,  3 Aug 2023 19:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691092172;
	bh=ZMqZISYHxsOJdLdGH8aCRlwzi9i8Bgd5dNN6Y5VKwAg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZaunLPI48EDbQTNHiPNCVbBlTRs6PBbT2Y8QUz+AgqK3simD/Qkjig9vwTz96tgyV
	 0F223m5mFIFbstv9QQOXntJgzKV8I/XSrLLIkNkULkpYyFT1gqUIufU4wNKl39r8Ne
	 TJj1hpxgB9fRGQm93v+Cy0mLavBIFlsJRTQmN6SHNrJvDF5eT549O/nIERVEBJdlw9
	 UUt8KLE5jhYPDmAAENcWW+Q5xcokICoYPua47owtzykXg2YPOwSJUi7ILgOmi5OvSL
	 TOcSCj78A3y78Nm0OkcJqhILQjGM6O3wcAQkbAHn3IrF56/HEC0OnyEEs7txwouMRR
	 Q0iLSqF9EYqcg==
Message-ID: <94946d6e-6ca1-84b2-fc4f-619390f9c4fe@kernel.org>
Date: Thu, 3 Aug 2023 13:49:31 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v5 2/2] selftests: fib_tests: Add a test case for
 IPv6 garbage collection
Content-Language: en-US
To: Kui-Feng Lee <sinquersw@gmail.com>, thinker.li@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, martin.lau@linux.dev,
 kernel-team@meta.com, yhs@meta.com
Cc: kuifeng@meta.com
References: <20230802004303.567266-1-thinker.li@gmail.com>
 <20230802004303.567266-3-thinker.li@gmail.com>
 <85c6c94e-1243-33ae-dadd-9bcdd7d328d1@kernel.org>
 <65a8a91f-65af-e948-1386-fc7d0d413b77@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <65a8a91f-65af-e948-1386-fc7d0d413b77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/2/23 10:09 PM, Kui-Feng Lee wrote:
> 
> 
> On 8/2/23 19:06, David Ahern wrote:
>> On 8/1/23 6:43 PM, thinker.li@gmail.com wrote:
>> \> @@ -747,6 +750,97 @@ fib_notify_test()
>>>       cleanup &> /dev/null
>>>   }
>>>   +fib6_gc_test()
>>> +{
>>> +    echo
>>> +    echo "Fib6 garbage collection test"
>>> +
>>> +    STRACE=$(which strace)
>>> +    if [ -z "$STRACE" ]; then
>>> +        echo "    SKIP: strace not found"
>>> +        ret=$ksft_skip
>>> +        return
>>> +    fi
>>> +
>>> +    EXPIRE=10
>>> +
>>> +    setup
>>> +
>>> +    set -e
>>> +
>>> +    # Check expiration of routes every 3 seconds (GC)
>>> +    $NS_EXEC sysctl -wq net.ipv6.route.gc_interval=300
>>> +
>>> +    $IP link add dummy_10 type dummy
>>> +    $IP link set dev dummy_10 up
>>> +    $IP -6 address add 2001:10::1/64 dev dummy_10
>>> +
>>> +    $NS_EXEC sysctl -wq net.ipv6.route.flush=1
>>> +
>>> +    # Temporary routes
>>> +    for i in $(seq 1 1000); do
>>> +        # Expire route after $EXPIRE seconds
>>> +        $IP -6 route add 2001:20::$i \
>>> +        via 2001:10::2 dev dummy_10 expires $EXPIRE
>>> +    done
>>> +    N_EXP=$($IP -6 route list |grep expires|wc -l)
>>> +    if [ $N_EXP -ne 1000 ]; then
>>
>> race condition here ... that you can install all 1000 routes and then
>> run this command before any expire. 10 seconds is normally more than
>> enough time, but on a loaded server it might not be. And really it does
>> not matter. What matters is that you install routes with an expires and
>> they disappear when expected - and I believe the flush below should not
>> be needed to validate they have been removed.
> 
> Without the flush below, the result will be very unpredictable or need
> to wait longer, at least two gc_interval seconds. We can
> shorten gc_interval to 10s, but we need to wait for 20s to make it
> certain. It is more predictable with the flush.
> 
> About race condition, I will remove the check.  Just like what you said,
> it is not necessary.

you do not need to measure how long it takes to remove expired routes in
a selftest; you are only testing that in fact the expired routes are
removed.

EXPIRES=1
install routes
# wait 2x expires time for removal
sleep 2
verify routes are removed.


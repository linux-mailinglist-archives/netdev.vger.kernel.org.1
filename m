Return-Path: <netdev+bounces-193926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20913AC64F7
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 10:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813EF168CA6
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 08:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000B92741AC;
	Wed, 28 May 2025 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="MaKNQq8j"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617BF274654;
	Wed, 28 May 2025 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748422735; cv=none; b=qru6ZhiRnJmjwnL/iJWVe4oMXB6L7yeijXAR0x5LaPpm+G0RtAs1lQ/6lWOyPux7Y2sW74QLi3jGupHRLMhi7L6ZqSJ5asNWQ9hZ2S1zMd8ut0nvsVPOzXaq8m5TIHs32VmTDZLrv7JjEgCjDEHN0Z7ps6jQ+DVl2SxptRKa6t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748422735; c=relaxed/simple;
	bh=MzUEp0oUJyRTES8Tk09QRNnjCyqgfx6IGrtjMCFN3KU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MN5kgq0SwQIAa01VCDGUKnvktPZIauPpcSsvI9VIK+7NlJb7kNJN3RkITC3GW4ieZbwJAIVsuedxqzk5L7BF8TlqAhHxf7VBcYYQBDp8vAu8Ab7S/klkZAQ1MyV5p6MaNrjzJyjqSIsAlC3WDXbj89Lsf49akc3V1JSz7v8/qzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=MaKNQq8j; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uKCcS-005EpJ-6s; Wed, 28 May 2025 10:58:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=0oAb0C7YV1iLSqUTjOfv41zdIB6dGnt2DLCvAuOAkVE=; b=MaKNQq8jnuhuAy7+h9hpsFqAS2
	J6f45ZwoBeOtZzv/ISfNM+VcpWiZwBdalK4CI5FM6rC5I/+lkNzE7sy08dmFCkHDAuLTl/CkC5Dw/
	WaeL7VPFr2kzohzYtCEHVtgspofbpRnhcppYM4vHxvgpg8/6GMNefYEHN6fznjA1XbWMeg+Yfr781
	dHrUKW5/f1JKYDFmfEbVG6BxX9ayvvIOheb5E9iC+o8+hr2Q7NCxSnKV8KAUCaAjd2/A0u0kXol2S
	jShwzZvK25TDVVxzzq4JN+eT9vhd/JZ/pJ7n5u63RNYiSh8verMOIy1FkEXIBIcIW3ztN21dvj+Ej
	sB68TCEA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uKCcR-0004wx-LN; Wed, 28 May 2025 10:58:39 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uKCcH-00CuGb-Ac; Wed, 28 May 2025 10:58:29 +0200
Message-ID: <54959090-440e-49e8-80b3-8eee0ef4582c@rbox.co>
Date: Wed, 28 May 2025 10:58:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net-next] vsock/test: Cover more CIDs in transport_uaf
 test
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250523-vsock-test-inc-cov-v1-1-fa3507941bbd@rbox.co>
 <limbmrszio42lvkmalapooflj5miedlszkmnnm4ckmy2upfghw@24vxuhgdji2z>
 <1f5cc46a-de4c-4361-a706-fc7fe06a7068@rbox.co>
 <gfmoupl72tjyymhwxcstwpgaabbfaz6f4v6vj4lwwzwssg577c@urkmgn7rapnj>
 <151bf5fe-c9ca-4244-aa21-8d7b8ff2470f@rbox.co>
 <skvayogoenhntikkdnqrkkjvqesmpnukjlil6reubrouo45sat@j7zw6lfthfrd>
Content-Language: pl-PL, en-GB
In-Reply-To: <skvayogoenhntikkdnqrkkjvqesmpnukjlil6reubrouo45sat@j7zw6lfthfrd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/25 10:41, Stefano Garzarella wrote:
> On Mon, May 26, 2025 at 10:44:05PM +0200, Michal Luczaj wrote:
>> On 5/26/25 16:39, Stefano Garzarella wrote:
>>> On Mon, May 26, 2025 at 02:51:18PM +0200, Michal Luczaj wrote:
>>>> On 5/26/25 10:25, Stefano Garzarella wrote:
>>>>> On Fri, May 23, 2025 at 12:31:16AM +0200, Michal Luczaj wrote:
>>>>>> Note that having only a virtio transport loaded (without vhost_vsock) is
>>>>>> unsupported; test will always pass. Depending on transports available, a
>>>>>
>>>>> Do you think it might make sense to print a warning if we are in this
>>>>> case, perhaps by parsing /proc/modules and looking at vsock
>>>>> dependencies?
>>>>
>>>> That'd nice, but would parsing /proc/modules work if a transport is
>>>> compiled-in (not a module)?
>>>
>>> Good point, I think not, maybe we can see something under /sys/module,
>>> though, I would say let's do best effort without going crazy ;-)
>>
>> Grepping through /proc/kallsyms would do the trick. Is this still a sane
>> ground?
> 
> It also depends on a config right?
> I see CONFIG_KALLSYMS, CONFIG_KALLSYMS_ALL, etc. but yeah, if it's 
> enabled, it should work for both modules and built-in transports.

FWIW, tools/testing/selftests/net/config has CONFIG_KALLSYMS=y, which
is enough for being able to check symbols like virtio_transport and
vhost_transport.

Administrative query: while net-next is closed, am I supposed to mark this
series as "RFC" and post v2 for a review as usual, or is it better to just
hold off until net-next opens?

>>>>>> +static void test_stream_transport_uaf_client(const struct test_opts *opts)
>>>>>> +{
>>>>>> +	bool tested = false;
>>>>>> +	int cid;
>>>>>> +
>>>>>> +	for (cid = VMADDR_CID_HYPERVISOR; cid <= VMADDR_CID_HOST + 1; ++cid)
>>>>>
>>>>>> +		tested |= test_stream_transport_uaf(cid);
>>>>>> +
>>>>>> +	if (!tested)
>>>>>> +		fprintf(stderr, "No transport tested\n");
>>>>>> +
>>>>>> 	control_writeln("DONE");
>>>>>
>>>>> While we're at it, I think we can remove this message, looking at
>>>>> run_tests() in util.c, we already have a barrier.
>>>>
>>>> Ok, sure. Note that console output gets slightly de-synchronised: server
>>>> will immediately print next test's prompt and wait there.
>>>
>>> I see, however I don't have a strong opinion, you can leave it that way
>>> if you prefer.
>>
>> How about adding a sync point to run_tests()? E.g.
> 
> Yep, why not, of course in another series :-)
> 
> And if you like, you can remove that specific sync point in that series 
> and check also other tests, but I think we have only that one.

OK, I'll leave that for later.

Thanks,
Michal



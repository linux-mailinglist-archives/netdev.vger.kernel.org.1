Return-Path: <netdev+bounces-193515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B0EAC448B
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 22:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90B53AF15A
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 20:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199E123E356;
	Mon, 26 May 2025 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="C6I22oNA"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C002147EF
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 20:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748292265; cv=none; b=NoKvHJ6/Ek5pKngmw9HHHiZRNF1mB8KmKFFjQmLBeFX6qyMB0v7gwByUYWVxXr4DQIievmJJdYa8be17rhz1pGbl9UpqmkfS4dtbFYh4bBlbIuI2JUxGN4c6MD9ROoX3dQqsQNg+nVY3GuuTFAhGLH9XJ8pCuDU7JAMrEo6iOzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748292265; c=relaxed/simple;
	bh=AzHiRE5DxccH0Bzd1aTfIjXj6/9DytdedTfIvmOw/LM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CU/th3SSfKPFOlb0OJPPiULDFe/0T8sSnJ30qHePTBYdoMJ5lMnSzcei/sQgq05mdT2bRuf73Fvm2gZx0gdq9RoFWMqq/cU1KPE/2euFjEeJlydhzzUHP75941ghOWF+T7FsJ+ew/GUSHkT5/RCcsFRuGOLMJCatXnzPj0RJCmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=C6I22oNA; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uJegD-000Z6T-5x; Mon, 26 May 2025 22:44:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=uz4Vu/ISMkzQ793816pVBACGXuYBKQfBQsZEMTq5ytE=; b=C6I22oNAw1YNt9k8nGPGZB1iib
	bk5hFcF0CwbTu0ozMDx6LfzVe5acNt+uDmLbz7lVv4JZTeHjgbT+zfBQr855M63GSQ6z3hQoVPhzG
	mw5E3tJjznlEn/D1xx2Aad2pvOHFZboJIiBW81aVNGALt51VjKfTNxze2UQBa9QttF0m6XTBQX8+z
	iSn5jG+zvE8INPTcBPkrXmFhelxsogi/KtgbfznRPQvjj0ak8LOWL6+rNSlpqBGW5/14FHSNBOcBh
	nO6othcbH3pgeDX3RTQhC1c5aYlCla6GqvS2nWTLOg8s9sBMPjqS3t6a+6dq37Ft+Vuu3s3+9NZI2
	yU6oXcbg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uJegC-0004yz-J4; Mon, 26 May 2025 22:44:16 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uJeg2-001oJV-CI; Mon, 26 May 2025 22:44:06 +0200
Message-ID: <151bf5fe-c9ca-4244-aa21-8d7b8ff2470f@rbox.co>
Date: Mon, 26 May 2025 22:44:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] vsock/test: Cover more CIDs in transport_uaf
 test
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250523-vsock-test-inc-cov-v1-1-fa3507941bbd@rbox.co>
 <limbmrszio42lvkmalapooflj5miedlszkmnnm4ckmy2upfghw@24vxuhgdji2z>
 <1f5cc46a-de4c-4361-a706-fc7fe06a7068@rbox.co>
 <gfmoupl72tjyymhwxcstwpgaabbfaz6f4v6vj4lwwzwssg577c@urkmgn7rapnj>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <gfmoupl72tjyymhwxcstwpgaabbfaz6f4v6vj4lwwzwssg577c@urkmgn7rapnj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/25 16:39, Stefano Garzarella wrote:
> On Mon, May 26, 2025 at 02:51:18PM +0200, Michal Luczaj wrote:
>> On 5/26/25 10:25, Stefano Garzarella wrote:
>>> On Fri, May 23, 2025 at 12:31:16AM +0200, Michal Luczaj wrote:
>>>> Increase the coverage of test for UAF due to socket unbinding, and losing
>>>> transport in general. It's a follow up to commit 301a62dfb0d0 ("vsock/test:
>>>> Add test for UAF due to socket unbinding") and discussion in [1].
>>>>
>>>> The idea remains the same: take an unconnected stream socket with a
>>>> transport assigned and then attempt to switch the transport by trying (and
>>>> failing) to connect to some other CID. Now do this iterating over all the
>>>> well known CIDs (plus one).
>>>>
>>>> Note that having only a virtio transport loaded (without vhost_vsock) is
>>>> unsupported; test will always pass. Depending on transports available, a
>>>
>>> Do you think it might make sense to print a warning if we are in this
>>> case, perhaps by parsing /proc/modules and looking at vsock
>>> dependencies?
>>
>> That'd nice, but would parsing /proc/modules work if a transport is
>> compiled-in (not a module)?
> 
> Good point, I think not, maybe we can see something under /sys/module,
> though, I would say let's do best effort without going crazy ;-)

Grepping through /proc/kallsyms would do the trick. Is this still a sane
ground?

>> And I've just realized feeding VMADDR_CID_HYPERVISOR to bind() doesn't make
>> sense at all. Will fix.
> 
> Yeah, we don't support it for now and maybe it makes sense only in the 
> VMM code (e.g. QEMU), but it's a test, so if you want to leave to stress 
> it more, I don't think it's a big issue.

All right, I'll keep it then. Fails quickly and politely anyway.

>>>> +static void test_stream_transport_uaf_client(const struct test_opts *opts)
>>>> +{
>>>> +	bool tested = false;
>>>> +	int cid;
>>>> +
>>>> +	for (cid = VMADDR_CID_HYPERVISOR; cid <= VMADDR_CID_HOST + 1; ++cid)
>>>
>>>> +		tested |= test_stream_transport_uaf(cid);
>>>> +
>>>> +	if (!tested)
>>>> +		fprintf(stderr, "No transport tested\n");
>>>> +
>>>> 	control_writeln("DONE");
>>>
>>> While we're at it, I think we can remove this message, looking at
>>> run_tests() in util.c, we already have a barrier.
>>
>> Ok, sure. Note that console output gets slightly de-synchronised: server
>> will immediately print next test's prompt and wait there.
> 
> I see, however I don't have a strong opinion, you can leave it that way 
> if you prefer.

How about adding a sync point to run_tests()? E.g.

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index de25892f865f..79a02b52dc19 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -451,6 +451,9 @@ void run_tests(const struct test_case *test_cases,
 			run(opts);

 		printf("ok\n");
+
+		control_writeln("RUN_TESTS_SYNC");
+		control_expectln("RUN_TESTS_SYNC");
 	}
 }



Return-Path: <netdev+bounces-193432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F7BAC3F87
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 14:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 836EE3AAE3B
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 12:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B2E202C3A;
	Mon, 26 May 2025 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="B93Bjv84"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957E61F8AD3;
	Mon, 26 May 2025 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748263910; cv=none; b=Xtzq0LNq9ed6pAJh8RK9zj6tsFlMEnmzkuXngow1mJs6CuG5xryvvL08maC/o91Ryh4/MuScb8/VzQAQPmZhVwumqzkVFyKJMZwKRLHtQXIebslj4Z7+cyulmf7CXL/N5xUKrin5frRnI73AKsVm6BDDM/61/4ynZBsJFGmF7LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748263910; c=relaxed/simple;
	bh=Srrw0lhNTQ8jQKndSUyuxD3sWb/xKNMVmvUkf5KQQFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=duVbC3HwiNrmdWu9chutYuD+5yrX62Upmcu2lfcBTullkFZyZAtw8YA8NvNSOCyEycACHUx40q/2RjXoImfMhmTpmEm+iRUF1ZwbUNF4M2V5j6jcpvbLDVCvt/yNZ7702V5zoZEbbyeXe4od+OpigcUj8UXDyRu+ysV/guQgvuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=B93Bjv84; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uJXIm-00H94C-UF; Mon, 26 May 2025 14:51:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=7GFPaRp+dFRjVa/eZf0+QeVTps4jC/9ydmcDiGh1F44=; b=B93Bjv84FwS2StimGuXuPbbDfC
	3bgEO7aP7jqDb4+cKLbro7IswMov5QfFkD0r8x/C9NwD0PENE8NOVX2eCWTSb5Ptbi9a60WMR3STI
	eetsXy81sjlgVRehCp/eGFI+r3X7xx7UElcX14cG1+/1gm8oRWrNCFdtIhLlEZ1gyHJT1svCug6D7
	hyJ2Vwv7md4i2YqQpD1zh7SlAVz8bJzzdF+L4tq6qmRNW3cHPQvxorLPQ7W8NBmeyLik26GA3YVpW
	YCfsct5I+8W00YNLprUPRJ/ds6TI7moFWAJ/BJfEWBWJjuAMnuyZG4N4NgNcF79L/ICgjx2/LpfBZ
	x6DedtAg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uJXIk-00027V-RN; Mon, 26 May 2025 14:51:36 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uJXIV-00GxJM-Cj; Mon, 26 May 2025 14:51:19 +0200
Message-ID: <1f5cc46a-de4c-4361-a706-fc7fe06a7068@rbox.co>
Date: Mon, 26 May 2025 14:51:18 +0200
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
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <limbmrszio42lvkmalapooflj5miedlszkmnnm4ckmy2upfghw@24vxuhgdji2z>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/25 10:25, Stefano Garzarella wrote:
> On Fri, May 23, 2025 at 12:31:16AM +0200, Michal Luczaj wrote:
>> Increase the coverage of test for UAF due to socket unbinding, and losing
>> transport in general. It's a follow up to commit 301a62dfb0d0 ("vsock/test:
>> Add test for UAF due to socket unbinding") and discussion in [1].
>>
>> The idea remains the same: take an unconnected stream socket with a
>> transport assigned and then attempt to switch the transport by trying (and
>> failing) to connect to some other CID. Now do this iterating over all the
>> well known CIDs (plus one).
>>
>> Note that having only a virtio transport loaded (without vhost_vsock) is
>> unsupported; test will always pass. Depending on transports available, a
> 
> Do you think it might make sense to print a warning if we are in this 
> case, perhaps by parsing /proc/modules and looking at vsock 
> dependencies?

That'd nice, but would parsing /proc/modules work if a transport is
compiled-in (not a module)?

>> +static bool test_stream_transport_uaf(int cid)
>> {
>> +	struct sockaddr_vm addr = {
>> +		.svm_family = AF_VSOCK,
>> +		.svm_cid = cid,
>> +		.svm_port = VMADDR_PORT_ANY
>> +	};
>> 	int sockets[MAX_PORT_RETRIES];
>> -	struct sockaddr_vm addr;
>> -	int fd, i, alen;
>> +	socklen_t alen;
>> +	int fd, i, c;
>>
>> -	fd = vsock_bind(VMADDR_CID_ANY, VMADDR_PORT_ANY, SOCK_STREAM);
>> +	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
>> +	if (fd < 0) {
>> +		perror("socket");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr))) {
>> +		if (errno != EADDRNOTAVAIL) {
>> +			perror("Unexpected bind() errno");
>> +			exit(EXIT_FAILURE);
>> +		}
>> +
>> +		close(fd);
>> +		return false;
> 
> Perhaps we should mention in the commit or in a comment above this 
> function, what we return and why we can expect EADDRNOTAVAIL.

Something like

/* Probe for a transport by attempting a local CID bind. Unavailable
 * transport (or more specifically: an unsupported transport/CID
 * combination) results in EADDRNOTAVAIL, other errnos are fatal.
 */

?

And I've just realized feeding VMADDR_CID_HYPERVISOR to bind() doesn't make
sense at all. Will fix.

> What about adding a vsock_bind_try() in util.c that can fail returning
> errno, so we can share most of the code with vsock_bind()?

Ah, yes, good idea.

>> +static void test_stream_transport_uaf_client(const struct test_opts *opts)
>> +{
>> +	bool tested = false;
>> +	int cid;
>> +
>> +	for (cid = VMADDR_CID_HYPERVISOR; cid <= VMADDR_CID_HOST + 1; ++cid)
> 
>> +		tested |= test_stream_transport_uaf(cid);
>> +
>> +	if (!tested)
>> +		fprintf(stderr, "No transport tested\n");
>> +
>> 	control_writeln("DONE");
> 
> While we're at it, I think we can remove this message, looking at 
> run_tests() in util.c, we already have a barrier.

Ok, sure. Note that console output gets slightly de-synchronised: server
will immediately print next test's prompt and wait there.

Thanks,
Michal



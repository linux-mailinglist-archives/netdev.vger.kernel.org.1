Return-Path: <netdev+bounces-195144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 142EAACE4A7
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 21:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47AC41898473
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 19:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5941FAC4A;
	Wed,  4 Jun 2025 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ZLWeHm8T"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9C2175A5;
	Wed,  4 Jun 2025 19:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749064303; cv=none; b=KaYbRhZINkg9osI44jZetCMqU+eSTS5UCkKL6x+j0ANSFVZn0P5xOauz8lgBfPOMK1dqTPjbMTEHkACiwmJgLBxS8GCwAStDONR90GhXcPpDJtBqcNH9AxfrDo5/xo8EivVHXeYh+i/RXN6Bd387IGf9GyJm//ke5dp1AUmsgqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749064303; c=relaxed/simple;
	bh=Ksjn+bV45i0A9pWDjuu7EeJglLRGYHw1mTFGii9v/S8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YsZEZGeXoLuw21H3wGM0YCzI2Yfpsezdjtq+Evm/xMJ/U4hFPfs93omRF2fqYbDZ3/Kv7kVDimqF+tbGPYd7G5Ofo/0Lo84S3WJx8Yzsoj85pgqnp4zgJaKFEHPamp974vJ6ZlfO1MBsvU8fp+EgD5JyNoo9TCl3nztkaCAGPhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ZLWeHm8T; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uMtWU-008zin-8O; Wed, 04 Jun 2025 21:11:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=HqjKTGpDcvQPnWOU38KH5Qrtb2k6G5HRlDi/DrOBjL8=; b=ZLWeHm8TTlvp9wvbq4hTVuTT2y
	adNm+N9/8tfgRXt6b0/D9y1J1AfhASRyn2u79a2xBMsNfrqUUikNVcdAalbvKaoxAmBhhE4wzVRcc
	IWLMPhfF7MaQa2mYYgnvjftTG8p6HP8Dq9qqR0y3rWeUtXSs/bvdQ85Lb2DahwkxEvALD/S0BT/S0
	Lq/6vMsg/tueKD+fmmqz/w2TTnl11/XatsrBw6f1r5YjbTAYsrP7yj2WkGIRxNm/d3VgtCtjBfduj
	zm6clatigKJb973ckW5njspOT5w843dmJib3lnI/+yzHPsGfi6ioCRuOdW/NK6FyxVn8UqigloidY
	v6JddLZA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uMtWS-0000r5-Sb; Wed, 04 Jun 2025 21:11:37 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uMtWQ-00Dqjl-OK; Wed, 04 Jun 2025 21:11:34 +0200
Message-ID: <77c48b6d-4539-4d01-bd7f-7b5415b7b995@rbox.co>
Date: Wed, 4 Jun 2025 21:11:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v2 3/3] vsock/test: Cover more CIDs in
 transport_uaf test
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250528-vsock-test-inc-cov-v2-0-8f655b40d57c@rbox.co>
 <20250528-vsock-test-inc-cov-v2-3-8f655b40d57c@rbox.co>
 <ocuwnpdoo7yxoqiockcs7yopoayg5x4b747ksvy4kmk3ds6lb3@f7zgcx7gigt5>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <ocuwnpdoo7yxoqiockcs7yopoayg5x4b747ksvy4kmk3ds6lb3@f7zgcx7gigt5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/25 11:37, Stefano Garzarella wrote:
> On Wed, May 28, 2025 at 10:44:43PM +0200, Michal Luczaj wrote:
>> +static bool test_stream_transport_uaf(int cid)
>> {
>> 	int sockets[MAX_PORT_RETRIES];
>> 	struct sockaddr_vm addr;
>> -	int fd, i, alen;
>> +	socklen_t alen;
>> +	int fd, i, c;
>> +	bool ret;
>> +
>> +	/* Probe for a transport by attempting a local CID bind. Unavailable
>> +	 * transport (or more specifically: an unsupported transport/CID
>> +	 * combination) results in EADDRNOTAVAIL, other errnos are fatal.
>> +	 */
>> +	fd = vsock_bind_try(cid, VMADDR_PORT_ANY, SOCK_STREAM);
>> +	if (fd < 0) {
>> +		if (errno != EADDRNOTAVAIL) {
>> +			perror("Unexpected bind() errno");
>> +			exit(EXIT_FAILURE);
>> +		}
>>
>> -	fd = vsock_bind(VMADDR_CID_ANY, VMADDR_PORT_ANY, SOCK_STREAM);
>> +		return false;
>> +	}
>>
>> 	alen = sizeof(addr);
>> 	if (getsockname(fd, (struct sockaddr *)&addr, &alen)) {
>> @@ -1735,38 +1746,73 @@ static void test_stream_transport_uaf_client(const struct test_opts *opts)
>> 		exit(EXIT_FAILURE);
>> 	}
>>
>> +	/* Drain the autobind pool; see __vsock_bind_connectible(). */
>> 	for (i = 0; i < MAX_PORT_RETRIES; ++i)
>> -		sockets[i] = vsock_bind(VMADDR_CID_ANY, ++addr.svm_port,
>> -					SOCK_STREAM);
>> +		sockets[i] = vsock_bind(cid, ++addr.svm_port, SOCK_STREAM);
>>
>> 	close(fd);
>> -	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
>> +	fd = socket(AF_VSOCK, SOCK_STREAM | SOCK_NONBLOCK, 0);
> 
> Why we need this change?

It's for the (void)connect() below (not the connect() expecting early
EADDRNOTAVAIL, the second one). We're not connecting to anything anyway, so
there's no point entering the main `while (sk->sk_state != TCP_ESTABLISHED`
loop in vsock_connect().

>> 	if (fd < 0) {
>> 		perror("socket");
>> 		exit(EXIT_FAILURE);
>> 	}
>>
>> -	if (!vsock_connect_fd(fd, addr.svm_cid, addr.svm_port)) {
>> -		perror("Unexpected connect() #1 success");
>> +	/* Assign transport, while failing to autobind. Autobind pool was
>> +	 * drained, so EADDRNOTAVAIL coming from __vsock_bind_connectible() is
>> +	 * expected.
>> +	 */
>> +	addr.svm_port = VMADDR_PORT_ANY;

(Ugh, this line looks useless...)

>> +	if (!connect(fd, (struct sockaddr *)&addr, alen)) {
>> +		fprintf(stderr, "Unexpected connect() success\n");
>> +		exit(EXIT_FAILURE);
>> +	} else if (errno == ENODEV) {
>> +		/* Handle unhappy vhost_vsock */
> 
> Why it's unhappy? No peer?

It's the case of test_stream_transport_uaf(VMADDR_CID_HOST) when only
vhost_vsock transport is loaded. Before we even reach (and fail)
vsock_auto_bind(), vsock_assign_transport() fails earlier: `new_transport`
gets set to `transport_g2h` (NULL) and then it's `if (!new_transport)
return -ENODEV`. So the idea was to swallow this errno and let the caller
report that nothing went through.

I guess we can narrow this down to `if (errno == ENODEV && cid ==
VMADDR_CID_HOST)`.

>> +		ret = false;
>> +		goto cleanup;
>> +	} else if (errno != EADDRNOTAVAIL) {
>> +		perror("Unexpected connect() errno");
>> 		exit(EXIT_FAILURE);
>> 	}
>>
>> -	/* Vulnerable system may crash now. */
>> -	if (!vsock_connect_fd(fd, VMADDR_CID_HOST, VMADDR_PORT_ANY)) {
>> -		perror("Unexpected connect() #2 success");
>> -		exit(EXIT_FAILURE);
>> +	/* Reassign transport, triggering old transport release and
>> +	 * (potentially) unbinding of an unbound socket.
>> +	 *
>> +	 * Vulnerable system may crash now.
>> +	 */
>> +	for (c = VMADDR_CID_HYPERVISOR; c <= VMADDR_CID_HOST + 1; ++c) {
>> +		if (c != cid) {
>> +			addr.svm_cid = c;
>> +			(void)connect(fd, (struct sockaddr *)&addr, alen);
>> +		}
>> 	}
>>
>> +	ret = true;
>> +cleanup:
>> 	close(fd);
>> 	while (i--)
>> 		close(sockets[i]);
>>
>> -	control_writeln("DONE");
>> +	return ret;
>> }
>>
>> -static void test_stream_transport_uaf_server(const struct test_opts *opts)
>> +/* Test attempts to trigger a transport release for an unbound socket. This can
>> + * lead to a reference count mishandling.
>> + */
>> +static void test_stream_transport_uaf_client(const struct test_opts *opts)
>> {
>> -	control_expectln("DONE");
>> +	bool tested = false;
>> +	int cid, tr;
>> +
>> +	for (cid = VMADDR_CID_HYPERVISOR; cid <= VMADDR_CID_HOST + 1; ++cid)
>> +		tested |= test_stream_transport_uaf(cid);
>> +
>> +	tr = get_transports();
>> +	if (!tr)
>> +		fprintf(stderr, "No transports detected\n");
>> +	else if (tr == TRANSPORT_VIRTIO)
>> +		fprintf(stderr, "Setup unsupported: sole virtio transport\n");
>> +	else if (!tested)
>> +		fprintf(stderr, "No transports tested\n");
>> }
>>
>> static void test_stream_connect_retry_client(const struct test_opts *opts)
>> @@ -2034,7 +2080,6 @@ static struct test_case test_cases[] = {
>> 	{
>> 		.name = "SOCK_STREAM transport release use-after-free",
>> 		.run_client = test_stream_transport_uaf_client,
>> -		.run_server = test_stream_transport_uaf_server,
> 
> Overall LGTM. I was not able to apply, so I'll test next version.

Bummer, I'll make sure to rebase.

Thanks,
Michal



Return-Path: <netdev+bounces-175972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D556A68177
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 01:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B120917FAC7
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 00:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359E31C6B4;
	Wed, 19 Mar 2025 00:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="abhxtknv"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3161B95B;
	Wed, 19 Mar 2025 00:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742344090; cv=none; b=AaJtoisglRicA8tV10WFgwxDrntLjgjrS6C43xWGswQEgvYaIensRip69YzD4As0p4wYH/WTBFWWQthK/Y7dRuhtGQPIijiz9u+2CDyE7xlgYkKcoPjCXrO/fXWvotTkS0EVcnXL4ZT5REaaUCfNcL2vP6/n3a2L6AeD95mOnFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742344090; c=relaxed/simple;
	bh=m0Zz9gxVif1U4ymWLXs8jG0OQ1KBLhLy2E/YTmAsNR8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=S/GDSOntwVCKwC0iN5L1TRpAdjWfRh8dCS3n0mdaH+qI9cxMnJEMLcldnJ+7zVoRC58owTCCmXuqISq9e1ai5GGFGCXtMQ97sl+FDU8qk0uzjJ8ie5Pjn/U6i1oE0O5ritRd+iY3lyUtT8hMIwXIbyohoPHEYuwpLKlMIuo3ntg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=abhxtknv; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tuhHo-001bZs-4O; Wed, 19 Mar 2025 01:27:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=YqOpd7H4mqMcldHN5Q5/K00SxC1j9Za4w+dyTwnLJtI=; b=abhxtknvG7Nj/ksGOPnNThzz2M
	YCf5dzpKvGraTfhZrsADYE6/4hh7CC3MNqmN3qtaq7+/WBqNooANT58rW6Iw8I8yxNr7ZsnNRJdyv
	KLwZToNs5VYCBMgL76JdtlcrMBNkJl1PcHf/0MyrnjTCf7vZh8mg3EsqXPgIOGDYl3+qq7GqgffQQ
	KzoumfKfGNOLsM2R2XlHBK3jx4lJr8nP2ik2tR9TwaeQ3MxOKs9lWOlbJitPqyOwpWLukrj2sBk5I
	XZZEsLrbNbVQePXd6w+cxMoSbe1fTqvsVBvjjqsyJCCB+hWu6Wrt5DA0rlkVx++LzS1oFmvOUOIxi
	O/oKGr0Q==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tuhHn-000887-NH; Wed, 19 Mar 2025 01:27:55 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tuhHU-0053Vx-FG; Wed, 19 Mar 2025 01:27:36 +0100
Message-ID: <85a034b7-a22d-438f-802e-ac193099dbe7@rbox.co>
Date: Wed, 19 Mar 2025 01:27:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net-next v2] vsock/test: Add test for null ptr deref when
 transport changes
To: Luigi Leonardi <leonardi@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hyunwoo Kim <v4bel@theori.io>
References: <20250314-test_vsock-v2-1-3c0a1d878a6d@redhat.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <20250314-test_vsock-v2-1-3c0a1d878a6d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/25 10:27, Luigi Leonardi wrote:
> Add a new test to ensure that when the transport changes a null pointer
> dereference does not occur[1].
> 
> Note that this test does not fail, but it may hang on the client side if
> it triggers a kernel oops.
> 
> This works by creating a socket, trying to connect to a server, and then
> executing a second connect operation on the same socket but to a
> different CID (0). This triggers a transport change. If the connect
> operation is interrupted by a signal, this could cause a null-ptr-deref.

Just to be clear: that's the splat, right?

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
CPU: 2 UID: 0 PID: 463 Comm: kworker/2:3 Not tainted
Workqueue: vsock-loopback vsock_loopback_work
RIP: 0010:vsock_stream_has_data+0x44/0x70
Call Trace:
 virtio_transport_do_close+0x68/0x1a0
 virtio_transport_recv_pkt+0x1045/0x2ae4
 vsock_loopback_work+0x27d/0x3f0
 process_one_work+0x846/0x1420
 worker_thread+0x5b3/0xf80
 kthread+0x35a/0x700
 ret_from_fork+0x2d/0x70
 ret_from_fork_asm+0x1a/0x30

> ...
> +static void test_stream_transport_change_client(const struct test_opts *opts)
> +{
> +	__sighandler_t old_handler;
> +	pid_t pid = getpid();
> +	pthread_t thread_id;
> +	time_t tout;
> +
> +	old_handler = signal(SIGUSR1, test_transport_change_signal_handler);
> +	if (old_handler == SIG_ERR) {
> +		perror("signal");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	if (pthread_create(&thread_id, NULL, test_stream_transport_change_thread, &pid)) {
> +		perror("pthread_create");

Does pthread_create() set errno on failure?

> +		exit(EXIT_FAILURE);
> +	}
> +
> +	tout = current_nsec() + TIMEOUT * NSEC_PER_SEC;

Isn't 10 seconds a bit excessive? I see the oops pretty much immediately.

> +	do {
> +		struct sockaddr_vm sa = {
> +			.svm_family = AF_VSOCK,
> +			.svm_cid = opts->peer_cid,
> +			.svm_port = opts->peer_port,
> +		};
> +		int s;
> +
> +		s = socket(AF_VSOCK, SOCK_STREAM, 0);
> +		if (s < 0) {
> +			perror("socket");
> +			exit(EXIT_FAILURE);
> +		}
> +
> +		connect(s, (struct sockaddr *)&sa, sizeof(sa));
> +
> +		/* Set CID to 0 cause a transport change. */
> +		sa.svm_cid = 0;
> +		connect(s, (struct sockaddr *)&sa, sizeof(sa));
> +
> +		close(s);
> +	} while (current_nsec() < tout);
> +
> +	if (pthread_cancel(thread_id)) {
> +		perror("pthread_cancel");

And errno here.

> +		exit(EXIT_FAILURE);
> +	}
> +
> +	/* Wait for the thread to terminate */
> +	if (pthread_join(thread_id, NULL)) {
> +		perror("pthread_join");

And here.
Aaand I've realized I've made exactly the same mistake elsewhere :)

> ...
> +static void test_stream_transport_change_server(const struct test_opts *opts)
> +{
> +	time_t tout = current_nsec() + TIMEOUT * NSEC_PER_SEC;
> +
> +	do {
> +		int s = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
> +
> +		close(s);
> +	} while (current_nsec() < tout);
> +}

I'm not certain you need to re-create the listener or measure the time
here. What about something like

	int s = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
	control_expectln("DONE");
	close(s);

Thanks,
Michal


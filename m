Return-Path: <netdev+bounces-151523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 239F39EFF06
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 23:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7AE188DB71
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 22:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D1D1D9341;
	Thu, 12 Dec 2024 22:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="JMSxfeV2"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5021C9B62
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 22:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734041570; cv=none; b=CWpNqGw8Z0tJweY2j72FFk9c4q2SZP1jvRaNT2mfMmwsgmVAn3WmbI+ptNbVyjM7tqUrvJor6HU5cZi7yy9028Wrs7UEGN65VobCqlwgjcUGPDEvA/j4SL/tpm2tK4zswbQcbmaaHX2Ui8RzGrrHubixx5bm9xoBXYbcPT1O9NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734041570; c=relaxed/simple;
	bh=BOpmmUeZCqjeJ7+RKs10dFqB97gFG1vMWXVp9qLeTTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ah3j94diX2MYuqiUZVRUWM3Y3pTtVFYNg5wjGWAjvLsGIbE/xbYQH2j43rMJMj3iyVgqhMVUeJVN9dYwFI5QDw8enuH1NOd2r4ewxWOpYdguM7FEHKLRidVL1cd8r1D+GNz3axP/4LJjShNNdUi8lkKDmcfb//Yv5uBCX1f9BZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=JMSxfeV2; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tLrQA-005Mp0-N8
	for netdev@vger.kernel.org; Thu, 12 Dec 2024 23:12:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=7bUyUz/86XjZKez7Q9dcH/GELtitlr142+Bys+TPLko=; b=JMSxfeV2vMZ4pRGtQ/ReVhbL1+
	x4XaPCfOV92T24yaq3IPO+G7KWZTgULH0MZ624ynVcPASzycTaLJa/Rg/IVQxXuSq0kzQ5Dk2gyhM
	2O5KLAeWJKsPly1GwgI3pB4JtaPNMt+f1vSxEVgQW3y3v8hEYH6GU8BSYJCk5EwdDyiAhbSUkVPxv
	ctiR8fbyB/xzEqA/XK4KQqVVEcK2osqZDSiFTn5k/Apoz3ridSuYKibASHxWCo4zSpnxmh2xlS3Cx
	GE4VTCFnKEMWvNThr2Qm+Okf2c6sOSoMQRn2W34FCj7E/LQwC8P1bwtMaBxgeC6uyBZJWXrDOTw6c
	TGVDcnuQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tLrQA-0000J3-9D; Thu, 12 Dec 2024 23:12:34 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tLrPw-008VTU-9o; Thu, 12 Dec 2024 23:12:20 +0100
Message-ID: <a8fa27ad-b1f5-4565-a3db-672f5b8a119a@rbox.co>
Date: Thu, 12 Dec 2024 23:12:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] vsock/test: Add test for accept_queue memory
 leak
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org
References: <20241206-test-vsock-leaks-v1-0-c31e8c875797@rbox.co>
 <20241206-test-vsock-leaks-v1-2-c31e8c875797@rbox.co>
 <uyzzicjukysdqzf5ls5s5qp26hfqgrwjz4ahbnb6jp36lzazck@67p3eejksk56>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <uyzzicjukysdqzf5ls5s5qp26hfqgrwjz4ahbnb6jp36lzazck@67p3eejksk56>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/24 17:18, Stefano Garzarella wrote:
> On Fri, Dec 06, 2024 at 07:34:52PM +0100, Michal Luczaj wrote:
>> [...]
>> +#define ACCEPTQ_LEAK_RACE_TIMEOUT 2 /* seconds */
>> +
>> +static void test_stream_leak_acceptq_client(const struct test_opts *opts)
>> +{
>> +	struct sockaddr_vm addr = {
>> +		.svm_family = AF_VSOCK,
>> +		.svm_port = opts->peer_port,
>> +		.svm_cid = opts->peer_cid
>> +	};
>> +	time_t tout;
>> +	int fd;
>> +
>> +	tout = current_nsec() + ACCEPTQ_LEAK_RACE_TIMEOUT * NSEC_PER_SEC;
>> +	do {
>> +		control_writeulong(1);
> 
> Can we use control_writeln() and control_expectln()?

Please see below.

>> +
>> +		fd = socket(AF_VSOCK, SOCK_STREAM, 0);
>> +		if (fd < 0) {
>> +			perror("socket");
>> +			exit(EXIT_FAILURE);
>> +		}
>> +
> 
> Do we need another control messages (server -> client) here to be sure
> the server is listening?

Ahh, I get your point.

>> +		connect(fd, (struct sockaddr *)&addr, sizeof(addr));
> 
> What about using `vsock_stream_connect` so you can remove a lot of
> code from this function (e.g. sockaddr_vm, socket(), etc.)
>
> We only need to add `control_expectln("LISTENING")` in the server which
> should also fix my previous comment.

Sure, I followed your suggestion with

	tout = current_nsec() + ACCEPTQ_LEAK_RACE_TIMEOUT * NSEC_PER_SEC;
	do {
		control_writeulong(RACE_CONTINUE);
		fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
		if (fd >= 0)
			close(fd);
	} while (current_nsec() < tout);
	control_writeulong(RACE_DONE);

vs.

	while (control_readulong() == RACE_CONTINUE) {
		fd = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
		control_writeln("LISTENING");
		close(fd);
	}

and it works just fine.

>> +static void test_stream_leak_acceptq_server(const struct test_opts *opts)
>> +{
>> +	int fd;
>> +
>> +	while (control_readulong()) {
> 
> Ah I see, the loop is easier by sending a number.
> I would just add some comments when we send 1 and 0 to explain it.

How about the #defines above?

Thanks!
Michal



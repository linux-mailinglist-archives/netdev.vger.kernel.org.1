Return-Path: <netdev+bounces-160416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EDCA19985
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 21:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D663A9928
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 20:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA5F216386;
	Wed, 22 Jan 2025 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Xcj7x+zf"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A771607AC
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 20:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737576718; cv=none; b=EENgkV3zxAipfsGOg7Dk4nv88sGwHuoy6Vo/LK+h05nvyfyQcmPz3ZeUWHpN/HOGnARl/I7q6FK5VCj7Uc54LgwgA8oc3f0k/nmtfqcNFZuQLE2QjaU+il4mM6IqyDItc+hRwut7wdgDmbwMIWLQYUF/6pvJa6LmQthesg2tQYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737576718; c=relaxed/simple;
	bh=AFCdjrgOqI0IPLvlgUMdfd2YwV19qX1SDl0iqAvVvaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtD8x0uymKBIJeNvvv+Zj4vSsmXuZiqh18SStjynOLuR/PMcjABfc6sFjEa3EYHsuI1UcorIQQCk46eGq8eT/tpS+ni+1xVLvMJmcXzr6WFr2BnAcw7ZMjSq6DKYQTPX/HKN0HVYREcWvN+HZq/lNeJEY6mbOFGByLN9QTnk6Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Xcj7x+zf; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tah4l-004LGd-Di; Wed, 22 Jan 2025 21:11:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=IM99RUdLWKXJsW7aJ9XUa5XofbUJ2Wamp21J+QqWWRQ=; b=Xcj7x+zf6uryhSkuHvGmGN4nj4
	0aPG9NmXjitkBooL9yCn13HJt61Uc0JLsOH0B6FOXD6I2CP5mD1ppd1NSJpJiGD76+gBQFPAr1jHO
	mLzjpmzLd7sUGBXzT2J7DqJK7pw639euucp3g6l9IyO18sClNVFbpNHvRu2v345UuMfKPVB/iX9/s
	e+mpqCDTkJrmpUL5dGVQYvBTsjLl4wqKeEip1zaBOeitnSJdV0momzUBz1pRrblvRt0TLSuNMnpp7
	Wmyd57vumZ0IZyLw30HuHLgwoNsDym9uKK1B2CKUzgzmRm0Cype+gZASRTOBhNHFdIkIno5i2Amta
	PyvhDMyg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tah4k-0002ln-Ha; Wed, 22 Jan 2025 21:11:46 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tah4W-00DJ63-Bw; Wed, 22 Jan 2025 21:11:32 +0100
Message-ID: <64fcd0af-a03b-47d5-960d-4326289023a5@rbox.co>
Date: Wed, 22 Jan 2025 21:11:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/6] vsock/test: Introduce vsock_bind()
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, George Zhang <georgezhang@vmware.com>,
 Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>,
 netdev@vger.kernel.org
References: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>
 <20250121-vsock-transport-vs-autobind-v2-3-aad6069a4e8c@rbox.co>
 <xzvqojpgicztj3waxetzemx5kzmjy57yl5hv5t7y2sh4bda27l@wwvuhac6zkgg>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <xzvqojpgicztj3waxetzemx5kzmjy57yl5hv5t7y2sh4bda27l@wwvuhac6zkgg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/22/25 17:01, Luigi Leonardi wrote:
> On Tue, Jan 21, 2025 at 03:44:04PM +0100, Michal Luczaj wrote:
>> Add a helper for socket()+bind(). Adapt callers.
>>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>> tools/testing/vsock/util.c       | 56 +++++++++++++++++-----------------------
>> tools/testing/vsock/util.h       |  1 +
>> tools/testing/vsock/vsock_test.c | 17 +-----------
>> 3 files changed, 25 insertions(+), 49 deletions(-)
>>
>> diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>> index 34e9dac0a105f8aeb8c9af379b080d5ce8cb2782..31ee1767c8b73c05cfd219c3d520a677df6e66a6 100644
>> --- a/tools/testing/vsock/util.c
>> +++ b/tools/testing/vsock/util.c
>> @@ -96,33 +96,42 @@ void vsock_wait_remote_close(int fd)
>> 	close(epollfd);
>> }
>>
>> -/* Bind to <bind_port>, connect to <cid, port> and return the file descriptor. */
>> -int vsock_bind_connect(unsigned int cid, unsigned int port, unsigned int bind_port, int type)
>
> If you need to send a v3, it would be nice to have a comment for 
> vsock_bind, as there used to be one.

Comment for vsock_bind_connect() remains, see below. As for vsock_bind(),
perhaps it's time to start using kernel-doc comments? v3 isn't coming, it
seems, but I'll comment the function later.

Thanks,
Michal

>> +/* Bind to <bind_port>, connect to <cid, port> and return the file descriptor. */
>> +int vsock_bind_connect(unsigned int cid, unsigned int port, unsigned int bind_port, int type)
>> +{
>> +	struct sockaddr_vm sa_server = {
>> +		.svm_family = AF_VSOCK,
>> +		.svm_cid = cid,
>> +		.svm_port = port,
>> +	};
>> +
>> +	int client_fd, ret;
>> +
>> +	client_fd = vsock_bind(VMADDR_CID_ANY, bind_port, type);
>> +
>> 	timeout_begin(TIMEOUT);
>> 	do {
>> 		ret = connect(client_fd, (struct sockaddr *)&sa_server, sizeof(sa_server));



Return-Path: <netdev+bounces-151724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 810619F0BBC
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873D316440C
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4C31DE899;
	Fri, 13 Dec 2024 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WSkJtz1g"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6432D1A08A6
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734090980; cv=none; b=Oe38eaSVonFjAqA64iOv9Ezc0fvZ/CfTjbElGN9FNip/SwA4FbvDBPYMlBwM2V7qpJn3WDZip2fpBnmJdbw14W/bKB8OGtuTOtit3i4UQMxhok6QkCh7eARYF82tRthW/zd8xGk5RUTItVugR8NJ7J2F0u6xZSMy4Ohh3oLM9S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734090980; c=relaxed/simple;
	bh=LNDM+GDxplxAwVapPzWjU21ZapTPTammDz0d9kfSJhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDE+idc9fl7m2VcYTMe0EtzZxDPReR7gsMdfm9KdgXMaLhG6+AZPB//GgZuNK92SiIzzxQDh9Pmnyd2Ld0nSJuLZOjq3NXvPiniiKLMDwtcMbFlSjN0wkElOLhBXb8WlZczZ0A1y5cW1RCMqHCRu60oz1qYU/WQaCOs6jBlQZXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WSkJtz1g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734090958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IRQnnyD5XTKJawwZjuhPS8d1gd8i7cWqiSLKbnk4FtI=;
	b=WSkJtz1g4VxkmAG+DNRASQM2GgYOdc5N6BeUmJfIb7geik3qvdk0nGBklfJyrlboWnDek6
	nPDZjDhzlUqWYcp9X7Cs5b8VkCi+R/VIZBUYr/uqJfq2WNsgkspDL1Me8+rKqricSW5Fzz
	KAmO1CTc0AVr2PHuAzd5igpyv3wya1Y=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-lVv4qpnqOBW7IAgtIBZKpg-1; Fri, 13 Dec 2024 06:55:56 -0500
X-MC-Unique: lVv4qpnqOBW7IAgtIBZKpg-1
X-Mimecast-MFC-AGG-ID: lVv4qpnqOBW7IAgtIBZKpg
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b6e4bea711so234953285a.3
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 03:55:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734090955; x=1734695755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRQnnyD5XTKJawwZjuhPS8d1gd8i7cWqiSLKbnk4FtI=;
        b=d1sZtyY1w1/c1J10CVSShBXrLxECpvLjNX28cdPgwGk+zbb9dMdIqtQAjkPJBDoZ3I
         BH4zZ2/J9QmtLGMIDZYW7//q1wOI+0PF+G18auxmvJlpoLprml3CrHQ2Ft5bdFh12ZCN
         4eyk6o1ErP+tkMHUTOYuaC2OT272xsp3u8VIx45kBjSmV0tj7i/6BOKAbfgpksHj6r2c
         tsRieMmGsDfTxxtyLmF+F4o5yQBbJgBbNrJOXBFXCHGMBx/4VhSbVq8VszLTy6ZzRwsH
         4BFfQqXSsPGGU9QB1Sx9jo5DgWQgCbCBxzE0QUn6lJ47FaQvXPBGtnbngbF3qeSequw/
         DV9Q==
X-Gm-Message-State: AOJu0YwYBSmRTn8d3p2LSj1OdqjNiMjvwqbuFJg/W7+5TVJ6SFzihjNi
	YoKl9ChdflFMQDzuplHfN68ACT1iT8SmYduZa97JshZaxNabE1ceS5fIk5vhiMOw5witASLQPfw
	pHqcer99BcbHfWaRiePbT/AyraouVRO5C9KSyR0C5binWnw+Cig5noQ0/r/wGQPFi
X-Gm-Gg: ASbGncvFhCELMl+SpcYd8nlwjHU9XiqtKm3xTPhoxus/F3Ylp09HRYXff5Brtxm8e2A
	z/HJ/UXCI4JXqKDMS4KrpSJxNZwS09oVT3UaMfyEctkWOl2W/ZCfb3tii1DNYunQ3gxRigkJkx6
	tSE/HY8RLphVi9+uEGiA70nooEHkByLf6MdcewwLTidPSwfz7W584HX23C8fQZ9HkTEIZode/dk
	1OU1SKVYExer07t1ePm2/UfAjEukgG+a8NhH1CX+LDF3rTD1hLKXdalm2CQxTj5H4swL0eBhvjZ
	kZB6SSqiiRfJ22S8YRDFy9/Kl96Xb69u
X-Received: by 2002:a05:620a:414b:b0:7b6:67a0:499d with SMTP id af79cd13be357-7b6fbecc676mr373294985a.1.1734090955739;
        Fri, 13 Dec 2024 03:55:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnTmjrUw7o56AbbKKNHGA1zO6wVso04nbCQIY2vqATFYwKV+z/PMzpzZb/of1JHKLC6kI8Ow==
X-Received: by 2002:a05:620a:414b:b0:7b6:67a0:499d with SMTP id af79cd13be357-7b6fbecc676mr373291785a.1.1734090955291;
        Fri, 13 Dec 2024 03:55:55 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6eb716f80sm268372185a.83.2024.12.13.03.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 03:55:54 -0800 (PST)
Date: Fri, 13 Dec 2024 12:55:50 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] vsock/test: Add test for accept_queue
 memory leak
Message-ID: <jep457tawmephttltjbohtqx57z63auoshgeolzhacz7j7rwra@z2uqfegja6dm>
References: <20241206-test-vsock-leaks-v1-0-c31e8c875797@rbox.co>
 <20241206-test-vsock-leaks-v1-2-c31e8c875797@rbox.co>
 <uyzzicjukysdqzf5ls5s5qp26hfqgrwjz4ahbnb6jp36lzazck@67p3eejksk56>
 <a8fa27ad-b1f5-4565-a3db-672f5b8a119a@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a8fa27ad-b1f5-4565-a3db-672f5b8a119a@rbox.co>

On Thu, Dec 12, 2024 at 11:12:19PM +0100, Michal Luczaj wrote:
>On 12/10/24 17:18, Stefano Garzarella wrote:
>> On Fri, Dec 06, 2024 at 07:34:52PM +0100, Michal Luczaj wrote:
>>> [...]
>>> +#define ACCEPTQ_LEAK_RACE_TIMEOUT 2 /* seconds */
>>> +
>>> +static void test_stream_leak_acceptq_client(const struct test_opts *opts)
>>> +{
>>> +	struct sockaddr_vm addr = {
>>> +		.svm_family = AF_VSOCK,
>>> +		.svm_port = opts->peer_port,
>>> +		.svm_cid = opts->peer_cid
>>> +	};
>>> +	time_t tout;
>>> +	int fd;
>>> +
>>> +	tout = current_nsec() + ACCEPTQ_LEAK_RACE_TIMEOUT * NSEC_PER_SEC;
>>> +	do {
>>> +		control_writeulong(1);
>>
>> Can we use control_writeln() and control_expectln()?
>
>Please see below.
>
>>> +
>>> +		fd = socket(AF_VSOCK, SOCK_STREAM, 0);
>>> +		if (fd < 0) {
>>> +			perror("socket");
>>> +			exit(EXIT_FAILURE);
>>> +		}
>>> +
>>
>> Do we need another control messages (server -> client) here to be sure
>> the server is listening?
>
>Ahh, I get your point.
>
>>> +		connect(fd, (struct sockaddr *)&addr, sizeof(addr));
>>
>> What about using `vsock_stream_connect` so you can remove a lot of
>> code from this function (e.g. sockaddr_vm, socket(), etc.)
>>
>> We only need to add `control_expectln("LISTENING")` in the server which
>> should also fix my previous comment.
>
>Sure, I followed your suggestion with
>
>	tout = current_nsec() + ACCEPTQ_LEAK_RACE_TIMEOUT * NSEC_PER_SEC;
>	do {
>		control_writeulong(RACE_CONTINUE);
>		fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>		if (fd >= 0)
>			close(fd);

I'd do
		if (fd < 0) {
			perror("connect");
			exit(EXIT_FAILURE);
		}
		close(fd);

apart of that LGTM!

>	} while (current_nsec() < tout);
>	control_writeulong(RACE_DONE);
>
>vs.
>
>	while (control_readulong() == RACE_CONTINUE) {
>		fd = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
>		control_writeln("LISTENING");
>		close(fd);
>	}
>
>and it works just fine.
>
>>> +static void test_stream_leak_acceptq_server(const struct test_opts *opts)
>>> +{
>>> +	int fd;
>>> +
>>> +	while (control_readulong()) {
>>
>> Ah I see, the loop is easier by sending a number.
>> I would just add some comments when we send 1 and 0 to explain it.
>
>How about the #defines above?

yeah, I like it!

Thanks,
Stefano

>
>Thanks!
>Michal
>



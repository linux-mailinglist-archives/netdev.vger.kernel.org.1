Return-Path: <netdev+bounces-193452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06322AC4193
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 16:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EC897AADCE
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 14:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C880211A2A;
	Mon, 26 May 2025 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVRr/v9F"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D0220E6F3
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748270408; cv=none; b=TyybJJoxFNoofRHQtcG7Tbv2lFjCLMmfb9KxO9Ym2PIoyaa8LMGhG+Nhvkrg42vIaAW4FIryrRQclMlfgcJVbb656B1Ww8bXGE+1HLc0FZTZ8wEWPd1Aq+d13lv2i8lE6/SsDpZtlhRJ8H+7MS8Ids+otOcyUJHpjaobOIV+jcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748270408; c=relaxed/simple;
	bh=/e+vyLtK0CFZ4t4mAapQB9b2M2hDkw8sV9L58+jnCMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVBV++OLzUXqHIOqKOOFiBMkhL0r0vivcRrhzSJC7/eKe4Qy8H4umpAW4OtRh8iQdJvQKQ+pUEpWOG06Wx7DR4SfxidXSofdmyE5T9rHPCtP2r0fjrzyUO6HWx3UQqVQIpO1tkVXCs6fJxdyi9YavaEmPe5b6Hxb9pJZ8xuTRhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SVRr/v9F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748270405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RF6pS1ObcOVvDlmvm5nj8NiMFIwIn9dVx82Hog1fdnE=;
	b=SVRr/v9FJT06dcOlhOj83WXFKXwEwe1uyLXphH6RWF1p8K+jEz04YYKrC6AmmKvxgPbFwn
	v35+5juJVxRydN/Mg149rZaADI7P90oicJ4AguVuUxNJ6+Otz3HPYHUEJcId6zR0Ol2cMP
	aJBNckqFIM2NrI70y009uPCeQVl6vj8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-TQvGL_ZZPxexeOgrjJGUfQ-1; Mon, 26 May 2025 10:40:03 -0400
X-MC-Unique: TQvGL_ZZPxexeOgrjJGUfQ-1
X-Mimecast-MFC-AGG-ID: TQvGL_ZZPxexeOgrjJGUfQ_1748270402
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43eed325461so15730475e9.3
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 07:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748270401; x=1748875201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RF6pS1ObcOVvDlmvm5nj8NiMFIwIn9dVx82Hog1fdnE=;
        b=aGrKdcoAZ1rknZqyFlf6hNoKQsN7OzZyM1l+qOl4Q2rW8Ffx70r+wLZ2XsjZMXJ3lD
         8sqBvs5RDx9VidFxbcFT68Rry05bYn65K8PjReP5OMOhn1xV4yXVOTyYGHoHpBN1Xh4C
         LzFmcn5v2Qd2oXqtSbUTiGmt9tq7N2JqxHrDob8LPDF4bItgp6tSByg2v9bfqxpWqr5C
         hNWw0dgBdjlZP8Nc6hZYHbCSZA40tNv+lguPkmbpqF9+/VbdgEr0PzQQbw7HXThbQpqY
         Kbkp5Vx9Nc8GNFl+MMsIByXrqvjstWQUIljd2PsvZlJ0fK33DP3c7Z4M33fXvnPs++gU
         NBsg==
X-Forwarded-Encrypted: i=1; AJvYcCUPjg3p7p2yB8RmLiCYtI0mAc8agIfIeYKTFa/N3RU1MxBW1cvu8oDYFc3pzRnSIEfaGXE0dfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZN+zbca+ocu/OEJHp8Ers2yehB4dD+dxo86Q6odHpDBfExQNW
	XTLvy5JKLV3g9HYE1r37CMxEgNfPyv1ZUw64yP+IkhPe9vSyc5Dx0aH3JwHu8GvLU5SVOUVjSpq
	9/mfaFeWNbudGJdECyeVithdztWFQO/qFOzjepqMBP8it5DXkPZeXz6LgzmsY4//EpQ==
X-Gm-Gg: ASbGncun8C5R/lq+e3v6CxHVnsbcFsVFwxVvxGn0dTNvspSSgBManftC44zLQ9WG8XZ
	dAVyZTjxeaJmk9XRA6Z+qCWYq/kklIwNWyIkfvY4YlAwzYETpWErpYGUnTX/Sdf42U+oWY0e0VA
	TEgAI/bJHB67fp3eWtKTOIR/DI4StRPaVlrCA1fCc37n4OsXmhZeKcH0dM9Yajg+FyW9P2cyMoX
	/RR8YiawY+LIQW90Hgj54x5pdLu8aDsltf6VszIrICU6whI+xZSu4Z7cg+r2gIOeOX2soGJ7wlR
	aO37sKYfIZPkXVjLSiDW4+u9+Qi6RsDTVDOJAXdraBYoC9A7XMdnAjyULU1B
X-Received: by 2002:a05:600c:511b:b0:442:dc6f:2f11 with SMTP id 5b1f17b1804b1-44c9493e671mr77932075e9.25.1748270401470;
        Mon, 26 May 2025 07:40:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWo+GvCwfq/rkNxHnvWQwirh+1VtVO+LjjW3fAOxqDotyizM//UqyOYsGby8MQArjXhlSeww==
X-Received: by 2002:a05:600c:511b:b0:442:dc6f:2f11 with SMTP id 5b1f17b1804b1-44c9493e671mr77931885e9.25.1748270400947;
        Mon, 26 May 2025 07:40:00 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78aef8asm247808255e9.29.2025.05.26.07.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 07:40:00 -0700 (PDT)
Date: Mon, 26 May 2025 16:39:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/test: Cover more CIDs in transport_uaf
 test
Message-ID: <gfmoupl72tjyymhwxcstwpgaabbfaz6f4v6vj4lwwzwssg577c@urkmgn7rapnj>
References: <20250523-vsock-test-inc-cov-v1-1-fa3507941bbd@rbox.co>
 <limbmrszio42lvkmalapooflj5miedlszkmnnm4ckmy2upfghw@24vxuhgdji2z>
 <1f5cc46a-de4c-4361-a706-fc7fe06a7068@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1f5cc46a-de4c-4361-a706-fc7fe06a7068@rbox.co>

On Mon, May 26, 2025 at 02:51:18PM +0200, Michal Luczaj wrote:
>On 5/26/25 10:25, Stefano Garzarella wrote:
>> On Fri, May 23, 2025 at 12:31:16AM +0200, Michal Luczaj wrote:
>>> Increase the coverage of test for UAF due to socket unbinding, and losing
>>> transport in general. It's a follow up to commit 301a62dfb0d0 ("vsock/test:
>>> Add test for UAF due to socket unbinding") and discussion in [1].
>>>
>>> The idea remains the same: take an unconnected stream socket with a
>>> transport assigned and then attempt to switch the transport by trying (and
>>> failing) to connect to some other CID. Now do this iterating over all the
>>> well known CIDs (plus one).
>>>
>>> Note that having only a virtio transport loaded (without vhost_vsock) is
>>> unsupported; test will always pass. Depending on transports available, a
>>
>> Do you think it might make sense to print a warning if we are in this
>> case, perhaps by parsing /proc/modules and looking at vsock
>> dependencies?
>
>That'd nice, but would parsing /proc/modules work if a transport is
>compiled-in (not a module)?

Good point, I think not, maybe we can see something under /sys/module,
though, I would say let's do best effort without going crazy ;-)

>
>>> +static bool test_stream_transport_uaf(int cid)
>>> {
>>> +	struct sockaddr_vm addr = {
>>> +		.svm_family = AF_VSOCK,
>>> +		.svm_cid = cid,
>>> +		.svm_port = VMADDR_PORT_ANY
>>> +	};
>>> 	int sockets[MAX_PORT_RETRIES];
>>> -	struct sockaddr_vm addr;
>>> -	int fd, i, alen;
>>> +	socklen_t alen;
>>> +	int fd, i, c;
>>>
>>> -	fd = vsock_bind(VMADDR_CID_ANY, VMADDR_PORT_ANY, SOCK_STREAM);
>>> +	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
>>> +	if (fd < 0) {
>>> +		perror("socket");
>>> +		exit(EXIT_FAILURE);
>>> +	}
>>> +
>>> +	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr))) {
>>> +		if (errno != EADDRNOTAVAIL) {
>>> +			perror("Unexpected bind() errno");
>>> +			exit(EXIT_FAILURE);
>>> +		}
>>> +
>>> +		close(fd);
>>> +		return false;
>>
>> Perhaps we should mention in the commit or in a comment above this
>> function, what we return and why we can expect EADDRNOTAVAIL.
>
>Something like
>
>/* Probe for a transport by attempting a local CID bind. Unavailable
> * transport (or more specifically: an unsupported transport/CID
> * combination) results in EADDRNOTAVAIL, other errnos are fatal.
> */
>
>?

LGTM!

>
>And I've just realized feeding VMADDR_CID_HYPERVISOR to bind() doesn't make
>sense at all. Will fix.

Yeah, we don't support it for now and maybe it makes sense only in the 
VMM code (e.g. QEMU), but it's a test, so if you want to leave to stress 
it more, I don't think it's a big issue.

>
>> What about adding a vsock_bind_try() in util.c that can fail returning
>> errno, so we can share most of the code with vsock_bind()?
>
>Ah, yes, good idea.
>
>>> +static void test_stream_transport_uaf_client(const struct test_opts *opts)
>>> +{
>>> +	bool tested = false;
>>> +	int cid;
>>> +
>>> +	for (cid = VMADDR_CID_HYPERVISOR; cid <= VMADDR_CID_HOST + 1; ++cid)
>>
>>> +		tested |= test_stream_transport_uaf(cid);
>>> +
>>> +	if (!tested)
>>> +		fprintf(stderr, "No transport tested\n");
>>> +
>>> 	control_writeln("DONE");
>>
>> While we're at it, I think we can remove this message, looking at
>> run_tests() in util.c, we already have a barrier.
>
>Ok, sure. Note that console output gets slightly de-synchronised: server
>will immediately print next test's prompt and wait there.

I see, however I don't have a strong opinion, you can leave it that way 
if you prefer.

Thanks,
Stefano



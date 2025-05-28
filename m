Return-Path: <netdev+bounces-193928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF36AC6534
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 11:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4077E3A7284
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 09:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A2C274651;
	Wed, 28 May 2025 09:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmx1OJXt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609C482899
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748423336; cv=none; b=gkLW8XWn26ZF1UiPb40jQDNbZNq8TLh4cN0+wM3g11x12r8GM97ZYIq/X925hoxePj3nfe8ZuZHxtuWG/ZOy/d0uKGrRDYTrNUb905ZUe0qHbXXhNPFbuk9Fp8fGfGpf2yv8u5TqMUj4O3Vo142yyFOuWdA0sdrjUw0xVhjv0ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748423336; c=relaxed/simple;
	bh=HeRntkvpjTLIxIK7T/7PBTHCgMLMpgZe/nO0/0LPjDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EV0YhrtXuuyAf6QdoDOtZW0xhxpVizgHId2iQ1HNz4fMNfb3ZJwHRdPlUxF7jGw4x22F4lAQM7tRyom95UtN+vVh2t4hFpTfT9fpn+A8chCN2BkbO5JwlmBStmk2U+SBZqW68LTn5fwsRnEpXfgyfSB5s6vkykdT5L6gF/oC6pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dmx1OJXt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748423333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K6fOjoths9BP+7g43cHI3UErFOLHs1REkE1Ir6J/HUc=;
	b=dmx1OJXtsrMmP2j0NZe11qfMhrxKVJJMk9Lk51XmPi8+zhF2mhRGD2bmGgEbrzWbIXluFh
	jthkop4QEixr4ez8pCEBKp56i74DES0Cnh3BERRTWS/51+5gE9bSqcXPRK2nGuagNiNp3f
	nb6+GH9e9UJjjtIFwLL3a6szLURp4bo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-pMFgamRsOBWb-GqffiK75A-1; Wed, 28 May 2025 05:08:51 -0400
X-MC-Unique: pMFgamRsOBWb-GqffiK75A-1
X-Mimecast-MFC-AGG-ID: pMFgamRsOBWb-GqffiK75A_1748423330
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d007b2c79so31694365e9.2
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 02:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748423330; x=1749028130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6fOjoths9BP+7g43cHI3UErFOLHs1REkE1Ir6J/HUc=;
        b=OJfu+fK4AbZVYuJkR47EkUBkm44CzZ6ML8ZZdg5Vs5V2yQd3DO2T4SLgw0shcfYtpT
         JfLMt1XhZ+uzylb1oRkKdKr226N07txOi24mpxL+oiWXw1AOROq92WozYZ9mPsaTzCkg
         +s/6RsOwcPPqxbjHFPRGxCUXN23VIVvTVVeirftwSI4H1LuxHBP9qzQc1tTNqKSdIBHf
         4lXaFK10SfAYuoAHp8lRsnRMWMpe01sWSKapUzRAGlk0AXJS1sHYTsrrsRdVAyfydey+
         BO+mvv3qiXBDBVUBKLUrnpbPo3al74vXBsNrZC1Yp44TslNnx8T17VIabYrBRkuX/UC+
         OI/g==
X-Forwarded-Encrypted: i=1; AJvYcCU7yU5Y6bo+n3en2FgT5IfwVL7wT1m0RtbkAMlrFeuxe7pE6gqupjqiVkJIq3BGOt6zRleE6v4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0KyZepnespRvCaAOcX6eKpPARwIAxmCxAYteF2S82+x9+sLYK
	8SyyB6/1x3Hz8cF6mDlv/KjkuRs5PFHdFIxWulrYFKokfTRAvckpL7sRb6ikSNZb8PqKU4XdtYI
	9/DzTAEEkpQeJsZ7a5Qqe60Gnkv/Vjnz8Y/dSPEcjUQ3ByAT33DD0Xl2mzkEsIUMynA==
X-Gm-Gg: ASbGncvbenXNBGYwws2Mz8tTk+zWZKJnw2dZKtrc7uIPKRhSikNN/b5U7+oROYmVWcZ
	f/OzLUqW7xIEC+RN2eUXJQzPPlM13u6imGAiEr/FfXMQhWgRcmZcaOhMm20wAVcDGG8Uq6l3+K/
	ARHvPkMBJUPINEa1yDAATrQlWbwx+MwpkJ4PJabDp60ZvWVQDQnt7Vunspr5QVLC55OwB2he5zf
	itwo66jIrfBW27+iO+YKP8/O+PCEGza1zA4dklK0a6/zzSmLYd33B88gtSDsYlKrhKgOEBJSFYI
	pAZBz7XQNxxhWTRv4+Yl/+BM4tS5sQIOc5E7uGpslH6wqJIyjgQHx0avmgqE
X-Received: by 2002:a05:600c:64c6:b0:43d:300f:fa1d with SMTP id 5b1f17b1804b1-44c937d125amr158521925e9.31.1748423329748;
        Wed, 28 May 2025 02:08:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSUDpB7MCB0r+KZHQbLDKkjrX6HPTl91hhU9m2/A027cB52iPz1nlOjL0WRytjQ2mFsWDovg==
X-Received: by 2002:a05:600c:64c6:b0:43d:300f:fa1d with SMTP id 5b1f17b1804b1-44c937d125amr158521515e9.31.1748423329064;
        Wed, 28 May 2025 02:08:49 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45006498c72sm14805555e9.2.2025.05.28.02.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 02:08:48 -0700 (PDT)
Date: Wed, 28 May 2025 11:08:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/test: Cover more CIDs in transport_uaf
 test
Message-ID: <7zqv5toj2qjucy7fvaebbpwj6pth53uunsbapwhgrhwbr5pq5t@gp7h6klhr5sj>
References: <20250523-vsock-test-inc-cov-v1-1-fa3507941bbd@rbox.co>
 <limbmrszio42lvkmalapooflj5miedlszkmnnm4ckmy2upfghw@24vxuhgdji2z>
 <1f5cc46a-de4c-4361-a706-fc7fe06a7068@rbox.co>
 <gfmoupl72tjyymhwxcstwpgaabbfaz6f4v6vj4lwwzwssg577c@urkmgn7rapnj>
 <151bf5fe-c9ca-4244-aa21-8d7b8ff2470f@rbox.co>
 <skvayogoenhntikkdnqrkkjvqesmpnukjlil6reubrouo45sat@j7zw6lfthfrd>
 <54959090-440e-49e8-80b3-8eee0ef4582c@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <54959090-440e-49e8-80b3-8eee0ef4582c@rbox.co>

On Wed, May 28, 2025 at 10:58:28AM +0200, Michal Luczaj wrote:
>On 5/27/25 10:41, Stefano Garzarella wrote:
>> On Mon, May 26, 2025 at 10:44:05PM +0200, Michal Luczaj wrote:
>>> On 5/26/25 16:39, Stefano Garzarella wrote:
>>>> On Mon, May 26, 2025 at 02:51:18PM +0200, Michal Luczaj wrote:
>>>>> On 5/26/25 10:25, Stefano Garzarella wrote:
>>>>>> On Fri, May 23, 2025 at 12:31:16AM +0200, Michal Luczaj wrote:
>>>>>>> Note that having only a virtio transport loaded (without vhost_vsock) is
>>>>>>> unsupported; test will always pass. Depending on transports available, a
>>>>>>
>>>>>> Do you think it might make sense to print a warning if we are in this
>>>>>> case, perhaps by parsing /proc/modules and looking at vsock
>>>>>> dependencies?
>>>>>
>>>>> That'd nice, but would parsing /proc/modules work if a transport is
>>>>> compiled-in (not a module)?
>>>>
>>>> Good point, I think not, maybe we can see something under /sys/module,
>>>> though, I would say let's do best effort without going crazy ;-)
>>>
>>> Grepping through /proc/kallsyms would do the trick. Is this still a sane
>>> ground?
>>
>> It also depends on a config right?
>> I see CONFIG_KALLSYMS, CONFIG_KALLSYMS_ALL, etc. but yeah, if it's
>> enabled, it should work for both modules and built-in transports.
>
>FWIW, tools/testing/selftests/net/config has CONFIG_KALLSYMS=y, which
>is enough for being able to check symbols like virtio_transport and
>vhost_transport.

Ok, I see, so let's go in that direction.

>
>Administrative query: while net-next is closed, am I supposed to mark this
>series as "RFC" and post v2 for a review as usual, or is it better to just
>hold off until net-next opens?

Whichever you prefer, if you are uncertain about the next version and 
want to speed things up with a review while waiting, then go with RFC, 
but if you think all comments are resolved and the next version is ready 
to be merged, wait for the reopening.
Thanks for asking!

>
>>>>>>> +static void test_stream_transport_uaf_client(const struct test_opts *opts)
>>>>>>> +{
>>>>>>> +	bool tested = false;
>>>>>>> +	int cid;
>>>>>>> +
>>>>>>> +	for (cid = VMADDR_CID_HYPERVISOR; cid <= VMADDR_CID_HOST + 1; ++cid)
>>>>>>
>>>>>>> +		tested |= test_stream_transport_uaf(cid);
>>>>>>> +
>>>>>>> +	if (!tested)
>>>>>>> +		fprintf(stderr, "No transport tested\n");
>>>>>>> +
>>>>>>> 	control_writeln("DONE");
>>>>>>
>>>>>> While we're at it, I think we can remove this message, looking at
>>>>>> run_tests() in util.c, we already have a barrier.
>>>>>
>>>>> Ok, sure. Note that console output gets slightly de-synchronised: server
>>>>> will immediately print next test's prompt and wait there.
>>>>
>>>> I see, however I don't have a strong opinion, you can leave it that way
>>>> if you prefer.
>>>
>>> How about adding a sync point to run_tests()? E.g.
>>
>> Yep, why not, of course in another series :-)
>>
>> And if you like, you can remove that specific sync point in that series
>> and check also other tests, but I think we have only that one.
>
>OK, I'll leave that for later.

Yep, feel free to discard my suggestion, we can fix it later.

Thanks,
Stefano



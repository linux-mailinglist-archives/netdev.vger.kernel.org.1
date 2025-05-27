Return-Path: <netdev+bounces-193585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DACDAC4A68
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 10:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88F03A5234
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 08:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87DC2494F5;
	Tue, 27 May 2025 08:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHym42bi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C3224A049
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748335277; cv=none; b=JRvY9Mi8c9swA448dP+7XR/215sD2RD7zfA+LIK0mat1svT1Nd8jR7z0aj031qwwl6vtPM7Bqmt0mi31cOKmQllSke1tJzlTBrgwtDXw9SKcDU8+6noOLc1OabTXXWFQEvnikCzzqlS43yKGxB5uUdx6XIZd4gUy3UJ3wLzQaMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748335277; c=relaxed/simple;
	bh=9/4frAyuK+mH4dCPcWolggSSGYIz8T6fceKUO2hSxFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxevTkhPGRP+VnNV82Q/uGLbpEsuLGpR2KEzOnzTxyt8s/+LBJ0TWK9ZExGWzqVKf/R2k8DEOPpOCqOnBeumKJAkUgixisr+CDEL7t9kGpJRVYO2lkI8FwKMiL3kC8ujB4UJ0TzpuIf0go7uMkSER0FZg7PgZW06El6EMb18Fek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XHym42bi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748335274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=otnLpqmsUXmp5NS65WlS5qhIeAcyrstq9DF1BYfQqbs=;
	b=XHym42bibaLAyOz3Yj1OfME8tZO+TixE2ho/3og18d8n6NqlTPn5seapyWg5FbkqGpM/ak
	gQPMsx5jrTlbqtmdKbz+Izr5OpNvizcA9gkKCBfdJaHK721Ezk8loRAqF+cbP5l0x9TYLB
	JeCTCDUcHhkn1PWrotNnbvnrOOuzI9s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-tK3Sl1hwOpOjhk_e9z0IuA-1; Tue, 27 May 2025 04:41:12 -0400
X-MC-Unique: tK3Sl1hwOpOjhk_e9z0IuA-1
X-Mimecast-MFC-AGG-ID: tK3Sl1hwOpOjhk_e9z0IuA_1748335271
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ad5697c4537so250973066b.0
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 01:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748335271; x=1748940071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otnLpqmsUXmp5NS65WlS5qhIeAcyrstq9DF1BYfQqbs=;
        b=S/uz/n7W+XBfV5IfIu7uXHnAzWojjDL9lClg+mytO83whQ/GiDgbSrhotG+GdJ4MvJ
         9KDF7G0UHO1MMKE9xLbp5dXsBMDfvObWJe6Xyw2NVGD8Agk+SzVm5U8O+U3aYR0TNA05
         g448PTHMC2kLDidg329EB/Xy98x7MG0LgokVPVTnfYI+qJ6ZAbi34PiJqQvPu8K7xXu9
         FzYkX1BwxRGm3MBUC21HFXYVbLC1ty+BgclPS4yBdQDOFy+0s6TN8ViQRlcEKvR0UnJW
         2PprCWKhcY7/N9hqvNps+nCRGHJuTM1vl+kuDkGrgJmBv0yssT+CNnIIxYkzJCgPwxAG
         yCJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwcGVExyl4i+dPb6DXq+dyEs1KlJQ5Fl7LztbbRfCJXssiPY8Ni1MjGcMWtiwoo91v3qmOz64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/8giIgtui9/DiPXDYV+uS5JvEOgtbpXPrUPTjDAosAvKWcsOQ
	TEWxRh7sLqZ1xj+NgzoAHN84VaUhZKq6oX7Y1GKKXP005nE/jIqLzqZB2ChzZuf+Svr6NWFgHCS
	E3tkMIU2UdVNg/QcwiWECUM5BdIWuBuLBJ0xZhvZ0Cd0aouKOkGuQINb8hjHJqO3EXQ==
X-Gm-Gg: ASbGncvLxDRSKLhJ5gcp6Co3nJOEybRCUHI3xFPcmg3k5iU6KvU5Divpd67mUgDnY6N
	i7S+x69ABLQomtCKqWS+ueKpAppHXtY6a59X51s+J7FTYOdlhd6euRv7lrXzvjEE+0hmSceEd2g
	04msl1mbJSWqn9jAaO3buqNDfG1xX5YbtqGqTPb6eW6ginCn14WgUIl5uWhgBXCu81EH/Ht9e0T
	wyBkyjIhBMupbBbK0jpXGWitmIXDNXjXw/HLiKz/E/4/N7OxENIvk8/8UFuRyD7aOqWD8WqylEW
	uI3zvtERQl1NUiuyceVFAdd5AfXhBV2DvguQamuWbm5to8ino5mIMO362RRB
X-Received: by 2002:a17:907:3f9c:b0:ad5:d6b3:5cd5 with SMTP id a640c23a62f3a-ad8596d9843mr1170685766b.5.1748335271011;
        Tue, 27 May 2025 01:41:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMIKp0vFl+Prf74hN6X8U5dcoTMgJ4VBfKwNEdm/vm6CaEpdolph/x3lK/ErbdGrfTaaYqSg==
X-Received: by 2002:a17:907:3f9c:b0:ad5:d6b3:5cd5 with SMTP id a640c23a62f3a-ad8596d9843mr1170682866b.5.1748335270353;
        Tue, 27 May 2025 01:41:10 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad892d47536sm43991366b.12.2025.05.27.01.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 01:41:09 -0700 (PDT)
Date: Tue, 27 May 2025 10:41:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/test: Cover more CIDs in transport_uaf
 test
Message-ID: <skvayogoenhntikkdnqrkkjvqesmpnukjlil6reubrouo45sat@j7zw6lfthfrd>
References: <20250523-vsock-test-inc-cov-v1-1-fa3507941bbd@rbox.co>
 <limbmrszio42lvkmalapooflj5miedlszkmnnm4ckmy2upfghw@24vxuhgdji2z>
 <1f5cc46a-de4c-4361-a706-fc7fe06a7068@rbox.co>
 <gfmoupl72tjyymhwxcstwpgaabbfaz6f4v6vj4lwwzwssg577c@urkmgn7rapnj>
 <151bf5fe-c9ca-4244-aa21-8d7b8ff2470f@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <151bf5fe-c9ca-4244-aa21-8d7b8ff2470f@rbox.co>

On Mon, May 26, 2025 at 10:44:05PM +0200, Michal Luczaj wrote:
>On 5/26/25 16:39, Stefano Garzarella wrote:
>> On Mon, May 26, 2025 at 02:51:18PM +0200, Michal Luczaj wrote:
>>> On 5/26/25 10:25, Stefano Garzarella wrote:
>>>> On Fri, May 23, 2025 at 12:31:16AM +0200, Michal Luczaj wrote:
>>>>> Increase the coverage of test for UAF due to socket unbinding, and losing
>>>>> transport in general. It's a follow up to commit 301a62dfb0d0 ("vsock/test:
>>>>> Add test for UAF due to socket unbinding") and discussion in [1].
>>>>>
>>>>> The idea remains the same: take an unconnected stream socket with a
>>>>> transport assigned and then attempt to switch the transport by trying (and
>>>>> failing) to connect to some other CID. Now do this iterating over all the
>>>>> well known CIDs (plus one).
>>>>>
>>>>> Note that having only a virtio transport loaded (without vhost_vsock) is
>>>>> unsupported; test will always pass. Depending on transports available, a
>>>>
>>>> Do you think it might make sense to print a warning if we are in this
>>>> case, perhaps by parsing /proc/modules and looking at vsock
>>>> dependencies?
>>>
>>> That'd nice, but would parsing /proc/modules work if a transport is
>>> compiled-in (not a module)?
>>
>> Good point, I think not, maybe we can see something under /sys/module,
>> though, I would say let's do best effort without going crazy ;-)
>
>Grepping through /proc/kallsyms would do the trick. Is this still a sane
>ground?

It also depends on a config right?
I see CONFIG_KALLSYMS, CONFIG_KALLSYMS_ALL, etc. but yeah, if it's 
enabled, it should work for both modules and built-in transports.

>
>>> And I've just realized feeding VMADDR_CID_HYPERVISOR to bind() doesn't make
>>> sense at all. Will fix.
>>
>> Yeah, we don't support it for now and maybe it makes sense only in the
>> VMM code (e.g. QEMU), but it's a test, so if you want to leave to stress
>> it more, I don't think it's a big issue.
>
>All right, I'll keep it then. Fails quickly and politely anyway.
>
>>>>> +static void test_stream_transport_uaf_client(const struct test_opts *opts)
>>>>> +{
>>>>> +	bool tested = false;
>>>>> +	int cid;
>>>>> +
>>>>> +	for (cid = VMADDR_CID_HYPERVISOR; cid <= VMADDR_CID_HOST + 1; ++cid)
>>>>
>>>>> +		tested |= test_stream_transport_uaf(cid);
>>>>> +
>>>>> +	if (!tested)
>>>>> +		fprintf(stderr, "No transport tested\n");
>>>>> +
>>>>> 	control_writeln("DONE");
>>>>
>>>> While we're at it, I think we can remove this message, looking at
>>>> run_tests() in util.c, we already have a barrier.
>>>
>>> Ok, sure. Note that console output gets slightly de-synchronised: server
>>> will immediately print next test's prompt and wait there.
>>
>> I see, however I don't have a strong opinion, you can leave it that way
>> if you prefer.
>
>How about adding a sync point to run_tests()? E.g.

Yep, why not, of course in another series :-)

And if you like, you can remove that specific sync point in that series 
and check also other tests, but I think we have only that one.

Thanks,
Stefano

>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index de25892f865f..79a02b52dc19 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -451,6 +451,9 @@ void run_tests(const struct test_case *test_cases,
> 			run(opts);
>
> 		printf("ok\n");
>+
>+		control_writeln("RUN_TESTS_SYNC");
>+		control_expectln("RUN_TESTS_SYNC");
> 	}
> }
>



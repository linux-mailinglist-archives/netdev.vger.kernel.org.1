Return-Path: <netdev+bounces-195143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80944ACE4A4
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 21:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7F6318984B2
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 19:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A799020010A;
	Wed,  4 Jun 2025 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="loQOQMW2"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18DD1FAC4A;
	Wed,  4 Jun 2025 19:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749064253; cv=none; b=lrE5c7y3z8uFPQ95NVDxvue+ydjBFwCriwYNC3nY+9NfuiQeo/Dw7hj5AILymlUP4zch4UJcAl4i3ylsPk4OX07jHyJ3c7hvvKXWu+cvEGZwx5razmMF1/2p3mo1LtfrKNSE2OFqFdAIOKCnJ4XJGeFHOFoUWKviYYdc87NZfK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749064253; c=relaxed/simple;
	bh=wuGlbgq1ihybUq6dXQKAnlId600qnDGxJZZOt/QdRkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IORoNTk4eiSspt6FjVoN0uenpkHIrvc+HbK52PF6diBKABkL4hH86U8eDZ3xAnWPlblJmEHSv3O3IATY5Kxy1DbHTR5LiK0hhRCxR6El2rhDYH8uAAbLJ8T37b8NE+ma/POMRwa8jrihLoi6QmMTut6ToAWVfcqI6PTo4gVgDXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=loQOQMW2; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uMtVX-008sOC-RO; Wed, 04 Jun 2025 21:10:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=VLTzvzCNVJfmTb7kZJWOYFxzkC9YfkFX6n1lQxh0h3Q=; b=loQOQMW2NaMi1fZUn+YZJtgAA/
	rdNxXfw/hIyR7OyZ7qDspqKEgFmMjVukRfr+LKJOr9we8UT5CK//o24kZDwvw8n19h3sFog8prNBy
	PqAQJU6KRBEGpgDlxtyHMIEDwDnmsTs0zp89a8rzYfn9fxTEYG3v7GuR0WCu6dLLKNaX6QT3Ct0Lk
	SmsBWmkWvJPWiRu261gon81SF25kHrQmLiZFVfIWrwRClm7Zm39wzQxtl/FA4V8gQKyrLfk0pWm1t
	oSza+g/2qNuEhlOH5Uvm65iRYWEUFvLtVT1cF0JHk0IrqtakhVvHVugdhJJwBgG6XKGposMZR8cFd
	Uu6AUTxA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uMtVW-0001Vn-So; Wed, 04 Jun 2025 21:10:39 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uMtVN-00DaDt-Nj; Wed, 04 Jun 2025 21:10:29 +0200
Message-ID: <b4f3bc0d-9ff5-4271-be28-bbace27927bd@rbox.co>
Date: Wed, 4 Jun 2025 21:10:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v2 2/3] vsock/test: Introduce
 get_transports()
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250528-vsock-test-inc-cov-v2-0-8f655b40d57c@rbox.co>
 <20250528-vsock-test-inc-cov-v2-2-8f655b40d57c@rbox.co>
 <wzbyv7fvzgpf4ta775of6k4ozypnfe6szysvnz4odd3363ipsp@2v3h5w77cr7a>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <wzbyv7fvzgpf4ta775of6k4ozypnfe6szysvnz4odd3363ipsp@2v3h5w77cr7a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/25 11:07, Stefano Garzarella wrote:
> On Wed, May 28, 2025 at 10:44:42PM +0200, Michal Luczaj wrote:
>> +static int __get_transports(void)
>> +{
>> +	/* Order must match transports defined in util.h.
>> +	 * man nm: "d" The symbol is in the initialized data section.
>> +	 */
>> +	const char * const syms[] = {
>> +		"d loopback_transport",
>> +		"d virtio_transport",
>> +		"d vhost_transport",
>> +		"d vmci_transport",
>> +		"d hvs_transport",
>> +	};
> 
> I would move this array (or a macro that define it), near the transport 
> defined in util.h, so they are near and we can easily update/review 
> changes.
> 
> BTW what about adding static asserts to check we are aligned?

Something like

#define KNOWN_TRANSPORTS	\
	_(LOOPBACK, "loopback")	\
	_(VIRTIO, "virtio")	\
	_(VHOST, "vhost")	\
	_(VMCI, "vmci")		\
	_(HYPERV, "hvs")

enum transport {
	TRANSPORT_COUNTER_BASE = __COUNTER__ + 1,
	#define _(name, symbol)	\
		TRANSPORT_##name = _BITUL(__COUNTER__ - TRANSPORT_COUNTER_BASE),
	KNOWN_TRANSPORTS
	TRANSPORT_NUM = __COUNTER__ - TRANSPORT_COUNTER_BASE,
	#undef _
};

static char * const transport_ksyms[] = {
	#define _(name, symbol) "d " symbol "_transport",
	KNOWN_TRANSPORTS
	#undef _
};

static_assert(ARRAY_SIZE(transport_ksyms) == TRANSPORT_NUM);

?

Note that I keep pushing for naming HVS a TRANSPORT_HYPERV. Perhaps it's
better to stick to TRANSPORT_HVS after all?

>> diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>> index 0afe7cbae12e5194172c639ccfbeb8b81f7c25ac..63953e32c3e18e1aa5c2addcf6f09f433660fa84 100644
>> --- a/tools/testing/vsock/util.h
>> +++ b/tools/testing/vsock/util.h
>> @@ -3,8 +3,19 @@
>> #define UTIL_H
>>
>> #include <sys/socket.h>
>> +#include <linux/bitops.h>
>> #include <linux/vm_sockets.h>
>>
>> +#define KALLSYMS_PATH		"/proc/kallsyms"
>> +#define KALLSYMS_LINE_LEN	512
> 
> We don't need to expose them in util.h IMO, we can keep in util.c

OK, sure.

Thanks,
Michal



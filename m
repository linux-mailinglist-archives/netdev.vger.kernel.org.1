Return-Path: <netdev+bounces-250569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6EED33591
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 16:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A2E33016937
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 15:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69CF33D501;
	Fri, 16 Jan 2026 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="W83LidmA"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C498336ECC;
	Fri, 16 Jan 2026 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768578898; cv=none; b=eeKuSruURS9QQEXqXMe4bwDpxzk1A0Y2QXCpEr0VM+Xx8HtEVZw5SXWuu4Dg9/7I6BBfDaqu7LUAOYg3gReMcEZ4bCRfTDWB5slUFHNlvZrvE8hSHo/fzVHPKUPIMliWBbMwUkVWwuV1uZX6Zl78NsEKfdXrGlft4uU1HZoZQsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768578898; c=relaxed/simple;
	bh=B+Awa794dqIO+/Uzgn/CPs4acC9KvBiq6b83PYrRyWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLvshlmfOKXcbBkb3rzrJMm1j2vjQnOumHDT1fiKK8LGXT2E2/0jpdO6mmQW4ClPcoCFuYjv1svjj66FNW6kxbkidh2h/FnBk18KqVcmiEBseo5G8ezLzYRVfMniplJyxJB/voZbt9z6YAe3NndEkslVRxKSadbqmtKLHStAXfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=W83LidmA; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vgm9x-009emH-3T; Fri, 16 Jan 2026 16:54:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=pPLXmraDS/TUqdgYNNIBp7gWJwJ6pPMA1qllGIDWHm0=; b=W83LidmAkqN0xBwx1jzBstFEzZ
	9C2xl/3Ener0pW3Q4W4jEwpMzrSvmqu0WKhUxQTxSd1MOCyPcCv2KHw4mSceKC66cLc2AS6tJIIYd
	byLyFi/u9Uj7i6aWwivuFAZ7yQ1pPUjNflazWPKDgq87LUXiOEFMqWS/jyost3mPDFpiYziWd/Vkw
	Yyl3b52hB7G3KL6K2g+Xnw/48HM4B935jkbFmZMN/VCUpckCPA9C1i+SSE3RT+YursLCwz+cDlNVf
	8GQdUHzROdlB0zJbmjupWo9ixh65nKzxTRTVZ3AaLyOK+nov3zWb565Vc7BWRRyRZVJrugu6eU+Eg
	04PzLP3A==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vgm9w-0004kJ-Nn; Fri, 16 Jan 2026 16:54:48 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vgm9i-004Ln0-Ll; Fri, 16 Jan 2026 16:54:34 +0100
Message-ID: <27a29281-03a3-4ec5-b0b1-28d474e0539e@rbox.co>
Date: Fri, 16 Jan 2026 16:54:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vsock/test: Do not filter kallsyms by symbol type
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Luigi Leonardi <leonardi@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260116-vsock_test-kallsyms-grep-v1-1-3320bc3346f2@rbox.co>
 <aWoKNf1AI9s1bmYM@sgarzare-redhat>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <aWoKNf1AI9s1bmYM@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/26 11:11, Stefano Garzarella wrote:
> On Fri, Jan 16, 2026 at 09:52:36AM +0100, Michal Luczaj wrote:
>> Blamed commit implemented logic to discover available vsock transports by
>> grepping /proc/kallsyms for known symbols. It incorrectly filtered entries
>> by type 'd'.
>>
>> For some kernel configs having
>>
>>    CONFIG_VIRTIO_VSOCKETS=m
>>    CONFIG_VSOCKETS_LOOPBACK=y
>>
>> kallsyms reports
>>
>>    0000000000000000 d virtio_transport	[vmw_vsock_virtio_transport]
>>    0000000000000000 t loopback_transport
>>
>> Overzealous filtering might have affected vsock test suit, resulting in
>> insufficient/misleading testing.
>>
>> Do not filter symbols by type. It never helped much.
>>
>> Fixes: 3070c05b7afd ("vsock/test: Introduce get_transports()")
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>> man nm says: 't' stands for symbol is in the text (code) section. Is this
>> correct for `static struct virtio_transport loopback_transport`?
> 
> I'm not an expert, but yeah I was expecting "d" too, but maybe since
> it's static and built-in will be in the text section?

But it does not end up in the text section. Address points at RW NX
(read-writeable non-executable) pages. Please see below.

> BTW I just checked and for example on my 6.18.4-100.fc42.x86_64 I have:
> 
> 0000000000000000 t sock_fs_type
> 0000000000000000 t proto_net_ops
> 0000000000000000 t net_inuse_ops
> 
> And they are all static structs of built-in modules.
> So it seems it is common.

$ mv .config .config.orig
$ vng -k --configitem RANDOMIZE_BASE=n --configitem CONFIG_PTDUMP_DEBUGFS=y
$ vng -b
$ vng --user root "grep sock_fs_type /proc/kallsyms"
ffffffff82c1f000 t sock_fs_type
$ vng --user root "grep 0xffffffff82 /sys/kernel/debug/page_tables/kernel"
0xffffffff82a00000-0xffffffff83000000     6M    RW    PSE   GLB NX pmd

And if I try a 2-year-old v6.13, kallsyms shows 'd' as we'd expect. I've
bisected it down to commit cb33ff9e063c ("x86/kexec: Move relocate_kernel
to kernel .data section"), but I still don't know if it's a bug or a feature.



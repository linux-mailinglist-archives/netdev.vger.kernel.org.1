Return-Path: <netdev+bounces-182628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C363A8968C
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 10:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422BF189D6BF
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 08:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FA628466D;
	Tue, 15 Apr 2025 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/T1M4QP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE1C13D539
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705483; cv=none; b=lQDZJwSYwGDfa4euerGS3A/8o7+Ritvvw9ovuMV5HIy/BlH7RGG8k3WIfVl84+7I7FujsCOpW/EiPZ3xObHBn6KJtT9zwDwbFyJZmQOecYb/WbunQvM3XcSjSpLwQCLvR8itD2mTwIqFDiReEnJyQDCpxzfK8NRrdHKD9OsxnGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705483; c=relaxed/simple;
	bh=vKYv/M9ajhjCM9oA8bR/2eWFDBzWCgzTfxFv/jPwpuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S74uz9i/vakKoJfNsXRaq/1AudHjstTMJYWCaLYEUsffR6fyP60TL4z9GhCVa0UdMS3MhlMFyzo0YFRpT4KEIA9O7oRMz6JSxlNkTu/3ww1lAwpTwK/HOf/rRxMO5E+SKI/yApjQ+vxEtMW9qb6fg4KgeO+RcjZHFMJ6hA0gwC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z/T1M4QP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744705477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fNUQZdJEfgBW55jJBNwuJY4OjuVE5fjTLKdKD/g6/bM=;
	b=Z/T1M4QPtYLnje/osuBDjKy0e5/7XLpmcHIoTbYyLvikGnnbj6mXofatyRzfyw/+Jz6gy9
	rdhkzSqOFe4QLuZtTPZNMT4Q4GmkJ2Ya3UnXOIls2ppaqBN6AquJ9ca6PS5VM1ktGNY0wA
	sb/ceyQL5+TPPx1BN+zaLDNG2u75QOE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-HwAxAsO3N3Wc-KK9tGvBVQ-1; Tue, 15 Apr 2025 04:24:36 -0400
X-MC-Unique: HwAxAsO3N3Wc-KK9tGvBVQ-1
X-Mimecast-MFC-AGG-ID: HwAxAsO3N3Wc-KK9tGvBVQ_1744705475
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf327e9a2so45693625e9.3
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 01:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744705473; x=1745310273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fNUQZdJEfgBW55jJBNwuJY4OjuVE5fjTLKdKD/g6/bM=;
        b=EAM8pC+oKOdnICK00espGDEkTTAQXJKfR9GTbl4rtnrA59BEoeyrL8lWre0wkFAGn2
         K/PWWCW+s741qgZBctunPhbi8zmP8Oro8Jl7ecMFFpUSzrgUWitiZQuEZfVVlg+8+6IU
         e1floBqSHYB3D6K5a1Ivd/rnVnSbQ+HIxcE6hTNHg6B7eLWf+d37fzXnElEeC7g4KS+m
         xq7KxqZSKKQNp/7kli6knQcKFSHpZG8fnhIRrEAjI4EI8IrKYxUYMcyrmQXOZr7LrByT
         Gp0dgEmDAbdmpuCn2GdJ/vPGo009jny0+hgYeRSrRh2hG+zm4y3va5IsYCq2BXULvd2O
         VB3g==
X-Gm-Message-State: AOJu0YwotYfmmJAS60q4phOt38o2hKAUzdFr+3sSlfMoIkT/+apodnIL
	o+FlGkmRaNz03owfRWI46Tr2VYRdeYFiTVvs7NRwB4BdDCnRbkHIrb632LNMmsqz2Yfu+GksrZt
	ldwffB8gQA78OynGT0i2p9gzqCTV8xLl5Orb7tdAmzJrt7k8pLSwGcw==
X-Gm-Gg: ASbGncsbiZu/UN2uTdtzUzwjo8tYfQVrxD7YGUC+1ysEpzCz11yas2rSPuS34Kqysqm
	uGClMGTK15PRrctQbmcGW8hpicBneOnFJGQNUxXhLeYJrIyYUHViWW/YMGoor7/+Rc12MM5ewK0
	QvIVS/b4wNtG3VPFt607j1oc88tU4wzySniVGnWGGDUnYg0NaIzr/7GnfYuYHgDFeW1dhnsQTSy
	KUEsHC4sIlvbY1e0vjRkvukuCT7p2bOtsgm1VaC0noCgs17nho/l2jRFCg17IThldBZniYz6/Wg
	nAqG6QBtO4zJlV+ERWdNTz90gWH1xCWZnwDikWY=
X-Received: by 2002:a05:600c:a53:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-43f3a9aedd2mr137482985e9.32.1744705472724;
        Tue, 15 Apr 2025 01:24:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9p2z4UapZcr7Xqst3QaiQ7S8RXnCmG/NalHMoIBtWDxFXLmzHcbd+AlPzv4FdLt/ZCrgM4Q==
X-Received: by 2002:a05:600c:a53:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-43f3a9aedd2mr137482755e9.32.1744705472321;
        Tue, 15 Apr 2025 01:24:32 -0700 (PDT)
Received: from [192.168.88.253] (146-241-34-52.dyn.eolo.it. [146.241.34.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f206332d9sm201428715e9.13.2025.04.15.01.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 01:24:31 -0700 (PDT)
Message-ID: <0a239bd2-b943-473b-ac3d-d3bf0401df34@redhat.com>
Date: Tue, 15 Apr 2025 10:24:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: tls: explicitly disallow disconnect
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Jakub Kicinski
 <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
 sd@queasysnail.net, syzbot+b4cd76826045a1eb93c1@syzkaller.appspotmail.com,
 bpf@vger.kernel.org, jiayuan.chen@linux.dev,
 Alexei Starovoitov <ast@kernel.org>
References: <20250404180334.3224206-1-kuba@kernel.org>
 <e0ea9f710fde34bdce42515f8c68722015403ab9@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <e0ea9f710fde34bdce42515f8c68722015403ab9@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 5:16 AM, Ihor Solodrai wrote:
> On 4/4/25 11:03 AM, Jakub Kicinski wrote:
>> syzbot discovered that it can disconnect a TLS socket and then
>> run into all sort of unexpected corner cases. I have a vague
>> recollection of Eric pointing this out to us a long time ago.
>> Supporting disconnect is really hard, for one thing if offload
>> is enabled we'd need to wait for all packets to be _acked_.
>> Disconnect is not commonly used, disallow it.
>>
>> The immediate problem syzbot run into is the warning in the strp,
>> but that's just the easiest bug to trigger:
>>
>>   WARNING: CPU: 0 PID: 5834 at net/tls/tls_strp.c:486 tls_strp_msg_load+0x72e/0xa80 net/tls/tls_strp.c:486
>>   RIP: 0010:tls_strp_msg_load+0x72e/0xa80 net/tls/tls_strp.c:486
>>   Call Trace:
>>    <TASK>
>>    tls_rx_rec_wait+0x280/0xa60 net/tls/tls_sw.c:1363
>>    tls_sw_recvmsg+0x85c/0x1c30 net/tls/tls_sw.c:2043
>>    inet6_recvmsg+0x2c9/0x730 net/ipv6/af_inet6.c:678
>>    sock_recvmsg_nosec net/socket.c:1023 [inline]
>>    sock_recvmsg+0x109/0x280 net/socket.c:1045
>>    __sys_recvfrom+0x202/0x380 net/socket.c:2237
>>
>> Fixes: 3c4d7559159b ("tls: kernel TLS support")
>> Reported-by: syzbot+b4cd76826045a1eb93c1@syzkaller.appspotmail.com
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> Hi everyone.
> 
> This patch has broken a BPF selftest and as a result BPF CI:
> * https://github.com/kernel-patches/bpf/actions/runs/14458537639
> * https://github.com/kernel-patches/bpf/actions/runs/14457178732
> 
> The test in question is test_sockmap_ktls_disconnect_after_delete
> (tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c) [1].
> 
> Since the test is about disconnect use-case, and the patch disallows
> it, I assume it's appropriate to simply remove the test?

Ideally, yes. disconnect() implementation by its own nature error and
race prone, I guess  TLS adds some more spice to it. Unless there is a
real end-user scenario behind it, removing the disconnect()
implementation is by far the best option.

Still the test presence hints at some possible use-case[???]. Was it
created using the plain tcp test cases as a template?

Thanks,

Paolo



Return-Path: <netdev+bounces-192551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B3BAC05DD
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 09:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED294A00D4
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 07:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5DA1E32A3;
	Thu, 22 May 2025 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJMCBnel"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CC2221FBF
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747899425; cv=none; b=jI3rVWx8Nxj6jXHjhDb3u+C/iGRe+sKS7Bdj7DJZUrDp0uIRrAX37G/ufq16wchBnPkqkhZOeJb4U8EBmTw7dpmRP8MekgWxCD/qNvyAD1q59kU0h3jTWYQaKgrMooz4zjzATPUIa/Chon1cWBnxxKsveTtWg6+TQlFX/BaQsoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747899425; c=relaxed/simple;
	bh=MhUQi67lHUlGkXBhHW/SZd1W/BKvqtEtFsl54vZLR6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wc/itXnR4xpLJqZu5pd5yC3ljzi0M4/rnMsU/kk0TzpfVIRJqMxh4/YUT0jbijujic0kqusuwi2iyChaXtSlui29goyqC1iDmYzvIQu1J2UmdwSkZ1C31SLaI4PrcP9EUQvfJLqtLcpbg2W9JiM4FP9aWMMPDNy0sT4kpICgiOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SJMCBnel; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747899422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jGzce2M0Egzfrl5h60jDGBZlObDAqhO7BYWw1jcjwRc=;
	b=SJMCBnel6TMs1bD94okaBOiii5O13ug1NrZtIiShv5YYiV99OpiLBLkTfq1CiruxyHL+vZ
	HigllqFbIPSGndQZmt/IKXtW+2iCwEpM3Zk0nMegX0ZZfX6Oey+Qsfhzq6lfXhvMAsTxoV
	iPsDdEz1KZZY1N4/JyD5lk3slQkLNCg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-9X9n8KE0Pk2yHtDkrh0Ixg-1; Thu, 22 May 2025 03:37:01 -0400
X-MC-Unique: 9X9n8KE0Pk2yHtDkrh0Ixg-1
X-Mimecast-MFC-AGG-ID: 9X9n8KE0Pk2yHtDkrh0Ixg_1747899420
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-442d472cf7fso59205055e9.3
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 00:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747899420; x=1748504220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGzce2M0Egzfrl5h60jDGBZlObDAqhO7BYWw1jcjwRc=;
        b=lqWpAKYS8EG0ygWyxRrk8eDRBH7XZVEtwj1520nYPHmrKbVAmVFp7eOdmsuQCotzVT
         m20uaUwPFMFSi7xDH/0yu3Dt2VK2dJ+/85LUP4zz67ZJFHhyfW99yxgtjsD3pItCU9mD
         RbYFq65rIO4UUHP4nIJ5fHLdq0UqDT+99CtfZePd53la6RMPM9TXuWD9QTnHPV/whr8Y
         C3COFtyG0QZUSrDKVc4qUP8K0WgpS18vM474iKWzknEnrOtSgQ/YuD3xwF5m74O6D5H5
         4MvspoCp/dYqT/ozZo1dN1gmFJcnxvJIuWewsxfmtJA7ORN8qeM8qofEErC+pAhI8oIz
         KqEg==
X-Gm-Message-State: AOJu0Yxahy+B2fKJyPa4uNR7Spyvxg9N8OWjcp4Nd/acux7f3HmscgDR
	uYeY/23GIhblkEuLMoLS3m5o1FECoSwulQpnzv4oLeAjbGchrXV/l14YmW3VBF91qYEdUsVM1DR
	4/VCytU3HmsfzMKkLgFCVY856Tmsnj7YJQLJOMHHaNUjypwZM+prI4PwWMMG8BfNSE4j3
X-Gm-Gg: ASbGncvS2MKU0IfRPqHp6+44MNpywC4+OTNYR/imopXClnhY+nx6LgRGbJCFGHFMfU2
	tMSOvQiQ7JHdi8h2phcgODk/ebne+wBbJrP/LpQzBsSDRUjbyLSniK6sed4jcBSMDfn02swBjbh
	ARcWfRdgl+xgmZf+6VCYtPFDBrQJr3vLj2ibhFdbDtLLRAeH8lZpAjGgHoWWfmT2JOuKP1/xcye
	fNZg/+mHFWaGIUPBprJGNuO7K2WZxVQ6qV3lNfaZ0QENzUSAm7BKY/HG1NRhvlRtNvRcSChCQmD
	pT8mxLHlYtT37te2Sb8=
X-Received: by 2002:a05:600c:1d81:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-442fd606b8emr227710105e9.4.1747899419793;
        Thu, 22 May 2025 00:36:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFRyShp8cUV0MgYi62QPEO/hFSDw332Y5eNFZ2okW1FoNh6erJ5c+RArJcsTPlsr/E5Yqe3w==
X-Received: by 2002:a05:600c:1d81:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-442fd606b8emr227709845e9.4.1747899419431;
        Thu, 22 May 2025 00:36:59 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247a:1010::f39? ([2a0d:3344:247a:1010::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f1ef01besm93633655e9.10.2025.05.22.00.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 00:36:59 -0700 (PDT)
Message-ID: <97283e6f-6018-4252-b3f0-e620f989c065@redhat.com>
Date: Thu, 22 May 2025 09:36:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 02/15] net: homa: create homa_wire.h
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <20250502233729.64220-3-ouster@cs.stanford.edu>
 <835b43b9-b9c4-4f09-9ce3-9157e1d9fea6@redhat.com>
 <CAGXJAmzxOxYHR+nM8qhFx2DrCD8dbPyzF-xsv40p3tO6EdDP2g@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAGXJAmzxOxYHR+nM8qhFx2DrCD8dbPyzF-xsv40p3tO6EdDP2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/22/25 7:31 AM, John Ousterhout wrote:
> One small follow-up:
> 
> On Mon, May 5, 2025 at 1:28 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> [...]
>>> +_Static_assert(sizeof(struct homa_data_hdr) <= HOMA_MAX_HEADER,
>>> +            "homa_data_hdr too large for HOMA_MAX_HEADER; must adjust HOMA_MAX_HEADER");
>>> +_Static_assert(sizeof(struct homa_data_hdr) >= HOMA_MIN_PKT_LENGTH,
>>> +            "homa_data_hdr too small: Homa doesn't currently have code to pad data packets");
>>> +_Static_assert(((sizeof(struct homa_data_hdr) - sizeof(struct homa_seg_hdr)) &
>>> +             0x3) == 0,
>>> +            " homa_data_hdr length not a multiple of 4 bytes (required for TCP/TSO compatibility");
>>
>> Please use BUILD_BUG_ON() in a .c file instead. Many other cases below.
> 
> BUILD_BUG_ON expands to code, so it only works in contexts where there
> can be code. I see that you said to put this in a .c file, but these
> assertions are closely related to the structure declaration, so they
> really belong right next to the structure (there's no natural place to
> put them in a .c file).

The customary practice is to add this kind of check in the relevant
_init function, see as a random example:

https://elixir.bootlin.com/linux/v6.14.7/source/net/ipv4/tcp_bbr.c#L1178

Possibly a good location could be the homa per netns init.

/P



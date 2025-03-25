Return-Path: <netdev+bounces-177467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20933A70462
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9824116B411
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7988F25A64C;
	Tue, 25 Mar 2025 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J56m4qYg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9D225A638
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914642; cv=none; b=pbhxQDQKWHaQ3n9eDkX8JZiSoVVHle+Ulz117lLGm/+BOK6TORr+bEtvJJO58k5E8MoHIVXnxKhZe6Nwd3IgHNOig3hWrX8d382oemBa5ol8o+GVd+YyrWBr2c/TYnouEvcNEex1X636zpp+xkyYjVrl7fCqIagHhZBCmT3YnbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914642; c=relaxed/simple;
	bh=1DDCb/rE5y0uCUgnbi2crL4gY7ukwSS2UrHJ0uyjq0k=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mSfh52PrV54OAHcUwZmUSTZwXjy37grgXHeQdObhMYvYN3Ofa21a4Tt3UauEMnLfUX0gAG/Fy53xLZ75KLUc0GTAMI2gDCwCeuI/c7m3vmy4x4yjcmudQbO5H9YY55piuHTm2YFEs/iXaKbwXT+K7n+3VvsGrGprJy/V1pLRkWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J56m4qYg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742914639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fGpw7+lzDBqKQi13meiBn0xCYbAhrMYmTI+bEs2bkbo=;
	b=J56m4qYg4tyKbhv2CRAmwpxdGTtGCrmCFdbswCbncZApatj0XEWiZQhSZAzw8MvDb8uXrS
	X6wY4+O57cI1GaTpPSmI/lPYbke1RpXEw4167c68TjZgV+NEqiXDzXuPRBkkuodaZ7wQZu
	gfX4XtfjK56uuY6NwZGFNCzTQZpVTqc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-UEZFxCRTPimP4RzjUg-syQ-1; Tue, 25 Mar 2025 10:57:18 -0400
X-MC-Unique: UEZFxCRTPimP4RzjUg-syQ-1
X-Mimecast-MFC-AGG-ID: UEZFxCRTPimP4RzjUg-syQ_1742914638
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c0b0cf53f3so874937785a.2
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 07:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742914638; x=1743519438;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fGpw7+lzDBqKQi13meiBn0xCYbAhrMYmTI+bEs2bkbo=;
        b=r8pN7PKDl0gNwOdzZFaeJketv12sU+Omh/XJW5gpp2m1+Y/LU1gd3i63RUwiDo4Gvn
         r65BKNU6YMUDfpLgNrO81suG2/FyzuG19KAWHGFJqcfKJMg838K3v7owbawmPo8mW6O9
         OCkvoNqCiexmYsaf27yRQE4ItOajuWWy+R+bV6Z8hLzehOHPwd2v3iEMHQWfPASJx3eN
         tOLtoaXem7OB+GRVhSzrrbHgVrUlOnLLBOyt9ed/AuJPeXILDrPCyA+bUiLVuC6aJjzF
         R/ZOleryTX3JLsDyF9/hz7dKp1lGjv9sGp/2iZYwgH5/QWb6S8wHFQ39okUN8P8VDzYj
         kbUA==
X-Forwarded-Encrypted: i=1; AJvYcCVEgmQMzQsad9SrMu3ugxPyXNPAprXMC1eMKaGSDl9wJJNxJyxHLEzNhEmNNXtRFn1vUCS7vh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaE765F5f6N1Eg4hrM72Fi2pU3YiB+Z6jeFl2Yczbmcz6eh6bG
	fh+RoDa45BMP4B1ovUuSWQ7uLY8d1NE3VTWoZIPuQcmxEibr3zdGSgNJXTPGvTV7wcYcg8DucpI
	qoWD2VFUOZorSvKMcwlByFoCQ6fYaFhqISwhrPwHFfzCGj6wwo0hhcA==
X-Gm-Gg: ASbGncv6txXdV1iQ97zyby5O7tMvRqzQjawbueDmg2c3UIHUgxgq/eycf5izFPYLl9w
	3Ay/apSb5q9zEhkPV2jaeRdfFaLdFDt+ts4cihOykGMwDz2tkQrDiovlDybSCUX9OSIcyGQhFcA
	2pbxlvV13muw3u5QNCeUMxXioLlB3e+R+yFwBWcHvQxgKafq4SD1UsYqjzM6fgM6VlJwXrHcNuC
	sEAWAfKxNHU6r5MlbkX3Jm6xQGJ0GpzaTkrYB5jKlm6dZlLevajyLFJPG5393CieieFgHicNsUX
	nFcs5wZjgrnkBo7vWHGrluqFGO53ncJGKqCnZV7iHqaKSB0Fz2WBW/QCDUHHUQ==
X-Received: by 2002:a05:620a:198e:b0:7c5:5791:122b with SMTP id af79cd13be357-7c5ba1ea609mr2241138885a.37.1742914637804;
        Tue, 25 Mar 2025 07:57:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdw4wa5MlvyVnws/DGXFKT5gLLg1vPYIG4jsjd3K++5hHCV3YaqI48me4hpLE7Ev6rVqlKmA==
X-Received: by 2002:a05:620a:198e:b0:7c5:5791:122b with SMTP id af79cd13be357-7c5ba1ea609mr2241135985a.37.1742914637381;
        Tue, 25 Mar 2025 07:57:17 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92ed0a9sm647869685a.65.2025.03.25.07.57.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 07:57:16 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <e4974c9e-057f-4f3f-ae2e-67a5da51df01@redhat.com>
Date: Tue, 25 Mar 2025 10:57:15 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with expedited
 RCU synchronization
To: Waiman Long <llong@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Peter Zijlstra
 <peterz@infradead.org>, Breno Leitao <leitao@debian.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, aeh@meta.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jhs@mojatatu.com,
 kernel-team@meta.com, Erik Lundgren <elundgren@meta.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
References: <20250321-lockdep-v1-1-78b732d195fb@debian.org>
 <20250324121202.GG14944@noisy.programming.kicks-ass.net>
 <CANn89iKykrnUVUsqML7dqMuHx6OuGnKWg-xRUV4ch4vGJtUTeg@mail.gmail.com>
 <67e1b0a6.050a0220.91d85.6caf@mx.google.com>
 <67e1b2c4.050a0220.353291.663c@mx.google.com>
 <67e1fd15.050a0220.bc49a.766e@mx.google.com>
 <c0a9a0d5-400b-4238-9242-bf21f875d419@redhat.com> <Z-Il69LWz6sIand0@Mac.home>
 <934d794b-7ebc-422c-b4fe-3e658a2e5e7a@redhat.com>
Content-Language: en-US
In-Reply-To: <934d794b-7ebc-422c-b4fe-3e658a2e5e7a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/25/25 10:52 AM, Waiman Long wrote:
> I agree that the commit that I mentioned is not relevant to the 
> current case. You are right that is_dynamic_key() is the only function 
> that is problematic, the other two are protected by the lockdep_lock. 
> So they are safe. Anyway, I believe that the actual race happens in 
> the iteration of the hashed list in is_dynamic_key(). The key that you 
> save in the lockdep_key_hazptr in your proposed patch should never be 
> the key (dead_key) that is passed to lockdep_unregister_key(). In 
> is_dynamic_key():
>
>     hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
>                 if (k == key) {
>                         found = true;
>                         break;
>                 }
>         }
>
> key != k (dead_key), but before accessing its content to get to 
> hash_entry, an interrupt/NMI can happen. In the mean time, the 
> structure holding the key is freed and its content can be overwritten 
> with some garbage. When interrupt/NMI returns, hash_entry can point to 
> anything leading to crash or an infinite loop.  Perhaps we can use 
> some kind of synchronization mechanism between is_dynamic_key() and 
> lockdep_unregister_key() to prevent this kind of racing. For example, 
> we can have an atomic counter associated with each head of the hashed 
> table. is_dynamic_key() can increment the counter if it is not zero to 
> proceed and lockdep_unregister_key() have to make sure it can safely 
> decrement the counter to 0 before going ahead. Just a thought!
>
Well, that is essentially an arch_rwlock_t for each list head.

Cheers,
Longman



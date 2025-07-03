Return-Path: <netdev+bounces-203744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90476AF6F21
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785E31C82752
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8772DFA2B;
	Thu,  3 Jul 2025 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBdPgt8e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802B22DCC1F
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751536032; cv=none; b=fw2N1WHXvbF9tU0GzkhyQz5epR9f2pV32254Wj4LjIRg2tkUG1LqkBI3JYQsve9riKEnR5qVVmWgXLStHfHF0YCGfOb1Y5L4tjTlp5pAPLdy5ww+Nw20F1B1r42U34OkWrN7BZesNpikRuI2C4zhE1bjZmmPpUHiVm74QWKKnvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751536032; c=relaxed/simple;
	bh=vAUqcE9WHLgFLocug0JQgsHfQyTephzjFLwqPNC07jQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jt3z5lkQGjhXgUa5ewyyPyg8gx4WpRRgG3NGVURwuPpVoqw9QxSIO92ngLrjlkIZj1KVLMrWkDgrm7d8JDb4N4IkmXZiU1MOWHzNw5eyQBXtTxvTSIGeXfCJY9qlvjAif3rKbKjTCXdaL3Y8IqAOEEXV8EanjQ+mn2gaK4CSYW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TBdPgt8e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751536029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RdONWkev/uzh24ec7UGP8PGlZlG60mDJHMOgMeP9f20=;
	b=TBdPgt8ev0KT/H7Q7M0MN7XtypnoOQLOVmWta2qalBaJYeGa+iQr9R/L8vPEYk7qJu9JLv
	+bjXVofNEBWAQ9QWiO0hT32DzR4cJ13LRINqQsMkNV0xgvfPuEwIHC17Rp/gqCs8wa7+u6
	Hqj/HohXtuqOCqlvIVqkhbwZNQ/v43Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-9XtKXwqeNVi6PWFPmpRFZA-1; Thu, 03 Jul 2025 05:47:08 -0400
X-MC-Unique: 9XtKXwqeNVi6PWFPmpRFZA-1
X-Mimecast-MFC-AGG-ID: 9XtKXwqeNVi6PWFPmpRFZA_1751536027
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4539b44e7b1so30536675e9.1
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 02:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751536027; x=1752140827;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RdONWkev/uzh24ec7UGP8PGlZlG60mDJHMOgMeP9f20=;
        b=N2//NIwQ7r6cjhRQUAsSTE/plkzLeB7vX6rSaKLbDyQM5m+1pyOMOsr2UH1qsHA1qt
         3NSAqNs/IIBOW8vSWi4Qo2OcGW8ik8Ryl4q1vphYz9p9zGg/eT2YvyixAxfy6vOeBJqw
         Zrw3hYGFfklraDxXX4I1dNi4JFmd/nMKcusM2VZDaR0cpEAVWa9NMsat+Rz0kSJ5kRm7
         dqwygel2i8DzQr2vMlAdOeDYFG4MFvyRH8v5Lvwne2mKMffh5cqn5m0PEpRPe8zWbcxp
         ofzBFlrGNH+u/2JRIISfGUdVbc7CRkyOFyR7daif5KAuTThX6p5vFR8RIjDsO5y2rCuv
         N/AA==
X-Forwarded-Encrypted: i=1; AJvYcCVGyjdyF7430rOhsVkpUium0qirB2W+gIn+qUcAgsKKF+ZEhM9TiX9l2/S5Dd7uUe3vgWR81Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIkO+frlMMf8cpUNeD+RBBAHAN7l95bczgoaF5ZUcH2NOBtGLm
	0sNYWTiwszZVbzC8+MJjdMGT1NbK9ZGZk22jG8pe6sFg5NO/W4sxbgkM1R1xMMDzUhhJcW5EPIR
	2r1s+XrnpSKqvqDooodjY7ZVfd2Gslxw1T/8GeLkC4yTiabRI+4yGFhFzyw==
X-Gm-Gg: ASbGncsP1gT0auE2QmWuRDUwuLSWHcYva708mENalXE/KFkbEnPWiQFwOsTN1S+xHM6
	gw3p6ySQ1h+ZjlK8Ily79YkqOWwhnOH/ZCgFvo4rsljs1UAjAhxJpLV+9dkCG2jdsvWv8j9E3MO
	Xqmhjr+bvS5KM9zJkJneq0tZfKOl3L8tKNu4vgvo6dDbpCp2dMqfjbNt4NnJpUMhYljAMoxvWo3
	HjPEbEvxDLftgYD5XTuj6aGpzpSJ9g1/4y0rrrFqFf6X29UgWxVEno2/qAqIInVlk3GUn9YZ5zq
	iRZaw5qd/f8Fszx8wZlfkJ3/udzt5aKURLmpoNaHzzslpBU0mf2SVimRQ6eE/LH4+VA=
X-Received: by 2002:a05:600c:3f0e:b0:43d:160:cd97 with SMTP id 5b1f17b1804b1-454a3728d1dmr56455915e9.25.1751536026748;
        Thu, 03 Jul 2025 02:47:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTquN2HQ6ykNf+B6aChu4ZLFvBv5XnqVUeKx73fDJCojdl+3JrMQRzkT7i5t5oqAJP5BLuGQ==
X-Received: by 2002:a05:600c:3f0e:b0:43d:160:cd97 with SMTP id 5b1f17b1804b1-454a3728d1dmr56455635e9.25.1751536026306;
        Thu, 03 Jul 2025 02:47:06 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314? ([2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9989328sm21313015e9.18.2025.07.03.02.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 02:47:05 -0700 (PDT)
Message-ID: <509f34f9-5eee-4ba3-bd09-dfd2d47df0bb@redhat.com>
Date: Thu, 3 Jul 2025 11:47:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests: net: fix resource leak in napi_id_helper.c
To: Malaya Kumar Rout <malayarout91@gmail.com>, edumazet@google.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAE2+fR_eG=eY+N9nE=Eh6Lip4nwWir2dRQq8Z-adOme3JNe06Q@mail.gmail.com>
 <20250630183619.566259-1-malayarout91@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250630183619.566259-1-malayarout91@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/25 8:36 PM, Malaya Kumar Rout wrote:
> Resolve minor resource leaks reported by cppcheck in napi_id_helper.c
> 
> cppcheck output before this patch:
> tools/testing/selftests/drivers/net/napi_id_helper.c:37:3: error: Resource leak: server [resourceLeak]
> tools/testing/selftests/drivers/net/napi_id_helper.c:46:3: error: Resource leak: server [resourceLeak]
> tools/testing/selftests/drivers/net/napi_id_helper.c:51:3: error: Resource leak: server [resourceLeak]
> tools/testing/selftests/drivers/net/napi_id_helper.c:59:3: error: Resource leak: server [resourceLeak]
> tools/testing/selftests/drivers/net/napi_id_helper.c:67:3: error: Resource leak: server [resourceLeak]
> tools/testing/selftests/drivers/net/napi_id_helper.c:76:3: error: Resource leak: server [resourceLeak]
> 
> cppcheck output after this patch:
> No resource leaks found
> 
> Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>

Lacks fixes tag and a target tree ('net') in the subj prefix, but please
do not resubmit, as there is no resource leak even without this patch as
the kernel will close anyway all the open file descriptor at process exit.

/P



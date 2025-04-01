Return-Path: <netdev+bounces-178554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D391A778C8
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 12:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 674967A2B0C
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 10:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582811F03C8;
	Tue,  1 Apr 2025 10:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7/B1RWO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CF71EDA35
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 10:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743503250; cv=none; b=ZZi0xmaeTUUi3InfTMSBPN1ZAQTBwCXH47BeAOwxCHp9oxY243ufjLySa+PVSjeMG1St/dHwOgmKQl5oBKkyMy9mlqlUZnMhPK6FN8oUomIcSkGVZ3wb4lys1fIfIHQGgjS/8UucF2teryE2YHX/V/JXJbtWqzb+MAsIkb5btvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743503250; c=relaxed/simple;
	bh=i65bli/LUjeAzAEjbdZeFArLOirreOB4o5/lk4mXqsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mPTM8MPIFI/oP/2JfseIsPfQQbAy1bR0rZfWfgnlm3dbTgpgqdjjYbnorTL5JKiBCDdcl2m+3hin9k9YOw8W3NyOfS6wj32H8mZx5Yi3J6u/XK6Ev2idz0CkZE820gDMBiBcZZLV9NBfcgG43pA3DJmJzIIxva4hM/HUO6zPvvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E7/B1RWO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743503247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCMlwQTPbF+tcTXJk5vNlRndQ5yW7K0i3e1xn78wccs=;
	b=E7/B1RWO9YRw+XlsdaQz1uOtrnDZLpyoKOG11CxPhCeMp5UGrtS733X3+v6UifpkXJ5Bq9
	X/Dp8STJVLGVzJsoLXEE4Ejq1PbQpXjidc+a0rhVxxXWeQM/Tox1t2X/I6FkAO/1w1exsi
	cXg5W060iZWuUI3D/IVeoejnn57Cwew=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-3Pk9jkexOVu9YZbaAtBziQ-1; Tue, 01 Apr 2025 06:27:26 -0400
X-MC-Unique: 3Pk9jkexOVu9YZbaAtBziQ-1
X-Mimecast-MFC-AGG-ID: 3Pk9jkexOVu9YZbaAtBziQ_1743503245
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39130f02631so1800639f8f.2
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 03:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743503245; x=1744108045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lCMlwQTPbF+tcTXJk5vNlRndQ5yW7K0i3e1xn78wccs=;
        b=KEE24ZmpewlOFcAVPdf3gobk4CoUnB+bKBCplKVLLNS7jLoBCsmCAFL/G134EGLkMv
         AZomHb1N+jv4McVpxjoy8z+ui69zU5rr25ncbewwbJrrDay0Npvv507qYFaXVhhyEIjm
         PXRwf7posm6q22PAkDvRAQ6RSTZsC2Jcmg0/s2X+7SD/JNdC9NSULiiu1OwfNK7t8aI+
         s5DDoaWhAIkkK5X2A/cqQPfYOCbWqlFXt+jHYnSYk4ro5ygWJnSWqtWgaEfLmM8KWcjv
         5PMuQTzOWXcsTwNWuNLclqpI9eAYtL3K/Sa1UYoMpQiHKbZV2s3OwQy0xfM3YeYByPU1
         BY8A==
X-Forwarded-Encrypted: i=1; AJvYcCVtefMZdVz/LiYugZggrAnlEoi3jXXvX2f5q00q0UT57tK4IQ3aPCwhC4b2oi8Rp0ZYxcAmFKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz97VtSXWTo9hX49F3dlWwNo8PzRfnt/DxYOIfz9mJ7rY5Nr3dR
	fldCHvWdJFCXfzl7DwhYjoVtcukPzz1IQ/b08+D459bnvNoc5H+ObrXhY/RFiVSdgYSwFxx0zrU
	jrkyGKnkj8xhx9BNlHHyZ+Ok/f2YhJVqd+wJM8kPSiOiHsswY2i9ikA==
X-Gm-Gg: ASbGncscTspTFPeJjSNzTwOSnf/C5zNjxbggvnUdRCNh+W7EsqX6xSPsyvg02tEPFKZ
	lZLeYzpkb7zpSrHpAgTPknV+/Up4W464AEFio5cEOmjVBeq0WAg30etUhi3yLGy42vvujBDCq3s
	2uBVNvjAskc0hL3alRw55LcZiBzH6WW1ojeqRx3J9Y3KrXN9wBgW4fqu72nZWXEknue/8YPRjdK
	2ly0cA+kmqvu/ySMoswYsRY9n5pIO0UFdMghspGl4jAVSHwnNy+ZmkW+alXSCfjsz0RwlVjS7MF
	k5URR25ngozOpMpx/oL0FgnlQI/hYVBeeMzSHR3N0Z+ykA==
X-Received: by 2002:a5d:6da1:0:b0:391:13ef:1b1b with SMTP id ffacd0b85a97d-39c236500aamr1960634f8f.30.1743503244341;
        Tue, 01 Apr 2025 03:27:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErywGUsB1jww0h7aRyVpVwYFuo7TtXzQBsO1rG5ZLjGsVlSSuop7KaYODnx/bHOTtheyZ/BA==
X-Received: by 2002:a5d:6da1:0:b0:391:13ef:1b1b with SMTP id ffacd0b85a97d-39c236500aamr1960614f8f.30.1743503244004;
        Tue, 01 Apr 2025 03:27:24 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a420bsm13526035f8f.82.2025.04.01.03.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 03:27:23 -0700 (PDT)
Message-ID: <6859da28-6e54-49a1-ad12-759fb85537d8@redhat.com>
Date: Tue, 1 Apr 2025 12:27:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net 0/2] net_sched: skbprio: Remove overly strict queue
 assertions
To: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org
Cc: jhs@mojatatu.com, jiri@resnulli.us
References: <20250329222536.696204-1-xiyou.wangcong@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250329222536.696204-1-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/29/25 11:25 PM, Cong Wang wrote:
> This patchset contains a bug fix and its test case. Please see each
> patch description for more details.
> 
> ---
> Cong Wang (2):
>   net_sched: skbprio: Remove overly strict queue assertions
>   selftests: tc-testing: Add TBF with SKBPRIO queue length corner case
>     test
> 
>  net/sched/sch_skbprio.c                       |  3 --
>  .../tc-testing/tc-tests/infra/qdiscs.json     | 34 ++++++++++++++++++-
>  2 files changed, 33 insertions(+), 4 deletions(-)
> 

Acked-by: Paolo Abeni <pabeni@redhat.com>



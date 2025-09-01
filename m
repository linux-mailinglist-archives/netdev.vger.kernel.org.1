Return-Path: <netdev+bounces-218637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52880B3DBA2
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 09:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B1F3B415F
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 07:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1E72EDD5A;
	Mon,  1 Sep 2025 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I50b5nhY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3312D7DC9
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756713563; cv=none; b=WPqLKaulCYfAAZHHCAFRyRmsytXrAUe7ylIQ4vbAh/RhlDkvwEuZUHyIex3hkDhPFnsFk7XLhHvlOpqXMw/52V7qykxqP4g6bFDhw2UvVzJnw/7T+ru8lpYdYs00Uq5dH5yQ63V87qtRl/MB+H3UaNiFhqo+Rs3nc0+ML7zhFeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756713563; c=relaxed/simple;
	bh=WYKmLS0ZST4WZUWfXGMPop0gt4xEt8NhisZIRGP3+XE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sXc7n7h9ccjIw6FSgNEkOCDUyOZAcNgWmeid98iHVNch3rEc4lSJxepOShKYjt9L8vxj7PaqcnGno5d2Ii4bQ1yos/Qjp7AsMzlGKlCS7mTfA+FbrSpxKjoviTuwz2G1iZXShS0SEg/94kPJ1Vyxqm6wsOhzW3L2EDhPUJnVfQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I50b5nhY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756713559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbgVwgAt4LZARVhzmIMwOJNl6sp8FqQV1C/DFB/D/Vo=;
	b=I50b5nhYYVnhnAbTxPBXZPQRAMhUva6tI0xxfshZM9shpU6WodIItsEwoY47TsqNC3WjBF
	4xfSUwJSzCfWCNKpVwWGTzAF5wVk6hztpRvhr6i0Cj6QDn4Go4FFcpf5fqp2/2vRIz1aoX
	VOXMiH8R22nlrHLhaffF+y4sJGjsWR8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-WFQ1gU9kMV2biNEPX1c9Dg-1; Mon, 01 Sep 2025 03:59:18 -0400
X-MC-Unique: WFQ1gU9kMV2biNEPX1c9Dg-1
X-Mimecast-MFC-AGG-ID: WFQ1gU9kMV2biNEPX1c9Dg_1756713557
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b8a2b9fcaso7127465e9.0
        for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 00:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756713557; x=1757318357;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbgVwgAt4LZARVhzmIMwOJNl6sp8FqQV1C/DFB/D/Vo=;
        b=rkvtuidGjPmIUpFkslF91rpkJGpCzBzIGH37cmcn4XDtvxW2uF5ZhfirfoVprVCnQk
         fMIDrnG/67e/CJgOcdsJrIzWi8kY9SBLFIRlqIjd28tC5MNIsWlgHbUt0MPaLEcJA9fo
         6eK8UZcPVKX56E1kmPtA/mPImk1GBqnwamXCZ+rjoT1FCyC0CdzDoFD9Jejg0Afyh5k/
         p3nWwEroMp1OtKmLk6bC02/RGjuY/sdHIY7bbvUpJWWm7W94Wg3qsFtBogCDSSsdK+EG
         sN63B5uhwZ/UsLulL1JDwRQsK3U1lO3WajaH93pBCbXoJGKUSPj9BbJN3bnKtV5abAzN
         W2nw==
X-Gm-Message-State: AOJu0Ywd9bTTGB7rHaap4dwS7WaZv818caIwa8aGS2G53gCpd7ZrKyYd
	EFQESfD9Ps1bXTOY8iOsieWIHdHpiS1Rs0xpOLPdQV+nsHQ/SvRTGe+SS4dLtkRrfG/Rsecna3I
	BtCiqSw6pzGp3LBenGW1ADNVenYbTeJ+4P6X502+fxCT3rPmDp4uC414niA==
X-Gm-Gg: ASbGncvdXsBrtTo1yqxbaupIMHW0p4fKPNPjBLkE7VECfCtDSNSyvJAW8xuPg1cRp1s
	PZ8i6AnScmat8gS6Lw5GFLi0B5gL5h1yC9FNMS+CvMUUhCCOb+s8hPYiYB7G/om/1/xXdcQH8i6
	a4gxxOaslOjoXgGFWcVn6juISgJY2n0Y1gKd8QMnGeYVsbrn/zlJl0iIEnnXaWoc+pq43ZzhpT1
	4bxKPHpBfArldWkqwBTk78ainaQxmVZbKx/swrSKHi4QhCg4UhZBh2UGcP1+4Y9Y7j02ZYp5CAU
	GYK9GtthqCxI8DbPDJiSZD67cTPlurgrX42BJBJQbJ5crCvq4qkR0TKGeIJqKsYCAH5ab+ni2F0
	fye6H86/Pgpk=
X-Received: by 2002:a05:6000:200b:b0:3ca:4b59:2715 with SMTP id ffacd0b85a97d-3d1dcf56456mr4980820f8f.20.1756713557275;
        Mon, 01 Sep 2025 00:59:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG00zIqhUhmP0vdPxsuoivNu3GWDMuKa+wFOFLqPE308iK/19D6Ugr14yy1Ctw8eXrN5nMhUQ==
X-Received: by 2002:a05:6000:200b:b0:3ca:4b59:2715 with SMTP id ffacd0b85a97d-3d1dcf56456mr4980807f8f.20.1756713556914;
        Mon, 01 Sep 2025 00:59:16 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e50e30asm146536405e9.24.2025.09.01.00.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 00:59:16 -0700 (PDT)
Message-ID: <5ef10a85-3b2a-468e-8a67-200c6ad63dfe@redhat.com>
Date: Mon, 1 Sep 2025 09:59:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 03/15] net: homa: create shared Homa header
 files
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
References: <20250818205551.2082-1-ouster@cs.stanford.edu>
 <20250818205551.2082-4-ouster@cs.stanford.edu>
 <ce4f62a8-1114-47b9-af08-51656e08c2b5@redhat.com>
 <CAGXJAmzwk87WCjxrxQbTn3bM8nemKcnzHzOeFTBJiKWABRf+Nw@mail.gmail.com>
 <6d99c24c-a327-471b-964f-cfe02aef7ce2@redhat.com>
 <CAGXJAmzpibzh+4FvM4mcvkXeT8f0AhMK00eqie7J8NEU9Z9xWg@mail.gmail.com>
 <fd3b25a3-018b-4732-af42-289b3c7c4817@redhat.com>
 <CAGXJAmz=DweQnvpWhgACnCUcxhq1-Yp9m5KznSL1RNCX-p_-EQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAGXJAmz=DweQnvpWhgACnCUcxhq1-Yp9m5KznSL1RNCX-p_-EQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/29/25 7:08 PM, John Ousterhout wrote:
> On Fri, Aug 29, 2025 at 12:53 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> If that is percent of total CPU time for a single core, such value is
>> inconsistent with my benchmarking where a couple of timestamp() reads
>> per aggregate packet are well below noise level.
> 
> Homa is doing a lot more than a couple of timestamp() reads per
> aggregate packet. 

Than it looks like this is the problem. Data processing should require ~
a single ts per packet. If you need more for instrumentation, you should
likely put such code behind a compiler's conditional and enable them
just in devel/debug build.

Or even better you could use ftrace/bpf trace for that.

/P



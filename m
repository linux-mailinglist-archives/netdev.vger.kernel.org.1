Return-Path: <netdev+bounces-152414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 635F99F3DDD
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 23:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A33188425E
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 22:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D2D1D63DB;
	Mon, 16 Dec 2024 22:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="nAG8hTcx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3591D88C4
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 22:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734389961; cv=none; b=N6L6mFvJxp/kv4E+WMbcdHbehULw+AaDBwY+WT75EaEF+hAnJ0wEfi78jDXP2bd/+c+0pBPNRzGRzkG4CZp0/JtSMHcMyshq1WMOVbR2F1RHzRx3PIT7b1zxTE4gdExljKGoF77nBu7lTmbGbLxu/4WrddkdUBn4i+Azj1y0dlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734389961; c=relaxed/simple;
	bh=BLFGzWUEtwBM81L1wTYEPAM1pC9SJpiKc0YgR6vVKT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMnsiXG0lmMNcstgpRtAmP0Z3GGHJF8020dYOV3R8PjhiVx4IvXOWI04jm5adl2bSccaqbQ3zXeGniBh4BvXTn6pYw1rgFmFwRCUkJooD+VGfOpk5NgFabGFIQXS5WVmzedwjV6+1bqxfqT7v6zMFhj03eZ8B1ahIj8JFEh6gQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=nAG8hTcx; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2161eb95317so42868995ad.1
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 14:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1734389959; x=1734994759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eSXq7JUWbRtqC0QJ9h8QKHh2a0AJbFQ6PL5LoK1ao0g=;
        b=nAG8hTcxEUo3ut0+67tEcHkVNjXFc2afzsh8AI7MbSJfBuvK+9keA7KDFbRnnaydDt
         OonqDFKY2tFlkzravvHFx+K+FexMT6Ik/BsM09LWLIaJrFaDPRN68LdIs3vtJ7D5iXOl
         KkZj8ynY2Uu8pUy0smR6JlgZcUiXJ++uZSb6aDAMFbJI0PbeUy7KNbAmmzuwNpCgqFrT
         Nygd5jv0zTb0y4HdNQ4TpxK86oZ3ChcQWiUazyE1LE4aSznQK7ufgNG0JejEwR3QOiJR
         IitxtaalvNfKmlnuLhUtO2UsIQtmVbqYkQBk76AMdxDLuJL09qyvb2999E2tlJlQKYhv
         EF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734389959; x=1734994759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eSXq7JUWbRtqC0QJ9h8QKHh2a0AJbFQ6PL5LoK1ao0g=;
        b=vvvlXDJinx4kgazUZUD4oznRPxco/sz5hX2FCVF7GCb2mdppbMd/8NxCM3ZvasY5g7
         Qnuz2wCvKRVN7Lpb5/PN98aUatfxWGW6dWzd9SYdfOpE06rlnRTOGI4zpeT6UBUQ0anW
         rnOKU4F+xntYXS2e5zcB1+4mV49IpK/ZxZ8J5Ap7y1KpTuz7fRW6IDsmDuu2yIy8X/I5
         bluVTcKcoAjHHg/RMLr9Z7gXrM5eAx3inZ77O7onGSN/mlRR/6dfddpMuK145VcINVDm
         HcMzPlW9X8tIxRZuJb8KGcB5NZEjWA2OtSyVmqrQUSujVbULt7fIHXL+e+BXkc1M3z9+
         t8PA==
X-Forwarded-Encrypted: i=1; AJvYcCX19S+ocpQOrpS29ZRzsHf2edVASFbemO/SZ7b5x+5lB83mDh6np6dO4nRNDHP7s0HnGuAYaPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXChRKl9ToE02x9F7xfaTbtuDHnG1pt0sUY/veazLC1QzZZfVn
	0Rx1zNVEqlBVNM5wxwGfZtNr826ff8GcJoN8bgiO31XX2kktCzqSF1ZkA7VNQVk=
X-Gm-Gg: ASbGncsuDJSgmAm97yzmEkPEIfioWIOzlhRjnRTLoYKZHcyK9IU+VNjmueX/9uPTxOp
	eFMJuBA4cC82F1ZXPFXMkuLwj8cCLyLjLT4zc3v1YHP9Ka5uMCVJY4gpRUprVOXpZHvE5PKIHUm
	gfBduasV/JYmdmEVko3A/M4JrTiLUe/jkWqnjJukGXY3wJSmG0sJ/pZcE6uICrcuw50KtaQKR5X
	2FNL3TF1t5mwvXkxmJ33KFbm3HGfNW6FlltKc0HLG/LQDqTnlFGpidnNKGrr4xXhgmIq4NvD6r2
	pSkNYwmLpT4FiedS7Q==
X-Google-Smtp-Source: AGHT+IEb8kMeJaR2WPFjP1p5y/AUsQ5gOhnnF3wVKbFPOPEkb7sgIIRjfAtRwJ8qA5oP7hpJ4LmfTQ==
X-Received: by 2002:a17:903:228c:b0:215:431f:268a with SMTP id d9443c01a7336-218929f0eb3mr236190015ad.31.1734389959038;
        Mon, 16 Dec 2024 14:59:19 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1256:1:80c:c984:f4f1:951f? ([2620:10d:c090:500::5:e499])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e510a9sm47799455ad.167.2024.12.16.14.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 14:59:18 -0800 (PST)
Message-ID: <5336d624-8d8b-40a6-b732-b020e4a119a2@davidwei.uk>
Date: Mon, 16 Dec 2024 14:59:16 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/3] bnxt_en: handle tpa_info in queue API
 implementation
Content-Language: en-GB
To: Michael Chan <michael.chan@broadcom.com>
Cc: Somnath Kotur <somnath.kotur@broadcom.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, netdev@vger.kernel.org,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20241204041022.56512-1-dw@davidwei.uk>
 <20241204041022.56512-4-dw@davidwei.uk>
 <9ca8506d-c42d-40a0-9532-7a95c06fed39@huawei.com>
 <0bc60b9d-fbf7-4421-ab6a-5854355d68f4@davidwei.uk>
 <a1d5ffda-1e6c-4730-8b36-6ba644bb0118@huawei.com>
 <fedc8606-b3bc-4fb1-8803-a004cb24216e@davidwei.uk>
 <CACKFLik1-rQB2QHY1pZ3eF0GYGUCgXFHvhh50DNboXV+A7MCuA@mail.gmail.com>
 <2d7f6fe0-9205-4eaf-bc43-dc36b14925a4@davidwei.uk>
 <CACKFLim-QG2j6rG6h+_Abwd-tzfQ7_nOunWkeAn==1JoqpT4dg@mail.gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CACKFLim-QG2j6rG6h+_Abwd-tzfQ7_nOunWkeAn==1JoqpT4dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-12-16 14:48, Michael Chan wrote:
> On Mon, Dec 16, 2024 at 1:41 PM David Wei <dw@davidwei.uk> wrote:
>>
>> On 2024-12-11 09:11, Michael Chan wrote:
>>> Yeah, I think it makes sense to add napi_disable().  Thanks.
>>
>> Michael, Som. I can't add napi_disable()/enable() because the NAPI
>> instance is shared between the Rx and Tx queues. If I disable a NAPI
>> instance, then it affects the corresponding Tx queue because it is not
>> quiesced. Only the Rx queue is quiesced indirectly by preventhing the HW
>> from receiving packets via the call to bnxt_hwrm_vnic_update().
>>
>> The other implementation of queue API (gve) will quiesce all queues for
>> an individual queue stop/start operation. To call
>> napi_disable()/enable() I believe we will need the same thing for bnxt.
> 
> Som is working on a set of driver patches to make
> queue_stop/queue_start work for the AMD PCIe TPH feature.  He will
> have to disable and re-enable the TX queue for TPH to work.  I think
> we can just include the napi_disable()/napi_enable() in Som's patches
> then.  Thanks.

Sounds good, thanks Michael.


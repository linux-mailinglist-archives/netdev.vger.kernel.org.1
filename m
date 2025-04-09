Return-Path: <netdev+bounces-180879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F9AA82CAA
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 18:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B91D189EA93
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECE621129A;
	Wed,  9 Apr 2025 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqrdkMRY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55381D5ADE;
	Wed,  9 Apr 2025 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744216778; cv=none; b=Wx0Mwv2fZxGvsp4e2RMFcDnYqyspP+L18n+R12hlv8q5IbNB0zuvIFjwofbny6bFou5vRf9V8DBXsg/Y4ztU2kdDgaV4cpa5xRV08Sf6ufBb4XeFSGkOpi1fGRyrBqDFny6lWbMY8xAI1/2pSTjaXz1d+SB7X+rvm1E/mV5jIPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744216778; c=relaxed/simple;
	bh=kOUCicDyZl5AL0JiwG4ALBhI0LuOOJDSt4uDigTBS9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMmdMfuWq0rXq+jpdy3GZtl35SxtjO9tLTJRNi3qf6NMUQSq6NVy8sjAMQjPiy79pqEwI+KNZ6SmKi6svhvPIOqU0NuMET5bQYqmWIQwyxGEI2OpGZsekqPi1i01s8mGsAXti2m830X5esBqJH60Hbtk5rU3i+RlR4vNWAX8UQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqrdkMRY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22403cbb47fso75969145ad.0;
        Wed, 09 Apr 2025 09:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744216776; x=1744821576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ttC/I+3QHsduFlKy1xOPz4Sh1BJmd/Ch1pNiMDet9ys=;
        b=hqrdkMRY1nG9YK3vx3oMD0AgDriGAUZAx6G3Jv1mTiqMbs4RcfY2Wr9g+j3GHpBsCt
         FbkcaQGvfNdXva7c27f9Qw8OCIimtOHg1wYYDQEY7ImHQw53GTqvvylkewVR/dM7fbJP
         m1ofP25XuBAm2/I2SfKPpeB2bUtlX4UsFnemSVY8eIwAOS7KIeQMt2A6/PfvvYkDfb0N
         rFomwQPRzioJ4vWEoPEF/wHwrYmwws+vG7MEesCfa1T+H5x+DmaaYKWKbgtmCijHIOud
         TnRgbJh813+4fVvlMgHA6VbTo4sUePmlkiP9LaMx76l57BIQ9DLNjy5I/YATpO6Ser/r
         4uBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744216776; x=1744821576;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ttC/I+3QHsduFlKy1xOPz4Sh1BJmd/Ch1pNiMDet9ys=;
        b=lCOUwigv28dEqcUnk3xWu6fctsJejnUIJdKOO5Y6HaxUMxb+WiNZgqGnDITzp48cTI
         pVoHbFxvGQHvQk1Lny5gYDQOJMdSMvq2wIaOp2RFpyGl3dhwXyho17ftbcIXclJU0iaH
         eLCjxwOSNdWkTDfn/qmfZ2Aj2ITsV9bSSJ2wovqfxszC7ya3jB7j07RtWt2D/91c9ISn
         aWyYCGc0F/ACwDTV7nDeF1VuS1K1AHE+r5eslUXMLCmS7RyHs1IXCRu2lcdCELSa7y1v
         nDI11exbWaNLjN6rJ9qqDo2nkSyHqNBSN8hXXvvnj7Db0nEKX/r9gnnHPpyjJkXcXoLy
         UXWg==
X-Forwarded-Encrypted: i=1; AJvYcCUAl6D5AOpX5cNE9Yw7CR3Y5+Sr3WU0haf09ZXqVSIcsjvjw7hQMhluwyOa1xFcsdJlHW7JKxkCAvzj8Y4=@vger.kernel.org, AJvYcCWQKvX1wevaSqoPz7trZcLJZ53p9oG+47+hut0k1pSC5Knf1gCkdAxIgNQ8dvdSR7rNwaXe7k2G@vger.kernel.org
X-Gm-Message-State: AOJu0YxRjtR10xn2cz79j06+GskPm6t2xLZLd7RwUERfB03r6DuGngb9
	3ABA5GUsh3ZV5nsAKRGzwElO+HlQ70DntqfvG2Rhv4g9DK4hoAo6jucrOoQBRevL
X-Gm-Gg: ASbGnct1O+//TpNNpeBysrqj9+aw2PEL0qWI1lp3id+Nxw3eQH3E3w9BAaiBbw6Np0X
	X6VBRX8uuCNUQQBdEGK0hN2z1UxiPYe1LFbZkj8nvMV7PWigtXIFtkCNHQoXT3xrH2XLdMnJLFe
	NW9D54xaJmE+l1uKHieTPHxdbYcnGHf2/5t7koTvpYrKdO/UjDNz4UJViDg0iihAmCxUHwqbK2s
	eGCQqHlRTeEJ22FQGfkz4s+X8ayvzanzZPvNyjQ4SHMzqDAg/umikYJ6gPlWykMPxViABXIK0gk
	mnrjyZuasEn/dJYCtKaL5M/AdfMmGPy/POTJtDG0cNvOqp9TpuEQPXOXYfOLxG3zci9jhaByk56
	YwBFf8YjexE74u/j+
X-Google-Smtp-Source: AGHT+IGhwOw6L+wPLKDE64AnLOsT4eQ9RSJDMx3d3wrEFprBbB96BqNUTRiHqyKavoD2yo1wMYZ2Ew==
X-Received: by 2002:a17:903:3bc6:b0:224:10a2:cad9 with SMTP id d9443c01a7336-22ac2a2991bmr64669645ad.41.1744216775829;
        Wed, 09 Apr 2025 09:39:35 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:115c:1:ad19:9fe2:82f9:d0b3? ([2620:10d:c090:500::5:d128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e38197sm1597385b3a.106.2025.04.09.09.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 09:39:35 -0700 (PDT)
Message-ID: <946af1cb-96e0-401d-a989-f49af7e2f4fb@gmail.com>
Date: Wed, 9 Apr 2025 09:39:33 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] GCPS Spec Compliance Patch Set
To: Paul Fertser <fercerpav@gmail.com>
Cc: Sam Mendoza-Jonas <sam@mendozajonas.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, npeacock@meta.com,
 akozlov@meta.com
References: <cover.1744048182.git.kalavakunta.hari.prasad@gmail.com>
 <ee5feee4-e74a-4dc6-ad8e-42cf9c81cb3c@mendozajonas.com>
 <b1abcf84-e187-468f-a05e-e634e825210c@gmail.com>
 <Z/VqQVGI6oP5oEzB@home.paul.comp>
 <1d570fb8-1da0-4aa6-99f5-052adf559091@gmail.com>
 <Z/V2pCKe8N6Uxa0O@home.paul.comp>
 <b1d373d7-77e5-4341-a685-07a617935db5@gmail.com>
 <Z/WkmPcCJ0e2go97@home.paul.comp>
 <93ac7481-43c0-4207-8965-2d793c90263c@gmail.com>
 <Z/Y5HxdJfZss/GiF@home.paul.comp>
Content-Language: en-US
From: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
In-Reply-To: <Z/Y5HxdJfZss/GiF@home.paul.comp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/2025 2:08 AM, Paul Fertser wrote:
> On Tue, Apr 08, 2025 at 04:23:43PM -0700, Hari Kalavakunta wrote:
>> On 4/8/2025 3:35 PM, Paul Fertser wrote:
>>> Thank you for doing the right thing! Looking forward to your updated
>>> patch (please do not forget to consider __be64 for the fields).
>>
>> I had not previously considered using __be64 for the struct
>> ncsi_rsp_gcps_pkt, as it is an interface structure. I would like to seek
>> your input on whether it is a good idea to use __be64 for interface
>> messages. In my experience, I haven't come across implementations that
>> utilize __be64. I am unsure about the portability of this approach,
>> particularly with regards to the Management Controller (MC).
> 
> I do not see why not[0][1]. What makes MC special, do you imply it
> doesn't have be64_to_cpu() (be64_to_cpup() for unaligned data) or
> what? If the values you get from hardware are indeed 64-bit BE clearly
> open-coding conversions from them is suboptimal.
> 
> [0] https://elixir.bootlin.com/linux/v6.13.7/A/ident/__be64
> [1] https://elixir.bootlin.com/linux/v6.13.7/source/drivers/net/ethernet/chelsio/cxgb4/t4_hw.h#L155
Thank you for providing the references. I will proceed with running a 
test on real hardware with be64_to_cpu() to verify that stat mediation 
works correctly all the way into the local driver structure. If 
everything looks correct, I will submit a revised patch.


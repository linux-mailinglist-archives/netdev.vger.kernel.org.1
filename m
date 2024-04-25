Return-Path: <netdev+bounces-91495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2D88B2DB8
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 01:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE92D1C21D03
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 23:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B02156F26;
	Thu, 25 Apr 2024 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="NWiFplzW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC4116EBEF
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714088409; cv=none; b=NkDoFvaxw2sc/utnGjbVGwfNjaFwpkZVNCH+ACmDG1HW/uEUjsz02lZ1F2m84X5AQTdX06rQQk8a3+9Bi+y11Yp8MDHlOIKi33CuIwJhA/WdNqnF/qytyHtf2cupc10jmczmKQFSphv72HLyWVFOu5GUDAVSG+zI80a1W3/eHK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714088409; c=relaxed/simple;
	bh=sqd+Pzkjq1by0yoGMGWkOlaOk2YG342Ax1yqdYHidcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FoAdHL2cHekJKuVvCYow4ahZ2KdwqRUuxtyHoAAxknVHdNv9gUM2Wk/yKGhjsOUtZPHCly1gMNV2DF39utiaSP2A1fOaBCN43r5ehHe8grckXwAFJkyPenf2K7BXCbCDONkxctGpZRsa87FofSMjqGSglxyj92QXspaoKy+bx2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=NWiFplzW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e8b03fa5e5so14062865ad.1
        for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 16:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714088407; x=1714693207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CNZNDCFaG4zLgZwNOp9mamznNRvdj0DfGLjcRWznK78=;
        b=NWiFplzW/EzQ9qOLuTIPxSFK73CZh6mr4V3K6FyBQIhGnuM3p6n+ljr9XSZCUbHAiP
         42DVzqf4sr6mGOdgQbn2eiJx/+pMlyybU0GIpjZkkJ3tgQ72hyZBfd8NZUAVuruhgJ2D
         Vs0r6HFAfRr/WV2AP8P0J6jl5515grTCLNlfqL4Y6iw3HjoXKR8JnRjn2R7+a/Eq2pDq
         6q8lsCbRGF7PV9s4bTbfg9uFLGcqyOtnQTAdRWq4poSZWQTeE4znyJj6Ph3WY4/CBZbE
         CSkeqfaOVL4j54cQPmdqK1jsqyrSZHk815OYKF8t3VK1IwOL8SiS8C4dDJ0Ix4HxzRJ4
         ASxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714088407; x=1714693207;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNZNDCFaG4zLgZwNOp9mamznNRvdj0DfGLjcRWznK78=;
        b=jKgE/pyLGNvnWKs8he/hcKLHswjeqaclc4inhcEVoKGExmUkzGknY7BsbltxIQ5VOi
         tGwGiKKvVn3DuydoFqsj6caVPs4VOP01fIxoCQKwDhgN/Aq7fwNViadszDVJ4WH8jcMs
         vZj1faG0hkmtUpMzHWRyc3NM2icNWX+od82gg0V8rmjzq5e+3ItcHnnrGmH7ov0MXeIO
         vExoOs6eF0iX1sywk9++vxyUB5AAT2Hhnc7iJrxK/lRNDya9o/ILVsMoSxmxnHHx0uYq
         LGt+YkuZN7YpoyzS720k3GWxjd3cdpqolVjUamC5dXX3QfWuo88BTWzqfOvNG04TBF9Q
         wrMQ==
X-Gm-Message-State: AOJu0YxQzjT6Y6HnCwf5vO3LP12SV0usKpIDbtmaWEJRPPwOPZPB1/FN
	P3WUZtNKq1/Fln9SuiZdBt2yfZ9Wt98b7DNHBf2Wkp6/mRpzhJg/xHgbtsMbbvU=
X-Google-Smtp-Source: AGHT+IFJWdpTKZCbwdg3s/6Q7j9U78KPSVH7gObfmppKsFrg7ppHuG8s6i0EgkluwGKJARl1vHTYvg==
X-Received: by 2002:a17:903:234e:b0:1e7:d482:9d96 with SMTP id c14-20020a170903234e00b001e7d4829d96mr1579558plh.10.1714088407266;
        Thu, 25 Apr 2024 16:40:07 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1256:2:c51:2090:e106:83fa? ([2620:10d:c090:500::6:8d4c])
        by smtp.gmail.com with ESMTPSA id mq8-20020a170902fd4800b001e23fcdebe9sm14375172plb.98.2024.04.25.16.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 16:40:06 -0700 (PDT)
Message-ID: <eb39f73b-d1a5-4bca-b1b9-c4f6715b6a10@davidwei.uk>
Date: Thu, 25 Apr 2024 16:40:05 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] bnxt: fix bnxt_get_avail_msix() returning
 negative values
Content-Language: en-GB
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240425212624.2703397-1-dw@davidwei.uk>
 <CACKFLingTDiXZOymZya33Zo_vJJZKtXOLefBPiow0Og5pL3sZw@mail.gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CACKFLingTDiXZOymZya33Zo_vJJZKtXOLefBPiow0Og5pL3sZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-04-25 3:25 pm, Michael Chan wrote:
> On Thu, Apr 25, 2024 at 2:26 PM David Wei <dw@davidwei.uk> wrote:
>>
>> Current net-next/main does not boot for older chipsets e.g. Stratus.
>>
>> Sample dmesg:
>> [   11.368315] bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized): Able to reserve only 0 out of 9 requested RX rings
>> [   11.390181] bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized): Unable to reserve tx rings
>> [   11.438780] bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized): 2nd rings reservation failed.
>> [   11.487559] bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized): Not enough rings available.
>> [   11.506012] bnxt_en 0000:02:00.0: probe with driver bnxt_en failed with error -12
>>
>> This is caused by bnxt_get_avail_msix() returning a negative value for
>> these chipsets not using the new resource manager i.e. !BNXT_NEW_RM.
>> This in turn causes hwr.cp in __bnxt_reserve_rings() to be set to 0.
>>
>> In the current call stack, __bnxt_reserve_rings() is called from
>> bnxt_set_dflt_rings() before bnxt_init_int_mode(). Therefore,
>> bp->total_irqs is always 0 and for !BNXT_NEW_RM bnxt_get_avail_msix()
>> always returns a negative number.
> 
> Thanks for the patch.  I'm still trying to understand the flow on this
> older NIC.
> 
> If BNXT_NEW_RM() is not true, shouldn't bnxt_need_reserve_ring()
> return false from the top of __bnxt_reserve_rings()?
> 
> Ah perhaps this NIC is using hwrm_spec_code >= 0x10601 and
> !BNXT_NEW_RM().  In that case bnxt_need_reserve_rings() will return
> true because we have to reserve only the TX rings.  Let me review this
> code path some more.  Thanks again.

Yes, hwrm_spec_code >= 0x10601 and the first conditional in
bnxt_need_reserve_rings() returns true.


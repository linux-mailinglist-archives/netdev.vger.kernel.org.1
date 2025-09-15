Return-Path: <netdev+bounces-222937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8747B571AB
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 09:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A44B3A570A
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 07:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21262D595A;
	Mon, 15 Sep 2025 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4TfD9VM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1392C0F79
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757921924; cv=none; b=ScQJn4QZ48K9UJPDCRyhg2nsCp9A14tXMh3f3PgTSnkuTNBJmce2TrlCX0CBhQ0kd2H1LnO0UIqUkY8BDGrG6CGGbg8ZzTtqriEeImZL7eEmssswLzyX2dIpW/+bWFm6d4LObnVDSAHK6iVfd0zv+rn1XymeQEHLxu8vnq0oiA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757921924; c=relaxed/simple;
	bh=kGHwg3luaanPBk/Byu/i1GQ/JK31vdNJbOeeSmaUbuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkKkPorJ0SHfTp5liEC9iJ1LiZVjbcQ25hnB7MN1GT99QjfqW1ODmis1seVACzXFookVOKe6XLvy5mlb43P8R6klqAV8p4qc5K+fwF/0/cagH4hSV3BsOrhOjVrn8XmQ1t6zCjNzQEaPQ0aUEZXGc7TgZCNbqYadscJYPHFKGjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4TfD9VM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45df7dc1b98so25845025e9.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 00:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757921921; x=1758526721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JanCUlFRjj5laV++kf8eFiKJiHLqqlH/hnFp+08fd18=;
        b=R4TfD9VMicu4a+dndbYW2Pupiy7oleCgttsD4I3EJ8FNX0Dk4WSl+mGHE4ABpzi14+
         2n7Cn+gdHLbe+EU5lHVgpccdC0M8BKIG8N4AJHQZh8lsZyC3TyA7Iu5Is3hz5gydaO7h
         EohqoQCSpPgI2JCwBnEUuYgjVDbk90PtV/YkY3sxNpFGpMBzLW4k04ikRlwG3RmTv3Xf
         cTq+BfPJH4okDNrqVE5Ay6eYO0hWzA2emOK1sGjSIX7hDfeKa95Fm4T2Rwxcp2NwjYwv
         fWfqMzpYFKVRwiMFzJ6sTIcmsrVmMehe54l+hX1oN7bf4pl4DuaKY+rMXA5ibUm5r6AL
         xylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757921921; x=1758526721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JanCUlFRjj5laV++kf8eFiKJiHLqqlH/hnFp+08fd18=;
        b=YIeFKNqHs+yR5xCNiS/Gsx3sF3rKWF8MWdzQ+o/LLDBv/KMiTt/IsBJNZzkN3aLuD2
         u/wNQHgYiwLOdIl3W7bTPwY+DoNvLGDZgQSncksYjCtXQtMW4/8phht/ozqz9JC2L4vw
         m/AA4N0w5mjcJmeInRtjnv7KJ4pfETSQKDE1IfXTT43/LgU0h8w7aPfynbEHR2Lz61HE
         dIvURqg0w8c7UWtCJauEqHnUOJJDnHNFvHdSMvyXAwuhYBRCgL76O97Sq7FWx8RLPdOf
         Ize2SdndDbVprLW03Y6RYVFV5T0JTJZDVnYanaGj9QfGsF8dgTn4mhf5vCRQQj7DXGtF
         4e/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5oQ9cExA9WCaPBg1Ufn/aYa7wv5lZwZT2vuAHuzq/NMV+ZGy1dUw/xMxgt0wjVzHxzYFsI6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsk3+sBOtUQVhpGJZni5ypVWK9S7wIF5giKA54GRdk6mI5Vct1
	XE775N4ChJ8UBhIp6Xvc7BhvZfmMDOJH58rDzt4BJYUPMPuhVQHrOKoJ
X-Gm-Gg: ASbGnctxBpc+MkLrmK6R5B2gaRMy/EJjCKH0hdk1AOyH4pgESR/vA7LCP00PqBPyQdv
	Z8JRXqjPq102pMcVAJxnPbKxVjluSNSac1UH/CsaKKboEea9IB7Y4mpZPf7cy1qHuzN+xGAugnb
	pRkwFGHm/EhygFEJziFM+bB96EU+b3bfww95rSvMaRiQ7KzCu9qAbcl5OV6QUorzM6lRajwbOvz
	Hw4WIM/OKiXFOgtx+2+9BXIvyGrUxZ6ZgV3XICgcjc3VoxOKc4qP/Br4xvBzMmH+dGfQ2DQYceT
	hLrXJFjljjl6YN3TxeAO13iMAD6LYqRAGaltBmp+qrd/AC/j4Nv1PNu8cDFhomtJT3SQDmaj6rZ
	RBFoKFEr1eTYOc2DViU2e0S+BYowoxjZx/NBqm1NC6yldQJ8NdaxtWQ==
X-Google-Smtp-Source: AGHT+IGgiNZFCx3A7Cjv6G6Nbr0a0VbqLvidbmj1KLlT+PabE1SdR3T2bnemHbr80ONhrSj9iyyLsg==
X-Received: by 2002:a05:600c:3515:b0:45f:28ed:6e1e with SMTP id 5b1f17b1804b1-45f28ed71c9mr64761095e9.16.1757921920946;
        Mon, 15 Sep 2025 00:38:40 -0700 (PDT)
Received: from [10.80.3.86] ([72.25.96.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0157619fsm169321285e9.7.2025.09.15.00.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 00:38:40 -0700 (PDT)
Message-ID: <af70c86b-2345-4403-9078-be5c8ef0886f@gmail.com>
Date: Mon, 15 Sep 2025 10:38:39 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 10/11] net/mlx5e: Update and set Xon/Xoff upon port
 speed set
To: Jakub Kicinski <kuba@kernel.org>, Mark Bloch <mbloch@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, linux-rdma@vger.kernel.org,
 Alexei Lazar <alazar@nvidia.com>
References: <20250825143435.598584-1-mbloch@nvidia.com>
 <20250825143435.598584-11-mbloch@nvidia.com>
 <20250910170011.70528106@kernel.org> <20250911064732.2234b9fb@kernel.org>
 <fdd4a537-8fa3-42ae-bfab-80c0dc32a7c2@nvidia.com>
 <20250911073630.14cd6764@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250911073630.14cd6764@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/09/2025 17:36, Jakub Kicinski wrote:
> On Thu, 11 Sep 2025 17:25:22 +0300 Mark Bloch wrote:
>> On 11/09/2025 16:47, Jakub Kicinski wrote:
>>> On Wed, 10 Sep 2025 17:00:11 -0700 Jakub Kicinski wrote:
>>>> Hi, this is breaking dual host CX7 w/ 28.45.1300 (but I think most
>>>> older FW versions, too). Looks like the host is not receiving any
>>>> mcast (ping within a subnet doesn't work because the host receives
>>>> no ndisc), and most traffic slows down to a trickle.
>>>> Lost of rx_prio0_buf_discard increments.
>>>>
>>>> Please TAL ASAP, this change went to LTS last week.
>>>
>>> Any news on this? I heard that it also breaks DCB/QoS configuration
>>> on 6.12.45 LTS.
>>
>> We are looking into this, once we have anything I'll update.
>> Just to make sure, reverting this is one commit solves the
>> issue you are seeing?
> 
> It did for me, but Daniel (who is working on the PSP series)
> mentioned that he had reverted all three to get net-next working:
> 
>    net/mlx5e: Set local Xoff after FW update
>    net/mlx5e: Update and set Xon/Xoff upon port speed set
>    net/mlx5e: Update and set Xon/Xoff upon MTU set
> 

Hi Jakub,

Thanks for reporting.
We're investigating and will update soon.

Regards,
Tariq



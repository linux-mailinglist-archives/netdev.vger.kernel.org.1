Return-Path: <netdev+bounces-235004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD90C2B1F4
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 11:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD993B1179
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 10:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BD3189F43;
	Mon,  3 Nov 2025 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJ6A2GaW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D432FF655
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 10:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166733; cv=none; b=Yvj8fnd+bkUqQO8e1YRfov4a85ZskTX/cfT2U+berz/zT9FuVhQ5366SiUDZKl7RQtQte9osfIPsgfdnxtT0e/+4g0+JzQwR7XZrISG24l3fllZoc7kZBx0SqFG9HzBckSQZnLS5R8afOpJ2AE1pMfd0rUNWYbQEgHV1ClIkzek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166733; c=relaxed/simple;
	bh=Hb+NtnyVthXxiqpa2NXyk20g72MBqja13I4aQNTrhOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZtH5I03qxbX4bn0REeuG5K6dCEE7C1CG71Ho/iBGIpSW9UKTZ1hcohjaG4sMENLCZE0dXGHyaImHkRgcIzSsUghMOncOU7ukg15ajTG2CfTYsia/77nq6oM+miTHAKeG+IsMZ/xJbHB6ZN3xAfDBT4EJqGjgNF8hWQjkCU8FV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJ6A2GaW; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429bccca1e8so1767616f8f.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 02:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762166730; x=1762771530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yI5CH4I0hfWueguyreAy8ApRHgpp9LZt+Rs6JeCDEcQ=;
        b=WJ6A2GaWyBU39iEkcNBksRk/4LFnpwiJPpwYehpeL04IWl2BHUqMJagfcjaj6vGFGU
         2iqlnAuqACnvlh5dxG7ol4REp5mQf2Rhuksgm1je/IsmUgVftV9hl1g5DqXdZ34E82ue
         UZyhNlyCdvuwa9+vH8xpHvBNc/BsdLHpKr8f3q/jyh6KfxrMNAc8fVy+t4A2OEwH75yh
         1bJqJYAO/G9tPGCmz5Cw9y8i6Pj+TpwLNYLlQqurXanWibLo9piWKEmQExnHOrYjct+r
         JyyaCBcnhlj7IGH01qqdEmKTUV4YGv5l5qnL+Tpo/+OWiJIMCrTlveoQihTsk9wuoRJt
         8Svg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762166730; x=1762771530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yI5CH4I0hfWueguyreAy8ApRHgpp9LZt+Rs6JeCDEcQ=;
        b=iU/qunfY6dzwkoLOhWCaQ8W6mFWIFzONMYeq+aeEVycUTHPr//5y5TviXFxPs2GrE5
         SGfAC6QyL1ABEcVqgaZnZsBc1XaEVE42fC5avkWAhpMSGRmmeaddUbLEpRDKZlp16ZI3
         4gO4YL9JDNYXvFJAlQ3DjX1J9OaWZk+60jwEpynZJSRxUqJO+fbs8dZc0z0VdfjpJK3u
         ojZ77VoUt47+J9+VFmz1CVDsNcFbgRwukLVx8AEgVjGclnHo7TTmLcm4kydhE2eRlMx3
         xymvMLh5+EW6eq6vgA7tgCe8/Cja1OMQMwUePahoLoKWjcHsa4lhkB/D5tu89kA44Fv5
         fzNQ==
X-Gm-Message-State: AOJu0YxYq31i4DGYG4eMiOXEnEFoigxgladrPjIaAAFn7BpFvhFdspdq
	FFVeVM2dQTw6Qu7AUO71SGjiPk5hHTZkIEmqYD9YFoQwyU1mGvdETOr6
X-Gm-Gg: ASbGncs7kzRzEuuYVFzoETguBpYZk9QbVuxVIDP2urs3JLWbEmhxL/9wGZvjc0xnpni
	B0C0TUhnGMtoI/Sd+065RvcmCOY5zmp9V5/amS+3IMMzkcgk8O2JKQYe4iNhjKnFTVlnYa9HTuO
	hi3qzPwtGaLpUa0VXuBFhCi0l5Fpr9eXXUPmsFFlgaB0sf4T7BHpVesHzE/Eq0IEVDXU6FwwV0K
	PzsmiWJlXKYvWYGCctLFo+KsXrLEV7ONL9qPhVKYaL0z717mTR9dY5fQ1wGHj1OZngJLfWfgjTq
	J3T8SKUxjxlRPQULyxB/jjR9kCdtGfEpisjYx8a6qsnaBo/XGk4sTzuIbK6rXv6q6iDN4ArohmB
	iNTAKMK5H89mys1t6AQcL1tt6oOb1TLzmJWkMcGQ8yq0Hj/vYfitf8oPadqCBnvpvWkT4JaHja6
	bqf5zveS14hnnp8meSF+zp9ZNEQNRzG4pgw7LMeeh552CK9bKlsYQOKsXQeW+z3xkG8UEtaX2EB
	bPjELw=
X-Google-Smtp-Source: AGHT+IHQNl5yaNEEnfDLkXoBAKr9B1YWaZcLDi6jUmiEXakR3IVbR9vWtrJEjXCFGaahZzJZWBO78Q==
X-Received: by 2002:a5d:5f52:0:b0:427:6a3:e72f with SMTP id ffacd0b85a97d-429bd69d80amr9409587f8f.34.1762166729820;
        Mon, 03 Nov 2025 02:45:29 -0800 (PST)
Received: from ?IPV6:2001:16a2:df90:d000:47a:1239:3dd1:d299? ([2001:16a2:df90:d000:47a:1239:3dd1:d299])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c9416f82sm13915853f8f.6.2025.11.03.02.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 02:45:28 -0800 (PST)
Message-ID: <0c2cc197-f540-4842-a807-3f11d2ae632a@gmail.com>
Date: Mon, 3 Nov 2025 13:45:26 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mlx5: CX7: fw_tracer: crash at mlx5_tracer_print_trace()
To: Moshe Shemesh <moshe@nvidia.com>, Breno Leitao <leitao@debian.org>,
 saeedm@nvidia.com, itayavr@nvidia.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dcostantino@meta.com, kuba@kernel.org
References: <hanz6rzrb2bqbplryjrakvkbmv4y5jlmtthnvi3thg5slqvelp@t3s3erottr6s>
 <e9abc694-27f2-4064-873c-76859573a921@nvidia.com>
Content-Language: en-GB
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <e9abc694-27f2-4064-873c-76859573a921@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 15/10/2025 12:13, Moshe Shemesh wrote:
> 
> 
> On 10/9/2025 3:42 PM, Breno Leitao wrote:
>> Hello,
>>
>> I am seeing a crash in some production host in function
>> mlx5_tracer_print_trace() that sprintf a string (%s) pointing to value
>> that doesn't seem to be addressable. I am seeing this on 6.13, but,
>> looking at the upstream code, the function is the same.
>>
>> Unfortunately I am not able to reproduce this on upstream kernel easily.
>> Host is running ConnectX-7.
>>
>> Here is the quick stack of the problem:
>>
>>     Unable to handle kernel paging request at virtual address 00000000213afe58
>>
>>     #0  string_nocheck(buf=0xffff8002a11af909[vmap stack: 1315725 (kworker/u576:1) +0xf909], end=0xffff8002a11afae0[vmap stack: 1315725 (kworker/u576:1) +0xfae0], s=0x213afe59, len=0) (lib/vsprintf.c:646:12)
>>     #1  string(end=0xffff8002a11afae0[vmap stack: 1315725 (kworker/u576:1) +0xfae0], s=0x213afe58) (lib/vsprintf.c:728:9)
>>     #2  vsnprintf(buf=0xffff8002a11af8e0[vmap stack: 1315725 (kworker/u576:1) +0xf8e0], fmt=0xffff10006cd4950a, end=0xffff8002a11afae0[vmap stack: 1315725 (kworker/u576:1) +0xfae0], str=0xffff8002a11af909[vmap stack: 1315725 (kworker/u576:1) +0xf909], old_fmt=0xffff10006cd49508) (lib/vsprintf.c:2848:10)
>>     #3  snprintf (lib/vsprintf.c:2983:6)
>>
>> Looking further, I found this code:
>>
>>          snprintf(tmp, sizeof(tmp), str_frmt->string,
>>                   str_frmt->params[0],
>>                   str_frmt->params[1],
>>                   str_frmt->params[2],
>>                   str_frmt->params[3],
>>                   str_frmt->params[4],
>>                   str_frmt->params[5],
>>                   str_frmt->params[6]);
>>
>>
>> and the str_frmt has the following content:
>>
>>     *(struct tracer_string_format *)0xffff100026547260 = {
>>     .string = (char *)0xffff10006cd494df = "PCA 9655E init, failed to verify command %s, failed %d",
>>     .params = (int [7]){ 557514328, 3 },
>>     .num_of_params = (int)2,
>>     .last_param_num = (int)2,
>>     .event_id = (u8)3,
>>     .tmsn = (u32)5201,
>>     .hlist = (struct hlist_node){
>>         .next = (struct hlist_node *)0xffff0009f63ce078,
>>         .pprev = (struct hlist_node **)0xffff0004123ec8d8,
>>     },
>>     .list = (struct list_head){
>>         .next = (struct list_head *)0xdead000000000100,
>>         .prev = (struct list_head *)0xdead000000000122,
>>     },
>>     .timestamp = (u32)22,
>>     .lost = (bool)0,
>>     }
>>
>>
>> My understanding that we are printf %s with params[0], which is 557514328 (aka
>> 0x213afe58). So, sprintf is trying to access the content of 0x213afe58, which
>> is invalid, and crash.
>>
>> Is this a known issue?
>>
> 
> Not a known issue, not expected, thanks for reporting.
> We will send patch to protect from such crash.
> Please send FW version it was detected on.

Hello!

I work with Breno and just following up on his behalf while he is away. Just wanted to check
if there was an update on the patch?

Thanks
Usama
> 
> Thanks,
> Moshe.
> 
>> Thanks
>> --breno
>>
> 



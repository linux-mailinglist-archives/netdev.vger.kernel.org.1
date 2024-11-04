Return-Path: <netdev+bounces-141710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF9F9BC175
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 00:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5601C21CED
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 23:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4551DD879;
	Mon,  4 Nov 2024 23:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFo1vkE5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE23A1ABEBA;
	Mon,  4 Nov 2024 23:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730763166; cv=none; b=UW3WwEDlpMmDV1MEsEeOn3KBBbun4TbPIx1gunsPB4+RIbNxk38NMlk08Uk1GV3Tk9gNIhmySky0vsZTXjAHRYRYVb21gxK7+F1CmSCrjl8v4ewPbpxSDffnw/yDXKFtgZl4iMJcBoJWxNymvSgWW/TXaxe3o3DPzSTM/x6ccFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730763166; c=relaxed/simple;
	bh=afPelZ8VyWWH0OiQ+4/wNEh8CyXxinnqLvrJ2XbsNjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jB4XWr+Yam9E09Z0ESwHRFD4+h5xgtRV6inQGqv5oHjcdCDB2yUXcYy7D1NmaseTpHo0VBVvLiF0PRJK2J6Djn/kZHgJyWAsWI5AmSlZgvl31FpSz55dy6g4OFzl6E9G1P+uVwaoc1Tlef4YZDRownxg6S1nMWv9Iq7/ib2wDF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFo1vkE5; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5ceb75f9631so4757719a12.0;
        Mon, 04 Nov 2024 15:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730763163; x=1731367963; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9in4eV8N1cjsDiDa/ULRRnTwuLUg5ORmTZvy/FTnXI=;
        b=BFo1vkE5rdQNOPIRrzy6hB8htvt8VBBCrvwIUiGk9fzrmJL5qlUChChIZYWe+Xs6av
         Q1pfxZUPddtAVCWNOSSAVL7zu460O4YQfdY4E2MIAHHs0QeCMnHSv4U9oPP7zSZHNaFN
         vUtzHrcWt8Op5whIaUbiXYQY+H/IMltHwzCL0BqxErHiP46Y1Z2c4o595/qe0TAqIUr5
         v5tbGeRmygQ9YS45wbBolC1qexGdAx6qpOMorCeGzotR41oF0J4Xoprd+CdPvDtxyYS9
         Nw1AHp+29A+qV/bgz/SC86RHgmqD+js9y2IOxlduQfvLdisGzVWScKJcXQrI8cbw6QDl
         Fspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730763163; x=1731367963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9in4eV8N1cjsDiDa/ULRRnTwuLUg5ORmTZvy/FTnXI=;
        b=YfkrV1YyrHjrOMQTbB69PLNlRCcjiYnJXh1vEj6X79/LJMHhwJt+gDluC/HuD2ooXR
         sMv32mqxesZwCtFxPS0l/LFEQt591owArtUh0eGLowOxRTzpvCbQxJq3j+ssQuc3s9By
         1Y17QGdeyIuJqkGqCW0lecb2oJdUJ15VZ+IKXfZvHuT6EhyXtvQczDy7Pde9XNY2s173
         tpZi7Mt4Z0uW7wF5vRIeuaZxC1LCt8bPiqMvrv2BAuNTM0jMor9I1XbZMe502f1Uy5Pm
         HaF9eBKpoPH9iy6npBxjNxGoY/mo+IExv2BUoHCanMAA0snjRXQFVAH+1c1Y+z0xF0uy
         0Ncw==
X-Forwarded-Encrypted: i=1; AJvYcCV8ReWC6udTUYGqnSG/YTUU6Ocf1G3bv8A+dYlOdGn3bG5NSLuoqZ+lkvlTUi2ji80gXfj0i91o@vger.kernel.org, AJvYcCXXbxVnaqtr72FZt9QWgYPQxAq+ASPoGLzyuGLuo+kDtaQraJAsFxF/03fJ7Pptra8yPIaSxVvdU9oGzCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg4OscdH5XryKVnpgFgEW+VDSaHf3Ov/l1j/1wFkfZZzVoC6sP
	E7bKBtbz9Z5Dxbp1GURkWvpwqL4qtNPZKyGubuOPhuVWi1Yx5yNUZLFAoQJ9Xo6tKNrOFpo/OqA
	EAKPnguz9vB7pQFVfl9ORkpsqmYA=
X-Google-Smtp-Source: AGHT+IGLp85RzkJpg9pQBMxfkYCOE4MPLzw6hNSqKUAeqsqgJVrVLYWKANQHz1xBPLmA5/U8sau1iyxAeJigPjsGRR4=
X-Received: by 2002:a05:6402:268e:b0:5ce:d53e:f258 with SMTP id
 4fb4d7f45d1cf-5ced53ef5acmr4655851a12.26.1730763162841; Mon, 04 Nov 2024
 15:32:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030132352.154488-1-islituo@gmail.com> <20241104160713.GE2118587@kernel.org>
In-Reply-To: <20241104160713.GE2118587@kernel.org>
From: Tuo Li <islituo@gmail.com>
Date: Tue, 5 Nov 2024 07:32:31 +0800
Message-ID: <CADm8TemexVr3gcuhKJ9M4PLDg2bF85nhT17a8J1uf_qqj_fKiQ@mail.gmail.com>
Subject: Re: [PATCH] chcr_ktls: fix a possible null-pointer dereference in chcr_ktls_dev_add()
To: Simon Horman <horms@kernel.org>
Cc: ayush.sawal@chelsio.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	almasrymina@google.com, dtatulea@nvidia.com, jacob.e.keller@intel.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Simon,

Thanks for your reply! It is very helpful.
Any further feedback will be appreciated.

Thank you very much!

Sincerely,
Tuo Li




On 2024/11/5 0:07, Simon Horman wrote:
> On Thu, Oct 31, 2024 at 12:23:52AM +1100, Tuo Li wrote:
>> There is a possible null-pointer dereference related to the wait-completion
>> synchronization mechanism in the function chcr_ktls_dev_add().
>>
>> Consider the following execution scenario:
>>
>>   chcr_ktls_cpl_act_open_rpl()   //641
>>     u_ctx = adap->uld[CXGB4_ULD_KTLS].handle;   //686
>>     if (u_ctx) {  //687
>>     complete(&tx_info->completion);  //704
>>
>> The variable u_ctx is checked by an if statement at Line 687, which means
>> it can be NULL. Then, complete() is called at Line 704, which will wake
>> up wait_for_completion_xxx().
>>
>> Consider the wait_for_completion_timeout() in chcr_ktls_dev_add():
>>
>>   chcr_ktls_dev_add()  //412
>>     u_ctx = adap->uld[CXGB4_ULD_KTLS].handle;  //432
>>     wait_for_completion_timeout(&tx_info->completion, 30 * HZ); //551
>>     xa_erase(&u_ctx->tid_list, tx_info->tid);  //580
>>
>> The variable u_ctx is dereferenced without being rechecked at Line 580
>> after the wait_for_completion_timeout(), which can introduce a null-pointer
>> dereference. Besides, the variable u_ctx is also checked at Line 442 in
>> chcr_ktls_dev_add(), which indicates that u_ctx is likely to be NULL in
>> some execution contexts.
>>
>> To fix this possible null-pointer dereference, a NULL check is put ahead of
>> the call to xa_erase().
>>
>> This potential bug was discovered using an experimental static analysis
>> tool developed by our team. The tool deduces complete() and
>> wait_for_completion() pairs using alias analysis. It then applies data
>> flow analysis to detect null-pointer dereferences across synchronization
>> points.
>>
>> Fixes: 65e302a9bd57 ("cxgb4/ch_ktls: Clear resources when pf4 device is removed")
>> Signed-off-by: Tuo Li <islituo@gmail.com>
>
> Hi Tuo Li,
>
> I do see that the checking of u_ctx is inconsistent,
> but it is not clear to me that is because one part is too defensive
> or, OTOH, there is a bug as you suggest. And I think that we need
> more analysis to determine which case it is.
>
> Also, if it is the case that there is a bug as you suggest, after a quick
> search, I think it also exists in at least one other place in this file.
>
> ...


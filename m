Return-Path: <netdev+bounces-174294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E065A5E2ED
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 18:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48DE67A7FE8
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 17:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE621E8327;
	Wed, 12 Mar 2025 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PjNjRf+z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984191D5165
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741801455; cv=none; b=O5QWwzENUkpHhD7x2cNfWNrOUHOoMiTQlU0YqDl6/FDdwFsz7Rsfasy4x9HsSh1wCPPr3tghGDjJKe64T8DSsvp8In0st0cEOmWoqCLdjdJpA6pz3JSMtpANoS9uXZgMZqgidaAw0JUKvJa7bOAZpHQgmdOtH56teuYspPT7Sww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741801455; c=relaxed/simple;
	bh=O06yWwsLTuIDqpF0jLnSB9l1QccuJgStDsf6D4XXw58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHgc4f2oLgKhiCtBA9OvCXvVw4rFm6FWTmCXEvqLWM/NxGDXJbx7MprOEu8VUBdCvPlNmf5pH7QDw+KHuVFefAfF9wXBynzQ0m8IyQMPIWr9PmIg+nVk1NrhB8AgF7XPmcSPIhEGcvNnHhnYpXkjoIW7JPcxBwb1mbJdZMMR6TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PjNjRf+z; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5ded500589aso6665a12.0
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 10:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741801452; x=1742406252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Me1d7jsgcXR/Dothc/0XiINADL8YMQoy8O6gl8JEjM=;
        b=PjNjRf+zjg+f/bkhqfRvbDAMJt1j48N0qNPvpXbKmq4y6lvWGerteyxIIthU+WCNOl
         p8ebryJu8Ym5SCSGpa0Cj99crLHJRMUJXRv0dvDeBVcO6Iv+lvV5bgwh08R8EPNWDVPQ
         JZU8BUedHVt0g6DeWPsRdAjTq7nbGuc1EPbIIOaMLKuSEQdt1Qm1fCmZ7lbdlaSfjXp9
         8PaF0WAITC2zlCTPa/xggXqy+xhdTqXeg5+bpetLUkS1bbqpzjbgYL2KW864FDJTnSD1
         gKzMPDsf3F7lSvDAYTrRyxrBRb/ERqN4EaTvETsp7FDN6IU9qWee9SmREeWWC/tjdE/1
         oYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741801452; x=1742406252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Me1d7jsgcXR/Dothc/0XiINADL8YMQoy8O6gl8JEjM=;
        b=t4dhE2ANjL31gl60vfwVTwHu2GX+1xW0HJLTFQ3rmK+yog5/6wPU4RRQn7YyvET1ck
         OLEG8z073HiARvbj6mzziI2V2luPD8yiSYd3mu5eStPRGZcWihFQtufc74tYFd+AVbu6
         qls3A67QuTMuU8r+fWZntN8d11+759Z22tv27T3G/SrFkcDxs/vC12t8VEMfSdAACIAz
         w5wJUBi5bRPLrufw/gqebcI8NpCLQ545M8v8vOSQ54i0KJYIcpXVIzBpxC28EW9m2dAD
         pkQ2D9nObHxtkxiuc3Od89r2dU8JgQw12aMG0ur2JK/yOKohv9npXKd9dpOjWpiZh3WZ
         PH4g==
X-Forwarded-Encrypted: i=1; AJvYcCUU0FGC+Ue5g3murnB5RtIBCn8WzL+YsZ/XtMMYAc6+fKjXqFULA+41nBqmEdbEq947NE2nz5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Ecpzz5LG8L+lff+J7cjKRJVa9quH3A5+sQsY1wvGuzQBj3v0
	P1G8jWwY1G9qm9hNwZpsYOcWAl063nrhK3/a9/MaWUf5/LjIGjWVFxIFqCDo55A=
X-Gm-Gg: ASbGncttTNIUf7heEyjP/NN6krO97tJovMJp+SebxyUVOkchxkqqWeey4tONn7NZrqX
	LWo2Yp/41/gwf/6VeQpN0t0sR8XY65p6R+fUR9Pk0FJbNcCChzz27rD92icpkT5S6tm++Yb7eWV
	JbSfiAFzgt5yk4FAqY/W9VpFfAYb8tkgB4uL2KaKcA9rT+lzmrk5jSC7gWBPGFLgb56z4LlD+Zc
	raNddK13Y+i0hS6G+lTSfb/5enL3F7SHEFKyzwikRU6xBhwLxT7Bvk/w0nTHYX3Oi1tSzXiVzVZ
	DOEYUf/H3L9LNQJG3oy1p/doIEFzlfvSYWBDIEZxO4G+/u6YHO0fBIxQz9lhUtj7LtTpaXiH6ch
	SIB2yz/VUQyqXsU3FeD8=
X-Google-Smtp-Source: AGHT+IHlyFWbL5gDujKGJhqntuqOOZoA5EhDToaXEPWUGaGZy5NNDq6/XTq3A9PjlZscDdnDMKDcRw==
X-Received: by 2002:a17:907:360c:b0:ac0:b71e:44e1 with SMTP id a640c23a62f3a-ac27137e457mr851991366b.6.1741801451824;
        Wed, 12 Mar 2025 10:44:11 -0700 (PDT)
Received: from [192.168.0.185] (77-59-158-88.dclient.hispeed.ch. [77.59.158.88])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c74a8e0asm9866140a12.39.2025.03.12.10.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 10:44:11 -0700 (PDT)
Message-ID: <318ad96d-99ba-4c53-a08d-7f257dbc3d6a@suse.com>
Date: Wed, 12 Mar 2025 18:44:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] net: enable SO_REUSEPORT for AF_TIPC sockets
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: edumazet@google.com, netdev@vger.kernel.org
References: <dec1f621-a770-4c9a-89e9-e0f26ab470e2@suse.com>
 <20250312163652.83267-1-kuniyu@amazon.com>
Content-Language: fr
From: Nicolas Morey <nicolas.morey@suse.com>
In-Reply-To: <20250312163652.83267-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-03-12 17:35, Kuniyuki Iwashima wrote:
> From: Nicolas Morey <nicolas.morey@suse.com>
> Date: Wed, 12 Mar 2025 14:48:01 +0100
>> Commit 5b0af621c3f6 ("net: restrict SO_REUSEPORT to inet sockets") disabled
>> SO_REUSEPORT for all non inet sockets, including AF_TIPC sockets which broke
>> one of our customer applications.
>> Re-enable SO_REUSEPORT for AF_TIPC to restore the original behaviour.
> 
> AFAIU, AF_TIPC does not actually implement SO_REUSEPORT logic, no ?
> If so, please tell your customer not to set it on AF_TIPC sockets.
> 
> There were similar reports about AF_VSOCK and AF_UNIX, and we told
> that the userspace should not set SO_REUSEPORT for such sockets
> that do not support the option.
> 
> https://lore.kernel.org/stable/CAGxU2F57EgVGbPifRuCvrUVjx06mrOXNdLcPdqhV9bdM0VqGvg@mail.gmail.com/
> https://github.com/amazonlinux/amazon-linux-2023/issues/901
> 
> 
Isn't the sk_reuseport inherited/used by the underlying UDP socket ?

Nicolas


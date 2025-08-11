Return-Path: <netdev+bounces-212470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5CBB20C2B
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 16:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F075168A24
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 14:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80202253958;
	Mon, 11 Aug 2025 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jneuUllB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96E63B29E;
	Mon, 11 Aug 2025 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922948; cv=none; b=Eve/IGWB82D44JpgS+WNMZU3/wbFVZSafjG3QRnjZUnzox2Qxlkxa+23J67JZJDtVRI6JBQzpE/uozOAiDs8zCbtYUO7dJrYSywI8RQOqoMuzrsHeCVZGgYqfahvpN+kOQOLpFuU/Nfip4G9AeCFzrSjJyexeMz4NadmX61XoXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922948; c=relaxed/simple;
	bh=KWIbCuU8cGbMCIn9WbjTY8OYm+V2OdvpTY8E5ptxJu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J43R094Y4RaBVzoScsQ9qhgtkWXswc+QK5nJvyGPQ831/zsXTRPqS5fMp0LyREo2ElCVZs4rwEKYQlNpc1PvE1ZwILRFps4sQNMjTvJMT3yUkMZkk3AGI6oaWSM9/nu3GdWAdLodns+QaqXYrzT9dsb8t/D6MG5p8TkE5MmbIi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jneuUllB; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-459e20ec1d9so44249605e9.3;
        Mon, 11 Aug 2025 07:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754922944; x=1755527744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0nABPxGxZ2n8SglCKgOj7GxMsQlTzWa7VjN2t+XuWFQ=;
        b=jneuUllBnGFQWuQtsxgWYeYa+Wbg5WNYPEBdvTKuThBFnpKJEnOmuV0amDip6s355K
         JXZzu5YlH/PFeDyPRmNin5v9owYsavBRSeI1VPf7Gd/pF92BoIM4wiwiNXsCmUb36F9k
         TZNdYJSfft9KyplB7h7EKxp3cZRTPbgbLJxefo65hnqmVZtQhTXZDTipG+81Ovp7F+t6
         ojK3YGUWIn8OzwUsJDRQrtuidz5fU/ZZNRr4+MylHZq9Zz7sCHKEsHKNVNSEY2NXWnlb
         LJV7W4bE9RctXcl3zVNz0V5fhEtzN898l2BNtIJjkZHorBYcaFM76I3xNp+ULrVGWiyK
         agiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754922944; x=1755527744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0nABPxGxZ2n8SglCKgOj7GxMsQlTzWa7VjN2t+XuWFQ=;
        b=O7XjQYnJSU4gBldNVtDHnCiz6thWNftviPzIh11yHwHKTy2nB4QBzzKtZu76LMsrr+
         EKJV/wU7blFldfGwRm5tUWyzFwEcyGWV7HEe0YDEUVfx9Tg5Z5DnLfKFxM6bXd4Y1PQl
         xL5wVSbGWEQefJclSV8+Nh71VGxDqVEQWRJW4sFa9h5IW7p/Gv8CkaL+4ttZWbFm6NMI
         DD9DETZPhLkap4A0zVKModVqIZ6x+wK1wmOYks6znYUig4wauh+q/I3jx+5vZ+Llbo0s
         YO3KUf2XqSe7sZEjjPre3CV8qltHCk8cpcs210A5WmAd7rC4kqmIY0sWt39m5eDMy8KV
         fLMg==
X-Forwarded-Encrypted: i=1; AJvYcCWYQfJ2gtfp358s2ji4JQ/kNCG+tlxmKYzbkX9ZRRP9R4JH8duHtw1fLiMiRVCu4NXlJd/FM3LErF7KeYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8VV3VlQIZ/Rxr8VMroYbUDpTO0xbOwtLemB1c2nAPs7bU1rjX
	Y9AqlhJDmjeaQ6qGSUWNTOtEFEe09nrFjV0AnmTsrvww7+x7qkhgbRFk
X-Gm-Gg: ASbGncsWT366sO1KBdrjj575olAPk89/6q5tNRJWHL3nvJDaSXS9NztHfYN5czs5IeM
	Xt/XwQj04EnJVvSu0kd2GKHFLKrbzz+ILKrxfXnzU17hrot8wlc9Bq4qjeNr+gLtVJ3LxtFzY2k
	PDXk9dXQzRggmDt01+4XtzQmwCYlviy7ACbBjw4/m9pYfm5h9P7Vrqu/Fyh18iWD3c7VaV6hBpS
	Lf/0CQ7W2UES5jRnA0z63xiEvqaXUPC/davf9HpHu74myDtteo7PmPPyXtMa5+a08KbaJc12MS4
	eOW3Yame7kulubeCfODylbKBmOpgYBnTvNpho4kCQOj+9kai7snsS6ih/KSzkHPvXfcWvjlJQj5
	xrFnxy0R+pCEewylhCs1rbIon4Hj27jo0NtY=
X-Google-Smtp-Source: AGHT+IGJp6Gfnt0CIJ+jxI2NYhdeuEM5FnZ+SAi6SOzmoW0cfaGdwEOjOGUo6UIqNkS2Ik5olNBGdg==
X-Received: by 2002:a05:600c:474f:b0:459:db54:5f34 with SMTP id 5b1f17b1804b1-459f4fc273dmr135170635e9.31.1754922943772;
        Mon, 11 Aug 2025 07:35:43 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::26f? ([2620:10d:c092:600::1:628b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac158sm41627825f8f.4.2025.08.11.07.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 07:35:43 -0700 (PDT)
Message-ID: <dfe92ca1-fdab-48f3-8410-e4435ab4f2f9@gmail.com>
Date: Mon, 11 Aug 2025 15:37:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v2] netmem: replace __netmem_clear_lsb() with
 netmem_to_nmdesc()
To: Byungchul Park <byungchul@sk.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel_team@skhynix.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 almasrymina@google.com, hawk@kernel.org, toke@redhat.com
References: <20250729104158.14975-1-byungchul@sk.com>
 <ef987e32-f7ce-4b5a-82c4-8d89d5034afd@gmail.com>
 <20250811042306.GA41974@system.software.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250811042306.GA41974@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/11/25 05:23, Byungchul Park wrote:
> On Sun, Aug 10, 2025 at 08:39:42PM +0100, Pavel Begunkov wrote:
>> On 7/29/25 11:41, Byungchul Park wrote:
>>> Changes from RFC:
>>>        1. Optimize the implementation of netmem_to_nmdesc to use less
>>>           instructions (feedbacked by Pavel)
>>>
>>> ---8<---
>>>   From 6a0dbaecbf9a2425afe73565914eaa762c5d15c8 Mon Sep 17 00:00:00 2001
>>> From: Byungchul Park <byungchul@sk.com>
>>> Date: Tue, 29 Jul 2025 19:34:12 +0900
>>> Subject: [RFC net-next v2] netmem: replace __netmem_clear_lsb() with netmem_to_nmdesc()
>>>
>>> Now that we have struct netmem_desc, it'd better access the pp fields
>>> via struct netmem_desc rather than struct net_iov.
>>>
>>> Introduce netmem_to_nmdesc() for safely converting netmem_ref to
>>> netmem_desc regardless of the type underneath e.i. netmem_desc, net_iov.
>>>
>>> While at it, remove __netmem_clear_lsb() and make netmem_to_nmdesc()
>>> used instead.
>>
>> I'll ultimately need this in another tree as indicated in the
>> original diff, so I'll take it into a branch and send it out
> 
> Just curious.  What is the original diff?

It was this one:

https://lore.kernel.org/all/a7bd1e6f-b854-4172-a29a-3f0662c6fd6e@gmail.com/

-- 
Pavel Begunkov



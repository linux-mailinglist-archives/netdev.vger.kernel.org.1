Return-Path: <netdev+bounces-240402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B29E8C742BF
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 14:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 0272D30B1A
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 13:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650CF296BBB;
	Thu, 20 Nov 2025 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4EJtkMN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYzbX3BB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688B8199EAD
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644826; cv=none; b=fS7yDHvmCgILlaGH8u4/y9guny1YqHEHmnCyqZwUfWf2dNA3v9AL8sQWxkgtd97TUKy7orGprcid4ABANMaOPvMceuCYKAfetU0LgBek66mqUlYr5KFTAXPzYUD5qnWss4tXfZtMfomZ8bOH6l0bAH1Xh3YXIN6bw1yCP9FCg9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644826; c=relaxed/simple;
	bh=qqVDFcJa5pEkHPM1koABowlzga7SG0/1oL+D67X5q9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bR4DtT1JrxETWlvEWb6wsXcwd5aorZ2O3g7kLZAGOVSWiev3aHalrHECacXkE2GJ003ZT2PBdEuB7fVtYuXHPvpn+wp1m1zceyuHzij8ekYSRhJggB0ZILLe6R6VfR06cYFg3f0MDFaT0qR/Y6017PLgs6zAtcS9/h/6/xI6Zjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K4EJtkMN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CYzbX3BB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763644823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2a8Spj1tHLvQegz/Tw95SZ80I86AUqba+QXaGpLJpnk=;
	b=K4EJtkMNVOf9GUaumeNQQAoc4m4ndV8f4WrZNr3vLvZ8ZJkEuMMZ8NhM8t7A+v7s7geqGN
	d9g+7MwvlQQaC9qLynrG7q/ieVSp1ZFFk0d/vyi/lbIGUOhVZds4HKx4/CoHZc/NIbHJMN
	I8B0pOI2q3HAVErnXcvoH3Hqp3oLI5A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-TsSm42q3PMqPJGtv3tXT6A-1; Thu, 20 Nov 2025 08:20:22 -0500
X-MC-Unique: TsSm42q3PMqPJGtv3tXT6A-1
X-Mimecast-MFC-AGG-ID: TsSm42q3PMqPJGtv3tXT6A_1763644821
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-64091bef2ecso1166263a12.3
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 05:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763644821; x=1764249621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2a8Spj1tHLvQegz/Tw95SZ80I86AUqba+QXaGpLJpnk=;
        b=CYzbX3BB47ze+fmhOaf4bZcyv9JyVr5krC4x24PxcczX3ywsDGw8XL6djAwOvPfC+M
         De/XvshDYFj1bJ8Ww3CVcl1e3bpMbFeKQPr5h/B2+ZQj1Ln3aQWXuelwoUKgzPqeBYFQ
         fWYESo/NRkPMumBpFUvN/2BgjoUqWLlMXoNtepBu5/NzGa1IyDQmVAygH+n+xz/024zG
         yWgkgEo03iM4Rl2t9BsVFcDrX1SsevElfwjSAvMTZxvCTPyMMaVcXW4CpyHx3+H8Dv6e
         ohIPd1C+fEBS/NoFkyNN9wVBM4ONG00p+qf8Az4WAPwntZLzB368EZDtIZ1M93t/CxUf
         +KqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763644821; x=1764249621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2a8Spj1tHLvQegz/Tw95SZ80I86AUqba+QXaGpLJpnk=;
        b=TJWZ9e2jPMd+xsugqcP8G4K/+keCTPWQI+1xqHgkhtrRNhKSheGqRafB5bdQwj/dyS
         uSeGzdxZwSl7LSCQ1uiKxuDMYsgesWQXk5w2Pjbt4Qk/6MlvqNPnOvA1vtTCmMhagbS5
         cfEYdNvyfDuW66wP5O8eeVuR8W8R/0nifgCGz9eoKsjIo1YpXOskWmOkb5ZmoadzjJCe
         S+PNU4EMWTascIfJrg9JfuV9Dj1s8/8F9Oh5Px+xvBQIYO1sGcWmCrTgNB1MLd9hJpjY
         4I4/TlfQzG3Tf3XFDNNUp/rlwU+bQ5KkiJdR70WGwS1kEdCpnPBvt4uiFz25l8eAKN8E
         GbCQ==
X-Gm-Message-State: AOJu0YwtOulpccqgba059OZsJbVQ5bCoXN44Jz69x6o5CyB6jNuOZgiQ
	lk9cTuTCwjyGwwAtn8x66R6wXqywvdLuSAZMT2cFpftOgl/E8jP5bFzMd9MFM9sGEvgnoGtmLXp
	Pg6yUtdcOkyFP3F2Pin2qYAEd078KrnzQwfIykW0XYHbh87mAQCfrAOK5Kg==
X-Gm-Gg: ASbGncvZeTogLDfhI/0/UgWgwUsE+V/VDy3R5xzhBCA/YFG+L6oM2iCRpJFEobACDLp
	shp3iXoA18gJBIhKZZ+g07PN4GXFJYCDy1WjCyIT2eFNil0DF1ATbs+ksjQwwZqI+k0+WgQLc46
	YiF8vekFQC3rwKv+mzaXYDWIxtQJsEsY7QgtQmfo1QRAx1pnm0kLV2Dw/dqWTPSTT09ooAb5EPw
	DIGdxBC6OockMw2BOasjoN8sy3CVCZ8OwSn5iaT67p2WzxOvKRqiuPYwmaHol20RhWoqHHlgZ4x
	qkrCsPIe0H+yDZIYG7Xjq2S8KX+SfoXhWhsbZwtPnh9rkRvUfMlI5UCUrZMemVGKTZU9FCUH/UC
	SopHXbqTC
X-Received: by 2002:a05:6402:520b:b0:63c:334c:fbc8 with SMTP id 4fb4d7f45d1cf-6453d9caf1cmr1623810a12.17.1763644820848;
        Thu, 20 Nov 2025 05:20:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4UcemIL5spLWi9Uo/YVDV3ErGXAfFRlFLGIXOECbAtBwJNPRFdw9OQRU05b7PqGmIrBW/Kg==
X-Received: by 2002:a05:6402:520b:b0:63c:334c:fbc8 with SMTP id 4fb4d7f45d1cf-6453d9caf1cmr1623771a12.17.1763644820416;
        Thu, 20 Nov 2025 05:20:20 -0800 (PST)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6453642d267sm2026289a12.22.2025.11.20.05.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 05:20:19 -0800 (PST)
Message-ID: <50ea6f8c-42d1-470d-9198-77e33ef070e4@redhat.com>
Date: Thu, 20 Nov 2025 14:20:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v4 3/3] dpll: Add dpll command
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, ivecera@redhat.com,
 jiri@resnulli.us, Jiri Pirko <jiri@nvidia.com>
References: <20251115233341.2701607-1-poros@redhat.com>
 <20251115233341.2701607-4-poros@redhat.com> <20251116090926.130f3b9e@phoenix>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20251116090926.130f3b9e@phoenix>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/16/25 18:09, Stephen Hemminger wrote:
> On Sun, 16 Nov 2025 00:33:41 +0100
> Petr Oros <poros@redhat.com> wrote:
>
>> +	/* Setup signal handler for graceful exit */
>> +	memset(&sa, 0, sizeof(sa));
> Personal preference, but I like initialization vs memset.
> To be pedantic use:
> 	sigemptyset(&sa.sa_mask);
fixed in v5
>
>> +	sa.sa_handler = monitor_sig_handler;
>> +	sigaction(SIGINT, &sa, NULL);
>> +	sigaction(SIGTERM, &sa, NULL);
>> +
> Current code is good enough, no need to change.
>
> If you are going to use signal for exit, why not use signalfd() which
> avoids lots of problems with interrupts in the middle of the loop.
I wasn’t aware of signalfd(). After looking into it, I like the approach
  and have rewritten the code to use it in v5.
>
> Checkpatch has some advice, most of it is not applicable but probably
> want to look at:
fixed in v5.
Many thanks for the constructive feedback; I want the code to be the 
best it can be.
>
> WARNING: Missing a blank line after declarations
> #1146: FILE: dpll/dpll.c:554:
> +	bool need_nl = true;
> +	if (argc > 0 && strcmp(argv[0], "help") == 0)
>
> WARNING: Missing a blank line after declarations
> #1725: FILE: dpll/dpll.c:1133:
> +		struct nlattr *tb_parent[DPLL_A_PIN_MAX + 1] = {};
> +		mnl_attr_parse_nested(ctx->entries[i], attr_pin_cb, tb_parent);
>
> WARNING: Missing a blank line after declarations
> #1761: FILE: dpll/dpll.c:1169:
> +		struct nlattr *tb_parent[DPLL_A_PIN_MAX + 1] = {};
> +		mnl_attr_parse_nested(ctx->entries[i], attr_pin_cb, tb_parent);
>
> WARNING: Missing a blank line after declarations
> #1790: FILE: dpll/dpll.c:1198:
> +		struct nlattr *tb_ref[DPLL_A_PIN_MAX + 1] = {};
> +		mnl_attr_parse_nested(ctx->entries[i], attr_pin_cb, tb_ref);
>
>
> WARNING: braces {} are not necessary for single statement blocks
> #2480: FILE: dpll/dpll.c:1888:
> +	if (json) {
> +		open_json_array(PRINT_JSON, "monitor");
> +	}
>
> WARNING: Block comments use a trailing */ on a separate line
> #2508: FILE: dpll/dpll.c:1916:
> +			 * If monitor_running is false, we're shutting down gracefully. */
>
> WARNING: braces {} are not necessary for single statement blocks
> #2516: FILE: dpll/dpll.c:1924:
> +	if (json) {
> +		close_json_array(PRINT_JSON, NULL);
> +	}
>
>



Return-Path: <netdev+bounces-151062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD8D9ECA00
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 11:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9BD1889DFA
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 10:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE281EC4DF;
	Wed, 11 Dec 2024 10:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdtQj0J6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141251E9B25;
	Wed, 11 Dec 2024 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733911876; cv=none; b=tXpzs2qu3Oeo3XSimTyaa4aTKbUGTdPflEoR6bkkHw4yGfWOYA0ERcpCNeSzraiT8Nc387PQr2gLUTUM8s2rMACC2qXZfzOKHcmsLiLNwhnaP7/5q3bOsXcwLGe8mYwRCuFRi3R7ZRe0dlm1MDwXokZonv0cDoFHapcOLjEfNmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733911876; c=relaxed/simple;
	bh=5Ac4MMu4M3l0nU0IJDoPVKHnPFWfuPHiTAl8/qMalaU=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ofVS2WCmHG8OWHeH10WQyYOkntAEYuTtBiQipLf4agZ8SL+5CvQfHzvL9uToyO2wr8glLWa/uR36pA0zLW9Kh3Up5tEVTVMLH5N3oQSlIHfSomenp7XtIhkwb9G6mWMN/uXq1F60qMHdy9lVGOlRS1n3UJx0X++0AKlvmRBGadU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdtQj0J6; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385ef8b64b3so5246346f8f.0;
        Wed, 11 Dec 2024 02:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733911873; x=1734516673; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hX6g4enLUD3i9WTvasZdHiGld+laa9+eheY6Oc4XtSU=;
        b=OdtQj0J6+I2vruZb22J6OPD6Z8Hc7WXTwjxZ6xgSZ9AHWywss5pnEyz9xtZsnRCX44
         Hmbpx5cQFTWbLd5hFEmnW007QlBGY7ioOne4MpCnbLASIdrS3eIKSqe9KKowvPQArSnB
         pRQcpR11dvqEOthntk43SQqSUv9DnGiXxUHOPpi5fVD8YDR7ZG1ypUhzM6jCzxXjcYm2
         WPEnivF9RGXINuIwtFEon1o+xYdUbNEFkXpRby6yRNpFTtOiKmOZuwfXj36YiFp+fnuH
         kcYwoJ8zaOtX3+sOgVUE5tsvDV1t2Z0pYChFG/ofYo+je2AIgaKMPFHxMOVfIQy9G9Mn
         HpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733911873; x=1734516673;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hX6g4enLUD3i9WTvasZdHiGld+laa9+eheY6Oc4XtSU=;
        b=GsSpADn69eDXbqYdIRFL0mne915ZHt+uHqFADuBJkUZvLlw8frOR/8PlDXGfpAOnLw
         zkkm00YNbXHlCSfFXsuyrKIZb9pS9RhV5jyQqHwhfk2bqD/6IiHmZTpQfzJ7m7IqY4xA
         kwOuhqNk7IfabWgVC6oUFv5hpVraLwFnB3gjk+rwNQxg36A96eRPnkb8T93rScjZX3td
         FOuakySyNh0FsG5v/6TSURQ+mfKflIBrbpZpbLH0Rt8FxtS2Q1k1EmBY/cfCgM/jeKa2
         zkVTR3MdBzDkIW77IZTIP/joYg9VimIbwdl7PYTlcR9YtM/CpNT3mW1Jq3B3+ymwgVt+
         DKwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ5YHSKXUReCdTuAN9fzz1wTEgb4aZSOe80uCQMgjVKjjel5JdrslEEIt+UUHj9AIAVR5zpMpZ@vger.kernel.org, AJvYcCWMRbwG1mc4V7l/6zHEsRVtpMyVn2pY8/XenOMAYHAG9VYM1XIjO07OdcmtVUilCdiM8dGbOlt/RzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzXzi8dyBlZ4fvpFBfEFNd4uKu7weJFS7InEHHyA7MCi8WwLT/
	bWJIFzMV+89FgCugekv8n4/RW6u7+rHRL+7TjdpK8GtiQJNZSWqx
X-Gm-Gg: ASbGncvXPAyqNfpWTa7UkKitqDfYumjr8FnJ1+5DTp7RhnhLo41ojDCHrwqKaQ1VRnp
	glh8Ad024NVDh4JhoVEO/cF8ryb1JUMGvTH4GJHDMPicRUYYO22BvOujZEQP7E6B+Nfzt+AjRZS
	2hOVjMERVTE+H7fbOrXgtvjzAeO3PN8JwpCFZ5h8wXR5HCyEvG+uLqZ2SH9jBd6XsHhUtn82ELU
	dwhfprPIem7St6Wk6QbPJm5BAHr+BOaZfDQjUK4Gz8u87dp/Du+yiB9BXOnMl9Wis/ik0G544mH
	0UmwTK75wWyr4D5BpAKWHJPyHSUZnFS6nmB1rzlALQ==
X-Google-Smtp-Source: AGHT+IEo55qgQ/J6fnwBY2AaO5VTsSfLJUDCkGZLcy+lptdX9HPGnloLsvpuE+UjzUujLgKaX3/44Q==
X-Received: by 2002:a5d:64e8:0:b0:386:3082:ee2d with SMTP id ffacd0b85a97d-3864cec5797mr1400070f8f.41.1733911873127;
        Wed, 11 Dec 2024 02:11:13 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362104aa9csm1520845e9.31.2024.12.11.02.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 02:11:12 -0800 (PST)
Subject: Re: [PATCH v7 28/28] sfc: support pio mapping based on cxl
To: Alejandro Lucero Palau <alucerop@amd.com>,
 alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-29-alejandro.lucero-palau@amd.com>
 <0f2c6c09-f3cd-4a27-4d07-6f9b5c805724@gmail.com>
 <bffb1a61-bc47-cc60-6d1c-70f57e749e36@amd.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <25df5f6d-096e-593c-9b6b-710658415a2f@gmail.com>
Date: Wed, 11 Dec 2024 10:11:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <bffb1a61-bc47-cc60-6d1c-70f57e749e36@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

On 11/12/2024 09:38, Alejandro Lucero Palau wrote:
> On 12/11/24 02:39, Edward Cree wrote:
>> On 09/12/2024 18:54, alejandro.lucero-palau@amd.com wrote:
>>> @@ -1263,8 +1281,25 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
>>>       iounmap(efx->membase);
>>>       efx->membase = membase;
>>>   -    /* Set up the WC mapping if needed */
>>> -    if (wc_mem_map_size) {
>>> +    if (!wc_mem_map_size)
>>> +        goto out;
>> Maybe this label ought to be called something else; it's not really an
>>   'early exit', it's a 'skip over mapping and linking PIO', which just
>>   _happens_ to be almost the last thing in the function.
> 
> 
> I do not know if I follow your point here. This was added following Martin's previous review for keeping the debugging when PIO is not needed.
> 
> It is formally skipping now because the change what I think is good for keeping indentation simpler with the additional conditional added.

Yeah, I agree that additional indentation is undesirable here.
(Although that does suggest that the *ideal* approach would be
 some refactoring into smaller functions, but I'm not going to
 ask you to take on that extra work just to get your change in.)

> Anyway, I can change the label to something like "out_through_debug "which adds, IMO, unnecessary name complexity. Just using "debug" could give the wrong idea ...
> 
> Any naming suggestion?

I was thinking something like "skip_pio:" or "no_piobufs:".
That way if someone later adds another bit of code to this function
 (to do something not PIO-related) it'll be obvious it should go
 after the label (& hence not be skipped), whereas with an "out:"
 label normally that means "something went wrong, we're exiting
 early" and thus additional functionality gets added before it.


Return-Path: <netdev+bounces-245498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9604FCCF249
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 10:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5F8F301D596
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 09:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FAB2F1FDA;
	Fri, 19 Dec 2025 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjAxv8kq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WRQL1dsI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3E32EF65C
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 09:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766136522; cv=none; b=hUFMSIS4stU4In578f+ZjkhjYNjIdo8pvR1OHRgDQcTFKtODVNwfoz3JITpyl8g0k1MlEYjLsvTD+r5t0LXGacy6F8GHKOhts+9GSL9JDNtWefKEG/7eff+gQeH8SZ7ZsVMyqCo2KB9+rEZX7M8o0CX1dMruTqUfed6bpu1hnag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766136522; c=relaxed/simple;
	bh=a9kGWB2VoIFD5H0J99TkVfZ6uDR6K/PyNGlZcO7cFag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZoKEzfIIi82O4Gc4pQbDeMBiryFzuj5RDXcFu+gqFw435qtlJFouTdVzQ8WuxuxUFz9LpqbQQcPB4g/CYOxWc/1V1fAearzNlhi1ZygII2HgJMVl9pO5SrQhlWQHxL1RZaA+SS3mcD6WkNRgfMutgsRiGlopGqxDpXekE7ESBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LjAxv8kq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WRQL1dsI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766136516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H7haCuyhI51FS9KbOrG4WJkMhKxZs4nFFL4lqUWoH9E=;
	b=LjAxv8kqhP9eQdenHSney+K/i7o+b5o4T8LtE6CDP6GpEe8b+iG6O+F0KNU/nCHB0hP+vP
	m7qyvYI3gRqL6CtpNz/HYT0OMoikA1ojnOk7fSORCLJZ3fwKSctEjZYEgO0gjepyehzfE9
	otQe0BuA1sG86jzWy/mNLvUoh2VRwZs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-2uAiRqwnOomC1zvJkbAoWw-1; Fri, 19 Dec 2025 04:28:35 -0500
X-MC-Unique: 2uAiRqwnOomC1zvJkbAoWw-1
X-Mimecast-MFC-AGG-ID: 2uAiRqwnOomC1zvJkbAoWw_1766136514
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso18762645e9.2
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 01:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766136514; x=1766741314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H7haCuyhI51FS9KbOrG4WJkMhKxZs4nFFL4lqUWoH9E=;
        b=WRQL1dsIbkfiQi6LcB6gpdyawE6x4n+UwwgvUzeQpD5QfD2laai4OJWc2MbU7/JvAL
         bbzFG4p3TlDYjWso6L6htwXlCyRfKgN1NP30O14icmeuem3/G0XYsxJHCMzl2ofiBO3k
         ZQTv4+VcyDUZHnuyMydRCOtsIuYba7JiYC+H21H1+Q2mXnXiIyqK93AcrzOETbmEbGU+
         AF34nXSR4ZVScn2AVdyb8ggSVkE3CgfW0Xe+oIUzZcROCig4LyIIrNKWj1p5R5nfJfa/
         U2wCOoCGGITdAA6qalYDGZ3lChXFbBLxDIHNqVIRVCnnIvgLcw6OXUjbOoiLEZh3UO63
         XuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766136514; x=1766741314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7haCuyhI51FS9KbOrG4WJkMhKxZs4nFFL4lqUWoH9E=;
        b=nTuAjQtOG4oqSPyQxvu43smrDQLGNpxZ+UtMugUkXpAGu158E3f+vjQY2e4EaSxCiM
         BvzztXDAZbGLnafKKzmZUMSXiKt/S4AqBaYEaMfuMf7BGb4Yo3LWGsVHhtnNIvRc7JsL
         dmcMDi0xobJGuaLgoHUSr93pR7Qgz67h8vqJ/e10kxh5NRILySXjYhDbKtrIC30DSwP2
         4SlcXCdT9rp8QbwRT9WpayexmUicpIzM6op7Hc8LISjraqBDJwD9NPSx/VwgYgrkB14r
         SQlvBmIrS2ZVG4QAHzyB7SUZffAKNExxrsjO3pfbFTnWHCtoT+hx5MVcyoXCAh5+/LPJ
         bSrg==
X-Forwarded-Encrypted: i=1; AJvYcCXt04PR966IUdq9NFW/iQWJTjX+EYz0e0DpCZbhvWZvN5FrqZYNRkrw9il/YeecdBxf2mjrJ8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw79zCSv22hwpZSqa03Tk63XKgXleh1wl/Auj1T7pFAcbCa7lS
	l6GUhc2S0vV/R9FcaeV4/t80cGHJggZO1mxV4OgnO2Yc9bE5JNx6pucKh2khNKtiTHBow6F+2nI
	gGRtMUZGonmttbpJ1BGKRLjADKqhJ/H8k5c5OiWkEiAryvW1bh2nNPK15DA==
X-Gm-Gg: AY/fxX5/OyfHUoosPMGO/kZkpDZlzMw/q/jFk1LE1NLPIe8I1CxaAtMoPuCmlTQBKcO
	hvUUBNvvz98dfL1dybOVBD5URzguvHGQ6k3kGkyJ9m7Dhae3FXZsUmNNpFe+0wXX1mc3XXo5/+9
	wstQi0RWgmTc1kgKBvPrI6D6hlW9wWY4LhNpA88GwR8Xlf4lbX1ECXtbM8extQrDeI3ZKUjqfxQ
	I8mvZcjAazQ8E4HkwjyJ5qjhNYkr9MfWX/j1ohm2i/72UISbMAL7pfSxXomkF3zcA4Vbfp8HB5a
	wTAQMpPrOu39BfIVIIKk3e5vMfHf+/cW04TokjDbOJ1tFR/viiPduJHM4IuDjbITLod5pzLWy1O
	VeiziPsQLvDEd
X-Received: by 2002:a05:600c:8107:b0:477:6374:6347 with SMTP id 5b1f17b1804b1-47d19594ce3mr17951225e9.22.1766136514140;
        Fri, 19 Dec 2025 01:28:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNoLKZcFi3Edz90O7ZAZd0UW0hmk7eXl1jBJlmWTqebq88oohMnYaPL71A6ehr5HyEB8Y1LQ==
X-Received: by 2002:a05:600c:8107:b0:477:6374:6347 with SMTP id 5b1f17b1804b1-47d19594ce3mr17950875e9.22.1766136513687;
        Fri, 19 Dec 2025 01:28:33 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d19352306sm34590835e9.5.2025.12.19.01.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 01:28:33 -0800 (PST)
Message-ID: <1491a7c7-3ff8-4aea-a6ee-4950f65c756f@redhat.com>
Date: Fri, 19 Dec 2025 10:28:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sysctl: Remove unused ctl_table forward declarations
To: Joel Granados <joel.granados@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, John Ogness
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-hams@vger.kernel.org, netdev@vger.kernel.org
References: <20251217-jag-sysctl_fw_decl-v2-1-d917a73635bc@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251217-jag-sysctl_fw_decl-v2-1-d917a73635bc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/25 1:16 PM, Joel Granados wrote:
> Remove superfluous forward declarations of ctl_table from header files
> where they are no longer needed. These declarations were left behind
> after sysctl code refactoring and cleanup.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Joel Granados <joel.granados@kernel.org>
> ---
> Apologies for such a big To: list. My idea is for this to go into
> mainline through sysctl; get back to me if you prefer otherwise. On the
> off chance that this has a V3, let me know if you want to be removed
> from the To and I'll make that happen

For the net bits:

Acked-by: Paolo Abeni <pabeni@redhat.com>

I'm ok with merging this via the sysctl tree, given that we don't see
much action happening in the ax25 header (and very low chances of
conflicts). But I would be also ok if you would split this into multiple
patches, one for each affected subsystem.

/P




Return-Path: <netdev+bounces-223475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD2AB59472
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C882B189C4A5
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D322C0F66;
	Tue, 16 Sep 2025 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mcwilliam.dev header.i=@mcwilliam.dev header.b="sRUNolMj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB6E2C031B
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020195; cv=none; b=TNHr/JBPUaNE3UfgLpphA2w3BOJOCFYgU3aQYehrLRdSWorb+XdNF6SEMrRksb98Yfuj9/b82o9li/X4s93NoNdJfls/ywCH8gvQ5xtHT586J6DevLLvhlLFU095RQrEYajIk0+VuNr7LmjEI/MtUms6icxyUwtQtN+/g344IW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020195; c=relaxed/simple;
	bh=QOmo0c2PA9x5E6zR7wmsAWu1t9+4taiEMEaZFXwXODE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hKE+hHLKlKWM7G77+dTkSAoQQ81QWZqF6QUVhLtsxJQYBMW34s/d2A5j+D3+HOnBiUHOdqbRefhIni+ORPTtOnKBJjPISvlVsiKi1ZnbuPsf7oDdlWl8tnJBWHbbkGVfxHTZN/LPMQ6EFsNh2W0tlWil5vY5bH3wtFym7WU7uvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mcwilliam.dev; spf=none smtp.mailfrom=mcwilliam.dev; dkim=fail (0-bit key) header.d=mcwilliam.dev header.i=@mcwilliam.dev header.b=sRUNolMj reason="key not found in DNS"; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mcwilliam.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mcwilliam.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso38620005e9.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 03:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mcwilliam.dev; s=google; t=1758020191; x=1758624991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FTdstMrjb0RpCXxsMZoI4rLXGQV5q97Fl5sehCzXMZM=;
        b=sRUNolMj45pHhTeeuQhG68+kU2WHLj1q5D6c7Fk2XaPnCp6lfv+CjWkyH9pSv8JjKH
         FZVGoFLWaABPfN024uPBKTdIQdcbetbwYW08ZrVk1KbrXRrSQhwMAkBK4yKnSdb80gdp
         VLSKrYM7HCThxG/FyNZ9vLctod7MVyjx+LGd3/JJFp1l3F7jbXfUKBjDMnrec9l46awr
         OZMW4mBW0fLKYS3TFmz8XxHxJgvyx6sNDmvk60Dv0Jdb4HOziu9/cuvKP1i1oD4h8Jb9
         NeEXQ2wIh7Ljl9WfWAF4Ivz5FV5FWpS7jw9nN9ps1X9muj1v1L61hWn/1fPzfYEaC6s/
         SdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758020191; x=1758624991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTdstMrjb0RpCXxsMZoI4rLXGQV5q97Fl5sehCzXMZM=;
        b=tZiScGe2evQeRrkAFn/DJCa+M6C+Dj3kV/EoKOBtQX8rqhAchLogEOwcpjiwpPjD2y
         FnuW/q1SPDqmWQUedH41pHi5F1IwikxnVNz2dsBztibVTMADSXJn7vzGPK9Js0+t81ug
         QeQevrx6SnRF0OsZkTDPFHZ1sPJhkNuq/DwIku8Pw3mSj82x3AITxuTp/cP0N8I1DRlZ
         CUIGhGkJOKLpRdy83UniKY5+KjHxnwdnkjT/kAj5+eY07p3vuNWQpDzOQ6C+gjgzpf1i
         FoCM6spVo/WqfO2whw6kd3Qg8pH8zVaycCS86qSvUfDKkXaz5vGgHWcUgOlgfrdzwjIx
         HNTw==
X-Forwarded-Encrypted: i=1; AJvYcCXeUkcFSJmp/NU6I99zO27o8+UbLMheTnAqxwjm/8eJCzB+fv8jdTeLAWO4CS6DN6bGsrHP908=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyGcxGoc5+e4beEqjCJ7xkbcgOIr0xxgIhsyBSeY9Dnwl2lHFP
	xiowNs6nXjUD9jszT18n29eXmqZJ6WXoFGg58pKj6en+L9nbnH9VPyIHbcZLg0uPCy0=
X-Gm-Gg: ASbGncsm210z+ymK4/P5QBrXK2EtsUNqOh2R1z4jEZYc+D0J/nZOTkfKqeVoPEmloZy
	m7APYTpv2LM3EwoRGH5ECL1/cKF7rOMKzamw6KwA0bCgWTb2r2brDJKSn4ALxhRv9xbaxVh3zMB
	COn3TuHToePWPU/Pt/jbopAXTPPFes3A+9HdRcDeXmf+bfiQVkToHQeeJMB2htGkfe1Mhrz2ECl
	l9tKeS1Yh9w4VT1NyrKhotm7xD+aqpRJvZKTM2aZI4aedp7lnTascXdMOw/bdUHlbeVBTv/JR3P
	0zpvkGCIBiGl8MTXmY4GHbHNnAD5+hRrkdKBJt7WgbvQuJVWBGQnu0VDvON6Vb2k6iiIGwC7xdW
	bd6pNt/iw9qLtDbmE5UKW3MWOTPN+1qWWJKNyVSzE6mNaCw==
X-Google-Smtp-Source: AGHT+IGAL2hHfSjXSyZ19tlfJdnzA4FS3CCDfc5G0tAHl9uOpUs+a4w0quzhkqCzBV0m8JCw+vFLrw==
X-Received: by 2002:a05:600c:314c:b0:45f:28dc:60ea with SMTP id 5b1f17b1804b1-45f28dc6192mr92284755e9.15.1758020191264;
        Tue, 16 Sep 2025 03:56:31 -0700 (PDT)
Received: from [192.168.0.92] ([146.255.105.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037186e5sm217298365e9.5.2025.09.16.03.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 03:56:30 -0700 (PDT)
Message-ID: <79587f3e-8f23-4a6b-af25-901364d8530d@mcwilliam.dev>
Date: Tue, 16 Sep 2025 11:56:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtnetlink: add needed_{head,tail}room attributes
Content-Language: en-GB
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20250915163217.368435-1-alasdair@mcwilliam.dev>
 <e742f9e0-671d-4058-99af-c3e38b73ec0d@iogearbox.net>
From: Alasdair McWilliam <alasdair@mcwilliam.dev>
In-Reply-To: <e742f9e0-671d-4058-99af-c3e38b73ec0d@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Daniel,

On 15/09/2025 17:49, Daniel Borkmann wrote:
> Hi Alasdair,
> 

>> @@ -2243,6 +2249,8 @@ static const struct nla_policy
>> ifla_policy[IFLA_MAX+1] = {
>>       [IFLA_GSO_IPV4_MAX_SIZE]    = NLA_POLICY_MIN(NLA_U32,
>> MAX_TCP_HEADER + 1),
>>       [IFLA_GRO_IPV4_MAX_SIZE]    = { .type = NLA_U32 },
>>       [IFLA_NETNS_IMMUTABLE]    = { .type = NLA_REJECT },
>> +    [IFLA_HEADROOM]        = { .type = NLA_U16 },
>> +    [IFLA_TAILROOM]        = { .type = NLA_U16 },
> 
> Given this is for dumping only, we'd need to replace NLA_U16 above with
> NLA_REJECT
> like in case of IFLA_NETNS_IMMUTABLE.
> 
> Also the Documentation/netlink/specs/rt_link.yaml needs an extension,
> otherwise lgtm.
> $subj should have [PATCH net-next] to indicate the target tree.
> 

Acknowledged. I will revise and re-submit. I will also include
additional context in the commit log as per your later email in this thread.

> Thanks,
> Daniel

Thanks!
Alasdair


Return-Path: <netdev+bounces-173803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D24A5BBD6
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 10:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722EF188EF2C
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 09:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6731EDA38;
	Tue, 11 Mar 2025 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6sCkBC3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9906F17AE11
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 09:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741684582; cv=none; b=umpjfqXxM+syMp4z6c4XLKDMjhGMQPoiN4md6ssOcNhLm2zKlVoUdAdJtk8RAzV1NpJlouVvxbpOUdOHYRiftyi9dnXXBFsyyxozbYQ+uMtmumArYTDQVSgX0nIHKRKWUU/hWnVaM0ZnQTNwEF4HrRzK2AtkungfsINaQWiTgjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741684582; c=relaxed/simple;
	bh=2Klz6USrV+JF4Fvg8UFTE+btW8UthvvuzGbaFIb9dBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Twe1700y/eGKeIjYH16vgE0L1jDoEL+ySJ7qL9r0i2Zvlnxm99jhmaQthQnXLte3gfAmGPL+RjxGcwxESK/WDzRjo8C4JLcbKyARuKAH12A5ZiY2/mT5JPl8ufFG1Tz/Fe3bCGqFvtHW6D9aBagjl7fx6/5r8skCOc5qnXd4zk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X6sCkBC3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741684579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DKGgQaKGX89LUHwZkiGUWXhgNXxI+p2/HEwJnREQX9c=;
	b=X6sCkBC39gJoT0dvQbnH4veBFXzfwBxYHGwP1fzD5z4loHpYNw0tv/pTEu2E4QwXI6sWVz
	Fw3zeO8112xJBcAyXr/mlVTEbvw07GJrwmqRNhNAC3oniFDOOUvGhrx6os/ZQ5pzmMqArZ
	MZ0YzE/ONSrZn9neS088IHnzlSzrmC4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-VqkrfjiGNMq3TuT5KKg0OQ-1; Tue, 11 Mar 2025 05:16:17 -0400
X-MC-Unique: VqkrfjiGNMq3TuT5KKg0OQ-1
X-Mimecast-MFC-AGG-ID: VqkrfjiGNMq3TuT5KKg0OQ_1741684577
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac254e4b515so451926766b.0
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 02:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741684577; x=1742289377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKGgQaKGX89LUHwZkiGUWXhgNXxI+p2/HEwJnREQX9c=;
        b=TfK1Q7oxjFi/iGyfTB0OlT+FOWZjAwWetObbzv7GfLE9CY5k/l6MeB8Gm6DrsWGvlz
         7FxQzYaTsXg/OAvq4IPPmCUW/StI6VaLFIR3zkitBd2+goHWjiGwYWu/OnjRRvfH3ieQ
         /8nUjTL3PPJzNJqHaq0CqFSYB2U+Is9bfmtD0JYulKq/dlMmMgT8NB42EbrijhqSQ5QS
         5RcZrtQdbbbqNs1zaGkVSP3591yV77Wwu0NluOh51Jywf0uspPlQNoetKqX85f/OBvKe
         6y+6/lihJoRtNpn1TmPyB+lB1722pVZbu2mgE9u6KJcyAjk1KqkP4iFyXCggam9GYptz
         gSig==
X-Forwarded-Encrypted: i=1; AJvYcCXix9Qo/4TjrUyi25YN1AfnishEUQ6uw9VCF6PzpuisKUMYOSh9rvrI8Aq9wDuexCfUjnv1l/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMMWlvyuQh1PfMrYraYSbIrrvApvu82wbut5DPPI3i1/N58d7L
	04CP8kfGFqwFAUqY3/yzCjQ/ECyL1BZ7OK0P7JnCbAGB498WDcWLMomPwUeKSbrjHhCXsuJNmcj
	Hfp6QVWfVp5hfGO3juy9EtXWkWTr0pzh4rE+HCyrxJpo/Fzzzaz2xrQ==
X-Gm-Gg: ASbGncvLpFuBo+BBENWo5aX3Xjus6/ibWlwQ2Mn2255zmAhMoDlcpIGAeKuIyCYPn9i
	oFA65yIoHlKlArn+6B4JccDMEaQ5cAeqgNi5QK6+QyOS0t9cMlTY7CkixxH/pcbSAap4Z2ibRky
	bnbzXSYaJKp9eymkjv41WNjYWKM54dUC4IZAwGE9B8NLqwoAqYvlwDKKu3vQiaDbccgzOtypq7C
	trYIsXFbxeXpFIiLDAbnYU2NIsvEtBUzpKwXyatLZ1x9RD3hWsZJm6TNzpwxj0SHU5S4Fe/B/Y7
	1VwjgCfyboknRXJg0ZX8sQKweTIukm9/4pV8JtM4QEiQsg==
X-Received: by 2002:a17:906:6a21:b0:ac1:791c:153a with SMTP id a640c23a62f3a-ac2ba53cff7mr222236266b.27.1741684576686;
        Tue, 11 Mar 2025 02:16:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnJH8UUUIVi208YGcVRuSkURFnR5lgAhQbJQsu9wvxRcbXehmVwy3UmwTSfGIMq32HzFNZyg==
X-Received: by 2002:a17:906:6a21:b0:ac1:791c:153a with SMTP id a640c23a62f3a-ac2ba53cff7mr222234266b.27.1741684576292;
        Tue, 11 Mar 2025 02:16:16 -0700 (PDT)
Received: from [192.168.88.253] (146-241-12-146.dyn.eolo.it. [146.241.12.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2a89f381fsm242567466b.169.2025.03.11.02.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 02:16:15 -0700 (PDT)
Message-ID: <952d6b81-6ca9-428c-8d43-1eb28dc04d59@redhat.com>
Date: Tue, 11 Mar 2025 10:16:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tc-tests: Update tc police action tests for tc
 buffer size rounding fixes.
To: Jonathan Lennox <jonathan.lennox42@gmail.com>,
 Jonathan Lennox <jonathan.lennox@8x8.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, Pedro Tammela <pctammela@mojatatu.com>
References: <2d8adcbe-c379-45c3-9ca9-4f50dbe6a6da@mojatatu.com>
 <20250304193813.3225343-1-jonathan.lennox@8x8.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250304193813.3225343-1-jonathan.lennox@8x8.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Adding the relevant maintainers and Pedro.

On 3/4/25 8:38 PM, Jonathan Lennox wrote:
> Before tc's recent change to fix rounding errors, several tests which
> specified a burst size of "1m" would translate back to being 1048574
> bytes (2b less than 1Mb).  sprint_size prints this as "1024Kb".
> 
> With the tc fix, the burst size is instead correctly reported as
> 1048576 bytes (precisely 1Mb), which sprint_size prints as "1Mb".
> 
> This updates the expected output in the tests' matchPattern values
> accordingly.
> 
> Signed-off-by: Jonathan Lennox <jonathan.lennox@8x8.com>

This is MIME multipart message, please send plaintext message instead
(PW surprisingly digest it, but not my tools).

AFAICS this fix will break the tests when running all version of
iproute2 except the upcoming one. I think this is not good enough; you
should detect the tc tool version and update expected output accordingly.

If that is not possible, I think it would be better to simply revert the
TC commit.

Thanks,

Paolo



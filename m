Return-Path: <netdev+bounces-144073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2639C5784
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8141F2234A
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 12:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FC61CD218;
	Tue, 12 Nov 2024 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0bAIkI2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F221C303A
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731413850; cv=none; b=QnoYZ2YXyB0zyuuDughXO/qef+sWEPBHTp/zu9D5eA70K7CTF0fkaZmyDW4xmSIqNYX5RsGaOr9UzILEHF99Nu6lHGqcn5668fq2o/moI8rK18kOdsrojqzo0YPysEueVoN4dtk2k5eJ5y4P6UTZ22z8Rwius6KmOia+ngBL6ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731413850; c=relaxed/simple;
	bh=4UlD1n85Mx1R4diNyJ5h8cEPGA+zUIDdlcIBZyTNcOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WC1dzZ4d6VanIgbKwv3WlJ6cIaIGyt3jANEGKqZ/2Y9uQrr5RsEVySrN5sHW8QFvwa+Aw6YP3LrlYN5YR48ObXv4WMqYaQS0CMmxNijioSV5MplqJcELubjxH5yqDk3dJB7wTUmCtHCqoJnGHg9BIdDVQtppyab2x3VFsCHjsOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K0bAIkI2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731413848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJt6NxM8Q1xDWj3BJjEeQ+B5ICpao9AwsVBlJa1hRFk=;
	b=K0bAIkI2KTq+dofEWn52CBH7vio1Smcsh9y5zmw5E7LPRTXrfOxxrRPLFOPhYWXsi0qhzh
	D5ZLkvZCu7n+MfDM9mVyu1rpcaDqoEhy8/O95qoVuUMFXrNVR5Yy5korGs2i1qODOxm3U5
	ixmQU3oPDQHaFddM+2tnRVTCAkWP5FM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-BPCu1STXOw2O13_Em4V9iw-1; Tue, 12 Nov 2024 07:17:23 -0500
X-MC-Unique: BPCu1STXOw2O13_Em4V9iw-1
X-Mimecast-MFC-AGG-ID: BPCu1STXOw2O13_Em4V9iw
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b15a8e9ff1so771358085a.1
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 04:17:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731413843; x=1732018643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJt6NxM8Q1xDWj3BJjEeQ+B5ICpao9AwsVBlJa1hRFk=;
        b=uv+uSyW1v0uxEUmSMoWW55YKynRYHm2jV8r98AZUCdng0FyCb1DFBttivygrQFESTR
         cr+Xuqr3FFpHKONoMOTvl3HgughANik6Kjjf2VSXy1acUFOQS9gzbVc6dClGXaTyBr3J
         lnkH2mLpRBy3+1crIle6Efr74ARpSc7P6+X521KxPtUTTAmKO7Kpwtg8OKxkbgyhP3s0
         E8yjsHYYJ3fy3YbQ1BgAxRebqJF5+LaogVUexAkBKnO2YOxg9YOeIkxxS0W/WTr6o38+
         M+//1xK8Obq1tL7/hqHz1Sl8O0YPIKGjipqsQe2ncwqW9FOTOQMHVvCKRQtF6r+GUDuk
         z9rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyBZQjJ2P4e1kGMj7etmjUVbuShj1ApGfmq+Ky0QaMSPcNvgcoWpzW32raJGM7Oky1ImK1tGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrWKV/6g4m1KC2e2Gu/zoSHNTIVKmzKgYJOnNjP4fys1HFvww8
	tlLGXV7wWP1r8cK3JA1GVZfujM01YYUZLgoNz6te5LhO7nm6cydKZwVG+quqyFqu8Ac0ByJ/F5f
	fEBrcLJk4ZImO5BM9ZX7Dz8rcpZADAKmnH2SyX6PozO7yKbjDxRanog==
X-Received: by 2002:a05:620a:1787:b0:7b1:448d:ea8a with SMTP id af79cd13be357-7b331ea9c26mr1929641485a.16.1731413843125;
        Tue, 12 Nov 2024 04:17:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERQUONaWM4vdc5qB97ytMRNYFHmjH8/VHVLMQZ58VCGKZQOk+EHnPEqiPcA7l/xokWpZs6oQ==
X-Received: by 2002:a05:620a:1787:b0:7b1:448d:ea8a with SMTP id af79cd13be357-7b331ea9c26mr1929638385a.16.1731413842765;
        Tue, 12 Nov 2024 04:17:22 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ab8d35dsm588406885a.0.2024.11.12.04.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 04:17:22 -0800 (PST)
Message-ID: <3248ec45-8168-47f2-84af-28a350261bf6@redhat.com>
Date: Tue, 12 Nov 2024 13:17:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] eth: fbnic: Add support to dump registers
To: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org
Cc: alexanderduyck@fb.com, kuba@kernel.org, andrew@lunn.ch,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kernel-team@meta.com, sanmanpradhan@meta.com, vadim.fedorenko@linux.dev,
 horms@kernel.org
References: <20241108013253.3934778-1-mohsin.bashr@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241108013253.3934778-1-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/24 02:32, Mohsin Bashir wrote:
> Add support for the 'ethtool -d <dev>' command to retrieve and print
> a register dump for fbnic. The dump defaults to version 1 and consists
> of two parts: all the register sections that can be dumped linearly, and
> an RPC RAM section that is structured in an interleaved fashion and
> requires special handling. For each register section, the dump also
> contains the start and end boundary information which can simplify parsing.
> 
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> ---
>  drivers/net/ethernet/meta/fbnic/Makefile      |   3 +-
>  drivers/net/ethernet/meta/fbnic/fbnic.h       |   3 +
>  drivers/net/ethernet/meta/fbnic/fbnic_csr.c   | 145 ++++++++++++++++++
>  drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  16 ++
>  .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  17 ++
>  5 files changed, 183 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_csr.c
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
> index cadd4dac6620..425e8b801265 100644
> --- a/drivers/net/ethernet/meta/fbnic/Makefile
> +++ b/drivers/net/ethernet/meta/fbnic/Makefile
> @@ -7,7 +7,8 @@
>  
>  obj-$(CONFIG_FBNIC) += fbnic.o
>  
> -fbnic-y := fbnic_devlink.o \
> +fbnic-y := fbnic_csr.o \
> +	   fbnic_devlink.o \
>  	   fbnic_ethtool.o \
>  	   fbnic_fw.o \
>  	   fbnic_hw_stats.o \
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
> index 9f9cb9b3e74e..98870cb2b689 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
> @@ -156,6 +156,9 @@ int fbnic_alloc_irqs(struct fbnic_dev *fbd);
>  void fbnic_get_fw_ver_commit_str(struct fbnic_dev *fbd, char *fw_version,
>  				 const size_t str_sz);
>  
> +void fbnic_csr_get_regs(struct fbnic_dev *fbd, u32 *data, u32 *regs_version);
> +int fbnic_csr_regs_len(struct fbnic_dev *fbd);
> +
>  enum fbnic_boards {
>  	fbnic_board_asic
>  };
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.c b/drivers/net/ethernet/meta/fbnic/fbnic_csr.c
> new file mode 100644
> index 000000000000..e6018e54bc68
> --- /dev/null
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.c

The code LGTM, but this newly created file lacks the SPDX licence
identifier.

Please add it.

/P

Side note: a few other files are missing such info, it would be good if
you could send patches to fix them, too.



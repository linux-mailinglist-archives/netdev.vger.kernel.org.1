Return-Path: <netdev+bounces-169393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D55CA43B0F
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6345C188B779
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3688A2144BF;
	Tue, 25 Feb 2025 10:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWuC+/UB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61442263F4D
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 10:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478340; cv=none; b=Bi0wmxU2nA0Or26AbwZXpBzuM9mSEkyVxtw6ntwT42NmixxjgRdFRu24XAwJSlWsCoLn6asZ9U3L/VJCta68PRVXkcUQTOJF0B3aXCssVNEzcytecXKpLVN7mpMJ9hG8CCKK7L3qUK/jHavT+P9ZnfhTQj5FCDi+rd2IzqlSPvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478340; c=relaxed/simple;
	bh=mJMkajuphg9Tig2oGHdnxIYcTJzX5VVeUg1rFBOJsSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dsu1JloJqHHYf1fpqm8iKteLBUC1dWWAkF4w3M9xxe3pwa3qshhRy+l5g6DWa3wmzONnQdP5EffbdUDwhQc1ldkn/P0pCd7EQTPfRGzqDDZidLrkil/UlcBKBNO9q9FYCwOc/EL/vXrRVdq8/6GKZsY4e+mpH1ulQzsDnNw7GaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FWuC+/UB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740478337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CZI2gzOBB0xJ5jkNLy+GmteL5L1iI7Kqn7pTf+x7Cc0=;
	b=FWuC+/UBeYsz2czjNWuXl4UMoeNhNHtdv23FzX0s4r81C3V3KE+kRhtuDG62KQfiNDxpRa
	tXTgFBWB/+L9S+5atxKrj6+nM7eusFi7hOp/9QCtMNaiNQiXxh27dwPgOZqjUX4a4RJAov
	YAT5kdBnkd8DEfyzq4gyRxqlklI+eQQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-1cfWpeR3MQisyOXMWB6G0Q-1; Tue, 25 Feb 2025 05:12:15 -0500
X-MC-Unique: 1cfWpeR3MQisyOXMWB6G0Q-1
X-Mimecast-MFC-AGG-ID: 1cfWpeR3MQisyOXMWB6G0Q_1740478334
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-439a5c4dfb2so24526595e9.1
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 02:12:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740478334; x=1741083134;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZI2gzOBB0xJ5jkNLy+GmteL5L1iI7Kqn7pTf+x7Cc0=;
        b=gcOr3ydXc9tbuswl76/UYkTFWzMQEJ2v/j1nEBbA/D4dKpWRb70wVMw5ayY3NjAt56
         TMTOVlzbDkAhPwlUR0Kqxhc5rwtOVuedWKeEo4R2Vtgf/ikpMvaod9Pe0RctV2QN8Qui
         YkW5H5/fHOfD/m4lnGuTkNZ5ScDKvVZqPMX4edY8D2glGBumc0WnhJrNGSQ6DHYO/aHR
         eiAESbyv0oo36e4r2o5T6D6kUtnqPFRkpy7XCBDZoTGqfsA6ol+grnjkbotJW+vrVTFX
         fUAtCEVihYm0debj7dAgoxpnHdNnSdotY454AjGowigu0jYgtHSwZZ6bM/ltA7jwKA1Z
         vC1w==
X-Forwarded-Encrypted: i=1; AJvYcCUFKl3axB7ZP1DiCR9IHv2NLCZW3EuZft1mHG2IT4BvujSZ4iMUkVMfKivv8DBuoq1eTVD4kgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo8XiNeYCjDOhS1M7JJPnIIBO1sCQnXeLnUvekfhHU89AfF3o6
	yMRwozNpX3GlWYJaurOqhCCMEamVhR1ltXLNvlMsBM5JgfV2ohFQjPJ2Ad2J18vSsiLcV3JVYGq
	T9W9+igPAI2ka7BgdoB9mKSF0GUXK2evUj+Kil9zYw9IRfPJ96iPB4w==
X-Gm-Gg: ASbGncv/1UuQPGMtv7FGvuPA5TnUO3RlUhgvpuc+IgVQwDgKoDlrFnxy6h9892lVXNg
	wxCATAPz1f8Ic8twt5+/LHpEVIkcv0Db3KnVyDo2IvPXgfaj18hiNLdl0wNUpq2wC/gBXlR5kNv
	W0mZ8lb5P1t7tWUHZC5c3Mpa1swRlqeX22SbT1miojspo2zSvafP416YEESTYQElWDaGplLEZIy
	fGM70Rgm+xkp9CzV0K4jF/ABrPJxQfdiMyiV3Ema7en2jMKkSn2ngzHBSuJAqWwX1Qo+6l9rdSo
	8qfsQDyEykRtpJJZ17n5IMZ3iFXQrUF+PA4OHTaBwFU=
X-Received: by 2002:a05:600c:1d1a:b0:439:94f8:fc68 with SMTP id 5b1f17b1804b1-439ba0b391dmr108465415e9.0.1740478334197;
        Tue, 25 Feb 2025 02:12:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiHtQb5hxUTUOWs8xAwnTVhAiAYLd0pv51f4bf2sD27cc5lb1TBJ+Vtress/OEMZlCb1ZWKg==
X-Received: by 2002:a05:600c:1d1a:b0:439:94f8:fc68 with SMTP id 5b1f17b1804b1-439ba0b391dmr108465065e9.0.1740478333874;
        Tue, 25 Feb 2025 02:12:13 -0800 (PST)
Received: from [192.168.88.253] (146-241-59-53.dyn.eolo.it. [146.241.59.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce615sm135773035e9.5.2025.02.25.02.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 02:12:13 -0800 (PST)
Message-ID: <63ede1de-1ee3-4872-84b7-d65ec2f68856@redhat.com>
Date: Tue, 25 Feb 2025 11:12:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v26 00/20] nvme-tcp receive offloads
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com, edumazet@google.com
References: <20250221095225.2159-1-aaptel@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250221095225.2159-1-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/25 10:52 AM, Aurelien Aptel wrote:
> The next iteration of our nvme-tcp receive offload series, rebased on top of yesterdays
> net-next 671819852118 ("Merge branch 'selftests-drv-net-add-a-simple-tso-test'")
> 
> We are pleased to announce that -as requested by Jakub- we now have
> continuous integration (via NIPA) testing running for this feature.

I'm sorry for the dumb question, but can you please share more details
on this point?

I don't see any self-test included here, nor any test result feeded to
the CI:

https://netdev.bots.linux.dev/devices.html

Thanks,

Paolo



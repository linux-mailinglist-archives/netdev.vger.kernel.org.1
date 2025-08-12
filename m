Return-Path: <netdev+bounces-212804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5144B220C7
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04CA33AF520
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 08:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31F82E1C5B;
	Tue, 12 Aug 2025 08:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="haYJJhgD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176412D4808
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 08:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987168; cv=none; b=EuIT/t7kZOVyT6CWwQhiu6h4fW5QA6RVY2mkyXcjuRJfzavbXPNa6Q+AjXdfjzrmtS++dsK+ZS5u06TCEWP0foFTsxpgOYeTbV3vHaSW8wLOc1lSF9c50+B5OGgma+q9gFkhfPVXfHyXlejXfHPlI4K+dBcGMyD3eFCU8Pj7UHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987168; c=relaxed/simple;
	bh=ZcMsCc5TDwaRo5gZq6fICFsrfcjz9crUEQn8lS//UiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYo8/A8p+CbybTSA27J3+nn69z5/g61smxOPrk0hA8ke3mwEQ4uZ3wmiydy2Bq8CTtTLFRW4eKFXI1qZKy9ERrz5yuGxEt9JedG/W8VSZ+eVoqetLiG47JyfV+yW+MzQ+SITTrq+xSQWuxHMxz25wZp5shmqNZLdxxxkOgPvvjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=haYJJhgD; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afa15bc3651so199964166b.2
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 01:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1754987165; x=1755591965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W0fkQusnFgYqVIIkXBH1DFrrD9Ca/c/G5j2OBwukywc=;
        b=haYJJhgDRiwLcHkRnI0hI86/gjPM3zt+joR5OUUO90D33x1HiPybUGBQWkTtx+FoqW
         CQP0yI5plfmaRuw6/L58mHS24WVmdUQLAWGcRf1e7w3Z3rXkEt2Dd33WAk3x2dkJTQP9
         0QkB9q6l8GZ8yOavZ8Zvs6DZrASBH+CA6UkYeX3NmRJ0LhLatr7TB4yTkdlX6PEdyP7e
         SwcRSON6+RVcptOqPjt2eHFK69sr97BGe9kt//5e1lEz0KWBMPpL7SZ2jaShiKdxgi2V
         uzjUW6laLokaHblyIAvO8UsRGqesp5GMan5QpW01p0O2irxmRWuxfimY5+MUv75VS580
         wN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987165; x=1755591965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W0fkQusnFgYqVIIkXBH1DFrrD9Ca/c/G5j2OBwukywc=;
        b=aCjPELtmZMi50GckYPxMpr/308vaMf9Q/O0iugGPf2v+hYYB2E4VboKcDo++B1IeVK
         7w9R/+xShnO2OtL1xdTENphmUYm+S8JaFEhL5EXt6ohCjp4VkBJiR24v88c+mNjGFolY
         rZNdloLh2b2Ml+qQWnLVmi+Fl2QpfAswWLYcd8B2GD7IK4dq95YrXNsFfi0E7pae2/iC
         dho3YW1j472Okcoq2g0q8xCJKJy3heED5/0reVqRJDXNJQgzKxfeIDUVSXANCaE49Hnj
         FICeB3kRNQhiY2+RAmfyNTzhtaicThEqn4FKbHd0CP/KRo6VDrW8nEf/RIG0rgPxFtkX
         XiUg==
X-Forwarded-Encrypted: i=1; AJvYcCXg6V3K6mlabV+d80+K2zHIL+6rdJa8s8TX0miPrfMBfTy7ItLanQ0NxfLkkCeSe4Rn4SVW764=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlZ1V1qSL+NiJYnDLKrOmWU1zI7BCwA054qrSJEH75aNGLrBAx
	EHI850vGPNJExjj5DuPQzrS1+zwoPayu3ZXYwgJCxyF7YcyEzNTv6v+ZS0bpoXqfUJ/vuKAokPS
	Yg9L/
X-Gm-Gg: ASbGncsPpaoZxy7mSZ1X8vm6oFIa5j/MSw+Tkm8dMTrZ17NsAdLrckcFoS9AFtuwfjd
	FMRB6r3oeymfNNiu3L60Q7YppzPwSdH1KHm/bMd/mUWRGk9mGNgh+chna7gj9Z/i9QOdXCguVYu
	sLGWIzii01sZlXE1rcmLv2GzogI3H8vcqIMScF1j5hYnux26N1mvYGQgTw6Y6Ts9bp4z6fpVdnl
	FBlryvaeK9ogMCCEmtLqrEGMMRglp5kqjwCfvdYX7E7E/VEj4IRLLf/CjMjL/BsKiifgNMEcS0T
	30t53Q6cKgc8cqy9zNH1/djBgt5z8bdQQGP4aM6LgUixV04hQztJE4VY6Jg1wmlcN0bKxVk7NxR
	zg5CXWiV0x42JN8tk/zD1Nj6+3WDF
X-Google-Smtp-Source: AGHT+IHtKyekBp44vQZ4BF4OZD9XDfwXO5YDjaF5O2uUPWtKN3kofQKvkiiQRy5kDI45DyTVh9wz1A==
X-Received: by 2002:a17:907:86a3:b0:af9:3eea:3531 with SMTP id a640c23a62f3a-afa1e17cc01mr212216666b.35.1754987165118;
        Tue, 12 Aug 2025 01:26:05 -0700 (PDT)
Received: from [100.115.92.205] ([109.160.72.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af93d62bc97sm1887229066b.80.2025.08.12.01.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 01:26:04 -0700 (PDT)
Message-ID: <04f94070-918d-4341-8983-0fafaa05089b@blackwall.org>
Date: Tue, 12 Aug 2025 11:26:02 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: forwarding: Add a test for FDB
 activity notification control
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, petrm@nvidia.com
References: <20250812071810.312346-1-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250812071810.312346-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 10:18, Ido Schimmel wrote:
> Test various aspects of FDB activity notification control:
> 
> * Transitioning of an FDB entry from inactive to active state.
> 
> * Transitioning of an FDB entry from active to inactive state.
> 
> * Avoiding the resetting of an FDB entry's last activity time (i.e.,
>    "updated" time) using the "norefresh" keyword.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   .../testing/selftests/net/forwarding/Makefile |   4 +-
>   .../net/forwarding/bridge_activity_notify.sh  | 173 ++++++++++++++++++
>   2 files changed, 176 insertions(+), 1 deletion(-)
>   create mode 100755 tools/testing/selftests/net/forwarding/bridge_activity_notify.sh
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



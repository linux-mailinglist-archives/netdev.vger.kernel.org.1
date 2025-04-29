Return-Path: <netdev+bounces-186879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90098AA3B68
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 00:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742DB5A7DF0
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D818527465D;
	Tue, 29 Apr 2025 22:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="JH9BxA5N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6416826B96E
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 22:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745965615; cv=none; b=LtFPaRujjQA6j4lXRW6VdRiSg0K/iPlOhFTr7gYLt12SXeVUeQVhmZKvZVZ0woiiDtK+ADZQQ2B2UShAIkuMp28S1O7FoExzS3zNKxMosJ130cmsjVkQUa7Idc1MDEWhSdcimmBa8CFOamfLMojvkUwVK0PFJgd9hgaavR4lFk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745965615; c=relaxed/simple;
	bh=ow/asRXv76CUGebD7pwmfFk3ILDK1CeFKJ2SPMQJi6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+/I+qEYkoqlxX2/pBzj8qhN0PL0pN5OXqnfD7h/M1OJHQw+39XDT8ShPMsyB2kD+MpR5ndhJz/vPjOCbrw6tSvLYlMuHhbqnJZfIBL3ZGMh12CxfRIjNUv5xMl688Uq7e11MpmcqOgm8qKieKcFdLeaOHv+GpAjAyZiTf+y9XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=JH9BxA5N; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22c336fcdaaso79740385ad.3
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 15:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1745965613; x=1746570413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4a+tuJg33+uhPPz1yAy/MA+ek1Svv81bOCIHxVUHSRU=;
        b=JH9BxA5NXATLT1H9YNRWHQaRstEy3RjSZSdQKQOrTbTuaL587EC+P7D8vw2e8eGzP1
         cBMec72UkNlLKF+2H/PcpYfURDTnZ3COQk+gTBWdWB5SxGKLFpiL7sOI+H0O4WCPueHM
         4JqYGx/A6/Xs94Et/RVOUnse0n6LRh0Jxxfp9pR1eig5Jh0ip7Wd2XGy9PIQDm4K+qen
         YfT2QPJ+ShRrv3m5MwjhfUXegavz2IhuIt5LfTd6OAQGtbiDSiQxQYQuAWrMIRvc/BEU
         xRUB7jne7tK3LN4E+LENlxqub3mYylu4dEoaGhy4UIDa09Qd0lOeeWJbWRU8IReW5/zJ
         smyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745965613; x=1746570413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4a+tuJg33+uhPPz1yAy/MA+ek1Svv81bOCIHxVUHSRU=;
        b=jAldKDFnoHGuPx2ilecEz7zWrWNq7QZjDdYiO2/rTS0JMyMMmPMEX5erIM2q2dghy/
         Bh+1C/1YERTF9FxbX8DyuwOqZTfgrpIR5Up9EKC0IsyZTFWB0JqAXE7HeK+MEwQcyU+P
         OaytT792Er/YwDUZ3squnKhRGCjmMsP1uns348LrdmL5i4lHZ1or9Yh/Y5G5tyHfizuh
         7qtRaE+oAdxKoxkLejAKWHleUwHS3CQJsiOhIxHEHlg5RnCPNuy7yNjWqSnokgLpT2ty
         dtCns9IKMLptjKeNpcmDUfzcq6S5VTyZxLrEsUPbpfAowsBBCgkU25l5yBZHxw/oIfe6
         qCyw==
X-Gm-Message-State: AOJu0YxsbAiSKXGOQ38lygGhqIHyxboNHkm6yu49rSTsWpNOBOZX5/i4
	CDcelXP2lx+Dd6/w1GO9UuDAL4l+BoPb5CZ7NEzrxyoyJ1ITni4dM314neUj3c4=
X-Gm-Gg: ASbGnctgellYAhpaXl6N1+yS6UhqBlAfcf5+GFqlL2QnsZ1nhJ1OjkEvxfMHaVk8B+V
	/zXTdD30eAV0GxAyhx50gAQMCWQACFBE8URomaBy802oOOfzo1beYxfCMA6+t1/1CQvbAQTE9Ul
	o2UQWhkuVAOJ/O2UuqVsPcSVN2PjF0yFilDPFfYuX33TgMN4Ih9MIZN8ecFtQ5pNw48sdTmWfnD
	ET2+D5vvGRu8VenofAKZH3LpJl50FuM+u12QOGaNMCYjAoA4ue0G14wYlH/vm2AvXvO6kfXs+pc
	9FMHZ1XxGCr2zBkQBOtOfRiVwZNEZQQh347PGUY5GvMrM4Xzh2COcZ/qDDLfIRvYpffgT+O5SRu
	Ldw==
X-Google-Smtp-Source: AGHT+IHjIH+rJDlRzcFT+UogmjjoQ2JdGkpcfatF3lmRq7xnru0QV3h1QIeSHYe+OUppnlu9eE4BpQ==
X-Received: by 2002:a17:903:32c5:b0:220:ec62:7dc8 with SMTP id d9443c01a7336-22df34a9d92mr14164495ad.2.1745965613544;
        Tue, 29 Apr 2025 15:26:53 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:70:cef2:3f8c:63fe? ([2620:10d:c090:500::5:cb11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e7a1dsm108760285ad.140.2025.04.29.15.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 15:26:53 -0700 (PDT)
Message-ID: <9b800fc9-de85-4dc1-b66e-5c549b206865@davidwei.uk>
Date: Tue, 29 Apr 2025 15:26:52 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] bnxt_en: add debugfs file for restarting rx
 queues
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20250429000627.1654039-1-dw@davidwei.uk>
 <20250429151824.6d20ea0c@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250429151824.6d20ea0c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/25 15:18, Jakub Kicinski wrote:
> On Mon, 28 Apr 2025 17:06:27 -0700 David Wei wrote:
>> Add a debugfs file that resets an Rx queue using
>> netdev_rx_queue_restart(). Useful for testing and debugging.
> 
> I think we need stronger justification to add reset triggers
> in debugfs. If you just need this for development please keep
> it in your local tree?

Okay, I thought it would be useful and didn't realise it needed strong
justification. Happy to drop and keep it locally.


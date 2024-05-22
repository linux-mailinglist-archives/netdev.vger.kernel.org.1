Return-Path: <netdev+bounces-97605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1888CC4D0
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 18:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F12280DFB
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 16:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ED5140E23;
	Wed, 22 May 2024 16:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M+yRx/qJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D156D13F42B
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716394777; cv=none; b=Eo3rO1IXVh/wMxKALK2fvzmpy2qJqhjzOt2cjhBuHuh+lt+uAwlnTvNRff3iEIMXAqb2OFtZX+85UkJpAxKB0pchKkEwNGtDjv0idYqYGUnBScxM4Tmu5IYnP/Yd12gvn19COXSFXLZHT7JEVa9fz7NRQb5ddSzorOwQ2E9MAbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716394777; c=relaxed/simple;
	bh=gRGdiC32qyMGfj6WpEKPIdOaphnyHadvcat7Ef04QOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/B9PfVnUo24H7vbr5owG/jn+bwhgxVBirRYQVJOBe96PJP7DoU362jNU+nS3nFHAb7B4WKd81yQRAHNfcpPVuyMyjIsU3qxo+dkQnYh9QMpg5mc9iusNmX9K4cVjceQCXqKXpVmoWgRpIObIHjE3OSY9BI7ciI4PuP07eNwTZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M+yRx/qJ; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7e1b520812fso35658839f.1
        for <netdev@vger.kernel.org>; Wed, 22 May 2024 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716394775; x=1716999575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=26coTTJPMwihRdwvqlxfLCNSgtD/ruUTDG9z4IGxkNE=;
        b=M+yRx/qJyV3krTJFoIJpvzfi5HD9gPOjhWMFsZvS2WRQuzcBNB/hwbz/AHOa4wY+th
         melQpBTsw3k8gyBdsCQAWDwm4ORJZG7qTjNgWuvT9k0e08W5V/6Bbgm1DM3CKge55wHg
         EooZNmGoEJrYgfRZu5Gh0qTVOiGcGlDf3K0y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716394775; x=1716999575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26coTTJPMwihRdwvqlxfLCNSgtD/ruUTDG9z4IGxkNE=;
        b=oHHWK148l449jBIJt9NcKRK/BOvu/T6YPynO3u2aaUD2ksCzPLNGoW4argpBIXKM+m
         C4ci7+uC6WtpP/VcnAcV9onkBsPhQrgbT/qSJ8Ht10LefxKkN7b1/FSLho97J0FiKIEQ
         0S9DDjx3nx44NJaGNIynSSSw5prVCj09b0Pc+Qyjkqjwg53QF/bFFY9Pq+mCU7Xrjd+m
         03K05x/SjAe010Yp2FIFQbbAFq9dt5/6nfKiAZYLREwE0cq1RFe3D13K/PxZOBUTIPsD
         nbUpZlil95gwk5xihoZLPfY4DbxxEfBzwaFaboySdb2KzGbbBfVJpwqo1LUZZVbRw5Ta
         Ojzw==
X-Forwarded-Encrypted: i=1; AJvYcCXqMY56TbzeFBSAYy/wNe2smgz57ruDYhRaGfpWWH07eFjzDW5hPRvRgy81eQIxLs1PyE95mhaYakppRZOuJoMtKvz1XHIO
X-Gm-Message-State: AOJu0YwH7K9fKhSA17+66Bzht8iJxYqw4drvbOJzeY93dWDcMgmKRTCT
	mT3K4gYv6yBlH8b7pOcamEOCsIXbvfupoJ7sJg8MwIi2bGHVER9U7/Dimaazq+I=
X-Google-Smtp-Source: AGHT+IH/KZa0o+v3YObJYKHyHITiD47mIwmwbzcFdaePVDylL6T1KHgx+UsgI0x7EBrdYtRJOKeT1w==
X-Received: by 2002:a5e:cb03:0:b0:7e1:d865:e700 with SMTP id ca18e2360f4ac-7e38b2004fbmr274656739f.2.1716394774799;
        Wed, 22 May 2024 09:19:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489376fc6aasm7421787173.174.2024.05.22.09.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 09:19:34 -0700 (PDT)
Message-ID: <6caf3332-9ed9-4257-9532-4fd71c465c0d@linuxfoundation.org>
Date: Wed, 22 May 2024 10:19:33 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/68] Define _GNU_SOURCE for sources using
To: Edward Liaw <edliaw@google.com>, shuah@kernel.org,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Christian Brauner <brauner@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, linux-security-module@vger.kernel.org,
 netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
 bpf@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240522005913.3540131-1-edliaw@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/21/24 18:56, Edward Liaw wrote:
> Centralizes the definition of _GNU_SOURCE into KHDR_INCLUDES and removes
> redefinitions of _GNU_SOURCE from source code.
> 
> 809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
> asprintf into kselftest_harness.h, which is a GNU extension and needs

Easier solution to define LINE_MAX locally. In gerenal it is advisable
to not add local defines, but it is desirable in some cases to avoid
churn like this one.

> _GNU_SOURCE to either be defined prior to including headers or with the
> -D_GNU_SOURCE flag passed to the compiler.
> 

This is huge churn to all the tests and some maintainers aren't
onboard to take this change.

Is there an wasier way to fix this instead? Please explore
localized options before asking me to take this series.

thanks,
-- Shuah


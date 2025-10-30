Return-Path: <netdev+bounces-234229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 492E4C1DFE6
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 02:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CBB81886627
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 01:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E54C23F417;
	Thu, 30 Oct 2025 01:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="UKWl2KFs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AED167272
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 01:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761786599; cv=none; b=fdAf6yaRX+/w46tYOaw4kCxc4rP1tGZNBnIvVvTNUlSzVSpe3wLYA56lQTRjO9EdVR0jK0+wEigOSUEpg4qotL32KZrsRDTDhazADnOaxT4XPnLTlYmidk8u49cdhRnVz5fPmSKnXzaNZ90E5tkhhUIVbIL4YvjlLDgx0Msud/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761786599; c=relaxed/simple;
	bh=D9Tme8q5q4e3sQxmpprJdpD+KQi5drqo8UZE60PpdhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CFX6r2oiegHoSV1mKfvK9v5HMrHNnsS/uRuVwcYJFjnLYBJ2Un1dvsXJK3hqkEde5K/agzoCXG0LJJwdzLqtlUeEqEl5AAKm6mDYrszOkm0gGnm8OBwNxdB99nPabh27tT4vCVhJLe+qQFJGtwf3LfYiFRYtRYBl+Gdb/AyXi3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=UKWl2KFs; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33067909400so392667a91.2
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 18:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761786597; x=1762391397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ZXkePErff/X7w1mCruG+ZVnzr8ox/6PFM/DVB8//m0=;
        b=UKWl2KFsFYd+n80UyCQm6BipqIQ99WCk8ba7UzQNbDQGPTOense90GaLj0Xy+/hJQc
         pA6aaLJ46NBkJW6M1bP7/XLsv++t86O4C1FofLFt76m8VDLI273CTwYXnBQi4RFM0dav
         rF9e5x0FcOO3RP3yArbOCsqWmxSBB49D82n1iLCREPTcGTWX64qaO2FWCt3e8syA6hmm
         NWmB79tE1xcVLhIb2teZcE7QD/4cFAq7+HBbKHK/KuEC3ydyzLtvccCVFOyC/Pta54OB
         fcPY84Y0QFMRhU5CblwGJq55sm3WHAUPb6sO7rxfiOFDn58+yMz388e4UwN57E520cqd
         QV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761786597; x=1762391397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZXkePErff/X7w1mCruG+ZVnzr8ox/6PFM/DVB8//m0=;
        b=JDjZXgpQfdE+CVRQ4pfakGYMK/dBwqh8n0XVUQuSLO7Eg2Oif99r+SUPnqxBdMvVQ3
         mng5tZbGayvVZkMUx8otKH2HfCjhhBiSBLVsC09Is3ga1edtefmxYffiiOxaXy6aj+SP
         JPvTDzzWHNUljqNC96k4AbFnxl0/QWgUalrLFrmLAwcO+LYovX49RDrsfkUjwBPaBot7
         gdjgUMl7ds3VHtY/z6z5Z5sMLije7VX7TlT96bhJeHqavpDgsUt3SkUf+xGvPRZg3uoL
         EFrq+s4/Nn+NE9sp/+iHFvrxroFAE1Fs0a/HaVhjkrHbHSPqhe31DVIWmxq+mykknWTa
         UkXg==
X-Forwarded-Encrypted: i=1; AJvYcCUrVMzMbdC3rkuOYBKhbIzDiuwQJ4kt42qrbefU9XscJd1usrrAK3sZJVbEmutUjYtPLiZEIQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6CDys6xaHcHutXEf+6TnwqNw0UDRsWpfffh4v3qdLrAtI2Avh
	4aFmQBcERImoNJpoYY+BmVL+v9EZns/t61YqkKL1yIwlhCQrr5wVJ4bBZFFMZxphO0M=
X-Gm-Gg: ASbGncvdKwu0/dHnNEqzZZDt+83+KE0KTFnPKzkvvSfax3JjZEbJLXqhvREL4Gw/H8D
	MjtzYYbbYRlXaSCrWM6x108+d2SgwOBI2Z6W+kWrXd9Mxdb73YR+6XhWt2WQoozQA67diFpnhIx
	SlT1MBZsRgqZKzBM+jvOwmhdEKZaMCYj/b6U0bFgmazmClS5eza9Uu9uc0NHgDZGnGQFAi3shBC
	+wzdz7L6UHq4uZAadZjdV8sZJaf+VshDH3nhVfrh5p4ybnzbkJ9XPGzW6Ubs3czz6kpUmn8v4EN
	HeAHtkat8kDw8/pD7P08lSph1w9G+4AjHVAc+ei/WhvF684xfORqxpiT2lXJCr/fBQ2n6x3FLG5
	/1kWW20u0GSJrcw5MiXFlL5IWSXXujw3hX7AafCzolDjqR625TTqIa5kMeIf4vRHxFnznYt9mNO
	GwxB326CHew25R0K7qcNctW+elu0S/M4+deiGEPaA=
X-Google-Smtp-Source: AGHT+IFnlVfY8DVFhe9uMkmdmncjLOn8LIsq1MiGRK386r+K+cPBJjGdv1pTqeoka32t8RKLLu9aQQ==
X-Received: by 2002:a17:90b:4e8e:b0:330:6d5e:f17e with SMTP id 98e67ed59e1d1-3403a299f98mr5702054a91.24.1761786597207;
        Wed, 29 Oct 2025 18:09:57 -0700 (PDT)
Received: from [192.168.86.109] ([136.27.45.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3402942f298sm3370583a91.5.2025.10.29.18.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 18:09:56 -0700 (PDT)
Message-ID: <3801c040-e6b4-4c09-b711-b94f3bdc8250@davidwei.uk>
Date: Wed, 29 Oct 2025 18:09:54 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] net: export netdev_get_by_index_lock()
To: Jakub Kicinski <kuba@kernel.org>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20251029231654.1156874-1-dw@davidwei.uk>
 <20251029231654.1156874-2-dw@davidwei.uk>
 <20251029165143.30704d62@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20251029165143.30704d62@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-29 16:51, Jakub Kicinski wrote:
> On Wed, 29 Oct 2025 16:16:53 -0700 David Wei wrote:
>> +EXPORT_SYMBOL(netdev_get_by_index_lock);
> 
> I don't think io_uring can be a module? No need to export

Got it, will remove.


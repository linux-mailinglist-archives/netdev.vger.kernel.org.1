Return-Path: <netdev+bounces-73759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5E385E35F
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 17:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191981C24759
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 16:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF9D81ABB;
	Wed, 21 Feb 2024 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGO1VyII"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189D080C03
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532833; cv=none; b=AKDvTyy1LOLHpoMqJCcZO4vae87zZjb3dPCrSYz31PD8z1qZUByOImmAMHqwlxtOf52Hw9Lvt0a65iW2yLHR7IbpDYYwMh9Bl052PxGS3A0xR9BjsGqrQ74V09fv64rwJLYiNKFxNdAFSReMRECh/afhdlpzHjl8z7HixsJvUzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532833; c=relaxed/simple;
	bh=oCFk8YOOd20Sghc+OthgFfREWS7c8748VyMt2Cb6JbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LzHeM/kuD3g/L+vgcm9GnslWQtVRalK0fV2eCFjiHG11R7afYaxK7apioJOJbZ1S4l8mZpSJKB5VTiE5+qoI9o3w0L90G6W3ylvKThKrN8MR9kKVgkp/1rz8tMdsY5BUTchCxAO09106aLHu1IfsDc4QdxK6oi0tdac0VXx4l1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGO1VyII; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-365169e0938so11640485ab.0
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 08:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708532831; x=1709137631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oCFk8YOOd20Sghc+OthgFfREWS7c8748VyMt2Cb6JbQ=;
        b=KGO1VyIIbUqYu2W7dVNjnxeck7PCrIY9FdYhmLq1HQG5FoQYMu8NR3BDn8vOKiiQAX
         dMgK/R1gCQsLsdDcE35r3OtIIaO8rrh3lXC2uuO1J/oYhlPwxFH05PcdnIteoGpI88ad
         JhHK7sMYzGGYa1vy1trWtGXFyDousn65vHB+zyl5HpMIqNztmlE7umBhIclTSZfcudz2
         pFJpSjhwIjpIfQvcBrRVfMzKwH7Fdw+p0i0m7RxvLyH3B6xcxTpFMttaPz0D42dHOYlD
         nwy6KNhQ/SJb9KsBKz4L3bp6WZ/p6jtHQCNnW/3NQzeXHE5J0kZpjWMJQqc4Gq3kzIMG
         9iOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708532831; x=1709137631;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oCFk8YOOd20Sghc+OthgFfREWS7c8748VyMt2Cb6JbQ=;
        b=ITWPKu5Bbb2dpPaFeVtR41Y/aqOfoTDlWeKr1QWMdJCPx4B6eXEIMFCP1R/DMGnid/
         vhB3dBDf4TdRFRdVyqCbEVbJ+doM0mWJlPA1Gd2bCYmJWbADHgjgj5SnHXX4in9nHTay
         O6ThTQJZ8Gwrl7ZmOWRF/VgtI3y2ZkbBFeXGtDbyyZvqOOjR7Z3Js+X02omFARm9Gy4t
         lA93Wj0gl9QvLhw8JMN68PNxQPTYt4g5jxtFcKCKuZLxtTDPMAVAdQ1rGKP+Z7bLKVNL
         JY1vkrWkWEqkugJdQ7pacPTQL++E35eVyTeosIZ1p/lmGwHlyT9DOTwGtGYSfPFAk+3Q
         Q/PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEb+UbUP8lcM1f9OXsAxv5eL1VEmLZI5YjRn0Ui+33Y4oNREP0G55pr0hFKEkKwz8MI+u8rMHGeCcK7YHgW576WtyA6VyI
X-Gm-Message-State: AOJu0YzLYkBN5qXdmFQZtqYTmGqjCq06xlb0W+4N5I7z8W6ya2HlXL57
	ymdeCsZqgbV1C7vAEhIwl2ZAwj7UvmaeM8dONe7Nistys/I7M3jl
X-Google-Smtp-Source: AGHT+IH9rvluEQ2Dke3crFgrb5ZMs+8p0g7EJ2SlLFb8ZW0XTSUxN/VuDs71JwMtwt59HEFcYi0LxA==
X-Received: by 2002:a92:cd49:0:b0:365:38e2:1dde with SMTP id v9-20020a92cd49000000b0036538e21ddemr4968569ilq.15.1708532831041;
        Wed, 21 Feb 2024 08:27:11 -0800 (PST)
Received: from ?IPV6:2601:282:1e82:2350:45ee:97bc:caaf:59f5? ([2601:282:1e82:2350:45ee:97bc:caaf:59f5])
        by smtp.googlemail.com with ESMTPSA id 17-20020a056e020cb100b00363d8ee8cf7sm3436371ilg.48.2024.02.21.08.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 08:27:10 -0800 (PST)
Message-ID: <0a806bb1-ab72-4afa-abe5-be62cc5fbf11@gmail.com>
Date: Wed, 21 Feb 2024 09:27:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2 v8 1/3] ss: add support for BPF socket-local
 storage
Content-Language: en-US
To: Quentin Deslandes <qde@naccy.de>, netdev@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>, kernel-team@meta.com,
 Matthieu Baerts <matttbe@kernel.org>
References: <20240214084235.25618-1-qde@naccy.de>
 <20240214084235.25618-2-qde@naccy.de>
 <576ebc9e-4307-4e01-9b41-12aaac83b14a@gmail.com>
 <5615212b-736d-4a91-8951-ddb9bc90049b@naccy.de>
 <9610f33d-ee98-4b95-a776-a203d83401bf@naccy.de>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <9610f33d-ee98-4b95-a776-a203d83401bf@naccy.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/24 4:00 AM, Quentin Deslandes wrote:
> This will ensure that: - Features relying on HAVE_LIBBPF in ss don't
> have to comply with the same requirements as the BPF socket-local
> storage support (because iproute2 only requires libbpf-0.1+). - This
> change won't prevent iproute2 as a whole from being compiled. This seems
> much more reasonable than using #error and failing the whole build. I'll
> send a v9 with these changes.

exactly, will take a look at the latest version in the next few days.


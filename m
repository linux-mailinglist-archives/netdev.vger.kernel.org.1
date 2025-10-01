Return-Path: <netdev+bounces-227512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC14DBB1AF9
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 22:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A1DA1C6918
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 20:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C112ED164;
	Wed,  1 Oct 2025 20:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cq4JAETc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0902ED87C
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 20:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759350523; cv=none; b=IAp8l3trU/qV8GdFPGw1Zr/M8ur6NcFnCEtvUlXOZkgSVZ0GK0p7NXruLnlEkqyLh2hERMHXg+TL8GAR9+QtlosfBi4BGBCb9sNo+VnbzU7WzoorCXbHNuAUpoRKtOueepvtfaM0aHXIphlgR+FAqbRDsUUqU8SHUQV5NaJHRv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759350523; c=relaxed/simple;
	bh=JzNNoDWyqa/zS7UWyDTfg/U2MEu+uqwPpkYQr/cahAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mG5lMvQDrGYItWCzZM0CRgyGeGwaoTFLLqo1bUOEaEvLzswwGmKKOngUsWCNJvpUHXyIzzSk4/FlSo6NOBpo2ky+6mZ6xY/U9Kw3N89CvfJTo3oruxl4qwuzrN5igGZxfTFTiklvMss6Y6CPw4ZaskPP20IXV3GOFWOwO4xKYrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cq4JAETc; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3f8d2180feso6401366b.1
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 13:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759350520; x=1759955320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+vx5hdGkahy1NQamogmVtVf5yuP6YF2+NsatonLX9Rk=;
        b=Cq4JAETch3Ja9gyGU51OUW21+iWbkyzBoXxGXMvDNCr4hiHCv6F9a/qBlU1K+vDsmW
         Gcij4MI56wnyelbiwiCWxyfWucJT3M2kPN5LF5Unf3OJtOGQSeHSRYT4+objcj8R2pmc
         t4QWUGdyW6SkUwulWbdCP6qgvC+OtlzYDBpAntbVMVXj04r0iRCmlXvtnXUyGOgkSyL9
         fBu+aUYVSgnn9OgLuF+EkYZGxTmubd0ridWIM3+erpxsuXDzQ6hNA7WJ5YBbgDEu8ouu
         rLDuzins0N60VaS/Na4nQch+zccwWv+TVmJFSzaghoD+XmgwT9CHpDnhhxgU432joNBZ
         6tmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759350520; x=1759955320;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vx5hdGkahy1NQamogmVtVf5yuP6YF2+NsatonLX9Rk=;
        b=dn0uh6t7waLbmKQDtJw6DMCwvVVmPOFZ8Ydr8GLbmgGsXEBHBHiMB1B1tnwSFs3C3r
         AMQ+c4MKUGoalo4tzjIx3PhoudOTk/M/fcRgpavVGpwpq/N//GfUTKxqyiZcVa/4qF9F
         iCgHkFLepSaC5LLAzg7RTFibtcpft8/rFfyzytfxYqVUdLSYY3fVLse5NzZzwtmPTmDN
         KMSuK3kNRth7My0/KAv333sCyPLCyCbndN7V4zSi6I3u9kbYwPRTU3feogXX79pSF5ez
         kwyFMzwHTbwYkXsLizByXnleZhCHLr+v+6NEqfzygX6QHSTdoJ3h7PmzGtIHFPdrV10l
         QQfg==
X-Forwarded-Encrypted: i=1; AJvYcCVSwNLx2md1yklJ6GB3ZgAOMiOvBWzNStUXwzdEhr1HE5wVDkMU/wCQR78vvrzDBj2gpAS5GY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBsMU/tMV3A3Qf/YlXM949S3Wy9i+0YjC3gcwi1t19M1X678sy
	1Qg+ue74QGkPMLnnv3b9ZbDPX0PoGLqSVznIX3s0zPLKrwiKwHTpn+h5
X-Gm-Gg: ASbGncvEuwr8qJyF6Uf5igCT87RKvfwK4rebRpdQk5CtGwLSiU38/OF1BeF6Y9x2I78
	IY4f5GNj0MS/KQyA+HI54cqp8Vft+S6lce7GdPD3cua7ylm+iWssbune1nCtFK0QoqvCASam43d
	LtAjwE9twZYKNQ2hCXbYmYYzbNCJ7gn96il1tfXGj2Snr4V/G6gLLrno92kgHWdn5W+Iw6ZArd7
	hmlUWqI29gwZvBgKrtwazVktSt9+QHJg3tKLYQuNBX1ZNSUu0cCCtAV3JBoOoKoW0myekLUoWgP
	6jhGIuBrwQYKs9oR6wGMFVB1WwDSLZtvZY4Ug2qw0jOWlfQWDJgdEBCqi5TjddsGupRPbFfDDfI
	Y1IwX6EMtx6QyDpoeSdEmKlUnaRH8wc+Rudh/NFhAlQ9dWR3fQeH2Wq5svH1aJDw2eLU+3g==
X-Google-Smtp-Source: AGHT+IFypxArnR4xsqK1PVKw3BTncFOVNbk0EzgLn+bv/Qi9HndoSHc9qYacyAg9i+F0I7m7EgQ4fQ==
X-Received: by 2002:a17:907:7eaa:b0:b3a:6c29:3552 with SMTP id a640c23a62f3a-b46ea1277b3mr326729366b.8.1759350519925;
        Wed, 01 Oct 2025 13:28:39 -0700 (PDT)
Received: from [192.168.1.103] ([165.50.124.97])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b23csm40909366b.61.2025.10.01.13.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 13:28:39 -0700 (PDT)
Message-ID: <581decf0-d360-4da8-a247-3b207d5ca21b@gmail.com>
Date: Wed, 1 Oct 2025 21:28:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/bpf: Add -Wsign-compare C compilation flag
To: Eduard Zingerman <eddyz87@gmail.com>, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, linux@jordanrome.com,
 ameryhung@gmail.com, toke@redhat.com, houtao1@huawei.com,
 emil@etsalapatis.com, yatsenko@meta.com, isolodrai@meta.com,
 a.s.protopopov@gmail.com, dxu@dxuuu.xyz, memxor@gmail.com,
 vmalik@redhat.com, bigeasy@linutronix.de, tj@kernel.org,
 gregkh@linuxfoundation.org, paul@paul-moore.com,
 bboscaccy@linux.microsoft.com, James.Bottomley@HansenPartnership.com,
 mrpre@163.com, jakub@cloudflare.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel-mentees@lists.linuxfoundation.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com
References: <20250924162408.815137-1-mehdi.benhadjkhelifa@gmail.com>
 <fbbeeee096dc14332c50b1086b2089f1b2f496d9.camel@gmail.com>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <fbbeeee096dc14332c50b1086b2089f1b2f496d9.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/25 9:23 PM, Eduard Zingerman wrote:
> On Wed, 2025-09-24 at 17:23 +0100, Mehdi Ben Hadj Khelifa wrote:
>> -Change all the source files and the corresponding headers
>> to having matching sign comparisons.
>>
>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>> ---
>> As suggested by the TODO, -Wsign-compare was added to the C compilation
>> flags for the selftests/bpf/Makefile and all corresponding files in
>> selftests and a single file under tools/lib/bpf/usdt.bpf.h have been
>> carefully changed to account for correct sign comparisons either by
>> explicit casting or changing the variable type.Only local variables
>> and variables which are in limited scope have been changed in cases
>> where it doesn't break the code.Other struct variables or global ones
>> have left untouched to avoid other conflicts and opted to explicit
>> casting in this case.This change will help avoid implicit type
>> conversions and have predictable behavior.
>>
>> I have already compiled all bpf tests with no errors as well as the
>> kernel and have ran all the selftests with no obvious side effects.
>> I would like to know if it's more convinient to have all changes as
>> a single patch like here or if it needs to be divided in some way
>> and sent as a patch series.
>>
>> Best Regards,
>> Mehdi Ben Hadj Khelifa
>> ---
> 
> I don't understand why this change is necessary.
> Have you found any bugs while doing this conversion?
> 
> [...]

Hi Eduard,
No I have not. It's more of a future proof patch / improvement rather 
than a fixing patch as i mentioned in this email[1] with more detail.
Regards,
Mehdi
[1]:https://lore.kernel.org/all/e3a0d8ff-d03d-4854-bf04-8ff8265b0257@gmail.com/



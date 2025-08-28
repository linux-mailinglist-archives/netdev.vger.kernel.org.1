Return-Path: <netdev+bounces-217734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B25B39A3F
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49EE37B77CA
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4462E7F30;
	Thu, 28 Aug 2025 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYgngK8p"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B073830C61A
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 10:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377326; cv=none; b=pPbGbQTvlyXD9eUXUZW5OScCmHNPn/N9eJ0l44hhUgzwejghi1aJ9mtG17VB2vFZTWTTKqQFDEIKGmjvxayNAfNN6yxyFvkVSDspV7Cci5973S7Oi0YwvsP7yoomP0CG9VlDLba5Opq4/4ejUCKMNs+Fm7zoC421eUIUIgtiDuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377326; c=relaxed/simple;
	bh=YBqvM7XD9rhPf/QZIHMHzzRfeAeDBLeryJu/pKtxx0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A4gzpi6lejRX303gP73HP482z1b1Vc2yby8qFFkC0xKk344DNrdgqFkAnNqZrq2fOa5WeLIFYEL+cTMN/Iq9qz0Shaam/Jx8RaZD/Z+Y3oZ/f9Tmp2SqulqwCm7BfBVPOwcTbKUNH7cmgP/lZbdweJhD8h4LwmFXH9BpoyN7WVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bYgngK8p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756377323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C02piPLI6v0W2skD1ryvCSQgX2iEqThf0fPi4OBy2HY=;
	b=bYgngK8p1RSv9x7c5ZJe5KgbttInzEhPraMsJeKnwzi2X+JnU/GNrmUOcdlbbMeBlb7xQ+
	Vu30Op2+at5YFdl8HZ4bKWioJfw98TEze5PO63/KzRqp8JCRJGC//KJ1/vqF4E4IwgLoRD
	l9trL9jCZm9Ly/1YZmrM0jJZNxVoSaw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-wz-5YLAwMx2DHpTvnFcs4Q-1; Thu, 28 Aug 2025 06:35:22 -0400
X-MC-Unique: wz-5YLAwMx2DHpTvnFcs4Q-1
X-Mimecast-MFC-AGG-ID: wz-5YLAwMx2DHpTvnFcs4Q_1756377321
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b2d2cbbf9cso23019291cf.0
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 03:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756377321; x=1756982121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C02piPLI6v0W2skD1ryvCSQgX2iEqThf0fPi4OBy2HY=;
        b=l7JlSPsBjNiRQEalvlznWX22Rbb+31LjLKbWRajqbJUYS+8pEdcN3gBsWwjFwvEkMy
         M35fLnt78XrDOZxnlaNdODPgA3U0jujmUDBAAcoghrOpCTAQNr7DiVcv5CHl63j/iZOA
         1gH0dHIp6Hj0U7q32n/p/7YFgq7XuGiPA48D9PTiMvD2LnvC45lZZhqfPf11CzMjnNCR
         /YgKYfhfTtHp9cGKU5FUWcrDKc8vPaBfbYvVGemwwDWxaiiZhLI19XD0os79EPBu363L
         VBInmWD56kbDKV0+0P6NFx3n0ZtfrEJjdYozZpIGxHr8KHOmpuKjy0ZeQbAR+ypDAvbk
         DbKA==
X-Forwarded-Encrypted: i=1; AJvYcCWdBhNTm3dMiyPuLvAGxUSehtfbmPGuwTTKsUMTwibmRcSPowNNeBnDbBgIliKEt6oU6R6k7SI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywEPEU+03DAyTvI32WucJKbCldath7fRzX3wazl5nvSg96ILhV
	JHcYHErprSGc62GspgbuArYdyYFERieH8/I3/Ql+K/+B18P1M6WyXMf224nFGxreZ94eHkqhADX
	lvno9zN3C+z3PnLFo+huvjey5xz0VuTTYLtLWV4B2eActbk2DFKW6Y5BUEQ==
X-Gm-Gg: ASbGncvRSxbjbVHLqiUw24x88z5KyWM5Uk13TFY71FtT8rUXtiExHHwVeNNsasCQ6g0
	mFAZtMJ2MwfaZse+/H/GFirGLoTMNwh6PnjH4YguAMQA+uc2GN4eGKyKp+BfOAHmAsDEHDancIm
	a7Q+S6c5SWmkl+SEzw2+2Y05TbOe2dpWw6sctXVO2uvDTyGoJODanHT8bovwtO7l4Hn6P7ktfHO
	ptcF/0nsum9ybPtTn+Exn7x5ksimE8fC0ZS6BoLjsIalI20Bcwo/trYXQYwFWTldrby7pK1bYkM
	mC7OY01IDcxl040gVOuaUXJKtm9O4AHG0NzPeUcDscuHb8HrTVWGU3c0JW29kxFHxyF2xYbbwpT
	khRmtdjtQc/Y=
X-Received: by 2002:a05:622a:550f:b0:4b0:7cb2:cec3 with SMTP id d75a77b69052e-4b2aab47d61mr372948851cf.38.1756377321372;
        Thu, 28 Aug 2025 03:35:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsh4vekrR3evrfrykNJt1W3/7S1JncvhmesTGIkRdX8pXGCxyUdMsfB9JJjtB2UfPg8BKFAw==
X-Received: by 2002:a05:622a:550f:b0:4b0:7cb2:cec3 with SMTP id d75a77b69052e-4b2aab47d61mr372948281cf.38.1756377320714;
        Thu, 28 Aug 2025 03:35:20 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2f52f650asm27706631cf.28.2025.08.28.03.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 03:35:20 -0700 (PDT)
Message-ID: <7090d5ae-c598-4db5-a051-b31720a27746@redhat.com>
Date: Thu, 28 Aug 2025 12:35:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED][PATCH] net: ipv4: fix regression in
 broadcast routes
To: kernel test robot <oliver.sang@intel.com>,
 Brett A C Sheffield <bacs@librecast.net>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, netdev@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org, davem@davemloft.net,
 dsahern@kernel.org, oscmaes92@gmail.com, kuba@kernel.org
References: <202508281637.f1c00f73-lkp@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <202508281637.f1c00f73-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/25 10:17 AM, kernel test robot wrote:
> commit: a1b445e1dcd6ee9682d77347faf3545b53354d71 ("[REGRESSION][BISECTED][PATCH] net: ipv4: fix regression in broadcast routes")
> url: https://github.com/intel-lab-lkp/linux/commits/Brett-A-C-Sheffield/net-ipv4-fix-regression-in-broadcast-routes/20250825-181407
> patch link: https://lore.kernel.org/all/20250822165231.4353-4-bacs@librecast.net/
> patch subject: [REGRESSION][BISECTED][PATCH] net: ipv4: fix regression in broadcast routes
> 
> in testcase: trinity
> version: trinity-x86_64-ba2360ed-1_20241228
> with following parameters:
> 
> 	runtime: 300s
> 	group: group-04
> 	nr_groups: 5
> 
> 
> 
> config: x86_64-randconfig-104-20250826
> compiler: clang-20
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)

Since I just merged v3 of the mentioned patch and I'm wrapping the PR
for Linus, the above scared me more than a bit.

AFAICS the issue reported here is the  unconditional 'fi' dereference
spotted and fixed during code review, so no real problem after all.

/P



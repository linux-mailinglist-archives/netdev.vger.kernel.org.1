Return-Path: <netdev+bounces-234330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF958C1F79E
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 11:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4C7F034CA02
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F31F33B955;
	Thu, 30 Oct 2025 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iuBmItiB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00323164D8
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819356; cv=none; b=bRwHSFyGiZP5aZPi6WGWTY9GA4dRZRx81tWPo8fS6b20WVNzhteeSMSax71oChMKoWfZjfviLFhZaHeuOVCiiu4mtXbIl5LyVcR6eAjhvnv6Rs5ODSPB6j3OXADfb1GtnxhX2lfHNSrudrNc7U6H1go4bLzC60QX7508IwI1hWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819356; c=relaxed/simple;
	bh=HwuBL7/j8iddX6AaVhQYYIFhCQoJyE/42FRGYgfEbzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxXU0bKYBEV1NdqWEuabKjGNUhOEdOjv+LKRQEKvE0acvfHyhj8xJsorWi8Byd+g/MluXTWe2dVDLhk6i7C3+xUAm2r/CjCrjdN1lgOPYHXf3jEURAZZzGsdBJ/zvCCsB01jGZlQVysk30xFJMIZb19HcxyPCVB6UQH9WyQ6xPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iuBmItiB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761819353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bOlCRowd2cbEJIalDQ+zCUHAgo4uy8C8YJgtAhPsurY=;
	b=iuBmItiBGExQqtwFU2sN6ljWYVN4O5301yz4O3Lic6xX0w7A0Gvqqt529dR8Pwhrcs/k0z
	3e+6XlmRcgIMCckCWakkYPQDMQrD2sbjMGRNOviwuxkmo6tHm2nBGovZxCIEKCGcLzZhBk
	IMGzbrVYskdZy+0wdgS1Sx4orZrQvLk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-D0qlzfo0MMu71SQvbCp8zA-1; Thu, 30 Oct 2025 06:15:22 -0400
X-MC-Unique: D0qlzfo0MMu71SQvbCp8zA-1
X-Mimecast-MFC-AGG-ID: D0qlzfo0MMu71SQvbCp8zA_1761819321
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-476b8c02445so8463625e9.1
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 03:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761819321; x=1762424121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOlCRowd2cbEJIalDQ+zCUHAgo4uy8C8YJgtAhPsurY=;
        b=w/CxYnx4ODQnGyvTYbo//L4q7/mWPnes215wsZuD/fNqoHCqD+b58QIuIOmSas4iGA
         DDMYFdZfSMsI3NvHwu51J2BHZwrfazSuB0E05m2DiN5TtBQ48mTTlj+pbFs6k/jTx3yH
         Yt/FhmToklPsYj5V0S06PS5KzWLQnqhzEHSVJb3bR4yTQOZcOa7FPInA3pNc8bGBGqMg
         xkBjPmH1XPA+v8jNfVbpmlTTAPvJe580rrsWWGz7dj01dx5p8LcOmF5mcvRyyhxf8TOe
         afUlEN+MSs3alQArSt+Gyu3RT6VK24XiVJGIVmx0IIibx9G7jzx0G4JUkgdGAKB1Ajt8
         V6mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUogFl2veE5Q//pw4rsnctgR1ghQAt4EH4nO+HnpA31w/vp3oM2mHQ4uw+PgbEYqi+3xAT1+rU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSKZMu8rm3qRZ2V+4Ee0Rvs9b8wsCChRabUuxzZKjtvpfmsJ4u
	9oncYk124h741ytAejZij23LA+O81kDayh+wHuuEJbq+tcBw1DoHLqdRsaJyYQJTMhu2RP5Q1x5
	v5cIXss8kXtSTCtO1xPcyFsv1mGuDEI+y5+RjxnqpJBrc5mqmafg8z9ptWklp5FmXpQ==
X-Gm-Gg: ASbGnctkrywdm2lCItxN3PpSH6tZzDuAQdz3Y7e1lWZdejmqEdvM3RwD1DKMximoa9O
	RKloROuu4T/LGStIU+N9PO82wzAAqCj4+URjWvA0Xl+j2I+6te/lf5wvcnA/9pboAuP/lR5Wxb1
	GBrtpQ1PHN3u26lHjcx7bF2i9jnUFeNC9D+Nd2Sa43xjJzbXgTsIG3cPTFhg2yK02RybgqWfkLM
	LbuKLAa5ODdfuTxF7BYbzlJqFzQjSiQb8kQaa6jTR1qxxAPHJZH3yagxNSV+ldzNSw1RsnFQBtH
	k3e8enQj0dkM0JVOSBtoY5JQJag40HIcKjNCvbi6z7bVa2o/fBAzvomBl5micI+dIRV2ZnVeJVm
	2ZA3fO9/Ws5mq03u/15Z9PcGypgEKMInhK7Cag1kGGHxc
X-Received: by 2002:a05:600c:35c3:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-4772684f823mr26611995e9.34.1761819321144;
        Thu, 30 Oct 2025 03:15:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyPrpvB9n94QmEp5mdsdi+Ry3jLFqF5DP/uud3K/QL/6/hTmUd566gZ2nFWiXbJf2cLc4FZA==
X-Received: by 2002:a05:600c:35c3:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-4772684f823mr26611665e9.34.1761819320702;
        Thu, 30 Oct 2025 03:15:20 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6? ([2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772899fe36sm32094485e9.2.2025.10.30.03.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 03:15:20 -0700 (PDT)
Message-ID: <54d1ac44-8e53-4056-8061-0c620d9ec4bf@redhat.com>
Date: Thu, 30 Oct 2025 11:15:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] xsk: add indirect call for xsk_destruct_skb
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 joe@dama.to, willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20251026145824.81675-1-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251026145824.81675-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/26/25 3:58 PM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Since Eric proposed an idea about adding indirect call for UDP and

Minor nit:                          ^^^^^^

either 'remove an indirect call' or 'adding indirect call wrappers'

> managed to see a huge improvement[1], the same situation can also be
> applied in xsk scenario.
> 
> This patch adds an indirect call for xsk and helps current copy mode
> improve the performance by around 1% stably which was observed with
> IXGBE at 10Gb/sec loaded. 

If I follow the conversation correctly, Jakub's concern is mostly about
this change affecting only the copy mode.

Out of sheer ignorance on my side is not clear how frequent that
scenario is. AFAICS, applications could always do zero-copy with proper
setup, am I correct?!?

In such case I think this patch is not worth.

Otherwise, please describe/explain the real-use case needing the copy mode.

Thanks,

Paolo



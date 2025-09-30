Return-Path: <netdev+bounces-227316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D4BBAC3B2
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 11:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E674321636
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 09:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DC42F6194;
	Tue, 30 Sep 2025 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkQTqxgI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CC724A076
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 09:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759223769; cv=none; b=uCcMikjk9eD2/RFP18Wl+d9zMTxNn5x5/7OY5aHqzKhDd4n3TVdWzCljFTm28YR74GaFHw06okUo1AkhUutxL1ns70fr82kw6gVSWXtalfVAGx6V8QsEvNOzgl/XsdVRYr8GBzFq/aPQL9Pu8i2JH0ZhPFcVQqNcc05Uk+V0S0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759223769; c=relaxed/simple;
	bh=DhVxX6nOFn/AJnMi25R+uMYpH2MejrrzwYzAdY7Psec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIp9eoMAd2qsQ6230tBbIS3E3hDVy9Ew+oq1dCXFpzDr+3HmrQKNy45MOCqb+XV1aGO13zLHaHRgPDyqBJveaXI7zGXGG0jd35hp+DMVLAGR1Nr1kL+EGFjkxYihCyaiAgYpnPX9WTgVZ9LLwBuZoHvgbBjC/RVRQ+L4k6X9Z+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LkQTqxgI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759223765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5mzLW36l3vHTN0xGG7e1jWdQ3WYx1BRHAB26zy8eZkI=;
	b=LkQTqxgIhwdpZbsWv35ulst7BFzko5Hw7MmL9g/Zm4dvhrXsd2D8CZPnMBw3bEgKEZSfh5
	h+a1oMQ7AuuEpqbNdFydscd12/60RxUFJ5UlNVKuj5KQ4bcZ9MbEJAJN6B53HNcB8gWVVj
	7FmaIsozkp37AsBBXPLlI1KNwqwilZM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-iDoCgkyzNXSp5oYbCkKHVQ-1; Tue, 30 Sep 2025 05:16:04 -0400
X-MC-Unique: iDoCgkyzNXSp5oYbCkKHVQ-1
X-Mimecast-MFC-AGG-ID: iDoCgkyzNXSp5oYbCkKHVQ_1759223763
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3f3c118cbb3so3693331f8f.3
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 02:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759223763; x=1759828563;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5mzLW36l3vHTN0xGG7e1jWdQ3WYx1BRHAB26zy8eZkI=;
        b=TpmbRl2Tyqm4ziaxIHLpr7YHicSmGKgZzbkh/4fVAyTVche75lHRbOtNTNPgf+Fw+b
         4xmIcj1YzUm46Usd4gWjZUYenebPaCHg3pakd/y1jdntvUi1XM9OCfulp8h3VS+cyjzu
         AuOcRsK/mWPQ87Ma8Ka9Ruxdp9gqsBbxvTGboe2vlbx8l5w26HZ1YZ6/tDCicYzRyKSh
         M05BkT0D2IcqJqRHBZKwjO3/beWp2JEeTHhz2FEPRSCW+iX4HcHZ9nMwxI+Y4NXdcnQX
         E+tAEYFJYtlD4IFBMHWmBwHzqoDDScgNhn+quysfu1y4xjklIFW27d+0l2IooO1WvCXr
         k2cA==
X-Forwarded-Encrypted: i=1; AJvYcCVRPwfrpLGmrHUnlcNH3CUHXNr/MHNYfXPWeyE0MsqAPziVjRkScMXotiIKl6V8DuLq12yMSIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2PNBsBRH+js3qf7UiO12mLcvL3tdSYsvBXu9SGaONbslYMmoU
	K3e8sTLrKZKY7+YdtQTCv1DyfeJBZl6DrZ8rFlqAcet1GBSkwA13aRBOQW4tYjT8KYcGOOtJT9G
	3A9MMh9ybrUberDdkjJu7UX8fgcVMfISCkEpYdAnzRxjwysVvNiH1iDVONQ==
X-Gm-Gg: ASbGncuUFTi/lyEVL8JN8XZB0QImOpmE/rD+NkQwBEnXaKj531Tgl/Nn233RhwcnEEa
	5WNEfY/LCdeXflW3w95RWWuaTlkFFOduH4di9novbhjmmysNa2Xtqrl1exjKgdB6GWc91zTLVCw
	pr46zO3RLIp70Q9RBgST/xzUsHTf7Hd/R6oohV1xjVutbhPob/cINp8HKv8oVFvUTCnrTPc2WjS
	WB7nLFe66MSczNlQ5df/exoOhurLgRbOBAk3Di9taMN5MORho5pdj8JTjXLas1hFvEkhBgHho6h
	ao1X+/K2TW3tUlXZUQ/dV+JJ6lFeJY60+ojs+4CjJi4696jf8NfIo172OaMTSFM+HSBOg7zzNwN
	pHhN2VkxWVrTe+iizlw==
X-Received: by 2002:a5d:64e8:0:b0:3ff:17ac:a34b with SMTP id ffacd0b85a97d-40e499acbf7mr18158161f8f.42.1759223762677;
        Tue, 30 Sep 2025 02:16:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPJYHsMgzyYX8n1S+NMBgDuxjdaGhUBWCQvgO9dlxbt4WgqHiEtGqYpfzNw/zyFhzKp+42mA==
X-Received: by 2002:a5d:64e8:0:b0:3ff:17ac:a34b with SMTP id ffacd0b85a97d-40e499acbf7mr18158140f8f.42.1759223762234;
        Tue, 30 Sep 2025 02:16:02 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc82f2965sm21712072f8f.55.2025.09.30.02.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 02:16:01 -0700 (PDT)
Message-ID: <f64b89b1-d01c-41d6-9158-e7c14d236d2d@redhat.com>
Date: Tue, 30 Sep 2025 11:16:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 1/3] rculist: Add hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
To: xuanqiang.luo@linux.dev, edumazet@google.com, kuniyu@google.com,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: kerneljasonxing@gmail.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
References: <20250926074033.1548675-1-xuanqiang.luo@linux.dev>
 <20250926074033.1548675-2-xuanqiang.luo@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250926074033.1548675-2-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/25 9:40 AM, xuanqiang.luo@linux.dev wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> Add two functions to atomically replace RCU-protected hlist_nulls entries.
> 
> Keep using WRITE_ONCE() to assign values to ->next and ->pprev, as
> mentioned in the patch below:
> commit efd04f8a8b45 ("rcu: Use WRITE_ONCE() for assignments to ->next for
> rculist_nulls")
> commit 860c8802ace1 ("rcu: Use WRITE_ONCE() for assignments to ->pprev for
> hlist_nulls")
> 
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

This deserves explicit ack from RCU maintainers.

Since we are finalizing the net-next PR, I suggest to defer this series
to the next cycle, to avoid rushing such request.

Thanks,

Paolo



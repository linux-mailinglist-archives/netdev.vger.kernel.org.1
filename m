Return-Path: <netdev+bounces-205703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC0EAFFCB7
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 10:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00CE43A565D
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 08:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B3B28BA86;
	Thu, 10 Jul 2025 08:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SlSAr/pu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB9C221FC0
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 08:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137179; cv=none; b=Pquy8TaIx2qtiJJm2cLu93PzlSaMGZsRMF3SHlGdGzq5vnWZJNfks9kGWt+AugxL7JDyzjujq8Q7C6k1SWE7de4Epi7dSzbkcdCpZAKRD+aN7OQPLtBzEoDx5qz2OgRMvCUm4R4HRgDtHcsIBXAcz63l8Ewln0/Ac8LRthzQ7ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137179; c=relaxed/simple;
	bh=EztoCdmnN/TXMn+viX2gSXCCexeXv26zbr8Y3UvqK/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWXQV7MxhMCCuCqdZwwVllspQ7F3S96LhvODcbXopdTgwjmMc3J4rYPAHISnNYJT6uFlT0sekJlp3NqUciPc6XuOCg2YRmJZFPd4ov75Lo+jIkGONpRsyHZ1kvppFFkgfJSxye6dupC0EpegJVIs+aZbpG2nPghPNYkIsI46B64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SlSAr/pu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752137176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PcvUi1eWySw/QvrSjzTNvr0wq6k0z0sn5FSsYfU//w0=;
	b=SlSAr/puvm0/C5TDXfXF/wpVMnEmVI4h9SYNSD1kBwmQiqcWCQlYOk1Q/9CH+jj117LuSP
	Jgqx2lncfc6cv9k2RgrgJyUw6GjCnfU45xLaFZhHAZ5kebxV2BVXZxpTOxc4vQyaiNuahO
	/p+QoFd3NvbZ+6AJRmQZ3ePc7c2YLrM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-Wj10dByEP_yO3GAogzCq6Q-1; Thu, 10 Jul 2025 04:46:15 -0400
X-MC-Unique: Wj10dByEP_yO3GAogzCq6Q-1
X-Mimecast-MFC-AGG-ID: Wj10dByEP_yO3GAogzCq6Q_1752137175
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4539b44e7b1so3717705e9.1
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 01:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137174; x=1752741974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PcvUi1eWySw/QvrSjzTNvr0wq6k0z0sn5FSsYfU//w0=;
        b=X81pG4oorrF4lCO1ULtlHiO2hC1kol+gYVKNA60BDDARf1eaVU/qHYiVssUcyJgETe
         4i1ZSmH7YdhVwy3SC7P5gwMGg7Qw7ybG+RmKfAhwE3aF9s0LIsGVFLnMvZY8G5iUwnFK
         hEi2B6XV6Vui1WIkS9Uk8kXnQ5F/Y+0TppTsM/0ixD0fSOgTSpjRrw7XfaYMWryBV/oq
         QxEEpyi6baoYgZWPJK8+8S/D5BfyouLg4kVJaZKnT50sKhjESE7sH95zCswy281gBvic
         1J65jXdbAY98J14czyZB3uaelWkHE4/meqYsAFii1qvMLvqdCJzN8rhD7WMFIifxreuw
         tdAA==
X-Gm-Message-State: AOJu0Yze3GJ88Z0ydq26e0e1zPqqbAp5eGkI14CLXBoAW0yMShTisEDS
	PSUY+bVa882yHz9Y3vOgsI142yOJ27GGMu48L2UuekWAiqjvOPTdZmLaL9Z/W64qlE/UX+kmrEP
	C9TY0kmk0qLzcp1kz7k8tizayHGhIRMb055dpRqRHwx3JUgvOskZt4m7yQ/Nh4arocA==
X-Gm-Gg: ASbGncsYmPmRxpBPb6agpyLAEKWM+qJwm5V8WE/BrXWAy6slnzoSPBWFLxg6xh6GTGh
	D8G5KT/i4YK/RAAKzXLgnCOxt3/CLqbnbV6GET9TSPQ9CIW17+hnjSxm1AMQPlKCAZAqPcVuh1g
	5Sx7MoYLhzoN9wQ/Ln3xWUUH1O79yB/VdWe65jdeT4p7i5SixjHwXgZOdlPXxJQtHYlvwvdiJwT
	vXn1anxNf6Wvzz5+nhHmRt0Mcx3FYY7LKiIuhdYg6aSW5xTBTQf0KgYdR2NOCP8roPfURmlS5AZ
	f9Al7DdzzMpBgHDwL9Eb2xKYHsh5w84BcBoESsWqAiqP9zNClDYlY9i6YDbHZSCDXouh/A==
X-Received: by 2002:a05:600c:3484:b0:453:b1c:442a with SMTP id 5b1f17b1804b1-454dd2da8e3mr16078175e9.27.1752137174105;
        Thu, 10 Jul 2025 01:46:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH9XyxMXdYoZpn8IIlQVwQGwj+KmG1H3Io1MO0RxQQcPIweg50djQVKai1ZJSnE6gFubwUIA==
X-Received: by 2002:a05:600c:3484:b0:453:b1c:442a with SMTP id 5b1f17b1804b1-454dd2da8e3mr16077765e9.27.1752137173686;
        Thu, 10 Jul 2025 01:46:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271f:bc10:144e:d87a:be22:d005? ([2a0d:3344:271f:bc10:144e:d87a:be22:d005])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50def1fsm50985345e9.21.2025.07.10.01.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 01:46:13 -0700 (PDT)
Message-ID: <a965baaa-c4e9-4d99-9143-466b11bc19f8@redhat.com>
Date: Thu, 10 Jul 2025 10:46:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: net: Convert Marvell Armada NETA and BM to
 DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcin Wojtas <marcin.s.wojtas@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250702222626.2761199-1-robh@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250702222626.2761199-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/25 12:26 AM, Rob Herring (Arm) wrote:
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 5d2a7a8d3ac6..741b545e3ab0 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -21,6 +21,7 @@ patternProperties:
>    "^(pciclass|pinctrl-single|#pinctrl-single|PowerPC),.*": true
>    "^(pl022|pxa-mmc|rcar_sound|rotary-encoder|s5m8767|sdhci),.*": true
>    "^(simple-audio-card|st-plgpio|st-spics|ts),.*": true
> +  "^pool[0-3],.*": true

The 'DO NOT ADD NEW PROPERTIES TO THIS LIST' comment just above this
block is a bit scaring, even if the list has been indeed updated a few
times. @Rob: can you please confirm this chunk is intended?

Also I understand you want this patch to go through the net-next tree,
could you please confirm?

Thanks,

/P



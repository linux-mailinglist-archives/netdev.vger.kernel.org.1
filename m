Return-Path: <netdev+bounces-212878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3093B225A2
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 13:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E254B1BC06A9
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 11:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0022ECE9B;
	Tue, 12 Aug 2025 11:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SyqkqVXD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2D02ECE9C
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 11:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754997176; cv=none; b=GTGOHQoGHdnS9ES2csSAcrBs/u2CGVOHoK9BjSry+RL3szcVwVyz2DjJlULVChMFoWuQ4V7q7NqeoTcip4pKPq4ZX7qMpGvu4Hj42th0nsSoAobi4OUtevz7YFcRvabKIwuGLpCpOrMAv+tId3HU5zhJxEu0tbx4nnYC1peTesM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754997176; c=relaxed/simple;
	bh=mAvVdXFly3RzYhUX9cv/kny4RZRWhC1AvwC2a27uNmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lqXf2IyOVVhp32wUL32BQCMRvlpkDoNery2NnhJcfA4XZPcti9AfE6XCAEWFpMPlW17HNOc4fiIWF8XdQ2rty/1ltbKJl9PhiMBvrg/aIRRVIUov0pR4v08f3rU+hErK79BrbA4hBG0xcS5tyukiVUa5hsvqCVymLeMvU2DpQ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SyqkqVXD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754997173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//obXwMFuZhQYhGTHbbzXxbGp1uJw0doBZ0Gzmkr8to=;
	b=SyqkqVXD2Whn/B5uuwSyAEXc2GW7WJKxP1noZNuXqZ03ZlVdIvrE4286j4ctpI02+UgNbs
	LxVJbj029KpbsQoLY4y8635MavYiMYeVOkXXagNCO0YJp8prsTGZXyyVS2geyk36uPTcdq
	rN7TK6IJVDArQ6eUUeN7rzsLqIo/+BQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-VSdSqKK3MhGyVJunLp9v7Q-1; Tue, 12 Aug 2025 07:12:52 -0400
X-MC-Unique: VSdSqKK3MhGyVJunLp9v7Q-1
X-Mimecast-MFC-AGG-ID: VSdSqKK3MhGyVJunLp9v7Q_1754997171
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4af210c5cf3so213089641cf.1
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 04:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754997171; x=1755601971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=//obXwMFuZhQYhGTHbbzXxbGp1uJw0doBZ0Gzmkr8to=;
        b=wAvj7y47Huqo2PMHOyXFc8q8LyoevV50j5vl/UOq8AlylsKtqTz4guADq/TkKllUU3
         cMe3TXMvFSVkRRJelMnsCZmWziFlZK/eklkYx9L+gTLlowli+7+EGua3D80wampcifS8
         X2i2l704xkqNJhynhgaC68gLK/Ave8YRTbMYfxfRbQlcE7vkA2DuVSXcNBLpKCLUlEcu
         ECHe1bCzzrFhbTJcyeCMUVDQETYTkPiZ+mEZS4VRHZiRBtZp8MfPcptWs4hfjXQKfsbh
         AQzkNi/R9wBe3EIhOL53TycjjViuDRYRCDCtLNnc2UKvQJHQ41dtoRtn0Tmt4X/rbSJb
         wgyg==
X-Gm-Message-State: AOJu0Yy81+pDG8qKR9MN/EgRP3xSCcWSMRYUblk+ABMkJoWYFkP/V5bF
	ZhNApqaZVQqNrtVkRFHG8JR3+U4snpW7afMYC2U3kvV9nEl/wffwCP6Nbf/IJuVv9mDJ6SDSBBU
	DNh41NYVbJaJzVploZY8SR0S7jN6WxqVCrqWD5HH6J2Tb889awZQE8BNlaA==
X-Gm-Gg: ASbGncvF5OF5filGumXeYx/1tYEim/0amvwrXS0QdGXPS9DyxWedlnqpQBvXvSoh2Ay
	OJ6Aqt2HNa+O2GJA1kKwNmQOK+xkcl2rPWv6W6dzRRehhd+ggRjGmkGaqlZGkYsfcAEwfaaVtkk
	1OdXVZBFfpn+pZtOfCRB6+pLsbGEnr2vOOqN/up/PYa8Vny8D6w5av0+Ff6r+zMyf8t15ENkrG6
	nT2ZmbYHFwUjSbr0bW/uKUaC/DPxhtDNI2bei8byp7zTvdPoTzvN1VPheScnpYAzgf6hfuVDj8s
	D3pJ87chL3jScQQdTNBDIslMSiSuaUe1TL7+UFwsl+Q=
X-Received: by 2002:a05:622a:1355:b0:4b0:6e11:c38d with SMTP id d75a77b69052e-4b0ecbe7076mr31187821cf.26.1754997171409;
        Tue, 12 Aug 2025 04:12:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb+GnezAp313Oe/VC6buWBT5Gei+SEerxd7EbVFtjv+1zgncHD2Qh7dygE7luAX2P9hrw08w==
X-Received: by 2002:a05:622a:1355:b0:4b0:6e11:c38d with SMTP id d75a77b69052e-4b0ecbe7076mr31187401cf.26.1754997170894;
        Tue, 12 Aug 2025 04:12:50 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.149.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b06a86735asm120286161cf.31.2025.08.12.04.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 04:12:49 -0700 (PDT)
Message-ID: <7c011a2f-cdd8-4aed-95b9-d8edb31478a7@redhat.com>
Date: Tue, 12 Aug 2025 13:12:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: drv-net: wait for carrier
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, shuah@kernel.org, willemb@google.com, petrm@nvidia.com,
 linux-kselftest@vger.kernel.org
References: <20250808225741.1095702-1-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250808225741.1095702-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/9/25 12:57 AM, Jakub Kicinski wrote:
> @@ -48,6 +51,19 @@ from .remote import Remote
>                  env[pair[0]] = pair[1]
>          return ksft_setup(env)
>  
> +    def __enter__(self):
> +        ip(f"link set dev {self.dev['ifname']} up")
> +        wait_file(f"/sys/class/net/{self.dev['ifname']}/carrier",
> +                  lambda x: x.strip() == "1")
> +
> +        return self
> +
> +    def __exit__(self, ex_type, ex_value, ex_tb):
> +        """
> +        __exit__ gets called at the end of a "with" block.
> +        """
> +        self.__del__()
> +

pylint is doing what looks like a reasonable complain to me:

tools/testing/selftests/drivers/net/lib/py/env.py:65:8: E1101: Instance
of 'NetDrvEnvBase' has no '__del__' member (no-member)

/P



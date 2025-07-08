Return-Path: <netdev+bounces-204921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68388AFC8C4
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 12:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54A618913B1
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 10:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B3C29A9D2;
	Tue,  8 Jul 2025 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOgprKRY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952EE285406;
	Tue,  8 Jul 2025 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751971583; cv=none; b=ol2Qt0XLvc2Jlk3kLOmOUVSoX0eIXSuaG72zGn/gCIlur71hBjXE23HFU8lK8kaKtmZrI+3Wl6RuLnQH+2viW9rT/iexDzJunpWCXMhFpfYFuKJb6+GhULMnBb+iSpS+D346y7SEkSyQN+Kt6SkqAb2zc+7hIQIL8AffLjjB+7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751971583; c=relaxed/simple;
	bh=ttQdL4tyQurb7Z1wSbCsRxZJsqZPUc/X/CgglrwIu14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTwgpqY+pf2qp4Jmo0QfaWQv2oFVFasUs5iXwUaC3xl1N0rIhjIzsYVYZcsbMc5S6D21Nql/sDCG0kGa/cqlfSF2STDLuY7CtrYV9kQeNIAbenLVNYzs51909f4ppmEGJIjqVtAxzqwe3gCZWhZjIPay5+k112RZiSNN3WuvGoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOgprKRY; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6097d144923so8635862a12.1;
        Tue, 08 Jul 2025 03:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751971580; x=1752576380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bSzcIEqfBflq6COaUtvcLoPgJp3tB4sR1/TnOwFihkA=;
        b=SOgprKRYqIpbW8DXPVRJdagcwxSYNWGoMEJj7hwwBVXxlVM13CGz8X5abrJBEEXO+5
         nN+WPOR+lqVeuw0gKWa/MCBwnl4UwA0vbhJBzIOnlBEvZw8sEDzTa6PlhcRJKqebEEKf
         V9wv6SUeHXISVFE1o2UeUq4M2CXKSw9wc2PRlcA7LnbUUj2mlNmMIVoUPPU8Hhiy0h6C
         6fWaecI9Oe+XC7AtrBcfnIqTgM1LnkAEwK4k7+Cb/B6x8rmVNa0boA2e57CnQHd1WkKH
         kzN3Bx7dhVhmtjkLljwioxpRAH4oZMDUlNk1a1Ya7T7IzdJ6lVdmJ5p4sxvuhjBE/7o2
         Kvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751971580; x=1752576380;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bSzcIEqfBflq6COaUtvcLoPgJp3tB4sR1/TnOwFihkA=;
        b=pgqTBwOj39EEzhZaP/HDDUMGlXLmfUZM/fs7uOOht8ZRYe+wJJfY+5sHrWUnhsTzOY
         f5kPU+Ut6e28B6yzrrwMWdVUy9RlmpOxGYbSJ7n+K47Ms4vIGni/rQ1a/nBvnN3Ied0g
         QzY0aBAlLLGNP+EB5BOpFdZRNxw32HR48NkFU7RuvqEyRw2DPDq6RSQ6uoImFf1Rb9vv
         bZvxSBGI4EvhDf3lAdLktsEzsPAChKOSDoHel38Lqy1JaOeMFp89F+0DqWhm5WhrnXPk
         fPdfVvyGvS3diQS+SWGxsEWdKPnhYVPIi8xKOIc3YU/Lmo9DkZSvH1rm9JfW3Q1HnVSs
         iPUw==
X-Forwarded-Encrypted: i=1; AJvYcCUGQgtEANpyRuwtAoNERW6hCgqTOR5cfy+CJcQn4sypC2PNlhOZUYCMWhY+LrTfdt/f6ACPM821VbyvYmo=@vger.kernel.org, AJvYcCV8qo1KGAmzuCz7fypakPJ5ldELwwVvphdkwSWRZeB/4+3Ga5UYI+kXkFapatYYwn1UQpHrgu0J@vger.kernel.org
X-Gm-Message-State: AOJu0YzUzyMROOEQ7HZ4Kz0sB3e3lAiiZlHvDYI/TVLmWKhmQd9GuL6j
	jfSxxnepH2NRP3QkhbymJKVIlN51tBFHnEYZrMX2L0xCOPgolxiTTeFA
X-Gm-Gg: ASbGncseQxE7FGSKEfGnYXDZAvItTI5uM8hAcCDylH8EBunW9y9hLFr5sXtsb0fOw5D
	o/FZdvr+eo3Gem62Bt4fP7n3WZdl7Rk23GK0cR2W04chOFM+3+BhK2oil8M1/0ZyH6XBazdlH3a
	GYsS163KZB3adkLJvjIGgVMvWPpl3QJ8mihn9BwD3DagS/cxk/Uj8rLOibmqoxGV9utY2XaWH/+
	WW3Hah0rTyf2Rc4Iueof3cDib7G3JrzNX8ygaNWVfstx+sdllk7UTw7ipnIJHyOFFhU4bcfuys5
	R4G7k7bRJYE/M5KBK8K2qlvQ0O4kMpSgt/zgJEhI8n8zJZyjyyR3wNW0AVxVbMYGwN/QXMAJDZU
	=
X-Google-Smtp-Source: AGHT+IGW8g7ypOx9xc5K0Ao5r6G+yDtrL+5c3NK/QrAUPDGwatJ+zP5X+l3M8rjoQKaiPuNFWlUIQg==
X-Received: by 2002:a05:6402:691:b0:609:a4af:ae8 with SMTP id 4fb4d7f45d1cf-6104c079afemr1674355a12.11.1751971579599;
        Tue, 08 Jul 2025 03:46:19 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::1ac? ([2620:10d:c092:600::1:4dfd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fc81a70e4sm6850991a12.0.2025.07.08.03.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 03:46:18 -0700 (PDT)
Message-ID: <edff4079-294e-4428-a2fa-f69bf9578785@gmail.com>
Date: Tue, 8 Jul 2025 11:47:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 1/4] net: Allow non parent devices to be used for
 ZC DMA
To: Mina Almasry <almasrymina@google.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250702172433.1738947-1-dtatulea@nvidia.com>
 <20250702172433.1738947-2-dtatulea@nvidia.com>
 <20250702113208.5adafe79@kernel.org>
 <c5pxc7ppuizhvgasy57llo2domksote5uvo54q65shch3sqmkm@bgcnojnxt4hh>
 <20250702135329.76dbd878@kernel.org>
 <CY8PR12MB7195361C14592016B8D2217DDC43A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <22kf5wtxym5x3zllar7ek3onkav6nfzclf7w2lzifhebjme4jb@h4qycdqmwern>
 <CAHS8izN-yJ1tm0uUvQxq327-bU1Vzj8JVc6bqns0CwNnWhc_XQ@mail.gmail.com>
 <sdy27zexcqivv4bfccu36koe4feswl5panavq3t2k6nndugve3@bcbbjxiciaow>
 <CAHS8izPTBY9vL-H31t26kEc4Y4UEMm+jW0K0NtbqmcsOA9s4Cw@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izPTBY9vL-H31t26kEc4Y4UEMm+jW0K0NtbqmcsOA9s4Cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/7/25 22:55, Mina Almasry wrote:
> On Mon, Jul 7, 2025 at 2:35 PM Dragos Tatulea <dtatulea@nvidia.com> wrote:
...>> Right. My patches show that. But the issue raised by Parav is different:
>> different queues can belong to different DMA devices from different
>> PFs in the case of Multi PF netdev.
>>
>> io_uring can do it because it maps individual buffers to individual
>> queues. So it would be trivial to get the DMA device of each queue through
>> a new queue op.
>>
> 
> Right, devmem doesn't stop you from mapping individual buffers to
> individual queues. It just also supports mapping the same buffer to
> multiple queues. AFAIR, io_uring also supports mapping a single buffer
> to multiple queues, but I could easily be very wrong about that. It's

It doesn't, but it could benefit from sharing depending on userspace,
so it might eventually come to the same problem.

-- 
Pavel Begunkov



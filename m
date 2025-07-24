Return-Path: <netdev+bounces-209699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 920DCB1071D
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 11:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5243C4E31D9
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 09:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE05F258CDC;
	Thu, 24 Jul 2025 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yq+0L+l9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5E62580E7
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753351038; cv=none; b=NmFX7QS2tZZSydqu030mQDXIrvP4S/XANfdHbqqasxUfwBUfgXG3Cl689wc6q2jEKeg3tlsE87HGs+OVsfLawZFN1CPAg6BU4dvcix4xzgsvrg0V+W4JxO+WXs6dPkEFZl191s1y7rntEBsP4Q/7n2KEw2z+dYSl1A1kYUKoaZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753351038; c=relaxed/simple;
	bh=3QN2SPK+xpAbgocIP4oE8AbjkT4UjG+6575GluaartQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iivv6UJ2UOw+vytL1dLbLLglVCv/BddGpwWmZXEl4OeRvnTW2Geua+rrrKN+5dbeZY1OCExSy1LGrn8rQgKRBuNKg5Dg6rKqzyvpDTU/Lhzp631BF+tFIdXan6YdjgmWdNwX9LPmVPTazLmiLgg3i/jC5urZuicxqfyk9MLZ5Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yq+0L+l9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753351036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3QN2SPK+xpAbgocIP4oE8AbjkT4UjG+6575GluaartQ=;
	b=Yq+0L+l9jAQB/k+QE4NBNVmFpRV34zGAF2IjOoSmJL4vsqJ8U8KtGxtQjoJaZ8XdVZeaL8
	59AP6I+rhGX7coO8t1ugw4JZRGNFF4duB0/BUP/kRcCzouwcJH5EozAd4LqxoV0D+755tE
	JfouTqW2gkr1orkwzJeqJiQPYOujU40=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-uo9PCxWeMK2AWoX1L8csOA-1; Thu, 24 Jul 2025 05:57:14 -0400
X-MC-Unique: uo9PCxWeMK2AWoX1L8csOA-1
X-Mimecast-MFC-AGG-ID: uo9PCxWeMK2AWoX1L8csOA_1753351033
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45626532e27so4453835e9.1
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 02:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753351033; x=1753955833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3QN2SPK+xpAbgocIP4oE8AbjkT4UjG+6575GluaartQ=;
        b=u8nmjFdF8ppeDwnHjGAF41qh+cPOux481R/jJ+MA/HIiB0GrYBhAaZK4teidJOGS6s
         529cWVEosCYXV0GRW8z/UUO3Pv3m7sBtlCmbK8LFUqpx//Ihr0/LomUmlumeMNAuZp4l
         t/wU3d2qnrkp74AIj5c5qC7w2XtQys5jKswSKrTRoVvA+ytj0RH01J4RMO1d4Ml7WN0Z
         Ba6xfHBO42WOfsgO6FhuXFJrwwoWn+c4nHNo9urfWCwGHHcRfgxdrQyoHRzxJLo8mIrk
         eTZ2GHY02G3e0IAeaK37IWM3W0v6aJcYbhCShe5yDIr8I7GVuPRVp/WkleFIhrR/Nb9D
         4B5w==
X-Gm-Message-State: AOJu0YxB6Fh3zNVrzHBcJ1m6CYGRCcct0MvGqPj+FlS2vd5eW5YuH7D9
	04riye8IuNoH+CDPbovRLSEN1hWfkeuv2B6GWq76rbkixp38NL+01HRM8FEk21JuA9kBay8JEZn
	o+ITWLoDwev0athae7oYyizuYmHHn68dfrYURXtqT3SxQBXqp4f2gRxVBJw==
X-Gm-Gg: ASbGncvh1k4cfhiP/JmUhSyRwQPRyPdaOhQehVnT1qllhj9G+gHv2+6yACtl5nYDnOY
	ezxiA/8M0yetPmJNzBqUwnFCd9Ccb2B/f0dl6dVfcO/vZjce4J6WMVUNQOLG9kt0dxaEqQqOoyA
	m44iZ8LHC3ssNKUwSN/LAxKRaY1VwHBJGvWzeNMlo/VssVESd0lCHHWCc5I2w1U4C2B2WPK/jb6
	HSkT7RfmFdJ0vFPO2/7j4mS8AEUOceK4REQWzcIZwhE85aC9xDFLA9S7es/E0dd4ZA3FkL/VnjI
	v6zk1V6DRKXEsBSwp4pmOz9Emx0DO2xSLNBnqUJkXKXqjqPYp6Fp2LEWCRAWBf0dvbf2Lo09ytQ
	iMK9VZW4hWig=
X-Received: by 2002:a05:600c:540c:b0:453:697:6f08 with SMTP id 5b1f17b1804b1-45868d6b4b4mr46224145e9.26.1753351032723;
        Thu, 24 Jul 2025 02:57:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBdiBk1y9FYFtZGZos+FZxTmneELrQSJ8S9Hi/6MjtohOABZ0cx37UcBf5gRBbBVayCRRaKw==
X-Received: by 2002:a05:600c:540c:b0:453:697:6f08 with SMTP id 5b1f17b1804b1-45868d6b4b4mr46223915e9.26.1753351032246;
        Thu, 24 Jul 2025 02:57:12 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcb9a2asm1677126f8f.63.2025.07.24.02.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 02:57:11 -0700 (PDT)
Message-ID: <045d1ff5-bb20-481d-a067-0a42345ab83d@redhat.com>
Date: Thu, 24 Jul 2025 11:57:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sfc: handle NULL returned by xdp_convert_buff_to_frame()
To: Chenyuan Yang <chenyuan0y@gmail.com>, ecree.xilinx@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, lorenzo@kernel.org
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com, bpf@vger.kernel.org,
 zzjas98@gmail.com
References: <20250723003203.1238480-1-chenyuan0y@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250723003203.1238480-1-chenyuan0y@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/25 2:32 AM, Chenyuan Yang wrote:
> The xdp_convert_buff_to_frame() function can return NULL when there is
> insufficient headroom in the buffer to store the xdp_frame structure
> or when the driver didn't reserve enough tailroom for skb_shared_info.

AFAIC the sfc driver reserves both enough headroom and tailroom, but
this is after ebpf run, which in turn could consume enough headroom to
cause a failure, so I think this makes sense.

@Eduard: could you please have a look?

Thanks,

Paolo



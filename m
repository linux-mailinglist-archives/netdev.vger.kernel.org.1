Return-Path: <netdev+bounces-144134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F81B9C5E40
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 18:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40045B48169
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 15:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6B220110F;
	Tue, 12 Nov 2024 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OskEEEjS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB77D2010F4
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423497; cv=none; b=Z4unET7k9KODXdmcKbTueEIDFOA39LbIEtJtOU0GqKof4XMTzwOAQSpxE5ysvyEGjvFTPUm1g/q8dLM1hVwWYNK51pcJ+4BA+2qFYHdlVisj9wY/Yh8dgkfMgsD/CWSmZ1J7ssYSqhKOkfg4s2rAMdX7GtAbgd/xrEavz4nH5UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423497; c=relaxed/simple;
	bh=CbesPWMcsq/ixaskCqwH9NH18vggZMMy8Pa9VlaZJqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CTga9SZRXQ8R5ojvwujEbbINwOFMupv15IkaTy3G5t65Rmbwht+hqJiT3MSb26rdtpGaDzHFjYoCR5HunyGpYKnQjIpMJr+hqZMJKN/yHxoUtzzeu0yJJaEr02kNDYao6UQdwiOr2GVPOR8QSPttbXtAMpA6f5R/Va90lpcCH5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OskEEEjS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731423494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/ex2PqhS3gmrriCvN8i7mPF+UeH9EkfP/orKGyBxxQ=;
	b=OskEEEjS364wWR18pQKsVcccSb9O2WU/N+dlyMUqK6wb6KEYYJP/a5uq/3IG3HXyXCvb+F
	RRccvvSMlW82YJvZj9A2wY1xKXM0sC8o3FoWr14//wULtq0y7LgXh8bb0V49Au0V28BONv
	KPdbbfBAqvt/WNfNupjyg3DP8fkrCrY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-SIK2NNkZO8KFQ-3ODgakDQ-1; Tue, 12 Nov 2024 09:58:10 -0500
X-MC-Unique: SIK2NNkZO8KFQ-3ODgakDQ-1
X-Mimecast-MFC-AGG-ID: SIK2NNkZO8KFQ-3ODgakDQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-431673032e6so38755595e9.0
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 06:58:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731423489; x=1732028289;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/ex2PqhS3gmrriCvN8i7mPF+UeH9EkfP/orKGyBxxQ=;
        b=OhDkIzUawM2hx+mF58zXqPnIDjlrvHUi4Ir0aTio+E461ga5bIIA4SlACtURbgZzZP
         PX0oRh4KdAVP4wnBcvEYODNqZEcnMRhpGJAgEAlKs+9tpfn4u7/Hnck0zqGsdrJe8IQR
         Z1Vr5bOnmDGgpYnfxvLaRAu3x5PMhTlvzq9dgeVPre7AyrENi7xCr7/gEJGKpxi+FY74
         ZsRjud+5AS7VvqQ1N4Zf/OCrIBR45cmgBgiTprC9SXmzg8dp7QfchD+WSIUMn1WyuF+7
         suenlHK2/+jewFMQu5fBjj4+uHMheKDbdm3wwF4/y/7cjTYhd3Nml+pvY1hdH1cl/Rhq
         4M3A==
X-Forwarded-Encrypted: i=1; AJvYcCU4eUQVMcF3mU9hdzt7AraHt7ETdZ8i2AUmfWoi9Lgf+YVRyS22Xi7B7qT9XjZvc7DNUl6rS3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9kROXE3dU3IHFKRRImjC9IdL9ssUoaAnCV6YG7WiG2qfEu876
	6BXffFMzyDPQgjXCe3eYzb4xUpdIH5eDQ6n9ddOo2NUqA6oukJqzv8BsO3TGl7QSjDIcZh3gk0M
	wE0JMDCR/3sRoDFzA1Qelf5QhKadq0fJTZ8h61yqPqC9qeuLf5kkuQA==
X-Received: by 2002:a05:600c:4e8b:b0:42c:b80e:5e50 with SMTP id 5b1f17b1804b1-432ccdff4bamr27706465e9.0.1731423489502;
        Tue, 12 Nov 2024 06:58:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4W6oYaMTaJeOn4kBkprHQNJ23knllUmAOMJdom3aC6xdXU5F+gTN51CL2IahIO02N5TPyrg==
X-Received: by 2002:a05:600c:4e8b:b0:42c:b80e:5e50 with SMTP id 5b1f17b1804b1-432ccdff4bamr27706015e9.0.1731423488308;
        Tue, 12 Nov 2024 06:58:08 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa5b5fb1sm257523955e9.8.2024.11.12.06.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 06:58:07 -0800 (PST)
Message-ID: <a1db0c11-38ee-4932-86bc-a397a0ecf963@redhat.com>
Date: Tue, 12 Nov 2024 15:58:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 3/4] ipv4/udp: Add 4-tuple hash for connected
 socket
To: Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dsahern@kernel.org, horms@kernel.org,
 antony.antony@secunet.com, steffen.klassert@secunet.com,
 linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com,
 jakub@cloudflare.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com
References: <20241108054836.123484-1-lulie@linux.alibaba.com>
 <20241108054836.123484-4-lulie@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241108054836.123484-4-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/24 06:48, Philo Lu wrote:
[...]
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> Signed-off-by: Cambda Zhu <cambda@linux.alibaba.com>
> Signed-off-by: Fred Chen <fred.cc@alibaba-inc.com>
> Signed-off-by: Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>

[...]
> @@ -2937,7 +3128,7 @@ struct proto udp_prot = {
>  	.owner			= THIS_MODULE,
>  	.close			= udp_lib_close,
>  	.pre_connect		= udp_pre_connect,
> -	.connect		= ip4_datagram_connect,
> +	.connect		= udp_connect,
>  	.disconnect		= udp_disconnect,
>  	.ioctl			= udp_ioctl,
>  	.init			= udp_init_sock,

2 minor notes, possibly not needing a repost:

- The SoB chain looks strange, do you mean co-developed-by actually?
- udplite is not touched. AFAICS should not be a problem - just the
feature will not be available for udplite. I'm wondering if syzbot could
prove me wrong about "not being a problem" (usually it's able to do that;)

/P




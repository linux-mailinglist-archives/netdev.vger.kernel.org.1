Return-Path: <netdev+bounces-154838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69575A00071
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 22:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4126A1883BDD
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 21:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE7A1B87D3;
	Thu,  2 Jan 2025 21:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOWhitiL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAAF1B87CB
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735852526; cv=none; b=CAt8lnhUIAFKLwZdF9win7IdEeCy679WCecDkJJLGTTP9r3zs2kAvmK/XtKfCivVYmzVtSmy+tXRAmrNa34SaOv7Jku1jnwxtP4PB9IwOCoYX9cnSLys+rHx0cs6or7bvWw+TUaPx0CPV7t9MI4vQnFJyQbgUEZ4U92BbhqnaZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735852526; c=relaxed/simple;
	bh=D2bpYeQ3+T18OhssPto2jA410eagxNl9RPl2o8AJpIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKWP2VVLobVMIsRSWfzid4t5RDczgeOKHrVjOun8mv+xyx3HAqQsUMf58Xes6an6vMWAXobeCEUUkXWB2RtPuWg18vDJB2U/DnCd3e5ddHe4bRODO8+KQX57M9450+VZvwCCn8QAbLUvGd9FG8mWsdqOsDR6Qc8d8Uu/L7/9gdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOWhitiL; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f43d17b0e3so16602847a91.0
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 13:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735852523; x=1736457323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tu3c/ANtzt25FIQ8ceBnn6iUyQEXBRoPJdoJicoYauo=;
        b=XOWhitiLgy3Bgn12VYkAiHQvHnC7nfUIaml0cMLdFF5rOrIpyHQTkcxNEd5OOu7wHo
         XywPZBAneInkVnKHOI/y2Bdo7QUQmXkPBpuD3d1ukwqGsp2A5/E5/YHsyIQQTwSCFf3w
         rM+Qrs+KTWN32LF4TZtMWuRAn/jgYM3DSoRNZl8kP+UJzMG/ijyRV4wjiOqfqXREQQ8J
         0qZO0y3VjIfCYVeCz+O3Esp+GzN14bBH0GWxDRnBs6J3+LaUVs1Vl4K1eQqtjPpairlP
         xZ8BAyngknEOTHRZLx2mWGL1q449Zvu3C6KXgNuQtQl6ab2I+OHKNeEHtM9HvnvpiPDQ
         X/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735852523; x=1736457323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tu3c/ANtzt25FIQ8ceBnn6iUyQEXBRoPJdoJicoYauo=;
        b=csJbCt0WtZobX6pdDHPCsqiX9l6ZhYI/UAbtLyQxfixzK751pLD64S/rm+ZIdS0oPv
         8D9wAdDkqmz+8nI/inx1Ab9RuQSPObjKN/PfKhNQbUngYMx02uFP9bdD6SiPTaKWTRid
         zrdLsx95liI6HPEeYXZRI/P8z5oyPrCZe/Il2FqLu0FpWHiirdf3ADdQWemm+RMFlmaC
         k5C40hduNgqvBv/hGZ8vmzNp5kfvtaj9fkmlVLzKrlmkZZy6J7mp08yafr41BQCd4O8+
         7PKERGjw/CO+9x1yfWANmm6li+S9JW0i+/qAm1xTx6LNxejb/XWAmzFBrVRKPHeKxBYn
         P9Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUk2kRIiWTCamaOSk+Vz3DuebUm7KM1mdC4Qyr4X3i7lRhNVm42++dyoM76tFtnDQtXfTzr/Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPh5cBWE8J7i3/4Gq6FiVXlqJDtTBt2eOKG5h2IMF51swAGTVS
	M9dkXaOJrnwqSYHlEBMYE+CcnlyhmC0+RNvTfAZ4gfGcQlqxJq0=
X-Gm-Gg: ASbGncv24fiS4XdlFnCjZNPDYtUFqoEeva17VJdO9PX9qHqgjG37P8d55SHwI6TsLYQ
	0XTO/QygTLAACztU7+XpDg6TvtRADeko6x5k78OW325d7D48G/spfZiKQWuZHlNcGbF3a8dH5JX
	T6iGpJ+er2TzWRRfytU5aDSC4qx9JOXFDb2mtFPlJJ8gQAvKKtMMpO+Rrm6aBRNbj7PQxn5jOM0
	IVg2CAqkkXQuoGyHuF5RCUI2B/wE5w3tr0vHiqunbYMCyGYcfKDZ+uD
X-Google-Smtp-Source: AGHT+IEOZsfN/A0RFO7XO//YkpeJDqaJvecN+4l1u3dcbB6lb0nPMHb7XhBgKNPFeroB+QVp4Dz9Dg==
X-Received: by 2002:a17:90b:2b8f:b0:2ee:f1e3:fd21 with SMTP id 98e67ed59e1d1-2f452eb3cecmr63176572a91.25.1735852523379;
        Thu, 02 Jan 2025 13:15:23 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4478c73ffsm29632968a91.48.2025.01.02.13.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 13:15:22 -0800 (PST)
Date: Thu, 2 Jan 2025 13:15:22 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] Add support to set napi threaded for
 individual napi
Message-ID: <Z3cB6mcpi5eJCpca@mini-arch>
References: <20250102191227.2084046-1-skhawaja@google.com>
 <20250102191227.2084046-2-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250102191227.2084046-2-skhawaja@google.com>

On 01/02, Samiullah Khawaja wrote:
> A net device has a threaded sysctl that can be used to enable threaded
> napi polling on all of the NAPI contexts under that device. Allow
> enabling threaded napi polling at individual napi level using netlink.
> 
> Add a new netlink operation `napi-set-threaded` that takes napi `id` and
> `threaded` attributes. This will enable the threaded polling on napi
> context.
> 
> Tested using following command in qemu/virtio-net:
> ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>   --do napi-set-threaded       --json '{"id": 513, "threaded": 1}'
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> ---
>  Documentation/netlink/specs/netdev.yaml | 19 +++++++++++++
>  include/linux/netdevice.h               |  9 ++++++
>  include/uapi/linux/netdev.h             |  2 ++
>  net/core/dev.c                          | 26 +++++++++++++++++
>  net/core/netdev-genl-gen.c              | 13 +++++++++
>  net/core/netdev-genl-gen.h              |  2 ++
>  net/core/netdev-genl.c                  | 37 +++++++++++++++++++++++++
>  tools/include/uapi/linux/netdev.h       |  2 ++
>  8 files changed, 110 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index cbb544bd6c84..aac343af7246 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -268,6 +268,14 @@ attribute-sets:
>          doc: The timeout, in nanoseconds, of how long to suspend irq
>               processing, if event polling finds events
>          type: uint
> +      -
> +        name: threaded
> +        doc: Whether the napi is configured to operate in threaded polling
> +             mode. If this is set to `1` then the NAPI context operates
> +             in threaded polling mode.
> +        type: u32
> +        checks:
> +          max: 1
>    -
>      name: queue
>      attributes:
> @@ -659,6 +667,7 @@ operations:
>              - defer-hard-irqs
>              - gro-flush-timeout
>              - irq-suspend-timeout
> +            - threaded
>        dump:
>          request:
>            attributes:
> @@ -711,6 +720,16 @@ operations:
>              - defer-hard-irqs
>              - gro-flush-timeout
>              - irq-suspend-timeout
> +    -
> +      name: napi-set-threaded
> +      doc: Set threaded napi mode on this napi.
> +      attribute-set: napi
> +      flags: [ admin-perm ]
> +      do:
> +        request:
> +          attributes:
> +            - id
> +            - threaded

Any reason we need a separate op to enable/disable? Why not piggyback
on napi_set?

Maybe also move 'threaded' flag to persistent napi config?


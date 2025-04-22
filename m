Return-Path: <netdev+bounces-184777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01913A97255
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 18:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CDCE1885DD2
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36D728E608;
	Tue, 22 Apr 2025 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STyvezYU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520EA1DFE8
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745338563; cv=none; b=X7PJNxCk3rxpR/Mnng8lFPXpHPdctdoV95zaNSWET5dZat1969qloPebQqVhh61riOlnvbrz6mQZl4VJoKfXVNgmCltDYemsaPIxVDqO/zn2Mc1P3L6pJRkFhVmJlLOJ/ZftUl4lX3mj6tCF+g8p3s5AfI3f4Zxo9U3mJb4SFSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745338563; c=relaxed/simple;
	bh=Qa5CC7Ruofsi5ACLgQkGcDuYqrmUDWXD9QpX9zorcKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWZUHoKjonemJY4LPSQwNjD+AGCpXdGYl7sdkjDLT7KzQNVQsIP3fTE9djTO3v40890keaBTjBjKzRurLxM18LgIb12b2dXt3fbXBXIu6O3ByOgwOzEFNFEhW4iPHlLvBBnoqI3/iEsskZ4kKMyIPNc6U1QZ25cCKpt3kvG2vNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STyvezYU; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-736bfa487c3so4971283b3a.1
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 09:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745338562; x=1745943362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KBWPwaBoXzOJTjZyeA7kJuH4jbk/IAV/zqYEpKy3xqc=;
        b=STyvezYU2CwiIDCN3PXWh2FzxDKHJpXZyAjzQ1iMzO9rb0zesBdX8L72wEz0j9NDiE
         Q5JLW1ex3ToTIbKxag/ezCuIPZQhTwwI8rZMsMt31GCiAMKZKyy5JLLVAmmrwRO4552s
         2rbfaocNVaUY42AkQoOT8zXXz4kbt49weiwp+WEDQ+uqtKp1HQBt6GTF58w6DyKNx3ET
         5IiC7KotQ5kdTcYyNfaRhjJZwwSCcmVm5Ip93CgqJBDGGeh5G3Ovl+2xN4upzIBz4PMt
         O1lbkzlkMZVjrWfiB0GTCSHJ1ebCTwnfi3mJyDfArm+P+4InI34HHehWcnzxmSD/Zp9c
         njnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745338562; x=1745943362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBWPwaBoXzOJTjZyeA7kJuH4jbk/IAV/zqYEpKy3xqc=;
        b=QqQj8VpO1Mn6eahAmOEGOOZsBpyfBz5V+Mi657++f6IXZ57Pe+i7Ax/J5EwykUPTTP
         CGHCqcxXFSxFaPwFZ/4ocnCc6SjudAFNew0LBsSKqSxbZ2ICC6b9tWawnuLmtBF3Vk9c
         vf7fHXANPRWKNbiTbzah7A13E8MG+RLAecQAl6omOmlMxgCWSIiYOKG4MWIKTUVuo3da
         C8A555ZK4Atx9IzWXwdKVexozyMcpWnlZOtzeRYopEBcW1tDknmhH3+gwFo3gFOEeJwK
         FeRySLl7jApysxoxU6ZHjwWuLquDhxL7f7OS9tuQr2S9IVJLnwFtwbd7NRL+wftycXFN
         1zOw==
X-Forwarded-Encrypted: i=1; AJvYcCWDucIV87Xw7sJED9anJYS0hnFQAwUQWaYpcKax2B9N8OkXXxbUhc2dJ7vdkfZrlFt2q34JeP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrmLyJZhLou7Dkbr+g3MkChpwQ8Ngdf7UHFs0s9h5rglFwaNXL
	73eRI/vc8J1LQONgXZuKOmVDCHYn1c+AG/y3Okr70xf6flsrvnU=
X-Gm-Gg: ASbGncsxOKGfxvHwl2j6syXnw+wCr3pQxLVqU1V6JNim2FDTmKcw6N0mtGNb9I6XanC
	JNk+/6O9+6awJ+Dz9S3QS0iWRgM7rddMF4zg/sdKyFAhMSmzQ/EHs0wWKuLtuSq3ifvW998ZUrq
	5yK4AGLoudycLAaY7fCTB/cSJuhmTx45oUah0z3+YduQ/eM6FKqIHQBolNmP2ewlR73UHCtFKds
	3UNdUgnU9OrEeRu/COJKE635eQjU8IHka1WD0w7QPENUNvmVATByD0NWoRHfgSYNf/uHK4Exf42
	vMzQLj5NCEhtk5myD/sy2E5uDvvAClJ4z259whXG
X-Google-Smtp-Source: AGHT+IFwV0k9asYaQPZXyol475vKjZDNmQj/Sd3IQvqWKWnj+cXazMSs5WXRTWjtiT31WxPfZBqUpw==
X-Received: by 2002:a05:6a00:8d86:b0:736:9fa2:bcbb with SMTP id d2e1a72fcca58-73dc15f1a87mr22763703b3a.24.1745338561230;
        Tue, 22 Apr 2025 09:16:01 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73dbf8e4932sm9115487b3a.55.2025.04.22.09.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 09:16:00 -0700 (PDT)
Date: Tue, 22 Apr 2025 09:15:59 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	donald.hunter@gmail.com, sdf@fomichev.me, almasrymina@google.com,
	dw@davidwei.uk, asml.silence@gmail.com, ap420073@gmail.com,
	jdamato@fastly.com, dtatulea@nvidia.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 17/22] netdev: add support for setting rx-buf-len
 per queue
Message-ID: <aAfAvxX707BGyLOZ@mini-arch>
References: <20250421222827.283737-1-kuba@kernel.org>
 <20250421222827.283737-18-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250421222827.283737-18-kuba@kernel.org>

On 04/21, Jakub Kicinski wrote:
> Zero-copy APIs increase the cost of buffer management. They also extend
> this cost to user space applications which may be used to dealing with
> much larger buffers. Allow setting rx-buf-len per queue, devices with
> HW-GRO support can commonly fill buffers up to 32k (or rather 64k - 1
> but that's not a power of 2..)
> 
> The implementation adds a new option to the netdev netlink, rather
> than ethtool. The NIC-wide setting lives in ethtool ringparams so
> one could argue that we should be extending the ethtool API.
> OTOH netdev API is where we already have queue-get, and it's how
> zero-copy applications bind memory providers.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/netlink/specs/netdev.yaml | 15 ++++
>  include/net/netdev_queues.h             |  5 ++
>  include/net/netlink.h                   | 19 +++++
>  include/uapi/linux/netdev.h             |  2 +
>  net/core/netdev-genl-gen.h              |  1 +
>  tools/include/uapi/linux/netdev.h       |  2 +
>  net/core/netdev-genl-gen.c              | 15 ++++
>  net/core/netdev-genl.c                  | 92 +++++++++++++++++++++++++
>  net/core/netdev_config.c                | 16 +++++
>  9 files changed, 167 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index f5e0750ab71d..b0dfa970ee83 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -324,6 +324,10 @@ name: netdev
>          doc: XSK information for this queue, if any.
>          type: nest
>          nested-attributes: xsk-info
> +      -
> +        name: rx-buf-len
> +        doc: Per-queue configuration of ETHTOOL_A_RINGS_RX_BUF_LEN.
> +        type: u32
>    -
>      name: qstats
>      doc: |
> @@ -743,6 +747,17 @@ name: netdev
>              - defer-hard-irqs
>              - gro-flush-timeout
>              - irq-suspend-timeout
> +    -
> +      name: queue-set
> +      doc: Set per-queue configurable options.
> +      attribute-set: queue
> +      do:
> +        request:
> +          attributes:
> +            - ifindex
> +            - type
> +            - id
> +            - rx-buf-len

Do we want some guidance going forward on what belongs to queue-set
vs napi-set? (mostly) HW settings for the queue-set and (mostly) SW
settings for (serving the queues) in napi-set?


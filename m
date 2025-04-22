Return-Path: <netdev+bounces-184782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C01A97273
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 18:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C5D3B5357
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042CD288C88;
	Tue, 22 Apr 2025 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="M9og+57r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782EE280CF5
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745338760; cv=none; b=Iu5cgulb4mYDpSC6YxzaxpX8vI0lf+esAZHY4LNPKERtSCYP82voJb9LWKQXDmOKL685Oc/i7XqQSrHIs4vJCkts6tmgaBpNpNuVn9CvN/MtonTY4qGxdsNFJFA5kZWEiUGo2yxwSgopJNQykX+I6nJBfZOIpcPM8OIQhGiuSDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745338760; c=relaxed/simple;
	bh=N7hmWvqBMYxAcPzbRFMmXk/IKkxvCKIHfzuWgxrTX5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbZz+gGeMFKfVBY2PsJa+fvRsdxlcZxjSFLHj6KPjHv8YpbxE0ca0x1DowwCfzO4LqL3AGtfiHZPJyzsa86R22yhsgHkuqoVoI15E/vSYqDCJa2ydtENEydZUvmquzHowNbRK/wwC5CzqNxH4ORR+SsCEK5/FmckeOmWpPcz3sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=M9og+57r; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2254e0b4b79so81448465ad.2
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 09:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1745338759; x=1745943559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7jKbx8knv6gYrs8gX7oAs0nfw7weprBuMHY7pQjB8bo=;
        b=M9og+57rQ31Q3Cp8ZawWl49aEOuMtdY5QeMwszrrZ7yTmVBBn97kbIg+yIxz3Kl9tl
         rg305wijbWju8B27RgVMn4JnTfyq1h2JD3BUY5LpEXHHzSnsbXDnfU/acr5jCJpPjQLd
         RvT6dkE/mJqIZoPbg60BqvnDcY42+yYh5gfYDrrAXkTaU2GdQVG2DcY7dnEnLtW7EF0B
         Y7NtRjZNAvpETrkF6tTf21LX5xLCnOssv8TafFQbhKMX/qpiP/7xkN9Iy/L3qEjyriGb
         Dg7c64hgCtSFM2xytntvi4JnQ71adVHAurI70mxTKCleGULolRV1IrEIvgchvT9FDICs
         Cecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745338759; x=1745943559;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7jKbx8knv6gYrs8gX7oAs0nfw7weprBuMHY7pQjB8bo=;
        b=FCpsK8XxdaL/4tvRdcFtD/JlVM4OC3VCFBJwOAaT2ndmEfVEaltf8JiIkbEbdHW7lh
         FTRDAzFNpwyrSe4zju5/r7kQjfPiSXbObpkoOiR6p8IblCduZXnDLCzC9ydqGaQ74idL
         A41tQg+emLkfr1JkKU2c684qBH3CyoBb42x7Mqb0Yp4dAUusNlnB1bkviPKrdGyc8PyZ
         LGR9Yhpkp3nOWazeOkwfOHcLIgFu2oeyBu3xmkaWc3AFo+zWkWUExYIlF/E/VgqcmFYy
         jNgVY5QdgJ6+1TBrQMPj0Qko3lRcj0wpjMeVYj5YTa4tce0RjzeNwFc/lGcHpAEpSIzE
         64cg==
X-Gm-Message-State: AOJu0YwFHFZkReQd3CmIbvHYR4gGpjcf4tvKuA5YSoRNl6YJ6LqqRYDh
	eWq2YP663OmOizr8YhW4JNuXlP4lsgAVVwjI2DIurGAEelaqZv5ShjbEv0Ln9Pg=
X-Gm-Gg: ASbGnctNnbE5Ikb5BY/84iyDp2R/9TmlJJvPmw6UZmKQr36uHfJ7ydPcuotcI99o9jG
	Wvva4Lp8GXuG6YIoGHDJjEcFLHhjh4WFSCqYSVh+LO/DgcPLLXmnPtzBJIuMh8kRa30hEQ2+zX7
	xXvTrSb7TmWxRBRQHhHH5csgH+0s4NeYJXzes/ePBOM5Y6u0PIUhXSu3rUp/KE+fUvKx+cVYOyN
	gumrA4y9eJQLKb2izRztvnCNxuw0E8/rk203Ai2sgmWZ3nMZnVjG/Tt8eUqucrVV44JlSwoAaSc
	4789hIEQ2F9va1R2KZljoqHpcWvYCvzGFwmSr6O+mML4B3+IpeKWLSy0l8XlFK6yl7rWU6FTxOp
	+STEovYmQmIAOfw==
X-Google-Smtp-Source: AGHT+IEanEQ6JSNikA85SJFBnTkBIAc+MXCrQm5mzgxlrZwarSBsM9Ysu9XPt6AdD3HAQ7sxPboQ2w==
X-Received: by 2002:a17:903:3bad:b0:220:f59b:6e6 with SMTP id d9443c01a7336-22c5356798amr201676795ad.8.1745338758775;
        Tue, 22 Apr 2025 09:19:18 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1cf1:8569:9916:d71f? ([2620:10d:c090:500::7:aab2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bf32aesm87451675ad.58.2025.04.22.09.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 09:19:18 -0700 (PDT)
Message-ID: <dca8f379-92f1-4d7b-89ff-f71f43343e23@davidwei.uk>
Date: Tue, 22 Apr 2025 09:19:16 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 01/22] docs: ethtool: document that rx_buf_len must
 control payload lengths
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 sdf@fomichev.me, almasrymina@google.com, asml.silence@gmail.com,
 ap420073@gmail.com, jdamato@fastly.com, dtatulea@nvidia.com,
 michael.chan@broadcom.com
References: <20250421222827.283737-1-kuba@kernel.org>
 <20250421222827.283737-2-kuba@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250421222827.283737-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-04-21 15:28, Jakub Kicinski wrote:
> Document the semantics of the rx_buf_len ethtool ring param.
> Clarify its meaning in case of HDS, where driver may have
> two separate buffer pools.
> 
> The various zero-copy TCP Rx schemes we have suffer from memory
> management overhead. Specifically applications aren't too impressed
> with the number of 4kB buffers they have to juggle. Zero-copy
> TCP makes most sense with larger memory transfers so using
> 16kB or 32kB buffers (with the help of HW-GRO) feels more
> natural.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/networking/ethtool-netlink.rst | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
> index b6e9af4d0f1b..eaa9c17a3cb1 100644
> --- a/Documentation/networking/ethtool-netlink.rst
> +++ b/Documentation/networking/ethtool-netlink.rst
> @@ -957,7 +957,6 @@ Kernel checks that requested ring sizes do not exceed limits reported by
>  driver. Driver may impose additional constraints and may not support all
>  attributes.
>  
> -
>  ``ETHTOOL_A_RINGS_CQE_SIZE`` specifies the completion queue event size.
>  Completion queue events (CQE) are the events posted by NIC to indicate the
>  completion status of a packet when the packet is sent (like send success or
> @@ -971,6 +970,11 @@ completion queue size can be adjusted in the driver if CQE size is modified.
>  header / data split feature. If a received packet size is larger than this
>  threshold value, header and data will be split.
>  
> +``ETHTOOL_A_RINGS_RX_BUF_LEN`` controls the size of the buffer chunks driver
> +uses to receive packets. If the device uses different memory polls for headers

pools

> +and payload this setting may control the size of the header buffers but must
> +control the size of the payload buffers.
> +
>  CHANNELS_GET
>  ============
>  


Return-Path: <netdev+bounces-178511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C31A7766A
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 10:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B898167322
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 08:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A51B1EA7CF;
	Tue,  1 Apr 2025 08:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvgiQBtQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAE31E47B3
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743496121; cv=none; b=fXWrrySnA0qmyatF5zHsxX6NAa66dM6e1ZtwVKnWSdrBZp053Mq2aALs1n+8NiKr5vvIyb/QwuABzJjzA5yB6vhdjLVqlBGfub5v5kfnK5u5tO0KJLZVQ2+7HfYrA7ze5dXh0JAQPyiVtxAkamEv0LGts3oOfHMJBrIVYCzq1Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743496121; c=relaxed/simple;
	bh=2TEgE2Gh5l/esd2JjsKB39oXFx7MFG2tU8DRfLx4nrk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=qxGzCVlKeMJpyP7Ht4VEEBJQmKXQkPsJodvh/xN7IOkcHL/znxyKMTyLgMGNtAv+F69QC+CDx43nl5opvEn9e9KIDzMJzObZXtqBKJBVQuPaE2rlO6EBv/saQ4J8FsghkxOj1vlRyQDjUKzLw0HDy3GEkFQtlmFSfZTgFVCw/kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvgiQBtQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso36676245e9.0
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 01:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743496118; x=1744100918; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m3NjyvvecvcpSpvcJ8ewc7DM5ZorTog+O/HqraBhzZ8=;
        b=WvgiQBtQPjNchslTca0qYWoz8x48xQUMQqroi4RDxUbC+RNa9K6/KVS/emDo9filW4
         wH5MTlVYxarknK5+Cn4kl76eGs4UdtwJGBm6odkQLZwEZm2RGGH0BYO92wxOo3ui5vE0
         XZXVMMvGcpXMLlymixdaG3WMiLQNJ/T51+an4S/PdYr9N8NQo9TEssErzP9a8+yBpV3G
         DhyQTsuPmfiSZeuWnUpFdrbO0kvwCfTy5JKLB7MBAIaDs1T9Ws8QvN2YW4ObHbiYB6BY
         7ZRJxsGLbtJnannUhy1ZkHO9xSy48lXvz0cy+lwb6t9uWRrbNErcy4nJwdqJB/lGK+wX
         QtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743496118; x=1744100918;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3NjyvvecvcpSpvcJ8ewc7DM5ZorTog+O/HqraBhzZ8=;
        b=rrDZKyIRCzSbGM3mVgjHR0tx07FAsDwq0XgF2Gm2ztvToI6qjqOmcrNO+QlG4JSNuj
         LFTUTFbLpcIZWs3zMFEv29cm/71a5yo4CgGxY9S0ct+PkDEod7HSuuNkEJwoD6tZsGWU
         rhM+tg9lTrszZYHMaZNCN7gi8I75KC+dqkJqh9fEPQkpxeQB5Kbq5xN7Iufu7epwjUnd
         NfmkCWPrH21Sr1ywT0Q8FdbbVDIiLVyA6PZNAB6Gug57ZfWLhCww7M+VxEwz7dUMqLPY
         yRZtAts+eBiT8CoDnTwJKbSaiB35808gUJUs+VtD/PFituaT3G71vIneMYQDUQk6iZTz
         J2YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmwi96eaSYQvxDVdfBgII+zEQHG16wbjYv6J/2DGMiE+gmY93+7Bdggt1R56q955T2eB3aGOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1nh0yFkjke41lG8ysjYJ7B472PDvMe1ktoY8h7brXuqo5sH1u
	uU2/Lzl5Hj1Iwz6M68JNQFNFUYoqrc/XLYMR6IOe5XbfWwn9Zttd
X-Gm-Gg: ASbGnctPTJKfsVgDp3oK9DachDwenSjmjxx9aHf+X0HnyxhhOuravlxGGdJN3pPM2Pe
	lAXDLrFQ/8uxGHaVlWRAwB/vXTNuCMNfQiyW3LT6tWzuRXiY2MjSHdl8SrlWR+kvdmzgZz8JjWn
	HKwnoYyJ7/9avnbbhnFikgLU28rWq6NCpSvKNccScbMAt2kmgLBDnCpXbL+OsjbcpAxTB8faRUl
	GomO8fsYzC+gKl7MiwS/KdTDMpF1s8defutZrFxjeOaDwUjnZ6lW6nqUfh2RtLYqJ7V1uSA66uf
	mAkIrHVhz8qB2emBdy7oHOXX0gRuVfzFRPvdotSJKNWlpwvxwrcR1SVAk0q5KqcOr8Vi
X-Google-Smtp-Source: AGHT+IGSSsJ2uaoAFr57mIV3I9zTlIs7G7pBWSePUCC5JrvteLiXIohHqI5a5A6ULL01I6AUn/BgHg==
X-Received: by 2002:a05:600c:510c:b0:43d:10a:1b90 with SMTP id 5b1f17b1804b1-43db6248f5cmr105815445e9.16.1743496117793;
        Tue, 01 Apr 2025 01:28:37 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:d018:a09f:82bc:eb27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b662bf9sm13087089f8f.29.2025.04.01.01.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 01:28:37 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  yuyanghuang@google.com,  jacob.e.keller@intel.com
Subject: Re: [PATCH net] netlink: specs: fix schema of rt_addr
In-Reply-To: <20250401012939.2116915-1-kuba@kernel.org> (Jakub Kicinski's
	message of "Mon, 31 Mar 2025 18:29:39 -0700")
Date: Tue, 01 Apr 2025 09:28:10 +0100
Message-ID: <m2msd0i8v9.fsf@gmail.com>
References: <20250401012939.2116915-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> The spec is mis-formatted, schema validation says:
>
>   Failed validating 'type' in schema['properties']['operations']['properties']['list']['items']['properties']['dump']['properties']['request']['properties']['value']:
>     {'minimum': 0, 'type': 'integer'}
>
>   On instance['operations']['list'][3]['dump']['request']['value']:
>     '58 - ifa-family'
>
> The ifa-family clearly wants to be part of an attribute list.
>
> Fixes: dfb0f7d9d979 ("doc/netlink: Add spec for rt addr messages")

The fixes tag looks wrong. I think it should be:

Fixes: 4f280376e531 ("selftests/net: Add selftest for IPv4 RTM_GETMULTICAST support")

I wonder if the op name should be changed from getmaddrs to getmaddr,
removing the plural to be consistent with do/dump conventions, or to
getmulticast to be consistent with RTM_GETMULTICAST.

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: yuyanghuang@google.com
> CC: jacob.e.keller@intel.com
> ---
>  Documentation/netlink/specs/rt_addr.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/netlink/specs/rt_addr.yaml b/Documentation/netlink/specs/rt_addr.yaml
> index 5dd5469044c7..3bc9b6f9087e 100644
> --- a/Documentation/netlink/specs/rt_addr.yaml
> +++ b/Documentation/netlink/specs/rt_addr.yaml
> @@ -187,6 +187,7 @@ protonum: 0
>        dump:
>          request:
>            value: 58
> +          attributes:
>              - ifa-family
>          reply:
>            value: 58


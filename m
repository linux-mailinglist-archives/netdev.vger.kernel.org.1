Return-Path: <netdev+bounces-179020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3435A7A0F9
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 12:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA3B1893324
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 10:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81662459F0;
	Thu,  3 Apr 2025 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PS8aGrz5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63833241CA0
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743676077; cv=none; b=TND+biBs5K1IPo78y3R7j/qJeBZZLn6bxqtBVR1V3n4kY20/K9TcvHX0ddzM95xaBc62dKChqCPEs0q/Etol4AoUMSOncFPmYTgNgAPjSUeXmq86eqzDi0uSyfOohey3PxD4fYfNC2f4nethwVdeewMCttK1EnPrmV0B+3efdsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743676077; c=relaxed/simple;
	bh=BjkO4Ok2EF5qBA434UpfkG12RhFwhV8Wfq16I2T5BTs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=PbNj8ttPoCri6zbqKTvA/SRrOo8U6IlzL5JNrcwtg8JcoUfysPdyFvAqD8jeCa/8ruwUlU4aQZLHwFffjsWBNy+CchtlMY1Q2eYQqxYHsCGPZMAAQNVh+V6xGd/3/4ukfluxeZmFPOzn65VuGM9T3wmfyKQ6OCcJouA0n32dlNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PS8aGrz5; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39c2688619bso451173f8f.1
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 03:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743676074; x=1744280874; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YDPxr04aT2xdATTj6LclbyOnYJ90s0UlaOSwL43Og20=;
        b=PS8aGrz5LMPsi3Esxx31u9SC9bgzQabvuMCpu99zhD3IZOCCAMXM7dw/qBY0x8zjjc
         WT59YJIQ7+3HlM6mI22fgZcC3jnM/A6kV740xS3SjuninHHFJSnTA5nDg0Uyf5Kg2TV4
         34kf2Xg1/dp++mxNlzz7EOHRarPoHYxSjPip0sWUelekqG1D1y1FHZv8EDg6cFxRgT9a
         imXLzcIi2lzn4MevctQI0Kzy9wPkPwC+NWmjaEtrvmqTEzyAVQyGwloj/g8kHIYQonqS
         +wFW5sCoPCztGz93elYfyaEqXrSx+QpzpUcoPrgm0wJ+WeQ8WfA9BIb1K3hS7abLZqHW
         JUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743676074; x=1744280874;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDPxr04aT2xdATTj6LclbyOnYJ90s0UlaOSwL43Og20=;
        b=brE4MTAQA1bWNMrE+v3Fp7FDfx0QYR8YVIHTerMeKy2wNvZ1P+rgleatYsKuECxpsr
         m7QPhpUoyu4mYbEIsQNifPlGEmf3QAwBt0yrrS1s23PH0iswasvZIsQn/Jawvy4d4bsK
         Sj98fBMLB6cMEBkEhwj/1TRV2Wv3csKSZII1jqL4bvwpUndOrCwVhBa4A+q8xh//VlsJ
         jsfTpZ0a4U4EpA9XkEOI4GuaozYeDCqwISW0FNVt9FQC5DcrhUcO32JnjTRE+dvFEW8D
         7DkrgLU8KkPPTk9JNmBaYdcHPU+L0wSnuZkPpSRvf1v/dY/9q0msyOeW2H+OUzuj2E1N
         cVCA==
X-Forwarded-Encrypted: i=1; AJvYcCU5Oqg/7Zpx5UVQmhkmk+T1evDxmNJ1ZSt+Ev/I3Kf6qkF67dL+dx91HE5ZN2vV9bLvs5qkwXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB2tFB+veX0b1RMUZ4ImqA6fQdGbt24YO/FZNf/gOxmQq0cDE/
	0UIAEa4JgcCyaPiTN4XwH8ARqGkzEfoPJoMBJEbk51b09M6iDdjA
X-Gm-Gg: ASbGncv0y/anM0c+xKCL0UAPJzwrPcywaXOMNiIVdv3z+ZgBucRBdutFZ6NGtz81etg
	Q6aHFYRKERkiMM7ozvPxyoJZ2//QgmBPWfW5aLjIMT2D3pBmRkSeKFgyv3FcsIxOpwaci6DmW7G
	A/JJaSgff9MCEYQk/t/stqJWz4b3A432a2hDk0lw3o/MAfQ3GYV95Cbs4pbWUY9Rkr3W5swUDSZ
	i6HcTpZrHT2FJTfy/IobI+L8Pf3UHvuUVLAIL/e28Ruvc10sZcm2wIWiTO06eoMU9s2i5vOtGJg
	eOm/H8SBlQ1e9gsiH1Bragp3MQhS1Xo0ZVX0CRpjjJGSiz8bdmazu710BA==
X-Google-Smtp-Source: AGHT+IHnEYGymMIXQhLXYj3C2/8XymcgOYEJb5uDE1ymVvTR6+oTIWEylEFRIltfguYnZs+X2Jg60Q==
X-Received: by 2002:a05:6000:1a8a:b0:39c:1257:feb8 with SMTP id ffacd0b85a97d-39c303ae5c6mr1599588f8f.56.1743676073466;
        Thu, 03 Apr 2025 03:27:53 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:45fa:4ac2:175f:2ea9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a6ae5sm1431937f8f.32.2025.04.03.03.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 03:27:52 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  yuyanghuang@google.com,  jacob.e.keller@intel.com
Subject: Re: [PATCH net v3 2/4] netlink: specs: rt_addr: fix get multi
 command name
In-Reply-To: <20250403013706.2828322-3-kuba@kernel.org> (Jakub Kicinski's
	message of "Wed, 2 Apr 2025 18:37:04 -0700")
Date: Thu, 03 Apr 2025 09:34:23 +0100
Message-ID: <m2cydthcds.fsf@gmail.com>
References: <20250403013706.2828322-1-kuba@kernel.org>
	<20250403013706.2828322-3-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Command names should match C defines, codegens may depend on it.
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Fixes: 4f280376e531 ("selftests/net: Add selftest for IPv4 RTM_GETMULTICAST support")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v3:
>  - fix the op name in the test
> v2: https://lore.kernel.org/20250402010300.2399363-3-kuba@kernel.org
> ---
>  Documentation/netlink/specs/rt_addr.yaml | 2 +-
>  tools/testing/selftests/net/rtnetlink.py | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/netlink/specs/rt_addr.yaml b/Documentation/netlink/specs/rt_addr.yaml
> index 3bc9b6f9087e..1650dc3f091a 100644
> --- a/Documentation/netlink/specs/rt_addr.yaml
> +++ b/Documentation/netlink/specs/rt_addr.yaml
> @@ -169,7 +169,7 @@ protonum: 0
>            value: 20
>            attributes: *ifaddr-all
>      -
> -      name: getmaddrs
> +      name: getmulticast
>        doc: Get / dump IPv4/IPv6 multicast addresses.
>        attribute-set: addr-attrs
>        fixed-header: ifaddrmsg
> diff --git a/tools/testing/selftests/net/rtnetlink.py b/tools/testing/selftests/net/rtnetlink.py
> index 80950888800b..69436415d56e 100755
> --- a/tools/testing/selftests/net/rtnetlink.py
> +++ b/tools/testing/selftests/net/rtnetlink.py
> @@ -12,7 +12,7 @@ IPV4_ALL_HOSTS_MULTICAST = b'\xe0\x00\x00\x01'
>      At least the loopback interface should have this address.
>      """
>  
> -    addresses = rtnl.getmaddrs({"ifa-family": socket.AF_INET}, dump=True)
> +    addresses = rtnl.getmulticast({"ifa-family": socket.AF_INET}, dump=True)
>  
>      all_host_multicasts = [
>          addr for addr in addresses if addr['ifa-multicast'] == IPV4_ALL_HOSTS_MULTICAST

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>


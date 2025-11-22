Return-Path: <netdev+bounces-240947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF52C7C806
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 06:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 73B5B34B558
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 05:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F17926D4DE;
	Sat, 22 Nov 2025 05:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xn6zY+b0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EA5293C42
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 05:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763790308; cv=none; b=KKdTNExJZnw5lAX+WVNVdEnPsoAjcKnV2S3b/U6ob7v3wEDP63s+kO6jr4IGn83nQj6hYffmG11VfOoxmXwnY+QwolbvVOIbj7n+YO1OOgYAqieLbWOPEoKmQqOTQn719siL1d75prsrhPoY6L/3Sf0NqFscZMs+2SRa13QVWgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763790308; c=relaxed/simple;
	bh=2gl9gVDIxZaiWHwDj/40w+f1RDpdlAYcXoZ2OWjUxSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8LpJJ3m+EAf7JOq3rDS5eQ1mwfP9zpNOF+BQghAiwD2H3C7GeTsgh7Z38M+OSdW+a/8QTPFEj0IczwLh5kEDMlFm6dac1O/6bHDs2cfW39Pa6GZT0qvjJM9f+oF3aMkNVdGjDgaG8bBGdsMaIW5Vo1oFpeq7NrLMY23sCozIns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xn6zY+b0; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7bab7c997eeso2963151b3a.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 21:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763790306; x=1764395106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YenTUml7bZ0JODI2rNiGWeX/UZHdxzPssmYma55zzUY=;
        b=Xn6zY+b0pfxYKtmjR5fftiHkmMiXYep3D469RQCNtunBMP6iaQQ97EdxmIyHZ76EbR
         OvhljF9qQW12HuUKKf9kiT/+YOLl4fzggzSd34pz42UBIwHm5nmwzi5m4vkT8z7dZxEN
         pIMMbgftHNgBXfkCbiCs7Y5pEcAwdDabzWtfmz2GboohBhqFjpZclnFTIj16W3Y+348y
         hhSxojcT2Cx7zNk1cBmPzzoScnOV1HgmNU8quOPG1WKrnjDitQLznf1oP7OITlPSLJ11
         3A8v2e3UWrdIMaE6UFMmPxp0wavO2llCEsp0XhfvYlb/Rkm4E4EvBsDNgyGKDWjn/fMV
         Hvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763790306; x=1764395106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YenTUml7bZ0JODI2rNiGWeX/UZHdxzPssmYma55zzUY=;
        b=nuPnBGTk1Ga0BVR3afpAU9Aadb1f0v3PwS5dx8JnfoWLe9DXNsIZmBqzbbv4T6xMXW
         25fflrR6MJV3ed7v1qHLq/HiYZW4ASJt4/D8zczZ/KnkHQWN3BaE5SpRMhQEQDqZZZBV
         5A+MwK91xqL1UNjrPzYPX34djFKaj+o6RsC+0cI70kfnU3bK/SQr7G+EfmmB3aL+K2V0
         X6xEsuYrvWCfdOOD2Sd4F8SPyedHxGEYC3VYIBw56JkS6qn6jxK2YNFRwTuOjdgYCQJ3
         c1JP1pdtsfaSHgp0evlc4PVyy1QDJg5SfGR1QYHmu5mm5IpA3DoA5XmdAHIzLIFfx63+
         JRPg==
X-Forwarded-Encrypted: i=1; AJvYcCVg/PcraUD8os4nsDmalv6OBiJux6dNA3LXSX/1jDNEYzUt89rTANJuKff2ejpITEwddjLwN1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx10NOnNFopUOw3gJLbWqV6S3Mxfq+oKtWKvcP3BZ3WfTg9YUa
	2Wm1M7cXUNDHrbPCsg7fn4T4Hc48kk+3VHwBsEzxzcQGssyzj85YGScOs5DbTwOMQtLXc/ff6bX
	UzU7NOoICp29FA3kyxBDYxMw8xwJXUABGx7qm9EIz
X-Gm-Gg: ASbGncv6PUer05ppngyECRg2ty4OVyLETz2iP1vMUz+pimPITZ1MyEFOJBd7vgfPnsI
	smsFv2+vKRhcA1H8d15j6WXeWr9OFJcVcghSNS9Dtj+Db1HOn2BktwdY8z8F/t6UfltEB/Dxukv
	qi4myZzedafttKse30AZJhrmL5DniJYZ/K7kk3jNF1QBgKeK60FJyKcH04iWd1hq6VbjnWuCjvp
	8TDb8m+1Y8Av+oGSvJNbbODj6/HGDjoqt+TSvpHAy3zPxWn/bhcHy67bTu8qg4wGKwssPVkit+w
	g4cXwFBz5TCWtnmhk2I2x8NZx43s
X-Google-Smtp-Source: AGHT+IGg4pMXEm4ZqlxDYZ0tZHgbXc8sFy1CHLUd8VkJMjzd/RX4+J46x9ql9k9X9dWK5ElSb9EzqwW1lw9MDGqtTy4=
X-Received: by 2002:a05:7022:ef06:b0:11b:9386:a3c0 with SMTP id
 a92af1059eb24-11c9d872c1dmr1965765c88.43.1763790305358; Fri, 21 Nov 2025
 21:45:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122051021.19709-1-a0979625527@icloud.com>
In-Reply-To: <20251122051021.19709-1-a0979625527@icloud.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 21 Nov 2025 21:44:54 -0800
X-Gm-Features: AWmQ_blpyFdUm70dEhnuMiWYOIrVRbokeosB5To3DP5d_MZJRL_H6Yl6NOfNgFs
Message-ID: <CAAVpQUAxOJDx5fH0XWe1aUD9mJLDwNzMsRq8MoBZ8-UBPPiYLg@mail.gmail.com>
Subject: Re: [PATCH] net: socket: add missing declaration for update_socket_protocol
To: Chia-Liang Wang <wjliang627@gmail.com>
Cc: edumazet@google.com, pabeni@redhat.com, willemb@google.com, 
	davem@davemloft.net, kuba@kernel.org, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chia-Liang Wang <a0979625527@icloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 9:11=E2=80=AFPM Chia-Liang Wang <wjliang627@gmail.c=
om> wrote:
>
> When building with C=3D1, sparse reports the following warning:
>
> net/socket.c:1735:21: warning: symbol 'update_socket_protocol' was not de=
clared. Should it be static?
>
> The function update_socket_protocol() is defined as __weak, intended
> to be overwritten by architecture-specific implementations. Therefore,
> it cannot be static.
>
> Add a declaration in include/net/sock.h to fix this sparse warning.

Sparse just doesn't understand the context.

The function is wrapped with __bpf_hook_start() that
should suppress the real warning by compilers.


>
> Signed-off-by: Chia-Liang Wang <a0979625527@icloud.com>
> ---
>  include/net/sock.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 60bcb13f045c..2081b6599edc 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -3103,4 +3103,6 @@ static inline bool sk_is_readable(struct sock *sk)
>
>         return false;
>  }
> +
> +int update_socket_protocol(int family, int type, int protocol);
>  #endif /* _SOCK_H */
> --
> 2.43.0
>


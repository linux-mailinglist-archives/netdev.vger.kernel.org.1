Return-Path: <netdev+bounces-196934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA70AD6FCC
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD3F17842C
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4051521FF5B;
	Thu, 12 Jun 2025 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZSBTD3T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DFB2F432A
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 12:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749730317; cv=none; b=HMGhXAirwcwmcSw/6x4oVBgRKYy7JnOYFkVo0Wd8y5z/p228uiVWWlb4kaOpQ6h8uOujlJdvhw1RTmKbWmMjsOLl+qQHEK5Q6DFgs7+mDLAHtvlzXCBknUetJP84Xd6S8DWwWzaAeTSDxCNbpufe6mvQtBjiKztSD9+IHPZCZkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749730317; c=relaxed/simple;
	bh=gy3ia7wHU+HGjiZJQrqlaD0GroCZVIID2YLPJxbPm7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFs+hVIp/qk7Yvxwwg3DQC+1FSEu5cRbzI9/sQmKS/S9GPOqbmzQGxTC8xjjYnE3U+VYVMZQDZ75hQ4A2g2zejxpI2dtp7QNNdys7DORNjhy5mYJI5dk+RPDVK+h0Fr0NQuAygw9eAAoN+IC9vc4cLCvbJ27v7VG8LCmySpLFk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZSBTD3T; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ade48b24c97so125322566b.2
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 05:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749730314; x=1750335114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mPFgahJgaAGctrInOwx2SZrivmTOTen2pX9dBMq8Hd4=;
        b=RZSBTD3TQntRUKz+XvkBlR1WjHj3Ey/iCxI+khF0yc2FWd4MKtSJ++5XeaJP7DcCfD
         99kn4NV4x/zw4pNEwUPSBFR6j+BjEfU7eKy1MA+cKEI0fJTEB1gM2Z7+oKIN9K4h/0LW
         PTOTnesbr40+2O21i/1rhFvt9t47SBEByQSODujICFfnT9iiB4mLyVOO2MZsl6vLVcYe
         DJZQopt0lbVL2VwkGX9Yd/qygnZXeNzARNV3taH9p+1MFivRy5w4A3ZQZJuAAx/kG+CG
         BdTI+/YetTNOV7f5v0iEa//5yWlhdzQsUBncyngEa4/9tQp+5ZPm1x2uETEbmAE7eK3b
         PJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749730314; x=1750335114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPFgahJgaAGctrInOwx2SZrivmTOTen2pX9dBMq8Hd4=;
        b=I8zT5nbjcKY9oHJ7V815Mg0oqIrmVUPam94KK384joYmjfSJEE5wGwHAxCl+DZHHfR
         qHRZYK2ro6heIYFTFoOpVOMConDKwefAYIWuBNiufQnhW3TDTX3U/aEPBkIHv54UNf3o
         dNcpvspD9I+9j0pTUDwswiv1R4BW/tc55MO8S3zZ2kR6+DtVTADYmq2i99k67r4dynhj
         rHbz/nSHbxFEKSS4nWxBxlRg6BZADpW8dmqUx76zsWx97aJXvNrb4jUdTfWJL8Jp+Yul
         bcemwDsFRpDUAIcNY4oA21FYOxaeha5K0FwkxRT+qsm/tRz3Neaojj9dkFIipLmf4ByE
         FIwg==
X-Forwarded-Encrypted: i=1; AJvYcCVUuqJySx5CUl9P1LgOg8IkOGeDIbdlRPGV3TFrM4oq9qrkai99RKgBvspxaZ7/Qxbo+7VIzOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfS6v17ZaJaAjoUQm4Vr5Exab6xm+mKq33VX4/DA9ywTPxB6rz
	i4DTIED6AF/Oz6gCi6TthGLTP+JIK4aJqNxaKilPQ78bvjhwV8rvzfMw
X-Gm-Gg: ASbGnctR3Q84Jg6r1dDmSDtRGSzRONHGA89WsIRzdgu0uvdzGyroRYtA5Sq0vPOy/Ec
	DvpJN3xLNaF7kFkJwVLYEug6BfW6wmDPZ6gK2KVDPwBVWShPB8s47vZ3Kd/M6d6ZM81Meid/JC0
	nVEMKt/hNaR5rpFPJvRDiK4zRgV3KNBcE2oby5djS2wJbWuEfoG1JO3kLJbOAKo0xxfN+oCGYis
	T6O0oXcq2sZgVcvud2EUT+07+d8R579AA64yzDuumUvtur7c4w1XmV04l3rJN/a7l163H7ZXnOs
	k2wXR9jPdXnOliRjoTQvt+bI1czZwVAkKIopX5iBcj1PMbsGCqUgGtETz5xfgej4MlOo5/D8xCC
	k
X-Google-Smtp-Source: AGHT+IF/i7HY0yBgWClFgmaoj7Q2zIAQcr8SkZQvtZh9pu49tVLxDtbEI5FSL18WXmyiV1TLtHkH0g==
X-Received: by 2002:a17:907:d9e:b0:ad8:8efe:31fd with SMTP id a640c23a62f3a-adea9a54103mr265329666b.52.1749730313441;
        Thu, 12 Jun 2025 05:11:53 -0700 (PDT)
Received: from [192.168.100.182] ([185.72.185.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adead4cf274sm125210466b.31.2025.06.12.05.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 05:11:52 -0700 (PDT)
Message-ID: <674de0c8-5d90-4850-a7c8-b3129a2f79ec@gmail.com>
Date: Thu, 12 Jun 2025 14:11:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net] af_unix: Allow passing cred for embryo without
 SO_PASSCRED/SO_PASSPIDFD.
To: Kuniyuki Iwashima <kuni1840@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Christian Heusel <christian@heusel.eu>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 netdev@vger.kernel.org
References: <20250611202758.3075858-1-kuni1840@gmail.com>
Content-Language: en-US, pl
From: =?UTF-8?Q?Jacek_=C5=81uczak?= <difrost.kernel@gmail.com>
In-Reply-To: <20250611202758.3075858-1-kuni1840@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/11/25 10:27 PM, Kuniyuki Iwashima wrote:
> From: Kuniyuki Iwashima <kuniyu@google.com>
> 
> Before the cited commit, the kernel unconditionally embedded SCM
> credentials to skb for embryo sockets even when both the sender
> and listener disabled SO_PASSCRED and SO_PASSPIDFD.
> 
> Now, the credentials are added to skb only when configured by the
> sender or the listener.
> 
> However, as reported in the link below, it caused a regression for
> some programs that assume credentials are included in every skb,
> but sometimes not now.
> 
> The only problematic scenario would be that a socket starts listening
> before setting the option.  Then, there will be 2 types of non-small
> race window, where a client can send skb without credentials, which
> the peer receives as an "invalid" message (and aborts the connection
> it seems ?):
> 
>    Client                    Server
>    ------                    ------
>                              s1.listen()  <-- No SO_PASS{CRED,PIDFD}
>    s2.connect()
>    s2.send()  <-- w/o cred
>                              s1.setsockopt(SO_PASS{CRED,PIDFD})
>    s2.send()  <-- w/  cred
> 
> or
> 
>    Client                    Server
>    ------                    ------
>                              s1.listen()  <-- No SO_PASS{CRED,PIDFD}
>    s2.connect()
>    s2.send()  <-- w/o cred
>                              s3, _ = s1.accept()  <-- Inherit cred options
>    s2.send()  <-- w/o cred                            but not set yet
> 
>                              s3.setsockopt(SO_PASS{CRED,PIDFD})
>    s2.send()  <-- w/  cred
> 
> It's unfortunate that buggy programs depend on the behaviour,
> but let's restore the previous behaviour.
> 
> Fixes: 3f84d577b79d ("af_unix: Inherit sk_flags at connect().")
> Reported-by: Jacek Łuczak <difrost.kernel@gmail.com>
> Closes: https://lore.kernel.org/all/68d38b0b-1666-4974-85d4-15575789c8d4@gmail.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>   net/unix/af_unix.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index fd6b5e17f6c4..87439d7f965d 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1971,7 +1971,8 @@ static void unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
>   	if (UNIXCB(skb).pid)
>   		return;
>   
> -	if (unix_may_passcred(sk) || unix_may_passcred(other)) {
> +	if (unix_may_passcred(sk) || unix_may_passcred(other) ||
> +	    !other->sk_socket) {
>   		UNIXCB(skb).pid = get_pid(task_tgid(current));
>   		current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
>   	}

Tested-by: Jacek Łuczak <difrost.kernel@gmail.com>



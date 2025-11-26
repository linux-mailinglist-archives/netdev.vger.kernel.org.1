Return-Path: <netdev+bounces-242097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C61C8C330
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 23:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD1C3BA06A
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 22:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E1D34572B;
	Wed, 26 Nov 2025 22:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ceh0248k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6163446CD
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 22:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764195545; cv=none; b=S3QGkcMNBUj670uog5nRz2JTCOYzRT0+9kdNx2Fv0RGf4u9JKwaMEa0JwydqMTcjo6qHR737PBUI78kj/vkDsBljd0EorePjZiDGkydbk7FOf8c+OYZTW/Yjd9PqpnRe9eeNBoD9+H7ZfAv2PMg8pJOya9BEp4iRSx+lo3Igk4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764195545; c=relaxed/simple;
	bh=sIWbRcx7sC05bYi/YIY2zR/NKUvh0KWELOSEGo3Hfzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFmDi/3IFdJTfsH0nIzsTiNA5UMf+6ggAp35I4mbTIVuRgdd4et0/kYEZbS3MKRn7lviIjrN1u6UFqqzl5akh9eTT465udQDw9bJ2HRfVdi5zQFP6CcjwTrWw0Sac4sj8X9L+hLfAfHyzw2kMj84OGbPFbOcrlBjav9GL7UKkJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ceh0248k; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-94964256caaso10486739f.3
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 14:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764195542; x=1764800342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1wowXlow3FMc8/tNrN2yLigPPDUDtx0JGtrYUEW5hUk=;
        b=Ceh0248kyaTc90MipJKQFJgX3pPuS4aCyr7FKFyuiJzy3OQ/nOTtsx4lt5ihaAC9Jf
         wAT2Q6NI1gM6Oe9YzpFy1mCOAbkJ0fQKQerimlqRWQRutwNWAvyCJI6vn+tfrP23Uy+k
         qIutfsaaHsQ8qoU/9dqZE/Y9eSb16YwGVPjVgqEyzZWUHY9ElHelTOxsrCwiO9qlYOpB
         Wp2O43aKUDOL0CaR0d5pgOfUYklhoKpoivCoYqr6bCusqZCPvTaAxRDdumWMNf2YJaHK
         rKIhcr45r7JnISjXQxWENBcHmMnuTI0TxuapbThn+Hc9e4VP7M4F4mFpdqbHIipsHI5O
         sSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764195542; x=1764800342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wowXlow3FMc8/tNrN2yLigPPDUDtx0JGtrYUEW5hUk=;
        b=Bar26I+D2YG6ujIIjiMux35orF2ZsSLx7/0hfqpcV0DPuvRkR79pbySSlFtd4dHJIe
         NEpKhl7R9NMa0vq39XJYHvqH2QsymmDxY9Qhd2eXfOGDySTd+Sg7QSUo7PwTn8bRsYGw
         ZLZmNBT+8TfZP9W0z8n1KKASn0uqr3QkqHZXt4lKeL7GZKMTIfPE2SShZOItR8NVMqYW
         tKRhUITG07txpcfGRbToWflqybOlGGXY3KT4Fe6HfMUWhPDUV0xSnjuhhdDvMfgHENjy
         pg4HSux/5MLIxiXJS4DrnuC+rFSpQUdpduociOQvxv25ELS6MFlARNTPn56zJNp4vNGJ
         ZUPA==
X-Forwarded-Encrypted: i=1; AJvYcCXeohbqck9YQe8SEOIfUd7Mji9zCGHwJUuTgQSqTclM9XLBqJx1oEE3aw6oGcv6nLOhIZcg/Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI5/Vu6Y8PnoCnxy8PQEEncxFjBBWNJt8obN83Pnfj6/X/wgps
	7IWsmmxIimcb8xqgS4xT3OcqdBc47UNiUJdR7Q/rf59RRlYvxkwZl5A51SujTYXRGms=
X-Gm-Gg: ASbGncsAvC4i4l4WciYl+FXOM9gNzk+Ea3LscBp9pRj1cYlJ9eO21nUQH7o1zZ/unob
	9SH5u1FVbiKOQcZDqgN6eWlrc8C0d7Ixo58RY6+pTCKmZHm6DEDIJ6RI226A35oES+Z4VEPCxa4
	M1Gzo7qWZanbJrtpB+sjRLZT50PuOvaHohEr9tgjQ47rTNn0BFh+NP80U4E5fY6epd/KFD3NfmA
	GmO8kEQU6DBpGoolG9TcijudvWHWpqP6kNPwbxiHEmRKDuWrhLLMXXQoQQPlkDM28dWE6o/4WEg
	96wlaiBK+Rx9ebIL0eM+ifAkemEiney44pIX/PHquH7JJDPRTSsN8otSfvDvSZ/qKxrato1Y9Yy
	P3u7w9ljAUXfDQfFQ407abVjwQ7/Cb9WQddI4fQ7oJ4N8Qop1aeyxpv6sgsFQPUcxE/BEmp/71p
	q0bsAXg5CV4ooIGr2x
X-Google-Smtp-Source: AGHT+IGxkxc8fCZt/xF4NNM9fIWKpLzM300DpmX1FeSS/Z4JaygfyFk1znrns1dtxauVsXPqqT3cZQ==
X-Received: by 2002:a05:6602:26c9:b0:948:81a5:7ac9 with SMTP id ca18e2360f4ac-94948b3d514mr1644646239f.18.1764195542254;
        Wed, 26 Nov 2025 14:19:02 -0800 (PST)
Received: from [192.168.1.99] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94938651ce7sm811919039f.10.2025.11.26.14.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 14:19:01 -0800 (PST)
Message-ID: <46280bc6-0db9-4526-aa7d-3e1143c33303@kernel.dk>
Date: Wed, 26 Nov 2025 15:19:00 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/net: wire up support for
 sk->sk_prot->uring_cmd() with SOCKET_URING_OP_PASSTHROUGH_FLAG
To: Stefan Metzmacher <metze@samba.org>, io-uring@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251126111931.1788970-1-metze@samba.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251126111931.1788970-1-metze@samba.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/25 4:19 AM, Stefan Metzmacher wrote:
> This will allow network protocols to implement async operations
> instead of using ioctl() syscalls.
> 
> By using the high bit there's more than enough room for generic
> calls to be added, but also more than enough for protocols to
> implement their own specific opcodes.
> 
> The IPPROTO_SMBDIRECT socket layer [1] I'm currently working on,
> will use this in future in order to let Samba use efficient RDMA offload.

Patch looks fine to me, but I think it needs to be submitted with an
actual user of it too. If not, then it's just unused infrastructure...

> [1]
> https://git.samba.org/?p=metze/linux/wip.git;a=shortlog;h=refs/heads/master-ipproto-smbdirect

This looks interesting, however!

-- 
Jens Axboe



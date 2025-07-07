Return-Path: <netdev+bounces-204507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C54AFAF08
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 10:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729F0189FC90
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 08:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ADA28B4E0;
	Mon,  7 Jul 2025 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OvnvMYX9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE22286D49
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751878604; cv=none; b=Dk9q83SoYb2876RWqpynlYe02gj8kznsxyOkl/QVFCo3QOV8rZL/PNVlzC23/K937p6IAJSiIXoAGrTxqWZtQYiAKRZpB7i7F7hyds/7ha+omlxP7HTd1pnCN7Eerp5nc9nDYcjwI9RJVEdMfT+DHISVB1G8DsJOOy6p+qv/s7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751878604; c=relaxed/simple;
	bh=iEBG2BEB+4++NdmPSsljo6ZDbAMgpxt5MNGltsMo79o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bpju99K1OcBtRQWhwfPfHUZUWmRgEINQDg2YiK7e5paQbQeh39ZB9Gngi9WN/JoM7N13v0whFUwH24ezio8tAYF3HjYUOFtA6M0JtFru1TJcdxaLvhhwEGKlSzGtpVo/B1oeLzf6iQASVl4c05s3DdDxoR6Mq2sF0uAXGqXovD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OvnvMYX9; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a818ed5b51so20619641cf.1
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 01:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751878601; x=1752483401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEBG2BEB+4++NdmPSsljo6ZDbAMgpxt5MNGltsMo79o=;
        b=OvnvMYX9NI7F4jdOw+2cR48Jgf66vLOXC2kRva5KAC7BoItetnhd0F70+EukMx3VxC
         w9iS0YjUUEbvXwg/zt1+/2S+4e093BwaIbJvxDjhWwwOGeHuRHRLPBlP0RJUX8a3dNhH
         Fk05O6I3jsae5b2c806xJWz8e4QhVh8VF8n1/bjtWyfpOPuqYFKWDiApf90EY2vcYHXA
         MbJ9eQxv0ML1qzhQav2qN7/PMqoCyWbr/zIr3aIl32xK4LOM7Ncg21iMBJXSu/hNTxfh
         IN3HwvRmpL8UB3eNl/LbTWxUbW2CooTS3tRqNvgkyZitT3Cms7N0azrEpPT52pyWWn1w
         py5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751878601; x=1752483401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEBG2BEB+4++NdmPSsljo6ZDbAMgpxt5MNGltsMo79o=;
        b=AHh8m+CVSA7lPqDV3jgMQvnVggYATVSbpXU5lmyLy71Ewermrd+jeewPgo9YJVhrDk
         cGyRWPLkpBdoF3wnMGCynhyU66jD88uq3qQd/XzzRYQ/4lT9elEG/ltorFr+E4SOCZ7b
         vCEVTYDt6Go2gg5CSituEgyrsi4OAlV9i4EumKLeveoWyOh6MOfurpPZabI83S7Cm4VP
         NKNiKztcRWB2NRExVPWniSUeQR8+1u5HuQLBTQEaHraWx81aUy6p1knV/Sp92M5nfr4v
         8d+0TUoSbeIM9rk6SGZvYpg8t5yMrYJin24xttOz9drosGIXzuD28ZYARqoLYYgMqZvE
         uT0A==
X-Forwarded-Encrypted: i=1; AJvYcCUVqADs1d2mzNdHPKHEm3DW1VDGttKNNqMQ815BDu0RC1GViFOaNV3l5dPNLMxSTt9F4tigq4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/q6MhJ3bT+n+JaeOt/UXw9l3KTEGGDJjmRjM7H2/dVkCqLDEk
	fOcEfsYwy712yO2rOxuMFSa2aoUbeIjyeBfHExjfmXzE0HcW3Ovgfi8hHxkKelJqr4A6zCp3qef
	oowsejvwnbhiw8lGIRM1mLjs5JrUqF9O7FOmqAsNw
X-Gm-Gg: ASbGncuweym+mHXrsMQUKeclgPKNRWwkNgSXBdJW2rzeyJx7sDXgiXVNl0hvGBrPXU6
	wKHeDXwo6+DeF5yx5vFZhRi0eDnwE5pWbIShXCdoogvqVHfJ0Or0525QDtO1F7XMWL1G8oKg12Q
	9LmiTTXYP2khEm3vcVMNsd9x1DJVCy2xq9/3xkZz9h2g==
X-Google-Smtp-Source: AGHT+IFbzUAR3AySOZHQnI850gnAOGSVbPTznUZQO+5GoyFC+wzpGVkSnFFUye/b0rqpA9VjDDYLKPqKJM/0yjpIgMQ=
X-Received: by 2002:a05:622a:5a8d:b0:4a8:182f:3514 with SMTP id
 d75a77b69052e-4a998887abemr208128351cf.49.1751878601008; Mon, 07 Jul 2025
 01:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707081629.10344-1-luyun_611@163.com>
In-Reply-To: <20250707081629.10344-1-luyun_611@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Jul 2025 01:56:30 -0700
X-Gm-Features: Ac12FXxsVtFZYPSQQ8yOqY-Y4CGMr7OVeyACAvTT4OXgLrXgDJmzFwLGe1Exgfo
Message-ID: <CANn89iKZRpJVduH0WZ57pqRaEma-HB2ymi9P9Q7aK-f7Q8r5XA@mail.gmail.com>
Subject: Re: [PATCH] af_packet: fix soft lockup issue caused by tpacket_snd()
To: Yun Lu <luyun_611@163.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 1:16=E2=80=AFAM Yun Lu <luyun_611@163.com> wrote:
>
> From: Yun Lu <luyun@kylinos.cn>
>
> When MSG_DONTWAIT is not set, the tpacket_snd operation will wait for
> pending_refcnt to decrement to zero before returning. The pending_refcnt
> is decremented by 1 when the skb->destructor function is called,
> indicating that the skb has been successfully sent and needs to be
> destroyed.
>
> If an error occurs during this process, the tpacket_snd() function will
> exit and return error, but pending_refcnt may not yet have decremented to
> zero. Assuming the next send operation is executed immediately, but there
> are no available frames to be sent in tx_ring (i.e., packet_current_frame
> returns NULL), and skb is also NULL, the function will not execute
> wait_for_completion_interruptible_timeout() to yield the CPU. Instead, it
> will enter a do-while loop, waiting for pending_refcnt to be zero. Even
> if the previous skb has completed transmission, the skb->destructor
> function can only be invoked in the ksoftirqd thread (assuming NAPI
> threading is enabled). When both the ksoftirqd thread and the tpacket_snd
> operation happen to run on the same CPU, and the CPU trapped in the
> do-while loop without yielding, the ksoftirqd thread will not get
> scheduled to run. As a result, pending_refcnt will never be reduced to
> zero, and the do-while loop cannot exit, eventually leading to a CPU soft
> lockup issue.
>
> In fact, as long as pending_refcnt is not zero, even if skb is NULL,
> wait_for_completion_interruptible_timeout() should be executed to yield
> the CPU, allowing the ksoftirqd thread to be scheduled. Therefore, the
> execution condition of this function should be modified to check if
> pending_refcnt is not zero.
>
> Signed-off-by: Yun Lu <luyun@kylinos.cn>

I think you forgot a Fixes: tag.

Also it seems the soft lockup could happen if MSG_DONTWAIT is set ?


Return-Path: <netdev+bounces-198796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F218ADDDC5
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE6617D776
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 21:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2492A2F004D;
	Tue, 17 Jun 2025 21:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JmFCHOE5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5BA1F8725
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 21:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750194966; cv=none; b=Ceq/Tn7VAOREg863IxlHjJETdYx5e63L96HNQzGOboqGPgabD6z+3GveI2fKXVga87qhpR+OA5iwtCoKx80NOZBE40CM6KEz14Nb+kC53NiMS2UyNoswXQXZAkJiI86y/sjrSD0EzjdoT+4By2PO03P4TloNbYdh7jKc/Cl/9zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750194966; c=relaxed/simple;
	bh=9eBtcygy47SZb5VaeO9DG1Ep4wTwbollzhARKjEHGfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6APs4vqCYEoQADHjN3MnpeKM9i5l/aoEFKMY4pTOqXVMLMwjQhnMY3PhOJs+ox5zBBPWIw/edo9dW08bV+qF9A78N2//BGXstnmbGAHsodn07SC4QKPc6+s8OM4L57vVRMiMAnVgWe1cb9sSCixqseaR99NlWx0eZlrWdNxcg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JmFCHOE5; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso753a12.1
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750194960; x=1750799760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eBtcygy47SZb5VaeO9DG1Ep4wTwbollzhARKjEHGfo=;
        b=JmFCHOE5IPHZNxfmklG3p68R5XXx/0ZXZRgC8dpv8tADhYB7vwA8I+f2qXKfV7xF+t
         mrOwWi8wP0oVi0HP+J4ooT8c3HR4xdo1b5j5aolo9ygQyYbuYCYDHN0wadQC/0Q6HUv1
         ooaEz7URXhJG6OzCl35sn1R8zTVKzvc0xJET6ONsTXk145VOKgKCq5mwehh4Qr4E7wu9
         zaGVvJUgC+nBmS5N3m8TVqpPrIWXdwPrhh3MY/dLo9fJhWXiHedf2Z8Tr1yetydNEuaW
         pVoAwtlDRjE9jQu225R8JzTmVNI+35PTZoR2g7mLSKvth86acrvqOai3V69Ks8meXzxv
         FzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750194960; x=1750799760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9eBtcygy47SZb5VaeO9DG1Ep4wTwbollzhARKjEHGfo=;
        b=jboUqwdvNFeTMbwmeh+2VIXIa8xo4enWbenOiVXOkB9QiQZKMmlqfqFoKXkvTo4Gcq
         ntwM1EfRmI3ITaTx4Q7OFs6MfYsLbssJqzqCpzCGlVx4U0OlTNPHTq1OCQKAFkQbwIvN
         8bKHaAUJBEq9c/TgGEHUrFuQn6fVUFpeXzqacWLlRu6ZVTEJvF0x26V2sdysUoOEBmAb
         1KkxyZoXZejAKfbNM2vuI9oeyOVOrTPsjxabjK3H/OcShI5MQbIws5EplrnraaT1orkp
         9BijyZXOCnk7IQFXB+ehaNELnA8Gbt7DgskArWrUy+om3ktEkfCXDTO03MeJrYQdDnqW
         sB5Q==
X-Gm-Message-State: AOJu0YyIl/ECDa3n0Xvk3jbQNvF+kIUNbs8tqy1b5QZdm9r9pTAILXom
	7mBwvwGvEcN8WMFf8/YWYVN/NDoKofjsSt8hX1ilhgAak6d534doAvDKhXy5FOA7KvPQJ1W6SHC
	WYJKuhk7KSypfY6dODQtE3DiYoJlHqKJXOSrXm1XiXiwF3MZCJQoPTzZTMys=
X-Gm-Gg: ASbGncuhc8BEjyS0RiLQEU3dqxmn18wcZhU1v++Fu/6HraV8rRhA7TDy30/xWTCo41y
	I2uOJ+Vy5VG61USIAsSmJOPcKuJXvO8Hfy2bO/uPBI1djn5ns9AV/+eTCLqu7Fi70yKHVdFpyZK
	LyjTxfVJZ6Rm7UAwAOWyWZxp4TsAijenN9T/A2LMkE9pt8xlrzgiXXGwW/P3wjeAs7I4C4+mWXx
	w==
X-Google-Smtp-Source: AGHT+IHSguIdelAkEXZw7KrekBLLZrXMrPoAP77usy+Fpa+804VQRdA4lcWnIyN3aCeWYBIHcg2/uwaXDI+XywBF11Y=
X-Received: by 2002:a50:d659:0:b0:606:f77b:7943 with SMTP id
 4fb4d7f45d1cf-608d2ea893amr273467a12.0.1750194960150; Tue, 17 Jun 2025
 14:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617210950.1338107-1-almasrymina@google.com>
In-Reply-To: <20250617210950.1338107-1-almasrymina@google.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 17 Jun 2025 14:15:43 -0700
X-Gm-Features: AX0GCFtm4NiCq-JdE7LLy3ZIpgaVJe6qSvO_oE342Pmx2zZ8EF2vpAd3SdtCHbo
Message-ID: <CAHS8izMWiiHbfnHY=r5uCjHmDSDbWgsOOrctyuxJF3Q3+XLxWw@mail.gmail.com>
Subject: Re: [PATCH net v1] netmem: fix skb_frag_address_safe with unreadable skbs
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	ap420073@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 2:09=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> skb_frag_address_safe() needs a check that the
> skb_frag_page exists check similar to skb_frag_address().
>
> Cc: ap420073@gmail.com
>

Sorry, I realized right after hitting send, I'm missing:

Fixes: 9f6b619edf2e ("net: support non paged skb frags")

I can respin after the 24hr cooldown.

--=20
Thanks,
Mina


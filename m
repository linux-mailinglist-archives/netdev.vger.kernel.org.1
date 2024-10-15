Return-Path: <netdev+bounces-135458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDE999E026
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310842834C2
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 08:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5516F1B85D4;
	Tue, 15 Oct 2024 08:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vdladWKj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BE11A76DD
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 08:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979294; cv=none; b=V6DSyftKDZ+j0+az6q8BPRbgJ6JxfzgLIChPNOdKejP0KvKtNZFPYEtuhpPqwXcJbs2Q6wWKIeRBNAGz48O1BoVxxG3p2DFxhFWfsQFRoI6SsjygKVkunFrpCF8g3u7BpSZ87qL6zZmXiUh0sr5HXHfR3h5mu44dqgp9WjhS1zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979294; c=relaxed/simple;
	bh=zj3VWhc1JXRNGK9CsDmZf0eapyKovX4dwjoqx2Q9Dio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7bJnXymsP1xgi62WGz+a/snWfvTkP36zCyT9rvsV4vhOvDZ5QpWqEscgUGA0NnSxjNxY3DqHNaezbffz2rQ0GjmZZq788T/04qa0kNiOnMTx1SEjDtX43lxoSDnZk8CfeETP17eObP6VfMZW58+BarFEtmhbtBCUZWN0IGOqcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vdladWKj; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb57f97d75so13112301fa.2
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 01:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979289; x=1729584089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zj3VWhc1JXRNGK9CsDmZf0eapyKovX4dwjoqx2Q9Dio=;
        b=vdladWKjT8WI2KeXleLj+/RcHhaLevl3oykRwHEj/ZVgkBv+hL95RJrvL0saG80l/8
         hvx+1Bb1fYt8letMQFveFcCn/7Bv4jMkKa0GTSDnD3WgpUDQmfKAbHlR90919YTxYlWp
         /MKxgZxRQSW5cvW6EI7vce1MPENxpdKmJ6vR1xTOZ56Myl5y/gBhADKnF2ML2nSNJBuo
         0CKgDhB/60XRjW7udytqDzU1zPwXbgv1lbIUxq2RuRGLH7WPD8QszDkoRbRkvyjXEJKE
         TyOi2XajDVnvWzSjxTBBTQUyU6PTe4QPzhkBn9L++TPSKc9bEbq5VQX4T7pRQg6sYw9v
         cyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979289; x=1729584089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zj3VWhc1JXRNGK9CsDmZf0eapyKovX4dwjoqx2Q9Dio=;
        b=R3475d562+6iZVWmTZXOKuAFpSJpXmaKYhN/OW9btOI+zwYTLu6NgIdZLGgt3cOfWF
         dSA1y+xWe6cZXmh7ffaBYI8vW7jNx3It7/nBqPXrn9RgjsAmlbenb82W0TSMdtBaD+bH
         kmikFGf/NbjngVgsyqY41e9Ljs8HtkbBxBlvCgHnq/oPPrkhT1mk+ROZfFbCetlmoOAo
         SpM47wkFvmQddvb2RwPdQcy9yMJAi5nnmwWJnnByr/XrTnJ6lQ+sVHNasIA6eGcD/3kU
         H0hfywAEZ/2++7JEdPjneIz9wKuhhUi+Qf/56M1rp+mBDQN57nI1cUz3Fvc/J15aXVQQ
         JZdg==
X-Forwarded-Encrypted: i=1; AJvYcCW3gubYkAPzZbsmDmJjAUmQ/nVnYyE1vNUxmfjAUW35ZM/APZhoztwiIOolmuZIVAKyMQdVfYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEquSP9SyKdtN8leBsyVzvKZrd+TnbQb9e4/zfzMEP/HwPmLeM
	zRCGY3FA1CsgDa87G6Ae3kLTm5wcd5uQnraZ7NwbT3yexpr7V8B8CywMDgLmnk0AMbNFk+TMUTf
	7RzagiIggU/uPoAasfvERPRoxe/yB4fmBbvDn
X-Google-Smtp-Source: AGHT+IHxfKaPProiszu4hPKA2JsWyWKW8QC7WkdMfm3qCN+vO+7OHhDa8OoE6YIicZSOeQRLIab3tjlWn0zyThhZ2QU=
X-Received: by 2002:a05:651c:2120:b0:2fb:5d8a:4cd3 with SMTP id
 38308e7fff4ca-2fb5d8a4f7cmr6486501fa.0.1728979289048; Tue, 15 Oct 2024
 01:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014153808.51894-1-ignat@cloudflare.com> <20241014153808.51894-2-ignat@cloudflare.com>
In-Reply-To: <20241014153808.51894-2-ignat@cloudflare.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:01:17 +0200
Message-ID: <CANn89iJ0i+k_wHn-aoafY1V+mJ8TAS1DzQKnu1KkjusAWLNuyg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/9] af_packet: avoid erroring out after
 sock_init_data() in packet_create()
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Alexander Aring <alex.aring@gmail.com>, 
	Stefan Schmidt <stefan@datenfreihafen.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-wpan@vger.kernel.org, kernel-team@cloudflare.com, kuniyu@amazon.com, 
	alibuda@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 5:38=E2=80=AFPM Ignat Korchagin <ignat@cloudflare.c=
om> wrote:
>
> After sock_init_data() the allocated sk object is attached to the provide=
d
> sock object. On error, packet_create() frees the sk object leaving the
> dangling pointer in the sock object on return. Some other code may try
> to use this pointer and cause use-after-free.
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.


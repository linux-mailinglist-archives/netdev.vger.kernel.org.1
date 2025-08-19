Return-Path: <netdev+bounces-214796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DA0B2B533
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 02:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99377526C89
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 00:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D11523A;
	Tue, 19 Aug 2025 00:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dCBBE1A2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6D42F4A
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 00:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755562043; cv=none; b=qPnvNUDMjkfX4ylCoSpxFJ0/5D3TGC6ZznMiswLI6sij1IsxhWmYrZy0+3GIn4tjDSGIlzLFbwyi15lJU8/+Np4tiBv39EVbU6gXnFtfGrTjXsd6UsIcuU+YHPHmLKRr6KQkMMNbiCAXl/xLXoDTUbWFx8jNY/yY5a41SvYfDX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755562043; c=relaxed/simple;
	bh=N3pRRETvDbhldeHYBaWwj/U2MHd/CSkmqAYUU00fkCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6XhfoU2TlxQcQKttfzTBZRGPhEooOjp5DGMEykkmmo22bx2H14N0UKXvLYyxkrmZV8g0Ccb6MuCexSrCUmurMun/RlfJe0COSZZk67TsTNIL/QqHh8reY4cmtFgE1FCCsgIcAuZVl6gjRMxo6J71crm3Oz4SB4GUXEJj8rFqlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dCBBE1A2; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55df3796649so4280e87.0
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 17:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755562040; x=1756166840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3pRRETvDbhldeHYBaWwj/U2MHd/CSkmqAYUU00fkCQ=;
        b=dCBBE1A2MlkuYtxvbmUansJU1Cp7lGhUCpelkoEIbwZIpEUotb9TzosHXI0arG2w7y
         d2CnPU/s2yejoJb6U+HdFxoTAnxOnKWXnuS1Eafb1J8oOKrwYPaslGIvWWlBhLTSarD7
         u/LdkycVgXdTi/A0z3DO9QcIG0wirxP1NG9k9fd+ZZHjdWsGhU14opWx+P1QIrDDtoiX
         Sk2KLyGt/1Kb5btcOOmC+zJOEPXbWfg4kXI9t9oHxkUkVVNypFh2GUvcG9EGrU2IZVOU
         MnjpLmhE7Koeti5BjzbqRK40qL7wgdyZpVZk2LoU5C8NyeE7cJaQrBj32Lk3zQJP7gkr
         F5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755562040; x=1756166840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3pRRETvDbhldeHYBaWwj/U2MHd/CSkmqAYUU00fkCQ=;
        b=VGdbeXwRvqWQi6hj1BCL/o998kYVAgN+iezwPB5CxG5MjjdFtliNFg98IPJHuQF/1H
         BeWz+fhqZ+o6Kp0S637eZI7acgRW8y5nJGkZjkWaXcXWXq6+TJQwz6dsFNvMfzRDtdW3
         kIizfsuo3zQlLqKU1t/NkGBZcK4sniVGwbd/AC4qyxKtSfxV7X5zRUx1Ia2sFguJ52/b
         sCUtkhKFEeWxkyH9FfdOzFFlq6S27WfeWGfDPVcquHFECebG4Sppw/ZIxkyRrZXOejxN
         fB0T87lxFKxseBbFc74wiNTCjYvufu9u9NUkzWdwnIYoT3YeiUoe+efiZlW3CD9/0cPi
         Ipcg==
X-Forwarded-Encrypted: i=1; AJvYcCV0zXgbPYMIbRk2eW3lshXMadC8xHBHtLsMfWlJho+62Yxi3Yv0IElBIvYeaa9P0xt061CBOwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSnXTCDR7iHNbLpbGxkXGX/AAexjLe1USmdfKmufSHj6wtgmSJ
	ST0Q8NsMXsAcgcX+eGgIXe4wEGKBTU9edBaNI86ZRGvRLMCIBp91+UhS+XyhEs8aZFf44MwaeTg
	xQZDiQeOfvVOO/DcDWjpcxcrkca1p3jCASFddWEQP
X-Gm-Gg: ASbGnctI2hKSulI6L+qnwLKIqGzpsCQSun+rYjXdavH5ELt0gznXjN+7zy8zca+JtVH
	+eEZKjOiwRbTDVXkjYbIE4mpqQaiPD3QGjn3p5VA4Ex0rHvGksvcKa2OomJN9D5VAYCVNGD3jkI
	9bbPs1JEKXhTw5C2Gx7Cdzb9Sp0QgtlB/k2zyQzVNp0MW2WIgir0mH8xlJhOt7+uhOQYk5Hvr3n
	UdPARnYh9TiJiV8bo4iqh9DbQ1V40LtA2HwqsWyWRkXWprFG6t/vSM=
X-Google-Smtp-Source: AGHT+IH8QR9XM3HVwygeTPkrgKju8SNdrS1lWW8eUw7kKiB8f808XKy73VlR0zxzRFL1iygyhjeNQ1MNS+CqwEdg714=
X-Received: by 2002:a05:6512:e86:b0:55d:9f5:8846 with SMTP id
 2adb3069b0e04-55e008bca39mr96231e87.0.1755562039838; Mon, 18 Aug 2025
 17:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755499375.git.asml.silence@gmail.com> <d36305d654e82045aff0547cb94521211245ed2c.1755499376.git.asml.silence@gmail.com>
In-Reply-To: <d36305d654e82045aff0547cb94521211245ed2c.1755499376.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 18 Aug 2025 17:07:06 -0700
X-Gm-Features: Ac12FXys-FgbC9QrXib0NwGDYjFEejqhlssYCN6AMvN6gxmzcokZAnqcu_SvM8o
Message-ID: <CAHS8izO_ivHDO_i9oxKZh672i6GSWeDOjB=wzGGa00HjA7Zt7Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 04/23] net: use zero value to restore
 rx_buf_len to default
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 6:56=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> Distinguish between rx_buf_len being driver default vs user config.
> Use 0 as a special value meaning "unset" or "restore driver default".
> This will be necessary later on to configure it per-queue, but
> the ability to restore defaults may be useful in itself.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

I wonder if it should be extended to the other driver using
rx_buf_len, hns3. For that, I think the default buf size would be
HNS3_DEFAULT_RX_BUF_LEN.

Other than that, seems fine to me,

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina


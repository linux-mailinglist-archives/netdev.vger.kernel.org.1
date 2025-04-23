Return-Path: <netdev+bounces-185274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2DCA99980
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 22:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9C1462ADA
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 20:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079D72673A5;
	Wed, 23 Apr 2025 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IqDCa3UN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E7B86331
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 20:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745440515; cv=none; b=isVgpn9E2b6xUjGklb9DsiBz6n4VG7ZotBCKvc/+IqxJMeTbpDdD6S3tphPQtaM+y+n4Wb7yIZMp5nFxuvQkCjWK5zb2rXSfl5Qj7Nkwmb3VnTuDGlsxhwIJeu1663UzKoX09rzYkvP/tXfaI4HcGEuVgwCCqh4IevvS+bIuagQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745440515; c=relaxed/simple;
	bh=PGaUAOiMiKZNW6eo55PaYE59RLvATWcy+aE2Rl/g00U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/M1UexSMz7AflAqUgoKHzjkcnEYUB1IidIhkwTXjJJwuJyQdtA+bayggPqvVKersLzCF36JZL8bE/JbcRo+SAS1uxqqm0dB09GTHz39aHwIBNCA9ax97fP5JoDoClQsjEmqZ6PpfMb1Wja7C6Vt7krta+aTzERyl24RIsr3jjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IqDCa3UN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2240aad70f2so64235ad.0
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 13:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745440514; x=1746045314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OP6x/SvmYDWBsSwjz+wW/QLgAnSGMPtUeNJseQYliVE=;
        b=IqDCa3UN/Lx6cw3BGvRbxeLDzAPXuMFeGgGyCq0p6JP/toYYIGUSa9TarXp7BtwKPE
         i4hbW8QFTYzeYXVdedtQFIWcUBk44IhDpHSNEHlwog4KwlaQdI3lDYidv4wLP9+VM20e
         VbDEwS8yJwrKPUbT0PHGxcXvXt1JYY1X3W5ctoEfDCrnhhPQWpcmoF3Mp5K+XYkmHKVS
         wgoBynMPgo7HTxcZCYHqnUsOEFMwk7x564/ozpWT8RJE+pfhspn1OWCnO1dWx/o61YCx
         iinkvOOd4aK1Ezo7lyk3XH6BJa78qnv9n/SDoTrNmdCPGfCNP9kkP4D0HpUBIUsaMlJB
         cTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745440514; x=1746045314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OP6x/SvmYDWBsSwjz+wW/QLgAnSGMPtUeNJseQYliVE=;
        b=qfCQbe+FpWQGbMj/1maOELAVe5NrPlp3mGhC+Zh53AVEzvh6eho2UGLnoqbbXz80J9
         dtRqaYkdVVVTCIg6HsyTenQRbF6VQQ43cmvbrKq3e0jPdnB49aYEytLgsOGy6ztQ7eLN
         ErOfx83TxucCO7BNNtwuPxuLE78Lw1QBYgD0OJQxBT3zT5JklJ4K/A/eMFK/rdg2firk
         lieLvU8sAN8e/L2ljmmMNSbAggOSeXiAuDWOipdtV3kmc09N+gGIMkDJ2sk5Sp7PGWPh
         z/FkRcQV1LwW/53yGu0JvqesowgBbuTkfJWysX67+OCjYkfE6YbIzPe8JiKM9LOevyL/
         qj8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSfE2bAc084l1vCVIDJw/hASIiK+8KS0Q/zAe/cgX65HkCbIXjnnHOJrJDl8IwYosKK+xLDsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkdwFUEQm4tbt9HDmrx8glIDMuBbDYkmKhC07Aps/xJpr4459d
	TjYksrRl9mNMInuQFvq7N+v+Y2ZxwFyWnCf7e9ozIB3H3CjhigtUsIiOzJvuhifi/FZY9oD9FK6
	TT3WB1jtn8TdKxnBKw/Qv8KANAPfdXQdWIJ3BxdSPEs3X854EGw==
X-Gm-Gg: ASbGncv8+PBSvaxCL8/niqY+YCLnXbgjxyzOT+CsOthi1wwkv/ha0QIqFRQqfQQvY7u
	2rbFiHwDSjKzUGJxGZ3arkfvDzv6xt7bY4KthMvuu9/cHO8NbdZ7LE0Xu6/KDT6r06zT1kS52xk
	D7MLPF6JLQnw5/+J18DA4nX46wbuAPhuA4Q6Y9XdZDXl/sBHu/gTNA
X-Google-Smtp-Source: AGHT+IF9aV5DlMNct8CKi/1ggi7BXHKa747cmMNGnhdvKQH10y41IEUmht3O2pI1agJ6uMYbVjWnKa2umnKyNKE2HFc=
X-Received: by 2002:a17:903:364d:b0:215:65f3:27ef with SMTP id
 d9443c01a7336-22db21443f8mr882685ad.12.1745440513439; Wed, 23 Apr 2025
 13:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421222827.283737-1-kuba@kernel.org> <20250421222827.283737-7-kuba@kernel.org>
In-Reply-To: <20250421222827.283737-7-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 23 Apr 2025 13:35:00 -0700
X-Gm-Features: ATxdqUHRxDWXOEezSmyl49BciZlvxeX_d5vfrvtRcVsnl4zznyRpgT_L0moETR8
Message-ID: <CAHS8izPze3g7qdTGJ7xd9LeipVyx5cNTKisLDaT6FOTj=X_VzQ@mail.gmail.com>
Subject: Re: [RFC net-next 06/22] eth: bnxt: read the page size from the
 adapter struct
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	donald.hunter@gmail.com, sdf@fomichev.me, dw@davidwei.uk, 
	asml.silence@gmail.com, ap420073@gmail.com, jdamato@fastly.com, 
	dtatulea@nvidia.com, michael.chan@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 3:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Switch from using a constant to storing the BNXT_RX_PAGE_SIZE
> inside struct bnxt. This will allow configuring the page size
> at runtime in subsequent patches.
>
> The MSS size calculation for older chip continues to use the constant.
> I'm intending to support the configuration only on more recent HW,
> looks like on older chips setting this per queue won't work,
> and that's the ultimate goal.
>
> This patch should not change the current behavior as value
> read from the struct will always be BNXT_RX_PAGE_SIZE at this stage.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 27 ++++++++++---------
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  4 +--
>  3 files changed, 17 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.h
> index 868a2e5a5b02..158b8f96f50c 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -2358,6 +2358,7 @@ struct bnxt {
>         u16                     max_tpa;
>         u32                     rx_buf_size;
>         u32                     rx_buf_use_size;        /* useable size *=
/
> +       u16                     rx_page_size;
I think you want a hunk that sets:

 rx_page_size =3D BNXT_RX_PAGE_SIZE;

In this patch? I could not find it, I don't know if I missed it. I
know in latery patches you're going to set this variable differently,
but for bisects and what not you may want to retain the current
behavior.

--=20
Thanks,
Mina


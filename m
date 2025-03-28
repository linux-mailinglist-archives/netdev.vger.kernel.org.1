Return-Path: <netdev+bounces-178170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 250E8A7523C
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 22:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAAAD3ABDB9
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 21:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB541E32DD;
	Fri, 28 Mar 2025 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P+FE6MNn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255991DDC20
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743198936; cv=none; b=mxmbMGvYpicnoh5N1f5sdYjPudaXfi1G88hz+Jhh7xn6pn7v7NtzPMwdlAO6xEXAvQok73lVjVFMstcuXkmWIHu/pnyB8PlSVZhkRUvqi0xBdRdEisouedNAnpeScusyF7MF6bZrcgWtQs7y7cabf+BuKzDsXhWrlgqOO2eVTfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743198936; c=relaxed/simple;
	bh=El5loDXXcBS/7i0wh5ubyZPJ3HcN/Sar+qvsdYZ6x6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CK4d71JzJs0pN1hxqg974J+RW50OhWHw58RKhi1o5xHyzrr+TFKJxlzRyMWFvxLNg5aVy74dwptloFWHmF8tjPObBfAvAUh7oJF5hvIlDc5kVnoUcRGb0bRSeId6pZ1KKtZHv8aykdTlcddo/cJi+TCaoCTPu7QK/ehAmlkAb9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P+FE6MNn; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2242ac37caeso19815ad.1
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 14:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743198934; x=1743803734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsZiwEhhQWspXSkQpyyE60dT4r9s8T+d8Q5iCPmZ8Ww=;
        b=P+FE6MNnLaaxlLYoUBQ+WqizfVoKAjcRh063+umiJcCMazG71z7uzyEkeZYixGaFNN
         68fp90/sHQnDKJ2h6+9QWc3aKyMLrabFviDdIhGmbKOkTr/P2FE1l0gs5qNagnUDeIBp
         JJiYJ5Us32HjrvLOraq0GLZplVp13HpOTWfCesX8NFUXNj8ZXepdRAxnkaGwM3ov2HXE
         e5zen3bNK7LIkUJmPk6Cf1BL5WUoTv6pbruDTAUALZ3ax+H6Js8FqkGOpEoqhZTYS8/d
         4bz+yZEa4MUz+5TPtjj/sJeuCrEBiMyJgNRNagc9oLgA7T/EAbf18R3HIKnPKxsYABiv
         4Qxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743198934; x=1743803734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AsZiwEhhQWspXSkQpyyE60dT4r9s8T+d8Q5iCPmZ8Ww=;
        b=M+Niy/xxcSELfb1ojWK+p6BnDbz9Z8GpSu9vQ/3DRiGa4Ti2ByhhfCQWRESnUlFj/d
         37QQwFWdeI3N8tRClQxxTqk2m4tPQ/t+SLrhCTKeBnKLQ9VoWimt6R9hG6Wh9AjITKET
         Oloi7bR8GMYpUMy5L92U7fB3DC2BZGV9SjGdMIQXnCzjrDp8bL4oYQ4pz+R7BnVnCTpw
         8P0x0h/DZ2BPKzOF+oH6ZVJVfpKggVSoScZ+S7l+mKs8XUIF6o3dDRR5mWIDMYeVAb/d
         FNahU7c/l4mjmB60sHPjuRfuBlFMMQkCNK6qUe/Zwt2tVTIThnrTAfhq/3KyVVVBZff7
         Gvww==
X-Forwarded-Encrypted: i=1; AJvYcCVyPu0mo+VWdyOyBhF0sUwVTJFB8fY6titd8uvW0qYuq+/23l8OhQCefQnqsrRYbPMj+/54iU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywttd/4PBwNTXXRvN7uF6v5e0kAge4nLHRPoQuDMSWwz/RqiHCW
	SuVotIEQ2wvU7FglREsOHJIR0ZHHQH2eJXLFGFSsyoodcvmPaFvG3cRv+S0XlStWtIiZI6/ewMe
	OZlL8v59BsFNWjQ9CAZHbI/aBFLNOrTxNkXW3
X-Gm-Gg: ASbGncuDEcg2c6HmYCCb/4qUq2FAovXoo10UqYdBz+Gbh9Adp62b5ds8MuOpBZgUNpI
	BnjO9siEpZh7kKiOnXGay3iGqtt2KPFSOXX0PskTpxqoG82BqACHKh31x32VMelhMKa6Ly83jCH
	9qMh5UcXXtMUpuIXMEJi/ob4FkFnmP/hpxyS6hexGTY7DABdi6I3w05KpLk3s=
X-Google-Smtp-Source: AGHT+IGDH2kUJYzFs7pHRc4iUFzgehOGnFP3N1G5wiwmcKajmGKB9Lz5rLCIJy8IAXBq8kaba6fE54HGz96GijiWWyw=
X-Received: by 2002:a17:903:c86:b0:223:3b76:4e25 with SMTP id
 d9443c01a7336-2293092a044mr235675ad.17.1743198934063; Fri, 28 Mar 2025
 14:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328164742.1268069-1-kuba@kernel.org>
In-Reply-To: <20250328164742.1268069-1-kuba@kernel.org>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Fri, 28 Mar 2025 14:55:23 -0700
X-Gm-Features: AQ5f1JqJAv55MTRI4_uMJoAsUTn0olTYF0AM5PfkB8SHPwDWW9q77ImKSduz_Sk
Message-ID: <CAEAWyHcj15WvAb_YyRPt6XRWuCLEbe-NygJeewyxhz52_3bsiw@mail.gmail.com>
Subject: Re: [PATCH net] eth: gve: add missing netdev locks on reset and
 shutdown paths
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	jeroendb@google.com, pkaligineedi@google.com, willemb@google.com, 
	shailend@google.com, joshwash@google.com, sdf@fomichev.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 9:47=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> All the misc entry points end up calling into either gve_open()
> or gve_close(), they take rtnl_lock today but since the recent
> instance locking changes should also take the instance lock.
>
> Found by code inspection and untested.
>
> Fixes: cae03e5bdd9e ("net: hold netdev instance lock during queue operati=
ons")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
> CC: jeroendb@google.com
> CC: hramamurthy@google.com
> CC: pkaligineedi@google.com
> CC: willemb@google.com
> CC: shailend@google.com
> CC: joshwash@google.com
> CC: sdf@fomichev.me
> ---
>  drivers/net/ethernet/google/gve/gve_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index cb2f9978f45e..f9a73c956861 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -2077,7 +2077,9 @@ static void gve_handle_reset(struct gve_priv *priv)
>
>         if (gve_get_do_reset(priv)) {
>                 rtnl_lock();
> +               netdev_lock(priv->dev);
>                 gve_reset(priv, false);
> +               netdev_unlock(priv->dev);
>                 rtnl_unlock();
>         }
>  }
> @@ -2714,6 +2716,7 @@ static void gve_shutdown(struct pci_dev *pdev)
>         bool was_up =3D netif_running(priv->dev);
>
>         rtnl_lock();
> +       netdev_lock(netdev);
>         if (was_up && gve_close(priv->dev)) {
>                 /* If the dev was up, attempt to close, if close fails, r=
eset */
>                 gve_reset_and_teardown(priv, was_up);
> @@ -2721,6 +2724,7 @@ static void gve_shutdown(struct pci_dev *pdev)
>                 /* If the dev wasn't up or close worked, finish tearing d=
own */
>                 gve_teardown_priv_resources(priv);
>         }
> +       netdev_unlock(netdev);
>         rtnl_unlock();
>  }
>
> --
> 2.49.0
>


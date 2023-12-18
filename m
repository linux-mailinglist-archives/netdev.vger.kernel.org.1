Return-Path: <netdev+bounces-58605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7863A817791
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 17:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26454283DE5
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 16:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A82D1E4A4;
	Mon, 18 Dec 2023 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fXZ4D+/n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EC71DFF9
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3365f1326e4so2104498f8f.1
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 08:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702917163; x=1703521963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxF72wKyjSEZjuqzTvuY0Vstw6URgB5M3BZ+UT5BCpI=;
        b=fXZ4D+/nytFwCQpJVw5oCtdBOwP100tphgnHffhcoNNH5VOeIRH4EKHULWXqJywViD
         Ga1u8H4cnVgUgPb4d29BVgCkn9DVlVaHZImckqQ468B4p46D8u2XVTgGL1mmhqCjWunh
         uLKub/aGTxqkla0B/trTqRIW+7YcPdNoiDBHYiBzfk6qIoiVU5t/WvO2Auwt+HBLimbB
         OcsS4DLWM1eHF7Zqqi5HNdZ7OvKlQSt3k1u4URTgGPNulEaJGFar52pZEygQEmAb2FK0
         1ArCyJ4o420F/jgjm0TgErr1G5F87KoBbsYo3XNgw3KERnMJm40UkRQ6zG9c2QZMrwol
         HcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702917163; x=1703521963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxF72wKyjSEZjuqzTvuY0Vstw6URgB5M3BZ+UT5BCpI=;
        b=lBhQ7dVbK7AOiIJX/Mx3xQmwSIbBudP5AflA46tzdApMNMGDB6E6o+ikzTWSjytwcJ
         UVyyb+efIYq7Gj1FN/Y2Y0gWtZ3F0vzBsw8Y1zzsIeF6t/K2s6h081mPA9++lCghbtFk
         9ZXda4rmmtHQL5fVsDXMOzYndHmdcjQVKZNVgxYcxEcBsCuD1zCQ/dqZImBpUdFCtLjU
         mP73mkjYcl51SKf9RTdz41itXbLaC0hXe3ztnBixQ/5ihFKZG+WOY+pww6rl2IlxyDOz
         5gj5C9V8+yfJIWqLwGiYFKr4KewRxbK/okk/bEE3IcK56BlhB3S2O4ffrCfwahqEZiF4
         lZXw==
X-Gm-Message-State: AOJu0YxZfLX/xr2Z2RAoyTulKo3GpQPPmpB9qNAJ/Y9igy8LNgmV8cnR
	sI5hxTLySs3W+Qcpg8yYGc0sCf37m5nLQs/iOhCy4A==
X-Google-Smtp-Source: AGHT+IHGfFW6R6JOaRG0q4/dC5NXDsnHxuGOKtVw5DDYC+yH+BCIjfLy0MnSQI2L3kNO0XZL8vOkfR4p88ZhQAopGz4=
X-Received: by 2002:a5d:4cd2:0:b0:336:42b9:6a75 with SMTP id
 c18-20020a5d4cd2000000b0033642b96a75mr4813068wrt.31.1702917162922; Mon, 18
 Dec 2023 08:32:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217-i40e-comma-v1-1-85c075eff237@kernel.org>
In-Reply-To: <20231217-i40e-comma-v1-1-85c075eff237@kernel.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 18 Dec 2023 08:32:28 -0800
Message-ID: <CAKwvOd=ZKV6KsgX0UxBX4Y89YEgpry00jG6K6qSjodwY3DLAzA@mail.gmail.com>
Subject: Re: [PATCH iwl-next] i40e: Avoid unnecessary use of comma operator
To: Simon Horman <horms@kernel.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 1:45=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> Although it does not seem to have any untoward side-effects,
> the use of ';' to separate to assignments seems more appropriate than ','=
.
>
> Flagged by clang-17 -Wcomma

Yikes! This kind of example is why I hate the comma operator!

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

(Is -Wcomma enabled by -Wall?)

Is there a fixes tag we can add?

>
> No functional change intended.
> Compile tested only.
>
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net=
/ethernet/intel/i40e/i40e_ethtool.c
> index 812d04747bd0..f542f2671957 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -1917,7 +1917,7 @@ int i40e_get_eeprom(struct net_device *netdev,
>                         len =3D eeprom->len - (I40E_NVM_SECTOR_SIZE * i);
>                         last =3D true;
>                 }
> -               offset =3D eeprom->offset + (I40E_NVM_SECTOR_SIZE * i),
> +               offset =3D eeprom->offset + (I40E_NVM_SECTOR_SIZE * i);
>                 ret_val =3D i40e_aq_read_nvm(hw, 0x0, offset, len,
>                                 (u8 *)eeprom_buff + (I40E_NVM_SECTOR_SIZE=
 * i),
>                                 last, NULL);
>
>


--=20
Thanks,
~Nick Desaulniers


Return-Path: <netdev+bounces-74140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B0086036C
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 21:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40930B2AEB1
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 19:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5F26AF8C;
	Thu, 22 Feb 2024 19:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ci9Tw2o/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CE86AF86
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708631611; cv=none; b=hduPXVA//nfKrtNN95eEjMGxol1cB3Bxl2cEw+9z19fmG5ukSYNQQ6dXfNF3frnHx55Ep3b9sufQUCXNl2bN+ZtZ85aaFgwbvHLMOe815b6eskLWNRzqsiBxwzd2G2XhHHk9CwrPEZk0zphhqSJzwaKmliNmiS5lMTZcG+XGzB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708631611; c=relaxed/simple;
	bh=v7Lvw1at5ToQVVbfg922jXBVHEWjc2/wWHZvRYkA7rY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fuLok98NcFDq+3ELscUpO+qvnN07IGeObMug4BibtgKac0e+YqB4Q8hGzDjMqmdN/39pGiV/gJYIDPmnF9ZE8WFsSI/9v9U/zM710p1gi23HsCGvyxwu5BtPgCKixGZ3TY1eO6SdN8f/C864ukTjTOYNv9DFp0hApMR48CesR1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ci9Tw2o/; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4c857f1c18cso33676e0c.3
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 11:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708631608; x=1709236408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kozEGOJC/7xLH6aBy/2SvD0c9oKy8kT6TL2kXc3Klg=;
        b=ci9Tw2o/9nlr0pOl1j90xlI84177T1unyzEQNEBsNbwIZxRYI/+5WnVzDQpPZOK9Jb
         abU46ojoM/TPpDZ1P/VNK3gD3Fd/9YtZ+W3S3jo2eIopdJGN1vFUJ0vl7UiiW3XOF0kv
         6/yWvFJuUrtqJDAEjw+8T1dYO5GKIiZJc47Y+vBouikueL2Rj/RJuGeLoDgWjAxobxB1
         tq/VYTKplCSHztRZ30IsBgPpwL5xLIqreLnbRPTSHHMh7x9XinjowLtNkKafFPJCeluO
         /jR8zX1y8Kp4VMeCwxaoF+OX/nzrkK1q2szRsYHplIsE0dRU3ZAeamqSstItDVCR6i8k
         QgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708631608; x=1709236408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kozEGOJC/7xLH6aBy/2SvD0c9oKy8kT6TL2kXc3Klg=;
        b=b2onGOGfYTFgs3rZtui9R8a3aACcu/vk2SmtHyCnux4vwh/oy3B1JNaA5lqip7TtH3
         QUNZUs+k6RdZE+l/J3Jei657lAbtE6R8Dl0Y7RPkeWHGq1RRRDKpIRpdvHopMVNgQfHq
         Y77lHbtGEp+WtmpINDtiYb91SIho96mjB2JxerjIJjxWyAjX7P4odbnLK0ToJC7ft2Ts
         LYpR7l6ldbxZ7v1dsB55UKcsOYf4VYXE59YJRW+vw8MxTPqs6DHEPvRnTXNdfOQE6tXR
         Sy+JO4o+cJOt0CNiRlkGlNXAZoqhqULONOlyr6Zg8QPz3Z20S/qrDWqpc0S1DMeqbV8I
         cWpA==
X-Forwarded-Encrypted: i=1; AJvYcCX+j8gs3/kZg4at1a9Qrviseh09sL0ol3Ae/lus1AB5Guav47zwB5+yuVOlyhhDknB7+uJIVBm3+q1Vf4XHbSXkTA5uFjxm
X-Gm-Message-State: AOJu0YyhNkFdoVoLdNfc2SIX9g7gWapFa+NYq+E9JNsqbd4U2CHsjs0c
	U5QDSuAevVAAOKVLgzw9XcwPtRYaLzwcHAnd5azCfTg/WasSp1WhYOn/ZB7kaxhMaWS79IZbJND
	lGPQI6NreZUKGpgE7F/ijjJdAQYDdu+K1Lj9F
X-Google-Smtp-Source: AGHT+IHd1fOHDrami1l/FXC8S9WReyWr/r16zMqJ++U2IMGyqdRRRkXy54yvZV6zhDuC7vRCY24PZbj2//w/q+ZxR8M=
X-Received: by 2002:a1f:e782:0:b0:4cd:1430:7834 with SMTP id
 e124-20020a1fe782000000b004cd14307834mr42201vkh.7.1708631608338; Thu, 22 Feb
 2024 11:53:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222-stmmac_xdp-v1-1-e8d2d2b79ff0@linutronix.de>
In-Reply-To: <20240222-stmmac_xdp-v1-1-e8d2d2b79ff0@linutronix.de>
From: Stanislav Fomichev <sdf@google.com>
Date: Thu, 22 Feb 2024 11:53:14 -0800
Message-ID: <CAKH8qBsCrYuT+18CsydQ5TeauRzu0Hdz7mZQ2c0W7er0KrJnkg@mail.gmail.com>
Subject: Re: [PATCH net] net: stmmac: Complete meta data only when enabled
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Song Yoong Siang <yoong.siang.song@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 1:45=E2=80=AFAM Kurt Kanzenbach <kurt@linutronix.de=
> wrote:
>
> Currently using XDP/ZC sockets on stmmac results in a kernel crash:
>
> |[  255.822584] Unable to handle kernel NULL pointer dereference at virtu=
al address 0000000000000000
> |[...]
> |[  255.822764] Call trace:
> |[  255.822766]  stmmac_tx_clean.constprop.0+0x848/0xc38
>
> The program counter indicates xsk_tx_metadata_complete(). However, this
> function shouldn't be called unless metadata is actually enabled.
>
> Tested on imx93 without XDP, with XDP and with XDP/ZC.
>
> Fixes: 1347b419318d ("net: stmmac: Add Tx HWTS support to XDP ZC")
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Tested-by: Serge Semin <fancer.lancer@gmail.com>
> Link: https://lore.kernel.org/netdev/87r0h7wg8u.fsf@kurt.kurt.home/

Acked-by: Stanislav Fomichev <sdf@google.com>

LGTM, thanks!

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index e80d77bd9f1f..8b77c0952071 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2672,7 +2672,8 @@ static int stmmac_tx_clean(struct stmmac_priv *priv=
, int budget, u32 queue,
>                         }
>                         if (skb) {
>                                 stmmac_get_tx_hwtstamp(priv, p, skb);
> -                       } else {
> +                       } else if (tx_q->xsk_pool &&
> +                                  xp_tx_metadata_enabled(tx_q->xsk_pool)=
) {
>                                 struct stmmac_xsk_tx_complete tx_compl =
=3D {
>                                         .priv =3D priv,
>                                         .desc =3D p,
>
> ---
> base-commit: 603ead96582d85903baec2d55f021b8dac5c25d2
> change-id: 20240222-stmmac_xdp-585ebf1680b3
>
> Best regards,
> --
> Kurt Kanzenbach <kurt@linutronix.de>
>


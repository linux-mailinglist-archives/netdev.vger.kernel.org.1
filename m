Return-Path: <netdev+bounces-245809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 598EECD81EB
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 06:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA02330022D5
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 05:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5082DCF61;
	Tue, 23 Dec 2025 05:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T+AnD8fi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADA52D3A80
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 05:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766467379; cv=pass; b=CRceWX9MLbR4IHHLDeSKc2lXV3YM3f1Fj8EzKiylfwv0FSc7uct4x9PYxewAfS04zFkjVIgPrOpCD2V5BKCEQNnxssh0toWouSG7BOs32AhK5jfofH63xR3UTSKslKnvFaGmVfGAqo2PK2AUw8vpn3ssAZyuy8V4S3UcUSLAXNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766467379; c=relaxed/simple;
	bh=oGJK7EbWGJvw8eLgkhH+eBMxx16VZ+DEA6p97FBdbdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jbuJhFb86UWIVtb6sfkOZd0RrevNLlgWQo1yoRrqRaPCm+UagzwrEFb+/Nj6GIg038hAr/7Y8O4vo7r7MQvGBR+ezcgv6a9NXQEMM/dFZMW/fa/MYqQuwVbyt3ufFtHRQspbCJ8FYFiaFkhJPiHiI3BP84Vrub0FsiZJlIUHjYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T+AnD8fi; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0d06cfa93so618705ad.1
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 21:22:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1766467377; cv=none;
        d=google.com; s=arc-20240605;
        b=fJpt1RYAvxx2mg8ySyvpUL/Bu0Cc+YfJH0KJLeHC5R1Zo3C4wkkSyzE3oqMZvtRkWN
         Ojo3TvTbVF8iWDKatkrefM/5uZ/XGb5m9hpS/QkO8gHluNGzCttlr9Ef3LThmGMK2wEh
         NlIJh5bWrVn+IvnqpfURXHoNs+Awgq7hU84K6r4RxGWkRkD+JUOZQcWxS9gzygvqr/Lh
         smTj95qnXELoqeibv1Ny7lGAqt0mMO6iPiByNMcfd8H4XFgd6GBnrMIXUgJtskr/z/nv
         agcHOV3neUn5Uy0bm9MD+yK6iPJKYeS7h+iQPJ0iRW8pZoVYNBv97kTkHrKi9OaZrBhF
         s5Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+1d355ZfJ30cpaNRqr0d1jUC+0heyDKGJr2dtE+FEMs=;
        fh=aXWuYVyWZ/1/VhjI/TiBYwMtXi3rUoEU5TBb4nvjpJM=;
        b=Dj4+BV6Nlv62q/Y3KEBpmN2xAuTUE/+OcDiQBCsA6KG2u1bE6E4IuWGkRFXhZRgfO/
         4Wd5qb+DyqIV58QrxSzN8bsLmRkBCN0+vDUo7fl1W5JobH0fsoSLQeKa+YrDlv/lbsiM
         OLl+11PiLA26LCim6FhZYr7o8RYm5OojSenu4tE8bCL7lC4QP1nTJ7W1bEQQLjOoKqsE
         1hFThdUHB5q6l1Xmj5aRhx20zrohuqlaXwXu/HWqkYln+84RsC4f9vPKY+WneSLXYtkI
         PgeOe0UanQZOtxgh8Rk6Volyr9oupFrEbUnQnm/smlpBKQ1yTrP388qtbtfTnRpFzbLR
         Xcwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766467377; x=1767072177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1d355ZfJ30cpaNRqr0d1jUC+0heyDKGJr2dtE+FEMs=;
        b=T+AnD8fiYW0N7puzQ59y5ZE8NNxAcJnkCZp+qGSS16rJF38v3nSXCeFkXPqRHnso6T
         +/QWfj9Mznnuc82GzrTdPILMvDILY7gUvGVEdAgEzypJ4ok3D3ev6aEmY6drUl8+do32
         yh/HS0MI/WBd5OCIapR2jf7qpyO167LilziehrEnAdTAbntM+jhZkz1+R3B3B/HxU0Xl
         wB5CDpBGbRdO6ijuCyFcNTEzY+UXMC1d3+fLzHFhJclJ7YMxgvHz/UnRq/FJMq7pIWTa
         ZpJ/HFsJlLay/QAwzaLcwcBzlrjngizyUNmhSbDPz5fcxC3u6kxm5c6duSTGjybBjzxs
         A6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766467377; x=1767072177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+1d355ZfJ30cpaNRqr0d1jUC+0heyDKGJr2dtE+FEMs=;
        b=V5QASZqa+6rKn6QgEpvmq42/XkYexsTuzkd/FjJk0m95xlIXf8/QNOewBxWSNLtJ8b
         ekCeVSMQktm9vKQu6s9clffPICdsX+mUDoGv+/1AW6tp7Tgil/XlQ3DGj4N3r03Fegsm
         FZoOPsBL28AmFJbdm3CP/3OCgdlkwgK2iRsIRo5paOmF/Jqt60XzMa9eScnaZaEC2XuI
         dvJZregjekH90jgqOzgbLDVW1tCWsaWCfk3Kpi740rGr3+VvmiIR+lUrVOE1/jddhPhV
         kXxuW5eDw3CwNM4yBYwK5Ff8/C3iAppSGxN7d7Guzq/kLKuvMknWH63I6t8sHODmG9Bu
         3p1A==
X-Forwarded-Encrypted: i=1; AJvYcCXnmXmgf0RWxWVIcg9UjinvudVGiUZfZpkRAY6Ek2bRyB7TCDKc58zwL9vXXzp23zWVo5F1Bg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNPRJKVrAgg9yRW01efAn2cBRdexa+WFcsoNaQtEuW7rDZhOcX
	EciQlxaLL0pDlwurGXaZPRYBWEDcjfUyp8xmloR2VpnlU22jZqxrLdDxAs61s3rCfo53Kjuaml9
	xgqhFRbAUpkYx6WOPEMZpOkiBQMfuYYERQLz+P0cP
X-Gm-Gg: AY/fxX4JPgo2JmYapfmRoPnF1uAiq5AFD9YyAx879mDapFp0DxCTR/YWgzptF0RnCb1
	HKfITBKmbAMzQ7dadontL/e1tCYly2AJRe7cqyx+Koq8FGnYhpzmtJiUN5XCCPdY+0woG6teQl1
	F7B1/r4rC/32jmRVgDA6RJrCoJRX2OcMSCaR4/zmCx08zezD8l9eDX9X4vEHb3A+VCkqMiv5r00
	h6sfSx/34+KXCB3kTI/i/itjtEkXwc0DNJmvqM3uAuCvWtx5GP7auMwqTmehKOtWip/MA==
X-Google-Smtp-Source: AGHT+IE796ewa6eSOI34Wx95ny6D0dEDlp6pqYl8lO6ZDlExxp6zRlyBilOjwMmO+aQgGTlzmVsikENeUZCVAzIcudA=
X-Received: by 2002:a17:902:d48f:b0:29d:7b9e:6df8 with SMTP id
 d9443c01a7336-2a31178000emr5576485ad.2.1766467376817; Mon, 22 Dec 2025
 21:22:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222-gxring_google-v1-1-35e7467e5c1a@debian.org>
In-Reply-To: <20251222-gxring_google-v1-1-35e7467e5c1a@debian.org>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Mon, 22 Dec 2025 21:22:45 -0800
X-Gm-Features: AQt7F2pyry8b2lMOeZd253dYMktxHvkz4UlZa_MZZABhivXIq72rsBZeoCCR7is
Message-ID: <CAEAWyHeB4JgXTm-a=QpSNkgV95vVCmkeL_usFwHZNUZiS0hOEA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: gve: convert to use .get_rx_ring_count
To: Breno Leitao <leitao@debian.org>
Cc: Joshua Washington <joshwash@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 9:19=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Convert the Google Virtual Ethernet (GVE) driver to use the new
> .get_rx_ring_count ethtool operation instead of handling
> ETHTOOL_GRXRINGS in .get_rxnfc. This simplifies the code by moving the
> ring count query to a dedicated callback.
>
> The new callback provides the same functionality in a more direct way,
> following the ongoing ethtool API modernization.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>

Thanks!

> ---
> PS: This was compile-tested only.
> ---
>  drivers/net/ethernet/google/gve/gve_ethtool.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/=
ethernet/google/gve/gve_ethtool.c
> index 52500ae8348e..9ed1d4529427 100644
> --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> @@ -815,15 +815,19 @@ static int gve_set_rxnfc(struct net_device *netdev,=
 struct ethtool_rxnfc *cmd)
>         return err;
>  }
>
> +static u32 gve_get_rx_ring_count(struct net_device *netdev)
> +{
> +       struct gve_priv *priv =3D netdev_priv(netdev);
> +
> +       return priv->rx_cfg.num_queues;
> +}
> +
>  static int gve_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc=
 *cmd, u32 *rule_locs)
>  {
>         struct gve_priv *priv =3D netdev_priv(netdev);
>         int err =3D 0;
>
>         switch (cmd->cmd) {
> -       case ETHTOOL_GRXRINGS:
> -               cmd->data =3D priv->rx_cfg.num_queues;
> -               break;
>         case ETHTOOL_GRXCLSRLCNT:
>                 if (!priv->max_flow_rules)
>                         return -EOPNOTSUPP;
> @@ -966,6 +970,7 @@ const struct ethtool_ops gve_ethtool_ops =3D {
>         .get_channels =3D gve_get_channels,
>         .set_rxnfc =3D gve_set_rxnfc,
>         .get_rxnfc =3D gve_get_rxnfc,
> +       .get_rx_ring_count =3D gve_get_rx_ring_count,
>         .get_rxfh_indir_size =3D gve_get_rxfh_indir_size,
>         .get_rxfh_key_size =3D gve_get_rxfh_key_size,
>         .get_rxfh =3D gve_get_rxfh,
>
> ---
> base-commit: 7b8e9264f55a9c320f398e337d215e68cca50131
> change-id: 20251222-gxring_google-d6c76c372f76
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
>


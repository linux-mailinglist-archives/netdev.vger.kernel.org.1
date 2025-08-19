Return-Path: <netdev+bounces-215040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4063B2CD85
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 22:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E43720DA6
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 20:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5598330DD0B;
	Tue, 19 Aug 2025 20:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nMfKOzE1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E002FB984
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 20:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755634252; cv=none; b=jR7AcrHR7P2MgNAivHvgQ/PU9t75V0kThB8wOtkohDlL+nmqUfuO06wGQ5x8FyBVYF0YaDqrpPyJdPlJqGg0NPrB3eeXLoX8DVJ4sYy3VN8rzQAN1dPv4l63LnnbeCcTRQlnhGPoOzXpcjzh2JPHaj1YVr/XRlWn+vubwL0MFN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755634252; c=relaxed/simple;
	bh=rMZHiApmfTWJvbl/Y3ClCgmKNQgGqWhcylhTmw6krww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RnKp5A8Vb6munmBv94LiuKw9D0M3NY1TkZrumEo1245HzBSp0aLrvXosc3DzCekkrssHsxaenFMHXpzHtmpxBTxcZeuCXAfFxPGESv2RrAqx45p3dcrR7+mW8nclLj1S1xiG7JFBmLAu+0UPpbLb1xKbsMaFRl8b2L0aE/Dszic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nMfKOzE1; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55cef2f624fso1683e87.1
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 13:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755634248; x=1756239048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8g1GABB4c6Nl3AjAt7p2WENAvE9Whp18TcJMWTNN3Ps=;
        b=nMfKOzE1RvZGO5un+ur721jj0LLTEWXJA5ELmzCZnyMUumoJqWCfGEio6kc8jKJ1RD
         CTjl7kL/8VUlPcLqZHssYstP6Mjf0EVtZETipHmawHuvTgmHrNyweO0tR/2HB6OH4J9X
         ob+uM1n7CA7y2DGycN1J+4IXEwT510rJXQPS7cMt6aX6MuPBd2PiEI1Pz0OXujAeruvD
         igTdFO2gnxPnJFGfmLUWqJbP4ZQYRGu+qLRF/sIhWsiRNGpVg1Z+TCDhoYVm37UljAzq
         qMYYiwSukI0P+M0RZVCe/XZTaENTsHjbvWVNcngXhiWEQi43ErNabC6hZJDB4bd2g4T+
         TkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755634248; x=1756239048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8g1GABB4c6Nl3AjAt7p2WENAvE9Whp18TcJMWTNN3Ps=;
        b=UeYQb2n7UUi2f1c/xdFxP1SBE7PF5Ux7dwx1Dt8tUQyczMsGTFLlLv3ygzPGDgyrJt
         l2hLQoW5ih9wjuLzVW3gZTb9cpiGONSLsrVZYsJmtQ+VwSJjjB/T4Bc8JROXEqxD7aFo
         Oz7tI7N1r3XxU4lCRItml/gPZKOoifqJSBqI061SV6EZbXZICjbopZRELgtOjHkEfDkr
         RIlN+VYHC3XqoVLg3T2f2vM81v7E2td1HTL+koJEzl77db7i2q+TmTMxPC8Z1KscQlq0
         wNwVSCZbc5WZq/nDrjFMMvsPt+PlIOlWFqQ3XQI1tVlOmGXLZXu9WOjEalc/hp0Le5we
         sUVw==
X-Forwarded-Encrypted: i=1; AJvYcCXcAHTE9X/VNxIBrSiwFWyhgfnml9FRHzUAIUXF9uhWQpz3NfK0zDvdK51smu7amCUmSNuGJhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbNz9fSKQlBAHuDt0TOIjlKOSny9WtceYMJbsI1dUN10p/s6q6
	1awFHzaf3vOL44zP24aeJcekHtW9XYS8bu6grIUowL0zKu4JggM3rdGz8/+0wCc408v/D7Uqaha
	I0gZDL9QHS6Az6Yrb3h+yAgx8OWNOvOAFgroC21il
X-Gm-Gg: ASbGnctiB9Apc2tnytCDXQ5HBPTxaKz1zIg6YtH1uE3G2kjjfHcHq8lO/K65UOpWq+h
	bXkYt5BaixhaQHbAbEgUaPDBYghwtohchAj0uec6REM9VG/f4E3TkOZJOlqdAae0ekDAWuePyPD
	sShHvD4zpXUF5I/tuxbcMbs7CYoMP6anEUDVzxgq55CTlIQdHsfDMnko9Wx7xAmgpw770p6o6EC
	K6A/xYMnImkhbWRiSgSSM6nFXi/75pk+fXMKa69oi9AqqY96Fbxsok=
X-Google-Smtp-Source: AGHT+IGWDEKpjkL8gMoTg11knrM+LgDSoCdoqV7uPa5wnI+Ffp6uCHV6PExiTkcQlwYReNDLYuv3IY9Lga3x2m1O1Dc=
X-Received: by 2002:a05:6512:1412:b0:55b:528c:6616 with SMTP id
 2adb3069b0e04-55e067e2d86mr59539e87.6.1755634248138; Tue, 19 Aug 2025
 13:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755499375.git.asml.silence@gmail.com> <155130382a12b1386540b51a4ca561f61e81177d.1755499376.git.asml.silence@gmail.com>
In-Reply-To: <155130382a12b1386540b51a4ca561f61e81177d.1755499376.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 19 Aug 2025 13:10:35 -0700
X-Gm-Features: Ac12FXxdfokg6kaVI87OSUtFCT6WqV-aHwt747JMGypTZ0xJY1GsNjRibf_11Lk
Message-ID: <CAHS8izOgxGNsYgc3OOkzn8L5P-BRUni4N0rxEJ-s9HLcmjKg9A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 09/23] eth: bnxt: support setting size of agg
 buffers via ethtool
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
> bnxt seems to be able to aggregate data up to 32kB without any issue.
> The driver is already capable of doing this for systems with higher
> order pages. While for systems with 4k pages we historically preferred
> to stick to small buffers because they are easier to allocate, the
> zero-copy APIs remove the allocation problem. The ZC mem is
> pre-allocated and fixed size.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  3 ++-
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 21 ++++++++++++++++++-
>  2 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.h
> index ac841d02d7ad..56aafae568f8 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -758,7 +758,8 @@ struct nqe_cn {
>  #define BNXT_RX_PAGE_SHIFT PAGE_SHIFT
>  #endif
>
> -#define BNXT_RX_PAGE_SIZE (1 << BNXT_RX_PAGE_SHIFT)
> +#define BNXT_MAX_RX_PAGE_SIZE  (1 << 15)
> +#define BNXT_RX_PAGE_SIZE      (1 << BNXT_RX_PAGE_SHIFT)
>
>  #define BNXT_MAX_MTU           9500
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/=
net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index 1b37612b1c01..2e130eeeabe5 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -835,6 +835,8 @@ static void bnxt_get_ringparam(struct net_device *dev=
,
>         ering->rx_jumbo_pending =3D bp->rx_agg_ring_size;
>         ering->tx_pending =3D bp->tx_ring_size;
>
> +       kernel_ering->rx_buf_len_max =3D BNXT_MAX_RX_PAGE_SIZE;
> +       kernel_ering->rx_buf_len =3D bp->rx_page_size;
>         kernel_ering->hds_thresh_max =3D BNXT_HDS_THRESHOLD_MAX;
>  }
>
> @@ -862,6 +864,21 @@ static int bnxt_set_ringparam(struct net_device *dev=
,
>                 return -EINVAL;
>         }
>
> +       if (!kernel_ering->rx_buf_len)  /* Zero means restore default */
> +               kernel_ering->rx_buf_len =3D BNXT_RX_PAGE_SIZE;
> +

I wonder if things should be refactored a bit such that not every
driver needs to do this 0 special handling, and core does it instead.
I notice patch 4 does the same thing for otx2. But this is fine too.

hns3 changes are missing, but assuming Jakub knows what he's doing
with hns3, the changes here look good to me.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina


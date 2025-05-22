Return-Path: <netdev+bounces-192886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8B5AC1800
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 01:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 417A03AD5B8
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 23:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCBC25B671;
	Thu, 22 May 2025 23:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="joyQYIP5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3F128EC12
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 23:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956408; cv=none; b=OMFG99204h/jTD8FhrPOCAxhPaM0qme8kFmlncvIMusUP7oBJu8jbDD/5O6W51DQFSEjedBpLw4ebHtdIZ03Yk12MZy2r3KkeTCc2VrnuhMk+E2MOth7GYAz51qbEtdgaFvFb7boByXBgicX+GfWZnBhmdhsEgxIpfr49lTiJlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956408; c=relaxed/simple;
	bh=Fm5MsU6AnFNe0fev7Fs8otIjBCU2BZ0zw3QOQzdznoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AmiqCpP9ZAGxk7CcZ+PJetENEhR/egFoRES+ZXDmKbU9R8T5SSYHPqkj13cx2/KeqRn1bGe8l681qv/aUIZkgsurMZTdEDkJB5QryNVo10ZI1qIl2s0s0318oJ0RVd8BLNuAomLvuv5rpnE/0Tw2YveWQU293yjv1WQA25EKy2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=joyQYIP5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-231ba6da557so45125ad.1
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 16:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747956407; x=1748561207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tewI1VjF8jaVqlFssXh4UdHKoEk0InUXOTIkBmq7a7w=;
        b=joyQYIP5G5JKzxPoy8Bug1EEzJ3QUquHJKX6sPEF0uURoIOR6WSZ5UtIiLfmMNPRgG
         cZ3QHbXx57fb42W2r1ncSvLQhmZMzgq/1kJIb/2BxqbhqREsjtLxGQ3cT8IY883112MS
         cenfMCLDj7ud6EPugHUsXjO1C3511VBrp8hSaT6oDJnfhafiP7h6aj3HZoUQgInyGPeR
         y2kouFhqjbOpd5l+Vu3LsSH4kJG16jIVwdzwTRw/TCXdgvdxA2jo4GDURQRqR+Uu8acG
         s4ecj+6yUkti0HueJm+PmHTAtYgSDA/yoIEysfa8UE1AbJjior4228mRK4Vn3UkxZqTC
         DOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747956407; x=1748561207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tewI1VjF8jaVqlFssXh4UdHKoEk0InUXOTIkBmq7a7w=;
        b=ZBP2EUSk8dUaAEGyhWjM0IM4yvgrRjIBa4hPyGHiC3FjYqprA77Tv10HZ7hJIAFgdw
         orgDnM61gclehSOJ3GVSCcKihejv34V5tCvvDBrRlyTPNRClWYStmLyW667oCZF/9STa
         vCkF6rKU8jQvrbDVXEve0oqg+Sn08lGK7j22jWviJxaom9k4If+6NZlAwpkb5Viag9Vc
         PP0mWUvuchtlQGUKUozU6dcg9U4hsp/CRHR0PwNFRhsx8ixInieVqtG1qdHQw5BsQmt0
         GOHlzS7+BL7h3+9yw5UFg8WKV4wuK999HiPWgV9IheUa4zRdSqtzpSvGK1JvpJkcYnZk
         OVTg==
X-Forwarded-Encrypted: i=1; AJvYcCVBDtcAilHsRYAgLUuUQ4kJO49V+2qslsmCewrWQFUaDKbPD/1dN4Io2gYfMTrgaxN393c8ACs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtI5I0kPWhY4RUg5x4KAu/kasaNy6Hlve1NHqBrr0NdXKw9y8O
	801Izn2IUx1Ec/TpyrYNkVdHblqIEFqMRlytbgXhnDloEl+gGRA/8aXnj2b5fbHyYd9u2hGnHuh
	CP2I6X9ks6xrRubSLxH1woQrPJv0/uVSyqdV5uBGQ
X-Gm-Gg: ASbGncuf+jIlmVnC8Ih7nbDTi8CuLeTVHWEtcup3+vHZC8HYsEV9wG0djVlOXUs+qcD
	hoR8twY3LT0tq3PlMeXGd63dpJvrq2fhTXdmzYCOei/Bc1GgWWtrgqC2V07qGkcNDoEgBOkIduF
	wGzyMWr96w4c1z/A1QU9Z07Xn8LyM5aIY8kdQAJffJmtsS9Givirt3BgSPABDYsoTOhF+RI/NlI
	MiOKIH9E8DW
X-Google-Smtp-Source: AGHT+IExQXp+kRhsr+xvbueIPx3isSBUAU+UOZQ8m1D2lTDyLYVrFiHMIU2uzePo0K4IVU4P7DIGc96cabT65kW5Pfk=
X-Received: by 2002:a17:903:120b:b0:224:6c8:8d84 with SMTP id
 d9443c01a7336-233f306b22emr758395ad.4.1747956406406; Thu, 22 May 2025
 16:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com> <1747950086-1246773-10-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1747950086-1246773-10-git-send-email-tariqt@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 22 May 2025 16:26:33 -0700
X-Gm-Features: AX0GCFtsIvmK98xADj6rEGCHUjIbzbhFEii4WAzkg0iSDJXH2J3dXgYsjaSUVc4
Message-ID: <CAHS8izOwPVSKQJBSOjmtfXfA6ZBHVqvWRV=WSYM41XXninsSSw@mail.gmail.com>
Subject: Re: [PATCH net-next V2 09/11] net/mlx5e: Add support for UNREADABLE
 netmem page pools
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 2:46=E2=80=AFPM Tariq Toukan <tariqt@nvidia.com> wr=
ote:
>
> From: Saeed Mahameed <saeedm@nvidia.com>
>
> On netdev_rx_queue_restart, a special type of page pool maybe expected.
>
> In this patch declare support for UNREADABLE netmem iov pages in the
> pool params only when header data split shampo RQ mode is enabled, also
> set the queue index in the page pool params struct.
>
> Shampo mode requirement: Without header split rx needs to peek at the dat=
a,
> we can't do UNREADABLE_NETMEM.
>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_main.c
> index 9e2975782a82..485b1515ace5 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -952,6 +952,11 @@ static int mlx5e_alloc_rq(struct mlx5e_params *param=
s,
>                 pp_params.netdev    =3D rq->netdev;
>                 pp_params.dma_dir   =3D rq->buff.map_dir;
>                 pp_params.max_len   =3D PAGE_SIZE;
> +               pp_params.queue_idx =3D rq->ix;
> +
> +               /* Shampo header data split allow for unreadable netmem *=
/
> +               if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
> +                       pp_params.flags |=3D PP_FLAG_ALLOW_UNREADABLE_NET=
MEM;
>

This patch itself looks good to me for FWIW, but unreadable netmem
will return netmem_address(netmem) =3D=3D NULL, which from an initial look
didn't seem like you were handling in the previous patches. Not sure
if oversight or you are sure you're not going to have unreadable
netmem in these code paths for some reason.


--=20
Thanks,
Mina


Return-Path: <netdev+bounces-185269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57090A99934
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 22:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C19417B7E2
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 20:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782A42690D4;
	Wed, 23 Apr 2025 20:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LFMZMmb5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83D652F88
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 20:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745438928; cv=none; b=cH1LHvsh05vj1hbI/mx6G/kiiqCaUueyAI4y4YAXrYoVrv2KHonHpouomabjAhlLx5wPJVzl1dLJpeUubpMrfzWT+gq6M8QBx5cy5O4wDsmB4auC0JeurENG1iHwo9MFS59ZRzOZKIl0J7LoznKrxgP2oAgWAfJ4CfMooz86NDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745438928; c=relaxed/simple;
	bh=vJRep+5x5cuCrOFMSd8O6OwyrA3LRakNFo+JFuwkA7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r94iHj8mh7CKW9ncfa/Pwm5RbPJ3jlpoyWlBjNZvY1N8eKqd+7XboUKn1RsqUC40QtvlwHO1VWePfNgHKqJhTB7EyC4AUTdGOhpLL96NZa5cmVI/zzvJPwani23sgToLvAUW1K2ROJ6FKJvS6r1ZFiVb+rznvkUNYRpEBV3Vu+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LFMZMmb5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2263428c8baso8005ad.1
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 13:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745438926; x=1746043726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Td/I5axVEdpyVj1YCE9QRnpsHuvWE+AYNCTtELm2XZs=;
        b=LFMZMmb5zEw3fPiZeswnIhzsKrms+TVjM2wBZ5G+lqmGXhmUwuwu2hXC1FBpWl0rTz
         IRQMLFMWImckjfS7Qi9nmYEGw8hBvGuyUhd1roxcS29Hxd3Hs9zbXKjzdTR6iWShQcD8
         MdUWs0iXMHwPm0HHu+C61ytYo5sjOnaPQHkGxsFVVUPJj7hyNKno1+x2n+KD18Fx0wbM
         vFD5oF5sYq1oDQfZoKz4wVvODIJz2YP2Lz0LrOuH1EZk+VxCo96QV+7qFO6i/Ds5qScF
         zCau7vXNwgeaAqWNlDZPVzMLmK39Bo7d7uEcglKeSGeWxIv+T05aQ9wOWL8x+p0xQ4Wv
         cKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745438926; x=1746043726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Td/I5axVEdpyVj1YCE9QRnpsHuvWE+AYNCTtELm2XZs=;
        b=aLFrAUBDQDtiUcdmI/yGbTDhsMVueV/Fmg2hOHLs5bl4pEtxEz7j2/5XADy4lhhcCT
         fwpd9g1UbgOXg5AK6oUn3ZpfkUJzWG+am/CufSq8yjQBGowsZ3X5KePv2lhlmkkW34Cv
         kScH9ouPqCT7Qm7tZvvXuqOl+0+9TJi2HcOHt7ZEb7eEtnoH9S1YqZcoUVfCeJZySCVH
         1J55iFaGSXoay1fc0wj9kGnSwaX9ru3+33iVqV32RpLsVqSH13x0kSyRzg1WVBrJVP8U
         ybqEd4MuA9AToXUFmmLzM/r4qbdD4COJL6IOCNECorProLVFanUinapwGzmfkCK7Oiud
         sZ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzL96hbRXtJwux+jXKEXaCbrIFztxMtWLSk7g4HbgaZPmH7YUHozsPvFHHNGBQBC6qbz7PdR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfuPpC0oeAEJSkAMn1ZYaLITopWwwphfGyUuOcNcq6hOr7sY2I
	1Y10RCyoyPEhA443nuAdWTVeAaBr3OkT05kIog71LEkfEto6LOlMKHu44+bOZnKSm4dolVJgmpc
	3npHW58/njYERi1SWi4yNc76lJaM1Rr+oWDwJ
X-Gm-Gg: ASbGnctAs+gS8KljspFwvLbPaUpVDiW24ot2YLbBB0Txpx5hnXYMuzYRPph0vuPHv2G
	Se5xifXTuwzqKsg58ByGhZJTr0C9t08Fe3UxZBrLB0WeqtrZePxECSxM00H+KcQFKUzwGKF3pLP
	/hzCmAKio2NYG2+UarjXIK5/9mUaM7WDojdZ1HRTGzey4Oy2v8KCNk
X-Google-Smtp-Source: AGHT+IGnZMFZjw0zOouukXHgaJDpUjhbs0s1Gd8WQIE85C1JWl9EPG5E1X0jj6W4f7hj27sw3V5qWT19Bhq9rK6XY60=
X-Received: by 2002:a17:903:28e:b0:223:37ec:63be with SMTP id
 d9443c01a7336-22db216ff93mr662805ad.4.1745438925881; Wed, 23 Apr 2025
 13:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421222827.283737-1-kuba@kernel.org> <20250421222827.283737-2-kuba@kernel.org>
In-Reply-To: <20250421222827.283737-2-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 23 Apr 2025 13:08:33 -0700
X-Gm-Features: ATxdqUHHM2Bz5vDO3tol3lUh2lz-YdcsPwfzpF3ElGZUVmdNWjEvr4gpdcVxywY
Message-ID: <CAHS8izODBjzaXObT8+i195_Kev_N80hJ_cg4jbfzrAoADW17oQ@mail.gmail.com>
Subject: Re: [RFC net-next 01/22] docs: ethtool: document that rx_buf_len must
 control payload lengths
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
> Document the semantics of the rx_buf_len ethtool ring param.
> Clarify its meaning in case of HDS, where driver may have
> two separate buffer pools.
>
> The various zero-copy TCP Rx schemes we have suffer from memory
> management overhead. Specifically applications aren't too impressed
> with the number of 4kB buffers they have to juggle. Zero-copy
> TCP makes most sense with larger memory transfers so using
> 16kB or 32kB buffers (with the help of HW-GRO) feels more
> natural.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/networking/ethtool-netlink.rst | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation=
/networking/ethtool-netlink.rst
> index b6e9af4d0f1b..eaa9c17a3cb1 100644
> --- a/Documentation/networking/ethtool-netlink.rst
> +++ b/Documentation/networking/ethtool-netlink.rst
> @@ -957,7 +957,6 @@ Kernel checks that requested ring sizes do not exceed=
 limits reported by
>  driver. Driver may impose additional constraints and may not support all
>  attributes.
>
> -
>  ``ETHTOOL_A_RINGS_CQE_SIZE`` specifies the completion queue event size.
>  Completion queue events (CQE) are the events posted by NIC to indicate t=
he
>  completion status of a packet when the packet is sent (like send success=
 or
> @@ -971,6 +970,11 @@ completion queue size can be adjusted in the driver =
if CQE size is modified.
>  header / data split feature. If a received packet size is larger than th=
is
>  threshold value, header and data will be split.
>
> +``ETHTOOL_A_RINGS_RX_BUF_LEN`` controls the size of the buffer chunks dr=
iver
> +uses to receive packets. If the device uses different memory polls for h=
eaders
> +and payload this setting may control the size of the header buffers but =
must
> +control the size of the payload buffers.
> +

FWIW I don't like the ambiguity that the setting may or may not apply
to header buffers. AFAIU header buffers are supposed to be in the
order of tens/hundreds of bytes while the payload buffers are 1-2
orders of magnitude larger. Why would a driver even want this setting
to apply for both? I would prefer this setting to apply to only
payload buffers.

--=20
Thanks,
Mina


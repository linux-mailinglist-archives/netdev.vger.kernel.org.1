Return-Path: <netdev+bounces-208825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 810DEB0D472
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 10:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66336C5CE1
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 08:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181C32D663F;
	Tue, 22 Jul 2025 08:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MRXbGt1d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AA22C159F
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 08:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172533; cv=none; b=YsnUWwdMHAIpOKpSX69sDkmCe3a/tPjvqXMq14t8IR2VkpCqcPmCMQq3tMI/c7Zo6JMrQRlNbbyK7hVYJnpNmod84r8up2J97qhGKBBP+F7+n2kbYIIJjB8ptuQiREtU6HCj2ZBe8I4L7ydhiNaBmGiKr9vFNRyYBHEwiTH5Nik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172533; c=relaxed/simple;
	bh=AqPimuJBJP0HmkqnFb4hqz+dIWY+dhN9ksXDr5DK54k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rK5PgnwLDtKtntqoeU7/PUlP9hOYMjC/2dge+O18vCAoe8DnAshdtAd4TSb47CimBwktUATdgyHZ2AhjYmAUioC9x0sKQrLnkOcEkLRHoWXu5JL+6j7aSW2eTIUjWT73Mk58h4mmYmKk+03GmRCdUm9wsK0PodNMOcNsW2BC3Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MRXbGt1d; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e2c920058fso589642885a.0
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 01:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753172530; x=1753777330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcvVgCGjMaHgaQsZ5zRWnzrXvg1tdnQm1fCvjHaJvhA=;
        b=MRXbGt1dbIiy4MXIt/Ksqjd0DmHeTxd1MT57d+cZaaFcpfarq6ZFUq4Se9BSzSRYAK
         1oqyJGLN/sWfM5r1Pm6lKEZws+XyziViqFIZT9bpdwTd75pEkIpVEOqzhRR9OcYP7cIb
         zrru1ebpGmyRXQmGuaPUbuFiOcXyx03caurSzV4SYGPdfmWb9YcijMu9N1ZhMoCsvitx
         aF5ILtE+EnC9R4P0hmqa98ZkrTmIvqsafIjm0J2zPJCf8lIsSq3a0dThIuBkGkdBn35m
         tf7N3V8YjFW4n22+NWrb2AzO0Jgoat9QcocKeec+s8x91sB9vxOwkabPso9u1Z9t2X1L
         fNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753172530; x=1753777330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcvVgCGjMaHgaQsZ5zRWnzrXvg1tdnQm1fCvjHaJvhA=;
        b=P5IRgI2Tjwl4WMLlqZSGwWXbZPPpwspmmo1fcG1MfYwKLJHoZIsJoqrMGiixFWX+ha
         TdtMu9jQaj9p7G6Xsk43Ds9bXbjRF0XF3lvSEefDgaZmmm6O46N9tSZIEq0FP1pef8Sk
         Tbf2AOHCPveEJl4o78DLXsUvj3z+VPRzU5TSQpASl2xVWZe2BfOmfI2vXonhCJTftlkA
         vn1h5sHE2BBhA6S4SsUortiXgfINAq2I/GMWIiKEGFKXPHwiA43F0UXsJQN9CCGvTIEq
         ClOpYIkmzGcQ2Aks45fhzBlVTi4bQOputtTB5+JcNLR3Ubh5FHov/zCHCTQggQ+c6vuj
         WzYg==
X-Forwarded-Encrypted: i=1; AJvYcCVxu0FQlw7e1ZifxEgUrQv3cr3QzvQ9tH2XG6cERN59LXCm3SGIHlOVTMfU4WA5miArH9Vlr/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4vmIQow24WXHQozoq7ywvxjEpqH/oXCmYReZmPQ6mOEuSSIsP
	6O7L+VMfo3gZUUPJjSr+W0KPDtiOEvn38BUgUWEDFzn3BJ6Z/U+etINpwXUlWItub/Jfuzarklu
	23tQ7yvRwgz8trdXZwhuWr96e/3VxixCYtle/yfYa
X-Gm-Gg: ASbGncuDIcA7DKoQQttYVCN6OXA0jkFTGu5rauAqrRM9OV1H1nwjQZWRyKYKVUD6WS2
	XH1edrxx4tjehOB1AmaMwggUkp1rHbvnwWMd5E9eOa7KJt9/aCsNvzADwh80BBqOB0Ik7XzWD9P
	BxIECwBab9H3D8QTBEqvXshjIQQHGd+nv9ErCT45CB9asoknErdglUP/QBOqVih1dwtkHQ/CZZN
	LUfSg==
X-Google-Smtp-Source: AGHT+IGMz8rBfBGR55FB+/kUKWnedug19WqWpG5l7M5oOxvPvzeYnO2BUcgt7xSs1vFaWIjwXXqaKZcIrT6q6/G7YHM=
X-Received: by 2002:a05:622a:1814:b0:4ab:8079:f4c1 with SMTP id
 d75a77b69052e-4ae5b7f76d7mr43674701cf.22.1753172530004; Tue, 22 Jul 2025
 01:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722030727.1033487-1-skhawaja@google.com> <20250722030727.1033487-2-skhawaja@google.com>
In-Reply-To: <20250722030727.1033487-2-skhawaja@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 01:21:58 -0700
X-Gm-Features: Ac12FXwwHwTQZSNivsl3Vfy3-_nVlk4tw3vSJs5lsxmVHdrjG5ZJmVSxQt5LjWs
Message-ID: <CANn89i++XK3BFzk4t4bvKeZtqXT-FUCaY_5SkSTOeV0AGNDdZg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 2/3] net: Use netif_set_threaded_hint instead
 of netif_set_threaded in drivers
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 8:07=E2=80=AFPM Samiullah Khawaja <skhawaja@google.=
com> wrote:
>
> Prepare for adding an enum type for NAPI threaded states by adding
> netif_set_threaded_hint API. De-export the existing netif_set_threaded AP=
I
> and only use it internally. Update existing drivers to use
> netif_set_threaded_hint instead of the de-exported netif_set_threaded.
>
> Note that dev_set_threaded used by mt76 debugfs file is unchanged.
>
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
> v7:
>  - Rebased and resolved conflicts.
>
> ---
>  drivers/net/ethernet/atheros/atl1c/atl1c_main.c | 2 +-
>  drivers/net/ethernet/mellanox/mlxsw/pci.c       | 2 +-
>  drivers/net/ethernet/renesas/ravb_main.c        | 2 +-
>  drivers/net/wireguard/device.c                  | 2 +-
>  drivers/net/wireless/ath/ath10k/snoc.c          | 2 +-
>  include/linux/netdevice.h                       | 2 +-
>  net/core/dev.c                                  | 7 ++++++-
>  net/core/dev.h                                  | 2 ++
>  8 files changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/ne=
t/ethernet/atheros/atl1c/atl1c_main.c
> index 3a9ad4a9c1cb..ee7d07c86dcf 100644
> --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> @@ -2688,7 +2688,7 @@ static int atl1c_probe(struct pci_dev *pdev, const =
struct pci_device_id *ent)
>         adapter->mii.mdio_write =3D atl1c_mdio_write;
>         adapter->mii.phy_id_mask =3D 0x1f;
>         adapter->mii.reg_num_mask =3D MDIO_CTRL_REG_MASK;
> -       netif_set_threaded(netdev, true);
> +       netif_set_threaded_hint(netdev);

I have not seen a cover letter for this series ?

netif_set_threaded_hint() name seems a bit strange, it seems drivers
intent is to enable threaded mode ?

netif_threaded_enable() might be a better name.


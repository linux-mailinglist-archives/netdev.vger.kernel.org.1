Return-Path: <netdev+bounces-103600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F49908C41
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 15:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F80D1C257C0
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 13:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888EB19A2B5;
	Fri, 14 Jun 2024 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bmIkdB6S"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DA218FC65
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718370530; cv=none; b=N+kcSNJXEpD5AEK5fHo4XDfYk+Gw6VDLi0YrkyPvLVvEBWEvm1OLh0Nu+XwixXuDIO46qW1NZF1SDeQXVIqMLEYvTJ4DFLMDt5iAue9sjYuzNrSWz59F2XYwXiokOj/YoG/Hkd2elwuhAkRQHvT4pmcy84id2GFpfWcjJAMyytI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718370530; c=relaxed/simple;
	bh=RhpMA204NZDYJYNHGbObqP1HVKtXQG0aL387cmYERWI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hmlu61c2T2IkH3De39j3SQfChbkH6WET3PqryAMGmf6eenWR3tgQY5c9Z146pHOWcLAUMvgLOp1cvN8beT9L8A2HxxaprR02XkKcDZrmmoLSF8PWdYtc0jO5ErEBm6cAXZoQn1ClZ1Qu1iw1j0dSsdH8n7gVH76LJMsgvwChX7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bmIkdB6S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718370527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o66M81Kt0vn1cGekbi5B1k+DRIpH0j0EOW3GSkaUuxs=;
	b=bmIkdB6SvbKNXyGXLBFSBQef9LtjM9/BuLB5F8q14N1Uu0o8SXPTvjywupWznOkZOpkZhH
	81OLO+87jo9mx7Ev6X4XZgxuANkUiltab2hmjuOPQbJvCTc2b5cL/CUd23sGjpLUXNiMDG
	KajrxVkrEGsO7I2Hzh3+XaN9rVV014o=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-dKiANskbNfKdONDsPGSgog-1; Fri, 14 Jun 2024 09:08:46 -0400
X-MC-Unique: dKiANskbNfKdONDsPGSgog-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ebf477ed09so3617661fa.0
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 06:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718370524; x=1718975324;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o66M81Kt0vn1cGekbi5B1k+DRIpH0j0EOW3GSkaUuxs=;
        b=E2kcBH2w5ETaJeB7HEDsPIacOSfIAO4LmPJcpPWzPxdma1CUpfpOCo9fHnfFTbWQfd
         qJ+0DEoyh8Wg0sB7tNKYIl7PUNJ1xdw4tLBNWaDDDmfiEtG4f+ce1PquK1W0vEE6IX9l
         JyNctps1LgrIchAgXrPNOlFPH5KvasnA/Sy5mjADP5wREmRFeJ7+JFROAvU/t8fsMFsb
         cZUgHRKI/YXtkmTdgrldu0jR3We1x+SROeBhxNNJQtSl8B5cncnpQS1H+3laYtU+EcSv
         SFvq6o1grWu2MPjNa5L0/XJuMpm8qO0ByxlNCYnloR48CLOoQqzy2DOGGNLsnXF5X1Lg
         n7Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVX6deEjD3YbKeWCkir8rcxU3QCjPg8dkbiIKdQw0URJRITpa28kUr2CBvJ/hhyFn2sygV3EhoBzV+IjGkVc8iQggYOao5T
X-Gm-Message-State: AOJu0Yx94NYjq1rWvS6beKGeJtKVOwbx0YpJhlkI8TIJ3vLH+vxvoeZ+
	9yF/cEPbO4gvrpEdLkbu/EgZYtqY7EBg/A+QJBpJyH8kLwQn9g9D9wWPy4BnNvctmUVS8KJgfX3
	Z/phSah4l8EgFb/Eq716mfGdE0wfv1QEfIdZw/o4i/B1+jHVko6SMSTx6kNLGcg==
X-Received: by 2002:ac2:5f5b:0:b0:52c:a7c8:ec3c with SMTP id 2adb3069b0e04-52ca7c8ecf1mr1344573e87.0.1718370524056;
        Fri, 14 Jun 2024 06:08:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ57w4Gx5dDKQsq3VemcAEipsIPrhuSF7VcNJmUPeZ0WTy/9bR151y62TJZ0xzmZpmJBwfPA==
X-Received: by 2002:ac2:5f5b:0:b0:52c:a7c8:ec3c with SMTP id 2adb3069b0e04-52ca7c8ecf1mr1344560e87.0.1718370523593;
        Fri, 14 Jun 2024 06:08:43 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b083:7210::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eef9c1sm98099655e9.7.2024.06.14.06.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 06:08:43 -0700 (PDT)
Message-ID: <1b99efc20adda0b1f24ec477b3612caedb704374.camel@redhat.com>
Subject: Re: [PATCH] hippi: fix possible buffer overflow caused by bad DMA
 value in rr_start_xmit()
From: Paolo Abeni <pabeni@redhat.com>
To: Huai-Yuan Liu <qq810974084@gmail.com>, jes@trained-monkey.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: linux-hippi@sunsite.dk, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Date: Fri, 14 Jun 2024 15:08:41 +0200
In-Reply-To: <20240612093153.297167-1-qq810974084@gmail.com>
References: <20240612093153.297167-1-qq810974084@gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-12 at 17:31 +0800, Huai-Yuan Liu wrote:
> The value rrpriv->info->tx_ctrl is stored in DMA memory, and it is
> assigned to txctrl, so txctrl->pi can be modified at any time by maliciou=
s
> hardware. Becausetxctrl->pi is assigned to index, buffer overflow may
> occur when the code "rrpriv->tx_skbuff[index]" is executed.
>=20
> To address this issue, the index should be checked.
>=20
> Fixes: f33a7251c825 ("hippi: switch from 'pci_' to 'dma_' API")
> Signed-off-by: Huai-Yuan Liu <qq810974084@gmail.com>
> ---
>  drivers/net/hippi/rrunner.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/net/hippi/rrunner.c b/drivers/net/hippi/rrunner.c
> index aa8f828a0ae7..184f0933bca0 100644
> --- a/drivers/net/hippi/rrunner.c
> +++ b/drivers/net/hippi/rrunner.c
> @@ -1440,6 +1440,11 @@ static netdev_tx_t rr_start_xmit(struct sk_buff *s=
kb,
>  	txctrl =3D &rrpriv->info->tx_ctrl;
> =20
>  	index =3D txctrl->pi;
> +	if (index < 0 || index >=3D TX_RING_ENTRIES) {

'index' is u32, the first condition is not needed.

> +		printk("invalid index value %02x\n", index);

please use netdev_err() instead.

Thanks,

Paolo



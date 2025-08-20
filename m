Return-Path: <netdev+bounces-215419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 867D7B2E8B2
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 01:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27DB76876EE
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 23:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D172DF3FB;
	Wed, 20 Aug 2025 23:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3URkUheW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096171DDC2A
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 23:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755732815; cv=none; b=Dz67P0WuTescyfUZmf3IRAwsEhl7UcMHpqoX2pS8fiBZrpXsfhith3XLevqDsYTtS4ZrcOXJs0iyxTVYqU56wVANPpTdd/po/2gCnlPPm0F3E+1yz/NK2GvIH0JJG+PQKXo5T4COuRrLBig+/IqjlZ7Y9a+M7n9VT68TMLW7mXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755732815; c=relaxed/simple;
	bh=usCHRZCkEYJEkV9AKTuU+2Loc9eF00pMpeY2OJ8qs9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAVMhSR+ItnAaN9nEF7g8ac+dYc29r8tfLjkVC5675NcXqhvfflIzs1y8ykjI/VTeEGFvL44p2qQXTtQJDbf8O5HoNzGdliK/S6iITzF+Jbk1lFpJANqHDzYZ3s/qrYEXzCpGe02xWgDBSFoj5n5YE/t2nhLjc3MnNNUDwMcSg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3URkUheW; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55e0be9425aso3095e87.0
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 16:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755732812; x=1756337612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlUmXQ4E7pD+GBvslmHnSvKF++Kf89xYG6qSrpC7cJU=;
        b=3URkUheWPZAAMyYmCxRqeiyYJmc57pxeb9uX2BYWHNByoMyyKF3jFKAlw8T/vWdZ6L
         hq2L6ik3bgXDIEWzt3Qef51DrLJZz6PCH29FKGBBxHIiTqvbcNhb5KG2iEzPBVPcsB6O
         wZARgbUNJZvIW9gKotJkVkdV+i5YLbWsSKtUB7TjMECp94kWnVn+6tyA+YWjes7jjzX6
         jRYUhPp9msmHgWJm7yR1a3Zk/S9sU9p2fZ99pHuvsQv3LHQjSGRuGjbdxK129yQS9k4H
         pLi81Q3rvZ52GGWuerUghNIJi6oFDY9fNBQrsiRddSnFhwCLWiO0zHZBHG528Viuz5kq
         02lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755732812; x=1756337612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlUmXQ4E7pD+GBvslmHnSvKF++Kf89xYG6qSrpC7cJU=;
        b=wsY4ZmcJ0bvxCIjTLGY5ePFONxWChKVeH9qJWCR3fzxiXWPyfcf0J1R0YxuM3kgJPK
         PmiuJ2z9dy5vOakDcO1YkjpGxS7cmQn+4LU2tbDB68Obv+ngzU1c1XWDeEwO/7A1tJfB
         F0ItrXZeRC2alGq50tbp8ul0nxbbK92yPNtnU5Z9/+2qPLqKXnNztQllkut72f2QaZKl
         P11efpmUFi5UrvJWaiIR0d+pfKnUQB0FKrBNPh90hxFU65DolDylhhCY3FozTObzND5u
         4fbL/YAijxPIMns+DQj/9YZHL18QMw3fLbT4qGAIaSMB5Dqkem3ZzwdgvCLPDMlaNZS9
         H1KA==
X-Forwarded-Encrypted: i=1; AJvYcCX4WOMrvKuvt32uCmqegMkT1PRyeRrbdr69KhyqTX0UboxqFnJ/Ch2gj2xAh+0OIrp/U1T34fY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjc7dEnhTNsMqZB3bkpdaaElirL1PGufDc1hTmxXg9vxkOtK+h
	oF3rMBZaasqiJoLiQENsiFltPrMY4EtVOnZenUFM66CE4P519ux3ZmGqrQGR0lGG4NPa56h2eMs
	iXgMQCSiIF3u9MsmB0sm+8Ub7emkWUK05CajMwJda
X-Gm-Gg: ASbGnctJjPdM5S3y07gmRIITWnx5spcIDbSnm6uYBEDp3mCIOCn8b7qabB7lRTmbxvy
	O6wqJIBwrsajf64hZl7UAzcfrg8H4LwQtKwWciFu6al+gTl8zNaBfDmwBnz0wCUC9SMfwFdZQvD
	vmKzLV1bTqQlWvHo3D/IJaPvGXcvYutc3yF4jDV7VS3tQo/Be/c32dvQUlv2aT5NI5gJtrj2Dd2
	VIhhsKeHF6J/yldzuKfRso2NZV/9fbokEnH/Z9w+9hLbamgieXKE6rZAQUe206iTA==
X-Google-Smtp-Source: AGHT+IHci/ZkcLtbxTeWnfaZ5DPuiYwqQAyjkuDyNShuvheb4r4TD8aai1TDud6dejNGJF9tTRiOsnGd0T/LUuax+Ok=
X-Received: by 2002:a05:6512:4047:20b0:55b:528c:6616 with SMTP id
 2adb3069b0e04-55e0d7f6d14mr36394e87.6.1755732811831; Wed, 20 Aug 2025
 16:33:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820025704.166248-1-kuba@kernel.org> <20250820025704.166248-13-kuba@kernel.org>
In-Reply-To: <20250820025704.166248-13-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 20 Aug 2025 16:33:18 -0700
X-Gm-Features: Ac12FXzGPPuZI34mVp8ejA7WDZEazd2ib9KQZpnZFgbvVsaEMVMNk-t0hhSCl2k
Message-ID: <CAHS8izMEwmcMQ7Z53Z6uV6NJyVQ40ew+CMmCBMHjwYNC3QtdMA@mail.gmail.com>
Subject: Re: [PATCH net-next 12/15] eth: fbnic: allocate unreadable page pool
 for the payloads
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	michael.chan@broadcom.com, tariqt@nvidia.com, dtatulea@nvidia.com, 
	hawk@kernel.org, ilias.apalodimas@linaro.org, alexanderduyck@fb.com, 
	sdf@fomichev.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 7:57=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Allow allocating a page pool with unreadable memory for the payload
> ring (sub1). We need to provide the queue ID so that the memory provider
> can match the PP, and use the appropriate page pool DMA sync helper.
> While at it remove the define for page pool flags.
>
> The rxq_idx is passed to fbnic_alloc_rx_qt_resources() explicitly
> to make it easy to allocate page pools without NAPI (see the patch
> after the next).
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>

> +       if (page_pool_rxq_wants_unreadable(&pp_params)) {
> +               pp_params.flags |=3D PP_FLAG_ALLOW_UNREADABLE_NETMEM;
> +               pp_params.dma_dir =3D DMA_FROM_DEVICE;
> +

Although I'm not sure why the dma_dir needed to change specifically
for unreadable.

--=20
Thanks,
Mina


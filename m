Return-Path: <netdev+bounces-220089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0423CB446BD
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 21:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B6567AAD69
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 19:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824BD277011;
	Thu,  4 Sep 2025 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UU1xd9A/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB04275B1F
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 19:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757015459; cv=none; b=FpYvTN1cuOfESwDXS7RwUeZ+fuW7JxBwY8UKSvuG+lRB1gzfCz1G8IL7vtwHLH724o9DY2EDomOvcPkr2bicOeqdtrmjjzUsG+a77Zvn0gU31q89ohBUIsb+92/lUZz5uc70WISfNlwvKlm8eoT/OpVtIjcRys3NTtjs8mfTL28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757015459; c=relaxed/simple;
	bh=y/BbCZOfutrrGdIEhnUdoJS38e3K8+RsUZAJr/I/qpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbZBtTSeoz0VpKxhopQmbwg2AcNG4SmLQ0AMY7IWGpk6zZ2B7q6XUgZQvDtTIHY2oLczOD4U8tgRssBw/AQa37N41sxppAeN1HngQ0Hx6A1qsfpL4ymWLTZiAZdjGJRxkZpXy5aJ270H2NhDQ/ON5TG1zt/gCAXstjiWGiWIMtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UU1xd9A/; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f6b77c91fso288e87.1
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 12:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757015456; x=1757620256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3eHPEufl9xUtgWD3aqAgCiDundMmJHck6jY2E0vTjQ=;
        b=UU1xd9A/T1WZWgzvK4d+Fip71c4GQu7kKDBPeTGZhIct2fEV1DlaX0atkEu37YoMqs
         kGRY//IHK485odl9w7YzByqSziFbVjqIONeOR42S0vbyacIGLY0JKNN9KjGMC+vjJNAK
         /Jr2h2eSFHozHzXsqyxlu++SMMQKtmOD2LiZAJxe7zW1ZMrtCze8/ULVIQv01Qyu6rPh
         YMerxr9L0u+DTUiSqROFik1tGTGqQyo46ej56y8Y3lIwu6yKQdPGXsNluZ5NpFnR3B64
         Vc4gLJEtbjQTTZDWLk18Otd2Z8JS9uO5ooK3UYptcsWp0f153GCr8JL+nGoPlKIGiKLI
         4V6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757015456; x=1757620256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3eHPEufl9xUtgWD3aqAgCiDundMmJHck6jY2E0vTjQ=;
        b=cpPDHsI6ban0BnRs9KmALiKt4L4bT/N/QweT7X3a1ApfRgW+Kz8HGeEDwiXw1ScA47
         QN8hGSWHNhAf1JuMoECUhNeq7rHs5T86vBDFf4Fqt+jde8fi2f9Vj+t1Fw9zL8z/0k+A
         4C8hmC8BipITHLewYMQU33qujINXqS5WBTRk4CWSUzHK0Vh3SfBIhSPKJhcnDqTxRir1
         mGS8FpQzU5A838Kx2jo2rONuTXjYzz/pzh5AjHaT7/5ODMpDTGkZpKxWsxLpJE7wAIJl
         1n260QDQkx5imuZuvTeF53L8byvBEKMB7IwyYCgwDbHx65FZ2vGi+/hPFowZLpHWEzeX
         MLpA==
X-Gm-Message-State: AOJu0Yxe/UD+rgxIvCe2FemHVVHoPGKPeC/2HfhlcuJKqDiiHjGO9xeA
	g/PrXXBs0YpOYlCB7QEqYihYbbuLI0+2mEDPwYTJi5UcRT4A2ez9ejQc0Kdgh/vSCcei7LJ5hlc
	VKcNBxogUMNzAxi+pgz5TJUY6fS+lSZjxm8ilRJ5E
X-Gm-Gg: ASbGnctZhPN2CFkl11sDvwyfjtFLZWe7MIzE4xZaOyZ6YKFl5I3W9urjNAKVKT9aUlJ
	8xUQUtwRwviJTkLG0CL+nTQ5OhG0pn+9fQPja5j9GreC70fdmXjLAs8M3TMBcO40qsNwA8oQhWv
	+HaVDaqDYT8CdE6kMt3T6JG9tb+XjoYeapPDB2XxpnyJab1au5D6j9Q8ZpqTJfyjDdrYAANV+Os
	/knVYljDXfjhHWPTs6UwBWDl65VpuSmUD0pH5ZnwQ==
X-Google-Smtp-Source: AGHT+IGAlYfo5wIBw3AY98IGAb3xSMB0Z+//3d+kFVon2XgHollfD4NDHAER8NA7szkq38D/pq1qQ3gl/Y+Zfpl4qFk=
X-Received: by 2002:a05:6512:114b:b0:55f:68fe:76d4 with SMTP id
 2adb3069b0e04-560dea6b1bbmr50021e87.5.1757015455655; Thu, 04 Sep 2025
 12:50:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904182710.1586473-1-sdf@fomichev.me>
In-Reply-To: <20250904182710.1586473-1-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 4 Sep 2025 12:50:42 -0700
X-Gm-Features: Ac12FXwcU_yEonQJHBSkDIvESK_yJi9xHlVf4i2Knv57VrlclcFjGd0j6CV8QsE
Message-ID: <CAHS8izOSq+mYmP58eNqC5WFTvXxh+s8gRSrTv6YQdq6jn41pMw@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: ncdevmem: don't retry EFAULT
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, shuah@kernel.org, 
	joe@dama.to, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 11:27=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> devmem test fails on NIPA. Most likely we get skb(s) with readable
> frags (why?)

I would expect if we get readable frags that the frags land in the
host buffer we provide ncdevmem and we actually hit this error:

```
  1                 if (!is_devmem) {
  0                         pr_err("flow steering error");
  1                         goto err_close_client;
  2                 }
```

which as it says, should be root caused in a flow steering error. I
don't know what would cause an EFAULT off the top of my head.

> but the failure manifests as an OOM. The OOM happens
> because ncdevmem spams the following message:
>
>   recvmsg ret=3D-1
>   recvmsg: Bad address
>
> As of today, ncdevmem can't deal with various reasons of EFAULT:
> - falling back to regular recvmsg for non-devmem skbs
> - increasing ctrl_data size (can't happen with ncdevmem's large buffer)
>
> Exit (cleanly) with error when recvmsg returns EFAULT. This should at
> least cause the test to cleanup its state.
>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Either way, change looks good to me.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina


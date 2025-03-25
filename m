Return-Path: <netdev+bounces-177285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F6FA6E93C
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 06:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B189016AE36
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 05:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BD5149DE8;
	Tue, 25 Mar 2025 05:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IFyRY5fx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCEFDDA9
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 05:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742879979; cv=none; b=AyxVeNdjNaJUAttO1NWdQ0xfDMYrRV6PUhLYsNtVXyxiLlpTqbrISPvbJjVm8V3ikb0vX7DdY/2D0nCpZCOMO8pDSkpjyoZJc+BSUmSoH/Vdm6yODP/KmNyUYCbuguRZanPrPWP/2CqSVZWmdPh+cclBCVD4yoigi2mwAdQI3hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742879979; c=relaxed/simple;
	bh=fH43DDx4NHfw+OBiy+bdnPnPOuXGD6UUgT4l/WBFEc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZIcRvAoSYsOWlZXinaIqPTqTLTEQK3V7zorJ/GsRowvgtjmTfcUGuqXk0lh3W8KqMz8P6ptbKYgfZBd2HZOHs9xcRUIwfp97k1yhAdmbT9iPleRxd3slVXP0IdcwaOJCfkopUGiIEFztdbe3gazlY8y6X43kNvub9uP5RDIjTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IFyRY5fx; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2264c9d0295so141285ad.0
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 22:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742879978; x=1743484778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fH43DDx4NHfw+OBiy+bdnPnPOuXGD6UUgT4l/WBFEc0=;
        b=IFyRY5fx0KToPXbGxLhsJ0X4d+l9N2Y/Lu1kJDKegKXUB5//Ro2ZefSBNed5HUc3ak
         bQLV//+tSzxH+d0DSZpwq1OzYb9IqmMVbxuZaFLDoRKI8t8rppLRtGujGRZmt0IWVSBQ
         l4FoTRHD2BSbaiCPv2N9XwXMDlVXnIUUqwi+f7dluC1Dsc26vonLwp+p5kdCr0eAFITI
         QuaJWsob57UtOgO/9EyoNcHkNHEjYQxrtciBDRYNHGSyjiAsmFZ+0QtcBwVTYA9cCIfR
         1cEi8hf5cAMMWbjQuqaA/kTcK7YC3W0dVk1xhGhKtxvIfKT+E+/j0OD/VnMBr0EmVszv
         ZOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742879978; x=1743484778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fH43DDx4NHfw+OBiy+bdnPnPOuXGD6UUgT4l/WBFEc0=;
        b=BdcX3AMzC5/D+9DG7Qy+2Xd6NkaB+1SDT9k4XT7sjE8wE+HALUgj2qTNA/sTNsXm6S
         ufT76warxJBHsQwHioBOhPqQajIMRgc3iQOjuZtUNtBGMHaxHxiZD7gCcUCZQMDxI9Km
         cEJE6eahgq/HvY6YqXHnpJrJx9HffyUOvnsbmaUgr1iT3GXZ2RQKKzUf90wcArbyT00N
         P0zk4XvukRIv3tQf3NF/uzlmxvkDaYdtKxJf6tmIgyBdGMDtuH9+BJIqQtgRZzjSlKg6
         NRXi7AZADVWufSe0LJyKrI4UKERmQQbgSfuXd8xQvlZfwnejhql8ie0GUvNxrijovSjb
         bhwA==
X-Forwarded-Encrypted: i=1; AJvYcCX3HrIoBRLIXzmFAdb6h7e+DR9SZaFB558sKyER+a197hRtfE7NYPWUtEI5/eeIeyKxstJx89Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKVVagN88EEWh8JGOM0+ndUOw+znXEIun/RYKsq+es3zf9Dryr
	gxc0Y87cXoj0nrOEq7flemvnPdpdq7ISdbxdQfyQyLSC+KWsmxsWblJJr+hyTqkv5PFwd5oWtLq
	CajTXziyzLIkrfedNLdffdiIRt4p7eE83AtcH
X-Gm-Gg: ASbGncvusmkJMm6194URXCBkyha++N5yWEHyDxMrneeXIyNpjCpINXSXDA0VqvJtmjj
	N+9jOhfJieOTSiTjKce5DIrYDzgugVx23Qg2cOY1CXx7Ex3ymHg2XpnFATlfAIdMixYTx6ZsPqC
	ZgBZSUpzr5KTf+7jKPK28BavIXW8U=
X-Google-Smtp-Source: AGHT+IGn/1e7rt4t44XqSVcXux0yw//GlISBz7eHppgmxk2BP2zyn4b755HZzub58hmH1tEslujaE5NPu7CR3XxRjYY=
X-Received: by 2002:a17:903:2350:b0:215:42a3:e844 with SMTP id
 d9443c01a7336-22799f6b2a2mr5973775ad.17.1742879977372; Mon, 24 Mar 2025
 22:19:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324224537.248800-1-kuba@kernel.org> <20250324224537.248800-2-kuba@kernel.org>
In-Reply-To: <20250324224537.248800-2-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 24 Mar 2025 22:19:23 -0700
X-Gm-Features: AQ5f1Jomg7okWUyfGalNdxum0LAA0zQRrq8AbGIk4RclLgCpP6yI3aZxN5aeb4w
Message-ID: <CAHS8izMOsOjerQ43gfPGbMoBgK5bsRkYGED3dSsZJW8JoVvppw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 01/11] net: bubble up taking netdev instance
 lock to callers of net_devmem_unbind_dmabuf()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 3:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> A recent commit added taking the netdev instance lock
> in netdev_nl_bind_rx_doit(), but didn't remove it in
> net_devmem_unbind_dmabuf() which it calls from an error path.
> Always expect the callers of net_devmem_unbind_dmabuf() to
> hold the lock. This is consistent with net_devmem_bind_dmabuf().
>
> (Not so) coincidentally this also protects mp_param with the instance
> lock, which the rest of this series needs.
>
> Fixes: 1d22d3060b9b ("net: drop rtnl_lock for queue_mgmt operations")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Sorry for not noticing this earlier.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--
Thanks,
Mina


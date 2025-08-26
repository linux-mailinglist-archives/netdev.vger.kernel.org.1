Return-Path: <netdev+bounces-217025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC7EB371C9
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 19:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9B81BA44DE
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 17:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985DD2F39A8;
	Tue, 26 Aug 2025 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GOo74N/x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1CC2F3617
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756230897; cv=none; b=N1Khf9783n7aEauc2J5eYC/xcYyMX7SAJZj5DSRsOh+NHXuhMj5q5vJ3N+sKwAE1iEk903uX2/fbXIfIj+e1E/96SwujqocZC7YH5cv3e6bJcV1TBkpcCy/tpfv4BpaPzrVmLjliKw+NJRjhpLVKJkW7AwCIfi+VEDzGwLZmz7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756230897; c=relaxed/simple;
	bh=ADBEEqt/I8SsdIPdL0Z1b4ITRIPJaLgfFIXwhculx/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eW/Y40wzBhZ5SNp71kJ2OQhi8ngY6f12NKxJlK8PxLpmA2AAvSJNrK3XLa/8APBkh3etQZ2YQzky9ji5z/2EzE3T5qZ3Qm120Q0E17MQBpzo/o6OwW0UfWvil3cJeiOcrG1EMxpO9A4sbpBpyXTdBoMGA+Qc/az8gSBT/b4S1VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GOo74N/x; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b113500aebso45146991cf.0
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 10:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756230893; x=1756835693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSb2xeuH5g+6pcK1HzZBzpHptHzZggPfdPMJITj9iKs=;
        b=GOo74N/xTMtfJqWHh6jYoH5XQtorOmI5hLJXW+WufI4HD1r+HenpJqmHtv9eiSrHaQ
         EtHBumHnWvlswCt8Jb52DX41BL4NKEM/Ct+HO+nwvhMJGPp9xI+x77Hx1peZ5CrPgokF
         pysilNTmZ704Wsz92bPIV896JLPokuRtSzoMkZgm1f5KeAuObPE7bW36let6WW60uT2f
         j0Fo0xTr3TJv0prvdMA2ylnngJwkEMSqns5VnlHVfy0FSzGIUz1LcV3njy8cAUmF8+zj
         sPZNj89YOlgiZIV/Oqykuzk6ovY0PRa6Urdo2MeQCkDDWbtVSFhHj0BrZm1IRRRcnXTZ
         EZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756230893; x=1756835693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSb2xeuH5g+6pcK1HzZBzpHptHzZggPfdPMJITj9iKs=;
        b=SAwoLZEJVqolq3haAJbyssrkwrsuQvR5M4QSGMyD/oWEISNN/QNNUjhmDjBUTO0Vvj
         J1LhsS6mzdRn43jUK1E3mFPkXQICfgeZjrFAz12hfH/HgJXJ1y2ivQUxZJ/QZhAhXHCR
         Nk4hNGUP0WZn5/2ZMWEDUWpEJ+TcoDPC1d9aYaDK6JQkyZy0e+6v1r0NRAg5N9zvXAes
         IhFNg/k4dIrar1qxKnG1iIY9Bj9H6MTVmg2frV7hsGHSJ1tcTPzwCq8NrMBBIYSPUCwg
         kWJXqxKgQBdHphQDU64hc2SpAWSVtEMtuG/h0obK2hA232T6F/2nazxYiJnfQ61Sw93K
         bRsw==
X-Forwarded-Encrypted: i=1; AJvYcCWgfccSnt0xbdxpa2x0ZvvRaAy4ZfiNJtGwXTeo3bhQdOOjNLyaNH8GIdGCqcjqehbTiueA6PM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBuPgWApoKrltfRvT4+OABN04pXx1qgjVDLFn/i2M6pV4gCu6K
	c/t8vq3HOdO8YYz5XCk+DEd0V1rViFVg52peBhXZLsx+mLxzebe7AgVwXTjrSWRFhHt0Vv16LBV
	pWGw7VWeyBKvnqJRLCti3UJ9rZ9wq5mmMfIApudgM2HYDhKKRV46GhCwhvoA=
X-Gm-Gg: ASbGncuDGp196XFPetA3zVpq5Mqb7GUFe3oBji14h3Xd9fUYqgMK97VP5QGCT2cqCpV
	g68pxwqNMIR3YNQHc58cHVvZ5o72tPUb9qIv3HEhNH5pSgpD26uil0hkrOzrgHGO1RVq+angoDm
	nZO1a5CMghEmFLgdkSC62q7nMPc2RaOmkp9h9Ldok1ciTjcwlCyybcPuqwzq8b6R8fRbAJuqjtL
	DEAol1VkgaX
X-Google-Smtp-Source: AGHT+IGGV2iyiFmOetInhyxJac4maVVv9fhX96wCprAYO268RITg9RwggZY0uPKZ1PsqeLTeF9F0EJGRkzJfaLhZnes=
X-Received: by 2002:a05:622a:282:b0:4b2:8ac4:ef6d with SMTP id
 d75a77b69052e-4b2aab2be72mr180073441cf.80.1756230892932; Tue, 26 Aug 2025
 10:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756195078.git.zhuyikai1@h-partners.com> <13ffd1d836eb7aa6563ad93bf5fa5196afdf0053.1756195078.git.zhuyikai1@h-partners.com>
In-Reply-To: <13ffd1d836eb7aa6563ad93bf5fa5196afdf0053.1756195078.git.zhuyikai1@h-partners.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 26 Aug 2025 10:54:41 -0700
X-Gm-Features: Ac12FXzidWiTzgg1SRAg60WMCjO05ky3XuED9kyRpFIj1-4hIpt4sOx0xIE9MUY
Message-ID: <CANn89i+D+mmGms5eYxntwpyd3OX1yXz3c9xvjQT_XmmnvxJGwg@mail.gmail.com>
Subject: Re: [PATCH net-next v01 10/12] hinic3: Add Rss function
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>, 
	Xin Guo <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, 
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, 
	Shi Jing <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>, 
	Gur Stavi <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>, 
	Michael Ellerman <mpe@ellerman.id.au>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Suman Ghosh <sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Joe Damato <jdamato@fastly.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 2:06=E2=80=AFAM Fan Gong <gongfan1@huawei.com> wrot=
e:
>
> Initialize rss functions. Configure rss hash data and HW resources.
>
> Co-developed-by: Xin Guo <guoxin09@huawei.com>
> Signed-off-by: Xin Guo <guoxin09@huawei.com>
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> ---

...

> +static int alloc_rss_resource(struct net_device *netdev)
> +{
> +       struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);
> +       static const u8 default_rss_key[L2NIC_RSS_KEY_SIZE] =3D {
> +               0x6d, 0x5a, 0x56, 0xda, 0x25, 0x5b, 0x0e, 0xc2,
> +               0x41, 0x67, 0x25, 0x3d, 0x43, 0xa3, 0x8f, 0xb0,
> +               0xd0, 0xca, 0x2b, 0xcb, 0xae, 0x7b, 0x30, 0xb4,
> +               0x77, 0xcb, 0x2d, 0xa3, 0x80, 0x30, 0xf2, 0x0c,
> +               0x6a, 0x42, 0xb7, 0x3b, 0xbe, 0xac, 0x01, 0xfa};
> +
> +       nic_dev->rss_hkey =3D kzalloc(L2NIC_RSS_KEY_SIZE, GFP_KERNEL);
> +       if (!nic_dev->rss_hkey)
> +               return -ENOMEM;
> +
> +       memcpy(nic_dev->rss_hkey, default_rss_key, L2NIC_RSS_KEY_SIZE);

I think you need to explain why you are not using netdev_rss_key_fill()


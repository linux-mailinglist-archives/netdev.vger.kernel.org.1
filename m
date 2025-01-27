Return-Path: <netdev+bounces-161115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ACAA1D71D
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 14:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2E2188648B
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 13:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9CB1FF7D4;
	Mon, 27 Jan 2025 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMVppRqL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474981FF7A5;
	Mon, 27 Jan 2025 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737985659; cv=none; b=T3QsouzJ2sqauGDJZRPbmng4oLAkVd3as6SIWny8GaRik+Z5r1OdlxRTyp85TwlICyqr7oL15Z5A5ZkC9B/En3FNHvei2aI0Us6EdA8C+NC6C6VvCVg3J6nrsQOG/PFE6k6ZTrnLjpmN3CkyOZQiVD+SWiMNXZBF2XpUwXvHhkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737985659; c=relaxed/simple;
	bh=FbHUn/6nLxF1tewy4sIvs0gNS5q6afUqFEF4FNmNk0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9fNiJ/TxjI7GmcEwfVi6ZR0ISSX3UXa876v0xEwi/orvEtA8m6Jo2+5IWFEhtnYaY5/TV6hTa9it3Sp/PSC9RVDQXlqzCwbkLNceo/VfOHL1vNQ4EWN/OcjocHiAq5j2bYrGTjLF0k2tu5ifa3k9vNrx5abuOXvtoUJFgMqsp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMVppRqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EF5C4CEE9;
	Mon, 27 Jan 2025 13:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737985658;
	bh=FbHUn/6nLxF1tewy4sIvs0gNS5q6afUqFEF4FNmNk0U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AMVppRqLYzLVfnZ7BBtG9j/Ay66+ApyXDcAbhR3CcXbkB0cVpDCYBZCKBC1txKuK0
	 JcR9EikxTyxHbYjtG5aq0U5xlOsBT310c1xBIXNYieRtGTn1H3xuFi+9jJrOVryNcZ
	 hu3FgpSParcE0MPOT5KxTUkC8n9Bv4APXj2+cDx5e1vW7BppQ7Zcui0lh12fARSeOB
	 27QxaCS128Hu/o3aHA7m5u+gLO3OV6rg4RmJzVAmNC0Vv+Rar/oElrsof5EPmwobT3
	 k7x3K93obbyy4KHrRHHDB5BOiHehhDsIJU6F3Ecsm5Lgf5ChF7KTd57fieYzHbcEEz
	 HEoxvZ/p33Idg==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaeef97ff02so739738466b.1;
        Mon, 27 Jan 2025 05:47:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWJ65zzsfyadBKNoQh/8ZqrVCdK/ZQQt7g137Q1NMzuAPpPVW74qZPbP4OrRzl0oR6evrb6Hd6j@vger.kernel.org, AJvYcCWwryZdrKtDZGR419YiAV5igl8P7MVOUVLwwJ4QFbAmPNjTyzBG5q3nnCleP1LxDBCTPoeSpYDDL0j9jTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLBy6bv+tpKdbkUG+J5hWYa7xrAEcHgALi0VSgh9o3DLbT2wv0
	PD9QW0No22tOh2TJ7vXt5hOuEMZYlIav4ffshupGet0+YUDuSgTkKnnve5XbsR05IyJ+NCWaojU
	wCv2H2UZytAaMF82FCEE++Fedo3Y=
X-Google-Smtp-Source: AGHT+IEbpxzqSj+hGIg7Y2xBOvV1yF7RmDBDc0hW9/d9I/wEh0AMT4Gd046K0pDJaIciNG24CI6n8R+CzgzXJ/YXqE8=
X-Received: by 2002:a17:906:f598:b0:aa6:832b:8d76 with SMTP id
 a640c23a62f3a-ab38b1919f3mr3874098766b.12.1737985657013; Mon, 27 Jan 2025
 05:47:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127092450.2945611-1-hayashi.kunihiko@socionext.com>
 <Z5dXJ1EIUx8DAh6J@shell.armlinux.org.uk> <CAAhV-H78fbK+jAsootOaZW=eQ3RPna3VQTxHd33vDSueYkyYtA@mail.gmail.com>
 <f1912a83-0840-4e82-9a60-9a59f1657694@lunn.ch>
In-Reply-To: <f1912a83-0840-4e82-9a60-9a59f1657694@lunn.ch>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 27 Jan 2025 21:47:29 +0800
X-Gmail-Original-Message-ID: <CAAhV-H73FNTzhjwkZwO4RAZFF1Ri6EzpJL3jnWW4rPRFZQRZZA@mail.gmail.com>
X-Gm-Features: AWEUYZk9467VQpU4g5ILSGXNQugm1uYVv8NWvcqq21h7HwGtHut0Xw9R2spdAsw
Message-ID: <CAAhV-H73FNTzhjwkZwO4RAZFF1Ri6EzpJL3jnWW4rPRFZQRZZA@mail.gmail.com>
Subject: Re: [PATCH net 0/3] net: stmmac: Fix usage of maximum queue number macros
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Andrew,

On Mon, Jan 27, 2025 at 9:21=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > I'm not very familiar with the difference between net and net-next,
> > but I think this series should be backported to stable branches.
>
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
According to the rules a "bug" should break build or break runtime or
a security issue, but shouldn't be spelling fixes.

But from my point of view, this series is not just "spelling fixes",
and not "trivial fixes without benefit for users". It is obviously a
copy-paste error and may confuse developers, so I think the patches
really have "benefits".

>
>
>   It must either fix a real bug that bothers people or just add a
>   device ID.
>
> Does this really bother people? Have we seen bug reports?
No bug report is because MTL_MAX_RX_QUEUES is accidentally equal to
MTL_MAX_TX_QUEUES and it just works, not because the logic is correct.
And Kunihiko's patch can also be treated as a report.

>
> There is another aspect to this. We are adding warnings saying that
> the device tree blob is broken. That should encourage users to upgrade
> their device tree blob. But most won't find any newer version. If this
> goes into net-next, the roll out will be a lot slower, developers on
> the leading edge will find the DT issue and submit a DT patch. By the
> time this is in a distro kernel, maybe most of the DT issues will
> already be fixed?
Goto net or goto net-next are both fine to me, I just think this
series should be backported to stable branches. There are lots of
patches backported even though they are less important than this
series (maybe not in the network subsystem).

Huacai
>
>         Andrew


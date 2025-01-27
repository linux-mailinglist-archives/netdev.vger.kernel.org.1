Return-Path: <netdev+bounces-161100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DD0A1D51C
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 12:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13383165F6B
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 11:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7CE1FCFC5;
	Mon, 27 Jan 2025 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fr9cVVFH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE771D540;
	Mon, 27 Jan 2025 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737976294; cv=none; b=OWDdrdTp7/9XR5+obWEcjLc/GYAXlOk/dullzw6+h8lVDN+IO83ZDn0jvMh9Rf6bcbxmj7/TJHj3HVzU7yE5kdnveDPzTYaMhwjZW6DPQEICukTqP1NyKDVVjH+uA+8FnvJ0a/XGWzkLWFlT1H2p/S06+ePD7dYZ95zFfNAEFPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737976294; c=relaxed/simple;
	bh=QzWIcfoUu4/gTEfIKnxjk/E8ZEHvpvzqvrQc4/Dp2fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LF87RP64XbJ0+fRpf5UHFJPD1H5+mpa26+Fwlm0gQJMbXah2fKmogR0MNXJFkQRfXLfhu9CQx5MiQGa/5+EAx9PvtAl+nlPAh6a68UQytO+wYLbOijxtSzVDfCoce3iGEzRRa2gwzAsOSB/REe/O5Suxl0aFZGPjUqQ3iNm5xE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fr9cVVFH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BA7C4AF0B;
	Mon, 27 Jan 2025 11:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737976294;
	bh=QzWIcfoUu4/gTEfIKnxjk/E8ZEHvpvzqvrQc4/Dp2fc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fr9cVVFH23KGKh5kIPUgIvl5oVy4Vpg5pTgePjZy7ASv+wI0GTqv4Odm9az101znP
	 FP96+HXcUboXZm4tu46qOotyFNkQHPTrQSFuCq5r6K00b5r9yAd1GcjDCkOp4pKhNO
	 4z0Oak9WyaTBB98hadgase6seRwOTiugXL/fxDHYsDghM1w5/jwEro7plRcFL+Nxvh
	 drO4la4CbxNvyVWs21xIo0mKXhbzSI4+MphIPjSvkLgzVSEA94MS5XPQEFF5gxYYYp
	 C5Lgpw7YYmrPnzuQG594Wo9fvr7jKp5ZJ4bUW/KCkUDRv6okqwk4/6WYh4/f3YKurl
	 HNBmcNmGzoNNA==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab2e308a99bso844810866b.1;
        Mon, 27 Jan 2025 03:11:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7ltnZf7laDQeR7OwouMHwp9hvMFlldnoGx4yIt0FiVfAP8HotPYsPWOxQaJcJFLt6Zh1I1j0C@vger.kernel.org, AJvYcCX765jxQYi7rIkI9wsClWemWvl7ySfAbUDP2pk47yUwNBjtNLwFJXi+FGqGF+Ar3H8JkESU1Jzp3Qt5AOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb7uA5m47gVO3SE0PbLJ+NpRf3zJjPg0uOuLM0pbOvlpDM/6lG
	DypFCUWFIu6IeGmLXkJdqsl4G9c6JRJw4FAtRT0jO1DTw9l5XENbsa79owGaB53Mq1PWFE8634C
	+JtE8/BW8LBkkwdNnhitrEjgwb3o=
X-Google-Smtp-Source: AGHT+IFW34bx+TvwETM2bWIhS/ttR/C5lgyWGoTlj/cjsPy2ouNJ3mTayzMCZgiBRkUQYm0oh6q1eg+j2GgENyL6FiY=
X-Received: by 2002:a17:907:3e8c:b0:ab2:f6e5:3f1 with SMTP id
 a640c23a62f3a-ab662968433mr1675237066b.8.1737976292927; Mon, 27 Jan 2025
 03:11:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127092450.2945611-1-hayashi.kunihiko@socionext.com> <Z5dXJ1EIUx8DAh6J@shell.armlinux.org.uk>
In-Reply-To: <Z5dXJ1EIUx8DAh6J@shell.armlinux.org.uk>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 27 Jan 2025 19:11:26 +0800
X-Gmail-Original-Message-ID: <CAAhV-H78fbK+jAsootOaZW=eQ3RPna3VQTxHd33vDSueYkyYtA@mail.gmail.com>
X-Gm-Features: AWEUYZkSqEExKEOJzEl1NVXZboUYivpjZE39q6fB7IQV6e_xCVeNjqqX__GrteM
Message-ID: <CAAhV-H78fbK+jAsootOaZW=eQ3RPna3VQTxHd33vDSueYkyYtA@mail.gmail.com>
Subject: Re: [PATCH net 0/3] net: stmmac: Fix usage of maximum queue number macros
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Russell,

On Mon, Jan 27, 2025 at 5:52=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Jan 27, 2025 at 06:24:47PM +0900, Kunihiko Hayashi wrote:
> > The maximum number of Rx and Tx queues is defined by MTL_MAX_RX_QUEUES =
and
> > MTL_MAX_TX_QUEUES respectively.
> >
> > There are some places where Rx and Tx are used in reverse. Currently th=
ese
> > two values as the same and there is no impact, but need to fix the usag=
e
> > to keep consistency.
>
> I disagree that this should be targetting the net tree - I think it
> should be the net-next tree. Nothing is currently broken, this isn't
> fixing a regression, there is no urgent need to get it into mainline.
> It is merely a cleanup because both macros have the same value:
I'm not very familiar with the difference between net and net-next,
but I think this series should be backported to stable branches.

Reviewed-by: Huacai Chen <chenhuacai@kernel.org>

Huacai

>
> include/linux/stmmac.h:#define MTL_MAX_RX_QUEUES        8
> include/linux/stmmac.h:#define MTL_MAX_TX_QUEUES        8
>
> Please re-send for net-next after the merge window and net-next has
> re-opened.
>
> In any case, for the whole series:
>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>
> Thanks!
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
>


Return-Path: <netdev+bounces-164302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6E8A2D561
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 10:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E52B188D6E3
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 09:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1434A199E80;
	Sat,  8 Feb 2025 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Md4g2XUi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833EB23C8C4;
	Sat,  8 Feb 2025 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739008144; cv=none; b=hF+rJVn+YhSwX2qv6/tb9Wx79N0pUUaLY8Vdarve+9fDk9nY60mdEELBAyzSFyX2z+oNhgrr0lZOe8ByHrQln1fw/rF8whkYDpBXQZAacd6EFw22pidEAzDJ5SM/ZoMB+MtbWHJE8pZNLNxxdZyIFLLBoPW5LyPa1o2lbOeokVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739008144; c=relaxed/simple;
	bh=K5p7UqoybweLMCHrgO5RWb9uhO49oo5au53PPusRemc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zs1j7lTn0pIQq9xVz1LYkNlrLs/dMIu+GM/PsJNlhlqG1PFCJjc1OUay/j+0KCOmzmI16Hegc1msveQmVWAhjSMj/tAwvS7wi44zrTHXlRyvQhZsDcrkSjFZvfUrymtpF6xYksZoEW8J49blVuNL/5xO28br0P9Kv3fu+p5oVek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Md4g2XUi; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e53a91756e5so2547630276.1;
        Sat, 08 Feb 2025 01:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739008141; x=1739612941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5p7UqoybweLMCHrgO5RWb9uhO49oo5au53PPusRemc=;
        b=Md4g2XUihXw0KmlxOIFqXDJr8nhqp0Nu8hq3OxrDI2GDm/T3BXdfUBAhczvSn35r63
         4am/CWl+xJ5k1g/Yt9K6BATP5yINp45fo/RpKBOHvlnYRGVrOL3ED3nWlvuGko5wTryk
         RH3xp5Ziokix1ioIkjlJ4qr3UNAOGqLW4bDWaQGvAJJyHarFSJZ3tTd42HZLjPWt280x
         LLVxQJYMvjjyEf2QU/k3umS8aSlgj9qDdxs5v72dbwzwLg8RHoUJOxYJioy5oXBCtNSq
         dL08dP3rLmmsrfF3XnjZSeWJ7h45Jpy0pHpEASZ9mGTyhmvPDZJMz6wGFe668rya4PC7
         YCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739008141; x=1739612941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5p7UqoybweLMCHrgO5RWb9uhO49oo5au53PPusRemc=;
        b=hMYO96EiAvIgifs5Bces78WpSMIIZ9CSrleJPghIal/SelJu6iq8XU8NKQaLcw6hTU
         o02w6IG9rgj6wOma1fwOFLfv/7lwRQFtDgSD+kWQRlnBdnESrfiizouOAUdoWkx2Jfh5
         t1ZX0tM1cIhuQswlNGUmRbjPC5wOUtI6jfkak1qDADj3+MNSwME8HDsN8beZd1xdVDYN
         wt9NK4PlgrWIu0ZRrj7w1HQ3UA7O0FfNBKPlN0iLmWDDxIN8sxAVqv66UAnC7ss5CTyV
         PRBp4+s87HEdrj4JSZM8AdPWjFgemdxr1AN1tWIMU05jGz7VoMq8ZY3QJHfqVq3jbs5t
         zMNA==
X-Forwarded-Encrypted: i=1; AJvYcCUHWQullAVW5EIi8a1yphCrOGkmQZdzoYoIXXpZQLMn+c8FRxxsIcDBqojNFOvP2qcz96/9baEsxmMtZKk=@vger.kernel.org, AJvYcCUS6TNrqMr9GGJQbaz4hvhrlgY23SPvDs4YKvJpFSbcOUEtCLqvdPrJUuywaVSiMD1usohX4bH0@vger.kernel.org
X-Gm-Message-State: AOJu0YwZaf39uN+gPDCEJ8xCCss1FDaQ2n0sXaeU8e82IVdhzmyAe1fH
	ifgYvKLzH08waHoFyKbEiV1JEzmG04eqjlBV2X5jyFKeFylu9UZe5l0xR0o40Ot53HweT8gGmZh
	SJjSMo14+zr9tKYpaWxX0/THvt/k=
X-Gm-Gg: ASbGncvDY12JZHMWY8cjMAT74srJ2Zrxj2kL+d2sEtaVwm5Dk/t2pEs6rqA/5ekHaRk
	BRNP2wW5IfJF7AXNlT3TRkGfsM2UfRjvpTupUyXMoB9za7WeSimOKWZfXAUo1ijaXrIFqvW8=
X-Google-Smtp-Source: AGHT+IGL/r9sSy0VTJwTsdfd7MnGDjOx5Ft+6tXZasVmTF54BlhZsohSuuTPVone9yTxIGPg4Fdsp7fijD1fPAOYYFE=
X-Received: by 2002:a05:6902:2009:b0:e5b:44a4:73c2 with SMTP id
 3f1490d57ef6-e5b4626dcf9mr5240031276.30.1739008141332; Sat, 08 Feb 2025
 01:49:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208092732.3136629-1-dqfext@gmail.com> <Z6ckCZpOo1_rvmh6@shell.armlinux.org.uk>
In-Reply-To: <Z6ckCZpOo1_rvmh6@shell.armlinux.org.uk>
From: Qingfang Deng <dqfext@gmail.com>
Date: Sat, 8 Feb 2025 17:48:46 +0800
X-Gm-Features: AWEUYZkhN2-wdzMWfL2150Js1S731p6ZrWSd5aj0RG5Eny-Vqw6NO7hfNSQzKGw
Message-ID: <CALW65jYG3vv9aCY_HDU4Wyij1kqfiOVOsZ3YnvioUf4AgSbnaw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ethernet: mediatek: add ethtool EEE callbacks
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 5:29=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Sat, Feb 08, 2025 at 05:27:32PM +0800, Qingfang Deng wrote:
> > Allow users to adjust the EEE settings of an attached PHY.
>
> Why do you need to do this? Does the MAC support EEE?

Yes, the MAC supports EEE.

>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


Return-Path: <netdev+bounces-201583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80224AE9FC5
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5083B3AD087
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26072580F3;
	Thu, 26 Jun 2025 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Duy61NBv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D746189F56
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750946449; cv=none; b=ATFFCt1//GL4UO1QFUU0n6vxpt7d23SGVEaAI9+u9afHRQ7op15A7BG5+ymluuAugArBSGTumo6aXTB7niFRLYtbHpbrl9NgNHtXNgmpwewqGzi9qy+52YQQM6/Y6ZQnMU5f3p3y1p6EhtDAjquylBzFBCcBxV3SG8tQHV2xGTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750946449; c=relaxed/simple;
	bh=PQYVS9lgd2Q+8iIIi7Qxe/FMzoIsJ0BiaQPhZFCKjl0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i2SBAeGgzQ1oPIGaVKxKriw3USS1g5dXqzIyD4aNGg6iJ/oJJ6akpSjo8fWW/hFkMJReJ4xLIWViHlGTsu5uOEhtWBymHZrROWu2GgaJgHPDted4buxkGjAJKguf35s4m8PomPaCq9jB8FJms7VffLaZrU8OD9QCT2rSRYgq1Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Duy61NBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A3DC4CEEB;
	Thu, 26 Jun 2025 14:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750946449;
	bh=PQYVS9lgd2Q+8iIIi7Qxe/FMzoIsJ0BiaQPhZFCKjl0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Duy61NBv8Pfs/O2OdKtZgcCYhdmxb4XXy0NYmKjlyL2CBuInFgOJDnripuj/sPTA/
	 k55N4ephS8Y+nB6NRfJlm88liFk8bsM0hgOM6RX8Uk/hp+yX8ejPV6FBHX4IIyAGrV
	 /9hhOa+KnNGDwtFfYYORqjrb9fG/mjW3r71EZRk7uyuL+E2RfgDg0t3bapSxzPgiHz
	 lXrix415qAzhAJwNmU+s3YIz02v4e+5Fw2RWpkC72Hw+Dln3jqgyfl0QuIOW10rhNQ
	 bsRU1jztSwMyHSoDnksYHw3sgh2wCUeYrNOOcTYARO7t/FonH3gmZflb2p/0jd4Nj/
	 NKka7OyW9GMwA==
Date: Thu, 26 Jun 2025 07:00:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Boris
 Pismenny <borisp@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, Willem
 de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, Neal
 Cardwell <ncardwell@google.com>, Patrisious Haddad <phaddad@nvidia.com>,
 Raed Salem <raeds@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdl?=
 =?UTF-8?B?bnNlbg==?= <toke@redhat.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Jacob Keller <jacob.e.keller@intel.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v2 02/17] psp: base PSP device support
Message-ID: <20250626070047.6567609c@kernel.org>
In-Reply-To: <685c8c553072b_2a5da429429@willemb.c.googlers.com.notmuch>
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
	<20250625135210.2975231-3-daniel.zahka@gmail.com>
	<685c8c553072b_2a5da429429@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 19:55:01 -0400 Willem de Bruijn wrote:
> > +#define PSP_SPI_KEY_ID		GENMASK(30, 0)
> > +#define PSP_SPI_KEY_PHASE	BIT(31)
> > +
> > +#define PSPHDR_CRYPT_OFFSET	GENMASK(5, 0)
> > +
> > +#define PSPHDR_VERFL_SAMPLE	BIT(7)
> > +#define PSPHDR_VERFL_DROP	BIT(6)
> > +#define PSPHDR_VERFL_VERSION	GENMASK(5, 2)
> > +#define PSPHDR_VERFL_VIRT	BIT(1)
> > +#define PSPHDR_VERFL_ONE	BIT(0)  
> 
> Use bitfields in struct psphdr rather than manual bit twiddling?

Some call it manual bit twiddling, some call it the recommended kernel
coding style? ;)

> Or else just consider just calling it flags rather than verfl
> (which stands for version and flags?).

(Yes.)

> > +
> > +/**
> > + * struct psp_dev_config - PSP device configuration
> > + * @versions: PSP versions enabled on the device
> > + */
> > +struct psp_dev_config {
> > +	u32 versions;
> > +};
> > +
> > +/**
> > + * struct psp_dev - PSP device struct
> > + * @main_netdev: original netdevice of this PSP device  
> 
> This makes sense with a single physical device plus optional virtual
> (vlan, bonding, ..) devices.
> 
> It may also be possible for a single physical device (with single
> device key) to present multiple PFs and/or VFs. In that case, will
> there be multiple struct psp_dev, or will one PF be the "main".

AFAIU we have no ability to represent multi-PCIe function devices 
in the kernel model today. So realistically I think psp_dev per
function and then propagate the rotation events.


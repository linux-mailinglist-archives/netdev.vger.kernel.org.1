Return-Path: <netdev+bounces-251330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C22FFD3BBBE
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 00:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDCDC302AAEA
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 23:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87CD2DB796;
	Mon, 19 Jan 2026 23:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KA1/+DPL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A8050096E
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 23:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768865185; cv=none; b=J+37v1eHoEcnguyPDqwtYymsPz4+eb7N4/q5xMqQzF0wGVRAnShJxAttXJjd7Wes0zmayzBA6wvSh6RuxYNM9WWeD2k3JfC7uZM+7ymUGy8dvbgI8kAbr4ffG5Aqw29PI/06K3GHkp2oXd22wkCvEFKbjIjauEspGd2VK/6Zc9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768865185; c=relaxed/simple;
	bh=iSPdqKQIt1jsMN/yEDTMiVpJnsjFVjHqCeLLITnfOtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkWqz3WUavYyo7r01sLv0D0lSXqVQGjlC496gJiRtE7lq+ZdIvIKTo+ntmEaW6s+I1J3YMvP3xUzZ83tExdmq22ZfSVsRWbUYmOGqZKjKTmTxxgqMNk0hVyIy/J5WVYtFmjfzvDIn0DxMaQb0SUD/K3EeaU102OQoukadUL9QSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KA1/+DPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDCBC2BC87
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 23:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768865185;
	bh=iSPdqKQIt1jsMN/yEDTMiVpJnsjFVjHqCeLLITnfOtA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KA1/+DPLxkpRJbPlNl030aPlKH9xIHfRg/DVPw/6BotAFKgyyDvTLQmMBykPHNv48
	 dpl+FSFoiMtKBbxHx4kSI/yK6ptz7wal3+HQiaKUTyTqGr/CRhu129CzPIgp2W63WB
	 HokNajaRQbKheRVlBpHXPZrqKYigtzhwIE7XZt3rGeQfnBLDyopLt6gGAZuMoFY7uP
	 MQ9Et0yBNsvrKksBNle1+cgb+UOBgrRNWhvzzZcWo1qDSsujvieFuHmBs/ImUeIZeE
	 w2NfkRz8hoRpPEYqwD+s2S6I58pqQgUC4uyWswdbxoyyntlLUm0AO634HcbXJTfVfx
	 u+gdO223iknYA==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7927b1620ddso67914687b3.0
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 15:26:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWKNx/BWnNPM43ha59YmUGjG1RLncishBbPe2YtMFKhP4oGfPUlWlo+RP59EuhqaVspjpo7inY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP5b7B9k9LbG8qRdgUClB1fsEc1y7nz6EuPqSHNxVqsS3gmKiN
	cgr+whNFrGbwm+zO/C1qoy8mBhf65cwK7wSvVH0gVrFYJ0C7zKSaVzuek/Wb3UcqSBACkC8C7Fq
	tQq+6LxggTAESTEQMg5VWzCMZorxmJQ8=
X-Received: by 2002:a05:690c:fc5:b0:787:fff5:b10b with SMTP id
 00721157ae682-793c57f0d21mr104522067b3.13.1768865184616; Mon, 19 Jan 2026
 15:26:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-ks8995-fixups-v2-0-98bd034a0d12@kernel.org>
 <20260119-ks8995-fixups-v2-2-98bd034a0d12@kernel.org> <20260119215818.qiaqdudcz32nk7f2@skbuf>
In-Reply-To: <20260119215818.qiaqdudcz32nk7f2@skbuf>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 20 Jan 2026 00:26:13 +0100
X-Gmail-Original-Message-ID: <CAD++jL=bVWWbgBezv6DTscK9122u0hOCa3Ooq58ziYr6h-CJDA@mail.gmail.com>
X-Gm-Features: AZwV_QgC_JiKGjRCW8hMi9y1xOrVM4GHADMaDuc_OxaExmAR9zPxganl_OcKz4U
Message-ID: <CAD++jL=bVWWbgBezv6DTscK9122u0hOCa3Ooq58ziYr6h-CJDA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/4] net: dsa: ks8955: Delete KSZ8864 and
 KSZ8795 support
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 10:58=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com=
> wrote:
> On Mon, Jan 19, 2026 at 03:30:06PM +0100, Linus Walleij wrote:

> > After studying the datasheets for a bit, I can conclude that
> > the register maps for the two KSZ variants explicitly said to
> > be supported by this driver are fully supported by the newer
> > Micrel KSZ driver, including full VLAN support and a different
> > custom tag than what the KS8995 is using.
> >
> > Delete this support, users should be using the KSZ driver
> > CONFIG_NET_DSA_MICROCHIP_KSZ_SPI and any new device trees should
> > use:
> > micrel,ksz8864 -> microchip,ksz8864
> > micrel,ksz8795 -> microchip,ksz8795
>
> So the binding changes you've done to Documentation/devicetree/bindings/n=
et/micrel-ks8995.txt
> in commit a0f29a07b654 ("dt-bindings: dsa: Rewrite Micrel KS8995 in schem=
a")
> were apparently backwards-compatible. But this isn't - you're offering
> no forward path for existing device trees.

There is theoretically no contract that Linux has to respond to
all compatible strings listed in a DT binding document, but yeah it
would be nice to not screw things up for any potential users.

> IMO, even if nobody cares about these compatible strings (given that the
> "PHY" driver dates from 2016 and the KSZ DSA driver has supported these
> chips since 2019), IMO it's pretty hard to sell a loss of hardware suppor=
t
> in a patch set targeted to 'net'.
>
> Does it make more sense to retarget the patches to 'net-next', drop
> the Fixes: tags and to somehow mark the driver as "experimental", to set
> the expectations about the fact that it's still under development and
> many things aren't how they should be?

I was thinking actually adding the micrel,* strings to the ksz driver
in this patch, or as a separate patch and mark them for backward
compatibility. But maybe that also need to qualify as non-fixes?

I can surely drop the Fixes: tags, mark experimental and perhaps also
put the revised tag patches on top to be safe, if we think this is
the best approach.

I did grep around, there are no users for the bindings in the in-kernel
trees or in OpenWrt. But who knows what it out there.

Yours,
Linus Walleij


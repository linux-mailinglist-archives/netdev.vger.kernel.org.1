Return-Path: <netdev+bounces-278614-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gN/+KCX03mnMMwAAu9opvQ
	(envelope-from <netdev+bounces-278614-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 04:12:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5FA3FFB25
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 04:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FD4F303D2FF
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 02:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B97528850D;
	Wed, 15 Apr 2026 02:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SK/77lxp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED9F157487
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 02:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776219170; cv=pass; b=a3qmY76e3E2VEgt/G6ZYCUE5k2x9PdsWlH7Z6a7P5njMe+o2RxJchNmfHHe8+IcIHEuM64fnigALsHCptrWSA5E709vPla00JXgCMBLFOwiBEshwEHhOBZPxE3VQJpH03/n2G5/154OGAQkebvO+fTUukgR6G7guwe7pNgJAE8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776219170; c=relaxed/simple;
	bh=aBV/+MFplyMX182F7OgLwYJLUvM+93jxAF1jhxn3A/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QlI3XsOAtr3v+uksyKdTahXysnY36p3eHmI2r6KJQ3Xyqsd17XcNvtakiLNaq6mJsl9YXvBo142DV4Ze6kbeszNG+cSWwwQNZxSEyq9bS537MDpH/O/8T+crVOv7gK0ARb3kqh49I2k8FwrMOtEP10i+RKMyJ0V6pBsHQQebYeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SK/77lxp; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso96342635e9.3
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 19:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776219167; cv=none;
        d=google.com; s=arc-20240605;
        b=WfgIw/kHPk6gczlQadUcoZ7WAzqnZqxMsscIx2sBPOHWWZULARSxgezP5tawKOWc7s
         HZhV7P/tiX/bNf5LP4SJZx7i9ALt4Mk71IyjtqnQ9h0aUVBBN+HJ8UnpEYubAtL7VEq3
         Tsbnc1CuqofLX41h7p6JHw4ESaMinxUweJnZGMOI8UjYO2nzPiP2NTxrBAnmLZZP0cY6
         IrxBwKjRZC/OTSpkKRi/XI4+dXgK2mQaOiRlLP7xXTdoAqaCtt6REC8SBQv8r8h1QXBQ
         heoyoSZZZ8mCjKL9fvcV1B67svNyg2VAFd+Quw3gAf/7rd0D450UExfcTIQKOI2Pqr2P
         4SpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aBV/+MFplyMX182F7OgLwYJLUvM+93jxAF1jhxn3A/M=;
        fh=WLLaJgo06f/sNHD5RIA5RiJmzp4baJTv6oQntwZw11U=;
        b=ZLc+TZnUxz0yrQMgfcB7BgEt9rkA53Jj5moVsARRRsvTthpj3jjN77av13IUbZwtxU
         f+dEuEvNm4AQXjT4T2BW9Z9gWBdgLFy5xe/bxlMoh7dJlfqWNMUajZtqa6feVC6bDzTW
         rD3bDiLgqZ1HMwbkT60iPaYIySQ5BJ28ZcUkuO9mP5tPu8awSVN/uNMHjDl5AO5MlJo4
         Uwcg3RTQ1pXMzti9oF5zbRejjBDGSnykRym5mzm0Gmh7p/1OMi9hLNHYIb+ibqSBI1s+
         EAf50E/3UUyqY89LJKbtOY+9AP0wsClt0Ek8W+HImPgRcOH1jWaD2UeneCjBCmDJD2SI
         l6EQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776219167; x=1776823967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBV/+MFplyMX182F7OgLwYJLUvM+93jxAF1jhxn3A/M=;
        b=SK/77lxp651qEf449XSnw13Z63odiq4KBAc1f8wa6SyPOdP6SLF4F6IQSEUL4zbxBc
         fRBDoyPpRDfvMeoWxLWNBwYsChOkIYjigwptukvTJKsYsb/OxWvH7dnIXWqnvd7r0WDv
         Z2S16tW1+22gV9OUlob96QWgmb0xYwI6KXhZIaZ0q6jy1DorkMmBq6SSIesIjCF12FHc
         PRkx/J20cholQpQWN8IgN07/oDiQDjLGVzibbhHe7jeLHb8ABxpIjxXHHJb4RqCCXqOx
         gx02YLY8AkuRhNUHy6gi3+cFnB9KAfMD9diPIat5nSKIFlswPcoJYqmBqaRc82sOgpIT
         Xnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776219167; x=1776823967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aBV/+MFplyMX182F7OgLwYJLUvM+93jxAF1jhxn3A/M=;
        b=nEmENCjYafxSxHyXTgNBxb8ZSsU3uJoN1OIPIyZnRhmFyRAfyXnNEmQf2ZoL19i/iY
         202PLLrj5zuw+Ac5e6KT0vWBoOBVMoXAy8Zz1bLaohcpvHbD95a/OjfZFzays/M8EUj3
         +YWxI4OqbktsGIju1WVoE5UZAJ5g3gOY8gYHHHQh9+aBIM0cCijM3MVrY9x+o9vf9GNZ
         bTGh4I+4la6ljex5oFiJU5ChMgr8k19YFzXmfCPaocULP48gZHONSQG4WgrFN5UjZMdU
         A8voItWW1GY/OLlWZkIuSUi7RAz+Et0sbyGi8bmRZcu5SUogTrodh19zjOQ3wic310W1
         Uvag==
X-Forwarded-Encrypted: i=1; AFNElJ93m770XcQc4iukF9cKxhmap/9TWWq9JIOivakorug3DToo6Zeg1MkGEPezbnZtWX2ld66tetY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT4VXcPOsqQZD8TeZpcDzklUCIPDs33xtojlQxEe7NxZxIYjrL
	qVJplMVeQX9L1r6EUz+X9/QlQ7YOl4LfxJKclF15KvgelZ4RkdOIsffa44Et/3BswUyB00RYjBs
	bwASDdMHqnUNs+D6mO2Uro+KdkdjRTF0=
X-Gm-Gg: AeBDieu28FVnn1HX0adwAXX/bs1znwb3Zsy4I+MSWOFJllo7juwI8eJAlV4olkIyLSR
	3xH9D1GR6q6j0He0B/B+3RVoEg9PvMx53QJh2kOthK3RFtarYvq3WN1vou8QdaE/CAmgVbu2jta
	EdGUVas0h7bQA98DRq2lsgKcZ44YtBYyZ0XanrouGw+l+1+2vHeCtJv11DxAlYmubAZlWOw2orv
	AISx5fGW86vdG5C5Ss4/C/CkZmT/Hcrrm1tV5Pz2r09Vk71VqihSchtnswSWjm04CZaqEUQddoS
	xbn52SeHPHOpKAtEcJ/VVz/MBWC9
X-Received: by 2002:a05:600c:4f83:b0:488:7ff5:2c67 with SMTP id
 5b1f17b1804b1-488d67f0aa2mr242704755e9.12.1776219166427; Tue, 14 Apr 2026
 19:12:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E1wBBaR-0000000GZHR-1dbM@rmk-PC.armlinux.org.uk>
 <20260413110222.49fc3759@kernel.org> <ad06yiZZbLC9k3jY@shell.armlinux.org.uk>
 <CAH5Ym4i7VV53hQGY3AjAUW3B8g_ffgmw69kPhPrk2CmcRbguuQ@mail.gmail.com>
 <ad5LlXzeQ8j14Mjg@shell.armlinux.org.uk> <ad7nsUQvksJF7JFK@shell.armlinux.org.uk>
In-Reply-To: <ad7nsUQvksJF7JFK@shell.armlinux.org.uk>
From: Sam Edwards <cfsworks@gmail.com>
Date: Tue, 14 Apr 2026 19:12:34 -0700
X-Gm-Features: AQROBzCDcuqEllTQUrqo3wn50XlYGqYnBRK7Hkwk8UIZegBM5SM6IflWL3J01U4
Message-ID: <CAH5Ym4jA8w9=UxMT4vKJpnXkuDHtkFtMcg4u2sy_0S+8wgy-9w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: stmmac: enable RPS and RBU interrupts
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	linux-stm32@st-md-mailman.stormreply.com, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278614-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF5FA3FFB25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 6:19=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
> Okay, just a quick note to say that nvidia's 5.10.216-tegra kernel
> survives iperf3 -c -R to the imx6.

Hi Russell,

Aw, you beat me to it! I was about to report that 5.10.104-tegra is
unaffected. And my iperf3 server is a multi-GbE amd64 machine.

> Dumping the registers and comparing, and then forcing the RQS and TQS
> values to 0x23 (+1 =3D 36, *256 =3D 9216 bytes) and 0x8f (+1 =3D 144,
> *256 =3D 36864 ytes) respectively seems to solve the problem. Under
> net-next, these both end up being 0xff (+1 =3D 256, *256 =3D 65536 bytes.=
)
> Suspiciously, 36 * 4 =3D 144, and I also see that this kernel programs
> all four of the MTL receive operation mode registers, but only the
> first MTL transmit operation mode register. However, DMA channels 1-3
> aren't initialised.

Wow, great! I wonder if the problem is that the MTL FIFOs are smaller
than that, so when the DMA suffers a momentary hiccup, the FIFOs are
allowed to overflow, putting the hardware in a bad state.

Though I suspect this is only half of the problem: do you still see
RBUs? Everything you've shared so far suggests the DMA failures are
_not_ because the rx ring is drying up. My gut's telling me the DMA
unit is encountering an AXI error, triggering RBU plus some kind of
recovery behavior, and the recovery takes the DMA offline long enough
for the FIFO to overflow (without triggering RPS because the RQS
threshold is unreachable).

It seems that the problem happens less frequently on my test setup
when I boot with iommu.passthrough=3D1 but that could be my imagination.
But if the hardware remains stable with RQS and TQS set correctly, I
don't feel an urgent need to dig deeper. :)

> Looking back at 5.10, I don't see any code that would account for these
> values being programmed for TQS and RQS, it looks like the calculations
> are basically the same as we have today.

Note that Nvidia have their own "nvethernet" driver for their vendor
kernel, which appears to pick the FIFO sizes from hardcoded tables in
its eqos_configure_mtl_queue() [1] function.

Cheers,
Sam

[1] https://github.com/proski/nvethernet/blob/main/nvethernetrm/osi/core/eq=
os_core.c#L263


Return-Path: <netdev+bounces-240579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C007CC76701
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 22:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id B1EC02A423
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 21:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082872EAB6E;
	Thu, 20 Nov 2025 21:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PexajmDq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5C42F25E5
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 21:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763675849; cv=none; b=gK39gUnw4G0Y7qYsEu3ZVjec2IZJdRgGTxo6p9+mHDSNkGDeVm/BcC1B+ER8AJqM4lc9EDrFn5SwmlTqXFyHCHPtxZ+vuZLvk7y4cedBtH4KMP5hAykuDjrxqQRENioRp/exo1F+F2Cew5pEaEMm3NtQQcClvwwoUnaudJV3Roo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763675849; c=relaxed/simple;
	bh=VIKRq0aH9aABuWVIGVcfN5YqIU2XFRDRNS0bP4bbPUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9ijI6BIHi+RT9qaC9DK26ZAcpcidfhn+nM/oW7lx74kVyzWVITzZ4gc3spm9DhwJqUiaQK+v3hIC6zgBuDTCxCMX+C4he2Z7Zuebuckmhsy1hNIrleQAiObfpMqsMm+hnee0taA6XwOuzsGsrPpBsgglMtZRSINUVd4zpFmpwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PexajmDq; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-780fd0da0e9so1234407b3.0
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 13:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763675847; x=1764280647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=acngTfTdYoPKs7QTbd+kw/zmLQ6CCjPa+Hcp6y5W2SQ=;
        b=PexajmDqUzVATi9xZpZ4FjEIB3wTrFbxfR9xUAi1YtWHB+EpXmGjdxuvPLqoYBSPIl
         JIEPWBMKGggnNYj90TMvaYwWfz7rOvYgWf6x5PNbRgJeCOR7fJEvgTiS4n0J+BcnAw1p
         jKYThpYXQ6Jj1RiDKajAFfxxOrp+Ce5wg5t2sn2teZ/GL/zHh3EIg4853r1VfKHsyVr8
         qF38u0Q1IHhUGyiGR/XVSfgKxxx+ZMjqfea/4KP7bVMm7G6KJPcQ1MAXwq9Q7uM2s4MF
         KKBSSd4evBt82HEx/t8yGdtWAGA7f76H2o2q/L4qDvHkjJXY/YuhcFDtXOTM2ZyQMSvG
         HQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763675847; x=1764280647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acngTfTdYoPKs7QTbd+kw/zmLQ6CCjPa+Hcp6y5W2SQ=;
        b=jTXyYuXJ2h6MzAZBXex8qHlLYApvB94oW3gqgnOXsqdoy3xFMoP9gpHzatMfHxz2Pp
         PWnV8BmQgmGd0pekic0pKBUvsbESa36j7cWK+rY4oHNUVsvkOYaQKVz3LO1ufCyngykm
         jiBfnKVdiOXI46z4jXwflHdQ2FvYeog9D+iXulMZK008kiKo5i7Ezy6j+0lLoGLWUww2
         OWomPWkncLN+Z8NPoj5je4qgw4+xTkMjorqlS+iX7A6mz61CBEtq4TfbwpuvO3PqO+9X
         AL8Y3+hI0ZrhYQtNXJL3dPBaQBxDLL408Omda9WRo6rloyNXJXudbrFsKMO+NG/v3CF2
         D+fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjFKWzUi9n4QD7Dr30sxvR0BXfXQHfVWJ1vEpZ6TcSQf6poMTYTJdHJUSYQwh6ODyvPdjVBEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiYbONIM8VVzuKWH9nlrNwUgwBn2mnSKwILtG5YGdG55GO2NO0
	wKgR1QHRK+z/ZMghiMwgsyTCSK/zaTJynsTSkWwJfOQPO2lrBBPDjE7/S7QNODS2NAysMmHrKZc
	XapIGYo/BKYe7JYEyuV5/CPOrw47hrwA=
X-Gm-Gg: ASbGnctcs5BXL5PrlIXxgF+gyofJg4EopPP8MXe+4hH1g8EKsZdhSvs/bdp/nSbWFVA
	SpYCfWUcIaUWiwRFnDBqu+r0VtKS5UJzvEuNT1rZ2r0xNWtu2wA7Dx/aXsTbuNaDd1IA0VP+6ZJ
	GytMgZ7gT+04DYulRJis6Y1Ch4Jc6mrQD23tgSGWgLN8ZiAwtjksMsYbpTwqjkjcHAoJ7kGan0w
	/Tl8NSR15hRcHDzCsbPMc+B0ChCKTfojPFtCH/sRz3+9oK5WjBnQEsGAex7uyPIbTEcSuUuUUh0
	hjVKUpDR5CQXFzeApQBuByx2XkGe3tto2Yv6hFo=
X-Google-Smtp-Source: AGHT+IFH278gd7LaywHnjKGV7yj58tOA/DWTSt1RwuOIc/Q06gl3Klfp6Ih7scebqFhpQ8DaqwGihTulQXH48vN/uNw=
X-Received: by 2002:a05:690c:95:b0:788:16d7:6ebb with SMTP id
 00721157ae682-78a795ed423mr35045787b3.5.1763675847167; Thu, 20 Nov 2025
 13:57:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120213805.4135-1-ptpt52@gmail.com> <20251120213805.4135-2-ptpt52@gmail.com>
In-Reply-To: <20251120213805.4135-2-ptpt52@gmail.com>
From: Vladimir Oltean <olteanv@gmail.com>
Date: Thu, 20 Nov 2025 23:57:15 +0200
X-Gm-Features: AWmQ_bnv4TbUctX3C0M8ZCciFb5_1SLblT9d2oxVI4WCyhhk5TijuqMkKDB1Ffg
Message-ID: <CA+h21hoW3v_hL+woeQRwpxVCQ00ywWhJ0H+DfhaRqpMWB2ZSng@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] net: dsa: mt7530: fix active-low reset sequence
To: Chen Minqiang <ptpt52@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"Chester A. Unal" <chester.a.unal@arinc9.com>, Daniel Golle <daniel@makrotopia.org>, 
	DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Chen,

On Thu, 20 Nov 2025 at 23:40, Chen Minqiang <ptpt52@gmail.com> wrote:
>
> With GPIO_ACTIVE_LOW configured in DTS, gpiod_set_value(1) asserts reset
> (drives the line low), and gpiod_set_value(0) deasserts reset (drives high).
>
> Update the reset sequence so that the driver:
>  - asserts reset by driving the GPIO low first
>  - waits for the required reset interval
>  - deasserts reset by driving it high
>
> This ensures MT7531 receives a correct low-to-high reset pulse.
>
> Compatibility notes:
>
> The previous implementation contained a polarity mismatch: the DTS
> described the reset line as active-high, while the driver asserted reset
> by driving the GPIO low. The two mistakes matched each other, so the
> reset sequence accidentally worked.
>
> This patch fixes both sides: the DTS is corrected to use
> GPIO_ACTIVE_LOW, and the driver now asserts reset by driving the line
> low (value = 1 for active-low) and then deasserts it by driving it high
> (value = 0).
>
> Because the old behaviour relied on a matched pair of bugs, this change
> is not compatible with mixed combinations of old DTS and new kernel, or
> new DTS and old kernel. Both sides must be updated together.
>
> Upstream DTS and upstream kernels will remain fully compatible after
> this patch. Out-of-tree DT blobs must update their reset-gpios flags to
> match the correct hardware polarity, or the switch may remain stuck in
> reset or fail to reset properly.
>
> There is no practical way to maintain compatibility with the previous
> incorrect behaviour without adding non-detectable heuristics, so fixing
> the binding and the driver together is the correct approach.
>
> Signed-off-by: Chen Minqiang <ptpt52@gmail.com>
> ---

If the switch reset is active low and that is a known invariant fact about this
hardware IP, why not use gpiod_is_active_low() in the driver to decide whether
to call the old reset sequence of the new one?

Then you can fix device trees without regressing the kernel. You'll still
regress old kernels which boot on updated (fixed) device trees, but for the
latter, you can request a backport of the DSA driver patch to stable kernels.

In networking process terms (be sure to read
Documentation/process/maintainer-netdev.rst)
it means you'll send one patch to the 'net' tree with a Fixes: tag like this:
Fixes: c288575f7810 ("net: dsa: mt7530: Add the support of MT7531 switch")
(when unsure, use "git log" and watch https://lore.kernel.org/netdev/ to see
how others do things), and separate patch sets to the respective SoC maintainers
for updating device trees.

BTW, didn't ./scripts/get_maintainer.pl also suggest my name in the CC
list for this email?


Return-Path: <netdev+bounces-277942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH6cOAFK3GnCOwkAu9opvQ
	(envelope-from <netdev+bounces-277942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 03:42:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 559FF3E6B0E
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 03:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5601E3009528
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 01:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E4E21D596;
	Mon, 13 Apr 2026 01:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxK40TED"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B01020299B
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 01:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776044538; cv=pass; b=QulQf9sd0DVdGOn/qPN98owSes8Ij9iFg9IQFeSabC8X2O7djiwRsyiiiSIG5bDV9/Hui/RnyPkyBcfnIlIMJAdbKlKDYBuxxZDrQnCivg1U7VtYQ8QtXQ1dddKmp4zt8DXT5yD2zoIUwZcyXKye2gYgoAr2y3XBwXnsuMt2yE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776044538; c=relaxed/simple;
	bh=mkQ6RBTZ5z5vPmik3lad4IDd4nljLh9X4eyQBenQOSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVJFAGK7MOYMETjT2CDVwlQeRrAkBa8/aGxZWdg/rOX3eHxs6fvsCf7Eh9Q1KaOfVHEzK0oaICvIvFjOwCNSX7rlKRsbSCfmJUYb/Z2lzXX6Tlo63+p+u7y9K/RnPIiz2fVgA2ovn5IfpzLD5MScKWH38Xr4yVGh4GDVNQ8Y2Eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxK40TED; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d72875729so473926f8f.3
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 18:42:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776044536; cv=none;
        d=google.com; s=arc-20240605;
        b=Gb0cRrvI58VjXFR+cap9BARY6UfQmPmblhJWXe0nvZCKqxG5VzZXf73A67Yxiz68Na
         pnTAwEgJR7Zzy8G/tZdpRcvpDL7zA010MYnlLieHoI/JJvK7eSG8vHDHIiruWnXP6mxe
         lmL7WMr+52pzo3RtJXgdTP+R4qSg29qnGo3HUQ2qVt3Qy4XmfKP0UeNc37vI6FZULGpu
         VsHFn3/SKXLCmvUn3q2sOLQdJ5GeGlDteIzIxmPEp/m3qRRYCo0oVLVBUDSqAzzpXdKM
         42dCae8F+nwPAEKK042yZ8VibtltU6tLrQ/7T7GiLkNJ0bg7eRLijPw9fhqm0T3Tmziv
         nWYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mkQ6RBTZ5z5vPmik3lad4IDd4nljLh9X4eyQBenQOSc=;
        fh=DQNtlvlTo9ggVpYGKC1pk5inDcQZ0cWSePIFohWtXWY=;
        b=S1CFXTdepcdPT7AoExmvQ+DtW+ffwmJ/hqSpvvtHAYmz4FjHvcR0HaJhGXgcsmApOM
         O3zNDoZmHXS8fapx5u4BHDYfEbFEZSjg7u1zNr01eHsBy+AmvcbOkY1sYPbX6wKaEwp1
         3WHNd0VVKqHkDUgvB60lfyBqOrgTVsXLZf0Qfw+8pY4FUdk6a+7yXH2ejXOWlHehB12r
         xLjruJa2u2swIq7tJIWtjbcS7opcQ8vs1uOFrBxwTj4bCH2FkntcfBwIgw37YzD/thAH
         CuQt7VmZg2S657wctQdaz/LDlDyr1Gi++Br1teRbcx2cD/X0Y0SwzRvB8bxtgMpuD4o5
         I5Og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776044536; x=1776649336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkQ6RBTZ5z5vPmik3lad4IDd4nljLh9X4eyQBenQOSc=;
        b=gxK40TEDuwJi9fznV0m7ZbLfQvPaeJL9a6EC/KT0t6z+6JCmAClxBTHsElLIoddpa2
         pFSiGXXxif5sNO0dleSvR0H2yElYXi9M6QNE+USt3yCu7pqzpfpGhAfsNS20PAC6YOSc
         WpXqKBhf6KOl3cpiJCBaw3Xi6nSNB8iR97DeSig2bMBw7/62x8qcBWirw/l2ab19DCU5
         Gnl/487tTiAI7VO0/hP6TfDJhvoylFwvF/vOyGc9r7ZQ3QBYA4dwFumApYmK4xnRNed1
         tt3Zykg4fzS/RFNX86Fvur6mR/4tRcAdrHf3YYqtWq3JZVJoMdhX0PylEMTdShciVREL
         XETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776044536; x=1776649336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mkQ6RBTZ5z5vPmik3lad4IDd4nljLh9X4eyQBenQOSc=;
        b=B+dV5iAjDs68Df27D508XlbNzdN0kDDrtICd8FR2t2NKh5cUCYiegFKSUIRrXmRv57
         FEHwnJZtVh2XvbLrUDNfsggqrFUXa9im822c86Ix/Sppa5NDVm5EM9gBk1g3mRJ80U/B
         hO3Pnw7JnZ2hbzHOYEZj3/URpSvsFz6veM7znk743txS8XYad+4UdOyabYh4IUOgOozI
         vYslQK1yIVnSfxXV6ZgcdQXLnJeew1IBjr/Jn//vw+aI+GpGcXo4gMnI3X7a58XulrLh
         FrHL6ny3u0KBCmfyD3r1oX+dGLP+JaQj/kpWLWOvZ4mxgOrztPkm2SXs6NMkusuf2qOg
         JQVQ==
X-Forwarded-Encrypted: i=1; AFNElJ8GJBHfklLMSnt2T2KUKGLKPzVnvJPzfx+NtvYIEx0PJ8iLtEdBAjDOTz5ffe4A0QlCzipLzPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXrWoSXxs2RVRLkwS0iP0Xqd6F/nurZAivbmPcJrmr8X/izv5S
	sbk3jcUfp7GlSaZG+S1WjE0TACCMEcpSjSaasowDCEZyGD+ZidfSw+9GH09F4uKE4zqfdIexN17
	TkZTjiVhEPl166of9tiNeLb8PQZ0XUDc=
X-Gm-Gg: AeBDies9bVcS7ash3wO6mPpLXrSZ2i7gAyXehvzS2FpIj3cLjtFHahGAmm23GnC/hdw
	cz2JJCc1PlNhzo+JpgPxg8RunDW51u+Fd4vwnMGUMMZ6DcSeQheHNARfnPl7qUR2oEcpRtB3HJa
	iOrXn6z3MkPZTyn00uQmecTLuXTBbce0z06C4LsMaXzrkQ0wza+4g5sgsyUpF+laWk6I0KvBHO9
	Kes3kMcKR4gvXtdoOJNcM4V5Qi65ZOfFz3oNI/ToKante1Zqv4/tQYySI0j8Ii4GNeeOW+a+Ycd
	FpbXMJhkbhF5h9m1ZQ+bYwzu/3uM5XJUYrQ1UwAi
X-Received: by 2002:a05:6000:4026:b0:43b:50d6:4f04 with SMTP id
 ffacd0b85a97d-43d642b5f41mr15811417f8f.38.1776044535544; Sun, 12 Apr 2026
 18:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E1wBBaR-0000000GZHR-1dbM@rmk-PC.armlinux.org.uk>
 <266998d8-7e38-4bae-a4df-2f889538fe88@bootlin.com> <aduq7Lvkfrz971Rb@shell.armlinux.org.uk>
In-Reply-To: <aduq7Lvkfrz971Rb@shell.armlinux.org.uk>
From: Sam Edwards <cfsworks@gmail.com>
Date: Sun, 12 Apr 2026 18:42:04 -0700
X-Gm-Features: AQROBzC8C6b8uovPJvoH5TRYEOGsdMo85w4vcpDsb0ECyjaa-7k3CW1WkTIND9g
Message-ID: <CAH5Ym4hEX15dmJhGBqhhk--_PoFRKRSyE1AomY4D3ipwAz+pKg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: stmmac: enable RPS and RBU interrupts
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277942-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 559FF3E6B0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 12, 2026 at 7:23=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
> As the dwmac 5.0 core receive path seems to lock up after the first
> RBU, I never see more than one of those at a time.
>
> Right now, I consider this pretty much unsolvable - I've spent quite
> some time looking at it and trying various approaches, nothing seems
> to fix it. However, adding dma_rmb() in the descriptor cleanup/refill
> paths does seem to improve the situation a little with the 480Mbps
> case, because I think it means that we're reading the descriptors in
> a more timely manner after the hardware has updated them.

Hey Russell,

I'd like to repro this but I currently can't boot net-next. My issue
is the same as [1], and the patch to fix it [2] isn't yet committed
anywhere apparently.

This prevents my Jetson Xavier NX from starting at all (and after
enough attempts, corrupts eMMC); I'm surprised you're not suffering
the same effects. But because this bug lives in the IOMMU subsystem
(and it has somewhat inconsistent effects), perhaps this is just a
different way it manifests? Could you confirm whether your dwmac hang
happens with IOMMU disabled, and/or with [1] reverted or [2] applied?

I'm using a defconfig build and a fairly minimal cmdline (just
console=3D, root=3D, and rootwait).

Cheers,
Sam

[1] https://lore.kernel.org/all/8800a38b-8515-4bbe-af15-0dae81274bf7@nvidia=
.com/
[2] https://lore.kernel.org/all/0-v1-664d3acaabb9+78b-iommu_gather_always_j=
gg@nvidia.com/


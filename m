Return-Path: <netdev+bounces-134875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6741B99B6EA
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 22:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E134282BF1
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 20:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DC5136328;
	Sat, 12 Oct 2024 20:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tv6cZJnP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138251946B;
	Sat, 12 Oct 2024 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728764629; cv=none; b=aoxmwq+ndF/m7OsksOkjGpWAe57gq/vu8Ts8a0Cx2BjSTdFEVAu7LPGpU3MAvCH/pX6o55L2oybxQ+Bnqq4B5X7XzL9FMyxXZZNcexPfbKSq1qXwRMftHM2Fm39+TLLddw80QLkhZvTyy/uxdxlJFjItmoejEHfDWoy3NmY6ebQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728764629; c=relaxed/simple;
	bh=2n10WYiBxiaYL+UX3as60lZrsbGDNy0wmFYExLXhKrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nOIWfvXDJXN9BJ5m6HUK193Skr+mrjOzqTAyITEC6FlB8eEbKAIcFu4jMoUrm6HQ1/cJCi9NOnAI7hbQgHDBTz1ndQUXxwbpoizVfraVxNpoTIWf3P746u55/+byOhWrEzmLQp9xHcjBKs8KLNT9pf5Y11FMQDTL+kqmxXlUqBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tv6cZJnP; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e2910d4a247so2334162276.2;
        Sat, 12 Oct 2024 13:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728764627; x=1729369427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2n10WYiBxiaYL+UX3as60lZrsbGDNy0wmFYExLXhKrE=;
        b=Tv6cZJnPTqVfLRSEgZoQwEW5HrfE0xsXZyNXg3lc+RcK+E9a7BMri1S3uCY25D+E/P
         LDzD4AM6P4oGwlsGiS0A3UXNHoLomqal9YwkokjbKNuu40eHe3VlxsR4+r/ZY/XYzccF
         RA3tzo8fwO044h6rP1u2kPizTlnurTOoMLgNn7s9QxE4xl27NLPPEeFVko3xRO04pbqO
         xJwB4vueLrakAxEw3TqREIRwrgJwpOjO4vxQRci0U1xe27spX7yWYN0FaAJ7+pOmxI8j
         otZROZcpIY3Z4Q9sQSUiEk+1bD1KjRMYnuFxwWUeIedufdW795paqzGAYsUl+Zijp8AR
         9bTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728764627; x=1729369427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2n10WYiBxiaYL+UX3as60lZrsbGDNy0wmFYExLXhKrE=;
        b=WykKCtrTJUJ7TFsYfvKjOpFT+Beu9WjbK6MkPfHUxontS1vrN3F5HoAHtqvimywdkB
         CCgYYR5dw5Stsehv1RKYxLKhVVCzXFiDyAD+OTQePonJVAIX2nceXCo7NoYf0SHZbiXG
         9B7b4vtbxZZbPutxBlBrma+pE3qsL4c5WcHJKQei7GmXsWf0CveblMvpxWMVv30iMh4J
         I0OrEIUU3PLjyen4HBdVPseLp7ueBKh/0krvVWLt4U5MKwkAQK8jzSU3JMfMyAcQeAPk
         iyX2WyJmeUkbjFqamllhhNL5gdA0a2dHqUZe1n0l2Xe0yUpS9Bde90jfQCFJzC4wDK0R
         UXKg==
X-Forwarded-Encrypted: i=1; AJvYcCV0p+5LFJaSCV50iXkcQgjkx38Z2zUGYCbSkigvmyzU9VrZo2oEnsqSDMIZBj6FqUTC9fzJppyf3EtI5/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YySnarwIwwMWVUEdkb6ZRY+8J79zwx3oEctYGmCp9xntwQht4xg
	EjqUS+RJSHNkAnH1I51hcYFPFtyiHMMghMjap51GQkbnPkndZvkkNswUXnyrm1VjkfLFqM3Bgvb
	crXUT4XZTUaGI5xN+7UZrvaG91Ag=
X-Google-Smtp-Source: AGHT+IGw0lVq1he2N1DXarK1ZmiYhStuv7vGnXSCXhuZs58LreJdA0RwXnt7nASls3rVAB9c/5/AZo4iq8gfQv+ETDM=
X-Received: by 2002:a05:6902:1007:b0:e29:310a:6878 with SMTP id
 3f1490d57ef6-e2931b15435mr2769752276.3.1728764627020; Sat, 12 Oct 2024
 13:23:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008104657.3549151-1-vladimir.oltean@nxp.com>
In-Reply-To: <20241008104657.3549151-1-vladimir.oltean@nxp.com>
From: =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date: Sat, 12 Oct 2024 22:23:35 +0200
Message-ID: <CAJN1KkyFgHSDydUN5CBhDpEkG2kEJd5iaA1TK24ynjYpVvK7aA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net: dsa: vsc73xx: remove
 ds->untag_bridge_pvid request
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

wt., 8 pa=C5=BA 2024 o 12:47 Vladimir Oltean <vladimir.oltean@nxp.com> napi=
sa=C5=82(a):
>
> Similar to the situation described for sja1105 in commit 1f9fc48fd302
> ("net: dsa: sja1105: fix reception from VLAN-unaware bridges") from the
> 'net' tree, the vsc73xx driver uses tag_8021q.
>
> The ds->untag_bridge_pvid option strips VLANs from packets received on
> VLAN-unaware bridge ports. But those VLANs should already be stripped by
> tag_vsc73xx_8021q.c as part of vsc73xx_rcv(). It is even plausible that
> the same bug that existed for sja1105 also exists for vsc73xx:
> dsa_software_untag_vlan_unaware_bridge() tries to untag a VLAN that
> doesn't exist, corrupting the packet.
>
> Only compile tested, as I don't have access to the hardware.
>

Thanks Vladimir for this patch. This fix is required for the proper
functioning of vsc73xx.

Tested-by: Pawel Dembicki <paweldembicki@gmail.com>


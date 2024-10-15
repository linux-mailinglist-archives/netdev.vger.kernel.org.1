Return-Path: <netdev+bounces-135460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D7B99E03B
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1401C21CE7
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 08:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A979D1B85DF;
	Tue, 15 Oct 2024 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mhmo0han"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8BE1AB512
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979447; cv=none; b=prWDruT5IB32OyarzhckbbfZ/HokBc3vW5F+/DSVo0luk37deFakiJSrpQOTLvdqWella3Ughplst4Gsry1DIb/qpxEL9VVocpgXoUQGiq2fB6KtlTi2bRYag7TN3aBD0Z7fc49Y9krbZZMhTQ85jjvV686Kcq3C01ihLTtraKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979447; c=relaxed/simple;
	bh=cg8ZTiKRHddH2LrkHl1Brodvt2NMZutN65i/7fv7CLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Za09kB1geVsMOp42Vq4VJqPVX5GLA/iU3vcw/1n4tOxf81M/iEUf6AZXne8hUy+pTHvxffW5gCAgI8gN4c51I904KoK5KEcvbzonP7OzyQDbXlLlP/Cf+fvfPtI7K048nXPP2F+cdMvaQbw0PlkeEVFqca/LvSz7rjjVZ2GDro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mhmo0han; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb599aac99so10492481fa.1
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 01:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728979444; x=1729584244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cg8ZTiKRHddH2LrkHl1Brodvt2NMZutN65i/7fv7CLc=;
        b=mhmo0hantn57SWaPFCp7/gJf7M+URmhe1rFdOo5F0/K1/7Me+HAZkbVKS7nsZjLUzm
         gOyjnoR8lcrvO6lthiw9cc1eWFyRT/tpWBks+2C26wV1wDQm8nE5yKwIUp9uDJVxRfvn
         nLkELe8MqkAGXtcE//rJWvxEVHX0776qWNTEoYMJ33Dzv3/cjMil8kVMwLzdfvNnh/dk
         qeztsMTBgs23YowTpnGZ6OUZXaiFJdIjalrRttOwZJTsa7a7nca18huX1KTnyIX3tGWN
         BaYw/d6ofznUof2OzKHlKSugAGZe9L716FE9tX9udtpHnBdOw1Xl2baf6t5fmy1+5BMC
         pr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979444; x=1729584244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cg8ZTiKRHddH2LrkHl1Brodvt2NMZutN65i/7fv7CLc=;
        b=CRESuPNmvodRWqd4h6GgKEm5mMWThDJlqzGsXHORmFPZ69QN607PsSeHMbvYdFYjXI
         Zop85KqI824AdemMP/H5H9mB2t9t+vdlIL75wLChY1iHcreq2lFlw3ZwzbSEhMdYlME+
         9MTRRovuGR5Cp/87JSanReJgR3SeML4EN3oKHyC7IUSJsaM6/JeU+q4UvnNeo5R18DB2
         vw4NwEbZbGHL4fvckz0aSzyJyEJbPkQi6KO62jg3KNEz0whuvlzcAD6ps9Sc3B1P8f7y
         fRNfMlcWflEqpWCCN53f8i2+hrxh3X5WR7B7ocMq/a96vLfTFEBaCFVzrCCm9pEoLTw9
         jzLQ==
X-Gm-Message-State: AOJu0Ywdr9eidQUvJ8GEYL23rHHA06jQJljLtUa4dq3w7aAxC3L5vG22
	EjIoEJbydAtJ/iw09VgnwTZAixOSfhSxWKfhgKwnufqcF5QnZhLNX4vXqLWgqBYmKpZaGP+vsZn
	axA8l6u70WDPLEnp+LgS0h5kNL24yuLU1+55GhA==
X-Google-Smtp-Source: AGHT+IFcQyrqiAdXJ+r9KDvXZ5YMMibfRlIbcBH5SMLB+VedSKbJjk6EUocMzB7vaVj1fgon7Ldo5J0xOGnBh/Tx5AE=
X-Received: by 2002:a2e:bc26:0:b0:2fa:d3a5:189c with SMTP id
 38308e7fff4ca-2fb3f2b22a7mr46261241fa.36.1728979444087; Tue, 15 Oct 2024
 01:04:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014153041.1110364-1-vladimir.oltean@nxp.com>
In-Reply-To: <20241014153041.1110364-1-vladimir.oltean@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Oct 2024 10:03:52 +0200
Message-ID: <CACRpkdZOQLnvcMEN=U-aAnJHHu2g6JoAK3US1heb1Rfr1KW9_A@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: dsa: vsc73xx: fix reception from VLAN-unaware bridges
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Pawel Dembicki <paweldembicki@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 5:30=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:

> Similar to the situation described for sja1105 in commit 1f9fc48fd302
> ("net: dsa: sja1105: fix reception from VLAN-unaware bridges"), the
> vsc73xx driver uses tag_8021q and doesn't need the ds->untag_bridge_pvid
> request. In fact, this option breaks packet reception.
>
> The ds->untag_bridge_pvid option strips VLANs from packets received on
> VLAN-unaware bridge ports. But those VLANs should already be stripped
> by tag_vsc73xx_8021q.c as part of vsc73xx_rcv() - they are not VLANs in
> VLAN-unaware mode, but DSA tags. Thus, dsa_software_vlan_untag() tries
> to untag a VLAN that doesn't exist, corrupting the packet.
>
> Fixes: 93e4649efa96 ("net: dsa: provide a software untagging function on =
RX for VLAN-aware bridges")
> Tested-by: Pawel Dembicki <paweldembicki@gmail.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


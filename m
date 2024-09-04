Return-Path: <netdev+bounces-124837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6993496B20E
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 08:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D141F25AB2
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 06:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E2E145330;
	Wed,  4 Sep 2024 06:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHjmucRn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B9D145344;
	Wed,  4 Sep 2024 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725432186; cv=none; b=mvhLJD7+JpaFfhMRkMtlERnYSEE+8cl0oKeAH8empAc18+klXjlwjVgPZtxOCoZbYl4cdvxOXb8V0fQvkpjvJi/KAasZw8DixdcPo0Yc6HJQoD7/+omS0NeUh7qGf7NhROMZ3VdDntshadqLSlK7+MyJ6tfEaJaCX1POoKyjioI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725432186; c=relaxed/simple;
	bh=hB5y3XBtrjaPYDnMJFqZB3Oh0NxIh2RWDw1V9lJAR0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rqa1L1csFJow89dt1lSG+MKbFKchyOHHYxbh2KSjsOboA0529HyBWtXMHGdFQX/nG+Q6l3h4ByBJpFZ/cpQQE30vC2sCEQAu9rDubaQDWGVzUnz+9ycdNZzzJtZeO5/drKkYuxhHHmq5E2bQnw/z/TIxwFYoUNC2AvFrI/IdMzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHjmucRn; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e116a5c3922so5904893276.1;
        Tue, 03 Sep 2024 23:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725432184; x=1726036984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hB5y3XBtrjaPYDnMJFqZB3Oh0NxIh2RWDw1V9lJAR0g=;
        b=nHjmucRnYPuvD5tQgsRXBbt11v/GZHJ9sr9+WL1tS10HPXX/sfFQuCc4NUjkGnre6Z
         nKEVaDdenfzin1gxNaD8RFcDpVdws31uPl9YDpwDO6AuCMcCfW0HQJNwZSzNIi3Cywhf
         7rkBpbUbgo3FLG1Et8IkA/XrN9hraq5JTVUMTwh+2SyxcLNOT3XyeGAle9YE47Hvhfvd
         8x7o6/iY0J5sHmedti/0UMA6g3/Gb+gZOOiVIe9PjsghpYl85jmQ24KYtvgbU295GSnd
         IRSqFk/IK/jrDszumI9HSbqgA9O0PV3FyC0Tn//UTdPJEK4oOld+R5WI0UzWsmmRk6Ha
         mrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725432184; x=1726036984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hB5y3XBtrjaPYDnMJFqZB3Oh0NxIh2RWDw1V9lJAR0g=;
        b=mGEWMRvsbHhcGfsKXCtBIRjyG+4QNupZ2ZqsDNcnHTtn01ncV77+3/sod7kuaIJjBA
         aN8HVY4HFJCIb1BVmbCGJre1YvRtfd8QhbxS8ijC4QCVxHqLGmeVl8RIWw+CCn8/clUf
         oXs/OJ/batb3gn8yEt2uQMTe+vj9NBS9Rnj+tYR3GjNF78izBctn2M/weQ3vgATWSQCT
         1kpewTkO4KKGVcbbDp5XvX8vrR3H0APEIAWCyAOnaONATJmcQklyJ21XuLXU69765oeO
         jiR1Pwl/8ikrJM49HUb1eKTvmYsg685WROVFEOOEzOT8nCbqNODQW8P//pm9RhfUfNaS
         G1vA==
X-Forwarded-Encrypted: i=1; AJvYcCVkqHTpFYTt44xUT1AJM6Avb52qavmOoGglzktc7YQnVP4LLrq5p/597mj6kscUecLQ81LwjxiEP+Iw3Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu5j2H1YKVyX5Te6uiaKp4POS+cWoZ9INeUaVnWAQ+lFMeO56d
	9Wx/SrxFbe0IrlhzuI/mstWrRXWgUgoaIuQNSes5XktgPvuC0a/8ef3/bcOXhsd16cB+PJiZf1E
	CR5z+nYQ/xk4qHHqWqaNXKc2HCwg=
X-Google-Smtp-Source: AGHT+IHr6NCgMziIAUwYeYSzh3i9qnpj4GlwblXZ1A169DLcgXRzXuKyW0Q6qX8iZBFbgk1khvFTd84D3KBEHy0zi2Y=
X-Received: by 2002:a05:6902:1587:b0:e13:c959:2d3f with SMTP id
 3f1490d57ef6-e1a7a030cf8mr16698157276.28.1725432183569; Tue, 03 Sep 2024
 23:43:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903203340.1518789-1-paweldembicki@gmail.com> <d7c82c78-9f7f-4083-aeec-013f338df11e@gmail.com>
In-Reply-To: <d7c82c78-9f7f-4083-aeec-013f338df11e@gmail.com>
From: =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date: Wed, 4 Sep 2024 08:42:52 +0200
Message-ID: <CAJN1KkzBpFeVs68-dgkME4iKmcQbp8Rit3z=beCj2Sc+XCPEpw@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: vsc73xx: fix possible subblocks range of
 CAPT block
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

wt., 3 wrz 2024 o 23:48 Florian Fainelli <f.fainelli@gmail.com> napisa=C5=
=82(a):
>
> On 9/3/24 13:33, Pawel Dembicki wrote:
> > CAPT block (CPU Capture Buffer) have 7 sublocks: 0-3, 4, 6, 7.
> > Function 'vsc73xx_is_addr_valid' allows to use only block 0 at this
> > moment.
> >
> > This patch fix it.
>
> No objection to targeting 'net' as it is a proper bug fix, however there
> is nothing in 'net' that currently depends upon VSC73XX_BLOCK_CAPTURE,
> so this has no functional impact at the moment.

Yes. I found it during work on the STP packet capture funcionality.
It's almost done, so I decided to send this fix to the 'net' before.


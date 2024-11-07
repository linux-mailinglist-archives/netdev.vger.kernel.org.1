Return-Path: <netdev+bounces-142733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B749C0248
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 11:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B49C283831
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 10:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0981B1E32DC;
	Thu,  7 Nov 2024 10:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fxL4NPKW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C151DFE30
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975146; cv=none; b=S+TCZCXLfCEMZFPtMs+AGx7SMSPQioDFqjxR61mJuZSHCYM9gaJdbG1ALjeTIg81BhAlHbG2zoVL4e8OdXqP0SIcl1kw/oABChMp+pvE+CNEx/Hwt5Lqx0EfmEmExYpsYTRdxtOQRgCHMqO0g+UPFWCpjcEJrZsUu+caKCTK7p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975146; c=relaxed/simple;
	bh=CrKn0ncj4UPOD7ltuDxP9BoA99oYardMCiwfQBJdUNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZWm259PpHOIyigVi8ZEuzHaoDXrd4wSAKVtbmCw/plExPibIIawaFtZ1AtcBs06Zar5wBV7z9Xfcax8aPQWfzzrKOfjCJGtWcBy+mj6w5wVUdfg2FJyiNPPHORT+EEdbaWK38U+UoaEw5/b6t8YhTG0uud5XY2OC46ZiNULEts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fxL4NPKW; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9ed7d8c86cso122431766b.2
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 02:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730975144; x=1731579944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrKn0ncj4UPOD7ltuDxP9BoA99oYardMCiwfQBJdUNI=;
        b=fxL4NPKWwXSBz2+Y/XLs9A0I+kjHTYItN60UYcNny8iXo/+o6obGAMUJEmnFHfR6xn
         tNTkGPValbguMNm2Q/wmAkfOEcVlbF6/IO6r9uW4cfKDvFqyAsqj6ssJqgX/R996Rhpt
         XvIx5QmcrXFhhzrmq+Gf2auUGghw2blwOPUhEkBymgafhqB7Ut+JMpn7PZeDGEeCsE5P
         9a6Nkv90GD61j5u5Z6PWLCVosg6ZM/GpPOqwpRVrXaHf3JZFUx4E7tBYYiJZOAqXmZp/
         OSL5MQZXq9/KP15n1Sgb/rg/0k41c3GSu3fJROs/L8qA9wN7D7Es4w+PLm4EWPtF+gXx
         ecag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730975144; x=1731579944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrKn0ncj4UPOD7ltuDxP9BoA99oYardMCiwfQBJdUNI=;
        b=kvOcxr/B4k2A3Co5ilXdc8JH2baJmiwlzHipsUTmvBeElFzSvozcjKIqU6VXRNctDf
         3AXsiD2iFKqJnBNQ5r1fPal1SsYHs2TRNe8WclnOtvhmyDpSPknk3a2ojn23MtUVhLVL
         pH4Vn6d+F/JZHpROEGC8qI0s4A0QXduDnJHZjii8WxRithMX1XRWNvaNp0cPkiOYFxdt
         UAQzpFnyDS3hHOrAOuL9wOsWmA71VY8AExYxulHkX8FBksEfsJGpenWE0UbOeklaQYV+
         7QWxtNiWqU+QwyMpfqrL2LZ2W5Z8XRKwOcBZ0UIs6TZzQ9gicSy80BZazXBtJ1gLIVLC
         dFTg==
X-Gm-Message-State: AOJu0Yy5RKpqIHTU5kFfS8p7YJbiUj74pOhQd82HdZLoIw5xBtCH6+OX
	eRZENANac7NyYMZ0wGWoRa2HGm1SztqTjKvVNjuplJX4rR48AXVzPXJhDjivKXS9LpkcxxqDh9G
	xn7loukWGOs3hSSknHSxa1mSMBNq/XmIx8iSQ
X-Google-Smtp-Source: AGHT+IHZLsVFBntb4ie5BCSaC9k5XgL6WJ95PL3h2d88YHNjEAVk6k4mLN6m0hTM14TiBWmGbBTjOgx9IbngPPnogU4=
X-Received: by 2002:a17:906:dac5:b0:a9a:67aa:31f5 with SMTP id
 a640c23a62f3a-a9ee747a42cmr46309166b.10.1730975143770; Thu, 07 Nov 2024
 02:25:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105100647.117346-1-chia-yu.chang@nokia-bell-labs.com> <20241105100647.117346-6-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20241105100647.117346-6-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Nov 2024 11:25:32 +0100
Message-ID: <CANn89iJzF+NPX6NS3gbMCw1dUd3KB1Eo-GqhaAdfQb3meXLA8w@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 05/13] tcp: reorganize SYN ECN code
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, dsahern@gmail.com, davem@davemloft.net, 
	dsahern@kernel.org, pabeni@redhat.com, joel.granados@kernel.org, 
	kuba@kernel.org, andrew+netdev@lunn.ch, horms@kernel.org, pablo@netfilter.org, 
	kadlec@netfilter.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 11:07=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> Prepare for AccECN that needs to have access here on IP ECN
> field value which is only available after INET_ECN_xmit().
>
> No functional changes.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>


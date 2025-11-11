Return-Path: <netdev+bounces-237595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27468C4D98E
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 13:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 586F43B3108
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 12:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87287357A4F;
	Tue, 11 Nov 2025 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Opy0Fl+m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C197F2E8E06
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862773; cv=none; b=r438F/5kJqKwC8iA7ZqEwemtbkv/hexwAg2h0mdkvkhBQvOIF8IPF8TrBbiS5vMbDeK05IKkiBr+CKiBIA/Gtm7QzozxawZhZ1f8xXcYCvZzh7SSXC2/9okxqFz6j61oq/H6svZhKnireHVgWQHCDckCm6xeY9SHikTvx4VLa2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862773; c=relaxed/simple;
	bh=PJfKGTHGMO4B/tz3afQroGNMYkZc/dI4F7dfZZ5badE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=EBGIA0gzHJaJoY1cYTQeYfALdbrMayCuUpsaZGvUZWWLL1JJQMM2JF/bOqql4efhZgERyeysdbQ88cMfdbB1ylRj1ybJaZ3rg3MBOocd8vxz1LGI/nQlcZ1/wzynQX2Amm81EKzoBWOqjkbbahjMtAaEbVBChp1ijWZ1rnI6/+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Opy0Fl+m; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477770019e4so33292795e9.3
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 04:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762862770; x=1763467570; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tT7bnLXzfMu67NErihZLpcxDP2Pl9Q0RxSNbOgMwrHo=;
        b=Opy0Fl+mrik04dHT9e7Nwiak8J+cGjwZpdMNFO4/q039V+gbZ5XpffQ4EC3WY+hw4l
         hBBUzkmjbJXpX23Z3lv5s0z5O1HIVZ/QiRfOaAJOfncJYEu3FThcWCGfzU27SXT1WQ0t
         H7xbSJ4hVuvq68dfAuNQY4CZk7KsXNP3wCN63R5MLJopqwJ7xRTOh7bdMppEX41DYcfK
         O/IbFb3sfyCmrvRU1CZXauErlVfjETMam4lMTpbNPtwszLktJN5j65OpF0U5bd5H1BBM
         YFjDhLZ/vZ+uT4My48/deM+mPSLqjdIJ/O3CTrJEYZdbxSwjELpUU12px1pk7bIBv4pG
         5s1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762862770; x=1763467570;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tT7bnLXzfMu67NErihZLpcxDP2Pl9Q0RxSNbOgMwrHo=;
        b=VzQFCIAYJqegkayhRC8UHZ1nTXz0W5DO+jF2bYOr0WQBJDLHefQliKVvSQtogAzaHI
         k+22mxqg2HUDg4gxWoYq+A4paza+KRcXSyLicp0QB9MDwnzpKCc2bAvTxZ+xpDpuhpTf
         XtcfxJJXdcW9PD6QXBMcSeksE2AMTXPRWC0a1GdBBOXPZMat89xQPo3csQwTeHF9Gcgh
         EZ1OasX2/F6S57sLIDBpupOWscdr3rxYHkvMwiiRPfZQjMzlvR7uVggMU8VhaoinpE6A
         EnjXg1khHfZM4qky7MSGM4h3BQQGr3zXuXSryjIZACWdt/ux36cW2hvyNXG6JK5wZv4K
         rA/A==
X-Gm-Message-State: AOJu0YyRTKlb3PPwQsd9fflRcqGBNCjaf98HPd6apaKamojXHkaYFi4c
	6aEPdN4W6foLLh/xAHB0UbeqYoCi1ed1eCQ4MPzjhx4JICKRqhmBbm5H
X-Gm-Gg: ASbGncu33sxkDrOtyZbEbTpycedP8s6LKiT3YR2coWMvS+PqgV35actERaSvJb81YWy
	NDDZlv6udG3fbUO79T/3YaqZkWUMZS/RiOpQM/93yVUMVpEGEy3SjjSc/b4JvKF3qsDAlB3tJmn
	PD/OW9EuuvQPCcxPZ3M0hgjF2H2izoTekk4hL9DDZjnbyqS+UD8Bbb8E9e6KzZUVlcC1FiE2SPE
	2sbrqSiVi79RtAADw2yPQsHqJ3wxOOxal69Q+k7NywSjxPZwg/Wipr55KFskAU80AE0oEGWc727
	eekgvMiHHJ4AxjuOneFlsg/QVQS44TNl4zmhV5BJpIJgbQxoV8Q1iGUddGcV0cwLFrRHbVD4Cty
	b1PUTXms6hZs53+4utj8HJ3LOZt8f1WQ4vd+75w/44RVsSw8KAM6nzdUpFEaoFzLERpNkdH/m0i
	CUxoaggKBDZZew6RCdBsLnzXM=
X-Google-Smtp-Source: AGHT+IGT4s2UC3Gd4AKGQvCZDeCXUtMZ0syHOqqJnB+gmPCJPQiplZnyHvbxPq4w+G1wtB3LxYmmgA==
X-Received: by 2002:a05:600c:1c1c:b0:475:dac3:699f with SMTP id 5b1f17b1804b1-4777322f0c4mr108561915e9.9.1762862769852;
        Tue, 11 Nov 2025 04:06:09 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:f46d:4de5:f20a:a3c4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce211d8sm386246165e9.11.2025.11.11.04.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 04:06:09 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Jan Stancek
 <jstancek@redhat.com>,  "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
  =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>,  Stanislav Fomichev
 <sdf@fomichev.me>,  Ido Schimmel <idosch@nvidia.com>,  Guillaume Nault
 <gnault@redhat.com>,  Sabrina Dubroca <sd@queasysnail.net>,  Petr Machata
 <petrm@nvidia.com>
Subject: Re: [PATCHv3 net-next 2/3] netlink: specs: support ipv4-or-v6 for
 dual-stack fields
In-Reply-To: <20251110100000.3837-3-liuhangbin@gmail.com>
Date: Tue, 11 Nov 2025 10:38:57 +0000
Message-ID: <m2bjl8q2f2.fsf@gmail.com>
References: <20251110100000.3837-1-liuhangbin@gmail.com>
	<20251110100000.3837-3-liuhangbin@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hangbin Liu <liuhangbin@gmail.com> writes:

> Since commit 1b255e1beabf ("tools: ynl: add ipv4-or-v6 display hint"), we
> can display either IPv4 or IPv6 addresses for a single field based on the
> address family. However, most dual-stack fields still use the ipv4 display
> hint. This update changes them to use the new ipv4-or-v6 display hint and
> converts IPv4-only fields to use the u32 type.
>
> Field changes:
>   - v4-or-v6
>     - IFA_ADDRESS, IFA_LOCAL
>     - IFLA_GRE_LOCAL, IFLA_GRE_REMOTE
>     - IFLA_VTI_LOCAL, IFLA_VTI_REMOTE
>     - IFLA_IPTUN_LOCAL, IFLA_IPTUN_REMOTE
>     - NDA_DST
>     - RTA_DST, RTA_SRC, RTA_GATEWAY, RTA_PREFSRC
>     - FRA_SRC, FRA_DST
>   - ipv4
>     - IFA_BROADCAST
>     - IFLA_GENEVE_REMOTE
>     - IFLA_IPTUN_6RD_RELAY_PREFIX
>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Thanks for all the fixes!

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>


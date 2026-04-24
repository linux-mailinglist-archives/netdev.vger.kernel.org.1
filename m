Return-Path: <netdev+bounces-281016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONdEEM6X62m7OgAAu9opvQ
	(envelope-from <netdev+bounces-281016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 18:18:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C34914613DD
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 18:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BED12300E17D
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 16:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD533C2794;
	Fri, 24 Apr 2026 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BROJ5W9X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E0D29D28F
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777047498; cv=none; b=A2lTU7ksEs3IKsv2khFxw8xfvKe24zEsxSpaXdqPbGcE0XmE/SJbXrTgZ7nO+mfJK+O2I3aBJSU4kZyDpkqCc5Is6XeVh9hRzMHTPRGa4P2fIkMuqaExEC1AAiTEN2iGZ/ZO8T3+GbiZRG9VtKLEM2vkf9qke8DcEUL+/2JuNm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777047498; c=relaxed/simple;
	bh=6EJdF9IDvq7iflL0mSzSBo6he08M6ARvBV7m3BxRL6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tsczw9HcPR5dC9xBkTD2LPbcNTy7XUTpgOlOAMZN8CZ3UK51T4Kd8vcxn0VbYtQ7Qb7blGDfOMVnsNuaH7Fqf7YOtpBDrNLtC/H7n8sICeamsHFYffLhdzzUYVXbcIFyNLA2zfEqGcLwyhjuifFJUQdJ4IDhEC7xg2tfDEzFzJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BROJ5W9X; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ba5b107eaa2so722080166b.3
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 09:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777047494; x=1777652294; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3amLi9wBSIruu8J6AEM8fHLHz5k7wpPVhDCPdVDaeOc=;
        b=BROJ5W9XkbkGNLAsyxJLnI0povrB59ADSSgTyTKiI4w+UJVw5yTnmNWi7Yrz+frWnp
         IbtiJNjey0F6ncZCUIGTBzuLnOn2PEzds4Gmf8FOhOO9yd3wAB4jagWuPHvI0wYO70cW
         bmYhm+UbQb957rc/yp7HLZ8FCa2O1c2fEWNCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777047494; x=1777652294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3amLi9wBSIruu8J6AEM8fHLHz5k7wpPVhDCPdVDaeOc=;
        b=o6VRsgwtaEdC9Trj8MJzu8vqJ7bth622g3aV4Vvjm81L+q8IJcBJlxsEvYUU8mezLV
         jWvnwWYHHE3B88AMNSRfalWut3Y1NDZYVLycg1h5/T/ivlC1PMB/ffkbwZLaOwUiQd92
         WytNk8LKAodpM4M0H7ZBRBHDH/ajKvvpwiYp8TBi5OcrrkGazfidDvDDU/5GqYbhcUge
         DKUzPxAVb34/PuUlg23r17W6iDvFnYbuAF6r6IojzpsNxib9bzCOAONTATTyBKaSKhSj
         FwnOCGdzLlwW0xjPqOts8RA1OgUECSQUUraz3yl1zorsI5QY9f08uQGOGg9XECoqmQvo
         JWoA==
X-Forwarded-Encrypted: i=1; AFNElJ+8gQsxtywf8/c4Typg0WDCyH/vZXORbt0OamEDk4N7FSyUKy767gSQhiN5bpVzx9T7DOUDV6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaOILcW9E1QOM9TmoUuN5aSUZ5R7B2FHa7OFkw3DI7LyFzWpQS
	8quT760WkD0+5IdqV6EYp2v42xdgZwt1fGw6Xsa7vfdm3g4UPB54yquI1soT6ack88mT0oYc6WO
	cJswGNdJqug==
X-Gm-Gg: AeBDies2K9cyoD5g6pxZfQFjTV2dGiSUmZLN6vuszTyzozj4Y2lwfJZ1J8U1ByovE6U
	3eaLGKvf2jTHgFKV+cWR3LCWA1XRWxx+st3b9snRsC55PAb+2z2oguW90r3DH9lT9MHRXkScdpg
	lMfMtadycpuWqlNW3/9h0p4mLBBo9hAwG0+IXuWo8hEzhM1nWmr7cSSXtFyH8XihK0Hg7uXw5As
	5L1gq49BU53Q1kbXJENPUA+zsixq+1XJMqHut0+fPmz8UY8sY9myMkjygPMrp4AnzITjJXsaDOe
	lmlkWZZdhbdXO/SntiebJdp4gqvXKXvLYX5KluTU8SrC8GRye1dJr1FwDC9FATzxHC3VEC4m0J8
	TDlbJi4xdvCgLVK0JeLZ78ttP2e59w8AUN9PDt1F0Qgf3tI9JsXr6bsU9D8BgQeycMdzsluPTnM
	sO6BwHKfBuEoDvZ/B41u8arr1jLhSP3+KPZr+EMHjgIA+nHQ7m4wIW6+uATikBnR5dGhctcM03g
	+aydDo2UKs=
X-Received: by 2002:a17:907:6d29:b0:ba6:2c73:47dd with SMTP id a640c23a62f3a-ba62c734e53mr1364198966b.5.1777047494396;
        Fri, 24 Apr 2026 09:18:14 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba451211091sm843489666b.5.2026.04.24.09.18.13
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 09:18:13 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-67785ef88feso4049916a12.1
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 09:18:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9rYfaZATIgQgiAfExvEwQT3QsDBYkxom9HgEuEaz7kV1YSvQV3jm3iQkypqwMbR26PsBjqtW4=@vger.kernel.org
X-Received: by 2002:a05:6402:1445:b0:676:2118:fb1d with SMTP id
 4fb4d7f45d1cf-6762119034dmr12841548a12.1.1777047493481; Fri, 24 Apr 2026
 09:18:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423235422.1541768-1-kuba@kernel.org> <CAFr9PXnNVL4mUEu19jMu2sPkOucGK7Q32iB-7FY8eUpKZY_XJA@mail.gmail.com>
In-Reply-To: <CAFr9PXnNVL4mUEu19jMu2sPkOucGK7Q32iB-7FY8eUpKZY_XJA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 Apr 2026 09:17:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wimzLyMALBZmQUDGs=X0uJhnLhpsQJ1c77=BMwhx4GT4A@mail.gmail.com>
X-Gm-Features: AQROBzDg1CRVAg01H7IC7MfgmN8PNYzkV2dcaSKcybki1cV-ATL-r0f9P7SVRV8
Message-ID: <CAHk-=wimzLyMALBZmQUDGs=X0uJhnLhpsQJ1c77=BMwhx4GT4A@mail.gmail.com>
Subject: Re: [GIT PULL] Networking deletions for 7.1
To: Daniel Palmer <daniel@0x0f.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C34914613DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281016-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

On Fri, 24 Apr 2026 at 04:15, Daniel Palmer <daniel@0x0f.com> wrote:
>
> For the drivers I really don't think enough time was given for people
> to come out of the woodwork and say they are using one of them and if
> they'd be willing to maintain it or not.

I don't think we'd ever have that.

> If this does get merged and someone wants to put one of them back will
> it be as simple as sending a revert?

I think we can easily resurrect individual drivers if there are actual users.

I'm looking at that 3c509 one and have memories of it being a good
card. But Christ, those memories are from three decades ago and using
BNC connectors. I can't actually imagine anybody *using* them any
more, except in museum setups.

              Linus


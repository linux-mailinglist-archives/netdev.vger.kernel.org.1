Return-Path: <netdev+bounces-223669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F260EB59E4E
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEFF14839C3
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E0328505E;
	Tue, 16 Sep 2025 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTMvh5Bi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9276C3016E3
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758041389; cv=none; b=gwTWLOLlL8FIoA57KFcHryUbqbZXZKvqrw2taIn3ePdH0wI5yybWNlLwhK3C8hHyElodxmwW+xywUVChbnU9W+djOd1HD2F6v4hicXH8wDSI7aI7m4EuTGg29rxdl/i5heGsEFJND3Syx3M1VSm+sJHioIX3JRSh8iycIqLMtns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758041389; c=relaxed/simple;
	bh=TwcfabmK9WC+2NnCZx+uDvKHL+px3+cu4KrnzhiY1uY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=fkFCuSVH82NDe5KIGzHdHAZ9gzoFwkz1b6tEDjclToiF65241wZXGVpZ+7C4RZbfhtA821zRenKS9sGgvmSbhtb+6GdDo+SwdD3AGxt8kgNLcLraLxvgDO6MyYruGUG+5vTDyNKIHYyqHSN+6ez2cjd4we6Yjg/p+aYMT7GZzMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTMvh5Bi; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45dcfecdc0fso57507295e9.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758041386; x=1758646186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwcfabmK9WC+2NnCZx+uDvKHL+px3+cu4KrnzhiY1uY=;
        b=cTMvh5BiZAQT7XxuqXQALlC0nPbDxLSNPWLLTD6SDCVaPRvLnG1dPSdFZkIaf80UTT
         FZ7dKG3/4W0ASBzyTsgRAxvJWGT+xJnMT4qllBWWu4xnhxHKQr+exMN8pqlMyzDhVThA
         C9mKynrDNjxMka4Xw4BITjSzRZCxh3YNIc6JKlh/3nzoLtnifA0nVZMhrr0tJL6MgXjx
         +PhO5nrvR4A787I7o0Jh+WVTZUQYbHNAQppxq3YdBKe/5MItN/GcosBy3awlf2+JIdph
         qjxJ5RDKwdCYcBHxO40afUcVR1tsdopQVgEBdy/Yui9JYqjWLD/oQlfnB2h37GsqfjgS
         m/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758041386; x=1758646186;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwcfabmK9WC+2NnCZx+uDvKHL+px3+cu4KrnzhiY1uY=;
        b=M9RvKFwLK9rPjfCmyth+f7FYdl4GD+qRbv+sRAYbSlGtEnGlX2JJpjCNWaUeZ6WI1G
         XSyx+2SFTIJHOLojSXylPmZu9aJWCcs8waagDKoKjs9K3ACUM+NbjbgHyNfDvzoNJOvZ
         c3tYxNDIKBzUtrh551VDpALdHKcQaYA1pUWci04GK4nuSij1MCg5APUtZ+ANin7ahtWi
         cxWde//74LVCB5phxbIcaE9EGH72TdIVOLN2RlL+JkPWb/TfYAIsRPskJQh4+Knx0oOb
         EXrC3Ib8bBm0w3h8PBpW0kQs5vrgAwTzlJgz8+1oq0BW7h010NN8R4Uw1K6LxSKonsAh
         LCOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2UkDiolR088m1eJwRYk0V18IBaWcW0X622u+SH3kH0gR1NwRwr0k4digiOYBCTKcAKRFUh98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1+AMAhCPQSPpygDkdjuEV4JgqlJ/3N1Kz4yLj+XfpMyH18ffp
	6d2V1qlDf85JycP+PBMDygixj3rezGQy6dS2THXLN/7xpoucKa3+Qw5nfpUL+ZH9V+Ag2aJAu6g
	zlO0rFYON+nlgh0IXeHYi30599Oy1csdWC4g3UqA=
X-Gm-Gg: ASbGncsMusimJhdBh/WowUgCYgU3XZSEEh+B59IKNl6/mes41my4vJEzbxacrfzfZbR
	cd2qTqkT528Sh3UIkEl/qXNEhydTfdoaSW5E6n0zGBjDaJzWmXvcDQUPEGUTNdxwJFBd412fHBf
	I3TvgQKuHdAz0PRUMJ9ZzOIsfqKD2yaF9GPQEP5iW39qdGnT9NSUUUmvvacvSNObdfFWxrGQ9No
	meULixzSXXwd2uEBfoU78ovrycWza2PYJxPWIYBdu4UBSHSh6hNCW756ng116Rf052bsehPJ3i4
	+Vns4Nw=
X-Received: by 2002:a05:6000:144e:b0:3ec:25d2:2bdf with SMTP id
 ffacd0b85a97d-3ec25d22d48mt4512325f8f.27.1758041385551; Tue, 16 Sep 2025
 09:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912163043.329233-1-eladwf@gmail.com>
In-Reply-To: <20250912163043.329233-1-eladwf@gmail.com>
From: Elad Yifee <eladwf@gmail.com>
Date: Tue, 16 Sep 2025 19:49:34 +0300
X-Gm-Features: AS18NWCrlr2QeaCB--5yANKThME9nJo6aat3FBzn5_cxJNe5mTnDqX1wNE37gpE
Message-ID: <CA+SN3sp6ZidPXhZnP0E4KQyt95pp_-M9h2MMwLozObp9JH-8LQ@mail.gmail.com>
Subject: Re: [PATCH net-next RFC] netfilter: flowtable: add CT metadata action
 for nft flowtables
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

One caveat: this change will cause some existing drivers to start
returning -EOPNOTSUPP, since they walk the action list and treat any
unknown action as fatal in their default switch. In other words, adding
CT metadata unconditionally would break offload in those drivers until
they are updated.

Follow-up patches will therefore be needed to make drivers either parse
or safely ignore FLOW_ACTION_CT_METADATA. Because this action is only
advisory, it should be harmless for drivers that don=E2=80=99t use it to si=
mply
accept and no-op it.

Just flagging this up front: the core patch by itself will break some
drivers, and additional work is required to make them tolerant of the
new metadata.

Thanks,
Elad


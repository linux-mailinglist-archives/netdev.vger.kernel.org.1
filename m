Return-Path: <netdev+bounces-240139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 144CFC70CC6
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 862D13477BC
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8E336C5AA;
	Wed, 19 Nov 2025 19:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="I+iiF84r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE45A366DD7
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 19:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580196; cv=none; b=MoIg7x4pc0jtb3tKsLtD1V8BdoUfLqFp7UQZUO8H1obywhr0x0+GzPHeEbXJtRyWRxHyv2ifDshnkSUbwVpeLC1hGts1ylHQpfvTfjUUUxQUdivRNsgopSTQrTny4AM8mbR0V+LyuxJt9oWUDQ7rY0wlD/tEWBCjtIdXOfkUbUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580196; c=relaxed/simple;
	bh=SNe4Mdqg6NAIPK1SK1Ms+lEEPh9CF2D5MUTmnt6p03E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BlwWZg1j0jQiXkPIbyMbzuE8igk9slTd/49dKaFR8Hrj+B7qesP5dR2Mw+Q/ayjvjFBBMquezt69VyQOW3gVxG6QcjmOPEmXuXHGiCs5gOilALWeavYiP+G+xUPar2OMWxQO8MeFd4If89NqWU64jUVxNTNzFTALybEoEmfeuAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=I+iiF84r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C752C4CEF5
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 19:23:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="I+iiF84r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1763580192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vBS1R+KWQuyQS4ikMq/m97ZN3SpSoGN8I0V3RuwXubs=;
	b=I+iiF84rbqTdp86zcKG7OWQO05xfM1C3zQx6pkgytcAHKBfVLgBnOGRJdJn1uRndhDSWHR
	3oQq/aDHNr1GYeVVUq0//19q1CoZryJgr4PfeeUPdnPGFN6oSMGgqzRTSbhwPgm8XogD6N
	BCQhIYnpGkcv0S9yPwPzH/QbknAGBCc=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 53acf135 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <netdev@vger.kernel.org>;
	Wed, 19 Nov 2025 19:23:11 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-450f7f91845so18001b6e.1
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 11:23:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVn9J22pfRzslae91djHkW5HzTJdfrTvCng/vo9onmR/P9qcns4dyFoTiN/824UoQpfd1k9BIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaZONTPILn9CgptjT1+rgq9evU2fu6Md4dMuvemMjhzjhmE9hb
	1zV7md/vsLnQdRRKxutJcp+j0Xi3lHcF44QrSrc/rMqNvdNtLxvznX3RGS1VdFZWV27MXxRaJPW
	M5r6O63oDDqgT4x7Begjb/tDIKUgwOKk=
X-Google-Smtp-Source: AGHT+IFWThcQphzmtMR1ZuP2+pYZXYtjvWAaMc/MPtL0eQ+UOwpEqO8TkAKOgEc0jUYpcex3oAJFRMG7Wc/2bTyrr7U=
X-Received: by 2002:a05:6808:1796:b0:450:c6a0:3f39 with SMTP id
 5614622812f47-450ff3e8b6amr241128b6e.58.1763580190101; Wed, 19 Nov 2025
 11:23:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105183223.89913-1-ast@fiberby.net> <20251105183223.89913-5-ast@fiberby.net>
 <aRvWzC8qz3iXDAb3@zx2c4.com> <f21458b6-f169-4cd3-bd1b-16255c78d6cd@fiberby.net>
 <aRyLoy2iqbkUipZW@zx2c4.com> <9871bdc7-774d-4e35-be5f-02d45063d317@fiberby.net>
 <aRz4rs1IpohQpgWf@zx2c4.com> <20251118165028.4e43ee01@kernel.org> <f4d147da-3299-4ae7-b11e-b4309625e2c9@fiberby.net>
In-Reply-To: <f4d147da-3299-4ae7-b11e-b4309625e2c9@fiberby.net>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 19 Nov 2025 20:22:57 +0100
X-Gmail-Original-Message-ID: <CAHmME9rzr8EGkTy3TduTXK45-w1CwEYnRLX=SjkAqo1CTTgVHA@mail.gmail.com>
X-Gm-Features: AWmQ_bkA-F3ilICecskNIJAu7S_B6vXW8UH-CCPXrJPWb6WBZhcwX_rzqk5QfHg
Message-ID: <CAHmME9rzr8EGkTy3TduTXK45-w1CwEYnRLX=SjkAqo1CTTgVHA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 04/11] netlink: specs: add specification for wireguard
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jacob Keller <jacob.e.keller@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jordan Rife <jordan@jrife.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 8:20=E2=80=AFPM Asbj=C3=B8rn Sloth T=C3=B8nnesen <a=
st@fiberby.net> wrote:
> B) Add a "operations"->"function-prefix" in YAML, only one funtion gets r=
enamed.
>
>     wg_get_device_start(), wg_get_device_dump() and wg_get_device_done() =
keep
>     their names, while wg_set_device() gets renamed to wg_set_device_doit=
().
>
>     This compliments the existing "name-prefix" (which is used for the UA=
PI enum names).
>
>     Documentation/netlink/genetlink-legacy.yaml |  6 ++++++
>     tools/net/ynl/pyynl/ynl_gen_c.py            | 13 +++++++++----
>     2 files changed, 15 insertions(+), 4 deletions(-)
>
> Jason, would option B work for you?

So just wg_set_device() -> wg_set_device_doit()? That seems quite fine
to me. And it's probably a better name, too, given that it corresponds
with device_dump. It makes both of those follow the form "wg_{genl
verb}_{nl verb}". I like it.

Jason


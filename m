Return-Path: <netdev+bounces-253433-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMwSJYlRd2lQeAEAu9opvQ
	(envelope-from <netdev+bounces-253433-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:35:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C4887AFB
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68EEE3015899
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0106B3321B3;
	Mon, 26 Jan 2026 11:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xi6WGCmH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8569132AACC
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769427327; cv=none; b=OYNrU7vSDRHeAN2D7i5SaZEv52V5gNpA5m//S/QjHxrS4bZhuNPi06y41YSBRmDj5WgXvQ9rJXd2EwGjwEEBG96glSaY41OpzCpbVQwSQKQ5mJcOFa3pZ/XBGf6H4Ab2KBTZpjaiOZGpb2zq3Xam7mx76PrqzqHnUHTQIe1RNXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769427327; c=relaxed/simple;
	bh=L+VFtFE8vaxxokw+Pishur3tMraQm5g6ETVyD3plCxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fVHmOHdsycIQBUrIKK1fUNv0uLslENinLLOcTz1AFh4Ipwd2UIhjpBCQXeLSt7038j6NJMCPiDrst2pbZt5I7k7iJ+qSFLXHPlQeHIA6vSe2wOctDKldAYChQuARr/lPS7gPOwA+LSGBn6lAdzWsfjxS3UKK/aBX3/or1tudgNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xi6WGCmH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so64429725e9.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 03:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769427325; x=1770032125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMoDGeIwmEnNyi6Vj8HIaY7XY3f1o3JzE6Y7fyQabWE=;
        b=Xi6WGCmHUTH7L2MloasXSsWS2UH7jmxvFsRFc/Kq3bi7Kh43k9dHz970v5BB1/a6W6
         x1SrNX7sGNT6sQy5/+jFzk5IXBzK0kPLpSZOojYp3RayGHWvYK1W4RUjnAr3OqcwTH7X
         SJFW+vrqiVxSTKcOYGoB9WBz1m9KbsgaRhgMVf1PFMHOa/2NZd41eBJqKYP/tnvwWJ0C
         xoyPwBSt0duA4E2jSJy9Myuzh59sB6F1LRFJ0hIjlbZcGHvRWDCxXCqOoi9a0Sc4+WCA
         Xe5AbC3+8B+YNypCMa8A5jR/NWEX1ktbd17S+lAImcS+ShUu9qtiRfFTlJzlIgxj3eyw
         0ZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769427325; x=1770032125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fMoDGeIwmEnNyi6Vj8HIaY7XY3f1o3JzE6Y7fyQabWE=;
        b=ljY3dnIKFwyXWVa+pS0iJ+GESfBbbRfH4p315kbnfDYYdMF0xrqKQ6LF0StoxxGRbw
         xIR5Zi4hqeKP1/o9tgRvkU1wSuuEZfmdnLwxKQGyXw7uF5nxbSgBTZAJFyFLl74osXij
         n33ERzkdIdt7J3z3Q7Oo7yviBmfX9CBc2G3ah4kzVoMs7uoWo/cXXr9XY+O0kgBXoS0b
         GI2X1JVNa9P2mRU37kGmwlShhQNZ4gbGijplxEeLsHiZ6upjTmCGtTHs0BOE7swVp6Ts
         I0jYFUTVmTcsffhDywS/2W/TrS70fcppFeZsPuuELvyAz0tb08GlVuKVOC6QKHPndGYb
         2GyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCZ1bXEDZ5dBumcDcjMOYqR/pfPYF1kSL+4P+Askw1sajX2iy9dGWmGySfmTSs/Bx4ELFwjhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeyN6EZ70pIn1qv2T36yMBDH5gHHoH5ks4awBSKhf/7LUwlZ/m
	ju2442Lg0/dAnx3KHRqafLSE4LuDQ9F0Wu9FfWJUXhMr6qzpUeeZxU2L
X-Gm-Gg: AZuq6aJSA8sTlR/+9syr/KH6aNphwOnHBXQnq7FMwIW2GZNCEehXu6l2gCXnOHGbemb
	YqIOutISThI9HP6Somxvihx7zMPq9OhkN9k6raIrbXI+BFPbI5q/h8WmdK4xkac9fSHOYa+rpey
	wjydblG+z+uf6liP0RfEfgyRs/QIAotmcY6tyjFZ+IttLeyol89Iugl1UJ7vHe6N9LvWDdDPXEQ
	1jUg2NgtBsCAZ5XfR/h7KmOWQN974IQtOKzsJQgBeI7XacKHsW0NlghOh6kYdAJnF829i0dcbNT
	mD0vWsg2Nf9++Ut+c9FtnHjhb9am2hjl/Frv8EXuLPuJEbq+QDdnh8dZyNnNklDkVW7Zg4tIvy8
	ejQ1tpgBBOW+LgmVink8gKJK145KskKr2oVapHAzQhRoMiIs+R5630jTaFmWkpdsqG+eyvr+NHJ
	gzdyagNIwYhabDg4a4lGUslEFemxJXrbfmq7BnKo7b86z0a9obYdCi
X-Received: by 2002:a05:600c:35c2:b0:47f:b737:5ce0 with SMTP id 5b1f17b1804b1-4805cf66771mr75346305e9.23.1769427324862;
        Mon, 26 Jan 2026 03:35:24 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804dbab1b8sm99455265e9.8.2026.01.26.03.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 03:35:24 -0800 (PST)
Date: Mon, 26 Jan 2026 11:35:23 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, David Yang <mmyangfl@gmail.com>,
 netdev@vger.kernel.org, Lino Sanfilippo <LinoSanfilippo@gmx.de>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: alacritech: Use u64_stats_t with
 u64_stats_sync properly
Message-ID: <20260126113523.3663baee@pumpkin>
In-Reply-To: <CANn89iK9xfvQ275f+PPht8mM6K49mUq-T9D-4UUxUkTncM4tRw@mail.gmail.com>
References: <20260122185113.2760355-1-mmyangfl@gmail.com>
	<20260125152324.1b7e5a9f@kernel.org>
	<CANn89iK9xfvQ275f+PPht8mM6K49mUq-T9D-4UUxUkTncM4tRw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-253433-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,gmx.de,lunn.ch,davemloft.net,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1C4887AFB
X-Rspamd-Action: no action

On Mon, 26 Jan 2026 11:11:09 +0100
Eric Dumazet <edumazet@google.com> wrote:

> On Mon, Jan 26, 2026 at 12:23=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >
> > On Fri, 23 Jan 2026 02:51:07 +0800 David Yang wrote: =20
> > > On 64bit arches, struct u64_stats_sync is empty and provides no help
> > > against load/store tearing. Convert to u64_stats_t to ensure atomic
> > > operations. =20
> >
> > Eric, could you comment if this matters? I expect David may send a
> > non-trivial number of these, I want to make sure we're making good
> > use of everyone's time here. 64b accesses are not torn on 64b arches,
> > and never used for control flow. =20
>=20
> I  added u64_stats_add()/u64_stats_inc() back in 2019, and never bothered
> sending dozens of patches.
>=20
> Presumably compilers could be really dumb back then, I am not sure
> this is still the case today.
>=20

gcc still generates 'crap code' for var_64 +=3D var_32 on x86-32.
Basically it zero-extends then does a 64bit add rather than
using 'adc $0, %reg_hi', the extra register is likely to force
a spill to stack.
But that is 'fixed' by using add_u64_u32().

Oh and you really don't want to support adding a signed 32bit value
for one place that wants to do a subtract.

	David


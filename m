Return-Path: <netdev+bounces-215618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135C4B2F93A
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0001D3A4845
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 12:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94E0322DA1;
	Thu, 21 Aug 2025 12:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0v9oDKlh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D789322A20
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 12:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780955; cv=none; b=dw+ZQTP9QMhCGPdk3G4wBtykKHgwWBZXKLdrnFtC/ZGP7UxqMH5xuFgMGQ+m0n2qZUmoE7W6qjR+bQd5KWtk4Xt7LKxrfdimI8sPgWgijp/deFzFB/yzHYiQU4r6Y1ifzGbJ1XqEOY90z5W7fDHP173dBKc3OC+wmsUPo9hlqPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780955; c=relaxed/simple;
	bh=yP4uFd+CVN8QmVu0Qh7N2PPSnM2w3mGXDGkAjb/uMEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtFyRUd8HTugXRBmETwF/TL4mgA+xCjcdaW0NfLM/Cc9d5dNSvJwyiGcAL63GtYH34tU2hQeymTAalNHxumD+H2jHLJv78jrLczFNg78jgOpRsfmAUiyrKifz0zWpxqvK1/8KpvMtfkMb1cIsdnbupyfHtTweY9SUSKoP3FMAXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0v9oDKlh; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b2979628f9so11319951cf.2
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 05:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755780953; x=1756385753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5528SypKxmfUKQp47IYx/CNrd7NN62FARpZB0q9InII=;
        b=0v9oDKlhRpjnuMvP16A2EZtSRJmnIUAzPrkFiknLNjiksyODNmtE5ZUHemXXP8cNVo
         +nWpxM4EhCNHrH+9ykjIKmFA+n0yQY/pFJ+4oqcJ33n8KqC9qRuBljoPXKKzSChHQPGb
         FC8PpKql0hhlMF1UPYzhYMnoUn5FlH+HBiKG30NYdYerqzbKni0ucCZVH7Dil/1Uheoc
         ylMPlpX9UXXs7hkojeuXmJsvCj+WexH49ki8M15XE5ZggqZVEgcC6apRqZfp3g/4zyJh
         HnLxGKxlkhfzI9yNlnc+OhrqjZgRJi5wKoHS9DV2dkL0OxCUS0mEpG1xKiv928QRi5Z5
         GC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755780953; x=1756385753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5528SypKxmfUKQp47IYx/CNrd7NN62FARpZB0q9InII=;
        b=GBq2NuXef76z2KnPvWQKDC9gA1Qi3+6zNFkuoUNFog9GUZQ71oyQbBrZ5XEYloDaw9
         ekAMrgzg41TFC7+9UhOAtQdvXjBIkjnP2VZisXCAsQcYC36jg4ExdR8LU45l2TJbhGcv
         0dF6aWWH0zLv7P/kFrk9YXh0o53D1/bITmuLhp7V3NP1nSh5q7R5N4+zpie8I4V1t64E
         ICSCSDr/za8z9j32uE0Wu9knl4djQVfg4fk1ataEqkGOz4qdvNyTq58Ot1yLGd6Yosxh
         d8fF5H7MpB50vL9f6oxoOsVG/A0rsUY52X5nmtAS8Y8nS+7SpixUDjT0pbcaW9K1JqQQ
         mNgA==
X-Forwarded-Encrypted: i=1; AJvYcCUd90P6/DuIp6M1tXMV4555EEHALUbzeawoYw+MGey+63kIVHUSF0xo0QmPXdCqgVHt5VeCr+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG9jE0usexuWSGVhElwXDbwYeVlyWY0/0kyBlOPvALQS5x+Mjf
	RHBNAHHTTiwEgiWNShS/pCbUfFqM4SiiQWYk7SK9eC1MnrxgNs72k3GLS/8tWwDPt9pjLrIdEYt
	uTEgzhwRWuDGv6qagxKU3SZZbWwYev9AFYd4Kk4pB
X-Gm-Gg: ASbGncvVrtQ+XP6m8mwODMDjqdrRZArhjs2/kaFLreoavIJCnlT75JTJd5bBTcj5tCF
	LM2tk/K9Xkuy9lmJWkwtZ3VDQr7nvd62+4m7fimD3Ssr2/dYH8s6b1XDxcGhEhlWH229XYfrPDO
	+lxHkHRrLji9WZZbF5CERh3cwRRnd3AlyCljqaRrmWoxHDeaBHWE9sIRW/rxaoP6YH33ZIzWuOB
	zPoEx73OSpWJU4=
X-Google-Smtp-Source: AGHT+IGxDBe1t3tqBTBMYOGbwfPoYLNM6YX1F3rAdQHXVgz1RYTgaAusYj182uyw4hmqn9/ToW6pADpoA8RYUEd0S3w=
X-Received: by 2002:a05:622a:5917:b0:4b0:f059:74a0 with SMTP id
 d75a77b69052e-4b29fe8f3b0mr29953531cf.38.1755780952620; Thu, 21 Aug 2025
 05:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com> <20250815083930.10547-13-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250815083930.10547-13-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Aug 2025 05:55:41 -0700
X-Gm-Features: Ac12FXzVorC3Kl9sEMZivEmtWbDbh3dePBwk2mL_884gL-t00rnVrn0sX3b2dM8
Message-ID: <CANn89i+xNs7jfc3OF42J0jat=-ivrQgTfycJPyKW28yTJPaaDg@mail.gmail.com>
Subject: Re: [PATCH v15 net-next 12/14] tcp: accecn: AccECN option failure handling
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, jhs@mojatatu.com, kuba@kernel.org, 
	stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, andrew+netdev@lunn.ch, donald.hunter@gmail.com, 
	ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 1:40=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> AccECN option may fail in various way, handle these:
> - Attempt to negotiate the use of AccECN on the 1st retransmitted SYN
>         - From the 2nd retransmitted SYN, stop AccECN negotiation
> - Remove option from SYN/ACK rexmits to handle blackholes
> - If no option arrives in SYN/ACK, assume Option is not usable
>         - If an option arrives later, re-enabled
> - If option is zeroed, disable AccECN option processing
>
> This patch use existing padding bits in tcp_request_sock and
> holes in tcp_sock without increasing the size.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Truly invasive changes, what can I say....

Not sure why you CC so many folks which will very unlikely give any feedbac=
k.

What is the purpose of WARN_ON_ONCE() in tcp_accecn_option_init() ?

Just to feed syzbot ?


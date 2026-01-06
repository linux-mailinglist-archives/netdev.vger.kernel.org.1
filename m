Return-Path: <netdev+bounces-247452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B182CFAD43
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 20:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCF51301B2F6
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 19:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D2B3081B8;
	Tue,  6 Jan 2026 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jO6hl05G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9013009E4
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 19:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767728739; cv=none; b=G7AajLCek3aMmM0Y/ur5vVfN/Pyd2jiYMT1FRQbB6sgCdDBtPhiZYI0fJD631LhH3jYSxAMZ0MePpKNOpKcPXM74SpFgdJ5U0EpnNtKb77NiBwAoteuWERIOCwj64NS5OI5P3R+mv+1skc4TMkJadAjGWNYfUeozQEGBkuJObj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767728739; c=relaxed/simple;
	bh=ayHnqcjeX/tzt/JWblQVAOckyhRj9Lap01Rrzl8WfXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMC3EtFPgiqCPxur5Sj+Y+hP4fSiweAjtsblSw4w7We1G3iIlswIA1OwTTnwevAY2Za9ClRbPQx4GESqgmgINwNPoHFWSNQHj/toe3kgvsM1646MZgdMciOGDGZiB9U5s0B/czLEGKbriBteQ7fo1SvMsK8CZGNLKf2hQbLxZSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jO6hl05G; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ee1e18fb37so11631001cf.0
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 11:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767728735; x=1768333535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HXJyTSWET4IDS2dXXf9mkzWer2AyglDkgyWxD0FgDI=;
        b=jO6hl05GNIFTQ3+y/kda/BV5xQbxOZSK9XRgYvOODkgoRE39LpDXKpobBaraeeQFpC
         idtTPOzjkLJDpyaNyCqSzlNSLVbmjRn7XJDRQhIlFHMzSFdbpmWWfo6VovARtWNgEgxF
         Vj2rMDrBS4iDkQVRzSjTVWr7VgJa8reNvcbFhmerfhpFva7hTBoZO3kq02hblcBoV0ii
         OIDTCqaaYAvncvxw5Wxk07dTh6+1R29RCubXm1Nz2L2PF77eP74OHtl6r/DS0r0jO62p
         9wOpLS51U14V2LLWOMdd4vYB1l6EiLKVJj4jxJnLp/fpdbuOXPleCfRL4gOUaTUnoMrW
         4kzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767728735; x=1768333535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9HXJyTSWET4IDS2dXXf9mkzWer2AyglDkgyWxD0FgDI=;
        b=ekLBB2WtvavdKWNFgJBzX7znbaWM/f9ucY4Q0rWg3q55PEalCIRrnXIva/EDFfjGVx
         K+1HqxsMlznbQURWCl7SV7CoLwww0SKfqbFvqgx11QeTfMsitjGEXqSuat/gE97izGgV
         qXbNP6PSOKxDxoeum+jDe5f5ai1v4k8yYJG0oMYkD1KcX2FE/j5lkRDsG6PUtggziGA9
         sRwgqz4nfdEx+X3UdcDyg4OGHUENt8QVLqn7IeKgFWMBBKMryhMpgK96+4Tyq54oYTce
         v2ux9XteS5c7TUU/aydpxdljBbbkKApkrSfqnN5EhcRJ+xpAxaZ8zCmHITRthykZsWal
         +j4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUj95HQ51NzgKPdgsqKj3wtxE/9cUojjpVHoKiNeLH54oCv0KwvrAU5CUA/yn83QK5vsbdL6FU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsKkqVyqdJRqPFifWlrVCfxC/HliaKCoHkfhlb7clGEtikLPV1
	7p5qEjYIKFcJ8IkiFrXvxCrG6bT+WrbT57ZgZqQGwqPSGDcgiN2GzwKTCBdmmJyxRBKxB3TTln0
	WjZrmfRIMDzF6Q+rRwp0s1HPshNsTiaQkuGxOV1Wh
X-Gm-Gg: AY/fxX5Rw96Anw6ezz4GGugfkxUsVBd/k68lvh9gGbgYu1P8yXNwLZngIHvqzJcuIcX
	R2gZ9JHSnkj6VeLeLAORTXj7IN4eWrotZATyVMv8xi/46b8A41YF+OJso+AcRL862y42NKVYX4w
	ZNJ9poLDtXStcD5ntJoFy2LxgxdQ2FEoDCCePiEAHJ2AosOzZrv1t5iHCIjocA2gF89pHJCAiJa
	rkyQyZgxawm0nzqpKiRGXTgB+w5qev2B0nBJsqpG3EWvgf/XSbE1eYgovidF2nUmKZUPJs=
X-Google-Smtp-Source: AGHT+IF4CF6Y4DrhHN9Vd/5+IpOIX4PtBsqt+D00WrtuY4RqKr1nBg2QHzPR4KP6DRBs6W+uAGSESqbP2fsXQl+NF5A=
X-Received: by 2002:ac8:6609:0:b0:4f4:ee07:91b9 with SMTP id
 d75a77b69052e-4ffb49f4abbmr650461cf.47.1767728735265; Tue, 06 Jan 2026
 11:45:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106164338.1738035-1-edumazet@google.com> <20260106113041.18423d86@kernel.org>
 <CANn89iKzd7LHOtQCKjTHN4a0uzbAv8En+QwzYy5HT0fQ1W3n+w@mail.gmail.com>
In-Reply-To: <CANn89iKzd7LHOtQCKjTHN4a0uzbAv8En+QwzYy5HT0fQ1W3n+w@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 6 Jan 2026 20:45:24 +0100
X-Gm-Features: AQt7F2r-6sRA--BrLaNt701APNSj4oRIZF1bPvqctuDVgH6Xl0vwCQh7rNaZOw0
Message-ID: <CANn89iLL==4WekcdtReFRTfLtgbzRWQinDfjFi2vNnHs1yTj_g@mail.gmail.com>
Subject: Re: [PATCH net] net: update netdev_lock_{type,name}
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 8:43=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Tue, Jan 6, 2026 at 8:30=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Tue,  6 Jan 2026 16:43:38 +0000 Eric Dumazet wrote:
> > > Add missing entries in netdev_lock_type[] and netdev_lock_name[] :
> > >
> > > CAN, MCTP, RAWIP, CAIF, IP6GRE, 6LOWPAN.
> > >
> > > Also add a WARN_ONCE() in netdev_lock_pos() to help future bug huntin=
g
> > > next time a protocol is added without updating these arrays.
> >
> > Looks like we're missing ARPHRD_NETLINK
>
> Thanks, I will add this to V2.

Also ARPHRD_VSOCKMON.


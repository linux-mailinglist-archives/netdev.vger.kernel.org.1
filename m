Return-Path: <netdev+bounces-201011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C58AE7D9A
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B37417564A
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CAC2BE7A5;
	Wed, 25 Jun 2025 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H3KI95Jg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7405627C863
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843995; cv=none; b=NyYuQd97IQ/WBWfy2XURIv3DP71FaLq7tHLIT9uNnbF9pBAwwG7KaDy3AxAsf/sQuhXb87PPfjWhFUCY6+yG8+u31ajqrpMEidiw2i1x63+F9xO4Typt3qWHbomr47l87LFDWult5Hfz+7NNvg+O5xAsWnr5VpV8NCbpvEUXx04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843995; c=relaxed/simple;
	bh=EHQEZ9ug+BKYVFfxiYsk5XGLHx7H07bgZOTK3MCyALo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhkJ8ORYqLiaUCLpufiXp4deWVHQOPxjzppayNxqJ1tVD3tlfqJ5n845VsCPsRQ78nSe9ASwLmHVEb28nklUMS89uIn7Tq0A1G6kRlIZS3rjMBH/BSSimd0SAtL+l6r491Yrk/HOX+L0/dDy48dyXtj/njsmKHahmVBXweUbCvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H3KI95Jg; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a76ea97cefso69040771cf.2
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 02:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750843992; x=1751448792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHQEZ9ug+BKYVFfxiYsk5XGLHx7H07bgZOTK3MCyALo=;
        b=H3KI95JgPVvSKpWSbt51FkmpBFShBNE7/kJN0w5yW1QK4IAIMz5Nv1C5id8QT6Z/cH
         A4sQvf84GKqrp18jfQ1kTCPyqw0VOeXBrkps9Vl3g7/UYr0B18r54fDy16QeevQ+yim6
         USC3di7fHQOPoGY/kA+BNeSIce6Dk3C3pgaIehbxOQdBHq5frJvnR/ax5e7pKDeUfO3A
         9SMrDRwwedcdECCDnBqXfOiLQj2amWCq5M74f8oei9HBl39uoCRnLZAtsp1bMi8Frn+a
         SokNub3Pt4QCOd8EujzApWr75Wx637ncmrwzbyKB9BlRzLEN293lCCxgnQ0HpLdsDW5Z
         HYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843992; x=1751448792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHQEZ9ug+BKYVFfxiYsk5XGLHx7H07bgZOTK3MCyALo=;
        b=pHPiFdTWvGa1CD/pyAE31Tcw0bgBafUOqVWLDSo+X3pERTYEPEh5sANRdC6XASQGmW
         /YFRVbXFMEmlgOa0Ic/q4DA1KWRhNW4vh+/gHb6w6IJIv7PMTGifAjO3vb11xCPOAQVF
         nGX8BkaSP+1Cb9SO4A0YPBhkdXyq004XpBnvz/0/fLhofJPMn0ApFSulxe8FfTEemJFX
         +Gzl32R/mLIVRghNzHyFT2Ff3jID+VBlixzTFYJBcJ4X+qtN9fgvvOjZ8Xz73hlBDUDU
         6GYEZ4+xpe4gxTcjnndvJS56qmyvnyHKL7GYi4cqUSy+HUVmNmo2mXaZv+YDE0ZKeq58
         yhSA==
X-Forwarded-Encrypted: i=1; AJvYcCVx683rF5lt6P6X88xvH21i8VRMfV89tsXhN7fCPvE868liK23swtQ+EoMwrzPaAtPzUaJcRJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmTNggmfQmtJ9eueaRADVHejvuV8n0M2tRbBhxGbYL7x3GUxAS
	cK2xcwXaq98EeJa3uQ6hkIwFmfWHKX41vTDaUdChqhyyeTeUQ+g/dSNn7CRyHa+6kdjl7BXOe/K
	Gn3MTNnMcO4kp0I2X60omiGr9js2J62Eo/ogd9HTa
X-Gm-Gg: ASbGncuZsSIhdoZXkBIwYBuS0leWuqi3F2KDaCQshGJwloBvA6LJiQYr9VDJ+23uyW5
	dPREtwEou5qacxcOOdCCpjiZN52NfTYpc72ucGeAq2yn/J2OylaKElfy+Ojnw7TT0imToiqQUuJ
	aMdM0+1XNwCsuqjDfQzEgO/el7fCC8+KnQyI6J6bk3TMJwBPVYBZQy
X-Google-Smtp-Source: AGHT+IFl2hsx83MoQtHXwzaTy2gdPUKkrnzBZt+R+53c44zwQHWVfxVlZ3qeSa5gcYdHaUTwLPYKINTrqGBaAZX4NCY=
X-Received: by 2002:ac8:5d4f:0:b0:4a4:2c4c:ccb3 with SMTP id
 d75a77b69052e-4a7c0808b1fmr38916781cf.38.1750843992056; Wed, 25 Jun 2025
 02:33:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com> <20250621193737.16593-15-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250621193737.16593-15-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 25 Jun 2025 02:33:01 -0700
X-Gm-Features: AX0GCFvvtwK3EY_HeBJK2lmz3DF6DjV7RiAEa0hah0gNfU2C4uUiuaopSIAF9OM
Message-ID: <CANn89iJQJbggfu63j7cLH1Fr5jPwEh2yP05dZn5pQ=zpk3iXmA@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 14/15] tcp: accecn: try to fit AccECN option
 with SACK
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 12:38=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com=
> wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> As SACK blocks tend to eat all option space when there are
> many holes, it is useful to compromise on sending many SACK
> blocks in every ACK and attempt to fit the AccECN option
> there by reducing the number of SACK blocks. However, it will
> never go below two SACK blocks because of the AccECN option.
>
> As the AccECN option is often not put to every ACK, the space
> hijack is usually only temporary. Depending on the length of
> AccECN option (can be either 11, 8, 5, or 2 bytes, cf. Table
> 5 in AccECN spec) and the NOPs used for alignment of other
> TCP options, up to two SACK blocks will be reduced.

I think it would be nice to study how AccECN and SACK compression play
together ?


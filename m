Return-Path: <netdev+bounces-216037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6722AB31A51
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 15:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C9A17F09F
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 13:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B20C3043A6;
	Fri, 22 Aug 2025 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f2gYEOTZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A6E2FD7B8
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870668; cv=none; b=Pn+2JDKxXRIKEmx6MDOw+6Msn9lTEBQxu8MC6qNA5T/jJ/2hgAM3phRUhdnC1XwNrt1g+I+KLH/HCq0icq2OEMt6yToiyrsR44ycR9rZejfJAcIUy7lgI54hfy//MQvXeKE5KF9qjBOAJ5Bkiy05rZtMjm3rpXPHrI5WKinvfMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870668; c=relaxed/simple;
	bh=yAa3zzY+Li1+IBiGePpfrTGngbPVzMHlZhuT4vm/+7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwA+HNkvjU1s/+0MnknT5yO2+OSCPMCB2WJv4i466NQ2tszt3a6NX4VET3ZkyyI1U8BwNdT3txzr+638rd6oFtZ0pCCWiwVJAk0ZGJImDCLUsdrpjWqECzVnjELEiXnt3jaPTvbvTKVal+aOgdq1A3bvp6bkm+MhGlqCpu5espE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f2gYEOTZ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b29b715106so287251cf.1
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 06:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755870665; x=1756475465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAa3zzY+Li1+IBiGePpfrTGngbPVzMHlZhuT4vm/+7s=;
        b=f2gYEOTZUTvUxf7s4weIWu9kSG88nXP9mLuIutsXlJKrBirDCGmkFvotGzELve9r04
         GHwZGZwfLmI6SGBoaxaBUABHaGbmjq2L+T/1al+OqUWUuoo9J1wDHBRfic9ALQBwU0pA
         1z54pEhdpRuldK7v0ShLHGL3uSeaJ+iXVfRLWvz0sIJBmr9+nEkoYgVpk5mHmmVob6KP
         8PRzFb43d11XDdNbA9hftx9xZjb75A5tkNT4JsR/WmNK+VH7u1mFFH+tBZ2wnVpwjfyX
         Mx6K5QJRurv7+w58vyHC3P4+WQCDYDgRIJ9L2PdvXarhprKqx0M4Q3AIBl6TtsawlqE9
         pxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755870665; x=1756475465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAa3zzY+Li1+IBiGePpfrTGngbPVzMHlZhuT4vm/+7s=;
        b=JzJqCG29vqIiJmdr23GzCpplJv8j6rsQHB+GzXkM2aqDdEyGE+JOXvsANzDLakz44D
         qN5vQRbMhL5EphpcjbtHLCoN6TafBRvnWc1Mw+7cr/m46sStZ3u8h1iEDJTN0qEhDGtJ
         papb1+iKKCssBFq/q+PahdPiLHOeefToBzyXiUeRHC9PxZCiHT5fKEPVWl29c4JnICMW
         sVG//EcXSFQYeBBbljqK0sEntC7QB60hmxeBIPPGmv4d5zDNe2cuy1C/9MhdZWuWbrmV
         okFAO2MF8Rrm4M7lq9BjGQ44irSk1lRXu1r+u/WwnLdUbnZvhhyWn71Oterl/o8xOMAa
         sCcA==
X-Forwarded-Encrypted: i=1; AJvYcCXS+IzDmN03WD/DVrCIyLs1Dskz0ZSsuAKF4KYY4hqSITxJto7Lcybkc4JXGBHfcbNBQ5GWcqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc+saEUp9ZOFRgPjYUYJx/hvs1UV2BR1TMdlY641npFVzc/a2j
	deQl/0U1K87FPo29W/KbZ4uYtegk73l05sWnvM3VISDq+X6f/jNfBCimjW5qOGh0iOYjPrZhDij
	D7Jc3Gr+h4+6pDXAmv8RhfOOSF6Qi0Zv0/CIu/e4V
X-Gm-Gg: ASbGncsfyfYQ35yUL9YbpB47qYp8kRrh+o28yqAMFXdl1S7pNjYkREBmvz9E3Eysfmc
	f2zFdtgPVtrAfs7LriApMLb0M4v49IxWBe1sacJ3hIkllEGYcgcIdWZLxwRqS3V++2w3X2thNCl
	MpXr+wXWK6MIfMBiOHJN26m/V8+wLry9YtaEIds5DYa7ARMTbpUvGDbEJ2xUIcDEHJXvfgVcQE6
	k1UR1lv51kkyA==
X-Google-Smtp-Source: AGHT+IG5JO/UGSEQErjrmS0W0/9EwQdguTWVlgDEFYiBQ2d6STdtsjaTnPC8GVL0W6VIrm13IhwdNWI/Z4/tIctq40c=
X-Received: by 2002:ac8:5a06:0:b0:4b0:f1f3:db94 with SMTP id
 d75a77b69052e-4b2ac5813bcmr4270421cf.5.1755870663627; Fri, 22 Aug 2025
 06:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822091727.835869-1-edumazet@google.com> <20250822091727.835869-3-edumazet@google.com>
In-Reply-To: <20250822091727.835869-3-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 22 Aug 2025 09:50:46 -0400
X-Gm-Features: Ac12FXwYzoWco0f1DxjgIsVMvqn3EsH19sBAFFlgxMaLnRQg8gFmNH-nVSmUz4Q
Message-ID: <CADVnQykkFBMtZ7LtSbNy2cnte_zdQXf1ZvJJ-0SqJfQXb_apbQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: annotate data-races around icsk->icsk_probes_out
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 5:17=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> icsk->icsk_probes_out is read locklessly from inet_sk_diag_fill(),
> get_tcp4_sock() and get_tcp6_sock().
>
> Add corresponding READ_ONCE()/WRITE_ONCE() annotations.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal


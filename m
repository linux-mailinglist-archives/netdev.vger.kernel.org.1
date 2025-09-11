Return-Path: <netdev+bounces-222049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B768B52EAD
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 12:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E4718878A5
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 10:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1F32D2386;
	Thu, 11 Sep 2025 10:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G/SMOWFm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928EE23ABAF
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757587057; cv=none; b=IF8Y3p81md1ZlO0+WIcNE88O2AE7LxoSuefYGL1dQPsYSrjK0d/vdHV5VvaSt9e8PBRITdmHV9iv1OrzluwUmqBkwGxMyQPA092P0xJsp9zHtQSKSr98NHTQrmpIkY1KfPdJN3/Ys1HNE4k3vutmEAskD+abkh/hRoQr0VWGkeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757587057; c=relaxed/simple;
	bh=gBJAhqvEHPrcQ7AuGOAnRt88ljqyRo1HkemhDWzHqMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTrClAbd10emlAGj1I/wdZ5Y4XZf2wlcSwp4GGLEtFW1Ke+DQLzqp9F5eYMAVLgV8N77/bvF9bB28kfl91FLJHJqugF67ifnhRXd6XpYqA3n43TTNw06FGJGroIPpPpu0fxyM/Bqf8UGRn90kfcGho8iWboM/Wn3NtvPEyxuGMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G/SMOWFm; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b5f79aa443so5220441cf.1
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 03:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757587053; x=1758191853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBJAhqvEHPrcQ7AuGOAnRt88ljqyRo1HkemhDWzHqMk=;
        b=G/SMOWFm7C0PlMXZdxkgFZD+AsTFtUjBh6xfVFkGJWtS3gcJJAGefDTAw6+YdzOVxz
         ykyPFnG8F7V418YTJ0XwEbJ6uy+0SGAgyNr+6TzT4ZwVij62NP7cPStiL/gXwnV1c7Hk
         3ORrsOwdD756dR0d3xG5GPpFwOIgk8glcOJIb8nuFA+KoxrFHL+qORzQ8pECyf0KtDs6
         G1yJS2orINxkLoLfC0ZcQJ/zgd9pZE/pz2A9Zq4iAGpSUWz2rrNLP7DrpxhklRiNnEQL
         RuuSdz2tvKb7pvQdMPoQof5vdIqzPTnCmN67X8cAB71mMJkJ1EGDXENSQwCNRu7H/vfd
         aM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757587053; x=1758191853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBJAhqvEHPrcQ7AuGOAnRt88ljqyRo1HkemhDWzHqMk=;
        b=FXqRyQj+ru4J7lvaoJhLVSQVzVN07/CCXvVAa1Ex9yumUAHr758sPuihFrAEvQQk4Q
         m/WGPjroBtPBeZhKoP6wt6/t40EwL0vbWFim7jZxp8z+LHSfQLS4GEj9D351deK/mwmj
         TpdJyAvUKSR3bOGJWZx2D6xKPEfKyopcETOiyjzxvOa1hGbv6Kd94ntqe5zOrOALBQiR
         YZ/GXD5aFRMMZV2n7Nar3g1eQEqqAH5cZ73anEwpk7nZjz90s8ihyYbDSyOdBKlYfzXl
         5sG3SjhjrmaPKBq/Z2QUD8D9uEHxWI4XJ6dC5cXfl1XCyj4PU2kdABmbG+buUk2x9Jw3
         cSvA==
X-Forwarded-Encrypted: i=1; AJvYcCUbcRijXJKBBMITxum29h/OfPMqJ+wpPI7qaz3v6bqQK0wmozCsylqcF1eL1PdlQ6wwyeILB8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAsMKbN5XOsjD0ivxw6WjPMZNJZx8MYLl0q7MkPy+GaWeJr/UJ
	eV7mS6ZvsFqv69rE886ooVXT0cMuZw7NpNRPXMQOlohtVCB8aN/2Ekid7kPVAnfG4ajAldE/9Kd
	j0hmq/zTare62fSi55WU0TcjsoNPZ0avgJLMkeIg3
X-Gm-Gg: ASbGncsi13DVJwTGKn+LYdOJj78aB31z/iH9cr0LsX2XLKAJe8uZEt1RpHoba3n3Ycd
	B6E9ib0jE/x5HU/7wtpvOCIm2E3Dj1lsoG9QN1LiQJQb2gk8kO5oYn7HL81iUDDPTekOTXr7z7z
	afQjunY0mCrTctzZ8RyuHGYskYrlVIGelaSGBEflXGbQhgw4Vnr63vEjb3UNqB0OdF3svDnO+U0
	GixV6HgYBGOoA==
X-Google-Smtp-Source: AGHT+IGIfwTrAX+eEwWNUP+gqA0VWd7OCs6gHhATUwsNn4thDtgWH+7/hdJD/+ZIYnscPVsLZtgwRe3URHJuJj1RLH4=
X-Received: by 2002:ac8:588d:0:b0:4b4:9590:e08a with SMTP id
 d75a77b69052e-4b5f848fd2fmr189486841cf.67.1757587052957; Thu, 11 Sep 2025
 03:37:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com> <20250908173408.79715-14-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250908173408.79715-14-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Sep 2025 03:37:20 -0700
X-Gm-Features: Ac12FXwkEN44-LdnfGfkXsCmivrlKxkPkl7EsRk6tBWM_mjIrqCCXjB3OREkXDo
Message-ID: <CANn89iKaM5HbOT2wU_qSaSxzyLRfRKz6Y3+AXq9ZmQhWjftMWQ@mail.gmail.com>
Subject: Re: [PATCH v17 net-next 13/14] tcp: accecn: AccECN option ceb/cep and
 ACE field multi-wrap heuristics
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

On Mon, Sep 8, 2025 at 10:34=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> The AccECN option ceb/cep heuristic algorithm is from AccECN spec
> Appendix A.2.2 to mitigate against false ACE field overflows. Armed
> with ceb delta from option, delivered bytes, and delivered packets it
> is possible to estimate how many times ACE field wrapped.
>
> This calculation is necessary only if more than one wrap is possible.
> Without SACK, delivered bytes and packets are not always trustworthy in
> which case TCP falls back to the simpler no-or-all wraps ceb algorithm.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>


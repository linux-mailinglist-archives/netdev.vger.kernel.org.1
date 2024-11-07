Return-Path: <netdev+bounces-142734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFC29C0262
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 11:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11030281A7C
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 10:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDA71EE00A;
	Thu,  7 Nov 2024 10:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jAfw0oTc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906E480603
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975440; cv=none; b=DQtBTAGUK81N/V+Kr47IKtLR83r+bmaBaSrrVUoni1W1on+/k+1cKXTtKJOwxKp+U4Yfz9k2IeD7CvtPv4AJfxRaBC+1nGqF2EOFDPV0jODEM67HwTg38UpzSQE4LNgpCy7pXol064P2AF69/I1ismBMoqvfMGrKNh1Sau4kbyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975440; c=relaxed/simple;
	bh=61IjfaEQn3qQ+6EN/a5E8MM0e/Hk9Oy+zJvkGf4+Mg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lf44hSIVJjXV0gHL5W0vDSRlwQRwZf8OmC89SlLpzyQN25HdbJWVleIhLyKPYM9AnMo+2kkqvsJJcUp0AdL0Wwdr80M7KIxG7pdvwEC11PZyG+2M4Vew9bmQArzBSj1suh4h0mT0z3PASYxgliMZbvlN7zjD3hjYEvhDeDIdO80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jAfw0oTc; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c95a962c2bso1060658a12.2
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 02:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730975437; x=1731580237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61IjfaEQn3qQ+6EN/a5E8MM0e/Hk9Oy+zJvkGf4+Mg4=;
        b=jAfw0oTcwQT2Z/rDEgo0gl0k1f56u++mOGPVW/DT/7pm19V2gb62bY8jCEscwbtufh
         s5sMurZwYkk6Om1v9MXjijNnRHwvIHoQK3i9WH6xYz++ck3/GqCMHd49k9zEdD3gnVU3
         ARfgDQf6MC9KtFd1ZpXSuoEBZBap8oC/saesBy6HRtM6NR7iLUWkumksXEpzrmgB0tZ2
         d8PS0HMO2kdzq2nxEFLPiYZCQmQh5xvtv/z6RENB4qQEf3erlItPn1KgN+3AEKA/Uavs
         3NGJqhAp+5Hulwd43F6fcmsntq0VeeQ5UjBk5r2px1f1uPkOP6YMN45vvpNCVlRtxJq7
         XVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730975437; x=1731580237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61IjfaEQn3qQ+6EN/a5E8MM0e/Hk9Oy+zJvkGf4+Mg4=;
        b=JsfYUfi3mehIFoYr3EakJFetti2EZ8Rs8BofESrw97kg6cvJVrD2HUlmlqZwJ5aKFg
         OdtflN9VO02kVs5imlXrc8kTBQaE92sn06b6KzaDgD9cdSRnHdmea5ELaL9uWgfFzw5w
         eV4I9rbRWM88EyptVCGdqJqWhkhgxRTz4Qm5ksTrbePSmr3pkSkJgSZSqJD41jbkqZQh
         gL0NoZzKgPE3f28UGugCXdm2zCuJOrj5sPURTQ2RQkVQk0qg7zftwRsIyTBeTrpL5pmp
         m9J7SquYVO5eFM9JwnkHBS8SyZsoS8dbZhKghA/Ypf6h7vXoo2mTE4ui/tpVJcgqWuEL
         O5Iw==
X-Gm-Message-State: AOJu0Yx8fpxXZxBLn1tNxGHEGOdK/p9Dhd0XDkduf8Rs8/qbOBF7KV9v
	Sw+xK24Y5a25Bxe3eOUD3RIAbovqLu97aE9X9CJjSmfn+kQxptWebgOAUoTEDKU2DBTQsqgIG6v
	PQ+lYbDqKRPnKfe+JQ7L0Fp7gwPXlw+byLDip
X-Google-Smtp-Source: AGHT+IG6bVOhtvsLxK2YX/L0Vhv8DZK684ype8EIDiKokeSnIt6mIlhseeujo/6tMoM5CJtKr4np6cDpX0yZIhQp+YM=
X-Received: by 2002:a05:6402:2347:b0:5cf:505:c12f with SMTP id
 4fb4d7f45d1cf-5cf05a048e3mr565369a12.21.1730975436892; Thu, 07 Nov 2024
 02:30:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105100647.117346-1-chia-yu.chang@nokia-bell-labs.com> <20241105100647.117346-7-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20241105100647.117346-7-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Nov 2024 11:30:25 +0100
Message-ID: <CANn89iKov5iu+rnGsbYrxKZZWcMQ+zKg6CPCY96TT1J_vVZ6Bw@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 06/13] tcp: rework {__,}tcp_ecn_check_ce() -> tcp_data_ecn_check()
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, dsahern@gmail.com, davem@davemloft.net, 
	dsahern@kernel.org, pabeni@redhat.com, joel.granados@kernel.org, 
	kuba@kernel.org, andrew+netdev@lunn.ch, horms@kernel.org, pablo@netfilter.org, 
	kadlec@netfilter.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 11:07=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> Rename tcp_ecn_check_ce to tcp_data_ecn_check as it is
> called only for data segments, not for ACKs (with AccECN,
> also ACKs may get ECN bits).
>
> The extra "layer" in tcp_ecn_check_ce() function just
> checks for ECN being enabled, that can be moved into
> tcp_ecn_field_check rather than having the __ variant.
>
> No functional changes.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>


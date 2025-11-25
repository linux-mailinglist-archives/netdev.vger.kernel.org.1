Return-Path: <netdev+bounces-241709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897FEC878A1
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 00:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9ED3AE53D
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 23:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8496E2F0C66;
	Tue, 25 Nov 2025 23:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wHn0gM9O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C89256C84
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 23:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764115192; cv=none; b=n2r5gAZ1EAN7F+I/dTxIxsxezmbVLmuvE2svy1S9MU3mALq3TAymJ2a+HR/A7VMGIqnCbzLukayXUa+l5fXPzcBgdb/Lxifg948PP8Soc3dyABSG/9OMk75/WnUielm5EbRiUAuNchuCPvzmfsXyLzv0/J9wq7iqenEelr0c9b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764115192; c=relaxed/simple;
	bh=X+UV3u+Q49e8jqKO8GCdnEJLoPsSDkePyMd6qLGXqYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A0V9EUnw6hcgHXFpb0A/16qEeZovGYVuz+nJok6/WCqL1PZBcFFR5lE6nhIrMui6yU0fVmKgGKlHVz78u3rhWvU1mCtWjTyk8mIFPtZV3knLnfVrK93ZP2j7yY5BjYOSFY6fh9A+6JikygotY+eTds8TAIINvJHK72226WOKlac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wHn0gM9O; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2984dfae0acso95667505ad.0
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 15:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764115190; x=1764719990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+UV3u+Q49e8jqKO8GCdnEJLoPsSDkePyMd6qLGXqYk=;
        b=wHn0gM9OmGqeK82I2tNRns7O1PyVpiU3XdKFD0O/277EeS/siPGTKdFeJ7n/XcwLCG
         KQaV7Bq6tNHshIXllkPasTFbrJCMuBRUGJYXN9LMoL8zkSHeNjyuLs3qoCNtESYNcTtg
         A0L+Sdg73QxGnbqcZX9tKOiFB1W9mun854PgAqSuGxAe0WtdYug5zvYfyBjAZQOQp6eI
         k28Q8F4b5j/Fsa8oL2hksZ8NdkyX3SkBHone6aWi2Xp0AYt+pxlEJGaf0O7RaKJkfsKI
         XXCbZpfmpWx4ZhTmylFA/itL2s5LaaD/o5m3VFfmplCWCgSNyH6h4CAtOEb6TXxIJGfL
         YQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764115190; x=1764719990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X+UV3u+Q49e8jqKO8GCdnEJLoPsSDkePyMd6qLGXqYk=;
        b=GcoFMaGpoyp16Sf9Wd8zoBPhbM1Bppc2uvT79JR9BwJ3FUZ8zUBUkvV2UQm6MQnYlo
         CUkgYGaKJD7F/vy/NPLiv8+OmRgKnI0bCb9Ocyh7Z+XdfTOo2fFUSY4PxINaXFhBa6BZ
         oyXC8nyHCWRdsEAxOYv6UXfwHf2OwK8GkATKChiiUN8GrBJP9F8hzaunPejS9ET7KRr7
         Z00EtxBQhgNItX8lPeh+cT1TGOnzeh6p6s+toBaE9slYSffWejA9p3mWqsPtChKcyNFN
         wxrft+svyXUAfDTqWjJULoJUffgeZAGJ5Yd/dpYP7rlamBcN8vgQWJv1pprkVYEPj5pd
         dhBg==
X-Forwarded-Encrypted: i=1; AJvYcCUNOqpL29A0tZ6k0HtojPB9w7xQHA62GHAhW0FhcnFs9k7nrvKmmMDNf3HuHfF77Q++KmgvyJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD+kuyegIHt1rYi8Uo4O3/H/EN6i7p3VBUi0829tpPSRFp2Pf7
	vNiae/1oc0fFJ5+vqcXFK5i+o5dFjg3S3gd0XysXpWlZRX5L9lVeXfCJZmJMiNjayYvsSi6gRsX
	2+YPvTd+2lBL4DTI5qQh790EA7syAapDbvl9KFJjh
X-Gm-Gg: ASbGncvh5N71K0MhLjwHQCFQ3WcoHhfxYFAKrKTVsx0aioQvE6b9zL25Q9Rpkyv8iCO
	xHr6XZAmfouD4BVWoJYJgtMZgVf9TFoMYhn+9tkKGbXrPz5GwtfHReGwqOhkgS0tZ8yraCshLWo
	mj3p33imsaIsjGlYJn4YGEk072gDic+r3Ki7DwD5e5ZMY5eAfs16EWfqj0h8S+J9SXjhMY6UT01
	qGt94VRHBYp7dUsVFgaB5i9pspxhg1qnlgD7K4+c7AKUsOLKK6IK4oHDuBXHPNcfc2Ci1h/Boky
	FFfaUwmUCxPfu54APlUqpUAbAQ==
X-Google-Smtp-Source: AGHT+IH+iD7QiGL52IruI6Y4H7C8A8j1AMErb0TxoPMCxGDtYpJ0IkSgDj9R5xsFS7FQSOqg6b7V1u3A17ck3mV7/28=
X-Received: by 2002:a05:7022:218:b0:11b:b61a:a497 with SMTP id
 a92af1059eb24-11cbba4ab48mr3618305c88.37.1764115190064; Tue, 25 Nov 2025
 15:59:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124175013.1473655-1-edumazet@google.com> <20251124175013.1473655-2-edumazet@google.com>
In-Reply-To: <20251124175013.1473655-2-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 25 Nov 2025 15:59:38 -0800
X-Gm-Features: AWmQ_blnv3dUfDVisTEl-Juk2KeL5MCrS-FrXkQv7uLbXv7zZUD6GXQOt2AS0BY
Message-ID: <CAAVpQUBK3rGabHzxwqRD2ht5BQkTiNXwGYsGj_+EVeKH=d9TUA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] tcp: rename icsk_timeout() to tcp_timeout_expires()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 9:50=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> In preparation of sk->tcp_timeout_timer introduction,
> rename icsk_timeout() helper and change its argument to plain
> 'const struct sock *sk'.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>


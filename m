Return-Path: <netdev+bounces-206378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABF0B02CF6
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 22:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77B723B8CFF
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 20:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9955226888;
	Sat, 12 Jul 2025 20:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M57ucyKm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B72B3594B
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 20:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752353546; cv=none; b=gj5uezfjmWU/asQBY5PIHfIwKp80pJpcbYjhKNn1UdYv8CRV15PstbDz3ybIzANARRzsyc+ctsqU73a3YjQXgLwo9TmwepmMK9KJOj88YacP5OSoBZkiCAVZc9DhJL9vyzDPLpb8Cl7gAaIuDfXsi9OvQdHYarorUESZtGqQ7E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752353546; c=relaxed/simple;
	bh=ZKV5gGN0hcAp1oQYmy9L/JIJ2uM4iwZonUGSEtcqokI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMoVON00a76mgeMLPqPEPMHskeGwWQf8zTa9NwZGYDGxNLAReJgZ58Ll5y9G3JbgoXfX13MYZbb01vUCBFv1t6ZbPnMROWRqKHjgB6Ix5cmRQ/1cqVohqcy1kw3PYKO8VHR/4TJwWY0YgJ+mPk9LnbXfSRVNmAyk1YugZbLtiTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M57ucyKm; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3141b84bf65so3073345a91.1
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 13:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752353544; x=1752958344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKV5gGN0hcAp1oQYmy9L/JIJ2uM4iwZonUGSEtcqokI=;
        b=M57ucyKmuml5CgeqbXpDzsupK7Az7zSM1auDCXX1CO1km0AN3h6uv2sloTy9IxZRna
         jfq+SKHfkARts46QZkUkG+JO1UASYDieQx5chl12lixGPfBIBtvZ3VOfRi1hisKTTE6p
         6g1n66kS8OgTXh9zigSEh3SnvgcfRPufAOUa+HSV424dKj1zyvxGWFxMy1IbPBEWB5OX
         /U1m+swV3qjtiAwbwOCsfN4Qyxy4du5Fkzw/aYJOdiUa3tCwZA76CjlKhxWzqaC5rGT0
         8CnnkejLQP+J4PtvaFf42XOQa+nVypturaXaoWXwjw3+N5scRkBayJWvRQ8nLoyT8YpU
         FO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752353544; x=1752958344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKV5gGN0hcAp1oQYmy9L/JIJ2uM4iwZonUGSEtcqokI=;
        b=nawV0/JVW/UyolbYtWUsupL1ipxOIou4J4z3q9r2olsEhyxNNFDgevMlaPdPzCG5ub
         vrGo2QQxD3BVs97KZ6XUt6XIJke+2GXINXQ+w6Zg5R2+mxCAPQOcdoAp8q0weuxzWEK5
         hM1+dZEgJEohYE+C6Q3zA0MU7h8qratnYNW3ggU8x8LrL5RuwavmlRG4u0sTrV6Nv3qL
         qvo0BQqrxlNZeC4Ticvlak6pDTJW5FDrEF8Hwpzk+CG8QDZr/WLqk7+Uv8qiWed78XxC
         iBH3oyO/AoMaoSqbDIwuBcfAsd5LF4gNSHTbBhVgtE0O0scMTeSSFmV2jbCetWis8KOx
         exyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmjRm0qJc+nrWcsQW+Mphg9MmkPdvn3EfbhcOy+nPvtXjrwRCHQQjmSDviQQUPDNlEYHDTyzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBsdHm05Z4a+VNdsH3szywYwyZDI+Ks/jMyxKKy29Iwn0pffeg
	yXuqlKHu2WfZmTd+g1UO6r1zVGe1rC4GIWjeDX5APx15DpkptjrXYQCn18pQy/E9+EV+iWtDC8j
	Ow/rpzl3r8rk3qsmaG2FXnyfJ2Gml1waF10XhMQ8C
X-Gm-Gg: ASbGncvhHlgrg4nv4K4rx0cREgz1z/jC0bX89savicXIp0W+JIHAn/vqM95e6UzGxBZ
	6WPkJ8PNp92jx3Wy7VwnSWhaXgbeI+Ty+R/tyV6oiNLCbuwiHY1iMtQHnW7fCs8SV3q87M96lnX
	fzuu674L4ceb9+xj6Dmc1PV0mzEPTqHHZ2SHRj3s55psC7O2eBmmE4pAZxjMtJeaLDcNyykyhvO
	Jz6QyN+yT4EUBcyklslFJy2wuP98CoMxfarf4ih
X-Google-Smtp-Source: AGHT+IGOPsXI6+BT9daaFM0svYyhaX9vs/HrXOwOpmETE+QVd8ncm4YlcHUuwbSzhHKteDBue/4qFACRZIDcUvnIDFo=
X-Received: by 2002:a17:90b:38c4:b0:311:df4b:4b81 with SMTP id
 98e67ed59e1d1-31c4ccfb9a8mr11316805a91.25.1752353544491; Sat, 12 Jul 2025
 13:52:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711114006.480026-1-edumazet@google.com> <20250711114006.480026-2-edumazet@google.com>
In-Reply-To: <20250711114006.480026-2-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 12 Jul 2025 13:52:12 -0700
X-Gm-Features: Ac12FXw06X93zWtDKXKP410X5UHo4VdxLoabMYXR2q2auYiz0pdNUaEToHJ3jBo
Message-ID: <CAAVpQUBngA+K1SJVFDTG1ve24Hkswij-8V+kqYjS_eVqPJ46FQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/8] tcp: do not accept packets beyond window
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 4:40=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Currently, TCP accepts incoming packets which might go beyond the
> offered RWIN.
>
> Add to tcp_sequence() the validation of packet end sequence.
>
> Add the corresponding check in the fast path.
>
> We relax this new constraint if the receive queue is empty,
> to not freeze flows from buggy peers.
>
> Add a new drop reason : SKB_DROP_REASON_TCP_INVALID_END_SEQUENCE.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>


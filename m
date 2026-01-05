Return-Path: <netdev+bounces-247179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 616FBCF5440
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 19:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63FE7302BB9C
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 18:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A7B338594;
	Mon,  5 Jan 2026 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZXHaE3b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06063009D4
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767638930; cv=none; b=nGu78StnbitO6AIoM3IrWDbc+rPMs3tzhQdPrUnt/DuWfKU382GQ6PADRyifqsqS3ZfOwBgbUUtnqv9b6npwcPV1KaaQp+Lwh6p7VLp/jJtqEQgT55gTXlgcm9nB7W5Af3a37XvRTPy06BjvNjWLeGri7JFRDiivLVqYo0uVqFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767638930; c=relaxed/simple;
	bh=fErRiiJwHiwz5/ivXZzt7DohWO5HJQPRcltM0RL8gWQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tFNbd0vFg4FvxMiA47/an68evP18uk964OaXqtuc+YBqiAhsAcicUXNiDHdVqkFY9CQfCvzks/VSAWhVevrW4ZUfoyTxt8vuQg4gGaFsuFoIvxUz1rpRzmaeu1ou2ilpnuZzSwwamO+DVh7atpq/Ph29s7qcDmoVMbUbyLCd6EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZXHaE3b; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c0c24d0f4ceso111926a12.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 10:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767638928; x=1768243728; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fErRiiJwHiwz5/ivXZzt7DohWO5HJQPRcltM0RL8gWQ=;
        b=mZXHaE3bjY1/TLHF5TyYuHdY4BwYSzdALTXna81bzobEbk+9KYSXjbYXXDhrZKrcBu
         mlx3AHxaB2fq3Ei0pDazi224kQL2aA9tHqX4/uerpqJj455+XLed2fjgR8U4fxaHnsKt
         3zRoFHAD80q+nNFor/EqO9phzG499/DoEuWG38GKWnX7RSKCkPaEm57loNjTfub7yaW1
         swxb3aF2iUWqJwADBq4qmEP2IunJS487vkx1KvAkGOccxGmagWzmq5omj0l7XwS8sfRg
         Urv7z04pRI70OmaqYoinlmbzUFLAVZvZy9rRHqsSRSK9WWVXBJxiFjLa25RfEI0Ea9Wn
         Yzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767638928; x=1768243728;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fErRiiJwHiwz5/ivXZzt7DohWO5HJQPRcltM0RL8gWQ=;
        b=F9IGgltOkZnBXaf0llSoorJjtUZCZwBmIzqLi5070bWUYW3uJA1aD/9XuLp0j5g0B+
         8i59T+4AIc7MtlUZHY+n1hNxDq7FUzhaGwlkrUIXyjY7nzWaupkzS2RNfErwj9/UPt9/
         VOD9/PPcMCHuDegDZ+HpTAZSxLZmZ7ZWH9WauIpKKSyFI2K5KfQI87dVGL0tGwPGqjaD
         NHqpyJgZAsDfI6huEE9y3OR9ZU0c7OAj6/tOMGEkCFPT4qjRP0FwYnqqWKnZSoE9vthe
         QH9ZpzNt0H90bmUceNH5dJe/gSMVqROx78+7y6cy75uzIBQadDKAnJqQ3rIKTgdF5aDI
         cGSw==
X-Gm-Message-State: AOJu0Yy8UsP8sAdM9XLI2ky1PYBqjjft3kwTZWKRYY95GA5yLIp+V7rm
	MjT+an5K0BxdUZWnDRag4yw+pntpTpxHV0QAUzQBHBGaQFcgv9I/+s65
X-Gm-Gg: AY/fxX6E+LIQ/dWPw7L5suV/Rj1A+vm48QAvgYs+587Z0nXhzmyqRTNEAyaV1zcUuij
	vUqMX9+tHRmZvtEQ8628g0xpM0mr8oKcPzRT5uQzu7rV2IrfKz+b7ns5nezw8d9LvkeEvH79dWK
	uVxLW/CogYVSt+isDMQ8FN4ChhUiA2FdyCc386aQ1yBqr8Dd8RBBbZuVCOt3QMTWQRLhpIt7gvm
	ZcCMs8rIu7L+CiOCl0H8ShytMCjm1EI1QjiHPpQ+hhDEmQ83y57zX0naMRYyVaGMVosNSfC5MAv
	XCdWZupIxkIBv/01lRouJaUlnbUYxubuJ+97+uS5+Yl/HPcmdQRts/KXQKqOSQtwaMvInazoNsD
	L0quun4bqd4Ce5KzyPqTR3BX+YZ/CVeJDKKsHTeTeHxpJ/AnDrZOQ8dTvIq4rCwzLOIolnCseeW
	cyw1tU9kPPIu5qSYXFiLw/gEd5wNdxQwVQTzLb
X-Google-Smtp-Source: AGHT+IHo4MCvN8bh9kZUcHAWtaL5GHodrDBMQruJzO/juSsyL4pCoBv0ojoMYJFRnRAh6v2+mBtL1g==
X-Received: by 2002:a05:7301:70d:b0:2af:7f2:50b3 with SMTP id 5a478bee46e88-2b16f8389f0mr181239eec.5.1767638927938;
        Mon, 05 Jan 2026 10:48:47 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:175e:3ec9:5deb:d470? ([2620:10d:c090:500::2:d7b1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b16f18e22csm709561eec.14.2026.01.05.10.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 10:48:47 -0800 (PST)
Message-ID: <6b7a415fc9ede7adf7321a18d239c5054476ce17.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 12/16] bpf, verifier: Turn seen_direct_write
 flag into a bitmap
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,  Alexei Starovoitov	 <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev	
 <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, Andrii Nakryiko	
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu	
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh	
 <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, 	kernel-team@cloudflare.com
Date: Mon, 05 Jan 2026 10:48:44 -0800
In-Reply-To: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-12-a21e679b5afa@cloudflare.com>
References: 
	<20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
	 <20260105-skb-meta-safeproof-netdevs-rx-only-v2-12-a21e679b5afa@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-01-05 at 13:14 +0100, Jakub Sitnicki wrote:
> Convert seen_direct_write from a boolean to a bitmap (seen_packet_access)
> in preparation for tracking additional packet access patterns.
>=20
> No functional change.
>=20
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


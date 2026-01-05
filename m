Return-Path: <netdev+bounces-247178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9D1CF543D
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 19:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDABB302DB30
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 18:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C2433ADB5;
	Mon,  5 Jan 2026 18:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dW20XOiC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB18B2F6911
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 18:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767638896; cv=none; b=iZhIkq7p0VKDkIG66BVJSnJiHXLJ3qBK4uLk7m7AsxwBrUbbG6GFNxkDGAdkVtPnNIKnwBd1STWBJbELhFimjMVhvwrg8EUsrTvy4Sx4s2wpoEeXN9eq6Tu/HCtqPC+IhIAzfM+bTIyTXKoKT1PnAhcL25lTSPi7nbbTPGa585Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767638896; c=relaxed/simple;
	bh=823ZyIiv6dLZZNtG94sIeR24IfpH1FUXwvJ8imTbqWU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NrtZfbrD7/hJyZEghvtb5BChdO7WqSqJsH7tnXCggEN2A2wzYuUHoKSNP3Kk+4Q66RYcnhDw74+Tfg6vUPI9MJVpsUoP71NpamhQ7EVUTmVf1OhHP6NoTTRF1VzQeO53UOlskmAC1HNVNKsD79CuJDBraygatI1NKMSVbt9u29E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dW20XOiC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a0834769f0so2292995ad.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 10:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767638893; x=1768243693; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=823ZyIiv6dLZZNtG94sIeR24IfpH1FUXwvJ8imTbqWU=;
        b=dW20XOiCTi9rOwCAi2T6NMJGlq3HQnpRfa1WopFFlecH1GaDQMVskHdQm3ARbfydIT
         tfrgpspvvI/Ux6lGIMwLS81Hi3e8wLJ//4+eaHt1v8nUiLgZlQ2FUvOJuZtvG8WUCLJg
         2Dwt5IQfjjj0AUk0j9MaoFPPG0s3dGRfW4Dyej1p93qgYTtXmP7YEn0tRAxstp9BmRxc
         ePtAoIPV8UXs/cb0D0AG4hdgeTRGUiVyH7APrGXcivQ1aM1cKQrRH55mLIjyZcMLOa6n
         dYqjGlaVTEy961p2ihTw3qvAkyBtgACncUp8ZaFNBjeIOArtMcX3u3wIn6+4IQOxVW90
         8zgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767638893; x=1768243693;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=823ZyIiv6dLZZNtG94sIeR24IfpH1FUXwvJ8imTbqWU=;
        b=nY7tVO7YEhjSsCombOm8V5yKxCfE/Pi95u8ABxFAUrYOx3qGadu9fRxQjbUlVrO5/U
         ZrqsOQcj6loQn+9HRGprsPYgrI8esjdzDRLR8D0jf6SmqN5SWwuHuf0wQNzyj+hX3NP0
         yefs7B3Cxhl9JR1vyUnSNtxMmjboc3Au6Bt59oW5UO4B407mXH6NNPvv/Mcijho5YgAy
         ccXm8DvkaVcewiR0f4pVjY2Sj5boGVsCBvGX0bHcuyWKsxbrfSvmyF+MBfICAGhICNpN
         lrwcAf/wcC4mWnfq5JyAj7347rptKTi5UUyhbaseOyatjzA19/gxUlMwgGRumqq91OBr
         0Ljg==
X-Gm-Message-State: AOJu0YwuSxOUyjrNr77d4Vi82geY52N7gib/nBhGQF9dB/lWEMj3Ei8v
	Mz6inDuOSlm49ZWLPlP+s+t/vuh+GTYhg9Nhr68RZX38Use7cPRITidy
X-Gm-Gg: AY/fxX7XCbX6+Udt2DvDrKv7sLXaDufWQUV4DfFFbtL2jYVL6L1hX2oNdjyDbhfVjne
	sr97bMUH4RAAMSMfjKo9fHBpZGNagceAbxjnN9bPusv6QEjL5Dx1acWLryT7N8unQCJ/B0s2boH
	keaw9w9umOVuaCfbzoG57IA9rqDHJC6h0FDujhLNA+xyo8vUADqHBlt3ePFZWGs6JAeCt/JNKPN
	K7OvLwT9GQsnreBerPQsQumRO0H7vcd3byqAGHzEF6cHpu+dyfIMoq+U9ttTAFvFZCmW+L1azEJ
	ea8RPapE5pIyQykcu2PkSd0kg2MlCf4DwUsEIA9vzVNcUv2d9Os/++HBvk4EGmgeNycZX56odFz
	t03AtAR2TmQ2tp3J3khB7jD/Ny0Jw+2HbKIqZMe9/Jvf2B65qEUqFveOIkrOdhApD1qaZv9wYYa
	+EJylIQaIBjWszpXmlcFFTwpH4yxtWCay35vuU
X-Google-Smtp-Source: AGHT+IGADnk0qu5rOZ12dW8/R5G6hKBZVjkflPwlw1XupSRGqqWwvD2EvQkybFKsbIobCX9s/oFOkA==
X-Received: by 2002:a05:7022:264b:b0:11b:9386:8259 with SMTP id a92af1059eb24-121f18f2f6dmr164053c88.46.1767638892921;
        Mon, 05 Jan 2026 10:48:12 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:175e:3ec9:5deb:d470? ([2620:10d:c090:500::2:d7b1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f1220a05sm1139671c88.4.2026.01.05.10.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 10:48:12 -0800 (PST)
Message-ID: <53f4ed220bbdfd1828dc5a54b9392e532ad9d9b6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 14/16] bpf, verifier: Track when data_meta
 pointer is loaded
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
Date: Mon, 05 Jan 2026 10:48:09 -0800
In-Reply-To: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-14-a21e679b5afa@cloudflare.com>
References: 
	<20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
	 <20260105-skb-meta-safeproof-netdevs-rx-only-v2-14-a21e679b5afa@cloudflare.com>
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
> Introduce PA_F_DATA_META_LOAD flag to track when a BPF program loads the
> skb->data_meta pointer.
>=20
> This information will be used by gen_prologue() to handle cases where the=
re
> is a gap between metadata end and skb->data, requiring metadata to be
> realigned.
>=20
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


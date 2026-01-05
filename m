Return-Path: <netdev+bounces-247180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31708CF544F
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 19:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71AD930D45D3
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 18:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A35C339B24;
	Mon,  5 Jan 2026 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+P1gYVK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1E132F774
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767638962; cv=none; b=SHqgryIoPnI+pEwfksnNxulLLjP6sCaw0FI8AyhAqS/vHbnc2+tR6fMkQc+G2Xj6kUk0qoDPcsJdMBUCvtysslhzyLfvnfAp6Ob3ORS5TbG5MRkiXlqsfbiAbsSgpLnBpui2wnvL4VwKS8gWVJQW2To5gDPHfJDl1iKFvWv3GmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767638962; c=relaxed/simple;
	bh=e003jG5vdieFFJDuCcrJsIwtjPz7vudFpkvsD/FMFE8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=THm8ZOaB3qTJgnfk0d5aDXT2gLHvH0y+8vGGK546eo21yLKQhLTc7j6du6YMt8QrFSIKKSYilbvhjT4aK57PJoz66Ft1wjfkZGAMV0146xkhQu31i8CwnN7kqXhScLKktqjC2mtDUm6k0C3mS0nmVQHtQp2TPWWWzA6hJbbUKbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+P1gYVK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a0d67f1877so2791315ad.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 10:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767638960; x=1768243760; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e003jG5vdieFFJDuCcrJsIwtjPz7vudFpkvsD/FMFE8=;
        b=Q+P1gYVKay8WSOrdhPI/auxGuVzyBRhvBLQ+fwlZXXKQ11URfCW6ZxCm29AnsCeHbq
         zvF2BK7zxRrNlk84sa8grHEXZQAC5PoaylPgNfaVDD+4sZlsqaPAViCwDb6vpYyQKhKI
         8DaLE3a3fB0PBSVgOEj7RCntEoA5w/jG67SYgUM8nZauoPAzxB8ahBTZelGHBE6UJ/Qj
         5G736UDAuKjZa5kq2TzOYqbag5vjefKf4M1BzZUjMZ5ZfMl3CpIi18X/JYfPIdLyqSco
         9r7jO+XDoKOqcGMDzn0vfButUDA44HAOrALIjDfb0n1FbuWMrhNgho6npzOSe3axN5Ic
         ZVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767638960; x=1768243760;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e003jG5vdieFFJDuCcrJsIwtjPz7vudFpkvsD/FMFE8=;
        b=wTkgG+GrniwjRpoUXsCW1HFddbvR0zDtaqrS2gQlpV9HLpoqTM15IuzOrtdj9xNtHE
         UtS/miDVjob7dXYuupZ8kC5vcVZo6O57QAc5Drhh96nOt+1Zho7CAXWV9fmSS8PAiPf/
         IHliweBdcaA9r1BIvN/9GWTva0JJizqQSCo4/+1nFj1cc3ObwNrN73rxUfh2pWLUDm0f
         1/oF1Id3fAeaRJB75pDkt9td5/owWgod/+z6QgUf9VGMnJr/Q5UIcCzSta/7xFYEwbBL
         6JfQomCKQaGnu0HBMNhzcmXVcTflF4wH9aiPHJpUnKQzIbIHuuzT2ZHlK6R/9scXlyia
         9J8g==
X-Gm-Message-State: AOJu0YzqeQbnxOQMwyZrjqNTuB8HawR+rCN/VTeD+HuyEIx5+tsTNCeG
	eqzfz15rP5lctEVfAY+VAjbx+QgdnsIBpCFiK4Y9+TUOhyxSDnGktebl
X-Gm-Gg: AY/fxX5sEfNxqdg5fW7JOK1j9zpzfg+erltqL73exXUFexzFUxI0N9qNecxqNRBQtFq
	LcCbFpuN9HSlRMvw2B+voVpArfEHQDzxdHQk+YUy3rWfledvlgnisBv/ESJeXdb7B0q/56Ss59F
	oLRKWvD7Xq7bhZ5Ddyb4LLbiUmh3a0Bl4gNq3rUjhefFmuM0tOroU6wX/oCL0+fNMw3Zei3JWQe
	DnZjujo7CwBDnHwmQhXLAW9KyU9vRMIoPcF7R+0xbxRufo9JctSoUhfvckqBoIDq6Wizm9mU0CU
	Et5APx5nyJ3Jb/iNmmImJc928JViswWcv2mwGNsz46O4KvGCzanvbnXjDzG95vDCR7XeYC2NXr/
	3+L4/4YB7fKtCwQS62aXddL53DP2DwDf2QyylVFa5QBWF55Z0y+aE2Qu32UkYmyAu+GYwsBWfFP
	ep32KIa+p3fDGb31W/BS5bZoV/hhSQG4aITZq7
X-Google-Smtp-Source: AGHT+IGo39NsQJ7PSdxFpuDGG5ulm3AIDxQrQW7tgt1k+akXwhbnJ6bNsI1NqEVpcSsafRJxeHoNPg==
X-Received: by 2002:a05:7022:6288:b0:119:e569:f277 with SMTP id a92af1059eb24-121f18dd993mr338414c88.32.1767638960393;
        Mon, 05 Jan 2026 10:49:20 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:175e:3ec9:5deb:d470? ([2620:10d:c090:500::2:d7b1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f13b7a88sm1118677c88.17.2026.01.05.10.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 10:49:20 -0800 (PST)
Message-ID: <d3f5cba91613e34ef5008c616f16a2fbef9d0391.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 13/16] bpf, verifier: Propagate packet
 access flags to gen_prologue
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
Date: Mon, 05 Jan 2026 10:49:17 -0800
In-Reply-To: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-13-a21e679b5afa@cloudflare.com>
References: 
	<20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
	 <20260105-skb-meta-safeproof-netdevs-rx-only-v2-13-a21e679b5afa@cloudflare.com>
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
> Change gen_prologue() to accept the packet access flags bitmap. This allo=
ws
> gen_prologue() to inspect multiple access patterns when needed.
>=20
> No functional change.
>=20
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


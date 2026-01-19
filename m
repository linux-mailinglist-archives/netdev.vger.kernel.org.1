Return-Path: <netdev+bounces-251328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AADD3BB0D
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 23:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF49F303A1B4
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 22:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A632C11F9;
	Mon, 19 Jan 2026 22:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AK2choiz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF839296BD6
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 22:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768863335; cv=none; b=Muo8XQNJIzvZuWKtic2DeYrA+AVMxRtNG1nAWtLEzj8J4Oe6U67kEP6GEXrA5/nCg6b7BVM8cHjfzpudbBDE/qA98gPeL0eY9Demn4Dhx8XFISyK3FqhFTYdNWI/QjNAKcsWAVESPA/S6Wh5VXdJtVB2knRYqcyNo4cOmeyJ6eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768863335; c=relaxed/simple;
	bh=CknUH1Ef36XFVXyjVu+tBfwZhOLw/zHsFq9ziLwCTqI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SXAXNSlSobfgnDhshEp6oFghYqJefbSpfpriTL39hc+GvnmZKtqTGAYNB96VyFGMxmj657TZ0guBKveQLENhYVIpbRwa3JtYItk4d8dxhP5fi9zltZQyHomI+YPypRA50ilrXdqXDidCW6EFW36M2+wY/xeS4RkqJD+Uy3/jqCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AK2choiz; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1233bb90317so3741515c88.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768863333; x=1769468133; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TZazt0YRQVuWHg3NtOlqMLp781jG3zf7E4stDnzqRW0=;
        b=AK2choizzYSc8ldcPOoXgouxp0wyq3U5VU5SJM5DrIhxfMOLyyhqttFL1vkik9Nnxh
         bFjzTyFR+9XV1svb9KeKmeDFMLcv9GXXUb0lCBb2ZnomUvAQabiOJ2EKnQeGrUmlyvjA
         UH6XAG4jnJQdJEl0o3XbBehcta6dkcBx2rPhKcnI7sAOt2hWGFQn2LT22BGNSzc4dC9y
         yGsvPc7hgkmsoWQAsXauDKhrUrSwU9Nny1oi3d9uUg0LyR5pSQRFWTFHOXPpgO1qYbEU
         NgPC2iIpg+1G0DhQq7nZdIIhTJffqp+5+EXtUCJlW8psd0YjJC43/jhIfizan1gB2xva
         jIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768863333; x=1769468133;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZazt0YRQVuWHg3NtOlqMLp781jG3zf7E4stDnzqRW0=;
        b=NyaBMWnYCAFFwdDjeBeIaHEJnHvbLOMHYEH4grBY98GrM4Jf/Sg12dhYWLxnlB05wM
         O3trOWC7xj/Mbh+hrfmIi+HD3Q6YlN6eMloS4Toec+T+p6cUi+/V70cA+j2HUZ96rtJe
         A/Xw65ERcJS0E5hHJ8HnJRaBkNwpYDnPoB90iXh8fxTlQ9ubfgDZsxSTm53yLHTSiekK
         AUu5/3YYo7tl+/qXWXkNpSfhvUN8b/Qsc/+0I+0c1f38ZwB8fWRQnmDbFwMA3Y+gVySF
         pC0im5w1Ohx9yCaEUh1eRdES2pJpo5vXe7aZMccHVNGLTLdajMb4/IH+I507U2z0BTHv
         YoZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd7hQYWB65uY2kUWidX7e+7GYCds2P4mGvVBlih2LrxJiE8E24Xr5QogAZTbcnntnRC6i3sQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoLYRHSgS+LS1ymQQoyWfcKMSSg8IR2wZqXy6dqDazysCjzVgu
	SWjP4tJDjxGVteWVKhg8V1g18ChsMDUDdOKOJsd9pOAsyXrkwr/Wz3sI
X-Gm-Gg: AY/fxX7NosjKrZ2wyquz2IBN5BWWDCZiZrjTPqy774QKMX1muHM3mWxvjw+DsY8/cMO
	p/ovLKdhmfDiwqnS5R7aiFekzEDYE0Ox3LLfog90/qQlEiDhiqWNLJ674q64yqMAmTostCFJYJX
	1QmEb0FnaysGwFdkvFrPlC/KCwTjMb+nhl6v+wtXzeG8LzhLasFXuzXeUv99oZuJvAv1NYdR+0h
	STwoYWYqDSiPYmmDJQoCbrOdSg+w0pyldAeNY6T/+WDPX1R41pVauezOJ0sjSBAEKn5pcGizEcc
	H5LFYzDJ7u6KHOT7igpO9rhixGpciaN5Sg5CesfZCY2Q3e71KvI+D4UM6ZjOFiDyAmHQfQ6qWja
	0flrNGOlhP49l4waEUu2gU8dp1y3FLSCxYUnMF9dff+HOCN8DA7Z30lCI7tmMVIHdCPuPidefwB
	T1u2a/sPK6HHr01rK6LYWK0CTtbW1ZnnUkEcslet20PRzfCw42JGK4YxwrnBpMR+PfXQ==
X-Received: by 2002:a05:7022:2489:b0:11b:c86b:3870 with SMTP id a92af1059eb24-1244a923b9amr9542797c88.4.1768863332815;
        Mon, 19 Jan 2026 14:55:32 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac6c2besm18729400c88.5.2026.01.19.14.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 14:55:32 -0800 (PST)
Message-ID: <8eb725d8d0878a7a1b582fdfacf05d20a2542304.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: Remove kfunc support in prologue and
 epilogue
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Amery Hung
 <ameryhung@gmail.com>, netdev@vger.kernel.org, kernel-team@cloudflare.com
Date: Mon, 19 Jan 2026 14:55:29 -0800
In-Reply-To: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-3-e8b88d6430d8@cloudflare.com>
References: 
	<20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
	 <20260119-skb-meta-bpf-emit-call-from-prologue-v1-3-e8b88d6430d8@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-01-19 at 20:53 +0100, Jakub Sitnicki wrote:
> Remove add_kfunc_in_insns() and its call sites in convert_ctx_accesses().
> This function was used to register kfuncs found in prologue and epilogue
> instructions, but is no longer needed now that we use direct helper calls
> via BPF_EMIT_CALL instead.
>=20
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

I think that patches #3 and #4 have to be swapped, otherwise there is
a selftest failure when only patches #1-3 are applied:

  #281/17  pro_epilogue/syscall_pro_epilogue:FAIL

If we want to keep selftests passing for arbitrary bisects.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


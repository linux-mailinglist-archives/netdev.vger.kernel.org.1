Return-Path: <netdev+bounces-244022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57196CAD8BC
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 16:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3C62301A70B
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 15:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228A327E066;
	Mon,  8 Dec 2025 15:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WBrBTJa1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E982221DB9
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765207108; cv=none; b=RKMuAQPjDiy5eW4SxYRFvYJotG8CSPyGFhP+kdfAhfOQpo3oggsSpMdU/LkejPRwqGDHqZm/DeBAmOUIGGOUwbL6D9gkLdGRWE3UKLwwJ9c8U64CAZYogzyq0Ta2m1YRR/TdfrVmUjeUqDvB/EPlep/FQOeSuAF/z5zm4Ks54ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765207108; c=relaxed/simple;
	bh=oKAfzbDpF5HxMruBvGmNP/TyJQbPITsy31Os9j1AF/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Po4QNNoS6qoDMLkk7lbP3RLMFRX93Jbqs3L9QcooNKYsvGrxc+TETUihJSzgOGtPNQDlwGCV5rEnVHf4cG63pB2eXwC371URLpo9spOae0COhLpl6eVttbCUtE18PRGLhAzrfMX2Qjwl2gI3iaLTl4rRsAqlQkbEDHwqg1LtCVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WBrBTJa1; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4eddfb8c7f5so45776251cf.1
        for <netdev@vger.kernel.org>; Mon, 08 Dec 2025 07:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765207105; x=1765811905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKAfzbDpF5HxMruBvGmNP/TyJQbPITsy31Os9j1AF/E=;
        b=WBrBTJa1xCNKnrVksu5YNuV85ybgutM91c7JA8rm22/A8Jqf8vAj0yrupIYswSvKLT
         LwN0pgP5wLZt4vcazJ7gvLHSgYml6PvyPKAL8cPtlHHnPvprnPOltfhx/dHLJknk+Jwn
         kZ8Y22+X7BaRSMIDNwDMgHYTtGENsgkPqlFF/4n9L8RUWJR10ez4Y6sMomeMpbLjXkkn
         5UbWk0sH2rkB/9dO5rDLiN0aDHooUFlGNYBflrkDc6btD4Mnx60H2asSv/01O8LuaV3h
         7A4TicAb4dlzB78o55bbpNfjp2fYv5uDwEsnFu2d/O7w3FLM4VyOgNDmI/8cJqPuG/KE
         Buig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765207105; x=1765811905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oKAfzbDpF5HxMruBvGmNP/TyJQbPITsy31Os9j1AF/E=;
        b=ZWsD/TDe85WISfD3DJo7QyM+RqXgHq7CDkoOQ3gslpUSBz4pU63wH0eLel6eMVd0jp
         iXkArV6FHIia1xsOBL/Kw0vo0k0eQMI/mzPG3B/9aGmccZy6rG06XbtTxjL2YEvvY6m5
         jJnkw0ES1IYztUnLSKM82MFLpOHzmT1KNrcVKNMEsN7POIwHfBEhNv4PwcqnLVfKtaw8
         /Dg4b0O08B1QKVTzuwaD39c7o+e5Hxnd14pWYHXqzZL1H2OGSBsMWpHTBOhjLrvah4E3
         tk7eIA9jMKujx1OJTz/p6u2GQ5x207N5XkrJFtc8WSnooeGNGZJJ48hG3SI2btEAGJIS
         Lp/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTJOtJULuvBB4hkqjxcMLKfRnz8eEwwBRwGwzhTEeHF3Mhvmm1OQVo9g1lIWgmJLOzwDe9M5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQBKlaBIsj0/Rc8vpfzRnETjkjcEvOEgDLP6LvryzaCPr1XrLj
	zxamWhwfbykJKBWQKLxU+j7IGZW8Jw0W5c3Xgrx4spH2wi3oJaracK3dRY6e/dr5O7IcYJMFWhf
	OGN6tv8AiyYgABNrXti3Xtdj8IX5r2rk94loKRGEtFXVhnpVrfQkMpZ0J
X-Gm-Gg: ASbGncs3ycQiB5oIkdKZBPdHSwZgUWmVfS6WLEAsg6lS7VmPgcpou5ZUI0dcuF8UFIJ
	id7JemjSptkYhwwx5FHnTIhhxj20CixVyHBcjC6GBf8apg3WsNu5fa0W51p+XDtLF2YvRJisBVu
	IVxKeiMEY1ABB1Kv4XaxU05JzoTvXmGHzRk1oG/+JL6wnoUu6S5XHSNI9mDpnk4QpHohhym79li
	jgMC+tVAexs18tH+eSNfyDc/gosvl33LwFc4OQznFelGnFR3ALSULKk5XOvvv2MyyDEjeg=
X-Google-Smtp-Source: AGHT+IG3QbYCkW0+w14+GxOn8zrOdultaiRW9GGC+8/GajzreNpWlXbmMSYEZgIhqNUBOeXUPiC/zyq2CdgSlnaQgIg=
X-Received: by 2002:ac8:5896:0:b0:4ed:1bba:f935 with SMTP id
 d75a77b69052e-4f03fedb2a3mr123684371cf.57.1765207104627; Mon, 08 Dec 2025
 07:18:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251207010942.1672972-1-kuba@kernel.org> <20251207010942.1672972-2-kuba@kernel.org>
In-Reply-To: <20251207010942.1672972-2-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Dec 2025 07:18:13 -0800
X-Gm-Features: AQt7F2oYapRJno2e3aRfjRsCvAw13aWyh8c4DdAqOiUWSZvDdIDiVYfXnMpLG_I
Message-ID: <CANn89iKJXNksYB1nOnsQAXgsrYYaVa78JLeSuG_y3b9QaXnoMg@mail.gmail.com>
Subject: Re: [PATCH net 1/4] inet: frags: avoid theoretical race in ip_frag_reinit()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, pablo@netfilter.org, fw@strlen.de, 
	netfilter-devel@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 6, 2025 at 5:10=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> In ip_frag_reinit() we want to move the frag timeout timer into
> the future. If the timer fires in the meantime we inadvertently
> scheduled it again, and since the timer assumes a ref on frag_queue
> we need to acquire one to balance things out.
>
> This is technically racy, we should have acquired the reference
> _before_ we touch the timer, it may fire again before we take the ref.
> Avoid this entire dance by using mod_timer_pending() which only modifies
> the timer if its pending (and which exists since Linux v2.6.30)
>
> Note that this was the only place we ever took a ref on frag_queue
> since Eric's conversion to RCU. So we could potentially replace
> the whole refcnt field with an atomic flag and a bit more RCU.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>


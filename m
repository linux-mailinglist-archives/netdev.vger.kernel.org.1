Return-Path: <netdev+bounces-231910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E7DBFE7CB
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 01:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C273518C7BDB
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 23:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8409B30595B;
	Wed, 22 Oct 2025 23:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hIbA6qyr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94D32D7DC5
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 23:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761174782; cv=none; b=lt42vLTBJF7beZtxg1sv9RHNrTQMI58/6cypoPy7uqpuaPyrMfzqwJzy/2wVwCA7ytg06of6NUJfqelUDtk85OY+tp31XcF4DTLEw3zwSjUahZMaCbfT/f2y1qfjKGirxNEU888uZ1SXtZ0kW5iBWtIbmzt54jkBrt/aBjv0xek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761174782; c=relaxed/simple;
	bh=HFgjSYdm8Qn7aeniSTWww+GwN2mmX1rRN9bBV3DPGAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKGcqAKEqdT+i+Q72uDfvqQ69f08CpmlE02U51LDqO+rP16rz9YBaXTZ4zi6VtsrwJUuAdJavWGU0TOaHYPCRMSPSGQZiFQ8QMmFK7DRPSQx3YdBZuKUi/Uo0thL515gTg+lfq2uwPIDjjzhg4X/KNgYdxTaA061FDjCSfgCkJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hIbA6qyr; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63e0cec110eso207340a12.2
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 16:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761174779; x=1761779579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxFAnF6XcsAwEWpdTDR586Woen3eGEVHOet3tUa9++Q=;
        b=hIbA6qyrLRqd4jEOVMdAHpEKhDwyx06xsvqnJ+vq+fj8v9JXVxoqh7zqsBc0rIlta5
         CSoQ7INrY/4TGa8TBqHeXwWK2EpAryAHS8ZXtq3g9uInKQwoN0ndM8CsifcPykBGpXdF
         B4eKXFqSl5rrQRKR9xoClJBpW7FdGnUcevRjFdeJIeruWjhmejGZSw4vScWrm+wFC0jb
         phHGON71Ujz69R70CSu5yIZPzi1bms9OOzRz8Q5LKY6Q76A+qh93kdF1tD3VyY3sfBZ6
         BN6kWqX47H2CLouhZTuRvn3RjVzYl+MNHgSETBiiseQZXmvMG2mvvjGumdMfQ1duUA4w
         t7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761174779; x=1761779579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxFAnF6XcsAwEWpdTDR586Woen3eGEVHOet3tUa9++Q=;
        b=E4ELWhcTuIc85BQH3XJCr0SySpErLmWkWxA4SXyyyNt2/S6Xydmazp1nqDrKeIS+Wf
         QYKuyLdIvT64I5Hd3yBvVpa0xP7Bm4CrFSXAsR9LW+wVty5kwmAOJNUgqVA8uuzreHtP
         TeaBy/lUlOieTR+WXkpiYPUF/6btVe6OE78DwdJzGsgFtf6ajk3EZaO9v2lvbmALhu03
         X2nagCrPGriBmBdaAL6lBHXDW4e7xPP4AG/pw1Ngg17q8J7nBQG1RuaOFCBydlMk2Z0n
         aBbdsnR5h4j80UEh8sTdfvebxa48rXuIBjVjlhpIYVxzNpbcbSPjLF+q57DMdcfDfE8O
         RKow==
X-Gm-Message-State: AOJu0YwhfX1S8HDYG/+Z+CDc7XBXDESyrOetYID11xvV9p44TjFILLB9
	9ZTBxHDegQ2n//ht5cWxZZUYKSmppzydOsyQ401ygFbEObvD5R/Bxpo1Bjou9QycKTf2kw4Ljdo
	l5Dak1t581xKCuvB0BB1hPmV7VnKX4KTT15nuK5r4LspHTXUt318vDL5M9bg=
X-Gm-Gg: ASbGncsRg3UN27qSf4IjRtTpUw4PFBhdV99dha9C++9nmTWnAhHBW2LtDvw2rkEYSvc
	HdJonwVCQUpeCLxjV7QZlTmnO1ruMFHZSDi+WTm515JWzaps2ZbTmkv1EzIAIrHGNMCOmTsswvd
	ayuiK2w91dPqU0L0bG4eaYA8mjP8gr4l655+BNuedzyMoz7JAj2f6UJHmtTjNk1jAKE1XHwxl1e
	pHfMT5+QHni5aNfGzJ3PK+YF1HYmw4zBnQ2yM+ZSAS7JFDGTzAOeKoOBXbGZAohp1OI9wFJuE0I
	GVMaHSVnSTTGkZc=
X-Google-Smtp-Source: AGHT+IFzUC8Igm/62oEkkFjnbCLNJyRB5mms2TWRp+OBg9/a3xDEWAqzoLMjGWFmHbD4pwxZVEean0+cgSNwM2c0aQc=
X-Received: by 2002:a05:6402:2551:b0:639:ff4f:4bba with SMTP id
 4fb4d7f45d1cf-63c1f631c38mr20866766a12.2.1761174778924; Wed, 22 Oct 2025
 16:12:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022221209.19716-1-ebiggers@kernel.org>
In-Reply-To: <20251022221209.19716-1-ebiggers@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 22 Oct 2025 16:12:46 -0700
X-Gm-Features: AS18NWCLwSkPmXXrwrRUKAzZQqdCkLiWFiRbclQU2Gkm3fJ5lh-vq1VECTvgGx8
Message-ID: <CAAVpQUAuCGendBRk1DCxoMyTz4vh6S0SbyY6GmSQoGdpG6RQ1A@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: Remove unnecessary null check in tcp_inbound_md5_hash()
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 3:12=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> The 'if (!key && hash_location)' check in tcp_inbound_md5_hash() implies
> that hash_location might be null.  However, later code in the function
> dereferences hash_location anyway, without checking for null first.
> Fortunately, there is no real bug, since tcp_inbound_md5_hash() is
> called only with non-null values of hash_location.
>
> Therefore, remove the unnecessary and misleading null check of
> hash_location.  This silences a Smatch static checker warning
> (https://lore.kernel.org/netdev/aPi4b6aWBbBR52P1@stanley.mountain/)
>
> Also fix the related comment at the beginning of the function.
>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>


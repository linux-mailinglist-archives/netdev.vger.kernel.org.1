Return-Path: <netdev+bounces-198166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15949ADB760
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 18:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE3E172C11
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 16:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6D61A5BB7;
	Mon, 16 Jun 2025 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="09/72+bT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35D82BEFE1
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750092646; cv=none; b=bj/W+pKfdXBwOMfa6rZ8UgeEHXt0Du0Hydcy/Mk39kFlqFY4k3YfVyMPfDp1fbU7c0BPmTaCQFp37NFNCvyJ8+3FVlwMlXKW643NTT854ivyUscCMW7xpXx1DYkF0vHJonaevSHXaOlSa22oGw5gjwkpa/X1TEy+NS9cUFiclqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750092646; c=relaxed/simple;
	bh=i7VPpTuoi35inIgu0sFVPjS7BoZ4bprIIRn2d9yt3Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YS2y/obh27a1tAzOvKcBNFavuwl6tIAkujI+smvtMVzdUFGouHwFwherth7Xrx/XJarSIZgN3pydggEguKfxjCQAdzWEQ4WfSrYFQpDTlhbLAFmgzCbwOd78j2SdSYAQVGSvKlpvseQfhM2yznuXCBn+pNG6En9iAedHVF+byxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=09/72+bT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-235ca5eba8cso5755ad.0
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 09:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750092644; x=1750697444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7VPpTuoi35inIgu0sFVPjS7BoZ4bprIIRn2d9yt3Q4=;
        b=09/72+bTPK2IMIsioHzCkRtgfI0FIcxyCH1bxEcu83Q5tQKWwrecNOPPKDzwoIXUYL
         LxPPh9PMk5+T4qsUEuSZJFYEpfvdCcIOPt+sSwoYTqEHTgCovLKw46lC6YiQtS+WNI00
         M0pgSLKqDX2cUpGNJQA2ToqCFEGe9EpBJL48iSSD3XF9GJxwrs+YpUADC+tzSN90TBSE
         Iizbv0CqGYMqyoViYuQQKvm2acNkQ5FHUPE1lBQdUhmobskre24VDm6N1nt0NOamygTq
         dTPppw1ti/Ls2xt+kTaHHB2XGZUVkXXvp05kmHk9+hm3/T3ptCg4AB4N8V9JmMHpLxE3
         NZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750092644; x=1750697444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7VPpTuoi35inIgu0sFVPjS7BoZ4bprIIRn2d9yt3Q4=;
        b=ruSmLE3yqek8Vr67HONbXfspCektdNy0HPU1jApzUjgVQwo4V0M5fOTfFg5baKM/0r
         RZNgsrhrdzwiOi6fURNH1rT7XZYifdJMuzr/DedqUPUzcaD1bWDATDnuKSSKUisUWLYZ
         9uwUvbfIxaKeZzoruh3WU1V8it/QI3gWav2HacXzK4izSDQSOGCix42X0zW0B2XlyXAC
         m7gEdn1n+Beul9c7UQd4FXyVSzap1qrzEzbJyqzP/Pmg9noDUWp6ootqkm8zNZUIAbDt
         Su5cgL9ThlARjR8pQcd8Ky98zlWwK2NvFz89daskcjp8xVIKE6eprFeYkCe210hg8dUK
         QpbQ==
X-Gm-Message-State: AOJu0YzPldD07MgiECz3myswb5xlh97yUUbNDceX1bcnOuOVAxVQR7rK
	5EU3oDS2rRrnITFrsRf6G8txHOTGAWSeB+TKf8iy61XSd3+lgNci721dqNKWxbmXIPFtDnHfwH2
	gVfHV4g0hVxQWjILpgD3QQar9gxySMFUSuLRdlM5X
X-Gm-Gg: ASbGncv9whJW1fbE47vvFy+vBysgX1xywVxFUhIPN6Qu3xTT7pCkyG/z9J/xKQiwTi4
	pVPXhyjhWx5YN4pW+pVL1luV6ZlD34GJ2zzfE37gTs5fPC5LV6g4s6qc0VoTLO1eQNwHr4ErYyh
	xXOvjJXDP8kgWhIxmjH7Hom0vRclM0c+oKotojjPnCkdV7
X-Google-Smtp-Source: AGHT+IEtmysCAJRd2Y9culPw1HiQoqC3NL7/XlkliBg+tjU0JjnXJI9OhunLKvbKSDCPBjM/5UoyKyxVUINNmNXhTp4=
X-Received: by 2002:a17:902:d48f:b0:223:2630:6b86 with SMTP id
 d9443c01a7336-2366eef035dmr4334895ad.7.1750092643541; Mon, 16 Jun 2025
 09:50:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615200733.520113-1-almasrymina@google.com> <aFAsRzbS1vTyB_uO@mini-arch>
In-Reply-To: <aFAsRzbS1vTyB_uO@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 16 Jun 2025 09:50:30 -0700
X-Gm-Features: AX0GCFtWTNjY1-x8SLZxP4yAbb2nIqk27bHyOOiZQoVuQA14qOEbD5vctBOxGo8
Message-ID: <CAHS8izMgmSQPPqu4xo1To=4vFvJi+cxP72KewhMJ+BqDbka0hQ@mail.gmail.com>
Subject: Re: [PATCH net v1] net: netmem: fix skb_ensure_writable with
 unreadable skbs
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	willemb@google.com, sdf@fomichev.me, asml.silence@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 7:38=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 06/15, Mina Almasry wrote:
> > skb_ensure_writable should succeed when it's trying to write to the
> > header of the unreadable skbs, so it doesn't need an unconditional
> > skb_frags_readable check. The preceding pskb_may_pull() call will
> > succeed if write_len is within the head and fail if we're trying to
> > write to the unreadable payload, so we don't need an additional check.
> >
> > Removing this check restores DSCP functionality with unreadable skbs as
> > it's called from dscp_tg.
>
> Can you share more info on which use-case (or which call sites) you're
> trying to fix?

Hi Stan,

It's the use case of setting a DSCP header, and the call site is
dscp_tg() -> skb_ensure_writable.

Repro steps should roughly be:

# Set DSCP header
sudo iptables -tmangle -A POSTROUTING -p tcp -m comment --comment
"foo" -j DSCP --set-dscp 0x08

# then run some unreadable netmem workload.

Before this change you should see 0 throughput, after this change the
unreadable netmem workload should work as expected.

--=20
Thanks,
Mina


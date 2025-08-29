Return-Path: <netdev+bounces-218065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB5DB3B03D
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 03:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1075E3AF66D
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 01:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1DE2F84F;
	Fri, 29 Aug 2025 01:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0/0/f7Dk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A373FE7
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 01:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756429755; cv=none; b=vC9+QFkJugtPJZccEofQ0ygQWcbZB9/wXPZTkTfPTiV0nrHjYoeOt0VW20j2N8lxwlE1RCEtb/J7r08vFlTaLCe0/nglKsNB1XfEmOkSDWiMHOQLAVq1p8R8IINRmELl5dAFZuwaG/NHPknS73uu93Ta9yIcmGfHL3qBB848Pa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756429755; c=relaxed/simple;
	bh=A0fUDnNY64ASkUqACo1tIkO+BQZT9AAlj2y8IPNV1+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ewPATBb+RGtbtfJfodx3mRilT9mYBp0NyB/M2qoBsBBQgSOMI4wbULxG/xaxw0GzoklRKwN3mDZrv+7MNej66e433Y4ccgXq9EGfoxQmaTRTLK5BjNXIjcDw9TC/dSX6OFwyHYDgZFV3oLCaaZW9OqTy2y9QSYAhvKQGBzofZFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0/0/f7Dk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2445824dc27so13581955ad.3
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 18:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756429753; x=1757034553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0fUDnNY64ASkUqACo1tIkO+BQZT9AAlj2y8IPNV1+c=;
        b=0/0/f7Dk/sPSeQxcI1y8sRU1quYNWjKekd+2uHGZo2CytqZy0iFVh/5MwHvPq5pTNT
         u/W7h36HtxlPuAFCEHFgqUpvxt+S4Rj0RMZTiGSZbkmcQnOBJ08kI3mmEaJXNhThDIqc
         TVv3eVc7MmbrBiKuPLbkQrGlHpt51QWsltYtYuotY97C8KSEeNlyLUmYnWf0E8nW9P5S
         dn/1SmuEugVJIobNjSGQfs1qLX0WNP0CQQ0oTMGnGHJW/n0kUFE2vsjHsrMhBtOkRepn
         jBiL5+YqNlHOXu1CfQJwGGMKssIBF5lfVXm0pOoQqGnPplsGStZBEAQLxzw2Ayi9Of5J
         /8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756429753; x=1757034553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0fUDnNY64ASkUqACo1tIkO+BQZT9AAlj2y8IPNV1+c=;
        b=h6lDUf1K74TV2DHxQMxzvwubnXACF6ctLZQMNf/lGOj2fa9a50rd0rZ+vttvVd+gyl
         uc6JD21V3tD7gCrf+cTsOkuOWXAb0VbwaFkX0zkhBsyfRZs8QPzy1ZSuLGbtT1z9NVs6
         srY44Q27gsW4z+TM2ANk+hfk4yqA6vZtzwwwGDeGP1Ky57lPIMGLcXzLPoImoR8K7Ale
         LaJ9gJcDpUJnSQD8R8Hvo1vN37irk+skbD41BkzJGcPB4Q+BvQ709xQ6J+3lUakdYWvY
         qDab1hqFT+KaXXCd/oN2jdLeW7MCQ29WbYEUGKMPxcVD5YRYodwQjpbg/csmm/DX+QxE
         I0cA==
X-Forwarded-Encrypted: i=1; AJvYcCVWjo0CnR92DCailcsLdrb34otlmdbgfiip5h9u1K4Z7HCDQHszUUaNLHCO48anaJUh2kvBNCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6PVnAGbFKX6cPCuRrclH7ZjU+jG7OwTE3YCJERfTx9ckwCVUM
	NyuGaTrOPlyneVlbr0z3aFrXMgvIXm57qzSdECabe4Gi9U/B19pr5ovzXv7xUvB6v7fADr7Oc8s
	cLAB1Jif6p2hUL0/js5feQO4SsH5JGnXAvj2sfjaU
X-Gm-Gg: ASbGncuCAk7B8G67UjawaY4PJv6M0EGLgWfk01L5y4T3ldJcAxbMgbQRFRjvezr/zB6
	l29VzLxg9rrtdYDLXaHIntvlPBQF+FvWnKM8/NUfEjONkKoSbzOsWSpHDJh4aQByrD8YDA5IyRz
	PcYKg0Dc/DMvlzB7B24G7k2hX9EPva3UmyrBHiQMDo1xspF86w9XASDkWs58MfDyJCE8laCMwTr
	Vbt8ihLisP88yaUb1FgTyDq22KQyzmbqloa8FdGHDKa5WrqsxhkQVnK5V0r+8qWIqZcwP1bZuLc
	hbELtqc80BQaIw==
X-Google-Smtp-Source: AGHT+IG8weDT1t8W2g0lIzqzvB75y7DPDq5ht+EfCS4aRynP0fHZgshm29RpbXblb7TGvtvKd32/JIUvfTtVY87o7t0=
X-Received: by 2002:a17:903:3843:b0:240:44a6:5027 with SMTP id
 d9443c01a7336-2462ee86251mr369231715ad.15.1756429753343; Thu, 28 Aug 2025
 18:09:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828102738.2065992-1-edumazet@google.com> <20250828102738.2065992-2-edumazet@google.com>
In-Reply-To: <20250828102738.2065992-2-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 28 Aug 2025 18:09:02 -0700
X-Gm-Features: Ac12FXydOg7oJrYgm2_nOV8s0ZRp6YxqTaSo3U03GmZhpbSIHcgLRjYAkHmhUWI
Message-ID: <CAAVpQUDZ=osfxRzXjPO5W3j+jbjWR07ZnoM4jxCOs2yFv8m4iQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/5] inet_diag: annotate data-races in inet_diag_msg_common_fill()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 3:27=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> inet_diag_msg_common_fill() can run without socket lock.
> Add READ_ONCE() or data_race() annotations.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>


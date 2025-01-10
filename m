Return-Path: <netdev+bounces-157211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2288A096D6
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 17:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF895188E886
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 16:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289AB212B29;
	Fri, 10 Jan 2025 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jBwpNDOO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742D6212B3F
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736525494; cv=none; b=ZNqawxEZWCmF8omsGPk37WcJdyLbHaOInN9sThLdWA68pgPk0IEDKfs6aNokQiVbv1s5JI17ixFYvtOi1zAMUSEtTFBaVsddV5IRnZBOpqmCwg656GqsxHb1ykCsUzSw/ArT11jOFPKdayLSlkd94otzFmnQ60JLxUEYFD/mPxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736525494; c=relaxed/simple;
	bh=5Tgw4awLEmI8N06VmYOIKW/yfAEXB+azJPSoJizFyGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMXYcVQe77LfmcveKrZv/y3yGxhKO1tyggDwQoTtmwdvs/ZUJUaInLOn7Iuj/9w+QBWYrvotnyyZErZS8Blo07Qjfcjvwu+IzwFoZ2cZ7+5CtKdft7Pe8FWoOO5QUPvL7psSL8pxspkNRv0HhJ9rNI3mHVjdV2vqcaqWM5kvI7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jBwpNDOO; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-467abce2ef9so265661cf.0
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 08:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736525491; x=1737130291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kehS/2IeaZHCWvshQCM5tz9TcHb+c8qXioeyt/w3Csg=;
        b=jBwpNDOOw8sk8OXgJycDby/VeCzbR/lKi/NMIM7+ZeTeitFhzAVrq6RcVeZu/1cgO8
         Ljuyhhqdft3DVNvrNPJDCsxnauADobh35nEoNuqpdoGHpijGwDikH7KSj0KU0mwiWhK5
         T03mQodWX6WyanjzlaU1yp77dsRySrceOJ95yYRqILiRtob76p8ZDPWVUgzv84ttnSaO
         DZW3aHkfcQ769jUIejBUMH6rAF5SgIPw7TyRt0XFDUSw4qPHMIbcU0z1KtDhtwRVjeAz
         dX3763AYyW/vSz7vmbYQWqbJs8xl27prp3ZzRPRfNxcSQQWDHzhnv3X24gErl2RIMog/
         u8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736525491; x=1737130291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kehS/2IeaZHCWvshQCM5tz9TcHb+c8qXioeyt/w3Csg=;
        b=nLd4AkA44VKe1U5vc2NnYTm7V2eDJ9zqF4JWPpPpAmYdZwHxY4Bw7/B2fvPuVsCh3D
         YQAAvrEwevjvQBJzpi8xEfmRcy4JljC5qujCwB6tZkhG0U0fZCvKCPem7nIqD9XWXJTk
         SqlwFou17smCklSPJaJdnJDQKkGwJte8MQ6L4toLSg8kFWZW8wP+GUQ1v5hi2+xGN9UU
         JzfsD2P+9+RN1cJLn+SW+l/PF14qGBZeysslCWz7f5PHx0ze/ZDJNz/ex3bCiX1Dq6qS
         ZWlxRpSFk7xTmR9shocTWmCx/3PLUAGQ0OGgwA/vxd0fpuy0PuG1AvqfKnkYOh+kZ+vv
         0tbw==
X-Forwarded-Encrypted: i=1; AJvYcCVynhJ7366fqd9X+48XCrrTvmFCY2Qqp9r0+fN4cGcz3eeFC5AtLELzkiydOE8pT5IXm5PRGYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7vTwHCF4F4UdeCCVw8IiShiW57QOBdtNNy6J0kIJmjgyuOsT0
	rpgAMs/P6cfjjI+0/Nc1swj8D6eBf5KiAYaH+Xbtoh+nevwaJ1BQSqX3LwqhhPwqtJi65EeU4ab
	nPrK3tBPbOSW1XZKZpTkeWqM++dLi8rpRCMbn
X-Gm-Gg: ASbGncvwNHbVP9xbN3magxBqYsQIBFx6zd9I3doPCi+0rdFWa78AyrBP5hdAg+EDsti
	FWRVxxDwUhg7K8ePNTP2dgDZn2n4/c2aybwO8q/1qZyeujMdlL/23VyYjmWWy36GfVVXpbA==
X-Google-Smtp-Source: AGHT+IGIuO0dExIm5n9EifiPcxMxn+ISKza0NXj8z+BHCIUGpx2U5zliEOTSHGQCKxIkYuFQ5xb2RwRt2AkCSMJ9nGo=
X-Received: by 2002:a05:622a:108:b0:466:8887:6751 with SMTP id
 d75a77b69052e-46c89deac26mr2990221cf.23.1736525490994; Fri, 10 Jan 2025
 08:11:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110143315.571872-1-edumazet@google.com> <20250110143315.571872-2-edumazet@google.com>
In-Reply-To: <20250110143315.571872-2-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 10 Jan 2025 11:11:14 -0500
X-Gm-Features: AbW1kvZ0WGyMjq4Cc9Dk_qTdLUWNJ_pyyYKEnupHHbWS1v8O-gxVk3gd2dHVNKc
Message-ID: <CADVnQynrCQzzibTSyoo1uz7eWiTuj7m+cLwL1LSfNp7PZtm+qQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: add drop_reason support to tcp_disordered_ack()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 9:33=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Following patch is adding a new drop_reason to tcp_validate_incoming().
>
> Change tcp_disordered_ack() to not return a boolean anymore,
> but a drop reason.
>
> Change its name to tcp_disordered_ack_check()
>
> Refactor tcp_validate_incoming() to ease the code
> review of the following patch, and reduce indentation
> level.
>
> This patch is a refactor, with no functional change.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/tcp_input.c | 79 ++++++++++++++++++++++++--------------------
>  1 file changed, 44 insertions(+), 35 deletions(-)
>

Looks great to me. Thanks, Eric!

Reviewed-by: Neal Cardwell <ncardwell@google.com>

neal


Return-Path: <netdev+bounces-91898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499288B4664
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 15:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4041F22D3D
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 13:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013C7481BD;
	Sat, 27 Apr 2024 13:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u2VRpjfU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0F7433BF
	for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714223205; cv=none; b=CtSvs578YQ2TiO3PTkgG78S9bQQ0LW+353br37Ynu7BnX/ohGu5Y6BGL9UrOse0CCEAfVIKbLziOD3lhb9MUTk4I4X0pLR1jjvLpaoGBDn4QLmgmLc5sZZ6zbWhyTniZB3M7TrOpnl5G13vGNZ0Y4JeoVfTM2ZBbaasfDPae33E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714223205; c=relaxed/simple;
	bh=leQrtatoiZ3Ha5OIk+geZJctYZOo/BVugVNXiKy/0Vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjeO43ETSJd5rJgs0S7pSVZ9e9koPlqGc3WEgh1rRBRkwr0B9AHi7yyPiyjcTbKYFILHOS8scslPdNCUeiCHlYysxsLJ2x+iouUGY5MHE5/toeTv+e4nX9TqEVAxdmOO0BvGt0ohAjw2JW2nwL84pxJk/uuzoKZtwIZceSLb4yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u2VRpjfU; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5722eb4f852so3811a12.0
        for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 06:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714223203; x=1714828003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQUL5fl18WL0ZKXvOjs5LrQEgdQrTnHGFv8AkEWwYJ8=;
        b=u2VRpjfUuRUrIxwjQCp3oKYVGWP1j7V2ufd+CZ2U8iY294lLoA+Eo8EVhcKqlSxNeE
         yQi+GSBlSoTlmgzZjRBKFUD4ZdtJVxBZbFgr3QxW77eSWBLrg2qaKyTPE++GJzjICaKn
         aPWbIjHPqD5jyI7eZk62fsuHnPaW8Q9B/9n/+fG+Gozhwketwb8uHx9SMNgBXrHKuG1D
         9fwBduJND8+AzJgEfErIRyIDfkktMAGLZ1Q6ZZq8PGfU/geiQ3Ei7RirTJPTJMSafx3P
         iDIVbLPYsGOKrUFk3yUMKnQAxco8nTp9VqpNnOsicoprOfzn+ELKXR7gCMtewdXWeAon
         e7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714223203; x=1714828003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQUL5fl18WL0ZKXvOjs5LrQEgdQrTnHGFv8AkEWwYJ8=;
        b=fq2odbuGHpFyKg/EV9Tc0fLEA4Y3M1cHQrT3HFrnWYj8cRfI+obpH/11/Ocr/T9j/t
         dOz+8LSzvtadfRq/YrCDF8+e5BvkH2tFqbIRUv9oi6z0uL7NxDzvozgk+qgZ8nxgH9NG
         BUVsaTY0WqOHnS8A28SkFLFZHocFc/inCq3qvirp+IzMppt0+C7Fc9QyNZkGavLLRQ3a
         p73nbFp4Js8WAvjKp4cCwYQRQ7j1dDBr7cmLoQCT834eIUzebRnE8h+5JkGFluNdwq0A
         0+xUZTdqlPwoqcsYM7Im80/5dykL+tVqCVJzhSlhKOnBfkXRodcvRdSv3cGk0P3ZJ0By
         ODxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqmATTMuc4KIiF2SXsqhMB/kFObysrnqKLHf9cAkobVEKPWq4HDH8S3FG1x5SeZNjW9s2EBPudBNE2i2inGKunzn8C5xmH
X-Gm-Message-State: AOJu0YyjmSZk+bN+g5Eog7cDwJxyCLJSqN3aI38BcNFjxwvnsu3ffzgZ
	Q4q6nspeZWjh2TstVo8oWyADD9wI3OHlbShhZZyrko5IEKrsgYIIX4K4GXAISuKEzRXrx7UNsG1
	eOwbEqEHQkoE6GD1U+BRYdafT98ZEycuoyG4S
X-Google-Smtp-Source: AGHT+IGWABgpAh73R+Nkuk9KHLNNB1TVJVsPGK9UUOMNEL4x+Ak23xL+y1CGqbsru3TcKWbCtlDHHgk4rv5VJgNTfKs=
X-Received: by 2002:aa7:c6c9:0:b0:572:fae:7f96 with SMTP id
 b9-20020aa7c6c9000000b005720fae7f96mr93652eds.6.1714223202418; Sat, 27 Apr
 2024 06:06:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424203713.4003974-1-miaxu@meta.com>
In-Reply-To: <20240424203713.4003974-1-miaxu@meta.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 27 Apr 2024 15:06:31 +0200
Message-ID: <CANn89i+HO59Sxwu2fhrKOJCX_3DjOPp+os0LOO3TjvrTdvEiyQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] [PATCH net-next,1/2] Add new args for cong_control in tcp_congestion_ops
To: Miao Xu <miaxu@meta.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Martin Lau <kafai@meta.com>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 10:38=E2=80=AFPM Miao Xu <miaxu@meta.com> wrote:
>
> This patch adds two new arguments for cong_control of struct
> tcp_congestion_ops:
>  - ack
>  - flag
> These two arguments are inherited from the caller tcp_cong_control in
> tcp_intput.c. One use case of them is to update cwnd and pacing rate
> inside cong_control based on the info they provide. For example, the
> flag can be used to decide if it is the right time to raise or reduce a
> sender's cwnd.
>
> Another change in this patch is to allow the write of tp->snd_cwnd_stamp
> for a bpf tcp ca program. An use case of writing this field is to keep
> track of the time whenever tp->snd_cwnd is raised or reduced inside the
> cong_control callback.
>
> Signed-off-by: Miao Xu <miaxu@meta.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>


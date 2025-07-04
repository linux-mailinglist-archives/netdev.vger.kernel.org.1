Return-Path: <netdev+bounces-204032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC15AF880F
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436EE1C473F2
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 06:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816F4260571;
	Fri,  4 Jul 2025 06:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zMaIgTlk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1071225EFBE
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 06:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751610853; cv=none; b=ql+JnC+6eDkhymIuqsoMSEAR72cKfLUkVPHllCU9TLTkvsmgrcAKq6z7XIDilcZJfFEhY95B2Vw9U+hMBKZV3oWk4XBBDybfICF7TBPzwsW7IUyKO2yEMIfkKdr+xQJ+qoqqNXX6aGRd0VC57p0q351CzTVCMu5MOPrq/ER7SrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751610853; c=relaxed/simple;
	bh=5M8Fr9I/dtlN6rU9kw+YGHD69fp+xGqnTo7cWHU1q0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/YxabjCvWmnY3yLlQ8dvSjCrlMm8IJtrRelHc4vgVles1fRoWKAFY56lpji2FWbxX1yfcpxsMAQdf7aR+2rXUv1+G/5RsrXljAWS3vzv+2g8TKwZuH1lAZAO4Kg7/XzqfI0ev40xxfv3phdkgKNYvsd9AfN1TfAJqat5x/Nmf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zMaIgTlk; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-311e2cc157bso581407a91.2
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 23:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751610850; x=1752215650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5M8Fr9I/dtlN6rU9kw+YGHD69fp+xGqnTo7cWHU1q0k=;
        b=zMaIgTlkzImlZu/AXi4YPdsDo+aIBzXezxpx/CYB2/BxXFk4xtg7sJZ9CNvlbntoIV
         LYSDNSe51R/McAtuaNbZKjaKHhmkGtHkspei+S+CP+BTKvQXBaOzJPG8iFdmmuuH3PLW
         ZBNJKAQU4spl8C10w2zUK1X1ImC981LINvrzELywK0Q4v/0mpo2Zpx91cVeX84vytLIa
         zxeIcW0iKm5Pvc7wly1ZiqCibbKU03V2YBBimuz0oV5erc+qBFaJDL306x4C5yPcjlgi
         uveB370cX3wJTbcpE9GhGR4vD2oAVRP1EiHYgMuA5vBJIltuDrRk0ZW0JoTDeME9LEvG
         hfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751610850; x=1752215650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5M8Fr9I/dtlN6rU9kw+YGHD69fp+xGqnTo7cWHU1q0k=;
        b=wy5pJIJ5cnty+GwoVwXYzovaNzsJGyJA0esXTr7BzlxT2YEFU5Pyqcgx1BY7mOVUdZ
         Rr9OutzAFOjEsILGh20hpJzazXZjTckCXbrttNDY+tIG6NIplKuGiTdcKIQatzHCXH+u
         yc2g093AtDedf1tvjAJGh9TQaGxPuasFvidp/tnAoOE7J4G2OIXL+eocAM6siBBRh3fp
         Tv/lUa+iunaw5OU2mXztJ1cMqcUE+d2pLC8mP2d0NzitF7r5tAtW8lXussedVklRgtrb
         WjiLn1lmekVOu11nqYK+WU/kUkvKqdMWPyfVxYyTwzFiyNwpJiK3LCUIQIYqMXS90XFN
         Foug==
X-Forwarded-Encrypted: i=1; AJvYcCWmzUPHqdjQCK8CMToUZMW7uTERZZlCgckRQtnUzPHQSibaO8G2JNbvLw3Ke/kb3y6HmDzOXHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvbF3UyH03LcQg/Tsx2qdB0N6kkOUi0Yc+Ac82/hTg4PEAUBNp
	14FkOJLj+aj0iOMa6mFt5y2oKNIXCMByLV0oRsbCeyCjPRhCpz0btxkBaVdIGZgPelBwDVzNeBR
	3WP76Co/iQSg2XxkUuRhXUAp5PRgFg78Tv55W15ft
X-Gm-Gg: ASbGnct+F42aWAJcvkajpTZwGof16KgRj0QZE4HidiEEKghd8Nzd780a4eZSdSgqc/J
	pIYHp3K8I7YBZoaipRYLXW9KWHHZp9qxlE5mMbMcxh4w+iZ+KomV47mUoEIdLywL5j6JAIcEo/j
	k0dSxTsGbjJ6m6Ig9tpk074Ij5cj6TH0feQAFvKmVwwu3zcJD4Sz9CkBVoajbZn+hL5q4V3BcfA
	A==
X-Google-Smtp-Source: AGHT+IFFs/KawIynWOhHfGaZuYOow+fzoxajeQIF6PVhYbAcS/f2hMXHIzwk22sZz1g0HIB8ntVe/IhT0BCAJNaeQFI=
X-Received: by 2002:a17:90b:4d8e:b0:311:b0d3:85d with SMTP id
 98e67ed59e1d1-31aac439638mr2599654a91.2.1751610850065; Thu, 03 Jul 2025
 23:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703222314.309967-1-aleksandr.mikhalitsyn@canonical.com> <20250703222314.309967-4-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20250703222314.309967-4-aleksandr.mikhalitsyn@canonical.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 3 Jul 2025 23:33:57 -0700
X-Gm-Features: Ac12FXwN2MLhXm0DuyGPgF2t_e6iJdGzxpwDP-93FsMhv9dosxci8gCd_v4uq3Q
Message-ID: <CAAVpQUAW3HMVzxyqB=jzSMb1RwL9y733icCLSQS-RbsYbwWcnQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/7] af_unix: introduce and use
 scm_replace_pid() helper
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Lennart Poettering <mzxreary@0pointer.de>, 
	Luca Boccassi <bluca@debian.org>, David Rheinsberg <david@readahead.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 3:23=E2=80=AFPM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> Existing logic in __scm_send() related to filling an struct scm_cookie
> with a proper struct pid reference is already pretty tricky. Let's
> simplify it a bit by introducing a new helper. This helper will be
> extended in one of the next patches.
>
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: Lennart Poettering <mzxreary@0pointer.de>
> Cc: Luca Boccassi <bluca@debian.org>
> Cc: David Rheinsberg <david@readahead.eu>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>


Return-Path: <netdev+bounces-122092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B0695FE00
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 02:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0F3EB21B38
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 00:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5897FD;
	Tue, 27 Aug 2024 00:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3MIn2Y+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE38366
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 00:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724718681; cv=none; b=KCB+g6RxInC9I88dM2sY7pUpqh9B7ffnqvyyVE2yT06Qf8p5rbr1Kvct5o83bz1mgee1u1rAh3qMzEWt7Eo0v4ShHVRW+ot0MPlt+WSlb3QiHGurOvI4rdItx5xZz7/eE2ZivcVPDx9lqHi7+Sm8TRguMIA5bsLrLRMe00ty3HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724718681; c=relaxed/simple;
	bh=oq8xayKC/I+36y0Q1zrk1DC6PmomC7QqY5AI2jIXKfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6Ji9kWS2gxrzI94XGNf1czXYevirQfqxe0bmKuMLbDLPZn9YKrD1x8YDrgZKBHnotI5Xr6Rm310C91pUwCFv6n4FXqF+uItzZt2i6oRAxUi/Pqt2+NFAUITjL3EOmEKvTpL0r/joLfzajCfHmtBGK74CnKTOYlwGdE0ZsfjoOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3MIn2Y+; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-81fda7d7a48so181889539f.3
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 17:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724718678; x=1725323478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oq8xayKC/I+36y0Q1zrk1DC6PmomC7QqY5AI2jIXKfU=;
        b=R3MIn2Y+q0tB0jNWho2C6UhyZiDR7bC/y9D7veg0TY+MOG0m0B0aGN3XhzXbK3eYBc
         ulHM5Wa7VzD6pzUBAe6CrCvm4C7EEEBBJ79mpcIOeltRsfzOfrAeJusFoQQynNBbQq8S
         H8sgswh0O1TUitQJ161pVmkum3HDYfZ4kJcptgq41D/61fVRfdQbEgBf26I+E2r/rPGS
         GqkFroOXPX2k3zM7Qq2ZZ3zLt03fyqnBoKR5aS5qIGQrwAzBT2AqNxjFFj57neitatr+
         HCl3JdeS5bByNJdKuuYvw5bqFS79YmpSxg4WPXC+pRag3JYUcHUBONRkQ0Q5OklU6R1m
         1VLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724718678; x=1725323478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oq8xayKC/I+36y0Q1zrk1DC6PmomC7QqY5AI2jIXKfU=;
        b=oZ/C6DSo9yGy6YbTV4UbYH2ywLybMSDLDCWsNuHrjC7Yy0PKYCAR1uWRlKpGfV3f22
         IIyyxpkmlKcFXwBvW+Q7UsuEUa+wHxlz5O0IMNd/XA7jnma9OqqTGd8LFpZHbaqgLG2m
         r3a3sWUb+RxCH/Mslzi4iKLaoV4PikOdqAeMyBQEQUpGBImIhqBeH5NFhzQz7QbyJVVX
         8TnvxEVPz7SnpQym36vQj0g9zzwr6rYOX/KAcXfHwUc0F3ObNa5/bhNvoGe/77rtqJGR
         MoM2EUaT4yLAs7M20s47B/10oieMLlzl17jMAHtTalSSlI0sUBr0o29yZX8eCuxkIDRZ
         UWNQ==
X-Gm-Message-State: AOJu0YzwVpBNotPRwEUa1CvJJjmEaG5wyq4v5a2MjttM0SKBLy9kbt7Z
	u2D/hbyO2V0otzB0GMBnUqhTjr+Gnbrotwx/j3XsdX1+Xb9xby86bcUe1tnDfH7BcR8e6YPRrdW
	hsfKPpC7GyVt00J6qBeJ0imkFJUc=
X-Google-Smtp-Source: AGHT+IFCh61k80vtWEERgPjml3zjByt1nRYNtjWNcWZt+SH9L7TAd5zAN6WaknFdNDneyh4oUneK//rohNM/Yfe2u5E=
X-Received: by 2002:a05:6e02:214a:b0:374:aa87:bcaa with SMTP id
 e9e14a558f8ab-39e63e91642mr14365855ab.14.1724718678407; Mon, 26 Aug 2024
 17:31:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826194932.420992-1-jmaloy@redhat.com> <20240826194932.420992-2-jmaloy@redhat.com>
In-Reply-To: <20240826194932.420992-2-jmaloy@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 27 Aug 2024 08:30:42 +0800
Message-ID: <CAL+tcoAiZcY9KF9W5JKJGWsw+m3tg0P9mTYDATh2-hzHTCaxsQ@mail.gmail.com>
Subject: Re: [net-next, v2 1/2] tcp: add SO_PEEK_OFF socket option tor TCPv6
To: jmaloy@redhat.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com, 
	dgibson@redhat.com, eric.dumazet@gmail.com, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 3:49=E2=80=AFAM <jmaloy@redhat.com> wrote:
>
> From: Jon Maloy <jmaloy@redhat.com>
>
> When we added the SO_PEEK_OFF socket option to TCP we forgot
> to add it even for TCP on IPv6.
>
> We do that here.
>
> Fixes: 05ea491641d3 ("tcp: add support for SO_PEEK_OFF socket option")
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
> Tested-by: Stefano Brivio <sbrivio@redhat.com>
> Signed-off-by: Jon Maloy <jmaloy@redhat.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>


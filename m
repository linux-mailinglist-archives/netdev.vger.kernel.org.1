Return-Path: <netdev+bounces-224096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C90B80B36
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3B257BA646
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9703B34134D;
	Wed, 17 Sep 2025 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WklVpJdr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E65D34134B
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123567; cv=none; b=bRPBgoFcVc+mcp/LG2XqIRI6BGerxzoVsn28Kq7o3zhx/wCwc3fWneA1eh5VFrinRnwkvVlmPOLDjJ68OHT7Sgi2GB3GW+7WUIH/7+3jwerHr/YuD8Pe71dDd7zBuz5dEPM0XbcLJnH5tWvm8wlUhjW7Nfo75Xea7d+2IbL682U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123567; c=relaxed/simple;
	bh=agXGg4XNgFezTeX13WGg1WyABTM6Xuc8zRAChstPnJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PjHiYCWJ5ffSwnvyFNTroJl0OJ44IeOn5HKzhua/mlDERXoXpFq0MHD3ClhcwRmhMYhq9FwgbxEXJKgup1dliUjdis75s/pNpLw4enj9e5liOlOWaohXRh4CDVkzQ82H3LHqRJbPbf4aRW2LooHX6aYa2ykIw21RQr5Fb0kkI0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WklVpJdr; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-424134d9924so214815ab.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 08:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758123565; x=1758728365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agXGg4XNgFezTeX13WGg1WyABTM6Xuc8zRAChstPnJI=;
        b=WklVpJdrz+m/Ygdd1VYTMHm5JJnslmR7XwqjjYkzVFE+eUChVGc5eGxrF0MwWRpDE9
         WN8gtuBv0rh2ax175TuNAAq4lah8Zhkh+XR7GgOyUXjLMgCjdCyKH+DiG56jCU56FGTV
         UNqyPfC/FAgkuWIhRF1KOKoPDIFgJQAypm/6YOzLvPXNId7X4i9PChAbKk60BwMJhHc4
         yKlsDgXqFQP4+y5+D+rAryu6c7EdXVqkJwCkjWeMbs4aQhoJgbr+OiAOZlzEoImBSb6N
         9dm2D1M5gLS+axEHWFJmrX0zIUSmKBLIAxGlJbUg6NvWKCsLaya3BukhRWmw5Sl+chIw
         9RYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758123565; x=1758728365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agXGg4XNgFezTeX13WGg1WyABTM6Xuc8zRAChstPnJI=;
        b=ALa8L0tZ1Ty65kif3HI18fjj3BwHpYvgaW1I4kWcAeQaV/aM/b/WVR22PFfwwpBwNO
         gXlnHaWMjLg7/aOxyX1piJj7R5GypQcpw/FsdDzgrHtzFblBMnpdvi30p3x3/bsZc+fF
         aFL99nSH/lxZ1h2VmIlFdFUk+bDv44fCfeLInll6Y9UjhEV78GU6xCmaO8yT26/bKWWj
         wxuYkS9ZO3VqCiR4Zf9oDNK1FRCS9j+AXEA7vwFuJHaZ+iIsndWtkEnIyQ9TSH5m55zD
         p17IzKfZkYqayqhXYTU6q5gj978JEoSLQqpBHltXm89bUbxxMCxPbyaKxjhWRpDFA01r
         kUEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUezs7CGIi0MseT1lvkgQ8CiTfoQ+Xn+6v3+c4DbYK5hXDDFEw9NgcuX2sgnHI3PSpZZesoi2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMJFjNwR+DCEjHLJ/quEdUvY9AmhuYLIAThfEclVu9knvj8/UG
	FZN3geJ9CUQkYgQMeZL5Qmkwo/MYZjcg3p8SHwng2HC+5xU7DPjH0JQ35QuieD9NiI4KGkFqL8q
	X6hknHhs05A6FCFlSI69d04wkaB1j6yCSNY5rGpFH
X-Gm-Gg: ASbGncvxzaNjnGsnJ73Ilk9AiwXgwCBoC326tmSyJugESi3GV8Et7rTrByyurUzKev9
	IwQnBgH71NCW8LzfHtpeOfHgsECjztbjNB0KNKG53YcHYZiTxCPVGe2U5EQrTCNE+uvvFlWoj8O
	gT/pqFqELFHieFq64Cdmo8vi2ZtDyNehDg93b9WmrAMxTpzyjr9BPkV8KY3sduxqSB2PBI1hQhz
	ils882G/zHJGEk=
X-Google-Smtp-Source: AGHT+IEsQn3nAaaAs3y3vAT4/c3NiR7NGnKHDruWaCH9o/2d8XIeX0cq8S68X9i5Gkr3Pa1NgxvtEOomdCs4MMI8xzo=
X-Received: by 2002:a05:6e02:1445:b0:420:30ce:ca95 with SMTP id
 e9e14a558f8ab-4241863c424mr7115625ab.6.1758123564633; Wed, 17 Sep 2025
 08:39:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917135337.1736101-1-edumazet@google.com>
In-Reply-To: <20250917135337.1736101-1-edumazet@google.com>
From: Andrei Vagin <avagin@google.com>
Date: Wed, 17 Sep 2025 08:39:13 -0700
X-Gm-Features: AS18NWArFSm85O9_M30vPPddmWWxCk7T3ZcZA1CcwWPgPcOrNSGFhi_Vz7iplas
Message-ID: <CAEWA0a6b5P-9_ERvh9mCWOgbH6OYdTUXWVGgA20CQ5pfDC2sYA@mail.gmail.com>
Subject: Re: [PATCH net] net: clear sk->sk_ino in sk_set_socket(sk, NULL)
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 6:53=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Andrei Vagin reported that blamed commit broke CRIU.
>
> Indeed, while we want to keep sk_uid unchanged when a socket
> is cloned, we want to clear sk->sk_ino.
>
> Otherwise, sock_diag might report multiple sockets sharing
> the same inode number.
>
> Move the clearing part from sock_orphan() to sk_set_socket(sk, NULL),
> called both from sock_orphan() and sk_clone_lock().
>
> Fixes: 5d6b58c932ec ("net: lockless sock_i_ino()")
> Closes: https://lore.kernel.org/netdev/aMhX-VnXkYDpKd9V@google.com/
> Closes: https://github.com/checkpoint-restore/criu/issues/2744
> Reported-by: Andrei Vagin <avagin@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by: Andrei Vagin <avagin@google.com>
I think we need to add `Cc: stable@vger.kernel.org`.

Thanks,
Andrei


Return-Path: <netdev+bounces-224111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09A5B80D0A
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 18:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE96A7AF3D6
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7FC309F02;
	Wed, 17 Sep 2025 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fzli/wkD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975A92DC35A
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758124801; cv=none; b=uIXKkL2ca/i5in3MlX7u/BPkyCWZkS2gevQKpg5f9S6xNdGbHnedEN/RI+wLwIkLZarcuaRncEywblgZaPGJ03eVtEODnDpz5RW/EvI8g3Y5ZYaHLPK2p+XihHEJNHmzwou2gRFq3ZU9G+Yn3CUDeEalRsoii5othIlDvf+oiaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758124801; c=relaxed/simple;
	bh=p8VU8d7acAevSPUK7uEtuzMqc5TZahg5NjVNZ0H49LM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YAViao4n4Yx2QBYTXQ+G1CQOaElb8wi+kYR5T5z9FUfDsY/SoJ9okRn3lgnBzpmpB3k2grIaUrN4kntt4OahazuGP7r6XrA7B9cDSHXusk14WgPuWoG5tXWcksepW38a83QxcRLV062MUj07WPmvadlz67fzAPF8VHTdomDpbuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fzli/wkD; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-80a6937c8c6so821832885a.2
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 08:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758124798; x=1758729598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8VU8d7acAevSPUK7uEtuzMqc5TZahg5NjVNZ0H49LM=;
        b=fzli/wkD90orpjV+GHgZws5gLaAF5+ZZoGjaYus+EalAjcLFStVi1oXoQBEhPBNwVm
         PBboavCgKkM7ZIuLK/bbjmUDIuJxNFYAAEuAPY6lHjCKG9bx6W1E5jxFh/i0xxSILcWY
         d4+kjhrZqX0SMB4j1/3mUaelOx4y6SRrSsXi8wogAzINXBRID1/3sBBaBl9qAdWT018v
         sxeO4neHYTW+SNMPNRTItlZEqmNG7lWlDsWXIdFi4yyMDRGYIyJZyecSaUUV6GR26kZp
         2bDhcEfYgcGgpE8lyvVt3vbcnEV317MMAFpx7Y4QBWXzfrn6VDdDCTp6KsCSKXmWZt/E
         MKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758124798; x=1758729598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8VU8d7acAevSPUK7uEtuzMqc5TZahg5NjVNZ0H49LM=;
        b=pO7nqqDdgtHgO6NZFqWIpBmtTd3pMfQ0WoV5oigRwOXMcxzDnV2aJVdvoKKQ39yjRC
         m6TtMLtzfNSpCUmU2tO8D3ockWjKxjpbx/VHtWXz3oF6XUsoZHCwpWv+304gKoQN8RZ9
         zRkdp/y2jZYIQwxBz/skI9G3wjtUAMZcD9Emh2UOFxxZfunQJBfgvgVv+UsIigEB64nT
         U9kuMD0tZzkWtWShP3W4XS3h60OnbD6xYzh1lVn9vER1ufYiw6T1Gk6zMwKqTmTmVC6y
         bhb4Sdv7wCfllzfj6cw6DpWfrA+95cuauEtGBJ4JMpuIeg4AwgE7QXvpmGqn5B9BJQTB
         Jgnw==
X-Forwarded-Encrypted: i=1; AJvYcCU4MfPmroc0jglNleY7xT7CmkInqJZp/in7E+37F6tOrQbUWXlIDPBGt7hPzrnTQ4HUpG6ZEg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHsAI2It5qKZlJ1cAtSWvCRs35VL2uaOTnLCPCEsX3rQXfBGMJ
	YPMxl7mT5xEBdcVSyX9erzfg9gfM+2zNyywMVizqA7DV8pzTa1w+wBQ2zmtoWIip/Ku8GoBXp4m
	MFK+FAynzF1RzsVqxhc/qHuL06EC+AR11vSA7ltwA
X-Gm-Gg: ASbGncsiOynzPzEATnBB7Ummze3RV/sHyLbvS6U0GUpJ9Dvjbltq4xw0fwPdEUO8OOD
	94fZUv4Ali5sFSVlpCnrMa/0dRlZi88Gw1LncQf884/xwQmaJC6kNg9JEsXPbY6i0SjOJTTqafM
	nomxwfbmq8I+4mX6Ioi+lbGb6MI2eCqRob++RQUxY3BrRuYYty/qcucMFHuipc5STwEColLPLPu
	hBWqwIWqM7k
X-Google-Smtp-Source: AGHT+IEY/PyZp1WBGsKJPyJFeI1IEf25apm8zXHVEw5wScGBo8SqeCbSKDuMXCsjLK828SsoHGuQ8EqD1wN180MnPzU=
X-Received: by 2002:a05:620a:44d4:b0:82b:54f:5b8a with SMTP id
 af79cd13be357-8311186db3dmr308775585a.75.1758124797892; Wed, 17 Sep 2025
 08:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917135337.1736101-1-edumazet@google.com> <CAEWA0a6b5P-9_ERvh9mCWOgbH6OYdTUXWVGgA20CQ5pfDC2sYA@mail.gmail.com>
In-Reply-To: <CAEWA0a6b5P-9_ERvh9mCWOgbH6OYdTUXWVGgA20CQ5pfDC2sYA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 08:59:46 -0700
X-Gm-Features: AS18NWDpc54Ny7WiC6WI8_pv5gt_wkspmTrUnbWeHn8u7AoM0Y3ZYaBU4oQyyGA
Message-ID: <CANn89iLC+Gr9BbyNQq-udVY-EZjtjZxCL9sJEpaySTps0KkFyg@mail.gmail.com>
Subject: Re: [PATCH net] net: clear sk->sk_ino in sk_set_socket(sk, NULL)
To: Andrei Vagin <avagin@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 8:39=E2=80=AFAM Andrei Vagin <avagin@google.com> wr=
ote:
>
> On Wed, Sep 17, 2025 at 6:53=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > Andrei Vagin reported that blamed commit broke CRIU.
> >
> > Indeed, while we want to keep sk_uid unchanged when a socket
> > is cloned, we want to clear sk->sk_ino.
> >
> > Otherwise, sock_diag might report multiple sockets sharing
> > the same inode number.
> >
> > Move the clearing part from sock_orphan() to sk_set_socket(sk, NULL),
> > called both from sock_orphan() and sk_clone_lock().
> >
> > Fixes: 5d6b58c932ec ("net: lockless sock_i_ino()")
> > Closes: https://lore.kernel.org/netdev/aMhX-VnXkYDpKd9V@google.com/
> > Closes: https://github.com/checkpoint-restore/criu/issues/2744
> > Reported-by: Andrei Vagin <avagin@google.com>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Acked-by: Andrei Vagin <avagin@google.com>
> I think we need to add `Cc: stable@vger.kernel.org`.

I never do this. Note that the prior patch had no such CC.


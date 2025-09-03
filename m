Return-Path: <netdev+bounces-219429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B1DB41456
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 07:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32B487AFEE2
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 05:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EC32D63E3;
	Wed,  3 Sep 2025 05:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZeJGHztt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF722D5A13
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 05:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756877214; cv=none; b=h5CqK/QMh3CjFGWgnYU/SeC4982T68hmVtC2yiqz056Vxl70mqPRVC+0aTjUynSIN4Ph+pLlQtduQRnsBnxNwqT/PGF+YqjYI/PDrJtUM1KDlQm0IOWiwtPI+kCXKC7yVjBSuojsysXQYw5vNpw7ABryb0lKIf9rHIrAzjKq6og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756877214; c=relaxed/simple;
	bh=Q6FWZGqSk1NKdUBu2EqU9JS+YrssKE4+/myDZ1X4EMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oA5qAuD/aE3b/ytG28qGzIZcpyMWmy3m7QmlOWYAqzvXdcFEq54KlauIfyB8F5lqSHP9JbBWtfJwa8DhLgce5e5a7lhx+rVnHx5AWgqugptHuYk8jJ/aIEIL+6U5Imk+X3nbBgPfeoY8fLVcl5Jm7VLHAavqSEI+j8DeRU6y000=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZeJGHztt; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b475dfb4f42so4155150a12.0
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 22:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756877212; x=1757482012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6FWZGqSk1NKdUBu2EqU9JS+YrssKE4+/myDZ1X4EMQ=;
        b=ZeJGHztteOsU+seLAk87q26LkDyu+XThcQJLxjrP7ElCFsEF/zintUM0s9p5r0fCIK
         VvTzMdGLFbxvEFjUq8D/bjQDYujPf0/13gPJ2EsshbWpK44VRtVUXag718CtYAMPpen6
         eNK1cOJIWdfc3LBnZAlOvaUYHHmpfaAsPKCXqO6zd46ClkS5fBo1QjC8v/69kbSC9A8X
         eC22MGiUaWIkWeqVcuzsB9X8gQ8anhpX9sJvhyifV4F2I8UxfIWaBZykRyzmVy07+/nh
         4ATFh3tPWEdATZm4y47xGL96DT7OaZYaln9p0fbjpCAL/Nj5QAOG3wCchR5B8uIr0N2A
         6cUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756877212; x=1757482012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6FWZGqSk1NKdUBu2EqU9JS+YrssKE4+/myDZ1X4EMQ=;
        b=ddAHGnpLT+HygF1+5M1NIkTnsqPCrPQCh5Wzadec1H46ZNNWPFXdliz55KqCZkJsII
         q4dD2TT3eSeTPzoZuRrwRMSPcE75tlchKV8VN12gkPAg1cJ29qbUjHLJLgoKDnsv2gza
         4zhuR0RcN7TlYD3ZK04e8R4rvZdlNRWwgP+DSCFdRg4Z9Ri2VBSycOZWlwzZ3ZMuIe0t
         79mcZcDFctA6Jb5MnP1v7i8IF66M8OzDLZlK2LwUWdhD8FkY0eIID79Pgj+OTBd3eUmB
         fRjpHOL0bOf++65Iwwu0NBDjISPhKyXT7UUOspgOjgwHrbqyYM7MgiNtVCMiPnGhbGJY
         T51A==
X-Forwarded-Encrypted: i=1; AJvYcCVsPK9hgQv2wwprasYPLoAYnu0TJC3MWX1hbInvq6X7FLmQzMnZQXR0SaL4c14gmUeZMl29YAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywva/c9s7YBuXNtx79+hJjedht4o6UX60iLEDQCxXmaD/6AlAjK
	e5eCzZZvIPjsyeAby6DMboZp+1r7o8p48QhrudbmpAeoxUQL800XMNmGwyF7bkFYndd1zrmMp0I
	ZhBFOv5EfjbDTvkmCXnShZlSFnO9FvsRvmKPvuRBm
X-Gm-Gg: ASbGnculYeeO++4YGWh8++r6sR2YU/H7OO+Z0gXVHqmAR2j7ryjprIAszRmIZXXdovH
	J83t4xC7Iw5SaL0GCbW0V8ZrTQ9vR3YmeO/BND/aAkbHxWgmcT09WwxGXt2BSHAkJ/9hTHAqj01
	f/g7B31Difex8UKyr/0S0fkgbTXc3L1FEs6hby8qB5K1qOYU/N783sGPLG9pqwndFRnVNRfmVld
	3QYdo8ZxPjqX1feeAwO4xuae+AsRhZui05lMF2R3NnlAHHLw+fy8Ist2VkSkedhTtK996Si/AF7
	t2v0SE/Ifusc
X-Google-Smtp-Source: AGHT+IGdpNawYh57MsjWSJV18X4BxWJ6czB8SD9oMKkZkZexakkIl5zmv+PzIdRaBwxb+v8rfw/ksKhqS27qEPaoAHQ=
X-Received: by 2002:a17:903:238a:b0:24b:1b82:2acd with SMTP id
 d9443c01a7336-24b1b822e9amr49951535ad.41.1756877212047; Tue, 02 Sep 2025
 22:26:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902183603.740428-1-edumazet@google.com>
In-Reply-To: <20250902183603.740428-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 2 Sep 2025 22:26:40 -0700
X-Gm-Features: Ac12FXymnvXqXweMH5dKvyrruOOCRQXp4G6LISeHKE1NcpqC4oGCghc6J8shm5Y
Message-ID: <CAAVpQUC9y6wO4VbowwbH99muNYR3AX5On0-EHYiVLTXRPysKEg@mail.gmail.com>
Subject: Re: [PATCH net] net: lockless sock_i_ino()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+50603c05bbdf4dfdaffa@syzkaller.appspotmail.com, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 11:36=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Followup of commit c51da3f7a161 ("net: remove sock_i_uid()")
>
> A recent syzbot report was the trigger for this change.
>
> Over the years, we had many problems caused by the
> read_lock[_bh](&sk->sk_callback_lock) in sock_i_uid().
>
> We could fix smc_diag_dump_proto() or make a more radical move:
>
> Instead of waiting for new syzbot reports, cache the socket
> inode number in sk->sk_ino, so that we no longer
> need to acquire sk->sk_callback_lock in sock_i_ino().
>
> This makes socket dumps faster (one less cache line miss,
> and two atomic ops avoided).
>
> Prior art:
>
> commit 25a9c8a4431c ("netlink: Add __sock_i_ino() for __netlink_diag_dump=
().")
> commit 4f9bf2a2f5aa ("tcp: Don't acquire inet_listen_hashbucket::lock wit=
h disabled BH.")
> commit efc3dbc37412 ("rds: Make rds_sock_lock BH rather than IRQ safe.")
>
> Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")
> Reported-by: syzbot+50603c05bbdf4dfdaffa@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/68b73804.050a0220.3db4df.01d8.GAE@=
google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!


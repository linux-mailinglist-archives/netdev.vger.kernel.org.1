Return-Path: <netdev+bounces-226926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A77BA6339
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 22:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4A5189A139
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 20:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6FF1991B6;
	Sat, 27 Sep 2025 20:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L8KHKr4C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E982C4C98
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 20:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759005081; cv=none; b=ZdDW+pQdKISQqZnpN+urhlvLGT2/cYG+7E8pYpFsRcslnnTML0/qhnImIK1aXyWi9DI88qm+xLYhrjN2GC11GxLoti/A6K7aeOiey/vaQpyZwmMKFSwiJJ/J262lFklALedipckXmmgnl+h2olcBpIwbXMMkwG/wSj6qQ62ZL8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759005081; c=relaxed/simple;
	bh=eVuwHl7dBSg0b9Gfg4lh1FwIk9Ym/qDJJ+0cBUv3crM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiKxfH27UTGoKIT0vFZ73IqpdTJ44xyq3zfkZUGFFPogZ/JrnLsga33xv8Uxf2P4FbcJMXqdnLgNefhBrwzJ482n6ksSnl/gcahjBStW/SSW9OpHjK63dsjsaaOJUmD7xJ/0fjxwehr0OvFTC85rAC9G14JPJGOPlppa8J7WaSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L8KHKr4C; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27ee41e074dso27623825ad.1
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 13:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759005079; x=1759609879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVuwHl7dBSg0b9Gfg4lh1FwIk9Ym/qDJJ+0cBUv3crM=;
        b=L8KHKr4CypmPJLlbpnSycuDaP2Ml1nUAA16QSROtGX2ICX5gLyy8Sfy5UjAOKLFG4/
         lUVeJncphQC4iNF9OXJrNxHEgIEEbbgTUy6QvbMpQ/wCs8GOuyInhxVMSeqsolsmc+Nk
         QV+Mw6bciIOxI1lneOB4//aQRANXVvzyYWXDY6sFHaRXWZem6iyZOgCI0crC/CL3bDwl
         hjOof9LCz7yvSMQsiJWmF6gAILtyPNj5dD/d7ZlCM1RBbxkPegLJiH1d2hhYKzxqjEx4
         U5Eb/gEqij25iFoVEsSfA3nIE+DRy5E1T6DEDy0Uu6efSq+mSBrdBV2DkjF9NwH09a21
         ZPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759005079; x=1759609879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVuwHl7dBSg0b9Gfg4lh1FwIk9Ym/qDJJ+0cBUv3crM=;
        b=sQiP+KJlUtIb0BT8O5v0PsxcUGnKVKm6OpT4752wJhu8XctCozhahn24VF6xNHGRE0
         TBIDHJF9U1rfkFwM86pHkPKHQoqaGEAqNbxZbaAuVI2+wV15P72NB6ltvNEDksDLTb6q
         kyI1v37rZ/7WsOeJWfaSLxkS9CWPFOPI9rYmqX5ZjE4Ko3wXXXJOW6ITVZLZESFW0Y12
         ArYqFicNPWRwLazUfl9ZDWI7bkoiwBEoXb7rhTtaz0X9Gn8zdgEs0EfMLdXdDOy6eIa+
         0TrSvvLfsd03p8XtTQZVhTAiYkFuC6hylxI9csLQSIou+3CNtF02R32zvvpgKQSlaUyN
         8pKA==
X-Forwarded-Encrypted: i=1; AJvYcCX1vTxs6Ne1kDLf0LJ1AJv/1S5FY2MyRM+txQmgvH0Gb5aAKHz7nvjWMUhOwiCXwfW0f7uR3w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT5xpHIE6QmlSRbKH3BQR3lGcP0iFMlvVXNhuiwEukrY0T+6zn
	B0BrdroNAYyhp86A8Oa/jaz45mXef9DUYKnZ6QxhZJDlbhyGfgRWxPP8MYu0IEd5Z9zm2f+Kw0o
	yDBlHIOV1KMkTTTCKV61gLbDhSxWADQ3R2lH1LZWg
X-Gm-Gg: ASbGnctqyb1Nc+ZyWBmP6uAQPmEA7TrtxukV4ylD991U2+htmLysqSgfUpQVzkHbCex
	5yZr7Bx+cHy82RxakBym5O9aWDFElcYkjIy7Tha6MtLadvGxIYvrdn004WvGUGgdX6/nwbA9G/a
	W4lP0KKQ5z5lAK1ryTn9aEP0NBsXg/hb1qoIaZyvBZPsqslX2tAcrPib3/Y8vj4sgCtug8m62VL
	dTkS4KEOAv0uffWN0H4zhMENL9nQ3RMooWKy3v8
X-Google-Smtp-Source: AGHT+IFFxkNi92GvhJYh3hQyHBUwHPMoDPUg9E+1AOwUvvYMX54Db2ctQJcHCx5sZPKiDqTkXOo+Qsl3IzEGpDAGqQU=
X-Received: by 2002:a17:903:90d:b0:268:baa6:94ba with SMTP id
 d9443c01a7336-27ed4ab65b8mr99926025ad.53.1759005078973; Sat, 27 Sep 2025
 13:31:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926074033.1548675-1-xuanqiang.luo@linux.dev> <20250926074033.1548675-2-xuanqiang.luo@linux.dev>
In-Reply-To: <20250926074033.1548675-2-xuanqiang.luo@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 27 Sep 2025 13:31:06 -0700
X-Gm-Features: AS18NWDiZUuQQ6JDqq-0iR8B16bJx4Tl1jAxIDjqMB-_yHukzIJBvrlkWWtgoBo
Message-ID: <CAAVpQUAi3wDmL2e+U-3Uo3hqdHEXPid3DpU2baC-wgLFcAi7XQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/3] rculist: Add hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
To: xuanqiang.luo@linux.dev
Cc: edumazet@google.com, "Paul E. McKenney" <paulmck@kernel.org>, kerneljasonxing@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 12:41=E2=80=AFAM <xuanqiang.luo@linux.dev> wrote:
>
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
> Add two functions to atomically replace RCU-protected hlist_nulls entries=
.
>
> Keep using WRITE_ONCE() to assign values to ->next and ->pprev, as
> mentioned in the patch below:
> commit efd04f8a8b45 ("rcu: Use WRITE_ONCE() for assignments to ->next for
> rculist_nulls")
> commit 860c8802ace1 ("rcu: Use WRITE_ONCE() for assignments to ->pprev fo=
r
> hlist_nulls")
>
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!


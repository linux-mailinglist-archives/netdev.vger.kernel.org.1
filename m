Return-Path: <netdev+bounces-224593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7710EB86839
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 20:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94C1170051
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 18:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C612D7DCC;
	Thu, 18 Sep 2025 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GJdUviO4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAC92D6E4E
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221294; cv=none; b=hV4l16v8LI3+jtXK7Aeph6ZAFBryhyvw/37XkVirdRkI74xYktGSFHCP0aFiIN5aQTzh3do+dsFdrAx53DQNpPMB8Nxy7QYur28RNllCkq3aNODmbLh4tBX6Ygnkt3NSKg6I4GrD75Ccx+eesfYJPtjvNsZeP0LgIAkiFkVvp0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221294; c=relaxed/simple;
	bh=3LUG8CDlFaeOAc7TmZpmAR80a/tbN4YHi+y0ePtW84I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9Yn/x+NB3ixrhl4VIRPur7Gll5HxhJI1OTl/4F83eL4O6jc+16A5Bu0TtTvpaxut7XmWJQyXywt0fsDcclwRiy5R1OO/M3yTooXGcAVXPe6w+jciA83/TiiT0AchtdhuXInA/A7T/GxwQTiURsUgN2OWAuK+NG453miJ5Y+mZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GJdUviO4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24456ce0b96so15344315ad.0
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 11:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758221292; x=1758826092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LUG8CDlFaeOAc7TmZpmAR80a/tbN4YHi+y0ePtW84I=;
        b=GJdUviO4cMljecghqlZIW7CMeuCDdgmnHnycTIqsUgeS7I4Kurc0uAJznZUMpmaf8x
         I7aOIlZPmm9HPwepR5dookk6dax0vqIjt6Lj19Sw2vJLst00yzF131lUtEh7t/tH5cJA
         R6J2QTA1prI7MVpFSKo/Xn7Io2asQVQBOVFHo5sOX5tFJYyt93j8iopUfKVBf7kbm2L8
         QKjiMJNWae47REPpg7dBpzWqecqEKMAlr4ZHenvdeXWndKxKdosRrgO0hSmvyLUDMrFl
         wCcZuGxwdVWCcRcHgXuI3gKWdTcQuhZ4B/Bn3nCKuaHQgoqlmykgOmMUlsLDzSOdzXDM
         7i0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758221292; x=1758826092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LUG8CDlFaeOAc7TmZpmAR80a/tbN4YHi+y0ePtW84I=;
        b=fmgdmwtvMvLT3pDpK2Uqqi1FSxLuOKDhmpnein+cgVKSluyVPsDgYWzzHSwclNpZIY
         kgp+Y1COkftj3ayTFp9xROkO/rl5lNAMQOm6XtzTmkQN4L+wMU05mwwcIfE0t2ZgHvNb
         FunhO82KD7/m1POWPnQ7HQI+4K2Zr/Tq2e8zJugd7dm/AgXM5DnorWKQv/16etlxuuK5
         zoZNg4iFta6YcCXSq6Ow6PZeYC8uMRp2SqVrZIEry9F0g3Z6tcdMq93TD9fuyri00KFV
         nssvHc1nM2bw/vsr1YtoY1XWXQwSYa5b1qXGgp/cWxK68c0EDLiVhMyKVZqRzOSzmOg3
         O8Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUIw8kpDhjnSyWv6gsds66hS4mM0RBIXqoQjoUqdSmLan3e9YwiOZcfT2G/RQKGHzA/mfhhThs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJj9HWJWGE6+6256ot6q/ODvCDHTZQizF3OvcySq3vo7CnS5qr
	GnBvHF2u2OE2lqlHc4I02DkPXuIE9JHCtj4KxtPzhO9qdSNc9vX0BKqsz86efgtHuNk0+XW1psJ
	kvVzj/HZSGoEggli6ZvzKYDfDrShuHBgi+aJeYI+6
X-Gm-Gg: ASbGncsqIv73YuKUr6pnxBua2Xu4dJCRa70Xz1M/pLeHeYiFAy/2JOn6+3TjsAtLft2
	MurgDOuY5trJ3cXdyG0EEUHxXcKkmkKQ2kV5zb6WGXTLZ89jEa8bga4eYsfLivYW0evKbBvHjGv
	st3ywoQMVQEuh0QrOliPnr8HZOD3/uX8WwPHUd+HF4xdZW9BZR/vZqM+LiSM8p1Yigt+JEqRG8S
	a4uAxipTfFleytc8xxLK7mr75ETxjGhsXtgXj2CnNFU0pHMali+mTND9dU0oajOpg==
X-Google-Smtp-Source: AGHT+IFChwu/WXFE/Bk1qPbNxzjVEQRH8mYRXcstr2vxeJXZTN7B4PXslngta4OJd71ruXQZuBfYRAqRPI1cCQdkWpQ=
X-Received: by 2002:a17:902:ce09:b0:267:c1ae:8f04 with SMTP id
 d9443c01a7336-269b92f5037mr8368235ad.20.1758221291602; Thu, 18 Sep 2025
 11:48:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918-net-next-mptcp-blackhole-reset-loopback-v1-1-bf5818326639@kernel.org>
In-Reply-To: <20250918-net-next-mptcp-blackhole-reset-loopback-v1-1-bf5818326639@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 18 Sep 2025 11:48:00 -0700
X-Gm-Features: AS18NWBIaYnWg5h64UvvqbyXa3vbYuymfJ8c7oW4xcgcAtF9AXx0O8o97REhA6I
Message-ID: <CAAVpQUCy-xurW6r9oUcDV17fS3wiJsn2QuQ1mQ4k2wXYa6L1RQ@mail.gmail.com>
Subject: Re: [PATCH net-next] mptcp: reset blackhole on success with
 non-loopback ifaces
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 1:51=E2=80=AFAM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> When a first MPTCP connection gets successfully established after a
> blackhole period, 'active_disable_times' was supposed to be reset when
> this connection was done via any non-loopback interfaces.
>
> Unfortunately, the opposite condition was checked: only reset when the
> connection was established via a loopback interface. Fixing this by
> simply looking at the opposite.
>
> This is similar to what is done with TCP FastOpen, see
> tcp_fastopen_active_disable_ofo_check().
>
> This patch is a follow-up of a previous discussion linked to commit
> 893c49a78d9f ("mptcp: Use __sk_dst_get() and dst_dev_rcu() in
> mptcp_active_enable()."), see [1].
>
> Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/4209a283-8822-47bd-95b7-87e96d9b7ea3@kernel=
.org [1]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Note: sending this fix to net-next, similar to commits 108a86c71c93
> ("mptcp: Call dst_release() in mptcp_active_enable().") and 893c49a78d9f
> ("mptcp: Use __sk_dst_get() and dst_dev_rcu() in mptcp_active_enable().")=
.
> Also to avoid conflicts, and because we are close to the merge windows.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks for the followup!


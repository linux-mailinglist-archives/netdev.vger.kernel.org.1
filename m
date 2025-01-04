Return-Path: <netdev+bounces-155140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 955EEA01370
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 09:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DBEC3A3558
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 08:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD3316A959;
	Sat,  4 Jan 2025 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2dZK54Iy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D9614E2E2
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735980970; cv=none; b=ScKYq0ja2SYhuNdwrbykD7sVCQPv5PYfiguZl0ig2vaaK+DWAeBtURw3fxFT+w/8oP9ykJd68z50x8othsx1AYcN1yQhVps7JgzsDIOqrlf4BT/8qDNVAPIYoGYhVqV+kFVzMb63m4kHjIYhHVcfmMv16aLdKO/nMGdWoi3esNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735980970; c=relaxed/simple;
	bh=4Ov0BtcpcIGV112oS5oCxqoXtaFlpvP+W/9zBiFVkHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhozKiy6FjOUQVTKAkZ9x/ut+rg6BJLdkfhri8c+VFm/To1SRaWk5mBJBeW1KNqzGjeY5+JrBcj7ZzneMfhEj7bMu9ASgBSfI++GQqJtbwZi4RoMVEqXQkzHvbqJo+VHrodT7HONaikxkI0ZbAk9E3cMp0+FT1keTZ1OK0RDeQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2dZK54Iy; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d437235769so2900482a12.2
        for <netdev@vger.kernel.org>; Sat, 04 Jan 2025 00:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735980967; x=1736585767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ov0BtcpcIGV112oS5oCxqoXtaFlpvP+W/9zBiFVkHI=;
        b=2dZK54IyWJOQxVuGyaO1jFDma7AKxAtKH87s4QJt2wku6g30K6rXnADuRLbXcEge/l
         1sIiZ4ZehCL0jpVHgeEwT14WfU3Tu8mJdb+4H6+YKmLyZLNLqpM4jnLu/g9vTJ2ISGgr
         BozkGU2Ybq2yKwKsGsT55mIn/eZjZ7LGSOjVf7mTfBweuMaKYY9zCkz0CDsMC6Kr3gjE
         La8PYsysKqV4ma5H/wTxOZqRWbpBvEFdBM7qKew1c8mUyHSh6LKD7rkHgoL+HxY11QQy
         IAjX4qFk5D23PynSJ6soWffNXnTpxiCR4f/bMSTuW0KtYZMYUV8BsEBK/UEL0PgsFRBq
         hrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735980967; x=1736585767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Ov0BtcpcIGV112oS5oCxqoXtaFlpvP+W/9zBiFVkHI=;
        b=G9jUMe+npUiFDNhHTYGSnDE2nZyJe+qCzHpiP3XVAF2CQnTNqrJojie5ZI21FmaEE5
         Ps7v7AernmTlWs3yLy1ApTTIOhFSI/3ZdYAT9y8jdvRueSBI6l67WOPGXbxSztE/RS8q
         hX5WByYxcVGLNI4BqkqWoBt/rg5AIT65+GL3wNTXIq1Sc4qHi47GAI3kp2QBRaRl080h
         uOTxrZEMLoraw1nPj4s/vqAJgyhpcTaSolDUHHzPAuwcWHJnBKzXdIVUBz1/Oam4d1za
         Cz/JSZtBkzgowSMu45iYvj7vMf/mzC+eQivQGkH2ocaU8R8tQlfNu9Omh3kLKbM6gnVC
         zyUg==
X-Forwarded-Encrypted: i=1; AJvYcCX/cPj19EMzLpzpMWNwOn5HuKnNHpMoYzFyDdIZW6cJOW+Wkbw0VaqGRKiNqtYg3zjiH/BOyJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRmt58OY+/40htzrPuZojT1JlGOHTtZnPnlivWazp9IiYgBOEr
	w0k4YEOkvwLRb4wFhulyiJbCJgFYzz+7JlB5OxOpV+zHkdhBAC+dCy1vvRENAaQiGxbJALLTEn+
	/CA8kVF4mwDudEdjDK33xA8PtBbCYsHHf87JJ
X-Gm-Gg: ASbGncvKAbo2Sx6AhRyyT4V0+LLExAnkEH1kUIoyYcUM6rW/HMpLnWtTvbSdGNIvTcr
	Rh9eRzsRwAP7T/+R6/w7QIVpi73GHzqYsX73QFco=
X-Google-Smtp-Source: AGHT+IH9THseuhlZ114iMqub2GR1cm6zsKU06tiVDhwLJf5f6+y9pq2dvKekYzxRlkArc8l5NBtfl6eQuvLqhhdRVpY=
X-Received: by 2002:a05:6402:35c2:b0:5cf:c33c:34cf with SMTP id
 4fb4d7f45d1cf-5d81dd99557mr41386765a12.15.1735980967278; Sat, 04 Jan 2025
 00:56:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250104082149.48493-1-kuniyu@amazon.com> <20250104082149.48493-2-kuniyu@amazon.com>
In-Reply-To: <20250104082149.48493-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 4 Jan 2025 09:55:56 +0100
Message-ID: <CANn89iL2=JBL5YrrEHLUUF3BEDeERH5rSN5GVv98UiX+voJGNg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/2] rtnetlink: Add rtnl_net_lock_killable().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 4, 2025 at 9:22=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> rtnl_lock_killable() is used only in register_netdev()
> and will be converted to per-netns RTNL.
>
> Let's unexport it and add the corresponding helper.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>


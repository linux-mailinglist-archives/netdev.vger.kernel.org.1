Return-Path: <netdev+bounces-209015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB1DB0DFEC
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF258542E34
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741812EBDDB;
	Tue, 22 Jul 2025 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uks0FgcT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC822DEA8D
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196543; cv=none; b=krC+Jrl5X8VBg58Vki46OGIR1667+G4ljzLPlXqpk3ckbMzo0SEKjoEuxthRH8cYnlcEgQuaLqh0hcA8hIiexH3JO9aah7AnFcTsDZXHfe8XRaTs3dZldMx1rvX0g3qK6egWP3yKs97XHrCH1EZxPB54b9Vr+TLW/N1onRw4T4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196543; c=relaxed/simple;
	bh=umAjpYj5j2Nm68r3Iyqwfyn5wdRoOmNs41221wlvsuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oTGJ+8b4OPoOLXkWTZcPTPd/cy+REsBE3cx9l7/v7LFDat+0VFDktjdXxkmKdfC1pP7siz657dM/h4fVOVFlvv6bB1X+urp6NSZ3Xz9+4AFCV06Kv0JRs2MbiEtlVMXJFjXcwqjcyBsS9FzYJFRdLUFNyJiFqzvl5tq2frsEjyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uks0FgcT; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ab380b8851so48284981cf.2
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 08:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753196541; x=1753801341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umAjpYj5j2Nm68r3Iyqwfyn5wdRoOmNs41221wlvsuw=;
        b=Uks0FgcTKWuZlIqUR95DWuVvfXVZNeC38/s7vc5vpulSpNb8NKuS1SdxbZVuU5PcP5
         ubehsfdOOZHMwChwQVHwPkqpqR6RNi+uUKOGgbsYFmlmFONs01ROcpBme7W1wWvmmNpf
         zxJ/CByYe5c2NOlMeT+XS7t+QlLA7rFUSFb/YGBcMyLgbrOchDqff7JXFOMpFyHw+pEY
         cUpjuDLv7hrYQNQvJbJcMvzhXBF8kcFz5DSiutfBXej8PAv9z3Tk2gXv+j7NIdMzl7ck
         AzTbSNXAnjRukJtQ+mmaEiq0wncPYtGLgQGkLxiHct67gJBbERdwxfjXCVIM991C1UnL
         uVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753196541; x=1753801341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umAjpYj5j2Nm68r3Iyqwfyn5wdRoOmNs41221wlvsuw=;
        b=j94vCZ94eWNuNHfqtudlckhaJLAuJy3HgfkxdaHf1l5Qts3Lyqjeb+N51Chq077Dra
         0cJVeBwhg8WLQCKBG/gvcEsxEyvPBG/ngR5zrcjGh3YXiwYZGHVKmYG+YijqxJdeh/9B
         2qhSypc3HKRFkU4GszwzeMMYtJ75c0I8pf6GjCi/vPN0Eo3sIxSLpG1nLQJ3goucFtgO
         M1I+TkCl4Uyy/8/moVI1LkAFW4Q6Aafu3NhJ9zoOlTFpFaK510Bi6W1Qvap4wHX39DWy
         FZGvkObk/vC3Rs28Q+JJW7DFW1QP28TH9paQ6oLCvL+O55/KagjAoa0zUsdwn6j87DQi
         cRnw==
X-Forwarded-Encrypted: i=1; AJvYcCVi40RxqooLNHpx3Sddgf5DzMFzLjwsCSngfAI7EhOj1vcojgTqnAhKjmHTNtX2Tn0y8PghAOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPmDZQFiBoeeuUamMTPdKxznOTi5V4BDGcFWo6gGhQCYlKd8IQ
	yxA9UU7qG4J72LpZfFjdSu5OkakT3pJxB2VJ6FsA15nw5XFfXYjcYQPVLEMkekgO/GU6a3FxmtE
	A/jmYjUFiddpglEagYvbXI6aVuuTmUEGji8pwB6jp
X-Gm-Gg: ASbGncuX4rbHcp4I/j7oD//bYKrFVKJrK56CfkVtB8EYy12NWJ94Qtc4LiQryL2p0DJ
	9wUNj0rohI+CXwp44+n38oIfcfgfYXLUdFu0BJUQphIH0awOmei+KknLq1gUltSlk8z0ztr0ZO1
	fpcdysPMuaJb1Yh8//+h4n/gomDzqBEYBG9D5LwI3PmH1LFobfQUa5Kdly51+6llTwzCcMhqCYU
	L2UMg==
X-Google-Smtp-Source: AGHT+IHatyO88FKjpHrkC5ZRrOvMvJcUcR//80j43PsSX5i96Xgq4GOLULMpeJdluQDo1lBmfvGH9r94q7sH87FUvUI=
X-Received: by 2002:ac8:7f13:0:b0:4ab:b02e:8c24 with SMTP id
 d75a77b69052e-4abb02e8cffmr222175891cf.9.1753196540172; Tue, 22 Jul 2025
 08:02:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-13-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-13-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 08:02:08 -0700
X-Gm-Features: Ac12FXwnxSRbbL9Frp0VNEdNEKZjMoYAXFHNjGRRYDkATQpDHC00xX2ThpLs5IY
Message-ID: <CANn89iJk3B57ytDOEL8YpQj5K-LacKS0v1ANgLi5+cZr5gqTyQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 12/13] net-memcg: Store memcg->socket_isolated
 in sk->sk_memcg.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 1:36=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> memcg->socket_isolated can change at any time, so we must
> snapshot the value for each socket to ensure consistency.
>
> Given sk->sk_memcg can be accessed in the fast path, it would
> be preferable to place the flag field in the same cache line
> as sk->sk_memcg.
>
> However, struct sock does not have such a 1-byte hole.
>
> Let's store the flag in the lowest bit of sk->sk_memcg and
> add a helper to check the bit.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>


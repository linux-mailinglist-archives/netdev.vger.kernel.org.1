Return-Path: <netdev+bounces-238682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C29D0C5D84E
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 15:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC0224F3F5E
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 14:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1C23218D8;
	Fri, 14 Nov 2025 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K6ARRQ22"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A331A9F90
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763129360; cv=none; b=Zjud0BWa+R8AsvetNJBZ3nv0rv5bFj1pDwXAVNhvOPB16kpva3LUJOheuDaUA672iSlgbMqDZnoQg66hLrADB50/cBtrNb7sRciGsw8HX9lpSMWZwoFs65Qeu8d/Lth80FIvsx6c1up43r1KGhpAQvOuAyZxwBP4lVrz4RyxKQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763129360; c=relaxed/simple;
	bh=l7S+z9OGzV8JkeDhr5VlIlGqOX9v1fKRr5/lT4OLb6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdOLyQLEdvww0YDnwBFpq23NJ42dqYK9OwnInEcxTHAVJyuaqKIvgo8lsjmqU95ZMYOHTDMVaHMfDiBHshU42ja4Qjywc9wALGrc/yJSlG7FypM+HH9RAcBdr0Pma/BIndwMtfYH0TM+51tRuEM7Tep+SAbrVNF3Bjx6EY8/c0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K6ARRQ22; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b29ff9d18cso207336185a.3
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 06:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763129351; x=1763734151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7S+z9OGzV8JkeDhr5VlIlGqOX9v1fKRr5/lT4OLb6E=;
        b=K6ARRQ22LgHDb+LlR7YIIzMltri+ZUXVmvPOqbfNHCqcrq4gVhRucsGDOGYo97U32A
         XbbCA7+q3BN7oOxoWhmkcvdAZj2L8mydG1SU0AxD5N9W4WfFZBqgnL54aQqAg/lep4UN
         RScH15UUOeHazi4LHELDyWut9/O2fj/6QdkxZkBnEhhVBXWcsI5hdIqANpZ7/kpSkbzk
         eiDlmsVO0gTpCpvKlBVliYwCALZX8cM9itF7aGTHBURaMmHsM8YGgATGLXvwDy0IePf/
         Ea/z+vKiYOwoWrYakkvWRDcVeUPlns35uKpFvNBrEAfpa8NYeMT1dATtG2J9n3wL0X9W
         kAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763129351; x=1763734151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l7S+z9OGzV8JkeDhr5VlIlGqOX9v1fKRr5/lT4OLb6E=;
        b=APkdkvKTYuZEsUqZwdijCFQW/pw6Yn4H9a5qH4C2LMYASeaPajjGJ7FzXGconyZp9P
         s/Vocn6Qt1olNPD5yiyloQ6O6lohqPnrZh8QT/ZFkXQ5oT5ztqlS1mBjxMpwmlCcgjd7
         +cgwtqaNhsvLOcv8miMw4qnAg/ibM3BrHY8fYxZgV+G2qY+Q3D3+Nr8PePJ/h8cff5Tx
         o3ZtNDqbO9adYd8hJA9qizhyIsMTWWw6X1dgaTUnsw8pmcS5WtzUfqbkgu7PVrlu8WVo
         7nF6WJ9m/iVwKv/WYCWf5mclG7m8vR7VmQyBeO4HbfGeKTQgEWvvem1aT3IYEXE3EO37
         7YNg==
X-Forwarded-Encrypted: i=1; AJvYcCVvM5uMPYb34LVMm0/zLudPdgq18uu/CU8qsDQXr564yym7d3eR951QpFaQG7ZkejD6loyZZ8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz+MjEtqc/z9EScK8aH6IXe8KqrsEE9TjyLDcmBXMKPlRYFUO1
	BwRv6FKXR7PT/jUcbO8R+a5s5DdhW97tqoHRWbvbNuy4TK3wS+sue8i8GiqmWHG4Dxe20huVeV1
	1OALWipOHtNWo/uuB82SJOI6uBavI1Ri1oSu1OjWh
X-Gm-Gg: ASbGnctBegOemp+QVDZvYkxEEGB7Ts4pOpCdtZpIydwll+fK6FyehZ9TmW+Obxsk+wd
	UerWEUT5+40RNxnEEi1opKP/E1xwISit8skP8RoSbEZNUL8p06cm+W/5rOuJU4rd+u7wrbaFyQt
	sUJm0RE6oFSTcV0An1tIBHVUVZZoTZ099RycyOiq/lI9FG0fMrZO7det6nRegAdd96PmdM5mLli
	Vy91mkmvMq0M3UsmCCLGDU/drxbi+gJklJJb179bEhm7pWf9yZrNTRs4DTLaIzpMPs6s3Y72rj+
	28+ojaeI6Oo0EiVt9kFollwTeArKwxj4FeDKn38b
X-Google-Smtp-Source: AGHT+IEyMWo3p2rNYdIM8b5IwedkDBiK0V+1Ty1RREd57iOvGPe9U8YoC7ppMT6Y+MXsbb0RG//TUW7F4Llg1PbPz04=
X-Received: by 2002:a05:622a:95:b0:4ed:b55b:6743 with SMTP id
 d75a77b69052e-4edf214ec04mr52739361cf.56.1763129350809; Fri, 14 Nov 2025
 06:09:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114135141.3810964-1-edumazet@google.com>
In-Reply-To: <20251114135141.3810964-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 14 Nov 2025 06:08:58 -0800
X-Gm-Features: AWmQ_bljx7FR0km3FM5wjj9XVLB_yImE-5sYGVDIQ7kzHjo5C3bppoMECEVdci0
Message-ID: <CANn89iLp_7voEq8SryQXUFhDDTPaRosryNtHersRD6RM49Kh0g@mail.gmail.com>
Subject: Re: [PATCH net] tcp: reduce tcp_comp_sack_slack_ns default value to
 10 usec
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 5:51=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> net.ipv4.tcp_comp_sack_slack_ns current default value is too high.
>
> When a flow has many drops (1 % or more), and small RTT, adding 100 usec
> before sending SACK stalls the sender relying on getting SACK
> fast enough to keep the pipe busy.
>
> Decrease the default to 10 usec.
>
> This is orthogonal to Congestion Control heuristics to determine
> if drops are caused by congestion or not.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

This was meant for net-next, but applying this to net tree should be
fine as well.

No need for backports though.


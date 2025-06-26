Return-Path: <netdev+bounces-201620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0029EAEA140
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A6D33AE884
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A9F2EB5B9;
	Thu, 26 Jun 2025 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xeBLbF5/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598DC2E7181
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 14:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949189; cv=none; b=bJYMEkla81eG+YXDVbi5gkV4ZAPvl6DWTTI0HCVIHoRGOqkTHsbINUu4XlEnc25kZA7iIKrc4PDne4XzozDNfXybQwKhR0TbrvPy3qzkKzBTIVDTMcIg82OjLIiROAx5r8bNTUYT9GqRPq2WeF3A9+DmZ43AKSVrZWUQk0I9oo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949189; c=relaxed/simple;
	bh=Cw6x/a2X2y1/4wocqjsOrUZnoL0vCjBGQvSjYkMpUVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kv05MOHzS4VM8TqpboHJVn/JixcT+gDSBiULs/PofLrqAwWM6XlHINydGLCuQcoc+tMeT38jRSA7BV+YNWzLQc8cf1fvD9GyAIGEPc5DxxglGVdNm8RDtVMuPTvnJV6uaTaFYZLAMgrsbra7acX6YJ1ldmeLe8jn+QTwFFYO1oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xeBLbF5/; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7d38d562a55so131090785a.2
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750949187; x=1751553987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cw6x/a2X2y1/4wocqjsOrUZnoL0vCjBGQvSjYkMpUVc=;
        b=xeBLbF5/M+7+AvNJzter9ts2CZmINSAVDhLcWBzokWaZG+eeH5GIYw1p+Dnk3QI8QD
         Qd0xiUW27GiUDw62bby/5aGIzh+6lA4qhDKkiyMCEF03lWUkl/KSZHKGCtpzhoa9h+BG
         SR9UM1vdpNcFndIb6xVdkhL91q/q9tXFpWQkBFUx3ZYRMaOjt56DlWQ85BzvT6OsBkMv
         Ax7bbjnIyR2u6EY3CSAi+CWwoD4p3WOsfnZut3N13eZ8+KH35wtrdXVtnpvaFs1rVT9y
         QHKq2ShFVHwaWEuDpVe8IzaQ8vAU4Xkeb4OXKEhXF9mRVWkRSq9THnEyf0KFXlRlKlkO
         NXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750949187; x=1751553987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cw6x/a2X2y1/4wocqjsOrUZnoL0vCjBGQvSjYkMpUVc=;
        b=Tnh8E+pOwXLqNkF2sxQKSTlbx3BnzS/HQxAfA8j0q2kj0OkhUZAYGusAX2IAbaRx0+
         gj+6BjC2GDbrJu3aaCxKQbRMsAba48NNaLk9CjlSnjwGZUGNkDS5rG0Qf/NR7dOQSRFj
         2GNWjERYq74dyHwVafAgATkxuCxKrKcbA2aBN64hy8B/H8AsTGEasUA66yCdI6SlRksN
         2SdiUVyEJ/qa5SKGLL3Uc8a/g1aFIbeUeOuxD/GVRO4eSd8kiahoZFsPqE1M0QpxYNQD
         PnTTST2/zs63t6EnoutlAARWBwKOAnaha2hH4XHmH6ooVEKuAUETJJTpOiUthM60cb7r
         uDIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv/V3sLgNFRlIEya2VvLVmADInTOM54Wxq31wcr5zZ/auouRPRxIVrHoZoP76WfhEkl0q25Jc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/E524+XSbPNYO8XAxcTuAcFKXAY2yOERlUeWa5tdcjukPHnf/
	d8fgLeF8enMx5WiHBqfhEPQL4s8OqFIHS+AtFw+vNDIpf1L06CVO4Ad4k4Xj/UK+hbtnnDf6dGG
	JbmkkucB+WZRThgLZGEA9fTGkR4ibwRCJTHxTNkjB
X-Gm-Gg: ASbGnct/aigU0M1i26cCYuI4kh3xHHEZR4QNei5VcuWPSjHNdidZecW4mkSV8UKYR+d
	EAKjH0D1/+Z+h3nEnhKh7TVjQ5mE0BbQIl7sYnWmIOwrhewEluTJzZQv/qPiitXZ8UVQwT7jcAz
	F580Czt85FThPb4s1g9dIB3AkzUxwUD0QsxFNZVOpESS8=
X-Google-Smtp-Source: AGHT+IGR2rt063M279ZAfLwE4jVglVq/GXMFZQHqoRlkc/MRbT5QchE3p5WlVJ87GhLKdT79h7/p4NDtc0gf935Gc0s=
X-Received: by 2002:a05:620a:450c:b0:7d3:a6d1:b66f with SMTP id
 af79cd13be357-7d42974c6f9mr1221226385a.47.1750949186270; Thu, 26 Jun 2025
 07:46:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624202616.526600-1-kuni1840@gmail.com> <20250624202616.526600-12-kuni1840@gmail.com>
In-Reply-To: <20250624202616.526600-12-kuni1840@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Jun 2025 07:46:14 -0700
X-Gm-Features: Ac12FXxxCG3JXDT9Rgi-QeodJDf_GuCVQtNt6u8yD0cDLJljRlsndU0y7Oqhg0g
Message-ID: <CANn89iLs3iGM6E0GummYY2ZoQgqEbAamO6=ff1wk54GgodCX+w@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 11/15] ipv6: anycast: Don't use rtnl_dereference().
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 1:26=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gmail.c=
om> wrote:
>
> From: Kuniyuki Iwashima <kuniyu@google.com>
>
> inet6_dev->ac_list is protected by inet6_dev->lock, so rtnl_dereference()
> is a bit rough annotation.
>
> As done in mcast.c, we can use ac_dereference() that checks if
> inet6_dev->lock is held.
>
> Let's replace rtnl_dereference() with a new helper ac_dereference().
>
> Note that now addrconf_join_solict() / addrconf_leave_solict() in
> __ipv6_dev_ac_inc() / __ipv6_dev_ac_dec() does not need RTNL, so we
> can remove ASSERT_RTNL() there.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>


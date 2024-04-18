Return-Path: <netdev+bounces-89269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6C28A9E59
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 17:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28644281E85
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B92216C69B;
	Thu, 18 Apr 2024 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="fhcbi2hT"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C316D15F321
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713454162; cv=none; b=BdW3ghrjCl2qcziAL/i3tN18tqqb3LW66VheGigA5w43n3GSzIeeVlrufsXlK7j+VdRiBx3O0XPYkQLWAy+/JJtceuMzikU09xvzYKCZBbpCmLYcCfUhyx9q/SCisdSOrieQV+i1WV95NjEjNLteVPw/e/2FPKfM9lMFuBEyjLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713454162; c=relaxed/simple;
	bh=KyjGWQMlbnn+Ej1p8+gQ5cZzOsblKSVT/vQUqS7vEW4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p0mOHSKnwBiXDiUj7L1U+8xgrUJFcNhfQUaE9/6NgRKcDqwaf55UnnS8Cg0TV12MHZImwB0dk1gOv5aiYXy8pTkTW+Kc6LKog/7OEFyG2F6AxqX8HdBTJ7cyfbNzxwLKjWbnU1wLye9gwoKhoJbpC1RF+JDEUPN5sgZymLiHwto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=fhcbi2hT; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1713453605; bh=KyjGWQMlbnn+Ej1p8+gQ5cZzOsblKSVT/vQUqS7vEW4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fhcbi2hTYBYljFfoogK71cpPjg1LkU5YEF2jLRZ2unzPR36x/ZNyim0VOsIs7y1Pl
	 wsLfYppUkxdPOrFMERMk7DuzlXSNGdB4c8cwGuEAN7YQdD/SC5UiZpIjOeRtX51L6Z
	 CbdkO4m9sCvoPHqldIAuQfaiQTvkmxkJleYxFqiqTQiq7q1SEVVIXvNVuAGwAmh0X5
	 vnRRDJRKdywDhD4ycPw1CvW5OJ+NxT4VcWQksIF9WxLij8bwjW8I5kWTPukNxvPvup
	 ikXdi6cokjAC3qwoLT6bOL6ClZeOxsvC3jeXbRWIFEYGbdIwYMca14+xcSWi9Epe5w
	 uW7TePmGY+6NQ==
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Simon Horman <horms@kernel.org>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, Eric Dumazet
 <edumazet@google.com>
Subject: Re: [PATCH v2 net-next 02/14] net_sched: cake: implement lockless
 cake_dump()
In-Reply-To: <20240418073248.2952954-3-edumazet@google.com>
References: <20240418073248.2952954-1-edumazet@google.com>
 <20240418073248.2952954-3-edumazet@google.com>
Date: Thu, 18 Apr 2024 17:20:05 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87h6fyu28q.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> Instead of relying on RTNL, cake_dump() can use READ_ONCE()
> annotations, paired with WRITE_ONCE() ones in cake_change().
>
> v2: addressed Simon feedback in V1: https://lore.kernel.org/netdev/202404=
17083549.GA3846178@kernel.org/
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>


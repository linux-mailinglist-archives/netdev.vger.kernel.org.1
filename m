Return-Path: <netdev+bounces-134230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7804A998755
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD33DB2469C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581FF1C9DD3;
	Thu, 10 Oct 2024 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lG32C6ZB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88EF1C9DCB
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 13:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728566130; cv=none; b=u/mBKlv3yNCyhOs52mP/r2pvCt6id7fWkTTgPxwUItZzdkONgQGDBef1Rde33A2N4AZbq+SxEmDzW2i6NYoCdDhEMq1cDrTuGRBGeqBpejDp+varlBjwYlXrz1UQxjWc7bTMcjnU5FC/jEiRgYQVcBi6dPcYanTC3bbOQGZLx88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728566130; c=relaxed/simple;
	bh=zKm0s87YxDGUwOyrpRBNwVkOgzJN1WpIj1ZuF3o1pqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YWLIu6/KnumZ8J9qmay1pZ7NVLG8OcHibxrb9B//AJAh0N6q1sjYp0LYrW9U5IHukwlBSPqrHgx2hvb96+hc+4DoRaSwudOn/1241BMZQDHkZhs085X/NzjsUofrszgIMpDaU8h35NCCpV21XzTMG2z89pQTOiGxa5BsIQw8usg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lG32C6ZB; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c920611a86so1138683a12.0
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 06:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728566126; x=1729170926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKm0s87YxDGUwOyrpRBNwVkOgzJN1WpIj1ZuF3o1pqw=;
        b=lG32C6ZBJZDnm/tz8YsBYLDpmqDhnnvE6y3YeaNOTVxjolwerW+EUQk3+lXjJuL5b5
         KdItrz0eR8Cck703DPGNKfBcz5AtxF7KRLsz1tVO2cmGY9pYn/QRFTz2IkNyA4kWGVJE
         EdliPILfWgD/+1Qf19ZK/prU1MRQcMo8+9CiWKiHmXNsfzp5nanliBz/EI73xhXraE5p
         C8RZv323NPuTb7FOidPCNADKWzYltlRW5tPr5hmRBChfa0G8kUg0lEw+t9GBUx0ukqH8
         t+j0MYKr0LvzGpLAcfPUbPpPT9JUl3YEG/ihhZqnxFVfkbNu0MknYIQlCInMSveHPINX
         22sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728566126; x=1729170926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKm0s87YxDGUwOyrpRBNwVkOgzJN1WpIj1ZuF3o1pqw=;
        b=oOF1rURq7rr+Wnb3/cVFruP+F5R9uqn0357ZElNSsuT0+DINgycwYQaCjWBMFMjzwT
         8NYjKI1atMJ2NAW+Q6hZUVQBwDGYJl9IdpHIaWx/NXDTTQFZtHT1II2k9rRnEYbcLY1y
         I8QVjxPBWYwFvqAurhFX8TSNAFBKI7mFyYtQipSpdjFaKrZ5TX2FoB7hd+UDwPbAxWvc
         NPJw/JTpn8aMmS1S0fGOxurGzo3cs9exF6frfeVUlznkmT5xZsSiyRgspMDDjH2mZxVY
         fYS/ZNmyiUNstwzSDgvsHV2gLqeEwb4n2GUElk6BsTJ/DDovGfUKPNIF09L5BNoQ7+nh
         XZ7A==
X-Forwarded-Encrypted: i=1; AJvYcCWrut2GFw+HDS2hr0VoUEtbSaEwE8Jtv7fwpSZAOa3IQF0boMUd18XurXCWUthFSqnly2sn6KA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQwvpDOtg6l8nwq+jW9ae06wJXzyUJu1RvZPDWwbClP/VzyIzl
	FZjdLud4RPU20xfUZt9QZBQQ0PgoD7vn1ffL0/noRaCfZSQbuYHCbrvh4pALEQtnng9Shk4Mm/2
	Zxv79d3fIhqpc0pdU5OntjvitvK54iVha/SkK
X-Google-Smtp-Source: AGHT+IHTOxdPIeJAjY2f7Lx4oe8SXx+rOyz4SGr5Qt/odla08IK8FSqHcP66BO0u6XOeiidGdyHQYPHoUjBK9v4ndWQ=
X-Received: by 2002:a05:6402:1d4a:b0:5c8:9459:b9f1 with SMTP id
 4fb4d7f45d1cf-5c91d59c15emr4244319a12.13.1728566125602; Thu, 10 Oct 2024
 06:15:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009231656.57830-1-kuniyu@amazon.com> <20241009231656.57830-13-kuniyu@amazon.com>
In-Reply-To: <20241009231656.57830-13-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 15:15:14 +0200
Message-ID: <CANn89iKw8RY+_ULTBf=Ksnw5cJ93jToJ6eAoyHUY-1EmP5qV_Q@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 12/13] rtnetlink: Call rtnl_link_get_net_capable()
 in do_setlink().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:21=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> We will push RTNL down to rtnl_setlink().
>
> RTM_SETLINK could call rtnl_link_get_net_capable() in do_setlink()
> to move a dev to a new netns, but the netns needs to be fetched before
> holding rtnl_net_lock().
>
> Let's move it to rtnl_setlink() and pass the netns to do_setlink().
>
> Now, RTM_NEWLINK paths (rtnl_changelink() and rtnl_group_changelink())
> can pass the prefetched netns to do_setlink().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>


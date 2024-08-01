Return-Path: <netdev+bounces-115138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC6D9454AB
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 00:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C529E1C22C88
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 22:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2616014BFBF;
	Thu,  1 Aug 2024 22:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/QYKaR1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42171D696;
	Thu,  1 Aug 2024 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722552693; cv=none; b=vAY5dV8j69KCouDFYLwKAqxF9YH6pqo47u5DH3k2vVNHHM+Xc89wmXeFEW7XWh3sFNk4LDNJqamHvgHf2o10xhxB5dIgwT6mCDAopJRYSaLWf8UkcVUEQZwvAjzBVijpIeXFjYGc7glRhQ0icQmDfj6LPS61YK8491m3EW2dV7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722552693; c=relaxed/simple;
	bh=naBe7n9SWJKcD3/+j3xRwKxcVyO8dX0yhYhJsoGkREM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URBP9pCC9LVyRKTGcnA3jTfGX/IdGqen7u2Tkam1jgepSZLZu19zytfbx0Lyf7INuxSri2E0UMPAyUkbfy4iM6KL8FS/jYURoz+yNxdvuxNo1n1ibk+GaKIDVS5OjPDaNjMhGJLN9dSI48Mlj4C5AK9MclxdWhHHD0qJOn7VDBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/QYKaR1; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2cb5e0b020eso5768656a91.2;
        Thu, 01 Aug 2024 15:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722552691; x=1723157491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e19UYp+ljud6ZcskAvvX1iEQ4cPZmGuXxIiRolrtGhQ=;
        b=d/QYKaR1xrcj0jS3LU9mCoyBSwGYVmIdX0YJ245RLFmPjzNKMlTgLKOUlYpMIoZTU8
         fQ9IFvqF4YYmbEWJKRF+VvUIc/iMPUaVjSUlZtl//aHIFQ8zkTzwjZ9huabdB9H93TyN
         NiCIVFouygxcaHXOi6tgOb10E3nLnM8hEzIlA3zWdH4ZlvgYSCUbsqYh+2rc2zvtBpPV
         4eHym8a/OmrfNzbppcPsEh7N06wmxTEgqm7ZBL7yQmq1my5PDwTbPrG8OztwebaiBlNd
         1reZJDeoMoIlAIUVgq2cIGKosze4GNg71NI5B8w+nSKJC4jO7gGtCr/pizJuA05enAJZ
         yc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722552691; x=1723157491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e19UYp+ljud6ZcskAvvX1iEQ4cPZmGuXxIiRolrtGhQ=;
        b=I/QKfB+4zpbcxbWUU0QCJoswOxemWYPbei1eJZfLVyeKTECEFnkTPFinv0jDcAkGp/
         CzpNMxCg4THME2GxFPefoAhe5wQzKKN43VIve7hKMeLYLTPqTC/irjeaQzyoleKfu+UK
         /UEQyjruxTL2Sbno2yOA0T/nzao794RwgZ26m4kCoPTKPhl7yR/hriKIIK93wsZW8azr
         KgfybjqlCOU30G3zEBHTKhjU6klBLBW6Y1WYM8jVwxkb5hjxg83LBqOip2OiqmCkV1yb
         Xuw+uueS3L9aOjz+lsk5jx1A8KA9T+OBGThhzU7hB4ARgYK+4oBa4MC/9IF/JJgAN3Ku
         SBwg==
X-Forwarded-Encrypted: i=1; AJvYcCWzmzbyc9qVGAtJzrxLE/LJVFtBiVNqIsEiayx38GD4l0zt1USnDQKcCYZIO9oTQqdmKQQl7ILztDZLlDeq/yJ6zq+E65NibdFydvkPA57z6NarCpOQisBatYrfZvbx2FY0xooe
X-Gm-Message-State: AOJu0Yz2h0mX0GhKIgqP2Offl9GmfU3nNfH9c5ZHsbI9T7F7wgHYRZqW
	Yehx82HRxKA3qeEuLx4lfJDvQ9YyzLSrZ3zZsvzLe5Ynz6UfprTNxcYTi2iYLhMWbxIT8iG8ihf
	VmXaeno2+7YomULMXyRvT0E5KgoM=
X-Google-Smtp-Source: AGHT+IHj+u6/jrC8H8jYf5x0OWqnjFHLFuNJN2Tbq5H4mnsv8oxnqHcVitBFze1pwXVeMgljA8ptmmrXdabe+KfrNZs=
X-Received: by 2002:a17:90b:4a08:b0:2c9:9fcd:aa51 with SMTP id
 98e67ed59e1d1-2cff9419a1fmr2105089a91.5.1722552690859; Thu, 01 Aug 2024
 15:51:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801111842.50031-1-aha310510@gmail.com> <20240801072842.69b0cc57@kernel.org>
In-Reply-To: <20240801072842.69b0cc57@kernel.org>
From: Jeongjun Park <aha310510@gmail.com>
Date: Fri, 2 Aug 2024 07:51:19 +0900
Message-ID: <CAO9qdTHJKMzOTRJB_N1VPjh2=Z=qLkpzu8eL5mcAr6hnFfiHXQ@mail.gmail.com>
Subject: Re: [PATCH net] team: fix possible deadlock in team_port_change_check
To: Jakub Kicinski <kuba@kernel.org>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Jakub Kicinski wrote:
>
> On Thu,  1 Aug 2024 20:18:42 +0900 Jeongjun Park wrote:
> >       struct team *team = port->team;
> > +     bool flag = true;
> >
> > -     mutex_lock(&team->lock);
> > +     if (mutex_is_locked(&team->lock)){
> > +             unsigned long owner, curr = (unsigned long)current;
> > +             owner = atomic_long_read(&team->lock.owner);
> > +             if (owner != curr)
> > +                     mutex_lock(&team->lock);
> > +             else
> > +                     flag = false;
> > +     }
> > +     else{
> > +             mutex_lock(&team->lock);
> > +     }
> >       __team_port_change_check(port, linkup);
> > -     mutex_unlock(&team->lock);
> > +     if (flag)
> > +             mutex_unlock(&team->lock);
>
> You didn't even run this thru checkpatch, let alone the fact that its
> reimplementing nested locks (or trying to) :(
>
> Some of the syzbot reports are not fixed because they are either hard
> or because there is a long standing disagreement on how to solve them.
> Please keep that in mind.

Okay, but I have a question. Is it true that team devices can also be
protected through rtnl? As far as I know, rtnl only protects net_device,
so I didn't think about removing the lock for team->lock.

Regards,
Jeongjun Park


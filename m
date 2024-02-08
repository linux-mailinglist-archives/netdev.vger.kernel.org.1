Return-Path: <netdev+bounces-70342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F403D84E71A
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 18:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3AD1C243FE
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 17:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BF985C60;
	Thu,  8 Feb 2024 17:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wpwXr4iM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBEE85276
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414578; cv=none; b=bpmyNVbcj8kfWAJGYoeD4CszN1vCu8utp66Yz5K1S5Ck8rCC3zk6wN46I8WTdIDk30pMfmL3AR7AMBZ7nCkBG184JAloaNDHg4tOHWR+mgWpCKnYogZneIsZWTwVjJeqr9ZKvhw+9G3JKcX1Nhhoj62nV57jD2uGg3JDkNAmy8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414578; c=relaxed/simple;
	bh=zda74WXXHe+dpK7C/1O9euGmKfSWLYZHT6inIgr65PI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4ECb9zqK8PEzymC7kFOWk0YtZGbPdKRe+CBFWBm01P4cZvpCr/sCG4z4b7Es2wPmbeKU5BqA+rfO8RiOWv+U0IL+fQ1QaQZP3uGs8erPYYG36GysYTwNXpA6HeBxbRRQlgClG9JK2Qc4tFBVi8fdt1TvCpIvPdQFhi4B2HPrWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wpwXr4iM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40f00adacfeso87045e9.1
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 09:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707414574; x=1708019374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCfiShFFpvtKtiBytNdjmOBh5smtgUcYd0nNspQ9STQ=;
        b=wpwXr4iMM2ZmAY9vuJlWMUTByLGQ09rbhpPMp49OFpUWFuBUEC5n5F4vTyDG5dZxQu
         lXPweZIr2v/bvCTf7MH2XFOGNP+cXL2dO/wXgRTSHacBexo5xadUSqxFq3CJ7nMdAPVS
         NjgIquP28LQLu7YLBJZzdhTNZ2B/k4JgVTS3F6H9Tc6iUG/6i0wIuA3+bbfIHELu0nky
         dSMbIb3CwyEDnqK/aZZMTJH6/YOTkipeOLYEsbQAnVKMyzJGTUliuhyDs4pjGP14BsbC
         15gzd8QflAHc3G5avRvEhONseNY1vLeH7SBeOqPhMqdqYzYLlZxHu44jYCkLywWoDgre
         0mcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707414574; x=1708019374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCfiShFFpvtKtiBytNdjmOBh5smtgUcYd0nNspQ9STQ=;
        b=AUlusRDN9S4liIFhkvBHonJ0OBlZzcwdCsSeXiJTfY0mdKFK/tCMIfs8zPkZPU+Twn
         S6q95+u/5IWQvRYM6fUM00y96aGW9jkcr4OpipmiJXheE45SG/UpzJPQrEKPD4ZFRH29
         EnG/zvx0AxOoADfaGvPwipf7EBo0Gr+38o0R+R9F3oIlmarrPr+ikiWz0Uk0F9zuDKg/
         s3nI2VFsdn82NE/NC8fj/hgU9ur5OMjR2eHvVSJD22MWqClqkBpE5o2s8dPuOxvCTucq
         2xmvMy6xkSz/yEf3R0EKeTCLUjqPRfScDl5RoophXxKQ90/q1mhhdDwPztNfuXrJkUe2
         f41A==
X-Forwarded-Encrypted: i=1; AJvYcCUX7pET72jkM49pUUGHxwILe0rBO/bGmtWREGht27opwfCVZnFP4+r0ccqBNKxWJnW4DdRBauEDZcyng47vYtsEOYo6a3Ce
X-Gm-Message-State: AOJu0YymWu7ddh84r/eVZhmvdmevc9SpjICsEmq2aU16/yc6VK4TCuDy
	Sg9J4S5WDwZEI4IyzSMgVTKoth5YDUefkORsX+OYS8FxxC8/lNtaPUg4CUtAFFHFf6ZYhDoK54R
	0EpSRph7YXxP6bcpc/x2+ph5/yjL+5uD5i5v4
X-Google-Smtp-Source: AGHT+IEstkMTSitlbM4q+eTyETgEQ6arnNpmDwi2H2dhpRlCslml1hPB7df4QjwKC06oN3wleuc+F11zwRfxak+YwIg=
X-Received: by 2002:a05:600c:cc6:b0:410:3ce8:8386 with SMTP id
 fk6-20020a05600c0cc600b004103ce88386mr2420wmb.0.1707414574332; Thu, 08 Feb
 2024 09:49:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205210453.11301-1-jdamato@fastly.com> <20240205210453.11301-4-jdamato@fastly.com>
 <20240207110437.292f7eaf@kernel.org>
In-Reply-To: <20240207110437.292f7eaf@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 8 Feb 2024 18:49:23 +0100
Message-ID: <CANn89iLBROzWjTxr4wFyEuCmBj9zoRkEwMGOLxUAJA683paVSg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/4] eventpoll: Add per-epoll prefer busy poll option
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joe Damato <jdamato@fastly.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, 
	linux-api@vger.kernel.org, brauner@kernel.org, davem@davemloft.net, 
	alexander.duyck@gmail.com, sridhar.samudrala@intel.com, 
	willemdebruijn.kernel@gmail.com, weiwan@google.com, David.Laight@aculab.com, 
	arnd@arndb.de, sdf@google.com, amritha.nambiar@intel.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 8:04=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  5 Feb 2024 21:04:48 +0000 Joe Damato wrote:
> > When using epoll-based busy poll, the prefer_busy_poll option is hardco=
ded
> > to false. Users may want to enable prefer_busy_poll to be used in
> > conjunction with gro_flush_timeout and defer_hard_irqs_count to keep de=
vice
> > IRQs masked.
> >
> > Other busy poll methods allow enabling or disabling prefer busy poll vi=
a
> > SO_PREFER_BUSY_POLL, but epoll-based busy polling uses a hardcoded valu=
e.
> >
> > Fix this edge case by adding support for a per-epoll context
> > prefer_busy_poll option. The default is false, as it was hardcoded befo=
re
> > this change.
>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>


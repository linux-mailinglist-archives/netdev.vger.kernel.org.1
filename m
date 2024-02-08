Return-Path: <netdev+bounces-70392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFABD84EB4E
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 23:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3071F22839
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 22:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB06F4F219;
	Thu,  8 Feb 2024 22:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="S3mpyD9H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF3D4F5EA
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 22:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430216; cv=none; b=J/8V168rGtMYrBpCtHqodNcZRGZV1sF2yf/hQ3odC4ZQFTeNDg/5/ekDSLa1jnVJcKEH9WK7XNw3duMyQKBlMgyWaH96ha6nX7lMK8xmYIa62wb2zmpgbgFmu6lcI9zl4hTJOqK1y1V3bZzkxwHcNEbeZSPMKgSvc4ZYEcSYOCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430216; c=relaxed/simple;
	bh=cIDPeKDb1D6Nxdo3/WB7Z4Qb/tehFQHdNJvHvDA7mlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWg7aTnu8ORm2kT1RLe2++naldaJNqWNnor5j2BSm8xjHWJqQye/cS5+9eT/yLlxoHgCCLgNeeAqvD61nGP/7GLWGAdVFnCODNgmD0q6ufpZ7NlETr8hccvdKyYHGmsHvj+fBv6CzC3Y4CxHKbiQJtT2vjwopLQnYf5HnW95cqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=S3mpyD9H; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6049b3deee8so3766557b3.1
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 14:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1707430213; x=1708035013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eq8iz/pVIEfh06m3jcgvpLtauQXrbptz8sS8cX4N2Tk=;
        b=S3mpyD9HSX2IP6ixJJdypHpupVhp3YtJeELxuFwPQ5OtXph1VeA3kC5K+OhFkol3mk
         icX+g3EigBnyiBcRulD0KDShokm2SpEqjtNfEVn/SsoYyxOwCb0qL3//8ZPSysoVApfO
         a5WR2yIPXuDZ0Yhn/A2yjfiUcRPAuX9X5M44hvF0Zxf1CJslDwpItlMYGR6cesgIhcdp
         X7jq1ZT8o/YPgs0B3Qf4UvKSjBDh2jm8YxgkoJs1Q4SjdR8QV498WBpCB1WPd3/9lMrq
         w/6s/+5PKnuOxdE8HMO9wn6CvXGva0Fy4JNa+pIeI8MmLY+Oa9z6O1vFUjSPRUM+QxX+
         Ae7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707430213; x=1708035013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eq8iz/pVIEfh06m3jcgvpLtauQXrbptz8sS8cX4N2Tk=;
        b=FVttlYwAjiTB+TnXifywmRpeV/iIxeUjhZsseBH1SSJlvIYLJO+qP+9vzCUllnsGyH
         QtGVfPk0oebNsH092FbwT2GtV1Fhgct8JxokRT6QWkMUJaF/h3GYSW3tnCLD80xQ7mbj
         /GDwxfjarHM3yzs/ewAx2gvfvi6XI2l9nbA43cYnGOXLFWujSajBJQUXZVqSQwZbPus1
         dWZODO6fXtUO2pnFO6ryQa6apQyEUUPHtQO0x0PNcFWVcKtt2LOMoFl784XygM9WVv/A
         ZXSGnEY2ykb41yEo4iXCkQjSnfWGL4c6UWu1SaBAjvui2NBABVDkOPH83SziIREiiLyN
         9j+g==
X-Forwarded-Encrypted: i=1; AJvYcCVSUjPC7o03cbWcT9B+ns2Uw7fEzWrlMngFwAIPRKcVeixxSga3+I9xIMQQk9ajmcu9QTtwHne+CkkxdH+z5OqP9co58NGe
X-Gm-Message-State: AOJu0YyAtuR5w7Z6iLlDKqMkAd4f7wNFnF70tVVFNU0Zixf1zoCoB8r6
	UsN1G8CJ4jckMSX5PNvwywmyJ0vim54wSQOV+HcYeRzR3cBywg6o27F4jsQejA16Z0zeC2/UzKP
	fjmaCBi5rqFfBs6tNihmHKDDdBTozVEAD9MjR
X-Google-Smtp-Source: AGHT+IFOTZPclPHlmCWRUIiNbEX/lHCcB02NaSHfE62lAtGR+P0Gx2rcEmf/k+ZEGfaGx7K+PElwMnocQIfChp2nWIU=
X-Received: by 2002:a25:b324:0:b0:dc6:d02b:f913 with SMTP id
 l36-20020a25b324000000b00dc6d02bf913mr872990ybj.22.1707430213193; Thu, 08 Feb
 2024 14:10:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208102508.262907-1-edumazet@google.com>
In-Reply-To: <20240208102508.262907-1-edumazet@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 8 Feb 2024 17:10:01 -0500
Message-ID: <CAM0EoM=5g2ZRDW-mFTKAZ9jC+gWYcwrmGQ6eyC3jTSzd1GVsnA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] net/sched: act_api: speed up netns dismantles
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 5:25=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Adopt the new exit_batch_rtnl() method to avoid extra
> rtnl_lock()//rtnl_unlock() pairs.
>

For the patchset:
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> Eric Dumazet (2):
>   net/sched: act_api: uninline tc_action_net_init() and
>     tc_action_net_exit()
>   net/sched: act_api: use exit_batch_rtnl() method
>
>  include/net/act_api.h      | 34 +++-------------------------------
>  net/sched/act_api.c        | 35 ++++++++++++++++++++++++++++++++---
>  net/sched/act_bpf.c        |  7 ++++---
>  net/sched/act_connmark.c   |  7 ++++---
>  net/sched/act_csum.c       |  7 ++++---
>  net/sched/act_ct.c         |  7 ++++---
>  net/sched/act_ctinfo.c     |  7 ++++---
>  net/sched/act_gact.c       |  7 ++++---
>  net/sched/act_gate.c       |  7 ++++---
>  net/sched/act_ife.c        |  7 ++++---
>  net/sched/act_mirred.c     |  7 ++++---
>  net/sched/act_mpls.c       |  7 ++++---
>  net/sched/act_nat.c        |  7 ++++---
>  net/sched/act_pedit.c      |  7 ++++---
>  net/sched/act_police.c     |  7 ++++---
>  net/sched/act_sample.c     |  7 ++++---
>  net/sched/act_simple.c     |  7 ++++---
>  net/sched/act_skbedit.c    |  7 ++++---
>  net/sched/act_skbmod.c     |  7 ++++---
>  net/sched/act_tunnel_key.c |  7 ++++---
>  net/sched/act_vlan.c       |  7 ++++---
>  21 files changed, 111 insertions(+), 91 deletions(-)
>
> --
> 2.43.0.594.gd9cf4e227d-goog
>


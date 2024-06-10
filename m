Return-Path: <netdev+bounces-102268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165A8902237
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAFF128580B
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 12:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F314811EB;
	Mon, 10 Jun 2024 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u199L6gx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730817FBA1
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 12:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718024378; cv=none; b=DEqYvZb1yoO3TpofSWorztaFmOCI9vZi82hIAFXmaTENqkrfKhWeUDGxAHKMwBxpPy9SeZ63buIZAm++k3sSc8e414eKVsTXubpKpH1RtoBcFr8ZR+YWi8Bb+DvAv6gUh9qydFrXgBMluDlTJR3VQIaqBWSX/HtNeL+jct642V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718024378; c=relaxed/simple;
	bh=0hyJGOwkbmYGmzPiCDh+xgrknTSLDQyNukxD2k3aGRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eVL6dt/EudIdeSJ9XiK4Jn7ercMUfvCMr6l7ZPw/s+syd2tB0pCJePX6mEDtRE5QJXQsqiXch2FqZbl0L1szEYNsMJHAVysjouKdfBkgtR8WDjuYpCQu/Ijsg6Vfq8/4k91ejMsWwpGM9Wm5yEaCf9ok5mpNo9Jr+FiBA5dAikI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u199L6gx; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso18605a12.0
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 05:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718024375; x=1718629175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1O4ihmzFe8L+d884SIxXY59u8X8nKTzh7I1ps56sDEo=;
        b=u199L6gxviHTZmzEM8AZj1sWfNs0Mym4f8fvf/LlwPJVy1AK0KvouVu3huSVD9SQA+
         ob+sR9l4i70H+RQ+bWodCxr7BgL8YbrV2ee5sX/RA0aAFjPSRYL9s218hGXxpzvhbErw
         0VTKgsZhFEYXHQe1sUCG6Drmf2q11YHqWAid5PJSLldRRg3dz9izNFtYvOEgo5aoH65I
         zKGjpRsjzkV3DVL0V7YieQfEM2ibInPUFJ4TIWdo5lS/AGfuC4VBq4BKdROP5egI9rTu
         mSXVwu6v9Vhg+2WdjGidXJVHSdCeb7mvEcLCm2J9VUy1GHn5F+qonNmx/cv5rKxxmFg8
         xABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718024375; x=1718629175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1O4ihmzFe8L+d884SIxXY59u8X8nKTzh7I1ps56sDEo=;
        b=rAv+2bJEpddjHqxp0Us9/SW5/O6V9msjv9QIbSMrRlI0F+XHHkb2rI/v4bpucjUBCL
         Tf2zgEaya80n94P5cBtsRH9qIDY+kWhyz98ZfK7FV8Skmw2SqSl8trNwXlA8ojKyId7g
         GcAONrUITTHTBtcocfFQq6xCsQlKRAfZRw7DZWwL6Yzb0Ld2dyPDxxofvFrRHU3pUUGv
         5QFP2CHslvzqto4zR66kFz1yHrANA51PssEV4IumSg1ZDM1suPwaKTI5xlXCcGUTAmOf
         Ijijwa+u55Ma5btjO+vkpelrRGxBxZRBkBJ4YnTj+NlAlXP2NdQwQbdTdtv/cvjFCwYg
         lh/A==
X-Forwarded-Encrypted: i=1; AJvYcCVV/UrFqitFQXrVaMHLdXB2fHKkEzmwzCEZASMHniUWw9VnJq0W20/zEe9qpi4gHv00+FZp4SNcwEcLS5P0b7i8Nz9cv8Ka
X-Gm-Message-State: AOJu0Ywl/S65mcMDLSfIVue5YS+M7miLAblXcQesoM/ATsBJwnIusjHW
	IGk7OL5Q2IcK9T+ShQU+R7WoFODSsYtolnNOpzPlnlbQzn3XzcN4UViE1VszRikQubTdd2RzC3H
	dW8UPwV6dOXYZOywmIszSZEl660IfjMs1xF2k
X-Google-Smtp-Source: AGHT+IFXYfPsqCxXFS9C1gx8aalh3o2ksG/7ybkgtXy3tBxXiSJRnqeSb2FAUlbQ5afjFdIkFZIoX2UmjaNLjTpo6dw=
X-Received: by 2002:aa7:c98e:0:b0:57c:57b3:6bb3 with SMTP id
 4fb4d7f45d1cf-57c6a8ea8d4mr301135a12.6.1718024374199; Mon, 10 Jun 2024
 05:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222105021.1943116-1-edumazet@google.com> <20240222105021.1943116-7-edumazet@google.com>
 <Zdd0SWlx4wH-sXbe@nanopsycho> <cbbd6e2d-39da-4da3-b239-1248ac8ded10@I-love.SAKURA.ne.jp>
 <628624ea-d815-4866-9711-70d096ea801d@I-love.SAKURA.ne.jp>
In-Reply-To: <628624ea-d815-4866-9711-70d096ea801d@I-love.SAKURA.ne.jp>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Jun 2024 14:59:19 +0200
Message-ID: <CANn89iJ34qOSiy7RFzqML-hSS5beniQCcKqP3nOERXKxt0RB1A@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 06/14] netlink: hold nlk->cb_mutex longer in __netlink_dump_start()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Dmitry Vyukov <dvyukov@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 9, 2024 at 10:29=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2024/06/09 17:17, Tetsuo Handa wrote:
> > Hello.
> >
> > While investigating hung task reports involving rtnl_mutex, I came to
> > suspect that commit b5590270068c ("netlink: hold nlk->cb_mutex longer
> > in __netlink_dump_start()") is buggy, for that commit made only
> > mutex_lock(nlk->cb_mutex) side conditionally. Why don't we need to make
> > mutex_unlock(nlk->cb_mutex) side conditionally?
> >
>
> Sorry for the noise. That commit should be correct, for the caller
> no longer calls mutex_unlock(nlk->cb_mutex).
>
> I'll try a debug printk() patch for linux-next.

I also have a lot of hung task reports as well, but in most reports
the console is flooded
before the crashes.


[  276.515597][    C1] yealink 4-1:36.0: urb_ctl_callback - urb status -71
[  276.522774][    C1] yealink 4-1:36.0: urb_irq_callback - urb status -71
[  276.529566][    C1] yealink 4-1:36.0: unexpected response 0
[  276.535875][    C1] yealink 4-1:36.0: urb_ctl_callback - urb status -71
[  276.543011][    C1] yealink 4-1:36.0: urb_irq_callback - urb status -71
[  276.549951][    C1] yealink 4-1:36.0: unexpected response 0
[  276.556111][    C1] yealink 4-1:36.0: urb_ctl_callback - urb status -71
[  276.563143][    C1] yealink 4-1:36.0: urb_irq_callback - urb status -71
[  276.570382][    C1] yealink 4-1:36.0: unexpected response 0
[  276.576399][    C1] yealink 4-1:36.0: urb_ctl_callback - urb status -71
[  276.584381][    C1] yealink 4-1:36.0: urb_irq_callback - urb status -71
[  276.591617][    C1] yealink 4-1:36.0: unexpected response 0
[  276.597904][    C1] yealink 4-1:36.0: urb_ctl_callback - urb status -71
[  276.605126][    C1] yealink 4-1:36.0: urb_irq_callback - urb status -71
[  276.612153][    C1] yealink 4-1:36.0: unexpected response 0
[  276.618588][    C1] yealink 4-1:36.0: urb_ctl_callback - urb status -71
[  276.626153][    C1] yealink 4-1:36.0: urb_irq_callback - urb status -71
[  276.631595][   T30] INFO: task dhcpcd:4749 blocked for more than 143 sec=
onds.
[  276.633015][    C1] yealink 4-1:36.0: unexpected response 0
[  276.646813][    C1] yealink 4-1:36.0: urb_ctl_callback - urb status -71
[  276.654401][   T30]       Not tainted
6.10.0-rc2-syzkaller-00269-g96e09b8f8166 #0


2024/06/08 02:48:35 SYZFATAL: failed to recv *flatrpc.HostMessageRaw: EOF

[  276.654461][    C1] yealink 4-1:36.0: urb_irq_callback - urb status -71

I wonder how to deal with SYZFATAL, maybe the reports are truncated and we
do not see who owns rtnl mutex.


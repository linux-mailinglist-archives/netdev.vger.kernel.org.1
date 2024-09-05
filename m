Return-Path: <netdev+bounces-125545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8A596DA51
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 15:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4EB1F23E08
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 13:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCFA19D895;
	Thu,  5 Sep 2024 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7IsqSwD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3388E19ABDE
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725542966; cv=none; b=m/8tSQeDsn7sWA94KVjD8W+Qhsjb1wTMYknW2ZeJZBOT0Gy6LdxJDvG36TAYv5jff1gc3Abb1zUER+SSxouVVHzHlCiPsjefAu21pcnPnwGrtKUnD14FYq+PNANZtS6ycDTuDzeaSQ9aT4jbSf4BkGjBF6xlcyz0nY5YYt2BUpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725542966; c=relaxed/simple;
	bh=LIyol8nUMlbAtBDPDOO2QQFvy0tGqUjyMyBkfkkdJkc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XCOCmqSQ01BM9E8/H+JszGwq8ELaG6R8ggY8TdPJrI6xJWpRUXhy3U78yDAsp1Ax/yL6dG0eRP0mrb1JSkeI1BXqAi4DPojDQ3FMrVALqDYkmhhdZ0TlR5sQOUJI+FdvWZmq+d82XejtYfMPAkU2aTAeg/jN/KUPpGuaUjjn6Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7IsqSwD; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-27830bce86bso497837fac.0
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 06:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725542964; x=1726147764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4seFofznoIQPdEi52kG+0QY7u1uJjEgnkKNqUO6vBw=;
        b=a7IsqSwDTMH+/mATg/SOkiV6Nwqo08ARVNRYb+wpuQqcBvOohNgXZ2IGtZ11bikIGf
         HBkQX4e/SeJATQ09vlFEpJTm1tBLTKAXOcX8ruh8hXuMuO7EtJyudyflBFbThzgi20h9
         zpMfsf7jSYm3lL+6WSkbt7wzx0ke4aKcqVng+7OoYVeIrnVAqEejHuCtI1FHwFNcCMje
         46Hu5lFzp2YlXw7HVaDM7kIhKiqsjXzPVfZKPAaW7oJIgRC9+pVAjUqoCxuZH0pgbkwO
         GOIZylFMoghu/UOshmCcxBJunCAzectNnsL829xgjXZA3d7zHVv3xFOlV7g6SJfzm5Wu
         Ea/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725542964; x=1726147764;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q4seFofznoIQPdEi52kG+0QY7u1uJjEgnkKNqUO6vBw=;
        b=jTC4QuWtqMcVkRwd94PRORtzF17C/vG6scU1h+Epz3AaHoer5plV51EZOqqaCVJ/Zl
         ox2mEzdv2TAvHE5kaWX/axyKub+vjS37vz+Ec7KeUNRruJPtqQNwLUgTu2zrQd+wN0rs
         skebM7shb/00LlulSV4ewD2pGQ1NxN0SvazNKNmfvFolvaiGub18vdHXPif/3ZX/5Dob
         /WFErJlGI0EgW5/VjCifLFk6r/6x3CKQco5S8FzH70107JJODT7WR4b8yFDbuBdp/d0m
         O5FgytLSQCg4YwDM+ADvyQup4MECFAH9zncyKe7vVxlpZjdZrcunxJcAfHDOYfCsMHSi
         MwJg==
X-Gm-Message-State: AOJu0Yynt+TFXR9YiWbRvbQUwkjZ3w/z54oEN9un5ta4+nGNCGwu9Q+w
	AUFB63uHEC5yWMFTD+KguZb6j/51oq5zsusy9bgPpmSl+y1TYrxf
X-Google-Smtp-Source: AGHT+IHhTf2NhG0A58AaNfbkVOw53LUwZ1HbReZ0GN2jNcAjqF/H8Mt50opGiwt9AfhpWlymmt+zjQ==
X-Received: by 2002:a05:6870:e38b:b0:277:ff80:b52d with SMTP id 586e51a60fabf-277ff80c8b9mr11389577fac.50.1725542963951;
        Thu, 05 Sep 2024 06:29:23 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98efed132sm74335885a.80.2024.09.05.06.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 06:29:23 -0700 (PDT)
Date: Thu, 05 Sep 2024 09:29:23 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Vadim Fedorenko <vadfed@meta.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Message-ID: <66d9b23322f2f_18ac212944a@willemb.c.googlers.com.notmuch>
In-Reply-To: <1946af56-9f6f-439d-b954-6bcb82367741@linux.dev>
References: <20240904113153.2196238-1-vadfed@meta.com>
 <20240904113153.2196238-2-vadfed@meta.com>
 <66d8c903bba20_163d9329498@willemb.c.googlers.com.notmuch>
 <1946af56-9f6f-439d-b954-6bcb82367741@linux.dev>
Subject: Re: [PATCH net-next v3 1/4] net_tstamp: add SCM_TS_OPT_ID to provide
 OPT_ID in control message
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Vadim Fedorenko wrote:
> On 04/09/2024 21:54, Willem de Bruijn wrote:
> > Vadim Fedorenko wrote:
> >> SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate TX
> >> timestamps and packets sent via socket. Unfortunately, there is no way
> >> to reliably predict socket timestamp ID value in case of error returned
> >> by sendmsg. For UDP sockets it's impossible because of lockless
> >> nature of UDP transmit, several threads may send packets in parallel. In
> >> case of RAW sockets MSG_MORE option makes things complicated. More
> >> details are in the conversation [1].
> >> This patch adds new control message type to give user-space
> >> software an opportunity to control the mapping between packets and
> >> values by providing ID with each sendmsg for UDP sockets.
> >> The documentation is also added in this patch.
> >>
> >> [1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com/
> >>
> >> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

> >> @@ -1325,8 +1330,11 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
> >>   	cork->mark = ipc->sockc.mark;
> >>   	cork->priority = ipc->priority;
> >>   	cork->transmit_time = ipc->sockc.transmit_time;
> >> +	cork->ts_opt_id = ipc->sockc.ts_opt_id;
> >>   	cork->tx_flags = 0;
> >>   	sock_tx_timestamp(sk, ipc->sockc.tsflags, &cork->tx_flags);
> >> +	if (ipc->sockc.tsflags & SOCKCM_FLAG_TS_OPT_ID)
> >> +		cork->flags |= IPCORK_TS_OPT_ID;
> > 
> > We can move initialization of ts_opt_id into the branch.
> > 
> > Or conversely avoid the branch with some convoluted shift operations
> > to have the rval be either 1 << 1 or 0 << 1. But let's do the simpler
> > thing.
> 
> What is the reason to move initialization behind the flag? We are not
> doing this for transmit_time even though it's also used with flag only.
> 
> It's not a big deal to change, I just wonder what are the benefits?

Just avoid one assignment in the hot path that does not use this
feature.

cork->ts_opt_id is only valuid if cork->flags & IPCORK_TS_OPT_ID.




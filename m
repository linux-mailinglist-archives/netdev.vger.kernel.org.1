Return-Path: <netdev+bounces-76731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0569886EAE7
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 22:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71BF9284751
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 21:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF6156B73;
	Fri,  1 Mar 2024 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="LaTSQRSN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8146856759
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 21:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709327250; cv=none; b=h/qc725p7h25eIdYaSIIWK+FfgjPHegU0pBv4fQw9Cr/JztJ2Z03xp9ZfA1/6cDBm5wjWBBFB6FntsAtPP2OOIE4gug3Kglq3c8f+O5aCoAudYDXj4fZOvJIngHRXK+SnIXVZJqH6J6xl0awqVXyTXNcKKJyu2pDw8//oGJ12cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709327250; c=relaxed/simple;
	bh=p0ZaZO9UhGkHfWNvzr4gBD+Qoi+U7ycWUel2rLQAKZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PjdDfV0olkBbFIt4DfafeoR0KP6zXclCJQvC3G9MT9IcpCt7r1xwgwJDoPY3VTBO0I2fW0O0tIiGhbmzpuY8JRDnT4w0nSUkPXiVazZgxNsJfEYPOAyD85AzlqXS2T5x+OFtSqm847p/GYOSTFmkl3ndZRhHQDc5ZeFmS71DwwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=LaTSQRSN; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-607c5679842so27151537b3.2
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 13:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1709327247; x=1709932047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0ZaZO9UhGkHfWNvzr4gBD+Qoi+U7ycWUel2rLQAKZE=;
        b=LaTSQRSNMrujt3/P5JkAGvQDPDqx9KCvYb9SMivdHdq+ERlzxz2RP1MSAZCckpm1x2
         LC0Deg3mYSppb1Drh5Pk5lhgcK5WslWhKGDxRRuo/J6aI3Jotpa1AqYmDNNfZUcq57c4
         Ed5h1jIStHgbMm+r6q/xi8/fFq7J7VImn+9AXvG+gtKPMIUgTjbx1slixTXbpykR6SGi
         0zcjvKOvAxhWbxW2zIR6zmKM3M0+4MfotC0/WmLUBhbb4ivimpTzmz7UxIPMUPt2UyXv
         lS4c1mRSYIy3t5PAXiCvAMtfL/KFKX0K3pGZBcY6nZAlmqSebkuqYfuAKTa3uJYy+a0F
         QwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709327247; x=1709932047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0ZaZO9UhGkHfWNvzr4gBD+Qoi+U7ycWUel2rLQAKZE=;
        b=Oq3+o68SpBSyZpJ6EDJRQIet2iu9x3H+QfM9l1mEsPNQbVb0kzy5Cj16kIOZW85kKR
         7sNKLYkLSfUmY2vxircQocXqKQpAxwiw4zLzSxoH2To9EBfNSgNwV4IIqBRaXIOKDtpK
         Q+eolE/kCBWadF0eyfsywwyhuD0F90RvMZOodj0a44a2ag9K2jrIHSac0gSwrF11KUi5
         ZjyXg0EGjPKG6qhV+s8MXdz5rnQuTeRTK5WjeaObiJjMgplhJVbDt/jideZBlxx0AFdf
         iLHkWxpOXD9jEVZtnf5gQv5Vr29j2pqoUBc2uRTiPCSdkpYrWwbqY2xBGT30N2PoxLsc
         YIxg==
X-Forwarded-Encrypted: i=1; AJvYcCUq1LyLIMUMCvyrcGd9nbb4WcdCOpN8gEy7VtbY1nAm/hJz0aTk4zyad8xLpQH+BRZyWiEM+MiPrqYY1cdPSQs85ogHHD+/
X-Gm-Message-State: AOJu0Yy75bfHPlTcxc9ssK3QQ9QX2/uIMKdqQqQ+OHPLWgFvU1sIHbeL
	OWnPokp+om1dk6UJJXj7VWq/lo1xCFELnfZxdHMlhS5nEZLTt0rKCEngqyvQcYQ4BwDiOaZrKxe
	3drnccnl1ZsPdgDD3F3AYss3M/prVNjWgBHL2
X-Google-Smtp-Source: AGHT+IEAMh7WOZ34OSXCbsOza9A1uwFW+6xAUTjxYlyOU/ythJUQ2QlpJchp1sHedtQ31N2sHA+w3VSYPVvUEhjqXjM=
X-Received: by 2002:a81:c214:0:b0:609:37fe:fb97 with SMTP id
 z20-20020a81c214000000b0060937fefb97mr2947278ywc.4.1709327247508; Fri, 01 Mar
 2024 13:07:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229143432.273b4871@gandalf.local.home> <CAM0EoMkOgTezVLnN7f1GoXTURQ73LmXjHnBjQBSBRPnv58K-VQ@mail.gmail.com>
 <20240301150153.36e5bf60@gandalf.local.home>
In-Reply-To: <20240301150153.36e5bf60@gandalf.local.home>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 1 Mar 2024 16:07:16 -0500
Message-ID: <CAM0EoMnLJ2W6HY9yNM1AKMVsnbam7VkW4gr+mhk+nywbh-+e1g@mail.gmail.com>
Subject: Re: [PATCH] tracing/net_sched: Fix tracepoints that save qdisc_dev()
 as a string
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, vaclav.zindulka@tlapnet.cz, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Coco Li <lixiaoyan@google.com>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 2:59=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Fri, 1 Mar 2024 14:24:17 -0500
> Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>
> > > Fixes: a34dac0b90552 ("net_sched: add tracepoints for qdisc_reset() a=
nd qdisc_destroy()")
> > > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> >
> > Should this be targeting the net tree?
>
> I was going to say that I need this for my work, but my work is aimed at
> the next merge window, but this should go into the kernel now and be mark=
ed
> for stable. So yes, it probably should go through the net tree.
>
> Do I need to resubmit it?
>

My view is it needs to be merged.
I note there are some big changes in net and net-next trees right now
that move the name - probably from 43a71cd66b9c0
Coco Li and Eric are on your Cc already.

> > Otherwise, LGTM. Just wondering - this worked before because "name"
> > was the first field?
>
> Looks like it. See commit 43a71cd66b9c0 ("net-device: reorganize net_devi=
ce
> fast path variables")
>
> I wonder if there's anything else that uses a pointer to struct net_devic=
e
> thinking it can just be switched to find the name?
>

From a quick scan i cant find anything obvious.

cheers,
jamal

> >
> > Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> Thanks,
>
> -- Steve


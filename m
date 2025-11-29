Return-Path: <netdev+bounces-242726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FD7C94494
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 17:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EEB7B343A1A
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 16:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A821DFD96;
	Sat, 29 Nov 2025 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhZO2ah3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7D41D86FF
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764435379; cv=none; b=D0uBz8j9KGrhS8qzVWSk5B5wUQPwIoALd89DTgtQis9ILamZFfy7nNGG6JNP7rIYecXrV8dqWoDtenZVHIsqyLEuzXYN64DxB8hC4vJRgJW0LY80UCZbWw9T1TxMlJAV0Vnsp0ysKMn1SccVKQNG0f4LF5gjQw9vafHjUE1/wJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764435379; c=relaxed/simple;
	bh=jduQ0Vl6RC3wguT8vbyfUmuhrwTZ7khakKZqlKqyBc4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=puL4cGMFdHbxgEKbDIwxhfk3I7UTdtg/BpuOajK65bh6xinTdOb5Ct9ESJLg2f+I+t4P3xbco1dawVxslcxl+NWpochj8yv6y5pM7sR/S9mAR9WsFr0tKphj/Jv3ssPR1bQYYE9OUEPtNMhC9rPoyUl9qzUV2dGGDL3KkHZAMYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhZO2ah3; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78a6c7ac38fso28410247b3.0
        for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 08:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764435377; x=1765040177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyK1frpIkqMT8VKh9JIYl1DpSkJ3TM9bY2MXFN6WCgQ=;
        b=MhZO2ah3gkT1e1ckjXj7jkB6BG3sxZa1aVxLgyT48e/p5Kcy+ImL+IshWlR+NlID3Z
         5ylJMZyqTSanUprhKvhB8LYsdKlzTlGlmTlo8ro13OI44alZtx7UOX4LFXPulW88BDnx
         og9LQ/L7rMitDlb9PVoAvZKBe6HgRKrVzB2nTAt7E9d1HHfDngJsRHE2r4rl4fmV0Ix+
         2AuU4q/f7qg2+C61hHeMsoVFE+TMw7BXK5H2FWflESI1afN3IqijP8D9Of0HQ1iFq82m
         h5BoXCJXdpRK4JMqyCq4StxfqzfrgVRKEjxhCA1+TN/DQW1yXM+/AvyLD9IYlejg61QQ
         B3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764435377; x=1765040177;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yyK1frpIkqMT8VKh9JIYl1DpSkJ3TM9bY2MXFN6WCgQ=;
        b=EiuePB84ObYyeC6QnPRbf3isogu2SLtQME9C7t04E7ExnSMOjFBXiK87lWILCTfWrs
         MM6qwLcxg+VhWDqQyK94S8gnR6K78GRjvkAUs2hdbqoz0iVkaFujKvr3UNw64hE8vuc8
         nqQbMkRxH0VeaL3AMlKaMh8qtx1KynYT51dsY+4ZJYkhmh1xZ4OuGepo31c0a85rPtFq
         C23yljSz4XGqUdAAlJ8f6ObSOIzZ86RUXMjumYJ5UH2ourEYDYq6IPKEPIzaK/0nk8ai
         W/I/eor9XLprQRVfjLUy6o1ZrAFVk9RZPOk8mix9ArYONS7ZFU+f0n/2g9DbsR09t0n4
         NQKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgys+ZR+YVlij30a5/eTaMmiZ0/7LNzSNOPEYkZaHGijHH0p+2zLpCdcu0z88wTUQ1OdKl/Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLzv4zxpOnWQxXUsweWiiKwyY5oRXD3WnQOAZsY/EOVuYvr4H6
	YPEBTem78bmisGCYgvJNG6xdiVd83IePiOE+/G8f/iXRM+gNpT/nNo2J
X-Gm-Gg: ASbGncslTd3B7t+hS8R2cHN3KgdhdcsG+RXISgbNY6TwvN0mdQZLMZaxuPSHoWu6ScH
	0LJT6LTFzQN3N9wtjBJswnr4ZkhPtbz+NdYY75KPktQZ7F1qlDaQgbya0Ari+OWezuAOpNJRTr1
	8GBMIV+OGsxdoHy80OYPnwl4Rp7yQuEzKaFU9ZUvHhXU3ieCX6Gb46BaedjTyxYw3Q20Il6mNNO
	VWu1lK/4q95XsRMIn62YOws/MDfdQIF3xWwWw059yWy0w38sSSp3rLkfTFJ+jZSjeM9brsEa8eQ
	R+4WYbkwLe6vFd4WWYgrWpUEUMjr72aMsz6aWbN+DPQYo+W/K9fn4W0oYYCdhVrbCebyIZbxVji
	wHFU+96V9n9CpcXSX3A5f3741Gyl8zg9AhKS+PTnzUpkYb/JNclTHCKv3A/MRVo7ti6F10Wq6dU
	/u/9237YpaHkiyxPaKLcEV9EK0uK/jnO/TvXiB49SUV9W7G5F41T6D+ouYrUcJF2zBGqc=
X-Google-Smtp-Source: AGHT+IEcrQRp4ITJhrH7YWzMD2/YwlxTQu831k+ljd/SPFUJAFFJTOlxkBAmUUm8nJcxZVwXYw0omQ==
X-Received: by 2002:a05:690c:f8f:b0:786:5712:46c4 with SMTP id 00721157ae682-78a8b495420mr279788797b3.27.1764435377025;
        Sat, 29 Nov 2025 08:56:17 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78ad0d5fefbsm27621837b3.20.2025.11.29.08.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 08:56:16 -0800 (PST)
Date: Sat, 29 Nov 2025 11:56:15 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: =?UTF-8?B?Sm9uYXMgS8O2cHBlbGVy?= <j.koeppeler@tu-berlin.de>, 
 cake@lists.bufferbloat.net, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.352b3243bf88@gmail.com>
In-Reply-To: <87a505b3dt.fsf@toke.dk>
References: <20251127-mq-cake-sub-qdisc-v2-0-24d9ead047b9@redhat.com>
 <20251127-mq-cake-sub-qdisc-v2-2-24d9ead047b9@redhat.com>
 <willemdebruijn.kernel.2e44851dd8b26@gmail.com>
 <87a505b3dt.fsf@toke.dk>
Subject: Re: [PATCH net-next v2 2/4] net/sched: sch_cake: Add cake_mq qdisc
 for using cake on mq devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Willem de Bruijn <willemdebruijn.kernel@gmail.com> writes:
> =

> > Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> Add a cake_mq qdisc which installs cake instances on each hardware
> >> queue on a multi-queue device.
> >> =

> >> This is just a copy of sch_mq that installs cake instead of the defa=
ult
> >> qdisc on each queue. Subsequent commits will add sharing of the conf=
ig
> >> between cake instances, as well as a multi-queue aware shaper algori=
thm.
> >> =

> >> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >> ---
> >>  net/sched/sch_cake.c | 214 ++++++++++++++++++++++++++++++++++++++++=
++++++++++-
> >>  1 file changed, 213 insertions(+), 1 deletion(-)
> >
> > Is this code duplication unavoidable?
> >
> > Could the same be achieved by either
> >
> > extending the original sch_mq to have a variant that calls the
> > custom cake_mq_change.
> >
> > Or avoid hanging the shared state off of parent mq entirely. Have the=

> > cake instances share it directly. E.g., where all but the instance on=

> > netdev_get_tx_queue(dev, 0) are opened in a special "shared" mode (a
> > bit like SO_REUSEPORT sockets) and lookup the state from that
> > instance.
> =

> We actually started out with something like that, but ended up with the=

> current variant for primarily UAPI reasons: Having the mq variant be a
> separate named qdisc is simple and easy to understand ('cake' gets you
> single-queue, 'cake_mq' gets you multi-queue).
> =

> I think having that variant live with the cake code makes sense. I
> suppose we could reuse a couple of the mq callbacks by exporting them
> and calling them from the cake code and avoid some duplication that way=
.
> I can follow up with a patch to consolidate those if you think it is
> worth it to do so?

Since most functions are identical, I do think reusing them is
preferable over duplicating them.

I'm not fully convinced that mq_cake + cake is preferable over
mq + cake (my second suggestion). We also do not have a separate
mq_fq, say. But mine is just one opinion from the peanut gallery.



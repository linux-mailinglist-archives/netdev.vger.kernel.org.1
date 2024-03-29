Return-Path: <netdev+bounces-83238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 267398916FB
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 11:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05B21F255E3
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 10:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EED524C6;
	Fri, 29 Mar 2024 10:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaF0YhCH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC2969DF4;
	Fri, 29 Mar 2024 10:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711708894; cv=none; b=HBORc7YKYri+Nm11ydu9M+DrVKAKQffJ0Aajm+lJQq8/Fg7r76Ke4+neRAeAq7ebdavU2iHeof80qZC//MCpwoTymdoDV/lRk0c/s8Mb4UAAdNu0mH/xQXa+mP4J67H6i7+BSUexDaiRtgX+kdNCI9jLYtePAsfLECDy+3BFxsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711708894; c=relaxed/simple;
	bh=JyQADm6StSmCk7VbG8Fc8OvnsSv53ToxBspbRlYQOVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AiSGdP9791MxE9TV4zxZWux6Bu9tS6mijiY6iNMz6IM5dxB/ytS0d6ThtEl78pSwpCW/6xfz2mAYVnvIkdg3TtxlzRqlxeUfgEZ5W6+Arauw6YsWXjA0Yk8tpIg4efvthrAdxyf21cFsNLfZKIiGpOTzFVb6gvv1xsspfcazZec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaF0YhCH; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a470d7f77eeso241425966b.3;
        Fri, 29 Mar 2024 03:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711708891; x=1712313691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJ7ur8CUhmXoyTw9SZZcPYYLBLjAq/4M04R8NlO7i7o=;
        b=YaF0YhCHE7ZluG9sKwvmBqNSPdF8DAsBr0xCzeYOQSr/pWwTvBmsKHyZ1AhXdn+PYM
         zD4mPDiuN1KPAjwAvtlGtm90qtybKRU/+e9cDqR+17TYDoy7p3LthL2Qxo47Ft4SBfTR
         djTWcHufNWVQOzIlqyP9+hjFamWhO3QzpUBXsbhs6ePOq3tjm+Ow6zUJWZ/O7RMneilP
         hddZhON0xd7RfD2Llu/Bkk11kHYkC3pmr7DYLODI6bae/N/OsMYdB/Ub+Opg98W6viVc
         +lnNvjwGBRzPwOpkEUJswexUZv3kXgHftfcQ2RprnLTqKa5bRhk1z3j5zYhBmESzWUUW
         ZJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711708891; x=1712313691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJ7ur8CUhmXoyTw9SZZcPYYLBLjAq/4M04R8NlO7i7o=;
        b=TGMWYu3xSHjFfXF0Egpdaq3sn0XJU7qXeE5e+evDbfpiWssl6ds6pen98NG5T918sk
         FPKkKJsvClrHmK4on6FwuYhTfdkXYVgaOIqXqLI9Uqf9Jsghhto6yjimRAXKRDUyFId2
         wTup7W3t/0eYABdzKxJAXUl5w2IXjCrGxxLH5R3PGCA1AJH4kJornjaFeTWbx6bxZsw4
         Ju0jDem0yNbbHBhhGWNpPvwaenM/ODNEm3Dk7EfqrIptZK3GkD5ERv4xEPsD4q/28bCI
         zjbHdcPTkdo6ZRKH0gzza969DJQXS7yeMh2bgadUnjnk3/ya4kpH505PtmSRyTgy0/3v
         JjTg==
X-Forwarded-Encrypted: i=1; AJvYcCXTwW772xY+Jg8pAbfZWDCgrmqlD5tsEY7jothVbgjRbNDn+iBo5xBG1Pv7f/2xKrzLZxg7fl37dBXjLgYPNHf42qTnLRJ7feNR2sQ5RCVqQ8tCJPre7/20zqA0rGtRXgv+tyXlS69FsVep
X-Gm-Message-State: AOJu0YyTlLDsdDXkGDkShndnV0cJbiTSntjtZEUvYBMaBPk3XIe9KoOt
	nfB4xpQo89pVMLF6X9ZR5EWeHEgKQ2AS1Mx3AIzKKNpe+qDQ6K8iBXiXAAkGqAlOIof0yVscO4o
	czpAcfBesNtpOUpUolxkMYJZHlC0LoU8SPgc=
X-Google-Smtp-Source: AGHT+IE9MsTixcTFY2cE03LT8ruG93/33BbQvBX6DoS6IktovOPkcU4CUUgzk0QL0matjkTNT2GCPetnJKf2RQ6TJlU=
X-Received: by 2002:a17:907:72c6:b0:a46:13d5:46fe with SMTP id
 du6-20020a17090772c600b00a4613d546femr1743237ejc.11.1711708890891; Fri, 29
 Mar 2024 03:41:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329034243.7929-1-kerneljasonxing@gmail.com>
 <20240329034243.7929-4-kerneljasonxing@gmail.com> <CANn89iJw8x-LqgsWOeJQQvgVg6DnL5aBRLi10QN2WBdr+X4k=w@mail.gmail.com>
In-Reply-To: <CANn89iJw8x-LqgsWOeJQQvgVg6DnL5aBRLi10QN2WBdr+X4k=w@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 29 Mar 2024 18:40:54 +0800
Message-ID: <CAL+tcoD0_tPkmp-jDg8tiQhcwoR6Lb_BwqiZ4xegoxObxsy86g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] tcp: add location into reset trace process
To: Eric Dumazet <edumazet@google.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, rostedt@goodmis.org, 
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 5:13=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Mar 29, 2024 at 4:43=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > In addition to knowing the 4-tuple of the flow which generates RST,
> > the reason why it does so is very important because we have some
> > cases where the RST should be sent and have no clue which one
> > exactly.
> >
> > Adding location of reset process can help us more, like what
> > trace_kfree_skb does.
>
> Well, I would prefer a drop_reason here, even if there is no 'dropped' pa=
cket.

Good idea really. Then we can accurately diagnose which kind of reason
exactly causes the RST behavior.

I'm not sure if we can reuse the drop_reason here, like adding/using
some reasons in enum skb_drop_reason {}? The name is a little bit
strange.

Oh, I can just print the string of reason directly instead of really
using enum skb_drop_reason {}...

>
> This would be more stable than something based on function names that
> could be changed.
>
> tracepoints do not have to get ugly, we can easily get stack traces if ne=
eded.
>
> perf record -a -g  -e tcp:tcp_send_reset ...

Ah, yes, I blindly mimic what trace_skb_kfree() and
trace_consume_skb() do. Introducing some RST reasons is more
reasonable and easier to detect since it's not hard to add four or
five reasons only.

Thanks,
Jason


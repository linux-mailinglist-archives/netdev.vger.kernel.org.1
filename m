Return-Path: <netdev+bounces-79054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BE1877A21
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 04:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611C61C209E3
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 03:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FDC15B3;
	Mon, 11 Mar 2024 03:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFmuZRJa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D272A15A5;
	Mon, 11 Mar 2024 03:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710127768; cv=none; b=ZlilX282k5zpfcfEe2WNuav41S28C5G1JKdVo0WMp7++x1lBi2kFrk1y5HKRB/SSJMcVHJPKafyIAWVVMtUq/f8pyeTbd3NBACCVgkNbrkt7hj/Js3cr1RfhnvpgNWHT2M/BoPr1maWeleV9gEgkSunB7+OFDMgJvRMv4kR3JRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710127768; c=relaxed/simple;
	bh=AkY5uDurSfrXwDY5iZzPAPWoaJANqVcywj1NHkU5EtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBfg72cGIO/ilVAoi+SScLhfpQX+B6pmirgGWSUCwwCWLzD4vwrwZPw8mC9pVNZFsMiI2CbjPCAiS7heGVHFLbM5nvE+kMc3Kv7cCINkX9+fuNf1HOMN7V7nsGAi5lkX5xGPOZfoa8O2ZFhx9AndEgsnveL6OHhGrQV5UtLZijY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFmuZRJa; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512e39226efso3770573e87.0;
        Sun, 10 Mar 2024 20:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710127765; x=1710732565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBCQ803QUzwyKr/m9OfBVscOO+uM7S6n4+xPEUUdKfI=;
        b=YFmuZRJa7hFp5/Ei3rf1M4tp/xCDT74I065r5Wd60a0axPWiKpHiLqMWseAI9EVwbg
         3WOthdbIzGk9gHuCSgtF8kIQ/lXB5iGI+6cXkRO+8/3IghgDQGNNXVJ8IeBvupJDjhoK
         YSLxlu8TkONB+exuregU9LXwZSbVrNXGRFJfgZ6tkjnhM0Zk/jmy7kFXmuACkKzzxSDS
         XP23W310cU4cmmmZ5X3iqb3SSlY+cZroEeWslrPtp34LTJ1fHM5gABPWDNfEvTcuNWWG
         g5+OY0aPJUdXWU8yIj6wJYwPB/lmAzV2LWofrwTcV/8G3gqlERzkajKxeMSgf4LhiD7d
         81xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710127765; x=1710732565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBCQ803QUzwyKr/m9OfBVscOO+uM7S6n4+xPEUUdKfI=;
        b=qbYPU/A9+msIfb8oijSqPY/qKkmanhamLSsIydQT67cYktJqshexz72T4XyNxxQe4B
         GdAMKRFfarepf5DV6V6KY8/r/MqmJqNRs7RZbKdNXGbJJPIZD59cKyOXivzPwmngPCSv
         gCrkgTJeEPv1Q7HqlGyw6G4Pl5wn7T6JRf7IWUw1zbTbJeRB07G8EvX8m4jT+uEvVE04
         DEKjwQHuwkPeq1wDT5Q4SqmuzoAaBZS41eJIiHLVdqArMEhSnorzXgOZ2RrmedNJjFaY
         HXZ0BrPc1+DjJcnXZxFihnnUL2ov6VQMet0ib9L48TBZx6yZUTB855B6YE3bwM/2WRFB
         gkjg==
X-Forwarded-Encrypted: i=1; AJvYcCXGqIXXhCDXNdB8VUDa3B3DYTNPV3JDW7/Et6lo5J57TxVrctU55Zn+EfHol8z/9o/GqnAmNlmOFhDWADYW/kK4eYnxyrlIIBaNnJmzDSkZHNQZxWWYoZDs/SNV7foZ+afoN0d81c9OoDWl
X-Gm-Message-State: AOJu0Yxh3JvlEdhm5DtmOujX23xN7iIlHKhWlXw/M/hPBjOvObBxdoyK
	NqfX3ZVCSTSu2r7AbmQezJlef3esRotGPHVuLZkebx/fpozo5LsWD2IXGBu262H4gVCiyjL4PRo
	QL8Zyobbqr6dAPLj631UUHVzpfus=
X-Google-Smtp-Source: AGHT+IEGqx6tOXsV1NDhtw/esCPZ4I0z48q2YqBl4r6W3XEYHysoNdIyBolAOa8iuLVZPkMdnOxTy9Alw87vtaUl3MA=
X-Received: by 2002:a05:6512:3ee:b0:513:e21:2a64 with SMTP id
 n14-20020a05651203ee00b005130e212a64mr3009071lfq.31.1710127764797; Sun, 10
 Mar 2024 20:29:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311024104.67522-1-kerneljasonxing@gmail.com>
 <20240311024104.67522-2-kerneljasonxing@gmail.com> <20240311032341.GA1241282@maili.marvell.com>
In-Reply-To: <20240311032341.GA1241282@maili.marvell.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 11 Mar 2024 11:28:48 +0800
Message-ID: <CAL+tcoAfz2xhfqGt4AnrfsRx8FhRGzND7mOPrx8ZH7b9bbkehA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] trace: adjust TP_STORE_ADDR_PORTS_SKB() parameters
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: edumazet@google.com, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	rostedt@goodmis.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 11:23=E2=80=AFAM Ratheesh Kannoth <rkannoth@marvell=
.com> wrote:
>
> On 2024-03-11 at 08:11:03, Jason Xing (kerneljasonxing@gmail.com) wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Introducing entry_saddr and entry_daddr parameters in this macro
> > for later use can help us record the reverse 4-turple by analyzing
> Did you mean tuple ? what is turple ?
>
> > the 4-turple of the incoming skb when receiving.

Oh, thanks for reminding me. I always remember the wrong word... Yes,
it is tuple.

Thanks,
Jason

> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  include/trace/events/tcp.h | 21 +++++++++++----------
> >  1 file changed, 11 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> > index 699dafd204ea..2495a1d579be 100644
> > --- a/include/trace/events/tcp.h
> > +++ b/include/trace/events/tcp.h
> > @@ -302,15 +302,15 @@ TRACE_EVENT(tcp_probe,
> >                 __entry->skbaddr, __entry->skaddr)
> >  );


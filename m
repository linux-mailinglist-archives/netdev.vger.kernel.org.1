Return-Path: <netdev+bounces-146844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F5D9D63F9
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 19:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F1D4B249FB
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 18:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BA81DF73A;
	Fri, 22 Nov 2024 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jhdKWzMJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE82158DA3
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732299006; cv=none; b=VNq9VUjUDEvBSnhoTgC538NzOGn+y4fi/ZBUDi4sMPk/vv87PUHf24+MxZ1L+p3FU0WtRqrGhP/2hDHbu+kU+C6sdrtVkQVZ0RCzun0RPJrL7+/9+l3hBRvLvwqxM38jhr8diQPWHBG+5VOwzyK22duxrR0igK4wsP2CZPUyTYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732299006; c=relaxed/simple;
	bh=pB+znEVj3W5BBygi/W+QW8fzOoiJ9fL4dqh6ukudCns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j988jnSAYZo2UwvvoqC98vbk2OLN/3Zy892aeSlRcBRB7/Q7r3nIQH43zxdA7JvO7lZy0hcPiLJ8cIK34ZVBjAERS+5hOAf35XehPykGx0jCGpfjRz5/QT0oF/XJMBLwH6JVgAZzBStgjqNQZl3/vjMXdSi1xYPzxvnqGUc+Rac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jhdKWzMJ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d0102fc7beso2386703a12.0
        for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 10:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732299003; x=1732903803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TrDLbnaTTL4igpcCtV1PIIXtNkJzbYF7pnoRGOZi0E=;
        b=jhdKWzMJI+LFqrNUCe545LNEq4FeSRzUMSAaw1aQANQDxeffpzXWcifffd8YkHbdvk
         5DjUp02TIq+TSHByAnM2MV8Hwd5YiD8DuA70TH5agc+kTEQfmupFMHNtlky1HhlFaIQ9
         ax6TyU2DOzQaMlRVGkG076rJpWyIgZydzG4yV5EwLwFgMFM1iTABAPR5Pd0D/67zqEvv
         +Udfw04Tmvfp9TGi/d5uxlc5xvu63VF8mLsXQr9XIZ6gxf271/JnnnEK4codWAo1UCpU
         KF4Canc8k9FJii9kKnqgOz72+rJF78YJ3ml+2FDCEFlY0qDN/j+2YPZwerCzNsn70b7z
         hzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732299003; x=1732903803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TrDLbnaTTL4igpcCtV1PIIXtNkJzbYF7pnoRGOZi0E=;
        b=WWusCNblfv2r78IZMtRJ0IF2FvuP8CPrLf/Z0jd3ObDcDFZ56fc7HtDe+8wIWV/cpV
         URJZzLv6AEGXAQsXXwyTPMEvlsGf/iBVCz6kn9GjJFdGRXL/an78Det9F2nhNcamQVkE
         IyqWZClbZY8N7RvSC1qt3VTKHgtIiZX3Nvt+smcovBOR0d9TGBHpVGtCZojbQiQi8AsP
         GFsBCVAycacUfJiQ5q4X93wgBKF4RwaN/dY5JKN9h1XiKNZS/6EN4PesbMByqSinuprw
         5HpT3QtZnc1ER3wQ74U7Ja2t0bsW+XOfAccxhwm4u+UNO7Iob7fZnBEaVIbdcjpaQeUU
         huSQ==
X-Gm-Message-State: AOJu0Yywx5MWxfFSZkbO7+ImFrpzNno5+XqZIRMccIooDc+SxQy97Qkm
	VhSjlVMY9vP0xqyJbZnVQRPZMzIA+C6WrDqkqasrifhFf0mV8vvQA3aPVB0JCHgg1pk5MjFSR13
	ugyptnUI3nkgnfDM2cNuFYhWlxeIhtgSguKfg
X-Gm-Gg: ASbGnctS+S0ejmvFaN9Z7cQORBmqzEtTZrJHNquCHOUhOkDf3tDmRKtxfccg5+2tE8y
	yJoY4lX7DITmpqHRiBcWGcZ1lSPm3EA==
X-Google-Smtp-Source: AGHT+IHtf4P3xfugTkD6+PExfOLL8xzzsj5ugGOp+lLOTN58SKsEdZ95FJE2no+cd5oGbvCfI1+kA/f9W8IZZTb1lRI=
X-Received: by 2002:a17:906:314c:b0:a9a:212d:4ecb with SMTP id
 a640c23a62f3a-aa50990662cmr321150566b.12.1732299002993; Fri, 22 Nov 2024
 10:10:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122162108.2697803-1-kuba@kernel.org> <CANn89iKBUJ6p56+3TRNB5JAn0bmuRPDWLeOwGmvLh5yjwnDasA@mail.gmail.com>
 <20241122093120.61806727@kernel.org>
In-Reply-To: <20241122093120.61806727@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 22 Nov 2024 19:09:51 +0100
Message-ID: <CANn89iJp09omWVAk43Aw2mPsii4QsgYxOSpjDdDyYeGjVQSGRw@mail.gmail.com>
Subject: Re: [PATCH net] net_sched: sch_fq: don't follow the fast path if Tx
 is behind now
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 6:31=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 22 Nov 2024 17:44:33 +0100 Eric Dumazet wrote:
> > Interesting... I guess we could also call fq_check_throttled() to
> > refresh a better view of the qdisc state ?
> >
> > But perhaps your patch is simpler. I guess it could be reduced to
> >
> > if (q->time_next_delayed_flow <=3D now + q->offload_horizon)
> >       return false;
> >
> > (Note the + q->offload_horizon)
> >
> > I do not think testing q->throttled_flows is strictly needed :
> > If 0, then q->time_next_delayed_flow is set to ~0ULL.
>
> Makes sense, I'll respin using your check tomorrow.

Great. I confirm that the fix reduces the TcpExtTCPSACKReorder SNMP
counter increase we had recently.

Also "ss -temoi" was showing suspect reordering:300 values I had no
time yet to investigate.

Thanks a lot for finding this !


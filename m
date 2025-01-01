Return-Path: <netdev+bounces-154652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09189FF43D
	for <lists+netdev@lfdr.de>; Wed,  1 Jan 2025 15:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8D53A1AB4
	for <lists+netdev@lfdr.de>; Wed,  1 Jan 2025 14:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC2B1E1A35;
	Wed,  1 Jan 2025 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bz/4XTed"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242172E62B
	for <netdev@vger.kernel.org>; Wed,  1 Jan 2025 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735743441; cv=none; b=D/NKkyMB+3rv3A0AgRZ2qO/nlCatvORyo7nLTOZYrUUFsGwLV1Tt4z2jQxXbpYaUc9kX+adnMHOqVbDwED2Jif29iWdkvhRGeiNdcxTuG/6hxtHocMh5h7pXzs+n++52DKZLlVoV12y/nRjQkrl7xsEb4eOX+aT0VjL3bGY4bCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735743441; c=relaxed/simple;
	bh=XqTWvGeUOo35VfxrmDPcEqof98nz5we+WFR64VS6MZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcwGmE87odefca6QWBu2FBTLCpq8/8m23JpIWxiHiuSHnbI5JJ2MchK3TrlomAK0/iHNQ0CetQxnW4oyiOrxsWBduqu5l7gaPBXpaf4B3xHMumE8I9ZLO3Tqu3NImS7uMkzwvrihIpUI62BPhPM791mT14nKj2kMD8NAzI2bNXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bz/4XTed; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso27145986d6.2
        for <netdev@vger.kernel.org>; Wed, 01 Jan 2025 06:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735743439; x=1736348239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcQe4rHsmeMVTWvZT/YNS0dlw57LoOKq4S4dPFLCxCw=;
        b=Bz/4XTedhkLp0adSlD6ezVc/Q8upXxaY0Zfi+8BGBt6/jOYV9oeIPMlBM4BtCPQyzo
         AVbVaGddQ+pWltr/57zuup5x+FgUd4jyn7pUTaKkz/HFJgpOvnjl/n4irdsfpbZYYt4a
         vGlJV8FntRh8AbYR2hur2V5rPzdYYLh6LYqH0XtdjGhChoN3oVp/YbqIHD7rzRYP2Gmx
         E6tKq1DV+WcnKCrUNU7EInSSO7cb+3ZxRfF+KjkgF1QfUF+P7P95aVo/GW5rENcC2a3p
         LEDimF79K/rc+MA+yCCl/XsVmTNOfpLYgPoUczbWJaj/mhLkU9TW8rtVO6+U/yl0qaFT
         1VrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735743439; x=1736348239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcQe4rHsmeMVTWvZT/YNS0dlw57LoOKq4S4dPFLCxCw=;
        b=HlKlqZroJZIoQxgweM4h7+cJ4r26yFvFBVQk268FkbQe+mA86WKDgsTg1V5wOg4kMM
         RgQwY4fzek34q/BpjFDYyqPIQt31CDyI5s2RUGsLH1NjH21/xxVEc+afT8COulZF4gkr
         8Pl59jRHCF/5jHbayPS77n1zrlVOHuMcDtQN+ojL3QADaSC3W/4EA+eOds3LaZfllhYJ
         zW6Dc4KQHqInhbSYiYEP7FAgzT0I64XsCh97taDqVj+ffzbGLOQPxU+W4uZjdbO0zra2
         mK4e4ms1AsKeejitWfVTQW5DABn0qBI4z3aG4MEoDok+54oeG4ib3c6pyzS6s3iGGCIp
         rjVQ==
X-Gm-Message-State: AOJu0YzAjly72BrVva5+Q1mpZkBqt8q5Bz+AflgcV3cgGdiHjV+BvFRe
	llH5WVWkZ+u2AeiM8OCIl8aCAMNp1Ko2big3eecYh8vC39hOlIMnehOcDL5tCvwzdyDnla9/Gml
	8cIop1y1xZYlvFOitRRuz+ROGyUU=
X-Gm-Gg: ASbGnctbv2hLWHMbwHkC8t5uAicO8FZUSmiTGSHlLz5C+QAKPSxcW+N+LxRH2xgBwMH
	qrOOOLjZnYxxop4EjZkA6F6Xz91c068SF5JViM10RySRYFh7z2Q==
X-Google-Smtp-Source: AGHT+IFrM+Vm1hdUXdqjEyZjlG+YGCy3+HjoK51mU7Wpjpirn/808k1kM4iEpQ7APLdzPOEhBPo4vT0AZFmbcnkZRU0=
X-Received: by 2002:a05:6214:c4f:b0:6d8:7db7:6d88 with SMTP id
 6a1803df08f44-6dd23355e2cmr752036356d6.28.1735743439021; Wed, 01 Jan 2025
 06:57:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFmV8Nc758FDNK3FNSLQui4RmE3-TQr7d2tM_tOM6bC=OfEDwQ@mail.gmail.com>
 <CANn89i++A224Of5B+Eu+qfiQO1mXfXVfzuejuXyfCwtK1rmMDA@mail.gmail.com>
In-Reply-To: <CANn89i++A224Of5B+Eu+qfiQO1mXfXVfzuejuXyfCwtK1rmMDA@mail.gmail.com>
From: Zhongqiu Duan <dzq.aishenghu0@gmail.com>
Date: Wed, 1 Jan 2025 22:57:08 +0800
Message-ID: <CAFmV8NdQc7YhT5XTV2ZVtVv0yPYeDpUdsUaaat+mSvgVEdC8Fg@mail.gmail.com>
Subject: Re: perhaps inet_csk_reqsk_queue_is_full should also allow zero backlog
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, kerneljasonxing@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2024 at 5:19=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Dec 31, 2024 at 9:24=E2=80=AFAM Zhongqiu Duan <dzq.aishenghu0@gma=
il.com> wrote:
> >
> > Hi all,
> >
> > We use a proprietary library in our product, it passes hardcoded zero
> > as the backlog of listen().
> > It works fine when syncookies is enabled, but when we disable syncookie=
s
> > by business requirement, no connection can be made.
> >
> > After some investigation, the problem is focused on the
> > inet_csk_reqsk_queue_is_full().
> >
> > static inline int inet_csk_reqsk_queue_is_full(const struct sock *sk)
> > {
> >         return inet_csk_reqsk_queue_len(sk) >=3D
> > READ_ONCE(sk->sk_max_ack_backlog);
> > }
> >
> > I noticed that the stories happened to sk_acceptq_is_full() about this
> > in the past, like
> > the commit c609e6a (Revert "net: correct sk_acceptq_is_full()").
> >
> > Perhaps we can also avoid the problem by using ">" in the decision
> > condition like
> > `inet_csk_reqsk_queue_len(sk) > READ_ONCE(sk->sk_max_ack_backlog)`.
> >
> > Best regards,
> > Zhongqiu
>
> Not sure I understand the issue you have, it seems to Work As Intended ?
>
> If you do not post a RFC patch, it is hard to follow what is the suggesti=
on.

I mean, when the backlog of listen() is set to zero,
sk_acceptq_is_full() allows a connection to be made (with syncookies
working), but inet_csk_reqsk_queue_is_full() does not.

Jason's reply to this thread describes this issue in more detail.

Thanks,
Zhongqiu


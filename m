Return-Path: <netdev+bounces-154653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C60249FF43F
	for <lists+netdev@lfdr.de>; Wed,  1 Jan 2025 16:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9A481882301
	for <lists+netdev@lfdr.de>; Wed,  1 Jan 2025 15:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6841E1A18;
	Wed,  1 Jan 2025 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HknMqnuf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8112B26ACD
	for <netdev@vger.kernel.org>; Wed,  1 Jan 2025 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735743790; cv=none; b=fUNfoHZxzdhlzHDyM37KhlrnzAjuSQNwMkmSf7tfTotn0aSod6fiEQr9MjFatiiuI0ttrDwy+wwnX5KF+4QzKwVu517CWTVwu15jbk6ojV5CVgZ+auSeo8w+/LUypD6AXW40bHNKAiB4MIWm+ojZrojMIhVmrSQabkZ0PgaE2uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735743790; c=relaxed/simple;
	bh=g+vXPLFbGZt6Q0YzjxDVdCfSL2KuwfJ4o3Kg8XT27UE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/GUObD915Y5ArwKfghFEUvHXHGXwV54wUIM1hkptlPYWo8uoasUf5T2HCS0jIqZ0gSZFiKOg+yBPHGr+39tOqepqa9l0WlSvYe9ivNMx1XrgUpPOk9VBvpWyem9FZWPC4kZdSflPkpcVTU6c317wJiCrwVSdunVy1ffIxWNeSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HknMqnuf; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b6e9317a2aso966024585a.0
        for <netdev@vger.kernel.org>; Wed, 01 Jan 2025 07:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735743787; x=1736348587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwUnTEWheYq7alSOBnRJPIsdBlPdfvBm7ZMXuAy9WT4=;
        b=HknMqnufGsNQxDmqQ3CzIjvcL4Tt0KZdftt1Pn4pIbD3RbMIGLOyBU34XHsHiR0gCv
         K/m+Gwqg7EVtKUp4pF4c2lBWeYhv/4giOz03Udk0tVWTt9pTQHdKhwHfBJG1jbMBENHW
         9rzoPw0pb0kX8SUSsRbwXmDJ3K073qmOvoae6uU+OaXvnfyFTz81RQRYIb/MDtSjqDgy
         8xSm0/c+U7p3BPbiJMGaaRDqfnDSKo6gnFecflsEyIEKEzOrJjogPQUORrLm635eNZJ8
         VBSBmvR1kuZyWFk1g8cMgROhxbGxhj1tQEnRzNxm1JOblvN5z+sO0lU7ekpyGxqHJnme
         T1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735743787; x=1736348587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwUnTEWheYq7alSOBnRJPIsdBlPdfvBm7ZMXuAy9WT4=;
        b=glKcUeNdYoYqxzptF3JJ1pt9iAsl6sPXz26G2WBBA5jyAXpAo1dAqN+eVC+dInkV5F
         PYi+XbhYJhrNJjY5CeRF4rSjHu+EOgw/nhkfa6l46Qf5aH8v7x0JAkB4U9FoDuGKSXAZ
         014WRzhzkYEetu7BkXMJrqoyCiHYUAvFAAmI+qKNDnNtDV9T0SksXrqDP3aPLGRWujgB
         1fc4AluFZw3OW9lYvIvZmzW1fLQm8dDD1NeAFmTcwr0OSm9pweOF7mPHTm7bH3/4jZ+E
         28p3opv/4bey7Cl4fOlwf9gXwuR8Uorw/DXpSsmE6EHPTjUHzKgPdBXL9o8F2ceI8vVC
         o4ow==
X-Gm-Message-State: AOJu0Yz71YM8xR1z562b8RQgNhApBShlGlUHCyotjxusJ9O/gHztFZnB
	CHakCuzTM/jGUEidHq7nAInjIeexwg40z5M4jRE7TxT+rRn3OMAHy7eXcIfXop6FDXMuLF2HEj/
	LZsBbmY9ZuwIVzktnno1a3XHZDU8=
X-Gm-Gg: ASbGncuVW3unnHm4UfVU8qX3KQ9sFn03mH9lTusuL3Xz6lmgnCjxg9ZAx+qGPTbkDv4
	0o40zBGf5gG6TfqmPhTUybLfwJ0pGQ+UZ30lQYBzDuUmX84IYsw==
X-Google-Smtp-Source: AGHT+IGJ9fbyVKtQUJxmB6wi75U8VS95UZUlB2I8T6d5FkbcOGmdd4+X7ig1EUc7Yf5mlm8q16rtvJFehTUeSAAtKLM=
X-Received: by 2002:ad4:5cc8:0:b0:6d8:f7eb:199c with SMTP id
 6a1803df08f44-6dd1555497fmr709587636d6.9.1735743787306; Wed, 01 Jan 2025
 07:03:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFmV8Nc758FDNK3FNSLQui4RmE3-TQr7d2tM_tOM6bC=OfEDwQ@mail.gmail.com>
 <CAL+tcoCWmJLQBL+O-GEEaDj8bDDrbjCcrKK3ky9+BJetWNOt5A@mail.gmail.com>
In-Reply-To: <CAL+tcoCWmJLQBL+O-GEEaDj8bDDrbjCcrKK3ky9+BJetWNOt5A@mail.gmail.com>
From: Zhongqiu Duan <dzq.aishenghu0@gmail.com>
Date: Wed, 1 Jan 2025 23:02:56 +0800
Message-ID: <CAFmV8NffAhhBR74xiq6QmkmyDq00u9_GxORNk+0kbFHk9yNjcw@mail.gmail.com>
Subject: Re: perhaps inet_csk_reqsk_queue_is_full should also allow zero backlog
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 1, 2025 at 9:53=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Tue, Dec 31, 2024 at 4:24=E2=80=AFPM Zhongqiu Duan <dzq.aishenghu0@gma=
il.com> wrote:
> >
> > Hi all,
> >
> > We use a proprietary library in our product, it passes hardcoded zero
> > as the backlog of listen().
> > It works fine when syncookies is enabled, but when we disable syncookie=
s
> > by business requirement, no connection can be made.
>
> I'm not that sure that the problem you encountered is the same as
> mine. I manage to reproduce it locally after noticing your report:
> 1) write the simplest c code with passing 0 as the backlog
> 2) adjust the value of net.ipv4.tcp_syncookies to see the different resul=
ts
>
> When net.ipv4.tcp_syncookies is set zero only, the connection will not
> be established.
>

Yes, that's the problem I want to describe.

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
>
> According to the experiment I conducted, I agree the above triggers
> the drop in tcp_conn_request(). When that sysctl is set to zero, the
> return value of tcp_syn_flood_action() is false, which leads to an
> immediate drop.
>
> Your changes in tcp_conn_request() can solve this issue, but you're
> solving a not that valid issue which can be handled in a decent way as
> below [1]. I can't see any good reason for passing zero as a backlog
> value in listen() since the sk_max_ack_backlog would be zero for sure.
>
> [1]
> I would also suggest trying the following two steps first like other peop=
le do:
> 1) pass a larger backlog number when calling listen().
> 2) adjust the sysctl net.core.somaxconn, say, a much larger one, like 409=
60
>
> Thanks,
> Jason

Even though only one connection is needed for this proprietary library
to work properly, I don't see any reason to set the backlog to zero
either. But it just happened. We simply bin patch the 3rd party
library to set a larger value for the backlog as a workaround.

Thanks for your suggestions, and I almost totally agree with you. I
just want to discuss whether it should and deserves to make some
changes in the kernel to keep the same behavior between
sk_acceptq_is_full() and inet_csk_reqsk_queue_is_full().

Regards,
Zhongqiu


Return-Path: <netdev+bounces-249570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B08ED1B12D
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 20:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9795A3017EC7
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 19:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78B336AB65;
	Tue, 13 Jan 2026 19:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViqxgXKK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748E734DCEE
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768332943; cv=none; b=fmuXs0BIfLOlNN2yPn/o1AXvOcgFlUFxa9DBLpJM5zhgfWizx+2Ajawp74deCSOrobGjQCgIsbEZ8TYAUiUGMMl/EOMQjYnUWcvHE6XxdmaxOivNyzCFwclTTVvwFvbiIKqPryxrppZGrfgSDQojF6taWwc6wZHxclkNdcKOGDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768332943; c=relaxed/simple;
	bh=jZZQroJrE7VeYEj+wn5kl2UT2gBb09x/39StwfupwIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQNOO1MRKE6HQ2NZ7TTLZgfrI+s4ycl4U0+ehxoBDlsiuKgoiTjoV01WxcIZabrBH8KASZbkN1DTJr9p731tcSZ/IXbx3+VkoR2BIFPKCCsT8TrDu2uW6s66UiHrkYeBlKSYObDBOM6PZGJFI0TSLdDoqhtZ2UIdxjUCE4GsBEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViqxgXKK; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-93f5b804d4aso3323102241.3
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 11:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768332941; x=1768937741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZZQroJrE7VeYEj+wn5kl2UT2gBb09x/39StwfupwIw=;
        b=ViqxgXKKLT39s15E372Cwq6EHuZwtS8SP+IuBa3xEevcTqmgZYJ9oQ+ID/Fipr4Kz3
         LiGUiKcNRqRt+7j/HWVzLR3j0MyL8Uij+g57K/8ESPRc3+SHcJgT11Tgp4otbtPyY0nC
         qsSracuXoQZ49FwzsKXi6+0Ca+S4buSC5yF08KTdWzQphAE1cxhqpBLYrnKu/ZcHjSKZ
         jm1En8/W6d62b0uXrr5X+Pe4B0Ftggzhq9NwqCOdjx3a9judqQaVTMJ/0WoPtveaHIU7
         McOQMS2jFdiUboi8ueFIimGHCTKelQWtsYmW0ZtA1JbWGctfaPco0h3yhCWEvUDqUkyS
         X0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768332941; x=1768937741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jZZQroJrE7VeYEj+wn5kl2UT2gBb09x/39StwfupwIw=;
        b=PkWO0pKkYU9Be/wpoYi95wJaI2lSYu8l5IrUShVbXXFDVV597A8vokHgf5481LyKC/
         QDMTEqjuuxRO4tOlaAsuEjrZ62M8dd6MPXi/dywwbLBo89JAlxBkeGxUuLKo2gdh46iw
         mE2nkNp6y/aBsWunyAa86kNbwGbiJF78szxaibnzXeCc8Szrq4fQGJWVvu1mBCq8MMOY
         GT6gnYOpvodrH2y0sOwxuIsXlQMSLBOoxK4MYhqZFb7YaH5IQHA9dpoZUyNJv05nFOE7
         IfXvQrbrBBFdAI9izGgDAUnP/GnxyQa+fj0/vQLwn0UdozQsZbCmCB4xeYgInGMfvwzK
         bBZw==
X-Forwarded-Encrypted: i=1; AJvYcCXsS2gBJU0WPyvVG6mzoEFjf9SGG+w/yQM7T8hr5yeF8tvRdoq67kRR12H2ZQTXRJeJuNucB9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJLYTn1Oj1jQSnpbIsOXl36UzlOmoW5CX0F9bQg3hXaMUzhQBd
	73D/BFaJjkB3Izrte2YB0kXB6Xt4IpItCZcT2rrTC2aokMHkGUwieQfPUGuKcqIIGusDi6rSDBy
	LoT8Cz+5RqKTRE8rZze3xcJF5341AT4M=
X-Gm-Gg: AY/fxX5Zr5O47g8jhNiGdU2VVM0KkkBd5JouWSXjjlzuU/R5M4eo0CGY3+KM2yEnXjT
	exHqHfqiS3kOxqU3uTQH2sS+Q5B2lsN5xGKe4C2qc2m038KRrJ6SpXXkLh7tPp2FetPkAjLewHo
	kSQT7Ff5xTmL61xTg+8Jkuk27DUinzYngSHqIK+6HUGHM/vmhJVSEBnWjq9/4IvXPvM9DYSO1yM
	F503kxvv6DetOaTyRgqMU/r8UiGQa2CyqPc1XfXvz5DtjJrZATQ8WZqdPHgsYBMEcF8Hu4IoMVu
	msGHZ7cfR3jVrkwgUcQesJDk/3Z1DA9244tblok=
X-Received: by 2002:a05:6102:809f:b0:5ef:a554:c125 with SMTP id
 ada2fe7eead31-5f17f66b0fdmr134285137.43.1768332941303; Tue, 13 Jan 2026
 11:35:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111163947.811248-1-jhs@mojatatu.com> <20260112222017.3d1da4c9@phoenix.local>
In-Reply-To: <20260112222017.3d1da4c9@phoenix.local>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Tue, 13 Jan 2026 11:35:29 -0800
X-Gm-Features: AZwV_QhX-tlO5YXcnb3KoSHtLpLjLJLNMLEkRcpYDY8DEX7WgjlkBYoB8QWntWY
Message-ID: <CAM_iQpWmiuOOUHHo0dnizjJDqU2KrLH8kWW1-zZXJD4UyJKXhw@mail.gmail.com>
Subject: Re: [PATCH net 0/6] net/sched: Fix packet loops in mirred and netem
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com, 
	dcaratti@redhat.com, lariel@nvidia.com, daniel@iogearbox.net, 
	pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, phil@nwl.cc, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	zyc199902@zohomail.cn, lrGerlinde@mailfence.com, jschung2@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 10:20=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
> This is a complex patch series so I decided to get a second opinion using=
 AI.
> It is worth reading (but not completely trusting). Review prompt is Chris=
 Mason's
> Claude review prompts.

Please prompt your AI what's a symptom and what is the cause. :)

Infinite loop is a symptom, not cause. Fixing symptoms does not
make sense, it only covers out the root cause even deeper.

Regards,
Cong


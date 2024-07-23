Return-Path: <netdev+bounces-112535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E28939C83
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 10:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51BA3B22597
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 08:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA6E14C5B0;
	Tue, 23 Jul 2024 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DgiJpQUs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AD314C582
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 08:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721722977; cv=none; b=KoUtZ10EaaEkAx4tDj0GKZ2VPhakhtX+OaR7Y/esvfKHSn8zHfI7IYqVLw5y1Hem/6kQcREezNBqIucyWf32pFfd4gBOIeqTrul+gkMYJPCq9PmndWgpj3I3Hzvukjm42NmH954rLG5tsajWNXyLrp4HKdzptsJGHUV8kUaBAiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721722977; c=relaxed/simple;
	bh=bULiKcYtzRzlX0GiORBKSEHwonRwDFkZZ43sE1qZNew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aULlYZTxNjbkC+z72tWidav7CzMnaHxOo6sgNU18B0gPi8UI63PDn60M/z1MsoAHp3Dv4/FsfrE4LfLxaMJvXN+BcAwIo905PnlpXC3fDVCNXjMrnEtWuEDQGD7duYjrVGj5+l1lKHxFcFYRmnAoZx6QZVDnEUYBRhnnP4vFhag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DgiJpQUs; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso13109a12.0
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 01:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721722974; x=1722327774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHzffdK1t29wgBUTlrheqQc/1FBrMdd1f0Xh1Fa/cyc=;
        b=DgiJpQUsHE6NgbimQXwzS8asrD0p7Sq1+4Vv+n8V6S7jxPgxatBpA/kMmSYj4TA1IN
         ECVgmajKP2rWl5Ahj6474oRkE5GS/n/e8MTeEp9Xr/n13r+4AqL6r9yczVUS9Ld9FGYg
         XpNFpY4KW1FYAsmr0fXku8FQFgNpLHgIIBmJSJVz/U7/enLukBB/cQZt/0D3xzneD1Gs
         f5Na+E0L2/rTdeCZPkZvXZfAdvxKUlbBeww/lmIqNl+/VRyI2zn/fhcm6W+AMWJVJOeW
         DqeSZc7jwxausTBHA5zRtvHSOcz/w4VxHhnslladpO/qWHZ1KTW+BxoUnBQDiHNEqAPR
         VMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721722974; x=1722327774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHzffdK1t29wgBUTlrheqQc/1FBrMdd1f0Xh1Fa/cyc=;
        b=Vb+PK6xpn89v/QgpRLa5zWgqf4WjRrPFDD+iNEZMO7xu4nhuK2VqoSKFVIp1LOR2SW
         No0qKwEC5T0Ljn2V8RHdsl1iy9iXbUJOk7qS6gQLYw/lug5Pv7d6tuKKjcadz7ae9Bst
         r6/Qk2AebfOfLuvybyB5lgAAoUIkLsnutXuNuOMGaiBWr8t/LdZdaKaqP9+K4nvKx3du
         YpLcj8DHGB52Qti1K8A+EUVwLss8kAaLpzDis24ITHHVcXGQdC0y5fsPvBP77aFl8dDJ
         Ggv8KdUSqIHtOvuKyQLDbkfe0eWsIGDV0LFmItR+6he5siA5WKac6xOQXnhhI5OJ0aQY
         sXkA==
X-Forwarded-Encrypted: i=1; AJvYcCXwPt5UZ8L3PDeeeV1ea+ukOxO0IE1d9bkzfbzfCmwa+BBLuyEEK/iSs62MkRRGHFKP9hIPQn98WxI68mxXdrE1MdPcC4b2
X-Gm-Message-State: AOJu0YxQcI2XmAVsUjq5Xakrs1NXTdJGQCBZSxRZGjk+YJKJ/6xFIjIH
	MFWIuuS8DjNjiowGpcBSddFZ2zepc46a4ET7BHtwC6Q5t5XEa4aMmccfEUkb+IlYwk425GNg8g+
	ccOMM7sZ/Bn++HjwLMVCm+CNKNJeG0Hsk8XWD
X-Google-Smtp-Source: AGHT+IFloeNOLjx98DobvZlaIXggAhKgmTEsQyFXl+zDVn0YHqOhg/R7X7Lh2OPbveWF/8Lg8FOnw+q/voxghpl33uk=
X-Received: by 2002:a05:6402:34d6:b0:57d:436b:68d6 with SMTP id
 4fb4d7f45d1cf-5a4a9300bddmr484291a12.7.1721722974127; Tue, 23 Jul 2024
 01:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-0-d653f85639f6@kernel.org>
 <a2f181c3-92d7-4874-b402-50a54b6d289c@redhat.com>
In-Reply-To: <a2f181c3-92d7-4874-b402-50a54b6d289c@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Jul 2024 01:22:40 -0700
Message-ID: <CANn89iJ+sBaa3hbPceGytu+pj6u9z7+YQ_G6eL1S4sYMfPVQmw@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] tcp: restrict crossed SYN specific actions to SYN-ACK
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jerry Chu <hkchu@google.com>, Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 1:10=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/18/24 12:33, Matthieu Baerts (NGI0) wrote:
> > A recent commit in TCP affects TFO and MPTCP in some cases. The first
> > patch fixes that.
> >
> > The second one applies the same fix to another crossed SYN specific
> > action just before.
> >
> > These two fixes simply restrict what should be done only for crossed SY=
N
> > cases to packets with SYN-ACK flags.
> >
> > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > ---
> > Changes in v2:
> > - Patch 1/2 has a simpler and generic check (Kuniyuki), and an updated
> >    comment.
> > - New patch 2/2: a related fix
> > - Link to v1: https://lore.kernel.org/r/20240716-upstream-net-next-2024=
0716-tcp-3rd-ack-consume-sk_socket-v1-1-4e61d0b79233@kernel.org
>
> Re-adding Neal for awareness. It would be great if this could go through
> some packetdrill testing,
>

I am back in France, let me see what I can do.


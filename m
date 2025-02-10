Return-Path: <netdev+bounces-164588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAFEA2E632
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E6C3AA629
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 08:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDFB1BD9FF;
	Mon, 10 Feb 2025 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KuJEZeBc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AFB1BC099
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739175505; cv=none; b=APVvYd6N/VaePVwLJ80kHwv9x77ZVuEF9xbC3cHxH7u6OcMs/8bSUvYK3fAjhnM/JVRNCbd+IgN3Vr37ZF/IPdMj7jbPJ+SIItE4uLKOS63nmMkQBThyk44Ii+3AZtA0ZLArQQrSBwMR9sS8JItpXDmpROuofSCYr+1yR85oesU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739175505; c=relaxed/simple;
	bh=HKOn5IJEgdtG8ZBAvP8oaDynHzAkHicOavKFEQoYX2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+SOGWZu+q7IMbFZoCuFIyfaJs3X3U14rgXAhGHWuROH4Uwl2AwkpEZbfvylv3f1ngk5J0rjsXmyT6E4bTVbrpy8KIhsSjdtmK6WelCwd6X6/sHRgrB3w/vbbcEVfT7jUzV2T/erR7AfVfOTBpk31/qI+FM0IrenbS7xbEfJOnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KuJEZeBc; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d9837f201aso10014872a12.0
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 00:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739175502; x=1739780302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKOn5IJEgdtG8ZBAvP8oaDynHzAkHicOavKFEQoYX2A=;
        b=KuJEZeBcU+44XpV4DzYHjVUcURH2b7u89WzWa4gbGJh5CY7bFhNI+L3DZJmZD781kC
         1UXB4m86CeGjuosIz8hwB49X4cR+uA9nqr0reeai2zXtikMHXwg43RvDZBf7hSbjTUof
         9gU4PaJByTtngd1t52F1ENKZr+LWigC1iaCG1Z/qxIqQsfh6OL2Xl9R2SNnTDurV72zX
         btoc4v28pIBEI7i54bwT0Rd2kqjRuFzooRsNWCbLAV2Wv6175KpgmXGni6NttsyO6bn0
         VIMhjI7p5RCPx/+K0Se1MAy3pzOzX49aKag6JC04iVV5yvAjCFbs5pgyPNzGRZRyoOJ9
         9Nbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739175502; x=1739780302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKOn5IJEgdtG8ZBAvP8oaDynHzAkHicOavKFEQoYX2A=;
        b=UxsnPTfcCyP7r7AePwQzye7nJRjK5QUD17c09R7ToCuunaauKMJvmpqb9XeOx7Scmv
         GVHRirKplC4lmzuJGujilAErzn6hHZ/RPei+az8lXRljAtQ+PzyZhCTlPZxIIKKqJ2FX
         f0cDOOa5LGXxsMdImu29qe39vMgnEYUB950DCDDjL5CKt8K+1NpnRtlMAOJKU8igsGoD
         n7fyZZm1rIHxTF7PZNAGl3s1o1zxyCXf/JF1LJDOxDAlh08B4d1Hmkv9zkY3/57XL7Xx
         TrNAz2oZTaf7I3yIJjWNhoj8NbiHku7TqXHklpQmzHm8MaI5ZrwzFjPLew8p6to/4rc7
         LDRw==
X-Forwarded-Encrypted: i=1; AJvYcCXpjWubnXfF7uZRX3PRGDYu2MDKZgh3y4kg3/VUXfIQT2SxxDMJUiblzP7OPRqgtzT2iOwBuRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEwNiKPzR56ZWoKahdaIQ6hSyOzAssfB8p1jsj/CY0ATbfsBaf
	lg3fafEaOd/XoseYT5dtIYun5OGuR6YQmkd0XWx4w6PN8Dim6zrX8hUqwNSPHYnlR/U7aPSsEyP
	aKT36rt8LclSc3JahEZZ38eXdhyXRo2wndtUt
X-Gm-Gg: ASbGncvqnr73jz3cLK0lZsKjv/jPZQZVgb+5AGH5QHDXDBR88xGEvw6kmxqCJUW5XR/
	GVqqMBiBXCx/c3O7W8jUih/svsm2DXUzWt4amrFaa4sMl7vZJq5SxG3j7mTLUXRMV9ZqNkWKf
X-Google-Smtp-Source: AGHT+IEnz23nI3lFQdy6MYkNw/gFDBTNNTn3pR4cQkkxYRnmYmDv4O28jkiVy6znhGb9T1Pd84FRNYtUzD14kaBf62k=
X-Received: by 2002:a05:6402:5254:b0:5db:e88c:914f with SMTP id
 4fb4d7f45d1cf-5de469a7607mr11983042a12.4.1739175501984; Mon, 10 Feb 2025
 00:18:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207152830.2527578-1-edumazet@google.com> <20250207152830.2527578-5-edumazet@google.com>
 <CAL+tcoD8FVYLqJnA0_h1Tc_OeY4eqmrDPQ7wJ22f0LHxSG+zBw@mail.gmail.com>
In-Reply-To: <CAL+tcoD8FVYLqJnA0_h1Tc_OeY4eqmrDPQ7wJ22f0LHxSG+zBw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Feb 2025 09:18:10 +0100
X-Gm-Features: AWEUYZmERHDghkO8HUk6VZL4aGwHT_JZGmZfsDOGqDmtAQVNxN52SgZbqsWrg0o
Message-ID: <CANn89i+k-EP+Xc8WWsESDGk+6dC31Tp0gSXg7MMdsB+sXmsm-g@mail.gmail.com>
Subject: Re: [PATCH net-next 4/5] tcp: add the ability to control max RTO
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Jason Xing <kernelxing@tencent.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 6:37=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Fri, Feb 7, 2025 at 11:31=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > Currently, TCP stack uses a constant (120 seconds)
> > to limit the RTO value exponential growth.
> >
> > Some applications want to set a lower value.
> >
> > Add TCP_RTO_MAX_MS socket option to set a value (in ms)
> > between 1 and 120 seconds.
> >
> > It is discouraged to change the socket rto max on a live
> > socket, as it might lead to unexpected disconnects.
> >
> > Following patch is adding a netns sysctl to control the
> > default value at socket creation time.
>
> I assume a bpf extension could be considered as a follow up patch on
> top of the series?

I left BPF and MPTP follow ups being handled by their owners

